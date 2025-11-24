
user/_kbdcount:     file format elf64-littleriscv


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
  printf("%d\n", get_keystrokes_count());
   8:	42a000ef          	jal	432 <get_keystrokes_count>
   c:	85aa                	mv	a1,a0
   e:	00001517          	auipc	a0,0x1
  12:	94250513          	addi	a0,a0,-1726 # 950 <malloc+0xfc>
  16:	786000ef          	jal	79c <printf>
  exit(0);
  1a:	4501                	li	a0,0
  1c:	376000ef          	jal	392 <exit>

0000000000000020 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  20:	1141                	addi	sp,sp,-16
  22:	e406                	sd	ra,8(sp)
  24:	e022                	sd	s0,0(sp)
  26:	0800                	addi	s0,sp,16
  extern int main();
  main();
  28:	fd9ff0ef          	jal	0 <main>
  exit(0);
  2c:	4501                	li	a0,0
  2e:	364000ef          	jal	392 <exit>

0000000000000032 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  32:	1141                	addi	sp,sp,-16
  34:	e406                	sd	ra,8(sp)
  36:	e022                	sd	s0,0(sp)
  38:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  3a:	87aa                	mv	a5,a0
  3c:	0585                	addi	a1,a1,1
  3e:	0785                	addi	a5,a5,1
  40:	fff5c703          	lbu	a4,-1(a1)
  44:	fee78fa3          	sb	a4,-1(a5)
  48:	fb75                	bnez	a4,3c <strcpy+0xa>
    ;
  return os;
}
  4a:	60a2                	ld	ra,8(sp)
  4c:	6402                	ld	s0,0(sp)
  4e:	0141                	addi	sp,sp,16
  50:	8082                	ret

0000000000000052 <strcmp>:

int strcmp(const char *p, const char *q)
{
  52:	1141                	addi	sp,sp,-16
  54:	e406                	sd	ra,8(sp)
  56:	e022                	sd	s0,0(sp)
  58:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  5a:	00054783          	lbu	a5,0(a0)
  5e:	cb91                	beqz	a5,72 <strcmp+0x20>
  60:	0005c703          	lbu	a4,0(a1)
  64:	00f71763          	bne	a4,a5,72 <strcmp+0x20>
    p++, q++;
  68:	0505                	addi	a0,a0,1
  6a:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  6c:	00054783          	lbu	a5,0(a0)
  70:	fbe5                	bnez	a5,60 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  72:	0005c503          	lbu	a0,0(a1)
}
  76:	40a7853b          	subw	a0,a5,a0
  7a:	60a2                	ld	ra,8(sp)
  7c:	6402                	ld	s0,0(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret

0000000000000082 <strlen>:

uint strlen(const char *s)
{
  82:	1141                	addi	sp,sp,-16
  84:	e406                	sd	ra,8(sp)
  86:	e022                	sd	s0,0(sp)
  88:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  8a:	00054783          	lbu	a5,0(a0)
  8e:	cf99                	beqz	a5,ac <strlen+0x2a>
  90:	0505                	addi	a0,a0,1
  92:	87aa                	mv	a5,a0
  94:	86be                	mv	a3,a5
  96:	0785                	addi	a5,a5,1
  98:	fff7c703          	lbu	a4,-1(a5)
  9c:	ff65                	bnez	a4,94 <strlen+0x12>
  9e:	40a6853b          	subw	a0,a3,a0
  a2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  a4:	60a2                	ld	ra,8(sp)
  a6:	6402                	ld	s0,0(sp)
  a8:	0141                	addi	sp,sp,16
  aa:	8082                	ret
  for (n = 0; s[n]; n++)
  ac:	4501                	li	a0,0
  ae:	bfdd                	j	a4 <strlen+0x22>

00000000000000b0 <memset>:

void *
memset(void *dst, int c, uint n)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e406                	sd	ra,8(sp)
  b4:	e022                	sd	s0,0(sp)
  b6:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  b8:	ca19                	beqz	a2,ce <memset+0x1e>
  ba:	87aa                	mv	a5,a0
  bc:	1602                	slli	a2,a2,0x20
  be:	9201                	srli	a2,a2,0x20
  c0:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
  c4:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  c8:	0785                	addi	a5,a5,1
  ca:	fee79de3          	bne	a5,a4,c4 <memset+0x14>
  }
  return dst;
}
  ce:	60a2                	ld	ra,8(sp)
  d0:	6402                	ld	s0,0(sp)
  d2:	0141                	addi	sp,sp,16
  d4:	8082                	ret

00000000000000d6 <strchr>:

