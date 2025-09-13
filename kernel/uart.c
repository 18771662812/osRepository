#include "uart.h"

// UART寄存器定义
#define UART_THR 0x10000000   // 发送保持寄存器（写入要发送的数据）
#define UART_LSR 0x10000005   // 线状态寄存器（检查发送状态）

// LSR寄存器的THRE位（发送保持寄存器为空）在第5位
#define LSR_THRE (1 << 5)     // 0x20

// 写入一个字符到UART
void uart_putc(char c) {
    // 等待直到发送保持寄存器为空
    // 这里检查LSR的THRE位，该位为1表示THR为空，可以发送新的数据
    while((*((volatile unsigned char*)UART_LSR) & LSR_THRE) == 0)
        ;
    
    // 向THR写入要发送的字符
    *((volatile unsigned char*)UART_THR) = c;
}

// 输出字符串
void uart_puts(char *s) {
    while(*s != '\0') {
        uart_putc(*s);
        s++;
    }
}
