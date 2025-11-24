
user/_sleep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  sleep(atoi(argv[1]));
   8:	6588                	ld	a0,8(a1)
   a:	1aa000ef          	jal	1b4 <atoi>
   e:	40c000ef          	jal	41a <sleep>
  exit(0);
  12:	4501                	li	a0,0
  14:	376000ef          	jal	38a <exit>

0000000000000018 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  18:	1141                	addi	sp,sp,-16
  1a:	e406                	sd	ra,8(sp)
  1c:	e022                	sd	s0,0(sp)
  1e:	0800                	addi	s0,sp,16
  extern int main();
  main();
  20:	fe1ff0ef          	jal	0 <main>
  exit(0);
  24:	4501                	li	a0,0
  26:	364000ef          	jal	38a <exit>

000000000000002a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  32:	87aa                	mv	a5,a0
  34:	0585                	addi	a1,a1,1
  36:	0785                	addi	a5,a5,1
  38:	fff5c703          	lbu	a4,-1(a1)
  3c:	fee78fa3          	sb	a4,-1(a5)
  40:	fb75                	bnez	a4,34 <strcpy+0xa>
    ;
  return os;
}
  42:	60a2                	ld	ra,8(sp)
  44:	6402                	ld	s0,0(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  52:	00054783          	lbu	a5,0(a0)
  56:	cb91                	beqz	a5,6a <strcmp+0x20>
  58:	0005c703          	lbu	a4,0(a1)
  5c:	00f71763          	bne	a4,a5,6a <strcmp+0x20>
    p++, q++;
  60:	0505                	addi	a0,a0,1
  62:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	fbe5                	bnez	a5,58 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  6a:	0005c503          	lbu	a0,0(a1)
}
  6e:	40a7853b          	subw	a0,a5,a0
  72:	60a2                	ld	ra,8(sp)
  74:	6402                	ld	s0,0(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strlen>:

uint strlen(const char *s)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  82:	00054783          	lbu	a5,0(a0)
  86:	cf99                	beqz	a5,a4 <strlen+0x2a>
  88:	0505                	addi	a0,a0,1
  8a:	87aa                	mv	a5,a0
  8c:	86be                	mv	a3,a5
  8e:	0785                	addi	a5,a5,1
  90:	fff7c703          	lbu	a4,-1(a5)
  94:	ff65                	bnez	a4,8c <strlen+0x12>
  96:	40a6853b          	subw	a0,a3,a0
  9a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  9c:	60a2                	ld	ra,8(sp)
  9e:	6402                	ld	s0,0(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret
  for (n = 0; s[n]; n++)
  a4:	4501                	li	a0,0
  a6:	bfdd                	j	9c <strlen+0x22>

00000000000000a8 <memset>:

void *
memset(void *dst, int c, uint n)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e406                	sd	ra,8(sp)
  ac:	e022                	sd	s0,0(sp)
  ae:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  b0:	ca19                	beqz	a2,c6 <memset+0x1e>
  b2:	87aa                	mv	a5,a0
  b4:	1602                	slli	a2,a2,0x20
  b6:	9201                	srli	a2,a2,0x20
  b8:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
  bc:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  c0:	0785                	addi	a5,a5,1
  c2:	fee79de3          	bne	a5,a4,bc <memset+0x14>
  }
  return dst;
}
  c6:	60a2                	ld	ra,8(sp)
  c8:	6402                	ld	s0,0(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret

00000000000000ce <strchr>:

char *
strchr(const char *s, char c)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  for (; *s; s++)
  d6:	00054783          	lbu	a5,0(a0)
  da:	cf81                	beqz	a5,f2 <strchr+0x24>
    if (*s == c)
  dc:	00f58763          	beq	a1,a5,ea <strchr+0x1c>
  for (; *s; s++)
  e0:	0505                	addi	a0,a0,1
  e2:	00054783          	lbu	a5,0(a0)
  e6:	fbfd                	bnez	a5,dc <strchr+0xe>
      return (char *)s;
  return 0;
  e8:	4501                	li	a0,0
}
  ea:	60a2                	ld	ra,8(sp)
  ec:	6402                	ld	s0,0(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret
  return 0;
  f2:	4501                	li	a0,0
  f4:	bfdd                	j	ea <strchr+0x1c>

00000000000000f6 <gets>:

char *
gets(char *buf, int max)
{
  f6:	7159                	addi	sp,sp,-112
  f8:	f486                	sd	ra,104(sp)
  fa:	f0a2                	sd	s0,96(sp)
  fc:	eca6                	sd	s1,88(sp)
  fe:	e8ca                	sd	s2,80(sp)
 100:	e4ce                	sd	s3,72(sp)
 102:	e0d2                	sd	s4,64(sp)
 104:	fc56                	sd	s5,56(sp)
 106:	f85a                	sd	s6,48(sp)
 108:	f45e                	sd	s7,40(sp)
 10a:	f062                	sd	s8,32(sp)
 10c:	ec66                	sd	s9,24(sp)
 10e:	e86a                	sd	s10,16(sp)
 110:	1880                	addi	s0,sp,112
 112:	8caa                	mv	s9,a0
 114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 116:	892a                	mv	s2,a0
 118:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 11a:	f9f40b13          	addi	s6,s0,-97
 11e:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 120:	4ba9                	li	s7,10
 122:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 124:	8d26                	mv	s10,s1
 126:	0014899b          	addiw	s3,s1,1
 12a:	84ce                	mv	s1,s3
 12c:	0349d563          	bge	s3,s4,156 <gets+0x60>
    cc = read(0, &c, 1);
 130:	8656                	mv	a2,s5
 132:	85da                	mv	a1,s6
 134:	4501                	li	a0,0
 136:	26c000ef          	jal	3a2 <read>
    if (cc < 1)
 13a:	00a05e63          	blez	a0,156 <gets+0x60>
    buf[i++] = c;
 13e:	f9f44783          	lbu	a5,-97(s0)
 142:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 146:	01778763          	beq	a5,s7,154 <gets+0x5e>
 14a:	0905                	addi	s2,s2,1
 14c:	fd879ce3          	bne	a5,s8,124 <gets+0x2e>
    buf[i++] = c;
 150:	8d4e                	mv	s10,s3
 152:	a011                	j	156 <gets+0x60>
 154:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 156:	9d66                	add	s10,s10,s9
 158:	000d0023          	sb	zero,0(s10)
  return buf;
}
 15c:	8566                	mv	a0,s9
 15e:	70a6                	ld	ra,104(sp)
 160:	7406                	ld	s0,96(sp)
 162:	64e6                	ld	s1,88(sp)
 164:	6946                	ld	s2,80(sp)
 166:	69a6                	ld	s3,72(sp)
 168:	6a06                	ld	s4,64(sp)
 16a:	7ae2                	ld	s5,56(sp)
 16c:	7b42                	ld	s6,48(sp)
 16e:	7ba2                	ld	s7,40(sp)
 170:	7c02                	ld	s8,32(sp)
 172:	6ce2                	ld	s9,24(sp)
 174:	6d42                	ld	s10,16(sp)
 176:	6165                	addi	sp,sp,112
 178:	8082                	ret

000000000000017a <stat>:

int stat(const char *n, struct stat *st)
{
 17a:	1101                	addi	sp,sp,-32
 17c:	ec06                	sd	ra,24(sp)
 17e:	e822                	sd	s0,16(sp)
 180:	e04a                	sd	s2,0(sp)
 182:	1000                	addi	s0,sp,32
 184:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 186:	4581                	li	a1,0
 188:	242000ef          	jal	3ca <open>
  if (fd < 0)
 18c:	02054263          	bltz	a0,1b0 <stat+0x36>
 190:	e426                	sd	s1,8(sp)
 192:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 194:	85ca                	mv	a1,s2
 196:	24c000ef          	jal	3e2 <fstat>
 19a:	892a                	mv	s2,a0
  close(fd);
 19c:	8526                	mv	a0,s1
 19e:	214000ef          	jal	3b2 <close>
  return r;
 1a2:	64a2                	ld	s1,8(sp)
}
 1a4:	854a                	mv	a0,s2
 1a6:	60e2                	ld	ra,24(sp)
 1a8:	6442                	ld	s0,16(sp)
 1aa:	6902                	ld	s2,0(sp)
 1ac:	6105                	addi	sp,sp,32
 1ae:	8082                	ret
    return -1;
 1b0:	597d                	li	s2,-1
 1b2:	bfcd                	j	1a4 <stat+0x2a>

00000000000001b4 <atoi>:

int atoi(const char *s)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e406                	sd	ra,8(sp)
 1b8:	e022                	sd	s0,0(sp)
 1ba:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1bc:	00054683          	lbu	a3,0(a0)
 1c0:	fd06879b          	addiw	a5,a3,-48
 1c4:	0ff7f793          	zext.b	a5,a5
 1c8:	4625                	li	a2,9
 1ca:	02f66963          	bltu	a2,a5,1fc <atoi+0x48>
 1ce:	872a                	mv	a4,a0
  n = 0;
 1d0:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1d2:	0705                	addi	a4,a4,1
 1d4:	0025179b          	slliw	a5,a0,0x2
 1d8:	9fa9                	addw	a5,a5,a0
 1da:	0017979b          	slliw	a5,a5,0x1
 1de:	9fb5                	addw	a5,a5,a3
 1e0:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 1e4:	00074683          	lbu	a3,0(a4)
 1e8:	fd06879b          	addiw	a5,a3,-48
 1ec:	0ff7f793          	zext.b	a5,a5
 1f0:	fef671e3          	bgeu	a2,a5,1d2 <atoi+0x1e>
  return n;
}
 1f4:	60a2                	ld	ra,8(sp)
 1f6:	6402                	ld	s0,0(sp)
 1f8:	0141                	addi	sp,sp,16
 1fa:	8082                	ret
  n = 0;
 1fc:	4501                	li	a0,0
 1fe:	bfdd                	j	1f4 <atoi+0x40>

