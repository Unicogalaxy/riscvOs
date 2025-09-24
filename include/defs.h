#ifndef DEFS_H
#define DEFS_H

#include"types.h"

//define the code of color
enum{
  RED, GREEN, YELLOW
};

//console.c
void cons_putc(char c);
void console_init();     //Init the console to input character
void clear_screen();


//printf.c
void printf(char *fmt, ...);
void printf_color(int color, char*fmt);



//uart.c
void uart_putc(char c);
void uart_puts(const char *s);
void uart_init();


#endif