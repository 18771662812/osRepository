#include "ramdisk.h"
#include "fs.h"
#include "bio.h"
#include "log.h"

extern void panic(char *s);

static unsigned char ramdisk[FS_TOTAL_BLOCKS][FS_BLOCK_SIZE];

static void kmemset(void *dst, int value, uint n) {
    unsigned char *d = (unsigned char*)dst;
    while (n--) *d++ = (unsigned char)value;
}

static void kmemmove(void *dst, const void *src, uint n) {
    const unsigned char *s = (const unsigned char*)src;
    unsigned char *d = (unsigned char*)dst;
    if (s < d && s + n > d) {
        s += n;
        d += n;
        while (n--) *--d = *--s;
    } else {
        while (n--) *d++ = *s++;
    }
}

static void ramdisk_read(uint dev, uint blockno, void *dst) {
    (void)dev;
    if (blockno >= FS_TOTAL_BLOCKS) panic("ramdisk_read");
    kmemmove(dst, ramdisk[blockno], FS_BLOCK_SIZE);
}

static void ramdisk_write(uint dev, uint blockno, const void *src) {
    (void)dev;
    if (blockno >= FS_TOTAL_BLOCKS) panic("ramdisk_write");
    kmemmove(ramdisk[blockno], src, FS_BLOCK_SIZE);
}

static void mark_block_used(uint blockno) {
    uint bi = blockno - FS_DATA_START;
    uint bmap_block = FS_BMAP_START + bi / FS_BLOCK_BITS;
    uint bit = bi % FS_BLOCK_BITS;
    unsigned char *blk = ramdisk[bmap_block];
    blk[bit / 8] |= (1 << (bit % 8));
}

void ramdisk_init(void) {
    kmemset(ramdisk, 0, sizeof(ramdisk));

    struct fs_superblock sb = {
        .magic = FS_SUPER_MAGIC,
        .total_blocks = FS_TOTAL_BLOCKS,
        .log_start = FS_LOG_START,
        .log_blocks = FS_LOG_BLOCKS,
        .inode_start = FS_INODE_START,
        .inode_blocks = FS_INODE_BLOCKS,
        .bmap_start = FS_BMAP_START,
        .bmap_blocks = FS_BMAP_BLOCKS,
        .data_start = FS_DATA_START,
        .data_blocks = FS_DATA_BLOCKS,
    };
    kmemmove(ramdisk[FS_SUPER_BLOCKNO], &sb, sizeof(sb));

    uint root_block = FS_DATA_START;
    struct fs_dinode root;
    kmemset(&root, 0, sizeof(root));
    root.mode = FS_IMODE_DIR;
    root.nlink = 2;
    root.size = 2 * sizeof(struct dirent);
    root.blocks = 1;
    root.direct[0] = root_block;

    uint iblock = FS_IBLOCK(FS_ROOT_INO);
    struct fs_dinode *dinodes = (struct fs_dinode*)ramdisk[iblock];
    kmemmove(&dinodes[FS_IOFF(FS_ROOT_INO)], &root, sizeof(root));

    struct dirent *de = (struct dirent*)ramdisk[root_block];
    de[0].inum = FS_ROOT_INO;
    de[1].inum = FS_ROOT_INO;
    kmemset(de[0].name, 0, FS_DIRSIZ);
    kmemset(de[1].name, 0, FS_DIRSIZ);
    de[0].name[0] = '.';
    de[1].name[0] = '.';
    de[1].name[1] = '.';

    mark_block_used(root_block);

    bio_register_backend(ramdisk_read, ramdisk_write);
}