0000000000000200 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 200:	1141                	addi	sp,sp,-16
 202:	e406                	sd	ra,8(sp)
 204:	e022                	sd	s0,0(sp)
 206:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 208:	02b57563          	bgeu	a0,a1,232 <memmove+0x32>
  {
    while (n-- > 0)
 20c:	00c05f63          	blez	a2,22a <memmove+0x2a>
 210:	1602                	slli	a2,a2,0x20
 212:	9201                	srli	a2,a2,0x20
 214:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 218:	872a                	mv	a4,a0
      *dst++ = *src++;
 21a:	0585                	addi	a1,a1,1
 21c:	0705                	addi	a4,a4,1
 21e:	fff5c683          	lbu	a3,-1(a1)
 222:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 226:	fee79ae3          	bne	a5,a4,21a <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 22a:	60a2                	ld	ra,8(sp)
 22c:	6402                	ld	s0,0(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret
    dst += n;
 232:	00c50733          	add	a4,a0,a2
    src += n;
 236:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 238:	fec059e3          	blez	a2,22a <memmove+0x2a>
 23c:	fff6079b          	addiw	a5,a2,-1
 240:	1782                	slli	a5,a5,0x20
 242:	9381                	srli	a5,a5,0x20
 244:	fff7c793          	not	a5,a5
 248:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24a:	15fd                	addi	a1,a1,-1
 24c:	177d                	addi	a4,a4,-1
 24e:	0005c683          	lbu	a3,0(a1)
 252:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 256:	fef71ae3          	bne	a4,a5,24a <memmove+0x4a>
 25a:	bfc1                	j	22a <memmove+0x2a>

000000000000025c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 264:	ca0d                	beqz	a2,296 <memcmp+0x3a>
 266:	fff6069b          	addiw	a3,a2,-1
 26a:	1682                	slli	a3,a3,0x20
 26c:	9281                	srli	a3,a3,0x20
 26e:	0685                	addi	a3,a3,1
 270:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 272:	00054783          	lbu	a5,0(a0)
 276:	0005c703          	lbu	a4,0(a1)
 27a:	00e79863          	bne	a5,a4,28a <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 27e:	0505                	addi	a0,a0,1
    p2++;
 280:	0585                	addi	a1,a1,1
  while (n-- > 0)
 282:	fed518e3          	bne	a0,a3,272 <memcmp+0x16>
  }
  return 0;
 286:	4501                	li	a0,0
 288:	a019                	j	28e <memcmp+0x32>
      return *p1 - *p2;
 28a:	40e7853b          	subw	a0,a5,a4
}
 28e:	60a2                	ld	ra,8(sp)
 290:	6402                	ld	s0,0(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
  return 0;
 296:	4501                	li	a0,0
 298:	bfdd                	j	28e <memcmp+0x32>

000000000000029a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a2:	f5fff0ef          	jal	200 <memmove>
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <strcat>:

char *strcat(char *dst, const char *src)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	c795                	beqz	a5,2e6 <strcat+0x38>
  char *p = dst;
 2bc:	87aa                	mv	a5,a0
    p++;
 2be:	0785                	addi	a5,a5,1
  while (*p)
 2c0:	0007c703          	lbu	a4,0(a5)
 2c4:	ff6d                	bnez	a4,2be <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 2c6:	0005c703          	lbu	a4,0(a1)
 2ca:	cb01                	beqz	a4,2da <strcat+0x2c>
  {
    *p = *src;
 2cc:	00e78023          	sb	a4,0(a5)
    p++;
 2d0:	0785                	addi	a5,a5,1
    src++;
 2d2:	0585                	addi	a1,a1,1
  while (*src)
 2d4:	0005c703          	lbu	a4,0(a1)
 2d8:	fb75                	bnez	a4,2cc <strcat+0x1e>
  }

  *p = 0;
 2da:	00078023          	sb	zero,0(a5)

  return dst;
}
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
  char *p = dst;
 2e6:	87aa                	mv	a5,a0
 2e8:	bff9                	j	2c6 <strcat+0x18>

