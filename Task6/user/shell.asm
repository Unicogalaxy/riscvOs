
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
      16:	41e58593          	addi	a1,a1,1054 # 1430 <malloc+0x104>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	e3c080e7          	jalr	-452(ra) # e58 <write>
  memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	b6e080e7          	jalr	-1170(ra) # b98 <memset>
  gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	ba8080e7          	jalr	-1112(ra) # bde <gets>
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
      64:	3e058593          	addi	a1,a1,992 # 1440 <malloc+0x114>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	1dc080e7          	jalr	476(ra) # 1246 <fprintf>
  exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	dac080e7          	jalr	-596(ra) # e20 <exit>

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
      88:	d94080e7          	jalr	-620(ra) # e18 <fork>
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
      9e:	3ae50513          	addi	a0,a0,942 # 1448 <malloc+0x11c>
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
      d6:	d66080e7          	jalr	-666(ra) # e38 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      da:	508c                	lw	a1,32(s1)
      dc:	6888                	ld	a0,16(s1)
      de:	00001097          	auipc	ra,0x1
      e2:	d62080e7          	jalr	-670(ra) # e40 <open>
      e6:	06054e63          	bltz	a0,162 <runcmd+0xb8>
    runcmd(rcmd->cmd);
      ea:	6488                	ld	a0,8(s1)
      ec:	00000097          	auipc	ra,0x0
      f0:	fbe080e7          	jalr	-66(ra) # aa <runcmd>
      f4:	e426                	sd	s1,8(sp)
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00001097          	auipc	ra,0x1
      fc:	d28080e7          	jalr	-728(ra) # e20 <exit>
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
     11e:	33650513          	addi	a0,a0,822 # 1450 <malloc+0x124>
     122:	00000097          	auipc	ra,0x0
     126:	f34080e7          	jalr	-204(ra) # 56 <panic>
    if(ecmd->argv[0] == 0)
     12a:	6508                	ld	a0,8(a0)
     12c:	c515                	beqz	a0,158 <runcmd+0xae>
    exec(ecmd->argv[0], ecmd->argv);
     12e:	00848593          	addi	a1,s1,8
     132:	00001097          	auipc	ra,0x1
     136:	d16080e7          	jalr	-746(ra) # e48 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     13a:	6490                	ld	a2,8(s1)
     13c:	00001597          	auipc	a1,0x1
     140:	31c58593          	addi	a1,a1,796 # 1458 <malloc+0x12c>
     144:	4509                	li	a0,2
     146:	00001097          	auipc	ra,0x1
     14a:	100080e7          	jalr	256(ra) # 1246 <fprintf>
  exit(0);
     14e:	4501                	li	a0,0
     150:	00001097          	auipc	ra,0x1
     154:	cd0080e7          	jalr	-816(ra) # e20 <exit>
      exit(1);
     158:	4505                	li	a0,1
     15a:	00001097          	auipc	ra,0x1
     15e:	cc6080e7          	jalr	-826(ra) # e20 <exit>
      fprintf(2, "open %s failed\n", rcmd->file);
     162:	6890                	ld	a2,16(s1)
     164:	00001597          	auipc	a1,0x1
     168:	30458593          	addi	a1,a1,772 # 1468 <malloc+0x13c>
     16c:	4509                	li	a0,2
     16e:	00001097          	auipc	ra,0x1
     172:	0d8080e7          	jalr	216(ra) # 1246 <fprintf>
      exit(1);
     176:	4505                	li	a0,1
     178:	00001097          	auipc	ra,0x1
     17c:	ca8080e7          	jalr	-856(ra) # e20 <exit>
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
     19a:	c92080e7          	jalr	-878(ra) # e28 <wait>
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
     1ba:	176080e7          	jalr	374(ra) # 132c <malloc>
     1be:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1c0:	0a800613          	li	a2,168
     1c4:	4581                	li	a1,0
     1c6:	00001097          	auipc	ra,0x1
     1ca:	9d2080e7          	jalr	-1582(ra) # b98 <memset>
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
     204:	12c080e7          	jalr	300(ra) # 132c <malloc>
     208:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     20a:	02800613          	li	a2,40
     20e:	4581                	li	a1,0
     210:	00001097          	auipc	ra,0x1
     214:	988080e7          	jalr	-1656(ra) # b98 <memset>
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
     25e:	0d2080e7          	jalr	210(ra) # 132c <malloc>
     262:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     264:	4661                	li	a2,24
     266:	4581                	li	a1,0
     268:	00001097          	auipc	ra,0x1
     26c:	930080e7          	jalr	-1744(ra) # b98 <memset>
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
     2a4:	08c080e7          	jalr	140(ra) # 132c <malloc>
     2a8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2aa:	4661                	li	a2,24
     2ac:	4581                	li	a1,0
     2ae:	00001097          	auipc	ra,0x1
     2b2:	8ea080e7          	jalr	-1814(ra) # b98 <memset>
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
     2e6:	04a080e7          	jalr	74(ra) # 132c <malloc>
     2ea:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2ec:	4641                	li	a2,16
     2ee:	4581                	li	a1,0
     2f0:	00001097          	auipc	ra,0x1
     2f4:	8a8080e7          	jalr	-1880(ra) # b98 <memset>
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
     342:	87c080e7          	jalr	-1924(ra) # bba <strchr>
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
     3a4:	00001097          	auipc	ra,0x1
     3a8:	816080e7          	jalr	-2026(ra) # bba <strchr>
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
     41c:	7a2080e7          	jalr	1954(ra) # bba <strchr>
     420:	e50d                	bnez	a0,44a <gettoken+0x13c>
     422:	0004c583          	lbu	a1,0(s1)
     426:	8556                	mv	a0,s5
     428:	00000097          	auipc	ra,0x0
     42c:	792080e7          	jalr	1938(ra) # bba <strchr>
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
     48a:	734080e7          	jalr	1844(ra) # bba <strchr>
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
     4bc:	702080e7          	jalr	1794(ra) # bba <strchr>
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
     4e6:	fb6a8a93          	addi	s5,s5,-74 # 1498 <malloc+0x16c>
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
     4f8:	f8450513          	addi	a0,a0,-124 # 1478 <malloc+0x14c>
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
     5d0:	ed460613          	addi	a2,a2,-300 # 14a0 <malloc+0x174>
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
     60c:	eb8b0b13          	addi	s6,s6,-328 # 14c0 <malloc+0x194>
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
     63a:	e7250513          	addi	a0,a0,-398 # 14a8 <malloc+0x17c>
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
     69c:	e1850513          	addi	a0,a0,-488 # 14b0 <malloc+0x184>
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
     6e2:	dea60613          	addi	a2,a2,-534 # 14c8 <malloc+0x19c>
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
     752:	d82a0a13          	addi	s4,s4,-638 # 14d0 <malloc+0x1a4>
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
     788:	d5460613          	addi	a2,a2,-684 # 14d8 <malloc+0x1ac>
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
     7ee:	cb660613          	addi	a2,a2,-842 # 14a0 <malloc+0x174>
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
     81e:	cd660613          	addi	a2,a2,-810 # 14f0 <malloc+0x1c4>
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
     860:	c8450513          	addi	a0,a0,-892 # 14e0 <malloc+0x1b4>
     864:	fffff097          	auipc	ra,0xfffff
     868:	7f2080e7          	jalr	2034(ra) # 56 <panic>
    panic("syntax - missing )");
     86c:	00001517          	auipc	a0,0x1
     870:	c8c50513          	addi	a0,a0,-884 # 14f8 <malloc+0x1cc>
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
     89c:	cc070713          	addi	a4,a4,-832 # 1558 <malloc+0x22c>
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
     92a:	248080e7          	jalr	584(ra) # b6e <strlen>
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
     948:	af460613          	addi	a2,a2,-1292 # 1438 <malloc+0x10c>
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
     97e:	b9658593          	addi	a1,a1,-1130 # 1510 <malloc+0x1e4>
     982:	4509                	li	a0,2
     984:	00001097          	auipc	ra,0x1
     988:	8c2080e7          	jalr	-1854(ra) # 1246 <fprintf>
    panic("syntax");
     98c:	00001517          	auipc	a0,0x1
     990:	b1c50513          	addi	a0,a0,-1252 # 14a8 <malloc+0x17c>
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
     9b4:	b7048493          	addi	s1,s1,-1168 # 1520 <malloc+0x1f4>
     9b8:	4589                	li	a1,2
     9ba:	8526                	mv	a0,s1
     9bc:	00000097          	auipc	ra,0x0
     9c0:	484080e7          	jalr	1156(ra) # e40 <open>
     9c4:	00054963          	bltz	a0,9d6 <main+0x3a>
    if(fd >= 3){
     9c8:	4789                	li	a5,2
     9ca:	fea7d7e3          	bge	a5,a0,9b8 <main+0x1c>
      close(fd);
     9ce:	00000097          	auipc	ra,0x0
     9d2:	46a080e7          	jalr	1130(ra) # e38 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     9d6:	00001a97          	auipc	s5,0x1
     9da:	64aa8a93          	addi	s5,s5,1610 # 2020 <buf.0>
    while (*cmd == ' ' || *cmd == '\t')
     9de:	02000913          	li	s2,32
     9e2:	49a5                	li	s3,9
     9e4:	00800a37          	lui	s4,0x800
     9e8:	0a4d                	addi	s4,s4,19 # 800013 <base+0x7fdf8b>
     9ea:	0a26                	slli	s4,s4,0x9
    if(cmd[0] == 'c' && cmd[1] == 'd' && (cmd[2] == 0 || cmd[2] == ' ' || cmd[2] == '\t')){
     9ec:	06300b13          	li	s6,99
     9f0:	a8b5                	j	a6c <main+0xd0>
      cmd++;
     9f2:	0485                	addi	s1,s1,1
    while (*cmd == ' ' || *cmd == '\t')
     9f4:	0004c783          	lbu	a5,0(s1)
     9f8:	ff278de3          	beq	a5,s2,9f2 <main+0x56>
     9fc:	ff378be3          	beq	a5,s3,9f2 <main+0x56>
  int n = strlen(s);
     a00:	8526                	mv	a0,s1
     a02:	00000097          	auipc	ra,0x0
     a06:	16c080e7          	jalr	364(ra) # b6e <strlen>
     a0a:	0005079b          	sext.w	a5,a0
  while(n > 0 && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\n' || s[n-1] == '\r'))
     a0e:	02f05a63          	blez	a5,a42 <main+0xa6>
     a12:	fff78713          	addi	a4,a5,-1
     a16:	9726                	add	a4,a4,s1
     a18:	ffe48613          	addi	a2,s1,-2
     a1c:	963e                	add	a2,a2,a5
     a1e:	37fd                	addiw	a5,a5,-1
     a20:	1782                	slli	a5,a5,0x20
     a22:	9381                	srli	a5,a5,0x20
     a24:	8e1d                	sub	a2,a2,a5
     a26:	86ba                	mv	a3,a4
     a28:	00074783          	lbu	a5,0(a4)
     a2c:	00f96b63          	bltu	s2,a5,a42 <main+0xa6>
     a30:	00fa57b3          	srl	a5,s4,a5
     a34:	8b85                	andi	a5,a5,1
     a36:	c791                	beqz	a5,a42 <main+0xa6>
    s[--n] = 0;
     a38:	00068023          	sb	zero,0(a3)
  while(n > 0 && (s[n-1] == ' ' || s[n-1] == '\t' || s[n-1] == '\n' || s[n-1] == '\r'))
     a3c:	177d                	addi	a4,a4,-1
     a3e:	fec714e3          	bne	a4,a2,a26 <main+0x8a>
    if (*cmd == 0)
     a42:	0004c783          	lbu	a5,0(s1)
     a46:	c39d                	beqz	a5,a6c <main+0xd0>
    if(cmd[0] == 'c' && cmd[1] == 'd' && (cmd[2] == 0 || cmd[2] == ' ' || cmd[2] == '\t')){
     a48:	01679863          	bne	a5,s6,a58 <main+0xbc>
     a4c:	0014c703          	lbu	a4,1(s1)
     a50:	06400793          	li	a5,100
     a54:	02f70a63          	beq	a4,a5,a88 <main+0xec>
    if(fork1() == 0)
     a58:	fffff097          	auipc	ra,0xfffff
     a5c:	624080e7          	jalr	1572(ra) # 7c <fork1>
     a60:	c949                	beqz	a0,af2 <main+0x156>
    wait(0);
     a62:	4501                	li	a0,0
     a64:	00000097          	auipc	ra,0x0
     a68:	3c4080e7          	jalr	964(ra) # e28 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     a6c:	06400593          	li	a1,100
     a70:	8556                	mv	a0,s5
     a72:	fffff097          	auipc	ra,0xfffff
     a76:	58e080e7          	jalr	1422(ra) # 0 <getcmd>
     a7a:	08054563          	bltz	a0,b04 <main+0x168>
    char *cmd = buf;
     a7e:	00001497          	auipc	s1,0x1
     a82:	5a248493          	addi	s1,s1,1442 # 2020 <buf.0>
     a86:	b7bd                	j	9f4 <main+0x58>
    if(cmd[0] == 'c' && cmd[1] == 'd' && (cmd[2] == 0 || cmd[2] == ' ' || cmd[2] == '\t')){
     a88:	0024c703          	lbu	a4,2(s1)
     a8c:	fce966e3          	bltu	s2,a4,a58 <main+0xbc>
     a90:	4785                	li	a5,1
     a92:	1782                	slli	a5,a5,0x20
     a94:	20178793          	addi	a5,a5,513
     a98:	00e7d7b3          	srl	a5,a5,a4
     a9c:	8b85                	andi	a5,a5,1
     a9e:	dfcd                	beqz	a5,a58 <main+0xbc>
      char *path = cmd + 2;
     aa0:	0489                	addi	s1,s1,2
      while(*path == ' ' || *path == '\t')
     aa2:	02000713          	li	a4,32
     aa6:	46a5                	li	a3,9
     aa8:	a011                	j	aac <main+0x110>
        path++;
     aaa:	0485                	addi	s1,s1,1
      while(*path == ' ' || *path == '\t')
     aac:	0004c783          	lbu	a5,0(s1)
     ab0:	fee78de3          	beq	a5,a4,aaa <main+0x10e>
     ab4:	fed78be3          	beq	a5,a3,aaa <main+0x10e>
      if(*path == 0){
     ab8:	eb99                	bnez	a5,ace <main+0x132>
        fprintf(2, "Usage: cd directory\n");
     aba:	00001597          	auipc	a1,0x1
     abe:	a6e58593          	addi	a1,a1,-1426 # 1528 <malloc+0x1fc>
     ac2:	4509                	li	a0,2
     ac4:	00000097          	auipc	ra,0x0
     ac8:	782080e7          	jalr	1922(ra) # 1246 <fprintf>
     acc:	b745                	j	a6c <main+0xd0>
      } else if(chdir(path) < 0){
     ace:	8526                	mv	a0,s1
     ad0:	00000097          	auipc	ra,0x0
     ad4:	390080e7          	jalr	912(ra) # e60 <chdir>
     ad8:	f8055ae3          	bgez	a0,a6c <main+0xd0>
        fprintf(2, "cannot cd %s\n", path);
     adc:	8626                	mv	a2,s1
     ade:	00001597          	auipc	a1,0x1
     ae2:	a6258593          	addi	a1,a1,-1438 # 1540 <malloc+0x214>
     ae6:	4509                	li	a0,2
     ae8:	00000097          	auipc	ra,0x0
     aec:	75e080e7          	jalr	1886(ra) # 1246 <fprintf>
     af0:	bfb5                	j	a6c <main+0xd0>
      runcmd(parsecmd(cmd));
     af2:	8526                	mv	a0,s1
     af4:	00000097          	auipc	ra,0x0
     af8:	e20080e7          	jalr	-480(ra) # 914 <parsecmd>
     afc:	fffff097          	auipc	ra,0xfffff
     b00:	5ae080e7          	jalr	1454(ra) # aa <runcmd>
  exit(0);
     b04:	4501                	li	a0,0
     b06:	00000097          	auipc	ra,0x0
     b0a:	31a080e7          	jalr	794(ra) # e20 <exit>

0000000000000b0e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     b0e:	1141                	addi	sp,sp,-16
     b10:	e406                	sd	ra,8(sp)
     b12:	e022                	sd	s0,0(sp)
     b14:	0800                	addi	s0,sp,16
  int r;
  extern int main();
  r = main();
     b16:	00000097          	auipc	ra,0x0
     b1a:	e86080e7          	jalr	-378(ra) # 99c <main>
  exit(r);
     b1e:	00000097          	auipc	ra,0x0
     b22:	302080e7          	jalr	770(ra) # e20 <exit>

0000000000000b26 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     b26:	1141                	addi	sp,sp,-16
     b28:	e422                	sd	s0,8(sp)
     b2a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b2c:	87aa                	mv	a5,a0
     b2e:	0585                	addi	a1,a1,1
     b30:	0785                	addi	a5,a5,1
     b32:	fff5c703          	lbu	a4,-1(a1)
     b36:	fee78fa3          	sb	a4,-1(a5)
     b3a:	fb75                	bnez	a4,b2e <strcpy+0x8>
    ;
  return os;
}
     b3c:	6422                	ld	s0,8(sp)
     b3e:	0141                	addi	sp,sp,16
     b40:	8082                	ret

0000000000000b42 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b42:	1141                	addi	sp,sp,-16
     b44:	e422                	sd	s0,8(sp)
     b46:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     b48:	00054783          	lbu	a5,0(a0)
     b4c:	cb91                	beqz	a5,b60 <strcmp+0x1e>
     b4e:	0005c703          	lbu	a4,0(a1)
     b52:	00f71763          	bne	a4,a5,b60 <strcmp+0x1e>
    p++, q++;
     b56:	0505                	addi	a0,a0,1
     b58:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     b5a:	00054783          	lbu	a5,0(a0)
     b5e:	fbe5                	bnez	a5,b4e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     b60:	0005c503          	lbu	a0,0(a1)
}
     b64:	40a7853b          	subw	a0,a5,a0
     b68:	6422                	ld	s0,8(sp)
     b6a:	0141                	addi	sp,sp,16
     b6c:	8082                	ret

0000000000000b6e <strlen>:

uint
strlen(const char *s)
{
     b6e:	1141                	addi	sp,sp,-16
     b70:	e422                	sd	s0,8(sp)
     b72:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     b74:	00054783          	lbu	a5,0(a0)
     b78:	cf91                	beqz	a5,b94 <strlen+0x26>
     b7a:	0505                	addi	a0,a0,1
     b7c:	87aa                	mv	a5,a0
     b7e:	86be                	mv	a3,a5
     b80:	0785                	addi	a5,a5,1
     b82:	fff7c703          	lbu	a4,-1(a5)
     b86:	ff65                	bnez	a4,b7e <strlen+0x10>
     b88:	40a6853b          	subw	a0,a3,a0
     b8c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     b8e:	6422                	ld	s0,8(sp)
     b90:	0141                	addi	sp,sp,16
     b92:	8082                	ret
  for(n = 0; s[n]; n++)
     b94:	4501                	li	a0,0
     b96:	bfe5                	j	b8e <strlen+0x20>

0000000000000b98 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b98:	1141                	addi	sp,sp,-16
     b9a:	e422                	sd	s0,8(sp)
     b9c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     b9e:	ca19                	beqz	a2,bb4 <memset+0x1c>
     ba0:	87aa                	mv	a5,a0
     ba2:	1602                	slli	a2,a2,0x20
     ba4:	9201                	srli	a2,a2,0x20
     ba6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     baa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     bae:	0785                	addi	a5,a5,1
     bb0:	fee79de3          	bne	a5,a4,baa <memset+0x12>
  }
  return dst;
}
     bb4:	6422                	ld	s0,8(sp)
     bb6:	0141                	addi	sp,sp,16
     bb8:	8082                	ret

0000000000000bba <strchr>:

char*
strchr(const char *s, char c)
{
     bba:	1141                	addi	sp,sp,-16
     bbc:	e422                	sd	s0,8(sp)
     bbe:	0800                	addi	s0,sp,16
  for(; *s; s++)
     bc0:	00054783          	lbu	a5,0(a0)
     bc4:	cb99                	beqz	a5,bda <strchr+0x20>
    if(*s == c)
     bc6:	00f58763          	beq	a1,a5,bd4 <strchr+0x1a>
  for(; *s; s++)
     bca:	0505                	addi	a0,a0,1
     bcc:	00054783          	lbu	a5,0(a0)
     bd0:	fbfd                	bnez	a5,bc6 <strchr+0xc>
      return (char*)s;
  return 0;
     bd2:	4501                	li	a0,0
}
     bd4:	6422                	ld	s0,8(sp)
     bd6:	0141                	addi	sp,sp,16
     bd8:	8082                	ret
  return 0;
     bda:	4501                	li	a0,0
     bdc:	bfe5                	j	bd4 <strchr+0x1a>

0000000000000bde <gets>:

char*
gets(char *buf, int max)
{
     bde:	711d                	addi	sp,sp,-96
     be0:	ec86                	sd	ra,88(sp)
     be2:	e8a2                	sd	s0,80(sp)
     be4:	e4a6                	sd	s1,72(sp)
     be6:	e0ca                	sd	s2,64(sp)
     be8:	fc4e                	sd	s3,56(sp)
     bea:	f852                	sd	s4,48(sp)
     bec:	f456                	sd	s5,40(sp)
     bee:	f05a                	sd	s6,32(sp)
     bf0:	ec5e                	sd	s7,24(sp)
     bf2:	1080                	addi	s0,sp,96
     bf4:	8baa                	mv	s7,a0
     bf6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bf8:	892a                	mv	s2,a0
     bfa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     bfc:	4aa9                	li	s5,10
     bfe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c00:	89a6                	mv	s3,s1
     c02:	2485                	addiw	s1,s1,1
     c04:	0344d863          	bge	s1,s4,c34 <gets+0x56>
    cc = read(0, &c, 1);
     c08:	4605                	li	a2,1
     c0a:	faf40593          	addi	a1,s0,-81
     c0e:	4501                	li	a0,0
     c10:	00000097          	auipc	ra,0x0
     c14:	240080e7          	jalr	576(ra) # e50 <read>
    if(cc < 1)
     c18:	00a05e63          	blez	a0,c34 <gets+0x56>
    buf[i++] = c;
     c1c:	faf44783          	lbu	a5,-81(s0)
     c20:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c24:	01578763          	beq	a5,s5,c32 <gets+0x54>
     c28:	0905                	addi	s2,s2,1
     c2a:	fd679be3          	bne	a5,s6,c00 <gets+0x22>
    buf[i++] = c;
     c2e:	89a6                	mv	s3,s1
     c30:	a011                	j	c34 <gets+0x56>
     c32:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     c34:	99de                	add	s3,s3,s7
     c36:	00098023          	sb	zero,0(s3)
  return buf;
}
     c3a:	855e                	mv	a0,s7
     c3c:	60e6                	ld	ra,88(sp)
     c3e:	6446                	ld	s0,80(sp)
     c40:	64a6                	ld	s1,72(sp)
     c42:	6906                	ld	s2,64(sp)
     c44:	79e2                	ld	s3,56(sp)
     c46:	7a42                	ld	s4,48(sp)
     c48:	7aa2                	ld	s5,40(sp)
     c4a:	7b02                	ld	s6,32(sp)
     c4c:	6be2                	ld	s7,24(sp)
     c4e:	6125                	addi	sp,sp,96
     c50:	8082                	ret

0000000000000c52 <atoi>:
//   return r;
// }

int
atoi(const char *s)
{
     c52:	1141                	addi	sp,sp,-16
     c54:	e422                	sd	s0,8(sp)
     c56:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c58:	00054683          	lbu	a3,0(a0)
     c5c:	fd06879b          	addiw	a5,a3,-48
     c60:	0ff7f793          	zext.b	a5,a5
     c64:	4625                	li	a2,9
     c66:	02f66863          	bltu	a2,a5,c96 <atoi+0x44>
     c6a:	872a                	mv	a4,a0
  n = 0;
     c6c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     c6e:	0705                	addi	a4,a4,1
     c70:	0025179b          	slliw	a5,a0,0x2
     c74:	9fa9                	addw	a5,a5,a0
     c76:	0017979b          	slliw	a5,a5,0x1
     c7a:	9fb5                	addw	a5,a5,a3
     c7c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     c80:	00074683          	lbu	a3,0(a4)
     c84:	fd06879b          	addiw	a5,a3,-48
     c88:	0ff7f793          	zext.b	a5,a5
     c8c:	fef671e3          	bgeu	a2,a5,c6e <atoi+0x1c>
  return n;
}
     c90:	6422                	ld	s0,8(sp)
     c92:	0141                	addi	sp,sp,16
     c94:	8082                	ret
  n = 0;
     c96:	4501                	li	a0,0
     c98:	bfe5                	j	c90 <atoi+0x3e>

0000000000000c9a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c9a:	1141                	addi	sp,sp,-16
     c9c:	e422                	sd	s0,8(sp)
     c9e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     ca0:	02b57463          	bgeu	a0,a1,cc8 <memmove+0x2e>
    while(n-- > 0)
     ca4:	00c05f63          	blez	a2,cc2 <memmove+0x28>
     ca8:	1602                	slli	a2,a2,0x20
     caa:	9201                	srli	a2,a2,0x20
     cac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     cb0:	872a                	mv	a4,a0
      *dst++ = *src++;
     cb2:	0585                	addi	a1,a1,1
     cb4:	0705                	addi	a4,a4,1
     cb6:	fff5c683          	lbu	a3,-1(a1)
     cba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     cbe:	fef71ae3          	bne	a4,a5,cb2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     cc2:	6422                	ld	s0,8(sp)
     cc4:	0141                	addi	sp,sp,16
     cc6:	8082                	ret
    dst += n;
     cc8:	00c50733          	add	a4,a0,a2
    src += n;
     ccc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     cce:	fec05ae3          	blez	a2,cc2 <memmove+0x28>
     cd2:	fff6079b          	addiw	a5,a2,-1
     cd6:	1782                	slli	a5,a5,0x20
     cd8:	9381                	srli	a5,a5,0x20
     cda:	fff7c793          	not	a5,a5
     cde:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ce0:	15fd                	addi	a1,a1,-1
     ce2:	177d                	addi	a4,a4,-1
     ce4:	0005c683          	lbu	a3,0(a1)
     ce8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     cec:	fee79ae3          	bne	a5,a4,ce0 <memmove+0x46>
     cf0:	bfc9                	j	cc2 <memmove+0x28>

0000000000000cf2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     cf2:	1141                	addi	sp,sp,-16
     cf4:	e422                	sd	s0,8(sp)
     cf6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     cf8:	ca05                	beqz	a2,d28 <memcmp+0x36>
     cfa:	fff6069b          	addiw	a3,a2,-1
     cfe:	1682                	slli	a3,a3,0x20
     d00:	9281                	srli	a3,a3,0x20
     d02:	0685                	addi	a3,a3,1
     d04:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     d06:	00054783          	lbu	a5,0(a0)
     d0a:	0005c703          	lbu	a4,0(a1)
     d0e:	00e79863          	bne	a5,a4,d1e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     d12:	0505                	addi	a0,a0,1
    p2++;
     d14:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     d16:	fed518e3          	bne	a0,a3,d06 <memcmp+0x14>
  }
  return 0;
     d1a:	4501                	li	a0,0
     d1c:	a019                	j	d22 <memcmp+0x30>
      return *p1 - *p2;
     d1e:	40e7853b          	subw	a0,a5,a4
}
     d22:	6422                	ld	s0,8(sp)
     d24:	0141                	addi	sp,sp,16
     d26:	8082                	ret
  return 0;
     d28:	4501                	li	a0,0
     d2a:	bfe5                	j	d22 <memcmp+0x30>

0000000000000d2c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     d2c:	1141                	addi	sp,sp,-16
     d2e:	e406                	sd	ra,8(sp)
     d30:	e022                	sd	s0,0(sp)
     d32:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     d34:	00000097          	auipc	ra,0x0
     d38:	f66080e7          	jalr	-154(ra) # c9a <memmove>
}
     d3c:	60a2                	ld	ra,8(sp)
     d3e:	6402                	ld	s0,0(sp)
     d40:	0141                	addi	sp,sp,16
     d42:	8082                	ret

