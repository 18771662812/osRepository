/* 定时器处理：timer_interrupt 实现及初始化 */
#include "timer.h"
#include "sbi.h"
#include "trap.h"
#include "types.h"
#include "uart.h"

extern int printf(char *fmt, ...);

// 约 100ms（10MHz timebase）间隔
#define TIMER_INTERVAL 1000000ULL

// 简单的系统节拍计数
static volatile uint64_t sys_ticks = 0;

// 导出给测试使用的中断计数器（每次 timer interrupt 增加）
volatile int timer_interrupt_count = 0;

// 定时器中断处理由 trap.c::clockintr 统一完成，这里仅维护本地计数供测试
void timer_interrupt(void *arg) {
    (void)arg;
    sys_ticks++;
    timer_interrupt_count++;
}

static uint64_t program_next_tick(void) {
    uint64_t now = get_time();
    uint64_t next = now + TIMER_INTERVAL;
    __asm__ volatile("csrw 0x14D, %0" :: "r" (next));
    return next;
}

void timer_schedule_next_tick(void) {
    program_next_tick();
}

// 对外初始化：设置首次定时器
void timer_init(void) {
    // 设定首次定时器
    uint64_t next = program_next_tick();
    printf("timer: first tick scheduled at %llu\n", next);
}

// 获取系统节拍数（供调试使用）
uint64_t get_sys_ticks(void) {
    return sys_ticks;
}

// 打印定时器状态（供调试使用，在非中断上下文中调用）
void timer_debug_print(void) {
    printf("timer: ticks=%llu, interrupt_count=%d\n", sys_ticks, timer_interrupt_count);
}
