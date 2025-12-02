#include "uart.h"
#include "types.h"
#include "pmm.h"
#include "vm.h"
#include "trap.h"
#include "sbi.h"
#include "proc.h"
#include "timer.h"
#include "bio.h"
#include "log.h"
#include "ramdisk.h"
#include "inode.h"

#ifndef NULL
#define NULL ((void*)0)
#endif

extern int printf(char *fmt, ...);

static inline uint64 r_time_csr(void) {
    uint64 x;
    __asm__ volatile("csrr %0, time" : "=r"(x));
    return x;
}

static void filesystem_selftest(void);
static void launch_concurrent_access_test(void);
static void fs_concurrent_runner(void);
static void fs_concurrent_worker(void *arg);
static void build_worker_path(char *buf, int buflen, int id);

#define FS_CONC_WORKERS 4
#define FS_CONC_ITERATIONS 100

void main() {
    pmm_init();
    kvminit();
    kvminithart();

    binit();
    ramdisk_init();
    fs_init(FS_ROOT_DEV);
    log_init(FS_ROOT_DEV);

    trap_init();
    timer_init();

    filesystem_selftest();

    proc_init();
    launch_concurrent_access_test();
    userinit();

    scheduler();
}

static void filesystem_selftest(void) {
    const char *path = "/testfile";
    const char *payload = "Hello, filesystem!";
    char buf[64];

    printf("Running filesystem selftest...\n");

    begin_op();
    struct inode *ip = fs_create((char*)path, FS_IMODE_FILE);
    if (!ip) {
        printf("selftest: create failed\n");
        end_op();
        return;
    }
    int len = 0;
    while (payload[len]) len++;
    ilock(ip);
    if (writei(ip, 0, (uint64)payload, 0, len) != len) {
        printf("selftest: write failed\n");
    }
    iunlock(ip);
    iput(ip);
    end_op();

    begin_op();
    ip = path_walk((char*)path);
    if (!ip) {
        printf("selftest: lookup failed\n");
        end_op();
        return;
    }
    ilock(ip);
    int r = readi(ip, 0, (uint64)buf, 0, sizeof(buf)-1);
    iunlock(ip);
    iput(ip);
    end_op();

    if (r > 0) buf[r] = 0; else buf[0] = 0;
    printf("selftest read: %s\n", buf);

    begin_op();
    if (fs_unlink((char*)path) < 0) {
        printf("selftest: unlink failed\n");
    }
    end_op();
    printf("Filesystem selftest finished.\n");
}

static void launch_concurrent_access_test(void) {
    int pid = create_process(fs_concurrent_runner);
    if (pid < 0) {
        printf("failed to spawn fs concurrency tester\n");
    } else {
        printf("spawned fs tester pid=%d\n", pid);
    }
}

static void build_worker_path(char *buf, int buflen, int id) {
    const char *prefix = "/test_";
    int pos = 0;
    while (prefix[pos] && pos < buflen - 1) {
        buf[pos] = prefix[pos];
        pos++;
    }
    if (pos < buflen - 1) {
        char digits[16];
        int dlen = 0;
        int n = id;
        if (n == 0) {
            digits[dlen++] = '0';
        } else {
            while (n > 0 && dlen < (int)sizeof(digits)) {
                digits[dlen++] = '0' + (n % 10);
                n /= 10;
            }
        }
        while (dlen > 0 && pos < buflen - 1) {
            buf[pos++] = digits[--dlen];
        }
    }
    buf[pos] = 0;
}

static void fs_concurrent_worker(void *arg) {
    int id = (int)(uint64)arg;
    char path[32];
    build_worker_path(path, sizeof(path), id);

    for (int j = 0; j < FS_CONC_ITERATIONS; j++) {
        begin_op();
        struct inode *ip = fs_create(path, FS_IMODE_FILE);
        if (!ip) {
            printf("worker %d iter %d: create failed\n", id, j);
            end_op();
            continue;
        }
        ilock(ip);
        if (writei(ip, 0, (uint64)&j, 0, sizeof(j)) != sizeof(j)) {
            printf("worker %d iter %d: write failed\n", id, j);
        }
        iunlock(ip);
        iput(ip);
        end_op();

        begin_op();
        if (fs_unlink(path) < 0) {
            printf("worker %d iter %d: unlink failed\n", id, j);
        }
        end_op();
    }
    printf("worker %d done\n", id);
}

static void fs_concurrent_runner(void) {
    printf("Testing concurrent file access...\n");
    int spawned = 0;
    for (int i = 0; i < FS_CONC_WORKERS; i++) {
        int pid = kproc_create(fs_concurrent_worker, (void*)(uint64)i, "fswrk");
        if (pid < 0) {
            printf("failed to spawn worker %d\n", i);
        } else {
            printf("spawned worker %d pid=%d\n", i, pid);
            spawned++;
        }
    }
    for (int i = 0; i < spawned; i++) {
        wait_process(0);
    }
    printf("Concurrent access test completed\n");
}