char *
strchr(const char *s, char c)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  for (; *s; s++)
  de:	00054783          	lbu	a5,0(a0)
  e2:	cf81                	beqz	a5,fa <strchr+0x24>
    if (*s == c)
  e4:	00f58763          	beq	a1,a5,f2 <strchr+0x1c>
  for (; *s; s++)
  e8:	0505                	addi	a0,a0,1
  ea:	00054783          	lbu	a5,0(a0)
  ee:	fbfd                	bnez	a5,e4 <strchr+0xe>
      return (char *)s;
  return 0;
  f0:	4501                	li	a0,0
}
  f2:	60a2                	ld	ra,8(sp)
  f4:	6402                	ld	s0,0(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret
  return 0;
  fa:	4501                	li	a0,0
  fc:	bfdd                	j	f2 <strchr+0x1c>

00000000000000fe <gets>:

char *
gets(char *buf, int max)
{
  fe:	7159                	addi	sp,sp,-112
 100:	f486                	sd	ra,104(sp)
 102:	f0a2                	sd	s0,96(sp)
 104:	eca6                	sd	s1,88(sp)
 106:	e8ca                	sd	s2,80(sp)
 108:	e4ce                	sd	s3,72(sp)
 10a:	e0d2                	sd	s4,64(sp)
 10c:	fc56                	sd	s5,56(sp)
 10e:	f85a                	sd	s6,48(sp)
 110:	f45e                	sd	s7,40(sp)
 112:	f062                	sd	s8,32(sp)
 114:	ec66                	sd	s9,24(sp)
 116:	e86a                	sd	s10,16(sp)
 118:	1880                	addi	s0,sp,112
 11a:	8caa                	mv	s9,a0
 11c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 11e:	892a                	mv	s2,a0
 120:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 122:	f9f40b13          	addi	s6,s0,-97
 126:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 128:	4ba9                	li	s7,10
 12a:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 12c:	8d26                	mv	s10,s1
 12e:	0014899b          	addiw	s3,s1,1
 132:	84ce                	mv	s1,s3
 134:	0349d563          	bge	s3,s4,15e <gets+0x60>
    cc = read(0, &c, 1);
 138:	8656                	mv	a2,s5
 13a:	85da                	mv	a1,s6
 13c:	4501                	li	a0,0
 13e:	26c000ef          	jal	3aa <read>
    if (cc < 1)
 142:	00a05e63          	blez	a0,15e <gets+0x60>
    buf[i++] = c;
 146:	f9f44783          	lbu	a5,-97(s0)
 14a:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 14e:	01778763          	beq	a5,s7,15c <gets+0x5e>
 152:	0905                	addi	s2,s2,1
 154:	fd879ce3          	bne	a5,s8,12c <gets+0x2e>
    buf[i++] = c;
 158:	8d4e                	mv	s10,s3
 15a:	a011                	j	15e <gets+0x60>
 15c:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 15e:	9d66                	add	s10,s10,s9
 160:	000d0023          	sb	zero,0(s10)
  return buf;
}
 164:	8566                	mv	a0,s9
 166:	70a6                	ld	ra,104(sp)
 168:	7406                	ld	s0,96(sp)
 16a:	64e6                	ld	s1,88(sp)
 16c:	6946                	ld	s2,80(sp)
 16e:	69a6                	ld	s3,72(sp)
 170:	6a06                	ld	s4,64(sp)
 172:	7ae2                	ld	s5,56(sp)
 174:	7b42                	ld	s6,48(sp)
 176:	7ba2                	ld	s7,40(sp)
 178:	7c02                	ld	s8,32(sp)
 17a:	6ce2                	ld	s9,24(sp)
 17c:	6d42                	ld	s10,16(sp)
 17e:	6165                	addi	sp,sp,112
 180:	8082                	ret

0000000000000182 <stat>:

int stat(const char *n, struct stat *st)
{
 182:	1101                	addi	sp,sp,-32
 184:	ec06                	sd	ra,24(sp)
 186:	e822                	sd	s0,16(sp)
 188:	e04a                	sd	s2,0(sp)
 18a:	1000                	addi	s0,sp,32
 18c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18e:	4581                	li	a1,0
 190:	242000ef          	jal	3d2 <open>
  if (fd < 0)
 194:	02054263          	bltz	a0,1b8 <stat+0x36>
 198:	e426                	sd	s1,8(sp)
 19a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19c:	85ca                	mv	a1,s2
 19e:	24c000ef          	jal	3ea <fstat>
 1a2:	892a                	mv	s2,a0
  close(fd);
 1a4:	8526                	mv	a0,s1
 1a6:	214000ef          	jal	3ba <close>
  return r;
 1aa:	64a2                	ld	s1,8(sp)
}
 1ac:	854a                	mv	a0,s2
 1ae:	60e2                	ld	ra,24(sp)
 1b0:	6442                	ld	s0,16(sp)
 1b2:	6902                	ld	s2,0(sp)
 1b4:	6105                	addi	sp,sp,32
 1b6:	8082                	ret
    return -1;
 1b8:	597d                	li	s2,-1
 1ba:	bfcd                	j	1ac <stat+0x2a>

00000000000001bc <atoi>:

int atoi(const char *s)
{
 1bc:	1141                	addi	sp,sp,-16
 1be:	e406                	sd	ra,8(sp)
 1c0:	e022                	sd	s0,0(sp)
 1c2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1c4:	00054683          	lbu	a3,0(a0)
 1c8:	fd06879b          	addiw	a5,a3,-48
 1cc:	0ff7f793          	zext.b	a5,a5
 1d0:	4625                	li	a2,9
 1d2:	02f66963          	bltu	a2,a5,204 <atoi+0x48>
 1d6:	872a                	mv	a4,a0
  n = 0;
 1d8:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 1da:	0705                	addi	a4,a4,1
 1dc:	0025179b          	slliw	a5,a0,0x2
 1e0:	9fa9                	addw	a5,a5,a0
 1e2:	0017979b          	slliw	a5,a5,0x1
 1e6:	9fb5                	addw	a5,a5,a3
 1e8:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 1ec:	00074683          	lbu	a3,0(a4)
 1f0:	fd06879b          	addiw	a5,a3,-48
 1f4:	0ff7f793          	zext.b	a5,a5
 1f8:	fef671e3          	bgeu	a2,a5,1da <atoi+0x1e>
  return n;
}
 1fc:	60a2                	ld	ra,8(sp)
 1fe:	6402                	ld	s0,0(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret
  n = 0;
 204:	4501                	li	a0,0
 206:	bfdd                	j	1fc <atoi+0x40>

0000000000000208 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 208:	1141                	addi	sp,sp,-16
 20a:	e406                	sd	ra,8(sp)
 20c:	e022                	sd	s0,0(sp)
 20e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 210:	02b57563          	bgeu	a0,a1,23a <memmove+0x32>
  {
    while (n-- > 0)
 214:	00c05f63          	blez	a2,232 <memmove+0x2a>
 218:	1602                	slli	a2,a2,0x20
 21a:	9201                	srli	a2,a2,0x20
 21c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 220:	872a                	mv	a4,a0
      *dst++ = *src++;
 222:	0585                	addi	a1,a1,1
 224:	0705                	addi	a4,a4,1
 226:	fff5c683          	lbu	a3,-1(a1)
 22a:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 22e:	fee79ae3          	bne	a5,a4,222 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 232:	60a2                	ld	ra,8(sp)
 234:	6402                	ld	s0,0(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret
    dst += n;
 23a:	00c50733          	add	a4,a0,a2
    src += n;
 23e:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 240:	fec059e3          	blez	a2,232 <memmove+0x2a>
 244:	fff6079b          	addiw	a5,a2,-1
 248:	1782                	slli	a5,a5,0x20
 24a:	9381                	srli	a5,a5,0x20
 24c:	fff7c793          	not	a5,a5
 250:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 252:	15fd                	addi	a1,a1,-1
 254:	177d                	addi	a4,a4,-1
 256:	0005c683          	lbu	a3,0(a1)
 25a:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 25e:	fef71ae3          	bne	a4,a5,252 <memmove+0x4a>
 262:	bfc1                	j	232 <memmove+0x2a>

0000000000000264 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 264:	1141                	addi	sp,sp,-16
 266:	e406                	sd	ra,8(sp)
 268:	e022                	sd	s0,0(sp)
 26a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 26c:	ca0d                	beqz	a2,29e <memcmp+0x3a>
 26e:	fff6069b          	addiw	a3,a2,-1
 272:	1682                	slli	a3,a3,0x20
 274:	9281                	srli	a3,a3,0x20
 276:	0685                	addi	a3,a3,1
 278:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 27a:	00054783          	lbu	a5,0(a0)
 27e:	0005c703          	lbu	a4,0(a1)
 282:	00e79863          	bne	a5,a4,292 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 286:	0505                	addi	a0,a0,1
    p2++;
 288:	0585                	addi	a1,a1,1
  while (n-- > 0)
 28a:	fed518e3          	bne	a0,a3,27a <memcmp+0x16>
  }
  return 0;
 28e:	4501                	li	a0,0
 290:	a019                	j	296 <memcmp+0x32>
      return *p1 - *p2;
 292:	40e7853b          	subw	a0,a5,a4
}
 296:	60a2                	ld	ra,8(sp)
 298:	6402                	ld	s0,0(sp)
 29a:	0141                	addi	sp,sp,16
 29c:	8082                	ret
  return 0;
 29e:	4501                	li	a0,0
 2a0:	bfdd                	j	296 <memcmp+0x32>

00000000000002a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e406                	sd	ra,8(sp)
 2a6:	e022                	sd	s0,0(sp)
 2a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2aa:	f5fff0ef          	jal	208 <memmove>
}
 2ae:	60a2                	ld	ra,8(sp)
 2b0:	6402                	ld	s0,0(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <strcat>:

char *strcat(char *dst, const char *src)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	c795                	beqz	a5,2ee <strcat+0x38>
  char *p = dst;
 2c4:	87aa                	mv	a5,a0
    p++;
 2c6:	0785                	addi	a5,a5,1
  while (*p)
 2c8:	0007c703          	lbu	a4,0(a5)
 2cc:	ff6d                	bnez	a4,2c6 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 2ce:	0005c703          	lbu	a4,0(a1)
 2d2:	cb01                	beqz	a4,2e2 <strcat+0x2c>
  {
    *p = *src;
 2d4:	00e78023          	sb	a4,0(a5)
    p++;
 2d8:	0785                	addi	a5,a5,1
    src++;
 2da:	0585                	addi	a1,a1,1
  while (*src)
 2dc:	0005c703          	lbu	a4,0(a1)
 2e0:	fb75                	bnez	a4,2d4 <strcat+0x1e>
  }

  *p = 0;
 2e2:	00078023          	sb	zero,0(a5)

  return dst;
}
 2e6:	60a2                	ld	ra,8(sp)
 2e8:	6402                	ld	s0,0(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret
  char *p = dst;
 2ee:	87aa                	mv	a5,a0
 2f0:	bff9                	j	2ce <strcat+0x18>

00000000000002f2 <isdir>:

int isdir(char *path)
{
 2f2:	7179                	addi	sp,sp,-48
 2f4:	f406                	sd	ra,40(sp)
 2f6:	f022                	sd	s0,32(sp)
 2f8:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 2fa:	fd840593          	addi	a1,s0,-40
 2fe:	e85ff0ef          	jal	182 <stat>
 302:	00054b63          	bltz	a0,318 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 306:	fe041503          	lh	a0,-32(s0)
 30a:	157d                	addi	a0,a0,-1
 30c:	00153513          	seqz	a0,a0
}
 310:	70a2                	ld	ra,40(sp)
 312:	7402                	ld	s0,32(sp)
 314:	6145                	addi	sp,sp,48
 316:	8082                	ret
    return 0;
 318:	4501                	li	a0,0
 31a:	bfdd                	j	310 <isdir+0x1e>

000000000000031c <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 31c:	7139                	addi	sp,sp,-64
 31e:	fc06                	sd	ra,56(sp)
 320:	f822                	sd	s0,48(sp)
 322:	f426                	sd	s1,40(sp)
 324:	f04a                	sd	s2,32(sp)
 326:	ec4e                	sd	s3,24(sp)
 328:	e852                	sd	s4,16(sp)
 32a:	e456                	sd	s5,8(sp)
 32c:	0080                	addi	s0,sp,64
 32e:	89aa                	mv	s3,a0
 330:	8aae                	mv	s5,a1
 332:	84b2                	mv	s1,a2
 334:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 336:	d4dff0ef          	jal	82 <strlen>
 33a:	892a                	mv	s2,a0
  int nn = strlen(filename);
 33c:	8556                	mv	a0,s5
 33e:	d45ff0ef          	jal	82 <strlen>
  int need = dn + 1 + nn + 1;
 342:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 346:	9fa9                	addw	a5,a5,a0
    return 0;
 348:	4501                	li	a0,0
  if (need > bufsize)
 34a:	0347d763          	bge	a5,s4,378 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 34e:	85ce                	mv	a1,s3
 350:	8526                	mv	a0,s1
 352:	ce1ff0ef          	jal	32 <strcpy>
  if (dir[dn - 1] != '/')
 356:	99ca                	add	s3,s3,s2
 358:	fff9c703          	lbu	a4,-1(s3)
 35c:	02f00793          	li	a5,47
 360:	00f70763          	beq	a4,a5,36e <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 364:	9926                	add	s2,s2,s1
 366:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 36a:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 36e:	85d6                	mv	a1,s5
 370:	8526                	mv	a0,s1
 372:	f45ff0ef          	jal	2b6 <strcat>
  return out_buffer;
 376:	8526                	mv	a0,s1
}
 378:	70e2                	ld	ra,56(sp)
 37a:	7442                	ld	s0,48(sp)
 37c:	74a2                	ld	s1,40(sp)
 37e:	7902                	ld	s2,32(sp)
 380:	69e2                	ld	s3,24(sp)
 382:	6a42                	ld	s4,16(sp)
 384:	6aa2                	ld	s5,8(sp)
 386:	6121                	addi	sp,sp,64
 388:	8082                	ret

000000000000038a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 38a:	4885                	li	a7,1
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <exit>:
.global exit
exit:
 li a7, SYS_exit
 392:	4889                	li	a7,2
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <wait>:
.global wait
wait:
 li a7, SYS_wait
 39a:	488d                	li	a7,3
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a2:	4891                	li	a7,4
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <read>:
.global read
read:
 li a7, SYS_read
 3aa:	4895                	li	a7,5
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <write>:
.global write
write:
 li a7, SYS_write
 3b2:	48c1                	li	a7,16
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <close>:
.global close
close:
 li a7, SYS_close
 3ba:	48d5                	li	a7,21
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c2:	4899                	li	a7,6
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ca:	489d                	li	a7,7
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <open>:
.global open
open:
 li a7, SYS_open
 3d2:	48bd                	li	a7,15
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3da:	48c5                	li	a7,17
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e2:	48c9                	li	a7,18
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ea:	48a1                	li	a7,8
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <link>:
.global link
link:
 li a7, SYS_link
 3f2:	48cd                	li	a7,19
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3fa:	48d1                	li	a7,20
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 402:	48a5                	li	a7,9
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <dup>:
.global dup
dup:
 li a7, SYS_dup
 40a:	48a9                	li	a7,10
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 412:	48ad                	li	a7,11
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 41a:	48b1                	li	a7,12
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 422:	48b5                	li	a7,13
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42a:	48b9                	li	a7,14
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 432:	48d9                	li	a7,22
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 43a:	1101                	addi	sp,sp,-32
 43c:	ec06                	sd	ra,24(sp)
 43e:	e822                	sd	s0,16(sp)
 440:	1000                	addi	s0,sp,32
 442:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 446:	4605                	li	a2,1
 448:	fef40593          	addi	a1,s0,-17
 44c:	f67ff0ef          	jal	3b2 <write>
}
 450:	60e2                	ld	ra,24(sp)
 452:	6442                	ld	s0,16(sp)
 454:	6105                	addi	sp,sp,32
 456:	8082                	ret

