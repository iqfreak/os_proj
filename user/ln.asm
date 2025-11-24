
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	97058593          	addi	a1,a1,-1680 # 980 <malloc+0xfe>
  18:	4509                	li	a0,2
  1a:	786000ef          	jal	7a0 <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	3a0000ef          	jal	3c0 <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	3f4000ef          	jal	420 <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	38a000ef          	jal	3c0 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	95a58593          	addi	a1,a1,-1702 # 998 <malloc+0x116>
  46:	4509                	li	a0,2
  48:	758000ef          	jal	7a0 <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  4e:	1141                	addi	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	addi	s0,sp,16
  extern int main();
  main();
  56:	fabff0ef          	jal	0 <main>
  exit(0);
  5a:	4501                	li	a0,0
  5c:	364000ef          	jal	3c0 <exit>

0000000000000060 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  60:	1141                	addi	sp,sp,-16
  62:	e406                	sd	ra,8(sp)
  64:	e022                	sd	s0,0(sp)
  66:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  68:	87aa                	mv	a5,a0
  6a:	0585                	addi	a1,a1,1
  6c:	0785                	addi	a5,a5,1
  6e:	fff5c703          	lbu	a4,-1(a1)
  72:	fee78fa3          	sb	a4,-1(a5)
  76:	fb75                	bnez	a4,6a <strcpy+0xa>
    ;
  return os;
}
  78:	60a2                	ld	ra,8(sp)
  7a:	6402                	ld	s0,0(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int strcmp(const char *p, const char *q)
{
  80:	1141                	addi	sp,sp,-16
  82:	e406                	sd	ra,8(sp)
  84:	e022                	sd	s0,0(sp)
  86:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  88:	00054783          	lbu	a5,0(a0)
  8c:	cb91                	beqz	a5,a0 <strcmp+0x20>
  8e:	0005c703          	lbu	a4,0(a1)
  92:	00f71763          	bne	a4,a5,a0 <strcmp+0x20>
    p++, q++;
  96:	0505                	addi	a0,a0,1
  98:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  9a:	00054783          	lbu	a5,0(a0)
  9e:	fbe5                	bnez	a5,8e <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a0:	0005c503          	lbu	a0,0(a1)
}
  a4:	40a7853b          	subw	a0,a5,a0
  a8:	60a2                	ld	ra,8(sp)
  aa:	6402                	ld	s0,0(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strlen>:

uint strlen(const char *s)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e406                	sd	ra,8(sp)
  b4:	e022                	sd	s0,0(sp)
  b6:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	cf99                	beqz	a5,da <strlen+0x2a>
  be:	0505                	addi	a0,a0,1
  c0:	87aa                	mv	a5,a0
  c2:	86be                	mv	a3,a5
  c4:	0785                	addi	a5,a5,1
  c6:	fff7c703          	lbu	a4,-1(a5)
  ca:	ff65                	bnez	a4,c2 <strlen+0x12>
  cc:	40a6853b          	subw	a0,a3,a0
  d0:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  d2:	60a2                	ld	ra,8(sp)
  d4:	6402                	ld	s0,0(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret
  for (n = 0; s[n]; n++)
  da:	4501                	li	a0,0
  dc:	bfdd                	j	d2 <strlen+0x22>

00000000000000de <memset>:

void *
memset(void *dst, int c, uint n)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  e6:	ca19                	beqz	a2,fc <memset+0x1e>
  e8:	87aa                	mv	a5,a0
  ea:	1602                	slli	a2,a2,0x20
  ec:	9201                	srli	a2,a2,0x20
  ee:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
  f2:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  f6:	0785                	addi	a5,a5,1
  f8:	fee79de3          	bne	a5,a4,f2 <memset+0x14>
  }
  return dst;
}
  fc:	60a2                	ld	ra,8(sp)
  fe:	6402                	ld	s0,0(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strchr>:

char *
strchr(const char *s, char c)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  for (; *s; s++)
 10c:	00054783          	lbu	a5,0(a0)
 110:	cf81                	beqz	a5,128 <strchr+0x24>
    if (*s == c)
 112:	00f58763          	beq	a1,a5,120 <strchr+0x1c>
  for (; *s; s++)
 116:	0505                	addi	a0,a0,1
 118:	00054783          	lbu	a5,0(a0)
 11c:	fbfd                	bnez	a5,112 <strchr+0xe>
      return (char *)s;
  return 0;
 11e:	4501                	li	a0,0
}
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret
  return 0;
 128:	4501                	li	a0,0
 12a:	bfdd                	j	120 <strchr+0x1c>

000000000000012c <gets>:

char *
gets(char *buf, int max)
{
 12c:	7159                	addi	sp,sp,-112
 12e:	f486                	sd	ra,104(sp)
 130:	f0a2                	sd	s0,96(sp)
 132:	eca6                	sd	s1,88(sp)
 134:	e8ca                	sd	s2,80(sp)
 136:	e4ce                	sd	s3,72(sp)
 138:	e0d2                	sd	s4,64(sp)
 13a:	fc56                	sd	s5,56(sp)
 13c:	f85a                	sd	s6,48(sp)
 13e:	f45e                	sd	s7,40(sp)
 140:	f062                	sd	s8,32(sp)
 142:	ec66                	sd	s9,24(sp)
 144:	e86a                	sd	s10,16(sp)
 146:	1880                	addi	s0,sp,112
 148:	8caa                	mv	s9,a0
 14a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 14c:	892a                	mv	s2,a0
 14e:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 150:	f9f40b13          	addi	s6,s0,-97
 154:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 156:	4ba9                	li	s7,10
 158:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 15a:	8d26                	mv	s10,s1
 15c:	0014899b          	addiw	s3,s1,1
 160:	84ce                	mv	s1,s3
 162:	0349d563          	bge	s3,s4,18c <gets+0x60>
    cc = read(0, &c, 1);
 166:	8656                	mv	a2,s5
 168:	85da                	mv	a1,s6
 16a:	4501                	li	a0,0
 16c:	26c000ef          	jal	3d8 <read>
    if (cc < 1)
 170:	00a05e63          	blez	a0,18c <gets+0x60>
    buf[i++] = c;
 174:	f9f44783          	lbu	a5,-97(s0)
 178:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 17c:	01778763          	beq	a5,s7,18a <gets+0x5e>
 180:	0905                	addi	s2,s2,1
 182:	fd879ce3          	bne	a5,s8,15a <gets+0x2e>
    buf[i++] = c;
 186:	8d4e                	mv	s10,s3
 188:	a011                	j	18c <gets+0x60>
 18a:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 18c:	9d66                	add	s10,s10,s9
 18e:	000d0023          	sb	zero,0(s10)
  return buf;
}
 192:	8566                	mv	a0,s9
 194:	70a6                	ld	ra,104(sp)
 196:	7406                	ld	s0,96(sp)
 198:	64e6                	ld	s1,88(sp)
 19a:	6946                	ld	s2,80(sp)
 19c:	69a6                	ld	s3,72(sp)
 19e:	6a06                	ld	s4,64(sp)
 1a0:	7ae2                	ld	s5,56(sp)
 1a2:	7b42                	ld	s6,48(sp)
 1a4:	7ba2                	ld	s7,40(sp)
 1a6:	7c02                	ld	s8,32(sp)
 1a8:	6ce2                	ld	s9,24(sp)
 1aa:	6d42                	ld	s10,16(sp)
 1ac:	6165                	addi	sp,sp,112
 1ae:	8082                	ret

00000000000001b0 <stat>:

int stat(const char *n, struct stat *st)
{
 1b0:	1101                	addi	sp,sp,-32
 1b2:	ec06                	sd	ra,24(sp)
 1b4:	e822                	sd	s0,16(sp)
 1b6:	e04a                	sd	s2,0(sp)
 1b8:	1000                	addi	s0,sp,32
 1ba:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1bc:	4581                	li	a1,0
 1be:	242000ef          	jal	400 <open>
  if (fd < 0)
 1c2:	02054263          	bltz	a0,1e6 <stat+0x36>
 1c6:	e426                	sd	s1,8(sp)
 1c8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ca:	85ca                	mv	a1,s2
 1cc:	24c000ef          	jal	418 <fstat>
 1d0:	892a                	mv	s2,a0
  close(fd);
 1d2:	8526                	mv	a0,s1
 1d4:	214000ef          	jal	3e8 <close>
  return r;
 1d8:	64a2                	ld	s1,8(sp)
}
 1da:	854a                	mv	a0,s2
 1dc:	60e2                	ld	ra,24(sp)
 1de:	6442                	ld	s0,16(sp)
 1e0:	6902                	ld	s2,0(sp)
 1e2:	6105                	addi	sp,sp,32
 1e4:	8082                	ret
    return -1;
 1e6:	597d                	li	s2,-1
 1e8:	bfcd                	j	1da <stat+0x2a>

00000000000001ea <atoi>:

int atoi(const char *s)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1f2:	00054683          	lbu	a3,0(a0)
 1f6:	fd06879b          	addiw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	4625                	li	a2,9
 200:	02f66963          	bltu	a2,a5,232 <atoi+0x48>
 204:	872a                	mv	a4,a0
  n = 0;
 206:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 208:	0705                	addi	a4,a4,1
 20a:	0025179b          	slliw	a5,a0,0x2
 20e:	9fa9                	addw	a5,a5,a0
 210:	0017979b          	slliw	a5,a5,0x1
 214:	9fb5                	addw	a5,a5,a3
 216:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 21a:	00074683          	lbu	a3,0(a4)
 21e:	fd06879b          	addiw	a5,a3,-48
 222:	0ff7f793          	zext.b	a5,a5
 226:	fef671e3          	bgeu	a2,a5,208 <atoi+0x1e>
  return n;
}
 22a:	60a2                	ld	ra,8(sp)
 22c:	6402                	ld	s0,0(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret
  n = 0;
 232:	4501                	li	a0,0
 234:	bfdd                	j	22a <atoi+0x40>

0000000000000236 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 236:	1141                	addi	sp,sp,-16
 238:	e406                	sd	ra,8(sp)
 23a:	e022                	sd	s0,0(sp)
 23c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 23e:	02b57563          	bgeu	a0,a1,268 <memmove+0x32>
  {
    while (n-- > 0)
 242:	00c05f63          	blez	a2,260 <memmove+0x2a>
 246:	1602                	slli	a2,a2,0x20
 248:	9201                	srli	a2,a2,0x20
 24a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24e:	872a                	mv	a4,a0
      *dst++ = *src++;
 250:	0585                	addi	a1,a1,1
 252:	0705                	addi	a4,a4,1
 254:	fff5c683          	lbu	a3,-1(a1)
 258:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 25c:	fee79ae3          	bne	a5,a4,250 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 260:	60a2                	ld	ra,8(sp)
 262:	6402                	ld	s0,0(sp)
 264:	0141                	addi	sp,sp,16
 266:	8082                	ret
    dst += n;
 268:	00c50733          	add	a4,a0,a2
    src += n;
 26c:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 26e:	fec059e3          	blez	a2,260 <memmove+0x2a>
 272:	fff6079b          	addiw	a5,a2,-1
 276:	1782                	slli	a5,a5,0x20
 278:	9381                	srli	a5,a5,0x20
 27a:	fff7c793          	not	a5,a5
 27e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 280:	15fd                	addi	a1,a1,-1
 282:	177d                	addi	a4,a4,-1
 284:	0005c683          	lbu	a3,0(a1)
 288:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 28c:	fef71ae3          	bne	a4,a5,280 <memmove+0x4a>
 290:	bfc1                	j	260 <memmove+0x2a>

0000000000000292 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 29a:	ca0d                	beqz	a2,2cc <memcmp+0x3a>
 29c:	fff6069b          	addiw	a3,a2,-1
 2a0:	1682                	slli	a3,a3,0x20
 2a2:	9281                	srli	a3,a3,0x20
 2a4:	0685                	addi	a3,a3,1
 2a6:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	0005c703          	lbu	a4,0(a1)
 2b0:	00e79863          	bne	a5,a4,2c0 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 2b4:	0505                	addi	a0,a0,1
    p2++;
 2b6:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2b8:	fed518e3          	bne	a0,a3,2a8 <memcmp+0x16>
  }
  return 0;
 2bc:	4501                	li	a0,0
 2be:	a019                	j	2c4 <memcmp+0x32>
      return *p1 - *p2;
 2c0:	40e7853b          	subw	a0,a5,a4
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  return 0;
 2cc:	4501                	li	a0,0
 2ce:	bfdd                	j	2c4 <memcmp+0x32>

00000000000002d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d8:	f5fff0ef          	jal	236 <memmove>
}
 2dc:	60a2                	ld	ra,8(sp)
 2de:	6402                	ld	s0,0(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret

00000000000002e4 <strcat>:

char *strcat(char *dst, const char *src)
{
 2e4:	1141                	addi	sp,sp,-16
 2e6:	e406                	sd	ra,8(sp)
 2e8:	e022                	sd	s0,0(sp)
 2ea:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	c795                	beqz	a5,31c <strcat+0x38>
  char *p = dst;
 2f2:	87aa                	mv	a5,a0
    p++;
 2f4:	0785                	addi	a5,a5,1
  while (*p)
 2f6:	0007c703          	lbu	a4,0(a5)
 2fa:	ff6d                	bnez	a4,2f4 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 2fc:	0005c703          	lbu	a4,0(a1)
 300:	cb01                	beqz	a4,310 <strcat+0x2c>
  {
    *p = *src;
 302:	00e78023          	sb	a4,0(a5)
    p++;
 306:	0785                	addi	a5,a5,1
    src++;
 308:	0585                	addi	a1,a1,1
  while (*src)
 30a:	0005c703          	lbu	a4,0(a1)
 30e:	fb75                	bnez	a4,302 <strcat+0x1e>
  }

  *p = 0;
 310:	00078023          	sb	zero,0(a5)

  return dst;
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  char *p = dst;
 31c:	87aa                	mv	a5,a0
 31e:	bff9                	j	2fc <strcat+0x18>

0000000000000320 <isdir>:

int isdir(char *path)
{
 320:	7179                	addi	sp,sp,-48
 322:	f406                	sd	ra,40(sp)
 324:	f022                	sd	s0,32(sp)
 326:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 328:	fd840593          	addi	a1,s0,-40
 32c:	e85ff0ef          	jal	1b0 <stat>
 330:	00054b63          	bltz	a0,346 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 334:	fe041503          	lh	a0,-32(s0)
 338:	157d                	addi	a0,a0,-1
 33a:	00153513          	seqz	a0,a0
}
 33e:	70a2                	ld	ra,40(sp)
 340:	7402                	ld	s0,32(sp)
 342:	6145                	addi	sp,sp,48
 344:	8082                	ret
    return 0;
 346:	4501                	li	a0,0
 348:	bfdd                	j	33e <isdir+0x1e>

000000000000034a <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 34a:	7139                	addi	sp,sp,-64
 34c:	fc06                	sd	ra,56(sp)
 34e:	f822                	sd	s0,48(sp)
 350:	f426                	sd	s1,40(sp)
 352:	f04a                	sd	s2,32(sp)
 354:	ec4e                	sd	s3,24(sp)
 356:	e852                	sd	s4,16(sp)
 358:	e456                	sd	s5,8(sp)
 35a:	0080                	addi	s0,sp,64
 35c:	89aa                	mv	s3,a0
 35e:	8aae                	mv	s5,a1
 360:	84b2                	mv	s1,a2
 362:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 364:	d4dff0ef          	jal	b0 <strlen>
 368:	892a                	mv	s2,a0
  int nn = strlen(filename);
 36a:	8556                	mv	a0,s5
 36c:	d45ff0ef          	jal	b0 <strlen>
  int need = dn + 1 + nn + 1;
 370:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 374:	9fa9                	addw	a5,a5,a0
    return 0;
 376:	4501                	li	a0,0
  if (need > bufsize)
 378:	0347d763          	bge	a5,s4,3a6 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 37c:	85ce                	mv	a1,s3
 37e:	8526                	mv	a0,s1
 380:	ce1ff0ef          	jal	60 <strcpy>
  if (dir[dn - 1] != '/')
 384:	99ca                	add	s3,s3,s2
 386:	fff9c703          	lbu	a4,-1(s3)
 38a:	02f00793          	li	a5,47
 38e:	00f70763          	beq	a4,a5,39c <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 392:	9926                	add	s2,s2,s1
 394:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 398:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 39c:	85d6                	mv	a1,s5
 39e:	8526                	mv	a0,s1
 3a0:	f45ff0ef          	jal	2e4 <strcat>
  return out_buffer;
 3a4:	8526                	mv	a0,s1
}
 3a6:	70e2                	ld	ra,56(sp)
 3a8:	7442                	ld	s0,48(sp)
 3aa:	74a2                	ld	s1,40(sp)
 3ac:	7902                	ld	s2,32(sp)
 3ae:	69e2                	ld	s3,24(sp)
 3b0:	6a42                	ld	s4,16(sp)
 3b2:	6aa2                	ld	s5,8(sp)
 3b4:	6121                	addi	sp,sp,64
 3b6:	8082                	ret

00000000000003b8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b8:	4885                	li	a7,1
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3c0:	4889                	li	a7,2
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c8:	488d                	li	a7,3
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3d0:	4891                	li	a7,4
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <read>:
.global read
read:
 li a7, SYS_read
 3d8:	4895                	li	a7,5
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <write>:
.global write
write:
 li a7, SYS_write
 3e0:	48c1                	li	a7,16
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <close>:
.global close
close:
 li a7, SYS_close
 3e8:	48d5                	li	a7,21
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3f0:	4899                	li	a7,6
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f8:	489d                	li	a7,7
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <open>:
.global open
open:
 li a7, SYS_open
 400:	48bd                	li	a7,15
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 408:	48c5                	li	a7,17
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 410:	48c9                	li	a7,18
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 418:	48a1                	li	a7,8
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <link>:
.global link
link:
 li a7, SYS_link
 420:	48cd                	li	a7,19
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 428:	48d1                	li	a7,20
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 430:	48a5                	li	a7,9
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <dup>:
.global dup
dup:
 li a7, SYS_dup
 438:	48a9                	li	a7,10
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 440:	48ad                	li	a7,11
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 448:	48b1                	li	a7,12
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 450:	48b5                	li	a7,13
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 458:	48b9                	li	a7,14
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 460:	48d9                	li	a7,22
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 468:	1101                	addi	sp,sp,-32
 46a:	ec06                	sd	ra,24(sp)
 46c:	e822                	sd	s0,16(sp)
 46e:	1000                	addi	s0,sp,32
 470:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 474:	4605                	li	a2,1
 476:	fef40593          	addi	a1,s0,-17
 47a:	f67ff0ef          	jal	3e0 <write>
}
 47e:	60e2                	ld	ra,24(sp)
 480:	6442                	ld	s0,16(sp)
 482:	6105                	addi	sp,sp,32
 484:	8082                	ret

