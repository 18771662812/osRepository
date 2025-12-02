#ifndef FS_H
#define FS_H

#include "types.h"

// 文件系统的基础参数设置
#define FS_BLOCK_SIZE          4096U
#define FS_TOTAL_BLOCKS        2048U    // 默认生成 8MiB 的磁盘镜像
#define FS_BOOT_BLOCKS         1U
#define FS_SUPER_BLOCKNO       1U
#define FS_SUPER_MAGIC         0x4F534653U  // "OSFS"
#define FS_LOG_START           2U
#define FS_LOG_BLOCKS          32U
#define FS_LOG_HEADER_BLOCKS   1U
#define FS_LOG_DATA_BLOCKS     (FS_LOG_BLOCKS - FS_LOG_HEADER_BLOCKS)
#define FS_LOG_MAX_OP_BLOCKS   10U
#define FS_ROOT_DEV            1U
#define FS_ROOT_INO            1U
#define FS_DIRSIZ              32
#define FS_MAX_INODES          1024U

// inode 中的块指针布局
#define FS_DIRECT_BLOCKS       12U
#define FS_INDIRECT_ENTRIES    (FS_BLOCK_SIZE / sizeof(uint32_t))
#define FS_DOUBLE_INDIRECT_ENTRIES (FS_INDIRECT_ENTRIES * FS_INDIRECT_ENTRIES)
#define FS_MAX_FILE_BLOCKS     (FS_DIRECT_BLOCKS + FS_INDIRECT_ENTRIES + FS_DOUBLE_INDIRECT_ENTRIES)
#define FS_INVALID_BLOCK       0xFFFFFFFFU

// 磁盘上的超级块格式
struct fs_superblock {
    uint32_t magic;
    uint32_t total_blocks;
    uint32_t log_start;
    uint32_t log_blocks;
    uint32_t inode_start;
    uint32_t inode_blocks;
    uint32_t bmap_start;
    uint32_t bmap_blocks;
    uint32_t data_start;
    uint32_t data_blocks;
} __attribute__((packed));

// 磁盘上的 inode 布局
struct fs_dinode {
    uint16_t mode;        // 文件类型与权限位
    uint16_t uid;         // 所有者
    uint16_t gid;         // 所属组
    uint16_t nlink;       // 硬链接计数
    uint32_t size;        // 文件大小（字节）
    uint32_t blocks;      // 已分配块数
    uint32_t atime;       // 最后访问时间
    uint32_t mtime;       // 最后修改时间
    uint32_t ctime;       // inode 状态变更时间
    uint32_t direct[FS_DIRECT_BLOCKS];
    uint32_t indirect;
    uint32_t double_indirect;
} __attribute__((packed));

#define FS_INODE_SIZE      ((uint32_t)sizeof(struct fs_dinode))
#define FS_INODE_START     (FS_LOG_START + FS_LOG_BLOCKS)
#define FS_INODE_BLOCKS    ((FS_MAX_INODES * FS_INODE_SIZE + FS_BLOCK_SIZE - 1) / FS_BLOCK_SIZE)
#define FS_INODES_PER_BLOCK (FS_BLOCK_SIZE / sizeof(struct fs_dinode))
#define FS_IBLOCK(inum)    (FS_INODE_START + ((inum) / FS_INODES_PER_BLOCK))
#define FS_IOFF(inum)      ((inum) % FS_INODES_PER_BLOCK)
#define FS_BLOCK_BITS      (FS_BLOCK_SIZE * 8U)
#define FS_BMAP_START      (FS_INODE_START + FS_INODE_BLOCKS)
#define FS_BMAP_BLOCKS     ((FS_TOTAL_BLOCKS + FS_BLOCK_BITS - 1) / FS_BLOCK_BITS)
#define FS_DATA_START      (FS_BMAP_START + FS_BMAP_BLOCKS)
#define FS_DATA_BLOCKS     (FS_TOTAL_BLOCKS - FS_DATA_START)

enum fs_inode_mode {
    FS_IMODE_FREE      = 0,
    FS_IMODE_FILE      = 0x8000,
    FS_IMODE_DIR       = 0x4000,
    FS_IMODE_SYMLINK   = 0xA000,
    FS_IMODE_DEVICE    = 0x2000,
};

struct dirent {
    uint32_t inum;
    char name[FS_DIRSIZ];
};

#endif // FS_H
