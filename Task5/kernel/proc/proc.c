#include"../../include/types.h"
#include"../../include/param.h"
#include"../../include/memlayout.h"
#include"../../include/riscv.h"
#include"./spinlock.h"
#include"./proc.h"
#include"../../include/defs.h"



struct cpu cpus[NCPU];
struct proc procs[NPROC];

struct proc *initproc;

struct spinlock wait_lock;
int nextpid = 1;
struct spinlock pid_lock;


void forkret();
extern char trampoline[]; // trampoline.S

void proc_mapstacks(uint64 *kernel_pagetable){
  struct proc *p;
  for(p = procs;p <= &procs[NPROC]; p++){
    uint64 *pg_ptr = alloc_page();
    if(!pg_ptr)
      panic("proc_stacks():");
    uint64 va = KSTACK((int)(p - procs));
    map_page(kernel_pagetable, va, (uint64)pg_ptr, PGSIZE, PTE_R|PTE_W);
  }
}

void proc_init(){
  struct proc *p;
  init_lock(&wait_lock, "wait_lock");
  init_lock(&pid_lock,"pid_lock");
  for(p = procs;p <= &procs[NPROC];p++){
    init_lock(&p->lock,"proclockx");
    p->state = UNUSED;
    p->kstack = KSTACK((int)(p - procs));
  }
}

//  调用cpuid的时候必须禁用中断，
//  否则调用此函数的进程可能会被转移到其他cpu
int cpuid(){
  int id = r_tp();
  return id;
}

//  返回当前运行进程所属的cpu
//  记得禁用中断
struct cpu* mycpu(){
  int id = cpuid();
  struct cpu *cpux = &cpus[id];
  return cpux;
}

//由于myproc在后面多次用到，所以push_off()写在函数里
struct proc* myproc(){
  push_off();
  struct cpu *cpux = mycpu();
  struct proc *procx = cpux->proc;
  pop_off();
  return procx; 
}

//  为进程分配pid
//  由于要避免已经完结的进程pid的干扰，所以不复用pid
int alloc_pid(){
  acquire(&pid_lock);
  int pid = nextpid;
  nextpid++;
  release(&pid_lock);
  return pid;
}

//  查找PCB（xv6中是procs[]），是否有空闲的进程空间
//  没有返回0
struct proc *alloc_proc(){
  struct proc *p;
  for(p = procs;p < &procs[NPROC];p++){
    acquire(&p->lock);
    if(p->state == UNUSED){
      goto found;
    } else{
      release(&p->lock);
    }  
  }
  return 0;


found:
  p->pid = alloc_pid();
  p->state = USED;
  
  if(((p->trapframe) = alloc_page()) == 0){
    free_proc(p);
    release(&p->lock);
    return 0;
  }

  p->pagetable = proc_pagetable(p);
  if(p->pagetable == 0){
    free_proc(p);
    release(&p->lock);
    return 0;
  }
  // To be continued
  memset(&p->context, 0, sizeof(p->context));
  p->context.ra = (uint64)forkret;
  p->context.sp = p->kstack + PGSIZE;

  return p;
}

//  将proc进程的内容清零
//  被调用时必须要持有锁
void free_proc(struct proc *p){
  if(p->trapframe)
    free_page(p->trapframe);
  p->trapframe = 0;
  if(p->pagetable)
    proc_freepagetable(p->pagetable, p->sz);
  p->pagetable = 0;
  p->parent = 0;
  p->pid = 0;
  p->state = 0;
  p->sz = 0;
  p->xstate = 0;
  p->name[0] = 0;
  p->killed = 0;
  p->chan = 0;
}

pagetable_t proc_pagetable(struct proc *proc){
  pagetable_t p = uvm_create();
  if(p == 0)
    return 0;

  //  映射trampoline地址
  if(map_page(p, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_W|PTE_R) == 0){
    uvm_free(p, 0);
    return 0;
  }

  //  映射trapframe地址
  if(map_page(p, TRAPFRAME, (uint64)proc->trapframe, PGSIZE, PTE_R|PTE_X) == 0){
    uvm_unmap(p, TRAPFRAME, 1, 0);
    uvm_free(p, 0);
    return 0;
  }
  return p;

}

void 
proc_freepagetable(pagetable_t pagetable, uint64 sz){
  uvm_unmap(pagetable, TRAMPOLINE, 1, 0);
  //  To be continued
  uvm_unmap(pagetable, TRAPFRAME, 1, 0);

  uvm_free(pagetable, sz);
}

void
userinit(){
  struct proc *p;

  p = alloc_proc();
  initproc = p;

  //  To be continued
  p->state = RUNNABLE;

  //  alloc_proc()分配成功的话，不会释放锁
  release(&p->lock);
}

