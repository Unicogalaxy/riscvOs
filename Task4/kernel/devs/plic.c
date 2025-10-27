#include"../../include/types.h"
#include"../../include/memlayout.h"
#include"../../include/defs.h"

// To be continued
int plic_claim(int hartid){
  //这里我猜应该是64bit只装了32bit
  int irq = *(uint32 *)PLIC_SCLAIM(hartid);
  return irq;
} 

// To be continued
void plic_compelete(int irq){
  *(uint32 *)PLIC_SCLAIM(0) = irq;
}