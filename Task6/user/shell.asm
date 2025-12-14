
user/_shell:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	2de58593          	addi	a1,a1,734 # 12f0 <malloc+0x104>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	d14080e7          	jalr	-748(ra) # d30 <write>
  memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	b00080e7          	jalr	-1280(ra) # b2a <memset>
  gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	b3a080e7          	jalr	-1222(ra) # b70 <gets>
  if(buf[0] == 0) // EOF
      3e:	0004c503          	lbu	a0,0(s1)
      42:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      46:	40a00533          	neg	a0,a0
      4a:	60e2                	ld	ra,24(sp)
      4c:	6442                	ld	s0,16(sp)
      4e:	64a2                	ld	s1,8(sp)
      50:	6902                	ld	s2,0(sp)
      52:	6105                	addi	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
  exit(0);
}

void
panic(char *s)
{
      56:	1141                	addi	sp,sp,-16
      58:	e406                	sd	ra,8(sp)
      5a:	e022                	sd	s0,0(sp)
      5c:	0800                	addi	s0,sp,16
      5e:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      60:	00001597          	auipc	a1,0x1
      64:	2a058593          	addi	a1,a1,672 # 1300 <malloc+0x114>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	09c080e7          	jalr	156(ra) # 1106 <fprintf>
  exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	c84080e7          	jalr	-892(ra) # cf8 <exit>

000000000000007c <fork1>:
}

int
fork1(void)
{
      7c:	1141                	addi	sp,sp,-16
      7e:	e406                	sd	ra,8(sp)
      80:	e022                	sd	s0,0(sp)
      82:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      84:	00001097          	auipc	ra,0x1
      88:	c6c080e7          	jalr	-916(ra) # cf0 <fork>
  if(pid == -1)
      8c:	57fd                	li	a5,-1
      8e:	00f50663          	beq	a0,a5,9a <fork1+0x1e>
    panic("fork");
  return pid;
}
      92:	60a2                	ld	ra,8(sp)
      94:	6402                	ld	s0,0(sp)
      96:	0141                	addi	sp,sp,16
      98:	8082                	ret
    panic("fork");
      9a:	00001517          	auipc	a0,0x1
      9e:	26e50513          	addi	a0,a0,622 # 1308 <malloc+0x11c>
      a2:	00000097          	auipc	ra,0x0
      a6:	fb4080e7          	jalr	-76(ra) # 56 <panic>

