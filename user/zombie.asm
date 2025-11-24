
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	380000ef          	jal	388 <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    sleep(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	37e000ef          	jal	390 <exit>
    sleep(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	408000ef          	jal	420 <sleep>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	addi	s0,sp,16
  extern int main();
  main();
  26:	fdbff0ef          	jal	0 <main>
  exit(0);
  2a:	4501                	li	a0,0
  2c:	364000ef          	jal	390 <exit>

0000000000000030 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  30:	1141                	addi	sp,sp,-16
  32:	e406                	sd	ra,8(sp)
  34:	e022                	sd	s0,0(sp)
  36:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  38:	87aa                	mv	a5,a0
  3a:	0585                	addi	a1,a1,1
  3c:	0785                	addi	a5,a5,1
  3e:	fff5c703          	lbu	a4,-1(a1)
  42:	fee78fa3          	sb	a4,-1(a5)
  46:	fb75                	bnez	a4,3a <strcpy+0xa>
    ;
  return os;
}
  48:	60a2                	ld	ra,8(sp)
  4a:	6402                	ld	s0,0(sp)
  4c:	0141                	addi	sp,sp,16
  4e:	8082                	ret

0000000000000050 <strcmp>:

int strcmp(const char *p, const char *q)
{
  50:	1141                	addi	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  58:	00054783          	lbu	a5,0(a0)
  5c:	cb91                	beqz	a5,70 <strcmp+0x20>
  5e:	0005c703          	lbu	a4,0(a1)
  62:	00f71763          	bne	a4,a5,70 <strcmp+0x20>
    p++, q++;
  66:	0505                	addi	a0,a0,1
  68:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  6a:	00054783          	lbu	a5,0(a0)
  6e:	fbe5                	bnez	a5,5e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  70:	0005c503          	lbu	a0,0(a1)
}
  74:	40a7853b          	subw	a0,a5,a0
  78:	60a2                	ld	ra,8(sp)
  7a:	6402                	ld	s0,0(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strlen>:

uint strlen(const char *s)
{
  80:	1141                	addi	sp,sp,-16
  82:	e406                	sd	ra,8(sp)
  84:	e022                	sd	s0,0(sp)
  86:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cf99                	beqz	a5,aa <strlen+0x2a>
  8e:	0505                	addi	a0,a0,1
  90:	87aa                	mv	a5,a0
  92:	86be                	mv	a3,a5
  94:	0785                	addi	a5,a5,1
  96:	fff7c703          	lbu	a4,-1(a5)
  9a:	ff65                	bnez	a4,92 <strlen+0x12>
  9c:	40a6853b          	subw	a0,a3,a0
  a0:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  a2:	60a2                	ld	ra,8(sp)
  a4:	6402                	ld	s0,0(sp)
  a6:	0141                	addi	sp,sp,16
  a8:	8082                	ret
  for (n = 0; s[n]; n++)
  aa:	4501                	li	a0,0
  ac:	bfdd                	j	a2 <strlen+0x22>

00000000000000ae <memset>:

void *
memset(void *dst, int c, uint n)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  b6:	ca19                	beqz	a2,cc <memset+0x1e>
  b8:	87aa                	mv	a5,a0
  ba:	1602                	slli	a2,a2,0x20
  bc:	9201                	srli	a2,a2,0x20
  be:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
  c2:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  c6:	0785                	addi	a5,a5,1
  c8:	fee79de3          	bne	a5,a4,c2 <memset+0x14>
  }
  return dst;
}
  cc:	60a2                	ld	ra,8(sp)
  ce:	6402                	ld	s0,0(sp)
  d0:	0141                	addi	sp,sp,16
  d2:	8082                	ret

00000000000000d4 <strchr>:

char *
strchr(const char *s, char c)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e406                	sd	ra,8(sp)
  d8:	e022                	sd	s0,0(sp)
  da:	0800                	addi	s0,sp,16
  for (; *s; s++)
  dc:	00054783          	lbu	a5,0(a0)
  e0:	cf81                	beqz	a5,f8 <strchr+0x24>
    if (*s == c)
  e2:	00f58763          	beq	a1,a5,f0 <strchr+0x1c>
  for (; *s; s++)
  e6:	0505                	addi	a0,a0,1
  e8:	00054783          	lbu	a5,0(a0)
  ec:	fbfd                	bnez	a5,e2 <strchr+0xe>
      return (char *)s;
  return 0;
  ee:	4501                	li	a0,0
}
  f0:	60a2                	ld	ra,8(sp)
  f2:	6402                	ld	s0,0(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret
  return 0;
  f8:	4501                	li	a0,0
  fa:	bfdd                	j	f0 <strchr+0x1c>

00000000000000fc <gets>:

char *
gets(char *buf, int max)
{
  fc:	7159                	addi	sp,sp,-112
  fe:	f486                	sd	ra,104(sp)
 100:	f0a2                	sd	s0,96(sp)
 102:	eca6                	sd	s1,88(sp)
 104:	e8ca                	sd	s2,80(sp)
 106:	e4ce                	sd	s3,72(sp)
 108:	e0d2                	sd	s4,64(sp)
 10a:	fc56                	sd	s5,56(sp)
 10c:	f85a                	sd	s6,48(sp)
 10e:	f45e                	sd	s7,40(sp)
 110:	f062                	sd	s8,32(sp)
 112:	ec66                	sd	s9,24(sp)
 114:	e86a                	sd	s10,16(sp)
 116:	1880                	addi	s0,sp,112
 118:	8caa                	mv	s9,a0
 11a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 11c:	892a                	mv	s2,a0
 11e:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 120:	f9f40b13          	addi	s6,s0,-97
 124:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 126:	4ba9                	li	s7,10
 128:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 12a:	8d26                	mv	s10,s1
 12c:	0014899b          	addiw	s3,s1,1
 130:	84ce                	mv	s1,s3
 132:	0349d563          	bge	s3,s4,15c <gets+0x60>
    cc = read(0, &c, 1);
 136:	8656                	mv	a2,s5
 138:	85da                	mv	a1,s6
 13a:	4501                	li	a0,0
 13c:	26c000ef          	jal	3a8 <read>
    if (cc < 1)
 140:	00a05e63          	blez	a0,15c <gets+0x60>
    buf[i++] = c;
 144:	f9f44783          	lbu	a5,-97(s0)
 148:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 14c:	01778763          	beq	a5,s7,15a <gets+0x5e>
 150:	0905                	addi	s2,s2,1
 152:	fd879ce3          	bne	a5,s8,12a <gets+0x2e>
    buf[i++] = c;
 156:	8d4e                	mv	s10,s3
 158:	a011                	j	15c <gets+0x60>
 15a:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 15c:	9d66                	add	s10,s10,s9
 15e:	000d0023          	sb	zero,0(s10)
  return buf;
}
 162:	8566                	mv	a0,s9
 164:	70a6                	ld	ra,104(sp)
 166:	7406                	ld	s0,96(sp)
 168:	64e6                	ld	s1,88(sp)
 16a:	6946                	ld	s2,80(sp)
 16c:	69a6                	ld	s3,72(sp)
 16e:	6a06                	ld	s4,64(sp)
 170:	7ae2                	ld	s5,56(sp)
 172:	7b42                	ld	s6,48(sp)
 174:	7ba2                	ld	s7,40(sp)
 176:	7c02                	ld	s8,32(sp)
 178:	6ce2                	ld	s9,24(sp)
 17a:	6d42                	ld	s10,16(sp)
 17c:	6165                	addi	sp,sp,112
 17e:	8082                	ret

0000000000000180 <stat>:

int stat(const char *n, struct stat *st)
{
 180:	1101                	addi	sp,sp,-32
 182:	ec06                	sd	ra,24(sp)
 184:	e822                	sd	s0,16(sp)
 186:	e04a                	sd	s2,0(sp)
 188:	1000                	addi	s0,sp,32
 18a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18c:	4581                	li	a1,0
 18e:	242000ef          	jal	3d0 <open>
  if (fd < 0)
 192:	02054263          	bltz	a0,1b6 <stat+0x36>
 196:	e426                	sd	s1,8(sp)
 198:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19a:	85ca                	mv	a1,s2
 19c:	24c000ef          	jal	3e8 <fstat>
 1a0:	892a                	mv	s2,a0
  close(fd);
 1a2:	8526                	mv	a0,s1
 1a4:	214000ef          	jal	3b8 <close>
  return r;
 1a8:	64a2                	ld	s1,8(sp)
}
 1aa:	854a                	mv	a0,s2
 1ac:	60e2                	ld	ra,24(sp)
 1ae:	6442                	ld	s0,16(sp)
 1b0:	6902                	ld	s2,0(sp)
 1b2:	6105                	addi	sp,sp,32
 1b4:	8082                	ret
    return -1;
 1b6:	597d                	li	s2,-1
 1b8:	bfcd                	j	1aa <stat+0x2a>

00000000000001ba <atoi>:

int atoi(const char *s)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e406                	sd	ra,8(sp)
 1be:	e022                	sd	s0,0(sp)
 1c0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1c2:	00054683          	lbu	a3,0(a0)
 1c6:	fd06879b          	addiw	a5,a3,-48
 1ca:	0ff7f793          	zext.b	a5,a5
 1ce:	4625                	li	a2,9
 1d0:	02f66963          	bltu	a2,a5,202 <atoi+0x48>
 1d4:	872a                	mv	a4,a0
  n = 0;
 1d6:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1d8:	0705                	addi	a4,a4,1
 1da:	0025179b          	slliw	a5,a0,0x2
 1de:	9fa9                	addw	a5,a5,a0
 1e0:	0017979b          	slliw	a5,a5,0x1
 1e4:	9fb5                	addw	a5,a5,a3
 1e6:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 1ea:	00074683          	lbu	a3,0(a4)
 1ee:	fd06879b          	addiw	a5,a3,-48
 1f2:	0ff7f793          	zext.b	a5,a5
 1f6:	fef671e3          	bgeu	a2,a5,1d8 <atoi+0x1e>
  return n;
}
 1fa:	60a2                	ld	ra,8(sp)
 1fc:	6402                	ld	s0,0(sp)
 1fe:	0141                	addi	sp,sp,16
 200:	8082                	ret
  n = 0;
 202:	4501                	li	a0,0
 204:	bfdd                	j	1fa <atoi+0x40>