0000000000000458 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 458:	7139                	addi	sp,sp,-64
 45a:	fc06                	sd	ra,56(sp)
 45c:	f822                	sd	s0,48(sp)
 45e:	f426                	sd	s1,40(sp)
 460:	f04a                	sd	s2,32(sp)
 462:	ec4e                	sd	s3,24(sp)
 464:	0080                	addi	s0,sp,64
 466:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 468:	c299                	beqz	a3,46e <printint+0x16>
 46a:	0605ce63          	bltz	a1,4e6 <printint+0x8e>
  neg = 0;
 46e:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 470:	fc040313          	addi	t1,s0,-64
  neg = 0;
 474:	869a                	mv	a3,t1
  i = 0;
 476:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 478:	00000817          	auipc	a6,0x0
 47c:	4e880813          	addi	a6,a6,1256 # 960 <digits>
 480:	88be                	mv	a7,a5
 482:	0017851b          	addiw	a0,a5,1
 486:	87aa                	mv	a5,a0
 488:	02c5f73b          	remuw	a4,a1,a2
 48c:	1702                	slli	a4,a4,0x20
 48e:	9301                	srli	a4,a4,0x20
 490:	9742                	add	a4,a4,a6
 492:	00074703          	lbu	a4,0(a4)
 496:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 49a:	872e                	mv	a4,a1
 49c:	02c5d5bb          	divuw	a1,a1,a2
 4a0:	0685                	addi	a3,a3,1
 4a2:	fcc77fe3          	bgeu	a4,a2,480 <printint+0x28>
  if(neg)
 4a6:	000e0c63          	beqz	t3,4be <printint+0x66>
    buf[i++] = '-';
 4aa:	fd050793          	addi	a5,a0,-48
 4ae:	00878533          	add	a0,a5,s0
 4b2:	02d00793          	li	a5,45
 4b6:	fef50823          	sb	a5,-16(a0)
 4ba:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4be:	fff7899b          	addiw	s3,a5,-1
 4c2:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4c6:	fff4c583          	lbu	a1,-1(s1)
 4ca:	854a                	mv	a0,s2
 4cc:	f6fff0ef          	jal	43a <putc>
  while(--i >= 0)
 4d0:	39fd                	addiw	s3,s3,-1
 4d2:	14fd                	addi	s1,s1,-1
 4d4:	fe09d9e3          	bgez	s3,4c6 <printint+0x6e>
}
 4d8:	70e2                	ld	ra,56(sp)
 4da:	7442                	ld	s0,48(sp)
 4dc:	74a2                	ld	s1,40(sp)
 4de:	7902                	ld	s2,32(sp)
 4e0:	69e2                	ld	s3,24(sp)
 4e2:	6121                	addi	sp,sp,64
 4e4:	8082                	ret
    x = -xx;
 4e6:	40b005bb          	negw	a1,a1
    neg = 1;
 4ea:	4e05                	li	t3,1
    x = -xx;
 4ec:	b751                	j	470 <printint+0x18>

