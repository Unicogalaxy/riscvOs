set confirm off
set architecture riscv:rv64
target remote :26000
symbol-file kernel.elf
set disassemble-next-line auto
