#include "spinlock.h"

void initlock(struct spinlock *lk, const char *name) {
    lk->locked = 0;
    lk->name = name;
}

void acquire(struct spinlock *lk) {
    while (__sync_lock_test_and_set(&lk->locked, 1) != 0) {
        __asm__ volatile("nop");
    }
    __sync_synchronize();
}

void release(struct spinlock *lk) {
    __sync_synchronize();
    __sync_lock_release(&lk->locked);
}

int holding(struct spinlock *lk) {
    return lk->locked != 0;
}
