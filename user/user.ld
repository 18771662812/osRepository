OUTPUT_ARCH("riscv")
ENTRY(_start)
SECTIONS
{
  . = 0;
  .text : {
    *(.text .text.*)
  }
  .rodata : {
    *(.rodata .rodata.*)
  }
  .data : {
    *(.data .data.*)
  }
  .bss : {
    *(.bss .bss.*)
  }
}
