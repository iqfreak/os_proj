
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

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

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	9e250513          	addi	a0,a0,-1566 # 9f0 <malloc+0x100>
  16:	458000ef          	jal	46e <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	486000ef          	jal	4a6 <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	480000ef          	jal	4a6 <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	9ce90913          	addi	s2,s2,-1586 # 9f8 <malloc+0x108>
  32:	854a                	mv	a0,s2
  34:	005000ef          	jal	838 <printf>
    pid = fork();
  38:	3ee000ef          	jal	426 <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	3f0000ef          	jal	436 <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	9f650513          	addi	a0,a0,-1546 # a48 <malloc+0x158>
  5a:	7de000ef          	jal	838 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	3ce000ef          	jal	42e <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	98850513          	addi	a0,a0,-1656 # 9f0 <malloc+0x100>
  70:	406000ef          	jal	476 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	97a50513          	addi	a0,a0,-1670 # 9f0 <malloc+0x100>
  7e:	3f0000ef          	jal	46e <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	98c50513          	addi	a0,a0,-1652 # a10 <malloc+0x120>
  8c:	7ac000ef          	jal	838 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	39c000ef          	jal	42e <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	98a50513          	addi	a0,a0,-1654 # a28 <malloc+0x138>
  a6:	3c0000ef          	jal	466 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	98650513          	addi	a0,a0,-1658 # a30 <malloc+0x140>
  b2:	786000ef          	jal	838 <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	376000ef          	jal	42e <exit>

00000000000000bc <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  extern int main();
  main();
  c4:	f3dff0ef          	jal	0 <main>
  exit(0);
  c8:	4501                	li	a0,0
  ca:	364000ef          	jal	42e <exit>

