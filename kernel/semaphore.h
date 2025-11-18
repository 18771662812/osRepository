#ifndef SEMAPHORE_H
#define SEMAPHORE_H

#include "spinlock.h"

struct semaphore {
    int value;
    struct spinlock lock;
    const char *name;
};

void sem_init(struct semaphore *s, int value, const char *name);
void sem_wait(struct semaphore *s);
void sem_signal(struct semaphore *s);

#endif // SEMAPHORE_H