0000000000000206 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 206:	1141                	addi	sp,sp,-16
 208:	e406                	sd	ra,8(sp)
 20a:	e022                	sd	s0,0(sp)
 20c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 20e:	02b57563          	bgeu	a0,a1,238 <memmove+0x32>
  {
    while (n-- > 0)
 212:	00c05f63          	blez	a2,230 <memmove+0x2a>
 216:	1602                	slli	a2,a2,0x20
 218:	9201                	srli	a2,a2,0x20
 21a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 21e:	872a                	mv	a4,a0
      *dst++ = *src++;
 220:	0585                	addi	a1,a1,1
 222:	0705                	addi	a4,a4,1
 224:	fff5c683          	lbu	a3,-1(a1)
 228:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 22c:	fee79ae3          	bne	a5,a4,220 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 230:	60a2                	ld	ra,8(sp)
 232:	6402                	ld	s0,0(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
    dst += n;
 238:	00c50733          	add	a4,a0,a2
    src += n;
 23c:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 23e:	fec059e3          	blez	a2,230 <memmove+0x2a>
 242:	fff6079b          	addiw	a5,a2,-1
 246:	1782                	slli	a5,a5,0x20
 248:	9381                	srli	a5,a5,0x20
 24a:	fff7c793          	not	a5,a5
 24e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 250:	15fd                	addi	a1,a1,-1
 252:	177d                	addi	a4,a4,-1
 254:	0005c683          	lbu	a3,0(a1)
 258:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 25c:	fef71ae3          	bne	a4,a5,250 <memmove+0x4a>
 260:	bfc1                	j	230 <memmove+0x2a>

0000000000000262 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 262:	1141                	addi	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 26a:	ca0d                	beqz	a2,29c <memcmp+0x3a>
 26c:	fff6069b          	addiw	a3,a2,-1
 270:	1682                	slli	a3,a3,0x20
 272:	9281                	srli	a3,a3,0x20
 274:	0685                	addi	a3,a3,1
 276:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 278:	00054783          	lbu	a5,0(a0)
 27c:	0005c703          	lbu	a4,0(a1)
 280:	00e79863          	bne	a5,a4,290 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 284:	0505                	addi	a0,a0,1
    p2++;
 286:	0585                	addi	a1,a1,1
  while (n-- > 0)
 288:	fed518e3          	bne	a0,a3,278 <memcmp+0x16>
  }
  return 0;
 28c:	4501                	li	a0,0
 28e:	a019                	j	294 <memcmp+0x32>
      return *p1 - *p2;
 290:	40e7853b          	subw	a0,a5,a4
}
 294:	60a2                	ld	ra,8(sp)
 296:	6402                	ld	s0,0(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret
  return 0;
 29c:	4501                	li	a0,0
 29e:	bfdd                	j	294 <memcmp+0x32>

00000000000002a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e406                	sd	ra,8(sp)
 2a4:	e022                	sd	s0,0(sp)
 2a6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a8:	f5fff0ef          	jal	206 <memmove>
}
 2ac:	60a2                	ld	ra,8(sp)
 2ae:	6402                	ld	s0,0(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <strcat>:

char *strcat(char *dst, const char *src)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 2bc:	00054783          	lbu	a5,0(a0)
 2c0:	c795                	beqz	a5,2ec <strcat+0x38>
  char *p = dst;
 2c2:	87aa                	mv	a5,a0
    p++;
 2c4:	0785                	addi	a5,a5,1
  while (*p)
 2c6:	0007c703          	lbu	a4,0(a5)
 2ca:	ff6d                	bnez	a4,2c4 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 2cc:	0005c703          	lbu	a4,0(a1)
 2d0:	cb01                	beqz	a4,2e0 <strcat+0x2c>
  {
    *p = *src;
 2d2:	00e78023          	sb	a4,0(a5)
    p++;
 2d6:	0785                	addi	a5,a5,1
    src++;
 2d8:	0585                	addi	a1,a1,1
  while (*src)
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	fb75                	bnez	a4,2d2 <strcat+0x1e>
  }

  *p = 0;
 2e0:	00078023          	sb	zero,0(a5)

  return dst;
}
 2e4:	60a2                	ld	ra,8(sp)
 2e6:	6402                	ld	s0,0(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
  char *p = dst;
 2ec:	87aa                	mv	a5,a0
 2ee:	bff9                	j	2cc <strcat+0x18>

00000000000002f0 <isdir>:

int isdir(char *path)
{
 2f0:	7179                	addi	sp,sp,-48
 2f2:	f406                	sd	ra,40(sp)
 2f4:	f022                	sd	s0,32(sp)
 2f6:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 2f8:	fd840593          	addi	a1,s0,-40
 2fc:	e85ff0ef          	jal	180 <stat>
 300:	00054b63          	bltz	a0,316 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 304:	fe041503          	lh	a0,-32(s0)
 308:	157d                	addi	a0,a0,-1
 30a:	00153513          	seqz	a0,a0
}
 30e:	70a2                	ld	ra,40(sp)
 310:	7402                	ld	s0,32(sp)
 312:	6145                	addi	sp,sp,48
 314:	8082                	ret
    return 0;
 316:	4501                	li	a0,0
 318:	bfdd                	j	30e <isdir+0x1e>

000000000000031a <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 31a:	7139                	addi	sp,sp,-64
 31c:	fc06                	sd	ra,56(sp)
 31e:	f822                	sd	s0,48(sp)
 320:	f426                	sd	s1,40(sp)
 322:	f04a                	sd	s2,32(sp)
 324:	ec4e                	sd	s3,24(sp)
 326:	e852                	sd	s4,16(sp)
 328:	e456                	sd	s5,8(sp)
 32a:	0080                	addi	s0,sp,64
 32c:	89aa                	mv	s3,a0
 32e:	8aae                	mv	s5,a1
 330:	84b2                	mv	s1,a2
 332:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 334:	d4dff0ef          	jal	80 <strlen>
 338:	892a                	mv	s2,a0
  int nn = strlen(filename);
 33a:	8556                	mv	a0,s5
 33c:	d45ff0ef          	jal	80 <strlen>
  int need = dn + 1 + nn + 1;
 340:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 344:	9fa9                	addw	a5,a5,a0
    return 0;
 346:	4501                	li	a0,0
  if (need > bufsize)
 348:	0347d763          	bge	a5,s4,376 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 34c:	85ce                	mv	a1,s3
 34e:	8526                	mv	a0,s1
 350:	ce1ff0ef          	jal	30 <strcpy>
  if (dir[dn - 1] != '/')
 354:	99ca                	add	s3,s3,s2
 356:	fff9c703          	lbu	a4,-1(s3)
 35a:	02f00793          	li	a5,47
 35e:	00f70763          	beq	a4,a5,36c <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 362:	9926                	add	s2,s2,s1
 364:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 368:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 36c:	85d6                	mv	a1,s5
 36e:	8526                	mv	a0,s1
 370:	f45ff0ef          	jal	2b4 <strcat>
  return out_buffer;
 374:	8526                	mv	a0,s1
}
 376:	70e2                	ld	ra,56(sp)
 378:	7442                	ld	s0,48(sp)
 37a:	74a2                	ld	s1,40(sp)
 37c:	7902                	ld	s2,32(sp)
 37e:	69e2                	ld	s3,24(sp)
 380:	6a42                	ld	s4,16(sp)
 382:	6aa2                	ld	s5,8(sp)
 384:	6121                	addi	sp,sp,64
 386:	8082                	ret