00000000000000ce <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  d6:	87aa                	mv	a5,a0
  d8:	0585                	addi	a1,a1,1
  da:	0785                	addi	a5,a5,1
  dc:	fff5c703          	lbu	a4,-1(a1)
  e0:	fee78fa3          	sb	a4,-1(a5)
  e4:	fb75                	bnez	a4,d8 <strcpy+0xa>
    ;
  return os;
}
  e6:	60a2                	ld	ra,8(sp)
  e8:	6402                	ld	s0,0(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strcmp>:

int strcmp(const char *p, const char *q)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e406                	sd	ra,8(sp)
  f2:	e022                	sd	s0,0(sp)
  f4:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb91                	beqz	a5,10e <strcmp+0x20>
  fc:	0005c703          	lbu	a4,0(a1)
 100:	00f71763          	bne	a4,a5,10e <strcmp+0x20>
    p++, q++;
 104:	0505                	addi	a0,a0,1
 106:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbe5                	bnez	a5,fc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 10e:	0005c503          	lbu	a0,0(a1)
}
 112:	40a7853b          	subw	a0,a5,a0
 116:	60a2                	ld	ra,8(sp)
 118:	6402                	ld	s0,0(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strlen>:

uint strlen(const char *s)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cf99                	beqz	a5,148 <strlen+0x2a>
 12c:	0505                	addi	a0,a0,1
 12e:	87aa                	mv	a5,a0
 130:	86be                	mv	a3,a5
 132:	0785                	addi	a5,a5,1
 134:	fff7c703          	lbu	a4,-1(a5)
 138:	ff65                	bnez	a4,130 <strlen+0x12>
 13a:	40a6853b          	subw	a0,a3,a0
 13e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 140:	60a2                	ld	ra,8(sp)
 142:	6402                	ld	s0,0(sp)
 144:	0141                	addi	sp,sp,16
 146:	8082                	ret
  for (n = 0; s[n]; n++)
 148:	4501                	li	a0,0
 14a:	bfdd                	j	140 <strlen+0x22>

000000000000014c <memset>:

void *
memset(void *dst, int c, uint n)
{
 14c:	1141                	addi	sp,sp,-16
 14e:	e406                	sd	ra,8(sp)
 150:	e022                	sd	s0,0(sp)
 152:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 154:	ca19                	beqz	a2,16a <memset+0x1e>
 156:	87aa                	mv	a5,a0
 158:	1602                	slli	a2,a2,0x20
 15a:	9201                	srli	a2,a2,0x20
 15c:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 160:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 164:	0785                	addi	a5,a5,1
 166:	fee79de3          	bne	a5,a4,160 <memset+0x14>
  }
  return dst;
}
 16a:	60a2                	ld	ra,8(sp)
 16c:	6402                	ld	s0,0(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret

0000000000000172 <strchr>:

char *
strchr(const char *s, char c)
{
 172:	1141                	addi	sp,sp,-16
 174:	e406                	sd	ra,8(sp)
 176:	e022                	sd	s0,0(sp)
 178:	0800                	addi	s0,sp,16
  for (; *s; s++)
 17a:	00054783          	lbu	a5,0(a0)
 17e:	cf81                	beqz	a5,196 <strchr+0x24>
    if (*s == c)
 180:	00f58763          	beq	a1,a5,18e <strchr+0x1c>
  for (; *s; s++)
 184:	0505                	addi	a0,a0,1
 186:	00054783          	lbu	a5,0(a0)
 18a:	fbfd                	bnez	a5,180 <strchr+0xe>
      return (char *)s;
  return 0;
 18c:	4501                	li	a0,0
}
 18e:	60a2                	ld	ra,8(sp)
 190:	6402                	ld	s0,0(sp)
 192:	0141                	addi	sp,sp,16
 194:	8082                	ret
  return 0;
 196:	4501                	li	a0,0
 198:	bfdd                	j	18e <strchr+0x1c>

000000000000019a <gets>:

char *
gets(char *buf, int max)
{
 19a:	7159                	addi	sp,sp,-112
 19c:	f486                	sd	ra,104(sp)
 19e:	f0a2                	sd	s0,96(sp)
 1a0:	eca6                	sd	s1,88(sp)
 1a2:	e8ca                	sd	s2,80(sp)
 1a4:	e4ce                	sd	s3,72(sp)
 1a6:	e0d2                	sd	s4,64(sp)
 1a8:	fc56                	sd	s5,56(sp)
 1aa:	f85a                	sd	s6,48(sp)
 1ac:	f45e                	sd	s7,40(sp)
 1ae:	f062                	sd	s8,32(sp)
 1b0:	ec66                	sd	s9,24(sp)
 1b2:	e86a                	sd	s10,16(sp)
 1b4:	1880                	addi	s0,sp,112
 1b6:	8caa                	mv	s9,a0
 1b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 1be:	f9f40b13          	addi	s6,s0,-97
 1c2:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 1c4:	4ba9                	li	s7,10
 1c6:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 1c8:	8d26                	mv	s10,s1
 1ca:	0014899b          	addiw	s3,s1,1
 1ce:	84ce                	mv	s1,s3
 1d0:	0349d563          	bge	s3,s4,1fa <gets+0x60>
    cc = read(0, &c, 1);
 1d4:	8656                	mv	a2,s5
 1d6:	85da                	mv	a1,s6
 1d8:	4501                	li	a0,0
 1da:	26c000ef          	jal	446 <read>
    if (cc < 1)
 1de:	00a05e63          	blez	a0,1fa <gets+0x60>
    buf[i++] = c;
 1e2:	f9f44783          	lbu	a5,-97(s0)
 1e6:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1ea:	01778763          	beq	a5,s7,1f8 <gets+0x5e>
 1ee:	0905                	addi	s2,s2,1
 1f0:	fd879ce3          	bne	a5,s8,1c8 <gets+0x2e>
    buf[i++] = c;
 1f4:	8d4e                	mv	s10,s3
 1f6:	a011                	j	1fa <gets+0x60>
 1f8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1fa:	9d66                	add	s10,s10,s9
 1fc:	000d0023          	sb	zero,0(s10)
  return buf;
}
 200:	8566                	mv	a0,s9
 202:	70a6                	ld	ra,104(sp)
 204:	7406                	ld	s0,96(sp)
 206:	64e6                	ld	s1,88(sp)
 208:	6946                	ld	s2,80(sp)
 20a:	69a6                	ld	s3,72(sp)
 20c:	6a06                	ld	s4,64(sp)
 20e:	7ae2                	ld	s5,56(sp)
 210:	7b42                	ld	s6,48(sp)
 212:	7ba2                	ld	s7,40(sp)
 214:	7c02                	ld	s8,32(sp)
 216:	6ce2                	ld	s9,24(sp)
 218:	6d42                	ld	s10,16(sp)
 21a:	6165                	addi	sp,sp,112
 21c:	8082                	ret

000000000000021e <stat>:

int stat(const char *n, struct stat *st)
{
 21e:	1101                	addi	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	e04a                	sd	s2,0(sp)
 226:	1000                	addi	s0,sp,32
 228:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22a:	4581                	li	a1,0
 22c:	242000ef          	jal	46e <open>
  if (fd < 0)
 230:	02054263          	bltz	a0,254 <stat+0x36>
 234:	e426                	sd	s1,8(sp)
 236:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 238:	85ca                	mv	a1,s2
 23a:	24c000ef          	jal	486 <fstat>
 23e:	892a                	mv	s2,a0
  close(fd);
 240:	8526                	mv	a0,s1
 242:	214000ef          	jal	456 <close>
  return r;
 246:	64a2                	ld	s1,8(sp)
}
 248:	854a                	mv	a0,s2
 24a:	60e2                	ld	ra,24(sp)
 24c:	6442                	ld	s0,16(sp)
 24e:	6902                	ld	s2,0(sp)
 250:	6105                	addi	sp,sp,32
 252:	8082                	ret
    return -1;
 254:	597d                	li	s2,-1
 256:	bfcd                	j	248 <stat+0x2a>

0000000000000258 <atoi>:

int atoi(const char *s)
{
 258:	1141                	addi	sp,sp,-16
 25a:	e406                	sd	ra,8(sp)
 25c:	e022                	sd	s0,0(sp)
 25e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 260:	00054683          	lbu	a3,0(a0)
 264:	fd06879b          	addiw	a5,a3,-48
 268:	0ff7f793          	zext.b	a5,a5
 26c:	4625                	li	a2,9
 26e:	02f66963          	bltu	a2,a5,2a0 <atoi+0x48>
 272:	872a                	mv	a4,a0
  n = 0;
 274:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 276:	0705                	addi	a4,a4,1
 278:	0025179b          	slliw	a5,a0,0x2
 27c:	9fa9                	addw	a5,a5,a0
 27e:	0017979b          	slliw	a5,a5,0x1
 282:	9fb5                	addw	a5,a5,a3
 284:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 288:	00074683          	lbu	a3,0(a4)
 28c:	fd06879b          	addiw	a5,a3,-48
 290:	0ff7f793          	zext.b	a5,a5
 294:	fef671e3          	bgeu	a2,a5,276 <atoi+0x1e>
  return n;
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
  n = 0;
 2a0:	4501                	li	a0,0
 2a2:	bfdd                	j	298 <atoi+0x40>

00000000000002a4 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 2ac:	02b57563          	bgeu	a0,a1,2d6 <memmove+0x32>
  {
    while (n-- > 0)
 2b0:	00c05f63          	blez	a2,2ce <memmove+0x2a>
 2b4:	1602                	slli	a2,a2,0x20
 2b6:	9201                	srli	a2,a2,0x20
 2b8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2bc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2be:	0585                	addi	a1,a1,1
 2c0:	0705                	addi	a4,a4,1
 2c2:	fff5c683          	lbu	a3,-1(a1)
 2c6:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 2ca:	fee79ae3          	bne	a5,a4,2be <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ce:	60a2                	ld	ra,8(sp)
 2d0:	6402                	ld	s0,0(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret
    dst += n;
 2d6:	00c50733          	add	a4,a0,a2
    src += n;
 2da:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 2dc:	fec059e3          	blez	a2,2ce <memmove+0x2a>
 2e0:	fff6079b          	addiw	a5,a2,-1
 2e4:	1782                	slli	a5,a5,0x20
 2e6:	9381                	srli	a5,a5,0x20
 2e8:	fff7c793          	not	a5,a5
 2ec:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ee:	15fd                	addi	a1,a1,-1
 2f0:	177d                	addi	a4,a4,-1
 2f2:	0005c683          	lbu	a3,0(a1)
 2f6:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2fa:	fef71ae3          	bne	a4,a5,2ee <memmove+0x4a>
 2fe:	bfc1                	j	2ce <memmove+0x2a>

0000000000000300 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 308:	ca0d                	beqz	a2,33a <memcmp+0x3a>
 30a:	fff6069b          	addiw	a3,a2,-1
 30e:	1682                	slli	a3,a3,0x20
 310:	9281                	srli	a3,a3,0x20
 312:	0685                	addi	a3,a3,1
 314:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 316:	00054783          	lbu	a5,0(a0)
 31a:	0005c703          	lbu	a4,0(a1)
 31e:	00e79863          	bne	a5,a4,32e <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 322:	0505                	addi	a0,a0,1
    p2++;
 324:	0585                	addi	a1,a1,1
  while (n-- > 0)
 326:	fed518e3          	bne	a0,a3,316 <memcmp+0x16>
  }
  return 0;
 32a:	4501                	li	a0,0
 32c:	a019                	j	332 <memcmp+0x32>
      return *p1 - *p2;
 32e:	40e7853b          	subw	a0,a5,a4
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  return 0;
 33a:	4501                	li	a0,0
 33c:	bfdd                	j	332 <memcmp+0x32>

000000000000033e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e406                	sd	ra,8(sp)
 342:	e022                	sd	s0,0(sp)
 344:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 346:	f5fff0ef          	jal	2a4 <memmove>
}
 34a:	60a2                	ld	ra,8(sp)
 34c:	6402                	ld	s0,0(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret

0000000000000352 <strcat>:

char *strcat(char *dst, const char *src)
{
 352:	1141                	addi	sp,sp,-16
 354:	e406                	sd	ra,8(sp)
 356:	e022                	sd	s0,0(sp)
 358:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 35a:	00054783          	lbu	a5,0(a0)
 35e:	c795                	beqz	a5,38a <strcat+0x38>
  char *p = dst;
 360:	87aa                	mv	a5,a0
    p++;
 362:	0785                	addi	a5,a5,1
  while (*p)
 364:	0007c703          	lbu	a4,0(a5)
 368:	ff6d                	bnez	a4,362 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 36a:	0005c703          	lbu	a4,0(a1)
 36e:	cb01                	beqz	a4,37e <strcat+0x2c>
  {
    *p = *src;
 370:	00e78023          	sb	a4,0(a5)
    p++;
 374:	0785                	addi	a5,a5,1
    src++;
 376:	0585                	addi	a1,a1,1
  while (*src)
 378:	0005c703          	lbu	a4,0(a1)
 37c:	fb75                	bnez	a4,370 <strcat+0x1e>
  }

  *p = 0;
 37e:	00078023          	sb	zero,0(a5)

  return dst;
}
 382:	60a2                	ld	ra,8(sp)
 384:	6402                	ld	s0,0(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
  char *p = dst;
 38a:	87aa                	mv	a5,a0
 38c:	bff9                	j	36a <strcat+0x18>

000000000000038e <isdir>:

int isdir(char *path)
{
 38e:	7179                	addi	sp,sp,-48
 390:	f406                	sd	ra,40(sp)
 392:	f022                	sd	s0,32(sp)
 394:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 396:	fd840593          	addi	a1,s0,-40
 39a:	e85ff0ef          	jal	21e <stat>
 39e:	00054b63          	bltz	a0,3b4 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 3a2:	fe041503          	lh	a0,-32(s0)
 3a6:	157d                	addi	a0,a0,-1
 3a8:	00153513          	seqz	a0,a0
}
 3ac:	70a2                	ld	ra,40(sp)
 3ae:	7402                	ld	s0,32(sp)
 3b0:	6145                	addi	sp,sp,48
 3b2:	8082                	ret
    return 0;
 3b4:	4501                	li	a0,0
 3b6:	bfdd                	j	3ac <isdir+0x1e>

00000000000003b8 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 3b8:	7139                	addi	sp,sp,-64
 3ba:	fc06                	sd	ra,56(sp)
 3bc:	f822                	sd	s0,48(sp)
 3be:	f426                	sd	s1,40(sp)
 3c0:	f04a                	sd	s2,32(sp)
 3c2:	ec4e                	sd	s3,24(sp)
 3c4:	e852                	sd	s4,16(sp)
 3c6:	e456                	sd	s5,8(sp)
 3c8:	0080                	addi	s0,sp,64
 3ca:	89aa                	mv	s3,a0
 3cc:	8aae                	mv	s5,a1
 3ce:	84b2                	mv	s1,a2
 3d0:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 3d2:	d4dff0ef          	jal	11e <strlen>
 3d6:	892a                	mv	s2,a0
  int nn = strlen(filename);
 3d8:	8556                	mv	a0,s5
 3da:	d45ff0ef          	jal	11e <strlen>
  int need = dn + 1 + nn + 1;
 3de:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 3e2:	9fa9                	addw	a5,a5,a0
    return 0;
 3e4:	4501                	li	a0,0
  if (need > bufsize)
 3e6:	0347d763          	bge	a5,s4,414 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 3ea:	85ce                	mv	a1,s3
 3ec:	8526                	mv	a0,s1
 3ee:	ce1ff0ef          	jal	ce <strcpy>
  if (dir[dn - 1] != '/')
 3f2:	99ca                	add	s3,s3,s2
 3f4:	fff9c703          	lbu	a4,-1(s3)
 3f8:	02f00793          	li	a5,47
 3fc:	00f70763          	beq	a4,a5,40a <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 400:	9926                	add	s2,s2,s1
 402:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 406:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 40a:	85d6                	mv	a1,s5
 40c:	8526                	mv	a0,s1
 40e:	f45ff0ef          	jal	352 <strcat>
  return out_buffer;
 412:	8526                	mv	a0,s1
}
 414:	70e2                	ld	ra,56(sp)
 416:	7442                	ld	s0,48(sp)
 418:	74a2                	ld	s1,40(sp)
 41a:	7902                	ld	s2,32(sp)
 41c:	69e2                	ld	s3,24(sp)
 41e:	6a42                	ld	s4,16(sp)
 420:	6aa2                	ld	s5,8(sp)
 422:	6121                	addi	sp,sp,64
 424:	8082                	ret

0000000000000426 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 426:	4885                	li	a7,1
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <exit>:
.global exit
exit:
 li a7, SYS_exit
 42e:	4889                	li	a7,2
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <wait>:
.global wait
wait:
 li a7, SYS_wait
 436:	488d                	li	a7,3
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 43e:	4891                	li	a7,4
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <read>:
.global read
read:
 li a7, SYS_read
 446:	4895                	li	a7,5
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <write>:
.global write
write:
 li a7, SYS_write
 44e:	48c1                	li	a7,16
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <close>:
.global close
close:
 li a7, SYS_close
 456:	48d5                	li	a7,21
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <kill>:
.global kill
kill:
 li a7, SYS_kill
 45e:	4899                	li	a7,6
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <exec>:
.global exec
exec:
 li a7, SYS_exec
 466:	489d                	li	a7,7
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <open>:
.global open
open:
 li a7, SYS_open
 46e:	48bd                	li	a7,15
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 476:	48c5                	li	a7,17
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 47e:	48c9                	li	a7,18
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 486:	48a1                	li	a7,8
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <link>:
.global link
link:
 li a7, SYS_link
 48e:	48cd                	li	a7,19
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 496:	48d1                	li	a7,20
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 49e:	48a5                	li	a7,9
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a6:	48a9                	li	a7,10
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4ae:	48ad                	li	a7,11
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b6:	48b1                	li	a7,12
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4be:	48b5                	li	a7,13
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c6:	48b9                	li	a7,14
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 4ce:	48d9                	li	a7,22
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4d6:	1101                	addi	sp,sp,-32
 4d8:	ec06                	sd	ra,24(sp)
 4da:	e822                	sd	s0,16(sp)
 4dc:	1000                	addi	s0,sp,32
 4de:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e2:	4605                	li	a2,1
 4e4:	fef40593          	addi	a1,s0,-17
 4e8:	f67ff0ef          	jal	44e <write>
}
 4ec:	60e2                	ld	ra,24(sp)
 4ee:	6442                	ld	s0,16(sp)
 4f0:	6105                	addi	sp,sp,32
 4f2:	8082                	ret

00000000000004f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f4:	7139                	addi	sp,sp,-64
 4f6:	fc06                	sd	ra,56(sp)
 4f8:	f822                	sd	s0,48(sp)
 4fa:	f426                	sd	s1,40(sp)
 4fc:	f04a                	sd	s2,32(sp)
 4fe:	ec4e                	sd	s3,24(sp)
 500:	0080                	addi	s0,sp,64
 502:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 504:	c299                	beqz	a3,50a <printint+0x16>
 506:	0605ce63          	bltz	a1,582 <printint+0x8e>
  neg = 0;
 50a:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 50c:	fc040313          	addi	t1,s0,-64
  neg = 0;
 510:	869a                	mv	a3,t1
  i = 0;
 512:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 514:	00000817          	auipc	a6,0x0
 518:	55c80813          	addi	a6,a6,1372 # a70 <digits>
 51c:	88be                	mv	a7,a5
 51e:	0017851b          	addiw	a0,a5,1
 522:	87aa                	mv	a5,a0
 524:	02c5f73b          	remuw	a4,a1,a2
 528:	1702                	slli	a4,a4,0x20
 52a:	9301                	srli	a4,a4,0x20
 52c:	9742                	add	a4,a4,a6
 52e:	00074703          	lbu	a4,0(a4)
 532:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 536:	872e                	mv	a4,a1
 538:	02c5d5bb          	divuw	a1,a1,a2
 53c:	0685                	addi	a3,a3,1
 53e:	fcc77fe3          	bgeu	a4,a2,51c <printint+0x28>
  if(neg)
 542:	000e0c63          	beqz	t3,55a <printint+0x66>
    buf[i++] = '-';
 546:	fd050793          	addi	a5,a0,-48
 54a:	00878533          	add	a0,a5,s0
 54e:	02d00793          	li	a5,45
 552:	fef50823          	sb	a5,-16(a0)
 556:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 55a:	fff7899b          	addiw	s3,a5,-1
 55e:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 562:	fff4c583          	lbu	a1,-1(s1)
 566:	854a                	mv	a0,s2
 568:	f6fff0ef          	jal	4d6 <putc>
  while(--i >= 0)
 56c:	39fd                	addiw	s3,s3,-1
 56e:	14fd                	addi	s1,s1,-1
 570:	fe09d9e3          	bgez	s3,562 <printint+0x6e>
}
 574:	70e2                	ld	ra,56(sp)
 576:	7442                	ld	s0,48(sp)
 578:	74a2                	ld	s1,40(sp)
 57a:	7902                	ld	s2,32(sp)
 57c:	69e2                	ld	s3,24(sp)
 57e:	6121                	addi	sp,sp,64
 580:	8082                	ret
    x = -xx;
 582:	40b005bb          	negw	a1,a1
    neg = 1;
 586:	4e05                	li	t3,1
    x = -xx;
 588:	b751                	j	50c <printint+0x18>

000000000000058a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58a:	711d                	addi	sp,sp,-96
 58c:	ec86                	sd	ra,88(sp)
 58e:	e8a2                	sd	s0,80(sp)
 590:	e4a6                	sd	s1,72(sp)
 592:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 594:	0005c483          	lbu	s1,0(a1)
 598:	26048663          	beqz	s1,804 <vprintf+0x27a>
 59c:	e0ca                	sd	s2,64(sp)
 59e:	fc4e                	sd	s3,56(sp)
 5a0:	f852                	sd	s4,48(sp)
 5a2:	f456                	sd	s5,40(sp)
 5a4:	f05a                	sd	s6,32(sp)
 5a6:	ec5e                	sd	s7,24(sp)
 5a8:	e862                	sd	s8,16(sp)
 5aa:	e466                	sd	s9,8(sp)
 5ac:	8b2a                	mv	s6,a0
 5ae:	8a2e                	mv	s4,a1
 5b0:	8bb2                	mv	s7,a2
  state = 0;
 5b2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5b4:	4901                	li	s2,0
 5b6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5b8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5bc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5c0:	06c00c93          	li	s9,108
 5c4:	a00d                	j	5e6 <vprintf+0x5c>
        putc(fd, c0);
 5c6:	85a6                	mv	a1,s1
 5c8:	855a                	mv	a0,s6
 5ca:	f0dff0ef          	jal	4d6 <putc>
 5ce:	a019                	j	5d4 <vprintf+0x4a>
    } else if(state == '%'){
 5d0:	03598363          	beq	s3,s5,5f6 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 5d4:	0019079b          	addiw	a5,s2,1
 5d8:	893e                	mv	s2,a5
 5da:	873e                	mv	a4,a5
 5dc:	97d2                	add	a5,a5,s4
 5de:	0007c483          	lbu	s1,0(a5)
 5e2:	20048963          	beqz	s1,7f4 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 5e6:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5ea:	fe0993e3          	bnez	s3,5d0 <vprintf+0x46>
      if(c0 == '%'){
 5ee:	fd579ce3          	bne	a5,s5,5c6 <vprintf+0x3c>
        state = '%';
 5f2:	89be                	mv	s3,a5
 5f4:	b7c5                	j	5d4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5f6:	00ea06b3          	add	a3,s4,a4
 5fa:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5fe:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 600:	c681                	beqz	a3,608 <vprintf+0x7e>
 602:	9752                	add	a4,a4,s4
 604:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 608:	03878e63          	beq	a5,s8,644 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 60c:	05978863          	beq	a5,s9,65c <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 610:	07500713          	li	a4,117
 614:	0ee78263          	beq	a5,a4,6f8 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 618:	07800713          	li	a4,120
 61c:	12e78463          	beq	a5,a4,744 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 620:	07000713          	li	a4,112
 624:	14e78963          	beq	a5,a4,776 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 628:	07300713          	li	a4,115
 62c:	18e78863          	beq	a5,a4,7bc <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 630:	02500713          	li	a4,37
 634:	04e79463          	bne	a5,a4,67c <vprintf+0xf2>
        putc(fd, '%');
 638:	85ba                	mv	a1,a4
 63a:	855a                	mv	a0,s6
 63c:	e9bff0ef          	jal	4d6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 640:	4981                	li	s3,0
 642:	bf49                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 644:	008b8493          	addi	s1,s7,8
 648:	4685                	li	a3,1
 64a:	4629                	li	a2,10
 64c:	000ba583          	lw	a1,0(s7)
 650:	855a                	mv	a0,s6
 652:	ea3ff0ef          	jal	4f4 <printint>
 656:	8ba6                	mv	s7,s1
      state = 0;
 658:	4981                	li	s3,0
 65a:	bfad                	j	5d4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 65c:	06400793          	li	a5,100
 660:	02f68963          	beq	a3,a5,692 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 664:	06c00793          	li	a5,108
 668:	04f68263          	beq	a3,a5,6ac <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 66c:	07500793          	li	a5,117
 670:	0af68063          	beq	a3,a5,710 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 674:	07800793          	li	a5,120
 678:	0ef68263          	beq	a3,a5,75c <vprintf+0x1d2>
        putc(fd, '%');
 67c:	02500593          	li	a1,37
 680:	855a                	mv	a0,s6
 682:	e55ff0ef          	jal	4d6 <putc>
        putc(fd, c0);
 686:	85a6                	mv	a1,s1
 688:	855a                	mv	a0,s6
 68a:	e4dff0ef          	jal	4d6 <putc>
      state = 0;
 68e:	4981                	li	s3,0
 690:	b791                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 692:	008b8493          	addi	s1,s7,8
 696:	4685                	li	a3,1
 698:	4629                	li	a2,10
 69a:	000ba583          	lw	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	e55ff0ef          	jal	4f4 <printint>
        i += 1;
 6a4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a6:	8ba6                	mv	s7,s1
      state = 0;
 6a8:	4981                	li	s3,0
        i += 1;
 6aa:	b72d                	j	5d4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ac:	06400793          	li	a5,100
 6b0:	02f60763          	beq	a2,a5,6de <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6b4:	07500793          	li	a5,117
 6b8:	06f60963          	beq	a2,a5,72a <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6bc:	07800793          	li	a5,120
 6c0:	faf61ee3          	bne	a2,a5,67c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c4:	008b8493          	addi	s1,s7,8
 6c8:	4681                	li	a3,0
 6ca:	4641                	li	a2,16
 6cc:	000ba583          	lw	a1,0(s7)
 6d0:	855a                	mv	a0,s6
 6d2:	e23ff0ef          	jal	4f4 <printint>
        i += 2;
 6d6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d8:	8ba6                	mv	s7,s1
      state = 0;
 6da:	4981                	li	s3,0
        i += 2;
 6dc:	bde5                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6de:	008b8493          	addi	s1,s7,8
 6e2:	4685                	li	a3,1
 6e4:	4629                	li	a2,10
 6e6:	000ba583          	lw	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	e09ff0ef          	jal	4f4 <printint>
        i += 2;
 6f0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f2:	8ba6                	mv	s7,s1
      state = 0;
 6f4:	4981                	li	s3,0
        i += 2;
 6f6:	bdf9                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 6f8:	008b8493          	addi	s1,s7,8
 6fc:	4681                	li	a3,0
 6fe:	4629                	li	a2,10
 700:	000ba583          	lw	a1,0(s7)
 704:	855a                	mv	a0,s6
 706:	defff0ef          	jal	4f4 <printint>
 70a:	8ba6                	mv	s7,s1
      state = 0;
 70c:	4981                	li	s3,0
 70e:	b5d9                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 710:	008b8493          	addi	s1,s7,8
 714:	4681                	li	a3,0
 716:	4629                	li	a2,10
 718:	000ba583          	lw	a1,0(s7)
 71c:	855a                	mv	a0,s6
 71e:	dd7ff0ef          	jal	4f4 <printint>
        i += 1;
 722:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	8ba6                	mv	s7,s1
      state = 0;
 726:	4981                	li	s3,0
        i += 1;
 728:	b575                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72a:	008b8493          	addi	s1,s7,8
 72e:	4681                	li	a3,0
 730:	4629                	li	a2,10
 732:	000ba583          	lw	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	dbdff0ef          	jal	4f4 <printint>
        i += 2;
 73c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 73e:	8ba6                	mv	s7,s1
      state = 0;
 740:	4981                	li	s3,0
        i += 2;
 742:	bd49                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 744:	008b8493          	addi	s1,s7,8
 748:	4681                	li	a3,0
 74a:	4641                	li	a2,16
 74c:	000ba583          	lw	a1,0(s7)
 750:	855a                	mv	a0,s6
 752:	da3ff0ef          	jal	4f4 <printint>
 756:	8ba6                	mv	s7,s1
      state = 0;
 758:	4981                	li	s3,0
 75a:	bdad                	j	5d4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 75c:	008b8493          	addi	s1,s7,8
 760:	4681                	li	a3,0
 762:	4641                	li	a2,16
 764:	000ba583          	lw	a1,0(s7)
 768:	855a                	mv	a0,s6
 76a:	d8bff0ef          	jal	4f4 <printint>
        i += 1;
 76e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 770:	8ba6                	mv	s7,s1
      state = 0;
 772:	4981                	li	s3,0
        i += 1;
 774:	b585                	j	5d4 <vprintf+0x4a>
 776:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 778:	008b8d13          	addi	s10,s7,8
 77c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 780:	03000593          	li	a1,48
 784:	855a                	mv	a0,s6
 786:	d51ff0ef          	jal	4d6 <putc>
  putc(fd, 'x');
 78a:	07800593          	li	a1,120
 78e:	855a                	mv	a0,s6
 790:	d47ff0ef          	jal	4d6 <putc>
 794:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 796:	00000b97          	auipc	s7,0x0
 79a:	2dab8b93          	addi	s7,s7,730 # a70 <digits>
 79e:	03c9d793          	srli	a5,s3,0x3c
 7a2:	97de                	add	a5,a5,s7
 7a4:	0007c583          	lbu	a1,0(a5)
 7a8:	855a                	mv	a0,s6
 7aa:	d2dff0ef          	jal	4d6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ae:	0992                	slli	s3,s3,0x4
 7b0:	34fd                	addiw	s1,s1,-1
 7b2:	f4f5                	bnez	s1,79e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 7b4:	8bea                	mv	s7,s10
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	6d02                	ld	s10,0(sp)
 7ba:	bd29                	j	5d4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7bc:	008b8993          	addi	s3,s7,8
 7c0:	000bb483          	ld	s1,0(s7)
 7c4:	cc91                	beqz	s1,7e0 <vprintf+0x256>
        for(; *s; s++)
 7c6:	0004c583          	lbu	a1,0(s1)
 7ca:	c195                	beqz	a1,7ee <vprintf+0x264>
          putc(fd, *s);
 7cc:	855a                	mv	a0,s6
 7ce:	d09ff0ef          	jal	4d6 <putc>
        for(; *s; s++)
 7d2:	0485                	addi	s1,s1,1
 7d4:	0004c583          	lbu	a1,0(s1)
 7d8:	f9f5                	bnez	a1,7cc <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 7da:	8bce                	mv	s7,s3
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bbdd                	j	5d4 <vprintf+0x4a>
          s = "(null)";
 7e0:	00000497          	auipc	s1,0x0
 7e4:	28848493          	addi	s1,s1,648 # a68 <malloc+0x178>
        for(; *s; s++)
 7e8:	02800593          	li	a1,40
 7ec:	b7c5                	j	7cc <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 7ee:	8bce                	mv	s7,s3
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	b3cd                	j	5d4 <vprintf+0x4a>
 7f4:	6906                	ld	s2,64(sp)
 7f6:	79e2                	ld	s3,56(sp)
 7f8:	7a42                	ld	s4,48(sp)
 7fa:	7aa2                	ld	s5,40(sp)
 7fc:	7b02                	ld	s6,32(sp)
 7fe:	6be2                	ld	s7,24(sp)
 800:	6c42                	ld	s8,16(sp)
 802:	6ca2                	ld	s9,8(sp)
    }
  }
}
 804:	60e6                	ld	ra,88(sp)
 806:	6446                	ld	s0,80(sp)
 808:	64a6                	ld	s1,72(sp)
 80a:	6125                	addi	sp,sp,96
 80c:	8082                	ret

