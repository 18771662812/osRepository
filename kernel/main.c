#include "uart.h"
#include "types.h"

// 函数声明
extern int printf(char *fmt, ...);
extern void clear_screen(void);
void test_printf_basic() {
    printf("Testing integer: %d\n", 42);
    printf("Testing negative: %d\n", -123);
    printf("Testing zero: %d\n", 0);
    printf("Testing hex: 0x%x\n", 0xABC);
    printf("Testing string: %s\n", "Hello");
    printf("Testing char: %c\n", 'X');
    printf("Testing percent: %%\n");
 }
 void test_printf_edge_cases() {
    printf("INT_MAX: %d\n", 2147483647);
     printf("INT_MIN: %d\n", -2147483648);
    printf("NULL string: %s\n", (char*)0);
    printf("Empty string: %s\n", "");
 }

void main() {
    uart_puts("Hello\n");
    // 使用printf输出信息
    test_printf_basic();
    test_printf_edge_cases();
     // 使用 ANSI 转义序列清屏
    clear_screen(); 
    
}