
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <ls>:
  printf("%s\n", name);
}

static void
ls(const char *path)
{
   0:	7159                	addi	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	e0d2                	sd	s4,64(sp)
   8:	1880                	addi	s0,sp,112
   a:	8a2a                	mv	s4,a0
  struct dirent de;
  int fd = open(path, O_RDONLY);
   c:	4581                	li	a1,0
   e:	00000097          	auipc	ra,0x0
  12:	494080e7          	jalr	1172(ra) # 4a2 <open>
  if(fd < 0){
  16:	02054563          	bltz	a0,40 <ls+0x40>
  1a:	eca6                	sd	s1,88(sp)
  1c:	e8ca                	sd	s2,80(sp)
  1e:	e4ce                	sd	s3,72(sp)
  20:	fc56                	sd	s5,56(sp)
  22:	f85a                	sd	s6,48(sp)
  24:	f45e                	sd	s7,40(sp)
  26:	f062                	sd	s8,32(sp)
  28:	892a                	mv	s2,a0
  2a:	4a81                	li	s5,0
    if(de.inum == 0)
      continue;

    char name[DIRSIZ + 1];
    int i;
    for(i = 0; i < DIRSIZ && de.name[i]; i++)
  2c:	4981                	li	s3,0
  2e:	44b9                	li	s1,14
      name[i] = de.name[i];
    name[i] = '\0';

    if(name[0] == '\0')
      continue;
    if(name[0] == '.' && (name[1] == '\0' || (name[1] == '.' && name[2] == '\0')))
  30:	02e00b13          	li	s6,46
  printf("%s\n", name);
  34:	00001c17          	auipc	s8,0x1
  38:	a6cc0c13          	addi	s8,s8,-1428 # aa0 <malloc+0x112>
      continue;

    emit_name(name);
    saw_dir = 1;
  3c:	4b85                	li	s7,1
  3e:	a025                	j	66 <ls+0x66>
    fprintf(2, "ls: cannot open %s\n", path);
  40:	8652                	mv	a2,s4
  42:	00001597          	auipc	a1,0x1
  46:	a4e58593          	addi	a1,a1,-1458 # a90 <malloc+0x102>
  4a:	4509                	li	a0,2
  4c:	00001097          	auipc	ra,0x1
  50:	85c080e7          	jalr	-1956(ra) # 8a8 <fprintf>
    return;
  54:	a849                	j	e6 <ls+0xe6>
  printf("%s\n", name);
  56:	f9040593          	addi	a1,s0,-112
  5a:	8562                	mv	a0,s8
  5c:	00001097          	auipc	ra,0x1
  60:	87a080e7          	jalr	-1926(ra) # 8d6 <printf>
    saw_dir = 1;
  64:	8ade                	mv	s5,s7
  while(read(fd, &de, sizeof(de)) == sizeof(de)){
  66:	4641                	li	a2,16
  68:	fa040593          	addi	a1,s0,-96
  6c:	854a                	mv	a0,s2
  6e:	00000097          	auipc	ra,0x0
  72:	444080e7          	jalr	1092(ra) # 4b2 <read>
  76:	47c1                	li	a5,16
  78:	04f51963          	bne	a0,a5,ca <ls+0xca>
    if(de.inum == 0)
  7c:	fa045783          	lhu	a5,-96(s0)
  80:	d3fd                	beqz	a5,66 <ls+0x66>
  82:	fa240713          	addi	a4,s0,-94
  86:	f9040693          	addi	a3,s0,-112
    for(i = 0; i < DIRSIZ && de.name[i]; i++)
  8a:	87ce                	mv	a5,s3
  8c:	00074603          	lbu	a2,0(a4)
  90:	ca01                	beqz	a2,a0 <ls+0xa0>
      name[i] = de.name[i];
  92:	00c68023          	sb	a2,0(a3)
    for(i = 0; i < DIRSIZ && de.name[i]; i++)
  96:	2785                	addiw	a5,a5,1
  98:	0705                	addi	a4,a4,1
  9a:	0685                	addi	a3,a3,1
  9c:	fe9798e3          	bne	a5,s1,8c <ls+0x8c>
    name[i] = '\0';
  a0:	fb078793          	addi	a5,a5,-80
  a4:	97a2                	add	a5,a5,s0
  a6:	fe078023          	sb	zero,-32(a5)
    if(name[0] == '\0')
  aa:	f9044783          	lbu	a5,-112(s0)
  ae:	dfc5                	beqz	a5,66 <ls+0x66>
    if(name[0] == '.' && (name[1] == '\0' || (name[1] == '.' && name[2] == '\0')))
  b0:	fb6793e3          	bne	a5,s6,56 <ls+0x56>
  b4:	f9144783          	lbu	a5,-111(s0)
  b8:	d7dd                	beqz	a5,66 <ls+0x66>
  ba:	02e00713          	li	a4,46
  be:	f8e79ce3          	bne	a5,a4,56 <ls+0x56>
  c2:	f9244783          	lbu	a5,-110(s0)
  c6:	fbc1                	bnez	a5,56 <ls+0x56>
  c8:	bf79                	j	66 <ls+0x66>
  }

  close(fd);
  ca:	854a                	mv	a0,s2
  cc:	00000097          	auipc	ra,0x0
  d0:	3ce080e7          	jalr	974(ra) # 49a <close>

  if(!saw_dir)
  d4:	000a8e63          	beqz	s5,f0 <ls+0xf0>
  d8:	64e6                	ld	s1,88(sp)
  da:	6946                	ld	s2,80(sp)
  dc:	69a6                	ld	s3,72(sp)
  de:	7ae2                	ld	s5,56(sp)
  e0:	7b42                	ld	s6,48(sp)
  e2:	7ba2                	ld	s7,40(sp)
  e4:	7c02                	ld	s8,32(sp)
    emit_name(path);
}
  e6:	70a6                	ld	ra,104(sp)
  e8:	7406                	ld	s0,96(sp)
  ea:	6a06                	ld	s4,64(sp)
  ec:	6165                	addi	sp,sp,112
  ee:	8082                	ret
  printf("%s\n", name);
  f0:	85d2                	mv	a1,s4
  f2:	00001517          	auipc	a0,0x1
  f6:	9ae50513          	addi	a0,a0,-1618 # aa0 <malloc+0x112>
  fa:	00000097          	auipc	ra,0x0
  fe:	7dc080e7          	jalr	2012(ra) # 8d6 <printf>
 102:	64e6                	ld	s1,88(sp)
 104:	6946                	ld	s2,80(sp)
 106:	69a6                	ld	s3,72(sp)
 108:	7ae2                	ld	s5,56(sp)
 10a:	7b42                	ld	s6,48(sp)
 10c:	7ba2                	ld	s7,40(sp)
 10e:	7c02                	ld	s8,32(sp)
}
 110:	bfd9                	j	e6 <ls+0xe6>

