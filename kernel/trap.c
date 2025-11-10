#include "trap.h"
#include "uart.h"
#include "sbi.h"
#include "proc.h"

// 手动定义标准库常量
#ifndef NULL
#define NULL ((void*)0)
#endif

extern int printf(char *fmt, ...);
extern void panic(char *s);

// xv6风格的CSR寄存器操作
static inline uint64 r_scause() {
    uint64 x;
    __asm__ volatile("csrr %0, scause" : "=r" (x));
    return x;
}

static inline uint64 r_sepc() {
    uint64 x;
    __asm__ volatile("csrr %0, sepc" : "=r" (x));
    return x;
}

static inline uint64 r_stval() {
    uint64 x;
    __asm__ volatile("csrr %0, stval" : "=r" (x));
    return x;
}

static inline void w_sepc(uint64 x) {
    __asm__ volatile("csrw sepc, %0" : : "r" (x));
}

static inline void w_sstatus(uint64 x) {
    __asm__ volatile("csrw sstatus, %0" : : "r" (x));
}

// S 态计时相关 CSR 助手（与 start.c 启用 sstc 保持一致）
static inline uint64 r_time_csr() { uint64 x; __asm__ volatile("csrr %0, time" : "=r" (x)); return x; }
// static inline void w_stimecmp(uint64 x) { __asm__ volatile("csrw stimecmp, %0" :: "r" (x)); }

// 系统时钟变量
volatile uint64_t ticks = 0;
// 来自 timer.c 的中断计数器（用于测试）
extern volatile int timer_interrupt_count;

// 时钟中断周期（按 timebase 计数）。QEMU virt 上常见 timebase=10MHz，这里取 1e6 约 100ms
static const uint64_t TIMER_INTERVAL = 1000000ULL;

// 前向声明
void clockintr(void);

// 中断注册机制：中断处理函数表
static interrupt_handler_t handler_table[MAX_IRQS];
static void *arg_table[MAX_IRQS];
static int enabled_table[MAX_IRQS];  // 1=使能, 0=禁用

// 初始化中断注册表（清零）
static void init_interrupt_table(void) {
    for (int i = 0; i < MAX_IRQS; i++) {
        handler_table[i] = NULL;
        arg_table[i] = NULL;
        enabled_table[i] = 0;
    }
}

// 注册中断处理函数
int register_interrupt(int irq, interrupt_handler_t h, void *arg) {
    if (irq < 0 || irq >= MAX_IRQS) {
        return -1;  // IRQ 号超出范围
    }
    if (h == NULL) {
        return -1;  // 处理函数不能为空
    }
    
    handler_table[irq] = h;
    arg_table[irq] = arg;
    enabled_table[irq] = 1;  // 默认使能
    return 0;
}

// 注销中断处理函数
int unregister_interrupt(int irq) {
    if (irq < 0 || irq >= MAX_IRQS) {
        return -1;
    }
    
    handler_table[irq] = NULL;
    arg_table[irq] = NULL;
    enabled_table[irq] = 0;
    return 0;
}

// 使能中断
void enable_interrupt(int irq) {
    if (irq >= 0 && irq < MAX_IRQS) {
        enabled_table[irq] = 1;
    }
}

// 禁用中断
void disable_interrupt(int irq) {
    if (irq >= 0 && irq < MAX_IRQS) {
        enabled_table[irq] = 0;
    }
}

// 分发中断：调用注册的处理函数
void handle_irq(int irq) {
    if (irq < 0 || irq >= MAX_IRQS) {
        return;  // 无效的 IRQ 号
    }
    
    if (!enabled_table[irq]) {
        return;  // 中断被禁用
    }
    
    if (handler_table[irq] != NULL) {
        handler_table[irq](arg_table[irq]);
    }
}

// 设备中断处理
int devintr() {
    uint64 scause = r_scause();

    // 最高位为 1 表示中断
    if (scause & (1ULL << 63)) {
        uint64 cause = scause & 0xff;
        int irq = (int)cause;  // 将 scause 的低位作为 IRQ 号

        // 首先尝试使用注册机制
        if (irq < MAX_IRQS && handler_table[irq] != NULL) {
            handle_irq(irq);
            return 2;  // 表示已处理
        }

        // 如果没有注册处理函数，使用硬编码的默认处理（兼容性）
        // 1: S-软件中断，5: S-定时器中断，9: S-外部中断
        if (cause == 5) {
            clockintr();
            return 2;
        } else if (cause == 1) {
            // 清除 SSIP
            uint64 sip;
            __asm__ volatile("csrr %0, sip" : "=r" (sip));
            __asm__ volatile("csrw sip, %0" : : "r" (sip & ~2));
            return 1;
        } else if (cause == 9) {
            // 外部中断（目前未接设备）
            return 1;
        }
    }

    return 0;
}

// 时钟中断处理
void clockintr() {
    ticks++;
    timer_interrupt_count++;
    // 设定下一次定时器（使用 sstc：stimecmp = time + interval）
    // uint64_t now = r_time_csr();
    // w_stimecmp(now + TIMER_INTERVAL);
    // 维护时间片：如果当前有进程，递减并设置 need_resched
    if (current && current->state == PROC_RUNNING) {
        if (current->time_slice > 0) {
            current->time_slice--;
        }
        if (current->time_slice == 0) {
            current->need_resched = 1;
        }
    }
}

// 初始化陷阱/中断子系统
void trap_init(void) {
    // 初始化中断注册表
    init_interrupt_table();
    
    // 设置监督态陷阱入口到汇编向量 kernelvec
    extern void kernelvec(void);
    __asm__ volatile("csrw stvec, %0" :: "r" ((uint64)kernelvec));

    // 打开 SIE 位并允许 S-定时器中断
    uint64 mstatus;
    __asm__ volatile("csrr %0, sstatus" : "=r" (mstatus));
    mstatus |= (1UL << 1); // SIE
    __asm__ volatile("csrw sstatus, %0" :: "r" (mstatus));

    uint64 sie;
    __asm__ volatile("csrr %0, sie" : "=r" (sie));
    sie |= (1UL << 5); // STIE: Supervisor timer interrupt enable
    sie |= (1UL << 1); // SSIE: Supervisor software interrupt enable
    __asm__ volatile("csrw sie, %0" :: "r" (sie));
}

// 用户态陷阱处理
void usertrap(void) {
    uint64 scause = r_scause();
    uint64 sepc = r_sepc();
    uint64 stval = r_stval();

    // 最高位=1 表示中断，统一交由设备中断分发
    if (scause >> 63) {
        if (devintr() != 0) return;
    }

    printf("usertrap: unexpected scause %p pid=%d\n", scause, 0);
    printf("            sepc=%p stval=%p\n", sepc, stval);
    panic("usertrap");
}

// 内核态陷阱处理
void kerneltrap(void) {
    uint64 scause = r_scause();
    uint64 sepc = r_sepc();
    uint64 stval = r_stval();

    // 最高位=1 表示中断，统一交由设备中断分发
    if (scause >> 63) {
        if (devintr() != 0) {
            // 如果是时钟中断导致需要调度，则在内核可切换点执行 yield
            if (current && current->need_resched) {
                yield();
            }
            return;
        }
    }

    printf("kerneltrap: unexpected scause %p\n", scause);
    printf("            sepc=%p stval=%p\n", sepc, stval);
    panic("kerneltrap");
}