0000000000000d44 <sbrk>:

char *
sbrk(int n) {
     d44:	1141                	addi	sp,sp,-16
     d46:	e406                	sd	ra,8(sp)
     d48:	e022                	sd	s0,0(sp)
     d4a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     d4c:	4585                	li	a1,1
     d4e:	00000097          	auipc	ra,0x0
     d52:	12a080e7          	jalr	298(ra) # e78 <sys_sbrk>
}
     d56:	60a2                	ld	ra,8(sp)
     d58:	6402                	ld	s0,0(sp)
     d5a:	0141                	addi	sp,sp,16
     d5c:	8082                	ret

0000000000000d5e <get_time>:
//   return sys_sbrk(n, SBRK_LAZY);
// }


unsigned int 
get_time(void) {
     d5e:	1141                	addi	sp,sp,-16
     d60:	e406                	sd	ra,8(sp)
     d62:	e022                	sd	s0,0(sp)
     d64:	0800                	addi	s0,sp,16
    return uptime();
     d66:	00000097          	auipc	ra,0x0
     d6a:	11a080e7          	jalr	282(ra) # e80 <uptime>
}
     d6e:	2501                	sext.w	a0,a0
     d70:	60a2                	ld	ra,8(sp)
     d72:	6402                	ld	s0,0(sp)
     d74:	0141                	addi	sp,sp,16
     d76:	8082                	ret