// 每一个CPU都运行一个scheduler()作为调度器，
// 调度器一旦开始运行便会一直循环运行为CPU调度进程
void 
scheduler(){
  struct cpu *c = mycpu();
  c->proc = 0;

  for(;;){
    // 先将之前proc留下的中断给处理了，
    // 否则如果所有的CPU都进入睡眠，直接死锁
    intr_on();
    intr_off();

    int found = 0;
    struct proc *p;
    // xv6中的轮询调度算法
    for(p = procs; p < &procs[NPROC]; p++){
      acquire(&p->lock);
      if(p->state == RUNNABLE){
        p->state = RUNNING;
        c->proc = p;
        found = 1;
        
        // swtch.S中将旧上下文保存，载入新上下文
        // 新的上下文是proc的，swtch的ret返回的ra也是proc的ra
        // 故swtch（）执行完后并不会返回这里
        swtch(&c->context, &p->context);

        // swtch()退出说明进程被抢占或者睡眠了
        // 在xv6中不存在高优先级进程抢占低优先级进程
        // 故c->proc = 0
        c->proc = 0;
      }

      release(&p->lock);
      if(found == 0){
        // wfi -> Wait for Interrupts
        // 让CPU进入低功耗等待中断状态
        asm volatile("wfi");
      }
    }
  }
}


//  恢复scheduler()的上下文
//  并且保存进程的上下文
void
sched(){
  struct proc *proc = myproc();
  int itena;

  if(!holding(&proc->lock))
    panic("sched(): proc->lock");
  if(mycpu()->noff != 1)
    panic("sched(): noff");
  if(proc->state == RUNNING)
    panic("sched(): proc->state");
  if(intr_get())
    panic("sched(): intr_get()");

  itena = mycpu()->intena;

  swtch(&myproc()->context, &mycpu()->context);

  mycpu()->intena = itena;
  
}

//  当进程要让度CPU的时候，调用yield()将CPU让给调度器
//  yield()调用sched()函数来将CPU让给scheduler()
void
yield(){
  struct proc *p = myproc();
  acquire(&p->lock);
  p->state = RUNNABLE;
  sched();
  release(&p->lock);
}

void 
forkret(){
  panic("forkret()");
}

void 
reparent(struct proc *p){
  struct proc *child_p;
  for(child_p = procs;child_p < &procs[NPROC];child_p++){
    if(child_p->parent == p){
      child_p->parent = initproc;
      //  需要唤醒initproc来处理僵尸进程,否则initproc下的zombie会堆积
      wakeup(initproc);
    }
  }
}

//  父进程调用wait想要回收子进程
uint64 
proc_wait(uint64 addr){
  struct proc *p = myproc();
  struct proc *pp;
  uint32 have_kid = 0;
  acquire(&wait_lock);

  for(;;){
    for(pp = procs;pp < &procs[NPROC];pp++){
      if(pp->parent == p){
        //  找到子进程，判断子进程是否可回收
        acquire(&pp->lock);

        have_kid = 1;
        if(pp->state == ZOMBIE){
          //  To be continued
          //  为什么要检查子进程的退出状态
          free_proc(pp);
          release(&pp->lock);
          release(&wait_lock);
        }
      }
    }

    if(!have_kid && get_killed(p)){
      release(&wait_lock);
      return -1;
    }

    sleep(&wait_lock, p);

  }
}


//  子进程调用exit想要结束进程，
// 执行释放资源，托孤，唤醒父进程等一系列操作
void 
proc_exit(int status){
  struct proc *p = myproc();
  if(p == initproc)
    panic("initproc is exiting\n");

  //  对文件系统进行操作  To be continued

  acquire(&wait_lock);

  reparent(p);  //将进程p的子进程托孤给init

  wakeup(p->parent);
  acquire(&p->lock);

  release(&wait_lock);
  p->xstate = status;
  p->state = ZOMBIE;

  sched();
  panic("zombie proc is resched()");
}


//  有条件锁为参数，考虑调用sleep的场景
void 
sleep(struct spinlock *lk, void *chan){
  //  获取当前进程
  struct proc *p = myproc();
  //  需要先获取进程的锁，再获取条件锁
  acquire(&p->lock);
  release(lk);

  p->state = SLEEPING;
  p->chan = chan;
  
  //  准备进行进程调度
  sched();
  // 进程wakeup()被唤醒之后从这里继续执行

  p->chan = 0;  
  acquire(lk);
  release(&p->lock);
  
}


//  唤醒睡眠中的进程。注意此处chan的理解
//  chan并没有什么作用，也不存储内容，单纯算作一个标记
//  睡眠中的进程标记上chan的会被唤醒
void 
wakeup(void *chan){
  struct proc *p;
  for(p = procs; p < &procs[NPROC]; p++){
    if(p != myproc()){
      acquire(&p->lock);
      if((p->state == SLEEPING) && (p->chan == chan)){
        p->state = RUNNABLE;
      }
      release(&p->lock);
    }
  }
}

//  获取进程的killed标识
int
get_killed(struct proc *p){
  int k = 0;
  acquire(&p->lock);
  k = p->killed;
  release(&p->lock);
  return k;
}

//  将函数的kiled标识设置为1
void 
set_killed(struct proc *p){
  acquire(&p->lock);
  p->killed = 1;
  release(&p->lock);
}