0000000000000486 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 486:	7139                	addi	sp,sp,-64
 488:	fc06                	sd	ra,56(sp)
 48a:	f822                	sd	s0,48(sp)
 48c:	f426                	sd	s1,40(sp)
 48e:	f04a                	sd	s2,32(sp)
 490:	ec4e                	sd	s3,24(sp)
 492:	0080                	addi	s0,sp,64
 494:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 496:	c299                	beqz	a3,49c <printint+0x16>
 498:	0605ce63          	bltz	a1,514 <printint+0x8e>
  neg = 0;
 49c:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 49e:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4a2:	869a                	mv	a3,t1
  i = 0;
 4a4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4a6:	00000817          	auipc	a6,0x0
 4aa:	51280813          	addi	a6,a6,1298 # 9b8 <digits>
 4ae:	88be                	mv	a7,a5
 4b0:	0017851b          	addiw	a0,a5,1
 4b4:	87aa                	mv	a5,a0
 4b6:	02c5f73b          	remuw	a4,a1,a2
 4ba:	1702                	slli	a4,a4,0x20
 4bc:	9301                	srli	a4,a4,0x20
 4be:	9742                	add	a4,a4,a6
 4c0:	00074703          	lbu	a4,0(a4)
 4c4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4c8:	872e                	mv	a4,a1
 4ca:	02c5d5bb          	divuw	a1,a1,a2
 4ce:	0685                	addi	a3,a3,1
 4d0:	fcc77fe3          	bgeu	a4,a2,4ae <printint+0x28>
  if(neg)
 4d4:	000e0c63          	beqz	t3,4ec <printint+0x66>
    buf[i++] = '-';
 4d8:	fd050793          	addi	a5,a0,-48
 4dc:	00878533          	add	a0,a5,s0
 4e0:	02d00793          	li	a5,45
 4e4:	fef50823          	sb	a5,-16(a0)
 4e8:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4ec:	fff7899b          	addiw	s3,a5,-1
 4f0:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4f4:	fff4c583          	lbu	a1,-1(s1)
 4f8:	854a                	mv	a0,s2
 4fa:	f6fff0ef          	jal	468 <putc>
  while(--i >= 0)
 4fe:	39fd                	addiw	s3,s3,-1
 500:	14fd                	addi	s1,s1,-1
 502:	fe09d9e3          	bgez	s3,4f4 <printint+0x6e>
}
 506:	70e2                	ld	ra,56(sp)
 508:	7442                	ld	s0,48(sp)
 50a:	74a2                	ld	s1,40(sp)
 50c:	7902                	ld	s2,32(sp)
 50e:	69e2                	ld	s3,24(sp)
 510:	6121                	addi	sp,sp,64
 512:	8082                	ret
    x = -xx;
 514:	40b005bb          	negw	a1,a1
    neg = 1;
 518:	4e05                	li	t3,1
    x = -xx;
 51a:	b751                	j	49e <printint+0x18>