00000000000004ee <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ee:	711d                	addi	sp,sp,-96
 4f0:	ec86                	sd	ra,88(sp)
 4f2:	e8a2                	sd	s0,80(sp)
 4f4:	e4a6                	sd	s1,72(sp)
 4f6:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f8:	0005c483          	lbu	s1,0(a1)
 4fc:	26048663          	beqz	s1,768 <vprintf+0x27a>
 500:	e0ca                	sd	s2,64(sp)
 502:	fc4e                	sd	s3,56(sp)
 504:	f852                	sd	s4,48(sp)
 506:	f456                	sd	s5,40(sp)
 508:	f05a                	sd	s6,32(sp)
 50a:	ec5e                	sd	s7,24(sp)
 50c:	e862                	sd	s8,16(sp)
 50e:	e466                	sd	s9,8(sp)
 510:	8b2a                	mv	s6,a0
 512:	8a2e                	mv	s4,a1
 514:	8bb2                	mv	s7,a2
  state = 0;
 516:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 518:	4901                	li	s2,0
 51a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 51c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 520:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 524:	06c00c93          	li	s9,108
 528:	a00d                	j	54a <vprintf+0x5c>
        putc(fd, c0);
 52a:	85a6                	mv	a1,s1
 52c:	855a                	mv	a0,s6
 52e:	f0dff0ef          	jal	43a <putc>
 532:	a019                	j	538 <vprintf+0x4a>
    } else if(state == '%'){
 534:	03598363          	beq	s3,s5,55a <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 538:	0019079b          	addiw	a5,s2,1
 53c:	893e                	mv	s2,a5
 53e:	873e                	mv	a4,a5
 540:	97d2                	add	a5,a5,s4
 542:	0007c483          	lbu	s1,0(a5)
 546:	20048963          	beqz	s1,758 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 54a:	0004879b          	sext.w	a5,s1
    if(state == 0){
 54e:	fe0993e3          	bnez	s3,534 <vprintf+0x46>
      if(c0 == '%'){
 552:	fd579ce3          	bne	a5,s5,52a <vprintf+0x3c>
        state = '%';
 556:	89be                	mv	s3,a5
 558:	b7c5                	j	538 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 55a:	00ea06b3          	add	a3,s4,a4
 55e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 562:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 564:	c681                	beqz	a3,56c <vprintf+0x7e>
 566:	9752                	add	a4,a4,s4
 568:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 56c:	03878e63          	beq	a5,s8,5a8 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 570:	05978863          	beq	a5,s9,5c0 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 574:	07500713          	li	a4,117
 578:	0ee78263          	beq	a5,a4,65c <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 57c:	07800713          	li	a4,120
 580:	12e78463          	beq	a5,a4,6a8 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 584:	07000713          	li	a4,112
 588:	14e78963          	beq	a5,a4,6da <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 58c:	07300713          	li	a4,115
 590:	18e78863          	beq	a5,a4,720 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 594:	02500713          	li	a4,37
 598:	04e79463          	bne	a5,a4,5e0 <vprintf+0xf2>
        putc(fd, '%');
 59c:	85ba                	mv	a1,a4
 59e:	855a                	mv	a0,s6
 5a0:	e9bff0ef          	jal	43a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5a4:	4981                	li	s3,0
 5a6:	bf49                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5a8:	008b8493          	addi	s1,s7,8
 5ac:	4685                	li	a3,1
 5ae:	4629                	li	a2,10
 5b0:	000ba583          	lw	a1,0(s7)
 5b4:	855a                	mv	a0,s6
 5b6:	ea3ff0ef          	jal	458 <printint>
 5ba:	8ba6                	mv	s7,s1
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	bfad                	j	538 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5c0:	06400793          	li	a5,100
 5c4:	02f68963          	beq	a3,a5,5f6 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5c8:	06c00793          	li	a5,108
 5cc:	04f68263          	beq	a3,a5,610 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 5d0:	07500793          	li	a5,117
 5d4:	0af68063          	beq	a3,a5,674 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 5d8:	07800793          	li	a5,120
 5dc:	0ef68263          	beq	a3,a5,6c0 <vprintf+0x1d2>
        putc(fd, '%');
 5e0:	02500593          	li	a1,37
 5e4:	855a                	mv	a0,s6
 5e6:	e55ff0ef          	jal	43a <putc>
        putc(fd, c0);
 5ea:	85a6                	mv	a1,s1
 5ec:	855a                	mv	a0,s6
 5ee:	e4dff0ef          	jal	43a <putc>
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	b791                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f6:	008b8493          	addi	s1,s7,8
 5fa:	4685                	li	a3,1
 5fc:	4629                	li	a2,10
 5fe:	000ba583          	lw	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	e55ff0ef          	jal	458 <printint>
        i += 1;
 608:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 60a:	8ba6                	mv	s7,s1
      state = 0;
 60c:	4981                	li	s3,0
        i += 1;
 60e:	b72d                	j	538 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 610:	06400793          	li	a5,100
 614:	02f60763          	beq	a2,a5,642 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 618:	07500793          	li	a5,117
 61c:	06f60963          	beq	a2,a5,68e <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 620:	07800793          	li	a5,120
 624:	faf61ee3          	bne	a2,a5,5e0 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 628:	008b8493          	addi	s1,s7,8
 62c:	4681                	li	a3,0
 62e:	4641                	li	a2,16
 630:	000ba583          	lw	a1,0(s7)
 634:	855a                	mv	a0,s6
 636:	e23ff0ef          	jal	458 <printint>
        i += 2;
 63a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 63c:	8ba6                	mv	s7,s1
      state = 0;
 63e:	4981                	li	s3,0
        i += 2;
 640:	bde5                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 642:	008b8493          	addi	s1,s7,8
 646:	4685                	li	a3,1
 648:	4629                	li	a2,10
 64a:	000ba583          	lw	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	e09ff0ef          	jal	458 <printint>
        i += 2;
 654:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 656:	8ba6                	mv	s7,s1
      state = 0;
 658:	4981                	li	s3,0
        i += 2;
 65a:	bdf9                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 65c:	008b8493          	addi	s1,s7,8
 660:	4681                	li	a3,0
 662:	4629                	li	a2,10
 664:	000ba583          	lw	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	defff0ef          	jal	458 <printint>
 66e:	8ba6                	mv	s7,s1
      state = 0;
 670:	4981                	li	s3,0
 672:	b5d9                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 674:	008b8493          	addi	s1,s7,8
 678:	4681                	li	a3,0
 67a:	4629                	li	a2,10
 67c:	000ba583          	lw	a1,0(s7)
 680:	855a                	mv	a0,s6
 682:	dd7ff0ef          	jal	458 <printint>
        i += 1;
 686:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 688:	8ba6                	mv	s7,s1
      state = 0;
 68a:	4981                	li	s3,0
        i += 1;
 68c:	b575                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 68e:	008b8493          	addi	s1,s7,8
 692:	4681                	li	a3,0
 694:	4629                	li	a2,10
 696:	000ba583          	lw	a1,0(s7)
 69a:	855a                	mv	a0,s6
 69c:	dbdff0ef          	jal	458 <printint>
        i += 2;
 6a0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a2:	8ba6                	mv	s7,s1
      state = 0;
 6a4:	4981                	li	s3,0
        i += 2;
 6a6:	bd49                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6a8:	008b8493          	addi	s1,s7,8
 6ac:	4681                	li	a3,0
 6ae:	4641                	li	a2,16
 6b0:	000ba583          	lw	a1,0(s7)
 6b4:	855a                	mv	a0,s6
 6b6:	da3ff0ef          	jal	458 <printint>
 6ba:	8ba6                	mv	s7,s1
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	bdad                	j	538 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c0:	008b8493          	addi	s1,s7,8
 6c4:	4681                	li	a3,0
 6c6:	4641                	li	a2,16
 6c8:	000ba583          	lw	a1,0(s7)
 6cc:	855a                	mv	a0,s6
 6ce:	d8bff0ef          	jal	458 <printint>
        i += 1;
 6d2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d4:	8ba6                	mv	s7,s1
      state = 0;
 6d6:	4981                	li	s3,0
        i += 1;
 6d8:	b585                	j	538 <vprintf+0x4a>
 6da:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6dc:	008b8d13          	addi	s10,s7,8
 6e0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e4:	03000593          	li	a1,48
 6e8:	855a                	mv	a0,s6
 6ea:	d51ff0ef          	jal	43a <putc>
  putc(fd, 'x');
 6ee:	07800593          	li	a1,120
 6f2:	855a                	mv	a0,s6
 6f4:	d47ff0ef          	jal	43a <putc>
 6f8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fa:	00000b97          	auipc	s7,0x0
 6fe:	266b8b93          	addi	s7,s7,614 # 960 <digits>
 702:	03c9d793          	srli	a5,s3,0x3c
 706:	97de                	add	a5,a5,s7
 708:	0007c583          	lbu	a1,0(a5)
 70c:	855a                	mv	a0,s6
 70e:	d2dff0ef          	jal	43a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 712:	0992                	slli	s3,s3,0x4
 714:	34fd                	addiw	s1,s1,-1
 716:	f4f5                	bnez	s1,702 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 718:	8bea                	mv	s7,s10
      state = 0;
 71a:	4981                	li	s3,0
 71c:	6d02                	ld	s10,0(sp)
 71e:	bd29                	j	538 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 720:	008b8993          	addi	s3,s7,8
 724:	000bb483          	ld	s1,0(s7)
 728:	cc91                	beqz	s1,744 <vprintf+0x256>
        for(; *s; s++)
 72a:	0004c583          	lbu	a1,0(s1)
 72e:	c195                	beqz	a1,752 <vprintf+0x264>
          putc(fd, *s);
 730:	855a                	mv	a0,s6
 732:	d09ff0ef          	jal	43a <putc>
        for(; *s; s++)
 736:	0485                	addi	s1,s1,1
 738:	0004c583          	lbu	a1,0(s1)
 73c:	f9f5                	bnez	a1,730 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 73e:	8bce                	mv	s7,s3
      state = 0;
 740:	4981                	li	s3,0
 742:	bbdd                	j	538 <vprintf+0x4a>
          s = "(null)";
 744:	00000497          	auipc	s1,0x0
 748:	21448493          	addi	s1,s1,532 # 958 <malloc+0x104>
        for(; *s; s++)
 74c:	02800593          	li	a1,40
 750:	b7c5                	j	730 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 752:	8bce                	mv	s7,s3
      state = 0;
 754:	4981                	li	s3,0
 756:	b3cd                	j	538 <vprintf+0x4a>
 758:	6906                	ld	s2,64(sp)
 75a:	79e2                	ld	s3,56(sp)
 75c:	7a42                	ld	s4,48(sp)
 75e:	7aa2                	ld	s5,40(sp)
 760:	7b02                	ld	s6,32(sp)
 762:	6be2                	ld	s7,24(sp)
 764:	6c42                	ld	s8,16(sp)
 766:	6ca2                	ld	s9,8(sp)
    }
  }
}
 768:	60e6                	ld	ra,88(sp)
 76a:	6446                	ld	s0,80(sp)
 76c:	64a6                	ld	s1,72(sp)
 76e:	6125                	addi	sp,sp,96
 770:	8082                	ret

