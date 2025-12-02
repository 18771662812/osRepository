#ifndef FILE_H
#define FILE_H

#define NOFILE 16

struct file {
    int readable;
    int writable;
};

extern struct file cons_file;

int filewrite(struct file *f, const char *buf, int n);
int fileread(struct file *f, char *buf, int n);
int fileclose(struct file *f);

#endif // FILE_H
