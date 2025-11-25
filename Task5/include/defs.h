#ifndef DEFS_H
#define DEFS_H

#include"types.h"
#include"riscv.h"
#include"../kernel/proc/spinlock.h"

//define the code of color
enum{
  RED, GREEN, YELLOW
};


struct context;
struct proc;
struct spinlock;

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
pagetable_t uvm_create();
void uvm_unmap(pagetable_t pagetable, uint64 va, int npages, int dofree);
void uvm_free(pagetable_t pagetable, uint64 sz);

//trap.c
void trap_init();
void trap_init_hart();



//spinlock.c
int holding(struct spinlock *lk);
void push_off();
void pop_off();
void init_lock(struct spinlock *lk, char *name);
void acquire(struct spinlock *lk);
void release(struct spinlock *lk);

//proc.c
void proc_mapstacks(uint64 *kernel_pagetable);
pagetable_t proc_pagetable(struct proc *p);
void free_proc(struct proc *p);
struct cpu *mycpu();
int cpuid();
struct proc *myproc();
void wakeup(void *chan);
void yield();
void sched();

void swtch(struct context*, struct context*); //  swtch.S


//plic.c
int plic_claim(int hartid);
void plic_compelete(int irq);
void proc_freepagetable(pagetable_t pagetable, uint64 sz);


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
//用于测试trap
void test_timer_interrupt();

//define assert()
#define assert(expr) ((expr)?(void)0:\
  printf("Assertion Error: %s, file %s, line %d, function %s\n", #expr, __FILE__, __LINE__, __func__))

#endif