0000000000000772 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 772:	715d                	addi	sp,sp,-80
 774:	ec06                	sd	ra,24(sp)
 776:	e822                	sd	s0,16(sp)
 778:	1000                	addi	s0,sp,32
 77a:	e010                	sd	a2,0(s0)
 77c:	e414                	sd	a3,8(s0)
 77e:	e818                	sd	a4,16(s0)
 780:	ec1c                	sd	a5,24(s0)
 782:	03043023          	sd	a6,32(s0)
 786:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 78a:	8622                	mv	a2,s0
 78c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 790:	d5fff0ef          	jal	4ee <vprintf>
}
 794:	60e2                	ld	ra,24(sp)
 796:	6442                	ld	s0,16(sp)
 798:	6161                	addi	sp,sp,80
 79a:	8082                	ret

000000000000079c <printf>:

void
printf(const char *fmt, ...)
{
 79c:	711d                	addi	sp,sp,-96
 79e:	ec06                	sd	ra,24(sp)
 7a0:	e822                	sd	s0,16(sp)
 7a2:	1000                	addi	s0,sp,32
 7a4:	e40c                	sd	a1,8(s0)
 7a6:	e810                	sd	a2,16(s0)
 7a8:	ec14                	sd	a3,24(s0)
 7aa:	f018                	sd	a4,32(s0)
 7ac:	f41c                	sd	a5,40(s0)
 7ae:	03043823          	sd	a6,48(s0)
 7b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7b6:	00840613          	addi	a2,s0,8
 7ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7be:	85aa                	mv	a1,a0
 7c0:	4505                	li	a0,1
 7c2:	d2dff0ef          	jal	4ee <vprintf>
}
 7c6:	60e2                	ld	ra,24(sp)
 7c8:	6442                	ld	s0,16(sp)
 7ca:	6125                	addi	sp,sp,96
 7cc:	8082                	ret