0000000000000388 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 388:	4885                	li	a7,1
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <exit>:
.global exit
exit:
 li a7, SYS_exit
 390:	4889                	li	a7,2
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <wait>:
.global wait
wait:
 li a7, SYS_wait
 398:	488d                	li	a7,3
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a0:	4891                	li	a7,4
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <read>:
.global read
read:
 li a7, SYS_read
 3a8:	4895                	li	a7,5
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <write>:
.global write
write:
 li a7, SYS_write
 3b0:	48c1                	li	a7,16
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <close>:
.global close
close:
 li a7, SYS_close
 3b8:	48d5                	li	a7,21
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c0:	4899                	li	a7,6
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c8:	489d                	li	a7,7
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <open>:
.global open
open:
 li a7, SYS_open
 3d0:	48bd                	li	a7,15
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d8:	48c5                	li	a7,17
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e0:	48c9                	li	a7,18
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e8:	48a1                	li	a7,8
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <link>:
.global link
link:
 li a7, SYS_link
 3f0:	48cd                	li	a7,19
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f8:	48d1                	li	a7,20
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 400:	48a5                	li	a7,9
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <dup>:
.global dup
dup:
 li a7, SYS_dup
 408:	48a9                	li	a7,10
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 410:	48ad                	li	a7,11
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 418:	48b1                	li	a7,12
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 420:	48b5                	li	a7,13
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 428:	48b9                	li	a7,14
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 430:	48d9                	li	a7,22
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 438:	1101                	addi	sp,sp,-32
 43a:	ec06                	sd	ra,24(sp)
 43c:	e822                	sd	s0,16(sp)
 43e:	1000                	addi	s0,sp,32
 440:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 444:	4605                	li	a2,1
 446:	fef40593          	addi	a1,s0,-17
 44a:	f67ff0ef          	jal	3b0 <write>
}
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 456:	7139                	addi	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f426                	sd	s1,40(sp)
 45e:	f04a                	sd	s2,32(sp)
 460:	ec4e                	sd	s3,24(sp)
 462:	0080                	addi	s0,sp,64
 464:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 466:	c299                	beqz	a3,46c <printint+0x16>
 468:	0605ce63          	bltz	a1,4e4 <printint+0x8e>
  neg = 0;
 46c:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 46e:	fc040313          	addi	t1,s0,-64
  neg = 0;
 472:	869a                	mv	a3,t1
  i = 0;
 474:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 476:	00000817          	auipc	a6,0x0
 47a:	4e280813          	addi	a6,a6,1250 # 958 <digits>
 47e:	88be                	mv	a7,a5
 480:	0017851b          	addiw	a0,a5,1
 484:	87aa                	mv	a5,a0
 486:	02c5f73b          	remuw	a4,a1,a2
 48a:	1702                	slli	a4,a4,0x20
 48c:	9301                	srli	a4,a4,0x20
 48e:	9742                	add	a4,a4,a6
 490:	00074703          	lbu	a4,0(a4)
 494:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 498:	872e                	mv	a4,a1
 49a:	02c5d5bb          	divuw	a1,a1,a2
 49e:	0685                	addi	a3,a3,1
 4a0:	fcc77fe3          	bgeu	a4,a2,47e <printint+0x28>
  if(neg)
 4a4:	000e0c63          	beqz	t3,4bc <printint+0x66>
    buf[i++] = '-';
 4a8:	fd050793          	addi	a5,a0,-48
 4ac:	00878533          	add	a0,a5,s0
 4b0:	02d00793          	li	a5,45
 4b4:	fef50823          	sb	a5,-16(a0)
 4b8:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4bc:	fff7899b          	addiw	s3,a5,-1
 4c0:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4c4:	fff4c583          	lbu	a1,-1(s1)
 4c8:	854a                	mv	a0,s2
 4ca:	f6fff0ef          	jal	438 <putc>
  while(--i >= 0)
 4ce:	39fd                	addiw	s3,s3,-1
 4d0:	14fd                	addi	s1,s1,-1
 4d2:	fe09d9e3          	bgez	s3,4c4 <printint+0x6e>
}
 4d6:	70e2                	ld	ra,56(sp)
 4d8:	7442                	ld	s0,48(sp)
 4da:	74a2                	ld	s1,40(sp)
 4dc:	7902                	ld	s2,32(sp)
 4de:	69e2                	ld	s3,24(sp)
 4e0:	6121                	addi	sp,sp,64
 4e2:	8082                	ret
    x = -xx;
 4e4:	40b005bb          	negw	a1,a1
    neg = 1;
 4e8:	4e05                	li	t3,1
    x = -xx;
 4ea:	b751                	j	46e <printint+0x18>

