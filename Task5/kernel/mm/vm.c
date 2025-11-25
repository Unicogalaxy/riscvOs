#include"../../include/types.h"
#include"../../include/riscv.h"
#include"../../include/memlayout.h"
#include"../../include/defs.h"

/*
内核的页表
*/
pagetable_t kernel_pagetable;

extern char etext[];  // kernel.ld sets this to end of kernel code.


pagetable_t kvmmake(){
  pagetable_t kpgtbl;
  kpgtbl = create_pagetable();

  // map kernel text executable and read-only.
  map_region(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);

  // map kernel data and the physical RAM we'll make use of.
  map_region(kpgtbl, (uint64)etext, (uint64)etext, PHYEND-(uint64)etext, PTE_R | PTE_W);
   // uart registers
  map_region(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);

  // virtio mmio disk interface
  map_region(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);

  // PLIC
  map_region(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);

  proc_mapstacks(kpgtbl);
  return kpgtbl;
}

void kvminit(){
  kernel_pagetable = kvmmake();
}

//激活页表，使得硬件开始使用虚拟地址
void kvminithart(){
  // 激活内核页表
    w_satp(MAKE_SATP(kernel_pagetable));
    sfence_vma();
}


// 返回页表 pagetable 中对应虚拟地址 va 的 PTE 地址。
// 如果 alloc != 0，在缺少中间页表页时会动态分配它们。
//
// The risc-v Sv39 scheme has three levels of page-table
// pages. A page-table page contains 512 64-bit PTEs.
// A 64-bit virtual address is split into five fields:
//   39..63 -- must be zero.
//   30..38 -- 9 bits of level-2 index.
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *walk(pagetable_t pagetable, uint64 va ,int alloc){
  if(va > MAXVA)
    panic("walk!");

  for(int level = 2; level > 0; level --){
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V)
      pagetable = (pagetable_t)PTE2PA(*pte);
    else{
      if(!alloc || !(pagetable = (pagetable_t)alloc_page()))
        return 0;
      memset(pagetable, 0, PGSIZE);  //必须清空所分配的页表
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
}


void map_region(pagetable_t pt, uint64 va, uint64 pa, int size, int perm){
  if(map_page(pt, va, pa, size, perm) != 0)
    panic("map_region()");
}

pagetable_t create_pagetable(){
  pagetable_t pt = (pagetable_t)alloc_page();
  if(!pt)
    panic("create_page(): alloc_page failed!");
  memset(pt, 0, PGSIZE);        //要将分配的页表给清理
  return pt;
}

void destroy_pagetable(pagetable_t pt){
  free_page((void*)pt);
}

/*
将物理地址与虚拟地址进行映射的函数，映射的大小为size,
如果映射失败(由于中间页表项分配失败)，返回-1
分配成功返回0
*/
int map_page(pagetable_t pt, uint64 va, uint64 pa, int size, int perm){

  pte_t *pte;
  if(size == 0)
    panic("map_page(): can not map 0 size page!");
  if(size%PGSIZE != 0)
    panic("map_page(): size is not aligned!");
  if(va%PGSIZE != 0)
    panic("map_page(): va is not aligned!");
  
  uint64 map_end = va + size - PGSIZE;        //最后一页的起始地址
  for(;;){  
    if(!(pte = walk(pt, va, 1)))
      return -1;
    //如果放回的页表项有效位为1，说明此页表项不能用
    if((*pte & PTE_V))
      panic("map_page(): walk() allocate page failed!");
    *pte = PA2PTE(pa) | PTE_V | (uint64)perm;
    if(va == map_end)
      break;
    va += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}


// 创建一个pagetable 给 User page
pagetable_t uvm_create(){
  pagetable_t p = alloc_page();
  if(p == 0){
    return 0;
  }
  memset(p, 0, PGSIZE);
  return p;
}

//  在xv6中采用三级页表
//  uvm_unmap()清除叶子页的PTE
// 以及选择性清除对应的物理页的内容
void 
uvm_unmap(pagetable_t pagetable, uint64 va, int npages, int dofree){
  pte_t *pte;
  uint64 a;
  if((va % PGSIZE) != 0)
    panic("uvm_unmap(): va is not aligned!");

  for(a = va;a < (va + PGSIZE * npages);a += PGSIZE){
    //此页表项本身不存在
    if((pte = walk(pagetable, a, 0)) == 0)
      continue;
    //此页表项无效
    if((*pte & PTE_V) == 0)
      continue;

    if(dofree){
      //清除页表项所指的物理页
      uint64 pa = PTE2PA(*pte);
      free_page((void *)pa);
    }
    *pte = 0;     //清除页表项的内容

  }
}

//  清除用户页表中除了叶子页表的其他PTE
void 
freewalk(pagetable_t pagetable){
  //  一个页表 4096B, 一个PTE 64bit --> 8B
  //  算得一个页表能够装 2^9 个PTE
  for(int i=0;i < 512;i++){
    pte_t pte = pagetable[i];
    //  注意 && 和 == 的优先性
    if((pte & PTE_V) && (pte & (PTE_W|PTE_X|PTE_R)) == 0){
      //  经上述条件判断pte必定指向下一级页表
      pagetable_t child_page = (pagetable_t)PTE2PA(pte);
      freewalk(child_page);
    } else if(pte & PTE_V){
      panic("freewalk():leaf page PTE is not cleard!");
    }
    free_page((void *)pagetable);
  }
}

//  先选择性的清除用户页内存
//  再清除页表中的内容
void 
uvm_free(pagetable_t pagetable, uint64 sz){
  if(sz > 0){
    //  调用uvm_unmap()将用户页的内存清除
    uvm_unmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  }
  freewalk(pagetable);
}