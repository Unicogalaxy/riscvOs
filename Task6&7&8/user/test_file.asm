
user/_test_file:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <my_assert>:
#include"../include/riscv.h"
#include"../include/fcntl.h"
#include"./user.h"

void my_assert(int condition, char *msg) {
    if (!condition) {
   0:	c111                	beqz	a0,4 <my_assert+0x4>
   2:	8082                	ret
void my_assert(int condition, char *msg) {
   4:	1141                	addi	sp,sp,-16
   6:	e406                	sd	ra,8(sp)
   8:	e022                	sd	s0,0(sp)
   a:	0800                	addi	s0,sp,16
        printf("Assertion failed: %s\n", msg);
   c:	00001517          	auipc	a0,0x1
  10:	cf450513          	addi	a0,a0,-780 # d00 <malloc+0x100>
  14:	00001097          	auipc	ra,0x1
  18:	b34080e7          	jalr	-1228(ra) # b48 <printf>
        exit(1);
  1c:	4505                	li	a0,1
  1e:	00000097          	auipc	ra,0x0
  22:	6d6080e7          	jalr	1750(ra) # 6f4 <exit>

0000000000000026 <test_filesystem_integrity>:
    }
}


void test_filesystem_integrity(void) {
  26:	7119                	addi	sp,sp,-128
  28:	fc86                	sd	ra,120(sp)
  2a:	f8a2                	sd	s0,112(sp)
  2c:	f4a6                	sd	s1,104(sp)
  2e:	f0ca                	sd	s2,96(sp)
  30:	0100                	addi	s0,sp,128
    printf("Testing filesystem integrity…\n");
  32:	00001517          	auipc	a0,0x1
  36:	cee50513          	addi	a0,a0,-786 # d20 <malloc+0x120>
  3a:	00001097          	auipc	ra,0x1
  3e:	b0e080e7          	jalr	-1266(ra) # b48 <printf>
    // 创建测试文件
    int fd = open("testfile", O_CREATE | O_RDWR);
  42:	20200593          	li	a1,514
  46:	00001517          	auipc	a0,0x1
  4a:	d0250513          	addi	a0,a0,-766 # d48 <malloc+0x148>
  4e:	00000097          	auipc	ra,0x0
  52:	6c6080e7          	jalr	1734(ra) # 714 <open>

    if(fd < 0){
  56:	0c054b63          	bltz	a0,12c <test_filesystem_integrity+0x106>
  5a:	84aa                	mv	s1,a0
        printf("Error: cannot create file 'testfile'\n");
        exit(1);
    }

    // 写入数据
    char buffer[] = "Hello, filesystem!";
  5c:	00001797          	auipc	a5,0x1
  60:	de478793          	addi	a5,a5,-540 # e40 <malloc+0x240>
  64:	6394                	ld	a3,0(a5)
  66:	6798                	ld	a4,8(a5)
  68:	fcd43423          	sd	a3,-56(s0)
  6c:	fce43823          	sd	a4,-48(s0)
  70:	0107d703          	lhu	a4,16(a5)
  74:	fce41c23          	sh	a4,-40(s0)
  78:	0127c783          	lbu	a5,18(a5)
  7c:	fcf40d23          	sb	a5,-38(s0)
    int bytes = write(fd, buffer, strlen(buffer));
  80:	fc840513          	addi	a0,s0,-56
  84:	00000097          	auipc	ra,0x0
  88:	3be080e7          	jalr	958(ra) # 442 <strlen>
  8c:	0005061b          	sext.w	a2,a0
  90:	fc840593          	addi	a1,s0,-56
  94:	8526                	mv	a0,s1
  96:	00000097          	auipc	ra,0x0
  9a:	696080e7          	jalr	1686(ra) # 72c <write>
  9e:	892a                	mv	s2,a0
    int len = strlen(buffer);
  a0:	fc840513          	addi	a0,s0,-56
  a4:	00000097          	auipc	ra,0x0
  a8:	39e080e7          	jalr	926(ra) # 442 <strlen>
  ac:	2501                	sext.w	a0,a0
    // 验证写入字节数
    if(bytes != len){
  ae:	08a91c63          	bne	s2,a0,146 <test_filesystem_integrity+0x120>
        printf("Error: write incomplete. Expected %d, wrote %d\n", len, bytes);
        close(fd);
        exit(1);
    }

    close(fd);
  b2:	8526                	mv	a0,s1
  b4:	00000097          	auipc	ra,0x0
  b8:	658080e7          	jalr	1624(ra) # 70c <close>
    // 重新打开并验证
    fd = open("testfile", O_RDONLY);
  bc:	4581                	li	a1,0
  be:	00001517          	auipc	a0,0x1
  c2:	c8a50513          	addi	a0,a0,-886 # d48 <malloc+0x148>
  c6:	00000097          	auipc	ra,0x0
  ca:	64e080e7          	jalr	1614(ra) # 714 <open>
  ce:	84aa                	mv	s1,a0
    if(fd < 0){
  d0:	08054f63          	bltz	a0,16e <test_filesystem_integrity+0x148>
        printf("Error: cannot open 'testfile' for reading\n");
        exit(1);
    }
    char read_buffer[64];
    bytes = read(fd, read_buffer, 
  d4:	04000613          	li	a2,64
  d8:	f8840593          	addi	a1,s0,-120
  dc:	00000097          	auipc	ra,0x0
  e0:	648080e7          	jalr	1608(ra) # 724 <read>
    sizeof(read_buffer));
    read_buffer[bytes] = '\0';
  e4:	fe050793          	addi	a5,a0,-32
  e8:	97a2                	add	a5,a5,s0
  ea:	fa078423          	sb	zero,-88(a5)

    if(bytes < 0){
  ee:	08054d63          	bltz	a0,188 <test_filesystem_integrity+0x162>
        printf("Error: read failed\n");
        exit(1);
    }
    close(fd);
  f2:	8526                	mv	a0,s1
  f4:	00000097          	auipc	ra,0x0
  f8:	618080e7          	jalr	1560(ra) # 70c <close>
    // 删除文件
    // 4. 删除文件 (unlink 是 xv6 中删除文件的系统调用)
    if(unlink("testfile") < 0){
  fc:	00001517          	auipc	a0,0x1
 100:	c4c50513          	addi	a0,a0,-948 # d48 <malloc+0x148>
 104:	00000097          	auipc	ra,0x0
 108:	660080e7          	jalr	1632(ra) # 764 <unlink>
 10c:	08054b63          	bltz	a0,1a2 <test_filesystem_integrity+0x17c>
        printf("Error: unlink (delete) failed\n");
        exit(1);
    }

    printf("Filesystem integrity test passed\n");
 110:	00001517          	auipc	a0,0x1
 114:	d0850513          	addi	a0,a0,-760 # e18 <malloc+0x218>
 118:	00001097          	auipc	ra,0x1
 11c:	a30080e7          	jalr	-1488(ra) # b48 <printf>
}
 120:	70e6                	ld	ra,120(sp)
 122:	7446                	ld	s0,112(sp)
 124:	74a6                	ld	s1,104(sp)
 126:	7906                	ld	s2,96(sp)
 128:	6109                	addi	sp,sp,128
 12a:	8082                	ret
        printf("Error: cannot create file 'testfile'\n");
 12c:	00001517          	auipc	a0,0x1
 130:	c2c50513          	addi	a0,a0,-980 # d58 <malloc+0x158>
 134:	00001097          	auipc	ra,0x1
 138:	a14080e7          	jalr	-1516(ra) # b48 <printf>
        exit(1);
 13c:	4505                	li	a0,1
 13e:	00000097          	auipc	ra,0x0
 142:	5b6080e7          	jalr	1462(ra) # 6f4 <exit>
        printf("Error: write incomplete. Expected %d, wrote %d\n", len, bytes);
 146:	864a                	mv	a2,s2
 148:	85aa                	mv	a1,a0
 14a:	00001517          	auipc	a0,0x1
 14e:	c3650513          	addi	a0,a0,-970 # d80 <malloc+0x180>
 152:	00001097          	auipc	ra,0x1
 156:	9f6080e7          	jalr	-1546(ra) # b48 <printf>
        close(fd);
 15a:	8526                	mv	a0,s1
 15c:	00000097          	auipc	ra,0x0
 160:	5b0080e7          	jalr	1456(ra) # 70c <close>
        exit(1);
 164:	4505                	li	a0,1
 166:	00000097          	auipc	ra,0x0
 16a:	58e080e7          	jalr	1422(ra) # 6f4 <exit>
        printf("Error: cannot open 'testfile' for reading\n");
 16e:	00001517          	auipc	a0,0x1
 172:	c4250513          	addi	a0,a0,-958 # db0 <malloc+0x1b0>
 176:	00001097          	auipc	ra,0x1
 17a:	9d2080e7          	jalr	-1582(ra) # b48 <printf>
        exit(1);
 17e:	4505                	li	a0,1
 180:	00000097          	auipc	ra,0x0
 184:	574080e7          	jalr	1396(ra) # 6f4 <exit>
        printf("Error: read failed\n");
 188:	00001517          	auipc	a0,0x1
 18c:	c5850513          	addi	a0,a0,-936 # de0 <malloc+0x1e0>
 190:	00001097          	auipc	ra,0x1
 194:	9b8080e7          	jalr	-1608(ra) # b48 <printf>
        exit(1);
 198:	4505                	li	a0,1
 19a:	00000097          	auipc	ra,0x0
 19e:	55a080e7          	jalr	1370(ra) # 6f4 <exit>
        printf("Error: unlink (delete) failed\n");
 1a2:	00001517          	auipc	a0,0x1
 1a6:	c5650513          	addi	a0,a0,-938 # df8 <malloc+0x1f8>
 1aa:	00001097          	auipc	ra,0x1
 1ae:	99e080e7          	jalr	-1634(ra) # b48 <printf>
        exit(1);
 1b2:	4505                	li	a0,1
 1b4:	00000097          	auipc	ra,0x0
 1b8:	540080e7          	jalr	1344(ra) # 6f4 <exit>

00000000000001bc <test_concurrent_access>:


void test_concurrent_access(void) {
 1bc:	711d                	addi	sp,sp,-96
 1be:	ec86                	sd	ra,88(sp)
 1c0:	e8a2                	sd	s0,80(sp)
 1c2:	e4a6                	sd	s1,72(sp)
 1c4:	e0ca                	sd	s2,64(sp)
 1c6:	1080                	addi	s0,sp,96
    printf("Testing concurrent file access...\n");
 1c8:	00001517          	auipc	a0,0x1
 1cc:	c9050513          	addi	a0,a0,-880 # e58 <malloc+0x258>
 1d0:	00001097          	auipc	ra,0x1
 1d4:	978080e7          	jalr	-1672(ra) # b48 <printf>

    // 创建 4 个子进程同时访问文件系统
    for (int i = 0; i < 4; i++) {
 1d8:	4481                	li	s1,0
 1da:	4911                	li	s2,4
        int pid = fork();
 1dc:	00000097          	auipc	ra,0x0
 1e0:	510080e7          	jalr	1296(ra) # 6ec <fork>
        
        if(pid < 0){
 1e4:	04054863          	bltz	a0,234 <test_concurrent_access+0x78>
            printf("fork failed\n");
            exit(1);
        }

        if (pid == 0) {
 1e8:	c525                	beqz	a0,250 <test_concurrent_access+0x94>
    for (int i = 0; i < 4; i++) {
 1ea:	2485                	addiw	s1,s1,1
 1ec:	ff2498e3          	bne	s1,s2,1dc <test_concurrent_access+0x20>
    }

    // 父进程：等待所有子进程完成
    // xv6 的 wait 接收一个地址来存状态，或者传 0 忽略
    for (int i = 0; i < 4; i++) {
        wait(0);
 1f0:	4501                	li	a0,0
 1f2:	00000097          	auipc	ra,0x0
 1f6:	50a080e7          	jalr	1290(ra) # 6fc <wait>
 1fa:	4501                	li	a0,0
 1fc:	00000097          	auipc	ra,0x0
 200:	500080e7          	jalr	1280(ra) # 6fc <wait>
 204:	4501                	li	a0,0
 206:	00000097          	auipc	ra,0x0
 20a:	4f6080e7          	jalr	1270(ra) # 6fc <wait>
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	4ec080e7          	jalr	1260(ra) # 6fc <wait>
    }

    printf("Concurrent access test completed\n");
 218:	00001517          	auipc	a0,0x1
 21c:	c9050513          	addi	a0,a0,-880 # ea8 <malloc+0x2a8>
 220:	00001097          	auipc	ra,0x1
 224:	928080e7          	jalr	-1752(ra) # b48 <printf>
}
 228:	60e6                	ld	ra,88(sp)
 22a:	6446                	ld	s0,80(sp)
 22c:	64a6                	ld	s1,72(sp)
 22e:	6906                	ld	s2,64(sp)
 230:	6125                	addi	sp,sp,96
 232:	8082                	ret
 234:	fc4e                	sd	s3,56(sp)
            printf("fork failed\n");
 236:	00001517          	auipc	a0,0x1
 23a:	c4a50513          	addi	a0,a0,-950 # e80 <malloc+0x280>
 23e:	00001097          	auipc	ra,0x1
 242:	90a080e7          	jalr	-1782(ra) # b48 <printf>
            exit(1);
 246:	4505                	li	a0,1
 248:	00000097          	auipc	ra,0x0
 24c:	4ac080e7          	jalr	1196(ra) # 6f4 <exit>
 250:	fc4e                	sd	s3,56(sp)
            make_filename(filename, "test_", i);
 252:	8626                	mv	a2,s1
 254:	00001597          	auipc	a1,0x1
 258:	c3c58593          	addi	a1,a1,-964 # e90 <malloc+0x290>
 25c:	fb040513          	addi	a0,s0,-80
 260:	00000097          	auipc	ra,0x0
 264:	3ec080e7          	jalr	1004(ra) # 64c <make_filename>
            for (int j = 0; j < 100; j++) {
 268:	fa042623          	sw	zero,-84(s0)
                        printf("write failed\n");
 26c:	00001997          	auipc	s3,0x1
 270:	c2c98993          	addi	s3,s3,-980 # e98 <malloc+0x298>
            for (int j = 0; j < 100; j++) {
 274:	06300913          	li	s2,99
 278:	a02d                	j	2a2 <test_concurrent_access+0xe6>
                    close(fd);
 27a:	8526                	mv	a0,s1
 27c:	00000097          	auipc	ra,0x0
 280:	490080e7          	jalr	1168(ra) # 70c <close>
                    unlink(filename);
 284:	fb040513          	addi	a0,s0,-80
 288:	00000097          	auipc	ra,0x0
 28c:	4dc080e7          	jalr	1244(ra) # 764 <unlink>
            for (int j = 0; j < 100; j++) {
 290:	fac42783          	lw	a5,-84(s0)
 294:	2785                	addiw	a5,a5,1
 296:	0007871b          	sext.w	a4,a5
 29a:	faf42623          	sw	a5,-84(s0)
 29e:	02e94d63          	blt	s2,a4,2d8 <test_concurrent_access+0x11c>
                int fd = open(filename, O_CREATE | O_RDWR);
 2a2:	20200593          	li	a1,514
 2a6:	fb040513          	addi	a0,s0,-80
 2aa:	00000097          	auipc	ra,0x0
 2ae:	46a080e7          	jalr	1130(ra) # 714 <open>
 2b2:	84aa                	mv	s1,a0
                if (fd >= 0) {
 2b4:	fc054ee3          	bltz	a0,290 <test_concurrent_access+0xd4>
                    if(write(fd, &j, sizeof(j)) != sizeof(j)){
 2b8:	4611                	li	a2,4
 2ba:	fac40593          	addi	a1,s0,-84
 2be:	00000097          	auipc	ra,0x0
 2c2:	46e080e7          	jalr	1134(ra) # 72c <write>
 2c6:	4791                	li	a5,4
 2c8:	faf509e3          	beq	a0,a5,27a <test_concurrent_access+0xbe>
                        printf("write failed\n");
 2cc:	854e                	mv	a0,s3
 2ce:	00001097          	auipc	ra,0x1
 2d2:	87a080e7          	jalr	-1926(ra) # b48 <printf>
 2d6:	b755                	j	27a <test_concurrent_access+0xbe>
            exit(0);
 2d8:	4501                	li	a0,0
 2da:	00000097          	auipc	ra,0x0
 2de:	41a080e7          	jalr	1050(ra) # 6f4 <exit>

00000000000002e2 <test_filesystem_performance>:


void test_filesystem_performance() {
 2e2:	711d                	addi	sp,sp,-96
 2e4:	ec86                	sd	ra,88(sp)
 2e6:	e8a2                	sd	s0,80(sp)
 2e8:	e4a6                	sd	s1,72(sp)
 2ea:	e0ca                	sd	s2,64(sp)
 2ec:	fc4e                	sd	s3,56(sp)
 2ee:	f852                	sd	s4,48(sp)
 2f0:	f456                	sd	s5,40(sp)
 2f2:	f05a                	sd	s6,32(sp)
 2f4:	1080                	addi	s0,sp,96
  
    printf("Testing filesystem performance...\n");
 2f6:	00001517          	auipc	a0,0x1
 2fa:	bda50513          	addi	a0,a0,-1062 # ed0 <malloc+0x2d0>
 2fe:	00001097          	auipc	ra,0x1
 302:	84a080e7          	jalr	-1974(ra) # b48 <printf>
    
    uint64 start_time = get_time();
 306:	00000097          	auipc	ra,0x0
 30a:	32c080e7          	jalr	812(ra) # 632 <get_time>
 30e:	00050b1b          	sext.w	s6,a0
    
    // --- 大量小文件测试 ---
    char filename[32];
    for (int i = 0; i < 100; i++) { // 为了不打爆xv6有限的inode，先测试100个
 312:	4901                	li	s2,0
        // 手动生成文件名，例如 "s_0", "s_1"
        make_filename(filename, "s_", i);
 314:	00001997          	auipc	s3,0x1
 318:	be498993          	addi	s3,s3,-1052 # ef8 <malloc+0x2f8>
        int fd = open(filename, O_CREATE | O_RDWR);
        if(fd < 0){
            printf("Error: cannot create file %s\n", filename);
            exit(1);
        }
        write(fd, "test", 4);
 31c:	00001a97          	auipc	s5,0x1
 320:	c04a8a93          	addi	s5,s5,-1020 # f20 <malloc+0x320>
    for (int i = 0; i < 100; i++) { // 为了不打爆xv6有限的inode，先测试100个
 324:	06400a13          	li	s4,100
        make_filename(filename, "s_", i);
 328:	864a                	mv	a2,s2
 32a:	85ce                	mv	a1,s3
 32c:	fa040513          	addi	a0,s0,-96
 330:	00000097          	auipc	ra,0x0
 334:	31c080e7          	jalr	796(ra) # 64c <make_filename>
        int fd = open(filename, O_CREATE | O_RDWR);
 338:	20200593          	li	a1,514
 33c:	fa040513          	addi	a0,s0,-96
 340:	00000097          	auipc	ra,0x0
 344:	3d4080e7          	jalr	980(ra) # 714 <open>
 348:	84aa                	mv	s1,a0
        if(fd < 0){
 34a:	04054863          	bltz	a0,39a <test_filesystem_performance+0xb8>
        write(fd, "test", 4);
 34e:	4611                	li	a2,4
 350:	85d6                	mv	a1,s5
 352:	00000097          	auipc	ra,0x0
 356:	3da080e7          	jalr	986(ra) # 72c <write>
        close(fd);
 35a:	8526                	mv	a0,s1
 35c:	00000097          	auipc	ra,0x0
 360:	3b0080e7          	jalr	944(ra) # 70c <close>
    for (int i = 0; i < 100; i++) { // 为了不打爆xv6有限的inode，先测试100个
 364:	2905                	addiw	s2,s2,1
 366:	fd4911e3          	bne	s2,s4,328 <test_filesystem_performance+0x46>
    }
    uint64 small_files_time = get_time() - start_time;
 36a:	00000097          	auipc	ra,0x0
 36e:	2c8080e7          	jalr	712(ra) # 632 <get_time>
    
    printf("Files (100x4B): %d ticks\n", (unsigned int)small_files_time);
 372:	416505bb          	subw	a1,a0,s6
 376:	00001517          	auipc	a0,0x1
 37a:	bb250513          	addi	a0,a0,-1102 # f28 <malloc+0x328>
 37e:	00000097          	auipc	ra,0x0
 382:	7ca080e7          	jalr	1994(ra) # b48 <printf>

    
}
 386:	60e6                	ld	ra,88(sp)
 388:	6446                	ld	s0,80(sp)
 38a:	64a6                	ld	s1,72(sp)
 38c:	6906                	ld	s2,64(sp)
 38e:	79e2                	ld	s3,56(sp)
 390:	7a42                	ld	s4,48(sp)
 392:	7aa2                	ld	s5,40(sp)
 394:	7b02                	ld	s6,32(sp)
 396:	6125                	addi	sp,sp,96
 398:	8082                	ret
            printf("Error: cannot create file %s\n", filename);
 39a:	fa040593          	addi	a1,s0,-96
 39e:	00001517          	auipc	a0,0x1
 3a2:	b6250513          	addi	a0,a0,-1182 # f00 <malloc+0x300>
 3a6:	00000097          	auipc	ra,0x0
 3aa:	7a2080e7          	jalr	1954(ra) # b48 <printf>
            exit(1);
 3ae:	4505                	li	a0,1
 3b0:	00000097          	auipc	ra,0x0
 3b4:	344080e7          	jalr	836(ra) # 6f4 <exit>

00000000000003b8 <main>:

// 3. 添加 main 函数作为入口
int 
main(int argc, char *argv[]) {
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e406                	sd	ra,8(sp)
 3bc:	e022                	sd	s0,0(sp)
 3be:	0800                	addi	s0,sp,16
    test_filesystem_integrity();
 3c0:	00000097          	auipc	ra,0x0
 3c4:	c66080e7          	jalr	-922(ra) # 26 <test_filesystem_integrity>
    test_concurrent_access();
 3c8:	00000097          	auipc	ra,0x0
 3cc:	df4080e7          	jalr	-524(ra) # 1bc <test_concurrent_access>
    test_filesystem_performance();
 3d0:	00000097          	auipc	ra,0x0
 3d4:	f12080e7          	jalr	-238(ra) # 2e2 <test_filesystem_performance>

    exit(0); // 必须调用 exit，否则会 trap
 3d8:	4501                	li	a0,0
 3da:	00000097          	auipc	ra,0x0
 3de:	31a080e7          	jalr	794(ra) # 6f4 <exit>

00000000000003e2 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 3e2:	1141                	addi	sp,sp,-16
 3e4:	e406                	sd	ra,8(sp)
 3e6:	e022                	sd	s0,0(sp)
 3e8:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
 3ea:	00000097          	auipc	ra,0x0
 3ee:	fce080e7          	jalr	-50(ra) # 3b8 <main>
  exit(r);
 3f2:	00000097          	auipc	ra,0x0
 3f6:	302080e7          	jalr	770(ra) # 6f4 <exit>

00000000000003fa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 3fa:	1141                	addi	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 400:	87aa                	mv	a5,a0
 402:	0585                	addi	a1,a1,1
 404:	0785                	addi	a5,a5,1
 406:	fff5c703          	lbu	a4,-1(a1)
 40a:	fee78fa3          	sb	a4,-1(a5)
 40e:	fb75                	bnez	a4,402 <strcpy+0x8>
    ;
  return os;
}
 410:	6422                	ld	s0,8(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret

0000000000000416 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 416:	1141                	addi	sp,sp,-16
 418:	e422                	sd	s0,8(sp)
 41a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 41c:	00054783          	lbu	a5,0(a0)
 420:	cb91                	beqz	a5,434 <strcmp+0x1e>
 422:	0005c703          	lbu	a4,0(a1)
 426:	00f71763          	bne	a4,a5,434 <strcmp+0x1e>
    p++, q++;
 42a:	0505                	addi	a0,a0,1
 42c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 42e:	00054783          	lbu	a5,0(a0)
 432:	fbe5                	bnez	a5,422 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 434:	0005c503          	lbu	a0,0(a1)
}
 438:	40a7853b          	subw	a0,a5,a0
 43c:	6422                	ld	s0,8(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret

0000000000000442 <strlen>:

uint
strlen(const char *s)
{
 442:	1141                	addi	sp,sp,-16
 444:	e422                	sd	s0,8(sp)
 446:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 448:	00054783          	lbu	a5,0(a0)
 44c:	cf91                	beqz	a5,468 <strlen+0x26>
 44e:	0505                	addi	a0,a0,1
 450:	87aa                	mv	a5,a0
 452:	86be                	mv	a3,a5
 454:	0785                	addi	a5,a5,1
 456:	fff7c703          	lbu	a4,-1(a5)
 45a:	ff65                	bnez	a4,452 <strlen+0x10>
 45c:	40a6853b          	subw	a0,a3,a0
 460:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 462:	6422                	ld	s0,8(sp)
 464:	0141                	addi	sp,sp,16
 466:	8082                	ret
  for(n = 0; s[n]; n++)
 468:	4501                	li	a0,0
 46a:	bfe5                	j	462 <strlen+0x20>

000000000000046c <memset>:

void*
memset(void *dst, int c, uint n)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 472:	ca19                	beqz	a2,488 <memset+0x1c>
 474:	87aa                	mv	a5,a0
 476:	1602                	slli	a2,a2,0x20
 478:	9201                	srli	a2,a2,0x20
 47a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 47e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 482:	0785                	addi	a5,a5,1
 484:	fee79de3          	bne	a5,a4,47e <memset+0x12>
  }
  return dst;
}
 488:	6422                	ld	s0,8(sp)
 48a:	0141                	addi	sp,sp,16
 48c:	8082                	ret

000000000000048e <strchr>:

char*
strchr(const char *s, char c)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
  for(; *s; s++)
 494:	00054783          	lbu	a5,0(a0)
 498:	cb99                	beqz	a5,4ae <strchr+0x20>
    if(*s == c)
 49a:	00f58763          	beq	a1,a5,4a8 <strchr+0x1a>
  for(; *s; s++)
 49e:	0505                	addi	a0,a0,1
 4a0:	00054783          	lbu	a5,0(a0)
 4a4:	fbfd                	bnez	a5,49a <strchr+0xc>
      return (char*)s;
  return 0;
 4a6:	4501                	li	a0,0
}
 4a8:	6422                	ld	s0,8(sp)
 4aa:	0141                	addi	sp,sp,16
 4ac:	8082                	ret
  return 0;
 4ae:	4501                	li	a0,0
 4b0:	bfe5                	j	4a8 <strchr+0x1a>

00000000000004b2 <gets>:

char*
gets(char *buf, int max)
{
 4b2:	711d                	addi	sp,sp,-96
 4b4:	ec86                	sd	ra,88(sp)
 4b6:	e8a2                	sd	s0,80(sp)
 4b8:	e4a6                	sd	s1,72(sp)
 4ba:	e0ca                	sd	s2,64(sp)
 4bc:	fc4e                	sd	s3,56(sp)
 4be:	f852                	sd	s4,48(sp)
 4c0:	f456                	sd	s5,40(sp)
 4c2:	f05a                	sd	s6,32(sp)
 4c4:	ec5e                	sd	s7,24(sp)
 4c6:	1080                	addi	s0,sp,96
 4c8:	8baa                	mv	s7,a0
 4ca:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4cc:	892a                	mv	s2,a0
 4ce:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4d0:	4aa9                	li	s5,10
 4d2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4d4:	89a6                	mv	s3,s1
 4d6:	2485                	addiw	s1,s1,1
 4d8:	0344d863          	bge	s1,s4,508 <gets+0x56>
    cc = read(0, &c, 1);
 4dc:	4605                	li	a2,1
 4de:	faf40593          	addi	a1,s0,-81
 4e2:	4501                	li	a0,0
 4e4:	00000097          	auipc	ra,0x0
 4e8:	240080e7          	jalr	576(ra) # 724 <read>
    if(cc < 1)
 4ec:	00a05e63          	blez	a0,508 <gets+0x56>
    buf[i++] = c;
 4f0:	faf44783          	lbu	a5,-81(s0)
 4f4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4f8:	01578763          	beq	a5,s5,506 <gets+0x54>
 4fc:	0905                	addi	s2,s2,1
 4fe:	fd679be3          	bne	a5,s6,4d4 <gets+0x22>
    buf[i++] = c;
 502:	89a6                	mv	s3,s1
 504:	a011                	j	508 <gets+0x56>
 506:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 508:	99de                	add	s3,s3,s7
 50a:	00098023          	sb	zero,0(s3)
  return buf;
}
 50e:	855e                	mv	a0,s7
 510:	60e6                	ld	ra,88(sp)
 512:	6446                	ld	s0,80(sp)
 514:	64a6                	ld	s1,72(sp)
 516:	6906                	ld	s2,64(sp)
 518:	79e2                	ld	s3,56(sp)
 51a:	7a42                	ld	s4,48(sp)
 51c:	7aa2                	ld	s5,40(sp)
 51e:	7b02                	ld	s6,32(sp)
 520:	6be2                	ld	s7,24(sp)
 522:	6125                	addi	sp,sp,96
 524:	8082                	ret

0000000000000526 <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
 526:	1141                	addi	sp,sp,-16
 528:	e422                	sd	s0,8(sp)
 52a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 52c:	00054683          	lbu	a3,0(a0)
 530:	fd06879b          	addiw	a5,a3,-48
 534:	0ff7f793          	zext.b	a5,a5
 538:	4625                	li	a2,9
 53a:	02f66863          	bltu	a2,a5,56a <atoi+0x44>
 53e:	872a                	mv	a4,a0
  n = 0;
 540:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 542:	0705                	addi	a4,a4,1
 544:	0025179b          	slliw	a5,a0,0x2
 548:	9fa9                	addw	a5,a5,a0
 54a:	0017979b          	slliw	a5,a5,0x1
 54e:	9fb5                	addw	a5,a5,a3
 550:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 554:	00074683          	lbu	a3,0(a4)
 558:	fd06879b          	addiw	a5,a3,-48
 55c:	0ff7f793          	zext.b	a5,a5
 560:	fef671e3          	bgeu	a2,a5,542 <atoi+0x1c>
  return n;
}
 564:	6422                	ld	s0,8(sp)
 566:	0141                	addi	sp,sp,16
 568:	8082                	ret
  n = 0;
 56a:	4501                	li	a0,0
 56c:	bfe5                	j	564 <atoi+0x3e>

000000000000056e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 56e:	1141                	addi	sp,sp,-16
 570:	e422                	sd	s0,8(sp)
 572:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 574:	02b57463          	bgeu	a0,a1,59c <memmove+0x2e>
    while(n-- > 0)
 578:	00c05f63          	blez	a2,596 <memmove+0x28>
 57c:	1602                	slli	a2,a2,0x20
 57e:	9201                	srli	a2,a2,0x20
 580:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 584:	872a                	mv	a4,a0
      *dst++ = *src++;
 586:	0585                	addi	a1,a1,1
 588:	0705                	addi	a4,a4,1
 58a:	fff5c683          	lbu	a3,-1(a1)
 58e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 592:	fef71ae3          	bne	a4,a5,586 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 596:	6422                	ld	s0,8(sp)
 598:	0141                	addi	sp,sp,16
 59a:	8082                	ret
    dst += n;
 59c:	00c50733          	add	a4,a0,a2
    src += n;
 5a0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5a2:	fec05ae3          	blez	a2,596 <memmove+0x28>
 5a6:	fff6079b          	addiw	a5,a2,-1
 5aa:	1782                	slli	a5,a5,0x20
 5ac:	9381                	srli	a5,a5,0x20
 5ae:	fff7c793          	not	a5,a5
 5b2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5b4:	15fd                	addi	a1,a1,-1
 5b6:	177d                	addi	a4,a4,-1
 5b8:	0005c683          	lbu	a3,0(a1)
 5bc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5c0:	fee79ae3          	bne	a5,a4,5b4 <memmove+0x46>
 5c4:	bfc9                	j	596 <memmove+0x28>

00000000000005c6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5c6:	1141                	addi	sp,sp,-16
 5c8:	e422                	sd	s0,8(sp)
 5ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5cc:	ca05                	beqz	a2,5fc <memcmp+0x36>
 5ce:	fff6069b          	addiw	a3,a2,-1
 5d2:	1682                	slli	a3,a3,0x20
 5d4:	9281                	srli	a3,a3,0x20
 5d6:	0685                	addi	a3,a3,1
 5d8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5da:	00054783          	lbu	a5,0(a0)
 5de:	0005c703          	lbu	a4,0(a1)
 5e2:	00e79863          	bne	a5,a4,5f2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5e6:	0505                	addi	a0,a0,1
    p2++;
 5e8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5ea:	fed518e3          	bne	a0,a3,5da <memcmp+0x14>
  }
  return 0;
 5ee:	4501                	li	a0,0
 5f0:	a019                	j	5f6 <memcmp+0x30>
      return *p1 - *p2;
 5f2:	40e7853b          	subw	a0,a5,a4
}
 5f6:	6422                	ld	s0,8(sp)
 5f8:	0141                	addi	sp,sp,16
 5fa:	8082                	ret
  return 0;
 5fc:	4501                	li	a0,0
 5fe:	bfe5                	j	5f6 <memcmp+0x30>

0000000000000600 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 600:	1141                	addi	sp,sp,-16
 602:	e406                	sd	ra,8(sp)
 604:	e022                	sd	s0,0(sp)
 606:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 608:	00000097          	auipc	ra,0x0
 60c:	f66080e7          	jalr	-154(ra) # 56e <memmove>
}
 610:	60a2                	ld	ra,8(sp)
 612:	6402                	ld	s0,0(sp)
 614:	0141                	addi	sp,sp,16
 616:	8082                	ret

0000000000000618 <sbrk>:

char *
sbrk(int n) {
 618:	1141                	addi	sp,sp,-16
 61a:	e406                	sd	ra,8(sp)
 61c:	e022                	sd	s0,0(sp)
 61e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 620:	4585                	li	a1,1
 622:	00000097          	auipc	ra,0x0
 626:	12a080e7          	jalr	298(ra) # 74c <sys_sbrk>
}
 62a:	60a2                	ld	ra,8(sp)
 62c:	6402                	ld	s0,0(sp)
 62e:	0141                	addi	sp,sp,16
 630:	8082                	ret

0000000000000632 <get_time>:
//   return sys_sbrk(n, SBRK_LAZY);
// }


unsigned int 
get_time(void) {
 632:	1141                	addi	sp,sp,-16
 634:	e406                	sd	ra,8(sp)
 636:	e022                	sd	s0,0(sp)
 638:	0800                	addi	s0,sp,16
    return uptime();
 63a:	00000097          	auipc	ra,0x0
 63e:	11a080e7          	jalr	282(ra) # 754 <uptime>
}
 642:	2501                	sext.w	a0,a0
 644:	60a2                	ld	ra,8(sp)
 646:	6402                	ld	s0,0(sp)
 648:	0141                	addi	sp,sp,16
 64a:	8082                	ret

000000000000064c <make_filename>:
void 
make_filename(char *buf, const char *prefix, int num) {
    // 复制前缀
    char *p = buf;
    const char *s = prefix;
    while(*s) *p++ = *s++;
 64c:	0005c783          	lbu	a5,0(a1)
 650:	cb81                	beqz	a5,660 <make_filename+0x14>
 652:	0585                	addi	a1,a1,1
 654:	0505                	addi	a0,a0,1
 656:	fef50fa3          	sb	a5,-1(a0)
 65a:	0005c783          	lbu	a5,0(a1)
 65e:	fbf5                	bnez	a5,652 <make_filename+0x6>
    
    // 处理数字部分
    if (num == 0) {
 660:	ca3d                	beqz	a2,6d6 <make_filename+0x8a>
make_filename(char *buf, const char *prefix, int num) {
 662:	1101                	addi	sp,sp,-32
 664:	ec22                	sd	s0,24(sp)
 666:	1000                	addi	s0,sp,32
        *p++ = '0';
    } else {
        // 临时缓冲区存放数字
        char digits[16];
        int i = 0;
        while(num > 0) {
 668:	fe040893          	addi	a7,s0,-32
 66c:	87c6                	mv	a5,a7
            digits[i++] = (num % 10) + '0';
 66e:	46a9                	li	a3,10
        while(num > 0) {
 670:	4825                	li	a6,9
 672:	06c05063          	blez	a2,6d2 <make_filename+0x86>
            digits[i++] = (num % 10) + '0';
 676:	02d6673b          	remw	a4,a2,a3
 67a:	0307071b          	addiw	a4,a4,48
 67e:	00e78023          	sb	a4,0(a5)
            num /= 10;
 682:	85b2                	mv	a1,a2
 684:	02d6463b          	divw	a2,a2,a3
        while(num > 0) {
 688:	873e                	mv	a4,a5
 68a:	0785                	addi	a5,a5,1
 68c:	feb845e3          	blt	a6,a1,676 <make_filename+0x2a>
 690:	4117073b          	subw	a4,a4,a7
 694:	0017069b          	addiw	a3,a4,1
            digits[i++] = (num % 10) + '0';
 698:	0006879b          	sext.w	a5,a3
        }
        // 倒序写入
        while(i > 0) *p++ = digits[--i];
 69c:	04f05663          	blez	a5,6e8 <make_filename+0x9c>
 6a0:	fe040713          	addi	a4,s0,-32
 6a4:	973e                	add	a4,a4,a5
 6a6:	02069593          	slli	a1,a3,0x20
 6aa:	9181                	srli	a1,a1,0x20
 6ac:	95aa                	add	a1,a1,a0
 6ae:	87aa                	mv	a5,a0
 6b0:	0785                	addi	a5,a5,1
 6b2:	fff74603          	lbu	a2,-1(a4)
 6b6:	fec78fa3          	sb	a2,-1(a5)
 6ba:	177d                	addi	a4,a4,-1
 6bc:	feb79ae3          	bne	a5,a1,6b0 <make_filename+0x64>
 6c0:	02069793          	slli	a5,a3,0x20
 6c4:	9381                	srli	a5,a5,0x20
 6c6:	97aa                	add	a5,a5,a0
    }
    *p = 0; // 字符串结束符
 6c8:	00078023          	sb	zero,0(a5)
 6cc:	6462                	ld	s0,24(sp)
 6ce:	6105                	addi	sp,sp,32
 6d0:	8082                	ret
        while(num > 0) {
 6d2:	87aa                	mv	a5,a0
 6d4:	bfd5                	j	6c8 <make_filename+0x7c>
        *p++ = '0';
 6d6:	00150793          	addi	a5,a0,1
 6da:	03000713          	li	a4,48
 6de:	00e50023          	sb	a4,0(a0)
    *p = 0; // 字符串结束符
 6e2:	00078023          	sb	zero,0(a5)
 6e6:	8082                	ret
        while(i > 0) *p++ = digits[--i];
 6e8:	87aa                	mv	a5,a0
 6ea:	bff9                	j	6c8 <make_filename+0x7c>

00000000000006ec <fork>:
.globl unlink
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6ec:	4885                	li	a7,1
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6f4:	4889                	li	a7,2
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <wait>:
.global wait
wait:
 li a7, SYS_wait
 6fc:	488d                	li	a7,3
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 704:	4891                	li	a7,4
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <close>:
.global close
close:
 li a7, SYS_close
 70c:	4899                	li	a7,6
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <open>:
.global open
open:
 li a7, SYS_open
 714:	489d                	li	a7,7
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <exec>:
.global exec
exec:
 li a7, SYS_exec
 71c:	4895                	li	a7,5
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <read>:
.global read
read:
 li a7, SYS_read
 724:	48a1                	li	a7,8
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <write>:
.global write
write:
 li a7, SYS_write
 72c:	48a5                	li	a7,9
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 734:	48a9                	li	a7,10
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 73c:	48ad                	li	a7,11
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 744:	48b1                	li	a7,12
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 74c:	48b5                	li	a7,13
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 754:	48b9                	li	a7,14
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 75c:	48bd                	li	a7,15
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 764:	48c1                	li	a7,16
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 76c:	1101                	addi	sp,sp,-32
 76e:	ec06                	sd	ra,24(sp)
 770:	e822                	sd	s0,16(sp)
 772:	1000                	addi	s0,sp,32
 774:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 778:	4605                	li	a2,1
 77a:	fef40593          	addi	a1,s0,-17
 77e:	00000097          	auipc	ra,0x0
 782:	fae080e7          	jalr	-82(ra) # 72c <write>
}
 786:	60e2                	ld	ra,24(sp)
 788:	6442                	ld	s0,16(sp)
 78a:	6105                	addi	sp,sp,32
 78c:	8082                	ret

000000000000078e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 78e:	715d                	addi	sp,sp,-80
 790:	e486                	sd	ra,72(sp)
 792:	e0a2                	sd	s0,64(sp)
 794:	f84a                	sd	s2,48(sp)
 796:	0880                	addi	s0,sp,80
 798:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 79a:	c299                	beqz	a3,7a0 <printint+0x12>
 79c:	0805c563          	bltz	a1,826 <printint+0x98>
  neg = 0;
 7a0:	4881                	li	a7,0
 7a2:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 7a6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 7a8:	00000517          	auipc	a0,0x0
 7ac:	7a850513          	addi	a0,a0,1960 # f50 <digits>
 7b0:	883e                	mv	a6,a5
 7b2:	2785                	addiw	a5,a5,1
 7b4:	02c5f733          	remu	a4,a1,a2
 7b8:	972a                	add	a4,a4,a0
 7ba:	00074703          	lbu	a4,0(a4)
 7be:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 7c2:	872e                	mv	a4,a1
 7c4:	02c5d5b3          	divu	a1,a1,a2
 7c8:	0685                	addi	a3,a3,1
 7ca:	fec773e3          	bgeu	a4,a2,7b0 <printint+0x22>
  if(neg)
 7ce:	00088b63          	beqz	a7,7e4 <printint+0x56>
    buf[i++] = '-';
 7d2:	fd078793          	addi	a5,a5,-48
 7d6:	97a2                	add	a5,a5,s0
 7d8:	02d00713          	li	a4,45
 7dc:	fee78423          	sb	a4,-24(a5)
 7e0:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 7e4:	02f05c63          	blez	a5,81c <printint+0x8e>
 7e8:	fc26                	sd	s1,56(sp)
 7ea:	f44e                	sd	s3,40(sp)
 7ec:	fb840713          	addi	a4,s0,-72
 7f0:	00f704b3          	add	s1,a4,a5
 7f4:	fff70993          	addi	s3,a4,-1
 7f8:	99be                	add	s3,s3,a5
 7fa:	37fd                	addiw	a5,a5,-1
 7fc:	1782                	slli	a5,a5,0x20
 7fe:	9381                	srli	a5,a5,0x20
 800:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 804:	fff4c583          	lbu	a1,-1(s1)
 808:	854a                	mv	a0,s2
 80a:	00000097          	auipc	ra,0x0
 80e:	f62080e7          	jalr	-158(ra) # 76c <putc>
  while(--i >= 0)
 812:	14fd                	addi	s1,s1,-1
 814:	ff3498e3          	bne	s1,s3,804 <printint+0x76>
 818:	74e2                	ld	s1,56(sp)
 81a:	79a2                	ld	s3,40(sp)
}
 81c:	60a6                	ld	ra,72(sp)
 81e:	6406                	ld	s0,64(sp)
 820:	7942                	ld	s2,48(sp)
 822:	6161                	addi	sp,sp,80
 824:	8082                	ret
    x = -xx;
 826:	40b005b3          	neg	a1,a1
    neg = 1;
 82a:	4885                	li	a7,1
    x = -xx;
 82c:	bf9d                	j	7a2 <printint+0x14>

000000000000082e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82e:	711d                	addi	sp,sp,-96
 830:	ec86                	sd	ra,88(sp)
 832:	e8a2                	sd	s0,80(sp)
 834:	e0ca                	sd	s2,64(sp)
 836:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 838:	0005c903          	lbu	s2,0(a1)
 83c:	2c090a63          	beqz	s2,b10 <vprintf+0x2e2>
 840:	e4a6                	sd	s1,72(sp)
 842:	fc4e                	sd	s3,56(sp)
 844:	f852                	sd	s4,48(sp)
 846:	f456                	sd	s5,40(sp)
 848:	f05a                	sd	s6,32(sp)
 84a:	ec5e                	sd	s7,24(sp)
 84c:	e862                	sd	s8,16(sp)
 84e:	e466                	sd	s9,8(sp)
 850:	8b2a                	mv	s6,a0
 852:	8a2e                	mv	s4,a1
 854:	8bb2                	mv	s7,a2
  state = 0;
 856:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 858:	4481                	li	s1,0
 85a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 85c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 860:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 864:	06c00c93          	li	s9,108
 868:	a015                	j	88c <vprintf+0x5e>
        putc(fd, c0);
 86a:	85ca                	mv	a1,s2
 86c:	855a                	mv	a0,s6
 86e:	00000097          	auipc	ra,0x0
 872:	efe080e7          	jalr	-258(ra) # 76c <putc>
 876:	a019                	j	87c <vprintf+0x4e>
    } else if(state == '%'){
 878:	03598263          	beq	s3,s5,89c <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 87c:	2485                	addiw	s1,s1,1
 87e:	8726                	mv	a4,s1
 880:	009a07b3          	add	a5,s4,s1
 884:	0007c903          	lbu	s2,0(a5)
 888:	26090c63          	beqz	s2,b00 <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 88c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 890:	fe0994e3          	bnez	s3,878 <vprintf+0x4a>
      if(c0 == '%'){
 894:	fd579be3          	bne	a5,s5,86a <vprintf+0x3c>
        state = '%';
 898:	89be                	mv	s3,a5
 89a:	b7cd                	j	87c <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 89c:	00ea06b3          	add	a3,s4,a4
 8a0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 8a4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 8a6:	c681                	beqz	a3,8ae <vprintf+0x80>
 8a8:	9752                	add	a4,a4,s4
 8aa:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 8ae:	05878563          	beq	a5,s8,8f8 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 8b2:	07978163          	beq	a5,s9,914 <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 8b6:	07500713          	li	a4,117
 8ba:	10e78563          	beq	a5,a4,9c4 <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 8be:	07800713          	li	a4,120
 8c2:	14e78d63          	beq	a5,a4,a1c <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 8c6:	07000713          	li	a4,112
 8ca:	18e78663          	beq	a5,a4,a56 <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 8ce:	06300713          	li	a4,99
 8d2:	1ce78c63          	beq	a5,a4,aaa <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 8d6:	07300713          	li	a4,115
 8da:	1ee78463          	beq	a5,a4,ac2 <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 8de:	02500713          	li	a4,37
 8e2:	04e79963          	bne	a5,a4,934 <vprintf+0x106>
        putc(fd, '%');
 8e6:	02500593          	li	a1,37
 8ea:	855a                	mv	a0,s6
 8ec:	00000097          	auipc	ra,0x0
 8f0:	e80080e7          	jalr	-384(ra) # 76c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	b759                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 8f8:	008b8913          	addi	s2,s7,8
 8fc:	4685                	li	a3,1
 8fe:	4629                	li	a2,10
 900:	000ba583          	lw	a1,0(s7)
 904:	855a                	mv	a0,s6
 906:	00000097          	auipc	ra,0x0
 90a:	e88080e7          	jalr	-376(ra) # 78e <printint>
 90e:	8bca                	mv	s7,s2
      state = 0;
 910:	4981                	li	s3,0
 912:	b7ad                	j	87c <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 914:	06400793          	li	a5,100
 918:	02f68d63          	beq	a3,a5,952 <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 91c:	06c00793          	li	a5,108
 920:	04f68863          	beq	a3,a5,970 <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 924:	07500793          	li	a5,117
 928:	0af68c63          	beq	a3,a5,9e0 <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 92c:	07800793          	li	a5,120
 930:	10f68463          	beq	a3,a5,a38 <vprintf+0x20a>
        putc(fd, '%');
 934:	02500593          	li	a1,37
 938:	855a                	mv	a0,s6
 93a:	00000097          	auipc	ra,0x0
 93e:	e32080e7          	jalr	-462(ra) # 76c <putc>
        putc(fd, c0);
 942:	85ca                	mv	a1,s2
 944:	855a                	mv	a0,s6
 946:	00000097          	auipc	ra,0x0
 94a:	e26080e7          	jalr	-474(ra) # 76c <putc>
      state = 0;
 94e:	4981                	li	s3,0
 950:	b735                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 952:	008b8913          	addi	s2,s7,8
 956:	4685                	li	a3,1
 958:	4629                	li	a2,10
 95a:	000bb583          	ld	a1,0(s7)
 95e:	855a                	mv	a0,s6
 960:	00000097          	auipc	ra,0x0
 964:	e2e080e7          	jalr	-466(ra) # 78e <printint>
        i += 1;
 968:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 96a:	8bca                	mv	s7,s2
      state = 0;
 96c:	4981                	li	s3,0
        i += 1;
 96e:	b739                	j	87c <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 970:	06400793          	li	a5,100
 974:	02f60963          	beq	a2,a5,9a6 <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 978:	07500793          	li	a5,117
 97c:	08f60163          	beq	a2,a5,9fe <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 980:	07800793          	li	a5,120
 984:	faf618e3          	bne	a2,a5,934 <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 988:	008b8913          	addi	s2,s7,8
 98c:	4681                	li	a3,0
 98e:	4641                	li	a2,16
 990:	000bb583          	ld	a1,0(s7)
 994:	855a                	mv	a0,s6
 996:	00000097          	auipc	ra,0x0
 99a:	df8080e7          	jalr	-520(ra) # 78e <printint>
        i += 2;
 99e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 9a0:	8bca                	mv	s7,s2
      state = 0;
 9a2:	4981                	li	s3,0
        i += 2;
 9a4:	bde1                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 9a6:	008b8913          	addi	s2,s7,8
 9aa:	4685                	li	a3,1
 9ac:	4629                	li	a2,10
 9ae:	000bb583          	ld	a1,0(s7)
 9b2:	855a                	mv	a0,s6
 9b4:	00000097          	auipc	ra,0x0
 9b8:	dda080e7          	jalr	-550(ra) # 78e <printint>
        i += 2;
 9bc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 9be:	8bca                	mv	s7,s2
      state = 0;
 9c0:	4981                	li	s3,0
        i += 2;
 9c2:	bd6d                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 9c4:	008b8913          	addi	s2,s7,8
 9c8:	4681                	li	a3,0
 9ca:	4629                	li	a2,10
 9cc:	000be583          	lwu	a1,0(s7)
 9d0:	855a                	mv	a0,s6
 9d2:	00000097          	auipc	ra,0x0
 9d6:	dbc080e7          	jalr	-580(ra) # 78e <printint>
 9da:	8bca                	mv	s7,s2
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	bd79                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9e0:	008b8913          	addi	s2,s7,8
 9e4:	4681                	li	a3,0
 9e6:	4629                	li	a2,10
 9e8:	000bb583          	ld	a1,0(s7)
 9ec:	855a                	mv	a0,s6
 9ee:	00000097          	auipc	ra,0x0
 9f2:	da0080e7          	jalr	-608(ra) # 78e <printint>
        i += 1;
 9f6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 9f8:	8bca                	mv	s7,s2
      state = 0;
 9fa:	4981                	li	s3,0
        i += 1;
 9fc:	b541                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9fe:	008b8913          	addi	s2,s7,8
 a02:	4681                	li	a3,0
 a04:	4629                	li	a2,10
 a06:	000bb583          	ld	a1,0(s7)
 a0a:	855a                	mv	a0,s6
 a0c:	00000097          	auipc	ra,0x0
 a10:	d82080e7          	jalr	-638(ra) # 78e <printint>
        i += 2;
 a14:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 a16:	8bca                	mv	s7,s2
      state = 0;
 a18:	4981                	li	s3,0
        i += 2;
 a1a:	b58d                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 a1c:	008b8913          	addi	s2,s7,8
 a20:	4681                	li	a3,0
 a22:	4641                	li	a2,16
 a24:	000be583          	lwu	a1,0(s7)
 a28:	855a                	mv	a0,s6
 a2a:	00000097          	auipc	ra,0x0
 a2e:	d64080e7          	jalr	-668(ra) # 78e <printint>
 a32:	8bca                	mv	s7,s2
      state = 0;
 a34:	4981                	li	s3,0
 a36:	b599                	j	87c <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 a38:	008b8913          	addi	s2,s7,8
 a3c:	4681                	li	a3,0
 a3e:	4641                	li	a2,16
 a40:	000bb583          	ld	a1,0(s7)
 a44:	855a                	mv	a0,s6
 a46:	00000097          	auipc	ra,0x0
 a4a:	d48080e7          	jalr	-696(ra) # 78e <printint>
        i += 1;
 a4e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 a50:	8bca                	mv	s7,s2
      state = 0;
 a52:	4981                	li	s3,0
        i += 1;
 a54:	b525                	j	87c <vprintf+0x4e>
 a56:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 a58:	008b8d13          	addi	s10,s7,8
 a5c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 a60:	03000593          	li	a1,48
 a64:	855a                	mv	a0,s6
 a66:	00000097          	auipc	ra,0x0
 a6a:	d06080e7          	jalr	-762(ra) # 76c <putc>
  putc(fd, 'x');
 a6e:	07800593          	li	a1,120
 a72:	855a                	mv	a0,s6
 a74:	00000097          	auipc	ra,0x0
 a78:	cf8080e7          	jalr	-776(ra) # 76c <putc>
 a7c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a7e:	00000b97          	auipc	s7,0x0
 a82:	4d2b8b93          	addi	s7,s7,1234 # f50 <digits>
 a86:	03c9d793          	srli	a5,s3,0x3c
 a8a:	97de                	add	a5,a5,s7
 a8c:	0007c583          	lbu	a1,0(a5)
 a90:	855a                	mv	a0,s6
 a92:	00000097          	auipc	ra,0x0
 a96:	cda080e7          	jalr	-806(ra) # 76c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a9a:	0992                	slli	s3,s3,0x4
 a9c:	397d                	addiw	s2,s2,-1
 a9e:	fe0914e3          	bnez	s2,a86 <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 aa2:	8bea                	mv	s7,s10
      state = 0;
 aa4:	4981                	li	s3,0
 aa6:	6d02                	ld	s10,0(sp)
 aa8:	bbd1                	j	87c <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 aaa:	008b8913          	addi	s2,s7,8
 aae:	000bc583          	lbu	a1,0(s7)
 ab2:	855a                	mv	a0,s6
 ab4:	00000097          	auipc	ra,0x0
 ab8:	cb8080e7          	jalr	-840(ra) # 76c <putc>
 abc:	8bca                	mv	s7,s2
      state = 0;
 abe:	4981                	li	s3,0
 ac0:	bb75                	j	87c <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 ac2:	008b8993          	addi	s3,s7,8
 ac6:	000bb903          	ld	s2,0(s7)
 aca:	02090163          	beqz	s2,aec <vprintf+0x2be>
        for(; *s; s++)
 ace:	00094583          	lbu	a1,0(s2)
 ad2:	c585                	beqz	a1,afa <vprintf+0x2cc>
          putc(fd, *s);
 ad4:	855a                	mv	a0,s6
 ad6:	00000097          	auipc	ra,0x0
 ada:	c96080e7          	jalr	-874(ra) # 76c <putc>
        for(; *s; s++)
 ade:	0905                	addi	s2,s2,1
 ae0:	00094583          	lbu	a1,0(s2)
 ae4:	f9e5                	bnez	a1,ad4 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 ae6:	8bce                	mv	s7,s3
      state = 0;
 ae8:	4981                	li	s3,0
 aea:	bb49                	j	87c <vprintf+0x4e>
          s = "(null)";
 aec:	00000917          	auipc	s2,0x0
 af0:	45c90913          	addi	s2,s2,1116 # f48 <malloc+0x348>
        for(; *s; s++)
 af4:	02800593          	li	a1,40
 af8:	bff1                	j	ad4 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 afa:	8bce                	mv	s7,s3
      state = 0;
 afc:	4981                	li	s3,0
 afe:	bbbd                	j	87c <vprintf+0x4e>
 b00:	64a6                	ld	s1,72(sp)
 b02:	79e2                	ld	s3,56(sp)
 b04:	7a42                	ld	s4,48(sp)
 b06:	7aa2                	ld	s5,40(sp)
 b08:	7b02                	ld	s6,32(sp)
 b0a:	6be2                	ld	s7,24(sp)
 b0c:	6c42                	ld	s8,16(sp)
 b0e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 b10:	60e6                	ld	ra,88(sp)
 b12:	6446                	ld	s0,80(sp)
 b14:	6906                	ld	s2,64(sp)
 b16:	6125                	addi	sp,sp,96
 b18:	8082                	ret

0000000000000b1a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 b1a:	715d                	addi	sp,sp,-80
 b1c:	ec06                	sd	ra,24(sp)
 b1e:	e822                	sd	s0,16(sp)
 b20:	1000                	addi	s0,sp,32
 b22:	e010                	sd	a2,0(s0)
 b24:	e414                	sd	a3,8(s0)
 b26:	e818                	sd	a4,16(s0)
 b28:	ec1c                	sd	a5,24(s0)
 b2a:	03043023          	sd	a6,32(s0)
 b2e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 b32:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 b36:	8622                	mv	a2,s0
 b38:	00000097          	auipc	ra,0x0
 b3c:	cf6080e7          	jalr	-778(ra) # 82e <vprintf>
}
 b40:	60e2                	ld	ra,24(sp)
 b42:	6442                	ld	s0,16(sp)
 b44:	6161                	addi	sp,sp,80
 b46:	8082                	ret

0000000000000b48 <printf>:

void
printf(const char *fmt, ...)
{
 b48:	711d                	addi	sp,sp,-96
 b4a:	ec06                	sd	ra,24(sp)
 b4c:	e822                	sd	s0,16(sp)
 b4e:	1000                	addi	s0,sp,32
 b50:	e40c                	sd	a1,8(s0)
 b52:	e810                	sd	a2,16(s0)
 b54:	ec14                	sd	a3,24(s0)
 b56:	f018                	sd	a4,32(s0)
 b58:	f41c                	sd	a5,40(s0)
 b5a:	03043823          	sd	a6,48(s0)
 b5e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b62:	00840613          	addi	a2,s0,8
 b66:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b6a:	85aa                	mv	a1,a0
 b6c:	4505                	li	a0,1
 b6e:	00000097          	auipc	ra,0x0
 b72:	cc0080e7          	jalr	-832(ra) # 82e <vprintf>
}
 b76:	60e2                	ld	ra,24(sp)
 b78:	6442                	ld	s0,16(sp)
 b7a:	6125                	addi	sp,sp,96
 b7c:	8082                	ret

0000000000000b7e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b7e:	1141                	addi	sp,sp,-16
 b80:	e422                	sd	s0,8(sp)
 b82:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b84:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b88:	00000797          	auipc	a5,0x0
 b8c:	4787b783          	ld	a5,1144(a5) # 1000 <freep>
 b90:	a02d                	j	bba <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b92:	4618                	lw	a4,8(a2)
 b94:	9f2d                	addw	a4,a4,a1
 b96:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b9a:	6398                	ld	a4,0(a5)
 b9c:	6310                	ld	a2,0(a4)
 b9e:	a83d                	j	bdc <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ba0:	ff852703          	lw	a4,-8(a0)
 ba4:	9f31                	addw	a4,a4,a2
 ba6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 ba8:	ff053683          	ld	a3,-16(a0)
 bac:	a091                	j	bf0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bae:	6398                	ld	a4,0(a5)
 bb0:	00e7e463          	bltu	a5,a4,bb8 <free+0x3a>
 bb4:	00e6ea63          	bltu	a3,a4,bc8 <free+0x4a>
{
 bb8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bba:	fed7fae3          	bgeu	a5,a3,bae <free+0x30>
 bbe:	6398                	ld	a4,0(a5)
 bc0:	00e6e463          	bltu	a3,a4,bc8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bc4:	fee7eae3          	bltu	a5,a4,bb8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 bc8:	ff852583          	lw	a1,-8(a0)
 bcc:	6390                	ld	a2,0(a5)
 bce:	02059813          	slli	a6,a1,0x20
 bd2:	01c85713          	srli	a4,a6,0x1c
 bd6:	9736                	add	a4,a4,a3
 bd8:	fae60de3          	beq	a2,a4,b92 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 bdc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 be0:	4790                	lw	a2,8(a5)
 be2:	02061593          	slli	a1,a2,0x20
 be6:	01c5d713          	srli	a4,a1,0x1c
 bea:	973e                	add	a4,a4,a5
 bec:	fae68ae3          	beq	a3,a4,ba0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 bf0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 bf2:	00000717          	auipc	a4,0x0
 bf6:	40f73723          	sd	a5,1038(a4) # 1000 <freep>
}
 bfa:	6422                	ld	s0,8(sp)
 bfc:	0141                	addi	sp,sp,16
 bfe:	8082                	ret

0000000000000c00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c00:	7139                	addi	sp,sp,-64
 c02:	fc06                	sd	ra,56(sp)
 c04:	f822                	sd	s0,48(sp)
 c06:	f426                	sd	s1,40(sp)
 c08:	ec4e                	sd	s3,24(sp)
 c0a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c0c:	02051493          	slli	s1,a0,0x20
 c10:	9081                	srli	s1,s1,0x20
 c12:	04bd                	addi	s1,s1,15
 c14:	8091                	srli	s1,s1,0x4
 c16:	0014899b          	addiw	s3,s1,1
 c1a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 c1c:	00000517          	auipc	a0,0x0
 c20:	3e453503          	ld	a0,996(a0) # 1000 <freep>
 c24:	c915                	beqz	a0,c58 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c26:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c28:	4798                	lw	a4,8(a5)
 c2a:	08977e63          	bgeu	a4,s1,cc6 <malloc+0xc6>
 c2e:	f04a                	sd	s2,32(sp)
 c30:	e852                	sd	s4,16(sp)
 c32:	e456                	sd	s5,8(sp)
 c34:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 c36:	8a4e                	mv	s4,s3
 c38:	0009871b          	sext.w	a4,s3
 c3c:	6685                	lui	a3,0x1
 c3e:	00d77363          	bgeu	a4,a3,c44 <malloc+0x44>
 c42:	6a05                	lui	s4,0x1
 c44:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c48:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c4c:	00000917          	auipc	s2,0x0
 c50:	3b490913          	addi	s2,s2,948 # 1000 <freep>
  if(p == SBRK_ERROR)
 c54:	5afd                	li	s5,-1
 c56:	a091                	j	c9a <malloc+0x9a>
 c58:	f04a                	sd	s2,32(sp)
 c5a:	e852                	sd	s4,16(sp)
 c5c:	e456                	sd	s5,8(sp)
 c5e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 c60:	00000797          	auipc	a5,0x0
 c64:	3b078793          	addi	a5,a5,944 # 1010 <base>
 c68:	00000717          	auipc	a4,0x0
 c6c:	38f73c23          	sd	a5,920(a4) # 1000 <freep>
 c70:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c72:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c76:	b7c1                	j	c36 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 c78:	6398                	ld	a4,0(a5)
 c7a:	e118                	sd	a4,0(a0)
 c7c:	a08d                	j	cde <malloc+0xde>
  hp->s.size = nu;
 c7e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c82:	0541                	addi	a0,a0,16
 c84:	00000097          	auipc	ra,0x0
 c88:	efa080e7          	jalr	-262(ra) # b7e <free>
  return freep;
 c8c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c90:	c13d                	beqz	a0,cf6 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c92:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c94:	4798                	lw	a4,8(a5)
 c96:	02977463          	bgeu	a4,s1,cbe <malloc+0xbe>
    if(p == freep)
 c9a:	00093703          	ld	a4,0(s2)
 c9e:	853e                	mv	a0,a5
 ca0:	fef719e3          	bne	a4,a5,c92 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 ca4:	8552                	mv	a0,s4
 ca6:	00000097          	auipc	ra,0x0
 caa:	972080e7          	jalr	-1678(ra) # 618 <sbrk>
  if(p == SBRK_ERROR)
 cae:	fd5518e3          	bne	a0,s5,c7e <malloc+0x7e>
        return 0;
 cb2:	4501                	li	a0,0
 cb4:	7902                	ld	s2,32(sp)
 cb6:	6a42                	ld	s4,16(sp)
 cb8:	6aa2                	ld	s5,8(sp)
 cba:	6b02                	ld	s6,0(sp)
 cbc:	a03d                	j	cea <malloc+0xea>
 cbe:	7902                	ld	s2,32(sp)
 cc0:	6a42                	ld	s4,16(sp)
 cc2:	6aa2                	ld	s5,8(sp)
 cc4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 cc6:	fae489e3          	beq	s1,a4,c78 <malloc+0x78>
        p->s.size -= nunits;
 cca:	4137073b          	subw	a4,a4,s3
 cce:	c798                	sw	a4,8(a5)
        p += p->s.size;
 cd0:	02071693          	slli	a3,a4,0x20
 cd4:	01c6d713          	srli	a4,a3,0x1c
 cd8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 cda:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 cde:	00000717          	auipc	a4,0x0
 ce2:	32a73123          	sd	a0,802(a4) # 1000 <freep>
      return (void*)(p + 1);
 ce6:	01078513          	addi	a0,a5,16
  }
}
 cea:	70e2                	ld	ra,56(sp)
 cec:	7442                	ld	s0,48(sp)
 cee:	74a2                	ld	s1,40(sp)
 cf0:	69e2                	ld	s3,24(sp)
 cf2:	6121                	addi	sp,sp,64
 cf4:	8082                	ret
 cf6:	7902                	ld	s2,32(sp)
 cf8:	6a42                	ld	s4,16(sp)
 cfa:	6aa2                	ld	s5,8(sp)
 cfc:	6b02                	ld	s6,0(sp)
 cfe:	b7f5                	j	cea <malloc+0xea>
