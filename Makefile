# Makefile for RISC-V OS

# 交叉编译工具链前缀
CROSS_COMPILE = riscv64-unknown-elf-
CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

# 编译标志
CFLAGS = -Wall -O2 -ffreestanding -nostdlib -nostdinc -mcmodel=medany -march=rv64imafd -mabi=lp64
LDFLAGS = -T kernel/kernel.ld

# 源文件
ASM_SRCS = kernel/entry.S kernel/kernelvec.S kernel/swtch.S
C_SRCS = kernel/start.c kernel/main.c kernel/uart.c kernel/printf.c kernel/console.c kernel/pmm.c kernel/vm.c \
         kernel/trap.c kernel/sbi.c kernel/timer.c kernel/proc.c
OBJS = $(ASM_SRCS:.S=.o) $(C_SRCS:.c=.o)

# 目标文件
KERNEL = kernel.elf

# 默认目标
all: $(KERNEL)

# 链接生成内核
$(KERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^
	$(OBJDUMP) -S $@ > kernel.asm
	$(OBJDUMP) -t $@ | grep -E "(start|end|text)" > kernel.sym

# 编译汇编文件
%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

# 编译C文件
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# 使用QEMU运行
qemu: $(KERNEL)
	qemu-system-riscv64 -machine virt -nographic -kernel kernel.elf -bios none

# 清理
clean:
	rm -f $(OBJS) $(KERNEL) kernel.asm kernel.sym

.PHONY: all clean qemu
