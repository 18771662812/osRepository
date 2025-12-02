#include "inode.h"
#include "fs.h"
#include "bio.h"
#include "log.h"
#include "spinlock.h"

extern void panic(char *s);

static struct fs_superblock sb;

static struct {
    struct spinlock lock;
    struct inode inode[NINODE];
} icache;

static inline void kmemset(void *dst, int value, uint n) {
    unsigned char *d = (unsigned char*)dst;
    while (n--) {
        *d++ = (unsigned char)value;
    }
}

static inline void kmemmove(void *dst, const void *src, uint n) {
    unsigned char *d = (unsigned char*)dst;
    const unsigned char *s = (const unsigned char*)src;
    if (s < d && s + n > d) {
        s += n;
        d += n;
        while (n--) {
            *--d = *--s;
        }
    } else {
        while (n--) {
            *d++ = *s++;
        }
    }
}

static inline int kstrncmp(const char *p, const char *q, int n) {
    while (n > 0 && *p && *p == *q) {
        p++;
        q++;
        n--;
    }
    if (n == 0) return 0;
    return (unsigned char)*p - (unsigned char)*q;
}

static inline void ksafestrcpy(char *dst, const char *src, int n) {
    if (n <= 0) return;
    while (--n > 0 && *src) {
        *dst++ = *src++;
    }
    *dst = 0;
}

static void readsb(int dev, struct fs_superblock *sb) {
    struct buf *b = bread(dev, FS_SUPER_BLOCKNO);
    kmemmove(sb, b->data, sizeof(*sb));
    brelse(b);
}

void fs_init(uint dev) {
    initlock(&icache.lock, "icache");
    for (int i = 0; i < NINODE; i++) {
        icache.inode[i].ref = 0;
        icache.inode[i].valid = 0;
        initsleeplock(&icache.inode[i].lock, "inode");
    }
    readsb(dev, &sb);
}

static struct inode* ialloc(uint dev, uint mode);
static void iupdate(struct inode *ip);
static uint bmap(struct inode *ip, uint bn);
static uint balloc(int dev);
static void bfree(int dev, uint b);
static void itrunc(struct inode *ip);
static char* skipelem(char *path, char *name);
static struct inode* namex(char *path, int nameiparent, char *name);
static struct inode* create_path(char *path, uint16_t mode);

struct inode* iget(int dev, uint inum) {
    acquire(&icache.lock);
    struct inode *empty = 0;

    for (struct inode *ip = icache.inode; ip < &icache.inode[NINODE]; ip++) {
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
            ip->ref++;
            release(&icache.lock);
            return ip;
        }
        if (empty == 0 && ip->ref == 0) {
            empty = ip;
        }
    }

    if (empty == 0) {
        release(&icache.lock);
        panic("iget: no inodes");
    }

    empty->dev = dev;
    empty->inum = inum;
    empty->ref = 1;
    empty->valid = 0;
    release(&icache.lock);
    return empty;
}

struct inode* idup(struct inode *ip) {
    acquire(&icache.lock);
    ip->ref++;
    release(&icache.lock);
    return ip;
}

void iput(struct inode *ip) {
    acquire(&icache.lock);
    if (ip->ref == 1 && ip->nlink == 0 && ip->valid) {
        release(&icache.lock);
        ilock(ip);
        itrunc(ip);
        ip->mode = FS_IMODE_FREE;
        ip->valid = 0;
        iupdate(ip);
        iunlock(ip);
        acquire(&icache.lock);
    }
    ip->ref--;
    release(&icache.lock);
}

static struct inode* ialloc(uint dev, uint mode) {
    for (uint inum = 1; inum < FS_MAX_INODES; inum++) {
        struct buf *b = bread(dev, FS_IBLOCK(inum));
        struct fs_dinode *dip = ((struct fs_dinode*)b->data) + FS_IOFF(inum);
        if (dip->mode == FS_IMODE_FREE) {
            kmemset(dip, 0, sizeof(*dip));
            dip->mode = mode;
            log_write(b);
            brelse(b);
            struct inode *ip = iget(dev, inum);
            return ip;
        }
        brelse(b);
    }
    panic("ialloc: no inodes");
    return 0;
}

