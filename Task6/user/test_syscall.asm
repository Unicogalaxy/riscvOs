
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
   c:	90850513          	addi	a0,a0,-1784 # 910 <malloc+0x10a>
  10:	00000097          	auipc	ra,0x0
  14:	73e080e7          	jalr	1854(ra) # 74e <printf>

  //测试getpid
  int pid = getpid();
  18:	00000097          	auipc	ra,0x0
  1c:	30a080e7          	jalr	778(ra) # 322 <getpid>
  20:	85aa                	mv	a1,a0
  printf("Current PID: %d\n",pid);
  22:	00001517          	auipc	a0,0x1
  26:	91650513          	addi	a0,a0,-1770 # 938 <malloc+0x132>
  2a:	00000097          	auipc	ra,0x0
  2e:	724080e7          	jalr	1828(ra) # 74e <printf>

  //测试fork
  int child_pid = fork();
  32:	00000097          	auipc	ra,0x0
  36:	2d8080e7          	jalr	728(ra) # 30a <fork>
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
  48:	2d6080e7          	jalr	726(ra) # 31a <wait>
    printf("Child exited with status: %d\n", status);
  4c:	fec42583          	lw	a1,-20(s0)
  50:	00001517          	auipc	a0,0x1
  54:	92050513          	addi	a0,a0,-1760 # 970 <malloc+0x16a>
  58:	00000097          	auipc	ra,0x0
  5c:	6f6080e7          	jalr	1782(ra) # 74e <printf>
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
  6c:	2ba080e7          	jalr	698(ra) # 322 <getpid>
  70:	85aa                	mv	a1,a0
  72:	00001517          	auipc	a0,0x1
  76:	8de50513          	addi	a0,a0,-1826 # 950 <malloc+0x14a>
  7a:	00000097          	auipc	ra,0x0
  7e:	6d4080e7          	jalr	1748(ra) # 74e <printf>
    exit(42);
  82:	02a00513          	li	a0,42
  86:	00000097          	auipc	ra,0x0
  8a:	28c080e7          	jalr	652(ra) # 312 <exit>
    printf("Fork failed\n");
  8e:	00001517          	auipc	a0,0x1
  92:	90250513          	addi	a0,a0,-1790 # 990 <malloc+0x18a>
  96:	00000097          	auipc	ra,0x0
  9a:	6b8080e7          	jalr	1720(ra) # 74e <printf>
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
  b6:	260080e7          	jalr	608(ra) # 312 <exit>

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
  ce:	248080e7          	jalr	584(ra) # 312 <exit>

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
 1c0:	186080e7          	jalr	390(ra) # 342 <read>
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
 2fe:	070080e7          	jalr	112(ra) # 36a <sys_sbrk>
}
 302:	60a2                	ld	ra,8(sp)
 304:	6402                	ld	s0,0(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret

000000000000030a <fork>:
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 30a:	4885                	li	a7,1
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <exit>:
.global exit
exit:
 li a7, SYS_exit
 312:	4889                	li	a7,2
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <wait>:
.global wait
wait:
 li a7, SYS_wait
 31a:	488d                	li	a7,3
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 322:	4891                	li	a7,4
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <close>:
.global close
close:
 li a7, SYS_close
 32a:	4899                	li	a7,6
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <open>:
.global open
open:
 li a7, SYS_open
 332:	489d                	li	a7,7
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <exec>:
.global exec
exec:
 li a7, SYS_exec
 33a:	4895                	li	a7,5
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <read>:
.global read
read:
 li a7, SYS_read
 342:	48a1                	li	a7,8
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <write>:
.global write
write:
 li a7, SYS_write
 34a:	48a5                	li	a7,9
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 352:	48a9                	li	a7,10
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 35a:	48ad                	li	a7,11
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 362:	48b1                	li	a7,12
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 36a:	48b5                	li	a7,13
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 372:	1101                	addi	sp,sp,-32
 374:	ec06                	sd	ra,24(sp)
 376:	e822                	sd	s0,16(sp)
 378:	1000                	addi	s0,sp,32
 37a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 37e:	4605                	li	a2,1
 380:	fef40593          	addi	a1,s0,-17
 384:	00000097          	auipc	ra,0x0
 388:	fc6080e7          	jalr	-58(ra) # 34a <write>
}
 38c:	60e2                	ld	ra,24(sp)
 38e:	6442                	ld	s0,16(sp)
 390:	6105                	addi	sp,sp,32
 392:	8082                	ret

