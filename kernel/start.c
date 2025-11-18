/* 启动代码 - 模仿 xv6 的 M->S 初始化流程 */

#include "types.h"
#include "uart.h"
#include "vm.h"
#include "pmm.h"

extern void main(void);

// CSR helpers
static inline uint64 r_mstatus() { uint64 x; __asm__ volatile("csrr %0, mstatus" : "=r" (x)); return x; }
static inline void w_mstatus(uint64 x) { __asm__ volatile("csrw mstatus, %0" :: "r" (x)); }
static inline void w_mepc(uint64 x) { __asm__ volatile("csrw mepc, %0" :: "r" (x)); }
static inline void w_medeleg(uint64 x) { __asm__ volatile("csrw medeleg, %0" :: "r" (x)); }
static inline void w_mideleg(uint64 x) { __asm__ volatile("csrw mideleg, %0" :: "r" (x)); }
static inline uint64 r_sie() { uint64 x; __asm__ volatile("csrr %0, sie" : "=r" (x)); return x; }
static inline void w_sie(uint64 x) { __asm__ volatile("csrw sie, %0" :: "r" (x)); }
static inline void w_pmpaddr0(uint64 x) { __asm__ volatile("csrw pmpaddr0, %0" :: "r" (x)); }
static inline void w_pmpcfg0(uint64 x) { __asm__ volatile("csrw pmpcfg0, %0" :: "r" (x)); }
static inline uint64 r_mie() { uint64 x; __asm__ volatile("csrr %0, mie" : "=r" (x)); return x; }
static inline void w_mie(uint64 x) { __asm__ volatile("csrw mie, %0" :: "r" (x)); }
static inline uint64 r_time() { uint64 x; __asm__ volatile("csrr %0, time" : "=r" (x)); return x; }
static inline void w_stimecmp(uint64 x) { __asm__ volatile("csrw 0x14D, %0" :: "r" (x)); }
static inline uint64 r_menvcfg() { uint64 x; __asm__ volatile("csrr %0, 0x30A" : "=r" (x)); return x; }
static inline void w_menvcfg(uint64 x) { __asm__ volatile("csrw 0x30A, %0" :: "r" (x)); }
static inline uint64 r_mcounteren() { uint64 x; __asm__ volatile("csrr %0, mcounteren" : "=r" (x)); return x; }
static inline void w_mcounteren(uint64 x) { __asm__ volatile("csrw mcounteren, %0" :: "r" (x)); }
static inline uint64 r_mhartid() { uint64 x; __asm__ volatile("csrr %0, mhartid" : "=r" (x)); return x; }
static inline void w_tp(uint64 x) { __asm__ volatile("mv tp, %0" :: "r" (x)); }

#define MSTATUS_MPP_MASK (3UL << 11)
#define MSTATUS_MPP_S (1UL << 11)
#define SIE_SEIE (1L << 9)
#define SIE_STIE (1L << 5)

// ask each hart to generate timer interrupts (xv6-style)
static void timerinit_xv6_like() {
    w_mie(r_mie() | (1UL << 5)); // MIE.STIE
    w_menvcfg(r_menvcfg() | (1UL << 63)); // enable sstc so S-mode can use stimecmp
    w_mcounteren(r_mcounteren() | 2); // allow S to read time
    w_stimecmp(r_time() + 1000000);
}

void start() {
    // set MPP=S for mret
    unsigned long x = r_mstatus();
    x &= ~MSTATUS_MPP_MASK;
    x |= MSTATUS_MPP_S;
    w_mstatus(x);

    // mepc -> main (supervisor entry)
    w_mepc((uint64)main);

    // disable paging for now
    w_satp(0);

    // delegate traps/interrupts to S mode（保留 S-mode ecall 在 M 模式以便执行 SBI）
    w_medeleg(0xffff & ~(1UL << 9));
    w_mideleg(0xffff);
    w_sie(r_sie() | SIE_SEIE | SIE_STIE);

    // PMP open up memory
    w_pmpaddr0(0x3fffffffffffffull);
    w_pmpcfg0(0xf);

    // timer init (sstc/time for S)
    timerinit_xv6_like();

    // tp = hartid
    int id = r_mhartid();
    w_tp(id);

    // to S-mode main()
    __asm__ volatile("mret");
}