00000000000000aa <runcmd>:
{
      aa:	1101                	addi	sp,sp,-32
      ac:	ec06                	sd	ra,24(sp)
      ae:	e822                	sd	s0,16(sp)
      b0:	1000                	addi	s0,sp,32
  if(cmd == 0)
      b2:	c129                	beqz	a0,f4 <runcmd+0x4a>
      b4:	e426                	sd	s1,8(sp)
      b6:	84aa                	mv	s1,a0
  switch(cmd->type){
      b8:	411c                	lw	a5,0(a0)
      ba:	4711                	li	a4,4
      bc:	0ce78263          	beq	a5,a4,180 <runcmd+0xd6>
      c0:	04f74063          	blt	a4,a5,100 <runcmd+0x56>
      c4:	4705                	li	a4,1
      c6:	06e78263          	beq	a5,a4,12a <runcmd+0x80>
      ca:	4709                	li	a4,2
      cc:	04e79763          	bne	a5,a4,11a <runcmd+0x70>
    close(rcmd->fd);
      d0:	5148                	lw	a0,36(a0)
      d2:	00001097          	auipc	ra,0x1
      d6:	c3e080e7          	jalr	-962(ra) # d10 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      da:	508c                	lw	a1,32(s1)
      dc:	6888                	ld	a0,16(s1)
      de:	00001097          	auipc	ra,0x1
      e2:	c3a080e7          	jalr	-966(ra) # d18 <open>
      e6:	06054e63          	bltz	a0,162 <runcmd+0xb8>
    runcmd(rcmd->cmd);
      ea:	6488                	ld	a0,8(s1)
      ec:	00000097          	auipc	ra,0x0
      f0:	fbe080e7          	jalr	-66(ra) # aa <runcmd>
      f4:	e426                	sd	s1,8(sp)
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00001097          	auipc	ra,0x1
      fc:	c00080e7          	jalr	-1024(ra) # cf8 <exit>
  switch(cmd->type){
     100:	4715                	li	a4,5
     102:	00e79c63          	bne	a5,a4,11a <runcmd+0x70>
    if(fork1() == 0)
     106:	00000097          	auipc	ra,0x0
     10a:	f76080e7          	jalr	-138(ra) # 7c <fork1>
     10e:	e121                	bnez	a0,14e <runcmd+0xa4>
      runcmd(bcmd->cmd);
     110:	6488                	ld	a0,8(s1)
     112:	00000097          	auipc	ra,0x0
     116:	f98080e7          	jalr	-104(ra) # aa <runcmd>
    panic("runcmd");
     11a:	00001517          	auipc	a0,0x1
     11e:	1f650513          	addi	a0,a0,502 # 1310 <malloc+0x124>
     122:	00000097          	auipc	ra,0x0
     126:	f34080e7          	jalr	-204(ra) # 56 <panic>
    if(ecmd->argv[0] == 0)
     12a:	6508                	ld	a0,8(a0)
     12c:	c515                	beqz	a0,158 <runcmd+0xae>
    exec(ecmd->argv[0], ecmd->argv);
     12e:	00848593          	addi	a1,s1,8
     132:	00001097          	auipc	ra,0x1
     136:	bee080e7          	jalr	-1042(ra) # d20 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     13a:	6490                	ld	a2,8(s1)
     13c:	00001597          	auipc	a1,0x1
     140:	1dc58593          	addi	a1,a1,476 # 1318 <malloc+0x12c>
     144:	4509                	li	a0,2
     146:	00001097          	auipc	ra,0x1
     14a:	fc0080e7          	jalr	-64(ra) # 1106 <fprintf>
  exit(0);
     14e:	4501                	li	a0,0
     150:	00001097          	auipc	ra,0x1
     154:	ba8080e7          	jalr	-1112(ra) # cf8 <exit>
      exit(1);
     158:	4505                	li	a0,1
     15a:	00001097          	auipc	ra,0x1
     15e:	b9e080e7          	jalr	-1122(ra) # cf8 <exit>
      fprintf(2, "open %s failed\n", rcmd->file);
     162:	6890                	ld	a2,16(s1)
     164:	00001597          	auipc	a1,0x1
     168:	1c458593          	addi	a1,a1,452 # 1328 <malloc+0x13c>
     16c:	4509                	li	a0,2
     16e:	00001097          	auipc	ra,0x1
     172:	f98080e7          	jalr	-104(ra) # 1106 <fprintf>
      exit(1);
     176:	4505                	li	a0,1
     178:	00001097          	auipc	ra,0x1
     17c:	b80080e7          	jalr	-1152(ra) # cf8 <exit>
    if(fork1() == 0)
     180:	00000097          	auipc	ra,0x0
     184:	efc080e7          	jalr	-260(ra) # 7c <fork1>
     188:	e511                	bnez	a0,194 <runcmd+0xea>
      runcmd(lcmd->left);
     18a:	6488                	ld	a0,8(s1)
     18c:	00000097          	auipc	ra,0x0
     190:	f1e080e7          	jalr	-226(ra) # aa <runcmd>
    wait(0);
     194:	4501                	li	a0,0
     196:	00001097          	auipc	ra,0x1
     19a:	b6a080e7          	jalr	-1174(ra) # d00 <wait>
    runcmd(lcmd->right);
     19e:	6888                	ld	a0,16(s1)
     1a0:	00000097          	auipc	ra,0x0
     1a4:	f0a080e7          	jalr	-246(ra) # aa <runcmd>

00000000000001a8 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     1a8:	1101                	addi	sp,sp,-32
     1aa:	ec06                	sd	ra,24(sp)
     1ac:	e822                	sd	s0,16(sp)
     1ae:	e426                	sd	s1,8(sp)
     1b0:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1b2:	0a800513          	li	a0,168
     1b6:	00001097          	auipc	ra,0x1
     1ba:	036080e7          	jalr	54(ra) # 11ec <malloc>
     1be:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1c0:	0a800613          	li	a2,168
     1c4:	4581                	li	a1,0
     1c6:	00001097          	auipc	ra,0x1
     1ca:	964080e7          	jalr	-1692(ra) # b2a <memset>
  cmd->type = EXEC;
     1ce:	4785                	li	a5,1
     1d0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     1d2:	8526                	mv	a0,s1
     1d4:	60e2                	ld	ra,24(sp)
     1d6:	6442                	ld	s0,16(sp)
     1d8:	64a2                	ld	s1,8(sp)
     1da:	6105                	addi	sp,sp,32
     1dc:	8082                	ret

00000000000001de <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     1de:	7139                	addi	sp,sp,-64
     1e0:	fc06                	sd	ra,56(sp)
     1e2:	f822                	sd	s0,48(sp)
     1e4:	f426                	sd	s1,40(sp)
     1e6:	f04a                	sd	s2,32(sp)
     1e8:	ec4e                	sd	s3,24(sp)
     1ea:	e852                	sd	s4,16(sp)
     1ec:	e456                	sd	s5,8(sp)
     1ee:	e05a                	sd	s6,0(sp)
     1f0:	0080                	addi	s0,sp,64
     1f2:	8b2a                	mv	s6,a0
     1f4:	8aae                	mv	s5,a1
     1f6:	8a32                	mv	s4,a2
     1f8:	89b6                	mv	s3,a3
     1fa:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1fc:	02800513          	li	a0,40
     200:	00001097          	auipc	ra,0x1
     204:	fec080e7          	jalr	-20(ra) # 11ec <malloc>
     208:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     20a:	02800613          	li	a2,40
     20e:	4581                	li	a1,0
     210:	00001097          	auipc	ra,0x1
     214:	91a080e7          	jalr	-1766(ra) # b2a <memset>
  cmd->type = REDIR;
     218:	4789                	li	a5,2
     21a:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     21c:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     220:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     224:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     228:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     22c:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     230:	8526                	mv	a0,s1
     232:	70e2                	ld	ra,56(sp)
     234:	7442                	ld	s0,48(sp)
     236:	74a2                	ld	s1,40(sp)
     238:	7902                	ld	s2,32(sp)
     23a:	69e2                	ld	s3,24(sp)
     23c:	6a42                	ld	s4,16(sp)
     23e:	6aa2                	ld	s5,8(sp)
     240:	6b02                	ld	s6,0(sp)
     242:	6121                	addi	sp,sp,64
     244:	8082                	ret

0000000000000246 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     246:	7179                	addi	sp,sp,-48
     248:	f406                	sd	ra,40(sp)
     24a:	f022                	sd	s0,32(sp)
     24c:	ec26                	sd	s1,24(sp)
     24e:	e84a                	sd	s2,16(sp)
     250:	e44e                	sd	s3,8(sp)
     252:	1800                	addi	s0,sp,48
     254:	89aa                	mv	s3,a0
     256:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     258:	4561                	li	a0,24
     25a:	00001097          	auipc	ra,0x1
     25e:	f92080e7          	jalr	-110(ra) # 11ec <malloc>
     262:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     264:	4661                	li	a2,24
     266:	4581                	li	a1,0
     268:	00001097          	auipc	ra,0x1
     26c:	8c2080e7          	jalr	-1854(ra) # b2a <memset>
  cmd->type = PIPE;
     270:	478d                	li	a5,3
     272:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     274:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     278:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     27c:	8526                	mv	a0,s1
     27e:	70a2                	ld	ra,40(sp)
     280:	7402                	ld	s0,32(sp)
     282:	64e2                	ld	s1,24(sp)
     284:	6942                	ld	s2,16(sp)
     286:	69a2                	ld	s3,8(sp)
     288:	6145                	addi	sp,sp,48
     28a:	8082                	ret

000000000000028c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     28c:	7179                	addi	sp,sp,-48
     28e:	f406                	sd	ra,40(sp)
     290:	f022                	sd	s0,32(sp)
     292:	ec26                	sd	s1,24(sp)
     294:	e84a                	sd	s2,16(sp)
     296:	e44e                	sd	s3,8(sp)
     298:	1800                	addi	s0,sp,48
     29a:	89aa                	mv	s3,a0
     29c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     29e:	4561                	li	a0,24
     2a0:	00001097          	auipc	ra,0x1
     2a4:	f4c080e7          	jalr	-180(ra) # 11ec <malloc>
     2a8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2aa:	4661                	li	a2,24
     2ac:	4581                	li	a1,0
     2ae:	00001097          	auipc	ra,0x1
     2b2:	87c080e7          	jalr	-1924(ra) # b2a <memset>
  cmd->type = LIST;
     2b6:	4791                	li	a5,4
     2b8:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2ba:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     2be:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     2c2:	8526                	mv	a0,s1
     2c4:	70a2                	ld	ra,40(sp)
     2c6:	7402                	ld	s0,32(sp)
     2c8:	64e2                	ld	s1,24(sp)
     2ca:	6942                	ld	s2,16(sp)
     2cc:	69a2                	ld	s3,8(sp)
     2ce:	6145                	addi	sp,sp,48
     2d0:	8082                	ret

00000000000002d2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     2d2:	1101                	addi	sp,sp,-32
     2d4:	ec06                	sd	ra,24(sp)
     2d6:	e822                	sd	s0,16(sp)
     2d8:	e426                	sd	s1,8(sp)
     2da:	e04a                	sd	s2,0(sp)
     2dc:	1000                	addi	s0,sp,32
     2de:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2e0:	4541                	li	a0,16
     2e2:	00001097          	auipc	ra,0x1
     2e6:	f0a080e7          	jalr	-246(ra) # 11ec <malloc>
     2ea:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2ec:	4641                	li	a2,16
     2ee:	4581                	li	a1,0
     2f0:	00001097          	auipc	ra,0x1
     2f4:	83a080e7          	jalr	-1990(ra) # b2a <memset>
  cmd->type = BACK;
     2f8:	4795                	li	a5,5
     2fa:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     300:	8526                	mv	a0,s1
     302:	60e2                	ld	ra,24(sp)
     304:	6442                	ld	s0,16(sp)
     306:	64a2                	ld	s1,8(sp)
     308:	6902                	ld	s2,0(sp)
     30a:	6105                	addi	sp,sp,32
     30c:	8082                	ret

000000000000030e <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     30e:	7139                	addi	sp,sp,-64
     310:	fc06                	sd	ra,56(sp)
     312:	f822                	sd	s0,48(sp)
     314:	f426                	sd	s1,40(sp)
     316:	f04a                	sd	s2,32(sp)
     318:	ec4e                	sd	s3,24(sp)
     31a:	e852                	sd	s4,16(sp)
     31c:	e456                	sd	s5,8(sp)
     31e:	e05a                	sd	s6,0(sp)
     320:	0080                	addi	s0,sp,64
     322:	8a2a                	mv	s4,a0
     324:	892e                	mv	s2,a1
     326:	8ab2                	mv	s5,a2
     328:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     32a:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     32c:	00002997          	auipc	s3,0x2
     330:	cdc98993          	addi	s3,s3,-804 # 2008 <whitespace>
     334:	00b4fe63          	bgeu	s1,a1,350 <gettoken+0x42>
     338:	0004c583          	lbu	a1,0(s1)
     33c:	854e                	mv	a0,s3
     33e:	00001097          	auipc	ra,0x1
     342:	80e080e7          	jalr	-2034(ra) # b4c <strchr>
     346:	c509                	beqz	a0,350 <gettoken+0x42>
    s++;
     348:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     34a:	fe9917e3          	bne	s2,s1,338 <gettoken+0x2a>
     34e:	84ca                	mv	s1,s2
  if(q)
     350:	000a8463          	beqz	s5,358 <gettoken+0x4a>
    *q = s;
     354:	009ab023          	sd	s1,0(s5)
  ret = *s;
     358:	0004c783          	lbu	a5,0(s1)
     35c:	00078a9b          	sext.w	s5,a5
  switch(*s){
     360:	03c00713          	li	a4,60
     364:	06f76663          	bltu	a4,a5,3d0 <gettoken+0xc2>
     368:	03a00713          	li	a4,58
     36c:	00f76e63          	bltu	a4,a5,388 <gettoken+0x7a>
     370:	cf89                	beqz	a5,38a <gettoken+0x7c>
     372:	02600713          	li	a4,38
     376:	00e78963          	beq	a5,a4,388 <gettoken+0x7a>
     37a:	fd87879b          	addiw	a5,a5,-40
     37e:	0ff7f793          	zext.b	a5,a5
     382:	4705                	li	a4,1
     384:	06f76d63          	bltu	a4,a5,3fe <gettoken+0xf0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     388:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     38a:	000b0463          	beqz	s6,392 <gettoken+0x84>
    *eq = s;
     38e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     392:	00002997          	auipc	s3,0x2
     396:	c7698993          	addi	s3,s3,-906 # 2008 <whitespace>
     39a:	0124fe63          	bgeu	s1,s2,3b6 <gettoken+0xa8>
     39e:	0004c583          	lbu	a1,0(s1)
     3a2:	854e                	mv	a0,s3
     3a4:	00000097          	auipc	ra,0x0
     3a8:	7a8080e7          	jalr	1960(ra) # b4c <strchr>
     3ac:	c509                	beqz	a0,3b6 <gettoken+0xa8>
    s++;
     3ae:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3b0:	fe9917e3          	bne	s2,s1,39e <gettoken+0x90>
     3b4:	84ca                	mv	s1,s2
  *ps = s;
     3b6:	009a3023          	sd	s1,0(s4)
  return ret;
}
     3ba:	8556                	mv	a0,s5
     3bc:	70e2                	ld	ra,56(sp)
     3be:	7442                	ld	s0,48(sp)
     3c0:	74a2                	ld	s1,40(sp)
     3c2:	7902                	ld	s2,32(sp)
     3c4:	69e2                	ld	s3,24(sp)
     3c6:	6a42                	ld	s4,16(sp)
     3c8:	6aa2                	ld	s5,8(sp)
     3ca:	6b02                	ld	s6,0(sp)
     3cc:	6121                	addi	sp,sp,64
     3ce:	8082                	ret
  switch(*s){
     3d0:	03e00713          	li	a4,62
     3d4:	02e79163          	bne	a5,a4,3f6 <gettoken+0xe8>
    s++;
     3d8:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     3dc:	0014c703          	lbu	a4,1(s1)
     3e0:	03e00793          	li	a5,62
      s++;
     3e4:	0489                	addi	s1,s1,2
      ret = '+';
     3e6:	02b00a93          	li	s5,43
    if(*s == '>'){
     3ea:	faf700e3          	beq	a4,a5,38a <gettoken+0x7c>
    s++;
     3ee:	84b6                	mv	s1,a3
  ret = *s;
     3f0:	03e00a93          	li	s5,62
     3f4:	bf59                	j	38a <gettoken+0x7c>
  switch(*s){
     3f6:	07c00713          	li	a4,124
     3fa:	f8e787e3          	beq	a5,a4,388 <gettoken+0x7a>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3fe:	00002997          	auipc	s3,0x2
     402:	c0a98993          	addi	s3,s3,-1014 # 2008 <whitespace>
     406:	00002a97          	auipc	s5,0x2
     40a:	bfaa8a93          	addi	s5,s5,-1030 # 2000 <symbols>
     40e:	0524f163          	bgeu	s1,s2,450 <gettoken+0x142>
     412:	0004c583          	lbu	a1,0(s1)
     416:	854e                	mv	a0,s3
     418:	00000097          	auipc	ra,0x0
     41c:	734080e7          	jalr	1844(ra) # b4c <strchr>
     420:	e50d                	bnez	a0,44a <gettoken+0x13c>
     422:	0004c583          	lbu	a1,0(s1)
     426:	8556                	mv	a0,s5
     428:	00000097          	auipc	ra,0x0
     42c:	724080e7          	jalr	1828(ra) # b4c <strchr>
     430:	e911                	bnez	a0,444 <gettoken+0x136>
      s++;
     432:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     434:	fc991fe3          	bne	s2,s1,412 <gettoken+0x104>
  if(eq)
     438:	84ca                	mv	s1,s2
    ret = 'a';
     43a:	06100a93          	li	s5,97
  if(eq)
     43e:	f40b18e3          	bnez	s6,38e <gettoken+0x80>
     442:	bf95                	j	3b6 <gettoken+0xa8>
    ret = 'a';
     444:	06100a93          	li	s5,97
     448:	b789                	j	38a <gettoken+0x7c>
     44a:	06100a93          	li	s5,97
     44e:	bf35                	j	38a <gettoken+0x7c>
     450:	06100a93          	li	s5,97
  if(eq)
     454:	f20b1de3          	bnez	s6,38e <gettoken+0x80>
     458:	bfb9                	j	3b6 <gettoken+0xa8>

000000000000045a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     45a:	7139                	addi	sp,sp,-64
     45c:	fc06                	sd	ra,56(sp)
     45e:	f822                	sd	s0,48(sp)
     460:	f426                	sd	s1,40(sp)
     462:	f04a                	sd	s2,32(sp)
     464:	ec4e                	sd	s3,24(sp)
     466:	e852                	sd	s4,16(sp)
     468:	e456                	sd	s5,8(sp)
     46a:	0080                	addi	s0,sp,64
     46c:	8a2a                	mv	s4,a0
     46e:	892e                	mv	s2,a1
     470:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     472:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     474:	00002997          	auipc	s3,0x2
     478:	b9498993          	addi	s3,s3,-1132 # 2008 <whitespace>
     47c:	00b4fe63          	bgeu	s1,a1,498 <peek+0x3e>
     480:	0004c583          	lbu	a1,0(s1)
     484:	854e                	mv	a0,s3
     486:	00000097          	auipc	ra,0x0
     48a:	6c6080e7          	jalr	1734(ra) # b4c <strchr>
     48e:	c509                	beqz	a0,498 <peek+0x3e>
    s++;
     490:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     492:	fe9917e3          	bne	s2,s1,480 <peek+0x26>
     496:	84ca                	mv	s1,s2
  *ps = s;
     498:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     49c:	0004c583          	lbu	a1,0(s1)
     4a0:	4501                	li	a0,0
     4a2:	e991                	bnez	a1,4b6 <peek+0x5c>
}
     4a4:	70e2                	ld	ra,56(sp)
     4a6:	7442                	ld	s0,48(sp)
     4a8:	74a2                	ld	s1,40(sp)
     4aa:	7902                	ld	s2,32(sp)
     4ac:	69e2                	ld	s3,24(sp)
     4ae:	6a42                	ld	s4,16(sp)
     4b0:	6aa2                	ld	s5,8(sp)
     4b2:	6121                	addi	sp,sp,64
     4b4:	8082                	ret
  return *s && strchr(toks, *s);
     4b6:	8556                	mv	a0,s5
     4b8:	00000097          	auipc	ra,0x0
     4bc:	694080e7          	jalr	1684(ra) # b4c <strchr>
     4c0:	00a03533          	snez	a0,a0
     4c4:	b7c5                	j	4a4 <peek+0x4a>

00000000000004c6 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4c6:	711d                	addi	sp,sp,-96
     4c8:	ec86                	sd	ra,88(sp)
     4ca:	e8a2                	sd	s0,80(sp)
     4cc:	e4a6                	sd	s1,72(sp)
     4ce:	e0ca                	sd	s2,64(sp)
     4d0:	fc4e                	sd	s3,56(sp)
     4d2:	f852                	sd	s4,48(sp)
     4d4:	f456                	sd	s5,40(sp)
     4d6:	f05a                	sd	s6,32(sp)
     4d8:	ec5e                	sd	s7,24(sp)
     4da:	1080                	addi	s0,sp,96
     4dc:	8a2a                	mv	s4,a0
     4de:	89ae                	mv	s3,a1
     4e0:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     4e2:	00001a97          	auipc	s5,0x1
     4e6:	e76a8a93          	addi	s5,s5,-394 # 1358 <malloc+0x16c>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4ea:	06100b13          	li	s6,97
      panic("missing file for redirection");
    switch(tok){
     4ee:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     4f2:	a02d                	j	51c <parseredirs+0x56>
      panic("missing file for redirection");
     4f4:	00001517          	auipc	a0,0x1
     4f8:	e4450513          	addi	a0,a0,-444 # 1338 <malloc+0x14c>
     4fc:	00000097          	auipc	ra,0x0
     500:	b5a080e7          	jalr	-1190(ra) # 56 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     504:	4701                	li	a4,0
     506:	4681                	li	a3,0
     508:	fa043603          	ld	a2,-96(s0)
     50c:	fa843583          	ld	a1,-88(s0)
     510:	8552                	mv	a0,s4
     512:	00000097          	auipc	ra,0x0
     516:	ccc080e7          	jalr	-820(ra) # 1de <redircmd>
     51a:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     51c:	8656                	mv	a2,s5
     51e:	85ca                	mv	a1,s2
     520:	854e                	mv	a0,s3
     522:	00000097          	auipc	ra,0x0
     526:	f38080e7          	jalr	-200(ra) # 45a <peek>
     52a:	cd25                	beqz	a0,5a2 <parseredirs+0xdc>
    tok = gettoken(ps, es, 0, 0);
     52c:	4681                	li	a3,0
     52e:	4601                	li	a2,0
     530:	85ca                	mv	a1,s2
     532:	854e                	mv	a0,s3
     534:	00000097          	auipc	ra,0x0
     538:	dda080e7          	jalr	-550(ra) # 30e <gettoken>
     53c:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     53e:	fa040693          	addi	a3,s0,-96
     542:	fa840613          	addi	a2,s0,-88
     546:	85ca                	mv	a1,s2
     548:	854e                	mv	a0,s3
     54a:	00000097          	auipc	ra,0x0
     54e:	dc4080e7          	jalr	-572(ra) # 30e <gettoken>
     552:	fb6511e3          	bne	a0,s6,4f4 <parseredirs+0x2e>
    switch(tok){
     556:	fb7487e3          	beq	s1,s7,504 <parseredirs+0x3e>
     55a:	03e00793          	li	a5,62
     55e:	02f48463          	beq	s1,a5,586 <parseredirs+0xc0>
     562:	02b00793          	li	a5,43
     566:	faf49be3          	bne	s1,a5,51c <parseredirs+0x56>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     56a:	4705                	li	a4,1
     56c:	20100693          	li	a3,513
     570:	fa043603          	ld	a2,-96(s0)
     574:	fa843583          	ld	a1,-88(s0)
     578:	8552                	mv	a0,s4
     57a:	00000097          	auipc	ra,0x0
     57e:	c64080e7          	jalr	-924(ra) # 1de <redircmd>
     582:	8a2a                	mv	s4,a0
      break;
     584:	bf61                	j	51c <parseredirs+0x56>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     586:	4705                	li	a4,1
     588:	60100693          	li	a3,1537
     58c:	fa043603          	ld	a2,-96(s0)
     590:	fa843583          	ld	a1,-88(s0)
     594:	8552                	mv	a0,s4
     596:	00000097          	auipc	ra,0x0
     59a:	c48080e7          	jalr	-952(ra) # 1de <redircmd>
     59e:	8a2a                	mv	s4,a0
      break;
     5a0:	bfb5                	j	51c <parseredirs+0x56>
    }
  }
  return cmd;
}
     5a2:	8552                	mv	a0,s4
     5a4:	60e6                	ld	ra,88(sp)
     5a6:	6446                	ld	s0,80(sp)
     5a8:	64a6                	ld	s1,72(sp)
     5aa:	6906                	ld	s2,64(sp)
     5ac:	79e2                	ld	s3,56(sp)
     5ae:	7a42                	ld	s4,48(sp)
     5b0:	7aa2                	ld	s5,40(sp)
     5b2:	7b02                	ld	s6,32(sp)
     5b4:	6be2                	ld	s7,24(sp)
     5b6:	6125                	addi	sp,sp,96
     5b8:	8082                	ret

00000000000005ba <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     5ba:	7159                	addi	sp,sp,-112
     5bc:	f486                	sd	ra,104(sp)
     5be:	f0a2                	sd	s0,96(sp)
     5c0:	eca6                	sd	s1,88(sp)
     5c2:	e0d2                	sd	s4,64(sp)
     5c4:	fc56                	sd	s5,56(sp)
     5c6:	1880                	addi	s0,sp,112
     5c8:	8a2a                	mv	s4,a0
     5ca:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     5cc:	00001617          	auipc	a2,0x1
     5d0:	d9460613          	addi	a2,a2,-620 # 1360 <malloc+0x174>
     5d4:	00000097          	auipc	ra,0x0
     5d8:	e86080e7          	jalr	-378(ra) # 45a <peek>
     5dc:	ed15                	bnez	a0,618 <parseexec+0x5e>
     5de:	e8ca                	sd	s2,80(sp)
     5e0:	e4ce                	sd	s3,72(sp)
     5e2:	f85a                	sd	s6,48(sp)
     5e4:	f45e                	sd	s7,40(sp)
     5e6:	f062                	sd	s8,32(sp)
     5e8:	ec66                	sd	s9,24(sp)
     5ea:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     5ec:	00000097          	auipc	ra,0x0
     5f0:	bbc080e7          	jalr	-1092(ra) # 1a8 <execcmd>
     5f4:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     5f6:	8656                	mv	a2,s5
     5f8:	85d2                	mv	a1,s4
     5fa:	00000097          	auipc	ra,0x0
     5fe:	ecc080e7          	jalr	-308(ra) # 4c6 <parseredirs>
     602:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     604:	008c0913          	addi	s2,s8,8
     608:	00001b17          	auipc	s6,0x1
     60c:	d78b0b13          	addi	s6,s6,-648 # 1380 <malloc+0x194>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     610:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     614:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     616:	a081                	j	656 <parseexec+0x9c>
    return parseblock(ps, es);
     618:	85d6                	mv	a1,s5
     61a:	8552                	mv	a0,s4
     61c:	00000097          	auipc	ra,0x0
     620:	1bc080e7          	jalr	444(ra) # 7d8 <parseblock>
     624:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     626:	8526                	mv	a0,s1
     628:	70a6                	ld	ra,104(sp)
     62a:	7406                	ld	s0,96(sp)
     62c:	64e6                	ld	s1,88(sp)
     62e:	6a06                	ld	s4,64(sp)
     630:	7ae2                	ld	s5,56(sp)
     632:	6165                	addi	sp,sp,112
     634:	8082                	ret
      panic("syntax");
     636:	00001517          	auipc	a0,0x1
     63a:	d3250513          	addi	a0,a0,-718 # 1368 <malloc+0x17c>
     63e:	00000097          	auipc	ra,0x0
     642:	a18080e7          	jalr	-1512(ra) # 56 <panic>
    ret = parseredirs(ret, ps, es);
     646:	8656                	mv	a2,s5
     648:	85d2                	mv	a1,s4
     64a:	8526                	mv	a0,s1
     64c:	00000097          	auipc	ra,0x0
     650:	e7a080e7          	jalr	-390(ra) # 4c6 <parseredirs>
     654:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     656:	865a                	mv	a2,s6
     658:	85d6                	mv	a1,s5
     65a:	8552                	mv	a0,s4
     65c:	00000097          	auipc	ra,0x0
     660:	dfe080e7          	jalr	-514(ra) # 45a <peek>
     664:	e131                	bnez	a0,6a8 <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     666:	f9040693          	addi	a3,s0,-112
     66a:	f9840613          	addi	a2,s0,-104
     66e:	85d6                	mv	a1,s5
     670:	8552                	mv	a0,s4
     672:	00000097          	auipc	ra,0x0
     676:	c9c080e7          	jalr	-868(ra) # 30e <gettoken>
     67a:	c51d                	beqz	a0,6a8 <parseexec+0xee>
    if(tok != 'a')
     67c:	fb951de3          	bne	a0,s9,636 <parseexec+0x7c>
    cmd->argv[argc] = q;
     680:	f9843783          	ld	a5,-104(s0)
     684:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     688:	f9043783          	ld	a5,-112(s0)
     68c:	04f93823          	sd	a5,80(s2)
    argc++;
     690:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     692:	0921                	addi	s2,s2,8
     694:	fb7999e3          	bne	s3,s7,646 <parseexec+0x8c>
      panic("too many args");
     698:	00001517          	auipc	a0,0x1
     69c:	cd850513          	addi	a0,a0,-808 # 1370 <malloc+0x184>
     6a0:	00000097          	auipc	ra,0x0
     6a4:	9b6080e7          	jalr	-1610(ra) # 56 <panic>
  cmd->argv[argc] = 0;
     6a8:	098e                	slli	s3,s3,0x3
     6aa:	9c4e                	add	s8,s8,s3
     6ac:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     6b0:	040c3c23          	sd	zero,88(s8)
     6b4:	6946                	ld	s2,80(sp)
     6b6:	69a6                	ld	s3,72(sp)
     6b8:	7b42                	ld	s6,48(sp)
     6ba:	7ba2                	ld	s7,40(sp)
     6bc:	7c02                	ld	s8,32(sp)
     6be:	6ce2                	ld	s9,24(sp)
  return ret;
     6c0:	b79d                	j	626 <parseexec+0x6c>

00000000000006c2 <parsepipe>:
{
     6c2:	7179                	addi	sp,sp,-48
     6c4:	f406                	sd	ra,40(sp)
     6c6:	f022                	sd	s0,32(sp)
     6c8:	ec26                	sd	s1,24(sp)
     6ca:	e84a                	sd	s2,16(sp)
     6cc:	e44e                	sd	s3,8(sp)
     6ce:	1800                	addi	s0,sp,48
     6d0:	892a                	mv	s2,a0
     6d2:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     6d4:	00000097          	auipc	ra,0x0
     6d8:	ee6080e7          	jalr	-282(ra) # 5ba <parseexec>
     6dc:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     6de:	00001617          	auipc	a2,0x1
     6e2:	caa60613          	addi	a2,a2,-854 # 1388 <malloc+0x19c>
     6e6:	85ce                	mv	a1,s3
     6e8:	854a                	mv	a0,s2
     6ea:	00000097          	auipc	ra,0x0
     6ee:	d70080e7          	jalr	-656(ra) # 45a <peek>
     6f2:	e909                	bnez	a0,704 <parsepipe+0x42>
}
     6f4:	8526                	mv	a0,s1
     6f6:	70a2                	ld	ra,40(sp)
     6f8:	7402                	ld	s0,32(sp)
     6fa:	64e2                	ld	s1,24(sp)
     6fc:	6942                	ld	s2,16(sp)
     6fe:	69a2                	ld	s3,8(sp)
     700:	6145                	addi	sp,sp,48
     702:	8082                	ret
    gettoken(ps, es, 0, 0);
     704:	4681                	li	a3,0
     706:	4601                	li	a2,0
     708:	85ce                	mv	a1,s3
     70a:	854a                	mv	a0,s2
     70c:	00000097          	auipc	ra,0x0
     710:	c02080e7          	jalr	-1022(ra) # 30e <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     714:	85ce                	mv	a1,s3
     716:	854a                	mv	a0,s2
     718:	00000097          	auipc	ra,0x0
     71c:	faa080e7          	jalr	-86(ra) # 6c2 <parsepipe>
     720:	85aa                	mv	a1,a0
     722:	8526                	mv	a0,s1
     724:	00000097          	auipc	ra,0x0
     728:	b22080e7          	jalr	-1246(ra) # 246 <pipecmd>
     72c:	84aa                	mv	s1,a0
  return cmd;
     72e:	b7d9                	j	6f4 <parsepipe+0x32>

0000000000000730 <parseline>:
{
     730:	7179                	addi	sp,sp,-48
     732:	f406                	sd	ra,40(sp)
     734:	f022                	sd	s0,32(sp)
     736:	ec26                	sd	s1,24(sp)
     738:	e84a                	sd	s2,16(sp)
     73a:	e44e                	sd	s3,8(sp)
     73c:	e052                	sd	s4,0(sp)
     73e:	1800                	addi	s0,sp,48
     740:	892a                	mv	s2,a0
     742:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     744:	00000097          	auipc	ra,0x0
     748:	f7e080e7          	jalr	-130(ra) # 6c2 <parsepipe>
     74c:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     74e:	00001a17          	auipc	s4,0x1
     752:	c42a0a13          	addi	s4,s4,-958 # 1390 <malloc+0x1a4>
     756:	a839                	j	774 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     758:	4681                	li	a3,0
     75a:	4601                	li	a2,0
     75c:	85ce                	mv	a1,s3
     75e:	854a                	mv	a0,s2
     760:	00000097          	auipc	ra,0x0
     764:	bae080e7          	jalr	-1106(ra) # 30e <gettoken>
    cmd = backcmd(cmd);
     768:	8526                	mv	a0,s1
     76a:	00000097          	auipc	ra,0x0
     76e:	b68080e7          	jalr	-1176(ra) # 2d2 <backcmd>
     772:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     774:	8652                	mv	a2,s4
     776:	85ce                	mv	a1,s3
     778:	854a                	mv	a0,s2
     77a:	00000097          	auipc	ra,0x0
     77e:	ce0080e7          	jalr	-800(ra) # 45a <peek>
     782:	f979                	bnez	a0,758 <parseline+0x28>
  if(peek(ps, es, ";")){
     784:	00001617          	auipc	a2,0x1
     788:	c1460613          	addi	a2,a2,-1004 # 1398 <malloc+0x1ac>
     78c:	85ce                	mv	a1,s3
     78e:	854a                	mv	a0,s2
     790:	00000097          	auipc	ra,0x0
     794:	cca080e7          	jalr	-822(ra) # 45a <peek>
     798:	e911                	bnez	a0,7ac <parseline+0x7c>
}
     79a:	8526                	mv	a0,s1
     79c:	70a2                	ld	ra,40(sp)
     79e:	7402                	ld	s0,32(sp)
     7a0:	64e2                	ld	s1,24(sp)
     7a2:	6942                	ld	s2,16(sp)
     7a4:	69a2                	ld	s3,8(sp)
     7a6:	6a02                	ld	s4,0(sp)
     7a8:	6145                	addi	sp,sp,48
     7aa:	8082                	ret
    gettoken(ps, es, 0, 0);
     7ac:	4681                	li	a3,0
     7ae:	4601                	li	a2,0
     7b0:	85ce                	mv	a1,s3
     7b2:	854a                	mv	a0,s2
     7b4:	00000097          	auipc	ra,0x0
     7b8:	b5a080e7          	jalr	-1190(ra) # 30e <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     7bc:	85ce                	mv	a1,s3
     7be:	854a                	mv	a0,s2
     7c0:	00000097          	auipc	ra,0x0
     7c4:	f70080e7          	jalr	-144(ra) # 730 <parseline>
     7c8:	85aa                	mv	a1,a0
     7ca:	8526                	mv	a0,s1
     7cc:	00000097          	auipc	ra,0x0
     7d0:	ac0080e7          	jalr	-1344(ra) # 28c <listcmd>
     7d4:	84aa                	mv	s1,a0
  return cmd;
     7d6:	b7d1                	j	79a <parseline+0x6a>

00000000000007d8 <parseblock>:
{
     7d8:	7179                	addi	sp,sp,-48
     7da:	f406                	sd	ra,40(sp)
     7dc:	f022                	sd	s0,32(sp)
     7de:	ec26                	sd	s1,24(sp)
     7e0:	e84a                	sd	s2,16(sp)
     7e2:	e44e                	sd	s3,8(sp)
     7e4:	1800                	addi	s0,sp,48
     7e6:	84aa                	mv	s1,a0
     7e8:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     7ea:	00001617          	auipc	a2,0x1
     7ee:	b7660613          	addi	a2,a2,-1162 # 1360 <malloc+0x174>
     7f2:	00000097          	auipc	ra,0x0
     7f6:	c68080e7          	jalr	-920(ra) # 45a <peek>
     7fa:	c12d                	beqz	a0,85c <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     7fc:	4681                	li	a3,0
     7fe:	4601                	li	a2,0
     800:	85ca                	mv	a1,s2
     802:	8526                	mv	a0,s1
     804:	00000097          	auipc	ra,0x0
     808:	b0a080e7          	jalr	-1270(ra) # 30e <gettoken>
  cmd = parseline(ps, es);
     80c:	85ca                	mv	a1,s2
     80e:	8526                	mv	a0,s1
     810:	00000097          	auipc	ra,0x0
     814:	f20080e7          	jalr	-224(ra) # 730 <parseline>
     818:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     81a:	00001617          	auipc	a2,0x1
     81e:	b9660613          	addi	a2,a2,-1130 # 13b0 <malloc+0x1c4>
     822:	85ca                	mv	a1,s2
     824:	8526                	mv	a0,s1
     826:	00000097          	auipc	ra,0x0
     82a:	c34080e7          	jalr	-972(ra) # 45a <peek>
     82e:	cd1d                	beqz	a0,86c <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     830:	4681                	li	a3,0
     832:	4601                	li	a2,0
     834:	85ca                	mv	a1,s2
     836:	8526                	mv	a0,s1
     838:	00000097          	auipc	ra,0x0
     83c:	ad6080e7          	jalr	-1322(ra) # 30e <gettoken>
  cmd = parseredirs(cmd, ps, es);
     840:	864a                	mv	a2,s2
     842:	85a6                	mv	a1,s1
     844:	854e                	mv	a0,s3
     846:	00000097          	auipc	ra,0x0
     84a:	c80080e7          	jalr	-896(ra) # 4c6 <parseredirs>
}
     84e:	70a2                	ld	ra,40(sp)
     850:	7402                	ld	s0,32(sp)
     852:	64e2                	ld	s1,24(sp)
     854:	6942                	ld	s2,16(sp)
     856:	69a2                	ld	s3,8(sp)
     858:	6145                	addi	sp,sp,48
     85a:	8082                	ret
    panic("parseblock");
     85c:	00001517          	auipc	a0,0x1
     860:	b4450513          	addi	a0,a0,-1212 # 13a0 <malloc+0x1b4>
     864:	fffff097          	auipc	ra,0xfffff
     868:	7f2080e7          	jalr	2034(ra) # 56 <panic>
    panic("syntax - missing )");
     86c:	00001517          	auipc	a0,0x1
     870:	b4c50513          	addi	a0,a0,-1204 # 13b8 <malloc+0x1cc>
     874:	fffff097          	auipc	ra,0xfffff
     878:	7e2080e7          	jalr	2018(ra) # 56 <panic>

000000000000087c <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     87c:	1101                	addi	sp,sp,-32
     87e:	ec06                	sd	ra,24(sp)
     880:	e822                	sd	s0,16(sp)
     882:	e426                	sd	s1,8(sp)
     884:	1000                	addi	s0,sp,32
     886:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     888:	c521                	beqz	a0,8d0 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     88a:	4118                	lw	a4,0(a0)
     88c:	4795                	li	a5,5
     88e:	04e7e163          	bltu	a5,a4,8d0 <nulterminate+0x54>
     892:	00056783          	lwu	a5,0(a0)
     896:	078a                	slli	a5,a5,0x2
     898:	00001717          	auipc	a4,0x1
     89c:	b6870713          	addi	a4,a4,-1176 # 1400 <malloc+0x214>
     8a0:	97ba                	add	a5,a5,a4
     8a2:	439c                	lw	a5,0(a5)
     8a4:	97ba                	add	a5,a5,a4
     8a6:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     8a8:	651c                	ld	a5,8(a0)
     8aa:	c39d                	beqz	a5,8d0 <nulterminate+0x54>
     8ac:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     8b0:	67b8                	ld	a4,72(a5)
     8b2:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     8b6:	07a1                	addi	a5,a5,8
     8b8:	ff87b703          	ld	a4,-8(a5)
     8bc:	fb75                	bnez	a4,8b0 <nulterminate+0x34>
     8be:	a809                	j	8d0 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     8c0:	6508                	ld	a0,8(a0)
     8c2:	00000097          	auipc	ra,0x0
     8c6:	fba080e7          	jalr	-70(ra) # 87c <nulterminate>
    *rcmd->efile = 0;
     8ca:	6c9c                	ld	a5,24(s1)
     8cc:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     8d0:	8526                	mv	a0,s1
     8d2:	60e2                	ld	ra,24(sp)
     8d4:	6442                	ld	s0,16(sp)
     8d6:	64a2                	ld	s1,8(sp)
     8d8:	6105                	addi	sp,sp,32
     8da:	8082                	ret
    nulterminate(pcmd->left);
     8dc:	6508                	ld	a0,8(a0)
     8de:	00000097          	auipc	ra,0x0
     8e2:	f9e080e7          	jalr	-98(ra) # 87c <nulterminate>
    nulterminate(pcmd->right);
     8e6:	6888                	ld	a0,16(s1)
     8e8:	00000097          	auipc	ra,0x0
     8ec:	f94080e7          	jalr	-108(ra) # 87c <nulterminate>
    break;
     8f0:	b7c5                	j	8d0 <nulterminate+0x54>
    nulterminate(lcmd->left);
     8f2:	6508                	ld	a0,8(a0)
     8f4:	00000097          	auipc	ra,0x0
     8f8:	f88080e7          	jalr	-120(ra) # 87c <nulterminate>
    nulterminate(lcmd->right);
     8fc:	6888                	ld	a0,16(s1)
     8fe:	00000097          	auipc	ra,0x0
     902:	f7e080e7          	jalr	-130(ra) # 87c <nulterminate>
    break;
     906:	b7e9                	j	8d0 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     908:	6508                	ld	a0,8(a0)
     90a:	00000097          	auipc	ra,0x0
     90e:	f72080e7          	jalr	-142(ra) # 87c <nulterminate>
    break;
     912:	bf7d                	j	8d0 <nulterminate+0x54>

0000000000000914 <parsecmd>:
{
     914:	7179                	addi	sp,sp,-48
     916:	f406                	sd	ra,40(sp)
     918:	f022                	sd	s0,32(sp)
     91a:	ec26                	sd	s1,24(sp)
     91c:	e84a                	sd	s2,16(sp)
     91e:	1800                	addi	s0,sp,48
     920:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     924:	84aa                	mv	s1,a0
     926:	00000097          	auipc	ra,0x0
     92a:	1da080e7          	jalr	474(ra) # b00 <strlen>
     92e:	1502                	slli	a0,a0,0x20
     930:	9101                	srli	a0,a0,0x20
     932:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     934:	85a6                	mv	a1,s1
     936:	fd840513          	addi	a0,s0,-40
     93a:	00000097          	auipc	ra,0x0
     93e:	df6080e7          	jalr	-522(ra) # 730 <parseline>
     942:	892a                	mv	s2,a0
  peek(&s, es, "");
     944:	00001617          	auipc	a2,0x1
     948:	9b460613          	addi	a2,a2,-1612 # 12f8 <malloc+0x10c>
     94c:	85a6                	mv	a1,s1
     94e:	fd840513          	addi	a0,s0,-40
     952:	00000097          	auipc	ra,0x0
     956:	b08080e7          	jalr	-1272(ra) # 45a <peek>
  if(s != es){
     95a:	fd843603          	ld	a2,-40(s0)
     95e:	00961e63          	bne	a2,s1,97a <parsecmd+0x66>
  nulterminate(cmd);
     962:	854a                	mv	a0,s2
     964:	00000097          	auipc	ra,0x0
     968:	f18080e7          	jalr	-232(ra) # 87c <nulterminate>
}
     96c:	854a                	mv	a0,s2
     96e:	70a2                	ld	ra,40(sp)
     970:	7402                	ld	s0,32(sp)
     972:	64e2                	ld	s1,24(sp)
     974:	6942                	ld	s2,16(sp)
     976:	6145                	addi	sp,sp,48
     978:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     97a:	00001597          	auipc	a1,0x1
     97e:	a5658593          	addi	a1,a1,-1450 # 13d0 <malloc+0x1e4>
     982:	4509                	li	a0,2
     984:	00000097          	auipc	ra,0x0
     988:	782080e7          	jalr	1922(ra) # 1106 <fprintf>
    panic("syntax");
     98c:	00001517          	auipc	a0,0x1
     990:	9dc50513          	addi	a0,a0,-1572 # 1368 <malloc+0x17c>
     994:	fffff097          	auipc	ra,0xfffff
     998:	6c2080e7          	jalr	1730(ra) # 56 <panic>

000000000000099c <main>:
{
     99c:	7139                	addi	sp,sp,-64
     99e:	fc06                	sd	ra,56(sp)
     9a0:	f822                	sd	s0,48(sp)
     9a2:	f426                	sd	s1,40(sp)
     9a4:	f04a                	sd	s2,32(sp)
     9a6:	ec4e                	sd	s3,24(sp)
     9a8:	e852                	sd	s4,16(sp)
     9aa:	e456                	sd	s5,8(sp)
     9ac:	e05a                	sd	s6,0(sp)
     9ae:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     9b0:	00001497          	auipc	s1,0x1
     9b4:	a3048493          	addi	s1,s1,-1488 # 13e0 <malloc+0x1f4>
     9b8:	4589                	li	a1,2
     9ba:	8526                	mv	a0,s1
     9bc:	00000097          	auipc	ra,0x0
     9c0:	35c080e7          	jalr	860(ra) # d18 <open>
     9c4:	00054963          	bltz	a0,9d6 <main+0x3a>
    if(fd >= 3){
     9c8:	4789                	li	a5,2
     9ca:	fea7d7e3          	bge	a5,a0,9b8 <main+0x1c>
      close(fd);
     9ce:	00000097          	auipc	ra,0x0
     9d2:	342080e7          	jalr	834(ra) # d10 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     9d6:	00001a17          	auipc	s4,0x1
     9da:	64aa0a13          	addi	s4,s4,1610 # 2020 <buf.0>
    while (*cmd == ' ' || *cmd == '\t')
     9de:	02000913          	li	s2,32
     9e2:	49a5                	li	s3,9
    if (*cmd == '\n') // is a blank command
     9e4:	4aa9                	li	s5,10
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     9e6:	06300b13          	li	s6,99
     9ea:	a825                	j	a22 <main+0x86>
      cmd++;
     9ec:	0485                	addi	s1,s1,1
    while (*cmd == ' ' || *cmd == '\t')
     9ee:	0004c783          	lbu	a5,0(s1)
     9f2:	ff278de3          	beq	a5,s2,9ec <main+0x50>
     9f6:	ff378be3          	beq	a5,s3,9ec <main+0x50>
    if (*cmd == '\n') // is a blank command
     9fa:	03578463          	beq	a5,s5,a22 <main+0x86>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     9fe:	01679863          	bne	a5,s6,a0e <main+0x72>
     a02:	0014c703          	lbu	a4,1(s1)
     a06:	06400793          	li	a5,100
     a0a:	02f70a63          	beq	a4,a5,a3e <main+0xa2>
      if(fork1() == 0)
     a0e:	fffff097          	auipc	ra,0xfffff
     a12:	66e080e7          	jalr	1646(ra) # 7c <fork1>
     a16:	c53d                	beqz	a0,a84 <main+0xe8>
      wait(0);
     a18:	4501                	li	a0,0
     a1a:	00000097          	auipc	ra,0x0
     a1e:	2e6080e7          	jalr	742(ra) # d00 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     a22:	06400593          	li	a1,100
     a26:	8552                	mv	a0,s4
     a28:	fffff097          	auipc	ra,0xfffff
     a2c:	5d8080e7          	jalr	1496(ra) # 0 <getcmd>
     a30:	06054363          	bltz	a0,a96 <main+0xfa>
    char *cmd = buf;
     a34:	00001497          	auipc	s1,0x1
     a38:	5ec48493          	addi	s1,s1,1516 # 2020 <buf.0>
     a3c:	bf4d                	j	9ee <main+0x52>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     a3e:	0024c783          	lbu	a5,2(s1)
     a42:	fd2796e3          	bne	a5,s2,a0e <main+0x72>
      cmd[strlen(cmd)-1] = 0;  // chop \n
     a46:	8526                	mv	a0,s1
     a48:	00000097          	auipc	ra,0x0
     a4c:	0b8080e7          	jalr	184(ra) # b00 <strlen>
     a50:	fff5079b          	addiw	a5,a0,-1
     a54:	1782                	slli	a5,a5,0x20
     a56:	9381                	srli	a5,a5,0x20
     a58:	97a6                	add	a5,a5,s1
     a5a:	00078023          	sb	zero,0(a5)
      if(chdir(cmd+3) < 0)
     a5e:	048d                	addi	s1,s1,3
     a60:	8526                	mv	a0,s1
     a62:	00000097          	auipc	ra,0x0
     a66:	2d6080e7          	jalr	726(ra) # d38 <chdir>
     a6a:	fa055ce3          	bgez	a0,a22 <main+0x86>
        fprintf(2, "cannot cd %s\n", cmd+3);
     a6e:	8626                	mv	a2,s1
     a70:	00001597          	auipc	a1,0x1
     a74:	97858593          	addi	a1,a1,-1672 # 13e8 <malloc+0x1fc>
     a78:	4509                	li	a0,2
     a7a:	00000097          	auipc	ra,0x0
     a7e:	68c080e7          	jalr	1676(ra) # 1106 <fprintf>
     a82:	b745                	j	a22 <main+0x86>
        runcmd(parsecmd(cmd));
     a84:	8526                	mv	a0,s1
     a86:	00000097          	auipc	ra,0x0
     a8a:	e8e080e7          	jalr	-370(ra) # 914 <parsecmd>
     a8e:	fffff097          	auipc	ra,0xfffff
     a92:	61c080e7          	jalr	1564(ra) # aa <runcmd>
  exit(0);
     a96:	4501                	li	a0,0
     a98:	00000097          	auipc	ra,0x0
     a9c:	260080e7          	jalr	608(ra) # cf8 <exit>

0000000000000aa0 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     aa0:	1141                	addi	sp,sp,-16
     aa2:	e406                	sd	ra,8(sp)
     aa4:	e022                	sd	s0,0(sp)
     aa6:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
     aa8:	00000097          	auipc	ra,0x0
     aac:	ef4080e7          	jalr	-268(ra) # 99c <main>
  exit(r);
     ab0:	00000097          	auipc	ra,0x0
     ab4:	248080e7          	jalr	584(ra) # cf8 <exit>

0000000000000ab8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     ab8:	1141                	addi	sp,sp,-16
     aba:	e422                	sd	s0,8(sp)
     abc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     abe:	87aa                	mv	a5,a0
     ac0:	0585                	addi	a1,a1,1
     ac2:	0785                	addi	a5,a5,1
     ac4:	fff5c703          	lbu	a4,-1(a1)
     ac8:	fee78fa3          	sb	a4,-1(a5)
     acc:	fb75                	bnez	a4,ac0 <strcpy+0x8>
    ;
  return os;
}
     ace:	6422                	ld	s0,8(sp)
     ad0:	0141                	addi	sp,sp,16
     ad2:	8082                	ret

0000000000000ad4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ad4:	1141                	addi	sp,sp,-16
     ad6:	e422                	sd	s0,8(sp)
     ad8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     ada:	00054783          	lbu	a5,0(a0)
     ade:	cb91                	beqz	a5,af2 <strcmp+0x1e>
     ae0:	0005c703          	lbu	a4,0(a1)
     ae4:	00f71763          	bne	a4,a5,af2 <strcmp+0x1e>
    p++, q++;
     ae8:	0505                	addi	a0,a0,1
     aea:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     aec:	00054783          	lbu	a5,0(a0)
     af0:	fbe5                	bnez	a5,ae0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     af2:	0005c503          	lbu	a0,0(a1)
}
     af6:	40a7853b          	subw	a0,a5,a0
     afa:	6422                	ld	s0,8(sp)
     afc:	0141                	addi	sp,sp,16
     afe:	8082                	ret

0000000000000b00 <strlen>:

uint
strlen(const char *s)
{
     b00:	1141                	addi	sp,sp,-16
     b02:	e422                	sd	s0,8(sp)
     b04:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     b06:	00054783          	lbu	a5,0(a0)
     b0a:	cf91                	beqz	a5,b26 <strlen+0x26>
     b0c:	0505                	addi	a0,a0,1
     b0e:	87aa                	mv	a5,a0
     b10:	86be                	mv	a3,a5
     b12:	0785                	addi	a5,a5,1
     b14:	fff7c703          	lbu	a4,-1(a5)
     b18:	ff65                	bnez	a4,b10 <strlen+0x10>
     b1a:	40a6853b          	subw	a0,a3,a0
     b1e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     b20:	6422                	ld	s0,8(sp)
     b22:	0141                	addi	sp,sp,16
     b24:	8082                	ret
  for(n = 0; s[n]; n++)
     b26:	4501                	li	a0,0
     b28:	bfe5                	j	b20 <strlen+0x20>

0000000000000b2a <memset>:

void*
memset(void *dst, int c, uint n)
{
     b2a:	1141                	addi	sp,sp,-16
     b2c:	e422                	sd	s0,8(sp)
     b2e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     b30:	ca19                	beqz	a2,b46 <memset+0x1c>
     b32:	87aa                	mv	a5,a0
     b34:	1602                	slli	a2,a2,0x20
     b36:	9201                	srli	a2,a2,0x20
     b38:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     b3c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     b40:	0785                	addi	a5,a5,1
     b42:	fee79de3          	bne	a5,a4,b3c <memset+0x12>
  }
  return dst;
}
     b46:	6422                	ld	s0,8(sp)
     b48:	0141                	addi	sp,sp,16
     b4a:	8082                	ret

0000000000000b4c <strchr>:

char*
strchr(const char *s, char c)
{
     b4c:	1141                	addi	sp,sp,-16
     b4e:	e422                	sd	s0,8(sp)
     b50:	0800                	addi	s0,sp,16
  for(; *s; s++)
     b52:	00054783          	lbu	a5,0(a0)
     b56:	cb99                	beqz	a5,b6c <strchr+0x20>
    if(*s == c)
     b58:	00f58763          	beq	a1,a5,b66 <strchr+0x1a>
  for(; *s; s++)
     b5c:	0505                	addi	a0,a0,1
     b5e:	00054783          	lbu	a5,0(a0)
     b62:	fbfd                	bnez	a5,b58 <strchr+0xc>
      return (char*)s;
  return 0;
     b64:	4501                	li	a0,0
}
     b66:	6422                	ld	s0,8(sp)
     b68:	0141                	addi	sp,sp,16
     b6a:	8082                	ret
  return 0;
     b6c:	4501                	li	a0,0
     b6e:	bfe5                	j	b66 <strchr+0x1a>

0000000000000b70 <gets>:

char*
gets(char *buf, int max)
{
     b70:	711d                	addi	sp,sp,-96
     b72:	ec86                	sd	ra,88(sp)
     b74:	e8a2                	sd	s0,80(sp)
     b76:	e4a6                	sd	s1,72(sp)
     b78:	e0ca                	sd	s2,64(sp)
     b7a:	fc4e                	sd	s3,56(sp)
     b7c:	f852                	sd	s4,48(sp)
     b7e:	f456                	sd	s5,40(sp)
     b80:	f05a                	sd	s6,32(sp)
     b82:	ec5e                	sd	s7,24(sp)
     b84:	1080                	addi	s0,sp,96
     b86:	8baa                	mv	s7,a0
     b88:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b8a:	892a                	mv	s2,a0
     b8c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     b8e:	4aa9                	li	s5,10
     b90:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     b92:	89a6                	mv	s3,s1
     b94:	2485                	addiw	s1,s1,1
     b96:	0344d863          	bge	s1,s4,bc6 <gets+0x56>
    cc = read(0, &c, 1);
     b9a:	4605                	li	a2,1
     b9c:	faf40593          	addi	a1,s0,-81
     ba0:	4501                	li	a0,0
     ba2:	00000097          	auipc	ra,0x0
     ba6:	186080e7          	jalr	390(ra) # d28 <read>
    if(cc < 1)
     baa:	00a05e63          	blez	a0,bc6 <gets+0x56>
    buf[i++] = c;
     bae:	faf44783          	lbu	a5,-81(s0)
     bb2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     bb6:	01578763          	beq	a5,s5,bc4 <gets+0x54>
     bba:	0905                	addi	s2,s2,1
     bbc:	fd679be3          	bne	a5,s6,b92 <gets+0x22>
    buf[i++] = c;
     bc0:	89a6                	mv	s3,s1
     bc2:	a011                	j	bc6 <gets+0x56>
     bc4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     bc6:	99de                	add	s3,s3,s7
     bc8:	00098023          	sb	zero,0(s3)
  return buf;
}
     bcc:	855e                	mv	a0,s7
     bce:	60e6                	ld	ra,88(sp)
     bd0:	6446                	ld	s0,80(sp)
     bd2:	64a6                	ld	s1,72(sp)
     bd4:	6906                	ld	s2,64(sp)
     bd6:	79e2                	ld	s3,56(sp)
     bd8:	7a42                	ld	s4,48(sp)
     bda:	7aa2                	ld	s5,40(sp)
     bdc:	7b02                	ld	s6,32(sp)
     bde:	6be2                	ld	s7,24(sp)
     be0:	6125                	addi	sp,sp,96
     be2:	8082                	ret

0000000000000be4 <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
     be4:	1141                	addi	sp,sp,-16
     be6:	e422                	sd	s0,8(sp)
     be8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     bea:	00054683          	lbu	a3,0(a0)
     bee:	fd06879b          	addiw	a5,a3,-48
     bf2:	0ff7f793          	zext.b	a5,a5
     bf6:	4625                	li	a2,9
     bf8:	02f66863          	bltu	a2,a5,c28 <atoi+0x44>
     bfc:	872a                	mv	a4,a0
  n = 0;
     bfe:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     c00:	0705                	addi	a4,a4,1
     c02:	0025179b          	slliw	a5,a0,0x2
     c06:	9fa9                	addw	a5,a5,a0
     c08:	0017979b          	slliw	a5,a5,0x1
     c0c:	9fb5                	addw	a5,a5,a3
     c0e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     c12:	00074683          	lbu	a3,0(a4)
     c16:	fd06879b          	addiw	a5,a3,-48
     c1a:	0ff7f793          	zext.b	a5,a5
     c1e:	fef671e3          	bgeu	a2,a5,c00 <atoi+0x1c>
  return n;
}
     c22:	6422                	ld	s0,8(sp)
     c24:	0141                	addi	sp,sp,16
     c26:	8082                	ret
  n = 0;
     c28:	4501                	li	a0,0
     c2a:	bfe5                	j	c22 <atoi+0x3e>

0000000000000c2c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c2c:	1141                	addi	sp,sp,-16
     c2e:	e422                	sd	s0,8(sp)
     c30:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     c32:	02b57463          	bgeu	a0,a1,c5a <memmove+0x2e>
    while(n-- > 0)
     c36:	00c05f63          	blez	a2,c54 <memmove+0x28>
     c3a:	1602                	slli	a2,a2,0x20
     c3c:	9201                	srli	a2,a2,0x20
     c3e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     c42:	872a                	mv	a4,a0
      *dst++ = *src++;
     c44:	0585                	addi	a1,a1,1
     c46:	0705                	addi	a4,a4,1
     c48:	fff5c683          	lbu	a3,-1(a1)
     c4c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     c50:	fef71ae3          	bne	a4,a5,c44 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     c54:	6422                	ld	s0,8(sp)
     c56:	0141                	addi	sp,sp,16
     c58:	8082                	ret
    dst += n;
     c5a:	00c50733          	add	a4,a0,a2
    src += n;
     c5e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     c60:	fec05ae3          	blez	a2,c54 <memmove+0x28>
     c64:	fff6079b          	addiw	a5,a2,-1
     c68:	1782                	slli	a5,a5,0x20
     c6a:	9381                	srli	a5,a5,0x20
     c6c:	fff7c793          	not	a5,a5
     c70:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     c72:	15fd                	addi	a1,a1,-1
     c74:	177d                	addi	a4,a4,-1
     c76:	0005c683          	lbu	a3,0(a1)
     c7a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     c7e:	fee79ae3          	bne	a5,a4,c72 <memmove+0x46>
     c82:	bfc9                	j	c54 <memmove+0x28>

0000000000000c84 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     c84:	1141                	addi	sp,sp,-16
     c86:	e422                	sd	s0,8(sp)
     c88:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     c8a:	ca05                	beqz	a2,cba <memcmp+0x36>
     c8c:	fff6069b          	addiw	a3,a2,-1
     c90:	1682                	slli	a3,a3,0x20
     c92:	9281                	srli	a3,a3,0x20
     c94:	0685                	addi	a3,a3,1
     c96:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     c98:	00054783          	lbu	a5,0(a0)
     c9c:	0005c703          	lbu	a4,0(a1)
     ca0:	00e79863          	bne	a5,a4,cb0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     ca4:	0505                	addi	a0,a0,1
    p2++;
     ca6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     ca8:	fed518e3          	bne	a0,a3,c98 <memcmp+0x14>
  }
  return 0;
     cac:	4501                	li	a0,0
     cae:	a019                	j	cb4 <memcmp+0x30>
      return *p1 - *p2;
     cb0:	40e7853b          	subw	a0,a5,a4
}
     cb4:	6422                	ld	s0,8(sp)
     cb6:	0141                	addi	sp,sp,16
     cb8:	8082                	ret
  return 0;
     cba:	4501                	li	a0,0
     cbc:	bfe5                	j	cb4 <memcmp+0x30>

0000000000000cbe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     cbe:	1141                	addi	sp,sp,-16
     cc0:	e406                	sd	ra,8(sp)
     cc2:	e022                	sd	s0,0(sp)
     cc4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     cc6:	00000097          	auipc	ra,0x0
     cca:	f66080e7          	jalr	-154(ra) # c2c <memmove>
}
     cce:	60a2                	ld	ra,8(sp)
     cd0:	6402                	ld	s0,0(sp)
     cd2:	0141                	addi	sp,sp,16
     cd4:	8082                	ret

0000000000000cd6 <sbrk>:

char *
sbrk(int n) {
     cd6:	1141                	addi	sp,sp,-16
     cd8:	e406                	sd	ra,8(sp)
     cda:	e022                	sd	s0,0(sp)
     cdc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     cde:	4585                	li	a1,1
     ce0:	00000097          	auipc	ra,0x0
     ce4:	070080e7          	jalr	112(ra) # d50 <sys_sbrk>
}
     ce8:	60a2                	ld	ra,8(sp)
     cea:	6402                	ld	s0,0(sp)
     cec:	0141                	addi	sp,sp,16
     cee:	8082                	ret

0000000000000cf0 <fork>:
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     cf0:	4885                	li	a7,1
 ecall
     cf2:	00000073          	ecall
 ret
     cf6:	8082                	ret

0000000000000cf8 <exit>:
.global exit
exit:
 li a7, SYS_exit
     cf8:	4889                	li	a7,2
 ecall
     cfa:	00000073          	ecall
 ret
     cfe:	8082                	ret

0000000000000d00 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d00:	488d                	li	a7,3
 ecall
     d02:	00000073          	ecall
 ret
     d06:	8082                	ret

0000000000000d08 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d08:	4891                	li	a7,4
 ecall
     d0a:	00000073          	ecall
 ret
     d0e:	8082                	ret

0000000000000d10 <close>:
.global close
close:
 li a7, SYS_close
     d10:	4899                	li	a7,6
 ecall
     d12:	00000073          	ecall
 ret
     d16:	8082                	ret

0000000000000d18 <open>:
.global open
open:
 li a7, SYS_open
     d18:	489d                	li	a7,7
 ecall
     d1a:	00000073          	ecall
 ret
     d1e:	8082                	ret

0000000000000d20 <exec>:
.global exec
exec:
 li a7, SYS_exec
     d20:	4895                	li	a7,5
 ecall
     d22:	00000073          	ecall
 ret
     d26:	8082                	ret

0000000000000d28 <read>:
.global read
read:
 li a7, SYS_read
     d28:	48a1                	li	a7,8
 ecall
     d2a:	00000073          	ecall
 ret
     d2e:	8082                	ret

0000000000000d30 <write>:
.global write
write:
 li a7, SYS_write
     d30:	48a5                	li	a7,9
 ecall
     d32:	00000073          	ecall
 ret
     d36:	8082                	ret

0000000000000d38 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d38:	48a9                	li	a7,10
 ecall
     d3a:	00000073          	ecall
 ret
     d3e:	8082                	ret

0000000000000d40 <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
     d40:	48ad                	li	a7,11
 ecall
     d42:	00000073          	ecall
 ret
     d46:	8082                	ret

0000000000000d48 <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
     d48:	48b1                	li	a7,12
 ecall
     d4a:	00000073          	ecall
 ret
     d4e:	8082                	ret

0000000000000d50 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     d50:	48b5                	li	a7,13
 ecall
     d52:	00000073          	ecall
 ret
     d56:	8082                	ret

0000000000000d58 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     d58:	1101                	addi	sp,sp,-32
     d5a:	ec06                	sd	ra,24(sp)
     d5c:	e822                	sd	s0,16(sp)
     d5e:	1000                	addi	s0,sp,32
     d60:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     d64:	4605                	li	a2,1
     d66:	fef40593          	addi	a1,s0,-17
     d6a:	00000097          	auipc	ra,0x0
     d6e:	fc6080e7          	jalr	-58(ra) # d30 <write>
}
     d72:	60e2                	ld	ra,24(sp)
     d74:	6442                	ld	s0,16(sp)
     d76:	6105                	addi	sp,sp,32
     d78:	8082                	ret

0000000000000d7a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     d7a:	715d                	addi	sp,sp,-80
     d7c:	e486                	sd	ra,72(sp)
     d7e:	e0a2                	sd	s0,64(sp)
     d80:	f84a                	sd	s2,48(sp)
     d82:	0880                	addi	s0,sp,80
     d84:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     d86:	c299                	beqz	a3,d8c <printint+0x12>
     d88:	0805c563          	bltz	a1,e12 <printint+0x98>
  neg = 0;
     d8c:	4881                	li	a7,0
     d8e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     d92:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     d94:	00000517          	auipc	a0,0x0
     d98:	68450513          	addi	a0,a0,1668 # 1418 <digits>
     d9c:	883e                	mv	a6,a5
     d9e:	2785                	addiw	a5,a5,1
     da0:	02c5f733          	remu	a4,a1,a2
     da4:	972a                	add	a4,a4,a0
     da6:	00074703          	lbu	a4,0(a4)
     daa:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     dae:	872e                	mv	a4,a1
     db0:	02c5d5b3          	divu	a1,a1,a2
     db4:	0685                	addi	a3,a3,1
     db6:	fec773e3          	bgeu	a4,a2,d9c <printint+0x22>
  if(neg)
     dba:	00088b63          	beqz	a7,dd0 <printint+0x56>
    buf[i++] = '-';
     dbe:	fd078793          	addi	a5,a5,-48
     dc2:	97a2                	add	a5,a5,s0
     dc4:	02d00713          	li	a4,45
     dc8:	fee78423          	sb	a4,-24(a5)
     dcc:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
     dd0:	02f05c63          	blez	a5,e08 <printint+0x8e>
     dd4:	fc26                	sd	s1,56(sp)
     dd6:	f44e                	sd	s3,40(sp)
     dd8:	fb840713          	addi	a4,s0,-72
     ddc:	00f704b3          	add	s1,a4,a5
     de0:	fff70993          	addi	s3,a4,-1
     de4:	99be                	add	s3,s3,a5
     de6:	37fd                	addiw	a5,a5,-1
     de8:	1782                	slli	a5,a5,0x20
     dea:	9381                	srli	a5,a5,0x20
     dec:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     df0:	fff4c583          	lbu	a1,-1(s1)
     df4:	854a                	mv	a0,s2
     df6:	00000097          	auipc	ra,0x0
     dfa:	f62080e7          	jalr	-158(ra) # d58 <putc>
  while(--i >= 0)
     dfe:	14fd                	addi	s1,s1,-1
     e00:	ff3498e3          	bne	s1,s3,df0 <printint+0x76>
     e04:	74e2                	ld	s1,56(sp)
     e06:	79a2                	ld	s3,40(sp)
}
     e08:	60a6                	ld	ra,72(sp)
     e0a:	6406                	ld	s0,64(sp)
     e0c:	7942                	ld	s2,48(sp)
     e0e:	6161                	addi	sp,sp,80
     e10:	8082                	ret
    x = -xx;
     e12:	40b005b3          	neg	a1,a1
    neg = 1;
     e16:	4885                	li	a7,1
    x = -xx;
     e18:	bf9d                	j	d8e <printint+0x14>