00000000000002ea <isdir>:

int isdir(char *path)
{
 2ea:	7179                	addi	sp,sp,-48
 2ec:	f406                	sd	ra,40(sp)
 2ee:	f022                	sd	s0,32(sp)
 2f0:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 2f2:	fd840593          	addi	a1,s0,-40
 2f6:	e85ff0ef          	jal	17a <stat>
 2fa:	00054b63          	bltz	a0,310 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 2fe:	fe041503          	lh	a0,-32(s0)
 302:	157d                	addi	a0,a0,-1
 304:	00153513          	seqz	a0,a0
}
 308:	70a2                	ld	ra,40(sp)
 30a:	7402                	ld	s0,32(sp)
 30c:	6145                	addi	sp,sp,48
 30e:	8082                	ret
    return 0;
 310:	4501                	li	a0,0
 312:	bfdd                	j	308 <isdir+0x1e>

0000000000000314 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 314:	7139                	addi	sp,sp,-64
 316:	fc06                	sd	ra,56(sp)
 318:	f822                	sd	s0,48(sp)
 31a:	f426                	sd	s1,40(sp)
 31c:	f04a                	sd	s2,32(sp)
 31e:	ec4e                	sd	s3,24(sp)
 320:	e852                	sd	s4,16(sp)
 322:	e456                	sd	s5,8(sp)
 324:	0080                	addi	s0,sp,64
 326:	89aa                	mv	s3,a0
 328:	8aae                	mv	s5,a1
 32a:	84b2                	mv	s1,a2
 32c:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 32e:	d4dff0ef          	jal	7a <strlen>
 332:	892a                	mv	s2,a0
  int nn = strlen(filename);
 334:	8556                	mv	a0,s5
 336:	d45ff0ef          	jal	7a <strlen>
  int need = dn + 1 + nn + 1;
 33a:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 33e:	9fa9                	addw	a5,a5,a0
    return 0;
 340:	4501                	li	a0,0
  if (need > bufsize)
 342:	0347d763          	bge	a5,s4,370 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 346:	85ce                	mv	a1,s3
 348:	8526                	mv	a0,s1
 34a:	ce1ff0ef          	jal	2a <strcpy>
  if (dir[dn - 1] != '/')
 34e:	99ca                	add	s3,s3,s2
 350:	fff9c703          	lbu	a4,-1(s3)
 354:	02f00793          	li	a5,47
 358:	00f70763          	beq	a4,a5,366 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 35c:	9926                	add	s2,s2,s1
 35e:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 362:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 366:	85d6                	mv	a1,s5
 368:	8526                	mv	a0,s1
 36a:	f45ff0ef          	jal	2ae <strcat>
  return out_buffer;
 36e:	8526                	mv	a0,s1
}
 370:	70e2                	ld	ra,56(sp)
 372:	7442                	ld	s0,48(sp)
 374:	74a2                	ld	s1,40(sp)
 376:	7902                	ld	s2,32(sp)
 378:	69e2                	ld	s3,24(sp)
 37a:	6a42                	ld	s4,16(sp)
 37c:	6aa2                	ld	s5,8(sp)
 37e:	6121                	addi	sp,sp,64
 380:	8082                	ret

