
user/_test_syscall:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <test_syscalls>:
#include"./user.h"

void
test_syscalls(){
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  printf("Testing basic system calls...\n");
   8:	00001517          	auipc	a0,0x1
   c:	9d850513          	addi	a0,a0,-1576 # 9e0 <malloc+0x108>
  10:	00001097          	auipc	ra,0x1
  14:	810080e7          	jalr	-2032(ra) # 820 <printf>

  //测试getpid
  int pid = getpid();
  18:	00000097          	auipc	ra,0x0
  1c:	3c4080e7          	jalr	964(ra) # 3dc <getpid>
  20:	85aa                	mv	a1,a0
  printf("Current PID: %d\n",pid);
  22:	00001517          	auipc	a0,0x1
  26:	9e650513          	addi	a0,a0,-1562 # a08 <malloc+0x130>
  2a:	00000097          	auipc	ra,0x0
  2e:	7f6080e7          	jalr	2038(ra) # 820 <printf>

  //测试fork
  int child_pid = fork();
  32:	00000097          	auipc	ra,0x0
  36:	392080e7          	jalr	914(ra) # 3c4 <fork>
  if(child_pid == 0){
  3a:	c51d                	beqz	a0,68 <test_syscalls+0x68>
    //子进程
    printf("Child process: PID = %d\n", getpid());
    exit(42);
  } else if(child_pid > 0){
  3c:	04a05963          	blez	a0,8e <test_syscalls+0x8e>
    //父进程
    int status;
    wait(&status);
  40:	fec40513          	addi	a0,s0,-20
  44:	00000097          	auipc	ra,0x0
  48:	390080e7          	jalr	912(ra) # 3d4 <wait>
    printf("Child exited with status: %d\n", status);
  4c:	fec42583          	lw	a1,-20(s0)
  50:	00001517          	auipc	a0,0x1
  54:	9f050513          	addi	a0,a0,-1552 # a40 <malloc+0x168>
  58:	00000097          	auipc	ra,0x0
  5c:	7c8080e7          	jalr	1992(ra) # 820 <printf>
  } else{
    printf("Fork failed\n");
  }
}
  60:	60e2                	ld	ra,24(sp)
  62:	6442                	ld	s0,16(sp)
  64:	6105                	addi	sp,sp,32
  66:	8082                	ret
    printf("Child process: PID = %d\n", getpid());
  68:	00000097          	auipc	ra,0x0
  6c:	374080e7          	jalr	884(ra) # 3dc <getpid>
  70:	85aa                	mv	a1,a0
  72:	00001517          	auipc	a0,0x1
  76:	9ae50513          	addi	a0,a0,-1618 # a20 <malloc+0x148>
  7a:	00000097          	auipc	ra,0x0
  7e:	7a6080e7          	jalr	1958(ra) # 820 <printf>
    exit(42);
  82:	02a00513          	li	a0,42
  86:	00000097          	auipc	ra,0x0
  8a:	346080e7          	jalr	838(ra) # 3cc <exit>
    printf("Fork failed\n");
  8e:	00001517          	auipc	a0,0x1
  92:	9d250513          	addi	a0,a0,-1582 # a60 <malloc+0x188>
  96:	00000097          	auipc	ra,0x0
  9a:	78a080e7          	jalr	1930(ra) # 820 <printf>
}
  9e:	b7c9                	j	60 <test_syscalls+0x60>

00000000000000a0 <main>:


int
main(int argc, char *argv[])
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e406                	sd	ra,8(sp)
  a4:	e022                	sd	s0,0(sp)
  a6:	0800                	addi	s0,sp,16
  test_syscalls();
  a8:	00000097          	auipc	ra,0x0
  ac:	f58080e7          	jalr	-168(ra) # 0 <test_syscalls>

  exit(0);
  b0:	4501                	li	a0,0
  b2:	00000097          	auipc	ra,0x0
  b6:	31a080e7          	jalr	794(ra) # 3cc <exit>

00000000000000ba <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e406                	sd	ra,8(sp)
  be:	e022                	sd	s0,0(sp)
  c0:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
  c2:	00000097          	auipc	ra,0x0
  c6:	fde080e7          	jalr	-34(ra) # a0 <main>
  exit(r);
  ca:	00000097          	auipc	ra,0x0
  ce:	302080e7          	jalr	770(ra) # 3cc <exit>