000000000000051c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 51c:	711d                	addi	sp,sp,-96
 51e:	ec86                	sd	ra,88(sp)
 520:	e8a2                	sd	s0,80(sp)
 522:	e4a6                	sd	s1,72(sp)
 524:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 526:	0005c483          	lbu	s1,0(a1)
 52a:	26048663          	beqz	s1,796 <vprintf+0x27a>
 52e:	e0ca                	sd	s2,64(sp)
 530:	fc4e                	sd	s3,56(sp)
 532:	f852                	sd	s4,48(sp)
 534:	f456                	sd	s5,40(sp)
 536:	f05a                	sd	s6,32(sp)
 538:	ec5e                	sd	s7,24(sp)
 53a:	e862                	sd	s8,16(sp)
 53c:	e466                	sd	s9,8(sp)
 53e:	8b2a                	mv	s6,a0
 540:	8a2e                	mv	s4,a1
 542:	8bb2                	mv	s7,a2
  state = 0;
 544:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 546:	4901                	li	s2,0
 548:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 54a:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 54e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 552:	06c00c93          	li	s9,108
 556:	a00d                	j	578 <vprintf+0x5c>
        putc(fd, c0);
 558:	85a6                	mv	a1,s1
 55a:	855a                	mv	a0,s6
 55c:	f0dff0ef          	jal	468 <putc>
 560:	a019                	j	566 <vprintf+0x4a>
    } else if(state == '%'){
 562:	03598363          	beq	s3,s5,588 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 566:	0019079b          	addiw	a5,s2,1
 56a:	893e                	mv	s2,a5
 56c:	873e                	mv	a4,a5
 56e:	97d2                	add	a5,a5,s4
 570:	0007c483          	lbu	s1,0(a5)
 574:	20048963          	beqz	s1,786 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 578:	0004879b          	sext.w	a5,s1
    if(state == 0){
 57c:	fe0993e3          	bnez	s3,562 <vprintf+0x46>
      if(c0 == '%'){
 580:	fd579ce3          	bne	a5,s5,558 <vprintf+0x3c>
        state = '%';
 584:	89be                	mv	s3,a5
 586:	b7c5                	j	566 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 588:	00ea06b3          	add	a3,s4,a4
 58c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 590:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 592:	c681                	beqz	a3,59a <vprintf+0x7e>
 594:	9752                	add	a4,a4,s4
 596:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 59a:	03878e63          	beq	a5,s8,5d6 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 59e:	05978863          	beq	a5,s9,5ee <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5a2:	07500713          	li	a4,117
 5a6:	0ee78263          	beq	a5,a4,68a <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5aa:	07800713          	li	a4,120
 5ae:	12e78463          	beq	a5,a4,6d6 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5b2:	07000713          	li	a4,112
 5b6:	14e78963          	beq	a5,a4,708 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5ba:	07300713          	li	a4,115
 5be:	18e78863          	beq	a5,a4,74e <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5c2:	02500713          	li	a4,37
 5c6:	04e79463          	bne	a5,a4,60e <vprintf+0xf2>
        putc(fd, '%');
 5ca:	85ba                	mv	a1,a4
 5cc:	855a                	mv	a0,s6
 5ce:	e9bff0ef          	jal	468 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	bf49                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5d6:	008b8493          	addi	s1,s7,8
 5da:	4685                	li	a3,1
 5dc:	4629                	li	a2,10
 5de:	000ba583          	lw	a1,0(s7)
 5e2:	855a                	mv	a0,s6
 5e4:	ea3ff0ef          	jal	486 <printint>
 5e8:	8ba6                	mv	s7,s1
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	bfad                	j	566 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5ee:	06400793          	li	a5,100
 5f2:	02f68963          	beq	a3,a5,624 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5f6:	06c00793          	li	a5,108
 5fa:	04f68263          	beq	a3,a5,63e <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 5fe:	07500793          	li	a5,117
 602:	0af68063          	beq	a3,a5,6a2 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 606:	07800793          	li	a5,120
 60a:	0ef68263          	beq	a3,a5,6ee <vprintf+0x1d2>
        putc(fd, '%');
 60e:	02500593          	li	a1,37
 612:	855a                	mv	a0,s6
 614:	e55ff0ef          	jal	468 <putc>
        putc(fd, c0);
 618:	85a6                	mv	a1,s1
 61a:	855a                	mv	a0,s6
 61c:	e4dff0ef          	jal	468 <putc>
      state = 0;
 620:	4981                	li	s3,0
 622:	b791                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 624:	008b8493          	addi	s1,s7,8
 628:	4685                	li	a3,1
 62a:	4629                	li	a2,10
 62c:	000ba583          	lw	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	e55ff0ef          	jal	486 <printint>
        i += 1;
 636:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 638:	8ba6                	mv	s7,s1
      state = 0;
 63a:	4981                	li	s3,0
        i += 1;
 63c:	b72d                	j	566 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 63e:	06400793          	li	a5,100
 642:	02f60763          	beq	a2,a5,670 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 646:	07500793          	li	a5,117
 64a:	06f60963          	beq	a2,a5,6bc <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 64e:	07800793          	li	a5,120
 652:	faf61ee3          	bne	a2,a5,60e <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 656:	008b8493          	addi	s1,s7,8
 65a:	4681                	li	a3,0
 65c:	4641                	li	a2,16
 65e:	000ba583          	lw	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	e23ff0ef          	jal	486 <printint>
        i += 2;
 668:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 66a:	8ba6                	mv	s7,s1
      state = 0;
 66c:	4981                	li	s3,0
        i += 2;
 66e:	bde5                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 670:	008b8493          	addi	s1,s7,8
 674:	4685                	li	a3,1
 676:	4629                	li	a2,10
 678:	000ba583          	lw	a1,0(s7)
 67c:	855a                	mv	a0,s6
 67e:	e09ff0ef          	jal	486 <printint>
        i += 2;
 682:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 684:	8ba6                	mv	s7,s1
      state = 0;
 686:	4981                	li	s3,0
        i += 2;
 688:	bdf9                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 68a:	008b8493          	addi	s1,s7,8
 68e:	4681                	li	a3,0
 690:	4629                	li	a2,10
 692:	000ba583          	lw	a1,0(s7)
 696:	855a                	mv	a0,s6
 698:	defff0ef          	jal	486 <printint>
 69c:	8ba6                	mv	s7,s1
      state = 0;
 69e:	4981                	li	s3,0
 6a0:	b5d9                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	4681                	li	a3,0
 6a8:	4629                	li	a2,10
 6aa:	000ba583          	lw	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	dd7ff0ef          	jal	486 <printint>
        i += 1;
 6b4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	8ba6                	mv	s7,s1
      state = 0;
 6b8:	4981                	li	s3,0
        i += 1;
 6ba:	b575                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6bc:	008b8493          	addi	s1,s7,8
 6c0:	4681                	li	a3,0
 6c2:	4629                	li	a2,10
 6c4:	000ba583          	lw	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	dbdff0ef          	jal	486 <printint>
        i += 2;
 6ce:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d0:	8ba6                	mv	s7,s1
      state = 0;
 6d2:	4981                	li	s3,0
        i += 2;
 6d4:	bd49                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6d6:	008b8493          	addi	s1,s7,8
 6da:	4681                	li	a3,0
 6dc:	4641                	li	a2,16
 6de:	000ba583          	lw	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	da3ff0ef          	jal	486 <printint>
 6e8:	8ba6                	mv	s7,s1
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	bdad                	j	566 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ee:	008b8493          	addi	s1,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4641                	li	a2,16
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	d8bff0ef          	jal	486 <printint>
        i += 1;
 700:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 702:	8ba6                	mv	s7,s1
      state = 0;
 704:	4981                	li	s3,0
        i += 1;
 706:	b585                	j	566 <vprintf+0x4a>
 708:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 70a:	008b8d13          	addi	s10,s7,8
 70e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 712:	03000593          	li	a1,48
 716:	855a                	mv	a0,s6
 718:	d51ff0ef          	jal	468 <putc>
  putc(fd, 'x');
 71c:	07800593          	li	a1,120
 720:	855a                	mv	a0,s6
 722:	d47ff0ef          	jal	468 <putc>
 726:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 728:	00000b97          	auipc	s7,0x0
 72c:	290b8b93          	addi	s7,s7,656 # 9b8 <digits>
 730:	03c9d793          	srli	a5,s3,0x3c
 734:	97de                	add	a5,a5,s7
 736:	0007c583          	lbu	a1,0(a5)
 73a:	855a                	mv	a0,s6
 73c:	d2dff0ef          	jal	468 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 740:	0992                	slli	s3,s3,0x4
 742:	34fd                	addiw	s1,s1,-1
 744:	f4f5                	bnez	s1,730 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 746:	8bea                	mv	s7,s10
      state = 0;
 748:	4981                	li	s3,0
 74a:	6d02                	ld	s10,0(sp)
 74c:	bd29                	j	566 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 74e:	008b8993          	addi	s3,s7,8
 752:	000bb483          	ld	s1,0(s7)
 756:	cc91                	beqz	s1,772 <vprintf+0x256>
        for(; *s; s++)
 758:	0004c583          	lbu	a1,0(s1)
 75c:	c195                	beqz	a1,780 <vprintf+0x264>
          putc(fd, *s);
 75e:	855a                	mv	a0,s6
 760:	d09ff0ef          	jal	468 <putc>
        for(; *s; s++)
 764:	0485                	addi	s1,s1,1
 766:	0004c583          	lbu	a1,0(s1)
 76a:	f9f5                	bnez	a1,75e <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 76c:	8bce                	mv	s7,s3
      state = 0;
 76e:	4981                	li	s3,0
 770:	bbdd                	j	566 <vprintf+0x4a>
          s = "(null)";
 772:	00000497          	auipc	s1,0x0
 776:	23e48493          	addi	s1,s1,574 # 9b0 <malloc+0x12e>
        for(; *s; s++)
 77a:	02800593          	li	a1,40
 77e:	b7c5                	j	75e <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 780:	8bce                	mv	s7,s3
      state = 0;
 782:	4981                	li	s3,0
 784:	b3cd                	j	566 <vprintf+0x4a>
 786:	6906                	ld	s2,64(sp)
 788:	79e2                	ld	s3,56(sp)
 78a:	7a42                	ld	s4,48(sp)
 78c:	7aa2                	ld	s5,40(sp)
 78e:	7b02                	ld	s6,32(sp)
 790:	6be2                	ld	s7,24(sp)
 792:	6c42                	ld	s8,16(sp)
 794:	6ca2                	ld	s9,8(sp)
    }
  }
}
 796:	60e6                	ld	ra,88(sp)
 798:	6446                	ld	s0,80(sp)
 79a:	64a6                	ld	s1,72(sp)
 79c:	6125                	addi	sp,sp,96
 79e:	8082                	ret