0000000000000382 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 382:	4885                	li	a7,1
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <exit>:
.global exit
exit:
 li a7, SYS_exit
 38a:	4889                	li	a7,2
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <wait>:
.global wait
wait:
 li a7, SYS_wait
 392:	488d                	li	a7,3
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 39a:	4891                	li	a7,4
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <read>:
.global read
read:
 li a7, SYS_read
 3a2:	4895                	li	a7,5
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <write>:
.global write
write:
 li a7, SYS_write
 3aa:	48c1                	li	a7,16
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <close>:
.global close
close:
 li a7, SYS_close
 3b2:	48d5                	li	a7,21
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ba:	4899                	li	a7,6
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c2:	489d                	li	a7,7
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <open>:
.global open
open:
 li a7, SYS_open
 3ca:	48bd                	li	a7,15
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d2:	48c5                	li	a7,17
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3da:	48c9                	li	a7,18
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e2:	48a1                	li	a7,8
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <link>:
.global link
link:
 li a7, SYS_link
 3ea:	48cd                	li	a7,19
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f2:	48d1                	li	a7,20
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fa:	48a5                	li	a7,9
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <dup>:
.global dup
dup:
 li a7, SYS_dup
 402:	48a9                	li	a7,10
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40a:	48ad                	li	a7,11
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 412:	48b1                	li	a7,12
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 41a:	48b5                	li	a7,13
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 422:	48b9                	li	a7,14
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 42a:	48d9                	li	a7,22
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 432:	1101                	addi	sp,sp,-32
 434:	ec06                	sd	ra,24(sp)
 436:	e822                	sd	s0,16(sp)
 438:	1000                	addi	s0,sp,32
 43a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 43e:	4605                	li	a2,1
 440:	fef40593          	addi	a1,s0,-17
 444:	f67ff0ef          	jal	3aa <write>
}
 448:	60e2                	ld	ra,24(sp)
 44a:	6442                	ld	s0,16(sp)
 44c:	6105                	addi	sp,sp,32
 44e:	8082                	ret

0000000000000450 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	7139                	addi	sp,sp,-64
 452:	fc06                	sd	ra,56(sp)
 454:	f822                	sd	s0,48(sp)
 456:	f426                	sd	s1,40(sp)
 458:	f04a                	sd	s2,32(sp)
 45a:	ec4e                	sd	s3,24(sp)
 45c:	0080                	addi	s0,sp,64
 45e:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 460:	c299                	beqz	a3,466 <printint+0x16>
 462:	0605ce63          	bltz	a1,4de <printint+0x8e>
  neg = 0;
 466:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 468:	fc040313          	addi	t1,s0,-64
  neg = 0;
 46c:	869a                	mv	a3,t1
  i = 0;
 46e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 470:	00000817          	auipc	a6,0x0
 474:	4d880813          	addi	a6,a6,1240 # 948 <digits>
 478:	88be                	mv	a7,a5
 47a:	0017851b          	addiw	a0,a5,1
 47e:	87aa                	mv	a5,a0
 480:	02c5f73b          	remuw	a4,a1,a2
 484:	1702                	slli	a4,a4,0x20
 486:	9301                	srli	a4,a4,0x20
 488:	9742                	add	a4,a4,a6
 48a:	00074703          	lbu	a4,0(a4)
 48e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 492:	872e                	mv	a4,a1
 494:	02c5d5bb          	divuw	a1,a1,a2
 498:	0685                	addi	a3,a3,1
 49a:	fcc77fe3          	bgeu	a4,a2,478 <printint+0x28>
  if(neg)
 49e:	000e0c63          	beqz	t3,4b6 <printint+0x66>
    buf[i++] = '-';
 4a2:	fd050793          	addi	a5,a0,-48
 4a6:	00878533          	add	a0,a5,s0
 4aa:	02d00793          	li	a5,45
 4ae:	fef50823          	sb	a5,-16(a0)
 4b2:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4b6:	fff7899b          	addiw	s3,a5,-1
 4ba:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4be:	fff4c583          	lbu	a1,-1(s1)
 4c2:	854a                	mv	a0,s2
 4c4:	f6fff0ef          	jal	432 <putc>
  while(--i >= 0)
 4c8:	39fd                	addiw	s3,s3,-1
 4ca:	14fd                	addi	s1,s1,-1
 4cc:	fe09d9e3          	bgez	s3,4be <printint+0x6e>
}
 4d0:	70e2                	ld	ra,56(sp)
 4d2:	7442                	ld	s0,48(sp)
 4d4:	74a2                	ld	s1,40(sp)
 4d6:	7902                	ld	s2,32(sp)
 4d8:	69e2                	ld	s3,24(sp)
 4da:	6121                	addi	sp,sp,64
 4dc:	8082                	ret
    x = -xx;
 4de:	40b005bb          	negw	a1,a1
    neg = 1;
 4e2:	4e05                	li	t3,1
    x = -xx;
 4e4:	b751                	j	468 <printint+0x18>