0000000000000394 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 394:	715d                	addi	sp,sp,-80
 396:	e486                	sd	ra,72(sp)
 398:	e0a2                	sd	s0,64(sp)
 39a:	f84a                	sd	s2,48(sp)
 39c:	0880                	addi	s0,sp,80
 39e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 3a0:	c299                	beqz	a3,3a6 <printint+0x12>
 3a2:	0805c563          	bltz	a1,42c <printint+0x98>
  neg = 0;
 3a6:	4881                	li	a7,0
 3a8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3ac:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3ae:	00000517          	auipc	a0,0x0
 3b2:	5fa50513          	addi	a0,a0,1530 # 9a8 <digits>
 3b6:	883e                	mv	a6,a5
 3b8:	2785                	addiw	a5,a5,1
 3ba:	02c5f733          	remu	a4,a1,a2
 3be:	972a                	add	a4,a4,a0
 3c0:	00074703          	lbu	a4,0(a4)
 3c4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3c8:	872e                	mv	a4,a1
 3ca:	02c5d5b3          	divu	a1,a1,a2
 3ce:	0685                	addi	a3,a3,1
 3d0:	fec773e3          	bgeu	a4,a2,3b6 <printint+0x22>
  if(neg)
 3d4:	00088b63          	beqz	a7,3ea <printint+0x56>
    buf[i++] = '-';
 3d8:	fd078793          	addi	a5,a5,-48
 3dc:	97a2                	add	a5,a5,s0
 3de:	02d00713          	li	a4,45
 3e2:	fee78423          	sb	a4,-24(a5)
 3e6:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 3ea:	02f05c63          	blez	a5,422 <printint+0x8e>
 3ee:	fc26                	sd	s1,56(sp)
 3f0:	f44e                	sd	s3,40(sp)
 3f2:	fb840713          	addi	a4,s0,-72
 3f6:	00f704b3          	add	s1,a4,a5
 3fa:	fff70993          	addi	s3,a4,-1
 3fe:	99be                	add	s3,s3,a5
 400:	37fd                	addiw	a5,a5,-1
 402:	1782                	slli	a5,a5,0x20
 404:	9381                	srli	a5,a5,0x20
 406:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 40a:	fff4c583          	lbu	a1,-1(s1)
 40e:	854a                	mv	a0,s2
 410:	00000097          	auipc	ra,0x0
 414:	f62080e7          	jalr	-158(ra) # 372 <putc>
  while(--i >= 0)
 418:	14fd                	addi	s1,s1,-1
 41a:	ff3498e3          	bne	s1,s3,40a <printint+0x76>
 41e:	74e2                	ld	s1,56(sp)
 420:	79a2                	ld	s3,40(sp)
}
 422:	60a6                	ld	ra,72(sp)
 424:	6406                	ld	s0,64(sp)
 426:	7942                	ld	s2,48(sp)
 428:	6161                	addi	sp,sp,80
 42a:	8082                	ret
    x = -xx;
 42c:	40b005b3          	neg	a1,a1
    neg = 1;
 430:	4885                	li	a7,1
    x = -xx;
 432:	bf9d                	j	3a8 <printint+0x14>

