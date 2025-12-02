# RISC-V OS Project

## 用户态系统调用接口

- `user/usys.pl` 根据 `kernel/syscall.h` 中的系统调用号生成 `user/usys.S`，为每个调用提供装配封装。
- 当新增系统调用时，更新脚本列表并重新运行 `user/usys.pl > user/usys.S` 即可。
- `user/user.h` 暴露了这些封装的函数声明，未来用户态程序只需 `#include "user/user.h"` 即可使用。

## 文件系统布局

`docs/fs_layout.md` 描述了基于 xv6 思路的磁盘划分、inode 结构以及日志区域规划。
相关的常量定义保存在 `kernel/fs.h` 中，后续实现文件系统模块时直接引用这些定义即可保持一致。

## 块缓存（bio）

`kernel/bio.c` 实现了类似 xv6 的块缓存：

- LRU 算法 + 哈希桶命中 `bread/bwrite/brelse`。
- `kernel/sleeplock.c` 提供 `sleeplock`，允许在等待块 I/O 时睡眠。
- 设备驱动通过 `bio_register_backend()` 注入真正的块读写函数。

## 日志系统

- `kernel/log.c` 实现写前日志事务：`begin_op`/`end_op` 控制事务生存期，`log_write` 记录被修改的块，`log_recover` 支持崩溃后的重放。
- 日志区的起点和大小由 `kernel/fs.h` 中的 `FS_LOG_START/FS_LOG_BLOCKS` 指定，与块缓存协同工作。

## 目录与路径解析

- `kernel/inode.c` 定义了 in-core inode 缓存、`readi/writei` 块读写、`dir_lookup/dir_link/dir_unlink` 等目录操作。
- `path_walk`/`path_parent` 实现逐段解析路径，后续文件系统调用可以直接使用这些接口查找 inode。

## 内存磁盘与自检

- `kernel/ramdisk.c` 构造了一个内存磁盘，并填充超级块与根目录；通过 `bio_register_backend()` 让块缓存可以直接读写 RAM。
- `kernel/main.c` 在启动时调用 `filesystem_selftest()`：创建 `/testfile`，写入/读取字符串并最终删除，用于验证当前块缓存、日志与目录层的基本协作。
- 同时 `kernel/main.c` 还会启动多个内核进程 (`fs_concurrent_runner`/`fs_concurrent_worker`) 并发创建/删除文件，验证 `begin_op()`/`end_op()` 的事务保护是否能支撑多进程访问。
