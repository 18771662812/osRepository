#ifndef PMM_H
#define PMM_H

#include "types.h"

// 内存管理相关常量
#define PAGE_SIZE 4096                    // 页面大小 4KB
#define PAGE_SHIFT 12                     // 页面大小位移
#define PAGE_MASK (~(PAGE_SIZE - 1))      // 页面掩码

// 内存布局常量 (参考kernel.ld)
#define KERNEL_BASE 0x80000000UL          // 内核加载地址
#define KERNEL_STACK_SIZE 4096            // 内核栈大小

// 空闲页结构体 (类似xv6的run结构)
struct run {
    struct run *next;                     // 指向下一个空闲页
};

// 物理内存管理器结构
struct pmm {
    struct run *freelist;                 // 空闲页链表
    uint64_t total_pages;                 // 总页面数
    uint64_t free_pages;                  // 空闲页面数
    uint64_t used_pages;                  // 已用页面数
    uint64_t mem_start;                   // 内存起始地址
    uint64_t mem_end;                     // 内存结束地址
};

// 全局物理内存管理器实例
extern struct pmm pmm_manager;

// 函数声明
void pmm_init(void);                      // 初始化物理内存管理器
void* alloc_page(void);                   // 分配一个物理页
void free_page(void* page);               // 释放一个物理页
void* alloc_pages(int n);                 // 分配连续的n个页面
void free_pages(void* pages, int n);      // 释放连续的n个页面
uint64_t get_total_pages(void);           // 获取总页面数
uint64_t get_free_pages(void);            // 获取空闲页面数
uint64_t get_used_pages(void);            // 获取已用页面数
void pmm_info(void);                      // 打印内存管理信息

// 位图：用于跟踪物理页的分配状态
// 每一位对应一个物理页（PFN）。1 表示已分配，0 表示空闲。
extern unsigned char *pmm_bitmap;         // 指向位图内存的指针
extern uint64_t pmm_bitmap_bytes;         // 位图占用的字节数

// Bitmap helpers
void bitmap_init(void);
void bitmap_set_pfn(uint64_t pfn);
void bitmap_clear_pfn(uint64_t pfn);
int  bitmap_test_pfn(uint64_t pfn);

// 辅助函数
static inline uint64_t align_page(uint64_t addr) {
    return (addr + PAGE_SIZE - 1) & PAGE_MASK;
}

static inline uint64_t page_to_pfn(void* page) {
    return ((uint64_t)page - pmm_manager.mem_start) >> PAGE_SHIFT;
}

static inline void* pfn_to_page(uint64_t pfn) {
    return (void*)(pmm_manager.mem_start + (pfn << PAGE_SHIFT));
}

// Convenience: check whether a physical page (address) is allocated
static inline int pmm_is_allocated(void *page) {
    if (!page) return 0;
    uint64_t addr = (uint64_t)page;
    if (addr < pmm_manager.mem_start || addr >= pmm_manager.mem_end) return 0;
    uint64_t pfn = page_to_pfn(page);
    return bitmap_test_pfn(pfn);
}

#endif // PMM_H