0000000000000434 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 434:	711d                	addi	sp,sp,-96
 436:	ec86                	sd	ra,88(sp)
 438:	e8a2                	sd	s0,80(sp)
 43a:	e0ca                	sd	s2,64(sp)
 43c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 43e:	0005c903          	lbu	s2,0(a1)
 442:	2c090a63          	beqz	s2,716 <vprintf+0x2e2>
 446:	e4a6                	sd	s1,72(sp)
 448:	fc4e                	sd	s3,56(sp)
 44a:	f852                	sd	s4,48(sp)
 44c:	f456                	sd	s5,40(sp)
 44e:	f05a                	sd	s6,32(sp)
 450:	ec5e                	sd	s7,24(sp)
 452:	e862                	sd	s8,16(sp)
 454:	e466                	sd	s9,8(sp)
 456:	8b2a                	mv	s6,a0
 458:	8a2e                	mv	s4,a1
 45a:	8bb2                	mv	s7,a2
  state = 0;
 45c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 45e:	4481                	li	s1,0
 460:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 462:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 466:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 46a:	06c00c93          	li	s9,108
 46e:	a015                	j	492 <vprintf+0x5e>
        putc(fd, c0);
 470:	85ca                	mv	a1,s2
 472:	855a                	mv	a0,s6
 474:	00000097          	auipc	ra,0x0
 478:	efe080e7          	jalr	-258(ra) # 372 <putc>
 47c:	a019                	j	482 <vprintf+0x4e>
    } else if(state == '%'){
 47e:	03598263          	beq	s3,s5,4a2 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 482:	2485                	addiw	s1,s1,1
 484:	8726                	mv	a4,s1
 486:	009a07b3          	add	a5,s4,s1
 48a:	0007c903          	lbu	s2,0(a5)
 48e:	26090c63          	beqz	s2,706 <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 492:	0009079b          	sext.w	a5,s2
    if(state == 0){
 496:	fe0994e3          	bnez	s3,47e <vprintf+0x4a>
      if(c0 == '%'){
 49a:	fd579be3          	bne	a5,s5,470 <vprintf+0x3c>
        state = '%';
 49e:	89be                	mv	s3,a5
 4a0:	b7cd                	j	482 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 4a2:	00ea06b3          	add	a3,s4,a4
 4a6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4aa:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4ac:	c681                	beqz	a3,4b4 <vprintf+0x80>
 4ae:	9752                	add	a4,a4,s4
 4b0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4b4:	05878563          	beq	a5,s8,4fe <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 4b8:	07978163          	beq	a5,s9,51a <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4bc:	07500713          	li	a4,117
 4c0:	10e78563          	beq	a5,a4,5ca <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4c4:	07800713          	li	a4,120
 4c8:	14e78d63          	beq	a5,a4,622 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4cc:	07000713          	li	a4,112
 4d0:	18e78663          	beq	a5,a4,65c <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 4d4:	06300713          	li	a4,99
 4d8:	1ce78c63          	beq	a5,a4,6b0 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 4dc:	07300713          	li	a4,115
 4e0:	1ee78463          	beq	a5,a4,6c8 <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 4e4:	02500713          	li	a4,37
 4e8:	04e79963          	bne	a5,a4,53a <vprintf+0x106>
        putc(fd, '%');
 4ec:	02500593          	li	a1,37
 4f0:	855a                	mv	a0,s6
 4f2:	00000097          	auipc	ra,0x0
 4f6:	e80080e7          	jalr	-384(ra) # 372 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 4fa:	4981                	li	s3,0
 4fc:	b759                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 4fe:	008b8913          	addi	s2,s7,8
 502:	4685                	li	a3,1
 504:	4629                	li	a2,10
 506:	000ba583          	lw	a1,0(s7)
 50a:	855a                	mv	a0,s6
 50c:	00000097          	auipc	ra,0x0
 510:	e88080e7          	jalr	-376(ra) # 394 <printint>
 514:	8bca                	mv	s7,s2
      state = 0;
 516:	4981                	li	s3,0
 518:	b7ad                	j	482 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 51a:	06400793          	li	a5,100
 51e:	02f68d63          	beq	a3,a5,558 <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 522:	06c00793          	li	a5,108
 526:	04f68863          	beq	a3,a5,576 <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 52a:	07500793          	li	a5,117
 52e:	0af68c63          	beq	a3,a5,5e6 <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 532:	07800793          	li	a5,120
 536:	10f68463          	beq	a3,a5,63e <vprintf+0x20a>
        putc(fd, '%');
 53a:	02500593          	li	a1,37
 53e:	855a                	mv	a0,s6
 540:	00000097          	auipc	ra,0x0
 544:	e32080e7          	jalr	-462(ra) # 372 <putc>
        putc(fd, c0);
 548:	85ca                	mv	a1,s2
 54a:	855a                	mv	a0,s6
 54c:	00000097          	auipc	ra,0x0
 550:	e26080e7          	jalr	-474(ra) # 372 <putc>
      state = 0;
 554:	4981                	li	s3,0
 556:	b735                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 558:	008b8913          	addi	s2,s7,8
 55c:	4685                	li	a3,1
 55e:	4629                	li	a2,10
 560:	000bb583          	ld	a1,0(s7)
 564:	855a                	mv	a0,s6
 566:	00000097          	auipc	ra,0x0
 56a:	e2e080e7          	jalr	-466(ra) # 394 <printint>
        i += 1;
 56e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 570:	8bca                	mv	s7,s2
      state = 0;
 572:	4981                	li	s3,0
        i += 1;
 574:	b739                	j	482 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 576:	06400793          	li	a5,100
 57a:	02f60963          	beq	a2,a5,5ac <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 57e:	07500793          	li	a5,117
 582:	08f60163          	beq	a2,a5,604 <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 586:	07800793          	li	a5,120
 58a:	faf618e3          	bne	a2,a5,53a <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 58e:	008b8913          	addi	s2,s7,8
 592:	4681                	li	a3,0
 594:	4641                	li	a2,16
 596:	000bb583          	ld	a1,0(s7)
 59a:	855a                	mv	a0,s6
 59c:	00000097          	auipc	ra,0x0
 5a0:	df8080e7          	jalr	-520(ra) # 394 <printint>
        i += 2;
 5a4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5a6:	8bca                	mv	s7,s2
      state = 0;
 5a8:	4981                	li	s3,0
        i += 2;
 5aa:	bde1                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ac:	008b8913          	addi	s2,s7,8
 5b0:	4685                	li	a3,1
 5b2:	4629                	li	a2,10
 5b4:	000bb583          	ld	a1,0(s7)
 5b8:	855a                	mv	a0,s6
 5ba:	00000097          	auipc	ra,0x0
 5be:	dda080e7          	jalr	-550(ra) # 394 <printint>
        i += 2;
 5c2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c4:	8bca                	mv	s7,s2
      state = 0;
 5c6:	4981                	li	s3,0
        i += 2;
 5c8:	bd6d                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5ca:	008b8913          	addi	s2,s7,8
 5ce:	4681                	li	a3,0
 5d0:	4629                	li	a2,10
 5d2:	000be583          	lwu	a1,0(s7)
 5d6:	855a                	mv	a0,s6
 5d8:	00000097          	auipc	ra,0x0
 5dc:	dbc080e7          	jalr	-580(ra) # 394 <printint>
 5e0:	8bca                	mv	s7,s2
      state = 0;
 5e2:	4981                	li	s3,0
 5e4:	bd79                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e6:	008b8913          	addi	s2,s7,8
 5ea:	4681                	li	a3,0
 5ec:	4629                	li	a2,10
 5ee:	000bb583          	ld	a1,0(s7)
 5f2:	855a                	mv	a0,s6
 5f4:	00000097          	auipc	ra,0x0
 5f8:	da0080e7          	jalr	-608(ra) # 394 <printint>
        i += 1;
 5fc:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5fe:	8bca                	mv	s7,s2
      state = 0;
 600:	4981                	li	s3,0
        i += 1;
 602:	b541                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 604:	008b8913          	addi	s2,s7,8
 608:	4681                	li	a3,0
 60a:	4629                	li	a2,10
 60c:	000bb583          	ld	a1,0(s7)
 610:	855a                	mv	a0,s6
 612:	00000097          	auipc	ra,0x0
 616:	d82080e7          	jalr	-638(ra) # 394 <printint>
        i += 2;
 61a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 61c:	8bca                	mv	s7,s2
      state = 0;
 61e:	4981                	li	s3,0
        i += 2;
 620:	b58d                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 622:	008b8913          	addi	s2,s7,8
 626:	4681                	li	a3,0
 628:	4641                	li	a2,16
 62a:	000be583          	lwu	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	00000097          	auipc	ra,0x0
 634:	d64080e7          	jalr	-668(ra) # 394 <printint>
 638:	8bca                	mv	s7,s2
      state = 0;
 63a:	4981                	li	s3,0
 63c:	b599                	j	482 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 63e:	008b8913          	addi	s2,s7,8
 642:	4681                	li	a3,0
 644:	4641                	li	a2,16
 646:	000bb583          	ld	a1,0(s7)
 64a:	855a                	mv	a0,s6
 64c:	00000097          	auipc	ra,0x0
 650:	d48080e7          	jalr	-696(ra) # 394 <printint>
        i += 1;
 654:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 656:	8bca                	mv	s7,s2
      state = 0;
 658:	4981                	li	s3,0
        i += 1;
 65a:	b525                	j	482 <vprintf+0x4e>
 65c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 65e:	008b8d13          	addi	s10,s7,8
 662:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 666:	03000593          	li	a1,48
 66a:	855a                	mv	a0,s6
 66c:	00000097          	auipc	ra,0x0
 670:	d06080e7          	jalr	-762(ra) # 372 <putc>
  putc(fd, 'x');
 674:	07800593          	li	a1,120
 678:	855a                	mv	a0,s6
 67a:	00000097          	auipc	ra,0x0
 67e:	cf8080e7          	jalr	-776(ra) # 372 <putc>
 682:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 684:	00000b97          	auipc	s7,0x0
 688:	324b8b93          	addi	s7,s7,804 # 9a8 <digits>
 68c:	03c9d793          	srli	a5,s3,0x3c
 690:	97de                	add	a5,a5,s7
 692:	0007c583          	lbu	a1,0(a5)
 696:	855a                	mv	a0,s6
 698:	00000097          	auipc	ra,0x0
 69c:	cda080e7          	jalr	-806(ra) # 372 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a0:	0992                	slli	s3,s3,0x4
 6a2:	397d                	addiw	s2,s2,-1
 6a4:	fe0914e3          	bnez	s2,68c <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 6a8:	8bea                	mv	s7,s10
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	6d02                	ld	s10,0(sp)
 6ae:	bbd1                	j	482 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 6b0:	008b8913          	addi	s2,s7,8
 6b4:	000bc583          	lbu	a1,0(s7)
 6b8:	855a                	mv	a0,s6
 6ba:	00000097          	auipc	ra,0x0
 6be:	cb8080e7          	jalr	-840(ra) # 372 <putc>
 6c2:	8bca                	mv	s7,s2
      state = 0;
 6c4:	4981                	li	s3,0
 6c6:	bb75                	j	482 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 6c8:	008b8993          	addi	s3,s7,8
 6cc:	000bb903          	ld	s2,0(s7)
 6d0:	02090163          	beqz	s2,6f2 <vprintf+0x2be>
        for(; *s; s++)
 6d4:	00094583          	lbu	a1,0(s2)
 6d8:	c585                	beqz	a1,700 <vprintf+0x2cc>
          putc(fd, *s);
 6da:	855a                	mv	a0,s6
 6dc:	00000097          	auipc	ra,0x0
 6e0:	c96080e7          	jalr	-874(ra) # 372 <putc>
        for(; *s; s++)
 6e4:	0905                	addi	s2,s2,1
 6e6:	00094583          	lbu	a1,0(s2)
 6ea:	f9e5                	bnez	a1,6da <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 6ec:	8bce                	mv	s7,s3
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	bb49                	j	482 <vprintf+0x4e>
          s = "(null)";
 6f2:	00000917          	auipc	s2,0x0
 6f6:	2ae90913          	addi	s2,s2,686 # 9a0 <malloc+0x19a>
        for(; *s; s++)
 6fa:	02800593          	li	a1,40
 6fe:	bff1                	j	6da <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 700:	8bce                	mv	s7,s3
      state = 0;
 702:	4981                	li	s3,0
 704:	bbbd                	j	482 <vprintf+0x4e>
 706:	64a6                	ld	s1,72(sp)
 708:	79e2                	ld	s3,56(sp)
 70a:	7a42                	ld	s4,48(sp)
 70c:	7aa2                	ld	s5,40(sp)
 70e:	7b02                	ld	s6,32(sp)
 710:	6be2                	ld	s7,24(sp)
 712:	6c42                	ld	s8,16(sp)
 714:	6ca2                	ld	s9,8(sp)
    }
  }
}
 716:	60e6                	ld	ra,88(sp)
 718:	6446                	ld	s0,80(sp)
 71a:	6906                	ld	s2,64(sp)
 71c:	6125                	addi	sp,sp,96
 71e:	8082                	ret

