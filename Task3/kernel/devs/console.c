#include "../../include/defs.h"

#define BACKSPACE 0x100

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

void console_init(){
  uart_init();
}

void clear_screen(){
  printf("\033[2J\033[H");
}

void go_to_xy(int x, int y){
  printf("\033[%d;%dH", x, y);
  printf("dym");
}