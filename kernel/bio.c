#include "bio.h"
#include "spinlock.h"
#include "sleeplock.h"

extern void panic(char *s);

static struct {
    struct spinlock lock;
    struct buf buf[BCACHE_NBUF];
    struct buf lru_head;
    struct buf *hash[BCACHE_HASH_SIZE];
    block_read_fn reader;
    block_write_fn writer;
} bcache;

static inline uint hash_index(uint dev, uint blockno) {
    return (dev ^ blockno) & (BCACHE_HASH_SIZE - 1);
}

static void hash_insert(struct buf *b) {
    uint idx = hash_index(b->dev, b->blockno);
    b->hash_next = bcache.hash[idx];
    b->hash_prev = 0;
    if (bcache.hash[idx]) {
        bcache.hash[idx]->hash_prev = b;
    }
    bcache.hash[idx] = b;
    b->in_hash = 1;
}

static void hash_remove(struct buf *b) {
    if (!b->in_hash) return;
    uint idx = hash_index(b->dev, b->blockno);
    if (bcache.hash[idx] == b) {
        bcache.hash[idx] = b->hash_next;
    }
    if (b->hash_next) {
        b->hash_next->hash_prev = b->hash_prev;
    }
    if (b->hash_prev) {
        b->hash_prev->hash_next = b->hash_next;
    }
    b->hash_prev = b->hash_next = 0;
    b->in_hash = 0;
}

static struct buf* hash_find(uint dev, uint blockno) {
    uint idx = hash_index(dev, blockno);
    struct buf *b = bcache.hash[idx];
    while (b) {
        if (b->dev == dev && b->blockno == blockno) {
            return b;
        }
        b = b->hash_next;
    }
    return 0;
}

static void lru_remove(struct buf *b) {
    if (b->lru_next) {
        b->lru_next->lru_prev = b->lru_prev;
    }
    if (b->lru_prev) {
        b->lru_prev->lru_next = b->lru_next;
    }
    b->lru_next = b->lru_prev = 0;
}

static void lru_insert_head(struct buf *b) {
    b->lru_next = bcache.lru_head.lru_next;
    b->lru_prev = &bcache.lru_head;
    bcache.lru_head.lru_next->lru_prev = b;
    bcache.lru_head.lru_next = b;
}

static block_read_fn get_reader(void) {
    block_read_fn fn;
    acquire(&bcache.lock);
    fn = bcache.reader;
    release(&bcache.lock);
    return fn;
}

static block_write_fn get_writer(void) {
    block_write_fn fn;
    acquire(&bcache.lock);
    fn = bcache.writer;
    release(&bcache.lock);
    return fn;
}

void binit(void) {
    initlock(&bcache.lock, "bcache");
    bcache.lru_head.lru_next = &bcache.lru_head;
    bcache.lru_head.lru_prev = &bcache.lru_head;
    bcache.reader = 0;
    bcache.writer = 0;
    for (int i = 0; i < BCACHE_HASH_SIZE; i++) {
        bcache.hash[i] = 0;
    }

    for (int i = 0; i < BCACHE_NBUF; i++) {
        struct buf *b = &bcache.buf[i];
        b->valid = 0;
        b->dirty = 0;
        b->dev = 0;
        b->blockno = 0;
        b->refcnt = 0;
        b->in_hash = 0;
        b->hash_next = b->hash_prev = 0;
        initsleeplock(&b->lock, "buffer");
        lru_insert_head(b);
    }
}

void bio_register_backend(block_read_fn reader, block_write_fn writer) {
    acquire(&bcache.lock);
    bcache.reader = reader;
    bcache.writer = writer;
    release(&bcache.lock);
}

static struct buf* bget(uint dev, uint blockno) {
    acquire(&bcache.lock);
    struct buf *b = hash_find(dev, blockno);
    if (b) {
        b->refcnt++;
        release(&bcache.lock);
        acquiresleep(&b->lock);
        return b;
    }

    for (b = bcache.lru_head.lru_prev; b != &bcache.lru_head; b = b->lru_prev) {
        if (b->refcnt == 0) {
            if (b->in_hash) {
                hash_remove(b);
            }
            b->dev = dev;
            b->blockno = blockno;
            b->valid = 0;
            b->dirty = 0;
            b->refcnt = 1;
            hash_insert(b);
            release(&bcache.lock);
            acquiresleep(&b->lock);
            return b;
        }
    }
    release(&bcache.lock);
    panic("bget: no buffers");
    return 0;
}

struct buf* bread(uint dev, uint blockno) {
    struct buf *b = bget(dev, blockno);
    if (!b->valid) {
        block_read_fn reader = get_reader();
        if (!reader) panic("bread: no backend");
        reader(dev, blockno, b->data);
        b->valid = 1;
    }
    return b;
}

void bwrite(struct buf *b) {
    if (!holdingsleep(&b->lock)) {
        panic("bwrite: not locked");
    }
    block_write_fn writer = get_writer();
    if (!writer) panic("bwrite: no backend");
    writer(b->dev, b->blockno, b->data);
    b->dirty = 0;
    b->valid = 1;
}

void bmarkdirty(struct buf *b) {
    if (!holdingsleep(&b->lock)) {
        panic("bmarkdirty: not locked");
    }
    b->dirty = 1;
}

void brelse(struct buf *b) {
    if (!holdingsleep(&b->lock)) {
        panic("brelse: not locked");
    }
    releasesleep(&b->lock);

    acquire(&bcache.lock);
    if (b->refcnt <= 0) {
        release(&bcache.lock);
        panic("brelse: bad refcnt");
    }
    b->refcnt--;
    if (b->refcnt == 0) {
        lru_remove(b);
        lru_insert_head(b);
    }
    release(&bcache.lock);
}

void bpin(struct buf *b) {
    acquire(&bcache.lock);
    b->refcnt++;
    release(&bcache.lock);
}

void bunpin(struct buf *b) {
    acquire(&bcache.lock);
    if (b->refcnt <= 0) {
        release(&bcache.lock);
        panic("bunpin: bad refcnt");
    }
    b->refcnt--;
    if (b->refcnt == 0) {
        lru_remove(b);
        lru_insert_head(b);
    }
    release(&bcache.lock);
}

void bsyncdev(uint dev) {
    acquire(&bcache.lock);
    struct buf *b = bcache.lru_head.lru_next;
    while (b != &bcache.lru_head) {
        struct buf *next = b->lru_next;
        if (b->dev == dev && b->dirty) {
            b->refcnt++;
            release(&bcache.lock);

            acquiresleep(&b->lock);
            block_write_fn writer = get_writer();
            if (!writer) panic("bsyncdev: no backend");
            writer(b->dev, b->blockno, b->data);
            b->dirty = 0;
            releasesleep(&b->lock);

            acquire(&bcache.lock);
            b->refcnt--;
            if (b->refcnt == 0) {
                lru_remove(b);
                lru_insert_head(b);
            }
        }
        b = next;
    }
    release(&bcache.lock);
}