0000000000000e1a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e1a:	711d                	addi	sp,sp,-96
     e1c:	ec86                	sd	ra,88(sp)
     e1e:	e8a2                	sd	s0,80(sp)
     e20:	e0ca                	sd	s2,64(sp)
     e22:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     e24:	0005c903          	lbu	s2,0(a1)
     e28:	2c090a63          	beqz	s2,10fc <vprintf+0x2e2>
     e2c:	e4a6                	sd	s1,72(sp)
     e2e:	fc4e                	sd	s3,56(sp)
     e30:	f852                	sd	s4,48(sp)
     e32:	f456                	sd	s5,40(sp)
     e34:	f05a                	sd	s6,32(sp)
     e36:	ec5e                	sd	s7,24(sp)
     e38:	e862                	sd	s8,16(sp)
     e3a:	e466                	sd	s9,8(sp)
     e3c:	8b2a                	mv	s6,a0
     e3e:	8a2e                	mv	s4,a1
     e40:	8bb2                	mv	s7,a2
  state = 0;
     e42:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     e44:	4481                	li	s1,0
     e46:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     e48:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     e4c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     e50:	06c00c93          	li	s9,108
     e54:	a015                	j	e78 <vprintf+0x5e>
        putc(fd, c0);
     e56:	85ca                	mv	a1,s2
     e58:	855a                	mv	a0,s6
     e5a:	00000097          	auipc	ra,0x0
     e5e:	efe080e7          	jalr	-258(ra) # d58 <putc>
     e62:	a019                	j	e68 <vprintf+0x4e>
    } else if(state == '%'){
     e64:	03598263          	beq	s3,s5,e88 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
     e68:	2485                	addiw	s1,s1,1
     e6a:	8726                	mv	a4,s1
     e6c:	009a07b3          	add	a5,s4,s1
     e70:	0007c903          	lbu	s2,0(a5)
     e74:	26090c63          	beqz	s2,10ec <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
     e78:	0009079b          	sext.w	a5,s2
    if(state == 0){
     e7c:	fe0994e3          	bnez	s3,e64 <vprintf+0x4a>
      if(c0 == '%'){
     e80:	fd579be3          	bne	a5,s5,e56 <vprintf+0x3c>
        state = '%';
     e84:	89be                	mv	s3,a5
     e86:	b7cd                	j	e68 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
     e88:	00ea06b3          	add	a3,s4,a4
     e8c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     e90:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     e92:	c681                	beqz	a3,e9a <vprintf+0x80>
     e94:	9752                	add	a4,a4,s4
     e96:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     e9a:	05878563          	beq	a5,s8,ee4 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
     e9e:	07978163          	beq	a5,s9,f00 <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     ea2:	07500713          	li	a4,117
     ea6:	10e78563          	beq	a5,a4,fb0 <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     eaa:	07800713          	li	a4,120
     eae:	14e78d63          	beq	a5,a4,1008 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     eb2:	07000713          	li	a4,112
     eb6:	18e78663          	beq	a5,a4,1042 <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     eba:	06300713          	li	a4,99
     ebe:	1ce78c63          	beq	a5,a4,1096 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     ec2:	07300713          	li	a4,115
     ec6:	1ee78463          	beq	a5,a4,10ae <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     eca:	02500713          	li	a4,37
     ece:	04e79963          	bne	a5,a4,f20 <vprintf+0x106>
        putc(fd, '%');
     ed2:	02500593          	li	a1,37
     ed6:	855a                	mv	a0,s6
     ed8:	00000097          	auipc	ra,0x0
     edc:	e80080e7          	jalr	-384(ra) # d58 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     ee0:	4981                	li	s3,0
     ee2:	b759                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
     ee4:	008b8913          	addi	s2,s7,8
     ee8:	4685                	li	a3,1
     eea:	4629                	li	a2,10
     eec:	000ba583          	lw	a1,0(s7)
     ef0:	855a                	mv	a0,s6
     ef2:	00000097          	auipc	ra,0x0
     ef6:	e88080e7          	jalr	-376(ra) # d7a <printint>
     efa:	8bca                	mv	s7,s2
      state = 0;
     efc:	4981                	li	s3,0
     efe:	b7ad                	j	e68 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
     f00:	06400793          	li	a5,100
     f04:	02f68d63          	beq	a3,a5,f3e <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f08:	06c00793          	li	a5,108
     f0c:	04f68863          	beq	a3,a5,f5c <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
     f10:	07500793          	li	a5,117
     f14:	0af68c63          	beq	a3,a5,fcc <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
     f18:	07800793          	li	a5,120
     f1c:	10f68463          	beq	a3,a5,1024 <vprintf+0x20a>
        putc(fd, '%');
     f20:	02500593          	li	a1,37
     f24:	855a                	mv	a0,s6
     f26:	00000097          	auipc	ra,0x0
     f2a:	e32080e7          	jalr	-462(ra) # d58 <putc>
        putc(fd, c0);
     f2e:	85ca                	mv	a1,s2
     f30:	855a                	mv	a0,s6
     f32:	00000097          	auipc	ra,0x0
     f36:	e26080e7          	jalr	-474(ra) # d58 <putc>
      state = 0;
     f3a:	4981                	li	s3,0
     f3c:	b735                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f3e:	008b8913          	addi	s2,s7,8
     f42:	4685                	li	a3,1
     f44:	4629                	li	a2,10
     f46:	000bb583          	ld	a1,0(s7)
     f4a:	855a                	mv	a0,s6
     f4c:	00000097          	auipc	ra,0x0
     f50:	e2e080e7          	jalr	-466(ra) # d7a <printint>
        i += 1;
     f54:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     f56:	8bca                	mv	s7,s2
      state = 0;
     f58:	4981                	li	s3,0
        i += 1;
     f5a:	b739                	j	e68 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f5c:	06400793          	li	a5,100
     f60:	02f60963          	beq	a2,a5,f92 <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     f64:	07500793          	li	a5,117
     f68:	08f60163          	beq	a2,a5,fea <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     f6c:	07800793          	li	a5,120
     f70:	faf618e3          	bne	a2,a5,f20 <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f74:	008b8913          	addi	s2,s7,8
     f78:	4681                	li	a3,0
     f7a:	4641                	li	a2,16
     f7c:	000bb583          	ld	a1,0(s7)
     f80:	855a                	mv	a0,s6
     f82:	00000097          	auipc	ra,0x0
     f86:	df8080e7          	jalr	-520(ra) # d7a <printint>
        i += 2;
     f8a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     f8c:	8bca                	mv	s7,s2
      state = 0;
     f8e:	4981                	li	s3,0
        i += 2;
     f90:	bde1                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f92:	008b8913          	addi	s2,s7,8
     f96:	4685                	li	a3,1
     f98:	4629                	li	a2,10
     f9a:	000bb583          	ld	a1,0(s7)
     f9e:	855a                	mv	a0,s6
     fa0:	00000097          	auipc	ra,0x0
     fa4:	dda080e7          	jalr	-550(ra) # d7a <printint>
        i += 2;
     fa8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     faa:	8bca                	mv	s7,s2
      state = 0;
     fac:	4981                	li	s3,0
        i += 2;
     fae:	bd6d                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
     fb0:	008b8913          	addi	s2,s7,8
     fb4:	4681                	li	a3,0
     fb6:	4629                	li	a2,10
     fb8:	000be583          	lwu	a1,0(s7)
     fbc:	855a                	mv	a0,s6
     fbe:	00000097          	auipc	ra,0x0
     fc2:	dbc080e7          	jalr	-580(ra) # d7a <printint>
     fc6:	8bca                	mv	s7,s2
      state = 0;
     fc8:	4981                	li	s3,0
     fca:	bd79                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fcc:	008b8913          	addi	s2,s7,8
     fd0:	4681                	li	a3,0
     fd2:	4629                	li	a2,10
     fd4:	000bb583          	ld	a1,0(s7)
     fd8:	855a                	mv	a0,s6
     fda:	00000097          	auipc	ra,0x0
     fde:	da0080e7          	jalr	-608(ra) # d7a <printint>
        i += 1;
     fe2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     fe4:	8bca                	mv	s7,s2
      state = 0;
     fe6:	4981                	li	s3,0
        i += 1;
     fe8:	b541                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fea:	008b8913          	addi	s2,s7,8
     fee:	4681                	li	a3,0
     ff0:	4629                	li	a2,10
     ff2:	000bb583          	ld	a1,0(s7)
     ff6:	855a                	mv	a0,s6
     ff8:	00000097          	auipc	ra,0x0
     ffc:	d82080e7          	jalr	-638(ra) # d7a <printint>
        i += 2;
    1000:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1002:	8bca                	mv	s7,s2
      state = 0;
    1004:	4981                	li	s3,0
        i += 2;
    1006:	b58d                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
    1008:	008b8913          	addi	s2,s7,8
    100c:	4681                	li	a3,0
    100e:	4641                	li	a2,16
    1010:	000be583          	lwu	a1,0(s7)
    1014:	855a                	mv	a0,s6
    1016:	00000097          	auipc	ra,0x0
    101a:	d64080e7          	jalr	-668(ra) # d7a <printint>
    101e:	8bca                	mv	s7,s2
      state = 0;
    1020:	4981                	li	s3,0
    1022:	b599                	j	e68 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1024:	008b8913          	addi	s2,s7,8
    1028:	4681                	li	a3,0
    102a:	4641                	li	a2,16
    102c:	000bb583          	ld	a1,0(s7)
    1030:	855a                	mv	a0,s6
    1032:	00000097          	auipc	ra,0x0
    1036:	d48080e7          	jalr	-696(ra) # d7a <printint>
        i += 1;
    103a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    103c:	8bca                	mv	s7,s2
      state = 0;
    103e:	4981                	li	s3,0
        i += 1;
    1040:	b525                	j	e68 <vprintf+0x4e>
    1042:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1044:	008b8d13          	addi	s10,s7,8
    1048:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    104c:	03000593          	li	a1,48
    1050:	855a                	mv	a0,s6
    1052:	00000097          	auipc	ra,0x0
    1056:	d06080e7          	jalr	-762(ra) # d58 <putc>
  putc(fd, 'x');
    105a:	07800593          	li	a1,120
    105e:	855a                	mv	a0,s6
    1060:	00000097          	auipc	ra,0x0
    1064:	cf8080e7          	jalr	-776(ra) # d58 <putc>
    1068:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    106a:	00000b97          	auipc	s7,0x0
    106e:	3aeb8b93          	addi	s7,s7,942 # 1418 <digits>
    1072:	03c9d793          	srli	a5,s3,0x3c
    1076:	97de                	add	a5,a5,s7
    1078:	0007c583          	lbu	a1,0(a5)
    107c:	855a                	mv	a0,s6
    107e:	00000097          	auipc	ra,0x0
    1082:	cda080e7          	jalr	-806(ra) # d58 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1086:	0992                	slli	s3,s3,0x4
    1088:	397d                	addiw	s2,s2,-1
    108a:	fe0914e3          	bnez	s2,1072 <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
    108e:	8bea                	mv	s7,s10
      state = 0;
    1090:	4981                	li	s3,0
    1092:	6d02                	ld	s10,0(sp)
    1094:	bbd1                	j	e68 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
    1096:	008b8913          	addi	s2,s7,8
    109a:	000bc583          	lbu	a1,0(s7)
    109e:	855a                	mv	a0,s6
    10a0:	00000097          	auipc	ra,0x0
    10a4:	cb8080e7          	jalr	-840(ra) # d58 <putc>
    10a8:	8bca                	mv	s7,s2
      state = 0;
    10aa:	4981                	li	s3,0
    10ac:	bb75                	j	e68 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
    10ae:	008b8993          	addi	s3,s7,8
    10b2:	000bb903          	ld	s2,0(s7)
    10b6:	02090163          	beqz	s2,10d8 <vprintf+0x2be>
        for(; *s; s++)
    10ba:	00094583          	lbu	a1,0(s2)
    10be:	c585                	beqz	a1,10e6 <vprintf+0x2cc>
          putc(fd, *s);
    10c0:	855a                	mv	a0,s6
    10c2:	00000097          	auipc	ra,0x0
    10c6:	c96080e7          	jalr	-874(ra) # d58 <putc>
        for(; *s; s++)
    10ca:	0905                	addi	s2,s2,1
    10cc:	00094583          	lbu	a1,0(s2)
    10d0:	f9e5                	bnez	a1,10c0 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
    10d2:	8bce                	mv	s7,s3
      state = 0;
    10d4:	4981                	li	s3,0
    10d6:	bb49                	j	e68 <vprintf+0x4e>
          s = "(null)";
    10d8:	00000917          	auipc	s2,0x0
    10dc:	32090913          	addi	s2,s2,800 # 13f8 <malloc+0x20c>
        for(; *s; s++)
    10e0:	02800593          	li	a1,40
    10e4:	bff1                	j	10c0 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
    10e6:	8bce                	mv	s7,s3
      state = 0;
    10e8:	4981                	li	s3,0
    10ea:	bbbd                	j	e68 <vprintf+0x4e>
    10ec:	64a6                	ld	s1,72(sp)
    10ee:	79e2                	ld	s3,56(sp)
    10f0:	7a42                	ld	s4,48(sp)
    10f2:	7aa2                	ld	s5,40(sp)
    10f4:	7b02                	ld	s6,32(sp)
    10f6:	6be2                	ld	s7,24(sp)
    10f8:	6c42                	ld	s8,16(sp)
    10fa:	6ca2                	ld	s9,8(sp)
    }
  }
}
    10fc:	60e6                	ld	ra,88(sp)
    10fe:	6446                	ld	s0,80(sp)
    1100:	6906                	ld	s2,64(sp)
    1102:	6125                	addi	sp,sp,96
    1104:	8082                	ret

