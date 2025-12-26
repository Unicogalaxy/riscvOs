# RISC-V OS Project README

本项目是一个基于 RISC-V 架构的教学操作系统实现。项目代码严格遵循《从零构建操作系统-学生指导手册》的指引，从零开始构建了包含引导、内存管理、中断处理、进程管理、系统调用、文件系统及ELF程序加载等核心功能的内核。

## 目录

- [实验1：RISC-V引导与裸机启动](https://www.google.com/search?q=%23实验1risc-v引导与裸机启动)
- [实验2：内核printf与清屏功能实现](https://www.google.com/search?q=%23实验2内核printf与清屏功能实现)
- [实验3：页表与内存管理](https://www.google.com/search?q=%23实验3页表与内存管理)
- [实验4：中断处理与时钟管理](https://www.google.com/search?q=%23实验4中断处理与时钟管理)
- [实验5：进程管理与调度](https://www.google.com/search?q=%23实验5进程管理与调度)
- [实验6：系统调用](https://www.google.com/search?q=%23实验6系统调用)
- [实验7：文件系统](https://www.google.com/search?q=%23实验7文件系统)
- [实验8：ELF加载器与用户空间](https://www.google.com/search?q=%23实验8elf加载器与用户空间)

------

## 实验1：RISC-V引导与裸机启动

本阶段实现了最小系统的裸机启动，完成了从汇编到C语言的跳转，并通过UART输出 "Hello OS"。

### 核心函数与代码说明

1. **`_entry` (kernel/boot/entry.S)**

	```c
	_entry:
	      #stack0 is defined in start.c
	      la sp, stack0
	      li a0, 4*1024
	      add sp, sp, a0
	
	      la a0, sbss
	      la a1, ebss
	clear_bss:
	      sb zero, 0(a0)
	      addi a0, a0, 1
	      bne a0, a1, clear_bss  
	clear_bss_done:
	      call start
	
	spin:
	      j spin
	```

	- **作用**：内核的入口点。主要工作是设置栈指针 (`sp`)，以便后续的 C 代码可以正常使用栈（存储局部变量、函数调用等）。
	- **代码逻辑**：将 `sp` 指向 `stack0 + 4096`（预留4KB栈空间），然后跳转到 `start` 函数。

2. **`start` (kernel/boot/start.c)**

	```c
	#define NCPU 1
	
	void main();        //Define in main.c
	
	//Define stack0 for entry.S
	char stack0[NCPU*4096];
	void start(){ 
	  main();
	  uart_puts("OS is shutting down!\n");
	
	  //dead loop
	  while(1){
	
	  }
	}
	```

	- **作用**：机器模式（Machine Mode）下的 C 语言入口。在此进行最初的硬件初始化（如设置 M 模式寄存器），为进入监督模式（Supervisor Mode）做准备。

3. **`uart_init` & `uart_putc` (kernel/devs/uart.c)**

	```c
	void uart_putc(char c){
	  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
	  ;
	  WriteReg(THR, (int)c);
	}
	
	void uart_puts(const char*s){
	  for(; *s; s++){
	    if(*s == '\n') uart_putc('\r'); //CRLF format is more safe
	    uart_putc(*s);
	  }
	}
	
	```

	- **作用**：初始化 UART 串口硬件，并实现单字符发送功能。这是实现 `printf` 的基石。

### 思考题解答

1. **启动栈的设计：你如何确定栈的大小？如果栈太小会发生什么？**
	- **解答**：在 `entry.S` 中，我们通常分配 4KB (`4096` 字节) 的栈空间。这个大小是经验值，对于启动阶段的简单 C 代码（无深度递归、无大数组）是足够的。如果栈太小，会导致**栈溢出 (Stack Overflow)**，覆盖掉栈上方的数据（或代码），引发非法指令异常或数据损坏，导致系统无法启动。
2. **BSS段清零：写一个全局变量，不清零BSS会有什么现象？**
	- **解答**：C 语言标准规定未初始化的全局变量应为 0。如果启动时不清理 BSS 段（即不写入 0），这些变量的初始值将是内存上残留的随机数据（垃圾值）。这会导致依赖 0 初始值的程序逻辑（如 `if (!ptr)`）出错。
3. **与xv6的对比：你的实现比xv6简化了哪些部分？**
	- **解答**：xv6 支持多核启动，会根据 `mhartid` 为每个 CPU 设置独立的栈。本实现简化为单核启动，仅设置一个 `stack0`。此外，xv6 的 `start.c` 中包含更复杂的 PMP（物理内存保护）配置，本实验可能进行了简化。

------

## 实验2：内核printf与清屏功能实现

本阶段构建了内核格式化输出机制，支持 `%d`, `%x`, `%s` 等格式符及 ANSI 彩色输出。

### 核心函数与代码说明

1. **`printf` (kernel/lib/printf.c)**

	```c
	void printf(char *fmt, ...){
	  va_list ap;
	  char c0, c1, c2;
	  char *s;
	  va_start(ap, fmt);
	
	  for(int i=0; (fmt[i] & 0xff) ; i++){
	    if(fmt[i] != '%'){
	      cons_putc(fmt[i]);
	      continue;
	    }
	    i++;
	    c0 = fmt[i] & 0xff;
	    c1 = c2 =0;
	    if(c0) c1 = fmt[i+1] & 0xff;
	    if(c1) c2 = fmt[i+2] & 0xff;
	    if('d' == c0){
	      print_int(va_arg(ap, int), 10, 1);
	    } else if('l' == c0 && 'd' == c1){
	      print_int(va_arg(ap, uint64), 10, 1);
	      i+=1;
	    } else if('l' == c0 && 'l' == c1 && 'd' == c2){
	      print_int(va_arg(ap, uint64), 10, 1);
	      i+=2;
	    } else if('u' == c0){
	      print_int(va_arg(ap, uint), 10, 0);
	    } else if('l' == c0 && 'u' == c1){
	      print_int(va_arg(ap, uint64), 10, 0);
	      i+=1;
	    } else if('l' == c0 && 'l' == c1 && 'u' == c2){
	      print_int(va_arg(ap, uint64), 10, 0);
	      i+=2;
	    } else if('x' == c0){
	      print_int(va_arg(ap, uint32), 16, 0);
	    } else if('l' == c0 && 'x' == c1){
	      print_int(va_arg(ap, uint64), 16, 0);
	      i+=1;
	    } else if('l' == c0 && 'l' == c1 && 'x' == c2){
	      print_int(va_arg(ap, uint64), 16, 0);
	      i+=2;
	    } else if('c' == c0){
	      cons_putc(va_arg(ap, uint));
	    } else if('s' == c0){
	      if(!(s = va_arg(ap, char*))){
	        s = "(null)";
	      }
	      for(; *s; s++){
	        cons_putc(*s);
	      }
	    } else if('p' == c0){
	      print_ptr(va_arg(ap, uint64));
	    } else if('%' == c0){
	      cons_putc('%');
	    } else if (0 == c0){
	      break;
	    } else {
	      // Print unknown % sequence to draw attention.
	      cons_putc('%');
	      cons_putc(c0);
	    }
	
	  }
	  va_end(ap);
	
	}
	void printf_color(int color, char *fmt){
	  int color_code = color + 31;
	  printf("\033[%dm%s\033[0m", color_code, fmt);
	}
	```

	- **作用**：核心格式化输出函数。
	- **实现**：使用 `stdarg.h` 处理可变参数。通过状态机解析格式字符串，遇到 `%` 时调用相应的处理逻辑（如 `printint`）。

2. **`printint` (kernel/lib/printf.c)**

	```c
	static void print_int(long long x, int base, int sign){
	  char buf[20];
	  unsigned long long xx;
	  if(sign && (sign = x < 0)){
	    xx = -x;
	  }
	  else 
	    xx = x;
	  int i = 0;
	  do{
	    buf[i++] = digit[xx % base];
	  } 
	  while ((xx /= base) != 0);
	
	  if(sign){
	    cons_putc('-');
	  }
	  while(--i >= 0){
	    cons_putc(buf[i]);
	  }
	}
	
	```

	

	- **作用**：将整数转换为字符串并输出。
	- **实现**：不使用递归（防止内核栈溢出），而是使用循环和栈上缓冲区 `buf[16]`。将数字模基数（10或16）取余得到低位字符，存入缓冲，最后逆序输出。

3. **`consputc` (kernel/devs/console.c)**

	```c
	void cons_putc(char c){
	  if(BACKSPACE == (int)c){
	    //'/b' is the real character of BACKSPACE and
	    //'/b'' ''\b' is the 
	    uart_putc('\b');
	    uart_putc(' ');
	    uart_putc('\b');
	  }
	  uart_putc(c);
	}
	```

	- **作用**：控制台输出抽象层。处理特殊字符（如 Backspace）并将字符传递给 UART 驱动。

### 思考题解答

1. **架构设计：为什么需要分层 (printf -> console -> uart)？**
	- **解答**：**解耦与抽象**。`printf` 负责“格式化逻辑”，不关心输出到哪里；`console` 负责“终端逻辑”（如处理退格、回显）；`uart` 负责“硬件通信”。这种设计使得未来更换输出设备（如 VGA）时只需修改底层，无需改动上层逻辑。
2. **算法选择：数字转字符串为什么不用递归？**
	- **解答**：内核栈空间非常有限（通常仅 4KB）。递归调用会消耗大量栈帧。如果打印一个极大的数字或在深层调用链中使用 `printf`，递归可能导致内核栈溢出（Kernel Panic）。
3. **性能优化：当前实现的性能瓶颈在哪里？**
	- **解答**：当前 `uart_putc` 采用**轮询 (Polling)** 方式，CPU 必须循环等待 UART 硬件就绪（`LSR` 寄存器空闲）才能发送下一个字符，浪费了大量 CPU 周期。优化方案是使用**中断驱动 + 软件缓冲区**。

------

## 实验3：页表与内存管理

本阶段实现了物理内存分配器和 Sv39 分页机制，建立了内核虚拟地址空间。

### 核心函数与代码说明

1. **`alloc_page` / `free_page` (kernel/mm/kalloc.c)**

	```c
	void free_page(void *p){
	  if((char *)p < end || (uint64)p > PHYEND || (uint64)p % PGSIZE !=0)
	    panic("free_page()");
	  memset(p, 0, PGSIZE);
	  struct pgptr *pa = p;
	  pa->next = freelist.header;
	  freelist.header = pa;
	  freelist.pages = freelist.pages + 1;
	}
	
	void *alloc_page(){
	  struct pgptr *pa = freelist.header;
	  //There should have a lock
	  if(pa){
	    freelist.header = pa->next;
	    freelist.pages--;
	  }
	  return (void *)pa;
	}
	```

	- **作用**：物理页帧分配器。
	- **实现**：维护一个空闲链表 (`struct run`)。`kfree` 将释放的页挂入链表头，`kalloc` 从链表头取出一个页。

2. **`walk` (kernel/mm/vm.c)**

	```c
	pte_t *walk(pagetable_t pagetable, uint64 va ,int alloc){
	  if(va > MAXVA)
	    panic("walk!");
	
	  for(int level = 2; level > 0; level --){
	    pte_t *pte = &pagetable[PX(level, va)];
	    if(*pte & PTE_V)
	      pagetable = (pagetable_t)PTE2PA(*pte);
	    else{
	      if(!alloc || !(pagetable = (pagetable_t)alloc_page()))
	        return 0;
	      memset(pagetable, 0, PGSIZE);  //必须清空所分配的页表
	      *pte = PA2PTE(pagetable) | PTE_V;
	    }
	  }
	  return &pagetable[PX(0, va)];
	}
	```

	- **作用**：页表遍历函数。
	- **实现**：模拟硬件 MMU 行为，根据虚拟地址的 3 级 VPN 索引（L2->L1->L0）逐级查找页表项 PTE。如果中间级页表不存在且 `alloc!=0`，则动态分配新物理页作为页表。

### 思考题解答

1. **设计对比：你的物理内存分配器与xv6有什么不同？**
	- **解答**：基本原理一致（空闲链表）。主要的权衡在于锁的设计。xv6 每个 CPU 有自己的 `kmem` 锁以减少竞争。本实验如果是单核实现，可能仅使用一把全局锁，简单但并发性能差。
2. **内存安全：如何防止内存分配器被恶意利用？**
	- **解答**：
		- **Double-free 检测**：`kfree` 之前检查该页是否已在空闲链表中（开销大）或检查引用计数。
		- **Use-after-free 防护**：在 `kfree` 时立即用 `memset` 将内存清零（或填充垃圾值），防止新分配者读取到旧的敏感数据。
3. **错误恢复：页表创建失败时如何清理已分配的资源？**
	- **解答**：在 `mappages` 或 `uvmcreate` 过程中，如果某一步 `kalloc` 失败，必须回滚。需要编写清理函数，递归遍历已建立的部分页表，释放页表页（PTE_V 有效且指向下级页表的 PTE），防止内存泄漏。

------

## 实验4：中断处理与时钟管理

本阶段实现了中断向量表、上下文保存恢复机制以及时钟中断处理。

### 核心函数与代码说明

1. **`kernelvec` (kernel/trap/kernelvec.S)**

	```c
	kernelvec:
	    #分配空间保存现场
	    addi sp, sp, -256
	
	    #save caller-saved registers
	    sd ra, 0(sp)
	    sd sp, 8(sp)
	    sd gp, 16(sp)
	    sd tp, 24(sp)
	    sd t0, 32(sp)
	    sd t1, 40(sp)
	    sd t2, 48(sp)
	    sd t3, 56(sp)
	    sd t4, 64(sp)
	    sd t5, 72(sp)
	    sd t6, 80(sp)
	    sd a0, 88(sp)
	    sd a1, 96(sp)
	    sd a2, 104(sp)
	    sd a3, 112(sp)
	    sd a4, 120(sp)
	    sd a5, 128(sp)
	    sd a6, 136(sp)
	    sd a7, 144(sp)
	    
	    #调用kerneltrap() --> 定义在trap.c中
	    call kerneltrap
	
	    #恢复现场
	    ld ra, 0(sp)
	    ld sp, 8(sp)
	    ld gp, 16(sp)
	    ld tp, 24(sp)
	    ld t0, 32(sp)
	    ld t1, 40(sp)
	    ld t2, 48(sp)
	    ld t3, 56(sp)
	    ld t4, 64(sp)
	    ld t5, 72(sp)
	    ld t6, 80(sp)
	    ld a0, 88(sp)
	    ld a1, 96(sp)
	    ld a2, 104(sp)
	    ld a3, 112(sp)
	    ld a4, 120(sp)
	    ld a5, 128(sp)
	    ld a6, 136(sp)
	    ld a7, 144(sp)
	
	    addi sp, sp, 256
	
	    sret
	```

	- **作用**：内核态中断入口。
	- **实现**：`addi sp, sp, -256` 开辟栈空间，保存所有通用寄存器 (`sd`)，调用 `kerneltrap`，返回时恢复寄存器 (`ld`) 并执行 `sret`。

2. **`devintr` (kernel/trap/trap.c)**

	```c
	int dev_intr(){
	  uint64 scause = r_scause();
	
	  // 最高位 = 1 --> interrupt, 0 --> exception
	  if(scause == 0x8000000000000009L){
	    //从PLIC处获得信息判断是哪一个外设发起中断
	    int irq = plic_claim(0);
	    if(irq == VIRTIO0_IRQ){
	      virtio_disk_intr();
	    } else if(irq == UART0_IRQ){
	      uart_intr();
	    } else{
	      printf("dev_intr(): Unexpected interrupt, irq:%d", irq);
	    }
	    if(irq){
	      plic_compelete(irq);
	    }
	
	    return 1;
	  } else if(scause == 0x8000000000000005L){
	    // Supervisor mode timer interrupt
	    clock_intr();
	    return 2;
	  } else{
	    return 0;
	  }
	}
	```

	- **作用**：设备中断分发。
	- **实现**：读取 `scause` 判断中断来源。如果是时钟中断（`0x80...01`），调用时钟处理逻辑；如果是外部中断（`0x80...09`），查询 PLIC 确定具体设备（如 UART）。

3. **`clock_intr` (kernel/trap/trap.c)**

	```c
	void clock_intr(){
	  ticks++;
	  w_stimecmp(r_time() + 1000000);
	}
	```

	- **作用**：在 M 模式下配置 CLINT 硬件，设置 `mtimecmp`，并将时钟中断委托给 S 模式处理。

### 思考题解答

1. **中断设计：为什么时钟中断需要在M模式处理后再委托给S模式？**
	- **解答**：RISC-V 规范中，时钟硬件（CLINT）是 M 模式特权资源。S 模式内核无法直接复位时钟比较器。因此，硬件触发 M 模式中断，M 模式处理程序（`timervec`）负责设置下一次时钟，并通过写 `sip` 寄存器软件触发一个 S 模式中断，从而“转发”给内核。
2. **性能考虑：中断处理的时间开销主要在哪里？**
	- **解答**：
		- **上下文切换**：保存/恢复 32 个 64 位寄存器涉及大量内存读写。
		- **流水线冲刷**：中断发生时 CPU 流水线被清空。
		- **Cache Miss**：中断处理程序可能不在 I-Cache 中。
3. **可靠性：如何确保中断处理函数的安全性？**
	- **解答**：
		- **原子性**：在保存寄存器之前必须关闭中断（`sstatus.sie = 0`），防止嵌套中断破坏现场。
		- **栈保护**：确保内核栈有足够空间处理中断，防止溢出。

------

## 实验5：进程管理与调度

本阶段实现了 `struct proc`，支持进程创建 (`fork`)、退出 (`exit`) 和基于时间片的轮转调度。

### 核心函数与代码说明

1. **`alloc_proc` (kernel/proc/proc.c)**

	```c
	struct proc *alloc_proc(){
	  struct proc *p;
	  for(p = procs;p < &procs[NPROC];p++){
	    acquire(&p->lock);
	    if(p->state == UNUSED){
	      goto found;
	    } else{
	      release(&p->lock);
	    }  
	  }
	  return 0;
	
	
	found:
	  p->pid = alloc_pid();
	  p->state = USED;
	  
	  if(((p->trapframe) = alloc_page()) == 0){
	    free_proc(p);
	    release(&p->lock);
	    return 0;
	  }
	
	  p->pagetable = proc_pagetable(p);
	  if(p->pagetable == 0){
	    free_proc(p);
	    release(&p->lock);
	    return 0;
	  }
	  // To be continued
	  memset(&p->context, 0, sizeof(p->context));
	  p->context.ra = (uint64)forkret;
	  p->context.sp = p->kstack + PGSIZE;
	
	  return p;
	}
	
	```

	- **作用**：分配新进程。
	- **实现**：扫描进程表寻找 `UNUSED` 状态的槽位。初始化 Trapframe、内核栈，并设置 `context.ra = forkret`，确保进程首次调度时能正确跳转。

2. **`scheduler` (kernel/proc/proc.c)**

	```c
	void 
	scheduler(){
	  struct cpu *c = mycpu();
	  c->proc = 0;
	
	  for(;;){
	    // 先将之前proc留下的中断给处理了，
	    // 否则如果所有的CPU都进入睡眠，直接死锁
	    intr_on();
	    intr_off();
	
	    int found = 0;
	    struct proc *p;
	    // xv6中的轮询调度算法
	    for(p = procs; p < &procs[NPROC]; p++){
	      acquire(&p->lock);
	      if(p->state == RUNNABLE){
	        p->state = RUNNING;
	        c->proc = p;
	        found = 1;
	        
	        // swtch.S中将旧上下文保存，载入新上下文
	        // 新的上下文是proc的，swtch的ret返回的ra也是proc的ra
	        // 故swtch（）执行完后并不会返回这里
	        swtch(&c->context, &p->context);
	
	        // swtch()退出说明进程被抢占或者睡眠了
	        // 在xv6中不存在高优先级进程抢占低优先级进程
	        // 故c->proc = 0
	        c->proc = 0;
	      }
	
	      release(&p->lock);
	      if(found == 0){
	        // wfi -> Wait for Interrupts
	        // 让CPU进入低功耗等待中断状态
	        asm volatile("wfi");
	      }
	    }
	  }
	}
	
	```

	- **作用**：CPU 调度器。
	- **实现**：无限循环扫描进程表，找到 `RUNNABLE` 进程，切换状态为 `RUNNING`，调用 `swtch` 切换上下文。

### 思考题解答

1. **进程模型：为什么选择这种进程结构设计？**
	- **解答**：xv6 模型将页表、文件描述符、内核栈、Trapframe 全部聚合在 `struct proc` 中。这种设计简单直观，适合单线程进程模型。每个进程拥有独立的地址空间和内核栈，隔离性好。
2. **调度策略：轮转调度的公平性如何？**
	- **解答**：轮转调度（Round Robin）保证每个 `RUNNABLE` 进程在每个周期内都有机会运行，避免了饥饿，具有基本的公平性。但它不区分 IO 密集型和 CPU 密集型任务，可能导致 IO 响应延迟。
3. **性能优化：fork()的性能瓶颈如何解决？**
	- **解答**：`fork` 最耗时的是 `uvmcopy`（内存复制）。解决方案是实现 **Copy-On-Write (COW)**：子进程只复制父进程的页表项（标记为只读），不复制物理页。当任一进程尝试写入时触发 Page Fault，此时再分配物理内存并复制数据。

------

## 实验6：系统调用

本阶段打通了用户态与内核态的边界，实现了 `syscall` 分发框架及基础调用。

### 核心函数与代码说明

1. **`usertrap` (kernel/trap/trap.c)**
	- **作用**：用户态陷阱入口。
	- **实现**：检查 `scause`。如果是 `8` (Syscall)，则 `epc += 4`（跳过 `ecall` 指令），开启中断，调用 `syscall()`。
2. **`syscall` (kernel/sys/syscall.c)**
	- **作用**：系统调用分发器。
	- **实现**：从 `trapframe->a7` 读取调用号，查表 `syscalls[]` 找到对应内核函数执行，并将返回值写入 `trapframe->a0`。
3. **`argaddr` / `fetchaddr` (kernel/sys/syscall.c)**
	- **作用**：安全地获取用户参数。
	- **实现**：不能直接解引用用户指针。必须通过页表查找（软件模拟 MMU）或使用 `copyin` 函数，确保指针指向用户合法内存区域，防止内核崩溃或安全漏洞。

### 思考题解答

1. **安全考虑：如何防止系统调用被滥用？**
	- **解答**：
		- **边界检查**：严格检查用户传入的指针是否越界（`addr >= p->sz`）。
		- **调用号检查**：检查 `a7` 是否在有效范围内。
		- **权限隔离**：确保用户态无法直接执行特权指令或访问内核内存。
2. **性能优化：系统调用的主要开销在哪里？**
	- **解答**：主要开销在于**模式切换**（User <-> Kernel）带来的上下文保存/恢复，以及**TLB 刷新**（切换 `satp`）。优化手段包括使用大页减少 TLB Miss，或使用 VDSO 技术在用户态处理部分只读系统调用（如 `gettime`）。

------

## 实验7：文件系统

本阶段实现了基于 Inode 和日志的磁盘文件系统，支持文件读写和崩溃恢复。

### 核心函数与代码说明

1. **`bmap` (kernel/fs/fs.c)**

	```c
	static uint 
	bmap(struct inode *ip, uint bn){
	  uint addr;
	  struct buffer *buf;
	  uint *array;
	
	  if(bn < NDIRECT){
	    if((addr = ip->addrs[bn]) == 0){
	      addr = alloc_block(ip->dev);
	      //如果分配不了
	      if(!addr)
	        return 0;
	      ip->addrs[bn] = addr;
	    }
	    return addr;
	  }
	  bn -= NDIRECT;
	
	  //间接的addr
	  if(bn < NINDIRECT){
	    if((addr = ip->addrs[NDIRECT]) == 0){
	      addr = alloc_block(ip->dev);
	      if(addr == 0)
	        return 0;
	      ip->addrs[NDIRECT] = addr;
	    }
	
	    buf = read_buf(ip->dev, addr);
	    array = (uint*)buf->data;
	    //如果间接block的第一个addr是0，要分配block号
	    if(array[bn] == 0){
	      addr = alloc_block(ip->dev);
	      if(addr == 0){
	        // 分配失败时需释放持有的缓存块锁，否则将导致后续读写死锁
	        relse_buf(buf);
	        return 0;
	      }
	      array[bn] = addr;
	      log_write(buf);
	    }
	    relse_buf(buf);
	    return addr;
	}
	```

	- **作用**：文件块映射。
	- **实现**：将文件逻辑块号转换为磁盘物理块号。支持**直接索引**（前12个块）和**一级间接索引**（`NDIRECT` 槽位指向一个块，该块存索引）。

2. **`bio` (kernel/fs/bio.c)**

	```c
	static struct buffer*
	get_buf(uint dev, uint block_num){
	  struct buffer *b;
	  
	  acquire(&bcache.lock);
	
	  for(b = bcache.head.next;b != &bcache.head; b = b->next){
	    if(b->dev == dev && b->blocknum == block_num){
	      b->refcnt++;
	      release(&bcache.lock);
	      acq_sleeplock(&b->lock);
	      return b;
	    }
	  }
	
	  //没找到buffer，分配最长时间没用的buf
	  for(b = bcache.head.prev;b != &bcache.head;b = b->prev){
	    if(b->refcnt == 0){
	      b->blocknum = block_num;
	      b->dev = dev;
	      b->valid = 0;
	      b->refcnt = 1;
	      release(&bcache.lock);
	      acq_sleeplock(&b->lock);
	      return b;
	    }
	  }
	  panic("get_buf():no available buffers\n");
	}
	
	//返回存有要查找内容的buffer
	//不存在就从disk中获取
	struct buffer *
	read_buf(uint dev, uint block_num){
	  struct buffer *buf;
	
	  buf = get_buf(dev, block_num);
	  if(!buf->valid){
	    virtio_disk_rw(buf, 0);
	    buf->valid = 1;
	  }
	  return buf;
	}
	
	void 
	write_buf(struct buffer *buf){
	  if(!holding_sleeplock(&buf->lock)){
	    panic("write_buf\n");
	  }
	  virtio_disk_rw(buf,1);
	}
	```

	- **作用**：块缓存。
	- **实现**：使用 LRU（最近最少使用）算法管理内存中的磁盘块副本。减少磁盘 I/O 次数。

### 思考题解答

1. **一致性保证：日志系统如何确保原子性？**
	- **解答**：通过 **Write-Ahead Logging (WAL)**。所有元数据修改先写入日志区，并原子地更新“Log Header”（提交点）。如果在写入 Log Header 前崩溃，重启后丢弃日志（视为未发生）；如果在写入 Log Header 后崩溃，重启时重放日志（Replay），将操作重新应用到文件系统，确保数据一致。
2. **性能优化：文件系统的主要性能瓶颈在哪里？**
	- **解答**：
		- **同步写**：日志系统要求频繁刷盘。
		- **目录查找**：线性扫描目录项（`namei`）在大目录下效率极低。优化方案是使用 B+ 树或哈希表索引目录。
		- **全局锁**：`bcache` 和日志系统的全局锁限制了多核并发性能。

------

## 实验8：ELF加载器与用户空间

本阶段（对应系统扩展项目2）实现了 `exec` 系统调用，能够解析 ELF 文件并加载用户程序运行。

### 核心函数与代码说明

1. **`kexec` (kernel/sys/exec.c)**
	- **作用**：加载并执行程序。
	- **实现**：
		1. `namei` 打开文件，检查 ELF Header 魔数。
		2. 遍历 ELF Program Headers，对 `LOAD` 类型段调用 `uvm_alloc` 分配内存，并使用 `loadseg` 将文件内容读入内存。
		3. 分配两页用户栈，并将 `argv` 参数字符串拷贝到栈顶。
		4. 切换页表，设置 Trapframe 的 `epc` 为 ELF 入口地址，`sp` 为新栈顶。
2. **`loadseg` (kernel/sys/exec.c)**
	- **作用**：加载段数据。
	- **实现**：由于新页表尚未激活，无法直接 `memcpy`。必须通过 `walkaddr` 查找新页表中虚拟地址对应的物理地址，然后通过 `readi` 读取文件内容到该物理地址。

### 思考题解答

1. **设计权衡：为什么 exec 不直接在当前页表操作？**
	- **解答**：为了原子性和错误恢复。`exec` 首先在新的页表中构建镜像。只有当加载过程完全成功（内存分配成功、文件读取成功）后，才替换掉进程旧的页表。如果加载中途失败，旧进程仍可继续运行或安全退出，不会留下一个被破坏的残缺状态。
2. **安全性：如何防止加载恶意的 ELF 文件？**
	- **解答**：
		- **格式检查**：验证 Magic Number。
		- **地址检查**：确保段的虚拟地址在用户空间范围内，不覆盖内核高地址。
		- **栈保护**：在用户栈下方设置一个不可访问的 Guard Page，防止栈溢出破坏堆数据。