0000000000000720 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 720:	715d                	addi	sp,sp,-80
 722:	ec06                	sd	ra,24(sp)
 724:	e822                	sd	s0,16(sp)
 726:	1000                	addi	s0,sp,32
 728:	e010                	sd	a2,0(s0)
 72a:	e414                	sd	a3,8(s0)
 72c:	e818                	sd	a4,16(s0)
 72e:	ec1c                	sd	a5,24(s0)
 730:	03043023          	sd	a6,32(s0)
 734:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 738:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 73c:	8622                	mv	a2,s0
 73e:	00000097          	auipc	ra,0x0
 742:	cf6080e7          	jalr	-778(ra) # 434 <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6161                	addi	sp,sp,80
 74c:	8082                	ret

000000000000074e <printf>:

void
printf(const char *fmt, ...)
{
 74e:	711d                	addi	sp,sp,-96
 750:	ec06                	sd	ra,24(sp)
 752:	e822                	sd	s0,16(sp)
 754:	1000                	addi	s0,sp,32
 756:	e40c                	sd	a1,8(s0)
 758:	e810                	sd	a2,16(s0)
 75a:	ec14                	sd	a3,24(s0)
 75c:	f018                	sd	a4,32(s0)
 75e:	f41c                	sd	a5,40(s0)
 760:	03043823          	sd	a6,48(s0)
 764:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 768:	00840613          	addi	a2,s0,8
 76c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 770:	85aa                	mv	a1,a0
 772:	4505                	li	a0,1
 774:	00000097          	auipc	ra,0x0
 778:	cc0080e7          	jalr	-832(ra) # 434 <vprintf>
}
 77c:	60e2                	ld	ra,24(sp)
 77e:	6442                	ld	s0,16(sp)
 780:	6125                	addi	sp,sp,96
 782:	8082                	ret

