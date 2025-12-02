#include "file.h"
#include "uart.h"

struct file cons_file = {
    .readable = 0,
    .writable = 1,
};

int filewrite(struct file *f, const char *buf, int n) {
    if (!f || !f->writable || !buf || n < 0) return -1;
    for (int i = 0; i < n; i++) {
        if (buf[i] == 0) break;
        uart_putc(buf[i]);
    }
    return n;
}

int fileread(struct file *f, char *buf, int n) {
    (void)f; (void)buf; (void)n;
    return -1;
}

int fileclose(struct file *f) {
    (void)f;
    return 0;
}
