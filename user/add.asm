
user/_add:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int sum = 0;
  for (int i = 1; i < argc; ++i)
  10:	4785                	li	a5,1
  12:	06a7d163          	bge	a5,a0,74 <main+0x74>
  16:	00858993          	addi	s3,a1,8
  1a:	ffe5091b          	addiw	s2,a0,-2
  1e:	02091793          	slli	a5,s2,0x20
  22:	01d7d913          	srli	s2,a5,0x1d
  26:	05c1                	addi	a1,a1,16
  28:	992e                	add	s2,s2,a1
  int sum = 0;
  2a:	4a01                	li	s4,0
  {
    for (int j = 0; argv[i][j]; ++j)
    {
      if (argv[i][j] < '0' || argv[i][j] > '9')
  2c:	44a5                	li	s1,9
    for (int j = 0; argv[i][j]; ++j)
  2e:	0009b503          	ld	a0,0(s3)
  32:	00054783          	lbu	a5,0(a0)
  36:	00150713          	addi	a4,a0,1
  3a:	cb99                	beqz	a5,50 <main+0x50>
      if (argv[i][j] < '0' || argv[i][j] > '9')
  3c:	fd07879b          	addiw	a5,a5,-48
  40:	0ff7f793          	zext.b	a5,a5
  44:	00f4ee63          	bltu	s1,a5,60 <main+0x60>
    for (int j = 0; argv[i][j]; ++j)
  48:	0705                	addi	a4,a4,1
  4a:	fff74783          	lbu	a5,-1(a4)
  4e:	f7fd                	bnez	a5,3c <main+0x3c>
      {
        printf("Bad usage at %s, only integers allowed\n", argv[i]);
        exit(1);
      }
    }
    sum += atoi(argv[i]);
  50:	1d6000ef          	jal	226 <atoi>
  54:	01450a3b          	addw	s4,a0,s4
  for (int i = 1; i < argc; ++i)
  58:	09a1                	addi	s3,s3,8
  5a:	fd299ae3          	bne	s3,s2,2e <main+0x2e>
  5e:	a821                	j	76 <main+0x76>
        printf("Bad usage at %s, only integers allowed\n", argv[i]);
  60:	85aa                	mv	a1,a0
  62:	00001517          	auipc	a0,0x1
  66:	94e50513          	addi	a0,a0,-1714 # 9b0 <malloc+0xf2>
  6a:	79c000ef          	jal	806 <printf>
        exit(1);
  6e:	4505                	li	a0,1
  70:	38c000ef          	jal	3fc <exit>
  int sum = 0;
  74:	4a01                	li	s4,0
  }
  printf("%d\n", sum);
  76:	85d2                	mv	a1,s4
  78:	00001517          	auipc	a0,0x1
  7c:	96050513          	addi	a0,a0,-1696 # 9d8 <malloc+0x11a>
  80:	786000ef          	jal	806 <printf>
  exit(0);
  84:	4501                	li	a0,0
  86:	376000ef          	jal	3fc <exit>

000000000000008a <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e406                	sd	ra,8(sp)
  8e:	e022                	sd	s0,0(sp)
  90:	0800                	addi	s0,sp,16
  extern int main();
  main();
  92:	f6fff0ef          	jal	0 <main>
  exit(0);
  96:	4501                	li	a0,0
  98:	364000ef          	jal	3fc <exit>

000000000000009c <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  9c:	1141                	addi	sp,sp,-16
  9e:	e406                	sd	ra,8(sp)
  a0:	e022                	sd	s0,0(sp)
  a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  a4:	87aa                	mv	a5,a0
  a6:	0585                	addi	a1,a1,1
  a8:	0785                	addi	a5,a5,1
  aa:	fff5c703          	lbu	a4,-1(a1)
  ae:	fee78fa3          	sb	a4,-1(a5)
  b2:	fb75                	bnez	a4,a6 <strcpy+0xa>
    ;
  return os;
}
  b4:	60a2                	ld	ra,8(sp)
  b6:	6402                	ld	s0,0(sp)
  b8:	0141                	addi	sp,sp,16
  ba:	8082                	ret

00000000000000bc <strcmp>:

int strcmp(const char *p, const char *q)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	cb91                	beqz	a5,dc <strcmp+0x20>
  ca:	0005c703          	lbu	a4,0(a1)
  ce:	00f71763          	bne	a4,a5,dc <strcmp+0x20>
    p++, q++;
  d2:	0505                	addi	a0,a0,1
  d4:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  d6:	00054783          	lbu	a5,0(a0)
  da:	fbe5                	bnez	a5,ca <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  dc:	0005c503          	lbu	a0,0(a1)
}
  e0:	40a7853b          	subw	a0,a5,a0
  e4:	60a2                	ld	ra,8(sp)
  e6:	6402                	ld	s0,0(sp)
  e8:	0141                	addi	sp,sp,16
  ea:	8082                	ret

00000000000000ec <strlen>:

uint strlen(const char *s)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e406                	sd	ra,8(sp)
  f0:	e022                	sd	s0,0(sp)
  f2:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  f4:	00054783          	lbu	a5,0(a0)
  f8:	cf99                	beqz	a5,116 <strlen+0x2a>
  fa:	0505                	addi	a0,a0,1
  fc:	87aa                	mv	a5,a0
  fe:	86be                	mv	a3,a5
 100:	0785                	addi	a5,a5,1
 102:	fff7c703          	lbu	a4,-1(a5)
 106:	ff65                	bnez	a4,fe <strlen+0x12>
 108:	40a6853b          	subw	a0,a3,a0
 10c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 10e:	60a2                	ld	ra,8(sp)
 110:	6402                	ld	s0,0(sp)
 112:	0141                	addi	sp,sp,16
 114:	8082                	ret
  for (n = 0; s[n]; n++)
 116:	4501                	li	a0,0
 118:	bfdd                	j	10e <strlen+0x22>