00000000000007ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ce:	1141                	addi	sp,sp,-16
 7d0:	e406                	sd	ra,8(sp)
 7d2:	e022                	sd	s0,0(sp)
 7d4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7d6:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7da:	00001797          	auipc	a5,0x1
 7de:	8267b783          	ld	a5,-2010(a5) # 1000 <freep>
 7e2:	a02d                	j	80c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e4:	4618                	lw	a4,8(a2)
 7e6:	9f2d                	addw	a4,a4,a1
 7e8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ec:	6398                	ld	a4,0(a5)
 7ee:	6310                	ld	a2,0(a4)
 7f0:	a83d                	j	82e <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f2:	ff852703          	lw	a4,-8(a0)
 7f6:	9f31                	addw	a4,a4,a2
 7f8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7fa:	ff053683          	ld	a3,-16(a0)
 7fe:	a091                	j	842 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 800:	6398                	ld	a4,0(a5)
 802:	00e7e463          	bltu	a5,a4,80a <free+0x3c>
 806:	00e6ea63          	bltu	a3,a4,81a <free+0x4c>
{
 80a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80c:	fed7fae3          	bgeu	a5,a3,800 <free+0x32>
 810:	6398                	ld	a4,0(a5)
 812:	00e6e463          	bltu	a3,a4,81a <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 816:	fee7eae3          	bltu	a5,a4,80a <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 81a:	ff852583          	lw	a1,-8(a0)
 81e:	6390                	ld	a2,0(a5)
 820:	02059813          	slli	a6,a1,0x20
 824:	01c85713          	srli	a4,a6,0x1c
 828:	9736                	add	a4,a4,a3
 82a:	fae60de3          	beq	a2,a4,7e4 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 82e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 832:	4790                	lw	a2,8(a5)
 834:	02061593          	slli	a1,a2,0x20
 838:	01c5d713          	srli	a4,a1,0x1c
 83c:	973e                	add	a4,a4,a5
 83e:	fae68ae3          	beq	a3,a4,7f2 <free+0x24>
    p->s.ptr = bp->s.ptr;
 842:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 844:	00000717          	auipc	a4,0x0
 848:	7af73e23          	sd	a5,1980(a4) # 1000 <freep>
}
 84c:	60a2                	ld	ra,8(sp)
 84e:	6402                	ld	s0,0(sp)
 850:	0141                	addi	sp,sp,16
 852:	8082                	ret

