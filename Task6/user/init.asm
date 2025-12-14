
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
  12:	94250513          	addi	a0,a0,-1726 # 950 <malloc+0x10c>
  16:	00000097          	auipc	ra,0x0
  1a:	35a080e7          	jalr	858(ra) # 370 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    open("console", O_RDWR); // 此时 fd = 0 (stdin)
    
  }
  
  // 复制 fd 0 到 fd 1 (stdout)
  duplicate(0); 
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	37c080e7          	jalr	892(ra) # 3a0 <duplicate>
  // 复制 fd 0 到 fd 2 (stderr)
  duplicate(0);
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	372080e7          	jalr	882(ra) # 3a0 <duplicate>

  

  // 2. 进入死循环：负责启动 Shell 并监控它
  for(;;){
    printf("init: starting shell\n");
  36:	00001917          	auipc	s2,0x1
  3a:	92290913          	addi	s2,s2,-1758 # 958 <malloc+0x114>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	74c080e7          	jalr	1868(ra) # 78c <printf>
    
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	300080e7          	jalr	768(ra) # 348 <fork>
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
  5e:	2fe080e7          	jalr	766(ra) # 358 <wait>
      
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
  6e:	94e50513          	addi	a0,a0,-1714 # 9b8 <malloc+0x174>
  72:	00000097          	auipc	ra,0x0
  76:	71a080e7          	jalr	1818(ra) # 78c <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	2d4080e7          	jalr	724(ra) # 350 <exit>
    makenode("console", 1, 1);
  84:	4605                	li	a2,1
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	8c850513          	addi	a0,a0,-1848 # 950 <malloc+0x10c>
  90:	00000097          	auipc	ra,0x0
  94:	308080e7          	jalr	776(ra) # 398 <makenode>
    open("console", O_RDWR); // 此时 fd = 0 (stdin)
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	8b650513          	addi	a0,a0,-1866 # 950 <malloc+0x10c>
  a2:	00000097          	auipc	ra,0x0
  a6:	2ce080e7          	jalr	718(ra) # 370 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	8cc50513          	addi	a0,a0,-1844 # 978 <malloc+0x134>
  b4:	00000097          	auipc	ra,0x0
  b8:	6d8080e7          	jalr	1752(ra) # 78c <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	292080e7          	jalr	658(ra) # 350 <exit>
      exec("shell", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	f3a58593          	addi	a1,a1,-198 # 1000 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	8c250513          	addi	a0,a0,-1854 # 990 <malloc+0x14c>
  d6:	00000097          	auipc	ra,0x0
  da:	2a2080e7          	jalr	674(ra) # 378 <exec>
      printf("init: exec shell failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	8ba50513          	addi	a0,a0,-1862 # 998 <malloc+0x154>
  e6:	00000097          	auipc	ra,0x0
  ea:	6a6080e7          	jalr	1702(ra) # 78c <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	260080e7          	jalr	608(ra) # 350 <exit>

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
 10c:	248080e7          	jalr	584(ra) # 350 <exit>

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
 1fe:	186080e7          	jalr	390(ra) # 380 <read>
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
 33c:	070080e7          	jalr	112(ra) # 3a8 <sys_sbrk>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <fork>:
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 348:	4885                	li	a7,1
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <exit>:
.global exit
exit:
 li a7, SYS_exit
 350:	4889                	li	a7,2
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <wait>:
.global wait
wait:
 li a7, SYS_wait
 358:	488d                	li	a7,3
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 360:	4891                	li	a7,4
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <close>:
.global close
close:
 li a7, SYS_close
 368:	4899                	li	a7,6
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <open>:
.global open
open:
 li a7, SYS_open
 370:	489d                	li	a7,7
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <exec>:
.global exec
exec:
 li a7, SYS_exec
 378:	4895                	li	a7,5
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <read>:
.global read
read:
 li a7, SYS_read
 380:	48a1                	li	a7,8
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <write>:
.global write
write:
 li a7, SYS_write
 388:	48a5                	li	a7,9
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 390:	48a9                	li	a7,10
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 398:	48ad                	li	a7,11
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 3a0:	48b1                	li	a7,12
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3a8:	48b5                	li	a7,13
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3b0:	1101                	addi	sp,sp,-32
 3b2:	ec06                	sd	ra,24(sp)
 3b4:	e822                	sd	s0,16(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3bc:	4605                	li	a2,1
 3be:	fef40593          	addi	a1,s0,-17
 3c2:	00000097          	auipc	ra,0x0
 3c6:	fc6080e7          	jalr	-58(ra) # 388 <write>
}
 3ca:	60e2                	ld	ra,24(sp)
 3cc:	6442                	ld	s0,16(sp)
 3ce:	6105                	addi	sp,sp,32
 3d0:	8082                	ret

00000000000003d2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3d2:	715d                	addi	sp,sp,-80
 3d4:	e486                	sd	ra,72(sp)
 3d6:	e0a2                	sd	s0,64(sp)
 3d8:	f84a                	sd	s2,48(sp)
 3da:	0880                	addi	s0,sp,80
 3dc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 3de:	c299                	beqz	a3,3e4 <printint+0x12>
 3e0:	0805c563          	bltz	a1,46a <printint+0x98>
  neg = 0;
 3e4:	4881                	li	a7,0
 3e6:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3ea:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3ec:	00000517          	auipc	a0,0x0
 3f0:	5f450513          	addi	a0,a0,1524 # 9e0 <digits>
 3f4:	883e                	mv	a6,a5
 3f6:	2785                	addiw	a5,a5,1
 3f8:	02c5f733          	remu	a4,a1,a2
 3fc:	972a                	add	a4,a4,a0
 3fe:	00074703          	lbu	a4,0(a4)
 402:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 406:	872e                	mv	a4,a1
 408:	02c5d5b3          	divu	a1,a1,a2
 40c:	0685                	addi	a3,a3,1
 40e:	fec773e3          	bgeu	a4,a2,3f4 <printint+0x22>
  if(neg)
 412:	00088b63          	beqz	a7,428 <printint+0x56>
    buf[i++] = '-';
 416:	fd078793          	addi	a5,a5,-48
 41a:	97a2                	add	a5,a5,s0
 41c:	02d00713          	li	a4,45
 420:	fee78423          	sb	a4,-24(a5)
 424:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 428:	02f05c63          	blez	a5,460 <printint+0x8e>
 42c:	fc26                	sd	s1,56(sp)
 42e:	f44e                	sd	s3,40(sp)
 430:	fb840713          	addi	a4,s0,-72
 434:	00f704b3          	add	s1,a4,a5
 438:	fff70993          	addi	s3,a4,-1
 43c:	99be                	add	s3,s3,a5
 43e:	37fd                	addiw	a5,a5,-1
 440:	1782                	slli	a5,a5,0x20
 442:	9381                	srli	a5,a5,0x20
 444:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 448:	fff4c583          	lbu	a1,-1(s1)
 44c:	854a                	mv	a0,s2
 44e:	00000097          	auipc	ra,0x0
 452:	f62080e7          	jalr	-158(ra) # 3b0 <putc>
  while(--i >= 0)
 456:	14fd                	addi	s1,s1,-1
 458:	ff3498e3          	bne	s1,s3,448 <printint+0x76>
 45c:	74e2                	ld	s1,56(sp)
 45e:	79a2                	ld	s3,40(sp)
}
 460:	60a6                	ld	ra,72(sp)
 462:	6406                	ld	s0,64(sp)
 464:	7942                	ld	s2,48(sp)
 466:	6161                	addi	sp,sp,80
 468:	8082                	ret
    x = -xx;
 46a:	40b005b3          	neg	a1,a1
    neg = 1;
 46e:	4885                	li	a7,1
    x = -xx;
 470:	bf9d                	j	3e6 <printint+0x14>

0000000000000472 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 472:	711d                	addi	sp,sp,-96
 474:	ec86                	sd	ra,88(sp)
 476:	e8a2                	sd	s0,80(sp)
 478:	e0ca                	sd	s2,64(sp)
 47a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 47c:	0005c903          	lbu	s2,0(a1)
 480:	2c090a63          	beqz	s2,754 <vprintf+0x2e2>
 484:	e4a6                	sd	s1,72(sp)
 486:	fc4e                	sd	s3,56(sp)
 488:	f852                	sd	s4,48(sp)
 48a:	f456                	sd	s5,40(sp)
 48c:	f05a                	sd	s6,32(sp)
 48e:	ec5e                	sd	s7,24(sp)
 490:	e862                	sd	s8,16(sp)
 492:	e466                	sd	s9,8(sp)
 494:	8b2a                	mv	s6,a0
 496:	8a2e                	mv	s4,a1
 498:	8bb2                	mv	s7,a2
  state = 0;
 49a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 49c:	4481                	li	s1,0
 49e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4a0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4a4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4a8:	06c00c93          	li	s9,108
 4ac:	a015                	j	4d0 <vprintf+0x5e>
        putc(fd, c0);
 4ae:	85ca                	mv	a1,s2
 4b0:	855a                	mv	a0,s6
 4b2:	00000097          	auipc	ra,0x0
 4b6:	efe080e7          	jalr	-258(ra) # 3b0 <putc>
 4ba:	a019                	j	4c0 <vprintf+0x4e>
    } else if(state == '%'){
 4bc:	03598263          	beq	s3,s5,4e0 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 4c0:	2485                	addiw	s1,s1,1
 4c2:	8726                	mv	a4,s1
 4c4:	009a07b3          	add	a5,s4,s1
 4c8:	0007c903          	lbu	s2,0(a5)
 4cc:	26090c63          	beqz	s2,744 <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 4d0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4d4:	fe0994e3          	bnez	s3,4bc <vprintf+0x4a>
      if(c0 == '%'){
 4d8:	fd579be3          	bne	a5,s5,4ae <vprintf+0x3c>
        state = '%';
 4dc:	89be                	mv	s3,a5
 4de:	b7cd                	j	4c0 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 4e0:	00ea06b3          	add	a3,s4,a4
 4e4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4e8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4ea:	c681                	beqz	a3,4f2 <vprintf+0x80>
 4ec:	9752                	add	a4,a4,s4
 4ee:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4f2:	05878563          	beq	a5,s8,53c <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 4f6:	07978163          	beq	a5,s9,558 <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4fa:	07500713          	li	a4,117
 4fe:	10e78563          	beq	a5,a4,608 <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 502:	07800713          	li	a4,120
 506:	14e78d63          	beq	a5,a4,660 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 50a:	07000713          	li	a4,112
 50e:	18e78663          	beq	a5,a4,69a <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 512:	06300713          	li	a4,99
 516:	1ce78c63          	beq	a5,a4,6ee <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 51a:	07300713          	li	a4,115
 51e:	1ee78463          	beq	a5,a4,706 <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 522:	02500713          	li	a4,37
 526:	04e79963          	bne	a5,a4,578 <vprintf+0x106>
        putc(fd, '%');
 52a:	02500593          	li	a1,37
 52e:	855a                	mv	a0,s6
 530:	00000097          	auipc	ra,0x0
 534:	e80080e7          	jalr	-384(ra) # 3b0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 538:	4981                	li	s3,0
 53a:	b759                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 53c:	008b8913          	addi	s2,s7,8
 540:	4685                	li	a3,1
 542:	4629                	li	a2,10
 544:	000ba583          	lw	a1,0(s7)
 548:	855a                	mv	a0,s6
 54a:	00000097          	auipc	ra,0x0
 54e:	e88080e7          	jalr	-376(ra) # 3d2 <printint>
 552:	8bca                	mv	s7,s2
      state = 0;
 554:	4981                	li	s3,0
 556:	b7ad                	j	4c0 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 558:	06400793          	li	a5,100
 55c:	02f68d63          	beq	a3,a5,596 <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 560:	06c00793          	li	a5,108
 564:	04f68863          	beq	a3,a5,5b4 <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 568:	07500793          	li	a5,117
 56c:	0af68c63          	beq	a3,a5,624 <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 570:	07800793          	li	a5,120
 574:	10f68463          	beq	a3,a5,67c <vprintf+0x20a>
        putc(fd, '%');
 578:	02500593          	li	a1,37
 57c:	855a                	mv	a0,s6
 57e:	00000097          	auipc	ra,0x0
 582:	e32080e7          	jalr	-462(ra) # 3b0 <putc>
        putc(fd, c0);
 586:	85ca                	mv	a1,s2
 588:	855a                	mv	a0,s6
 58a:	00000097          	auipc	ra,0x0
 58e:	e26080e7          	jalr	-474(ra) # 3b0 <putc>
      state = 0;
 592:	4981                	li	s3,0
 594:	b735                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 596:	008b8913          	addi	s2,s7,8
 59a:	4685                	li	a3,1
 59c:	4629                	li	a2,10
 59e:	000bb583          	ld	a1,0(s7)
 5a2:	855a                	mv	a0,s6
 5a4:	00000097          	auipc	ra,0x0
 5a8:	e2e080e7          	jalr	-466(ra) # 3d2 <printint>
        i += 1;
 5ac:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ae:	8bca                	mv	s7,s2
      state = 0;
 5b0:	4981                	li	s3,0
        i += 1;
 5b2:	b739                	j	4c0 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5b4:	06400793          	li	a5,100
 5b8:	02f60963          	beq	a2,a5,5ea <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5bc:	07500793          	li	a5,117
 5c0:	08f60163          	beq	a2,a5,642 <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5c4:	07800793          	li	a5,120
 5c8:	faf618e3          	bne	a2,a5,578 <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5cc:	008b8913          	addi	s2,s7,8
 5d0:	4681                	li	a3,0
 5d2:	4641                	li	a2,16
 5d4:	000bb583          	ld	a1,0(s7)
 5d8:	855a                	mv	a0,s6
 5da:	00000097          	auipc	ra,0x0
 5de:	df8080e7          	jalr	-520(ra) # 3d2 <printint>
        i += 2;
 5e2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5e4:	8bca                	mv	s7,s2
      state = 0;
 5e6:	4981                	li	s3,0
        i += 2;
 5e8:	bde1                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ea:	008b8913          	addi	s2,s7,8
 5ee:	4685                	li	a3,1
 5f0:	4629                	li	a2,10
 5f2:	000bb583          	ld	a1,0(s7)
 5f6:	855a                	mv	a0,s6
 5f8:	00000097          	auipc	ra,0x0
 5fc:	dda080e7          	jalr	-550(ra) # 3d2 <printint>
        i += 2;
 600:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 602:	8bca                	mv	s7,s2
      state = 0;
 604:	4981                	li	s3,0
        i += 2;
 606:	bd6d                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 608:	008b8913          	addi	s2,s7,8
 60c:	4681                	li	a3,0
 60e:	4629                	li	a2,10
 610:	000be583          	lwu	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	00000097          	auipc	ra,0x0
 61a:	dbc080e7          	jalr	-580(ra) # 3d2 <printint>
 61e:	8bca                	mv	s7,s2
      state = 0;
 620:	4981                	li	s3,0
 622:	bd79                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 624:	008b8913          	addi	s2,s7,8
 628:	4681                	li	a3,0
 62a:	4629                	li	a2,10
 62c:	000bb583          	ld	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	00000097          	auipc	ra,0x0
 636:	da0080e7          	jalr	-608(ra) # 3d2 <printint>
        i += 1;
 63a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 63c:	8bca                	mv	s7,s2
      state = 0;
 63e:	4981                	li	s3,0
        i += 1;
 640:	b541                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 642:	008b8913          	addi	s2,s7,8
 646:	4681                	li	a3,0
 648:	4629                	li	a2,10
 64a:	000bb583          	ld	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	00000097          	auipc	ra,0x0
 654:	d82080e7          	jalr	-638(ra) # 3d2 <printint>
        i += 2;
 658:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 65a:	8bca                	mv	s7,s2
      state = 0;
 65c:	4981                	li	s3,0
        i += 2;
 65e:	b58d                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 660:	008b8913          	addi	s2,s7,8
 664:	4681                	li	a3,0
 666:	4641                	li	a2,16
 668:	000be583          	lwu	a1,0(s7)
 66c:	855a                	mv	a0,s6
 66e:	00000097          	auipc	ra,0x0
 672:	d64080e7          	jalr	-668(ra) # 3d2 <printint>
 676:	8bca                	mv	s7,s2
      state = 0;
 678:	4981                	li	s3,0
 67a:	b599                	j	4c0 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 67c:	008b8913          	addi	s2,s7,8
 680:	4681                	li	a3,0
 682:	4641                	li	a2,16
 684:	000bb583          	ld	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	00000097          	auipc	ra,0x0
 68e:	d48080e7          	jalr	-696(ra) # 3d2 <printint>
        i += 1;
 692:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 694:	8bca                	mv	s7,s2
      state = 0;
 696:	4981                	li	s3,0
        i += 1;
 698:	b525                	j	4c0 <vprintf+0x4e>
 69a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 69c:	008b8d13          	addi	s10,s7,8
 6a0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6a4:	03000593          	li	a1,48
 6a8:	855a                	mv	a0,s6
 6aa:	00000097          	auipc	ra,0x0
 6ae:	d06080e7          	jalr	-762(ra) # 3b0 <putc>
  putc(fd, 'x');
 6b2:	07800593          	li	a1,120
 6b6:	855a                	mv	a0,s6
 6b8:	00000097          	auipc	ra,0x0
 6bc:	cf8080e7          	jalr	-776(ra) # 3b0 <putc>
 6c0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c2:	00000b97          	auipc	s7,0x0
 6c6:	31eb8b93          	addi	s7,s7,798 # 9e0 <digits>
 6ca:	03c9d793          	srli	a5,s3,0x3c
 6ce:	97de                	add	a5,a5,s7
 6d0:	0007c583          	lbu	a1,0(a5)
 6d4:	855a                	mv	a0,s6
 6d6:	00000097          	auipc	ra,0x0
 6da:	cda080e7          	jalr	-806(ra) # 3b0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6de:	0992                	slli	s3,s3,0x4
 6e0:	397d                	addiw	s2,s2,-1
 6e2:	fe0914e3          	bnez	s2,6ca <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 6e6:	8bea                	mv	s7,s10
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	6d02                	ld	s10,0(sp)
 6ec:	bbd1                	j	4c0 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 6ee:	008b8913          	addi	s2,s7,8
 6f2:	000bc583          	lbu	a1,0(s7)
 6f6:	855a                	mv	a0,s6
 6f8:	00000097          	auipc	ra,0x0
 6fc:	cb8080e7          	jalr	-840(ra) # 3b0 <putc>
 700:	8bca                	mv	s7,s2
      state = 0;
 702:	4981                	li	s3,0
 704:	bb75                	j	4c0 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 706:	008b8993          	addi	s3,s7,8
 70a:	000bb903          	ld	s2,0(s7)
 70e:	02090163          	beqz	s2,730 <vprintf+0x2be>
        for(; *s; s++)
 712:	00094583          	lbu	a1,0(s2)
 716:	c585                	beqz	a1,73e <vprintf+0x2cc>
          putc(fd, *s);
 718:	855a                	mv	a0,s6
 71a:	00000097          	auipc	ra,0x0
 71e:	c96080e7          	jalr	-874(ra) # 3b0 <putc>
        for(; *s; s++)
 722:	0905                	addi	s2,s2,1
 724:	00094583          	lbu	a1,0(s2)
 728:	f9e5                	bnez	a1,718 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 72a:	8bce                	mv	s7,s3
      state = 0;
 72c:	4981                	li	s3,0
 72e:	bb49                	j	4c0 <vprintf+0x4e>
          s = "(null)";
 730:	00000917          	auipc	s2,0x0
 734:	2a890913          	addi	s2,s2,680 # 9d8 <malloc+0x194>
        for(; *s; s++)
 738:	02800593          	li	a1,40
 73c:	bff1                	j	718 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 73e:	8bce                	mv	s7,s3
      state = 0;
 740:	4981                	li	s3,0
 742:	bbbd                	j	4c0 <vprintf+0x4e>
 744:	64a6                	ld	s1,72(sp)
 746:	79e2                	ld	s3,56(sp)
 748:	7a42                	ld	s4,48(sp)
 74a:	7aa2                	ld	s5,40(sp)
 74c:	7b02                	ld	s6,32(sp)
 74e:	6be2                	ld	s7,24(sp)
 750:	6c42                	ld	s8,16(sp)
 752:	6ca2                	ld	s9,8(sp)
    }
  }
}
 754:	60e6                	ld	ra,88(sp)
 756:	6446                	ld	s0,80(sp)
 758:	6906                	ld	s2,64(sp)
 75a:	6125                	addi	sp,sp,96
 75c:	8082                	ret

