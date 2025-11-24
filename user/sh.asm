
user/_sh:     file format elf64-littleriscv


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
      16:	2ce58593          	addi	a1,a1,718 # 12e0 <malloc+0xfe>
      1a:	8532                	mv	a0,a2
      1c:	525000ef          	jal	d40 <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	219000ef          	jal	a3e <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	25f000ef          	jal	a8c <gets>
  if(buf[0] == 0) // EOF
      32:	0004c503          	lbu	a0,0(s1)
      36:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      3a:	40a0053b          	negw	a0,a0
      3e:	60e2                	ld	ra,24(sp)
      40:	6442                	ld	s0,16(sp)
      42:	64a2                	ld	s1,8(sp)
      44:	6902                	ld	s2,0(sp)
      46:	6105                	addi	sp,sp,32
      48:	8082                	ret

000000000000004a <panic>:
  exit(0);
}

void
panic(char *s)
{
      4a:	1141                	addi	sp,sp,-16
      4c:	e406                	sd	ra,8(sp)
      4e:	e022                	sd	s0,0(sp)
      50:	0800                	addi	s0,sp,16
      52:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      54:	00001597          	auipc	a1,0x1
      58:	29c58593          	addi	a1,a1,668 # 12f0 <malloc+0x10e>
      5c:	4509                	li	a0,2
      5e:	0a2010ef          	jal	1100 <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	4bd000ef          	jal	d20 <exit>

0000000000000068 <fork1>:
}

int
fork1(void)
{
      68:	1141                	addi	sp,sp,-16
      6a:	e406                	sd	ra,8(sp)
      6c:	e022                	sd	s0,0(sp)
      6e:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      70:	4a9000ef          	jal	d18 <fork>
  if(pid == -1)
      74:	57fd                	li	a5,-1
      76:	00f50663          	beq	a0,a5,82 <fork1+0x1a>
    panic("fork");
  return pid;
}
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
    panic("fork");
      82:	00001517          	auipc	a0,0x1
      86:	27650513          	addi	a0,a0,630 # 12f8 <malloc+0x116>
      8a:	fc1ff0ef          	jal	4a <panic>

