typedef unsigned char uint8_t;
extern void main(void);

#define UART0_BASE 0x10000000ULL
#define UART_THR 0x00    // 发送保持寄存器
#define UART_LSR 0x05    // 线状态寄存器
#define UART_LSR_EMPTY_MASK 0x40  // 发送保持寄存器空标志位

// 写入UART寄存器
static inline void uart_write_reg(int reg, char c) {
    volatile uint8_t *p = (volatile uint8_t *)(UART0_BASE + reg);
    *p = c;
}

// 读取UART寄存器
static inline char uart_read_reg(int reg) {
    volatile uint8_t *p = (volatile uint8_t *)(UART0_BASE + reg);
    return *p;
}

// 初始化UART
static void uart_init() {
    // 简单起见，假设QEMU已经初始化了大部分UART配置
    // 在实际硬件上需要配置波特率等参数
}

// 通过UART发送字符
static void uart_putc(char c) {
    // 等待发送缓冲区为空
    while ((uart_read_reg(UART_LSR) & UART_LSR_EMPTY_MASK) == 0)
        ;
    uart_write_reg(UART_THR, c);
}

// 启动函数
void start() {
    // 初始化UART
    uart_init();
    
    // 输出启动信息
    const char *msg = "RISC-V OS Starting...\n";
    for (const char *p = msg; *p; p++) {
        uart_putc(*p);
    }

    // 跳转到main函数
    main();

    // 不应该返回到这里
    while (1) {
        __asm__ volatile("wfi");
    }
}