00000000000004ec <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ec:	711d                	addi	sp,sp,-96
 4ee:	ec86                	sd	ra,88(sp)
 4f0:	e8a2                	sd	s0,80(sp)
 4f2:	e4a6                	sd	s1,72(sp)
 4f4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f6:	0005c483          	lbu	s1,0(a1)
 4fa:	26048663          	beqz	s1,766 <vprintf+0x27a>
 4fe:	e0ca                	sd	s2,64(sp)
 500:	fc4e                	sd	s3,56(sp)
 502:	f852                	sd	s4,48(sp)
 504:	f456                	sd	s5,40(sp)
 506:	f05a                	sd	s6,32(sp)
 508:	ec5e                	sd	s7,24(sp)
 50a:	e862                	sd	s8,16(sp)
 50c:	e466                	sd	s9,8(sp)
 50e:	8b2a                	mv	s6,a0
 510:	8a2e                	mv	s4,a1
 512:	8bb2                	mv	s7,a2
  state = 0;
 514:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 516:	4901                	li	s2,0
 518:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 51a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 51e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 522:	06c00c93          	li	s9,108
 526:	a00d                	j	548 <vprintf+0x5c>
        putc(fd, c0);
 528:	85a6                	mv	a1,s1
 52a:	855a                	mv	a0,s6
 52c:	f0dff0ef          	jal	438 <putc>
 530:	a019                	j	536 <vprintf+0x4a>
    } else if(state == '%'){
 532:	03598363          	beq	s3,s5,558 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 536:	0019079b          	addiw	a5,s2,1
 53a:	893e                	mv	s2,a5
 53c:	873e                	mv	a4,a5
 53e:	97d2                	add	a5,a5,s4
 540:	0007c483          	lbu	s1,0(a5)
 544:	20048963          	beqz	s1,756 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 548:	0004879b          	sext.w	a5,s1
    if(state == 0){
 54c:	fe0993e3          	bnez	s3,532 <vprintf+0x46>
      if(c0 == '%'){
 550:	fd579ce3          	bne	a5,s5,528 <vprintf+0x3c>
        state = '%';
 554:	89be                	mv	s3,a5
 556:	b7c5                	j	536 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 558:	00ea06b3          	add	a3,s4,a4
 55c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 560:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 562:	c681                	beqz	a3,56a <vprintf+0x7e>
 564:	9752                	add	a4,a4,s4
 566:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 56a:	03878e63          	beq	a5,s8,5a6 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 56e:	05978863          	beq	a5,s9,5be <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 572:	07500713          	li	a4,117
 576:	0ee78263          	beq	a5,a4,65a <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 57a:	07800713          	li	a4,120
 57e:	12e78463          	beq	a5,a4,6a6 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 582:	07000713          	li	a4,112
 586:	14e78963          	beq	a5,a4,6d8 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 58a:	07300713          	li	a4,115
 58e:	18e78863          	beq	a5,a4,71e <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 592:	02500713          	li	a4,37
 596:	04e79463          	bne	a5,a4,5de <vprintf+0xf2>
        putc(fd, '%');
 59a:	85ba                	mv	a1,a4
 59c:	855a                	mv	a0,s6
 59e:	e9bff0ef          	jal	438 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5a2:	4981                	li	s3,0
 5a4:	bf49                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5a6:	008b8493          	addi	s1,s7,8
 5aa:	4685                	li	a3,1
 5ac:	4629                	li	a2,10
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	855a                	mv	a0,s6
 5b4:	ea3ff0ef          	jal	456 <printint>
 5b8:	8ba6                	mv	s7,s1
      state = 0;
 5ba:	4981                	li	s3,0
 5bc:	bfad                	j	536 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5be:	06400793          	li	a5,100
 5c2:	02f68963          	beq	a3,a5,5f4 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5c6:	06c00793          	li	a5,108
 5ca:	04f68263          	beq	a3,a5,60e <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 5ce:	07500793          	li	a5,117
 5d2:	0af68063          	beq	a3,a5,672 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 5d6:	07800793          	li	a5,120
 5da:	0ef68263          	beq	a3,a5,6be <vprintf+0x1d2>
        putc(fd, '%');
 5de:	02500593          	li	a1,37
 5e2:	855a                	mv	a0,s6
 5e4:	e55ff0ef          	jal	438 <putc>
        putc(fd, c0);
 5e8:	85a6                	mv	a1,s1
 5ea:	855a                	mv	a0,s6
 5ec:	e4dff0ef          	jal	438 <putc>
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	b791                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f4:	008b8493          	addi	s1,s7,8
 5f8:	4685                	li	a3,1
 5fa:	4629                	li	a2,10
 5fc:	000ba583          	lw	a1,0(s7)
 600:	855a                	mv	a0,s6
 602:	e55ff0ef          	jal	456 <printint>
        i += 1;
 606:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 608:	8ba6                	mv	s7,s1
      state = 0;
 60a:	4981                	li	s3,0
        i += 1;
 60c:	b72d                	j	536 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 60e:	06400793          	li	a5,100
 612:	02f60763          	beq	a2,a5,640 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 616:	07500793          	li	a5,117
 61a:	06f60963          	beq	a2,a5,68c <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 61e:	07800793          	li	a5,120
 622:	faf61ee3          	bne	a2,a5,5de <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 626:	008b8493          	addi	s1,s7,8
 62a:	4681                	li	a3,0
 62c:	4641                	li	a2,16
 62e:	000ba583          	lw	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	e23ff0ef          	jal	456 <printint>
        i += 2;
 638:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 63a:	8ba6                	mv	s7,s1
      state = 0;
 63c:	4981                	li	s3,0
        i += 2;
 63e:	bde5                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 640:	008b8493          	addi	s1,s7,8
 644:	4685                	li	a3,1
 646:	4629                	li	a2,10
 648:	000ba583          	lw	a1,0(s7)
 64c:	855a                	mv	a0,s6
 64e:	e09ff0ef          	jal	456 <printint>
        i += 2;
 652:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 654:	8ba6                	mv	s7,s1
      state = 0;
 656:	4981                	li	s3,0
        i += 2;
 658:	bdf9                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 65a:	008b8493          	addi	s1,s7,8
 65e:	4681                	li	a3,0
 660:	4629                	li	a2,10
 662:	000ba583          	lw	a1,0(s7)
 666:	855a                	mv	a0,s6
 668:	defff0ef          	jal	456 <printint>
 66c:	8ba6                	mv	s7,s1
      state = 0;
 66e:	4981                	li	s3,0
 670:	b5d9                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 672:	008b8493          	addi	s1,s7,8
 676:	4681                	li	a3,0
 678:	4629                	li	a2,10
 67a:	000ba583          	lw	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	dd7ff0ef          	jal	456 <printint>
        i += 1;
 684:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 686:	8ba6                	mv	s7,s1
      state = 0;
 688:	4981                	li	s3,0
        i += 1;
 68a:	b575                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 68c:	008b8493          	addi	s1,s7,8
 690:	4681                	li	a3,0
 692:	4629                	li	a2,10
 694:	000ba583          	lw	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	dbdff0ef          	jal	456 <printint>
        i += 2;
 69e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a0:	8ba6                	mv	s7,s1
      state = 0;
 6a2:	4981                	li	s3,0
        i += 2;
 6a4:	bd49                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6a6:	008b8493          	addi	s1,s7,8
 6aa:	4681                	li	a3,0
 6ac:	4641                	li	a2,16
 6ae:	000ba583          	lw	a1,0(s7)
 6b2:	855a                	mv	a0,s6
 6b4:	da3ff0ef          	jal	456 <printint>
 6b8:	8ba6                	mv	s7,s1
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bdad                	j	536 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4641                	li	a2,16
 6c6:	000ba583          	lw	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	d8bff0ef          	jal	456 <printint>
        i += 1;
 6d0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
        i += 1;
 6d6:	b585                	j	536 <vprintf+0x4a>
 6d8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6da:	008b8d13          	addi	s10,s7,8
 6de:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e2:	03000593          	li	a1,48
 6e6:	855a                	mv	a0,s6
 6e8:	d51ff0ef          	jal	438 <putc>
  putc(fd, 'x');
 6ec:	07800593          	li	a1,120
 6f0:	855a                	mv	a0,s6
 6f2:	d47ff0ef          	jal	438 <putc>
 6f6:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f8:	00000b97          	auipc	s7,0x0
 6fc:	260b8b93          	addi	s7,s7,608 # 958 <digits>
 700:	03c9d793          	srli	a5,s3,0x3c
 704:	97de                	add	a5,a5,s7
 706:	0007c583          	lbu	a1,0(a5)
 70a:	855a                	mv	a0,s6
 70c:	d2dff0ef          	jal	438 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 710:	0992                	slli	s3,s3,0x4
 712:	34fd                	addiw	s1,s1,-1
 714:	f4f5                	bnez	s1,700 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 716:	8bea                	mv	s7,s10
      state = 0;
 718:	4981                	li	s3,0
 71a:	6d02                	ld	s10,0(sp)
 71c:	bd29                	j	536 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 71e:	008b8993          	addi	s3,s7,8
 722:	000bb483          	ld	s1,0(s7)
 726:	cc91                	beqz	s1,742 <vprintf+0x256>
        for(; *s; s++)
 728:	0004c583          	lbu	a1,0(s1)
 72c:	c195                	beqz	a1,750 <vprintf+0x264>
          putc(fd, *s);
 72e:	855a                	mv	a0,s6
 730:	d09ff0ef          	jal	438 <putc>
        for(; *s; s++)
 734:	0485                	addi	s1,s1,1
 736:	0004c583          	lbu	a1,0(s1)
 73a:	f9f5                	bnez	a1,72e <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 73c:	8bce                	mv	s7,s3
      state = 0;
 73e:	4981                	li	s3,0
 740:	bbdd                	j	536 <vprintf+0x4a>
          s = "(null)";
 742:	00000497          	auipc	s1,0x0
 746:	20e48493          	addi	s1,s1,526 # 950 <malloc+0xfe>
        for(; *s; s++)
 74a:	02800593          	li	a1,40
 74e:	b7c5                	j	72e <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 750:	8bce                	mv	s7,s3
      state = 0;
 752:	4981                	li	s3,0
 754:	b3cd                	j	536 <vprintf+0x4a>
 756:	6906                	ld	s2,64(sp)
 758:	79e2                	ld	s3,56(sp)
 75a:	7a42                	ld	s4,48(sp)
 75c:	7aa2                	ld	s5,40(sp)
 75e:	7b02                	ld	s6,32(sp)
 760:	6be2                	ld	s7,24(sp)
 762:	6c42                	ld	s8,16(sp)
 764:	6ca2                	ld	s9,8(sp)
    }
  }
}
 766:	60e6                	ld	ra,88(sp)
 768:	6446                	ld	s0,80(sp)
 76a:	64a6                	ld	s1,72(sp)
 76c:	6125                	addi	sp,sp,96
 76e:	8082                	ret

