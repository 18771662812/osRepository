    .globl _start
    .align 2
_start:
    call main
    mv a0, a0
    call exit
1:  j 1b
