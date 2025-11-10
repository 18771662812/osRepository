/* 简单的 SBI helper：实现 sbi_set_timer 和 get_time（读取时钟） */
#include "types.h"

// 使用 SBI TIME extension 设置下一次时钟中断（stime_value 为周期的绝对时刻）
void sbi_set_timer(uint64_t stime_value) {
    register uint64_t a0 asm("a0") = stime_value;
    register uint64_t a7 asm("a7") = 0x54494D45; /* 'TIME' */
    register uint64_t a6 asm("a6") = 0; /* SBI_EXT_TIME_SET_TIMER */
    asm volatile ("ecall" : "+r" (a0) : "r" (a6), "r" (a7) : "memory");
}

// 读取当前时间（在 RV64 上直接读取 time CSR）
uint64_t get_time(void) {
    uint64_t t;
    __asm__ volatile ("csrr %0, time" : "=r" (t));
    return t;
}