0000000000000d78 <make_filename>:
void 
make_filename(char *buf, const char *prefix, int num) {
    // 复制前缀
    char *p = buf;
    const char *s = prefix;
    while(*s) *p++ = *s++;
     d78:	0005c783          	lbu	a5,0(a1)
     d7c:	cb81                	beqz	a5,d8c <make_filename+0x14>
     d7e:	0585                	addi	a1,a1,1
     d80:	0505                	addi	a0,a0,1
     d82:	fef50fa3          	sb	a5,-1(a0)
     d86:	0005c783          	lbu	a5,0(a1)
     d8a:	fbf5                	bnez	a5,d7e <make_filename+0x6>
    
    // 处理数字部分
    if (num == 0) {
     d8c:	ca3d                	beqz	a2,e02 <make_filename+0x8a>
make_filename(char *buf, const char *prefix, int num) {
     d8e:	1101                	addi	sp,sp,-32
     d90:	ec22                	sd	s0,24(sp)
     d92:	1000                	addi	s0,sp,32
        *p++ = '0';
    } else {
        // 临时缓冲区存放数字
        char digits[16];
        int i = 0;
        while(num > 0) {
     d94:	fe040893          	addi	a7,s0,-32
     d98:	87c6                	mv	a5,a7
            digits[i++] = (num % 10) + '0';
     d9a:	46a9                	li	a3,10
        while(num > 0) {
     d9c:	4825                	li	a6,9
     d9e:	06c05063          	blez	a2,dfe <make_filename+0x86>
            digits[i++] = (num % 10) + '0';
     da2:	02d6673b          	remw	a4,a2,a3
     da6:	0307071b          	addiw	a4,a4,48
     daa:	00e78023          	sb	a4,0(a5)
            num /= 10;
     dae:	85b2                	mv	a1,a2
     db0:	02d6463b          	divw	a2,a2,a3
        while(num > 0) {
     db4:	873e                	mv	a4,a5
     db6:	0785                	addi	a5,a5,1
     db8:	feb845e3          	blt	a6,a1,da2 <make_filename+0x2a>
     dbc:	4117073b          	subw	a4,a4,a7
     dc0:	0017069b          	addiw	a3,a4,1
            digits[i++] = (num % 10) + '0';
     dc4:	0006879b          	sext.w	a5,a3
        }
        // 倒序写入
        while(i > 0) *p++ = digits[--i];
     dc8:	04f05663          	blez	a5,e14 <make_filename+0x9c>
     dcc:	fe040713          	addi	a4,s0,-32
     dd0:	973e                	add	a4,a4,a5
     dd2:	02069593          	slli	a1,a3,0x20
     dd6:	9181                	srli	a1,a1,0x20
     dd8:	95aa                	add	a1,a1,a0
     dda:	87aa                	mv	a5,a0
     ddc:	0785                	addi	a5,a5,1
     dde:	fff74603          	lbu	a2,-1(a4)
     de2:	fec78fa3          	sb	a2,-1(a5)
     de6:	177d                	addi	a4,a4,-1
     de8:	feb79ae3          	bne	a5,a1,ddc <make_filename+0x64>
     dec:	02069793          	slli	a5,a3,0x20
     df0:	9381                	srli	a5,a5,0x20
     df2:	97aa                	add	a5,a5,a0
    }
    *p = 0; // 字符串结束符
     df4:	00078023          	sb	zero,0(a5)
     df8:	6462                	ld	s0,24(sp)
     dfa:	6105                	addi	sp,sp,32
     dfc:	8082                	ret
        while(num > 0) {
     dfe:	87aa                	mv	a5,a0
     e00:	bfd5                	j	df4 <make_filename+0x7c>
        *p++ = '0';
     e02:	00150793          	addi	a5,a0,1
     e06:	03000713          	li	a4,48
     e0a:	00e50023          	sb	a4,0(a0)
    *p = 0; // 字符串结束符
     e0e:	00078023          	sb	zero,0(a5)
     e12:	8082                	ret
        while(i > 0) *p++ = digits[--i];
     e14:	87aa                	mv	a5,a0
     e16:	bff9                	j	df4 <make_filename+0x7c>

0000000000000e18 <fork>:
.globl unlink
# generated by usys.pl - do not edit
#include "../kernel/sys/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e18:	4885                	li	a7,1
 ecall
     e1a:	00000073          	ecall
 ret
     e1e:	8082                	ret

0000000000000e20 <exit>:
.global exit
exit:
 li a7, SYS_exit
     e20:	4889                	li	a7,2
 ecall
     e22:	00000073          	ecall
 ret
     e26:	8082                	ret

0000000000000e28 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e28:	488d                	li	a7,3
 ecall
     e2a:	00000073          	ecall
 ret
     e2e:	8082                	ret

0000000000000e30 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e30:	4891                	li	a7,4
 ecall
     e32:	00000073          	ecall
 ret
     e36:	8082                	ret

0000000000000e38 <close>:
.global close
close:
 li a7, SYS_close
     e38:	4899                	li	a7,6
 ecall
     e3a:	00000073          	ecall
 ret
     e3e:	8082                	ret

0000000000000e40 <open>:
.global open
open:
 li a7, SYS_open
     e40:	489d                	li	a7,7
 ecall
     e42:	00000073          	ecall
 ret
     e46:	8082                	ret

0000000000000e48 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e48:	4895                	li	a7,5
 ecall
     e4a:	00000073          	ecall
 ret
     e4e:	8082                	ret

0000000000000e50 <read>:
.global read
read:
 li a7, SYS_read
     e50:	48a1                	li	a7,8
 ecall
     e52:	00000073          	ecall
 ret
     e56:	8082                	ret

0000000000000e58 <write>:
.global write
write:
 li a7, SYS_write
     e58:	48a5                	li	a7,9
 ecall
     e5a:	00000073          	ecall
 ret
     e5e:	8082                	ret

0000000000000e60 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e60:	48a9                	li	a7,10
 ecall
     e62:	00000073          	ecall
 ret
     e66:	8082                	ret

0000000000000e68 <makenode>:
.global makenode
makenode:
 li a7, SYS_makenode
     e68:	48ad                	li	a7,11
 ecall
     e6a:	00000073          	ecall
 ret
     e6e:	8082                	ret

0000000000000e70 <duplicate>:
.global duplicate
duplicate:
 li a7, SYS_duplicate
     e70:	48b1                	li	a7,12
 ecall
     e72:	00000073          	ecall
 ret
     e76:	8082                	ret

0000000000000e78 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     e78:	48b5                	li	a7,13
 ecall
     e7a:	00000073          	ecall
 ret
     e7e:	8082                	ret

0000000000000e80 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e80:	48b9                	li	a7,14
 ecall
     e82:	00000073          	ecall
 ret
     e86:	8082                	ret

0000000000000e88 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e88:	48bd                	li	a7,15
 ecall
     e8a:	00000073          	ecall
 ret
     e8e:	8082                	ret

0000000000000e90 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e90:	48c1                	li	a7,16
 ecall
     e92:	00000073          	ecall
 ret
     e96:	8082                	ret

0000000000000e98 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e98:	1101                	addi	sp,sp,-32
     e9a:	ec06                	sd	ra,24(sp)
     e9c:	e822                	sd	s0,16(sp)
     e9e:	1000                	addi	s0,sp,32
     ea0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ea4:	4605                	li	a2,1
     ea6:	fef40593          	addi	a1,s0,-17
     eaa:	00000097          	auipc	ra,0x0
     eae:	fae080e7          	jalr	-82(ra) # e58 <write>
}
     eb2:	60e2                	ld	ra,24(sp)
     eb4:	6442                	ld	s0,16(sp)
     eb6:	6105                	addi	sp,sp,32
     eb8:	8082                	ret

0000000000000eba <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     eba:	715d                	addi	sp,sp,-80
     ebc:	e486                	sd	ra,72(sp)
     ebe:	e0a2                	sd	s0,64(sp)
     ec0:	f84a                	sd	s2,48(sp)
     ec2:	0880                	addi	s0,sp,80
     ec4:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     ec6:	c299                	beqz	a3,ecc <printint+0x12>
     ec8:	0805c563          	bltz	a1,f52 <printint+0x98>
  neg = 0;
     ecc:	4881                	li	a7,0
     ece:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     ed2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     ed4:	00000517          	auipc	a0,0x0
     ed8:	69c50513          	addi	a0,a0,1692 # 1570 <digits>
     edc:	883e                	mv	a6,a5
     ede:	2785                	addiw	a5,a5,1
     ee0:	02c5f733          	remu	a4,a1,a2
     ee4:	972a                	add	a4,a4,a0
     ee6:	00074703          	lbu	a4,0(a4)
     eea:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     eee:	872e                	mv	a4,a1
     ef0:	02c5d5b3          	divu	a1,a1,a2
     ef4:	0685                	addi	a3,a3,1
     ef6:	fec773e3          	bgeu	a4,a2,edc <printint+0x22>
  if(neg)
     efa:	00088b63          	beqz	a7,f10 <printint+0x56>
    buf[i++] = '-';
     efe:	fd078793          	addi	a5,a5,-48
     f02:	97a2                	add	a5,a5,s0
     f04:	02d00713          	li	a4,45
     f08:	fee78423          	sb	a4,-24(a5)
     f0c:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
     f10:	02f05c63          	blez	a5,f48 <printint+0x8e>
     f14:	fc26                	sd	s1,56(sp)
     f16:	f44e                	sd	s3,40(sp)
     f18:	fb840713          	addi	a4,s0,-72
     f1c:	00f704b3          	add	s1,a4,a5
     f20:	fff70993          	addi	s3,a4,-1
     f24:	99be                	add	s3,s3,a5
     f26:	37fd                	addiw	a5,a5,-1
     f28:	1782                	slli	a5,a5,0x20
     f2a:	9381                	srli	a5,a5,0x20
     f2c:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     f30:	fff4c583          	lbu	a1,-1(s1)
     f34:	854a                	mv	a0,s2
     f36:	00000097          	auipc	ra,0x0
     f3a:	f62080e7          	jalr	-158(ra) # e98 <putc>
  while(--i >= 0)
     f3e:	14fd                	addi	s1,s1,-1
     f40:	ff3498e3          	bne	s1,s3,f30 <printint+0x76>
     f44:	74e2                	ld	s1,56(sp)
     f46:	79a2                	ld	s3,40(sp)
}
     f48:	60a6                	ld	ra,72(sp)
     f4a:	6406                	ld	s0,64(sp)
     f4c:	7942                	ld	s2,48(sp)
     f4e:	6161                	addi	sp,sp,80
     f50:	8082                	ret
    x = -xx;
     f52:	40b005b3          	neg	a1,a1
    neg = 1;
     f56:	4885                	li	a7,1
    x = -xx;
     f58:	bf9d                	j	ece <printint+0x14>

0000000000000f5a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f5a:	711d                	addi	sp,sp,-96
     f5c:	ec86                	sd	ra,88(sp)
     f5e:	e8a2                	sd	s0,80(sp)
     f60:	e0ca                	sd	s2,64(sp)
     f62:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f64:	0005c903          	lbu	s2,0(a1)
     f68:	2c090a63          	beqz	s2,123c <vprintf+0x2e2>
     f6c:	e4a6                	sd	s1,72(sp)
     f6e:	fc4e                	sd	s3,56(sp)
     f70:	f852                	sd	s4,48(sp)
     f72:	f456                	sd	s5,40(sp)
     f74:	f05a                	sd	s6,32(sp)
     f76:	ec5e                	sd	s7,24(sp)
     f78:	e862                	sd	s8,16(sp)
     f7a:	e466                	sd	s9,8(sp)
     f7c:	8b2a                	mv	s6,a0
     f7e:	8a2e                	mv	s4,a1
     f80:	8bb2                	mv	s7,a2
  state = 0;
     f82:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     f84:	4481                	li	s1,0
     f86:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     f88:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     f8c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     f90:	06c00c93          	li	s9,108
     f94:	a015                	j	fb8 <vprintf+0x5e>
        putc(fd, c0);
     f96:	85ca                	mv	a1,s2
     f98:	855a                	mv	a0,s6
     f9a:	00000097          	auipc	ra,0x0
     f9e:	efe080e7          	jalr	-258(ra) # e98 <putc>
     fa2:	a019                	j	fa8 <vprintf+0x4e>
    } else if(state == '%'){
     fa4:	03598263          	beq	s3,s5,fc8 <vprintf+0x6e>
  for(i = 0; fmt[i]; i++){
     fa8:	2485                	addiw	s1,s1,1
     faa:	8726                	mv	a4,s1
     fac:	009a07b3          	add	a5,s4,s1
     fb0:	0007c903          	lbu	s2,0(a5)
     fb4:	26090c63          	beqz	s2,122c <vprintf+0x2d2>
    c0 = fmt[i] & 0xff;
     fb8:	0009079b          	sext.w	a5,s2
    if(state == 0){
     fbc:	fe0994e3          	bnez	s3,fa4 <vprintf+0x4a>
      if(c0 == '%'){
     fc0:	fd579be3          	bne	a5,s5,f96 <vprintf+0x3c>
        state = '%';
     fc4:	89be                	mv	s3,a5
     fc6:	b7cd                	j	fa8 <vprintf+0x4e>
      if(c0) c1 = fmt[i+1] & 0xff;
     fc8:	00ea06b3          	add	a3,s4,a4
     fcc:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     fd0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     fd2:	c681                	beqz	a3,fda <vprintf+0x80>
     fd4:	9752                	add	a4,a4,s4
     fd6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     fda:	05878563          	beq	a5,s8,1024 <vprintf+0xca>
      } else if(c0 == 'l' && c1 == 'd'){
     fde:	07978163          	beq	a5,s9,1040 <vprintf+0xe6>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     fe2:	07500713          	li	a4,117
     fe6:	10e78563          	beq	a5,a4,10f0 <vprintf+0x196>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     fea:	07800713          	li	a4,120
     fee:	14e78d63          	beq	a5,a4,1148 <vprintf+0x1ee>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     ff2:	07000713          	li	a4,112
     ff6:	18e78663          	beq	a5,a4,1182 <vprintf+0x228>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     ffa:	06300713          	li	a4,99
     ffe:	1ce78c63          	beq	a5,a4,11d6 <vprintf+0x27c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
    1002:	07300713          	li	a4,115
    1006:	1ee78463          	beq	a5,a4,11ee <vprintf+0x294>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    100a:	02500713          	li	a4,37
    100e:	04e79963          	bne	a5,a4,1060 <vprintf+0x106>
        putc(fd, '%');
    1012:	02500593          	li	a1,37
    1016:	855a                	mv	a0,s6
    1018:	00000097          	auipc	ra,0x0
    101c:	e80080e7          	jalr	-384(ra) # e98 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
    1020:	4981                	li	s3,0
    1022:	b759                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, int), 10, 1);
    1024:	008b8913          	addi	s2,s7,8
    1028:	4685                	li	a3,1
    102a:	4629                	li	a2,10
    102c:	000ba583          	lw	a1,0(s7)
    1030:	855a                	mv	a0,s6
    1032:	00000097          	auipc	ra,0x0
    1036:	e88080e7          	jalr	-376(ra) # eba <printint>
    103a:	8bca                	mv	s7,s2
      state = 0;
    103c:	4981                	li	s3,0
    103e:	b7ad                	j	fa8 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'd'){
    1040:	06400793          	li	a5,100
    1044:	02f68d63          	beq	a3,a5,107e <vprintf+0x124>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    1048:	06c00793          	li	a5,108
    104c:	04f68863          	beq	a3,a5,109c <vprintf+0x142>
      } else if(c0 == 'l' && c1 == 'u'){
    1050:	07500793          	li	a5,117
    1054:	0af68c63          	beq	a3,a5,110c <vprintf+0x1b2>
      } else if(c0 == 'l' && c1 == 'x'){
    1058:	07800793          	li	a5,120
    105c:	10f68463          	beq	a3,a5,1164 <vprintf+0x20a>
        putc(fd, '%');
    1060:	02500593          	li	a1,37
    1064:	855a                	mv	a0,s6
    1066:	00000097          	auipc	ra,0x0
    106a:	e32080e7          	jalr	-462(ra) # e98 <putc>
        putc(fd, c0);
    106e:	85ca                	mv	a1,s2
    1070:	855a                	mv	a0,s6
    1072:	00000097          	auipc	ra,0x0
    1076:	e26080e7          	jalr	-474(ra) # e98 <putc>
      state = 0;
    107a:	4981                	li	s3,0
    107c:	b735                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
    107e:	008b8913          	addi	s2,s7,8
    1082:	4685                	li	a3,1
    1084:	4629                	li	a2,10
    1086:	000bb583          	ld	a1,0(s7)
    108a:	855a                	mv	a0,s6
    108c:	00000097          	auipc	ra,0x0
    1090:	e2e080e7          	jalr	-466(ra) # eba <printint>
        i += 1;
    1094:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    1096:	8bca                	mv	s7,s2
      state = 0;
    1098:	4981                	li	s3,0
        i += 1;
    109a:	b739                	j	fa8 <vprintf+0x4e>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    109c:	06400793          	li	a5,100
    10a0:	02f60963          	beq	a2,a5,10d2 <vprintf+0x178>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    10a4:	07500793          	li	a5,117
    10a8:	08f60163          	beq	a2,a5,112a <vprintf+0x1d0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    10ac:	07800793          	li	a5,120
    10b0:	faf618e3          	bne	a2,a5,1060 <vprintf+0x106>
        printint(fd, va_arg(ap, uint64), 16, 0);
    10b4:	008b8913          	addi	s2,s7,8
    10b8:	4681                	li	a3,0
    10ba:	4641                	li	a2,16
    10bc:	000bb583          	ld	a1,0(s7)
    10c0:	855a                	mv	a0,s6
    10c2:	00000097          	auipc	ra,0x0
    10c6:	df8080e7          	jalr	-520(ra) # eba <printint>
        i += 2;
    10ca:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    10cc:	8bca                	mv	s7,s2
      state = 0;
    10ce:	4981                	li	s3,0
        i += 2;
    10d0:	bde1                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 1);
    10d2:	008b8913          	addi	s2,s7,8
    10d6:	4685                	li	a3,1
    10d8:	4629                	li	a2,10
    10da:	000bb583          	ld	a1,0(s7)
    10de:	855a                	mv	a0,s6
    10e0:	00000097          	auipc	ra,0x0
    10e4:	dda080e7          	jalr	-550(ra) # eba <printint>
        i += 2;
    10e8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    10ea:	8bca                	mv	s7,s2
      state = 0;
    10ec:	4981                	li	s3,0
        i += 2;
    10ee:	bd6d                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 10, 0);
    10f0:	008b8913          	addi	s2,s7,8
    10f4:	4681                	li	a3,0
    10f6:	4629                	li	a2,10
    10f8:	000be583          	lwu	a1,0(s7)
    10fc:	855a                	mv	a0,s6
    10fe:	00000097          	auipc	ra,0x0
    1102:	dbc080e7          	jalr	-580(ra) # eba <printint>
    1106:	8bca                	mv	s7,s2
      state = 0;
    1108:	4981                	li	s3,0
    110a:	bd79                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
    110c:	008b8913          	addi	s2,s7,8
    1110:	4681                	li	a3,0
    1112:	4629                	li	a2,10
    1114:	000bb583          	ld	a1,0(s7)
    1118:	855a                	mv	a0,s6
    111a:	00000097          	auipc	ra,0x0
    111e:	da0080e7          	jalr	-608(ra) # eba <printint>
        i += 1;
    1122:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1124:	8bca                	mv	s7,s2
      state = 0;
    1126:	4981                	li	s3,0
        i += 1;
    1128:	b541                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 10, 0);
    112a:	008b8913          	addi	s2,s7,8
    112e:	4681                	li	a3,0
    1130:	4629                	li	a2,10
    1132:	000bb583          	ld	a1,0(s7)
    1136:	855a                	mv	a0,s6
    1138:	00000097          	auipc	ra,0x0
    113c:	d82080e7          	jalr	-638(ra) # eba <printint>
        i += 2;
    1140:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1142:	8bca                	mv	s7,s2
      state = 0;
    1144:	4981                	li	s3,0
        i += 2;
    1146:	b58d                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint32), 16, 0);
    1148:	008b8913          	addi	s2,s7,8
    114c:	4681                	li	a3,0
    114e:	4641                	li	a2,16
    1150:	000be583          	lwu	a1,0(s7)
    1154:	855a                	mv	a0,s6
    1156:	00000097          	auipc	ra,0x0
    115a:	d64080e7          	jalr	-668(ra) # eba <printint>
    115e:	8bca                	mv	s7,s2
      state = 0;
    1160:	4981                	li	s3,0
    1162:	b599                	j	fa8 <vprintf+0x4e>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1164:	008b8913          	addi	s2,s7,8
    1168:	4681                	li	a3,0
    116a:	4641                	li	a2,16
    116c:	000bb583          	ld	a1,0(s7)
    1170:	855a                	mv	a0,s6
    1172:	00000097          	auipc	ra,0x0
    1176:	d48080e7          	jalr	-696(ra) # eba <printint>
        i += 1;
    117a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    117c:	8bca                	mv	s7,s2
      state = 0;
    117e:	4981                	li	s3,0
        i += 1;
    1180:	b525                	j	fa8 <vprintf+0x4e>
    1182:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1184:	008b8d13          	addi	s10,s7,8
    1188:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    118c:	03000593          	li	a1,48
    1190:	855a                	mv	a0,s6
    1192:	00000097          	auipc	ra,0x0
    1196:	d06080e7          	jalr	-762(ra) # e98 <putc>
  putc(fd, 'x');
    119a:	07800593          	li	a1,120
    119e:	855a                	mv	a0,s6
    11a0:	00000097          	auipc	ra,0x0
    11a4:	cf8080e7          	jalr	-776(ra) # e98 <putc>
    11a8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    11aa:	00000b97          	auipc	s7,0x0
    11ae:	3c6b8b93          	addi	s7,s7,966 # 1570 <digits>
    11b2:	03c9d793          	srli	a5,s3,0x3c
    11b6:	97de                	add	a5,a5,s7
    11b8:	0007c583          	lbu	a1,0(a5)
    11bc:	855a                	mv	a0,s6
    11be:	00000097          	auipc	ra,0x0
    11c2:	cda080e7          	jalr	-806(ra) # e98 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    11c6:	0992                	slli	s3,s3,0x4
    11c8:	397d                	addiw	s2,s2,-1
    11ca:	fe0914e3          	bnez	s2,11b2 <vprintf+0x258>
        printptr(fd, va_arg(ap, uint64));
    11ce:	8bea                	mv	s7,s10
      state = 0;
    11d0:	4981                	li	s3,0
    11d2:	6d02                	ld	s10,0(sp)
    11d4:	bbd1                	j	fa8 <vprintf+0x4e>
        putc(fd, va_arg(ap, uint32));
    11d6:	008b8913          	addi	s2,s7,8
    11da:	000bc583          	lbu	a1,0(s7)
    11de:	855a                	mv	a0,s6
    11e0:	00000097          	auipc	ra,0x0
    11e4:	cb8080e7          	jalr	-840(ra) # e98 <putc>
    11e8:	8bca                	mv	s7,s2
      state = 0;
    11ea:	4981                	li	s3,0
    11ec:	bb75                	j	fa8 <vprintf+0x4e>
        if((s = va_arg(ap, char*)) == 0)
    11ee:	008b8993          	addi	s3,s7,8
    11f2:	000bb903          	ld	s2,0(s7)
    11f6:	02090163          	beqz	s2,1218 <vprintf+0x2be>
        for(; *s; s++)
    11fa:	00094583          	lbu	a1,0(s2)
    11fe:	c585                	beqz	a1,1226 <vprintf+0x2cc>
          putc(fd, *s);
    1200:	855a                	mv	a0,s6
    1202:	00000097          	auipc	ra,0x0
    1206:	c96080e7          	jalr	-874(ra) # e98 <putc>
        for(; *s; s++)
    120a:	0905                	addi	s2,s2,1
    120c:	00094583          	lbu	a1,0(s2)
    1210:	f9e5                	bnez	a1,1200 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
    1212:	8bce                	mv	s7,s3
      state = 0;
    1214:	4981                	li	s3,0
    1216:	bb49                	j	fa8 <vprintf+0x4e>
          s = "(null)";
    1218:	00000917          	auipc	s2,0x0
    121c:	33890913          	addi	s2,s2,824 # 1550 <malloc+0x224>
        for(; *s; s++)
    1220:	02800593          	li	a1,40
    1224:	bff1                	j	1200 <vprintf+0x2a6>
        if((s = va_arg(ap, char*)) == 0)
    1226:	8bce                	mv	s7,s3
      state = 0;
    1228:	4981                	li	s3,0
    122a:	bbbd                	j	fa8 <vprintf+0x4e>
    122c:	64a6                	ld	s1,72(sp)
    122e:	79e2                	ld	s3,56(sp)
    1230:	7a42                	ld	s4,48(sp)
    1232:	7aa2                	ld	s5,40(sp)
    1234:	7b02                	ld	s6,32(sp)
    1236:	6be2                	ld	s7,24(sp)
    1238:	6c42                	ld	s8,16(sp)
    123a:	6ca2                	ld	s9,8(sp)
    }
  }
}
    123c:	60e6                	ld	ra,88(sp)
    123e:	6446                	ld	s0,80(sp)
    1240:	6906                	ld	s2,64(sp)
    1242:	6125                	addi	sp,sp,96
    1244:	8082                	ret