000000000000011a <memset>:

void *
memset(void *dst, int c, uint n)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 122:	ca19                	beqz	a2,138 <memset+0x1e>
 124:	87aa                	mv	a5,a0
 126:	1602                	slli	a2,a2,0x20
 128:	9201                	srli	a2,a2,0x20
 12a:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 12e:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 132:	0785                	addi	a5,a5,1
 134:	fee79de3          	bne	a5,a4,12e <memset+0x14>
  }
  return dst;
}
 138:	60a2                	ld	ra,8(sp)
 13a:	6402                	ld	s0,0(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret

0000000000000140 <strchr>:

char *
strchr(const char *s, char c)
{
 140:	1141                	addi	sp,sp,-16
 142:	e406                	sd	ra,8(sp)
 144:	e022                	sd	s0,0(sp)
 146:	0800                	addi	s0,sp,16
  for (; *s; s++)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cf81                	beqz	a5,164 <strchr+0x24>
    if (*s == c)
 14e:	00f58763          	beq	a1,a5,15c <strchr+0x1c>
  for (; *s; s++)
 152:	0505                	addi	a0,a0,1
 154:	00054783          	lbu	a5,0(a0)
 158:	fbfd                	bnez	a5,14e <strchr+0xe>
      return (char *)s;
  return 0;
 15a:	4501                	li	a0,0
}
 15c:	60a2                	ld	ra,8(sp)
 15e:	6402                	ld	s0,0(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret
  return 0;
 164:	4501                	li	a0,0
 166:	bfdd                	j	15c <strchr+0x1c>

0000000000000168 <gets>:

char *
gets(char *buf, int max)
{
 168:	7159                	addi	sp,sp,-112
 16a:	f486                	sd	ra,104(sp)
 16c:	f0a2                	sd	s0,96(sp)
 16e:	eca6                	sd	s1,88(sp)
 170:	e8ca                	sd	s2,80(sp)
 172:	e4ce                	sd	s3,72(sp)
 174:	e0d2                	sd	s4,64(sp)
 176:	fc56                	sd	s5,56(sp)
 178:	f85a                	sd	s6,48(sp)
 17a:	f45e                	sd	s7,40(sp)
 17c:	f062                	sd	s8,32(sp)
 17e:	ec66                	sd	s9,24(sp)
 180:	e86a                	sd	s10,16(sp)
 182:	1880                	addi	s0,sp,112
 184:	8caa                	mv	s9,a0
 186:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 188:	892a                	mv	s2,a0
 18a:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 18c:	f9f40b13          	addi	s6,s0,-97
 190:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 192:	4ba9                	li	s7,10
 194:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 196:	8d26                	mv	s10,s1
 198:	0014899b          	addiw	s3,s1,1
 19c:	84ce                	mv	s1,s3
 19e:	0349d563          	bge	s3,s4,1c8 <gets+0x60>
    cc = read(0, &c, 1);
 1a2:	8656                	mv	a2,s5
 1a4:	85da                	mv	a1,s6
 1a6:	4501                	li	a0,0
 1a8:	26c000ef          	jal	414 <read>
    if (cc < 1)
 1ac:	00a05e63          	blez	a0,1c8 <gets+0x60>
    buf[i++] = c;
 1b0:	f9f44783          	lbu	a5,-97(s0)
 1b4:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1b8:	01778763          	beq	a5,s7,1c6 <gets+0x5e>
 1bc:	0905                	addi	s2,s2,1
 1be:	fd879ce3          	bne	a5,s8,196 <gets+0x2e>
    buf[i++] = c;
 1c2:	8d4e                	mv	s10,s3
 1c4:	a011                	j	1c8 <gets+0x60>
 1c6:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1c8:	9d66                	add	s10,s10,s9
 1ca:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1ce:	8566                	mv	a0,s9
 1d0:	70a6                	ld	ra,104(sp)
 1d2:	7406                	ld	s0,96(sp)
 1d4:	64e6                	ld	s1,88(sp)
 1d6:	6946                	ld	s2,80(sp)
 1d8:	69a6                	ld	s3,72(sp)
 1da:	6a06                	ld	s4,64(sp)
 1dc:	7ae2                	ld	s5,56(sp)
 1de:	7b42                	ld	s6,48(sp)
 1e0:	7ba2                	ld	s7,40(sp)
 1e2:	7c02                	ld	s8,32(sp)
 1e4:	6ce2                	ld	s9,24(sp)
 1e6:	6d42                	ld	s10,16(sp)
 1e8:	6165                	addi	sp,sp,112
 1ea:	8082                	ret

00000000000001ec <stat>:

int stat(const char *n, struct stat *st)
{
 1ec:	1101                	addi	sp,sp,-32
 1ee:	ec06                	sd	ra,24(sp)
 1f0:	e822                	sd	s0,16(sp)
 1f2:	e04a                	sd	s2,0(sp)
 1f4:	1000                	addi	s0,sp,32
 1f6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f8:	4581                	li	a1,0
 1fa:	242000ef          	jal	43c <open>
  if (fd < 0)
 1fe:	02054263          	bltz	a0,222 <stat+0x36>
 202:	e426                	sd	s1,8(sp)
 204:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 206:	85ca                	mv	a1,s2
 208:	24c000ef          	jal	454 <fstat>
 20c:	892a                	mv	s2,a0
  close(fd);
 20e:	8526                	mv	a0,s1
 210:	214000ef          	jal	424 <close>
  return r;
 214:	64a2                	ld	s1,8(sp)
}
 216:	854a                	mv	a0,s2
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	6902                	ld	s2,0(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
    return -1;
 222:	597d                	li	s2,-1
 224:	bfcd                	j	216 <stat+0x2a>

0000000000000226 <atoi>:

int atoi(const char *s)
{
 226:	1141                	addi	sp,sp,-16
 228:	e406                	sd	ra,8(sp)
 22a:	e022                	sd	s0,0(sp)
 22c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 22e:	00054683          	lbu	a3,0(a0)
 232:	fd06879b          	addiw	a5,a3,-48
 236:	0ff7f793          	zext.b	a5,a5
 23a:	4625                	li	a2,9
 23c:	02f66963          	bltu	a2,a5,26e <atoi+0x48>
 240:	872a                	mv	a4,a0
  n = 0;
 242:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 244:	0705                	addi	a4,a4,1
 246:	0025179b          	slliw	a5,a0,0x2
 24a:	9fa9                	addw	a5,a5,a0
 24c:	0017979b          	slliw	a5,a5,0x1
 250:	9fb5                	addw	a5,a5,a3
 252:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 256:	00074683          	lbu	a3,0(a4)
 25a:	fd06879b          	addiw	a5,a3,-48
 25e:	0ff7f793          	zext.b	a5,a5
 262:	fef671e3          	bgeu	a2,a5,244 <atoi+0x1e>
  return n;
}
 266:	60a2                	ld	ra,8(sp)
 268:	6402                	ld	s0,0(sp)
 26a:	0141                	addi	sp,sp,16
 26c:	8082                	ret
  n = 0;
 26e:	4501                	li	a0,0
 270:	bfdd                	j	266 <atoi+0x40>

0000000000000272 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 272:	1141                	addi	sp,sp,-16
 274:	e406                	sd	ra,8(sp)
 276:	e022                	sd	s0,0(sp)
 278:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 27a:	02b57563          	bgeu	a0,a1,2a4 <memmove+0x32>
  {
    while (n-- > 0)
 27e:	00c05f63          	blez	a2,29c <memmove+0x2a>
 282:	1602                	slli	a2,a2,0x20
 284:	9201                	srli	a2,a2,0x20
 286:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28a:	872a                	mv	a4,a0
      *dst++ = *src++;
 28c:	0585                	addi	a1,a1,1
 28e:	0705                	addi	a4,a4,1
 290:	fff5c683          	lbu	a3,-1(a1)
 294:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 298:	fee79ae3          	bne	a5,a4,28c <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29c:	60a2                	ld	ra,8(sp)
 29e:	6402                	ld	s0,0(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
    dst += n;
 2a4:	00c50733          	add	a4,a0,a2
    src += n;
 2a8:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 2aa:	fec059e3          	blez	a2,29c <memmove+0x2a>
 2ae:	fff6079b          	addiw	a5,a2,-1
 2b2:	1782                	slli	a5,a5,0x20
 2b4:	9381                	srli	a5,a5,0x20
 2b6:	fff7c793          	not	a5,a5
 2ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2bc:	15fd                	addi	a1,a1,-1
 2be:	177d                	addi	a4,a4,-1
 2c0:	0005c683          	lbu	a3,0(a1)
 2c4:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2c8:	fef71ae3          	bne	a4,a5,2bc <memmove+0x4a>
 2cc:	bfc1                	j	29c <memmove+0x2a>

00000000000002ce <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2d6:	ca0d                	beqz	a2,308 <memcmp+0x3a>
 2d8:	fff6069b          	addiw	a3,a2,-1
 2dc:	1682                	slli	a3,a3,0x20
 2de:	9281                	srli	a3,a3,0x20
 2e0:	0685                	addi	a3,a3,1
 2e2:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	00e79863          	bne	a5,a4,2fc <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 2f0:	0505                	addi	a0,a0,1
    p2++;
 2f2:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2f4:	fed518e3          	bne	a0,a3,2e4 <memcmp+0x16>
  }
  return 0;
 2f8:	4501                	li	a0,0
 2fa:	a019                	j	300 <memcmp+0x32>
      return *p1 - *p2;
 2fc:	40e7853b          	subw	a0,a5,a4
}
 300:	60a2                	ld	ra,8(sp)
 302:	6402                	ld	s0,0(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret
  return 0;
 308:	4501                	li	a0,0
 30a:	bfdd                	j	300 <memcmp+0x32>

000000000000030c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30c:	1141                	addi	sp,sp,-16
 30e:	e406                	sd	ra,8(sp)
 310:	e022                	sd	s0,0(sp)
 312:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 314:	f5fff0ef          	jal	272 <memmove>
}
 318:	60a2                	ld	ra,8(sp)
 31a:	6402                	ld	s0,0(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret

0000000000000320 <strcat>:

char *strcat(char *dst, const char *src)
{
 320:	1141                	addi	sp,sp,-16
 322:	e406                	sd	ra,8(sp)
 324:	e022                	sd	s0,0(sp)
 326:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 328:	00054783          	lbu	a5,0(a0)
 32c:	c795                	beqz	a5,358 <strcat+0x38>
  char *p = dst;
 32e:	87aa                	mv	a5,a0
    p++;
 330:	0785                	addi	a5,a5,1
  while (*p)
 332:	0007c703          	lbu	a4,0(a5)
 336:	ff6d                	bnez	a4,330 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 338:	0005c703          	lbu	a4,0(a1)
 33c:	cb01                	beqz	a4,34c <strcat+0x2c>
  {
    *p = *src;
 33e:	00e78023          	sb	a4,0(a5)
    p++;
 342:	0785                	addi	a5,a5,1
    src++;
 344:	0585                	addi	a1,a1,1
  while (*src)
 346:	0005c703          	lbu	a4,0(a1)
 34a:	fb75                	bnez	a4,33e <strcat+0x1e>
  }

  *p = 0;
 34c:	00078023          	sb	zero,0(a5)

  return dst;
}
 350:	60a2                	ld	ra,8(sp)
 352:	6402                	ld	s0,0(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret
  char *p = dst;
 358:	87aa                	mv	a5,a0
 35a:	bff9                	j	338 <strcat+0x18>

000000000000035c <isdir>:

int isdir(char *path)
{
 35c:	7179                	addi	sp,sp,-48
 35e:	f406                	sd	ra,40(sp)
 360:	f022                	sd	s0,32(sp)
 362:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 364:	fd840593          	addi	a1,s0,-40
 368:	e85ff0ef          	jal	1ec <stat>
 36c:	00054b63          	bltz	a0,382 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 370:	fe041503          	lh	a0,-32(s0)
 374:	157d                	addi	a0,a0,-1
 376:	00153513          	seqz	a0,a0
}
 37a:	70a2                	ld	ra,40(sp)
 37c:	7402                	ld	s0,32(sp)
 37e:	6145                	addi	sp,sp,48
 380:	8082                	ret
    return 0;
 382:	4501                	li	a0,0
 384:	bfdd                	j	37a <isdir+0x1e>

0000000000000386 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 386:	7139                	addi	sp,sp,-64
 388:	fc06                	sd	ra,56(sp)
 38a:	f822                	sd	s0,48(sp)
 38c:	f426                	sd	s1,40(sp)
 38e:	f04a                	sd	s2,32(sp)
 390:	ec4e                	sd	s3,24(sp)
 392:	e852                	sd	s4,16(sp)
 394:	e456                	sd	s5,8(sp)
 396:	0080                	addi	s0,sp,64
 398:	89aa                	mv	s3,a0
 39a:	8aae                	mv	s5,a1
 39c:	84b2                	mv	s1,a2
 39e:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 3a0:	d4dff0ef          	jal	ec <strlen>
 3a4:	892a                	mv	s2,a0
  int nn = strlen(filename);
 3a6:	8556                	mv	a0,s5
 3a8:	d45ff0ef          	jal	ec <strlen>
  int need = dn + 1 + nn + 1;
 3ac:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 3b0:	9fa9                	addw	a5,a5,a0
    return 0;
 3b2:	4501                	li	a0,0
  if (need > bufsize)
 3b4:	0347d763          	bge	a5,s4,3e2 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 3b8:	85ce                	mv	a1,s3
 3ba:	8526                	mv	a0,s1
 3bc:	ce1ff0ef          	jal	9c <strcpy>
  if (dir[dn - 1] != '/')
 3c0:	99ca                	add	s3,s3,s2
 3c2:	fff9c703          	lbu	a4,-1(s3)
 3c6:	02f00793          	li	a5,47
 3ca:	00f70763          	beq	a4,a5,3d8 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 3ce:	9926                	add	s2,s2,s1
 3d0:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 3d4:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 3d8:	85d6                	mv	a1,s5
 3da:	8526                	mv	a0,s1
 3dc:	f45ff0ef          	jal	320 <strcat>
  return out_buffer;
 3e0:	8526                	mv	a0,s1
}
 3e2:	70e2                	ld	ra,56(sp)
 3e4:	7442                	ld	s0,48(sp)
 3e6:	74a2                	ld	s1,40(sp)
 3e8:	7902                	ld	s2,32(sp)
 3ea:	69e2                	ld	s3,24(sp)
 3ec:	6a42                	ld	s4,16(sp)
 3ee:	6aa2                	ld	s5,8(sp)
 3f0:	6121                	addi	sp,sp,64
 3f2:	8082                	ret

00000000000003f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f4:	4885                	li	a7,1
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3fc:	4889                	li	a7,2
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <wait>:
.global wait
wait:
 li a7, SYS_wait
 404:	488d                	li	a7,3
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 40c:	4891                	li	a7,4
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <read>:
.global read
read:
 li a7, SYS_read
 414:	4895                	li	a7,5
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <write>:
.global write
write:
 li a7, SYS_write
 41c:	48c1                	li	a7,16
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <close>:
.global close
close:
 li a7, SYS_close
 424:	48d5                	li	a7,21
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <kill>:
.global kill
kill:
 li a7, SYS_kill
 42c:	4899                	li	a7,6
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <exec>:
.global exec
exec:
 li a7, SYS_exec
 434:	489d                	li	a7,7
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <open>:
.global open
open:
 li a7, SYS_open
 43c:	48bd                	li	a7,15
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 444:	48c5                	li	a7,17
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 44c:	48c9                	li	a7,18
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 454:	48a1                	li	a7,8
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <link>:
.global link
link:
 li a7, SYS_link
 45c:	48cd                	li	a7,19
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 464:	48d1                	li	a7,20
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 46c:	48a5                	li	a7,9
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <dup>:
.global dup
dup:
 li a7, SYS_dup
 474:	48a9                	li	a7,10
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 47c:	48ad                	li	a7,11
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 484:	48b1                	li	a7,12
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 48c:	48b5                	li	a7,13
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 494:	48b9                	li	a7,14
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 49c:	48d9                	li	a7,22
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a4:	1101                	addi	sp,sp,-32
 4a6:	ec06                	sd	ra,24(sp)
 4a8:	e822                	sd	s0,16(sp)
 4aa:	1000                	addi	s0,sp,32
 4ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b0:	4605                	li	a2,1
 4b2:	fef40593          	addi	a1,s0,-17
 4b6:	f67ff0ef          	jal	41c <write>
}
 4ba:	60e2                	ld	ra,24(sp)
 4bc:	6442                	ld	s0,16(sp)
 4be:	6105                	addi	sp,sp,32
 4c0:	8082                	ret

00000000000004c2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c2:	7139                	addi	sp,sp,-64
 4c4:	fc06                	sd	ra,56(sp)
 4c6:	f822                	sd	s0,48(sp)
 4c8:	f426                	sd	s1,40(sp)
 4ca:	f04a                	sd	s2,32(sp)
 4cc:	ec4e                	sd	s3,24(sp)
 4ce:	0080                	addi	s0,sp,64
 4d0:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4d2:	c299                	beqz	a3,4d8 <printint+0x16>
 4d4:	0605ce63          	bltz	a1,550 <printint+0x8e>
  neg = 0;
 4d8:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4da:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4de:	869a                	mv	a3,t1
  i = 0;
 4e0:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4e2:	00000817          	auipc	a6,0x0
 4e6:	50680813          	addi	a6,a6,1286 # 9e8 <digits>
 4ea:	88be                	mv	a7,a5
 4ec:	0017851b          	addiw	a0,a5,1
 4f0:	87aa                	mv	a5,a0
 4f2:	02c5f73b          	remuw	a4,a1,a2
 4f6:	1702                	slli	a4,a4,0x20
 4f8:	9301                	srli	a4,a4,0x20
 4fa:	9742                	add	a4,a4,a6
 4fc:	00074703          	lbu	a4,0(a4)
 500:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 504:	872e                	mv	a4,a1
 506:	02c5d5bb          	divuw	a1,a1,a2
 50a:	0685                	addi	a3,a3,1
 50c:	fcc77fe3          	bgeu	a4,a2,4ea <printint+0x28>
  if(neg)
 510:	000e0c63          	beqz	t3,528 <printint+0x66>
    buf[i++] = '-';
 514:	fd050793          	addi	a5,a0,-48
 518:	00878533          	add	a0,a5,s0
 51c:	02d00793          	li	a5,45
 520:	fef50823          	sb	a5,-16(a0)
 524:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 528:	fff7899b          	addiw	s3,a5,-1
 52c:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 530:	fff4c583          	lbu	a1,-1(s1)
 534:	854a                	mv	a0,s2
 536:	f6fff0ef          	jal	4a4 <putc>
  while(--i >= 0)
 53a:	39fd                	addiw	s3,s3,-1
 53c:	14fd                	addi	s1,s1,-1
 53e:	fe09d9e3          	bgez	s3,530 <printint+0x6e>
}
 542:	70e2                	ld	ra,56(sp)
 544:	7442                	ld	s0,48(sp)
 546:	74a2                	ld	s1,40(sp)
 548:	7902                	ld	s2,32(sp)
 54a:	69e2                	ld	s3,24(sp)
 54c:	6121                	addi	sp,sp,64
 54e:	8082                	ret
    x = -xx;
 550:	40b005bb          	negw	a1,a1
    neg = 1;
 554:	4e05                	li	t3,1
    x = -xx;
 556:	b751                	j	4da <printint+0x18>

0000000000000558 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 558:	711d                	addi	sp,sp,-96
 55a:	ec86                	sd	ra,88(sp)
 55c:	e8a2                	sd	s0,80(sp)
 55e:	e4a6                	sd	s1,72(sp)
 560:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 562:	0005c483          	lbu	s1,0(a1)
 566:	26048663          	beqz	s1,7d2 <vprintf+0x27a>
 56a:	e0ca                	sd	s2,64(sp)
 56c:	fc4e                	sd	s3,56(sp)
 56e:	f852                	sd	s4,48(sp)
 570:	f456                	sd	s5,40(sp)
 572:	f05a                	sd	s6,32(sp)
 574:	ec5e                	sd	s7,24(sp)
 576:	e862                	sd	s8,16(sp)
 578:	e466                	sd	s9,8(sp)
 57a:	8b2a                	mv	s6,a0
 57c:	8a2e                	mv	s4,a1
 57e:	8bb2                	mv	s7,a2
  state = 0;
 580:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 582:	4901                	li	s2,0
 584:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 586:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 58a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 58e:	06c00c93          	li	s9,108
 592:	a00d                	j	5b4 <vprintf+0x5c>
        putc(fd, c0);
 594:	85a6                	mv	a1,s1
 596:	855a                	mv	a0,s6
 598:	f0dff0ef          	jal	4a4 <putc>
 59c:	a019                	j	5a2 <vprintf+0x4a>
    } else if(state == '%'){
 59e:	03598363          	beq	s3,s5,5c4 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 5a2:	0019079b          	addiw	a5,s2,1
 5a6:	893e                	mv	s2,a5
 5a8:	873e                	mv	a4,a5
 5aa:	97d2                	add	a5,a5,s4
 5ac:	0007c483          	lbu	s1,0(a5)
 5b0:	20048963          	beqz	s1,7c2 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 5b4:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5b8:	fe0993e3          	bnez	s3,59e <vprintf+0x46>
      if(c0 == '%'){
 5bc:	fd579ce3          	bne	a5,s5,594 <vprintf+0x3c>
        state = '%';
 5c0:	89be                	mv	s3,a5
 5c2:	b7c5                	j	5a2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5c4:	00ea06b3          	add	a3,s4,a4
 5c8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5cc:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5ce:	c681                	beqz	a3,5d6 <vprintf+0x7e>
 5d0:	9752                	add	a4,a4,s4
 5d2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5d6:	03878e63          	beq	a5,s8,612 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 5da:	05978863          	beq	a5,s9,62a <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5de:	07500713          	li	a4,117
 5e2:	0ee78263          	beq	a5,a4,6c6 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5e6:	07800713          	li	a4,120
 5ea:	12e78463          	beq	a5,a4,712 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5ee:	07000713          	li	a4,112
 5f2:	14e78963          	beq	a5,a4,744 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5f6:	07300713          	li	a4,115
 5fa:	18e78863          	beq	a5,a4,78a <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5fe:	02500713          	li	a4,37
 602:	04e79463          	bne	a5,a4,64a <vprintf+0xf2>
        putc(fd, '%');
 606:	85ba                	mv	a1,a4
 608:	855a                	mv	a0,s6
 60a:	e9bff0ef          	jal	4a4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 60e:	4981                	li	s3,0
 610:	bf49                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 612:	008b8493          	addi	s1,s7,8
 616:	4685                	li	a3,1
 618:	4629                	li	a2,10
 61a:	000ba583          	lw	a1,0(s7)
 61e:	855a                	mv	a0,s6
 620:	ea3ff0ef          	jal	4c2 <printint>
 624:	8ba6                	mv	s7,s1
      state = 0;
 626:	4981                	li	s3,0
 628:	bfad                	j	5a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 62a:	06400793          	li	a5,100
 62e:	02f68963          	beq	a3,a5,660 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 632:	06c00793          	li	a5,108
 636:	04f68263          	beq	a3,a5,67a <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 63a:	07500793          	li	a5,117
 63e:	0af68063          	beq	a3,a5,6de <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 642:	07800793          	li	a5,120
 646:	0ef68263          	beq	a3,a5,72a <vprintf+0x1d2>
        putc(fd, '%');
 64a:	02500593          	li	a1,37
 64e:	855a                	mv	a0,s6
 650:	e55ff0ef          	jal	4a4 <putc>
        putc(fd, c0);
 654:	85a6                	mv	a1,s1
 656:	855a                	mv	a0,s6
 658:	e4dff0ef          	jal	4a4 <putc>
      state = 0;
 65c:	4981                	li	s3,0
 65e:	b791                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 660:	008b8493          	addi	s1,s7,8
 664:	4685                	li	a3,1
 666:	4629                	li	a2,10
 668:	000ba583          	lw	a1,0(s7)
 66c:	855a                	mv	a0,s6
 66e:	e55ff0ef          	jal	4c2 <printint>
        i += 1;
 672:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 674:	8ba6                	mv	s7,s1
      state = 0;
 676:	4981                	li	s3,0
        i += 1;
 678:	b72d                	j	5a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 67a:	06400793          	li	a5,100
 67e:	02f60763          	beq	a2,a5,6ac <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 682:	07500793          	li	a5,117
 686:	06f60963          	beq	a2,a5,6f8 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 68a:	07800793          	li	a5,120
 68e:	faf61ee3          	bne	a2,a5,64a <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 692:	008b8493          	addi	s1,s7,8
 696:	4681                	li	a3,0
 698:	4641                	li	a2,16
 69a:	000ba583          	lw	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	e23ff0ef          	jal	4c2 <printint>
        i += 2;
 6a4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a6:	8ba6                	mv	s7,s1
      state = 0;
 6a8:	4981                	li	s3,0
        i += 2;
 6aa:	bde5                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ac:	008b8493          	addi	s1,s7,8
 6b0:	4685                	li	a3,1
 6b2:	4629                	li	a2,10
 6b4:	000ba583          	lw	a1,0(s7)
 6b8:	855a                	mv	a0,s6
 6ba:	e09ff0ef          	jal	4c2 <printint>
        i += 2;
 6be:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c0:	8ba6                	mv	s7,s1
      state = 0;
 6c2:	4981                	li	s3,0
        i += 2;
 6c4:	bdf9                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 6c6:	008b8493          	addi	s1,s7,8
 6ca:	4681                	li	a3,0
 6cc:	4629                	li	a2,10
 6ce:	000ba583          	lw	a1,0(s7)
 6d2:	855a                	mv	a0,s6
 6d4:	defff0ef          	jal	4c2 <printint>
 6d8:	8ba6                	mv	s7,s1
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b5d9                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6de:	008b8493          	addi	s1,s7,8
 6e2:	4681                	li	a3,0
 6e4:	4629                	li	a2,10
 6e6:	000ba583          	lw	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	dd7ff0ef          	jal	4c2 <printint>
        i += 1;
 6f0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f2:	8ba6                	mv	s7,s1
      state = 0;
 6f4:	4981                	li	s3,0
        i += 1;
 6f6:	b575                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f8:	008b8493          	addi	s1,s7,8
 6fc:	4681                	li	a3,0
 6fe:	4629                	li	a2,10
 700:	000ba583          	lw	a1,0(s7)
 704:	855a                	mv	a0,s6
 706:	dbdff0ef          	jal	4c2 <printint>
        i += 2;
 70a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 70c:	8ba6                	mv	s7,s1
      state = 0;
 70e:	4981                	li	s3,0
        i += 2;
 710:	bd49                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 712:	008b8493          	addi	s1,s7,8
 716:	4681                	li	a3,0
 718:	4641                	li	a2,16
 71a:	000ba583          	lw	a1,0(s7)
 71e:	855a                	mv	a0,s6
 720:	da3ff0ef          	jal	4c2 <printint>
 724:	8ba6                	mv	s7,s1
      state = 0;
 726:	4981                	li	s3,0
 728:	bdad                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 72a:	008b8493          	addi	s1,s7,8
 72e:	4681                	li	a3,0
 730:	4641                	li	a2,16
 732:	000ba583          	lw	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	d8bff0ef          	jal	4c2 <printint>
        i += 1;
 73c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 73e:	8ba6                	mv	s7,s1
      state = 0;
 740:	4981                	li	s3,0
        i += 1;
 742:	b585                	j	5a2 <vprintf+0x4a>
 744:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 746:	008b8d13          	addi	s10,s7,8
 74a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 74e:	03000593          	li	a1,48
 752:	855a                	mv	a0,s6
 754:	d51ff0ef          	jal	4a4 <putc>
  putc(fd, 'x');
 758:	07800593          	li	a1,120
 75c:	855a                	mv	a0,s6
 75e:	d47ff0ef          	jal	4a4 <putc>
 762:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 764:	00000b97          	auipc	s7,0x0
 768:	284b8b93          	addi	s7,s7,644 # 9e8 <digits>
 76c:	03c9d793          	srli	a5,s3,0x3c
 770:	97de                	add	a5,a5,s7
 772:	0007c583          	lbu	a1,0(a5)
 776:	855a                	mv	a0,s6
 778:	d2dff0ef          	jal	4a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 77c:	0992                	slli	s3,s3,0x4
 77e:	34fd                	addiw	s1,s1,-1
 780:	f4f5                	bnez	s1,76c <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 782:	8bea                	mv	s7,s10
      state = 0;
 784:	4981                	li	s3,0
 786:	6d02                	ld	s10,0(sp)
 788:	bd29                	j	5a2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 78a:	008b8993          	addi	s3,s7,8
 78e:	000bb483          	ld	s1,0(s7)
 792:	cc91                	beqz	s1,7ae <vprintf+0x256>
        for(; *s; s++)
 794:	0004c583          	lbu	a1,0(s1)
 798:	c195                	beqz	a1,7bc <vprintf+0x264>
          putc(fd, *s);
 79a:	855a                	mv	a0,s6
 79c:	d09ff0ef          	jal	4a4 <putc>
        for(; *s; s++)
 7a0:	0485                	addi	s1,s1,1
 7a2:	0004c583          	lbu	a1,0(s1)
 7a6:	f9f5                	bnez	a1,79a <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 7a8:	8bce                	mv	s7,s3
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	bbdd                	j	5a2 <vprintf+0x4a>
          s = "(null)";
 7ae:	00000497          	auipc	s1,0x0
 7b2:	23248493          	addi	s1,s1,562 # 9e0 <malloc+0x122>
        for(; *s; s++)
 7b6:	02800593          	li	a1,40
 7ba:	b7c5                	j	79a <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 7bc:	8bce                	mv	s7,s3
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	b3cd                	j	5a2 <vprintf+0x4a>
 7c2:	6906                	ld	s2,64(sp)
 7c4:	79e2                	ld	s3,56(sp)
 7c6:	7a42                	ld	s4,48(sp)
 7c8:	7aa2                	ld	s5,40(sp)
 7ca:	7b02                	ld	s6,32(sp)
 7cc:	6be2                	ld	s7,24(sp)
 7ce:	6c42                	ld	s8,16(sp)
 7d0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7d2:	60e6                	ld	ra,88(sp)
 7d4:	6446                	ld	s0,80(sp)
 7d6:	64a6                	ld	s1,72(sp)
 7d8:	6125                	addi	sp,sp,96
 7da:	8082                	ret

00000000000007dc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7dc:	715d                	addi	sp,sp,-80
 7de:	ec06                	sd	ra,24(sp)
 7e0:	e822                	sd	s0,16(sp)
 7e2:	1000                	addi	s0,sp,32
 7e4:	e010                	sd	a2,0(s0)
 7e6:	e414                	sd	a3,8(s0)
 7e8:	e818                	sd	a4,16(s0)
 7ea:	ec1c                	sd	a5,24(s0)
 7ec:	03043023          	sd	a6,32(s0)
 7f0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7f4:	8622                	mv	a2,s0
 7f6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7fa:	d5fff0ef          	jal	558 <vprintf>
}
 7fe:	60e2                	ld	ra,24(sp)
 800:	6442                	ld	s0,16(sp)
 802:	6161                	addi	sp,sp,80
 804:	8082                	ret

0000000000000806 <printf>:

void
printf(const char *fmt, ...)
{
 806:	711d                	addi	sp,sp,-96
 808:	ec06                	sd	ra,24(sp)
 80a:	e822                	sd	s0,16(sp)
 80c:	1000                	addi	s0,sp,32
 80e:	e40c                	sd	a1,8(s0)
 810:	e810                	sd	a2,16(s0)
 812:	ec14                	sd	a3,24(s0)
 814:	f018                	sd	a4,32(s0)
 816:	f41c                	sd	a5,40(s0)
 818:	03043823          	sd	a6,48(s0)
 81c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 820:	00840613          	addi	a2,s0,8
 824:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 828:	85aa                	mv	a1,a0
 82a:	4505                	li	a0,1
 82c:	d2dff0ef          	jal	558 <vprintf>
}
 830:	60e2                	ld	ra,24(sp)
 832:	6442                	ld	s0,16(sp)
 834:	6125                	addi	sp,sp,96
 836:	8082                	ret

0000000000000838 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 838:	1141                	addi	sp,sp,-16
 83a:	e406                	sd	ra,8(sp)
 83c:	e022                	sd	s0,0(sp)
 83e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 840:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 844:	00000797          	auipc	a5,0x0
 848:	7bc7b783          	ld	a5,1980(a5) # 1000 <freep>
 84c:	a02d                	j	876 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 84e:	4618                	lw	a4,8(a2)
 850:	9f2d                	addw	a4,a4,a1
 852:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 856:	6398                	ld	a4,0(a5)
 858:	6310                	ld	a2,0(a4)
 85a:	a83d                	j	898 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 85c:	ff852703          	lw	a4,-8(a0)
 860:	9f31                	addw	a4,a4,a2
 862:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 864:	ff053683          	ld	a3,-16(a0)
 868:	a091                	j	8ac <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86a:	6398                	ld	a4,0(a5)
 86c:	00e7e463          	bltu	a5,a4,874 <free+0x3c>
 870:	00e6ea63          	bltu	a3,a4,884 <free+0x4c>
{
 874:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 876:	fed7fae3          	bgeu	a5,a3,86a <free+0x32>
 87a:	6398                	ld	a4,0(a5)
 87c:	00e6e463          	bltu	a3,a4,884 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 880:	fee7eae3          	bltu	a5,a4,874 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 884:	ff852583          	lw	a1,-8(a0)
 888:	6390                	ld	a2,0(a5)
 88a:	02059813          	slli	a6,a1,0x20
 88e:	01c85713          	srli	a4,a6,0x1c
 892:	9736                	add	a4,a4,a3
 894:	fae60de3          	beq	a2,a4,84e <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 898:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 89c:	4790                	lw	a2,8(a5)
 89e:	02061593          	slli	a1,a2,0x20
 8a2:	01c5d713          	srli	a4,a1,0x1c
 8a6:	973e                	add	a4,a4,a5
 8a8:	fae68ae3          	beq	a3,a4,85c <free+0x24>
    p->s.ptr = bp->s.ptr;
 8ac:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	74f73923          	sd	a5,1874(a4) # 1000 <freep>
}
 8b6:	60a2                	ld	ra,8(sp)
 8b8:	6402                	ld	s0,0(sp)
 8ba:	0141                	addi	sp,sp,16
 8bc:	8082                	ret

00000000000008be <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8be:	7139                	addi	sp,sp,-64
 8c0:	fc06                	sd	ra,56(sp)
 8c2:	f822                	sd	s0,48(sp)
 8c4:	f04a                	sd	s2,32(sp)
 8c6:	ec4e                	sd	s3,24(sp)
 8c8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ca:	02051993          	slli	s3,a0,0x20
 8ce:	0209d993          	srli	s3,s3,0x20
 8d2:	09bd                	addi	s3,s3,15
 8d4:	0049d993          	srli	s3,s3,0x4
 8d8:	2985                	addiw	s3,s3,1
 8da:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8dc:	00000517          	auipc	a0,0x0
 8e0:	72453503          	ld	a0,1828(a0) # 1000 <freep>
 8e4:	c905                	beqz	a0,914 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e8:	4798                	lw	a4,8(a5)
 8ea:	09377663          	bgeu	a4,s3,976 <malloc+0xb8>
 8ee:	f426                	sd	s1,40(sp)
 8f0:	e852                	sd	s4,16(sp)
 8f2:	e456                	sd	s5,8(sp)
 8f4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8f6:	8a4e                	mv	s4,s3
 8f8:	6705                	lui	a4,0x1
 8fa:	00e9f363          	bgeu	s3,a4,900 <malloc+0x42>
 8fe:	6a05                	lui	s4,0x1
 900:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 904:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 908:	00000497          	auipc	s1,0x0
 90c:	6f848493          	addi	s1,s1,1784 # 1000 <freep>
  if(p == (char*)-1)
 910:	5afd                	li	s5,-1
 912:	a83d                	j	950 <malloc+0x92>
 914:	f426                	sd	s1,40(sp)
 916:	e852                	sd	s4,16(sp)
 918:	e456                	sd	s5,8(sp)
 91a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 91c:	00000797          	auipc	a5,0x0
 920:	6f478793          	addi	a5,a5,1780 # 1010 <base>
 924:	00000717          	auipc	a4,0x0
 928:	6cf73e23          	sd	a5,1756(a4) # 1000 <freep>
 92c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 92e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 932:	b7d1                	j	8f6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 934:	6398                	ld	a4,0(a5)
 936:	e118                	sd	a4,0(a0)
 938:	a899                	j	98e <malloc+0xd0>
  hp->s.size = nu;
 93a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 93e:	0541                	addi	a0,a0,16
 940:	ef9ff0ef          	jal	838 <free>
  return freep;
 944:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 946:	c125                	beqz	a0,9a6 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 948:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 94a:	4798                	lw	a4,8(a5)
 94c:	03277163          	bgeu	a4,s2,96e <malloc+0xb0>
    if(p == freep)
 950:	6098                	ld	a4,0(s1)
 952:	853e                	mv	a0,a5
 954:	fef71ae3          	bne	a4,a5,948 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 958:	8552                	mv	a0,s4
 95a:	b2bff0ef          	jal	484 <sbrk>
  if(p == (char*)-1)
 95e:	fd551ee3          	bne	a0,s5,93a <malloc+0x7c>
        return 0;
 962:	4501                	li	a0,0
 964:	74a2                	ld	s1,40(sp)
 966:	6a42                	ld	s4,16(sp)
 968:	6aa2                	ld	s5,8(sp)
 96a:	6b02                	ld	s6,0(sp)
 96c:	a03d                	j	99a <malloc+0xdc>
 96e:	74a2                	ld	s1,40(sp)
 970:	6a42                	ld	s4,16(sp)
 972:	6aa2                	ld	s5,8(sp)
 974:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 976:	fae90fe3          	beq	s2,a4,934 <malloc+0x76>
        p->s.size -= nunits;
 97a:	4137073b          	subw	a4,a4,s3
 97e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 980:	02071693          	slli	a3,a4,0x20
 984:	01c6d713          	srli	a4,a3,0x1c
 988:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 98a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 98e:	00000717          	auipc	a4,0x0
 992:	66a73923          	sd	a0,1650(a4) # 1000 <freep>
      return (void*)(p + 1);
 996:	01078513          	addi	a0,a5,16
  }
}
 99a:	70e2                	ld	ra,56(sp)
 99c:	7442                	ld	s0,48(sp)
 99e:	7902                	ld	s2,32(sp)
 9a0:	69e2                	ld	s3,24(sp)
 9a2:	6121                	addi	sp,sp,64
 9a4:	8082                	ret
 9a6:	74a2                	ld	s1,40(sp)
 9a8:	6a42                	ld	s4,16(sp)
 9aa:	6aa2                	ld	s5,8(sp)
 9ac:	6b02                	ld	s6,0(sp)
 9ae:	b7f5                	j	99a <malloc+0xdc>