00000000000007a0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a0:	715d                	addi	sp,sp,-80
 7a2:	ec06                	sd	ra,24(sp)
 7a4:	e822                	sd	s0,16(sp)
 7a6:	1000                	addi	s0,sp,32
 7a8:	e010                	sd	a2,0(s0)
 7aa:	e414                	sd	a3,8(s0)
 7ac:	e818                	sd	a4,16(s0)
 7ae:	ec1c                	sd	a5,24(s0)
 7b0:	03043023          	sd	a6,32(s0)
 7b4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7b8:	8622                	mv	a2,s0
 7ba:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7be:	d5fff0ef          	jal	51c <vprintf>
}
 7c2:	60e2                	ld	ra,24(sp)
 7c4:	6442                	ld	s0,16(sp)
 7c6:	6161                	addi	sp,sp,80
 7c8:	8082                	ret

00000000000007ca <printf>:

void
printf(const char *fmt, ...)
{
 7ca:	711d                	addi	sp,sp,-96
 7cc:	ec06                	sd	ra,24(sp)
 7ce:	e822                	sd	s0,16(sp)
 7d0:	1000                	addi	s0,sp,32
 7d2:	e40c                	sd	a1,8(s0)
 7d4:	e810                	sd	a2,16(s0)
 7d6:	ec14                	sd	a3,24(s0)
 7d8:	f018                	sd	a4,32(s0)
 7da:	f41c                	sd	a5,40(s0)
 7dc:	03043823          	sd	a6,48(s0)
 7e0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7e4:	00840613          	addi	a2,s0,8
 7e8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7ec:	85aa                	mv	a1,a0
 7ee:	4505                	li	a0,1
 7f0:	d2dff0ef          	jal	51c <vprintf>
}
 7f4:	60e2                	ld	ra,24(sp)
 7f6:	6442                	ld	s0,16(sp)
 7f8:	6125                	addi	sp,sp,96
 7fa:	8082                	ret

