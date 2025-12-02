#include "vm.h"
#include "pmm.h"

extern int printf(char *fmt, ...);
extern char trampoline[];

// Global kernel page table
pagetable_t kernel_pagetable = 0;

// Minimal memset since we compile without libc
static void *k_memset(void *dst, int c, uint64 n) {
	unsigned char *p = (unsigned char*)dst;
	for (uint64 i = 0; i < n; i++) p[i] = (unsigned char)c;
	return dst;
}

static void *k_memcpy(void *dst, const void *src, uint64 n) {
	unsigned char *d = (unsigned char*)dst;
	const unsigned char *s = (const unsigned char*)src;
	for (uint64 i = 0; i < n; i++) d[i] = s[i];
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

// Exported helpers
pte_t* walk_create(pagetable_t pt, uint64 va) { return walk_inner((uint64)pt, va, 1); }
pte_t* walk_lookup(pagetable_t pt, uint64 va) { return walk_inner((uint64)pt, va, 0); }

int map_page(pagetable_t pt, uint64 va, uint64 pa, int perm) {
	pte_t *pte = walk_inner(pt, va, 1);
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

pagetable_t uvmcreate(void) {
	return create_pagetable();
}

uint64 uvmalloc(pagetable_t pt, uint64 oldsz, uint64 newsz, int perm) {
	if (newsz < oldsz) return oldsz;
	uint64 start = PGROUNDUP(oldsz);
	uint64 a = start;
	for (; a < newsz; a += PGSIZE) {
		void *mem = alloc_page();
		if (!mem) {
			uvmunmap(pt, start, a - start);
			return 0;
		}
		map_page(pt, a, (uint64)mem, perm | PTE_U);
	}
	return newsz;
}

uint64 uvmdealloc(pagetable_t pt, uint64 oldsz, uint64 newsz) {
	if (newsz >= oldsz) return oldsz;
	uint64 newa = PGROUNDUP(newsz);
	if (newa < PGROUNDUP(oldsz)) {
		uvmunmap(pt, newa, PGROUNDUP(oldsz) - newa);
	}
	return newsz;
}

void uvmunmap(pagetable_t pt, uint64 va, uint64 size) {
	for (uint64 a = va; a < va + size; a += PGSIZE) {
		pte_t *pte = walk_lookup(pt, a);
		if (!pte || !(*pte & PTE_V)) continue;
		uint64 pa = PA_FROM_PTE(*pte);
		free_page((void*)pa);
		*pte = 0;
	}
}

void free_user_pagetable(pagetable_t pt) {
	destroy_pagetable(pt);
}

static int copyin_internal(pagetable_t pt, char *dst, uint64 srcva, uint64 len, int instr) {
	uint64 n, pa;
	while (len > 0) {
		pte_t *pte = walk_lookup(pt, srcva);
		if (!pte || !(*pte & PTE_V) || !(*pte & PTE_U)) return -1;
		pa = PA_FROM_PTE(*pte);
		uint64 offset = srcva & (PGSIZE-1);
		uint64 tocopy = PGSIZE - offset;
		if (tocopy > len) tocopy = len;
		char *p = (char*)(pa + offset);
		for (n = 0; n < tocopy; n++) {
			if (instr && p[n] == 0) {
				dst[n] = 0;
				return 0;
			}
			dst[n] = p[n];
		}
		if (instr) dst += n;
		srcva += tocopy;
		dst += tocopy;
		len -= tocopy;
		if (instr) return -1;
	}
	return 0;
}

int copyin(pagetable_t pt, char *dst, uint64 srcva, uint64 len) {
	return copyin_internal(pt, dst, srcva, len, 0);
}

int copyinstr(pagetable_t pt, char *dst, uint64 srcva, int max) {
	return copyin_internal(pt, dst, srcva, max, 1);
}

int copyout(pagetable_t pt, uint64 dstva, const char *src, uint64 len) {
	while (len > 0) {
		pte_t *pte = walk_lookup(pt, dstva);
		if (!pte || !(*pte & PTE_V) || !(*pte & PTE_U)) return -1;
		uint64 pa = PA_FROM_PTE(*pte);
		uint64 offset = dstva & (PGSIZE-1);
		uint64 tocopy = PGSIZE - offset;
		if (tocopy > len) tocopy = len;
		char *p = (char*)(pa + offset);
		for (uint64 n = 0; n < tocopy; n++) p[n] = src[n];
		dstva += tocopy;
		src += tocopy;
		len -= tocopy;
	}
	return 0;
}

int uvmcopy(pagetable_t old, pagetable_t newpt, uint64 sz) {
	for (uint64 i = 0; i < sz; i += PGSIZE) {
		pte_t *pte = walk_lookup(old, i);
		if (!pte || !(*pte & PTE_V)) {
			return -1;
		}
		uint64 pa = PA_FROM_PTE(*pte);
		int flags = PTE_FLAGS(*pte) & (PTE_R | PTE_W | PTE_X | PTE_U);
		void *mem = alloc_page();
		if (!mem) {
			uvmunmap(newpt, 0, i);
			return -1;
		}
		k_memcpy(mem, (void*)pa, PGSIZE);
		if (map_page(newpt, i, (uint64)mem, flags) != 0) {
			free_page(mem);
			uvmunmap(newpt, 0, i + PGSIZE);
			return -1;
		}
	}
	return 0;
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
	for (uint64 off = 0; off < size; off += PGSIZE) {
		uint64 p = va + off;
		uint64 pa_page = pa + off;
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
	
	// 映射整个可用物理内存区域
	uint64 mem_size = pmm_manager.mem_end - KERNEL_BASE;
	if (map_region(kernel_pagetable, KERNEL_BASE, KERNEL_BASE, mem_size, PTE_R | PTE_W | PTE_X) != 0) {
		printf("ERROR: Failed to map kernel memory!\n");
		return;
	}
	
	// 4. 映射设备内存 (UART等)
	if (map_region(kernel_pagetable, UART0_BASE, UART0_BASE, UART0_SIZE, PTE_R | PTE_W) != 0) {
		printf("ERROR: Failed to map UART!\n");
		return;
	}

	// 5. 映射 trampoline（供内核/用户共享）
	if (map_region(kernel_pagetable, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X) != 0) {
		printf("ERROR: Failed to map trampoline!\n");
		return;
	}
	
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
	
}