0000000000000112 <main>:

int
main(int argc, char *argv[])
{
 112:	1101                	addi	sp,sp,-32
 114:	ec06                	sd	ra,24(sp)
 116:	e822                	sd	s0,16(sp)
 118:	1000                	addi	s0,sp,32
  if(argc <= 1){
 11a:	4785                	li	a5,1
 11c:	02a7db63          	bge	a5,a0,152 <main+0x40>
 120:	e426                	sd	s1,8(sp)
 122:	e04a                	sd	s2,0(sp)
 124:	00858493          	addi	s1,a1,8
 128:	ffe5091b          	addiw	s2,a0,-2
 12c:	02091793          	slli	a5,s2,0x20
 130:	01d7d913          	srli	s2,a5,0x1d
 134:	05c1                	addi	a1,a1,16
 136:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }

  for(int i = 1; i < argc; i++)
    ls(argv[i]);
 138:	6088                	ld	a0,0(s1)
 13a:	00000097          	auipc	ra,0x0
 13e:	ec6080e7          	jalr	-314(ra) # 0 <ls>
  for(int i = 1; i < argc; i++)
 142:	04a1                	addi	s1,s1,8
 144:	ff249ae3          	bne	s1,s2,138 <main+0x26>

  exit(0);
 148:	4501                	li	a0,0
 14a:	00000097          	auipc	ra,0x0
 14e:	338080e7          	jalr	824(ra) # 482 <exit>
 152:	e426                	sd	s1,8(sp)
 154:	e04a                	sd	s2,0(sp)
    ls(".");
 156:	00001517          	auipc	a0,0x1
 15a:	95250513          	addi	a0,a0,-1710 # aa8 <malloc+0x11a>
 15e:	00000097          	auipc	ra,0x0
 162:	ea2080e7          	jalr	-350(ra) # 0 <ls>
    exit(0);
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	31a080e7          	jalr	794(ra) # 482 <exit>

0000000000000170 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 170:	1141                	addi	sp,sp,-16
 172:	e406                	sd	ra,8(sp)
 174:	e022                	sd	s0,0(sp)
 176:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
 178:	00000097          	auipc	ra,0x0
 17c:	f9a080e7          	jalr	-102(ra) # 112 <main>
  exit(r);
 180:	00000097          	auipc	ra,0x0
 184:	302080e7          	jalr	770(ra) # 482 <exit>

0000000000000188 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18e:	87aa                	mv	a5,a0
 190:	0585                	addi	a1,a1,1
 192:	0785                	addi	a5,a5,1
 194:	fff5c703          	lbu	a4,-1(a1)
 198:	fee78fa3          	sb	a4,-1(a5)
 19c:	fb75                	bnez	a4,190 <strcpy+0x8>
    ;
  return os;
}
 19e:	6422                	ld	s0,8(sp)
 1a0:	0141                	addi	sp,sp,16
 1a2:	8082                	ret

00000000000001a4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a4:	1141                	addi	sp,sp,-16
 1a6:	e422                	sd	s0,8(sp)
 1a8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1aa:	00054783          	lbu	a5,0(a0)
 1ae:	cb91                	beqz	a5,1c2 <strcmp+0x1e>
 1b0:	0005c703          	lbu	a4,0(a1)
 1b4:	00f71763          	bne	a4,a5,1c2 <strcmp+0x1e>
    p++, q++;
 1b8:	0505                	addi	a0,a0,1
 1ba:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	fbe5                	bnez	a5,1b0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1c2:	0005c503          	lbu	a0,0(a1)
}
 1c6:	40a7853b          	subw	a0,a5,a0
 1ca:	6422                	ld	s0,8(sp)
 1cc:	0141                	addi	sp,sp,16
 1ce:	8082                	ret

00000000000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	1141                	addi	sp,sp,-16
 1d2:	e422                	sd	s0,8(sp)
 1d4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1d6:	00054783          	lbu	a5,0(a0)
 1da:	cf91                	beqz	a5,1f6 <strlen+0x26>
 1dc:	0505                	addi	a0,a0,1
 1de:	87aa                	mv	a5,a0
 1e0:	86be                	mv	a3,a5
 1e2:	0785                	addi	a5,a5,1
 1e4:	fff7c703          	lbu	a4,-1(a5)
 1e8:	ff65                	bnez	a4,1e0 <strlen+0x10>
 1ea:	40a6853b          	subw	a0,a3,a0
 1ee:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1f0:	6422                	ld	s0,8(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret
  for(n = 0; s[n]; n++)
 1f6:	4501                	li	a0,0
 1f8:	bfe5                	j	1f0 <strlen+0x20>

00000000000001fa <memset>:

void*
memset(void *dst, int c, uint n)
{
 1fa:	1141                	addi	sp,sp,-16
 1fc:	e422                	sd	s0,8(sp)
 1fe:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 200:	ca19                	beqz	a2,216 <memset+0x1c>
 202:	87aa                	mv	a5,a0
 204:	1602                	slli	a2,a2,0x20
 206:	9201                	srli	a2,a2,0x20
 208:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 20c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 210:	0785                	addi	a5,a5,1
 212:	fee79de3          	bne	a5,a4,20c <memset+0x12>
  }
  return dst;
}
 216:	6422                	ld	s0,8(sp)
 218:	0141                	addi	sp,sp,16
 21a:	8082                	ret

000000000000021c <strchr>:

