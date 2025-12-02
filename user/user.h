#ifndef USER_USER_H
#define USER_USER_H

#include "../kernel/types.h"

int getpid(void);
void exit(int status) __attribute__((noreturn));
int wait(int *status);
int fork(void);
int yield(void);
int sbrk(int increment);
int write(int fd, const void *buf, int len);
int read(int fd, void *buf, int len);
int kill(int pid);
int open(const char *path, int mode);
int close(int fd);
int sleep(int ticks);

void printf(const char *fmt, ...);
void *memset(void *dst, int c, unsigned int n);
uint strlen(const char *s);

#endif // USER_USER_H
