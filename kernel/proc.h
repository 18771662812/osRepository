#ifndef PROC_H
#define PROC_H

#include "types.h"
#include "pmm.h"
#include "spinlock.h"
#include "file.h"

#define NPROC 64
#define KSTACK_SIZE KERNEL_STACK_SIZE

// 进程状态
typedef enum {
    PROC_UNUSED = 0,
    PROC_EMBRYO,
    PROC_RUNNABLE,
    PROC_RUNNING,
    PROC_SLEEPING,
    PROC_ZOMBIE
} proc_state_t;

// swtch 保存/恢复的寄存器集合（callee-saved）
struct context {
    uint64 ra;
    uint64 sp;
    uint64 s0;
    uint64 s1;
    uint64 s2;
    uint64 s3;
    uint64 s4;
    uint64 s5;
    uint64 s6;
    uint64 s7;
    uint64 s8;
    uint64 s9;
    uint64 s10;
    uint64 s11;
};

// 用户态陷阱帧占位（后续扩展到用户态时使用）
struct trapframe {
    uint64 kernel_satp;
    uint64 kernel_sp;
    uint64 kernel_trap;
    uint64 epc;
    uint64 kernel_hartid;
    uint64 ra, sp;
    uint64 gp, tp;
    uint64 t0, t1, t2;
    uint64 s0, s1;
    uint64 a0, a1, a2, a3, a4, a5, a6, a7;
    uint64 s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
    uint64 t3, t4, t5, t6;
};

struct proc {
    int pid;
    proc_state_t state;
    char name[16];

    // 内核栈
    uint64 kstack;   // 栈底物理地址

    // 调度/上下文
    struct context ctx;
    int time_slice;
    int need_resched;
    void *chan;      // sleep/wakeup 使用的等待通道
    int qlevel;
    uint64 last_run_tick;
    uint64 last_ready_tick;
    struct proc *parent;
    int child_count;
    int exit_status;

    // 用户态相关（占位）
    struct trapframe *tf;
    uint64 pagetable; // 用户页表根（satp中的ppn<<12）
    uint64 sz;        // 用户内存大小
    struct file *ofile[NOFILE];
};

extern struct proc proc_table[NPROC];
extern struct proc *current;

// 进程/调度 API
void proc_init(void);
struct proc* alloc_process(void);
void free_process(struct proc *p);
int create_process(void (*entry)(void));
void exit_process(int status);
int wait_process(int *status);
int kill_process(int pid);
struct proc* myproc(void);
void scheduler(void);
void yield(void);
void sched(void);
void userinit(void);
int grow_process(int n);
int fork_user_process(void);

// 同步原语：基于通道的睡眠/唤醒（简化版，禁中断避免 lost wakeup）
void sleep(void *chan, struct spinlock *lk);
void wakeup(void *chan);

// 创建内核线程用于演示
int kproc_create(void (*fn)(void *), void *arg, const char *name);

// 调试辅助：打印进程表
void debug_proc_table(void);

// 由汇编实现
void swtch(struct context *old, struct context *new);

#endif // PROC_H