char*
strchr(const char *s, char c)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
  for(; *s; s++)
 222:	00054783          	lbu	a5,0(a0)
 226:	cb99                	beqz	a5,23c <strchr+0x20>
    if(*s == c)
 228:	00f58763          	beq	a1,a5,236 <strchr+0x1a>
  for(; *s; s++)
 22c:	0505                	addi	a0,a0,1
 22e:	00054783          	lbu	a5,0(a0)
 232:	fbfd                	bnez	a5,228 <strchr+0xc>
      return (char*)s;
  return 0;
 234:	4501                	li	a0,0
}
 236:	6422                	ld	s0,8(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret
  return 0;
 23c:	4501                	li	a0,0
 23e:	bfe5                	j	236 <strchr+0x1a>

0000000000000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	711d                	addi	sp,sp,-96
 242:	ec86                	sd	ra,88(sp)
 244:	e8a2                	sd	s0,80(sp)
 246:	e4a6                	sd	s1,72(sp)
 248:	e0ca                	sd	s2,64(sp)
 24a:	fc4e                	sd	s3,56(sp)
 24c:	f852                	sd	s4,48(sp)
 24e:	f456                	sd	s5,40(sp)
 250:	f05a                	sd	s6,32(sp)
 252:	ec5e                	sd	s7,24(sp)
 254:	1080                	addi	s0,sp,96
 256:	8baa                	mv	s7,a0
 258:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25a:	892a                	mv	s2,a0
 25c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 25e:	4aa9                	li	s5,10
 260:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 262:	89a6                	mv	s3,s1
 264:	2485                	addiw	s1,s1,1
 266:	0344d863          	bge	s1,s4,296 <gets+0x56>
    cc = read(0, &c, 1);
 26a:	4605                	li	a2,1
 26c:	faf40593          	addi	a1,s0,-81
 270:	4501                	li	a0,0
 272:	00000097          	auipc	ra,0x0
 276:	240080e7          	jalr	576(ra) # 4b2 <read>
    if(cc < 1)
 27a:	00a05e63          	blez	a0,296 <gets+0x56>
    buf[i++] = c;
 27e:	faf44783          	lbu	a5,-81(s0)
 282:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 286:	01578763          	beq	a5,s5,294 <gets+0x54>
 28a:	0905                	addi	s2,s2,1
 28c:	fd679be3          	bne	a5,s6,262 <gets+0x22>
    buf[i++] = c;
 290:	89a6                	mv	s3,s1
 292:	a011                	j	296 <gets+0x56>
 294:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 296:	99de                	add	s3,s3,s7
 298:	00098023          	sb	zero,0(s3)
  return buf;
}
 29c:	855e                	mv	a0,s7
 29e:	60e6                	ld	ra,88(sp)
 2a0:	6446                	ld	s0,80(sp)
 2a2:	64a6                	ld	s1,72(sp)
 2a4:	6906                	ld	s2,64(sp)
 2a6:	79e2                	ld	s3,56(sp)
 2a8:	7a42                	ld	s4,48(sp)
 2aa:	7aa2                	ld	s5,40(sp)
 2ac:	7b02                	ld	s6,32(sp)
 2ae:	6be2                	ld	s7,24(sp)
 2b0:	6125                	addi	sp,sp,96
 2b2:	8082                	ret

00000000000002b4 <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e422                	sd	s0,8(sp)
 2b8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ba:	00054683          	lbu	a3,0(a0)
 2be:	fd06879b          	addiw	a5,a3,-48
 2c2:	0ff7f793          	zext.b	a5,a5
 2c6:	4625                	li	a2,9
 2c8:	02f66863          	bltu	a2,a5,2f8 <atoi+0x44>
 2cc:	872a                	mv	a4,a0
  n = 0;
 2ce:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d0:	0705                	addi	a4,a4,1
 2d2:	0025179b          	slliw	a5,a0,0x2
 2d6:	9fa9                	addw	a5,a5,a0
 2d8:	0017979b          	slliw	a5,a5,0x1
 2dc:	9fb5                	addw	a5,a5,a3
 2de:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e2:	00074683          	lbu	a3,0(a4)
 2e6:	fd06879b          	addiw	a5,a3,-48
 2ea:	0ff7f793          	zext.b	a5,a5
 2ee:	fef671e3          	bgeu	a2,a5,2d0 <atoi+0x1c>
  return n;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  n = 0;
 2f8:	4501                	li	a0,0
 2fa:	bfe5                	j	2f2 <atoi+0x3e>

00000000000002fc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 302:	02b57463          	bgeu	a0,a1,32a <memmove+0x2e>
    while(n-- > 0)
 306:	00c05f63          	blez	a2,324 <memmove+0x28>
 30a:	1602                	slli	a2,a2,0x20
 30c:	9201                	srli	a2,a2,0x20
 30e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 312:	872a                	mv	a4,a0
      *dst++ = *src++;
 314:	0585                	addi	a1,a1,1
 316:	0705                	addi	a4,a4,1
 318:	fff5c683          	lbu	a3,-1(a1)
 31c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 320:	fef71ae3          	bne	a4,a5,314 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 324:	6422                	ld	s0,8(sp)
 326:	0141                	addi	sp,sp,16
 328:	8082                	ret
    dst += n;
 32a:	00c50733          	add	a4,a0,a2
    src += n;
 32e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 330:	fec05ae3          	blez	a2,324 <memmove+0x28>
 334:	fff6079b          	addiw	a5,a2,-1
 338:	1782                	slli	a5,a5,0x20
 33a:	9381                	srli	a5,a5,0x20
 33c:	fff7c793          	not	a5,a5
 340:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 342:	15fd                	addi	a1,a1,-1
 344:	177d                	addi	a4,a4,-1
 346:	0005c683          	lbu	a3,0(a1)
 34a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 34e:	fee79ae3          	bne	a5,a4,342 <memmove+0x46>
 352:	bfc9                	j	324 <memmove+0x28>

0000000000000354 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 35a:	ca05                	beqz	a2,38a <memcmp+0x36>
 35c:	fff6069b          	addiw	a3,a2,-1
 360:	1682                	slli	a3,a3,0x20
 362:	9281                	srli	a3,a3,0x20
 364:	0685                	addi	a3,a3,1
 366:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 368:	00054783          	lbu	a5,0(a0)
 36c:	0005c703          	lbu	a4,0(a1)
 370:	00e79863          	bne	a5,a4,380 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 374:	0505                	addi	a0,a0,1
    p2++;
 376:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 378:	fed518e3          	bne	a0,a3,368 <memcmp+0x14>
  }
  return 0;
 37c:	4501                	li	a0,0
 37e:	a019                	j	384 <memcmp+0x30>
      return *p1 - *p2;
 380:	40e7853b          	subw	a0,a5,a4
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
  return 0;
 38a:	4501                	li	a0,0
 38c:	bfe5                	j	384 <memcmp+0x30>