0000000000000784 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 784:	1141                	addi	sp,sp,-16
 786:	e422                	sd	s0,8(sp)
 788:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78e:	00001797          	auipc	a5,0x1
 792:	8727b783          	ld	a5,-1934(a5) # 1000 <freep>
 796:	a02d                	j	7c0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 798:	4618                	lw	a4,8(a2)
 79a:	9f2d                	addw	a4,a4,a1
 79c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a0:	6398                	ld	a4,0(a5)
 7a2:	6310                	ld	a2,0(a4)
 7a4:	a83d                	j	7e2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7a6:	ff852703          	lw	a4,-8(a0)
 7aa:	9f31                	addw	a4,a4,a2
 7ac:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7ae:	ff053683          	ld	a3,-16(a0)
 7b2:	a091                	j	7f6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b4:	6398                	ld	a4,0(a5)
 7b6:	00e7e463          	bltu	a5,a4,7be <free+0x3a>
 7ba:	00e6ea63          	bltu	a3,a4,7ce <free+0x4a>
{
 7be:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c0:	fed7fae3          	bgeu	a5,a3,7b4 <free+0x30>
 7c4:	6398                	ld	a4,0(a5)
 7c6:	00e6e463          	bltu	a3,a4,7ce <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ca:	fee7eae3          	bltu	a5,a4,7be <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7ce:	ff852583          	lw	a1,-8(a0)
 7d2:	6390                	ld	a2,0(a5)
 7d4:	02059813          	slli	a6,a1,0x20
 7d8:	01c85713          	srli	a4,a6,0x1c
 7dc:	9736                	add	a4,a4,a3
 7de:	fae60de3          	beq	a2,a4,798 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7e6:	4790                	lw	a2,8(a5)
 7e8:	02061593          	slli	a1,a2,0x20
 7ec:	01c5d713          	srli	a4,a1,0x1c
 7f0:	973e                	add	a4,a4,a5
 7f2:	fae68ae3          	beq	a3,a4,7a6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7f6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7f8:	00001717          	auipc	a4,0x1
 7fc:	80f73423          	sd	a5,-2040(a4) # 1000 <freep>
}
 800:	6422                	ld	s0,8(sp)
 802:	0141                	addi	sp,sp,16
 804:	8082                	ret

