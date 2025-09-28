#include "pmm.h"
#include "uart.h"

// 声明printf函数
extern int printf(char *fmt, ...);

// 手动定义标准库常量和类型
#ifndef NULL
#define NULL ((void*)0)
#endif

#ifndef size_t
typedef unsigned long size_t;
#endif

// 全局物理内存管理器实例
struct pmm pmm_manager = {0};


// 简单的memset实现
static void memset(void* ptr, int value, size_t size) {
    unsigned char* p = (unsigned char*)ptr;
    for (size_t i = 0; i < size; i++) {
        p[i] = (unsigned char)value;
    }
}

// 简单的内存检测函数 (针对QEMU virt机器)
static uint64_t detect_memory_size(void) {
    // QEMU virt机器默认有128MB内存
    // 实际项目中应该从设备树或BIOS获取
    return 128 * 1024 * 1024; // 128MB
}

// 初始化物理内存管理器
void pmm_init(void) {
    // 检测内存大小
    uint64_t mem_size = detect_memory_size();
    
    // 设置内存范围
    pmm_manager.mem_start = KERNEL_BASE;
    pmm_manager.mem_end = KERNEL_BASE + mem_size;
    
    // 计算总页面数
    pmm_manager.total_pages = (mem_size - KERNEL_STACK_SIZE) / PAGE_SIZE;
    pmm_manager.free_pages = 0;
    pmm_manager.used_pages = 0;
    
    // 初始化空闲链表
    pmm_manager.freelist = NULL;
    
    // 计算内核结束位置 (包括代码、数据、BSS和栈)
    extern char _bss_end[];
    uint64_t kernel_end = align_page((uint64_t)_bss_end + KERNEL_STACK_SIZE);
    
    // 将剩余内存添加到空闲链表
    uint64_t free_start = kernel_end;
    uint64_t free_end = pmm_manager.mem_end;
    
    // 从高地址向低地址添加页面到空闲链表
    // 这样可以避免与内核数据冲突
    for (uint64_t addr = free_end - PAGE_SIZE; 
         addr >= free_start; 
         addr -= PAGE_SIZE) {
        
        struct run *r = (struct run*)addr;
        r->next = pmm_manager.freelist;
        pmm_manager.freelist = r;
        pmm_manager.free_pages++;
    }
    
    // 输出初始化信息
    printf("Physical Memory Manager initialized:\n");
    printf("  Total memory: 128MB\n");
    printf("  Total pages: %llu\n", pmm_manager.total_pages);
    printf("  Free pages: %llu\n", pmm_manager.free_pages);
}

// 分配一个物理页
void* alloc_page(void) {
    if (pmm_manager.freelist == NULL) {
        printf("ERROR: No free pages available!\n");
        return NULL;
    }
    
    // 从空闲链表头部取出一个页面
    struct run *r = pmm_manager.freelist;
    pmm_manager.freelist = r->next;
    
    pmm_manager.free_pages--;
    pmm_manager.used_pages++;
    
    // 清零页面内容
    memset(r, 0, PAGE_SIZE);
    
    return (void*)r;
}

// 释放一个物理页
void free_page(void* page) {
    if (page == NULL) {
        return;
    }
    
    // 检查页面地址是否有效
    if ((uint64_t)page < pmm_manager.mem_start || 
        (uint64_t)page >= pmm_manager.mem_end) {
        printf("ERROR: Invalid page address for free!\n");
        return;
    }
    
    // 检查页面是否页面对齐
    if ((uint64_t)page & (PAGE_SIZE - 1)) {
        printf("ERROR: Page address not aligned!\n");
        return;
    }
    
    // 将页面添加到空闲链表头部
    struct run *r = (struct run*)page;
    r->next = pmm_manager.freelist;
    pmm_manager.freelist = r;
    
    pmm_manager.free_pages++;
    pmm_manager.used_pages--;
}

// 分配连续的n个页面
void* alloc_pages(int n) {
    if (n <= 0) {
        return NULL;
    }
    
    if (n == 1) {
        return alloc_page();
    }
    
    // 对于连续页面分配，这里使用简单的策略
    // 实际实现可能需要更复杂的算法来避免碎片
    void* pages = alloc_page();
    if (pages == NULL) {
        return NULL;
    }
    
    // 尝试分配后续页面
    for (int i = 1; i < n; i++) {
        void* next_page = alloc_page();
        if (next_page == NULL) {
            // 分配失败，释放已分配的页面
            for (int j = 0; j < i; j++) {
                free_page((char*)pages + j * PAGE_SIZE);
            }
            return NULL;
        }
    }
    
    return pages;
}

// 释放连续的n个页面
void free_pages(void* pages, int n) {
    if (pages == NULL || n <= 0) {
        return;
    }
    
    for (int i = 0; i < n; i++) {
        free_page((char*)pages + i * PAGE_SIZE);
    }
}

// 获取总页面数
uint64_t get_total_pages(void) {
    return pmm_manager.total_pages;
}

// 获取空闲页面数
uint64_t get_free_pages(void) {
    return pmm_manager.free_pages;
}

// 获取已用页面数
uint64_t get_used_pages(void) {
    return pmm_manager.used_pages;
}

// 打印内存管理信息
void pmm_info(void) {
    printf("=== Physical Memory Manager Info ===\n");
    printf("Total pages: %llu\n", pmm_manager.total_pages);
    printf("Free pages: %llu\n", pmm_manager.free_pages);
    printf("Used pages: %llu\n", pmm_manager.used_pages);
    
    if (pmm_manager.total_pages > 0) {
        uint64_t usage_percent = (pmm_manager.used_pages * 100) / pmm_manager.total_pages;
        printf("Memory usage: %llu%%\n", usage_percent);
    }
}

