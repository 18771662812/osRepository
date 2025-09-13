OUTPUT_ARCH("riscv")
ENTRY(_entry)

SECTIONS
{
    /* 内核加载地址 */
    . = 0x80000000;

    .text : {
        *(.text.entry)   /* 入口代码段 */
        *(.text .text.*) /* 其他代码段 */
    }

    .rodata : {
        *(.rodata .rodata.*) /* 只读数据段 */
    }

    .data : {
        *(.data .data.*) /* 数据段 */
        . = ALIGN(4096);
        _stack_bottom = .;
        . += 4096;      /* 设置4KB 栈空间 */
        _stack_top = .;
    }

    .bss : {
        _bss_start = .;
        *(.bss .bss.*)  /* BSS段 */
        *(COMMON)
        _bss_end = .;
    }

    /DISCARD/ : {
        *(.eh_frame)     /* 丢弃不需要的段 */
    }
}