000000000000038e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e406                	sd	ra,8(sp)
 392:	e022                	sd	s0,0(sp)
 394:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 396:	00000097          	auipc	ra,0x0
 39a:	f66080e7          	jalr	-154(ra) # 2fc <memmove>
}
 39e:	60a2                	ld	ra,8(sp)
 3a0:	6402                	ld	s0,0(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret

00000000000003a6 <sbrk>:

char *
sbrk(int n) {
 3a6:	1141                	addi	sp,sp,-16
 3a8:	e406                	sd	ra,8(sp)
 3aa:	e022                	sd	s0,0(sp)
 3ac:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3ae:	4585                	li	a1,1
 3b0:	00000097          	auipc	ra,0x0
 3b4:	12a080e7          	jalr	298(ra) # 4da <sys_sbrk>
}
 3b8:	60a2                	ld	ra,8(sp)
 3ba:	6402                	ld	s0,0(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <get_time>:
//   return sys_sbrk(n, SBRK_LAZY);
// }


unsigned int 
get_time(void) {
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e406                	sd	ra,8(sp)
 3c4:	e022                	sd	s0,0(sp)
 3c6:	0800                	addi	s0,sp,16
    return uptime();
 3c8:	00000097          	auipc	ra,0x0
 3cc:	11a080e7          	jalr	282(ra) # 4e2 <uptime>
}
 3d0:	2501                	sext.w	a0,a0
 3d2:	60a2                	ld	ra,8(sp)
 3d4:	6402                	ld	s0,0(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret

00000000000003da <make_filename>:
void 
make_filename(char *buf, const char *prefix, int num) {
    // 复制前缀
    char *p = buf;
    const char *s = prefix;
    while(*s) *p++ = *s++;
 3da:	0005c783          	lbu	a5,0(a1)
 3de:	cb81                	beqz	a5,3ee <make_filename+0x14>
 3e0:	0585                	addi	a1,a1,1
 3e2:	0505                	addi	a0,a0,1
 3e4:	fef50fa3          	sb	a5,-1(a0)
 3e8:	0005c783          	lbu	a5,0(a1)
 3ec:	fbf5                	bnez	a5,3e0 <make_filename+0x6>
    
    // 处理数字部分
    if (num == 0) {
 3ee:	ca3d                	beqz	a2,464 <make_filename+0x8a>
make_filename(char *buf, const char *prefix, int num) {
 3f0:	1101                	addi	sp,sp,-32
 3f2:	ec22                	sd	s0,24(sp)
 3f4:	1000                	addi	s0,sp,32
        *p++ = '0';
    } else {
        // 临时缓冲区存放数字
        char digits[16];
        int i = 0;
        while(num > 0) {
 3f6:	fe040893          	addi	a7,s0,-32
 3fa:	87c6                	mv	a5,a7
            digits[i++] = (num % 10) + '0';
 3fc:	46a9                	li	a3,10
        while(num > 0) {
 3fe:	4825                	li	a6,9
 400:	06c05063          	blez	a2,460 <make_filename+0x86>
            digits[i++] = (num % 10) + '0';
 404:	02d6673b          	remw	a4,a2,a3
 408:	0307071b          	addiw	a4,a4,48
 40c:	00e78023          	sb	a4,0(a5)
            num /= 10;
 410:	85b2                	mv	a1,a2
 412:	02d6463b          	divw	a2,a2,a3
        while(num > 0) {
 416:	873e                	mv	a4,a5
 418:	0785                	addi	a5,a5,1
 41a:	feb845e3          	blt	a6,a1,404 <make_filename+0x2a>
 41e:	4117073b          	subw	a4,a4,a7
 422:	0017069b          	addiw	a3,a4,1
            digits[i++] = (num % 10) + '0';
 426:	0006879b          	sext.w	a5,a3
        }
        // 倒序写入
        while(i > 0) *p++ = digits[--i];
 42a:	04f05663          	blez	a5,476 <make_filename+0x9c>
 42e:	fe040713          	addi	a4,s0,-32
 432:	973e                	add	a4,a4,a5
 434:	02069593          	slli	a1,a3,0x20
 438:	9181                	srli	a1,a1,0x20
 43a:	95aa                	add	a1,a1,a0
 43c:	87aa                	mv	a5,a0
 43e:	0785                	addi	a5,a5,1
 440:	fff74603          	lbu	a2,-1(a4)
 444:	fec78fa3          	sb	a2,-1(a5)
 448:	177d                	addi	a4,a4,-1
 44a:	feb79ae3          	bne	a5,a1,43e <make_filename+0x64>
 44e:	02069793          	slli	a5,a3,0x20
 452:	9381                	srli	a5,a5,0x20
 454:	97aa                	add	a5,a5,a0
    }
    *p = 0; // 字符串结束符
 456:	00078023          	sb	zero,0(a5)
 45a:	6462                	ld	s0,24(sp)
 45c:	6105                	addi	sp,sp,32
 45e:	8082                	ret
        while(num > 0) {
 460:	87aa                	mv	a5,a0
 462:	bfd5                	j	456 <make_filename+0x7c>
        *p++ = '0';
 464:	00150793          	addi	a5,a0,1
 468:	03000713          	li	a4,48
 46c:	00e50023          	sb	a4,0(a0)
    *p = 0; // 字符串结束符
 470:	00078023          	sb	zero,0(a5)
 474:	8082                	ret
        while(i > 0) *p++ = digits[--i];
 476:	87aa                	mv	a5,a0
 478:	bff9                	j	456 <make_filename+0x7c>

000000000000047a <fork>:
.globl unlink
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 47a:	4885                	li	a7,1
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <exit>:
.global exit
exit:
 li a7, SYS_exit
 482:	4889                	li	a7,2
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <wait>:
.global wait
wait:
 li a7, SYS_wait
 48a:	488d                	li	a7,3
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 492:	4891                	li	a7,4
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <close>:
.global close
close:
 li a7, SYS_close
 49a:	4899                	li	a7,6
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <open>:
.global open
open:
 li a7, SYS_open
 4a2:	489d                	li	a7,7
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <exec>:
.global exec
exec:
 li a7, SYS_exec
 4aa:	4895                	li	a7,5
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <read>:
.global read
read:
 li a7, SYS_read
 4b2:	48a1                	li	a7,8
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <write>:
.global write
write:
 li a7, SYS_write
 4ba:	48a5                	li	a7,9
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c2:	48a9                	li	a7,10
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
 4ca:	48ad                	li	a7,11
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
 4d2:	48b1                	li	a7,12
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4da:	48b5                	li	a7,13
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e2:	48b9                	li	a7,14
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ea:	48bd                	li	a7,15
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f2:	48c1                	li	a7,16
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4fa:	1101                	addi	sp,sp,-32
 4fc:	ec06                	sd	ra,24(sp)
 4fe:	e822                	sd	s0,16(sp)
 500:	1000                	addi	s0,sp,32
 502:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 506:	4605                	li	a2,1
 508:	fef40593          	addi	a1,s0,-17
 50c:	00000097          	auipc	ra,0x0
 510:	fae080e7          	jalr	-82(ra) # 4ba <write>
}
 514:	60e2                	ld	ra,24(sp)
 516:	6442                	ld	s0,16(sp)
 518:	6105                	addi	sp,sp,32
 51a:	8082                	ret

000000000000051c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 51c:	715d                	addi	sp,sp,-80
 51e:	e486                	sd	ra,72(sp)
 520:	e0a2                	sd	s0,64(sp)
 522:	f84a                	sd	s2,48(sp)
 524:	0880                	addi	s0,sp,80
 526:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 528:	c299                	beqz	a3,52e <printint+0x12>
 52a:	0805c563          	bltz	a1,5b4 <printint+0x98>
  neg = 0;
 52e:	4881                	li	a7,0
 530:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 534:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 536:	00000517          	auipc	a0,0x0
 53a:	58250513          	addi	a0,a0,1410 # ab8 <digits>
 53e:	883e                	mv	a6,a5
 540:	2785                	addiw	a5,a5,1
 542:	02c5f733          	remu	a4,a1,a2
 546:	972a                	add	a4,a4,a0
 548:	00074703          	lbu	a4,0(a4)
 54c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 550:	872e                	mv	a4,a1
 552:	02c5d5b3          	divu	a1,a1,a2
 556:	0685                	addi	a3,a3,1
 558:	fec773e3          	bgeu	a4,a2,53e <printint+0x22>
  if(neg)
 55c:	00088b63          	beqz	a7,572 <printint+0x56>
    buf[i++] = '-';
 560:	fd078793          	addi	a5,a5,-48
 564:	97a2                	add	a5,a5,s0
 566:	02d00713          	li	a4,45
 56a:	fee78423          	sb	a4,-24(a5)
 56e:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 572:	02f05c63          	blez	a5,5aa <printint+0x8e>
 576:	fc26                	sd	s1,56(sp)
 578:	f44e                	sd	s3,40(sp)
 57a:	fb840713          	addi	a4,s0,-72
 57e:	00f704b3          	add	s1,a4,a5
 582:	fff70993          	addi	s3,a4,-1
 586:	99be                	add	s3,s3,a5
 588:	37fd                	addiw	a5,a5,-1
 58a:	1782                	slli	a5,a5,0x20
 58c:	9381                	srli	a5,a5,0x20
 58e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 592:	fff4c583          	lbu	a1,-1(s1)
 596:	854a                	mv	a0,s2
 598:	00000097          	auipc	ra,0x0
 59c:	f62080e7          	jalr	-158(ra) # 4fa <putc>
  while(--i >= 0)
 5a0:	14fd                	addi	s1,s1,-1
 5a2:	ff3498e3          	bne	s1,s3,592 <printint+0x76>
 5a6:	74e2                	ld	s1,56(sp)
 5a8:	79a2                	ld	s3,40(sp)
}
 5aa:	60a6                	ld	ra,72(sp)
 5ac:	6406                	ld	s0,64(sp)
 5ae:	7942                	ld	s2,48(sp)
 5b0:	6161                	addi	sp,sp,80
 5b2:	8082                	ret
    x = -xx;
 5b4:	40b005b3          	neg	a1,a1
    neg = 1;
 5b8:	4885                	li	a7,1
    x = -xx;
 5ba:	bf9d                	j	530 <printint+0x14>

00000000000005bc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5bc:	711d                	addi	sp,sp,-96
 5be:	ec86                	sd	ra,88(sp)
 5c0:	e8a2                	sd	s0,80(sp)
 5c2:	e0ca                	sd	s2,64(sp)
 5c4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c6:	0005c903          	lbu	s2,0(a1)
 5ca:	2c090a63          	beqz	s2,89e <vprintf+0x2e2>
 5ce:	e4a6                	sd	s1,72(sp)
 5d0:	fc4e                	sd	s3,56(sp)
 5d2:	f852                	sd	s4,48(sp)
 5d4:	f456                	sd	s5,40(sp)
 5d6:	f05a                	sd	s6,32(sp)
 5d8:	ec5e                	sd	s7,24(sp)
 5da:	e862                	sd	s8,16(sp)
 5dc:	e466                	sd	s9,8(sp)
 5de:	8b2a                	mv	s6,a0
 5e0:	8a2e                	mv	s4,a1
 5e2:	8bb2                	mv	s7,a2
  state = 0;
 5e4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5e6:	4481                	li	s1,0
 5e8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5ea:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5ee:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5f2:	06c00c93          	li	s9,108
 5f6:	a015                	j	61a <vprintf+0x5e>
        putc(fd, c0);
 5f8:	85ca                	mv	a1,s2
 5fa:	855a                	mv	a0,s6
 5fc:	00000097          	auipc	ra,0x0
 600:	efe080e7          	jalr	-258(ra) # 4fa <putc>
 604:	a019                	j	60a <vprintf+0x4e>
    } else if(state == '%'){
 606:	03598263          	beq	s3,s5,62a <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
 60a:	2485                	addiw	s1,s1,1
 60c:	8726                	mv	a4,s1
 60e:	009a07b3          	add	a5,s4,s1
 612:	0007c903          	lbu	s2,0(a5)
 616:	26090c63          	beqz	s2,88e <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
 61a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 61e:	fe0994e3          	bnez	s3,606 <vprintf+0x4a>
      if(c0 == '%'){
 622:	fd579be3          	bne	a5,s5,5f8 <vprintf+0x3c>
        state = '%';
 626:	89be                	mv	s3,a5
 628:	b7cd                	j	60a <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
 62a:	00ea06b3          	add	a3,s4,a4
 62e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 632:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 634:	c681                	beqz	a3,63c <vprintf+0x80>
 636:	9752                	add	a4,a4,s4
 638:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 63c:	05878563          	beq	a5,s8,686 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
 640:	07978163          	beq	a5,s9,6a2 <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 644:	07500713          	li	a4,117
 648:	10e78563          	beq	a5,a4,752 <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 64c:	07800713          	li	a4,120
 650:	14e78d63          	beq	a5,a4,7aa <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 654:	07000713          	li	a4,112
 658:	18e78663          	beq	a5,a4,7e4 <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 65c:	06300713          	li	a4,99
 660:	1ce78c63          	beq	a5,a4,838 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 664:	07300713          	li	a4,115
 668:	1ee78463          	beq	a5,a4,850 <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 66c:	02500713          	li	a4,37
 670:	04e79963          	bne	a5,a4,6c2 <vprintf+0x106>
        putc(fd, '%');
 674:	02500593          	li	a1,37
 678:	855a                	mv	a0,s6
 67a:	00000097          	auipc	ra,0x0
 67e:	e80080e7          	jalr	-384(ra) # 4fa <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 682:	4981                	li	s3,0
 684:	b759                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
 686:	008b8913          	addi	s2,s7,8
 68a:	4685                	li	a3,1
 68c:	4629                	li	a2,10
 68e:	000ba583          	lw	a1,0(s7)
 692:	855a                	mv	a0,s6
 694:	00000097          	auipc	ra,0x0
 698:	e88080e7          	jalr	-376(ra) # 51c <printint>
 69c:	8bca                	mv	s7,s2
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b7ad                	j	60a <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
 6a2:	06400793          	li	a5,100
 6a6:	02f68d63          	beq	a3,a5,6e0 <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6aa:	06c00793          	li	a5,108
 6ae:	04f68863          	beq	a3,a5,6fe <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
 6b2:	07500793          	li	a5,117
 6b6:	0af68c63          	beq	a3,a5,76e <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
 6ba:	07800793          	li	a5,120
 6be:	10f68463          	beq	a3,a5,7c6 <vprintf+0x20a>
        putc(fd, '%');
 6c2:	02500593          	li	a1,37
 6c6:	855a                	mv	a0,s6
 6c8:	00000097          	auipc	ra,0x0
 6cc:	e32080e7          	jalr	-462(ra) # 4fa <putc>
        putc(fd, c0);
 6d0:	85ca                	mv	a1,s2
 6d2:	855a                	mv	a0,s6
 6d4:	00000097          	auipc	ra,0x0
 6d8:	e26080e7          	jalr	-474(ra) # 4fa <putc>
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	b735                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e0:	008b8913          	addi	s2,s7,8
 6e4:	4685                	li	a3,1
 6e6:	4629                	li	a2,10
 6e8:	000bb583          	ld	a1,0(s7)
 6ec:	855a                	mv	a0,s6
 6ee:	00000097          	auipc	ra,0x0
 6f2:	e2e080e7          	jalr	-466(ra) # 51c <printint>
        i += 1;
 6f6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f8:	8bca                	mv	s7,s2
      state = 0;
 6fa:	4981                	li	s3,0
        i += 1;
 6fc:	b739                	j	60a <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6fe:	06400793          	li	a5,100
 702:	02f60963          	beq	a2,a5,734 <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 706:	07500793          	li	a5,117
 70a:	08f60163          	beq	a2,a5,78c <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 70e:	07800793          	li	a5,120
 712:	faf618e3          	bne	a2,a5,6c2 <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
 716:	008b8913          	addi	s2,s7,8
 71a:	4681                	li	a3,0
 71c:	4641                	li	a2,16
 71e:	000bb583          	ld	a1,0(s7)
 722:	855a                	mv	a0,s6
 724:	00000097          	auipc	ra,0x0
 728:	df8080e7          	jalr	-520(ra) # 51c <printint>
        i += 2;
 72c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 72e:	8bca                	mv	s7,s2
      state = 0;
 730:	4981                	li	s3,0
        i += 2;
 732:	bde1                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
 734:	008b8913          	addi	s2,s7,8
 738:	4685                	li	a3,1
 73a:	4629                	li	a2,10
 73c:	000bb583          	ld	a1,0(s7)
 740:	855a                	mv	a0,s6
 742:	00000097          	auipc	ra,0x0
 746:	dda080e7          	jalr	-550(ra) # 51c <printint>
        i += 2;
 74a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 74c:	8bca                	mv	s7,s2
      state = 0;
 74e:	4981                	li	s3,0
        i += 2;
 750:	bd6d                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
 752:	008b8913          	addi	s2,s7,8
 756:	4681                	li	a3,0
 758:	4629                	li	a2,10
 75a:	000be583          	lwu	a1,0(s7)
 75e:	855a                	mv	a0,s6
 760:	00000097          	auipc	ra,0x0
 764:	dbc080e7          	jalr	-580(ra) # 51c <printint>
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
 76c:	bd79                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76e:	008b8913          	addi	s2,s7,8
 772:	4681                	li	a3,0
 774:	4629                	li	a2,10
 776:	000bb583          	ld	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	00000097          	auipc	ra,0x0
 780:	da0080e7          	jalr	-608(ra) # 51c <printint>
        i += 1;
 784:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 786:	8bca                	mv	s7,s2
      state = 0;
 788:	4981                	li	s3,0
        i += 1;
 78a:	b541                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
 78c:	008b8913          	addi	s2,s7,8
 790:	4681                	li	a3,0
 792:	4629                	li	a2,10
 794:	000bb583          	ld	a1,0(s7)
 798:	855a                	mv	a0,s6
 79a:	00000097          	auipc	ra,0x0
 79e:	d82080e7          	jalr	-638(ra) # 51c <printint>
        i += 2;
 7a2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a4:	8bca                	mv	s7,s2
      state = 0;
 7a6:	4981                	li	s3,0
        i += 2;
 7a8:	b58d                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7aa:	008b8913          	addi	s2,s7,8
 7ae:	4681                	li	a3,0
 7b0:	4641                	li	a2,16
 7b2:	000be583          	lwu	a1,0(s7)
 7b6:	855a                	mv	a0,s6
 7b8:	00000097          	auipc	ra,0x0
 7bc:	d64080e7          	jalr	-668(ra) # 51c <printint>
 7c0:	8bca                	mv	s7,s2
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	b599                	j	60a <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7c6:	008b8913          	addi	s2,s7,8
 7ca:	4681                	li	a3,0
 7cc:	4641                	li	a2,16
 7ce:	000bb583          	ld	a1,0(s7)
 7d2:	855a                	mv	a0,s6
 7d4:	00000097          	auipc	ra,0x0
 7d8:	d48080e7          	jalr	-696(ra) # 51c <printint>
        i += 1;
 7dc:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7de:	8bca                	mv	s7,s2
      state = 0;
 7e0:	4981                	li	s3,0
        i += 1;
 7e2:	b525                	j	60a <vprintf+0x4e>
 7e4:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7e6:	008b8d13          	addi	s10,s7,8
 7ea:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7ee:	03000593          	li	a1,48
 7f2:	855a                	mv	a0,s6
 7f4:	00000097          	auipc	ra,0x0
 7f8:	d06080e7          	jalr	-762(ra) # 4fa <putc>
  putc(fd, 'x');
 7fc:	07800593          	li	a1,120
 800:	855a                	mv	a0,s6
 802:	00000097          	auipc	ra,0x0
 806:	cf8080e7          	jalr	-776(ra) # 4fa <putc>
 80a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 80c:	00000b97          	auipc	s7,0x0
 810:	2acb8b93          	addi	s7,s7,684 # ab8 <digits>
 814:	03c9d793          	srli	a5,s3,0x3c
 818:	97de                	add	a5,a5,s7
 81a:	0007c583          	lbu	a1,0(a5)
 81e:	855a                	mv	a0,s6
 820:	00000097          	auipc	ra,0x0
 824:	cda080e7          	jalr	-806(ra) # 4fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 828:	0992                	slli	s3,s3,0x4
 82a:	397d                	addiw	s2,s2,-1
 82c:	fe0914e3          	bnez	s2,814 <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
 830:	8bea                	mv	s7,s10
      state = 0;
 832:	4981                	li	s3,0
 834:	6d02                	ld	s10,0(sp)
 836:	bbd1                	j	60a <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
 838:	008b8913          	addi	s2,s7,8
 83c:	000bc583          	lbu	a1,0(s7)
 840:	855a                	mv	a0,s6
 842:	00000097          	auipc	ra,0x0
 846:	cb8080e7          	jalr	-840(ra) # 4fa <putc>
 84a:	8bca                	mv	s7,s2
      state = 0;
 84c:	4981                	li	s3,0
 84e:	bb75                	j	60a <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
 850:	008b8993          	addi	s3,s7,8
 854:	000bb903          	ld	s2,0(s7)
 858:	02090163          	beqz	s2,87a <vprintf+0x2be>
        for(; *s; s++)
 85c:	00094583          	lbu	a1,0(s2)
 860:	c585                	beqz	a1,888 <vprintf+0x2cc>
          putc(fd, *s);
 862:	855a                	mv	a0,s6
 864:	00000097          	auipc	ra,0x0
 868:	c96080e7          	jalr	-874(ra) # 4fa <putc>
        for(; *s; s++)
 86c:	0905                	addi	s2,s2,1
 86e:	00094583          	lbu	a1,0(s2)
 872:	f9e5                	bnez	a1,862 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 874:	8bce                	mv	s7,s3
      state = 0;
 876:	4981                	li	s3,0
 878:	bb49                	j	60a <vprintf+0x4e>
          s = "(null)";
 87a:	00000917          	auipc	s2,0x0
 87e:	23690913          	addi	s2,s2,566 # ab0 <malloc+0x122>
        for(; *s; s++)
 882:	02800593          	li	a1,40
 886:	bff1                	j	862 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
 888:	8bce                	mv	s7,s3
      state = 0;
 88a:	4981                	li	s3,0
 88c:	bbbd                	j	60a <vprintf+0x4e>
 88e:	64a6                	ld	s1,72(sp)
 890:	79e2                	ld	s3,56(sp)
 892:	7a42                	ld	s4,48(sp)
 894:	7aa2                	ld	s5,40(sp)
 896:	7b02                	ld	s6,32(sp)
 898:	6be2                	ld	s7,24(sp)
 89a:	6c42                	ld	s8,16(sp)
 89c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 89e:	60e6                	ld	ra,88(sp)
 8a0:	6446                	ld	s0,80(sp)
 8a2:	6906                	ld	s2,64(sp)
 8a4:	6125                	addi	sp,sp,96
 8a6:	8082                	ret

00000000000008a8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8a8:	715d                	addi	sp,sp,-80
 8aa:	ec06                	sd	ra,24(sp)
 8ac:	e822                	sd	s0,16(sp)
 8ae:	1000                	addi	s0,sp,32
 8b0:	e010                	sd	a2,0(s0)
 8b2:	e414                	sd	a3,8(s0)
 8b4:	e818                	sd	a4,16(s0)
 8b6:	ec1c                	sd	a5,24(s0)
 8b8:	03043023          	sd	a6,32(s0)
 8bc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8c4:	8622                	mv	a2,s0
 8c6:	00000097          	auipc	ra,0x0
 8ca:	cf6080e7          	jalr	-778(ra) # 5bc <vprintf>
}
 8ce:	60e2                	ld	ra,24(sp)
 8d0:	6442                	ld	s0,16(sp)
 8d2:	6161                	addi	sp,sp,80
 8d4:	8082                	ret

00000000000008d6 <printf>:

void
printf(const char *fmt, ...)
{
 8d6:	711d                	addi	sp,sp,-96
 8d8:	ec06                	sd	ra,24(sp)
 8da:	e822                	sd	s0,16(sp)
 8dc:	1000                	addi	s0,sp,32
 8de:	e40c                	sd	a1,8(s0)
 8e0:	e810                	sd	a2,16(s0)
 8e2:	ec14                	sd	a3,24(s0)
 8e4:	f018                	sd	a4,32(s0)
 8e6:	f41c                	sd	a5,40(s0)
 8e8:	03043823          	sd	a6,48(s0)
 8ec:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8f0:	00840613          	addi	a2,s0,8
 8f4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8f8:	85aa                	mv	a1,a0
 8fa:	4505                	li	a0,1
 8fc:	00000097          	auipc	ra,0x0
 900:	cc0080e7          	jalr	-832(ra) # 5bc <vprintf>
}
 904:	60e2                	ld	ra,24(sp)
 906:	6442                	ld	s0,16(sp)
 908:	6125                	addi	sp,sp,96
 90a:	8082                	ret

000000000000090c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 90c:	1141                	addi	sp,sp,-16
 90e:	e422                	sd	s0,8(sp)
 910:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 912:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 916:	00000797          	auipc	a5,0x0
 91a:	6ea7b783          	ld	a5,1770(a5) # 1000 <freep>
 91e:	a02d                	j	948 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 920:	4618                	lw	a4,8(a2)
 922:	9f2d                	addw	a4,a4,a1
 924:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 928:	6398                	ld	a4,0(a5)
 92a:	6310                	ld	a2,0(a4)
 92c:	a83d                	j	96a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 92e:	ff852703          	lw	a4,-8(a0)
 932:	9f31                	addw	a4,a4,a2
 934:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 936:	ff053683          	ld	a3,-16(a0)
 93a:	a091                	j	97e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93c:	6398                	ld	a4,0(a5)
 93e:	00e7e463          	bltu	a5,a4,946 <free+0x3a>
 942:	00e6ea63          	bltu	a3,a4,956 <free+0x4a>
{
 946:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 948:	fed7fae3          	bgeu	a5,a3,93c <free+0x30>
 94c:	6398                	ld	a4,0(a5)
 94e:	00e6e463          	bltu	a3,a4,956 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 952:	fee7eae3          	bltu	a5,a4,946 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 956:	ff852583          	lw	a1,-8(a0)
 95a:	6390                	ld	a2,0(a5)
 95c:	02059813          	slli	a6,a1,0x20
 960:	01c85713          	srli	a4,a6,0x1c
 964:	9736                	add	a4,a4,a3
 966:	fae60de3          	beq	a2,a4,920 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 96a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 96e:	4790                	lw	a2,8(a5)
 970:	02061593          	slli	a1,a2,0x20
 974:	01c5d713          	srli	a4,a1,0x1c
 978:	973e                	add	a4,a4,a5
 97a:	fae68ae3          	beq	a3,a4,92e <free+0x22>
    p->s.ptr = bp->s.ptr;
 97e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 980:	00000717          	auipc	a4,0x0
 984:	68f73023          	sd	a5,1664(a4) # 1000 <freep>
}
 988:	6422                	ld	s0,8(sp)
 98a:	0141                	addi	sp,sp,16
 98c:	8082                	ret

000000000000098e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 98e:	7139                	addi	sp,sp,-64
 990:	fc06                	sd	ra,56(sp)
 992:	f822                	sd	s0,48(sp)
 994:	f426                	sd	s1,40(sp)
 996:	ec4e                	sd	s3,24(sp)
 998:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99a:	02051493          	slli	s1,a0,0x20
 99e:	9081                	srli	s1,s1,0x20
 9a0:	04bd                	addi	s1,s1,15
 9a2:	8091                	srli	s1,s1,0x4
 9a4:	0014899b          	addiw	s3,s1,1
 9a8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9aa:	00000517          	auipc	a0,0x0
 9ae:	65653503          	ld	a0,1622(a0) # 1000 <freep>
 9b2:	c915                	beqz	a0,9e6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b6:	4798                	lw	a4,8(a5)
 9b8:	08977e63          	bgeu	a4,s1,a54 <malloc+0xc6>
 9bc:	f04a                	sd	s2,32(sp)
 9be:	e852                	sd	s4,16(sp)
 9c0:	e456                	sd	s5,8(sp)
 9c2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9c4:	8a4e                	mv	s4,s3
 9c6:	0009871b          	sext.w	a4,s3
 9ca:	6685                	lui	a3,0x1
 9cc:	00d77363          	bgeu	a4,a3,9d2 <malloc+0x44>
 9d0:	6a05                	lui	s4,0x1
 9d2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9da:	00000917          	auipc	s2,0x0
 9de:	62690913          	addi	s2,s2,1574 # 1000 <freep>
  if(p == SBRK_ERROR)
 9e2:	5afd                	li	s5,-1
 9e4:	a091                	j	a28 <malloc+0x9a>
 9e6:	f04a                	sd	s2,32(sp)
 9e8:	e852                	sd	s4,16(sp)
 9ea:	e456                	sd	s5,8(sp)
 9ec:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9ee:	00000797          	auipc	a5,0x0
 9f2:	62278793          	addi	a5,a5,1570 # 1010 <base>
 9f6:	00000717          	auipc	a4,0x0
 9fa:	60f73523          	sd	a5,1546(a4) # 1000 <freep>
 9fe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a00:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a04:	b7c1                	j	9c4 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a06:	6398                	ld	a4,0(a5)
 a08:	e118                	sd	a4,0(a0)
 a0a:	a08d                	j	a6c <malloc+0xde>
  hp->s.size = nu;
 a0c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a10:	0541                	addi	a0,a0,16
 a12:	00000097          	auipc	ra,0x0
 a16:	efa080e7          	jalr	-262(ra) # 90c <free>
  return freep;
 a1a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a1e:	c13d                	beqz	a0,a84 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a20:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a22:	4798                	lw	a4,8(a5)
 a24:	02977463          	bgeu	a4,s1,a4c <malloc+0xbe>
    if(p == freep)
 a28:	00093703          	ld	a4,0(s2)
 a2c:	853e                	mv	a0,a5
 a2e:	fef719e3          	bne	a4,a5,a20 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 a32:	8552                	mv	a0,s4
 a34:	00000097          	auipc	ra,0x0
 a38:	972080e7          	jalr	-1678(ra) # 3a6 <sbrk>
  if(p == SBRK_ERROR)
 a3c:	fd5518e3          	bne	a0,s5,a0c <malloc+0x7e>
        return 0;
 a40:	4501                	li	a0,0
 a42:	7902                	ld	s2,32(sp)
 a44:	6a42                	ld	s4,16(sp)
 a46:	6aa2                	ld	s5,8(sp)
 a48:	6b02                	ld	s6,0(sp)
 a4a:	a03d                	j	a78 <malloc+0xea>
 a4c:	7902                	ld	s2,32(sp)
 a4e:	6a42                	ld	s4,16(sp)
 a50:	6aa2                	ld	s5,8(sp)
 a52:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a54:	fae489e3          	beq	s1,a4,a06 <malloc+0x78>
        p->s.size -= nunits;
 a58:	4137073b          	subw	a4,a4,s3
 a5c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a5e:	02071693          	slli	a3,a4,0x20
 a62:	01c6d713          	srli	a4,a3,0x1c
 a66:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a68:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a6c:	00000717          	auipc	a4,0x0
 a70:	58a73a23          	sd	a0,1428(a4) # 1000 <freep>
      return (void*)(p + 1);
 a74:	01078513          	addi	a0,a5,16
  }
}
 a78:	70e2                	ld	ra,56(sp)
 a7a:	7442                	ld	s0,48(sp)
 a7c:	74a2                	ld	s1,40(sp)
 a7e:	69e2                	ld	s3,24(sp)
 a80:	6121                	addi	sp,sp,64
 a82:	8082                	ret
 a84:	7902                	ld	s2,32(sp)
 a86:	6a42                	ld	s4,16(sp)
 a88:	6aa2                	ld	s5,8(sp)
 a8a:	6b02                	ld	s6,0(sp)
 a8c:	b7f5                	j	a78 <malloc+0xea>
