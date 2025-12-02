# Filesystem Layout

This describes the first cut of the xv6-like filesystem that will back the
project. The intent is to lock the disk format and the inode layout before we
wire the implementation into `kernel/file.c`.

## Block allocation plan

- Block size is `4096` bytes. That matches the CPU page size so buffer cache
  and paging can share allocations.
- The default disk image is `2048` blocks (8 MiB). The boot ROM consumes
  block 0, the superblock uses block 1, and blocks `[2, 33]` form a contiguous
  log region to support write-ahead logging.
- The inode table starts at block 34. We reserve `1024` inodes. With an 84-byte
  on-disk inode this requires 21 blocks.
- The block bitmap immediately follows the inode table. Each bitmap block tracks
  `4096*8 = 32768` blocks, so the current size only needs one bitmap block.
- All remaining blocks belong to the data region. This yields `32712` data
  blocks on the default image.

The values above are encoded in `kernel/fs.h` through the `FS_*` macros so they
can be used consistently in user land tooling and in the kernel.

## Inode and data block layout

On-disk inodes (`struct fs_dinode`) store POSIX-style metadata and a mix of
block pointers:

- `direct[12]` hold up to 12 direct block addresses, allowing files that fit in
  48 KiB to avoid descriptor indirection.
- `indirect` addresses a single-level block containing block numbers for medium
  files (roughly 16 MiB).
- `double_indirect` extends capacity for large files (~512 MiB) while keeping
  small files cheap.

Each inode tracks `mode`, `uid`, `gid`, `nlink`, `size`, `blocks`, and the
POSIX timestamps (`atime`, `mtime`, `ctime`). The `mode` stores both the file
type and the permission bits. Symbolic links and device nodes are encoded via
dedicated `mode` bits. Additional metadata (like xattrs) can reuse the unused
space in each inode or live in separate files once needed.

## Design considerations

1. **Balancing small vs. large files:** Direct pointers keep the critical path
   short for tiny files, while the indirect and double-indirect levels add
   capacity without per-inode bloat.
2. **Metadata extensibility:** Each inode has timestamps and a `blocks` field.
   Future extensions (ACLs, xattrs) can either consume spare inode padding or
   use dedicated attribute files referenced from the inode.
3. **Log performance:** The write-ahead log sits in a contiguous block range to
   simplify DMA I/O. Batching commits inside the log keeps metadata updates
   consistent.
4. **Symbolic links:** A separate inode mode value reserves space for symlinks.
   Short targets can fit inside the first direct block; longer targets spill
   into regular data blocks.

These decisions mirror xv6 where possible while adjusting the sizes to fit the
current RISC-V OS project.
