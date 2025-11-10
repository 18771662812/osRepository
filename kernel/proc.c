#include "proc.h"
#include "uart.h"
#include "pmm.h"

extern int printf(char *fmt, ...);

struct proc proc_table[NPROC];
struct proc *current = 0;
// 调度器自身的上下文，用于保存 scheduler 的寄存器
static struct context sched_ctx;

static int next_pid = 1;

static void context_init(struct context *c, uint64 sp, uint64 ra_entry) {
    c->ra = ra_entry;
    c->sp = sp;
    c->s0 = c->s1 = c->s2 = c->s3 = c->s4 = c->s5 = 0;
    c->s6 = c->s7 = c->s8 = c->s9 = c->s10 = c->s11 = 0;
}

void proc_init(void) {
    printf("proc_init\n");
    for (int i = 0; i < NPROC; i++) {
        proc_table[i].pid = 0;
        proc_table[i].state = PROC_UNUSED;
        proc_table[i].kstack = 0;
        proc_table[i].time_slice = 0;
        proc_table[i].need_resched = 0;
        proc_table[i].tf = 0;
        proc_table[i].pagetable = 0;
        for (int j = 0; j < 16; j++) proc_table[i].name[j] = 0;
    }
}

struct proc* allocproc(void) {
    for (int i = 0; i < NPROC; i++) {
        if (proc_table[i].state == PROC_UNUSED) {
            struct proc *p = &proc_table[i];
            p->state = PROC_EMBRYO;
            p->pid = next_pid++;
            // 分配内核栈
            void *page = alloc_page();
            if (!page) {
                p->state = PROC_UNUSED;
                return 0;
            }
            p->kstack = (uint64)page + KSTACK_SIZE; // 栈向下生长，sp 指向页末
            p->time_slice = 5;
            p->need_resched = 0;
            return p;
        }
    }
    return 0;
}

// 内核进程的启动桩：从 s0 寄存器读取参数指针，调用 fn(arg) 后进入 sched
struct kproc_start_arg { void (*fn)(void*); void *arg; };
// 注意：这个函数通过 swtch 返回来执行，参数指针通过 s0 寄存器传递
static void kproc_start_trampoline(void) {
    // 从 s0 寄存器读取参数结构指针（s0 是 callee-saved，会被 swtch 保存/恢复）
    struct kproc_start_arg *a;
    __asm__ volatile("mv %0, s0" : "=r" (a));
    void (*fn)(void*) = a->fn;
    void *arg = a->arg;
    // 调用用户函数
    fn(arg);
    // 运行结束，进入僵尸状态并调度
    current->state = PROC_ZOMBIE;
    sched();
}

int kproc_create(void (*fn)(void *), void *arg, const char *name) {
    struct proc *p = allocproc();
    if (!p) return -1;
    // 栈的范围：从 (p->kstack - KSTACK_SIZE) 到 p->kstack
    // 栈向下生长，栈顶是 p->kstack（高地址）
    // 在栈顶附近放置参数结构（留出足够空间给函数调用）
    uint64 arg_addr = p->kstack - sizeof(struct kproc_start_arg);  // 在栈顶下方放置参数结构
    struct kproc_start_arg *a = (struct kproc_start_arg *)arg_addr;
    a->fn = fn;
    a->arg = arg;
    // 初始化 context：
    // - sp 设置为参数结构的下方（更低地址），为函数调用留出栈空间
    // - s0 保存参数结构指针（callee-saved，会被 swtch 保存/恢复）
    // - ra 指向 trampoline 函数
    uint64 sp = arg_addr - 128;  // sp 在参数结构下方128字节，为函数调用留出足够空间
    context_init(&p->ctx, sp, (uint64)kproc_start_trampoline);
    p->ctx.s0 = (uint64)a;  // 通过 s0 传递参数指针
    // 名称
    int i=0; for (; i<15 && name && name[i]; i++) p->name[i]=name[i]; p->name[i]=0;
    p->state = PROC_RUNNABLE;
    return p->pid;
}

void sched(void) {
    // 将 CPU 切换回调度器
    struct context *old = current ? &current->ctx : &sched_ctx;
    current = 0;
    swtch(old, &sched_ctx);
}

void yield(void) {
    if (!current) return;
    current->state = PROC_RUNNABLE;
    current->need_resched = 0;
    sched();
}

// 轮转调度器：在一个专用内核上下文中循环挑选 RUNNABLE 进程运行
void scheduler(void) {
    while (1) {
        for (int i = 0; i < NPROC; i++) {
            struct proc *p = &proc_table[i];
            if (p->state != PROC_RUNNABLE) continue;
            // 切换到 p
            current = p;
            p->state = PROC_RUNNING;
            p->time_slice = 5;
            swtch(&sched_ctx, &p->ctx); // 从调度器切到进程
            // 返回到这里表示该进程调用了 sched/yield 或结束
            if (p->state == PROC_ZOMBIE) {
                if (p->kstack) free_page((void*)(p->kstack - KSTACK_SIZE));
                p->pid = 0;
                p->state = PROC_UNUSED;
                p->kstack = 0;
            }
        }
        // 可加入 wfi 省电
        __asm__ volatile("wfi");
    }
}

// ---- sleep/wakeup 简化实现（禁中断防止 lost wakeup） ----
static inline uint64 r_sstatus_local() { uint64 x; __asm__ volatile("csrr %0, sstatus" : "=r" (x)); return x; }
static inline void w_sstatus_local(uint64 x) { __asm__ volatile("csrw sstatus, %0" :: "r" (x)); }
#define SSTATUS_SIE (1UL<<1)

static inline int intr_get_local() { return (r_sstatus_local() & SSTATUS_SIE) != 0; }
static inline void intr_on_local() { w_sstatus_local(r_sstatus_local() | SSTATUS_SIE); }
static inline void intr_off_local() { w_sstatus_local(r_sstatus_local() & ~SSTATUS_SIE); }

void sleep(void *chan) {
    if (!current) return;
    int int_was_on = intr_get_local();
    intr_off_local();
    current->chan = chan;
    current->state = PROC_SLEEPING;
    sched();
    current->chan = 0;
    if (int_was_on) intr_on_local();
}

void wakeup(void *chan) {
    int int_was_on = intr_get_local();
    intr_off_local();
    for (int i = 0; i < NPROC; i++) {
        struct proc *p = &proc_table[i];
        if (p->state == PROC_SLEEPING && p->chan == chan) {
            p->state = PROC_RUNNABLE;
        }
    }
    if (int_was_on) intr_on_local();
}


