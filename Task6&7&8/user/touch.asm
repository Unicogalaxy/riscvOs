
user/_touch:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
  return 0;
}

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	0080                	addi	s0,sp,64
  if(argc < 2){
   8:	4785                	li	a5,1
   a:	04a7dc63          	bge	a5,a0,62 <main+0x62>
   e:	f426                	sd	s1,40(sp)
  10:	f04a                	sd	s2,32(sp)
  12:	ec4e                	sd	s3,24(sp)
  14:	e852                	sd	s4,16(sp)
  16:	e456                	sd	s5,8(sp)
  18:	00858493          	addi	s1,a1,8
  1c:	ffe5091b          	addiw	s2,a0,-2
  20:	02091793          	slli	a5,s2,0x20
  24:	01d7d913          	srli	s2,a5,0x1d
  28:	05c1                	addi	a1,a1,16
  2a:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: touch files...\n");
    exit(1);
  }

  int status = 0;
  2c:	4981                	li	s3,0
  for(int i = 1; i < argc; i++){
    if(create_file(argv[i]) < 0){
      fprintf(2, "touch: %s failed\n", argv[i]);
  2e:	00001a97          	auipc	s5,0x1
  32:	9aaa8a93          	addi	s5,s5,-1622 # 9d8 <malloc+0x120>
      status = 1;
  36:	4a05                	li	s4,1
  int fd = open(path, O_CREATE | O_WRONLY);
  38:	20100593          	li	a1,513
  3c:	6088                	ld	a0,0(s1)
  3e:	00000097          	auipc	ra,0x0
  42:	38e080e7          	jalr	910(ra) # 3cc <open>
  if(fd < 0)
  46:	04054163          	bltz	a0,88 <main+0x88>
  close(fd);
  4a:	00000097          	auipc	ra,0x0
  4e:	37a080e7          	jalr	890(ra) # 3c4 <close>
  for(int i = 1; i < argc; i++){
  52:	04a1                	addi	s1,s1,8
  54:	ff2492e3          	bne	s1,s2,38 <main+0x38>
    }
  }

  exit(status);
  58:	854e                	mv	a0,s3
  5a:	00000097          	auipc	ra,0x0
  5e:	352080e7          	jalr	850(ra) # 3ac <exit>
  62:	f426                	sd	s1,40(sp)
  64:	f04a                	sd	s2,32(sp)
  66:	ec4e                	sd	s3,24(sp)
  68:	e852                	sd	s4,16(sp)
  6a:	e456                	sd	s5,8(sp)
    fprintf(2, "Usage: touch files...\n");
  6c:	00001597          	auipc	a1,0x1
  70:	95458593          	addi	a1,a1,-1708 # 9c0 <malloc+0x108>
  74:	4509                	li	a0,2
  76:	00000097          	auipc	ra,0x0
  7a:	75c080e7          	jalr	1884(ra) # 7d2 <fprintf>
    exit(1);
  7e:	4505                	li	a0,1
  80:	00000097          	auipc	ra,0x0
  84:	32c080e7          	jalr	812(ra) # 3ac <exit>
      fprintf(2, "touch: %s failed\n", argv[i]);
  88:	6090                	ld	a2,0(s1)
  8a:	85d6                	mv	a1,s5
  8c:	4509                	li	a0,2
  8e:	00000097          	auipc	ra,0x0
  92:	744080e7          	jalr	1860(ra) # 7d2 <fprintf>
      status = 1;
  96:	89d2                	mv	s3,s4
  98:	bf6d                	j	52 <main+0x52>

000000000000009a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  9a:	1141                	addi	sp,sp,-16
  9c:	e406                	sd	ra,8(sp)
  9e:	e022                	sd	s0,0(sp)
  a0:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
  a2:	00000097          	auipc	ra,0x0
  a6:	f5e080e7          	jalr	-162(ra) # 0 <main>
  exit(r);
  aa:	00000097          	auipc	ra,0x0
  ae:	302080e7          	jalr	770(ra) # 3ac <exit>

00000000000000b2 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  b2:	1141                	addi	sp,sp,-16
  b4:	e422                	sd	s0,8(sp)
  b6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  b8:	87aa                	mv	a5,a0
  ba:	0585                	addi	a1,a1,1
  bc:	0785                	addi	a5,a5,1
  be:	fff5c703          	lbu	a4,-1(a1)
  c2:	fee78fa3          	sb	a4,-1(a5)
  c6:	fb75                	bnez	a4,ba <strcpy+0x8>
    ;
  return os;
}
  c8:	6422                	ld	s0,8(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret

00000000000000ce <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e422                	sd	s0,8(sp)
  d2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  d4:	00054783          	lbu	a5,0(a0)
  d8:	cb91                	beqz	a5,ec <strcmp+0x1e>
  da:	0005c703          	lbu	a4,0(a1)
  de:	00f71763          	bne	a4,a5,ec <strcmp+0x1e>
    p++, q++;
  e2:	0505                	addi	a0,a0,1
  e4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	fbe5                	bnez	a5,da <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ec:	0005c503          	lbu	a0,0(a1)
}
  f0:	40a7853b          	subw	a0,a5,a0
  f4:	6422                	ld	s0,8(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret

00000000000000fa <strlen>:

uint
strlen(const char *s)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 100:	00054783          	lbu	a5,0(a0)
 104:	cf91                	beqz	a5,120 <strlen+0x26>
 106:	0505                	addi	a0,a0,1
 108:	87aa                	mv	a5,a0
 10a:	86be                	mv	a3,a5
 10c:	0785                	addi	a5,a5,1
 10e:	fff7c703          	lbu	a4,-1(a5)
 112:	ff65                	bnez	a4,10a <strlen+0x10>
 114:	40a6853b          	subw	a0,a3,a0
 118:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret
  for(n = 0; s[n]; n++)
 120:	4501                	li	a0,0
 122:	bfe5                	j	11a <strlen+0x20>

0000000000000124 <memset>:

void*
memset(void *dst, int c, uint n)
{
 124:	1141                	addi	sp,sp,-16
 126:	e422                	sd	s0,8(sp)
 128:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 12a:	ca19                	beqz	a2,140 <memset+0x1c>
 12c:	87aa                	mv	a5,a0
 12e:	1602                	slli	a2,a2,0x20
 130:	9201                	srli	a2,a2,0x20
 132:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 136:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 13a:	0785                	addi	a5,a5,1
 13c:	fee79de3          	bne	a5,a4,136 <memset+0x12>
  }
  return dst;
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret

0000000000000146 <strchr>:

char*
strchr(const char *s, char c)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 14c:	00054783          	lbu	a5,0(a0)
 150:	cb99                	beqz	a5,166 <strchr+0x20>
    if(*s == c)
 152:	00f58763          	beq	a1,a5,160 <strchr+0x1a>
  for(; *s; s++)
 156:	0505                	addi	a0,a0,1
 158:	00054783          	lbu	a5,0(a0)
 15c:	fbfd                	bnez	a5,152 <strchr+0xc>
      return (char*)s;
  return 0;
 15e:	4501                	li	a0,0
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret
  return 0;
 166:	4501                	li	a0,0
 168:	bfe5                	j	160 <strchr+0x1a>

000000000000016a <gets>:

char*
gets(char *buf, int max)
{
 16a:	711d                	addi	sp,sp,-96
 16c:	ec86                	sd	ra,88(sp)
 16e:	e8a2                	sd	s0,80(sp)
 170:	e4a6                	sd	s1,72(sp)
 172:	e0ca                	sd	s2,64(sp)
 174:	fc4e                	sd	s3,56(sp)
 176:	f852                	sd	s4,48(sp)
 178:	f456                	sd	s5,40(sp)
 17a:	f05a                	sd	s6,32(sp)
 17c:	ec5e                	sd	s7,24(sp)
 17e:	1080                	addi	s0,sp,96
 180:	8baa                	mv	s7,a0
 182:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 184:	892a                	mv	s2,a0
 186:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 188:	4aa9                	li	s5,10
 18a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 18c:	89a6                	mv	s3,s1
 18e:	2485                	addiw	s1,s1,1
 190:	0344d863          	bge	s1,s4,1c0 <gets+0x56>
    cc = read(0, &c, 1);
 194:	4605                	li	a2,1
 196:	faf40593          	addi	a1,s0,-81
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	240080e7          	jalr	576(ra) # 3dc <read>
    if(cc < 1)
 1a4:	00a05e63          	blez	a0,1c0 <gets+0x56>
    buf[i++] = c;
 1a8:	faf44783          	lbu	a5,-81(s0)
 1ac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1b0:	01578763          	beq	a5,s5,1be <gets+0x54>
 1b4:	0905                	addi	s2,s2,1
 1b6:	fd679be3          	bne	a5,s6,18c <gets+0x22>
    buf[i++] = c;
 1ba:	89a6                	mv	s3,s1
 1bc:	a011                	j	1c0 <gets+0x56>
 1be:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1c0:	99de                	add	s3,s3,s7
 1c2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1c6:	855e                	mv	a0,s7
 1c8:	60e6                	ld	ra,88(sp)
 1ca:	6446                	ld	s0,80(sp)
 1cc:	64a6                	ld	s1,72(sp)
 1ce:	6906                	ld	s2,64(sp)
 1d0:	79e2                	ld	s3,56(sp)
 1d2:	7a42                	ld	s4,48(sp)
 1d4:	7aa2                	ld	s5,40(sp)
 1d6:	7b02                	ld	s6,32(sp)
 1d8:	6be2                	ld	s7,24(sp)
 1da:	6125                	addi	sp,sp,96
 1dc:	8082                	ret

00000000000001de <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e4:	00054683          	lbu	a3,0(a0)
 1e8:	fd06879b          	addiw	a5,a3,-48
 1ec:	0ff7f793          	zext.b	a5,a5
 1f0:	4625                	li	a2,9
 1f2:	02f66863          	bltu	a2,a5,222 <atoi+0x44>
 1f6:	872a                	mv	a4,a0
  n = 0;
 1f8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1fa:	0705                	addi	a4,a4,1
 1fc:	0025179b          	slliw	a5,a0,0x2
 200:	9fa9                	addw	a5,a5,a0
 202:	0017979b          	slliw	a5,a5,0x1
 206:	9fb5                	addw	a5,a5,a3
 208:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 20c:	00074683          	lbu	a3,0(a4)
 210:	fd06879b          	addiw	a5,a3,-48
 214:	0ff7f793          	zext.b	a5,a5
 218:	fef671e3          	bgeu	a2,a5,1fa <atoi+0x1c>
  return n;
}
 21c:	6422                	ld	s0,8(sp)
 21e:	0141                	addi	sp,sp,16
 220:	8082                	ret
  n = 0;
 222:	4501                	li	a0,0
 224:	bfe5                	j	21c <atoi+0x3e>

0000000000000226 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 226:	1141                	addi	sp,sp,-16
 228:	e422                	sd	s0,8(sp)
 22a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 22c:	02b57463          	bgeu	a0,a1,254 <memmove+0x2e>
    while(n-- > 0)
 230:	00c05f63          	blez	a2,24e <memmove+0x28>
 234:	1602                	slli	a2,a2,0x20
 236:	9201                	srli	a2,a2,0x20
 238:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 23c:	872a                	mv	a4,a0
      *dst++ = *src++;
 23e:	0585                	addi	a1,a1,1
 240:	0705                	addi	a4,a4,1
 242:	fff5c683          	lbu	a3,-1(a1)
 246:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 24a:	fef71ae3          	bne	a4,a5,23e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 24e:	6422                	ld	s0,8(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret
    dst += n;
 254:	00c50733          	add	a4,a0,a2
    src += n;
 258:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 25a:	fec05ae3          	blez	a2,24e <memmove+0x28>
 25e:	fff6079b          	addiw	a5,a2,-1
 262:	1782                	slli	a5,a5,0x20
 264:	9381                	srli	a5,a5,0x20
 266:	fff7c793          	not	a5,a5
 26a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 26c:	15fd                	addi	a1,a1,-1
 26e:	177d                	addi	a4,a4,-1
 270:	0005c683          	lbu	a3,0(a1)
 274:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 278:	fee79ae3          	bne	a5,a4,26c <memmove+0x46>
 27c:	bfc9                	j	24e <memmove+0x28>

000000000000027e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 284:	ca05                	beqz	a2,2b4 <memcmp+0x36>
 286:	fff6069b          	addiw	a3,a2,-1
 28a:	1682                	slli	a3,a3,0x20
 28c:	9281                	srli	a3,a3,0x20
 28e:	0685                	addi	a3,a3,1
 290:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 292:	00054783          	lbu	a5,0(a0)
 296:	0005c703          	lbu	a4,0(a1)
 29a:	00e79863          	bne	a5,a4,2aa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 29e:	0505                	addi	a0,a0,1
    p2++;
 2a0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2a2:	fed518e3          	bne	a0,a3,292 <memcmp+0x14>
  }
  return 0;
 2a6:	4501                	li	a0,0
 2a8:	a019                	j	2ae <memcmp+0x30>
      return *p1 - *p2;
 2aa:	40e7853b          	subw	a0,a5,a4
}
 2ae:	6422                	ld	s0,8(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret
  return 0;
 2b4:	4501                	li	a0,0
 2b6:	bfe5                	j	2ae <memcmp+0x30>

00000000000002b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b8:	1141                	addi	sp,sp,-16
 2ba:	e406                	sd	ra,8(sp)
 2bc:	e022                	sd	s0,0(sp)
 2be:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2c0:	00000097          	auipc	ra,0x0
 2c4:	f66080e7          	jalr	-154(ra) # 226 <memmove>
}
 2c8:	60a2                	ld	ra,8(sp)
 2ca:	6402                	ld	s0,0(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret

00000000000002d0 <sbrk>:

char *
sbrk(int n) {
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2d8:	4585                	li	a1,1
 2da:	00000097          	auipc	ra,0x0
 2de:	12a080e7          	jalr	298(ra) # 404 <sys_sbrk>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <get_time>:
//   return sys_sbrk(n, SBRK_LAZY);
// }


unsigned int 
get_time(void) {
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
    return uptime();
 2f2:	00000097          	auipc	ra,0x0
 2f6:	11a080e7          	jalr	282(ra) # 40c <uptime>
}
 2fa:	2501                	sext.w	a0,a0
 2fc:	60a2                	ld	ra,8(sp)
 2fe:	6402                	ld	s0,0(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret

0000000000000304 <make_filename>:
void 
make_filename(char *buf, const char *prefix, int num) {
    // 复制前缀
    char *p = buf;
    const char *s = prefix;
    while(*s) *p++ = *s++;
 304:	0005c783          	lbu	a5,0(a1)
 308:	cb81                	beqz	a5,318 <make_filename+0x14>
 30a:	0585                	addi	a1,a1,1
 30c:	0505                	addi	a0,a0,1
 30e:	fef50fa3          	sb	a5,-1(a0)
 312:	0005c783          	lbu	a5,0(a1)
 316:	fbf5                	bnez	a5,30a <make_filename+0x6>
    
    // 处理数字部分
    if (num == 0) {
 318:	ca3d                	beqz	a2,38e <make_filename+0x8a>
make_filename(char *buf, const char *prefix, int num) {
 31a:	1101                	addi	sp,sp,-32
 31c:	ec22                	sd	s0,24(sp)
 31e:	1000                	addi	s0,sp,32
        *p++ = '0';
    } else {
        // 临时缓冲区存放数字
        char digits[16];
        int i = 0;
        while(num > 0) {
 320:	fe040893          	addi	a7,s0,-32
 324:	87c6                	mv	a5,a7
            digits[i++] = (num % 10) + '0';
 326:	46a9                	li	a3,10
        while(num > 0) {
 328:	4825                	li	a6,9
 32a:	06c05063          	blez	a2,38a <make_filename+0x86>
            digits[i++] = (num % 10) + '0';
 32e:	02d6673b          	remw	a4,a2,a3
 332:	0307071b          	addiw	a4,a4,48
 336:	00e78023          	sb	a4,0(a5)
            num /= 10;
 33a:	85b2                	mv	a1,a2
 33c:	02d6463b          	divw	a2,a2,a3
        while(num > 0) {
 340:	873e                	mv	a4,a5
 342:	0785                	addi	a5,a5,1
 344:	feb845e3          	blt	a6,a1,32e <make_filename+0x2a>
 348:	4117073b          	subw	a4,a4,a7
 34c:	0017069b          	addiw	a3,a4,1
            digits[i++] = (num % 10) + '0';
 350:	0006879b          	sext.w	a5,a3
        }
        // 倒序写入
        while(i > 0) *p++ = digits[--i];
 354:	04f05663          	blez	a5,3a0 <make_filename+0x9c>
 358:	fe040713          	addi	a4,s0,-32
 35c:	973e                	add	a4,a4,a5
 35e:	02069593          	slli	a1,a3,0x20
 362:	9181                	srli	a1,a1,0x20
 364:	95aa                	add	a1,a1,a0
 366:	87aa                	mv	a5,a0
 368:	0785                	addi	a5,a5,1
 36a:	fff74603          	lbu	a2,-1(a4)
 36e:	fec78fa3          	sb	a2,-1(a5)
 372:	177d                	addi	a4,a4,-1
 374:	feb79ae3          	bne	a5,a1,368 <make_filename+0x64>
 378:	02069793          	slli	a5,a3,0x20
 37c:	9381                	srli	a5,a5,0x20
 37e:	97aa                	add	a5,a5,a0
    }
    *p = 0; // 字符串结束符
 380:	00078023          	sb	zero,0(a5)
 384:	6462                	ld	s0,24(sp)
 386:	6105                	addi	sp,sp,32
 388:	8082                	ret
        while(num > 0) {
 38a:	87aa                	mv	a5,a0
 38c:	bfd5                	j	380 <make_filename+0x7c>
        *p++ = '0';
 38e:	00150793          	addi	a5,a0,1
 392:	03000713          	li	a4,48
 396:	00e50023          	sb	a4,0(a0)
    *p = 0; // 字符串结束符
 39a:	00078023          	sb	zero,0(a5)
 39e:	8082                	ret
        while(i > 0) *p++ = digits[--i];
 3a0:	87aa                	mv	a5,a0
 3a2:	bff9                	j	380 <make_filename+0x7c>

00000000000003a4 <fork>:
.globl unlink
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a4:	4885                	li	a7,1
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ac:	4889                	li	a7,2
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b4:	488d                	li	a7,3
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3bc:	4891                	li	a7,4
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <close>:
.global close
close:
 li a7, SYS_close
 3c4:	4899                	li	a7,6
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <open>:
.global open
open:
 li a7, SYS_open
 3cc:	489d                	li	a7,7
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d4:	4895                	li	a7,5
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <read>:
.global read
read:
 li a7, SYS_read
 3dc:	48a1                	li	a7,8
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <write>:
.global write
write:
 li a7, SYS_write
 3e4:	48a5                	li	a7,9
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3ec:	48a9                	li	a7,10
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 3f4:	48ad                	li	a7,11
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 3fc:	48b1                	li	a7,12
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 404:	48b5                	li	a7,13
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 40c:	48b9                	li	a7,14
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 414:	48bd                	li	a7,15
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 41c:	48c1                	li	a7,16
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 424:	1101                	addi	sp,sp,-32
 426:	ec06                	sd	ra,24(sp)
 428:	e822                	sd	s0,16(sp)
 42a:	1000                	addi	s0,sp,32
 42c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 430:	4605                	li	a2,1
 432:	fef40593          	addi	a1,s0,-17
 436:	00000097          	auipc	ra,0x0
 43a:	fae080e7          	jalr	-82(ra) # 3e4 <write>
}
 43e:	60e2                	ld	ra,24(sp)
 440:	6442                	ld	s0,16(sp)
 442:	6105                	addi	sp,sp,32
 444:	8082                	ret

0000000000000446 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 446:	715d                	addi	sp,sp,-80
 448:	e486                	sd	ra,72(sp)
 44a:	e0a2                	sd	s0,64(sp)
 44c:	f84a                	sd	s2,48(sp)
 44e:	0880                	addi	s0,sp,80
 450:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 452:	c299                	beqz	a3,458 <printint+0x12>
 454:	0805c563          	bltz	a1,4de <printint+0x98>
  neg = 0;
 458:	4881                	li	a7,0
 45a:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 45e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 460:	00000517          	auipc	a0,0x0
 464:	59850513          	addi	a0,a0,1432 # 9f8 <digits>
 468:	883e                	mv	a6,a5
 46a:	2785                	addiw	a5,a5,1
 46c:	02c5f733          	remu	a4,a1,a2
 470:	972a                	add	a4,a4,a0
 472:	00074703          	lbu	a4,0(a4)
 476:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 47a:	872e                	mv	a4,a1
 47c:	02c5d5b3          	divu	a1,a1,a2
 480:	0685                	addi	a3,a3,1
 482:	fec773e3          	bgeu	a4,a2,468 <printint+0x22>
  if(neg)
 486:	00088b63          	beqz	a7,49c <printint+0x56>
    buf[i++] = '-';
 48a:	fd078793          	addi	a5,a5,-48
 48e:	97a2                	add	a5,a5,s0
 490:	02d00713          	li	a4,45
 494:	fee78423          	sb	a4,-24(a5)
 498:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 49c:	02f05c63          	blez	a5,4d4 <printint+0x8e>
 4a0:	fc26                	sd	s1,56(sp)
 4a2:	f44e                	sd	s3,40(sp)
 4a4:	fb840713          	addi	a4,s0,-72
 4a8:	00f704b3          	add	s1,a4,a5
 4ac:	fff70993          	addi	s3,a4,-1
 4b0:	99be                	add	s3,s3,a5
 4b2:	37fd                	addiw	a5,a5,-1
 4b4:	1782                	slli	a5,a5,0x20
 4b6:	9381                	srli	a5,a5,0x20
 4b8:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4bc:	fff4c583          	lbu	a1,-1(s1)
 4c0:	854a                	mv	a0,s2
 4c2:	00000097          	auipc	ra,0x0
 4c6:	f62080e7          	jalr	-158(ra) # 424 <putc>
  while(--i >= 0)
 4ca:	14fd                	addi	s1,s1,-1
 4cc:	ff3498e3          	bne	s1,s3,4bc <printint+0x76>
 4d0:	74e2                	ld	s1,56(sp)
 4d2:	79a2                	ld	s3,40(sp)
}
 4d4:	60a6                	ld	ra,72(sp)
 4d6:	6406                	ld	s0,64(sp)
 4d8:	7942                	ld	s2,48(sp)
 4da:	6161                	addi	sp,sp,80
 4dc:	8082                	ret
    x = -xx;
 4de:	40b005b3          	neg	a1,a1
    neg = 1;
 4e2:	4885                	li	a7,1
    x = -xx;
 4e4:	bf9d                	j	45a <printint+0x14>

00000000000004e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e6:	711d                	addi	sp,sp,-96
 4e8:	ec86                	sd	ra,88(sp)
 4ea:	e8a2                	sd	s0,80(sp)
 4ec:	e0ca                	sd	s2,64(sp)
 4ee:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f0:	0005c903          	lbu	s2,0(a1)
 4f4:	2c090a63          	beqz	s2,7c8 <vprintf+0x2e2>
 4f8:	e4a6                	sd	s1,72(sp)
 4fa:	fc4e                	sd	s3,56(sp)
 4fc:	f852                	sd	s4,48(sp)
 4fe:	f456                	sd	s5,40(sp)
 500:	f05a                	sd	s6,32(sp)
 502:	ec5e                	sd	s7,24(sp)
 504:	e862                	sd	s8,16(sp)
 506:	e466                	sd	s9,8(sp)
 508:	8b2a                	mv	s6,a0
 50a:	8a2e                	mv	s4,a1
 50c:	8bb2                	mv	s7,a2
  state = 0;
 50e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 510:	4481                	li	s1,0
 512:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 514:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 518:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 51c:	06c00c93          	li	s9,108
 520:	a015                	j	544 <vprintf+0x5e>
        putc(fd, c0);
 522:	85ca                	mv	a1,s2
 524:	855a                	mv	a0,s6
 526:	00000097          	auipc	ra,0x0
 52a:	efe080e7          	jalr	-258(ra) # 424 <putc>
 52e:	a019                	j	534 <vprintf+0x4e>
    } else if(state == '%'){
 530:	03598263          	beq	s3,s5,554 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 534:	2485                	addiw	s1,s1,1
 536:	8726                	mv	a4,s1
 538:	009a07b3          	add	a5,s4,s1
 53c:	0007c903          	lbu	s2,0(a5)
 540:	26090c63          	beqz	s2,7b8 <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 544:	0009079b          	sext.w	a5,s2
    if(state == 0){
 548:	fe0994e3          	bnez	s3,530 <vprintf+0x4a>
      if(c0 == '%'){
 54c:	fd579be3          	bne	a5,s5,522 <vprintf+0x3c>
        state = '%';
 550:	89be                	mv	s3,a5
 552:	b7cd                	j	534 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 554:	00ea06b3          	add	a3,s4,a4
 558:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 55c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 55e:	c681                	beqz	a3,566 <vprintf+0x80>
 560:	9752                	add	a4,a4,s4
 562:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 566:	05878563          	beq	a5,s8,5b0 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 56a:	07978163          	beq	a5,s9,5cc <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 56e:	07500713          	li	a4,117
 572:	10e78563          	beq	a5,a4,67c <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 576:	07800713          	li	a4,120
 57a:	14e78d63          	beq	a5,a4,6d4 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 57e:	07000713          	li	a4,112
 582:	18e78663          	beq	a5,a4,70e <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 586:	06300713          	li	a4,99
 58a:	1ce78c63          	beq	a5,a4,762 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 58e:	07300713          	li	a4,115
 592:	1ee78463          	beq	a5,a4,77a <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 596:	02500713          	li	a4,37
 59a:	04e79963          	bne	a5,a4,5ec <vprintf+0x106>
        putc(fd, '%');
 59e:	02500593          	li	a1,37
 5a2:	855a                	mv	a0,s6
 5a4:	00000097          	auipc	ra,0x0
 5a8:	e80080e7          	jalr	-384(ra) # 424 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5ac:	4981                	li	s3,0
 5ae:	b759                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 5b0:	008b8913          	addi	s2,s7,8
 5b4:	4685                	li	a3,1
 5b6:	4629                	li	a2,10
 5b8:	000ba583          	lw	a1,0(s7)
 5bc:	855a                	mv	a0,s6
 5be:	00000097          	auipc	ra,0x0
 5c2:	e88080e7          	jalr	-376(ra) # 446 <printint>
 5c6:	8bca                	mv	s7,s2
      state = 0;
 5c8:	4981                	li	s3,0
 5ca:	b7ad                	j	534 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 5cc:	06400793          	li	a5,100
 5d0:	02f68d63          	beq	a3,a5,60a <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5d4:	06c00793          	li	a5,108
 5d8:	04f68863          	beq	a3,a5,628 <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 5dc:	07500793          	li	a5,117
 5e0:	0af68c63          	beq	a3,a5,698 <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 5e4:	07800793          	li	a5,120
 5e8:	10f68463          	beq	a3,a5,6f0 <vprintf+0x20a>
        putc(fd, '%');
 5ec:	02500593          	li	a1,37
 5f0:	855a                	mv	a0,s6
 5f2:	00000097          	auipc	ra,0x0
 5f6:	e32080e7          	jalr	-462(ra) # 424 <putc>
        putc(fd, c0);
 5fa:	85ca                	mv	a1,s2
 5fc:	855a                	mv	a0,s6
 5fe:	00000097          	auipc	ra,0x0
 602:	e26080e7          	jalr	-474(ra) # 424 <putc>
      state = 0;
 606:	4981                	li	s3,0
 608:	b735                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 60a:	008b8913          	addi	s2,s7,8
 60e:	4685                	li	a3,1
 610:	4629                	li	a2,10
 612:	000bb583          	ld	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	00000097          	auipc	ra,0x0
 61c:	e2e080e7          	jalr	-466(ra) # 446 <printint>
        i += 1;
 620:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 622:	8bca                	mv	s7,s2
      state = 0;
 624:	4981                	li	s3,0
        i += 1;
 626:	b739                	j	534 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 628:	06400793          	li	a5,100
 62c:	02f60963          	beq	a2,a5,65e <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 630:	07500793          	li	a5,117
 634:	08f60163          	beq	a2,a5,6b6 <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 638:	07800793          	li	a5,120
 63c:	faf618e3          	bne	a2,a5,5ec <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 640:	008b8913          	addi	s2,s7,8
 644:	4681                	li	a3,0
 646:	4641                	li	a2,16
 648:	000bb583          	ld	a1,0(s7)
 64c:	855a                	mv	a0,s6
 64e:	00000097          	auipc	ra,0x0
 652:	df8080e7          	jalr	-520(ra) # 446 <printint>
        i += 2;
 656:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 658:	8bca                	mv	s7,s2
      state = 0;
 65a:	4981                	li	s3,0
        i += 2;
 65c:	bde1                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 65e:	008b8913          	addi	s2,s7,8
 662:	4685                	li	a3,1
 664:	4629                	li	a2,10
 666:	000bb583          	ld	a1,0(s7)
 66a:	855a                	mv	a0,s6
 66c:	00000097          	auipc	ra,0x0
 670:	dda080e7          	jalr	-550(ra) # 446 <printint>
        i += 2;
 674:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 676:	8bca                	mv	s7,s2
      state = 0;
 678:	4981                	li	s3,0
        i += 2;
 67a:	bd6d                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 67c:	008b8913          	addi	s2,s7,8
 680:	4681                	li	a3,0
 682:	4629                	li	a2,10
 684:	000be583          	lwu	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	00000097          	auipc	ra,0x0
 68e:	dbc080e7          	jalr	-580(ra) # 446 <printint>
 692:	8bca                	mv	s7,s2
      state = 0;
 694:	4981                	li	s3,0
 696:	bd79                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 698:	008b8913          	addi	s2,s7,8
 69c:	4681                	li	a3,0
 69e:	4629                	li	a2,10
 6a0:	000bb583          	ld	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	00000097          	auipc	ra,0x0
 6aa:	da0080e7          	jalr	-608(ra) # 446 <printint>
        i += 1;
 6ae:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b0:	8bca                	mv	s7,s2
      state = 0;
 6b2:	4981                	li	s3,0
        i += 1;
 6b4:	b541                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	008b8913          	addi	s2,s7,8
 6ba:	4681                	li	a3,0
 6bc:	4629                	li	a2,10
 6be:	000bb583          	ld	a1,0(s7)
 6c2:	855a                	mv	a0,s6
 6c4:	00000097          	auipc	ra,0x0
 6c8:	d82080e7          	jalr	-638(ra) # 446 <printint>
        i += 2;
 6cc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	8bca                	mv	s7,s2
      state = 0;
 6d0:	4981                	li	s3,0
        i += 2;
 6d2:	b58d                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4641                	li	a2,16
 6dc:	000be583          	lwu	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	00000097          	auipc	ra,0x0
 6e6:	d64080e7          	jalr	-668(ra) # 446 <printint>
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	b599                	j	534 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	00000097          	auipc	ra,0x0
 702:	d48080e7          	jalr	-696(ra) # 446 <printint>
        i += 1;
 706:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 708:	8bca                	mv	s7,s2
      state = 0;
 70a:	4981                	li	s3,0
        i += 1;
 70c:	b525                	j	534 <vprintf+0x4e>
 70e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 710:	008b8d13          	addi	s10,s7,8
 714:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 718:	03000593          	li	a1,48
 71c:	855a                	mv	a0,s6
 71e:	00000097          	auipc	ra,0x0
 722:	d06080e7          	jalr	-762(ra) # 424 <putc>
  putc(fd, 'x');
 726:	07800593          	li	a1,120
 72a:	855a                	mv	a0,s6
 72c:	00000097          	auipc	ra,0x0
 730:	cf8080e7          	jalr	-776(ra) # 424 <putc>
 734:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 736:	00000b97          	auipc	s7,0x0
 73a:	2c2b8b93          	addi	s7,s7,706 # 9f8 <digits>
 73e:	03c9d793          	srli	a5,s3,0x3c
 742:	97de                	add	a5,a5,s7
 744:	0007c583          	lbu	a1,0(a5)
 748:	855a                	mv	a0,s6
 74a:	00000097          	auipc	ra,0x0
 74e:	cda080e7          	jalr	-806(ra) # 424 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 752:	0992                	slli	s3,s3,0x4
 754:	397d                	addiw	s2,s2,-1
 756:	fe0914e3          	bnez	s2,73e <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 75a:	8bea                	mv	s7,s10
      state = 0;
 75c:	4981                	li	s3,0
 75e:	6d02                	ld	s10,0(sp)
 760:	bbd1                	j	534 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 762:	008b8913          	addi	s2,s7,8
 766:	000bc583          	lbu	a1,0(s7)
 76a:	855a                	mv	a0,s6
 76c:	00000097          	auipc	ra,0x0
 770:	cb8080e7          	jalr	-840(ra) # 424 <putc>
 774:	8bca                	mv	s7,s2
      state = 0;
 776:	4981                	li	s3,0
 778:	bb75                	j	534 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 77a:	008b8993          	addi	s3,s7,8
 77e:	000bb903          	ld	s2,0(s7)
 782:	02090163          	beqz	s2,7a4 <vprintf+0x2be>
        for(; *s; s++)
 786:	00094583          	lbu	a1,0(s2)
 78a:	c585                	beqz	a1,7b2 <vprintf+0x2cc>
          putc(fd, *s);
 78c:	855a                	mv	a0,s6
 78e:	00000097          	auipc	ra,0x0
 792:	c96080e7          	jalr	-874(ra) # 424 <putc>
        for(; *s; s++)
 796:	0905                	addi	s2,s2,1
 798:	00094583          	lbu	a1,0(s2)
 79c:	f9e5                	bnez	a1,78c <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 79e:	8bce                	mv	s7,s3
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bb49                	j	534 <vprintf+0x4e>
          s = "(null)";
 7a4:	00000917          	auipc	s2,0x0
 7a8:	24c90913          	addi	s2,s2,588 # 9f0 <malloc+0x138>
        for(; *s; s++)
 7ac:	02800593          	li	a1,40
 7b0:	bff1                	j	78c <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 7b2:	8bce                	mv	s7,s3
      state = 0;
 7b4:	4981                	li	s3,0
 7b6:	bbbd                	j	534 <vprintf+0x4e>
 7b8:	64a6                	ld	s1,72(sp)
 7ba:	79e2                	ld	s3,56(sp)
 7bc:	7a42                	ld	s4,48(sp)
 7be:	7aa2                	ld	s5,40(sp)
 7c0:	7b02                	ld	s6,32(sp)
 7c2:	6be2                	ld	s7,24(sp)
 7c4:	6c42                	ld	s8,16(sp)
 7c6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7c8:	60e6                	ld	ra,88(sp)
 7ca:	6446                	ld	s0,80(sp)
 7cc:	6906                	ld	s2,64(sp)
 7ce:	6125                	addi	sp,sp,96
 7d0:	8082                	ret

00000000000007d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d2:	715d                	addi	sp,sp,-80
 7d4:	ec06                	sd	ra,24(sp)
 7d6:	e822                	sd	s0,16(sp)
 7d8:	1000                	addi	s0,sp,32
 7da:	e010                	sd	a2,0(s0)
 7dc:	e414                	sd	a3,8(s0)
 7de:	e818                	sd	a4,16(s0)
 7e0:	ec1c                	sd	a5,24(s0)
 7e2:	03043023          	sd	a6,32(s0)
 7e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ea:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ee:	8622                	mv	a2,s0
 7f0:	00000097          	auipc	ra,0x0
 7f4:	cf6080e7          	jalr	-778(ra) # 4e6 <vprintf>
}
 7f8:	60e2                	ld	ra,24(sp)
 7fa:	6442                	ld	s0,16(sp)
 7fc:	6161                	addi	sp,sp,80
 7fe:	8082                	ret

0000000000000800 <printf>:

void
printf(const char *fmt, ...)
{
 800:	711d                	addi	sp,sp,-96
 802:	ec06                	sd	ra,24(sp)
 804:	e822                	sd	s0,16(sp)
 806:	1000                	addi	s0,sp,32
 808:	e40c                	sd	a1,8(s0)
 80a:	e810                	sd	a2,16(s0)
 80c:	ec14                	sd	a3,24(s0)
 80e:	f018                	sd	a4,32(s0)
 810:	f41c                	sd	a5,40(s0)
 812:	03043823          	sd	a6,48(s0)
 816:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 81a:	00840613          	addi	a2,s0,8
 81e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 822:	85aa                	mv	a1,a0
 824:	4505                	li	a0,1
 826:	00000097          	auipc	ra,0x0
 82a:	cc0080e7          	jalr	-832(ra) # 4e6 <vprintf>
}
 82e:	60e2                	ld	ra,24(sp)
 830:	6442                	ld	s0,16(sp)
 832:	6125                	addi	sp,sp,96
 834:	8082                	ret

0000000000000836 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 836:	1141                	addi	sp,sp,-16
 838:	e422                	sd	s0,8(sp)
 83a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 83c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 840:	00000797          	auipc	a5,0x0
 844:	7c07b783          	ld	a5,1984(a5) # 1000 <freep>
 848:	a02d                	j	872 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 84a:	4618                	lw	a4,8(a2)
 84c:	9f2d                	addw	a4,a4,a1
 84e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 852:	6398                	ld	a4,0(a5)
 854:	6310                	ld	a2,0(a4)
 856:	a83d                	j	894 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 858:	ff852703          	lw	a4,-8(a0)
 85c:	9f31                	addw	a4,a4,a2
 85e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 860:	ff053683          	ld	a3,-16(a0)
 864:	a091                	j	8a8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 866:	6398                	ld	a4,0(a5)
 868:	00e7e463          	bltu	a5,a4,870 <free+0x3a>
 86c:	00e6ea63          	bltu	a3,a4,880 <free+0x4a>
{
 870:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 872:	fed7fae3          	bgeu	a5,a3,866 <free+0x30>
 876:	6398                	ld	a4,0(a5)
 878:	00e6e463          	bltu	a3,a4,880 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87c:	fee7eae3          	bltu	a5,a4,870 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 880:	ff852583          	lw	a1,-8(a0)
 884:	6390                	ld	a2,0(a5)
 886:	02059813          	slli	a6,a1,0x20
 88a:	01c85713          	srli	a4,a6,0x1c
 88e:	9736                	add	a4,a4,a3
 890:	fae60de3          	beq	a2,a4,84a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 894:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 898:	4790                	lw	a2,8(a5)
 89a:	02061593          	slli	a1,a2,0x20
 89e:	01c5d713          	srli	a4,a1,0x1c
 8a2:	973e                	add	a4,a4,a5
 8a4:	fae68ae3          	beq	a3,a4,858 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8a8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8aa:	00000717          	auipc	a4,0x0
 8ae:	74f73b23          	sd	a5,1878(a4) # 1000 <freep>
}
 8b2:	6422                	ld	s0,8(sp)
 8b4:	0141                	addi	sp,sp,16
 8b6:	8082                	ret

00000000000008b8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b8:	7139                	addi	sp,sp,-64
 8ba:	fc06                	sd	ra,56(sp)
 8bc:	f822                	sd	s0,48(sp)
 8be:	f426                	sd	s1,40(sp)
 8c0:	ec4e                	sd	s3,24(sp)
 8c2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c4:	02051493          	slli	s1,a0,0x20
 8c8:	9081                	srli	s1,s1,0x20
 8ca:	04bd                	addi	s1,s1,15
 8cc:	8091                	srli	s1,s1,0x4
 8ce:	0014899b          	addiw	s3,s1,1
 8d2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8d4:	00000517          	auipc	a0,0x0
 8d8:	72c53503          	ld	a0,1836(a0) # 1000 <freep>
 8dc:	c915                	beqz	a0,910 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e0:	4798                	lw	a4,8(a5)
 8e2:	08977e63          	bgeu	a4,s1,97e <malloc+0xc6>
 8e6:	f04a                	sd	s2,32(sp)
 8e8:	e852                	sd	s4,16(sp)
 8ea:	e456                	sd	s5,8(sp)
 8ec:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ee:	8a4e                	mv	s4,s3
 8f0:	0009871b          	sext.w	a4,s3
 8f4:	6685                	lui	a3,0x1
 8f6:	00d77363          	bgeu	a4,a3,8fc <malloc+0x44>
 8fa:	6a05                	lui	s4,0x1
 8fc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 900:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 904:	00000917          	auipc	s2,0x0
 908:	6fc90913          	addi	s2,s2,1788 # 1000 <freep>
  if(p == SBRK_ERROR)
 90c:	5afd                	li	s5,-1
 90e:	a091                	j	952 <malloc+0x9a>
 910:	f04a                	sd	s2,32(sp)
 912:	e852                	sd	s4,16(sp)
 914:	e456                	sd	s5,8(sp)
 916:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 918:	00000797          	auipc	a5,0x0
 91c:	6f878793          	addi	a5,a5,1784 # 1010 <base>
 920:	00000717          	auipc	a4,0x0
 924:	6ef73023          	sd	a5,1760(a4) # 1000 <freep>
 928:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 92a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 92e:	b7c1                	j	8ee <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 930:	6398                	ld	a4,0(a5)
 932:	e118                	sd	a4,0(a0)
 934:	a08d                	j	996 <malloc+0xde>
  hp->s.size = nu;
 936:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 93a:	0541                	addi	a0,a0,16
 93c:	00000097          	auipc	ra,0x0
 940:	efa080e7          	jalr	-262(ra) # 836 <free>
  return freep;
 944:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 948:	c13d                	beqz	a0,9ae <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 94a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94c:	4798                	lw	a4,8(a5)
 94e:	02977463          	bgeu	a4,s1,976 <malloc+0xbe>
    if(p == freep)
 952:	00093703          	ld	a4,0(s2)
 956:	853e                	mv	a0,a5
 958:	fef719e3          	bne	a4,a5,94a <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 95c:	8552                	mv	a0,s4
 95e:	00000097          	auipc	ra,0x0
 962:	972080e7          	jalr	-1678(ra) # 2d0 <sbrk>
  if(p == SBRK_ERROR)
 966:	fd5518e3          	bne	a0,s5,936 <malloc+0x7e>
        return 0;
 96a:	4501                	li	a0,0
 96c:	7902                	ld	s2,32(sp)
 96e:	6a42                	ld	s4,16(sp)
 970:	6aa2                	ld	s5,8(sp)
 972:	6b02                	ld	s6,0(sp)
 974:	a03d                	j	9a2 <malloc+0xea>
 976:	7902                	ld	s2,32(sp)
 978:	6a42                	ld	s4,16(sp)
 97a:	6aa2                	ld	s5,8(sp)
 97c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 97e:	fae489e3          	beq	s1,a4,930 <malloc+0x78>
        p->s.size -= nunits;
 982:	4137073b          	subw	a4,a4,s3
 986:	c798                	sw	a4,8(a5)
        p += p->s.size;
 988:	02071693          	slli	a3,a4,0x20
 98c:	01c6d713          	srli	a4,a3,0x1c
 990:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 992:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 996:	00000717          	auipc	a4,0x0
 99a:	66a73523          	sd	a0,1642(a4) # 1000 <freep>
      return (void*)(p + 1);
 99e:	01078513          	addi	a0,a5,16
  }
}
 9a2:	70e2                	ld	ra,56(sp)
 9a4:	7442                	ld	s0,48(sp)
 9a6:	74a2                	ld	s1,40(sp)
 9a8:	69e2                	ld	s3,24(sp)
 9aa:	6121                	addi	sp,sp,64
 9ac:	8082                	ret
 9ae:	7902                	ld	s2,32(sp)
 9b0:	6a42                	ld	s4,16(sp)
 9b2:	6aa2                	ld	s5,8(sp)
 9b4:	6b02                	ld	s6,0(sp)
 9b6:	b7f5                	j	9a2 <malloc+0xea>
