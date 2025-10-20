PREVIOUS = riscv64-unknown-elf-
CC = $(PREVIOUS)gcc
LD = $(PREVIOUS)ld
OBJDUMP = $(PREVIOUS)objdump
OBJCOPY = $(PREVIOUS)objcopy

CFLAGS = -Wall -Werror -O -ggdb -MD -fno-omit-frame-pointer
CFLAGS += -ffreestanding -nostdlib -mno-relax -mcmodel=medany
LDFLAGS = -nostdlib

QEMU = qemu-system-riscv64
QEMU-OPTS= -machine virt -bios none -nographic