0000000000001106 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1106:	715d                	addi	sp,sp,-80
    1108:	ec06                	sd	ra,24(sp)
    110a:	e822                	sd	s0,16(sp)
    110c:	1000                	addi	s0,sp,32
    110e:	e010                	sd	a2,0(s0)
    1110:	e414                	sd	a3,8(s0)
    1112:	e818                	sd	a4,16(s0)
    1114:	ec1c                	sd	a5,24(s0)
    1116:	03043023          	sd	a6,32(s0)
    111a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    111e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1122:	8622                	mv	a2,s0
    1124:	00000097          	auipc	ra,0x0
    1128:	cf6080e7          	jalr	-778(ra) # e1a <vprintf>
}
    112c:	60e2                	ld	ra,24(sp)
    112e:	6442                	ld	s0,16(sp)
    1130:	6161                	addi	sp,sp,80
    1132:	8082                	ret

0000000000001134 <printf>:

void
printf(const char *fmt, ...)
{
    1134:	711d                	addi	sp,sp,-96
    1136:	ec06                	sd	ra,24(sp)
    1138:	e822                	sd	s0,16(sp)
    113a:	1000                	addi	s0,sp,32
    113c:	e40c                	sd	a1,8(s0)
    113e:	e810                	sd	a2,16(s0)
    1140:	ec14                	sd	a3,24(s0)
    1142:	f018                	sd	a4,32(s0)
    1144:	f41c                	sd	a5,40(s0)
    1146:	03043823          	sd	a6,48(s0)
    114a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    114e:	00840613          	addi	a2,s0,8
    1152:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1156:	85aa                	mv	a1,a0
    1158:	4505                	li	a0,1
    115a:	00000097          	auipc	ra,0x0
    115e:	cc0080e7          	jalr	-832(ra) # e1a <vprintf>
}
    1162:	60e2                	ld	ra,24(sp)
    1164:	6442                	ld	s0,16(sp)
    1166:	6125                	addi	sp,sp,96
    1168:	8082                	ret

