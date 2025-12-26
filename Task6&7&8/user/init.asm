
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "shell", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  
  // 1. 初始化文件描述符：确保 0, 1, 2 都指向控制台
  // 尝试打开控制台设备
  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	a1250513          	addi	a0,a0,-1518 # a20 <malloc+0x10a>
  16:	00000097          	auipc	ra,0x0
  1a:	414080e7          	jalr	1044(ra) # 42a <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    open("console", O_RDWR); // 此时 fd = 0 (stdin)
    
  }
  
  // 复制 fd 0 到 fd 1 (stdout)
  duplicate(0); 
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	436080e7          	jalr	1078(ra) # 45a <duplicate>
  // 复制 fd 0 到 fd 2 (stderr)
  duplicate(0);
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	42c080e7          	jalr	1068(ra) # 45a <duplicate>

  

  // 2. 进入死循环：负责启动 Shell 并监控它
  for(;;){
    printf("init: starting shell\n");
  36:	00001917          	auipc	s2,0x1
  3a:	9f290913          	addi	s2,s2,-1550 # a28 <malloc+0x112>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	81e080e7          	jalr	-2018(ra) # 85e <printf>
    
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	3ba080e7          	jalr	954(ra) # 402 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    // --- 父进程 (init) 逻辑 ---
    // 等待子进程退出。
    // 注意：init 还有一个职责是回收所有"孤儿进程"（父进程先退出的进程）。
    for(;;){
      // wait 返回退出的子进程 PID
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	3b8080e7          	jalr	952(ra) # 412 <wait>
      
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // 如果退出的正是我们启动的 shell，
        // 那么跳出内层循环，回到外层循环重新启动一个新的 shell
        break; 
      }
      
      if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	a1e50513          	addi	a0,a0,-1506 # a88 <malloc+0x172>
  72:	00000097          	auipc	ra,0x0
  76:	7ec080e7          	jalr	2028(ra) # 85e <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	38e080e7          	jalr	910(ra) # 40a <exit>
    makenode("console", 1, 1);
  84:	4605                	li	a2,1
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	99850513          	addi	a0,a0,-1640 # a20 <malloc+0x10a>
  90:	00000097          	auipc	ra,0x0
  94:	3c2080e7          	jalr	962(ra) # 452 <makenode>
    open("console", O_RDWR); // 此时 fd = 0 (stdin)
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	98650513          	addi	a0,a0,-1658 # a20 <malloc+0x10a>
  a2:	00000097          	auipc	ra,0x0
  a6:	388080e7          	jalr	904(ra) # 42a <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	99c50513          	addi	a0,a0,-1636 # a48 <malloc+0x132>
  b4:	00000097          	auipc	ra,0x0
  b8:	7aa080e7          	jalr	1962(ra) # 85e <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	34c080e7          	jalr	844(ra) # 40a <exit>
      exec("shell", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	addi	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	99250513          	addi	a0,a0,-1646 # a60 <malloc+0x14a>
  d6:	00000097          	auipc	ra,0x0
  da:	35c080e7          	jalr	860(ra) # 432 <exec>
      printf("init: exec shell failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	98a50513          	addi	a0,a0,-1654 # a68 <malloc+0x152>
  e6:	00000097          	auipc	ra,0x0
  ea:	778080e7          	jalr	1912(ra) # 85e <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	31a080e7          	jalr	794(ra) # 40a <exit>

00000000000000f8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <main>
  exit(r);
 108:	00000097          	auipc	ra,0x0
 10c:	302080e7          	jalr	770(ra) # 40a <exit>

0000000000000110 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 110:	1141                	addi	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 116:	87aa                	mv	a5,a0
 118:	0585                	addi	a1,a1,1
 11a:	0785                	addi	a5,a5,1
 11c:	fff5c703          	lbu	a4,-1(a1)
 120:	fee78fa3          	sb	a4,-1(a5)
 124:	fb75                	bnez	a4,118 <strcpy+0x8>
    ;
  return os;
}
 126:	6422                	ld	s0,8(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 12c:	1141                	addi	sp,sp,-16
 12e:	e422                	sd	s0,8(sp)
 130:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 132:	00054783          	lbu	a5,0(a0)
 136:	cb91                	beqz	a5,14a <strcmp+0x1e>
 138:	0005c703          	lbu	a4,0(a1)
 13c:	00f71763          	bne	a4,a5,14a <strcmp+0x1e>
    p++, q++;
 140:	0505                	addi	a0,a0,1
 142:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	fbe5                	bnez	a5,138 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14a:	0005c503          	lbu	a0,0(a1)
}
 14e:	40a7853b          	subw	a0,a5,a0
 152:	6422                	ld	s0,8(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen(const char *s)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 15e:	00054783          	lbu	a5,0(a0)
 162:	cf91                	beqz	a5,17e <strlen+0x26>
 164:	0505                	addi	a0,a0,1
 166:	87aa                	mv	a5,a0
 168:	86be                	mv	a3,a5
 16a:	0785                	addi	a5,a5,1
 16c:	fff7c703          	lbu	a4,-1(a5)
 170:	ff65                	bnez	a4,168 <strlen+0x10>
 172:	40a6853b          	subw	a0,a3,a0
 176:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 178:	6422                	ld	s0,8(sp)
 17a:	0141                	addi	sp,sp,16
 17c:	8082                	ret
  for(n = 0; s[n]; n++)
 17e:	4501                	li	a0,0
 180:	bfe5                	j	178 <strlen+0x20>

0000000000000182 <memset>:

void*
memset(void *dst, int c, uint n)
{
 182:	1141                	addi	sp,sp,-16
 184:	e422                	sd	s0,8(sp)
 186:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 188:	ca19                	beqz	a2,19e <memset+0x1c>
 18a:	87aa                	mv	a5,a0
 18c:	1602                	slli	a2,a2,0x20
 18e:	9201                	srli	a2,a2,0x20
 190:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 194:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 198:	0785                	addi	a5,a5,1
 19a:	fee79de3          	bne	a5,a4,194 <memset+0x12>
  }
  return dst;
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret

00000000000001a4 <strchr>:

char*
strchr(const char *s, char c)
{
 1a4:	1141                	addi	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1aa:	00054783          	lbu	a5,0(a0)
 1ae:	cb99                	beqz	a5,1c4 <strchr+0x20>
    if(*s == c)
 1b0:	00f58763          	beq	a1,a5,1be <strchr+0x1a>
  for(; *s; s++)
 1b4:	0505                	addi	a0,a0,1
 1b6:	00054783          	lbu	a5,0(a0)
 1ba:	fbfd                	bnez	a5,1b0 <strchr+0xc>
      return (char*)s;
  return 0;
 1bc:	4501                	li	a0,0
}
 1be:	6422                	ld	s0,8(sp)
 1c0:	0141                	addi	sp,sp,16
 1c2:	8082                	ret
  return 0;
 1c4:	4501                	li	a0,0
 1c6:	bfe5                	j	1be <strchr+0x1a>

00000000000001c8 <gets>:

char*
gets(char *buf, int max)
{
 1c8:	711d                	addi	sp,sp,-96
 1ca:	ec86                	sd	ra,88(sp)
 1cc:	e8a2                	sd	s0,80(sp)
 1ce:	e4a6                	sd	s1,72(sp)
 1d0:	e0ca                	sd	s2,64(sp)
 1d2:	fc4e                	sd	s3,56(sp)
 1d4:	f852                	sd	s4,48(sp)
 1d6:	f456                	sd	s5,40(sp)
 1d8:	f05a                	sd	s6,32(sp)
 1da:	ec5e                	sd	s7,24(sp)
 1dc:	1080                	addi	s0,sp,96
 1de:	8baa                	mv	s7,a0
 1e0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e2:	892a                	mv	s2,a0
 1e4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1e6:	4aa9                	li	s5,10
 1e8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ea:	89a6                	mv	s3,s1
 1ec:	2485                	addiw	s1,s1,1
 1ee:	0344d863          	bge	s1,s4,21e <gets+0x56>
    cc = read(0, &c, 1);
 1f2:	4605                	li	a2,1
 1f4:	faf40593          	addi	a1,s0,-81
 1f8:	4501                	li	a0,0
 1fa:	00000097          	auipc	ra,0x0
 1fe:	240080e7          	jalr	576(ra) # 43a <read>
    if(cc < 1)
 202:	00a05e63          	blez	a0,21e <gets+0x56>
    buf[i++] = c;
 206:	faf44783          	lbu	a5,-81(s0)
 20a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 20e:	01578763          	beq	a5,s5,21c <gets+0x54>
 212:	0905                	addi	s2,s2,1
 214:	fd679be3          	bne	a5,s6,1ea <gets+0x22>
    buf[i++] = c;
 218:	89a6                	mv	s3,s1
 21a:	a011                	j	21e <gets+0x56>
 21c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 21e:	99de                	add	s3,s3,s7
 220:	00098023          	sb	zero,0(s3)
  return buf;
}
 224:	855e                	mv	a0,s7
 226:	60e6                	ld	ra,88(sp)
 228:	6446                	ld	s0,80(sp)
 22a:	64a6                	ld	s1,72(sp)
 22c:	6906                	ld	s2,64(sp)
 22e:	79e2                	ld	s3,56(sp)
 230:	7a42                	ld	s4,48(sp)
 232:	7aa2                	ld	s5,40(sp)
 234:	7b02                	ld	s6,32(sp)
 236:	6be2                	ld	s7,24(sp)
 238:	6125                	addi	sp,sp,96
 23a:	8082                	ret

000000000000023c <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 242:	00054683          	lbu	a3,0(a0)
 246:	fd06879b          	addiw	a5,a3,-48
 24a:	0ff7f793          	zext.b	a5,a5
 24e:	4625                	li	a2,9
 250:	02f66863          	bltu	a2,a5,280 <atoi+0x44>
 254:	872a                	mv	a4,a0
  n = 0;
 256:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 258:	0705                	addi	a4,a4,1
 25a:	0025179b          	slliw	a5,a0,0x2
 25e:	9fa9                	addw	a5,a5,a0
 260:	0017979b          	slliw	a5,a5,0x1
 264:	9fb5                	addw	a5,a5,a3
 266:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 26a:	00074683          	lbu	a3,0(a4)
 26e:	fd06879b          	addiw	a5,a3,-48
 272:	0ff7f793          	zext.b	a5,a5
 276:	fef671e3          	bgeu	a2,a5,258 <atoi+0x1c>
  return n;
}
 27a:	6422                	ld	s0,8(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
  n = 0;
 280:	4501                	li	a0,0
 282:	bfe5                	j	27a <atoi+0x3e>

0000000000000284 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 284:	1141                	addi	sp,sp,-16
 286:	e422                	sd	s0,8(sp)
 288:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 28a:	02b57463          	bgeu	a0,a1,2b2 <memmove+0x2e>
    while(n-- > 0)
 28e:	00c05f63          	blez	a2,2ac <memmove+0x28>
 292:	1602                	slli	a2,a2,0x20
 294:	9201                	srli	a2,a2,0x20
 296:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 29a:	872a                	mv	a4,a0
      *dst++ = *src++;
 29c:	0585                	addi	a1,a1,1
 29e:	0705                	addi	a4,a4,1
 2a0:	fff5c683          	lbu	a3,-1(a1)
 2a4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a8:	fef71ae3          	bne	a4,a5,29c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ac:	6422                	ld	s0,8(sp)
 2ae:	0141                	addi	sp,sp,16
 2b0:	8082                	ret
    dst += n;
 2b2:	00c50733          	add	a4,a0,a2
    src += n;
 2b6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b8:	fec05ae3          	blez	a2,2ac <memmove+0x28>
 2bc:	fff6079b          	addiw	a5,a2,-1
 2c0:	1782                	slli	a5,a5,0x20
 2c2:	9381                	srli	a5,a5,0x20
 2c4:	fff7c793          	not	a5,a5
 2c8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ca:	15fd                	addi	a1,a1,-1
 2cc:	177d                	addi	a4,a4,-1
 2ce:	0005c683          	lbu	a3,0(a1)
 2d2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d6:	fee79ae3          	bne	a5,a4,2ca <memmove+0x46>
 2da:	bfc9                	j	2ac <memmove+0x28>

00000000000002dc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2e2:	ca05                	beqz	a2,312 <memcmp+0x36>
 2e4:	fff6069b          	addiw	a3,a2,-1
 2e8:	1682                	slli	a3,a3,0x20
 2ea:	9281                	srli	a3,a3,0x20
 2ec:	0685                	addi	a3,a3,1
 2ee:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2f0:	00054783          	lbu	a5,0(a0)
 2f4:	0005c703          	lbu	a4,0(a1)
 2f8:	00e79863          	bne	a5,a4,308 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2fc:	0505                	addi	a0,a0,1
    p2++;
 2fe:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 300:	fed518e3          	bne	a0,a3,2f0 <memcmp+0x14>
  }
  return 0;
 304:	4501                	li	a0,0
 306:	a019                	j	30c <memcmp+0x30>
      return *p1 - *p2;
 308:	40e7853b          	subw	a0,a5,a4
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret
  return 0;
 312:	4501                	li	a0,0
 314:	bfe5                	j	30c <memcmp+0x30>

0000000000000316 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 316:	1141                	addi	sp,sp,-16
 318:	e406                	sd	ra,8(sp)
 31a:	e022                	sd	s0,0(sp)
 31c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 31e:	00000097          	auipc	ra,0x0
 322:	f66080e7          	jalr	-154(ra) # 284 <memmove>
}
 326:	60a2                	ld	ra,8(sp)
 328:	6402                	ld	s0,0(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret

000000000000032e <sbrk>:

char *
sbrk(int n) {
 32e:	1141                	addi	sp,sp,-16
 330:	e406                	sd	ra,8(sp)
 332:	e022                	sd	s0,0(sp)
 334:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 336:	4585                	li	a1,1
 338:	00000097          	auipc	ra,0x0
 33c:	12a080e7          	jalr	298(ra) # 462 <sys_sbrk>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <get_time>:
//   return sys_sbrk(n, SBRK_LAZY);
// }


unsigned int 
get_time(void) {
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
    return uptime();
 350:	00000097          	auipc	ra,0x0
 354:	11a080e7          	jalr	282(ra) # 46a <uptime>
}
 358:	2501                	sext.w	a0,a0
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <make_filename>:
void 
make_filename(char *buf, const char *prefix, int num) {
    // 复制前缀
    char *p = buf;
    const char *s = prefix;
    while(*s) *p++ = *s++;
 362:	0005c783          	lbu	a5,0(a1)
 366:	cb81                	beqz	a5,376 <make_filename+0x14>
 368:	0585                	addi	a1,a1,1
 36a:	0505                	addi	a0,a0,1
 36c:	fef50fa3          	sb	a5,-1(a0)
 370:	0005c783          	lbu	a5,0(a1)
 374:	fbf5                	bnez	a5,368 <make_filename+0x6>
    
    // 处理数字部分
    if (num == 0) {
 376:	ca3d                	beqz	a2,3ec <make_filename+0x8a>
make_filename(char *buf, const char *prefix, int num) {
 378:	1101                	addi	sp,sp,-32
 37a:	ec22                	sd	s0,24(sp)
 37c:	1000                	addi	s0,sp,32
        *p++ = '0';
    } else {
        // 临时缓冲区存放数字
        char digits[16];
        int i = 0;
        while(num > 0) {
 37e:	fe040893          	addi	a7,s0,-32
 382:	87c6                	mv	a5,a7
            digits[i++] = (num % 10) + '0';
 384:	46a9                	li	a3,10
        while(num > 0) {
 386:	4825                	li	a6,9
 388:	06c05063          	blez	a2,3e8 <make_filename+0x86>
            digits[i++] = (num % 10) + '0';
 38c:	02d6673b          	remw	a4,a2,a3
 390:	0307071b          	addiw	a4,a4,48
 394:	00e78023          	sb	a4,0(a5)
            num /= 10;
 398:	85b2                	mv	a1,a2
 39a:	02d6463b          	divw	a2,a2,a3
        while(num > 0) {
 39e:	873e                	mv	a4,a5
 3a0:	0785                	addi	a5,a5,1
 3a2:	feb845e3          	blt	a6,a1,38c <make_filename+0x2a>
 3a6:	4117073b          	subw	a4,a4,a7
 3aa:	0017069b          	addiw	a3,a4,1
            digits[i++] = (num % 10) + '0';
 3ae:	0006879b          	sext.w	a5,a3
        }
        // 倒序写入
        while(i > 0) *p++ = digits[--i];
 3b2:	04f05663          	blez	a5,3fe <make_filename+0x9c>
 3b6:	fe040713          	addi	a4,s0,-32
 3ba:	973e                	add	a4,a4,a5
 3bc:	02069593          	slli	a1,a3,0x20
 3c0:	9181                	srli	a1,a1,0x20
 3c2:	95aa                	add	a1,a1,a0
 3c4:	87aa                	mv	a5,a0
 3c6:	0785                	addi	a5,a5,1
 3c8:	fff74603          	lbu	a2,-1(a4)
 3cc:	fec78fa3          	sb	a2,-1(a5)
 3d0:	177d                	addi	a4,a4,-1
 3d2:	feb79ae3          	bne	a5,a1,3c6 <make_filename+0x64>
 3d6:	02069793          	slli	a5,a3,0x20
 3da:	9381                	srli	a5,a5,0x20
 3dc:	97aa                	add	a5,a5,a0
    }
    *p = 0; // 字符串结束符
 3de:	00078023          	sb	zero,0(a5)
 3e2:	6462                	ld	s0,24(sp)
 3e4:	6105                	addi	sp,sp,32
 3e6:	8082                	ret
        while(num > 0) {
 3e8:	87aa                	mv	a5,a0
 3ea:	bfd5                	j	3de <make_filename+0x7c>
        *p++ = '0';
 3ec:	00150793          	addi	a5,a0,1
 3f0:	03000713          	li	a4,48
 3f4:	00e50023          	sb	a4,0(a0)
    *p = 0; // 字符串结束符
 3f8:	00078023          	sb	zero,0(a5)
 3fc:	8082                	ret
        while(i > 0) *p++ = digits[--i];
 3fe:	87aa                	mv	a5,a0
 400:	bff9                	j	3de <make_filename+0x7c>

0000000000000402 <fork>:
.globl unlink
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 402:	4885                	li	a7,1
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <exit>:
.global exit
exit:
 li a7, SYS_exit
 40a:	4889                	li	a7,2
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <wait>:
.global wait
wait:
 li a7, SYS_wait
 412:	488d                	li	a7,3
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 41a:	4891                	li	a7,4
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <close>:
.global close
close:
 li a7, SYS_close
 422:	4899                	li	a7,6
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <open>:
.global open
open:
 li a7, SYS_open
 42a:	489d                	li	a7,7
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <exec>:
.global exec
exec:
 li a7, SYS_exec
 432:	4895                	li	a7,5
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <read>:
.global read
read:
 li a7, SYS_read
 43a:	48a1                	li	a7,8
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <write>:
.global write
write:
 li a7, SYS_write
 442:	48a5                	li	a7,9
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 44a:	48a9                	li	a7,10
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 452:	48ad                	li	a7,11
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 45a:	48b1                	li	a7,12
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 462:	48b5                	li	a7,13
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 46a:	48b9                	li	a7,14
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 472:	48bd                	li	a7,15
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 47a:	48c1                	li	a7,16
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 482:	1101                	addi	sp,sp,-32
 484:	ec06                	sd	ra,24(sp)
 486:	e822                	sd	s0,16(sp)
 488:	1000                	addi	s0,sp,32
 48a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 48e:	4605                	li	a2,1
 490:	fef40593          	addi	a1,s0,-17
 494:	00000097          	auipc	ra,0x0
 498:	fae080e7          	jalr	-82(ra) # 442 <write>
}
 49c:	60e2                	ld	ra,24(sp)
 49e:	6442                	ld	s0,16(sp)
 4a0:	6105                	addi	sp,sp,32
 4a2:	8082                	ret

00000000000004a4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4a4:	715d                	addi	sp,sp,-80
 4a6:	e486                	sd	ra,72(sp)
 4a8:	e0a2                	sd	s0,64(sp)
 4aa:	f84a                	sd	s2,48(sp)
 4ac:	0880                	addi	s0,sp,80
 4ae:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4b0:	c299                	beqz	a3,4b6 <printint+0x12>
 4b2:	0805c563          	bltz	a1,53c <printint+0x98>
  neg = 0;
 4b6:	4881                	li	a7,0
 4b8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4bc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4be:	00000517          	auipc	a0,0x0
 4c2:	5f250513          	addi	a0,a0,1522 # ab0 <digits>
 4c6:	883e                	mv	a6,a5
 4c8:	2785                	addiw	a5,a5,1
 4ca:	02c5f733          	remu	a4,a1,a2
 4ce:	972a                	add	a4,a4,a0
 4d0:	00074703          	lbu	a4,0(a4)
 4d4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4d8:	872e                	mv	a4,a1
 4da:	02c5d5b3          	divu	a1,a1,a2
 4de:	0685                	addi	a3,a3,1
 4e0:	fec773e3          	bgeu	a4,a2,4c6 <printint+0x22>
  if(neg)
 4e4:	00088b63          	beqz	a7,4fa <printint+0x56>
    buf[i++] = '-';
 4e8:	fd078793          	addi	a5,a5,-48
 4ec:	97a2                	add	a5,a5,s0
 4ee:	02d00713          	li	a4,45
 4f2:	fee78423          	sb	a4,-24(a5)
 4f6:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4fa:	02f05c63          	blez	a5,532 <printint+0x8e>
 4fe:	fc26                	sd	s1,56(sp)
 500:	f44e                	sd	s3,40(sp)
 502:	fb840713          	addi	a4,s0,-72
 506:	00f704b3          	add	s1,a4,a5
 50a:	fff70993          	addi	s3,a4,-1
 50e:	99be                	add	s3,s3,a5
 510:	37fd                	addiw	a5,a5,-1
 512:	1782                	slli	a5,a5,0x20
 514:	9381                	srli	a5,a5,0x20
 516:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 51a:	fff4c583          	lbu	a1,-1(s1)
 51e:	854a                	mv	a0,s2
 520:	00000097          	auipc	ra,0x0
 524:	f62080e7          	jalr	-158(ra) # 482 <putc>
  while(--i >= 0)
 528:	14fd                	addi	s1,s1,-1
 52a:	ff3498e3          	bne	s1,s3,51a <printint+0x76>
 52e:	74e2                	ld	s1,56(sp)
 530:	79a2                	ld	s3,40(sp)
}
 532:	60a6                	ld	ra,72(sp)
 534:	6406                	ld	s0,64(sp)
 536:	7942                	ld	s2,48(sp)
 538:	6161                	addi	sp,sp,80
 53a:	8082                	ret
    x = -xx;
 53c:	40b005b3          	neg	a1,a1
    neg = 1;
 540:	4885                	li	a7,1
    x = -xx;
 542:	bf9d                	j	4b8 <printint+0x14>

0000000000000544 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 544:	711d                	addi	sp,sp,-96
 546:	ec86                	sd	ra,88(sp)
 548:	e8a2                	sd	s0,80(sp)
 54a:	e0ca                	sd	s2,64(sp)
 54c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 54e:	0005c903          	lbu	s2,0(a1)
 552:	2c090a63          	beqz	s2,826 <vprintf+0x2e2>
 556:	e4a6                	sd	s1,72(sp)
 558:	fc4e                	sd	s3,56(sp)
 55a:	f852                	sd	s4,48(sp)
 55c:	f456                	sd	s5,40(sp)
 55e:	f05a                	sd	s6,32(sp)
 560:	ec5e                	sd	s7,24(sp)
 562:	e862                	sd	s8,16(sp)
 564:	e466                	sd	s9,8(sp)
 566:	8b2a                	mv	s6,a0
 568:	8a2e                	mv	s4,a1
 56a:	8bb2                	mv	s7,a2
  state = 0;
 56c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 56e:	4481                	li	s1,0
 570:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 572:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 576:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 57a:	06c00c93          	li	s9,108
 57e:	a015                	j	5a2 <vprintf+0x5e>
        putc(fd, c0);
 580:	85ca                	mv	a1,s2
 582:	855a                	mv	a0,s6
 584:	00000097          	auipc	ra,0x0
 588:	efe080e7          	jalr	-258(ra) # 482 <putc>
 58c:	a019                	j	592 <vprintf+0x4e>
    } else if(state == '%'){
 58e:	03598263          	beq	s3,s5,5b2 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 592:	2485                	addiw	s1,s1,1
 594:	8726                	mv	a4,s1
 596:	009a07b3          	add	a5,s4,s1
 59a:	0007c903          	lbu	s2,0(a5)
 59e:	26090c63          	beqz	s2,816 <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 5a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5a6:	fe0994e3          	bnez	s3,58e <vprintf+0x4a>
      if(c0 == '%'){
 5aa:	fd579be3          	bne	a5,s5,580 <vprintf+0x3c>
        state = '%';
 5ae:	89be                	mv	s3,a5
 5b0:	b7cd                	j	592 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 5b2:	00ea06b3          	add	a3,s4,a4
 5b6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5ba:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5bc:	c681                	beqz	a3,5c4 <vprintf+0x80>
 5be:	9752                	add	a4,a4,s4
 5c0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5c4:	05878563          	beq	a5,s8,60e <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 5c8:	07978163          	beq	a5,s9,62a <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5cc:	07500713          	li	a4,117
 5d0:	10e78563          	beq	a5,a4,6da <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5d4:	07800713          	li	a4,120
 5d8:	14e78d63          	beq	a5,a4,732 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5dc:	07000713          	li	a4,112
 5e0:	18e78663          	beq	a5,a4,76c <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5e4:	06300713          	li	a4,99
 5e8:	1ce78c63          	beq	a5,a4,7c0 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ec:	07300713          	li	a4,115
 5f0:	1ee78463          	beq	a5,a4,7d8 <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5f4:	02500713          	li	a4,37
 5f8:	04e79963          	bne	a5,a4,64a <vprintf+0x106>
        putc(fd, '%');
 5fc:	02500593          	li	a1,37
 600:	855a                	mv	a0,s6
 602:	00000097          	auipc	ra,0x0
 606:	e80080e7          	jalr	-384(ra) # 482 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 60a:	4981                	li	s3,0
 60c:	b759                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 60e:	008b8913          	addi	s2,s7,8
 612:	4685                	li	a3,1
 614:	4629                	li	a2,10
 616:	000ba583          	lw	a1,0(s7)
 61a:	855a                	mv	a0,s6
 61c:	00000097          	auipc	ra,0x0
 620:	e88080e7          	jalr	-376(ra) # 4a4 <printint>
 624:	8bca                	mv	s7,s2
      state = 0;
 626:	4981                	li	s3,0
 628:	b7ad                	j	592 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 62a:	06400793          	li	a5,100
 62e:	02f68d63          	beq	a3,a5,668 <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 632:	06c00793          	li	a5,108
 636:	04f68863          	beq	a3,a5,686 <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 63a:	07500793          	li	a5,117
 63e:	0af68c63          	beq	a3,a5,6f6 <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 642:	07800793          	li	a5,120
 646:	10f68463          	beq	a3,a5,74e <vprintf+0x20a>
        putc(fd, '%');
 64a:	02500593          	li	a1,37
 64e:	855a                	mv	a0,s6
 650:	00000097          	auipc	ra,0x0
 654:	e32080e7          	jalr	-462(ra) # 482 <putc>
        putc(fd, c0);
 658:	85ca                	mv	a1,s2
 65a:	855a                	mv	a0,s6
 65c:	00000097          	auipc	ra,0x0
 660:	e26080e7          	jalr	-474(ra) # 482 <putc>
      state = 0;
 664:	4981                	li	s3,0
 666:	b735                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 668:	008b8913          	addi	s2,s7,8
 66c:	4685                	li	a3,1
 66e:	4629                	li	a2,10
 670:	000bb583          	ld	a1,0(s7)
 674:	855a                	mv	a0,s6
 676:	00000097          	auipc	ra,0x0
 67a:	e2e080e7          	jalr	-466(ra) # 4a4 <printint>
        i += 1;
 67e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 680:	8bca                	mv	s7,s2
      state = 0;
 682:	4981                	li	s3,0
        i += 1;
 684:	b739                	j	592 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 686:	06400793          	li	a5,100
 68a:	02f60963          	beq	a2,a5,6bc <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 68e:	07500793          	li	a5,117
 692:	08f60163          	beq	a2,a5,714 <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 696:	07800793          	li	a5,120
 69a:	faf618e3          	bne	a2,a5,64a <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 69e:	008b8913          	addi	s2,s7,8
 6a2:	4681                	li	a3,0
 6a4:	4641                	li	a2,16
 6a6:	000bb583          	ld	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	00000097          	auipc	ra,0x0
 6b0:	df8080e7          	jalr	-520(ra) # 4a4 <printint>
        i += 2;
 6b4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b6:	8bca                	mv	s7,s2
      state = 0;
 6b8:	4981                	li	s3,0
        i += 2;
 6ba:	bde1                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6bc:	008b8913          	addi	s2,s7,8
 6c0:	4685                	li	a3,1
 6c2:	4629                	li	a2,10
 6c4:	000bb583          	ld	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	00000097          	auipc	ra,0x0
 6ce:	dda080e7          	jalr	-550(ra) # 4a4 <printint>
        i += 2;
 6d2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d4:	8bca                	mv	s7,s2
      state = 0;
 6d6:	4981                	li	s3,0
        i += 2;
 6d8:	bd6d                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6da:	008b8913          	addi	s2,s7,8
 6de:	4681                	li	a3,0
 6e0:	4629                	li	a2,10
 6e2:	000be583          	lwu	a1,0(s7)
 6e6:	855a                	mv	a0,s6
 6e8:	00000097          	auipc	ra,0x0
 6ec:	dbc080e7          	jalr	-580(ra) # 4a4 <printint>
 6f0:	8bca                	mv	s7,s2
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	bd79                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f6:	008b8913          	addi	s2,s7,8
 6fa:	4681                	li	a3,0
 6fc:	4629                	li	a2,10
 6fe:	000bb583          	ld	a1,0(s7)
 702:	855a                	mv	a0,s6
 704:	00000097          	auipc	ra,0x0
 708:	da0080e7          	jalr	-608(ra) # 4a4 <printint>
        i += 1;
 70c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 70e:	8bca                	mv	s7,s2
      state = 0;
 710:	4981                	li	s3,0
        i += 1;
 712:	b541                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 714:	008b8913          	addi	s2,s7,8
 718:	4681                	li	a3,0
 71a:	4629                	li	a2,10
 71c:	000bb583          	ld	a1,0(s7)
 720:	855a                	mv	a0,s6
 722:	00000097          	auipc	ra,0x0
 726:	d82080e7          	jalr	-638(ra) # 4a4 <printint>
        i += 2;
 72a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 72c:	8bca                	mv	s7,s2
      state = 0;
 72e:	4981                	li	s3,0
        i += 2;
 730:	b58d                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 732:	008b8913          	addi	s2,s7,8
 736:	4681                	li	a3,0
 738:	4641                	li	a2,16
 73a:	000be583          	lwu	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	00000097          	auipc	ra,0x0
 744:	d64080e7          	jalr	-668(ra) # 4a4 <printint>
 748:	8bca                	mv	s7,s2
      state = 0;
 74a:	4981                	li	s3,0
 74c:	b599                	j	592 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 74e:	008b8913          	addi	s2,s7,8
 752:	4681                	li	a3,0
 754:	4641                	li	a2,16
 756:	000bb583          	ld	a1,0(s7)
 75a:	855a                	mv	a0,s6
 75c:	00000097          	auipc	ra,0x0
 760:	d48080e7          	jalr	-696(ra) # 4a4 <printint>
        i += 1;
 764:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 766:	8bca                	mv	s7,s2
      state = 0;
 768:	4981                	li	s3,0
        i += 1;
 76a:	b525                	j	592 <vprintf+0x4e>
 76c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 76e:	008b8d13          	addi	s10,s7,8
 772:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 776:	03000593          	li	a1,48
 77a:	855a                	mv	a0,s6
 77c:	00000097          	auipc	ra,0x0
 780:	d06080e7          	jalr	-762(ra) # 482 <putc>
  putc(fd, 'x');
 784:	07800593          	li	a1,120
 788:	855a                	mv	a0,s6
 78a:	00000097          	auipc	ra,0x0
 78e:	cf8080e7          	jalr	-776(ra) # 482 <putc>
 792:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 794:	00000b97          	auipc	s7,0x0
 798:	31cb8b93          	addi	s7,s7,796 # ab0 <digits>
 79c:	03c9d793          	srli	a5,s3,0x3c
 7a0:	97de                	add	a5,a5,s7
 7a2:	0007c583          	lbu	a1,0(a5)
 7a6:	855a                	mv	a0,s6
 7a8:	00000097          	auipc	ra,0x0
 7ac:	cda080e7          	jalr	-806(ra) # 482 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b0:	0992                	slli	s3,s3,0x4
 7b2:	397d                	addiw	s2,s2,-1
 7b4:	fe0914e3          	bnez	s2,79c <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 7b8:	8bea                	mv	s7,s10
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	6d02                	ld	s10,0(sp)
 7be:	bbd1                	j	592 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 7c0:	008b8913          	addi	s2,s7,8
 7c4:	000bc583          	lbu	a1,0(s7)
 7c8:	855a                	mv	a0,s6
 7ca:	00000097          	auipc	ra,0x0
 7ce:	cb8080e7          	jalr	-840(ra) # 482 <putc>
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bb75                	j	592 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 7d8:	008b8993          	addi	s3,s7,8
 7dc:	000bb903          	ld	s2,0(s7)
 7e0:	02090163          	beqz	s2,802 <vprintf+0x2be>
        for(; *s; s++)
 7e4:	00094583          	lbu	a1,0(s2)
 7e8:	c585                	beqz	a1,810 <vprintf+0x2cc>
          putc(fd, *s);
 7ea:	855a                	mv	a0,s6
 7ec:	00000097          	auipc	ra,0x0
 7f0:	c96080e7          	jalr	-874(ra) # 482 <putc>
        for(; *s; s++)
 7f4:	0905                	addi	s2,s2,1
 7f6:	00094583          	lbu	a1,0(s2)
 7fa:	f9e5                	bnez	a1,7ea <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 7fc:	8bce                	mv	s7,s3
      state = 0;
 7fe:	4981                	li	s3,0
 800:	bb49                	j	592 <vprintf+0x4e>
          s = "(null)";
 802:	00000917          	auipc	s2,0x0
 806:	2a690913          	addi	s2,s2,678 # aa8 <malloc+0x192>
        for(; *s; s++)
 80a:	02800593          	li	a1,40
 80e:	bff1                	j	7ea <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 810:	8bce                	mv	s7,s3
      state = 0;
 812:	4981                	li	s3,0
 814:	bbbd                	j	592 <vprintf+0x4e>
 816:	64a6                	ld	s1,72(sp)
 818:	79e2                	ld	s3,56(sp)
 81a:	7a42                	ld	s4,48(sp)
 81c:	7aa2                	ld	s5,40(sp)
 81e:	7b02                	ld	s6,32(sp)
 820:	6be2                	ld	s7,24(sp)
 822:	6c42                	ld	s8,16(sp)
 824:	6ca2                	ld	s9,8(sp)
    }
  }
}
 826:	60e6                	ld	ra,88(sp)
 828:	6446                	ld	s0,80(sp)
 82a:	6906                	ld	s2,64(sp)
 82c:	6125                	addi	sp,sp,96
 82e:	8082                	ret

0000000000000830 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 830:	715d                	addi	sp,sp,-80
 832:	ec06                	sd	ra,24(sp)
 834:	e822                	sd	s0,16(sp)
 836:	1000                	addi	s0,sp,32
 838:	e010                	sd	a2,0(s0)
 83a:	e414                	sd	a3,8(s0)
 83c:	e818                	sd	a4,16(s0)
 83e:	ec1c                	sd	a5,24(s0)
 840:	03043023          	sd	a6,32(s0)
 844:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 848:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 84c:	8622                	mv	a2,s0
 84e:	00000097          	auipc	ra,0x0
 852:	cf6080e7          	jalr	-778(ra) # 544 <vprintf>
}
 856:	60e2                	ld	ra,24(sp)
 858:	6442                	ld	s0,16(sp)
 85a:	6161                	addi	sp,sp,80
 85c:	8082                	ret

000000000000085e <printf>:

void
printf(const char *fmt, ...)
{
 85e:	711d                	addi	sp,sp,-96
 860:	ec06                	sd	ra,24(sp)
 862:	e822                	sd	s0,16(sp)
 864:	1000                	addi	s0,sp,32
 866:	e40c                	sd	a1,8(s0)
 868:	e810                	sd	a2,16(s0)
 86a:	ec14                	sd	a3,24(s0)
 86c:	f018                	sd	a4,32(s0)
 86e:	f41c                	sd	a5,40(s0)
 870:	03043823          	sd	a6,48(s0)
 874:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 878:	00840613          	addi	a2,s0,8
 87c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 880:	85aa                	mv	a1,a0
 882:	4505                	li	a0,1
 884:	00000097          	auipc	ra,0x0
 888:	cc0080e7          	jalr	-832(ra) # 544 <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6125                	addi	sp,sp,96
 892:	8082                	ret

0000000000000894 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 894:	1141                	addi	sp,sp,-16
 896:	e422                	sd	s0,8(sp)
 898:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89e:	00000797          	auipc	a5,0x0
 8a2:	7727b783          	ld	a5,1906(a5) # 1010 <freep>
 8a6:	a02d                	j	8d0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a8:	4618                	lw	a4,8(a2)
 8aa:	9f2d                	addw	a4,a4,a1
 8ac:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b0:	6398                	ld	a4,0(a5)
 8b2:	6310                	ld	a2,0(a4)
 8b4:	a83d                	j	8f2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b6:	ff852703          	lw	a4,-8(a0)
 8ba:	9f31                	addw	a4,a4,a2
 8bc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8be:	ff053683          	ld	a3,-16(a0)
 8c2:	a091                	j	906 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	6398                	ld	a4,0(a5)
 8c6:	00e7e463          	bltu	a5,a4,8ce <free+0x3a>
 8ca:	00e6ea63          	bltu	a3,a4,8de <free+0x4a>
{
 8ce:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	fed7fae3          	bgeu	a5,a3,8c4 <free+0x30>
 8d4:	6398                	ld	a4,0(a5)
 8d6:	00e6e463          	bltu	a3,a4,8de <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8da:	fee7eae3          	bltu	a5,a4,8ce <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8de:	ff852583          	lw	a1,-8(a0)
 8e2:	6390                	ld	a2,0(a5)
 8e4:	02059813          	slli	a6,a1,0x20
 8e8:	01c85713          	srli	a4,a6,0x1c
 8ec:	9736                	add	a4,a4,a3
 8ee:	fae60de3          	beq	a2,a4,8a8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8f2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f6:	4790                	lw	a2,8(a5)
 8f8:	02061593          	slli	a1,a2,0x20
 8fc:	01c5d713          	srli	a4,a1,0x1c
 900:	973e                	add	a4,a4,a5
 902:	fae68ae3          	beq	a3,a4,8b6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 906:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 908:	00000717          	auipc	a4,0x0
 90c:	70f73423          	sd	a5,1800(a4) # 1010 <freep>
}
 910:	6422                	ld	s0,8(sp)
 912:	0141                	addi	sp,sp,16
 914:	8082                	ret

0000000000000916 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 916:	7139                	addi	sp,sp,-64
 918:	fc06                	sd	ra,56(sp)
 91a:	f822                	sd	s0,48(sp)
 91c:	f426                	sd	s1,40(sp)
 91e:	ec4e                	sd	s3,24(sp)
 920:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	02051493          	slli	s1,a0,0x20
 926:	9081                	srli	s1,s1,0x20
 928:	04bd                	addi	s1,s1,15
 92a:	8091                	srli	s1,s1,0x4
 92c:	0014899b          	addiw	s3,s1,1
 930:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 932:	00000517          	auipc	a0,0x0
 936:	6de53503          	ld	a0,1758(a0) # 1010 <freep>
 93a:	c915                	beqz	a0,96e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93e:	4798                	lw	a4,8(a5)
 940:	08977e63          	bgeu	a4,s1,9dc <malloc+0xc6>
 944:	f04a                	sd	s2,32(sp)
 946:	e852                	sd	s4,16(sp)
 948:	e456                	sd	s5,8(sp)
 94a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 94c:	8a4e                	mv	s4,s3
 94e:	0009871b          	sext.w	a4,s3
 952:	6685                	lui	a3,0x1
 954:	00d77363          	bgeu	a4,a3,95a <malloc+0x44>
 958:	6a05                	lui	s4,0x1
 95a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 95e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 962:	00000917          	auipc	s2,0x0
 966:	6ae90913          	addi	s2,s2,1710 # 1010 <freep>
  if(p == SBRK_ERROR)
 96a:	5afd                	li	s5,-1
 96c:	a091                	j	9b0 <malloc+0x9a>
 96e:	f04a                	sd	s2,32(sp)
 970:	e852                	sd	s4,16(sp)
 972:	e456                	sd	s5,8(sp)
 974:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 976:	00000797          	auipc	a5,0x0
 97a:	6aa78793          	addi	a5,a5,1706 # 1020 <base>
 97e:	00000717          	auipc	a4,0x0
 982:	68f73923          	sd	a5,1682(a4) # 1010 <freep>
 986:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 988:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 98c:	b7c1                	j	94c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 98e:	6398                	ld	a4,0(a5)
 990:	e118                	sd	a4,0(a0)
 992:	a08d                	j	9f4 <malloc+0xde>
  hp->s.size = nu;
 994:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 998:	0541                	addi	a0,a0,16
 99a:	00000097          	auipc	ra,0x0
 99e:	efa080e7          	jalr	-262(ra) # 894 <free>
  return freep;
 9a2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a6:	c13d                	beqz	a0,a0c <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9aa:	4798                	lw	a4,8(a5)
 9ac:	02977463          	bgeu	a4,s1,9d4 <malloc+0xbe>
    if(p == freep)
 9b0:	00093703          	ld	a4,0(s2)
 9b4:	853e                	mv	a0,a5
 9b6:	fef719e3          	bne	a4,a5,9a8 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 9ba:	8552                	mv	a0,s4
 9bc:	00000097          	auipc	ra,0x0
 9c0:	972080e7          	jalr	-1678(ra) # 32e <sbrk>
  if(p == SBRK_ERROR)
 9c4:	fd5518e3          	bne	a0,s5,994 <malloc+0x7e>
        return 0;
 9c8:	4501                	li	a0,0
 9ca:	7902                	ld	s2,32(sp)
 9cc:	6a42                	ld	s4,16(sp)
 9ce:	6aa2                	ld	s5,8(sp)
 9d0:	6b02                	ld	s6,0(sp)
 9d2:	a03d                	j	a00 <malloc+0xea>
 9d4:	7902                	ld	s2,32(sp)
 9d6:	6a42                	ld	s4,16(sp)
 9d8:	6aa2                	ld	s5,8(sp)
 9da:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9dc:	fae489e3          	beq	s1,a4,98e <malloc+0x78>
        p->s.size -= nunits;
 9e0:	4137073b          	subw	a4,a4,s3
 9e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e6:	02071693          	slli	a3,a4,0x20
 9ea:	01c6d713          	srli	a4,a3,0x1c
 9ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9f4:	00000717          	auipc	a4,0x0
 9f8:	60a73e23          	sd	a0,1564(a4) # 1010 <freep>
      return (void*)(p + 1);
 9fc:	01078513          	addi	a0,a5,16
  }
}
 a00:	70e2                	ld	ra,56(sp)
 a02:	7442                	ld	s0,48(sp)
 a04:	74a2                	ld	s1,40(sp)
 a06:	69e2                	ld	s3,24(sp)
 a08:	6121                	addi	sp,sp,64
 a0a:	8082                	ret
 a0c:	7902                	ld	s2,32(sp)
 a0e:	6a42                	ld	s4,16(sp)
 a10:	6aa2                	ld	s5,8(sp)
 a12:	6b02                	ld	s6,0(sp)
 a14:	b7f5                	j	a00 <malloc+0xea>
