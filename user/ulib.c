#include "../kernel/types.h"
#include "user.h"

void *memset(void *dst, int c, uint n) {
    char *d = (char*)dst;
    for (uint i = 0; i < n; i++) d[i] = c;
    return dst;
}

int memcmp(const void *s1, const void *s2, uint n) {
    const unsigned char *p1 = s1, *p2 = s2;
    for (uint i = 0; i < n; i++, p1++, p2++) {
        if (*p1 != *p2) return *p1 - *p2;
    }
    return 0;
}

void *memmove(void *dst, const void *src, uint n) {
    char *d = dst;
    const char *s = src;
    if (s < d && s + n > d) {
        for (int i = n - 1; i >= 0; i--) d[i] = s[i];
    } else {
        for (uint i = 0; i < n; i++) d[i] = s[i];
    }
    return dst;
}

char *strcpy(char *dst, const char *src) {
    char *ret = dst;
    while ((*dst++ = *src++) != 0) {}
    return ret;
}

int strcmp(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++; b++;
    }
    return *(const unsigned char*)a - *(const unsigned char*)b;
}

uint strlen(const char *s) {
    uint n = 0;
    while (s[n]) n++;
    return n;
}