0000000000000770 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 770:	715d                	addi	sp,sp,-80
 772:	ec06                	sd	ra,24(sp)
 774:	e822                	sd	s0,16(sp)
 776:	1000                	addi	s0,sp,32
 778:	e010                	sd	a2,0(s0)
 77a:	e414                	sd	a3,8(s0)
 77c:	e818                	sd	a4,16(s0)
 77e:	ec1c                	sd	a5,24(s0)
 780:	03043023          	sd	a6,32(s0)
 784:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 788:	8622                	mv	a2,s0
 78a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 78e:	d5fff0ef          	jal	4ec <vprintf>
}
 792:	60e2                	ld	ra,24(sp)
 794:	6442                	ld	s0,16(sp)
 796:	6161                	addi	sp,sp,80
 798:	8082                	ret

000000000000079a <printf>:

void
printf(const char *fmt, ...)
{
 79a:	711d                	addi	sp,sp,-96
 79c:	ec06                	sd	ra,24(sp)
 79e:	e822                	sd	s0,16(sp)
 7a0:	1000                	addi	s0,sp,32
 7a2:	e40c                	sd	a1,8(s0)
 7a4:	e810                	sd	a2,16(s0)
 7a6:	ec14                	sd	a3,24(s0)
 7a8:	f018                	sd	a4,32(s0)
 7aa:	f41c                	sd	a5,40(s0)
 7ac:	03043823          	sd	a6,48(s0)
 7b0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7b4:	00840613          	addi	a2,s0,8
 7b8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7bc:	85aa                	mv	a1,a0
 7be:	4505                	li	a0,1
 7c0:	d2dff0ef          	jal	4ec <vprintf>
}
 7c4:	60e2                	ld	ra,24(sp)
 7c6:	6442                	ld	s0,16(sp)
 7c8:	6125                	addi	sp,sp,96
 7ca:	8082                	ret

