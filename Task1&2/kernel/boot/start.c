#include "../../include/defs.h"

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