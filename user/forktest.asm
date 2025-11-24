
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	12a000ef          	jal	136 <strlen>
  10:	862a                	mv	a2,a0
  12:	85a6                	mv	a1,s1
  14:	4505                	li	a0,1
  16:	450000ef          	jal	466 <write>
}
  1a:	60e2                	ld	ra,24(sp)
  1c:	6442                	ld	s0,16(sp)
  1e:	64a2                	ld	s1,8(sp)
  20:	6105                	addi	sp,sp,32
  22:	8082                	ret

0000000000000024 <forktest>:

void
forktest(void)
{
  24:	1101                	addi	sp,sp,-32
  26:	ec06                	sd	ra,24(sp)
  28:	e822                	sd	s0,16(sp)
  2a:	e426                	sd	s1,8(sp)
  2c:	e04a                	sd	s2,0(sp)
  2e:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  30:	00000517          	auipc	a0,0x0
  34:	4c050513          	addi	a0,a0,1216 # 4f0 <get_keystrokes_count+0xa>
  38:	fc9ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3c:	4481                	li	s1,0
  3e:	3e800913          	li	s2,1000
    pid = fork();
  42:	3fc000ef          	jal	43e <fork>
    if(pid < 0)
  46:	04054363          	bltz	a0,8c <forktest+0x68>
      break;
    if(pid == 0)
  4a:	cd09                	beqz	a0,64 <forktest+0x40>
  for(n=0; n<N; n++){
  4c:	2485                	addiw	s1,s1,1
  4e:	ff249ae3          	bne	s1,s2,42 <forktest+0x1e>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  52:	00000517          	auipc	a0,0x0
  56:	4ee50513          	addi	a0,a0,1262 # 540 <get_keystrokes_count+0x5a>
  5a:	fa7ff0ef          	jal	0 <print>
    exit(1);
  5e:	4505                	li	a0,1
  60:	3e6000ef          	jal	446 <exit>
      exit(0);
  64:	3e2000ef          	jal	446 <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      print("wait stopped early\n");
  68:	00000517          	auipc	a0,0x0
  6c:	49850513          	addi	a0,a0,1176 # 500 <get_keystrokes_count+0x1a>
  70:	f91ff0ef          	jal	0 <print>
      exit(1);
  74:	4505                	li	a0,1
  76:	3d0000ef          	jal	446 <exit>
    }
  }

  if(wait(0) != -1){
    print("wait got too many\n");
  7a:	00000517          	auipc	a0,0x0
  7e:	49e50513          	addi	a0,a0,1182 # 518 <get_keystrokes_count+0x32>
  82:	f7fff0ef          	jal	0 <print>
    exit(1);
  86:	4505                	li	a0,1
  88:	3be000ef          	jal	446 <exit>
  for(; n > 0; n--){
  8c:	00905963          	blez	s1,9e <forktest+0x7a>
    if(wait(0) < 0){
  90:	4501                	li	a0,0
  92:	3bc000ef          	jal	44e <wait>
  96:	fc0549e3          	bltz	a0,68 <forktest+0x44>
  for(; n > 0; n--){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f8f5                	bnez	s1,90 <forktest+0x6c>
  if(wait(0) != -1){
  9e:	4501                	li	a0,0
  a0:	3ae000ef          	jal	44e <wait>
  a4:	57fd                	li	a5,-1
  a6:	fcf51ae3          	bne	a0,a5,7a <forktest+0x56>
  }

  print("fork test OK\n");
  aa:	00000517          	auipc	a0,0x0
  ae:	48650513          	addi	a0,a0,1158 # 530 <get_keystrokes_count+0x4a>
  b2:	f4fff0ef          	jal	0 <print>
}
  b6:	60e2                	ld	ra,24(sp)
  b8:	6442                	ld	s0,16(sp)
  ba:	64a2                	ld	s1,8(sp)
  bc:	6902                	ld	s2,0(sp)
  be:	6105                	addi	sp,sp,32
  c0:	8082                	ret

00000000000000c2 <main>:

int
main(void)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e406                	sd	ra,8(sp)
  c6:	e022                	sd	s0,0(sp)
  c8:	0800                	addi	s0,sp,16
  forktest();
  ca:	f5bff0ef          	jal	24 <forktest>
  exit(0);
  ce:	4501                	li	a0,0
  d0:	376000ef          	jal	446 <exit>

00000000000000d4 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e406                	sd	ra,8(sp)
  d8:	e022                	sd	s0,0(sp)
  da:	0800                	addi	s0,sp,16
  extern int main();
  main();
  dc:	fe7ff0ef          	jal	c2 <main>
  exit(0);
  e0:	4501                	li	a0,0
  e2:	364000ef          	jal	446 <exit>

00000000000000e6 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e406                	sd	ra,8(sp)
  ea:	e022                	sd	s0,0(sp)
  ec:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	addi	a1,a1,1
  f2:	0785                	addi	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0xa>
    ;
  return os;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strcmp>:

int strcmp(const char *p, const char *q)
{
 106:	1141                	addi	sp,sp,-16
 108:	e406                	sd	ra,8(sp)
 10a:	e022                	sd	s0,0(sp)
 10c:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cb91                	beqz	a5,126 <strcmp+0x20>
 114:	0005c703          	lbu	a4,0(a1)
 118:	00f71763          	bne	a4,a5,126 <strcmp+0x20>
    p++, q++;
 11c:	0505                	addi	a0,a0,1
 11e:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	fbe5                	bnez	a5,114 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 126:	0005c503          	lbu	a0,0(a1)
}
 12a:	40a7853b          	subw	a0,a5,a0
 12e:	60a2                	ld	ra,8(sp)
 130:	6402                	ld	s0,0(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strlen>:

uint strlen(const char *s)
{
 136:	1141                	addi	sp,sp,-16
 138:	e406                	sd	ra,8(sp)
 13a:	e022                	sd	s0,0(sp)
 13c:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf99                	beqz	a5,160 <strlen+0x2a>
 144:	0505                	addi	a0,a0,1
 146:	87aa                	mv	a5,a0
 148:	86be                	mv	a3,a5
 14a:	0785                	addi	a5,a5,1
 14c:	fff7c703          	lbu	a4,-1(a5)
 150:	ff65                	bnez	a4,148 <strlen+0x12>
 152:	40a6853b          	subw	a0,a3,a0
 156:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 158:	60a2                	ld	ra,8(sp)
 15a:	6402                	ld	s0,0(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret
  for (n = 0; s[n]; n++)
 160:	4501                	li	a0,0
 162:	bfdd                	j	158 <strlen+0x22>

0000000000000164 <memset>:

void *
memset(void *dst, int c, uint n)
{
 164:	1141                	addi	sp,sp,-16
 166:	e406                	sd	ra,8(sp)
 168:	e022                	sd	s0,0(sp)
 16a:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 16c:	ca19                	beqz	a2,182 <memset+0x1e>
 16e:	87aa                	mv	a5,a0
 170:	1602                	slli	a2,a2,0x20
 172:	9201                	srli	a2,a2,0x20
 174:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 178:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 17c:	0785                	addi	a5,a5,1
 17e:	fee79de3          	bne	a5,a4,178 <memset+0x14>
  }
  return dst;
}
 182:	60a2                	ld	ra,8(sp)
 184:	6402                	ld	s0,0(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret

000000000000018a <strchr>:

char *
strchr(const char *s, char c)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e406                	sd	ra,8(sp)
 18e:	e022                	sd	s0,0(sp)
 190:	0800                	addi	s0,sp,16
  for (; *s; s++)
 192:	00054783          	lbu	a5,0(a0)
 196:	cf81                	beqz	a5,1ae <strchr+0x24>
    if (*s == c)
 198:	00f58763          	beq	a1,a5,1a6 <strchr+0x1c>
  for (; *s; s++)
 19c:	0505                	addi	a0,a0,1
 19e:	00054783          	lbu	a5,0(a0)
 1a2:	fbfd                	bnez	a5,198 <strchr+0xe>
      return (char *)s;
  return 0;
 1a4:	4501                	li	a0,0
}
 1a6:	60a2                	ld	ra,8(sp)
 1a8:	6402                	ld	s0,0(sp)
 1aa:	0141                	addi	sp,sp,16
 1ac:	8082                	ret
  return 0;
 1ae:	4501                	li	a0,0
 1b0:	bfdd                	j	1a6 <strchr+0x1c>

00000000000001b2 <gets>:

char *
gets(char *buf, int max)
{
 1b2:	7159                	addi	sp,sp,-112
 1b4:	f486                	sd	ra,104(sp)
 1b6:	f0a2                	sd	s0,96(sp)
 1b8:	eca6                	sd	s1,88(sp)
 1ba:	e8ca                	sd	s2,80(sp)
 1bc:	e4ce                	sd	s3,72(sp)
 1be:	e0d2                	sd	s4,64(sp)
 1c0:	fc56                	sd	s5,56(sp)
 1c2:	f85a                	sd	s6,48(sp)
 1c4:	f45e                	sd	s7,40(sp)
 1c6:	f062                	sd	s8,32(sp)
 1c8:	ec66                	sd	s9,24(sp)
 1ca:	e86a                	sd	s10,16(sp)
 1cc:	1880                	addi	s0,sp,112
 1ce:	8caa                	mv	s9,a0
 1d0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1d2:	892a                	mv	s2,a0
 1d4:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 1d6:	f9f40b13          	addi	s6,s0,-97
 1da:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 1dc:	4ba9                	li	s7,10
 1de:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 1e0:	8d26                	mv	s10,s1
 1e2:	0014899b          	addiw	s3,s1,1
 1e6:	84ce                	mv	s1,s3
 1e8:	0349d563          	bge	s3,s4,212 <gets+0x60>
    cc = read(0, &c, 1);
 1ec:	8656                	mv	a2,s5
 1ee:	85da                	mv	a1,s6
 1f0:	4501                	li	a0,0
 1f2:	26c000ef          	jal	45e <read>
    if (cc < 1)
 1f6:	00a05e63          	blez	a0,212 <gets+0x60>
    buf[i++] = c;
 1fa:	f9f44783          	lbu	a5,-97(s0)
 1fe:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 202:	01778763          	beq	a5,s7,210 <gets+0x5e>
 206:	0905                	addi	s2,s2,1
 208:	fd879ce3          	bne	a5,s8,1e0 <gets+0x2e>
    buf[i++] = c;
 20c:	8d4e                	mv	s10,s3
 20e:	a011                	j	212 <gets+0x60>
 210:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 212:	9d66                	add	s10,s10,s9
 214:	000d0023          	sb	zero,0(s10)
  return buf;
}
 218:	8566                	mv	a0,s9
 21a:	70a6                	ld	ra,104(sp)
 21c:	7406                	ld	s0,96(sp)
 21e:	64e6                	ld	s1,88(sp)
 220:	6946                	ld	s2,80(sp)
 222:	69a6                	ld	s3,72(sp)
 224:	6a06                	ld	s4,64(sp)
 226:	7ae2                	ld	s5,56(sp)
 228:	7b42                	ld	s6,48(sp)
 22a:	7ba2                	ld	s7,40(sp)
 22c:	7c02                	ld	s8,32(sp)
 22e:	6ce2                	ld	s9,24(sp)
 230:	6d42                	ld	s10,16(sp)
 232:	6165                	addi	sp,sp,112
 234:	8082                	ret

0000000000000236 <stat>:

int stat(const char *n, struct stat *st)
{
 236:	1101                	addi	sp,sp,-32
 238:	ec06                	sd	ra,24(sp)
 23a:	e822                	sd	s0,16(sp)
 23c:	e04a                	sd	s2,0(sp)
 23e:	1000                	addi	s0,sp,32
 240:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 242:	4581                	li	a1,0
 244:	242000ef          	jal	486 <open>
  if (fd < 0)
 248:	02054263          	bltz	a0,26c <stat+0x36>
 24c:	e426                	sd	s1,8(sp)
 24e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 250:	85ca                	mv	a1,s2
 252:	24c000ef          	jal	49e <fstat>
 256:	892a                	mv	s2,a0
  close(fd);
 258:	8526                	mv	a0,s1
 25a:	214000ef          	jal	46e <close>
  return r;
 25e:	64a2                	ld	s1,8(sp)
}
 260:	854a                	mv	a0,s2
 262:	60e2                	ld	ra,24(sp)
 264:	6442                	ld	s0,16(sp)
 266:	6902                	ld	s2,0(sp)
 268:	6105                	addi	sp,sp,32
 26a:	8082                	ret
    return -1;
 26c:	597d                	li	s2,-1
 26e:	bfcd                	j	260 <stat+0x2a>

0000000000000270 <atoi>:

int atoi(const char *s)
{
 270:	1141                	addi	sp,sp,-16
 272:	e406                	sd	ra,8(sp)
 274:	e022                	sd	s0,0(sp)
 276:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 278:	00054683          	lbu	a3,0(a0)
 27c:	fd06879b          	addiw	a5,a3,-48
 280:	0ff7f793          	zext.b	a5,a5
 284:	4625                	li	a2,9
 286:	02f66963          	bltu	a2,a5,2b8 <atoi+0x48>
 28a:	872a                	mv	a4,a0
  n = 0;
 28c:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 28e:	0705                	addi	a4,a4,1
 290:	0025179b          	slliw	a5,a0,0x2
 294:	9fa9                	addw	a5,a5,a0
 296:	0017979b          	slliw	a5,a5,0x1
 29a:	9fb5                	addw	a5,a5,a3
 29c:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2a0:	00074683          	lbu	a3,0(a4)
 2a4:	fd06879b          	addiw	a5,a3,-48
 2a8:	0ff7f793          	zext.b	a5,a5
 2ac:	fef671e3          	bgeu	a2,a5,28e <atoi+0x1e>
  return n;
}
 2b0:	60a2                	ld	ra,8(sp)
 2b2:	6402                	ld	s0,0(sp)
 2b4:	0141                	addi	sp,sp,16
 2b6:	8082                	ret
  n = 0;
 2b8:	4501                	li	a0,0
 2ba:	bfdd                	j	2b0 <atoi+0x40>

00000000000002bc <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e406                	sd	ra,8(sp)
 2c0:	e022                	sd	s0,0(sp)
 2c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 2c4:	02b57563          	bgeu	a0,a1,2ee <memmove+0x32>
  {
    while (n-- > 0)
 2c8:	00c05f63          	blez	a2,2e6 <memmove+0x2a>
 2cc:	1602                	slli	a2,a2,0x20
 2ce:	9201                	srli	a2,a2,0x20
 2d0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2d4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d6:	0585                	addi	a1,a1,1
 2d8:	0705                	addi	a4,a4,1
 2da:	fff5c683          	lbu	a3,-1(a1)
 2de:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 2e2:	fee79ae3          	bne	a5,a4,2d6 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2e6:	60a2                	ld	ra,8(sp)
 2e8:	6402                	ld	s0,0(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret
    dst += n;
 2ee:	00c50733          	add	a4,a0,a2
    src += n;
 2f2:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 2f4:	fec059e3          	blez	a2,2e6 <memmove+0x2a>
 2f8:	fff6079b          	addiw	a5,a2,-1
 2fc:	1782                	slli	a5,a5,0x20
 2fe:	9381                	srli	a5,a5,0x20
 300:	fff7c793          	not	a5,a5
 304:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 306:	15fd                	addi	a1,a1,-1
 308:	177d                	addi	a4,a4,-1
 30a:	0005c683          	lbu	a3,0(a1)
 30e:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 312:	fef71ae3          	bne	a4,a5,306 <memmove+0x4a>
 316:	bfc1                	j	2e6 <memmove+0x2a>

0000000000000318 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 320:	ca0d                	beqz	a2,352 <memcmp+0x3a>
 322:	fff6069b          	addiw	a3,a2,-1
 326:	1682                	slli	a3,a3,0x20
 328:	9281                	srli	a3,a3,0x20
 32a:	0685                	addi	a3,a3,1
 32c:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 32e:	00054783          	lbu	a5,0(a0)
 332:	0005c703          	lbu	a4,0(a1)
 336:	00e79863          	bne	a5,a4,346 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 33a:	0505                	addi	a0,a0,1
    p2++;
 33c:	0585                	addi	a1,a1,1
  while (n-- > 0)
 33e:	fed518e3          	bne	a0,a3,32e <memcmp+0x16>
  }
  return 0;
 342:	4501                	li	a0,0
 344:	a019                	j	34a <memcmp+0x32>
      return *p1 - *p2;
 346:	40e7853b          	subw	a0,a5,a4
}
 34a:	60a2                	ld	ra,8(sp)
 34c:	6402                	ld	s0,0(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret
  return 0;
 352:	4501                	li	a0,0
 354:	bfdd                	j	34a <memcmp+0x32>

0000000000000356 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 35e:	f5fff0ef          	jal	2bc <memmove>
}
 362:	60a2                	ld	ra,8(sp)
 364:	6402                	ld	s0,0(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret

000000000000036a <strcat>:

char *strcat(char *dst, const char *src)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e406                	sd	ra,8(sp)
 36e:	e022                	sd	s0,0(sp)
 370:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 372:	00054783          	lbu	a5,0(a0)
 376:	c795                	beqz	a5,3a2 <strcat+0x38>
  char *p = dst;
 378:	87aa                	mv	a5,a0
    p++;
 37a:	0785                	addi	a5,a5,1
  while (*p)
 37c:	0007c703          	lbu	a4,0(a5)
 380:	ff6d                	bnez	a4,37a <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 382:	0005c703          	lbu	a4,0(a1)
 386:	cb01                	beqz	a4,396 <strcat+0x2c>
  {
    *p = *src;
 388:	00e78023          	sb	a4,0(a5)
    p++;
 38c:	0785                	addi	a5,a5,1
    src++;
 38e:	0585                	addi	a1,a1,1
  while (*src)
 390:	0005c703          	lbu	a4,0(a1)
 394:	fb75                	bnez	a4,388 <strcat+0x1e>
  }

  *p = 0;
 396:	00078023          	sb	zero,0(a5)

  return dst;
}
 39a:	60a2                	ld	ra,8(sp)
 39c:	6402                	ld	s0,0(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
  char *p = dst;
 3a2:	87aa                	mv	a5,a0
 3a4:	bff9                	j	382 <strcat+0x18>

00000000000003a6 <isdir>:

int isdir(char *path)
{
 3a6:	7179                	addi	sp,sp,-48
 3a8:	f406                	sd	ra,40(sp)
 3aa:	f022                	sd	s0,32(sp)
 3ac:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 3ae:	fd840593          	addi	a1,s0,-40
 3b2:	e85ff0ef          	jal	236 <stat>
 3b6:	00054b63          	bltz	a0,3cc <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 3ba:	fe041503          	lh	a0,-32(s0)
 3be:	157d                	addi	a0,a0,-1
 3c0:	00153513          	seqz	a0,a0
}
 3c4:	70a2                	ld	ra,40(sp)
 3c6:	7402                	ld	s0,32(sp)
 3c8:	6145                	addi	sp,sp,48
 3ca:	8082                	ret
    return 0;
 3cc:	4501                	li	a0,0
 3ce:	bfdd                	j	3c4 <isdir+0x1e>

00000000000003d0 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 3d0:	7139                	addi	sp,sp,-64
 3d2:	fc06                	sd	ra,56(sp)
 3d4:	f822                	sd	s0,48(sp)
 3d6:	f426                	sd	s1,40(sp)
 3d8:	f04a                	sd	s2,32(sp)
 3da:	ec4e                	sd	s3,24(sp)
 3dc:	e852                	sd	s4,16(sp)
 3de:	e456                	sd	s5,8(sp)
 3e0:	0080                	addi	s0,sp,64
 3e2:	89aa                	mv	s3,a0
 3e4:	8aae                	mv	s5,a1
 3e6:	84b2                	mv	s1,a2
 3e8:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 3ea:	d4dff0ef          	jal	136 <strlen>
 3ee:	892a                	mv	s2,a0
  int nn = strlen(filename);
 3f0:	8556                	mv	a0,s5
 3f2:	d45ff0ef          	jal	136 <strlen>
  int need = dn + 1 + nn + 1;
 3f6:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 3fa:	9fa9                	addw	a5,a5,a0
    return 0;
 3fc:	4501                	li	a0,0
  if (need > bufsize)
 3fe:	0347d763          	bge	a5,s4,42c <joinpath+0x5c>
  strcpy(out_buffer, dir);
 402:	85ce                	mv	a1,s3
 404:	8526                	mv	a0,s1
 406:	ce1ff0ef          	jal	e6 <strcpy>
  if (dir[dn - 1] != '/')
 40a:	99ca                	add	s3,s3,s2
 40c:	fff9c703          	lbu	a4,-1(s3)
 410:	02f00793          	li	a5,47
 414:	00f70763          	beq	a4,a5,422 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 418:	9926                	add	s2,s2,s1
 41a:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 41e:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 422:	85d6                	mv	a1,s5
 424:	8526                	mv	a0,s1
 426:	f45ff0ef          	jal	36a <strcat>
  return out_buffer;
 42a:	8526                	mv	a0,s1
}
 42c:	70e2                	ld	ra,56(sp)
 42e:	7442                	ld	s0,48(sp)
 430:	74a2                	ld	s1,40(sp)
 432:	7902                	ld	s2,32(sp)
 434:	69e2                	ld	s3,24(sp)
 436:	6a42                	ld	s4,16(sp)
 438:	6aa2                	ld	s5,8(sp)
 43a:	6121                	addi	sp,sp,64
 43c:	8082                	ret

000000000000043e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 43e:	4885                	li	a7,1
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <exit>:
.global exit
exit:
 li a7, SYS_exit
 446:	4889                	li	a7,2
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <wait>:
.global wait
wait:
 li a7, SYS_wait
 44e:	488d                	li	a7,3
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 456:	4891                	li	a7,4
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <read>:
.global read
read:
 li a7, SYS_read
 45e:	4895                	li	a7,5
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <write>:
.global write
write:
 li a7, SYS_write
 466:	48c1                	li	a7,16
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <close>:
.global close
close:
 li a7, SYS_close
 46e:	48d5                	li	a7,21
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <kill>:
.global kill
kill:
 li a7, SYS_kill
 476:	4899                	li	a7,6
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <exec>:
.global exec
exec:
 li a7, SYS_exec
 47e:	489d                	li	a7,7
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <open>:
.global open
open:
 li a7, SYS_open
 486:	48bd                	li	a7,15
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 48e:	48c5                	li	a7,17
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 496:	48c9                	li	a7,18
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 49e:	48a1                	li	a7,8
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <link>:
.global link
link:
 li a7, SYS_link
 4a6:	48cd                	li	a7,19
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ae:	48d1                	li	a7,20
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4b6:	48a5                	li	a7,9
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <dup>:
.global dup
dup:
 li a7, SYS_dup
 4be:	48a9                	li	a7,10
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4c6:	48ad                	li	a7,11
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4ce:	48b1                	li	a7,12
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4d6:	48b5                	li	a7,13
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4de:	48b9                	li	a7,14
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 4e6:	48d9                	li	a7,22
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret
