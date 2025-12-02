#ifndef BIO_H
#define BIO_H

#include "types.h"
#include "fs.h"
#include "sleeplock.h"

#define BCACHE_NBUF 32
#define BCACHE_HASH_SIZE 32

struct buf {
    int valid;                  // 数据是否有效
    int dirty;                  // 是否需要写回
    uint dev;                   // 设备号
    uint blockno;               // 块号
    struct sleeplock lock;      // 保护缓冲区内容
    int refcnt;                 // 引用计数
    int in_hash;                // 是否挂在哈希桶上
    struct buf *hash_next;      // 哈希链
    struct buf *hash_prev;
    struct buf *lru_next;       // LRU 双向链
    struct buf *lru_prev;
    uchar data[FS_BLOCK_SIZE];  // 实际数据
};

typedef void (*block_read_fn)(uint dev, uint blockno, void *dst);
typedef void (*block_write_fn)(uint dev, uint blockno, const void *src);

void binit(void);
void bio_register_backend(block_read_fn reader, block_write_fn writer);
struct buf* bread(uint dev, uint blockno);
void bwrite(struct buf *b);
void brelse(struct buf *b);
void bmarkdirty(struct buf *b);
void bpin(struct buf *b);
void bunpin(struct buf *b);
void bsyncdev(uint dev);

#endif // BIO_H
