#include "uart.h"
#include "types.h"
#include "pmm.h"
#include "vm.h"
#include "trap.h"
#include "sbi.h"
#include "proc.h"
#include "timer.h"
#include "semaphore.h"

#ifndef NULL
#define NULL ((void*)0)
#endif

extern int printf(char *fmt, ...);

static inline void msleep(uint64 ms) {
    // 假设 timebase ~10MHz，则1ms≈10,000 cycles
    const uint64 cycles_per_ms = 10000ULL;
    uint64 begin = get_time();
    uint64 target = begin + ms * cycles_per_ms;
    while (get_time() < target) {
        __asm__ volatile("wfi");
    }
}

static void kproc_trampoline(void *arg) {
    void (*fn)(void) = (void (*)(void))arg;
    fn();
}

static int spawn_process(void (*fn)(void)) {
    static int seq = 0; char name[16];
    int n = seq++; if (n > 9999) n = 0;
    int i=0; name[i++]='p'; name[i++]='r'; name[i++]='o'; name[i++]='c'; name[i++]='-';
    name[i++] = '0' + (n/1000)%10; name[i++] = '0' + (n/100)%10; name[i++]='0'+(n/10)%10; name[i++]='0'+(n%10); name[i]=0;
    return kproc_create(kproc_trampoline, (void*)fn, name);
}

static void cpu_intensive_task(void) {
    volatile uint64 sum = 0;
    for (int i = 0; i < 50000; i++) {
        sum += i ^ (sum << 1);
        if ((i % 5000) == 0) yield();
    }
    (void)sum;
    printf("CPU intensive task completed\n");
}

static void run_scheduler_test(void *arg) {
    (void)arg;
    printf("Testing scheduler...\n");
    for (int i = 0; i < 3; i++) spawn_process(cpu_intensive_task);
    uint64 start_time = get_time();
    msleep(1000);
    uint64 end_time = get_time();
    printf("Scheduler test completed in %lu cycles\n", end_time - start_time);
    printf("Scheduler test finished.\n");
    debug_proc_table();
}

static void info_task(void) {
    printf("info_task running\n");
    yield();
}

static void run_creation_test(void *arg) {
    (void)arg;
    printf("Testing bulk process creation...\n");
    for (int i = 0; i < 10; i++) {
        if (spawn_process(info_task) < 0) {
            printf("spawn process %d failed\n", i);
            break;
        }
    }
    msleep(200);
    debug_proc_table();
    printf("Bulk creation test finished.\n");
}

#define PC_BUFFER_SIZE 4
#define PC_ITEMS 10
static struct semaphore sem_empty;
static struct semaphore sem_full;
static struct semaphore sem_mutex;
static struct semaphore sem_done;
static int pc_buffer[PC_BUFFER_SIZE];
static int pc_head = 0;
static int pc_tail = 0;

static void pc_init(void) {
    sem_init(&sem_empty, PC_BUFFER_SIZE, "pc_empty");
    sem_init(&sem_full, 0, "pc_full");
    sem_init(&sem_mutex, 1, "pc_mutex");
    sem_init(&sem_done, 0, "pc_done");
    pc_head = pc_tail = 0;
}

static void producer_task(void) {
    for (int item = 1; item <= PC_ITEMS; item++) {
        sem_wait(&sem_empty);
        sem_wait(&sem_mutex);
        pc_buffer[pc_tail] = item;
        pc_tail = (pc_tail + 1) % PC_BUFFER_SIZE;
        printf("[producer] item %d\n", item);
        sem_signal(&sem_mutex);
        sem_signal(&sem_full);
        yield();
    }
    printf("[producer] done\n");
}

static void consumer_task(void) {
    for (int i = 1; i <= PC_ITEMS; i++) {
        sem_wait(&sem_full);
        sem_wait(&sem_mutex);
        int value = pc_buffer[pc_head];
        pc_head = (pc_head + 1) % PC_BUFFER_SIZE;
        printf("[consumer] got %d\n", value);
        sem_signal(&sem_mutex);
        sem_signal(&sem_empty);
        yield();
    }
    printf("[consumer] done\n");
    sem_signal(&sem_done);
}

static void run_sync_test(void *arg) {
    (void)arg;
    printf("Testing producer-consumer synchronization...\n");
    pc_init();
    int prod = spawn_process(producer_task);
    int cons = spawn_process(consumer_task);
    if (prod < 0 || cons < 0) {
        printf("Failed to spawn producer/consumer (prod=%d cons=%d)\n", prod, cons);
        return;
    }
    printf("Spawned producer PID=%d consumer PID=%d\n", prod, cons);
    sem_wait(&sem_done);
    printf("Producer-consumer test finished.\n");
}

void main() {
    printf("main function started\n");
    
    // 初始化内存与页表（分配内核栈需要物理页）
    pmm_init();
    kvminit();
    
    trap_init();
    timer_init();
    
    
    // 初始化进程与调度器
    proc_init();
    // 启动：运行调度器与同步测试
    kproc_create(run_scheduler_test, 0, "test-scheduler");
    kproc_create(run_sync_test, 0, "test-sync");
    kproc_create(run_creation_test, 0, "test-create");
    // 进入调度器（不返回）
    scheduler();
}