000000000000075e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 75e:	715d                	addi	sp,sp,-80
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	addi	s0,sp,32
 766:	e010                	sd	a2,0(s0)
 768:	e414                	sd	a3,8(s0)
 76a:	e818                	sd	a4,16(s0)
 76c:	ec1c                	sd	a5,24(s0)
 76e:	03043023          	sd	a6,32(s0)
 772:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 776:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 77a:	8622                	mv	a2,s0
 77c:	00000097          	auipc	ra,0x0
 780:	cf6080e7          	jalr	-778(ra) # 472 <vprintf>
}
 784:	60e2                	ld	ra,24(sp)
 786:	6442                	ld	s0,16(sp)
 788:	6161                	addi	sp,sp,80
 78a:	8082                	ret

000000000000078c <printf>:

void
printf(const char *fmt, ...)
{
 78c:	711d                	addi	sp,sp,-96
 78e:	ec06                	sd	ra,24(sp)
 790:	e822                	sd	s0,16(sp)
 792:	1000                	addi	s0,sp,32
 794:	e40c                	sd	a1,8(s0)
 796:	e810                	sd	a2,16(s0)
 798:	ec14                	sd	a3,24(s0)
 79a:	f018                	sd	a4,32(s0)
 79c:	f41c                	sd	a5,40(s0)
 79e:	03043823          	sd	a6,48(s0)
 7a2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a6:	00840613          	addi	a2,s0,8
 7aa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ae:	85aa                	mv	a1,a0
 7b0:	4505                	li	a0,1
 7b2:	00000097          	auipc	ra,0x0
 7b6:	cc0080e7          	jalr	-832(ra) # 472 <vprintf>
}
 7ba:	60e2                	ld	ra,24(sp)
 7bc:	6442                	ld	s0,16(sp)
 7be:	6125                	addi	sp,sp,96
 7c0:	8082                	ret

