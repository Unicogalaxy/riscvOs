#include"../../include/defs.h"

void main(){
  console_init();
  printf("Printf() is testing!\n");
  printf("the number is %d\n", 10);
  printf("unsigned number is %llu\n",12345678);
  printf_color(GREEN, "Hello World!\n");
}