0000000000001246 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1246:	715d                	addi	sp,sp,-80
    1248:	ec06                	sd	ra,24(sp)
    124a:	e822                	sd	s0,16(sp)
    124c:	1000                	addi	s0,sp,32
    124e:	e010                	sd	a2,0(s0)
    1250:	e414                	sd	a3,8(s0)
    1252:	e818                	sd	a4,16(s0)
    1254:	ec1c                	sd	a5,24(s0)
    1256:	03043023          	sd	a6,32(s0)
    125a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    125e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1262:	8622                	mv	a2,s0
    1264:	00000097          	auipc	ra,0x0
    1268:	cf6080e7          	jalr	-778(ra) # f5a <vprintf>
}
    126c:	60e2                	ld	ra,24(sp)
    126e:	6442                	ld	s0,16(sp)
    1270:	6161                	addi	sp,sp,80
    1272:	8082                	ret

0000000000001274 <printf>:

void
printf(const char *fmt, ...)
{
    1274:	711d                	addi	sp,sp,-96
    1276:	ec06                	sd	ra,24(sp)
    1278:	e822                	sd	s0,16(sp)
    127a:	1000                	addi	s0,sp,32
    127c:	e40c                	sd	a1,8(s0)
    127e:	e810                	sd	a2,16(s0)
    1280:	ec14                	sd	a3,24(s0)
    1282:	f018                	sd	a4,32(s0)
    1284:	f41c                	sd	a5,40(s0)
    1286:	03043823          	sd	a6,48(s0)
    128a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    128e:	00840613          	addi	a2,s0,8
    1292:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1296:	85aa                	mv	a1,a0
    1298:	4505                	li	a0,1
    129a:	00000097          	auipc	ra,0x0
    129e:	cc0080e7          	jalr	-832(ra) # f5a <vprintf>
}
    12a2:	60e2                	ld	ra,24(sp)
    12a4:	6442                	ld	s0,16(sp)
    12a6:	6125                	addi	sp,sp,96
    12a8:	8082                	ret