00000000000000d2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d8:	87aa                	mv	a5,a0
  da:	0585                	addi	a1,a1,1
  dc:	0785                	addi	a5,a5,1
  de:	fff5c703          	lbu	a4,-1(a1)
  e2:	fee78fa3          	sb	a4,-1(a5)
  e6:	fb75                	bnez	a4,da <strcpy+0x8>
    ;
  return os;
}
  e8:	6422                	ld	s0,8(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e422                	sd	s0,8(sp)
  f2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	cb91                	beqz	a5,10c <strcmp+0x1e>
  fa:	0005c703          	lbu	a4,0(a1)
  fe:	00f71763          	bne	a4,a5,10c <strcmp+0x1e>
    p++, q++;
 102:	0505                	addi	a0,a0,1
 104:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 106:	00054783          	lbu	a5,0(a0)
 10a:	fbe5                	bnez	a5,fa <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 10c:	0005c503          	lbu	a0,0(a1)
}
 110:	40a7853b          	subw	a0,a5,a0
 114:	6422                	ld	s0,8(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strlen>:

uint
strlen(const char *s)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e422                	sd	s0,8(sp)
 11e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 120:	00054783          	lbu	a5,0(a0)
 124:	cf91                	beqz	a5,140 <strlen+0x26>
 126:	0505                	addi	a0,a0,1
 128:	87aa                	mv	a5,a0
 12a:	86be                	mv	a3,a5
 12c:	0785                	addi	a5,a5,1
 12e:	fff7c703          	lbu	a4,-1(a5)
 132:	ff65                	bnez	a4,12a <strlen+0x10>
 134:	40a6853b          	subw	a0,a3,a0
 138:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 13a:	6422                	ld	s0,8(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret
  for(n = 0; s[n]; n++)
 140:	4501                	li	a0,0
 142:	bfe5                	j	13a <strlen+0x20>

0000000000000144 <memset>:

void*
memset(void *dst, int c, uint n)
{
 144:	1141                	addi	sp,sp,-16
 146:	e422                	sd	s0,8(sp)
 148:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 14a:	ca19                	beqz	a2,160 <memset+0x1c>
 14c:	87aa                	mv	a5,a0
 14e:	1602                	slli	a2,a2,0x20
 150:	9201                	srli	a2,a2,0x20
 152:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 156:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 15a:	0785                	addi	a5,a5,1
 15c:	fee79de3          	bne	a5,a4,156 <memset+0x12>
  }
  return dst;
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <strchr>:

char*
strchr(const char *s, char c)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cb99                	beqz	a5,186 <strchr+0x20>
    if(*s == c)
 172:	00f58763          	beq	a1,a5,180 <strchr+0x1a>
  for(; *s; s++)
 176:	0505                	addi	a0,a0,1
 178:	00054783          	lbu	a5,0(a0)
 17c:	fbfd                	bnez	a5,172 <strchr+0xc>
      return (char*)s;
  return 0;
 17e:	4501                	li	a0,0
}
 180:	6422                	ld	s0,8(sp)
 182:	0141                	addi	sp,sp,16
 184:	8082                	ret
  return 0;
 186:	4501                	li	a0,0
 188:	bfe5                	j	180 <strchr+0x1a>

000000000000018a <gets>:

char*
gets(char *buf, int max)
{
 18a:	711d                	addi	sp,sp,-96
 18c:	ec86                	sd	ra,88(sp)
 18e:	e8a2                	sd	s0,80(sp)
 190:	e4a6                	sd	s1,72(sp)
 192:	e0ca                	sd	s2,64(sp)
 194:	fc4e                	sd	s3,56(sp)
 196:	f852                	sd	s4,48(sp)
 198:	f456                	sd	s5,40(sp)
 19a:	f05a                	sd	s6,32(sp)
 19c:	ec5e                	sd	s7,24(sp)
 19e:	1080                	addi	s0,sp,96
 1a0:	8baa                	mv	s7,a0
 1a2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a4:	892a                	mv	s2,a0
 1a6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1a8:	4aa9                	li	s5,10
 1aa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ac:	89a6                	mv	s3,s1
 1ae:	2485                	addiw	s1,s1,1
 1b0:	0344d863          	bge	s1,s4,1e0 <gets+0x56>
    cc = read(0, &c, 1);
 1b4:	4605                	li	a2,1
 1b6:	faf40593          	addi	a1,s0,-81
 1ba:	4501                	li	a0,0
 1bc:	00000097          	auipc	ra,0x0
 1c0:	240080e7          	jalr	576(ra) # 3fc <read>
    if(cc < 1)
 1c4:	00a05e63          	blez	a0,1e0 <gets+0x56>
    buf[i++] = c;
 1c8:	faf44783          	lbu	a5,-81(s0)
 1cc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1d0:	01578763          	beq	a5,s5,1de <gets+0x54>
 1d4:	0905                	addi	s2,s2,1
 1d6:	fd679be3          	bne	a5,s6,1ac <gets+0x22>
    buf[i++] = c;
 1da:	89a6                	mv	s3,s1
 1dc:	a011                	j	1e0 <gets+0x56>
 1de:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1e0:	99de                	add	s3,s3,s7
 1e2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e6:	855e                	mv	a0,s7
 1e8:	60e6                	ld	ra,88(sp)
 1ea:	6446                	ld	s0,80(sp)
 1ec:	64a6                	ld	s1,72(sp)
 1ee:	6906                	ld	s2,64(sp)
 1f0:	79e2                	ld	s3,56(sp)
 1f2:	7a42                	ld	s4,48(sp)
 1f4:	7aa2                	ld	s5,40(sp)
 1f6:	7b02                	ld	s6,32(sp)
 1f8:	6be2                	ld	s7,24(sp)
 1fa:	6125                	addi	sp,sp,96
 1fc:	8082                	ret

00000000000001fe <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
 1fe:	1141                	addi	sp,sp,-16
 200:	e422                	sd	s0,8(sp)
 202:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 204:	00054683          	lbu	a3,0(a0)
 208:	fd06879b          	addiw	a5,a3,-48
 20c:	0ff7f793          	zext.b	a5,a5
 210:	4625                	li	a2,9
 212:	02f66863          	bltu	a2,a5,242 <atoi+0x44>
 216:	872a                	mv	a4,a0
  n = 0;
 218:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 21a:	0705                	addi	a4,a4,1
 21c:	0025179b          	slliw	a5,a0,0x2
 220:	9fa9                	addw	a5,a5,a0
 222:	0017979b          	slliw	a5,a5,0x1
 226:	9fb5                	addw	a5,a5,a3
 228:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22c:	00074683          	lbu	a3,0(a4)
 230:	fd06879b          	addiw	a5,a3,-48
 234:	0ff7f793          	zext.b	a5,a5
 238:	fef671e3          	bgeu	a2,a5,21a <atoi+0x1c>
  return n;
}
 23c:	6422                	ld	s0,8(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  n = 0;
 242:	4501                	li	a0,0
 244:	bfe5                	j	23c <atoi+0x3e>

0000000000000246 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e422                	sd	s0,8(sp)
 24a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 24c:	02b57463          	bgeu	a0,a1,274 <memmove+0x2e>
    while(n-- > 0)
 250:	00c05f63          	blez	a2,26e <memmove+0x28>
 254:	1602                	slli	a2,a2,0x20
 256:	9201                	srli	a2,a2,0x20
 258:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 25c:	872a                	mv	a4,a0
      *dst++ = *src++;
 25e:	0585                	addi	a1,a1,1
 260:	0705                	addi	a4,a4,1
 262:	fff5c683          	lbu	a3,-1(a1)
 266:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 26a:	fef71ae3          	bne	a4,a5,25e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26e:	6422                	ld	s0,8(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret
    dst += n;
 274:	00c50733          	add	a4,a0,a2
    src += n;
 278:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 27a:	fec05ae3          	blez	a2,26e <memmove+0x28>
 27e:	fff6079b          	addiw	a5,a2,-1
 282:	1782                	slli	a5,a5,0x20
 284:	9381                	srli	a5,a5,0x20
 286:	fff7c793          	not	a5,a5
 28a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 28c:	15fd                	addi	a1,a1,-1
 28e:	177d                	addi	a4,a4,-1
 290:	0005c683          	lbu	a3,0(a1)
 294:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 298:	fee79ae3          	bne	a5,a4,28c <memmove+0x46>
 29c:	bfc9                	j	26e <memmove+0x28>

000000000000029e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a4:	ca05                	beqz	a2,2d4 <memcmp+0x36>
 2a6:	fff6069b          	addiw	a3,a2,-1
 2aa:	1682                	slli	a3,a3,0x20
 2ac:	9281                	srli	a3,a3,0x20
 2ae:	0685                	addi	a3,a3,1
 2b0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2b2:	00054783          	lbu	a5,0(a0)
 2b6:	0005c703          	lbu	a4,0(a1)
 2ba:	00e79863          	bne	a5,a4,2ca <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2be:	0505                	addi	a0,a0,1
    p2++;
 2c0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2c2:	fed518e3          	bne	a0,a3,2b2 <memcmp+0x14>
  }
  return 0;
 2c6:	4501                	li	a0,0
 2c8:	a019                	j	2ce <memcmp+0x30>
      return *p1 - *p2;
 2ca:	40e7853b          	subw	a0,a5,a4
}
 2ce:	6422                	ld	s0,8(sp)
 2d0:	0141                	addi	sp,sp,16
 2d2:	8082                	ret
  return 0;
 2d4:	4501                	li	a0,0
 2d6:	bfe5                	j	2ce <memcmp+0x30>

00000000000002d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d8:	1141                	addi	sp,sp,-16
 2da:	e406                	sd	ra,8(sp)
 2dc:	e022                	sd	s0,0(sp)
 2de:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2e0:	00000097          	auipc	ra,0x0
 2e4:	f66080e7          	jalr	-154(ra) # 246 <memmove>
}
 2e8:	60a2                	ld	ra,8(sp)
 2ea:	6402                	ld	s0,0(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret

00000000000002f0 <sbrk>:

char *
sbrk(int n) {
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e406                	sd	ra,8(sp)
 2f4:	e022                	sd	s0,0(sp)
 2f6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2f8:	4585                	li	a1,1
 2fa:	00000097          	auipc	ra,0x0
 2fe:	12a080e7          	jalr	298(ra) # 424 <sys_sbrk>
}
 302:	60a2                	ld	ra,8(sp)
 304:	6402                	ld	s0,0(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret

000000000000030a <get_time>:
//   return sys_sbrk(n, SBRK_LAZY);
// }


unsigned int 
get_time(void) {
 30a:	1141                	addi	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	addi	s0,sp,16
    return uptime();
 312:	00000097          	auipc	ra,0x0
 316:	11a080e7          	jalr	282(ra) # 42c <uptime>
}
 31a:	2501                	sext.w	a0,a0
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <make_filename>:
void 
make_filename(char *buf, const char *prefix, int num) {
    // 复制前缀
    char *p = buf;
    const char *s = prefix;
    while(*s) *p++ = *s++;
 324:	0005c783          	lbu	a5,0(a1)
 328:	cb81                	beqz	a5,338 <make_filename+0x14>
 32a:	0585                	addi	a1,a1,1
 32c:	0505                	addi	a0,a0,1
 32e:	fef50fa3          	sb	a5,-1(a0)
 332:	0005c783          	lbu	a5,0(a1)
 336:	fbf5                	bnez	a5,32a <make_filename+0x6>
    
    // 处理数字部分
    if (num == 0) {
 338:	ca3d                	beqz	a2,3ae <make_filename+0x8a>
make_filename(char *buf, const char *prefix, int num) {
 33a:	1101                	addi	sp,sp,-32
 33c:	ec22                	sd	s0,24(sp)
 33e:	1000                	addi	s0,sp,32
        *p++ = '0';
    } else {
        // 临时缓冲区存放数字
        char digits[16];
        int i = 0;
        while(num > 0) {
 340:	fe040893          	addi	a7,s0,-32
 344:	87c6                	mv	a5,a7
            digits[i++] = (num % 10) + '0';
 346:	46a9                	li	a3,10
        while(num > 0) {
 348:	4825                	li	a6,9
 34a:	06c05063          	blez	a2,3aa <make_filename+0x86>
            digits[i++] = (num % 10) + '0';
 34e:	02d6673b          	remw	a4,a2,a3
 352:	0307071b          	addiw	a4,a4,48
 356:	00e78023          	sb	a4,0(a5)
            num /= 10;
 35a:	85b2                	mv	a1,a2
 35c:	02d6463b          	divw	a2,a2,a3
        while(num > 0) {
 360:	873e                	mv	a4,a5
 362:	0785                	addi	a5,a5,1
 364:	feb845e3          	blt	a6,a1,34e <make_filename+0x2a>
 368:	4117073b          	subw	a4,a4,a7
 36c:	0017069b          	addiw	a3,a4,1
            digits[i++] = (num % 10) + '0';
 370:	0006879b          	sext.w	a5,a3
        }
        // 倒序写入
        while(i > 0) *p++ = digits[--i];
 374:	04f05663          	blez	a5,3c0 <make_filename+0x9c>
 378:	fe040713          	addi	a4,s0,-32
 37c:	973e                	add	a4,a4,a5
 37e:	02069593          	slli	a1,a3,0x20
 382:	9181                	srli	a1,a1,0x20
 384:	95aa                	add	a1,a1,a0
 386:	87aa                	mv	a5,a0
 388:	0785                	addi	a5,a5,1
 38a:	fff74603          	lbu	a2,-1(a4)
 38e:	fec78fa3          	sb	a2,-1(a5)
 392:	177d                	addi	a4,a4,-1
 394:	feb79ae3          	bne	a5,a1,388 <make_filename+0x64>
 398:	02069793          	slli	a5,a3,0x20
 39c:	9381                	srli	a5,a5,0x20
 39e:	97aa                	add	a5,a5,a0
    }
    *p = 0; // 字符串结束符
 3a0:	00078023          	sb	zero,0(a5)
 3a4:	6462                	ld	s0,24(sp)
 3a6:	6105                	addi	sp,sp,32
 3a8:	8082                	ret
        while(num > 0) {
 3aa:	87aa                	mv	a5,a0
 3ac:	bfd5                	j	3a0 <make_filename+0x7c>
        *p++ = '0';
 3ae:	00150793          	addi	a5,a0,1
 3b2:	03000713          	li	a4,48
 3b6:	00e50023          	sb	a4,0(a0)
    *p = 0; // 字符串结束符
 3ba:	00078023          	sb	zero,0(a5)
 3be:	8082                	ret
        while(i > 0) *p++ = digits[--i];
 3c0:	87aa                	mv	a5,a0
 3c2:	bff9                	j	3a0 <make_filename+0x7c>

00000000000003c4 <fork>:
.globl unlink
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3c4:	4885                	li	a7,1
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3cc:	4889                	li	a7,2
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d4:	488d                	li	a7,3
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3dc:	4891                	li	a7,4
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <close>:
.global close
close:
 li a7, SYS_close
 3e4:	4899                	li	a7,6
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <open>:
.global open
open:
 li a7, SYS_open
 3ec:	489d                	li	a7,7
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f4:	4895                	li	a7,5
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <read>:
.global read
read:
 li a7, SYS_read
 3fc:	48a1                	li	a7,8
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <write>:
.global write
write:
 li a7, SYS_write
 404:	48a5                	li	a7,9
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 40c:	48a9                	li	a7,10
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 414:	48ad                	li	a7,11
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 41c:	48b1                	li	a7,12
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 424:	48b5                	li	a7,13
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42c:	48b9                	li	a7,14
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 434:	48bd                	li	a7,15
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43c:	48c1                	li	a7,16
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 444:	1101                	addi	sp,sp,-32
 446:	ec06                	sd	ra,24(sp)
 448:	e822                	sd	s0,16(sp)
 44a:	1000                	addi	s0,sp,32
 44c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 450:	4605                	li	a2,1
 452:	fef40593          	addi	a1,s0,-17
 456:	00000097          	auipc	ra,0x0
 45a:	fae080e7          	jalr	-82(ra) # 404 <write>
}
 45e:	60e2                	ld	ra,24(sp)
 460:	6442                	ld	s0,16(sp)
 462:	6105                	addi	sp,sp,32
 464:	8082                	ret

0000000000000466 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 466:	715d                	addi	sp,sp,-80
 468:	e486                	sd	ra,72(sp)
 46a:	e0a2                	sd	s0,64(sp)
 46c:	f84a                	sd	s2,48(sp)
 46e:	0880                	addi	s0,sp,80
 470:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 472:	c299                	beqz	a3,478 <printint+0x12>
 474:	0805c563          	bltz	a1,4fe <printint+0x98>
  neg = 0;
 478:	4881                	li	a7,0
 47a:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 47e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 480:	00000517          	auipc	a0,0x0
 484:	5f850513          	addi	a0,a0,1528 # a78 <digits>
 488:	883e                	mv	a6,a5
 48a:	2785                	addiw	a5,a5,1
 48c:	02c5f733          	remu	a4,a1,a2
 490:	972a                	add	a4,a4,a0
 492:	00074703          	lbu	a4,0(a4)
 496:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 49a:	872e                	mv	a4,a1
 49c:	02c5d5b3          	divu	a1,a1,a2
 4a0:	0685                	addi	a3,a3,1
 4a2:	fec773e3          	bgeu	a4,a2,488 <printint+0x22>
  if(neg)
 4a6:	00088b63          	beqz	a7,4bc <printint+0x56>
    buf[i++] = '-';
 4aa:	fd078793          	addi	a5,a5,-48
 4ae:	97a2                	add	a5,a5,s0
 4b0:	02d00713          	li	a4,45
 4b4:	fee78423          	sb	a4,-24(a5)
 4b8:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4bc:	02f05c63          	blez	a5,4f4 <printint+0x8e>
 4c0:	fc26                	sd	s1,56(sp)
 4c2:	f44e                	sd	s3,40(sp)
 4c4:	fb840713          	addi	a4,s0,-72
 4c8:	00f704b3          	add	s1,a4,a5
 4cc:	fff70993          	addi	s3,a4,-1
 4d0:	99be                	add	s3,s3,a5
 4d2:	37fd                	addiw	a5,a5,-1
 4d4:	1782                	slli	a5,a5,0x20
 4d6:	9381                	srli	a5,a5,0x20
 4d8:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4dc:	fff4c583          	lbu	a1,-1(s1)
 4e0:	854a                	mv	a0,s2
 4e2:	00000097          	auipc	ra,0x0
 4e6:	f62080e7          	jalr	-158(ra) # 444 <putc>
  while(--i >= 0)
 4ea:	14fd                	addi	s1,s1,-1
 4ec:	ff3498e3          	bne	s1,s3,4dc <printint+0x76>
 4f0:	74e2                	ld	s1,56(sp)
 4f2:	79a2                	ld	s3,40(sp)
}
 4f4:	60a6                	ld	ra,72(sp)
 4f6:	6406                	ld	s0,64(sp)
 4f8:	7942                	ld	s2,48(sp)
 4fa:	6161                	addi	sp,sp,80
 4fc:	8082                	ret
    x = -xx;
 4fe:	40b005b3          	neg	a1,a1
    neg = 1;
 502:	4885                	li	a7,1
    x = -xx;
 504:	bf9d                	j	47a <printint+0x14>

0000000000000506 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 506:	711d                	addi	sp,sp,-96
 508:	ec86                	sd	ra,88(sp)
 50a:	e8a2                	sd	s0,80(sp)
 50c:	e0ca                	sd	s2,64(sp)
 50e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 510:	0005c903          	lbu	s2,0(a1)
 514:	2c090a63          	beqz	s2,7e8 <vprintf+0x2e2>
 518:	e4a6                	sd	s1,72(sp)
 51a:	fc4e                	sd	s3,56(sp)
 51c:	f852                	sd	s4,48(sp)
 51e:	f456                	sd	s5,40(sp)
 520:	f05a                	sd	s6,32(sp)
 522:	ec5e                	sd	s7,24(sp)
 524:	e862                	sd	s8,16(sp)
 526:	e466                	sd	s9,8(sp)
 528:	8b2a                	mv	s6,a0
 52a:	8a2e                	mv	s4,a1
 52c:	8bb2                	mv	s7,a2
  state = 0;
 52e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 530:	4481                	li	s1,0
 532:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 534:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 538:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 53c:	06c00c93          	li	s9,108
 540:	a015                	j	564 <vprintf+0x5e>
        putc(fd, c0);
 542:	85ca                	mv	a1,s2
 544:	855a                	mv	a0,s6
 546:	00000097          	auipc	ra,0x0
 54a:	efe080e7          	jalr	-258(ra) # 444 <putc>
 54e:	a019                	j	554 <vprintf+0x4e>
    } else if(state == '%'){
 550:	03598263          	beq	s3,s5,574 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 554:	2485                	addiw	s1,s1,1
 556:	8726                	mv	a4,s1
 558:	009a07b3          	add	a5,s4,s1
 55c:	0007c903          	lbu	s2,0(a5)
 560:	26090c63          	beqz	s2,7d8 <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 564:	0009079b          	sext.w	a5,s2
    if(state == 0){
 568:	fe0994e3          	bnez	s3,550 <vprintf+0x4a>
      if(c0 == '%'){
 56c:	fd579be3          	bne	a5,s5,542 <vprintf+0x3c>
        state = '%';
 570:	89be                	mv	s3,a5
 572:	b7cd                	j	554 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 574:	00ea06b3          	add	a3,s4,a4
 578:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 57c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 57e:	c681                	beqz	a3,586 <vprintf+0x80>
 580:	9752                	add	a4,a4,s4
 582:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 586:	05878563          	beq	a5,s8,5d0 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 58a:	07978163          	beq	a5,s9,5ec <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 58e:	07500713          	li	a4,117
 592:	10e78563          	beq	a5,a4,69c <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 596:	07800713          	li	a4,120
 59a:	14e78d63          	beq	a5,a4,6f4 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 59e:	07000713          	li	a4,112
 5a2:	18e78663          	beq	a5,a4,72e <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5a6:	06300713          	li	a4,99
 5aa:	1ce78c63          	beq	a5,a4,782 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ae:	07300713          	li	a4,115
 5b2:	1ee78463          	beq	a5,a4,79a <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5b6:	02500713          	li	a4,37
 5ba:	04e79963          	bne	a5,a4,60c <vprintf+0x106>
        putc(fd, '%');
 5be:	02500593          	li	a1,37
 5c2:	855a                	mv	a0,s6
 5c4:	00000097          	auipc	ra,0x0
 5c8:	e80080e7          	jalr	-384(ra) # 444 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	b759                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 5d0:	008b8913          	addi	s2,s7,8
 5d4:	4685                	li	a3,1
 5d6:	4629                	li	a2,10
 5d8:	000ba583          	lw	a1,0(s7)
 5dc:	855a                	mv	a0,s6
 5de:	00000097          	auipc	ra,0x0
 5e2:	e88080e7          	jalr	-376(ra) # 466 <printint>
 5e6:	8bca                	mv	s7,s2
      state = 0;
 5e8:	4981                	li	s3,0
 5ea:	b7ad                	j	554 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 5ec:	06400793          	li	a5,100
 5f0:	02f68d63          	beq	a3,a5,62a <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5f4:	06c00793          	li	a5,108
 5f8:	04f68863          	beq	a3,a5,648 <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 5fc:	07500793          	li	a5,117
 600:	0af68c63          	beq	a3,a5,6b8 <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 604:	07800793          	li	a5,120
 608:	10f68463          	beq	a3,a5,710 <vprintf+0x20a>
        putc(fd, '%');
 60c:	02500593          	li	a1,37
 610:	855a                	mv	a0,s6
 612:	00000097          	auipc	ra,0x0
 616:	e32080e7          	jalr	-462(ra) # 444 <putc>
        putc(fd, c0);
 61a:	85ca                	mv	a1,s2
 61c:	855a                	mv	a0,s6
 61e:	00000097          	auipc	ra,0x0
 622:	e26080e7          	jalr	-474(ra) # 444 <putc>
      state = 0;
 626:	4981                	li	s3,0
 628:	b735                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 62a:	008b8913          	addi	s2,s7,8
 62e:	4685                	li	a3,1
 630:	4629                	li	a2,10
 632:	000bb583          	ld	a1,0(s7)
 636:	855a                	mv	a0,s6
 638:	00000097          	auipc	ra,0x0
 63c:	e2e080e7          	jalr	-466(ra) # 466 <printint>
        i += 1;
 640:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 642:	8bca                	mv	s7,s2
      state = 0;
 644:	4981                	li	s3,0
        i += 1;
 646:	b739                	j	554 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 648:	06400793          	li	a5,100
 64c:	02f60963          	beq	a2,a5,67e <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 650:	07500793          	li	a5,117
 654:	08f60163          	beq	a2,a5,6d6 <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 658:	07800793          	li	a5,120
 65c:	faf618e3          	bne	a2,a5,60c <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 660:	008b8913          	addi	s2,s7,8
 664:	4681                	li	a3,0
 666:	4641                	li	a2,16
 668:	000bb583          	ld	a1,0(s7)
 66c:	855a                	mv	a0,s6
 66e:	00000097          	auipc	ra,0x0
 672:	df8080e7          	jalr	-520(ra) # 466 <printint>
        i += 2;
 676:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 678:	8bca                	mv	s7,s2
      state = 0;
 67a:	4981                	li	s3,0
        i += 2;
 67c:	bde1                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 67e:	008b8913          	addi	s2,s7,8
 682:	4685                	li	a3,1
 684:	4629                	li	a2,10
 686:	000bb583          	ld	a1,0(s7)
 68a:	855a                	mv	a0,s6
 68c:	00000097          	auipc	ra,0x0
 690:	dda080e7          	jalr	-550(ra) # 466 <printint>
        i += 2;
 694:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
        i += 2;
 69a:	bd6d                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 69c:	008b8913          	addi	s2,s7,8
 6a0:	4681                	li	a3,0
 6a2:	4629                	li	a2,10
 6a4:	000be583          	lwu	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	00000097          	auipc	ra,0x0
 6ae:	dbc080e7          	jalr	-580(ra) # 466 <printint>
 6b2:	8bca                	mv	s7,s2
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	bd79                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b8:	008b8913          	addi	s2,s7,8
 6bc:	4681                	li	a3,0
 6be:	4629                	li	a2,10
 6c0:	000bb583          	ld	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	00000097          	auipc	ra,0x0
 6ca:	da0080e7          	jalr	-608(ra) # 466 <printint>
        i += 1;
 6ce:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
        i += 1;
 6d4:	b541                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4681                	li	a3,0
 6dc:	4629                	li	a2,10
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	00000097          	auipc	ra,0x0
 6e8:	d82080e7          	jalr	-638(ra) # 466 <printint>
        i += 2;
 6ec:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ee:	8bca                	mv	s7,s2
      state = 0;
 6f0:	4981                	li	s3,0
        i += 2;
 6f2:	b58d                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6f4:	008b8913          	addi	s2,s7,8
 6f8:	4681                	li	a3,0
 6fa:	4641                	li	a2,16
 6fc:	000be583          	lwu	a1,0(s7)
 700:	855a                	mv	a0,s6
 702:	00000097          	auipc	ra,0x0
 706:	d64080e7          	jalr	-668(ra) # 466 <printint>
 70a:	8bca                	mv	s7,s2
      state = 0;
 70c:	4981                	li	s3,0
 70e:	b599                	j	554 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 710:	008b8913          	addi	s2,s7,8
 714:	4681                	li	a3,0
 716:	4641                	li	a2,16
 718:	000bb583          	ld	a1,0(s7)
 71c:	855a                	mv	a0,s6
 71e:	00000097          	auipc	ra,0x0
 722:	d48080e7          	jalr	-696(ra) # 466 <printint>
        i += 1;
 726:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 728:	8bca                	mv	s7,s2
      state = 0;
 72a:	4981                	li	s3,0
        i += 1;
 72c:	b525                	j	554 <vprintf+0x4e>
 72e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 730:	008b8d13          	addi	s10,s7,8
 734:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 738:	03000593          	li	a1,48
 73c:	855a                	mv	a0,s6
 73e:	00000097          	auipc	ra,0x0
 742:	d06080e7          	jalr	-762(ra) # 444 <putc>
  putc(fd, 'x');
 746:	07800593          	li	a1,120
 74a:	855a                	mv	a0,s6
 74c:	00000097          	auipc	ra,0x0
 750:	cf8080e7          	jalr	-776(ra) # 444 <putc>
 754:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 756:	00000b97          	auipc	s7,0x0
 75a:	322b8b93          	addi	s7,s7,802 # a78 <digits>
 75e:	03c9d793          	srli	a5,s3,0x3c
 762:	97de                	add	a5,a5,s7
 764:	0007c583          	lbu	a1,0(a5)
 768:	855a                	mv	a0,s6
 76a:	00000097          	auipc	ra,0x0
 76e:	cda080e7          	jalr	-806(ra) # 444 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 772:	0992                	slli	s3,s3,0x4
 774:	397d                	addiw	s2,s2,-1
 776:	fe0914e3          	bnez	s2,75e <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 77a:	8bea                	mv	s7,s10
      state = 0;
 77c:	4981                	li	s3,0
 77e:	6d02                	ld	s10,0(sp)
 780:	bbd1                	j	554 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 782:	008b8913          	addi	s2,s7,8
 786:	000bc583          	lbu	a1,0(s7)
 78a:	855a                	mv	a0,s6
 78c:	00000097          	auipc	ra,0x0
 790:	cb8080e7          	jalr	-840(ra) # 444 <putc>
 794:	8bca                	mv	s7,s2
      state = 0;
 796:	4981                	li	s3,0
 798:	bb75                	j	554 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 79a:	008b8993          	addi	s3,s7,8
 79e:	000bb903          	ld	s2,0(s7)
 7a2:	02090163          	beqz	s2,7c4 <vprintf+0x2be>
        for(; *s; s++)
 7a6:	00094583          	lbu	a1,0(s2)
 7aa:	c585                	beqz	a1,7d2 <vprintf+0x2cc>
          putc(fd, *s);
 7ac:	855a                	mv	a0,s6
 7ae:	00000097          	auipc	ra,0x0
 7b2:	c96080e7          	jalr	-874(ra) # 444 <putc>
        for(; *s; s++)
 7b6:	0905                	addi	s2,s2,1
 7b8:	00094583          	lbu	a1,0(s2)
 7bc:	f9e5                	bnez	a1,7ac <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 7be:	8bce                	mv	s7,s3
      state = 0;
 7c0:	4981                	li	s3,0
 7c2:	bb49                	j	554 <vprintf+0x4e>
          s = "(null)";
 7c4:	00000917          	auipc	s2,0x0
 7c8:	2ac90913          	addi	s2,s2,684 # a70 <malloc+0x198>
        for(; *s; s++)
 7cc:	02800593          	li	a1,40
 7d0:	bff1                	j	7ac <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 7d2:	8bce                	mv	s7,s3
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bbbd                	j	554 <vprintf+0x4e>
 7d8:	64a6                	ld	s1,72(sp)
 7da:	79e2                	ld	s3,56(sp)
 7dc:	7a42                	ld	s4,48(sp)
 7de:	7aa2                	ld	s5,40(sp)
 7e0:	7b02                	ld	s6,32(sp)
 7e2:	6be2                	ld	s7,24(sp)
 7e4:	6c42                	ld	s8,16(sp)
 7e6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7e8:	60e6                	ld	ra,88(sp)
 7ea:	6446                	ld	s0,80(sp)
 7ec:	6906                	ld	s2,64(sp)
 7ee:	6125                	addi	sp,sp,96
 7f0:	8082                	ret

00000000000007f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7f2:	715d                	addi	sp,sp,-80
 7f4:	ec06                	sd	ra,24(sp)
 7f6:	e822                	sd	s0,16(sp)
 7f8:	1000                	addi	s0,sp,32
 7fa:	e010                	sd	a2,0(s0)
 7fc:	e414                	sd	a3,8(s0)
 7fe:	e818                	sd	a4,16(s0)
 800:	ec1c                	sd	a5,24(s0)
 802:	03043023          	sd	a6,32(s0)
 806:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 80a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 80e:	8622                	mv	a2,s0
 810:	00000097          	auipc	ra,0x0
 814:	cf6080e7          	jalr	-778(ra) # 506 <vprintf>
}
 818:	60e2                	ld	ra,24(sp)
 81a:	6442                	ld	s0,16(sp)
 81c:	6161                	addi	sp,sp,80
 81e:	8082                	ret

0000000000000820 <printf>:

void
printf(const char *fmt, ...)
{
 820:	711d                	addi	sp,sp,-96
 822:	ec06                	sd	ra,24(sp)
 824:	e822                	sd	s0,16(sp)
 826:	1000                	addi	s0,sp,32
 828:	e40c                	sd	a1,8(s0)
 82a:	e810                	sd	a2,16(s0)
 82c:	ec14                	sd	a3,24(s0)
 82e:	f018                	sd	a4,32(s0)
 830:	f41c                	sd	a5,40(s0)
 832:	03043823          	sd	a6,48(s0)
 836:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 83a:	00840613          	addi	a2,s0,8
 83e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 842:	85aa                	mv	a1,a0
 844:	4505                	li	a0,1
 846:	00000097          	auipc	ra,0x0
 84a:	cc0080e7          	jalr	-832(ra) # 506 <vprintf>
}
 84e:	60e2                	ld	ra,24(sp)
 850:	6442                	ld	s0,16(sp)
 852:	6125                	addi	sp,sp,96
 854:	8082                	ret

0000000000000856 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 856:	1141                	addi	sp,sp,-16
 858:	e422                	sd	s0,8(sp)
 85a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 860:	00000797          	auipc	a5,0x0
 864:	7a07b783          	ld	a5,1952(a5) # 1000 <freep>
 868:	a02d                	j	892 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 86a:	4618                	lw	a4,8(a2)
 86c:	9f2d                	addw	a4,a4,a1
 86e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 872:	6398                	ld	a4,0(a5)
 874:	6310                	ld	a2,0(a4)
 876:	a83d                	j	8b4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 878:	ff852703          	lw	a4,-8(a0)
 87c:	9f31                	addw	a4,a4,a2
 87e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 880:	ff053683          	ld	a3,-16(a0)
 884:	a091                	j	8c8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	6398                	ld	a4,0(a5)
 888:	00e7e463          	bltu	a5,a4,890 <free+0x3a>
 88c:	00e6ea63          	bltu	a3,a4,8a0 <free+0x4a>
{
 890:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 892:	fed7fae3          	bgeu	a5,a3,886 <free+0x30>
 896:	6398                	ld	a4,0(a5)
 898:	00e6e463          	bltu	a3,a4,8a0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89c:	fee7eae3          	bltu	a5,a4,890 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8a0:	ff852583          	lw	a1,-8(a0)
 8a4:	6390                	ld	a2,0(a5)
 8a6:	02059813          	slli	a6,a1,0x20
 8aa:	01c85713          	srli	a4,a6,0x1c
 8ae:	9736                	add	a4,a4,a3
 8b0:	fae60de3          	beq	a2,a4,86a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8b4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8b8:	4790                	lw	a2,8(a5)
 8ba:	02061593          	slli	a1,a2,0x20
 8be:	01c5d713          	srli	a4,a1,0x1c
 8c2:	973e                	add	a4,a4,a5
 8c4:	fae68ae3          	beq	a3,a4,878 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8c8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ca:	00000717          	auipc	a4,0x0
 8ce:	72f73b23          	sd	a5,1846(a4) # 1000 <freep>
}
 8d2:	6422                	ld	s0,8(sp)
 8d4:	0141                	addi	sp,sp,16
 8d6:	8082                	ret

00000000000008d8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d8:	7139                	addi	sp,sp,-64
 8da:	fc06                	sd	ra,56(sp)
 8dc:	f822                	sd	s0,48(sp)
 8de:	f426                	sd	s1,40(sp)
 8e0:	ec4e                	sd	s3,24(sp)
 8e2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e4:	02051493          	slli	s1,a0,0x20
 8e8:	9081                	srli	s1,s1,0x20
 8ea:	04bd                	addi	s1,s1,15
 8ec:	8091                	srli	s1,s1,0x4
 8ee:	0014899b          	addiw	s3,s1,1
 8f2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8f4:	00000517          	auipc	a0,0x0
 8f8:	70c53503          	ld	a0,1804(a0) # 1000 <freep>
 8fc:	c915                	beqz	a0,930 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 900:	4798                	lw	a4,8(a5)
 902:	08977e63          	bgeu	a4,s1,99e <malloc+0xc6>
 906:	f04a                	sd	s2,32(sp)
 908:	e852                	sd	s4,16(sp)
 90a:	e456                	sd	s5,8(sp)
 90c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 90e:	8a4e                	mv	s4,s3
 910:	0009871b          	sext.w	a4,s3
 914:	6685                	lui	a3,0x1
 916:	00d77363          	bgeu	a4,a3,91c <malloc+0x44>
 91a:	6a05                	lui	s4,0x1
 91c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 920:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 924:	00000917          	auipc	s2,0x0
 928:	6dc90913          	addi	s2,s2,1756 # 1000 <freep>
  if(p == SBRK_ERROR)
 92c:	5afd                	li	s5,-1
 92e:	a091                	j	972 <malloc+0x9a>
 930:	f04a                	sd	s2,32(sp)
 932:	e852                	sd	s4,16(sp)
 934:	e456                	sd	s5,8(sp)
 936:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 938:	00000797          	auipc	a5,0x0
 93c:	6d878793          	addi	a5,a5,1752 # 1010 <base>
 940:	00000717          	auipc	a4,0x0
 944:	6cf73023          	sd	a5,1728(a4) # 1000 <freep>
 948:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 94a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 94e:	b7c1                	j	90e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 950:	6398                	ld	a4,0(a5)
 952:	e118                	sd	a4,0(a0)
 954:	a08d                	j	9b6 <malloc+0xde>
  hp->s.size = nu;
 956:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95a:	0541                	addi	a0,a0,16
 95c:	00000097          	auipc	ra,0x0
 960:	efa080e7          	jalr	-262(ra) # 856 <free>
  return freep;
 964:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 968:	c13d                	beqz	a0,9ce <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96c:	4798                	lw	a4,8(a5)
 96e:	02977463          	bgeu	a4,s1,996 <malloc+0xbe>
    if(p == freep)
 972:	00093703          	ld	a4,0(s2)
 976:	853e                	mv	a0,a5
 978:	fef719e3          	bne	a4,a5,96a <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 97c:	8552                	mv	a0,s4
 97e:	00000097          	auipc	ra,0x0
 982:	972080e7          	jalr	-1678(ra) # 2f0 <sbrk>
  if(p == SBRK_ERROR)
 986:	fd5518e3          	bne	a0,s5,956 <malloc+0x7e>
        return 0;
 98a:	4501                	li	a0,0
 98c:	7902                	ld	s2,32(sp)
 98e:	6a42                	ld	s4,16(sp)
 990:	6aa2                	ld	s5,8(sp)
 992:	6b02                	ld	s6,0(sp)
 994:	a03d                	j	9c2 <malloc+0xea>
 996:	7902                	ld	s2,32(sp)
 998:	6a42                	ld	s4,16(sp)
 99a:	6aa2                	ld	s5,8(sp)
 99c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 99e:	fae489e3          	beq	s1,a4,950 <malloc+0x78>
        p->s.size -= nunits;
 9a2:	4137073b          	subw	a4,a4,s3
 9a6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a8:	02071693          	slli	a3,a4,0x20
 9ac:	01c6d713          	srli	a4,a3,0x1c
 9b0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9b2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9b6:	00000717          	auipc	a4,0x0
 9ba:	64a73523          	sd	a0,1610(a4) # 1000 <freep>
      return (void*)(p + 1);
 9be:	01078513          	addi	a0,a5,16
  }
}
 9c2:	70e2                	ld	ra,56(sp)
 9c4:	7442                	ld	s0,48(sp)
 9c6:	74a2                	ld	s1,40(sp)
 9c8:	69e2                	ld	s3,24(sp)
 9ca:	6121                	addi	sp,sp,64
 9cc:	8082                	ret
 9ce:	7902                	ld	s2,32(sp)
 9d0:	6a42                	ld	s4,16(sp)
 9d2:	6aa2                	ld	s5,8(sp)
 9d4:	6b02                	ld	s6,0(sp)
 9d6:	b7f5                	j	9c2 <malloc+0xea>