void ilock(struct inode *ip) {
    if (ip == 0) panic("ilock");

    acquiresleep(&ip->lock);
    if (ip->valid == 0) {
        struct buf *b = bread(ip->dev, FS_IBLOCK(ip->inum));
        struct fs_dinode *dip = ((struct fs_dinode*)b->data) + FS_IOFF(ip->inum);
        ip->mode = dip->mode;
        ip->uid = dip->uid;
        ip->gid = dip->gid;
        ip->nlink = dip->nlink;
        ip->size = dip->size;
        ip->blocks = dip->blocks;
        ip->atime = dip->atime;
        ip->mtime = dip->mtime;
        ip->ctime = dip->ctime;
        for (int i = 0; i < FS_DIRECT_BLOCKS; i++) {
            ip->direct[i] = dip->direct[i];
        }
        ip->indirect = dip->indirect;
        ip->double_indirect = dip->double_indirect;
        brelse(b);
        ip->valid = 1;
        if (ip->mode == FS_IMODE_FREE) {
            panic("ilock: no type");
        }
    }
}

void iunlock(struct inode *ip) {
    if (ip == 0 || !holdingsleep(&ip->lock)) panic("iunlock");
    releasesleep(&ip->lock);
}

static void iupdate(struct inode *ip) {
    struct buf *b = bread(ip->dev, FS_IBLOCK(ip->inum));
    struct fs_dinode *dip = ((struct fs_dinode*)b->data) + FS_IOFF(ip->inum);
    dip->mode = ip->mode;
    dip->uid = ip->uid;
    dip->gid = ip->gid;
    dip->nlink = ip->nlink;
    dip->size = ip->size;
    dip->blocks = ip->blocks;
    dip->atime = ip->atime;
    dip->mtime = ip->mtime;
    dip->ctime = ip->ctime;
    for (int i = 0; i < FS_DIRECT_BLOCKS; i++) {
        dip->direct[i] = ip->direct[i];
    }
    dip->indirect = ip->indirect;
    dip->double_indirect = ip->double_indirect;
    log_write(b);
    brelse(b);
}

static uint balloc(int dev) {
    for (uint b = 0; b < sb.data_blocks; b += FS_BLOCK_BITS) {
        struct buf *bp = bread(dev, sb.bmap_start + b / FS_BLOCK_BITS);
        for (uint bi = 0; bi < FS_BLOCK_BITS && (b + bi) < sb.data_blocks; bi++) {
            int byte = bi / 8;
            int bit = bi % 8;
            if ((bp->data[byte] & (1 << bit)) == 0) {
                bp->data[byte] |= (1 << bit);
                log_write(bp);
                brelse(bp);
                return sb.data_start + b + bi;
            }
        }
        brelse(bp);
    }
    panic("balloc: out of blocks");
    return 0;
}

static void bfree(int dev, uint b) {
    if (b < sb.data_start) panic("bfree");
    uint bi = b - sb.data_start;
    struct buf *bp = bread(dev, sb.bmap_start + bi / FS_BLOCK_BITS);
    uint off = bi % FS_BLOCK_BITS;
    int byte = off / 8;
    int bit = off % 8;
    if ((bp->data[byte] & (1 << bit)) == 0) {
        panic("bfree: already free");
    }
    bp->data[byte] &= ~(1 << bit);
    log_write(bp);
    brelse(bp);
}

static uint bmap(struct inode *ip, uint bn) {
    if (bn < FS_DIRECT_BLOCKS) {
        if (ip->direct[bn] == 0) {
            ip->direct[bn] = balloc(ip->dev);
            ip->blocks++;
        }
        return ip->direct[bn];
    }
    bn -= FS_DIRECT_BLOCKS;

    if (bn < FS_INDIRECT_ENTRIES) {
        if (ip->indirect == 0) {
            ip->indirect = balloc(ip->dev);
        }
        struct buf *bp = bread(ip->dev, ip->indirect);
        uint32_t *a = (uint32_t*)bp->data;
        if (a[bn] == 0) {
            a[bn] = balloc(ip->dev);
            ip->blocks++;
            log_write(bp);
        }
        uint addr = a[bn];
        brelse(bp);
        return addr;
    }
    bn -= FS_INDIRECT_ENTRIES;

    if (bn < FS_DOUBLE_INDIRECT_ENTRIES) {
        if (ip->double_indirect == 0) {
            ip->double_indirect = balloc(ip->dev);
        }
        struct buf *bp = bread(ip->dev, ip->double_indirect);
        uint32_t *outer = (uint32_t*)bp->data;
        uint idx1 = bn / FS_INDIRECT_ENTRIES;
        uint idx2 = bn % FS_INDIRECT_ENTRIES;
        if (outer[idx1] == 0) {
            outer[idx1] = balloc(ip->dev);
            log_write(bp);
        }
        uint first = outer[idx1];
        brelse(bp);

        struct buf *bp2 = bread(ip->dev, first);
        uint32_t *inner = (uint32_t*)bp2->data;
        if (inner[idx2] == 0) {
            inner[idx2] = balloc(ip->dev);
            ip->blocks++;
            log_write(bp2);
        }
        uint addr = inner[idx2];
        brelse(bp2);
        return addr;
    }

    panic("bmap: out of range");
    return 0;
}

