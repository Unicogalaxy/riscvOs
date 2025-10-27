#include"../../include/types.h"
#include"../../include/riscv.h"
#include"../../include/memlayout.h"
#include"../../include/defs.h"

unsigned int ticks;     //用于时钟中断计数

void kernelvec();   //定义在kernelvec.c中，用汇编写的

int dev_intr();

void usertrap();


/*
  kerneltrap()只处理中断而不处理异常
  因为内核态下如果出现异常那么代码写的有问题
*/
// To be continued
void kerneltrap(){
  uint which_intr = 0;
  uint64 sepc = r_sepc();
  uint64 sstatus = r_sstatus();

  if((sstatus & SSTATUS_SPP) == 0)
    panic("kerneltrap(): not from supervisor mode!");
  // 此时要检查SIE中断是否没被机器清零，要不然在解决中断的时候又会被中断
  if(intr_get() != 0)
    panic("kerneltrap(): supervisor mode is enabled!");
  if((which_intr = dev_intr()) == 0){
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", r_scause(), r_sepc(), r_stval());
    panic("kerneltrap(): trap not recognized!"); 
  }
  

}

// To be continued
void clock_intr(){
  ticks++;
  w_stimecmp(r_time() + 1000000);
}


/*
  判断中断是什么类型的，external interrupt or timer interrupt
  在xv6中似乎没有处理 software interrupt
  external --> return 2
  timer --> return 1
  not recognized --> return 0
*/
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