0000000000000806 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 806:	7139                	addi	sp,sp,-64
 808:	fc06                	sd	ra,56(sp)
 80a:	f822                	sd	s0,48(sp)
 80c:	f426                	sd	s1,40(sp)
 80e:	ec4e                	sd	s3,24(sp)
 810:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	02051493          	slli	s1,a0,0x20
 816:	9081                	srli	s1,s1,0x20
 818:	04bd                	addi	s1,s1,15
 81a:	8091                	srli	s1,s1,0x4
 81c:	0014899b          	addiw	s3,s1,1
 820:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 822:	00000517          	auipc	a0,0x0
 826:	7de53503          	ld	a0,2014(a0) # 1000 <freep>
 82a:	c915                	beqz	a0,85e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 82e:	4798                	lw	a4,8(a5)
 830:	08977e63          	bgeu	a4,s1,8cc <malloc+0xc6>
 834:	f04a                	sd	s2,32(sp)
 836:	e852                	sd	s4,16(sp)
 838:	e456                	sd	s5,8(sp)
 83a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 83c:	8a4e                	mv	s4,s3
 83e:	0009871b          	sext.w	a4,s3
 842:	6685                	lui	a3,0x1
 844:	00d77363          	bgeu	a4,a3,84a <malloc+0x44>
 848:	6a05                	lui	s4,0x1
 84a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 84e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 852:	00000917          	auipc	s2,0x0
 856:	7ae90913          	addi	s2,s2,1966 # 1000 <freep>
  if(p == SBRK_ERROR)
 85a:	5afd                	li	s5,-1
 85c:	a091                	j	8a0 <malloc+0x9a>
 85e:	f04a                	sd	s2,32(sp)
 860:	e852                	sd	s4,16(sp)
 862:	e456                	sd	s5,8(sp)
 864:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 866:	00000797          	auipc	a5,0x0
 86a:	7aa78793          	addi	a5,a5,1962 # 1010 <base>
 86e:	00000717          	auipc	a4,0x0
 872:	78f73923          	sd	a5,1938(a4) # 1000 <freep>
 876:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 878:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 87c:	b7c1                	j	83c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 87e:	6398                	ld	a4,0(a5)
 880:	e118                	sd	a4,0(a0)
 882:	a08d                	j	8e4 <malloc+0xde>
  hp->s.size = nu;
 884:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 888:	0541                	addi	a0,a0,16
 88a:	00000097          	auipc	ra,0x0
 88e:	efa080e7          	jalr	-262(ra) # 784 <free>
  return freep;
 892:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 896:	c13d                	beqz	a0,8fc <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 898:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 89a:	4798                	lw	a4,8(a5)
 89c:	02977463          	bgeu	a4,s1,8c4 <malloc+0xbe>
    if(p == freep)
 8a0:	00093703          	ld	a4,0(s2)
 8a4:	853e                	mv	a0,a5
 8a6:	fef719e3          	bne	a4,a5,898 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 8aa:	8552                	mv	a0,s4
 8ac:	00000097          	auipc	ra,0x0
 8b0:	a44080e7          	jalr	-1468(ra) # 2f0 <sbrk>
  if(p == SBRK_ERROR)
 8b4:	fd5518e3          	bne	a0,s5,884 <malloc+0x7e>
        return 0;
 8b8:	4501                	li	a0,0
 8ba:	7902                	ld	s2,32(sp)
 8bc:	6a42                	ld	s4,16(sp)
 8be:	6aa2                	ld	s5,8(sp)
 8c0:	6b02                	ld	s6,0(sp)
 8c2:	a03d                	j	8f0 <malloc+0xea>
 8c4:	7902                	ld	s2,32(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8cc:	fae489e3          	beq	s1,a4,87e <malloc+0x78>
        p->s.size -= nunits;
 8d0:	4137073b          	subw	a4,a4,s3
 8d4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8d6:	02071693          	slli	a3,a4,0x20
 8da:	01c6d713          	srli	a4,a3,0x1c
 8de:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8e0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8e4:	00000717          	auipc	a4,0x0
 8e8:	70a73e23          	sd	a0,1820(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ec:	01078513          	addi	a0,a5,16
  }
}
 8f0:	70e2                	ld	ra,56(sp)
 8f2:	7442                	ld	s0,48(sp)
 8f4:	74a2                	ld	s1,40(sp)
 8f6:	69e2                	ld	s3,24(sp)
 8f8:	6121                	addi	sp,sp,64
 8fa:	8082                	ret
 8fc:	7902                	ld	s2,32(sp)
 8fe:	6a42                	ld	s4,16(sp)
 900:	6aa2                	ld	s5,8(sp)
 902:	6b02                	ld	s6,0(sp)
 904:	b7f5                	j	8f0 <malloc+0xea>
