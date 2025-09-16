#include "uart.h"

// 方案1：使用ANSI转义序列清屏
void clear_screen(void) {
    // ESC [ 2 J - 清除整个屏幕
    uart_putc(0x1B);    // ESC
    uart_putc('[');
    uart_putc('2');
    uart_putc('J');
    
    // ESC [ H - 将光标移动到屏幕左上角
    uart_putc(0x1B);    // ESC
    uart_putc('[');
    uart_putc('H');
}
