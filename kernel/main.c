#include "uart.h"
#include "types.h"
#include "pmm.h"
#include "vm.h"

// 函数声明
extern int printf(char *fmt, ...);

// 简单的assert函数实现
void assert(int condition) {
	if (!condition) {
		printf("ASSERTION FAILED!\n");
		while(1) { // 死循环，停止执行
			__asm__ volatile("wfi");
		}
	}
}

void test_physical_memory(void) {
	// 测试基本分配和释放
	void *page1 = alloc_page();
	void *page2 = alloc_page();
	assert(page1 != page2);
	assert(((uint64_t)page1 & 0xFFF) == 0); // 页对齐检查
	
	// 测试数据写入
	*(int*)page1 = 0x12345678;
	assert(*(int*)page1 == 0x12345678);
	
	// 测试释放和重新分配
	free_page(page1);
	void *page3 = alloc_page();
	// page3可能等于page1(取决于分配策略)
	free_page(page2);
	free_page(page3);
	
	// 显示最终内存信息
	pmm_info();
}

void test_pagetable(void) {
	pagetable_t pt = create_pagetable();
	
	// 测试基本映射
	uint64 va = 0x1000000;
	uint64 pa = (uint64)alloc_page();
	assert(map_page(pt, va, pa, PTE_R | PTE_W) == 0);
	
	// 测试地址转换
	pte_t *pte = walk_lookup(pt, va);
	assert(pte != 0 && (*pte & PTE_V));
	assert(PTE_PA(*pte) == pa);
	
	// 测试权限位
	assert(*pte & PTE_R);
	assert(*pte & PTE_W);
	assert(!(*pte & PTE_X));
	
	destroy_pagetable(pt);
	free_page((void*)pa);
}

void main() {
	printf("Hello OS\n");
	
	// 初始化物理内存管理器
	pmm_init();
	
	// 初始化内核页表
	kvminit();
	
	// 激活虚拟内存
	kvminithart();
	
	// 测试物理内存管理器
	test_physical_memory();
	
	// 测试页表管理系统
	test_pagetable();
	
	// ANSI 转义序列清屏
	//clear_screen(); 
	
}