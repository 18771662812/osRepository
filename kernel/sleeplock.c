#include "sleeplock.h"
#include "proc.h"

void initsleeplock(struct sleeplock *lk, const char *name) {
    initlock(&lk->lk, "sleeplock");
    int i = 0;
    for (; i < 15 && name && name[i]; i++) {
        lk->name[i] = name[i];
    }
    lk->name[i] = 0;
    lk->locked = 0;
    lk->owner = 0;
}

void acquiresleep(struct sleeplock *lk) {
    acquire(&lk->lk);
    while (lk->locked) {
        sleep(lk, &lk->lk);
    }
    lk->locked = 1;
    lk->owner = current;
    release(&lk->lk);
}

void releasesleep(struct sleeplock *lk) {
    acquire(&lk->lk);
    lk->locked = 0;
    lk->owner = 0;
    wakeup(lk);
    release(&lk->lk);
}

int holdingsleep(struct sleeplock *lk) {
    int r;
    acquire(&lk->lk);
    r = (lk->locked && lk->owner == current);
    release(&lk->lk);
    return r;
}
