#ifndef SYSCALL_H
#define SYSCALL_H

#define SYS_getpid 1
#define SYS_exit   2
#define SYS_wait   3
#define SYS_fork   4
#define SYS_yield  5
#define SYS_sbrk   6
#define SYS_write  7
#define SYS_read   8
#define SYS_kill   9
#define SYS_open   10
#define SYS_close  11
#define SYS_sleep  12

#ifndef __ASSEMBLER__

// 系统调用描述
struct syscall_desc {
    int (*func)(void);   // 实现函数
    const char *name;    // 名称
    int arg_count;       // 参数个数
};

extern struct syscall_desc syscall_table[];
extern const int NSYSCALL;

// 系统调用分发
void syscall_dispatch(void);

// 参数获取
int argint(int n, int *ip);
int argaddr(int n, uint64 *ap);
int argstr(int n, char *buf, int max);

#endif // __ASSEMBLER__

#endif // SYSCALL_H