00000000000007c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c2:	1141                	addi	sp,sp,-16
 7c4:	e422                	sd	s0,8(sp)
 7c6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7cc:	00001797          	auipc	a5,0x1
 7d0:	8447b783          	ld	a5,-1980(a5) # 1010 <freep>
 7d4:	a02d                	j	7fe <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7d6:	4618                	lw	a4,8(a2)
 7d8:	9f2d                	addw	a4,a4,a1
 7da:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7de:	6398                	ld	a4,0(a5)
 7e0:	6310                	ld	a2,0(a4)
 7e2:	a83d                	j	820 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7e4:	ff852703          	lw	a4,-8(a0)
 7e8:	9f31                	addw	a4,a4,a2
 7ea:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7ec:	ff053683          	ld	a3,-16(a0)
 7f0:	a091                	j	834 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f2:	6398                	ld	a4,0(a5)
 7f4:	00e7e463          	bltu	a5,a4,7fc <free+0x3a>
 7f8:	00e6ea63          	bltu	a3,a4,80c <free+0x4a>
{
 7fc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fe:	fed7fae3          	bgeu	a5,a3,7f2 <free+0x30>
 802:	6398                	ld	a4,0(a5)
 804:	00e6e463          	bltu	a3,a4,80c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 808:	fee7eae3          	bltu	a5,a4,7fc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 80c:	ff852583          	lw	a1,-8(a0)
 810:	6390                	ld	a2,0(a5)
 812:	02059813          	slli	a6,a1,0x20
 816:	01c85713          	srli	a4,a6,0x1c
 81a:	9736                	add	a4,a4,a3
 81c:	fae60de3          	beq	a2,a4,7d6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 820:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 824:	4790                	lw	a2,8(a5)
 826:	02061593          	slli	a1,a2,0x20
 82a:	01c5d713          	srli	a4,a1,0x1c
 82e:	973e                	add	a4,a4,a5
 830:	fae68ae3          	beq	a3,a4,7e4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 834:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 836:	00000717          	auipc	a4,0x0
 83a:	7cf73d23          	sd	a5,2010(a4) # 1010 <freep>
}
 83e:	6422                	ld	s0,8(sp)
 840:	0141                	addi	sp,sp,16
 842:	8082                	ret

