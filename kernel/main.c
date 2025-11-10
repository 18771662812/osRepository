#include "uart.h"
#include "types.h"
#include "pmm.h"
#include "vm.h"
#include "trap.h"
#include "sbi.h"
#include "proc.h"

#ifndef NULL
#define NULL ((void*)0)
#endif

// 测试使用的外部计数器
extern volatile uint64_t ticks;

// 定时器初始化函数原型
extern void timer_init(void);

// 函数声明
extern int printf(char *fmt, ...);

void assert(int condition) {
	if (!condition) {
		printf("ASSERTION FAILED!\n");
		while(1) { // 死循环，停止执行
			__asm__ volatile("wfi");
		}
	}
}



// --------- 测试支撑与示例任务 ---------
static inline void msleep(uint64 ms) {
    // 假设 timebase ~10MHz，则1ms≈10,000 cycles
    const uint64 cycles_per_ms = 10000ULL;
    uint64 begin = get_time();
    uint64 target = begin + ms * cycles_per_ms;
    while (get_time() < target) {
        __asm__ volatile("wfi");
    }
}

static int create_process(void (*fn)(void)) {
    // 适配已有内核进程创建 API
    extern int kproc_create(void (*fn)(void *), void *arg, const char *name);
    static int seq = 0; char name[16];
    int n = seq++; if (n > 9999) n = 0;
    int i=0; name[i++]='p'; name[i++]='r'; name[i++]='o'; name[i++]='c'; name[i++]='-';
    name[i++] = '0' + (n/1000)%10; name[i++] = '0' + (n/100)%10; name[i++]='0'+(n/10)%10; name[i++]='0'+(n%10); name[i]=0;
    // 包装无参函数为有参签名
    void trampoline(void *x) { (void)x; fn(); }
    return kproc_create(trampoline, 0, name);
}

static void wait_process(void *unused) { (void)unused; msleep(200); }

// 简单任务：打印后结束
static void simple_task(void) {
    printf("simple_task running\n");
}

// 计算密集任务：做一些无意义计算并周期性让出
static void cpu_intensive_task(void) {
    volatile uint64 sum = 0;
    for (int i = 0; i < 50000; i++) {
        sum += i ^ (sum << 1);
        if ((i % 5000) == 0) yield();
    }
    (void)sum;
    printf("CPU intensive task completed\n");
}

// 生产者-消费者示例
static int buf_has = 0;
static int buf_value = 0;
static void *chan_empty = (void*)1;
static void *chan_full  = (void*)2;

static void shared_buffer_init(void) {
    buf_has = 0; buf_value = 0;
}

static void producer_task(void) {
    for (int i = 1; i <= 10; i++) {
        while (buf_has) {
            sleep(chan_empty);
        }
        buf_value = i;
        buf_has = 1;
        wakeup(chan_full);
        yield();
    }
}

static void consumer_task(void) {
    for (int i = 1; i <= 10; i++) {
        while (!buf_has) {
            sleep(chan_full);
        }
        int v = buf_value; (void)v;
        buf_has = 0;
        wakeup(chan_empty);
        yield();
    }
}

// --------- 测试集 ---------
static void test_process_creation(void) {
    printf("Testing process creation...\n");
    int pid = create_process(simple_task);
    assert(pid > 0);

    int count = 0;
    for (int i = 0; i < NPROC + 5; i++) {
        int pid2 = create_process(simple_task);
        if (pid2 > 0) count++; else break;
    }
    printf("Created %d processes\n", count);
    for (int i = 0; i < count; i++) wait_process(NULL);
}

static void test_scheduler(void) {
    printf("Testing scheduler...\n");
    for (int i = 0; i < 3; i++) create_process(cpu_intensive_task);
    uint64 start_time = get_time();
    msleep(1000);
    uint64 end_time = get_time();
    printf("Scheduler test completed in %lu cycles\n", end_time - start_time);
}

static void test_synchronization(void) {
    shared_buffer_init();
    create_process(producer_task);
    create_process(consumer_task);
    wait_process(NULL);
    wait_process(NULL);
    printf("Synchronization test completed\n");
}

static void run_process_creation_only(void *arg) {
    (void)arg;
    test_process_creation();
    printf("Process creation test finished.\n");
}

static void run_scheduler_test(void *arg) {
    (void)arg;
    test_scheduler();
    printf("Scheduler test finished.\n");
}

void main() {
    printf("main function started\n");
    
    // 初始化内存与页表（分配内核栈需要物理页）
    pmm_init();
    kvminit();
    
    trap_init();
    
    
    // 初始化进程与调度器
    proc_init();
    // 启动：运行调度器测试
    kproc_create(run_scheduler_test, 0, "test-scheduler");
    // 进入调度器（不返回）
    scheduler();
}