000000000000080e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 80e:	715d                	addi	sp,sp,-80
 810:	ec06                	sd	ra,24(sp)
 812:	e822                	sd	s0,16(sp)
 814:	1000                	addi	s0,sp,32
 816:	e010                	sd	a2,0(s0)
 818:	e414                	sd	a3,8(s0)
 81a:	e818                	sd	a4,16(s0)
 81c:	ec1c                	sd	a5,24(s0)
 81e:	03043023          	sd	a6,32(s0)
 822:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 826:	8622                	mv	a2,s0
 828:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 82c:	d5fff0ef          	jal	58a <vprintf>
}
 830:	60e2                	ld	ra,24(sp)
 832:	6442                	ld	s0,16(sp)
 834:	6161                	addi	sp,sp,80
 836:	8082                	ret

0000000000000838 <printf>:

void
printf(const char *fmt, ...)
{
 838:	711d                	addi	sp,sp,-96
 83a:	ec06                	sd	ra,24(sp)
 83c:	e822                	sd	s0,16(sp)
 83e:	1000                	addi	s0,sp,32
 840:	e40c                	sd	a1,8(s0)
 842:	e810                	sd	a2,16(s0)
 844:	ec14                	sd	a3,24(s0)
 846:	f018                	sd	a4,32(s0)
 848:	f41c                	sd	a5,40(s0)
 84a:	03043823          	sd	a6,48(s0)
 84e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 852:	00840613          	addi	a2,s0,8
 856:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 85a:	85aa                	mv	a1,a0
 85c:	4505                	li	a0,1
 85e:	d2dff0ef          	jal	58a <vprintf>
}
 862:	60e2                	ld	ra,24(sp)
 864:	6442                	ld	s0,16(sp)
 866:	6125                	addi	sp,sp,96
 868:	8082                	ret

