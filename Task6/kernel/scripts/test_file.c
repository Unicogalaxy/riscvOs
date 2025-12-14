#include"../../include/param.h"
#include"../../include/riscv.h"
#include"../proc/proc.h"
#include"../../include/defs.h"
#include"../proc/sleeplock.h"
#include"../fs/fs.h"
#include"../fs/file.h"



void kassert(int condition, char *msg) {
    if (!condition) {
        printf("KERNEL ASSERT FAILED: %s\n", msg);
        panic("kassert");
    }
}

void test_filesystem_integrity(void) {
  printf("Testing filesystem integrity…\n");

  struct proc *p = alloc_proc();
  release(&p->lock);
  mycpu()->proc = p;

  struct inode *ip;
    char *filename = "ktest";
    char wbuffer[] = "Hello from Kernel!";
    char rbuffer[64];
    int len = sizeof(wbuffer); // 包含 \0

    // ---------------------------------------------------------
    // 步骤 1: 创建文件
    // 在内核中，"创建" = 分配 inode (ialloc) + 链接到目录 (dirlink)
    // ---------------------------------------------------------
    begin_op(); // 【重要】开启日志事务

    // 1.1 获取根目录 inode
    struct inode *root = namei("/"); 
    lock_inode(root); // 必须锁住才能操作

    // 1.2 分配一个新的 inode (类型为文件 T_FILE)
    ip = alloc_inode(root->dev, T_FILE);
    lock_inode(ip); // 锁住新 inode 以便修改
    
    // 初始化新 inode 的属性
    ip->major = 0;
    ip->minor = 0;
    ip->links = 1; // 链接数设为 1
    update_inode(ip);   // 写回磁盘

    // 1.3 将新 inode 链接到根目录，名字叫 "ktest"
    if(link_dir(root, filename, ip->inode_num) < 0)
        panic("dirlink failed");
    
    // 释放根目录锁（用完了）
    unlock_inode(root);
    putback_inode(root);

    // 此时 ip 仍然被锁住 (ilocked)，我们可以继续写数据
    
    // ---------------------------------------------------------
    // 步骤 2: 写入数据 (使用 writei)
    // ---------------------------------------------------------
    printf("[Kernel] Writing data...\n");
    
    // writei 参数: inode, user_src(0=内核地址), src, offset, n
    int wbytes = write_inode(ip, 0, (uint64)wbuffer, 0, len);
    
    kassert(wbytes == len, "Write bytes mismatch");
    printf("[Kernel] Wrote %d bytes: %s\n", wbytes, wbuffer);

    // 写入完成，先解锁并结束当前事务（为了模拟真实情况，或者是避免事务过大）
    unlock_inode(ip);
    end_op();


    // ---------------------------------------------------------
    // 步骤 3: 读取并验证 (使用 readi)
    // ---------------------------------------------------------
    begin_op(); // 开启新事务（读取虽然不改磁盘，但获取锁通常建议在 op 中，或者为了一致性）
    lock_inode(ip);  // 再次锁住 inode 准备读取

    // 清空缓冲区
    memset(rbuffer, 0, sizeof(rbuffer));

    printf("[Kernel] Reading data...\n");
    // readi 参数: inode, user_dst(0=内核地址), dst, offset, n
    int rbytes = read_inode(ip, 0, (uint64)rbuffer, 0, sizeof(rbuffer));

    kassert(rbytes == len, "Read bytes length mismatch");
    kassert(strncmp(wbuffer, rbuffer, len) == 0, "Content mismatch");
    
    printf("[Kernel] Read content verified: %s\n", rbuffer);

    // ---------------------------------------------------------
    // 步骤 4: 清理资源
    // ---------------------------------------------------------
    // 在内核态删除文件比较麻烦（需要手动操作目录项），
    // 这里我们只释放 inode 引用。
    // 如果你想真正删除，需要编写类似 sys_unlink 的逻辑。
    unlock_inode(ip); // 释放锁并减少引用计数
    putback_inode(ip);
    
    end_op();

    mycpu()->proc = 0;
  printf("Filesystem integrity test passed\n");
}