000000000000008e <runcmd>:
{
      8e:	7179                	addi	sp,sp,-48
      90:	f406                	sd	ra,40(sp)
      92:	f022                	sd	s0,32(sp)
      94:	1800                	addi	s0,sp,48
  if(cmd == 0)
      96:	c115                	beqz	a0,ba <runcmd+0x2c>
      98:	ec26                	sd	s1,24(sp)
      9a:	84aa                	mv	s1,a0
  switch(cmd->type){
      9c:	4118                	lw	a4,0(a0)
      9e:	4795                	li	a5,5
      a0:	02e7e163          	bltu	a5,a4,c2 <runcmd+0x34>
      a4:	00056783          	lwu	a5,0(a0)
      a8:	078a                	slli	a5,a5,0x2
      aa:	00001717          	auipc	a4,0x1
      ae:	34e70713          	addi	a4,a4,846 # 13f8 <malloc+0x216>
      b2:	97ba                	add	a5,a5,a4
      b4:	439c                	lw	a5,0(a5)
      b6:	97ba                	add	a5,a5,a4
      b8:	8782                	jr	a5
      ba:	ec26                	sd	s1,24(sp)
    exit(1);
      bc:	4505                	li	a0,1
      be:	463000ef          	jal	d20 <exit>
    panic("runcmd");
      c2:	00001517          	auipc	a0,0x1
      c6:	23e50513          	addi	a0,a0,574 # 1300 <malloc+0x11e>
      ca:	f81ff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      ce:	6508                	ld	a0,8(a0)
      d0:	c105                	beqz	a0,f0 <runcmd+0x62>
    exec(ecmd->argv[0], ecmd->argv);
      d2:	00848593          	addi	a1,s1,8
      d6:	483000ef          	jal	d58 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      da:	6490                	ld	a2,8(s1)
      dc:	00001597          	auipc	a1,0x1
      e0:	22c58593          	addi	a1,a1,556 # 1308 <malloc+0x126>
      e4:	4509                	li	a0,2
      e6:	01a010ef          	jal	1100 <fprintf>
  exit(0);
      ea:	4501                	li	a0,0
      ec:	435000ef          	jal	d20 <exit>
      exit(1);
      f0:	4505                	li	a0,1
      f2:	42f000ef          	jal	d20 <exit>
    close(rcmd->fd);
      f6:	5148                	lw	a0,36(a0)
      f8:	451000ef          	jal	d48 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
      fc:	508c                	lw	a1,32(s1)
      fe:	6888                	ld	a0,16(s1)
     100:	461000ef          	jal	d60 <open>
     104:	00054563          	bltz	a0,10e <runcmd+0x80>
    runcmd(rcmd->cmd);
     108:	6488                	ld	a0,8(s1)
     10a:	f85ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     10e:	6890                	ld	a2,16(s1)
     110:	00001597          	auipc	a1,0x1
     114:	20858593          	addi	a1,a1,520 # 1318 <malloc+0x136>
     118:	4509                	li	a0,2
     11a:	7e7000ef          	jal	1100 <fprintf>
      exit(1);
     11e:	4505                	li	a0,1
     120:	401000ef          	jal	d20 <exit>
    if(fork1() == 0)
     124:	f45ff0ef          	jal	68 <fork1>
     128:	e501                	bnez	a0,130 <runcmd+0xa2>
      runcmd(lcmd->left);
     12a:	6488                	ld	a0,8(s1)
     12c:	f63ff0ef          	jal	8e <runcmd>
    wait(0);
     130:	4501                	li	a0,0
     132:	3f7000ef          	jal	d28 <wait>
    runcmd(lcmd->right);
     136:	6888                	ld	a0,16(s1)
     138:	f57ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     13c:	fd840513          	addi	a0,s0,-40
     140:	3f1000ef          	jal	d30 <pipe>
     144:	02054763          	bltz	a0,172 <runcmd+0xe4>
    if(fork1() == 0){
     148:	f21ff0ef          	jal	68 <fork1>
     14c:	e90d                	bnez	a0,17e <runcmd+0xf0>
      close(1);
     14e:	4505                	li	a0,1
     150:	3f9000ef          	jal	d48 <close>
      dup(p[1]);
     154:	fdc42503          	lw	a0,-36(s0)
     158:	441000ef          	jal	d98 <dup>
      close(p[0]);
     15c:	fd842503          	lw	a0,-40(s0)
     160:	3e9000ef          	jal	d48 <close>
      close(p[1]);
     164:	fdc42503          	lw	a0,-36(s0)
     168:	3e1000ef          	jal	d48 <close>
      runcmd(pcmd->left);
     16c:	6488                	ld	a0,8(s1)
     16e:	f21ff0ef          	jal	8e <runcmd>
      panic("pipe");
     172:	00001517          	auipc	a0,0x1
     176:	1b650513          	addi	a0,a0,438 # 1328 <malloc+0x146>
     17a:	ed1ff0ef          	jal	4a <panic>
    if(fork1() == 0){
     17e:	eebff0ef          	jal	68 <fork1>
     182:	e115                	bnez	a0,1a6 <runcmd+0x118>
      close(0);
     184:	3c5000ef          	jal	d48 <close>
      dup(p[0]);
     188:	fd842503          	lw	a0,-40(s0)
     18c:	40d000ef          	jal	d98 <dup>
      close(p[0]);
     190:	fd842503          	lw	a0,-40(s0)
     194:	3b5000ef          	jal	d48 <close>
      close(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	3ad000ef          	jal	d48 <close>
      runcmd(pcmd->right);
     1a0:	6888                	ld	a0,16(s1)
     1a2:	eedff0ef          	jal	8e <runcmd>
    close(p[0]);
     1a6:	fd842503          	lw	a0,-40(s0)
     1aa:	39f000ef          	jal	d48 <close>
    close(p[1]);
     1ae:	fdc42503          	lw	a0,-36(s0)
     1b2:	397000ef          	jal	d48 <close>
    wait(0);
     1b6:	4501                	li	a0,0
     1b8:	371000ef          	jal	d28 <wait>
    wait(0);
     1bc:	4501                	li	a0,0
     1be:	36b000ef          	jal	d28 <wait>
    break;
     1c2:	b725                	j	ea <runcmd+0x5c>
    if(fork1() == 0)
     1c4:	ea5ff0ef          	jal	68 <fork1>
     1c8:	f20511e3          	bnez	a0,ea <runcmd+0x5c>
      runcmd(bcmd->cmd);
     1cc:	6488                	ld	a0,8(s1)
     1ce:	ec1ff0ef          	jal	8e <runcmd>

00000000000001d2 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     1d2:	1101                	addi	sp,sp,-32
     1d4:	ec06                	sd	ra,24(sp)
     1d6:	e822                	sd	s0,16(sp)
     1d8:	e426                	sd	s1,8(sp)
     1da:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     1dc:	0a800513          	li	a0,168
     1e0:	002010ef          	jal	11e2 <malloc>
     1e4:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     1e6:	0a800613          	li	a2,168
     1ea:	4581                	li	a1,0
     1ec:	053000ef          	jal	a3e <memset>
  cmd->type = EXEC;
     1f0:	4785                	li	a5,1
     1f2:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     1f4:	8526                	mv	a0,s1
     1f6:	60e2                	ld	ra,24(sp)
     1f8:	6442                	ld	s0,16(sp)
     1fa:	64a2                	ld	s1,8(sp)
     1fc:	6105                	addi	sp,sp,32
     1fe:	8082                	ret

0000000000000200 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     200:	7139                	addi	sp,sp,-64
     202:	fc06                	sd	ra,56(sp)
     204:	f822                	sd	s0,48(sp)
     206:	f426                	sd	s1,40(sp)
     208:	f04a                	sd	s2,32(sp)
     20a:	ec4e                	sd	s3,24(sp)
     20c:	e852                	sd	s4,16(sp)
     20e:	e456                	sd	s5,8(sp)
     210:	e05a                	sd	s6,0(sp)
     212:	0080                	addi	s0,sp,64
     214:	8b2a                	mv	s6,a0
     216:	8aae                	mv	s5,a1
     218:	8a32                	mv	s4,a2
     21a:	89b6                	mv	s3,a3
     21c:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     21e:	02800513          	li	a0,40
     222:	7c1000ef          	jal	11e2 <malloc>
     226:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     228:	02800613          	li	a2,40
     22c:	4581                	li	a1,0
     22e:	011000ef          	jal	a3e <memset>
  cmd->type = REDIR;
     232:	4789                	li	a5,2
     234:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     236:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     23a:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     23e:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     242:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     246:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     24a:	8526                	mv	a0,s1
     24c:	70e2                	ld	ra,56(sp)
     24e:	7442                	ld	s0,48(sp)
     250:	74a2                	ld	s1,40(sp)
     252:	7902                	ld	s2,32(sp)
     254:	69e2                	ld	s3,24(sp)
     256:	6a42                	ld	s4,16(sp)
     258:	6aa2                	ld	s5,8(sp)
     25a:	6b02                	ld	s6,0(sp)
     25c:	6121                	addi	sp,sp,64
     25e:	8082                	ret

0000000000000260 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     260:	7179                	addi	sp,sp,-48
     262:	f406                	sd	ra,40(sp)
     264:	f022                	sd	s0,32(sp)
     266:	ec26                	sd	s1,24(sp)
     268:	e84a                	sd	s2,16(sp)
     26a:	e44e                	sd	s3,8(sp)
     26c:	1800                	addi	s0,sp,48
     26e:	89aa                	mv	s3,a0
     270:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     272:	4561                	li	a0,24
     274:	76f000ef          	jal	11e2 <malloc>
     278:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     27a:	4661                	li	a2,24
     27c:	4581                	li	a1,0
     27e:	7c0000ef          	jal	a3e <memset>
  cmd->type = PIPE;
     282:	478d                	li	a5,3
     284:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     286:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     28a:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     28e:	8526                	mv	a0,s1
     290:	70a2                	ld	ra,40(sp)
     292:	7402                	ld	s0,32(sp)
     294:	64e2                	ld	s1,24(sp)
     296:	6942                	ld	s2,16(sp)
     298:	69a2                	ld	s3,8(sp)
     29a:	6145                	addi	sp,sp,48
     29c:	8082                	ret

000000000000029e <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     29e:	7179                	addi	sp,sp,-48
     2a0:	f406                	sd	ra,40(sp)
     2a2:	f022                	sd	s0,32(sp)
     2a4:	ec26                	sd	s1,24(sp)
     2a6:	e84a                	sd	s2,16(sp)
     2a8:	e44e                	sd	s3,8(sp)
     2aa:	1800                	addi	s0,sp,48
     2ac:	89aa                	mv	s3,a0
     2ae:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b0:	4561                	li	a0,24
     2b2:	731000ef          	jal	11e2 <malloc>
     2b6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2b8:	4661                	li	a2,24
     2ba:	4581                	li	a1,0
     2bc:	782000ef          	jal	a3e <memset>
  cmd->type = LIST;
     2c0:	4791                	li	a5,4
     2c2:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2c4:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     2c8:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     2cc:	8526                	mv	a0,s1
     2ce:	70a2                	ld	ra,40(sp)
     2d0:	7402                	ld	s0,32(sp)
     2d2:	64e2                	ld	s1,24(sp)
     2d4:	6942                	ld	s2,16(sp)
     2d6:	69a2                	ld	s3,8(sp)
     2d8:	6145                	addi	sp,sp,48
     2da:	8082                	ret

00000000000002dc <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     2dc:	1101                	addi	sp,sp,-32
     2de:	ec06                	sd	ra,24(sp)
     2e0:	e822                	sd	s0,16(sp)
     2e2:	e426                	sd	s1,8(sp)
     2e4:	e04a                	sd	s2,0(sp)
     2e6:	1000                	addi	s0,sp,32
     2e8:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ea:	4541                	li	a0,16
     2ec:	6f7000ef          	jal	11e2 <malloc>
     2f0:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2f2:	4641                	li	a2,16
     2f4:	4581                	li	a1,0
     2f6:	748000ef          	jal	a3e <memset>
  cmd->type = BACK;
     2fa:	4795                	li	a5,5
     2fc:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2fe:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     302:	8526                	mv	a0,s1
     304:	60e2                	ld	ra,24(sp)
     306:	6442                	ld	s0,16(sp)
     308:	64a2                	ld	s1,8(sp)
     30a:	6902                	ld	s2,0(sp)
     30c:	6105                	addi	sp,sp,32
     30e:	8082                	ret

0000000000000310 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     310:	7139                	addi	sp,sp,-64
     312:	fc06                	sd	ra,56(sp)
     314:	f822                	sd	s0,48(sp)
     316:	f426                	sd	s1,40(sp)
     318:	f04a                	sd	s2,32(sp)
     31a:	ec4e                	sd	s3,24(sp)
     31c:	e852                	sd	s4,16(sp)
     31e:	e456                	sd	s5,8(sp)
     320:	e05a                	sd	s6,0(sp)
     322:	0080                	addi	s0,sp,64
     324:	8a2a                	mv	s4,a0
     326:	892e                	mv	s2,a1
     328:	8ab2                	mv	s5,a2
     32a:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     32c:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     32e:	00002997          	auipc	s3,0x2
     332:	cda98993          	addi	s3,s3,-806 # 2008 <whitespace>
     336:	00b4fc63          	bgeu	s1,a1,34e <gettoken+0x3e>
     33a:	0004c583          	lbu	a1,0(s1)
     33e:	854e                	mv	a0,s3
     340:	724000ef          	jal	a64 <strchr>
     344:	c509                	beqz	a0,34e <gettoken+0x3e>
    s++;
     346:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     348:	fe9919e3          	bne	s2,s1,33a <gettoken+0x2a>
     34c:	84ca                	mv	s1,s2
  if(q)
     34e:	000a8463          	beqz	s5,356 <gettoken+0x46>
    *q = s;
     352:	009ab023          	sd	s1,0(s5)
  ret = *s;
     356:	0004c783          	lbu	a5,0(s1)
     35a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     35e:	03c00713          	li	a4,60
     362:	06f76463          	bltu	a4,a5,3ca <gettoken+0xba>
     366:	03a00713          	li	a4,58
     36a:	00f76e63          	bltu	a4,a5,386 <gettoken+0x76>
     36e:	cf89                	beqz	a5,388 <gettoken+0x78>
     370:	02600713          	li	a4,38
     374:	00e78963          	beq	a5,a4,386 <gettoken+0x76>
     378:	fd87879b          	addiw	a5,a5,-40
     37c:	0ff7f793          	zext.b	a5,a5
     380:	4705                	li	a4,1
     382:	06f76b63          	bltu	a4,a5,3f8 <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     386:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     388:	000b0463          	beqz	s6,390 <gettoken+0x80>
    *eq = s;
     38c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     390:	00002997          	auipc	s3,0x2
     394:	c7898993          	addi	s3,s3,-904 # 2008 <whitespace>
     398:	0124fc63          	bgeu	s1,s2,3b0 <gettoken+0xa0>
     39c:	0004c583          	lbu	a1,0(s1)
     3a0:	854e                	mv	a0,s3
     3a2:	6c2000ef          	jal	a64 <strchr>
     3a6:	c509                	beqz	a0,3b0 <gettoken+0xa0>
    s++;
     3a8:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3aa:	fe9919e3          	bne	s2,s1,39c <gettoken+0x8c>
     3ae:	84ca                	mv	s1,s2
  *ps = s;
     3b0:	009a3023          	sd	s1,0(s4)
  return ret;
}
     3b4:	8556                	mv	a0,s5
     3b6:	70e2                	ld	ra,56(sp)
     3b8:	7442                	ld	s0,48(sp)
     3ba:	74a2                	ld	s1,40(sp)
     3bc:	7902                	ld	s2,32(sp)
     3be:	69e2                	ld	s3,24(sp)
     3c0:	6a42                	ld	s4,16(sp)
     3c2:	6aa2                	ld	s5,8(sp)
     3c4:	6b02                	ld	s6,0(sp)
     3c6:	6121                	addi	sp,sp,64
     3c8:	8082                	ret
  switch(*s){
     3ca:	03e00713          	li	a4,62
     3ce:	02e79163          	bne	a5,a4,3f0 <gettoken+0xe0>
    s++;
     3d2:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     3d6:	0014c703          	lbu	a4,1(s1)
     3da:	03e00793          	li	a5,62
      s++;
     3de:	0489                	addi	s1,s1,2
      ret = '+';
     3e0:	02b00a93          	li	s5,43
    if(*s == '>'){
     3e4:	faf702e3          	beq	a4,a5,388 <gettoken+0x78>
    s++;
     3e8:	84b6                	mv	s1,a3
  ret = *s;
     3ea:	03e00a93          	li	s5,62
     3ee:	bf69                	j	388 <gettoken+0x78>
  switch(*s){
     3f0:	07c00713          	li	a4,124
     3f4:	f8e789e3          	beq	a5,a4,386 <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3f8:	00002997          	auipc	s3,0x2
     3fc:	c1098993          	addi	s3,s3,-1008 # 2008 <whitespace>
     400:	00002a97          	auipc	s5,0x2
     404:	c00a8a93          	addi	s5,s5,-1024 # 2000 <symbols>
     408:	0324fd63          	bgeu	s1,s2,442 <gettoken+0x132>
     40c:	0004c583          	lbu	a1,0(s1)
     410:	854e                	mv	a0,s3
     412:	652000ef          	jal	a64 <strchr>
     416:	e11d                	bnez	a0,43c <gettoken+0x12c>
     418:	0004c583          	lbu	a1,0(s1)
     41c:	8556                	mv	a0,s5
     41e:	646000ef          	jal	a64 <strchr>
     422:	e911                	bnez	a0,436 <gettoken+0x126>
      s++;
     424:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     426:	fe9913e3          	bne	s2,s1,40c <gettoken+0xfc>
  if(eq)
     42a:	84ca                	mv	s1,s2
    ret = 'a';
     42c:	06100a93          	li	s5,97
  if(eq)
     430:	f40b1ee3          	bnez	s6,38c <gettoken+0x7c>
     434:	bfb5                	j	3b0 <gettoken+0xa0>
    ret = 'a';
     436:	06100a93          	li	s5,97
     43a:	b7b9                	j	388 <gettoken+0x78>
     43c:	06100a93          	li	s5,97
     440:	b7a1                	j	388 <gettoken+0x78>
     442:	06100a93          	li	s5,97
  if(eq)
     446:	f40b13e3          	bnez	s6,38c <gettoken+0x7c>
     44a:	b79d                	j	3b0 <gettoken+0xa0>

000000000000044c <peek>:

int
peek(char **ps, char *es, char *toks)
{
     44c:	7139                	addi	sp,sp,-64
     44e:	fc06                	sd	ra,56(sp)
     450:	f822                	sd	s0,48(sp)
     452:	f426                	sd	s1,40(sp)
     454:	f04a                	sd	s2,32(sp)
     456:	ec4e                	sd	s3,24(sp)
     458:	e852                	sd	s4,16(sp)
     45a:	e456                	sd	s5,8(sp)
     45c:	0080                	addi	s0,sp,64
     45e:	8a2a                	mv	s4,a0
     460:	892e                	mv	s2,a1
     462:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     464:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     466:	00002997          	auipc	s3,0x2
     46a:	ba298993          	addi	s3,s3,-1118 # 2008 <whitespace>
     46e:	00b4fc63          	bgeu	s1,a1,486 <peek+0x3a>
     472:	0004c583          	lbu	a1,0(s1)
     476:	854e                	mv	a0,s3
     478:	5ec000ef          	jal	a64 <strchr>
     47c:	c509                	beqz	a0,486 <peek+0x3a>
    s++;
     47e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     480:	fe9919e3          	bne	s2,s1,472 <peek+0x26>
     484:	84ca                	mv	s1,s2
  *ps = s;
     486:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     48a:	0004c583          	lbu	a1,0(s1)
     48e:	4501                	li	a0,0
     490:	e991                	bnez	a1,4a4 <peek+0x58>
}
     492:	70e2                	ld	ra,56(sp)
     494:	7442                	ld	s0,48(sp)
     496:	74a2                	ld	s1,40(sp)
     498:	7902                	ld	s2,32(sp)
     49a:	69e2                	ld	s3,24(sp)
     49c:	6a42                	ld	s4,16(sp)
     49e:	6aa2                	ld	s5,8(sp)
     4a0:	6121                	addi	sp,sp,64
     4a2:	8082                	ret
  return *s && strchr(toks, *s);
     4a4:	8556                	mv	a0,s5
     4a6:	5be000ef          	jal	a64 <strchr>
     4aa:	00a03533          	snez	a0,a0
     4ae:	b7d5                	j	492 <peek+0x46>

00000000000004b0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4b0:	7159                	addi	sp,sp,-112
     4b2:	f486                	sd	ra,104(sp)
     4b4:	f0a2                	sd	s0,96(sp)
     4b6:	eca6                	sd	s1,88(sp)
     4b8:	e8ca                	sd	s2,80(sp)
     4ba:	e4ce                	sd	s3,72(sp)
     4bc:	e0d2                	sd	s4,64(sp)
     4be:	fc56                	sd	s5,56(sp)
     4c0:	f85a                	sd	s6,48(sp)
     4c2:	f45e                	sd	s7,40(sp)
     4c4:	f062                	sd	s8,32(sp)
     4c6:	ec66                	sd	s9,24(sp)
     4c8:	1880                	addi	s0,sp,112
     4ca:	8a2a                	mv	s4,a0
     4cc:	89ae                	mv	s3,a1
     4ce:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     4d0:	00001b17          	auipc	s6,0x1
     4d4:	e80b0b13          	addi	s6,s6,-384 # 1350 <malloc+0x16e>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     4d8:	f9040c93          	addi	s9,s0,-112
     4dc:	f9840c13          	addi	s8,s0,-104
     4e0:	06100b93          	li	s7,97
  while(peek(ps, es, "<>")){
     4e4:	a00d                	j	506 <parseredirs+0x56>
      panic("missing file for redirection");
     4e6:	00001517          	auipc	a0,0x1
     4ea:	e4a50513          	addi	a0,a0,-438 # 1330 <malloc+0x14e>
     4ee:	b5dff0ef          	jal	4a <panic>
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     4f2:	4701                	li	a4,0
     4f4:	4681                	li	a3,0
     4f6:	f9043603          	ld	a2,-112(s0)
     4fa:	f9843583          	ld	a1,-104(s0)
     4fe:	8552                	mv	a0,s4
     500:	d01ff0ef          	jal	200 <redircmd>
     504:	8a2a                	mv	s4,a0
    switch(tok){
     506:	03c00a93          	li	s5,60
  while(peek(ps, es, "<>")){
     50a:	865a                	mv	a2,s6
     50c:	85ca                	mv	a1,s2
     50e:	854e                	mv	a0,s3
     510:	f3dff0ef          	jal	44c <peek>
     514:	c135                	beqz	a0,578 <parseredirs+0xc8>
    tok = gettoken(ps, es, 0, 0);
     516:	4681                	li	a3,0
     518:	4601                	li	a2,0
     51a:	85ca                	mv	a1,s2
     51c:	854e                	mv	a0,s3
     51e:	df3ff0ef          	jal	310 <gettoken>
     522:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     524:	86e6                	mv	a3,s9
     526:	8662                	mv	a2,s8
     528:	85ca                	mv	a1,s2
     52a:	854e                	mv	a0,s3
     52c:	de5ff0ef          	jal	310 <gettoken>
     530:	fb751be3          	bne	a0,s7,4e6 <parseredirs+0x36>
    switch(tok){
     534:	fb548fe3          	beq	s1,s5,4f2 <parseredirs+0x42>
     538:	03e00793          	li	a5,62
     53c:	02f48263          	beq	s1,a5,560 <parseredirs+0xb0>
     540:	02b00793          	li	a5,43
     544:	fcf493e3          	bne	s1,a5,50a <parseredirs+0x5a>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     548:	4705                	li	a4,1
     54a:	20100693          	li	a3,513
     54e:	f9043603          	ld	a2,-112(s0)
     552:	f9843583          	ld	a1,-104(s0)
     556:	8552                	mv	a0,s4
     558:	ca9ff0ef          	jal	200 <redircmd>
     55c:	8a2a                	mv	s4,a0
      break;
     55e:	b765                	j	506 <parseredirs+0x56>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     560:	4705                	li	a4,1
     562:	60100693          	li	a3,1537
     566:	f9043603          	ld	a2,-112(s0)
     56a:	f9843583          	ld	a1,-104(s0)
     56e:	8552                	mv	a0,s4
     570:	c91ff0ef          	jal	200 <redircmd>
     574:	8a2a                	mv	s4,a0
      break;
     576:	bf41                	j	506 <parseredirs+0x56>
    }
  }
  return cmd;
}
     578:	8552                	mv	a0,s4
     57a:	70a6                	ld	ra,104(sp)
     57c:	7406                	ld	s0,96(sp)
     57e:	64e6                	ld	s1,88(sp)
     580:	6946                	ld	s2,80(sp)
     582:	69a6                	ld	s3,72(sp)
     584:	6a06                	ld	s4,64(sp)
     586:	7ae2                	ld	s5,56(sp)
     588:	7b42                	ld	s6,48(sp)
     58a:	7ba2                	ld	s7,40(sp)
     58c:	7c02                	ld	s8,32(sp)
     58e:	6ce2                	ld	s9,24(sp)
     590:	6165                	addi	sp,sp,112
     592:	8082                	ret

0000000000000594 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     594:	7119                	addi	sp,sp,-128
     596:	fc86                	sd	ra,120(sp)
     598:	f8a2                	sd	s0,112(sp)
     59a:	f4a6                	sd	s1,104(sp)
     59c:	e8d2                	sd	s4,80(sp)
     59e:	e4d6                	sd	s5,72(sp)
     5a0:	0100                	addi	s0,sp,128
     5a2:	8a2a                	mv	s4,a0
     5a4:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     5a6:	00001617          	auipc	a2,0x1
     5aa:	db260613          	addi	a2,a2,-590 # 1358 <malloc+0x176>
     5ae:	e9fff0ef          	jal	44c <peek>
     5b2:	e121                	bnez	a0,5f2 <parseexec+0x5e>
     5b4:	f0ca                	sd	s2,96(sp)
     5b6:	ecce                	sd	s3,88(sp)
     5b8:	e0da                	sd	s6,64(sp)
     5ba:	fc5e                	sd	s7,56(sp)
     5bc:	f862                	sd	s8,48(sp)
     5be:	f466                	sd	s9,40(sp)
     5c0:	f06a                	sd	s10,32(sp)
     5c2:	ec6e                	sd	s11,24(sp)
     5c4:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     5c6:	c0dff0ef          	jal	1d2 <execcmd>
     5ca:	8daa                	mv	s11,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     5cc:	8656                	mv	a2,s5
     5ce:	85d2                	mv	a1,s4
     5d0:	ee1ff0ef          	jal	4b0 <parseredirs>
     5d4:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     5d6:	008d8913          	addi	s2,s11,8
     5da:	00001b17          	auipc	s6,0x1
     5de:	d9eb0b13          	addi	s6,s6,-610 # 1378 <malloc+0x196>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     5e2:	f8040c13          	addi	s8,s0,-128
     5e6:	f8840b93          	addi	s7,s0,-120
      break;
    if(tok != 'a')
     5ea:	06100d13          	li	s10,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     5ee:	4ca9                	li	s9,10
  while(!peek(ps, es, "|)&;")){
     5f0:	a815                	j	624 <parseexec+0x90>
    return parseblock(ps, es);
     5f2:	85d6                	mv	a1,s5
     5f4:	8552                	mv	a0,s4
     5f6:	170000ef          	jal	766 <parseblock>
     5fa:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     5fc:	8526                	mv	a0,s1
     5fe:	70e6                	ld	ra,120(sp)
     600:	7446                	ld	s0,112(sp)
     602:	74a6                	ld	s1,104(sp)
     604:	6a46                	ld	s4,80(sp)
     606:	6aa6                	ld	s5,72(sp)
     608:	6109                	addi	sp,sp,128
     60a:	8082                	ret
      panic("syntax");
     60c:	00001517          	auipc	a0,0x1
     610:	d5450513          	addi	a0,a0,-684 # 1360 <malloc+0x17e>
     614:	a37ff0ef          	jal	4a <panic>
    ret = parseredirs(ret, ps, es);
     618:	8656                	mv	a2,s5
     61a:	85d2                	mv	a1,s4
     61c:	8526                	mv	a0,s1
     61e:	e93ff0ef          	jal	4b0 <parseredirs>
     622:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     624:	865a                	mv	a2,s6
     626:	85d6                	mv	a1,s5
     628:	8552                	mv	a0,s4
     62a:	e23ff0ef          	jal	44c <peek>
     62e:	ed05                	bnez	a0,666 <parseexec+0xd2>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     630:	86e2                	mv	a3,s8
     632:	865e                	mv	a2,s7
     634:	85d6                	mv	a1,s5
     636:	8552                	mv	a0,s4
     638:	cd9ff0ef          	jal	310 <gettoken>
     63c:	c50d                	beqz	a0,666 <parseexec+0xd2>
    if(tok != 'a')
     63e:	fda517e3          	bne	a0,s10,60c <parseexec+0x78>
    cmd->argv[argc] = q;
     642:	f8843783          	ld	a5,-120(s0)
     646:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     64a:	f8043783          	ld	a5,-128(s0)
     64e:	04f93823          	sd	a5,80(s2)
    argc++;
     652:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     654:	0921                	addi	s2,s2,8
     656:	fd9991e3          	bne	s3,s9,618 <parseexec+0x84>
      panic("too many args");
     65a:	00001517          	auipc	a0,0x1
     65e:	d0e50513          	addi	a0,a0,-754 # 1368 <malloc+0x186>
     662:	9e9ff0ef          	jal	4a <panic>
  cmd->argv[argc] = 0;
     666:	098e                	slli	s3,s3,0x3
     668:	9dce                	add	s11,s11,s3
     66a:	000db423          	sd	zero,8(s11)
  cmd->eargv[argc] = 0;
     66e:	040dbc23          	sd	zero,88(s11)
     672:	7906                	ld	s2,96(sp)
     674:	69e6                	ld	s3,88(sp)
     676:	6b06                	ld	s6,64(sp)
     678:	7be2                	ld	s7,56(sp)
     67a:	7c42                	ld	s8,48(sp)
     67c:	7ca2                	ld	s9,40(sp)
     67e:	7d02                	ld	s10,32(sp)
     680:	6de2                	ld	s11,24(sp)
  return ret;
     682:	bfad                	j	5fc <parseexec+0x68>

0000000000000684 <parsepipe>:
{
     684:	7179                	addi	sp,sp,-48
     686:	f406                	sd	ra,40(sp)
     688:	f022                	sd	s0,32(sp)
     68a:	ec26                	sd	s1,24(sp)
     68c:	e84a                	sd	s2,16(sp)
     68e:	e44e                	sd	s3,8(sp)
     690:	1800                	addi	s0,sp,48
     692:	892a                	mv	s2,a0
     694:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     696:	effff0ef          	jal	594 <parseexec>
     69a:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     69c:	00001617          	auipc	a2,0x1
     6a0:	ce460613          	addi	a2,a2,-796 # 1380 <malloc+0x19e>
     6a4:	85ce                	mv	a1,s3
     6a6:	854a                	mv	a0,s2
     6a8:	da5ff0ef          	jal	44c <peek>
     6ac:	e909                	bnez	a0,6be <parsepipe+0x3a>
}
     6ae:	8526                	mv	a0,s1
     6b0:	70a2                	ld	ra,40(sp)
     6b2:	7402                	ld	s0,32(sp)
     6b4:	64e2                	ld	s1,24(sp)
     6b6:	6942                	ld	s2,16(sp)
     6b8:	69a2                	ld	s3,8(sp)
     6ba:	6145                	addi	sp,sp,48
     6bc:	8082                	ret
    gettoken(ps, es, 0, 0);
     6be:	4681                	li	a3,0
     6c0:	4601                	li	a2,0
     6c2:	85ce                	mv	a1,s3
     6c4:	854a                	mv	a0,s2
     6c6:	c4bff0ef          	jal	310 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6ca:	85ce                	mv	a1,s3
     6cc:	854a                	mv	a0,s2
     6ce:	fb7ff0ef          	jal	684 <parsepipe>
     6d2:	85aa                	mv	a1,a0
     6d4:	8526                	mv	a0,s1
     6d6:	b8bff0ef          	jal	260 <pipecmd>
     6da:	84aa                	mv	s1,a0
  return cmd;
     6dc:	bfc9                	j	6ae <parsepipe+0x2a>

00000000000006de <parseline>:
{
     6de:	7179                	addi	sp,sp,-48
     6e0:	f406                	sd	ra,40(sp)
     6e2:	f022                	sd	s0,32(sp)
     6e4:	ec26                	sd	s1,24(sp)
     6e6:	e84a                	sd	s2,16(sp)
     6e8:	e44e                	sd	s3,8(sp)
     6ea:	e052                	sd	s4,0(sp)
     6ec:	1800                	addi	s0,sp,48
     6ee:	892a                	mv	s2,a0
     6f0:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     6f2:	f93ff0ef          	jal	684 <parsepipe>
     6f6:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     6f8:	00001a17          	auipc	s4,0x1
     6fc:	c90a0a13          	addi	s4,s4,-880 # 1388 <malloc+0x1a6>
     700:	a819                	j	716 <parseline+0x38>
    gettoken(ps, es, 0, 0);
     702:	4681                	li	a3,0
     704:	4601                	li	a2,0
     706:	85ce                	mv	a1,s3
     708:	854a                	mv	a0,s2
     70a:	c07ff0ef          	jal	310 <gettoken>
    cmd = backcmd(cmd);
     70e:	8526                	mv	a0,s1
     710:	bcdff0ef          	jal	2dc <backcmd>
     714:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     716:	8652                	mv	a2,s4
     718:	85ce                	mv	a1,s3
     71a:	854a                	mv	a0,s2
     71c:	d31ff0ef          	jal	44c <peek>
     720:	f16d                	bnez	a0,702 <parseline+0x24>
  if(peek(ps, es, ";")){
     722:	00001617          	auipc	a2,0x1
     726:	c6e60613          	addi	a2,a2,-914 # 1390 <malloc+0x1ae>
     72a:	85ce                	mv	a1,s3
     72c:	854a                	mv	a0,s2
     72e:	d1fff0ef          	jal	44c <peek>
     732:	e911                	bnez	a0,746 <parseline+0x68>
}
     734:	8526                	mv	a0,s1
     736:	70a2                	ld	ra,40(sp)
     738:	7402                	ld	s0,32(sp)
     73a:	64e2                	ld	s1,24(sp)
     73c:	6942                	ld	s2,16(sp)
     73e:	69a2                	ld	s3,8(sp)
     740:	6a02                	ld	s4,0(sp)
     742:	6145                	addi	sp,sp,48
     744:	8082                	ret
    gettoken(ps, es, 0, 0);
     746:	4681                	li	a3,0
     748:	4601                	li	a2,0
     74a:	85ce                	mv	a1,s3
     74c:	854a                	mv	a0,s2
     74e:	bc3ff0ef          	jal	310 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     752:	85ce                	mv	a1,s3
     754:	854a                	mv	a0,s2
     756:	f89ff0ef          	jal	6de <parseline>
     75a:	85aa                	mv	a1,a0
     75c:	8526                	mv	a0,s1
     75e:	b41ff0ef          	jal	29e <listcmd>
     762:	84aa                	mv	s1,a0
  return cmd;
     764:	bfc1                	j	734 <parseline+0x56>

0000000000000766 <parseblock>:
{
     766:	7179                	addi	sp,sp,-48
     768:	f406                	sd	ra,40(sp)
     76a:	f022                	sd	s0,32(sp)
     76c:	ec26                	sd	s1,24(sp)
     76e:	e84a                	sd	s2,16(sp)
     770:	e44e                	sd	s3,8(sp)
     772:	1800                	addi	s0,sp,48
     774:	84aa                	mv	s1,a0
     776:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     778:	00001617          	auipc	a2,0x1
     77c:	be060613          	addi	a2,a2,-1056 # 1358 <malloc+0x176>
     780:	ccdff0ef          	jal	44c <peek>
     784:	c539                	beqz	a0,7d2 <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     786:	4681                	li	a3,0
     788:	4601                	li	a2,0
     78a:	85ca                	mv	a1,s2
     78c:	8526                	mv	a0,s1
     78e:	b83ff0ef          	jal	310 <gettoken>
  cmd = parseline(ps, es);
     792:	85ca                	mv	a1,s2
     794:	8526                	mv	a0,s1
     796:	f49ff0ef          	jal	6de <parseline>
     79a:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     79c:	00001617          	auipc	a2,0x1
     7a0:	c0c60613          	addi	a2,a2,-1012 # 13a8 <malloc+0x1c6>
     7a4:	85ca                	mv	a1,s2
     7a6:	8526                	mv	a0,s1
     7a8:	ca5ff0ef          	jal	44c <peek>
     7ac:	c90d                	beqz	a0,7de <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     7ae:	4681                	li	a3,0
     7b0:	4601                	li	a2,0
     7b2:	85ca                	mv	a1,s2
     7b4:	8526                	mv	a0,s1
     7b6:	b5bff0ef          	jal	310 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     7ba:	864a                	mv	a2,s2
     7bc:	85a6                	mv	a1,s1
     7be:	854e                	mv	a0,s3
     7c0:	cf1ff0ef          	jal	4b0 <parseredirs>
}
     7c4:	70a2                	ld	ra,40(sp)
     7c6:	7402                	ld	s0,32(sp)
     7c8:	64e2                	ld	s1,24(sp)
     7ca:	6942                	ld	s2,16(sp)
     7cc:	69a2                	ld	s3,8(sp)
     7ce:	6145                	addi	sp,sp,48
     7d0:	8082                	ret
    panic("parseblock");
     7d2:	00001517          	auipc	a0,0x1
     7d6:	bc650513          	addi	a0,a0,-1082 # 1398 <malloc+0x1b6>
     7da:	871ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     7de:	00001517          	auipc	a0,0x1
     7e2:	bd250513          	addi	a0,a0,-1070 # 13b0 <malloc+0x1ce>
     7e6:	865ff0ef          	jal	4a <panic>

00000000000007ea <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     7ea:	1101                	addi	sp,sp,-32
     7ec:	ec06                	sd	ra,24(sp)
     7ee:	e822                	sd	s0,16(sp)
     7f0:	e426                	sd	s1,8(sp)
     7f2:	1000                	addi	s0,sp,32
     7f4:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     7f6:	c131                	beqz	a0,83a <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     7f8:	4118                	lw	a4,0(a0)
     7fa:	4795                	li	a5,5
     7fc:	02e7ef63          	bltu	a5,a4,83a <nulterminate+0x50>
     800:	00056783          	lwu	a5,0(a0)
     804:	078a                	slli	a5,a5,0x2
     806:	00001717          	auipc	a4,0x1
     80a:	c0a70713          	addi	a4,a4,-1014 # 1410 <malloc+0x22e>
     80e:	97ba                	add	a5,a5,a4
     810:	439c                	lw	a5,0(a5)
     812:	97ba                	add	a5,a5,a4
     814:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     816:	651c                	ld	a5,8(a0)
     818:	c38d                	beqz	a5,83a <nulterminate+0x50>
     81a:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     81e:	67b8                	ld	a4,72(a5)
     820:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     824:	07a1                	addi	a5,a5,8
     826:	ff87b703          	ld	a4,-8(a5)
     82a:	fb75                	bnez	a4,81e <nulterminate+0x34>
     82c:	a039                	j	83a <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     82e:	6508                	ld	a0,8(a0)
     830:	fbbff0ef          	jal	7ea <nulterminate>
    *rcmd->efile = 0;
     834:	6c9c                	ld	a5,24(s1)
     836:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     83a:	8526                	mv	a0,s1
     83c:	60e2                	ld	ra,24(sp)
     83e:	6442                	ld	s0,16(sp)
     840:	64a2                	ld	s1,8(sp)
     842:	6105                	addi	sp,sp,32
     844:	8082                	ret
    nulterminate(pcmd->left);
     846:	6508                	ld	a0,8(a0)
     848:	fa3ff0ef          	jal	7ea <nulterminate>
    nulterminate(pcmd->right);
     84c:	6888                	ld	a0,16(s1)
     84e:	f9dff0ef          	jal	7ea <nulterminate>
    break;
     852:	b7e5                	j	83a <nulterminate+0x50>
    nulterminate(lcmd->left);
     854:	6508                	ld	a0,8(a0)
     856:	f95ff0ef          	jal	7ea <nulterminate>
    nulterminate(lcmd->right);
     85a:	6888                	ld	a0,16(s1)
     85c:	f8fff0ef          	jal	7ea <nulterminate>
    break;
     860:	bfe9                	j	83a <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     862:	6508                	ld	a0,8(a0)
     864:	f87ff0ef          	jal	7ea <nulterminate>
    break;
     868:	bfc9                	j	83a <nulterminate+0x50>

000000000000086a <parsecmd>:
{
     86a:	7139                	addi	sp,sp,-64
     86c:	fc06                	sd	ra,56(sp)
     86e:	f822                	sd	s0,48(sp)
     870:	f426                	sd	s1,40(sp)
     872:	f04a                	sd	s2,32(sp)
     874:	ec4e                	sd	s3,24(sp)
     876:	0080                	addi	s0,sp,64
     878:	fca43423          	sd	a0,-56(s0)
  es = s + strlen(s);
     87c:	84aa                	mv	s1,a0
     87e:	192000ef          	jal	a10 <strlen>
     882:	1502                	slli	a0,a0,0x20
     884:	9101                	srli	a0,a0,0x20
     886:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     888:	fc840993          	addi	s3,s0,-56
     88c:	85a6                	mv	a1,s1
     88e:	854e                	mv	a0,s3
     890:	e4fff0ef          	jal	6de <parseline>
     894:	892a                	mv	s2,a0
  peek(&s, es, "");
     896:	00001617          	auipc	a2,0x1
     89a:	a5260613          	addi	a2,a2,-1454 # 12e8 <malloc+0x106>
     89e:	85a6                	mv	a1,s1
     8a0:	854e                	mv	a0,s3
     8a2:	babff0ef          	jal	44c <peek>
  if(s != es){
     8a6:	fc843603          	ld	a2,-56(s0)
     8aa:	00961d63          	bne	a2,s1,8c4 <parsecmd+0x5a>
  nulterminate(cmd);
     8ae:	854a                	mv	a0,s2
     8b0:	f3bff0ef          	jal	7ea <nulterminate>
}
     8b4:	854a                	mv	a0,s2
     8b6:	70e2                	ld	ra,56(sp)
     8b8:	7442                	ld	s0,48(sp)
     8ba:	74a2                	ld	s1,40(sp)
     8bc:	7902                	ld	s2,32(sp)
     8be:	69e2                	ld	s3,24(sp)
     8c0:	6121                	addi	sp,sp,64
     8c2:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     8c4:	00001597          	auipc	a1,0x1
     8c8:	b0458593          	addi	a1,a1,-1276 # 13c8 <malloc+0x1e6>
     8cc:	4509                	li	a0,2
     8ce:	033000ef          	jal	1100 <fprintf>
    panic("syntax");
     8d2:	00001517          	auipc	a0,0x1
     8d6:	a8e50513          	addi	a0,a0,-1394 # 1360 <malloc+0x17e>
     8da:	f70ff0ef          	jal	4a <panic>

00000000000008de <main>:
{
     8de:	7139                	addi	sp,sp,-64
     8e0:	fc06                	sd	ra,56(sp)
     8e2:	f822                	sd	s0,48(sp)
     8e4:	f426                	sd	s1,40(sp)
     8e6:	f04a                	sd	s2,32(sp)
     8e8:	ec4e                	sd	s3,24(sp)
     8ea:	e852                	sd	s4,16(sp)
     8ec:	e456                	sd	s5,8(sp)
     8ee:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     8f0:	4489                	li	s1,2
     8f2:	00001917          	auipc	s2,0x1
     8f6:	ae690913          	addi	s2,s2,-1306 # 13d8 <malloc+0x1f6>
     8fa:	85a6                	mv	a1,s1
     8fc:	854a                	mv	a0,s2
     8fe:	462000ef          	jal	d60 <open>
     902:	00054663          	bltz	a0,90e <main+0x30>
    if(fd >= 3){
     906:	fea4dae3          	bge	s1,a0,8fa <main+0x1c>
      close(fd);
     90a:	43e000ef          	jal	d48 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     90e:	00001497          	auipc	s1,0x1
     912:	71248493          	addi	s1,s1,1810 # 2020 <buf.0>
     916:	06400913          	li	s2,100
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     91a:	06300993          	li	s3,99
     91e:	02000a13          	li	s4,32
     922:	a039                	j	930 <main+0x52>
    if(fork1() == 0)
     924:	f44ff0ef          	jal	68 <fork1>
     928:	c925                	beqz	a0,998 <main+0xba>
    wait(0);
     92a:	4501                	li	a0,0
     92c:	3fc000ef          	jal	d28 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     930:	85ca                	mv	a1,s2
     932:	8526                	mv	a0,s1
     934:	eccff0ef          	jal	0 <getcmd>
     938:	06054863          	bltz	a0,9a8 <main+0xca>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     93c:	0004c783          	lbu	a5,0(s1)
     940:	ff3792e3          	bne	a5,s3,924 <main+0x46>
     944:	0014c783          	lbu	a5,1(s1)
     948:	fd279ee3          	bne	a5,s2,924 <main+0x46>
     94c:	0024c783          	lbu	a5,2(s1)
     950:	fd479ae3          	bne	a5,s4,924 <main+0x46>
      buf[strlen(buf)-1] = 0;  // chop \n
     954:	00001a97          	auipc	s5,0x1
     958:	6cca8a93          	addi	s5,s5,1740 # 2020 <buf.0>
     95c:	8556                	mv	a0,s5
     95e:	0b2000ef          	jal	a10 <strlen>
     962:	fff5079b          	addiw	a5,a0,-1
     966:	1782                	slli	a5,a5,0x20
     968:	9381                	srli	a5,a5,0x20
     96a:	9abe                	add	s5,s5,a5
     96c:	000a8023          	sb	zero,0(s5)
      if(chdir(buf+3) < 0)
     970:	00001517          	auipc	a0,0x1
     974:	6b350513          	addi	a0,a0,1715 # 2023 <buf.0+0x3>
     978:	418000ef          	jal	d90 <chdir>
     97c:	fa055ae3          	bgez	a0,930 <main+0x52>
        fprintf(2, "cannot cd %s\n", buf+3);
     980:	00001617          	auipc	a2,0x1
     984:	6a360613          	addi	a2,a2,1699 # 2023 <buf.0+0x3>
     988:	00001597          	auipc	a1,0x1
     98c:	a5858593          	addi	a1,a1,-1448 # 13e0 <malloc+0x1fe>
     990:	4509                	li	a0,2
     992:	76e000ef          	jal	1100 <fprintf>
     996:	bf69                	j	930 <main+0x52>
      runcmd(parsecmd(buf));
     998:	00001517          	auipc	a0,0x1
     99c:	68850513          	addi	a0,a0,1672 # 2020 <buf.0>
     9a0:	ecbff0ef          	jal	86a <parsecmd>
     9a4:	eeaff0ef          	jal	8e <runcmd>
  exit(0);
     9a8:	4501                	li	a0,0
     9aa:	376000ef          	jal	d20 <exit>

00000000000009ae <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
     9ae:	1141                	addi	sp,sp,-16
     9b0:	e406                	sd	ra,8(sp)
     9b2:	e022                	sd	s0,0(sp)
     9b4:	0800                	addi	s0,sp,16
  extern int main();
  main();
     9b6:	f29ff0ef          	jal	8de <main>
  exit(0);
     9ba:	4501                	li	a0,0
     9bc:	364000ef          	jal	d20 <exit>

00000000000009c0 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     9c0:	1141                	addi	sp,sp,-16
     9c2:	e406                	sd	ra,8(sp)
     9c4:	e022                	sd	s0,0(sp)
     9c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
     9c8:	87aa                	mv	a5,a0
     9ca:	0585                	addi	a1,a1,1
     9cc:	0785                	addi	a5,a5,1
     9ce:	fff5c703          	lbu	a4,-1(a1)
     9d2:	fee78fa3          	sb	a4,-1(a5)
     9d6:	fb75                	bnez	a4,9ca <strcpy+0xa>
    ;
  return os;
}
     9d8:	60a2                	ld	ra,8(sp)
     9da:	6402                	ld	s0,0(sp)
     9dc:	0141                	addi	sp,sp,16
     9de:	8082                	ret

00000000000009e0 <strcmp>:

int strcmp(const char *p, const char *q)
{
     9e0:	1141                	addi	sp,sp,-16
     9e2:	e406                	sd	ra,8(sp)
     9e4:	e022                	sd	s0,0(sp)
     9e6:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
     9e8:	00054783          	lbu	a5,0(a0)
     9ec:	cb91                	beqz	a5,a00 <strcmp+0x20>
     9ee:	0005c703          	lbu	a4,0(a1)
     9f2:	00f71763          	bne	a4,a5,a00 <strcmp+0x20>
    p++, q++;
     9f6:	0505                	addi	a0,a0,1
     9f8:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
     9fa:	00054783          	lbu	a5,0(a0)
     9fe:	fbe5                	bnez	a5,9ee <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     a00:	0005c503          	lbu	a0,0(a1)
}
     a04:	40a7853b          	subw	a0,a5,a0
     a08:	60a2                	ld	ra,8(sp)
     a0a:	6402                	ld	s0,0(sp)
     a0c:	0141                	addi	sp,sp,16
     a0e:	8082                	ret

0000000000000a10 <strlen>:

uint strlen(const char *s)
{
     a10:	1141                	addi	sp,sp,-16
     a12:	e406                	sd	ra,8(sp)
     a14:	e022                	sd	s0,0(sp)
     a16:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
     a18:	00054783          	lbu	a5,0(a0)
     a1c:	cf99                	beqz	a5,a3a <strlen+0x2a>
     a1e:	0505                	addi	a0,a0,1
     a20:	87aa                	mv	a5,a0
     a22:	86be                	mv	a3,a5
     a24:	0785                	addi	a5,a5,1
     a26:	fff7c703          	lbu	a4,-1(a5)
     a2a:	ff65                	bnez	a4,a22 <strlen+0x12>
     a2c:	40a6853b          	subw	a0,a3,a0
     a30:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     a32:	60a2                	ld	ra,8(sp)
     a34:	6402                	ld	s0,0(sp)
     a36:	0141                	addi	sp,sp,16
     a38:	8082                	ret
  for (n = 0; s[n]; n++)
     a3a:	4501                	li	a0,0
     a3c:	bfdd                	j	a32 <strlen+0x22>

0000000000000a3e <memset>:

void *
memset(void *dst, int c, uint n)
{
     a3e:	1141                	addi	sp,sp,-16
     a40:	e406                	sd	ra,8(sp)
     a42:	e022                	sd	s0,0(sp)
     a44:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
     a46:	ca19                	beqz	a2,a5c <memset+0x1e>
     a48:	87aa                	mv	a5,a0
     a4a:	1602                	slli	a2,a2,0x20
     a4c:	9201                	srli	a2,a2,0x20
     a4e:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
     a52:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
     a56:	0785                	addi	a5,a5,1
     a58:	fee79de3          	bne	a5,a4,a52 <memset+0x14>
  }
  return dst;
}
     a5c:	60a2                	ld	ra,8(sp)
     a5e:	6402                	ld	s0,0(sp)
     a60:	0141                	addi	sp,sp,16
     a62:	8082                	ret

0000000000000a64 <strchr>:

char *
strchr(const char *s, char c)
{
     a64:	1141                	addi	sp,sp,-16
     a66:	e406                	sd	ra,8(sp)
     a68:	e022                	sd	s0,0(sp)
     a6a:	0800                	addi	s0,sp,16
  for (; *s; s++)
     a6c:	00054783          	lbu	a5,0(a0)
     a70:	cf81                	beqz	a5,a88 <strchr+0x24>
    if (*s == c)
     a72:	00f58763          	beq	a1,a5,a80 <strchr+0x1c>
  for (; *s; s++)
     a76:	0505                	addi	a0,a0,1
     a78:	00054783          	lbu	a5,0(a0)
     a7c:	fbfd                	bnez	a5,a72 <strchr+0xe>
      return (char *)s;
  return 0;
     a7e:	4501                	li	a0,0
}
     a80:	60a2                	ld	ra,8(sp)
     a82:	6402                	ld	s0,0(sp)
     a84:	0141                	addi	sp,sp,16
     a86:	8082                	ret
  return 0;
     a88:	4501                	li	a0,0
     a8a:	bfdd                	j	a80 <strchr+0x1c>

0000000000000a8c <gets>:

char *
gets(char *buf, int max)
{
     a8c:	7159                	addi	sp,sp,-112
     a8e:	f486                	sd	ra,104(sp)
     a90:	f0a2                	sd	s0,96(sp)
     a92:	eca6                	sd	s1,88(sp)
     a94:	e8ca                	sd	s2,80(sp)
     a96:	e4ce                	sd	s3,72(sp)
     a98:	e0d2                	sd	s4,64(sp)
     a9a:	fc56                	sd	s5,56(sp)
     a9c:	f85a                	sd	s6,48(sp)
     a9e:	f45e                	sd	s7,40(sp)
     aa0:	f062                	sd	s8,32(sp)
     aa2:	ec66                	sd	s9,24(sp)
     aa4:	e86a                	sd	s10,16(sp)
     aa6:	1880                	addi	s0,sp,112
     aa8:	8caa                	mv	s9,a0
     aaa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
     aac:	892a                	mv	s2,a0
     aae:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
     ab0:	f9f40b13          	addi	s6,s0,-97
     ab4:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
     ab6:	4ba9                	li	s7,10
     ab8:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
     aba:	8d26                	mv	s10,s1
     abc:	0014899b          	addiw	s3,s1,1
     ac0:	84ce                	mv	s1,s3
     ac2:	0349d563          	bge	s3,s4,aec <gets+0x60>
    cc = read(0, &c, 1);
     ac6:	8656                	mv	a2,s5
     ac8:	85da                	mv	a1,s6
     aca:	4501                	li	a0,0
     acc:	26c000ef          	jal	d38 <read>
    if (cc < 1)
     ad0:	00a05e63          	blez	a0,aec <gets+0x60>
    buf[i++] = c;
     ad4:	f9f44783          	lbu	a5,-97(s0)
     ad8:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
     adc:	01778763          	beq	a5,s7,aea <gets+0x5e>
     ae0:	0905                	addi	s2,s2,1
     ae2:	fd879ce3          	bne	a5,s8,aba <gets+0x2e>
    buf[i++] = c;
     ae6:	8d4e                	mv	s10,s3
     ae8:	a011                	j	aec <gets+0x60>
     aea:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
     aec:	9d66                	add	s10,s10,s9
     aee:	000d0023          	sb	zero,0(s10)
  return buf;
}
     af2:	8566                	mv	a0,s9
     af4:	70a6                	ld	ra,104(sp)
     af6:	7406                	ld	s0,96(sp)
     af8:	64e6                	ld	s1,88(sp)
     afa:	6946                	ld	s2,80(sp)
     afc:	69a6                	ld	s3,72(sp)
     afe:	6a06                	ld	s4,64(sp)
     b00:	7ae2                	ld	s5,56(sp)
     b02:	7b42                	ld	s6,48(sp)
     b04:	7ba2                	ld	s7,40(sp)
     b06:	7c02                	ld	s8,32(sp)
     b08:	6ce2                	ld	s9,24(sp)
     b0a:	6d42                	ld	s10,16(sp)
     b0c:	6165                	addi	sp,sp,112
     b0e:	8082                	ret

0000000000000b10 <stat>:

int stat(const char *n, struct stat *st)
{
     b10:	1101                	addi	sp,sp,-32
     b12:	ec06                	sd	ra,24(sp)
     b14:	e822                	sd	s0,16(sp)
     b16:	e04a                	sd	s2,0(sp)
     b18:	1000                	addi	s0,sp,32
     b1a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b1c:	4581                	li	a1,0
     b1e:	242000ef          	jal	d60 <open>
  if (fd < 0)
     b22:	02054263          	bltz	a0,b46 <stat+0x36>
     b26:	e426                	sd	s1,8(sp)
     b28:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b2a:	85ca                	mv	a1,s2
     b2c:	24c000ef          	jal	d78 <fstat>
     b30:	892a                	mv	s2,a0
  close(fd);
     b32:	8526                	mv	a0,s1
     b34:	214000ef          	jal	d48 <close>
  return r;
     b38:	64a2                	ld	s1,8(sp)
}
     b3a:	854a                	mv	a0,s2
     b3c:	60e2                	ld	ra,24(sp)
     b3e:	6442                	ld	s0,16(sp)
     b40:	6902                	ld	s2,0(sp)
     b42:	6105                	addi	sp,sp,32
     b44:	8082                	ret
    return -1;
     b46:	597d                	li	s2,-1
     b48:	bfcd                	j	b3a <stat+0x2a>

0000000000000b4a <atoi>:

int atoi(const char *s)
{
     b4a:	1141                	addi	sp,sp,-16
     b4c:	e406                	sd	ra,8(sp)
     b4e:	e022                	sd	s0,0(sp)
     b50:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
     b52:	00054683          	lbu	a3,0(a0)
     b56:	fd06879b          	addiw	a5,a3,-48
     b5a:	0ff7f793          	zext.b	a5,a5
     b5e:	4625                	li	a2,9
     b60:	02f66963          	bltu	a2,a5,b92 <atoi+0x48>
     b64:	872a                	mv	a4,a0
  n = 0;
     b66:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
     b68:	0705                	addi	a4,a4,1
     b6a:	0025179b          	slliw	a5,a0,0x2
     b6e:	9fa9                	addw	a5,a5,a0
     b70:	0017979b          	slliw	a5,a5,0x1
     b74:	9fb5                	addw	a5,a5,a3
     b76:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
     b7a:	00074683          	lbu	a3,0(a4)
     b7e:	fd06879b          	addiw	a5,a3,-48
     b82:	0ff7f793          	zext.b	a5,a5
     b86:	fef671e3          	bgeu	a2,a5,b68 <atoi+0x1e>
  return n;
}
     b8a:	60a2                	ld	ra,8(sp)
     b8c:	6402                	ld	s0,0(sp)
     b8e:	0141                	addi	sp,sp,16
     b90:	8082                	ret
  n = 0;
     b92:	4501                	li	a0,0
     b94:	bfdd                	j	b8a <atoi+0x40>

0000000000000b96 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     b96:	1141                	addi	sp,sp,-16
     b98:	e406                	sd	ra,8(sp)
     b9a:	e022                	sd	s0,0(sp)
     b9c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
     b9e:	02b57563          	bgeu	a0,a1,bc8 <memmove+0x32>
  {
    while (n-- > 0)
     ba2:	00c05f63          	blez	a2,bc0 <memmove+0x2a>
     ba6:	1602                	slli	a2,a2,0x20
     ba8:	9201                	srli	a2,a2,0x20
     baa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     bae:	872a                	mv	a4,a0
      *dst++ = *src++;
     bb0:	0585                	addi	a1,a1,1
     bb2:	0705                	addi	a4,a4,1
     bb4:	fff5c683          	lbu	a3,-1(a1)
     bb8:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
     bbc:	fee79ae3          	bne	a5,a4,bb0 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     bc0:	60a2                	ld	ra,8(sp)
     bc2:	6402                	ld	s0,0(sp)
     bc4:	0141                	addi	sp,sp,16
     bc6:	8082                	ret
    dst += n;
     bc8:	00c50733          	add	a4,a0,a2
    src += n;
     bcc:	95b2                	add	a1,a1,a2
    while (n-- > 0)
     bce:	fec059e3          	blez	a2,bc0 <memmove+0x2a>
     bd2:	fff6079b          	addiw	a5,a2,-1
     bd6:	1782                	slli	a5,a5,0x20
     bd8:	9381                	srli	a5,a5,0x20
     bda:	fff7c793          	not	a5,a5
     bde:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     be0:	15fd                	addi	a1,a1,-1
     be2:	177d                	addi	a4,a4,-1
     be4:	0005c683          	lbu	a3,0(a1)
     be8:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
     bec:	fef71ae3          	bne	a4,a5,be0 <memmove+0x4a>
     bf0:	bfc1                	j	bc0 <memmove+0x2a>

0000000000000bf2 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
     bf2:	1141                	addi	sp,sp,-16
     bf4:	e406                	sd	ra,8(sp)
     bf6:	e022                	sd	s0,0(sp)
     bf8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
     bfa:	ca0d                	beqz	a2,c2c <memcmp+0x3a>
     bfc:	fff6069b          	addiw	a3,a2,-1
     c00:	1682                	slli	a3,a3,0x20
     c02:	9281                	srli	a3,a3,0x20
     c04:	0685                	addi	a3,a3,1
     c06:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
     c08:	00054783          	lbu	a5,0(a0)
     c0c:	0005c703          	lbu	a4,0(a1)
     c10:	00e79863          	bne	a5,a4,c20 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
     c14:	0505                	addi	a0,a0,1
    p2++;
     c16:	0585                	addi	a1,a1,1
  while (n-- > 0)
     c18:	fed518e3          	bne	a0,a3,c08 <memcmp+0x16>
  }
  return 0;
     c1c:	4501                	li	a0,0
     c1e:	a019                	j	c24 <memcmp+0x32>
      return *p1 - *p2;
     c20:	40e7853b          	subw	a0,a5,a4
}
     c24:	60a2                	ld	ra,8(sp)
     c26:	6402                	ld	s0,0(sp)
     c28:	0141                	addi	sp,sp,16
     c2a:	8082                	ret
  return 0;
     c2c:	4501                	li	a0,0
     c2e:	bfdd                	j	c24 <memcmp+0x32>

0000000000000c30 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c30:	1141                	addi	sp,sp,-16
     c32:	e406                	sd	ra,8(sp)
     c34:	e022                	sd	s0,0(sp)
     c36:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c38:	f5fff0ef          	jal	b96 <memmove>
}
     c3c:	60a2                	ld	ra,8(sp)
     c3e:	6402                	ld	s0,0(sp)
     c40:	0141                	addi	sp,sp,16
     c42:	8082                	ret

0000000000000c44 <strcat>:

char *strcat(char *dst, const char *src)
{
     c44:	1141                	addi	sp,sp,-16
     c46:	e406                	sd	ra,8(sp)
     c48:	e022                	sd	s0,0(sp)
     c4a:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
     c4c:	00054783          	lbu	a5,0(a0)
     c50:	c795                	beqz	a5,c7c <strcat+0x38>
  char *p = dst;
     c52:	87aa                	mv	a5,a0
    p++;
     c54:	0785                	addi	a5,a5,1
  while (*p)
     c56:	0007c703          	lbu	a4,0(a5)
     c5a:	ff6d                	bnez	a4,c54 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
     c5c:	0005c703          	lbu	a4,0(a1)
     c60:	cb01                	beqz	a4,c70 <strcat+0x2c>
  {
    *p = *src;
     c62:	00e78023          	sb	a4,0(a5)
    p++;
     c66:	0785                	addi	a5,a5,1
    src++;
     c68:	0585                	addi	a1,a1,1
  while (*src)
     c6a:	0005c703          	lbu	a4,0(a1)
     c6e:	fb75                	bnez	a4,c62 <strcat+0x1e>
  }

  *p = 0;
     c70:	00078023          	sb	zero,0(a5)

  return dst;
}
     c74:	60a2                	ld	ra,8(sp)
     c76:	6402                	ld	s0,0(sp)
     c78:	0141                	addi	sp,sp,16
     c7a:	8082                	ret
  char *p = dst;
     c7c:	87aa                	mv	a5,a0
     c7e:	bff9                	j	c5c <strcat+0x18>

0000000000000c80 <isdir>:

int isdir(char *path)
{
     c80:	7179                	addi	sp,sp,-48
     c82:	f406                	sd	ra,40(sp)
     c84:	f022                	sd	s0,32(sp)
     c86:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
     c88:	fd840593          	addi	a1,s0,-40
     c8c:	e85ff0ef          	jal	b10 <stat>
     c90:	00054b63          	bltz	a0,ca6 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
     c94:	fe041503          	lh	a0,-32(s0)
     c98:	157d                	addi	a0,a0,-1
     c9a:	00153513          	seqz	a0,a0
}
     c9e:	70a2                	ld	ra,40(sp)
     ca0:	7402                	ld	s0,32(sp)
     ca2:	6145                	addi	sp,sp,48
     ca4:	8082                	ret
    return 0;
     ca6:	4501                	li	a0,0
     ca8:	bfdd                	j	c9e <isdir+0x1e>

0000000000000caa <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
     caa:	7139                	addi	sp,sp,-64
     cac:	fc06                	sd	ra,56(sp)
     cae:	f822                	sd	s0,48(sp)
     cb0:	f426                	sd	s1,40(sp)
     cb2:	f04a                	sd	s2,32(sp)
     cb4:	ec4e                	sd	s3,24(sp)
     cb6:	e852                	sd	s4,16(sp)
     cb8:	e456                	sd	s5,8(sp)
     cba:	0080                	addi	s0,sp,64
     cbc:	89aa                	mv	s3,a0
     cbe:	8aae                	mv	s5,a1
     cc0:	84b2                	mv	s1,a2
     cc2:	8a36                	mv	s4,a3
  int dn = strlen(dir);
     cc4:	d4dff0ef          	jal	a10 <strlen>
     cc8:	892a                	mv	s2,a0
  int nn = strlen(filename);
     cca:	8556                	mv	a0,s5
     ccc:	d45ff0ef          	jal	a10 <strlen>
  int need = dn + 1 + nn + 1;
     cd0:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
     cd4:	9fa9                	addw	a5,a5,a0
    return 0;
     cd6:	4501                	li	a0,0
  if (need > bufsize)
     cd8:	0347d763          	bge	a5,s4,d06 <joinpath+0x5c>
  strcpy(out_buffer, dir);
     cdc:	85ce                	mv	a1,s3
     cde:	8526                	mv	a0,s1
     ce0:	ce1ff0ef          	jal	9c0 <strcpy>
  if (dir[dn - 1] != '/')
     ce4:	99ca                	add	s3,s3,s2
     ce6:	fff9c703          	lbu	a4,-1(s3)
     cea:	02f00793          	li	a5,47
     cee:	00f70763          	beq	a4,a5,cfc <joinpath+0x52>
  {
    out_buffer[dn] = '/';
     cf2:	9926                	add	s2,s2,s1
     cf4:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
     cf8:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
     cfc:	85d6                	mv	a1,s5
     cfe:	8526                	mv	a0,s1
     d00:	f45ff0ef          	jal	c44 <strcat>
  return out_buffer;
     d04:	8526                	mv	a0,s1
}
     d06:	70e2                	ld	ra,56(sp)
     d08:	7442                	ld	s0,48(sp)
     d0a:	74a2                	ld	s1,40(sp)
     d0c:	7902                	ld	s2,32(sp)
     d0e:	69e2                	ld	s3,24(sp)
     d10:	6a42                	ld	s4,16(sp)
     d12:	6aa2                	ld	s5,8(sp)
     d14:	6121                	addi	sp,sp,64
     d16:	8082                	ret

0000000000000d18 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     d18:	4885                	li	a7,1
 ecall
     d1a:	00000073          	ecall
 ret
     d1e:	8082                	ret

0000000000000d20 <exit>:
.global exit
exit:
 li a7, SYS_exit
     d20:	4889                	li	a7,2
 ecall
     d22:	00000073          	ecall
 ret
     d26:	8082                	ret

0000000000000d28 <wait>:
.global wait
wait:
 li a7, SYS_wait
     d28:	488d                	li	a7,3
 ecall
     d2a:	00000073          	ecall
 ret
     d2e:	8082                	ret

0000000000000d30 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d30:	4891                	li	a7,4
 ecall
     d32:	00000073          	ecall
 ret
     d36:	8082                	ret

0000000000000d38 <read>:
.global read
read:
 li a7, SYS_read
     d38:	4895                	li	a7,5
 ecall
     d3a:	00000073          	ecall
 ret
     d3e:	8082                	ret

0000000000000d40 <write>:
.global write
write:
 li a7, SYS_write
     d40:	48c1                	li	a7,16
 ecall
     d42:	00000073          	ecall
 ret
     d46:	8082                	ret

0000000000000d48 <close>:
.global close
close:
 li a7, SYS_close
     d48:	48d5                	li	a7,21
 ecall
     d4a:	00000073          	ecall
 ret
     d4e:	8082                	ret

0000000000000d50 <kill>:
.global kill
kill:
 li a7, SYS_kill
     d50:	4899                	li	a7,6
 ecall
     d52:	00000073          	ecall
 ret
     d56:	8082                	ret

0000000000000d58 <exec>:
.global exec
exec:
 li a7, SYS_exec
     d58:	489d                	li	a7,7
 ecall
     d5a:	00000073          	ecall
 ret
     d5e:	8082                	ret

0000000000000d60 <open>:
.global open
open:
 li a7, SYS_open
     d60:	48bd                	li	a7,15
 ecall
     d62:	00000073          	ecall
 ret
     d66:	8082                	ret

0000000000000d68 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     d68:	48c5                	li	a7,17
 ecall
     d6a:	00000073          	ecall
 ret
     d6e:	8082                	ret

0000000000000d70 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     d70:	48c9                	li	a7,18
 ecall
     d72:	00000073          	ecall
 ret
     d76:	8082                	ret

0000000000000d78 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     d78:	48a1                	li	a7,8
 ecall
     d7a:	00000073          	ecall
 ret
     d7e:	8082                	ret

0000000000000d80 <link>:
.global link
link:
 li a7, SYS_link
     d80:	48cd                	li	a7,19
 ecall
     d82:	00000073          	ecall
 ret
     d86:	8082                	ret

0000000000000d88 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     d88:	48d1                	li	a7,20
 ecall
     d8a:	00000073          	ecall
 ret
     d8e:	8082                	ret

0000000000000d90 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d90:	48a5                	li	a7,9
 ecall
     d92:	00000073          	ecall
 ret
     d96:	8082                	ret

0000000000000d98 <dup>:
.global dup
dup:
 li a7, SYS_dup
     d98:	48a9                	li	a7,10
 ecall
     d9a:	00000073          	ecall
 ret
     d9e:	8082                	ret

0000000000000da0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     da0:	48ad                	li	a7,11
 ecall
     da2:	00000073          	ecall
 ret
     da6:	8082                	ret

0000000000000da8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     da8:	48b1                	li	a7,12
 ecall
     daa:	00000073          	ecall
 ret
     dae:	8082                	ret

0000000000000db0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     db0:	48b5                	li	a7,13
 ecall
     db2:	00000073          	ecall
 ret
     db6:	8082                	ret

0000000000000db8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     db8:	48b9                	li	a7,14
 ecall
     dba:	00000073          	ecall
 ret
     dbe:	8082                	ret

0000000000000dc0 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
     dc0:	48d9                	li	a7,22
 ecall
     dc2:	00000073          	ecall
 ret
     dc6:	8082                	ret

0000000000000dc8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     dc8:	1101                	addi	sp,sp,-32
     dca:	ec06                	sd	ra,24(sp)
     dcc:	e822                	sd	s0,16(sp)
     dce:	1000                	addi	s0,sp,32
     dd0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     dd4:	4605                	li	a2,1
     dd6:	fef40593          	addi	a1,s0,-17
     dda:	f67ff0ef          	jal	d40 <write>
}
     dde:	60e2                	ld	ra,24(sp)
     de0:	6442                	ld	s0,16(sp)
     de2:	6105                	addi	sp,sp,32
     de4:	8082                	ret

0000000000000de6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     de6:	7139                	addi	sp,sp,-64
     de8:	fc06                	sd	ra,56(sp)
     dea:	f822                	sd	s0,48(sp)
     dec:	f426                	sd	s1,40(sp)
     dee:	f04a                	sd	s2,32(sp)
     df0:	ec4e                	sd	s3,24(sp)
     df2:	0080                	addi	s0,sp,64
     df4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     df6:	c299                	beqz	a3,dfc <printint+0x16>
     df8:	0605ce63          	bltz	a1,e74 <printint+0x8e>
  neg = 0;
     dfc:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     dfe:	fc040313          	addi	t1,s0,-64
  neg = 0;
     e02:	869a                	mv	a3,t1
  i = 0;
     e04:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     e06:	00000817          	auipc	a6,0x0
     e0a:	62280813          	addi	a6,a6,1570 # 1428 <digits>
     e0e:	88be                	mv	a7,a5
     e10:	0017851b          	addiw	a0,a5,1
     e14:	87aa                	mv	a5,a0
     e16:	02c5f73b          	remuw	a4,a1,a2
     e1a:	1702                	slli	a4,a4,0x20
     e1c:	9301                	srli	a4,a4,0x20
     e1e:	9742                	add	a4,a4,a6
     e20:	00074703          	lbu	a4,0(a4)
     e24:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     e28:	872e                	mv	a4,a1
     e2a:	02c5d5bb          	divuw	a1,a1,a2
     e2e:	0685                	addi	a3,a3,1
     e30:	fcc77fe3          	bgeu	a4,a2,e0e <printint+0x28>
  if(neg)
     e34:	000e0c63          	beqz	t3,e4c <printint+0x66>
    buf[i++] = '-';
     e38:	fd050793          	addi	a5,a0,-48
     e3c:	00878533          	add	a0,a5,s0
     e40:	02d00793          	li	a5,45
     e44:	fef50823          	sb	a5,-16(a0)
     e48:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
     e4c:	fff7899b          	addiw	s3,a5,-1
     e50:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
     e54:	fff4c583          	lbu	a1,-1(s1)
     e58:	854a                	mv	a0,s2
     e5a:	f6fff0ef          	jal	dc8 <putc>
  while(--i >= 0)
     e5e:	39fd                	addiw	s3,s3,-1
     e60:	14fd                	addi	s1,s1,-1
     e62:	fe09d9e3          	bgez	s3,e54 <printint+0x6e>
}
     e66:	70e2                	ld	ra,56(sp)
     e68:	7442                	ld	s0,48(sp)
     e6a:	74a2                	ld	s1,40(sp)
     e6c:	7902                	ld	s2,32(sp)
     e6e:	69e2                	ld	s3,24(sp)
     e70:	6121                	addi	sp,sp,64
     e72:	8082                	ret
    x = -xx;
     e74:	40b005bb          	negw	a1,a1
    neg = 1;
     e78:	4e05                	li	t3,1
    x = -xx;
     e7a:	b751                	j	dfe <printint+0x18>

0000000000000e7c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e7c:	711d                	addi	sp,sp,-96
     e7e:	ec86                	sd	ra,88(sp)
     e80:	e8a2                	sd	s0,80(sp)
     e82:	e4a6                	sd	s1,72(sp)
     e84:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     e86:	0005c483          	lbu	s1,0(a1)
     e8a:	26048663          	beqz	s1,10f6 <vprintf+0x27a>
     e8e:	e0ca                	sd	s2,64(sp)
     e90:	fc4e                	sd	s3,56(sp)
     e92:	f852                	sd	s4,48(sp)
     e94:	f456                	sd	s5,40(sp)
     e96:	f05a                	sd	s6,32(sp)
     e98:	ec5e                	sd	s7,24(sp)
     e9a:	e862                	sd	s8,16(sp)
     e9c:	e466                	sd	s9,8(sp)
     e9e:	8b2a                	mv	s6,a0
     ea0:	8a2e                	mv	s4,a1
     ea2:	8bb2                	mv	s7,a2
  state = 0;
     ea4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     ea6:	4901                	li	s2,0
     ea8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     eaa:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     eae:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     eb2:	06c00c93          	li	s9,108
     eb6:	a00d                	j	ed8 <vprintf+0x5c>
        putc(fd, c0);
     eb8:	85a6                	mv	a1,s1
     eba:	855a                	mv	a0,s6
     ebc:	f0dff0ef          	jal	dc8 <putc>
     ec0:	a019                	j	ec6 <vprintf+0x4a>
    } else if(state == '%'){
     ec2:	03598363          	beq	s3,s5,ee8 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
     ec6:	0019079b          	addiw	a5,s2,1
     eca:	893e                	mv	s2,a5
     ecc:	873e                	mv	a4,a5
     ece:	97d2                	add	a5,a5,s4
     ed0:	0007c483          	lbu	s1,0(a5)
     ed4:	20048963          	beqz	s1,10e6 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
     ed8:	0004879b          	sext.w	a5,s1
    if(state == 0){
     edc:	fe0993e3          	bnez	s3,ec2 <vprintf+0x46>
      if(c0 == '%'){
     ee0:	fd579ce3          	bne	a5,s5,eb8 <vprintf+0x3c>
        state = '%';
     ee4:	89be                	mv	s3,a5
     ee6:	b7c5                	j	ec6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     ee8:	00ea06b3          	add	a3,s4,a4
     eec:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     ef0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     ef2:	c681                	beqz	a3,efa <vprintf+0x7e>
     ef4:	9752                	add	a4,a4,s4
     ef6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     efa:	03878e63          	beq	a5,s8,f36 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     efe:	05978863          	beq	a5,s9,f4e <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     f02:	07500713          	li	a4,117
     f06:	0ee78263          	beq	a5,a4,fea <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     f0a:	07800713          	li	a4,120
     f0e:	12e78463          	beq	a5,a4,1036 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     f12:	07000713          	li	a4,112
     f16:	14e78963          	beq	a5,a4,1068 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     f1a:	07300713          	li	a4,115
     f1e:	18e78863          	beq	a5,a4,10ae <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     f22:	02500713          	li	a4,37
     f26:	04e79463          	bne	a5,a4,f6e <vprintf+0xf2>
        putc(fd, '%');
     f2a:	85ba                	mv	a1,a4
     f2c:	855a                	mv	a0,s6
     f2e:	e9bff0ef          	jal	dc8 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     f32:	4981                	li	s3,0
     f34:	bf49                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     f36:	008b8493          	addi	s1,s7,8
     f3a:	4685                	li	a3,1
     f3c:	4629                	li	a2,10
     f3e:	000ba583          	lw	a1,0(s7)
     f42:	855a                	mv	a0,s6
     f44:	ea3ff0ef          	jal	de6 <printint>
     f48:	8ba6                	mv	s7,s1
      state = 0;
     f4a:	4981                	li	s3,0
     f4c:	bfad                	j	ec6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     f4e:	06400793          	li	a5,100
     f52:	02f68963          	beq	a3,a5,f84 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f56:	06c00793          	li	a5,108
     f5a:	04f68263          	beq	a3,a5,f9e <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     f5e:	07500793          	li	a5,117
     f62:	0af68063          	beq	a3,a5,1002 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     f66:	07800793          	li	a5,120
     f6a:	0ef68263          	beq	a3,a5,104e <vprintf+0x1d2>
        putc(fd, '%');
     f6e:	02500593          	li	a1,37
     f72:	855a                	mv	a0,s6
     f74:	e55ff0ef          	jal	dc8 <putc>
        putc(fd, c0);
     f78:	85a6                	mv	a1,s1
     f7a:	855a                	mv	a0,s6
     f7c:	e4dff0ef          	jal	dc8 <putc>
      state = 0;
     f80:	4981                	li	s3,0
     f82:	b791                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f84:	008b8493          	addi	s1,s7,8
     f88:	4685                	li	a3,1
     f8a:	4629                	li	a2,10
     f8c:	000ba583          	lw	a1,0(s7)
     f90:	855a                	mv	a0,s6
     f92:	e55ff0ef          	jal	de6 <printint>
        i += 1;
     f96:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     f98:	8ba6                	mv	s7,s1
      state = 0;
     f9a:	4981                	li	s3,0
        i += 1;
     f9c:	b72d                	j	ec6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f9e:	06400793          	li	a5,100
     fa2:	02f60763          	beq	a2,a5,fd0 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     fa6:	07500793          	li	a5,117
     faa:	06f60963          	beq	a2,a5,101c <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     fae:	07800793          	li	a5,120
     fb2:	faf61ee3          	bne	a2,a5,f6e <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     fb6:	008b8493          	addi	s1,s7,8
     fba:	4681                	li	a3,0
     fbc:	4641                	li	a2,16
     fbe:	000ba583          	lw	a1,0(s7)
     fc2:	855a                	mv	a0,s6
     fc4:	e23ff0ef          	jal	de6 <printint>
        i += 2;
     fc8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     fca:	8ba6                	mv	s7,s1
      state = 0;
     fcc:	4981                	li	s3,0
        i += 2;
     fce:	bde5                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     fd0:	008b8493          	addi	s1,s7,8
     fd4:	4685                	li	a3,1
     fd6:	4629                	li	a2,10
     fd8:	000ba583          	lw	a1,0(s7)
     fdc:	855a                	mv	a0,s6
     fde:	e09ff0ef          	jal	de6 <printint>
        i += 2;
     fe2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     fe4:	8ba6                	mv	s7,s1
      state = 0;
     fe6:	4981                	li	s3,0
        i += 2;
     fe8:	bdf9                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     fea:	008b8493          	addi	s1,s7,8
     fee:	4681                	li	a3,0
     ff0:	4629                	li	a2,10
     ff2:	000ba583          	lw	a1,0(s7)
     ff6:	855a                	mv	a0,s6
     ff8:	defff0ef          	jal	de6 <printint>
     ffc:	8ba6                	mv	s7,s1
      state = 0;
     ffe:	4981                	li	s3,0
    1000:	b5d9                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1002:	008b8493          	addi	s1,s7,8
    1006:	4681                	li	a3,0
    1008:	4629                	li	a2,10
    100a:	000ba583          	lw	a1,0(s7)
    100e:	855a                	mv	a0,s6
    1010:	dd7ff0ef          	jal	de6 <printint>
        i += 1;
    1014:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    1016:	8ba6                	mv	s7,s1
      state = 0;
    1018:	4981                	li	s3,0
        i += 1;
    101a:	b575                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    101c:	008b8493          	addi	s1,s7,8
    1020:	4681                	li	a3,0
    1022:	4629                	li	a2,10
    1024:	000ba583          	lw	a1,0(s7)
    1028:	855a                	mv	a0,s6
    102a:	dbdff0ef          	jal	de6 <printint>
        i += 2;
    102e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1030:	8ba6                	mv	s7,s1
      state = 0;
    1032:	4981                	li	s3,0
        i += 2;
    1034:	bd49                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    1036:	008b8493          	addi	s1,s7,8
    103a:	4681                	li	a3,0
    103c:	4641                	li	a2,16
    103e:	000ba583          	lw	a1,0(s7)
    1042:	855a                	mv	a0,s6
    1044:	da3ff0ef          	jal	de6 <printint>
    1048:	8ba6                	mv	s7,s1
      state = 0;
    104a:	4981                	li	s3,0
    104c:	bdad                	j	ec6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    104e:	008b8493          	addi	s1,s7,8
    1052:	4681                	li	a3,0
    1054:	4641                	li	a2,16
    1056:	000ba583          	lw	a1,0(s7)
    105a:	855a                	mv	a0,s6
    105c:	d8bff0ef          	jal	de6 <printint>
        i += 1;
    1060:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    1062:	8ba6                	mv	s7,s1
      state = 0;
    1064:	4981                	li	s3,0
        i += 1;
    1066:	b585                	j	ec6 <vprintf+0x4a>
    1068:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    106a:	008b8d13          	addi	s10,s7,8
    106e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1072:	03000593          	li	a1,48
    1076:	855a                	mv	a0,s6
    1078:	d51ff0ef          	jal	dc8 <putc>
  putc(fd, 'x');
    107c:	07800593          	li	a1,120
    1080:	855a                	mv	a0,s6
    1082:	d47ff0ef          	jal	dc8 <putc>
    1086:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1088:	00000b97          	auipc	s7,0x0
    108c:	3a0b8b93          	addi	s7,s7,928 # 1428 <digits>
    1090:	03c9d793          	srli	a5,s3,0x3c
    1094:	97de                	add	a5,a5,s7
    1096:	0007c583          	lbu	a1,0(a5)
    109a:	855a                	mv	a0,s6
    109c:	d2dff0ef          	jal	dc8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10a0:	0992                	slli	s3,s3,0x4
    10a2:	34fd                	addiw	s1,s1,-1
    10a4:	f4f5                	bnez	s1,1090 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    10a6:	8bea                	mv	s7,s10
      state = 0;
    10a8:	4981                	li	s3,0
    10aa:	6d02                	ld	s10,0(sp)
    10ac:	bd29                	j	ec6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    10ae:	008b8993          	addi	s3,s7,8
    10b2:	000bb483          	ld	s1,0(s7)
    10b6:	cc91                	beqz	s1,10d2 <vprintf+0x256>
        for(; *s; s++)
    10b8:	0004c583          	lbu	a1,0(s1)
    10bc:	c195                	beqz	a1,10e0 <vprintf+0x264>
          putc(fd, *s);
    10be:	855a                	mv	a0,s6
    10c0:	d09ff0ef          	jal	dc8 <putc>
        for(; *s; s++)
    10c4:	0485                	addi	s1,s1,1
    10c6:	0004c583          	lbu	a1,0(s1)
    10ca:	f9f5                	bnez	a1,10be <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
    10cc:	8bce                	mv	s7,s3
      state = 0;
    10ce:	4981                	li	s3,0
    10d0:	bbdd                	j	ec6 <vprintf+0x4a>
          s = "(null)";
    10d2:	00000497          	auipc	s1,0x0
    10d6:	31e48493          	addi	s1,s1,798 # 13f0 <malloc+0x20e>
        for(; *s; s++)
    10da:	02800593          	li	a1,40
    10de:	b7c5                	j	10be <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
    10e0:	8bce                	mv	s7,s3
      state = 0;
    10e2:	4981                	li	s3,0
    10e4:	b3cd                	j	ec6 <vprintf+0x4a>
    10e6:	6906                	ld	s2,64(sp)
    10e8:	79e2                	ld	s3,56(sp)
    10ea:	7a42                	ld	s4,48(sp)
    10ec:	7aa2                	ld	s5,40(sp)
    10ee:	7b02                	ld	s6,32(sp)
    10f0:	6be2                	ld	s7,24(sp)
    10f2:	6c42                	ld	s8,16(sp)
    10f4:	6ca2                	ld	s9,8(sp)
    }
  }
}
    10f6:	60e6                	ld	ra,88(sp)
    10f8:	6446                	ld	s0,80(sp)
    10fa:	64a6                	ld	s1,72(sp)
    10fc:	6125                	addi	sp,sp,96
    10fe:	8082                	ret

0000000000001100 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1100:	715d                	addi	sp,sp,-80
    1102:	ec06                	sd	ra,24(sp)
    1104:	e822                	sd	s0,16(sp)
    1106:	1000                	addi	s0,sp,32
    1108:	e010                	sd	a2,0(s0)
    110a:	e414                	sd	a3,8(s0)
    110c:	e818                	sd	a4,16(s0)
    110e:	ec1c                	sd	a5,24(s0)
    1110:	03043023          	sd	a6,32(s0)
    1114:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1118:	8622                	mv	a2,s0
    111a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    111e:	d5fff0ef          	jal	e7c <vprintf>
}
    1122:	60e2                	ld	ra,24(sp)
    1124:	6442                	ld	s0,16(sp)
    1126:	6161                	addi	sp,sp,80
    1128:	8082                	ret

000000000000112a <printf>:

void
printf(const char *fmt, ...)
{
    112a:	711d                	addi	sp,sp,-96
    112c:	ec06                	sd	ra,24(sp)
    112e:	e822                	sd	s0,16(sp)
    1130:	1000                	addi	s0,sp,32
    1132:	e40c                	sd	a1,8(s0)
    1134:	e810                	sd	a2,16(s0)
    1136:	ec14                	sd	a3,24(s0)
    1138:	f018                	sd	a4,32(s0)
    113a:	f41c                	sd	a5,40(s0)
    113c:	03043823          	sd	a6,48(s0)
    1140:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1144:	00840613          	addi	a2,s0,8
    1148:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    114c:	85aa                	mv	a1,a0
    114e:	4505                	li	a0,1
    1150:	d2dff0ef          	jal	e7c <vprintf>
}
    1154:	60e2                	ld	ra,24(sp)
    1156:	6442                	ld	s0,16(sp)
    1158:	6125                	addi	sp,sp,96
    115a:	8082                	ret

000000000000115c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    115c:	1141                	addi	sp,sp,-16
    115e:	e406                	sd	ra,8(sp)
    1160:	e022                	sd	s0,0(sp)
    1162:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1164:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1168:	00001797          	auipc	a5,0x1
    116c:	ea87b783          	ld	a5,-344(a5) # 2010 <freep>
    1170:	a02d                	j	119a <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1172:	4618                	lw	a4,8(a2)
    1174:	9f2d                	addw	a4,a4,a1
    1176:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    117a:	6398                	ld	a4,0(a5)
    117c:	6310                	ld	a2,0(a4)
    117e:	a83d                	j	11bc <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1180:	ff852703          	lw	a4,-8(a0)
    1184:	9f31                	addw	a4,a4,a2
    1186:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1188:	ff053683          	ld	a3,-16(a0)
    118c:	a091                	j	11d0 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    118e:	6398                	ld	a4,0(a5)
    1190:	00e7e463          	bltu	a5,a4,1198 <free+0x3c>
    1194:	00e6ea63          	bltu	a3,a4,11a8 <free+0x4c>
{
    1198:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    119a:	fed7fae3          	bgeu	a5,a3,118e <free+0x32>
    119e:	6398                	ld	a4,0(a5)
    11a0:	00e6e463          	bltu	a3,a4,11a8 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11a4:	fee7eae3          	bltu	a5,a4,1198 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
    11a8:	ff852583          	lw	a1,-8(a0)
    11ac:	6390                	ld	a2,0(a5)
    11ae:	02059813          	slli	a6,a1,0x20
    11b2:	01c85713          	srli	a4,a6,0x1c
    11b6:	9736                	add	a4,a4,a3
    11b8:	fae60de3          	beq	a2,a4,1172 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
    11bc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    11c0:	4790                	lw	a2,8(a5)
    11c2:	02061593          	slli	a1,a2,0x20
    11c6:	01c5d713          	srli	a4,a1,0x1c
    11ca:	973e                	add	a4,a4,a5
    11cc:	fae68ae3          	beq	a3,a4,1180 <free+0x24>
    p->s.ptr = bp->s.ptr;
    11d0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    11d2:	00001717          	auipc	a4,0x1
    11d6:	e2f73f23          	sd	a5,-450(a4) # 2010 <freep>
}
    11da:	60a2                	ld	ra,8(sp)
    11dc:	6402                	ld	s0,0(sp)
    11de:	0141                	addi	sp,sp,16
    11e0:	8082                	ret

00000000000011e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11e2:	7139                	addi	sp,sp,-64
    11e4:	fc06                	sd	ra,56(sp)
    11e6:	f822                	sd	s0,48(sp)
    11e8:	f04a                	sd	s2,32(sp)
    11ea:	ec4e                	sd	s3,24(sp)
    11ec:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11ee:	02051993          	slli	s3,a0,0x20
    11f2:	0209d993          	srli	s3,s3,0x20
    11f6:	09bd                	addi	s3,s3,15
    11f8:	0049d993          	srli	s3,s3,0x4
    11fc:	2985                	addiw	s3,s3,1
    11fe:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    1200:	00001517          	auipc	a0,0x1
    1204:	e1053503          	ld	a0,-496(a0) # 2010 <freep>
    1208:	c905                	beqz	a0,1238 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    120a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    120c:	4798                	lw	a4,8(a5)
    120e:	09377663          	bgeu	a4,s3,129a <malloc+0xb8>
    1212:	f426                	sd	s1,40(sp)
    1214:	e852                	sd	s4,16(sp)
    1216:	e456                	sd	s5,8(sp)
    1218:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    121a:	8a4e                	mv	s4,s3
    121c:	6705                	lui	a4,0x1
    121e:	00e9f363          	bgeu	s3,a4,1224 <malloc+0x42>
    1222:	6a05                	lui	s4,0x1
    1224:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1228:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    122c:	00001497          	auipc	s1,0x1
    1230:	de448493          	addi	s1,s1,-540 # 2010 <freep>
  if(p == (char*)-1)
    1234:	5afd                	li	s5,-1
    1236:	a83d                	j	1274 <malloc+0x92>
    1238:	f426                	sd	s1,40(sp)
    123a:	e852                	sd	s4,16(sp)
    123c:	e456                	sd	s5,8(sp)
    123e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1240:	00001797          	auipc	a5,0x1
    1244:	e4878793          	addi	a5,a5,-440 # 2088 <base>
    1248:	00001717          	auipc	a4,0x1
    124c:	dcf73423          	sd	a5,-568(a4) # 2010 <freep>
    1250:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1252:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1256:	b7d1                	j	121a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    1258:	6398                	ld	a4,0(a5)
    125a:	e118                	sd	a4,0(a0)
    125c:	a899                	j	12b2 <malloc+0xd0>
  hp->s.size = nu;
    125e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1262:	0541                	addi	a0,a0,16
    1264:	ef9ff0ef          	jal	115c <free>
  return freep;
    1268:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    126a:	c125                	beqz	a0,12ca <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    126c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    126e:	4798                	lw	a4,8(a5)
    1270:	03277163          	bgeu	a4,s2,1292 <malloc+0xb0>
    if(p == freep)
    1274:	6098                	ld	a4,0(s1)
    1276:	853e                	mv	a0,a5
    1278:	fef71ae3          	bne	a4,a5,126c <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    127c:	8552                	mv	a0,s4
    127e:	b2bff0ef          	jal	da8 <sbrk>
  if(p == (char*)-1)
    1282:	fd551ee3          	bne	a0,s5,125e <malloc+0x7c>
        return 0;
    1286:	4501                	li	a0,0
    1288:	74a2                	ld	s1,40(sp)
    128a:	6a42                	ld	s4,16(sp)
    128c:	6aa2                	ld	s5,8(sp)
    128e:	6b02                	ld	s6,0(sp)
    1290:	a03d                	j	12be <malloc+0xdc>
    1292:	74a2                	ld	s1,40(sp)
    1294:	6a42                	ld	s4,16(sp)
    1296:	6aa2                	ld	s5,8(sp)
    1298:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    129a:	fae90fe3          	beq	s2,a4,1258 <malloc+0x76>
        p->s.size -= nunits;
    129e:	4137073b          	subw	a4,a4,s3
    12a2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12a4:	02071693          	slli	a3,a4,0x20
    12a8:	01c6d713          	srli	a4,a3,0x1c
    12ac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12ae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12b2:	00001717          	auipc	a4,0x1
    12b6:	d4a73f23          	sd	a0,-674(a4) # 2010 <freep>
      return (void*)(p + 1);
    12ba:	01078513          	addi	a0,a5,16
  }
}
    12be:	70e2                	ld	ra,56(sp)
    12c0:	7442                	ld	s0,48(sp)
    12c2:	7902                	ld	s2,32(sp)
    12c4:	69e2                	ld	s3,24(sp)
    12c6:	6121                	addi	sp,sp,64
    12c8:	8082                	ret
    12ca:	74a2                	ld	s1,40(sp)
    12cc:	6a42                	ld	s4,16(sp)
    12ce:	6aa2                	ld	s5,8(sp)
    12d0:	6b02                	ld	s6,0(sp)
    12d2:	b7f5                	j	12be <malloc+0xdc>
