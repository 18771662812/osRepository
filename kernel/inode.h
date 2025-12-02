#ifndef INODE_H
#define INODE_H

#include "types.h"
#include "fs.h"
#include "sleeplock.h"

#define NINODE 50

struct inode {
    int dev;
    uint32_t inum;
    int ref;
    struct sleeplock lock;
    int valid;

    uint16_t mode;
    uint16_t uid;
    uint16_t gid;
    uint16_t nlink;
    uint32_t size;
    uint32_t blocks;
    uint32_t atime;
    uint32_t mtime;
    uint32_t ctime;
    uint32_t direct[FS_DIRECT_BLOCKS];
    uint32_t indirect;
    uint32_t double_indirect;
};

void fs_init(uint dev);
struct inode* iget(int dev, uint inum);
struct inode* idup(struct inode *ip);
void iput(struct inode *ip);
void ilock(struct inode *ip);
void iunlock(struct inode *ip);
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n);
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n);

struct inode* dir_lookup(struct inode *dp, char *name, uint *poff);
int dir_link(struct inode *dp, char *name, uint inum);
int dir_unlink(struct inode *dp, char *name);
struct inode* path_walk(char *path);
struct inode* path_parent(char *path, char *name);
struct inode* fs_create(char *path, uint16_t mode);
int fs_unlink(char *path);

#endif // INODE_H