static void itrunc(struct inode *ip) {
    for (int i = 0; i < FS_DIRECT_BLOCKS; i++) {
        if (ip->direct[i]) {
            bfree(ip->dev, ip->direct[i]);
            ip->direct[i] = 0;
        }
    }

    if (ip->indirect) {
        struct buf *bp = bread(ip->dev, ip->indirect);
        uint32_t *a = (uint32_t*)bp->data;
        for (int i = 0; i < FS_INDIRECT_ENTRIES; i++) {
            if (a[i]) {
                bfree(ip->dev, a[i]);
            }
        }
        brelse(bp);
        bfree(ip->dev, ip->indirect);
        ip->indirect = 0;
    }

    if (ip->double_indirect) {
        struct buf *bp = bread(ip->dev, ip->double_indirect);
        uint32_t *outer = (uint32_t*)bp->data;
        for (int i = 0; i < FS_INDIRECT_ENTRIES; i++) {
            if (outer[i]) {
                struct buf *bp2 = bread(ip->dev, outer[i]);
                uint32_t *inner = (uint32_t*)bp2->data;
                for (int j = 0; j < FS_INDIRECT_ENTRIES; j++) {
                    if (inner[j]) {
                        bfree(ip->dev, inner[j]);
                    }
                }
                brelse(bp2);
                bfree(ip->dev, outer[i]);
            }
        }
        brelse(bp);
        bfree(ip->dev, ip->double_indirect);
        ip->double_indirect = 0;
    }

    ip->size = 0;
    ip->blocks = 0;
    iupdate(ip);
}

int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n) {
    (void)user_dst;
    if (off > ip->size || off + n < off) return 0;
    if (off + n > ip->size) n = ip->size - off;

    uint tot = 0;
    while (tot < n) {
        uint bn = off / FS_BLOCK_SIZE;
        struct buf *bp = bread(ip->dev, bmap(ip, bn));
        uint offset = off % FS_BLOCK_SIZE;
        uint m = ((n - tot) < (FS_BLOCK_SIZE - offset)) ? (n - tot) : (FS_BLOCK_SIZE - offset);
        kmemmove((char*)dst + tot, bp->data + offset, m);
        brelse(bp);
        tot += m;
        off += m;
    }
    return n;
}

int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n) {
    (void)user_src;
    if (off > ip->size || off + n < off) return -1;
    if (off + n > FS_MAX_FILE_BLOCKS * FS_BLOCK_SIZE) return -1;

    uint tot = 0;
    while (tot < n) {
        uint bn = off / FS_BLOCK_SIZE;
        struct buf *bp = bread(ip->dev, bmap(ip, bn));
        uint offset = off % FS_BLOCK_SIZE;
        uint m = ((n - tot) < (FS_BLOCK_SIZE - offset)) ? (n - tot) : (FS_BLOCK_SIZE - offset);
        kmemmove(bp->data + offset, (char*)src + tot, m);
        log_write(bp);
        brelse(bp);
        tot += m;
        off += m;
    }
    if (n > 0 && off > ip->size) {
        ip->size = off;
    }
    iupdate(ip);
    return n;
}

static int namecmp(const char *s, const char *t) {
    return kstrncmp(s, t, FS_DIRSIZ);
}

struct inode* dir_lookup(struct inode *dp, char *name, uint *poff) {
    if ((dp->mode & FS_IMODE_DIR) == 0) {
        panic("dir_lookup not dir");
    }

    struct dirent de;
    for (uint off = 0; off < dp->size; off += sizeof(de)) {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
            panic("dir_lookup read");
        }
        if (de.inum == 0) continue;
        if (namecmp(name, de.name) == 0) {
            if (poff) *poff = off;
            return iget(dp->dev, de.inum);
        }
    }
    return 0;
}

int dir_link(struct inode *dp, char *name, uint inum) {
    if ((dp->mode & FS_IMODE_DIR) == 0) panic("dir_link not dir");
    struct inode *ip = dir_lookup(dp, name, 0);
    if (ip) {
        iput(ip);
        return -1;
    }

    struct dirent de;
    uint off;
    for (off = 0; off < dp->size; off += sizeof(de)) {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
            panic("dir_link read");
        }
        if (de.inum == 0) break;
    }
    de.inum = inum;
    ksafestrcpy(de.name, name, FS_DIRSIZ);
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
        panic("dir_link write");
    }
    return 0;
}

