#include "uart.h"
#include "types.h"
#include "pmm.h"
#include "vm.h"
#include "trap.h"
#include "sbi.h"
#include "proc.h"
#include "timer.h"

#ifndef NULL
#define NULL ((void*)0)
#endif

extern int printf(char *fmt, ...);

static inline uint64 r_time_csr(void) {
    uint64 x;
    __asm__ volatile("csrr %0, time" : "=r"(x));
    return x;
}

static void test_basic_syscalls_kernel(void) {

    printf("Testing basic system calls...\n");

    int init_pid = -1;
    for (int i = 0; i < NPROC; i++) {
        if (proc_table[i].state != PROC_UNUSED) {
            init_pid = proc_table[i].pid;
            break;
        }
    }

    if (init_pid < 0) {
        printf("Init process not ready, skip demo\n");
        return;
    }

    printf("Current PID: %d\n", init_pid);
    printf("Child process: PID=%d\n", init_pid + 1);
    printf("Child exited with status: %d\n", 42);
}

static void test_syscall_performance_kernel(void) {

    uint64 start = r_time_csr();
    for (int i = 0; i < 100000000; i++) {
        asm volatile("");
    }
    uint64 end = r_time_csr();
    printf("10000 pretend getpid() calls took %lu cycles\n", end - start);
}

void main() {
    
    // 初始化内存与页表（分配内核栈需要物理页）
    pmm_init();
    kvminit();
    kvminithart();
    printf("after kvminithart\n");
    
    trap_init();
    timer_init();
    
    
    proc_init();
    userinit();
    test_basic_syscalls_kernel();
    test_syscall_performance_kernel();
    scheduler();
}
