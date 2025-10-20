#include"./types.h"
#ifndef __ASSEMBLER__
#define __ASSEMBLER__

//将页表项内容和物理页起始地址转换
#define PA2PTE(pa) ((((uint64)pa) >> 12) << 10)  //riscv中页表项最低10位是flag位
#define PTE2PA(pte) ((pte >> 10) << 12)

//求出不同级数下的页表序号
#define PXMASK 0x1ff
#define PXSHIFT(level) (PGSHIFT + 9 * level)
#define PX(level, va) ((((uint64)va) >> PXSHIFT(level)) & PXMASK)  


// use riscv's sv39 page table scheme.
#define SATP_SV39 (8L << 60)

#define MAKE_SATP(pagetable) (SATP_SV39 | (((uint64)pagetable) >> 12))

// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
}

// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
}


typedef uint64 pte_t;
typedef uint64 *pagetable_t;

#endif

// one beyond the highest possible virtual address.
// MAXVA is actually one bit less than the max allowed by
// Sv39, to avoid having to sign-extend virtual addresses
// that have the high bit set.
#define MAXVA (1L << (9 + 9 + 9 + 12 - 1))


#define PGSIZE 4096
#define PGSHIFT 12      //12位页内偏移
#define PGROUNDUP(sz) ((sz + PGSIZE - 1) & (~(PGSIZE - 1)))
#define PGROUNDDOWN(sz) ((sz) & (~(PGSIZE - 1)))
#define PTE_V (1L << 0)
#define PTE_R (1L << 1)
#define PTE_W (1L << 2)
#define PTE_X (1L << 3)
#define PTE_U (1L << 4)