0000000000000844 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 844:	7139                	addi	sp,sp,-64
 846:	fc06                	sd	ra,56(sp)
 848:	f822                	sd	s0,48(sp)
 84a:	f426                	sd	s1,40(sp)
 84c:	ec4e                	sd	s3,24(sp)
 84e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 850:	02051493          	slli	s1,a0,0x20
 854:	9081                	srli	s1,s1,0x20
 856:	04bd                	addi	s1,s1,15
 858:	8091                	srli	s1,s1,0x4
 85a:	0014899b          	addiw	s3,s1,1
 85e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 860:	00000517          	auipc	a0,0x0
 864:	7b053503          	ld	a0,1968(a0) # 1010 <freep>
 868:	c915                	beqz	a0,89c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 86c:	4798                	lw	a4,8(a5)
 86e:	08977e63          	bgeu	a4,s1,90a <malloc+0xc6>
 872:	f04a                	sd	s2,32(sp)
 874:	e852                	sd	s4,16(sp)
 876:	e456                	sd	s5,8(sp)
 878:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 87a:	8a4e                	mv	s4,s3
 87c:	0009871b          	sext.w	a4,s3
 880:	6685                	lui	a3,0x1
 882:	00d77363          	bgeu	a4,a3,888 <malloc+0x44>
 886:	6a05                	lui	s4,0x1
 888:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 88c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 890:	00000917          	auipc	s2,0x0
 894:	78090913          	addi	s2,s2,1920 # 1010 <freep>
  if(p == SBRK_ERROR)
 898:	5afd                	li	s5,-1
 89a:	a091                	j	8de <malloc+0x9a>
 89c:	f04a                	sd	s2,32(sp)
 89e:	e852                	sd	s4,16(sp)
 8a0:	e456                	sd	s5,8(sp)
 8a2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8a4:	00000797          	auipc	a5,0x0
 8a8:	77c78793          	addi	a5,a5,1916 # 1020 <base>
 8ac:	00000717          	auipc	a4,0x0
 8b0:	76f73223          	sd	a5,1892(a4) # 1010 <freep>
 8b4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ba:	b7c1                	j	87a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8bc:	6398                	ld	a4,0(a5)
 8be:	e118                	sd	a4,0(a0)
 8c0:	a08d                	j	922 <malloc+0xde>
  hp->s.size = nu;
 8c2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8c6:	0541                	addi	a0,a0,16
 8c8:	00000097          	auipc	ra,0x0
 8cc:	efa080e7          	jalr	-262(ra) # 7c2 <free>
  return freep;
 8d0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8d4:	c13d                	beqz	a0,93a <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d8:	4798                	lw	a4,8(a5)
 8da:	02977463          	bgeu	a4,s1,902 <malloc+0xbe>
    if(p == freep)
 8de:	00093703          	ld	a4,0(s2)
 8e2:	853e                	mv	a0,a5
 8e4:	fef719e3          	bne	a4,a5,8d6 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 8e8:	8552                	mv	a0,s4
 8ea:	00000097          	auipc	ra,0x0
 8ee:	a44080e7          	jalr	-1468(ra) # 32e <sbrk>
  if(p == SBRK_ERROR)
 8f2:	fd5518e3          	bne	a0,s5,8c2 <malloc+0x7e>
        return 0;
 8f6:	4501                	li	a0,0
 8f8:	7902                	ld	s2,32(sp)
 8fa:	6a42                	ld	s4,16(sp)
 8fc:	6aa2                	ld	s5,8(sp)
 8fe:	6b02                	ld	s6,0(sp)
 900:	a03d                	j	92e <malloc+0xea>
 902:	7902                	ld	s2,32(sp)
 904:	6a42                	ld	s4,16(sp)
 906:	6aa2                	ld	s5,8(sp)
 908:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 90a:	fae489e3          	beq	s1,a4,8bc <malloc+0x78>
        p->s.size -= nunits;
 90e:	4137073b          	subw	a4,a4,s3
 912:	c798                	sw	a4,8(a5)
        p += p->s.size;
 914:	02071693          	slli	a3,a4,0x20
 918:	01c6d713          	srli	a4,a3,0x1c
 91c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 91e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 922:	00000717          	auipc	a4,0x0
 926:	6ea73723          	sd	a0,1774(a4) # 1010 <freep>
      return (void*)(p + 1);
 92a:	01078513          	addi	a0,a5,16
  }
}
 92e:	70e2                	ld	ra,56(sp)
 930:	7442                	ld	s0,48(sp)
 932:	74a2                	ld	s1,40(sp)
 934:	69e2                	ld	s3,24(sp)
 936:	6121                	addi	sp,sp,64
 938:	8082                	ret
 93a:	7902                	ld	s2,32(sp)
 93c:	6a42                	ld	s4,16(sp)
 93e:	6aa2                	ld	s5,8(sp)
 940:	6b02                	ld	s6,0(sp)
 942:	b7f5                	j	92e <malloc+0xea>
