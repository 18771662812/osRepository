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
USER_CFLAGS = -Wall -O2 -ffreestanding -nostdlib -nostartfiles -mcmodel=medany -march=rv64imafd -mabi=lp64 -Iuser
LDFLAGS = -T kernel/kernel.ld

# 源文件
ASM_SRCS = kernel/entry.S kernel/kernelvec.S kernel/swtch.S kernel/trampoline.S
C_SRCS = kernel/start.c kernel/main.c kernel/uart.c kernel/printf.c kernel/console.c kernel/pmm.c kernel/vm.c \
         kernel/trap.c kernel/sbi.c kernel/timer.c kernel/proc.c kernel/spinlock.c kernel/semaphore.c kernel/syscall.c \
         kernel/file.c kernel/sleeplock.c kernel/bio.c kernel/log.c kernel/inode.c kernel/ramdisk.c
OBJS = $(ASM_SRCS:.S=.o) $(C_SRCS:.c=.o)

USER_OBJS = user/crt0.o user/test_basic.o user/printf.o user/ulib.o user/usys.o
USER_ELF = user/test_basic.elf
USER_BIN = user/test_basic.bin
USER_BIN_OBJ = user/test_basic_bin.o
OBJS += $(USER_BIN_OBJ)

# 目标文件
KERNEL = kernel.elf

# 默认目标
all: $(KERNEL)

# 链接生成内核
$(KERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^
	$(OBJDUMP) -S $@ > kernel.asm
	$(OBJDUMP) -t $@ | grep -E "(start|end|text)" > kernel.sym

$(USER_ELF): $(USER_OBJS) user/user.ld
	$(CC) $(USER_CFLAGS) -T user/user.ld -o $@ $(USER_OBJS)

$(USER_BIN): $(USER_ELF)
	$(OBJCOPY) -O binary $< $@

$(USER_BIN_OBJ): $(USER_BIN)
	$(LD) -r -b binary -o $@ $<

# 编译汇编文件
user/%.o: user/%.S
	$(CC) $(USER_CFLAGS) -c $< -o $@

user/%.o: user/%.c
	$(CC) $(USER_CFLAGS) -c $< -o $@

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
	rm -f $(OBJS) $(KERNEL) kernel.asm kernel.sym $(USER_OBJS) $(USER_ELF) $(USER_BIN) $(USER_BIN_OBJ)

.PHONY: all clean qemu
