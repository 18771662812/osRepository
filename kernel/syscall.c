#include "types.h"
#include "syscall.h"
#include "proc.h"
#include "vm.h"

extern int printf(char *fmt, ...);

// -------- 参数获取实现 --------
static uint64 argraw(int n) {
    if (!current || !current->tf) return 0;
    switch (n) {
    case 0: return current->tf->a0;
    case 1: return current->tf->a1;
    case 2: return current->tf->a2;
    case 3: return current->tf->a3;
    case 4: return current->tf->a4;
    case 5: return current->tf->a5;
    default: return 0;
    }
}

int argint(int n, int *ip) {
    uint64 v = argraw(n);
    *ip = (int)v;
    return 0;
}

int argaddr(int n, uint64 *ap) {
    *ap = argraw(n);
    return 0;
}

int argstr(int n, char *buf, int max) {
    uint64 v;
    if (argaddr(n, &v) < 0) return -1;
    if (!buf || max <= 0) return -1;
    if (copyinstr((pagetable_t)current->pagetable, buf, v, max) < 0) return -1;
    return 0;
}

// -------- sys_* 桩实现 --------
static int sys_getpid(void) {
    return current ? current->pid : -1;
}

static int sys_exit(void) {
    int status = 0;
    argint(0, &status);
    exit_process(status);
    return 0; // 不会返回
}

static int sys_wait(void) {
    uint64 stptr;
    if (argaddr(0, &stptr) < 0) return -1;
    int status = 0;
    int *kptr = (stptr ? &status : 0);
    int pid = wait_process(kptr);
    if (pid >= 0 && stptr) {
        if (copyout((pagetable_t)current->pagetable, stptr, (char*)&status, sizeof(status)) < 0) {
            return -1;
        }
    }
    return pid;
}

static int sys_yield(void) {
    yield();
    return 0;
}

static int sys_fork(void) {
    return fork_user_process();
}

static int sys_sbrk(void) {
    int inc = 0;
    if (argint(0, &inc) < 0) return -1;
    return grow_process(inc);
}

static int sys_write(void) {
    uint64 buf;
    int len;
    int fd;
    if (argint(0, &fd) < 0 || argaddr(1, &buf) < 0 || argint(2, &len) < 0) return -1;
    if (fd < 0 || fd >= NOFILE || !current || !current->ofile[fd]) return -1;
    struct file *f = current->ofile[fd];
    char tmp[128];
    int written = 0;
    while (written < len) {
        int chunk = len - written;
        if (chunk > (int)sizeof(tmp)) chunk = sizeof(tmp);
        if (copyin((pagetable_t)current->pagetable, tmp, buf + written, chunk) < 0) break;
        int ret = filewrite(f, tmp, chunk);
        if (ret < 0) return -1;
        written += chunk;
        if (ret < chunk) break;
    }
    return written;
}

static int sys_read(void) {

    return -1;
}

static int sys_kill(void) {
    int pid;
    if (argint(0, &pid) < 0) return -1;
    return kill_process(pid);
}

static int sys_open(void) { return -1; }
static int sys_close(void) { return -1; }
static int sys_sleep(void) {
    extern volatile uint64_t ticks;
    int t;
    if (argint(0, &t) < 0) return -1;
    uint64 start = ticks;
    while ((int)(ticks - start) < t) {
        yield();
    }
    return 0;
}

struct syscall_desc syscall_table[] = {
    [SYS_getpid] = { sys_getpid, "getpid", 0 },
    [SYS_exit]   = { sys_exit,   "exit",   1 },
    [SYS_wait]   = { sys_wait,   "wait",   1 },
    [SYS_fork]   = { sys_fork,   "fork",   0 },
    [SYS_yield]  = { sys_yield,  "yield",  0 },
    [SYS_sbrk]   = { sys_sbrk,   "sbrk",   1 },
    [SYS_write]  = { sys_write,  "write",  3 },
    [SYS_read]   = { sys_read,   "read",   3 },
    [SYS_kill]   = { sys_kill,   "kill",   1 },
    [SYS_open]   = { sys_open,   "open",   2 },
    [SYS_close]  = { sys_close,  "close",  1 }, 
    [SYS_sleep]  = { sys_sleep,  "sleep",  1 },
};

const int NSYSCALL = sizeof(syscall_table) / sizeof(syscall_table[0]);

void syscall_dispatch(void) {
    if (!current || !current->tf) return;
    uint64 num = current->tf->a7;
    int ret = -1;
    if (num < (uint64)NSYSCALL && syscall_table[num].func) {
        ret = syscall_table[num].func();
    }
    current->tf->a0 = ret;
}
