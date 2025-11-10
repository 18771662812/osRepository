#ifndef VM_H
#define VM_H

#include "types.h"
#include "pmm.h"

// Sv39 constants
#define PGSIZE           4096UL
#define PTE_V            (1UL<<0)
#define PTE_R            (1UL<<1)
#define PTE_W            (1UL<<2)
#define PTE_Z            (1UL<<3) // reserved bit position in Sv39 (we'll not use)
#define PTE_X            (1UL<<3) // reuse for execute to align with simple mask (note: in real Sv39, X is bit 3)
#undef  PTE_Z
#define PTE_U            (1UL<<4)
#define PTE_G            (1UL<<5)
#define PTE_A            (1UL<<6)
#define PTE_D            (1UL<<7)

// Convenience masks
#define PTE_PERM_MASK    (PTE_R|PTE_W|PTE_X|PTE_U|PTE_G)

// Sv39 address decoding
#define VPN_SHIFT(level)   (12 + 9 * (level))
#define VPN_MASK(va, level) (((va) >> VPN_SHIFT(level)) & 0x1FF)
#define PTE_PPN_MASK       (((1UL<<44)-1) << 10)
#define PTE_FLAGS(pte)     ((pte) & 0x3FFUL)
#define PTE_PPN(pte)       (((pte) >> 10) & ((1UL<<44)-1))
#define PTE_PA(pte)        PA_FROM_PTE(pte)  // alias for compatibility
#define PA_FROM_PTE(pte)   ((uint64_t)PTE_PPN(pte) << 12)
#define MAKE_PTE(pa, flags) ((((uint64_t)(pa)) >> 12) << 10 | ((flags) & 0x3FF))

// Kernel virtual memory layout
#define KERNEL_BASE      0x80000000UL
#define UART0_BASE       0x10000000UL
#define UART0_SIZE       0x1000UL

// SATP helpers
#define SATP_MODE_SV39   8UL
#define MAKE_SATP(pt)    ((SATP_MODE_SV39) << 60 | ((uint64_t)(pt) >> 12))

// Types
typedef uint64 pagetable_t;   // root page table physical address
typedef uint64 pte_t;

// Public APIs
pagetable_t create_pagetable(void);
int map_page(pagetable_t pt, uint64 va, uint64 pa, int perm);
void destroy_pagetable(pagetable_t pt);
void dump_pagetable(pagetable_t pt, int level);
// Internal walking helpers (exposed for tests)
pte_t* walk_create(pagetable_t pt, uint64 va);
pte_t* walk_lookup(pagetable_t pt, uint64 va);

// Kernel virtual memory
extern pagetable_t kernel_pagetable;
void kvminit(void);
void kvminithart(void);
int map_region(pagetable_t pt, uint64 va, uint64 pa, uint64 size, int perm);

// SATP and TLB
static inline void w_satp(uint64 x) {
	__asm__ volatile("csrw satp, %0" : : "r"(x));
}
static inline void sfence_vma(void) {
	__asm__ volatile("sfence.vma");
}

#endif // VM_H