000000000000116a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    116a:	1141                	addi	sp,sp,-16
    116c:	e422                	sd	s0,8(sp)
    116e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1170:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1174:	00001797          	auipc	a5,0x1
    1178:	e9c7b783          	ld	a5,-356(a5) # 2010 <freep>
    117c:	a02d                	j	11a6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    117e:	4618                	lw	a4,8(a2)
    1180:	9f2d                	addw	a4,a4,a1
    1182:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1186:	6398                	ld	a4,0(a5)
    1188:	6310                	ld	a2,0(a4)
    118a:	a83d                	j	11c8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    118c:	ff852703          	lw	a4,-8(a0)
    1190:	9f31                	addw	a4,a4,a2
    1192:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1194:	ff053683          	ld	a3,-16(a0)
    1198:	a091                	j	11dc <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    119a:	6398                	ld	a4,0(a5)
    119c:	00e7e463          	bltu	a5,a4,11a4 <free+0x3a>
    11a0:	00e6ea63          	bltu	a3,a4,11b4 <free+0x4a>
{
    11a4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11a6:	fed7fae3          	bgeu	a5,a3,119a <free+0x30>
    11aa:	6398                	ld	a4,0(a5)
    11ac:	00e6e463          	bltu	a3,a4,11b4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11b0:	fee7eae3          	bltu	a5,a4,11a4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    11b4:	ff852583          	lw	a1,-8(a0)
    11b8:	6390                	ld	a2,0(a5)
    11ba:	02059813          	slli	a6,a1,0x20
    11be:	01c85713          	srli	a4,a6,0x1c
    11c2:	9736                	add	a4,a4,a3
    11c4:	fae60de3          	beq	a2,a4,117e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    11c8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    11cc:	4790                	lw	a2,8(a5)
    11ce:	02061593          	slli	a1,a2,0x20
    11d2:	01c5d713          	srli	a4,a1,0x1c
    11d6:	973e                	add	a4,a4,a5
    11d8:	fae68ae3          	beq	a3,a4,118c <free+0x22>
    p->s.ptr = bp->s.ptr;
    11dc:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    11de:	00001717          	auipc	a4,0x1
    11e2:	e2f73923          	sd	a5,-462(a4) # 2010 <freep>
}
    11e6:	6422                	ld	s0,8(sp)
    11e8:	0141                	addi	sp,sp,16
    11ea:	8082                	ret

