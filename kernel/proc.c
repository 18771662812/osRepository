#include "proc.h"
#include "uart.h"
#include "pmm.h"
#include "spinlock.h"
#include "timer.h"

extern int printf(char *fmt, ...);
extern void panic(char *s);
extern volatile uint64_t ticks;

struct proc proc_table[NPROC];
struct proc *current = 0;
// 调度器自身的上下文，用于保存 scheduler 的寄存器
static struct context sched_ctx;
static struct spinlock proc_lock;

#define NQUEUE 3
static const int queue_slices[NQUEUE] = {2, 4, 8};
static const uint64 AGING_INTERVAL = 50;
static int queue_cursor[NQUEUE] = {0, 0, 0};

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
        proc_table[i].qlevel = 0;
        proc_table[i].last_run_tick = 0;
        proc_table[i].last_ready_tick = 0;
        proc_table[i].parent = 0;
        proc_table[i].child_count = 0;
        proc_table[i].exit_status = 0;
        for (int j = 0; j < 16; j++) proc_table[i].name[j] = 0;
    }
    initlock(&proc_lock, "proc_table");
}

struct proc* alloc_process(void) {
    struct proc *p = 0;
    acquire(&proc_lock);
    for (int i = 0; i < NPROC; i++) {
        if (proc_table[i].state == PROC_UNUSED) {
            p = &proc_table[i];
            p->state = PROC_EMBRYO;
            p->pid = next_pid++;
            break;
        }
    }
    release(&proc_lock);
    if (!p) return 0;
    void *page = alloc_page();
    if (!page) {
        acquire(&proc_lock);
        p->state = PROC_UNUSED;
        release(&proc_lock);
        return 0;
    }
    p->kstack = (uint64)page + KSTACK_SIZE;
    p->qlevel = 0;
    p->time_slice = queue_slices[p->qlevel];
    p->need_resched = 0;
    p->last_run_tick = ticks;
    p->last_ready_tick = ticks;
    p->parent = 0;
    p->child_count = 0;
    p->exit_status = 0;
    return p;
}

void free_process(struct proc *p) {
    if (!p) return;
    if (p->kstack) {
        free_page((void*)(p->kstack - KSTACK_SIZE));
        p->kstack = 0;
    }
    if (p->parent) {
        p->parent->child_count--;
        if (p->parent->child_count < 0) p->parent->child_count = 0;
    }
    p->pid = 0;
    p->state = PROC_UNUSED;
    p->time_slice = 0;
    p->need_resched = 0;
    p->chan = 0;
    p->qlevel = 0;
    p->last_run_tick = 0;
    p->last_ready_tick = 0;
    p->parent = 0;
    p->child_count = 0;
    p->exit_status = 0;
    for (int j = 0; j < 16; j++) p->name[j] = 0;
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
    // 运行结束，调用统一退出路径
    exit_process(0);
}

int kproc_create(void (*fn)(void *), void *arg, const char *name) {
    struct proc *p = alloc_process();
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
    acquire(&proc_lock);
    p->state = PROC_RUNNABLE;
    p->last_ready_tick = ticks;
    p->parent = current;
    if (current) current->child_count++;
    release(&proc_lock);
    return p->pid;
}

static void proc_entry_wrapper(void *arg) {
    void (*fn)(void) = (void (*)(void))arg;
    fn();
}

int create_process(void (*entry)(void)) {
    return kproc_create(proc_entry_wrapper, (void*)entry, "proc");
}

void sched(void) {
    // 将 CPU 切换回调度器
    struct context *old = current ? &current->ctx : &sched_ctx;
    current = 0;
    swtch(old, &sched_ctx);
}

void yield(void) {
    if (!current) return;
    acquire(&proc_lock);
    current->state = PROC_RUNNABLE;
    current->need_resched = 0;
    current->last_ready_tick = ticks;
    release(&proc_lock);
    sched();
}

void exit_process(int status) {
    acquire(&proc_lock);
    current->exit_status = status;
    // 重新父子关系：孤儿交给 0（无父）
    for (int i = 0; i < NPROC; i++) {
        struct proc *p = &proc_table[i];
        if (p->parent == current) {
            p->parent = 0;
        }
    }
    current->child_count = 0;
    current->state = PROC_ZOMBIE;
    if (current->parent) {
        wakeup(current->parent);
    }
    release(&proc_lock);
    sched();
    panic("exit_process returned");
}