0000000000000854 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 854:	7139                	addi	sp,sp,-64
 856:	fc06                	sd	ra,56(sp)
 858:	f822                	sd	s0,48(sp)
 85a:	f04a                	sd	s2,32(sp)
 85c:	ec4e                	sd	s3,24(sp)
 85e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 860:	02051993          	slli	s3,a0,0x20
 864:	0209d993          	srli	s3,s3,0x20
 868:	09bd                	addi	s3,s3,15
 86a:	0049d993          	srli	s3,s3,0x4
 86e:	2985                	addiw	s3,s3,1
 870:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 872:	00000517          	auipc	a0,0x0
 876:	78e53503          	ld	a0,1934(a0) # 1000 <freep>
 87a:	c905                	beqz	a0,8aa <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87e:	4798                	lw	a4,8(a5)
 880:	09377663          	bgeu	a4,s3,90c <malloc+0xb8>
 884:	f426                	sd	s1,40(sp)
 886:	e852                	sd	s4,16(sp)
 888:	e456                	sd	s5,8(sp)
 88a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 88c:	8a4e                	mv	s4,s3
 88e:	6705                	lui	a4,0x1
 890:	00e9f363          	bgeu	s3,a4,896 <malloc+0x42>
 894:	6a05                	lui	s4,0x1
 896:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 89a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 89e:	00000497          	auipc	s1,0x0
 8a2:	76248493          	addi	s1,s1,1890 # 1000 <freep>
  if(p == (char*)-1)
 8a6:	5afd                	li	s5,-1
 8a8:	a83d                	j	8e6 <malloc+0x92>
 8aa:	f426                	sd	s1,40(sp)
 8ac:	e852                	sd	s4,16(sp)
 8ae:	e456                	sd	s5,8(sp)
 8b0:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8b2:	00000797          	auipc	a5,0x0
 8b6:	75e78793          	addi	a5,a5,1886 # 1010 <base>
 8ba:	00000717          	auipc	a4,0x0
 8be:	74f73323          	sd	a5,1862(a4) # 1000 <freep>
 8c2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8c4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8c8:	b7d1                	j	88c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8ca:	6398                	ld	a4,0(a5)
 8cc:	e118                	sd	a4,0(a0)
 8ce:	a899                	j	924 <malloc+0xd0>
  hp->s.size = nu;
 8d0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8d4:	0541                	addi	a0,a0,16
 8d6:	ef9ff0ef          	jal	7ce <free>
  return freep;
 8da:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8dc:	c125                	beqz	a0,93c <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e0:	4798                	lw	a4,8(a5)
 8e2:	03277163          	bgeu	a4,s2,904 <malloc+0xb0>
    if(p == freep)
 8e6:	6098                	ld	a4,0(s1)
 8e8:	853e                	mv	a0,a5
 8ea:	fef71ae3          	bne	a4,a5,8de <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8ee:	8552                	mv	a0,s4
 8f0:	b2bff0ef          	jal	41a <sbrk>
  if(p == (char*)-1)
 8f4:	fd551ee3          	bne	a0,s5,8d0 <malloc+0x7c>
        return 0;
 8f8:	4501                	li	a0,0
 8fa:	74a2                	ld	s1,40(sp)
 8fc:	6a42                	ld	s4,16(sp)
 8fe:	6aa2                	ld	s5,8(sp)
 900:	6b02                	ld	s6,0(sp)
 902:	a03d                	j	930 <malloc+0xdc>
 904:	74a2                	ld	s1,40(sp)
 906:	6a42                	ld	s4,16(sp)
 908:	6aa2                	ld	s5,8(sp)
 90a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 90c:	fae90fe3          	beq	s2,a4,8ca <malloc+0x76>
        p->s.size -= nunits;
 910:	4137073b          	subw	a4,a4,s3
 914:	c798                	sw	a4,8(a5)
        p += p->s.size;
 916:	02071693          	slli	a3,a4,0x20
 91a:	01c6d713          	srli	a4,a3,0x1c
 91e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 920:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 924:	00000717          	auipc	a4,0x0
 928:	6ca73e23          	sd	a0,1756(a4) # 1000 <freep>
      return (void*)(p + 1);
 92c:	01078513          	addi	a0,a5,16
  }
}
 930:	70e2                	ld	ra,56(sp)
 932:	7442                	ld	s0,48(sp)
 934:	7902                	ld	s2,32(sp)
 936:	69e2                	ld	s3,24(sp)
 938:	6121                	addi	sp,sp,64
 93a:	8082                	ret
 93c:	74a2                	ld	s1,40(sp)
 93e:	6a42                	ld	s4,16(sp)
 940:	6aa2                	ld	s5,8(sp)
 942:	6b02                	ld	s6,0(sp)
 944:	b7f5                	j	930 <malloc+0xdc>
