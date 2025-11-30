#include"../../include/defs.h"

void main(){
  console_init();
  pmm_init();
  kvminit();
  kvminithart();
  trap_init();
  trap_init_hart();
  // test_physical_memory();
  // test_pagetable();
  // test_virtual_memory();
  // test_printf_basic();
  // test_printf_edge_cases();
  // test_timer_interrupt();
  printf_color(GREEN,"COMMON ON!\n");

  printf("--------Dead Loop in the end of main.c---------\n");
  while(1){
    
  }
  
}
