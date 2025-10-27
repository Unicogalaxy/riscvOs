#ifndef DEFS_H
#define DEFS_H

#include"types.h"
#include"riscv.h"


//define the code of color
enum{
  RED, GREEN, YELLOW
};

//console.c
void cons_putc(char c);
void console_init();     //Init the console to input character
void clear_screen();
void go_to_xy(int x, int y);

//printf.c
void printf(char *fmt, ...);
void printf_color(int color, char*fmt);
void panic(char*) __attribute__((noreturn));

//string.c
void *memset(void *ptr, int c, uint n);
void panic(char *str);

//uart.c
void uart_putc(char c);
void uart_puts(const char *s);
void uart_init();
void uart_intr();

//kalloc.c
void pmm_init();
void freerange(void *pa_start, void *pa_end);
void free_page(void *p);
void *alloc_page(); //Allocate one page of physical memory

//vm.c
void kvminit();
void kvminithart();
pagetable_t kvmmake();
pagetable_t create_pagetable();
int map_page(pagetable_t pt, uint64 va, uint64 pa, int size, int perm);
void map_region(pagetable_t pt, uint64 va, uint64 pa, int size, int perm);
pte_t *walk(pagetable_t pagetable, uint64 va, int alloc);


//plic.c
int plic_claim(int hartid);
void plic_compelete(int irq);

//virtio_disk.c
void virtio_disk_intr();

/*
scripts/test文件夹下的测试函数
*/
//用于测试内核print.c
void test_printf_basic();
void test_printf_edge_cases();
//用于测试内存分配
void test_physical_memory();
void test_pagetable();
void test_virtual_memory();


//define assert()
#define assert(expr) ((expr)?(void)0:\
  printf("Assertion Error: %s, file %s, line %d, function %s\n", #expr, __FILE__, __LINE__, __func__))

#endif