00000000000007cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7cc:	1141                	addi	sp,sp,-16
 7ce:	e406                	sd	ra,8(sp)
 7d0:	e022                	sd	s0,0(sp)
 7d2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7d4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d8:	00001797          	auipc	a5,0x1
 7dc:	8287b783          	ld	a5,-2008(a5) # 1000 <freep>
 7e0:	a02d                	j	80a <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e2:	4618                	lw	a4,8(a2)
 7e4:	9f2d                	addw	a4,a4,a1
 7e6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ea:	6398                	ld	a4,0(a5)
 7ec:	6310                	ld	a2,0(a4)
 7ee:	a83d                	j	82c <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f0:	ff852703          	lw	a4,-8(a0)
 7f4:	9f31                	addw	a4,a4,a2
 7f6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7f8:	ff053683          	ld	a3,-16(a0)
 7fc:	a091                	j	840 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fe:	6398                	ld	a4,0(a5)
 800:	00e7e463          	bltu	a5,a4,808 <free+0x3c>
 804:	00e6ea63          	bltu	a3,a4,818 <free+0x4c>
{
 808:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80a:	fed7fae3          	bgeu	a5,a3,7fe <free+0x32>
 80e:	6398                	ld	a4,0(a5)
 810:	00e6e463          	bltu	a3,a4,818 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	fee7eae3          	bltu	a5,a4,808 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 818:	ff852583          	lw	a1,-8(a0)
 81c:	6390                	ld	a2,0(a5)
 81e:	02059813          	slli	a6,a1,0x20
 822:	01c85713          	srli	a4,a6,0x1c
 826:	9736                	add	a4,a4,a3
 828:	fae60de3          	beq	a2,a4,7e2 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 82c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 830:	4790                	lw	a2,8(a5)
 832:	02061593          	slli	a1,a2,0x20
 836:	01c5d713          	srli	a4,a1,0x1c
 83a:	973e                	add	a4,a4,a5
 83c:	fae68ae3          	beq	a3,a4,7f0 <free+0x24>
    p->s.ptr = bp->s.ptr;
 840:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 842:	00000717          	auipc	a4,0x0
 846:	7af73f23          	sd	a5,1982(a4) # 1000 <freep>
}
 84a:	60a2                	ld	ra,8(sp)
 84c:	6402                	ld	s0,0(sp)
 84e:	0141                	addi	sp,sp,16
 850:	8082                	ret