00000000000004e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e6:	711d                	addi	sp,sp,-96
 4e8:	ec86                	sd	ra,88(sp)
 4ea:	e8a2                	sd	s0,80(sp)
 4ec:	e4a6                	sd	s1,72(sp)
 4ee:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f0:	0005c483          	lbu	s1,0(a1)
 4f4:	26048663          	beqz	s1,760 <vprintf+0x27a>
 4f8:	e0ca                	sd	s2,64(sp)
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
 510:	4901                	li	s2,0
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
 520:	a00d                	j	542 <vprintf+0x5c>
        putc(fd, c0);
 522:	85a6                	mv	a1,s1
 524:	855a                	mv	a0,s6
 526:	f0dff0ef          	jal	432 <putc>
 52a:	a019                	j	530 <vprintf+0x4a>
    } else if(state == '%'){
 52c:	03598363          	beq	s3,s5,552 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 530:	0019079b          	addiw	a5,s2,1
 534:	893e                	mv	s2,a5
 536:	873e                	mv	a4,a5
 538:	97d2                	add	a5,a5,s4
 53a:	0007c483          	lbu	s1,0(a5)
 53e:	20048963          	beqz	s1,750 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 542:	0004879b          	sext.w	a5,s1
    if(state == 0){
 546:	fe0993e3          	bnez	s3,52c <vprintf+0x46>
      if(c0 == '%'){
 54a:	fd579ce3          	bne	a5,s5,522 <vprintf+0x3c>
        state = '%';
 54e:	89be                	mv	s3,a5
 550:	b7c5                	j	530 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 552:	00ea06b3          	add	a3,s4,a4
 556:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 55a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 55c:	c681                	beqz	a3,564 <vprintf+0x7e>
 55e:	9752                	add	a4,a4,s4
 560:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 564:	03878e63          	beq	a5,s8,5a0 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 568:	05978863          	beq	a5,s9,5b8 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 56c:	07500713          	li	a4,117
 570:	0ee78263          	beq	a5,a4,654 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 574:	07800713          	li	a4,120
 578:	12e78463          	beq	a5,a4,6a0 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 57c:	07000713          	li	a4,112
 580:	14e78963          	beq	a5,a4,6d2 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 584:	07300713          	li	a4,115
 588:	18e78863          	beq	a5,a4,718 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 58c:	02500713          	li	a4,37
 590:	04e79463          	bne	a5,a4,5d8 <vprintf+0xf2>
        putc(fd, '%');
 594:	85ba                	mv	a1,a4
 596:	855a                	mv	a0,s6
 598:	e9bff0ef          	jal	432 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 59c:	4981                	li	s3,0
 59e:	bf49                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5a0:	008b8493          	addi	s1,s7,8
 5a4:	4685                	li	a3,1
 5a6:	4629                	li	a2,10
 5a8:	000ba583          	lw	a1,0(s7)
 5ac:	855a                	mv	a0,s6
 5ae:	ea3ff0ef          	jal	450 <printint>
 5b2:	8ba6                	mv	s7,s1
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	bfad                	j	530 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5b8:	06400793          	li	a5,100
 5bc:	02f68963          	beq	a3,a5,5ee <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5c0:	06c00793          	li	a5,108
 5c4:	04f68263          	beq	a3,a5,608 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 5c8:	07500793          	li	a5,117
 5cc:	0af68063          	beq	a3,a5,66c <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 5d0:	07800793          	li	a5,120
 5d4:	0ef68263          	beq	a3,a5,6b8 <vprintf+0x1d2>
        putc(fd, '%');
 5d8:	02500593          	li	a1,37
 5dc:	855a                	mv	a0,s6
 5de:	e55ff0ef          	jal	432 <putc>
        putc(fd, c0);
 5e2:	85a6                	mv	a1,s1
 5e4:	855a                	mv	a0,s6
 5e6:	e4dff0ef          	jal	432 <putc>
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	b791                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ee:	008b8493          	addi	s1,s7,8
 5f2:	4685                	li	a3,1
 5f4:	4629                	li	a2,10
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	e55ff0ef          	jal	450 <printint>
        i += 1;
 600:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 602:	8ba6                	mv	s7,s1
      state = 0;
 604:	4981                	li	s3,0
        i += 1;
 606:	b72d                	j	530 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 608:	06400793          	li	a5,100
 60c:	02f60763          	beq	a2,a5,63a <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 610:	07500793          	li	a5,117
 614:	06f60963          	beq	a2,a5,686 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 618:	07800793          	li	a5,120
 61c:	faf61ee3          	bne	a2,a5,5d8 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 620:	008b8493          	addi	s1,s7,8
 624:	4681                	li	a3,0
 626:	4641                	li	a2,16
 628:	000ba583          	lw	a1,0(s7)
 62c:	855a                	mv	a0,s6
 62e:	e23ff0ef          	jal	450 <printint>
        i += 2;
 632:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 634:	8ba6                	mv	s7,s1
      state = 0;
 636:	4981                	li	s3,0
        i += 2;
 638:	bde5                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63a:	008b8493          	addi	s1,s7,8
 63e:	4685                	li	a3,1
 640:	4629                	li	a2,10
 642:	000ba583          	lw	a1,0(s7)
 646:	855a                	mv	a0,s6
 648:	e09ff0ef          	jal	450 <printint>
        i += 2;
 64c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 64e:	8ba6                	mv	s7,s1
      state = 0;
 650:	4981                	li	s3,0
        i += 2;
 652:	bdf9                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 654:	008b8493          	addi	s1,s7,8
 658:	4681                	li	a3,0
 65a:	4629                	li	a2,10
 65c:	000ba583          	lw	a1,0(s7)
 660:	855a                	mv	a0,s6
 662:	defff0ef          	jal	450 <printint>
 666:	8ba6                	mv	s7,s1
      state = 0;
 668:	4981                	li	s3,0
 66a:	b5d9                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 66c:	008b8493          	addi	s1,s7,8
 670:	4681                	li	a3,0
 672:	4629                	li	a2,10
 674:	000ba583          	lw	a1,0(s7)
 678:	855a                	mv	a0,s6
 67a:	dd7ff0ef          	jal	450 <printint>
        i += 1;
 67e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 680:	8ba6                	mv	s7,s1
      state = 0;
 682:	4981                	li	s3,0
        i += 1;
 684:	b575                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 686:	008b8493          	addi	s1,s7,8
 68a:	4681                	li	a3,0
 68c:	4629                	li	a2,10
 68e:	000ba583          	lw	a1,0(s7)
 692:	855a                	mv	a0,s6
 694:	dbdff0ef          	jal	450 <printint>
        i += 2;
 698:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 69a:	8ba6                	mv	s7,s1
      state = 0;
 69c:	4981                	li	s3,0
        i += 2;
 69e:	bd49                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6a0:	008b8493          	addi	s1,s7,8
 6a4:	4681                	li	a3,0
 6a6:	4641                	li	a2,16
 6a8:	000ba583          	lw	a1,0(s7)
 6ac:	855a                	mv	a0,s6
 6ae:	da3ff0ef          	jal	450 <printint>
 6b2:	8ba6                	mv	s7,s1
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	bdad                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b8:	008b8493          	addi	s1,s7,8
 6bc:	4681                	li	a3,0
 6be:	4641                	li	a2,16
 6c0:	000ba583          	lw	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	d8bff0ef          	jal	450 <printint>
        i += 1;
 6ca:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6cc:	8ba6                	mv	s7,s1
      state = 0;
 6ce:	4981                	li	s3,0
        i += 1;
 6d0:	b585                	j	530 <vprintf+0x4a>
 6d2:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6d4:	008b8d13          	addi	s10,s7,8
 6d8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6dc:	03000593          	li	a1,48
 6e0:	855a                	mv	a0,s6
 6e2:	d51ff0ef          	jal	432 <putc>
  putc(fd, 'x');
 6e6:	07800593          	li	a1,120
 6ea:	855a                	mv	a0,s6
 6ec:	d47ff0ef          	jal	432 <putc>
 6f0:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6f2:	00000b97          	auipc	s7,0x0
 6f6:	256b8b93          	addi	s7,s7,598 # 948 <digits>
 6fa:	03c9d793          	srli	a5,s3,0x3c
 6fe:	97de                	add	a5,a5,s7
 700:	0007c583          	lbu	a1,0(a5)
 704:	855a                	mv	a0,s6
 706:	d2dff0ef          	jal	432 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 70a:	0992                	slli	s3,s3,0x4
 70c:	34fd                	addiw	s1,s1,-1
 70e:	f4f5                	bnez	s1,6fa <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 710:	8bea                	mv	s7,s10
      state = 0;
 712:	4981                	li	s3,0
 714:	6d02                	ld	s10,0(sp)
 716:	bd29                	j	530 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 718:	008b8993          	addi	s3,s7,8
 71c:	000bb483          	ld	s1,0(s7)
 720:	cc91                	beqz	s1,73c <vprintf+0x256>
        for(; *s; s++)
 722:	0004c583          	lbu	a1,0(s1)
 726:	c195                	beqz	a1,74a <vprintf+0x264>
          putc(fd, *s);
 728:	855a                	mv	a0,s6
 72a:	d09ff0ef          	jal	432 <putc>
        for(; *s; s++)
 72e:	0485                	addi	s1,s1,1
 730:	0004c583          	lbu	a1,0(s1)
 734:	f9f5                	bnez	a1,728 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 736:	8bce                	mv	s7,s3
      state = 0;
 738:	4981                	li	s3,0
 73a:	bbdd                	j	530 <vprintf+0x4a>
          s = "(null)";
 73c:	00000497          	auipc	s1,0x0
 740:	20448493          	addi	s1,s1,516 # 940 <malloc+0xf4>
        for(; *s; s++)
 744:	02800593          	li	a1,40
 748:	b7c5                	j	728 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 74a:	8bce                	mv	s7,s3
      state = 0;
 74c:	4981                	li	s3,0
 74e:	b3cd                	j	530 <vprintf+0x4a>
 750:	6906                	ld	s2,64(sp)
 752:	79e2                	ld	s3,56(sp)
 754:	7a42                	ld	s4,48(sp)
 756:	7aa2                	ld	s5,40(sp)
 758:	7b02                	ld	s6,32(sp)
 75a:	6be2                	ld	s7,24(sp)
 75c:	6c42                	ld	s8,16(sp)
 75e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 760:	60e6                	ld	ra,88(sp)
 762:	6446                	ld	s0,80(sp)
 764:	64a6                	ld	s1,72(sp)
 766:	6125                	addi	sp,sp,96
 768:	8082                	ret

000000000000076a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 76a:	715d                	addi	sp,sp,-80
 76c:	ec06                	sd	ra,24(sp)
 76e:	e822                	sd	s0,16(sp)
 770:	1000                	addi	s0,sp,32
 772:	e010                	sd	a2,0(s0)
 774:	e414                	sd	a3,8(s0)
 776:	e818                	sd	a4,16(s0)
 778:	ec1c                	sd	a5,24(s0)
 77a:	03043023          	sd	a6,32(s0)
 77e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 782:	8622                	mv	a2,s0
 784:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 788:	d5fff0ef          	jal	4e6 <vprintf>
}
 78c:	60e2                	ld	ra,24(sp)
 78e:	6442                	ld	s0,16(sp)
 790:	6161                	addi	sp,sp,80
 792:	8082                	ret

0000000000000794 <printf>:

void
printf(const char *fmt, ...)
{
 794:	711d                	addi	sp,sp,-96
 796:	ec06                	sd	ra,24(sp)
 798:	e822                	sd	s0,16(sp)
 79a:	1000                	addi	s0,sp,32
 79c:	e40c                	sd	a1,8(s0)
 79e:	e810                	sd	a2,16(s0)
 7a0:	ec14                	sd	a3,24(s0)
 7a2:	f018                	sd	a4,32(s0)
 7a4:	f41c                	sd	a5,40(s0)
 7a6:	03043823          	sd	a6,48(s0)
 7aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ae:	00840613          	addi	a2,s0,8
 7b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b6:	85aa                	mv	a1,a0
 7b8:	4505                	li	a0,1
 7ba:	d2dff0ef          	jal	4e6 <vprintf>
}
 7be:	60e2                	ld	ra,24(sp)
 7c0:	6442                	ld	s0,16(sp)
 7c2:	6125                	addi	sp,sp,96
 7c4:	8082                	ret

00000000000007c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c6:	1141                	addi	sp,sp,-16
 7c8:	e406                	sd	ra,8(sp)
 7ca:	e022                	sd	s0,0(sp)
 7cc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ce:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d2:	00001797          	auipc	a5,0x1
 7d6:	82e7b783          	ld	a5,-2002(a5) # 1000 <freep>
 7da:	a02d                	j	804 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7dc:	4618                	lw	a4,8(a2)
 7de:	9f2d                	addw	a4,a4,a1
 7e0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e4:	6398                	ld	a4,0(a5)
 7e6:	6310                	ld	a2,0(a4)
 7e8:	a83d                	j	826 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ea:	ff852703          	lw	a4,-8(a0)
 7ee:	9f31                	addw	a4,a4,a2
 7f0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7f2:	ff053683          	ld	a3,-16(a0)
 7f6:	a091                	j	83a <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f8:	6398                	ld	a4,0(a5)
 7fa:	00e7e463          	bltu	a5,a4,802 <free+0x3c>
 7fe:	00e6ea63          	bltu	a3,a4,812 <free+0x4c>
{
 802:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 804:	fed7fae3          	bgeu	a5,a3,7f8 <free+0x32>
 808:	6398                	ld	a4,0(a5)
 80a:	00e6e463          	bltu	a3,a4,812 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80e:	fee7eae3          	bltu	a5,a4,802 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 812:	ff852583          	lw	a1,-8(a0)
 816:	6390                	ld	a2,0(a5)
 818:	02059813          	slli	a6,a1,0x20
 81c:	01c85713          	srli	a4,a6,0x1c
 820:	9736                	add	a4,a4,a3
 822:	fae60de3          	beq	a2,a4,7dc <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 826:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 82a:	4790                	lw	a2,8(a5)
 82c:	02061593          	slli	a1,a2,0x20
 830:	01c5d713          	srli	a4,a1,0x1c
 834:	973e                	add	a4,a4,a5
 836:	fae68ae3          	beq	a3,a4,7ea <free+0x24>
    p->s.ptr = bp->s.ptr;
 83a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 83c:	00000717          	auipc	a4,0x0
 840:	7cf73223          	sd	a5,1988(a4) # 1000 <freep>
}
 844:	60a2                	ld	ra,8(sp)
 846:	6402                	ld	s0,0(sp)
 848:	0141                	addi	sp,sp,16
 84a:	8082                	ret

000000000000084c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84c:	7139                	addi	sp,sp,-64
 84e:	fc06                	sd	ra,56(sp)
 850:	f822                	sd	s0,48(sp)
 852:	f04a                	sd	s2,32(sp)
 854:	ec4e                	sd	s3,24(sp)
 856:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 858:	02051993          	slli	s3,a0,0x20
 85c:	0209d993          	srli	s3,s3,0x20
 860:	09bd                	addi	s3,s3,15
 862:	0049d993          	srli	s3,s3,0x4
 866:	2985                	addiw	s3,s3,1
 868:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 86a:	00000517          	auipc	a0,0x0
 86e:	79653503          	ld	a0,1942(a0) # 1000 <freep>
 872:	c905                	beqz	a0,8a2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 874:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 876:	4798                	lw	a4,8(a5)
 878:	09377663          	bgeu	a4,s3,904 <malloc+0xb8>
 87c:	f426                	sd	s1,40(sp)
 87e:	e852                	sd	s4,16(sp)
 880:	e456                	sd	s5,8(sp)
 882:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 884:	8a4e                	mv	s4,s3
 886:	6705                	lui	a4,0x1
 888:	00e9f363          	bgeu	s3,a4,88e <malloc+0x42>
 88c:	6a05                	lui	s4,0x1
 88e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 892:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 896:	00000497          	auipc	s1,0x0
 89a:	76a48493          	addi	s1,s1,1898 # 1000 <freep>
  if(p == (char*)-1)
 89e:	5afd                	li	s5,-1
 8a0:	a83d                	j	8de <malloc+0x92>
 8a2:	f426                	sd	s1,40(sp)
 8a4:	e852                	sd	s4,16(sp)
 8a6:	e456                	sd	s5,8(sp)
 8a8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8aa:	00000797          	auipc	a5,0x0
 8ae:	76678793          	addi	a5,a5,1894 # 1010 <base>
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74f73723          	sd	a5,1870(a4) # 1000 <freep>
 8ba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8bc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c0:	b7d1                	j	884 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8c2:	6398                	ld	a4,0(a5)
 8c4:	e118                	sd	a4,0(a0)
 8c6:	a899                	j	91c <malloc+0xd0>
  hp->s.size = nu;
 8c8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8cc:	0541                	addi	a0,a0,16
 8ce:	ef9ff0ef          	jal	7c6 <free>
  return freep;
 8d2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8d4:	c125                	beqz	a0,934 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d8:	4798                	lw	a4,8(a5)
 8da:	03277163          	bgeu	a4,s2,8fc <malloc+0xb0>
    if(p == freep)
 8de:	6098                	ld	a4,0(s1)
 8e0:	853e                	mv	a0,a5
 8e2:	fef71ae3          	bne	a4,a5,8d6 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8e6:	8552                	mv	a0,s4
 8e8:	b2bff0ef          	jal	412 <sbrk>
  if(p == (char*)-1)
 8ec:	fd551ee3          	bne	a0,s5,8c8 <malloc+0x7c>
        return 0;
 8f0:	4501                	li	a0,0
 8f2:	74a2                	ld	s1,40(sp)
 8f4:	6a42                	ld	s4,16(sp)
 8f6:	6aa2                	ld	s5,8(sp)
 8f8:	6b02                	ld	s6,0(sp)
 8fa:	a03d                	j	928 <malloc+0xdc>
 8fc:	74a2                	ld	s1,40(sp)
 8fe:	6a42                	ld	s4,16(sp)
 900:	6aa2                	ld	s5,8(sp)
 902:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 904:	fae90fe3          	beq	s2,a4,8c2 <malloc+0x76>
        p->s.size -= nunits;
 908:	4137073b          	subw	a4,a4,s3
 90c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 90e:	02071693          	slli	a3,a4,0x20
 912:	01c6d713          	srli	a4,a3,0x1c
 916:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 918:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 91c:	00000717          	auipc	a4,0x0
 920:	6ea73223          	sd	a0,1764(a4) # 1000 <freep>
      return (void*)(p + 1);
 924:	01078513          	addi	a0,a5,16
  }
}
 928:	70e2                	ld	ra,56(sp)
 92a:	7442                	ld	s0,48(sp)
 92c:	7902                	ld	s2,32(sp)
 92e:	69e2                	ld	s3,24(sp)
 930:	6121                	addi	sp,sp,64
 932:	8082                	ret
 934:	74a2                	ld	s1,40(sp)
 936:	6a42                	ld	s4,16(sp)
 938:	6aa2                	ld	s5,8(sp)
 93a:	6b02                	ld	s6,0(sp)
 93c:	b7f5                	j	928 <malloc+0xdc>
