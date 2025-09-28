OUTPUT_ARCH("riscv")
ENTRY(_entry)

PHDRS
{
    text PT_LOAD FLAGS(5);     /* 代码段：可读(4)+可执行(1) */
    rodata PT_LOAD FLAGS(4);   /* 只读数据：可读(4) */
    data PT_LOAD FLAGS(6);     /* 数据段：可读(4)+可写(2) */
}

SECTIONS
{
    /* 内核加载地址 */
    . = 0x80000000;

    .text : {
        _text_start = .;
        *(.text.entry)   /* 入口代码段 */
        *(.text .text.*) /* 其他代码段 */
        _text_end = .;
    } :text

    .rodata : {
        *(.rodata .rodata.*) /* 只读数据段 */
    } :rodata

    .data : {
        _data_start = .;
        *(.data .data.*) /* 数据段 */
        . = ALIGN(4096);
        _stack0 = .;
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