0000000000000852 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 852:	7139                	addi	sp,sp,-64
 854:	fc06                	sd	ra,56(sp)
 856:	f822                	sd	s0,48(sp)
 858:	f04a                	sd	s2,32(sp)
 85a:	ec4e                	sd	s3,24(sp)
 85c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 85e:	02051993          	slli	s3,a0,0x20
 862:	0209d993          	srli	s3,s3,0x20
 866:	09bd                	addi	s3,s3,15
 868:	0049d993          	srli	s3,s3,0x4
 86c:	2985                	addiw	s3,s3,1
 86e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 870:	00000517          	auipc	a0,0x0
 874:	79053503          	ld	a0,1936(a0) # 1000 <freep>
 878:	c905                	beqz	a0,8a8 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87c:	4798                	lw	a4,8(a5)
 87e:	09377663          	bgeu	a4,s3,90a <malloc+0xb8>
 882:	f426                	sd	s1,40(sp)
 884:	e852                	sd	s4,16(sp)
 886:	e456                	sd	s5,8(sp)
 888:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 88a:	8a4e                	mv	s4,s3
 88c:	6705                	lui	a4,0x1
 88e:	00e9f363          	bgeu	s3,a4,894 <malloc+0x42>
 892:	6a05                	lui	s4,0x1
 894:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 898:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 89c:	00000497          	auipc	s1,0x0
 8a0:	76448493          	addi	s1,s1,1892 # 1000 <freep>
  if(p == (char*)-1)
 8a4:	5afd                	li	s5,-1
 8a6:	a83d                	j	8e4 <malloc+0x92>
 8a8:	f426                	sd	s1,40(sp)
 8aa:	e852                	sd	s4,16(sp)
 8ac:	e456                	sd	s5,8(sp)
 8ae:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8b0:	00000797          	auipc	a5,0x0
 8b4:	76078793          	addi	a5,a5,1888 # 1010 <base>
 8b8:	00000717          	auipc	a4,0x0
 8bc:	74f73423          	sd	a5,1864(a4) # 1000 <freep>
 8c0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8c2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c6:	b7d1                	j	88a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8c8:	6398                	ld	a4,0(a5)
 8ca:	e118                	sd	a4,0(a0)
 8cc:	a899                	j	922 <malloc+0xd0>
  hp->s.size = nu;
 8ce:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8d2:	0541                	addi	a0,a0,16
 8d4:	ef9ff0ef          	jal	7cc <free>
  return freep;
 8d8:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8da:	c125                	beqz	a0,93a <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8dc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8de:	4798                	lw	a4,8(a5)
 8e0:	03277163          	bgeu	a4,s2,902 <malloc+0xb0>
    if(p == freep)
 8e4:	6098                	ld	a4,0(s1)
 8e6:	853e                	mv	a0,a5
 8e8:	fef71ae3          	bne	a4,a5,8dc <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8ec:	8552                	mv	a0,s4
 8ee:	b2bff0ef          	jal	418 <sbrk>
  if(p == (char*)-1)
 8f2:	fd551ee3          	bne	a0,s5,8ce <malloc+0x7c>
        return 0;
 8f6:	4501                	li	a0,0
 8f8:	74a2                	ld	s1,40(sp)
 8fa:	6a42                	ld	s4,16(sp)
 8fc:	6aa2                	ld	s5,8(sp)
 8fe:	6b02                	ld	s6,0(sp)
 900:	a03d                	j	92e <malloc+0xdc>
 902:	74a2                	ld	s1,40(sp)
 904:	6a42                	ld	s4,16(sp)
 906:	6aa2                	ld	s5,8(sp)
 908:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 90a:	fae90fe3          	beq	s2,a4,8c8 <malloc+0x76>
        p->s.size -= nunits;
 90e:	4137073b          	subw	a4,a4,s3
 912:	c798                	sw	a4,8(a5)
        p += p->s.size;
 914:	02071693          	slli	a3,a4,0x20
 918:	01c6d713          	srli	a4,a3,0x1c
 91c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 91e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 922:	00000717          	auipc	a4,0x0
 926:	6ca73f23          	sd	a0,1758(a4) # 1000 <freep>
      return (void*)(p + 1);
 92a:	01078513          	addi	a0,a5,16
  }
}
 92e:	70e2                	ld	ra,56(sp)
 930:	7442                	ld	s0,48(sp)
 932:	7902                	ld	s2,32(sp)
 934:	69e2                	ld	s3,24(sp)
 936:	6121                	addi	sp,sp,64
 938:	8082                	ret
 93a:	74a2                	ld	s1,40(sp)
 93c:	6a42                	ld	s4,16(sp)
 93e:	6aa2                	ld	s5,8(sp)
 940:	6b02                	ld	s6,0(sp)
 942:	b7f5                	j	92e <malloc+0xdc>