static void promote_waiting_procs(void) {
    uint64 now = ticks;
    for (int i = 0; i < NPROC; i++) {
        struct proc *p = &proc_table[i];
        if (p->state != PROC_RUNNABLE) continue;
        if (p->qlevel > 0 && (now - p->last_ready_tick) >= AGING_INTERVAL) {
            p->qlevel--;
            p->time_slice = queue_slices[p->qlevel];
            p->last_ready_tick = now;
        }
    }
}

// 多级反馈队列调度器
void scheduler(void) {
    while (1) {
        acquire(&proc_lock);
        promote_waiting_procs();
        int scheduled = 0;
        for (int level = 0; level < NQUEUE && !scheduled; level++) {
            int start = queue_cursor[level];
            for (int offset = 0; offset < NPROC; offset++) {
                int idx = (start + offset) % NPROC;
                struct proc *p = &proc_table[idx];
                if (p->state != PROC_RUNNABLE || p->qlevel != level) continue;
                current = p;
                p->state = PROC_RUNNING;
                p->time_slice = queue_slices[p->qlevel];
                p->last_run_tick = ticks;
                release(&proc_lock);
                swtch(&sched_ctx, &p->ctx);
                acquire(&proc_lock);
                queue_cursor[level] = (idx + 1) % NPROC;
                if (p->state == PROC_ZOMBIE) {
                    if (p->parent) {
                        wakeup(p->parent);
                    } else {
                        free_process(p);
                    }
                } else if (p->state == PROC_RUNNABLE && p->time_slice <= 0) {
                    if (p->qlevel < NQUEUE - 1) {
                        p->qlevel++;
                    }
                    p->time_slice = queue_slices[p->qlevel];
                    p->last_ready_tick = ticks;
                }
                scheduled = 1;
                break;
            }
        }
        release(&proc_lock);
        __asm__ volatile("wfi");
    }
}

void sleep(void *chan, struct spinlock *lk) {
    if (!current || lk == 0) return;
    acquire(&proc_lock);
    release(lk);
    current->chan = chan;
    current->state = PROC_SLEEPING;
    release(&proc_lock);
    sched();
    acquire(&proc_lock);
    current->chan = 0;
    release(&proc_lock);
    acquire(lk);
}

void wakeup(void *chan) {
    acquire(&proc_lock);
    for (int i = 0; i < NPROC; i++) {
        struct proc *p = &proc_table[i];
        if (p->state == PROC_SLEEPING && p->chan == chan) {
            p->state = PROC_RUNNABLE;
            p->last_ready_tick = ticks;
        }
    }
    release(&proc_lock);
}

int wait_process(int *status) {
    acquire(&proc_lock);
    for (;;) {
        int havekids = 0;
        for (int i = 0; i < NPROC; i++) {
            struct proc *p = &proc_table[i];
            if (p->parent != current) continue;
            havekids = 1;
            if (p->state == PROC_ZOMBIE) {
                int pid = p->pid;
                if (status) *status = p->exit_status;
                free_process(p);
                release(&proc_lock);
                return pid;
            }
        }
        if (!havekids) {
            release(&proc_lock);
            return -1;
        }
        sleep(current, &proc_lock);
    }
}

void debug_proc_table(void) {
    static const char *state_names[] = {
        "UNUSED", "EMBRYO", "RUNNABLE", "RUNNING", "SLEEPING", "ZOMBIE"
    };
    acquire(&proc_lock);
    printf("=== Process Table ===\n");
    for (int i = 0; i < NPROC; i++) {
        struct proc *p = &proc_table[i];
        if (p->state == PROC_UNUSED) continue;
        const char *name = (p->name[0] ? p->name : "(noname)");
        const char *state = (p->state >= 0 && p->state <= PROC_ZOMBIE)
            ? state_names[p->state] : "UNKNOWN";
        printf("PID:%d State:%s Q:%d Slice:%d Name:%s\n",
               p->pid, state, p->qlevel, p->time_slice, name);
    }
    release(&proc_lock);
}