000000000000086a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 86a:	1141                	addi	sp,sp,-16
 86c:	e406                	sd	ra,8(sp)
 86e:	e022                	sd	s0,0(sp)
 870:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 872:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 876:	00000797          	auipc	a5,0x0
 87a:	79a7b783          	ld	a5,1946(a5) # 1010 <freep>
 87e:	a02d                	j	8a8 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 880:	4618                	lw	a4,8(a2)
 882:	9f2d                	addw	a4,a4,a1
 884:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 888:	6398                	ld	a4,0(a5)
 88a:	6310                	ld	a2,0(a4)
 88c:	a83d                	j	8ca <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 88e:	ff852703          	lw	a4,-8(a0)
 892:	9f31                	addw	a4,a4,a2
 894:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 896:	ff053683          	ld	a3,-16(a0)
 89a:	a091                	j	8de <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89c:	6398                	ld	a4,0(a5)
 89e:	00e7e463          	bltu	a5,a4,8a6 <free+0x3c>
 8a2:	00e6ea63          	bltu	a3,a4,8b6 <free+0x4c>
{
 8a6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a8:	fed7fae3          	bgeu	a5,a3,89c <free+0x32>
 8ac:	6398                	ld	a4,0(a5)
 8ae:	00e6e463          	bltu	a3,a4,8b6 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b2:	fee7eae3          	bltu	a5,a4,8a6 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 8b6:	ff852583          	lw	a1,-8(a0)
 8ba:	6390                	ld	a2,0(a5)
 8bc:	02059813          	slli	a6,a1,0x20
 8c0:	01c85713          	srli	a4,a6,0x1c
 8c4:	9736                	add	a4,a4,a3
 8c6:	fae60de3          	beq	a2,a4,880 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 8ca:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ce:	4790                	lw	a2,8(a5)
 8d0:	02061593          	slli	a1,a2,0x20
 8d4:	01c5d713          	srli	a4,a1,0x1c
 8d8:	973e                	add	a4,a4,a5
 8da:	fae68ae3          	beq	a3,a4,88e <free+0x24>
    p->s.ptr = bp->s.ptr;
 8de:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8e0:	00000717          	auipc	a4,0x0
 8e4:	72f73823          	sd	a5,1840(a4) # 1010 <freep>
}
 8e8:	60a2                	ld	ra,8(sp)
 8ea:	6402                	ld	s0,0(sp)
 8ec:	0141                	addi	sp,sp,16
 8ee:	8082                	ret

