#ifndef SPINLOCK_H
#define SPINLOCK_H

#include "types.h"

struct spinlock {
    volatile int locked;
    const char *name;
};

void initlock(struct spinlock *lk, const char *name);
void acquire(struct spinlock *lk);
void release(struct spinlock *lk);
int holding(struct spinlock *lk);

#endif // SPINLOCK_H