00000000000012aa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12aa:	1141                	addi	sp,sp,-16
    12ac:	e422                	sd	s0,8(sp)
    12ae:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    12b0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12b4:	00001797          	auipc	a5,0x1
    12b8:	d5c7b783          	ld	a5,-676(a5) # 2010 <freep>
    12bc:	a02d                	j	12e6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12be:	4618                	lw	a4,8(a2)
    12c0:	9f2d                	addw	a4,a4,a1
    12c2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    12c6:	6398                	ld	a4,0(a5)
    12c8:	6310                	ld	a2,0(a4)
    12ca:	a83d                	j	1308 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12cc:	ff852703          	lw	a4,-8(a0)
    12d0:	9f31                	addw	a4,a4,a2
    12d2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    12d4:	ff053683          	ld	a3,-16(a0)
    12d8:	a091                	j	131c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12da:	6398                	ld	a4,0(a5)
    12dc:	00e7e463          	bltu	a5,a4,12e4 <free+0x3a>
    12e0:	00e6ea63          	bltu	a3,a4,12f4 <free+0x4a>
{
    12e4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12e6:	fed7fae3          	bgeu	a5,a3,12da <free+0x30>
    12ea:	6398                	ld	a4,0(a5)
    12ec:	00e6e463          	bltu	a3,a4,12f4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12f0:	fee7eae3          	bltu	a5,a4,12e4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    12f4:	ff852583          	lw	a1,-8(a0)
    12f8:	6390                	ld	a2,0(a5)
    12fa:	02059813          	slli	a6,a1,0x20
    12fe:	01c85713          	srli	a4,a6,0x1c
    1302:	9736                	add	a4,a4,a3
    1304:	fae60de3          	beq	a2,a4,12be <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1308:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    130c:	4790                	lw	a2,8(a5)
    130e:	02061593          	slli	a1,a2,0x20
    1312:	01c5d713          	srli	a4,a1,0x1c
    1316:	973e                	add	a4,a4,a5
    1318:	fae68ae3          	beq	a3,a4,12cc <free+0x22>
    p->s.ptr = bp->s.ptr;
    131c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    131e:	00001717          	auipc	a4,0x1
    1322:	cef73923          	sd	a5,-782(a4) # 2010 <freep>
}
    1326:	6422                	ld	s0,8(sp)
    1328:	0141                	addi	sp,sp,16
    132a:	8082                	ret