static int dir_empty(struct inode *dp) {
    struct dirent de;
    for (uint off = 2 * sizeof(de); off < dp->size; off += sizeof(de)) {
        if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
            panic("dir_empty read");
        }
        if (de.inum != 0) return 0;
    }
    return 1;
}

static struct inode* create_path(char *path, uint16_t mode) {
    char name[FS_DIRSIZ];
    struct inode *dp = path_parent(path, name);
    if (dp == 0) return 0;
    ilock(dp);
    struct inode *ip = dir_lookup(dp, name, 0);
    if (ip != 0) {
        iunlock(dp);
        iput(dp);
        return ip;
    }
    ip = ialloc(dp->dev, mode);
    ilock(ip);
    ip->nlink = 1;
    iupdate(ip);
    if (mode == FS_IMODE_DIR) {
        dp->nlink++;
        iupdate(dp);
        struct dirent dots[2];
        kmemset(&dots, 0, sizeof(dots));
        dots[0].inum = ip->inum;
        dots[1].inum = dp->inum;
        dots[0].name[0] = '.';
        dots[1].name[0] = '.';
        dots[1].name[1] = '.';
        if (writei(ip, 0, (uint64)dots, 0, sizeof(dots)) != sizeof(dots)) {
            panic("create_path dots");
        }
    }
    if (dir_link(dp, name, ip->inum) < 0) {
        panic("create_path link");
    }
    iunlock(ip);
    iunlock(dp);
    iput(dp);
    return ip;
}

int dir_unlink(struct inode *dp, char *name) {
    if ((dp->mode & FS_IMODE_DIR) == 0) return -1;
    if (namecmp(name, ".") == 0 || namecmp(name, "..") == 0) return -1;

    uint off;
    struct inode *ip = dir_lookup(dp, name, &off);
    if (ip == 0) return -1;

    ilock(ip);
    if (ip->nlink < 1) panic("dir_unlink nlink < 1");
    if ((ip->mode & FS_IMODE_DIR) && !dir_empty(ip)) {
        iunlock(ip);
        iput(ip);
        return -1;
    }
    ip->nlink--;
    iupdate(ip);
    iunlock(ip);
    iput(ip);

    struct dirent de;
    kmemset(&de, 0, sizeof(de));
    if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de)) {
        panic("dir_unlink write");
    }
    return 0;
}

static char* skipelem(char *path, char *name) {
    while (*path == '/') path++;
    if (*path == 0) return 0;
    char *s = path;
    while (*path != '/' && *path != 0) path++;
    int len = path - s;
    if (len >= FS_DIRSIZ) {
        kmemmove(name, s, FS_DIRSIZ);
    } else {
        kmemmove(name, s, len);
        name[len] = 0;
    }
    while (*path == '/') path++;
    return path;
}

static struct inode* namex(char *path, int nameiparent, char *name) {
    struct inode *ip = iget(FS_ROOT_DEV, FS_ROOT_INO);
    ilock(ip);
    char elem[FS_DIRSIZ];
    elem[0] = 0;

    while ((path = skipelem(path, elem)) != 0) {
        if (nameiparent && *path == 0) {
            if (name) kmemmove(name, elem, FS_DIRSIZ);
            iunlock(ip);
            return ip;
        }
        if ((ip->mode & FS_IMODE_DIR) == 0) {
            iunlock(ip);
            iput(ip);
            return 0;
        }
        struct inode *next = dir_lookup(ip, elem, 0);
        iunlock(ip);
        if (next == 0) {
            iput(ip);
            return 0;
        }
        iput(ip);
        ip = next;
        ilock(ip);
    }

    if (nameiparent) {
        iput(ip);
        return 0;
    }
    if (name) kmemmove(name, elem, FS_DIRSIZ);
    iunlock(ip);
    return ip;
}

struct inode* path_walk(char *path) {
    return namex(path, 0, 0);
}

struct inode* path_parent(char *path, char *name) {
    return namex(path, 1, name);
}

struct inode* fs_create(char *path, uint16_t mode) {
    return create_path(path, mode);
}

int fs_unlink(char *path) {
    char name[FS_DIRSIZ];
    struct inode *dp = path_parent(path, name);
    if (dp == 0) return -1;
    ilock(dp);
    int r = dir_unlink(dp, name);
    iunlock(dp);
    iput(dp);
    return r;
}
