include ./common.mk

KERN = kernel
KERNEL_ELF = kernel.elf


.PHONY: $(KERN) build 

all: build 


# 调试
GDBPORT = $(shell expr `id -u` % 5000 + 25000)
QEMUGDB = $(shell if $(QEMU) -help | grep -q '^-gdb'; \
	then echo "-gdb tcp::$(GDBPORT)"; \
	else echo "-s -p $(GDBPORT)"; fi)

$(KERN): 
	$(MAKE) build --directory=$@

qemu: $(KERN)
	@echo "Starting the qemu!"
	$(QEMU) $(QEMU-OPTS) -kernel kernel.elf

.gdbinit: .gdbinit.tmpl-riscv
	sed "s/:1234/:$(GDBPORT)/" < $^ > $@

qemu-gdb: $(KERN) .gdbinit
	$(QEMU) $(QEMU-OPTS) -kernel kernel.elf -S $(QEMUGDB)

build: $(KERN)

clean:
	$(MAKE) --directory=$(KERN) clean
	rm -f $(KERNEL_ELF) .gdbinit