000000000000132c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    132c:	7139                	addi	sp,sp,-64
    132e:	fc06                	sd	ra,56(sp)
    1330:	f822                	sd	s0,48(sp)
    1332:	f426                	sd	s1,40(sp)
    1334:	ec4e                	sd	s3,24(sp)
    1336:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1338:	02051493          	slli	s1,a0,0x20
    133c:	9081                	srli	s1,s1,0x20
    133e:	04bd                	addi	s1,s1,15
    1340:	8091                	srli	s1,s1,0x4
    1342:	0014899b          	addiw	s3,s1,1
    1346:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1348:	00001517          	auipc	a0,0x1
    134c:	cc853503          	ld	a0,-824(a0) # 2010 <freep>
    1350:	c915                	beqz	a0,1384 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1352:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1354:	4798                	lw	a4,8(a5)
    1356:	08977e63          	bgeu	a4,s1,13f2 <malloc+0xc6>
    135a:	f04a                	sd	s2,32(sp)
    135c:	e852                	sd	s4,16(sp)
    135e:	e456                	sd	s5,8(sp)
    1360:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1362:	8a4e                	mv	s4,s3
    1364:	0009871b          	sext.w	a4,s3
    1368:	6685                	lui	a3,0x1
    136a:	00d77363          	bgeu	a4,a3,1370 <malloc+0x44>
    136e:	6a05                	lui	s4,0x1
    1370:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1374:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1378:	00001917          	auipc	s2,0x1
    137c:	c9890913          	addi	s2,s2,-872 # 2010 <freep>
  if(p == SBRK_ERROR)
    1380:	5afd                	li	s5,-1
    1382:	a091                	j	13c6 <malloc+0x9a>
    1384:	f04a                	sd	s2,32(sp)
    1386:	e852                	sd	s4,16(sp)
    1388:	e456                	sd	s5,8(sp)
    138a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    138c:	00001797          	auipc	a5,0x1
    1390:	cfc78793          	addi	a5,a5,-772 # 2088 <base>
    1394:	00001717          	auipc	a4,0x1
    1398:	c6f73e23          	sd	a5,-900(a4) # 2010 <freep>
    139c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    139e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    13a2:	b7c1                	j	1362 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    13a4:	6398                	ld	a4,0(a5)
    13a6:	e118                	sd	a4,0(a0)
    13a8:	a08d                	j	140a <malloc+0xde>
  hp->s.size = nu;
    13aa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    13ae:	0541                	addi	a0,a0,16
    13b0:	00000097          	auipc	ra,0x0
    13b4:	efa080e7          	jalr	-262(ra) # 12aa <free>
  return freep;
    13b8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    13bc:	c13d                	beqz	a0,1422 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13be:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13c0:	4798                	lw	a4,8(a5)
    13c2:	02977463          	bgeu	a4,s1,13ea <malloc+0xbe>
    if(p == freep)
    13c6:	00093703          	ld	a4,0(s2)
    13ca:	853e                	mv	a0,a5
    13cc:	fef719e3          	bne	a4,a5,13be <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
    13d0:	8552                	mv	a0,s4
    13d2:	00000097          	auipc	ra,0x0
    13d6:	972080e7          	jalr	-1678(ra) # d44 <sbrk>
  if(p == SBRK_ERROR)
    13da:	fd5518e3          	bne	a0,s5,13aa <malloc+0x7e>
        return 0;
    13de:	4501                	li	a0,0
    13e0:	7902                	ld	s2,32(sp)
    13e2:	6a42                	ld	s4,16(sp)
    13e4:	6aa2                	ld	s5,8(sp)
    13e6:	6b02                	ld	s6,0(sp)
    13e8:	a03d                	j	1416 <malloc+0xea>
    13ea:	7902                	ld	s2,32(sp)
    13ec:	6a42                	ld	s4,16(sp)
    13ee:	6aa2                	ld	s5,8(sp)
    13f0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    13f2:	fae489e3          	beq	s1,a4,13a4 <malloc+0x78>
        p->s.size -= nunits;
    13f6:	4137073b          	subw	a4,a4,s3
    13fa:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13fc:	02071693          	slli	a3,a4,0x20
    1400:	01c6d713          	srli	a4,a3,0x1c
    1404:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1406:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    140a:	00001717          	auipc	a4,0x1
    140e:	c0a73323          	sd	a0,-1018(a4) # 2010 <freep>
      return (void*)(p + 1);
    1412:	01078513          	addi	a0,a5,16
  }
}
    1416:	70e2                	ld	ra,56(sp)
    1418:	7442                	ld	s0,48(sp)
    141a:	74a2                	ld	s1,40(sp)
    141c:	69e2                	ld	s3,24(sp)
    141e:	6121                	addi	sp,sp,64
    1420:	8082                	ret
    1422:	7902                	ld	s2,32(sp)
    1424:	6a42                	ld	s4,16(sp)
    1426:	6aa2                	ld	s5,8(sp)
    1428:	6b02                	ld	s6,0(sp)
    142a:	b7f5                	j	1416 <malloc+0xea>