00000000000007fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7fc:	1141                	addi	sp,sp,-16
 7fe:	e406                	sd	ra,8(sp)
 800:	e022                	sd	s0,0(sp)
 802:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 804:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 808:	00000797          	auipc	a5,0x0
 80c:	7f87b783          	ld	a5,2040(a5) # 1000 <freep>
 810:	a02d                	j	83a <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 812:	4618                	lw	a4,8(a2)
 814:	9f2d                	addw	a4,a4,a1
 816:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 81a:	6398                	ld	a4,0(a5)
 81c:	6310                	ld	a2,0(a4)
 81e:	a83d                	j	85c <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 820:	ff852703          	lw	a4,-8(a0)
 824:	9f31                	addw	a4,a4,a2
 826:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 828:	ff053683          	ld	a3,-16(a0)
 82c:	a091                	j	870 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	6398                	ld	a4,0(a5)
 830:	00e7e463          	bltu	a5,a4,838 <free+0x3c>
 834:	00e6ea63          	bltu	a3,a4,848 <free+0x4c>
{
 838:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	fed7fae3          	bgeu	a5,a3,82e <free+0x32>
 83e:	6398                	ld	a4,0(a5)
 840:	00e6e463          	bltu	a3,a4,848 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 844:	fee7eae3          	bltu	a5,a4,838 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 848:	ff852583          	lw	a1,-8(a0)
 84c:	6390                	ld	a2,0(a5)
 84e:	02059813          	slli	a6,a1,0x20
 852:	01c85713          	srli	a4,a6,0x1c
 856:	9736                	add	a4,a4,a3
 858:	fae60de3          	beq	a2,a4,812 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 85c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 860:	4790                	lw	a2,8(a5)
 862:	02061593          	slli	a1,a2,0x20
 866:	01c5d713          	srli	a4,a1,0x1c
 86a:	973e                	add	a4,a4,a5
 86c:	fae68ae3          	beq	a3,a4,820 <free+0x24>
    p->s.ptr = bp->s.ptr;
 870:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 872:	00000717          	auipc	a4,0x0
 876:	78f73723          	sd	a5,1934(a4) # 1000 <freep>
}
 87a:	60a2                	ld	ra,8(sp)
 87c:	6402                	ld	s0,0(sp)
 87e:	0141                	addi	sp,sp,16
 880:	8082                	ret

