OUTPUT_ARCH("riscv")
ENTRY(_entry)

SECTIONS {
  . = 0x80000000;

  .text :{
    ./boot/entry.o(_entry)
    *(.text);
  }

  .rodata :{
    *(.rodata);
  }

  .data :{
    *(.data);
  }

  .bss :{
    /* Define sbss, ebss as label to realize clear_bss in entry.S*/
    sbss = .;
    *(.bss);
    ebss = .;
  }
}