#include "../kernel/types.h"
#include "user.h"
#include "../kernel/stdarg.h"

static char digits[] = "0123456789ABCDEF";

static void putc(int fd, char c) {
    write(fd, &c, 1);
}

static void printint(int fd, long long xx, int base, int sign) {
    char buf[20];
    int i = 0;
    unsigned long long x;
    if (sign && xx < 0) {
        x = -xx;
    } else {
        x = xx;
    }
    do {
        buf[i++] = digits[x % base];
    } while ((x /= base) != 0);
    if (sign && xx < 0) buf[i++] = '-';
    while (--i >= 0) putc(fd, buf[i]);
}

static void printptr(int fd, uint64 x) {
    putc(fd, '0');
    putc(fd, 'x');
    for (int i = 0; i < (int)(sizeof(uint64) * 2); i++, x <<= 4) {
        putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    }
}

void vprintf(int fd, const char *fmt, va_list ap) {
    for (int i = 0; fmt[i]; i++) {
        char c = fmt[i];
        if (c != '%') {
            putc(fd, c);
            continue;
        }
        c = fmt[++i];
        if (c == 0) break;
        switch (c) {
        case 'd':
            printint(fd, va_arg(ap, int), 10, 1);
            break;
        case 'l':
            printint(fd, va_arg(ap, uint64), 10, 1);
            break;
        case 'x':
            printint(fd, va_arg(ap, uint32), 16, 0);
            break;
        case 'p':
            printptr(fd, va_arg(ap, uint64));
            break;
        case 's': {
            char *s = va_arg(ap, char*);
            if (!s) s = "(null)";
            while (*s) putc(fd, *s++);
            break;
        }
        case 'c':
            putc(fd, va_arg(ap, int));
            break;
        case '%':
            putc(fd, '%');
            break;
        default:
            putc(fd, '%');
            putc(fd, c);
            break;
        }
    }
}

void printf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vprintf(1, fmt, ap);
}