0000000000000882 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 882:	7139                	addi	sp,sp,-64
 884:	fc06                	sd	ra,56(sp)
 886:	f822                	sd	s0,48(sp)
 888:	f04a                	sd	s2,32(sp)
 88a:	ec4e                	sd	s3,24(sp)
 88c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88e:	02051993          	slli	s3,a0,0x20
 892:	0209d993          	srli	s3,s3,0x20
 896:	09bd                	addi	s3,s3,15
 898:	0049d993          	srli	s3,s3,0x4
 89c:	2985                	addiw	s3,s3,1
 89e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8a0:	00000517          	auipc	a0,0x0
 8a4:	76053503          	ld	a0,1888(a0) # 1000 <freep>
 8a8:	c905                	beqz	a0,8d8 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ac:	4798                	lw	a4,8(a5)
 8ae:	09377663          	bgeu	a4,s3,93a <malloc+0xb8>
 8b2:	f426                	sd	s1,40(sp)
 8b4:	e852                	sd	s4,16(sp)
 8b6:	e456                	sd	s5,8(sp)
 8b8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ba:	8a4e                	mv	s4,s3
 8bc:	6705                	lui	a4,0x1
 8be:	00e9f363          	bgeu	s3,a4,8c4 <malloc+0x42>
 8c2:	6a05                	lui	s4,0x1
 8c4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8cc:	00000497          	auipc	s1,0x0
 8d0:	73448493          	addi	s1,s1,1844 # 1000 <freep>
  if(p == (char*)-1)
 8d4:	5afd                	li	s5,-1
 8d6:	a83d                	j	914 <malloc+0x92>
 8d8:	f426                	sd	s1,40(sp)
 8da:	e852                	sd	s4,16(sp)
 8dc:	e456                	sd	s5,8(sp)
 8de:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8e0:	00000797          	auipc	a5,0x0
 8e4:	73078793          	addi	a5,a5,1840 # 1010 <base>
 8e8:	00000717          	auipc	a4,0x0
 8ec:	70f73c23          	sd	a5,1816(a4) # 1000 <freep>
 8f0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8f2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8f6:	b7d1                	j	8ba <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8f8:	6398                	ld	a4,0(a5)
 8fa:	e118                	sd	a4,0(a0)
 8fc:	a899                	j	952 <malloc+0xd0>
  hp->s.size = nu;
 8fe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 902:	0541                	addi	a0,a0,16
 904:	ef9ff0ef          	jal	7fc <free>
  return freep;
 908:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 90a:	c125                	beqz	a0,96a <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90e:	4798                	lw	a4,8(a5)
 910:	03277163          	bgeu	a4,s2,932 <malloc+0xb0>
    if(p == freep)
 914:	6098                	ld	a4,0(s1)
 916:	853e                	mv	a0,a5
 918:	fef71ae3          	bne	a4,a5,90c <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 91c:	8552                	mv	a0,s4
 91e:	b2bff0ef          	jal	448 <sbrk>
  if(p == (char*)-1)
 922:	fd551ee3          	bne	a0,s5,8fe <malloc+0x7c>
        return 0;
 926:	4501                	li	a0,0
 928:	74a2                	ld	s1,40(sp)
 92a:	6a42                	ld	s4,16(sp)
 92c:	6aa2                	ld	s5,8(sp)
 92e:	6b02                	ld	s6,0(sp)
 930:	a03d                	j	95e <malloc+0xdc>
 932:	74a2                	ld	s1,40(sp)
 934:	6a42                	ld	s4,16(sp)
 936:	6aa2                	ld	s5,8(sp)
 938:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 93a:	fae90fe3          	beq	s2,a4,8f8 <malloc+0x76>
        p->s.size -= nunits;
 93e:	4137073b          	subw	a4,a4,s3
 942:	c798                	sw	a4,8(a5)
        p += p->s.size;
 944:	02071693          	slli	a3,a4,0x20
 948:	01c6d713          	srli	a4,a3,0x1c
 94c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 94e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 952:	00000717          	auipc	a4,0x0
 956:	6aa73723          	sd	a0,1710(a4) # 1000 <freep>
      return (void*)(p + 1);
 95a:	01078513          	addi	a0,a5,16
  }
}
 95e:	70e2                	ld	ra,56(sp)
 960:	7442                	ld	s0,48(sp)
 962:	7902                	ld	s2,32(sp)
 964:	69e2                	ld	s3,24(sp)
 966:	6121                	addi	sp,sp,64
 968:	8082                	ret
 96a:	74a2                	ld	s1,40(sp)
 96c:	6a42                	ld	s4,16(sp)
 96e:	6aa2                	ld	s5,8(sp)
 970:	6b02                	ld	s6,0(sp)
 972:	b7f5                	j	95e <malloc+0xdc>
