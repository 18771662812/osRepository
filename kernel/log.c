#include "log.h"
#include "fs.h"
#include "spinlock.h"
#include "proc.h"

extern void panic(char *s);

struct logheader {
    int n;
    uint block[FS_LOG_DATA_BLOCKS];
};

static struct {
    struct spinlock lock;
    int start;
    int size;
    int dev;
    int outstanding;
    int committing;
    struct logheader lh;
} log;

static void read_head(void);
static void write_head(void);
static void write_log(void);
static void install_trans(int recovering);
static void commit(void);

static inline void block_copy(uchar *dst, const uchar *src) {
    for (int i = 0; i < FS_BLOCK_SIZE; i++) {
        dst[i] = src[i];
    }
}

void log_init(uint dev) {
    initlock(&log.lock, "fslog");
    log.start = FS_LOG_START;
    log.size = FS_LOG_BLOCKS;
    log.dev = dev;
    log.outstanding = 0;
    log.committing = 0;
    log.lh.n = 0;
    log_recover();
}

void log_recover(void) {
    read_head();
    install_trans(1);
    log.lh.n = 0;
    write_head();
}

void begin_op(void) {
    acquire(&log.lock);
    for (;;) {
        if (log.committing) {
            sleep(&log, &log.lock);
        } else if (log.lh.n + (log.outstanding + 1) * FS_LOG_MAX_OP_BLOCKS > (log.size - FS_LOG_HEADER_BLOCKS)) {
            sleep(&log, &log.lock);
        } else {
            log.outstanding++;
            release(&log.lock);
            break;
        }
    }
}

void end_op(void) {
    int do_commit = 0;

    acquire(&log.lock);
    if (log.outstanding < 1) {
        panic("end_op without begin");
    }
    log.outstanding--;
    if (log.committing) {
        panic("log already committing");
    }
    if (log.outstanding == 0) {
        do_commit = 1;
        log.committing = 1;
    } else {
        wakeup(&log);
    }
    release(&log.lock);

    if (do_commit) {
        commit();
        acquire(&log.lock);
        log.committing = 0;
        wakeup(&log);
        release(&log.lock);
    }
}

void log_write(struct buf *b) {
    if (!holdingsleep(&b->lock)) {
        panic("log_write without buffer lock");
    }
    acquire(&log.lock);
    if (log.lh.n >= FS_LOG_DATA_BLOCKS || log.lh.n >= log.size - FS_LOG_HEADER_BLOCKS) {
        release(&log.lock);
        panic("log_write: log full");
    }
    if (log.outstanding < 1) {
        release(&log.lock);
        panic("log_write outside transaction");
    }

    int i;
    for (i = 0; i < log.lh.n; i++) {
        if (log.lh.block[i] == b->blockno) {
            break;
        }
    }
    log.lh.block[i] = b->blockno;
    if (i == log.lh.n) {
        bpin(b);
        log.lh.n++;
    }
    release(&log.lock);
}

static void commit(void) {
    if (log.lh.n > 0) {
        write_log();
        write_head();
        install_trans(0);
        log.lh.n = 0;
        write_head();
    }
}

static void write_log(void) {
    for (int i = 0; i < log.lh.n; i++) {
        struct buf *to = bread(log.dev, log.start + FS_LOG_HEADER_BLOCKS + i);
        struct buf *from = bread(log.dev, log.lh.block[i]);
        block_copy(to->data, from->data);
        bwrite(to);
        brelse(from);
        brelse(to);
    }
}

static void install_trans(int recovering) {
    for (int i = 0; i < log.lh.n; i++) {
        struct buf *logbuf = bread(log.dev, log.start + FS_LOG_HEADER_BLOCKS + i);
        struct buf *dest = bread(log.dev, log.lh.block[i]);
        block_copy(dest->data, logbuf->data);
        bwrite(dest);
        if (!recovering) {
            bunpin(dest);
        }
        brelse(logbuf);
        brelse(dest);
    }
}

static void read_head(void) {
    struct buf *b = bread(log.dev, log.start);
    struct logheader *lh = (struct logheader*)b->data;
    log.lh.n = lh->n;
    if (log.lh.n < 0 || log.lh.n > FS_LOG_DATA_BLOCKS) {
        log.lh.n = 0;
    }
    for (int i = 0; i < log.lh.n; i++) {
        log.lh.block[i] = lh->block[i];
    }
    brelse(b);
}

static void write_head(void) {
    struct buf *b = bread(log.dev, log.start);
    struct logheader *lh = (struct logheader*)b->data;
    lh->n = log.lh.n;
    for (int i = 0; i < log.lh.n; i++) {
        lh->block[i] = log.lh.block[i];
    }
    bwrite(b);
    brelse(b);
}
