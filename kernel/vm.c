#include "vm.h"
#include "pmm.h"

extern int printf(char *fmt, ...);

// Global kernel page table
pagetable_t kernel_pagetable = 0;

// Minimal memset since we compile without libc
static void *k_memset(void *dst, int c, uint64 n) {
	unsigned char *p = (unsigned char*)dst;
	for (uint64 i = 0; i < n; i++) p[i] = (unsigned char)c;
	return dst;
}

static inline uint64 kvaddr_to_paddr(void *va) {
	// In this toy kernel we identity-map physical to kernel virtual for simplicity.
	// If later you introduce a kernel virtual base, adjust here.
	return (uint64)va;
}

static inline void* paddr_to_kvaddr(uint64 pa) {
	return (void*)pa;
}

// Allocate a zeroed page for a pagetable and return its physical address
static uint64 alloc_pt_page_pa(void) {
	void *page = alloc_page();
	if (!page) return 0;
	k_memset(page, 0, PGSIZE);
	return kvaddr_to_paddr(page);
}

pagetable_t create_pagetable(void) {
	uint64 pa = alloc_pt_page_pa();
	return (pagetable_t)pa;
}

static pte_t* walk_inner(uint64 pt_pa, uint64 va, int alloc) {
	// Walk levels 2 -> 1 -> 0; create intermediate levels if alloc
	for (int level = 2; level > 0; level--) {
		pte_t *pt = (pte_t*)paddr_to_kvaddr(pt_pa);
		uint64 idx = VPN_MASK(va, level);
		pte_t *pte = &pt[idx];
		if (*pte & PTE_V) {
			uint64 next_pa = PA_FROM_PTE(*pte);
			pt_pa = next_pa;
			continue;
		} else {
			if (!alloc) return 0;
			uint64 next_pa = alloc_pt_page_pa();
			if (!next_pa) return 0;
			*pte = MAKE_PTE(next_pa, PTE_V);
			pt_pa = next_pa;
		}
	}
	// Return pointer to leaf pte in level 0
	pte_t *l0 = (pte_t*)paddr_to_kvaddr(pt_pa);
	return &l0[VPN_MASK(va, 0)];
}

pte_t* walk_create(pagetable_t pt, uint64 va) {
	return walk_inner((uint64)pt, va, 1);
}

pte_t* walk_lookup(pagetable_t pt, uint64 va) {
	return walk_inner((uint64)pt, va, 0);
}

int map_page(pagetable_t pt, uint64 va, uint64 pa, int perm) {
	pte_t *pte = walk_create(pt, va);
	if (!pte) return -1;
	if (*pte & PTE_V) {
		// remap is an error in this simple version
		return -2;
	}
	*pte = MAKE_PTE(pa, PTE_V | (perm & PTE_PERM_MASK) | PTE_A | PTE_D);
	return 0;
}

static void free_table_recursive(uint64 pt_pa, int level) {
	pte_t *pt = (pte_t*)paddr_to_kvaddr(pt_pa);
	for (int i = 0; i < 512; i++) {
		pte_t pte = pt[i];
		if (!(pte & PTE_V)) continue;
		uint64 child_pa = PA_FROM_PTE(pte);
		if (level > 0 && (PTE_FLAGS(pte) == PTE_V)) {
			// valid intermediate PTE (no R/W/X)
			free_table_recursive(child_pa, level - 1);
		}
	}
	free_page((void*)pt);
}

void destroy_pagetable(pagetable_t pt) {
	if (!pt) return;
	free_table_recursive((uint64)pt, 2);
}

// Dumpers
static void dump_indent(int level) {
	for (int i = 0; i < level; i++) printf("  ");
}

void dump_pagetable(pagetable_t pt, int level) {
	pte_t *root = (pte_t*)paddr_to_kvaddr((uint64)pt);
	for (int i = 0; i < 512; i++) {
		pte_t pte = root[i];
		if (!(pte & PTE_V)) continue;
		uint64 child = PA_FROM_PTE(pte);
		dump_indent(level);
		printf("[%d] PTE=0x%llx -> pa=0x%llx flags=0x%llx\n", i, (uint64)pte, child, (uint64)PTE_FLAGS(pte));
		if (level < 2 && (PTE_FLAGS(pte) == PTE_V)) {
			// intermediate
			pagetable_t nxt = (pagetable_t)child;
			dump_pagetable(nxt, level + 1);
		}
	}
}

// Map a region of memory
int map_region(pagetable_t pt, uint64 va, uint64 pa, uint64 size, int perm) {
	uint64 a = va;
	uint64 last = va + size - 1;
	
	for (uint64 p = a; p <= last; p += PGSIZE) {
		uint64 pa_page = pa + (p - a);
		if (map_page(pt, p, pa_page, perm) != 0) {
			return -1;
		}
	}
	return 0;
}

// Initialize kernel page table
void kvminit(void) {
	// 1. 创建内核页表
	kernel_pagetable = create_pagetable();
	if (!kernel_pagetable) {
		printf("ERROR: Failed to create kernel page table!\n");
		return;
	}
	
	// 2. 映射内核代码段 (R+X权限) - 简化版本
	// 映射整个内核区域，从KERNEL_BASE开始
	uint64 kernel_size = 0x100000; // 1MB 内核区域
	if (map_region(kernel_pagetable, KERNEL_BASE, KERNEL_BASE, kernel_size, PTE_R | PTE_X) != 0) {
		printf("ERROR: Failed to map kernel text!\n");
		return;
	}
	
	// 3. 映射内核数据段 (R+W权限) - 简化版本
	// 映射数据区域，紧跟在代码段后面
	uint64 data_start = KERNEL_BASE + kernel_size;
	uint64 data_size = 0x100000; // 1MB 数据区域
	if (map_region(kernel_pagetable, data_start, data_start, data_size, PTE_R | PTE_W) != 0) {
		printf("ERROR: Failed to map kernel data!\n");
		return;
	}
	
	// 4. 映射设备内存 (UART等)
	if (map_region(kernel_pagetable, UART0_BASE, UART0_BASE, UART0_SIZE, PTE_R | PTE_W) != 0) {
		printf("ERROR: Failed to map UART!\n");
		return;
	}
	
	printf("Kernel page table initialized successfully\n");
}

// Activate kernel page table
void kvminithart(void) {
	if (!kernel_pagetable) {
		printf("ERROR: Kernel page table not initialized!\n");
		return;
	}
	
	// 激活内核页表
	w_satp(MAKE_SATP(kernel_pagetable));
	sfence_vma();
	
	printf("Virtual memory enabled (Sv39 mode)\n");
}