00000000000008f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8f0:	7139                	addi	sp,sp,-64
 8f2:	fc06                	sd	ra,56(sp)
 8f4:	f822                	sd	s0,48(sp)
 8f6:	f04a                	sd	s2,32(sp)
 8f8:	ec4e                	sd	s3,24(sp)
 8fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fc:	02051993          	slli	s3,a0,0x20
 900:	0209d993          	srli	s3,s3,0x20
 904:	09bd                	addi	s3,s3,15
 906:	0049d993          	srli	s3,s3,0x4
 90a:	2985                	addiw	s3,s3,1
 90c:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 90e:	00000517          	auipc	a0,0x0
 912:	70253503          	ld	a0,1794(a0) # 1010 <freep>
 916:	c905                	beqz	a0,946 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91a:	4798                	lw	a4,8(a5)
 91c:	09377663          	bgeu	a4,s3,9a8 <malloc+0xb8>
 920:	f426                	sd	s1,40(sp)
 922:	e852                	sd	s4,16(sp)
 924:	e456                	sd	s5,8(sp)
 926:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 928:	8a4e                	mv	s4,s3
 92a:	6705                	lui	a4,0x1
 92c:	00e9f363          	bgeu	s3,a4,932 <malloc+0x42>
 930:	6a05                	lui	s4,0x1
 932:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 936:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 93a:	00000497          	auipc	s1,0x0
 93e:	6d648493          	addi	s1,s1,1750 # 1010 <freep>
  if(p == (char*)-1)
 942:	5afd                	li	s5,-1
 944:	a83d                	j	982 <malloc+0x92>
 946:	f426                	sd	s1,40(sp)
 948:	e852                	sd	s4,16(sp)
 94a:	e456                	sd	s5,8(sp)
 94c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 94e:	00000797          	auipc	a5,0x0
 952:	6d278793          	addi	a5,a5,1746 # 1020 <base>
 956:	00000717          	auipc	a4,0x0
 95a:	6af73d23          	sd	a5,1722(a4) # 1010 <freep>
 95e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 960:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 964:	b7d1                	j	928 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 966:	6398                	ld	a4,0(a5)
 968:	e118                	sd	a4,0(a0)
 96a:	a899                	j	9c0 <malloc+0xd0>
  hp->s.size = nu;
 96c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 970:	0541                	addi	a0,a0,16
 972:	ef9ff0ef          	jal	86a <free>
  return freep;
 976:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 978:	c125                	beqz	a0,9d8 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 97c:	4798                	lw	a4,8(a5)
 97e:	03277163          	bgeu	a4,s2,9a0 <malloc+0xb0>
    if(p == freep)
 982:	6098                	ld	a4,0(s1)
 984:	853e                	mv	a0,a5
 986:	fef71ae3          	bne	a4,a5,97a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 98a:	8552                	mv	a0,s4
 98c:	b2bff0ef          	jal	4b6 <sbrk>
  if(p == (char*)-1)
 990:	fd551ee3          	bne	a0,s5,96c <malloc+0x7c>
        return 0;
 994:	4501                	li	a0,0
 996:	74a2                	ld	s1,40(sp)
 998:	6a42                	ld	s4,16(sp)
 99a:	6aa2                	ld	s5,8(sp)
 99c:	6b02                	ld	s6,0(sp)
 99e:	a03d                	j	9cc <malloc+0xdc>
 9a0:	74a2                	ld	s1,40(sp)
 9a2:	6a42                	ld	s4,16(sp)
 9a4:	6aa2                	ld	s5,8(sp)
 9a6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9a8:	fae90fe3          	beq	s2,a4,966 <malloc+0x76>
        p->s.size -= nunits;
 9ac:	4137073b          	subw	a4,a4,s3
 9b0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9b2:	02071693          	slli	a3,a4,0x20
 9b6:	01c6d713          	srli	a4,a3,0x1c
 9ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9c0:	00000717          	auipc	a4,0x0
 9c4:	64a73823          	sd	a0,1616(a4) # 1010 <freep>
      return (void*)(p + 1);
 9c8:	01078513          	addi	a0,a5,16
  }
}
 9cc:	70e2                	ld	ra,56(sp)
 9ce:	7442                	ld	s0,48(sp)
 9d0:	7902                	ld	s2,32(sp)
 9d2:	69e2                	ld	s3,24(sp)
 9d4:	6121                	addi	sp,sp,64
 9d6:	8082                	ret
 9d8:	74a2                	ld	s1,40(sp)
 9da:	6a42                	ld	s4,16(sp)
 9dc:	6aa2                	ld	s5,8(sp)
 9de:	6b02                	ld	s6,0(sp)
 9e0:	b7f5                	j	9cc <malloc+0xdc>
