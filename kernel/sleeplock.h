#ifndef SLEEPLOCK_H
#define SLEEPLOCK_H

#include "types.h"
#include "spinlock.h"

struct proc;

struct sleeplock {
    struct spinlock lk;   // 保护锁的内部状态
    char name[16];
    int locked;           // 是否被持有
    struct proc *owner;   // 当前持有者
};

void initsleeplock(struct sleeplock *lk, const char *name);
void acquiresleep(struct sleeplock *lk);
void releasesleep(struct sleeplock *lk);
int holdingsleep(struct sleeplock *lk);

#endif // SLEEPLOCK_H
