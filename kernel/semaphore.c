#include "semaphore.h"
#include "proc.h"

void sem_init(struct semaphore *s, int value, const char *name) {
    initlock(&s->lock, name);
    s->value = value;
    s->name = name;
}

void sem_wait(struct semaphore *s) {
    acquire(&s->lock);
    while (s->value == 0) {
        sleep((void*)s, &s->lock);
    }
    s->value--;
    release(&s->lock);
}

void sem_signal(struct semaphore *s) {
    acquire(&s->lock);
    s->value++;
    wakeup((void*)s);
    release(&s->lock);
}
