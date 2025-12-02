#ifndef TRAP_H
#define TRAP_H

#include "types.h"

// 中断处理函数类型：接收一个 void* 参数
typedef void (*interrupt_handler_t)(void *arg);

// 简单框架支持的最大 IRQ 向量数
#define MAX_IRQS 256

// 初始化陷阱/中断子系统
void trap_init(void);

// 注册/注销中断处理函数
// 成功返回 0，出错返回 -1
int register_interrupt(int irq, interrupt_handler_t h, void *arg);
int unregister_interrupt(int irq);

// 使能/禁用逻辑 IRQ（框架层标志）
void enable_interrupt(int irq);
void disable_interrupt(int irq);

// 分发辅助函数：平台相关的 IRQ 入口应调用此函数
// 以执行为给定 irq 注册的处理函数
void handle_irq(int irq);

// 用户态陷阱处理入口
void usertrap(void);
void usertrapret(void);

// 内核态陷阱处理入口  
void kerneltrap(void);

// 系统调用处理
void syscall(void);

// 页错误处理
void pagefault(uint64_t stval, uint64_t scause);

#endif // TRAP_H