00000000000011ec <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11ec:	7139                	addi	sp,sp,-64
    11ee:	fc06                	sd	ra,56(sp)
    11f0:	f822                	sd	s0,48(sp)
    11f2:	f426                	sd	s1,40(sp)
    11f4:	ec4e                	sd	s3,24(sp)
    11f6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11f8:	02051493          	slli	s1,a0,0x20
    11fc:	9081                	srli	s1,s1,0x20
    11fe:	04bd                	addi	s1,s1,15
    1200:	8091                	srli	s1,s1,0x4
    1202:	0014899b          	addiw	s3,s1,1
    1206:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1208:	00001517          	auipc	a0,0x1
    120c:	e0853503          	ld	a0,-504(a0) # 2010 <freep>
    1210:	c915                	beqz	a0,1244 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1212:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1214:	4798                	lw	a4,8(a5)
    1216:	08977e63          	bgeu	a4,s1,12b2 <malloc+0xc6>
    121a:	f04a                	sd	s2,32(sp)
    121c:	e852                	sd	s4,16(sp)
    121e:	e456                	sd	s5,8(sp)
    1220:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1222:	8a4e                	mv	s4,s3
    1224:	0009871b          	sext.w	a4,s3
    1228:	6685                	lui	a3,0x1
    122a:	00d77363          	bgeu	a4,a3,1230 <malloc+0x44>
    122e:	6a05                	lui	s4,0x1
    1230:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1234:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1238:	00001917          	auipc	s2,0x1
    123c:	dd890913          	addi	s2,s2,-552 # 2010 <freep>
  if(p == SBRK_ERROR)
    1240:	5afd                	li	s5,-1
    1242:	a091                	j	1286 <malloc+0x9a>
    1244:	f04a                	sd	s2,32(sp)
    1246:	e852                	sd	s4,16(sp)
    1248:	e456                	sd	s5,8(sp)
    124a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    124c:	00001797          	auipc	a5,0x1
    1250:	e3c78793          	addi	a5,a5,-452 # 2088 <base>
    1254:	00001717          	auipc	a4,0x1
    1258:	daf73e23          	sd	a5,-580(a4) # 2010 <freep>
    125c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    125e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1262:	b7c1                	j	1222 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1264:	6398                	ld	a4,0(a5)
    1266:	e118                	sd	a4,0(a0)
    1268:	a08d                	j	12ca <malloc+0xde>
  hp->s.size = nu;
    126a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    126e:	0541                	addi	a0,a0,16
    1270:	00000097          	auipc	ra,0x0
    1274:	efa080e7          	jalr	-262(ra) # 116a <free>
  return freep;
    1278:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    127c:	c13d                	beqz	a0,12e2 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    127e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1280:	4798                	lw	a4,8(a5)
    1282:	02977463          	bgeu	a4,s1,12aa <malloc+0xbe>
    if(p == freep)
    1286:	00093703          	ld	a4,0(s2)
    128a:	853e                	mv	a0,a5
    128c:	fef719e3          	bne	a4,a5,127e <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    1290:	8552                	mv	a0,s4
    1292:	00000097          	auipc	ra,0x0
    1296:	a44080e7          	jalr	-1468(ra) # cd6 <sbrk>
  if(p == SBRK_ERROR)
    129a:	fd5518e3          	bne	a0,s5,126a <malloc+0x7e>
        return 0;
    129e:	4501                	li	a0,0
    12a0:	7902                	ld	s2,32(sp)
    12a2:	6a42                	ld	s4,16(sp)
    12a4:	6aa2                	ld	s5,8(sp)
    12a6:	6b02                	ld	s6,0(sp)
    12a8:	a03d                	j	12d6 <malloc+0xea>
    12aa:	7902                	ld	s2,32(sp)
    12ac:	6a42                	ld	s4,16(sp)
    12ae:	6aa2                	ld	s5,8(sp)
    12b0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    12b2:	fae489e3          	beq	s1,a4,1264 <malloc+0x78>
        p->s.size -= nunits;
    12b6:	4137073b          	subw	a4,a4,s3
    12ba:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12bc:	02071693          	slli	a3,a4,0x20
    12c0:	01c6d713          	srli	a4,a3,0x1c
    12c4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12c6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12ca:	00001717          	auipc	a4,0x1
    12ce:	d4a73323          	sd	a0,-698(a4) # 2010 <freep>
      return (void*)(p + 1);
    12d2:	01078513          	addi	a0,a5,16
  }
}
    12d6:	70e2                	ld	ra,56(sp)
    12d8:	7442                	ld	s0,48(sp)
    12da:	74a2                	ld	s1,40(sp)
    12dc:	69e2                	ld	s3,24(sp)
    12de:	6121                	addi	sp,sp,64
    12e0:	8082                	ret
    12e2:	7902                	ld	s2,32(sp)
    12e4:	6a42                	ld	s4,16(sp)
    12e6:	6aa2                	ld	s5,8(sp)
    12e8:	6b02                	ld	s6,0(sp)
    12ea:	b7f5                	j	12d6 <malloc+0xea>
