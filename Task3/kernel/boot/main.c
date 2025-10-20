#include"../../include/defs.h"

void main(){
  console_init();
  pmm_init();
  kvminit();
  kvminithart();
  // test_physical_memory();
  // test_pagetable();
  // test_virtual_memory();
  // test_printf_basic();
  // test_printf_edge_cases();
  printf_color(GREEN,"COMMON ON!\n");
  
}
