#ifndef TIMER_H
#define TIMER_H

#include "types.h"

// 定时器初始化
void timer_init(void);

// 定时器中断处理函数
void timer_interrupt(void *arg);

// 获取系统节拍数
uint64_t get_sys_ticks(void);

// 打印定时器状态（调试用）
void timer_debug_print(void);

// 导出的中断计数器
extern volatile int timer_interrupt_count;

#endif // TIMER_H
