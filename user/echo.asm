
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	06a7d063          	bge	a5,a0,76 <main+0x76>
  1a:	00858493          	addi	s1,a1,8
  1e:	3579                	addiw	a0,a0,-2
  20:	02051793          	slli	a5,a0,0x20
  24:	01d7d513          	srli	a0,a5,0x1d
  28:	00a48ab3          	add	s5,s1,a0
  2c:	05c1                	addi	a1,a1,16
  2e:	00a58a33          	add	s4,a1,a0
    write(1, argv[i], strlen(argv[i]));
  32:	4985                	li	s3,1
    if(i + 1 < argc){
      write(1, " ", 1);
  34:	00001b17          	auipc	s6,0x1
  38:	97cb0b13          	addi	s6,s6,-1668 # 9b0 <malloc+0x100>
  3c:	a809                	j	4e <main+0x4e>
  3e:	864e                	mv	a2,s3
  40:	85da                	mv	a1,s6
  42:	854e                	mv	a0,s3
  44:	3ca000ef          	jal	40e <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03448663          	beq	s1,s4,76 <main+0x76>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	08a000ef          	jal	de <strlen>
  58:	862a                	mv	a2,a0
  5a:	85ca                	mv	a1,s2
  5c:	854e                	mv	a0,s3
  5e:	3b0000ef          	jal	40e <write>
    if(i + 1 < argc){
  62:	fd549ee3          	bne	s1,s5,3e <main+0x3e>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	95058593          	addi	a1,a1,-1712 # 9b8 <malloc+0x108>
  70:	8532                	mv	a0,a2
  72:	39c000ef          	jal	40e <write>
    }
  }
  exit(0);
  76:	4501                	li	a0,0
  78:	376000ef          	jal	3ee <exit>

000000000000007c <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e406                	sd	ra,8(sp)
  80:	e022                	sd	s0,0(sp)
  82:	0800                	addi	s0,sp,16
  extern int main();
  main();
  84:	f7dff0ef          	jal	0 <main>
  exit(0);
  88:	4501                	li	a0,0
  8a:	364000ef          	jal	3ee <exit>

000000000000008e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  96:	87aa                	mv	a5,a0
  98:	0585                	addi	a1,a1,1
  9a:	0785                	addi	a5,a5,1
  9c:	fff5c703          	lbu	a4,-1(a1)
  a0:	fee78fa3          	sb	a4,-1(a5)
  a4:	fb75                	bnez	a4,98 <strcpy+0xa>
    ;
  return os;
}
  a6:	60a2                	ld	ra,8(sp)
  a8:	6402                	ld	s0,0(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int strcmp(const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cb91                	beqz	a5,ce <strcmp+0x20>
  bc:	0005c703          	lbu	a4,0(a1)
  c0:	00f71763          	bne	a4,a5,ce <strcmp+0x20>
    p++, q++;
  c4:	0505                	addi	a0,a0,1
  c6:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	fbe5                	bnez	a5,bc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ce:	0005c503          	lbu	a0,0(a1)
}
  d2:	40a7853b          	subw	a0,a5,a0
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <strlen>:

uint strlen(const char *s)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	cf99                	beqz	a5,108 <strlen+0x2a>
  ec:	0505                	addi	a0,a0,1
  ee:	87aa                	mv	a5,a0
  f0:	86be                	mv	a3,a5
  f2:	0785                	addi	a5,a5,1
  f4:	fff7c703          	lbu	a4,-1(a5)
  f8:	ff65                	bnez	a4,f0 <strlen+0x12>
  fa:	40a6853b          	subw	a0,a3,a0
  fe:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 100:	60a2                	ld	ra,8(sp)
 102:	6402                	ld	s0,0(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  for (n = 0; s[n]; n++)
 108:	4501                	li	a0,0
 10a:	bfdd                	j	100 <strlen+0x22>

000000000000010c <memset>:

void *
memset(void *dst, int c, uint n)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 114:	ca19                	beqz	a2,12a <memset+0x1e>
 116:	87aa                	mv	a5,a0
 118:	1602                	slli	a2,a2,0x20
 11a:	9201                	srli	a2,a2,0x20
 11c:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 120:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 124:	0785                	addi	a5,a5,1
 126:	fee79de3          	bne	a5,a4,120 <memset+0x14>
  }
  return dst;
}
 12a:	60a2                	ld	ra,8(sp)
 12c:	6402                	ld	s0,0(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strchr>:

char *
strchr(const char *s, char c)
{
 132:	1141                	addi	sp,sp,-16
 134:	e406                	sd	ra,8(sp)
 136:	e022                	sd	s0,0(sp)
 138:	0800                	addi	s0,sp,16
  for (; *s; s++)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cf81                	beqz	a5,156 <strchr+0x24>
    if (*s == c)
 140:	00f58763          	beq	a1,a5,14e <strchr+0x1c>
  for (; *s; s++)
 144:	0505                	addi	a0,a0,1
 146:	00054783          	lbu	a5,0(a0)
 14a:	fbfd                	bnez	a5,140 <strchr+0xe>
      return (char *)s;
  return 0;
 14c:	4501                	li	a0,0
}
 14e:	60a2                	ld	ra,8(sp)
 150:	6402                	ld	s0,0(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
  return 0;
 156:	4501                	li	a0,0
 158:	bfdd                	j	14e <strchr+0x1c>

000000000000015a <gets>:

char *
gets(char *buf, int max)
{
 15a:	7159                	addi	sp,sp,-112
 15c:	f486                	sd	ra,104(sp)
 15e:	f0a2                	sd	s0,96(sp)
 160:	eca6                	sd	s1,88(sp)
 162:	e8ca                	sd	s2,80(sp)
 164:	e4ce                	sd	s3,72(sp)
 166:	e0d2                	sd	s4,64(sp)
 168:	fc56                	sd	s5,56(sp)
 16a:	f85a                	sd	s6,48(sp)
 16c:	f45e                	sd	s7,40(sp)
 16e:	f062                	sd	s8,32(sp)
 170:	ec66                	sd	s9,24(sp)
 172:	e86a                	sd	s10,16(sp)
 174:	1880                	addi	s0,sp,112
 176:	8caa                	mv	s9,a0
 178:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 17a:	892a                	mv	s2,a0
 17c:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 17e:	f9f40b13          	addi	s6,s0,-97
 182:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 184:	4ba9                	li	s7,10
 186:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 188:	8d26                	mv	s10,s1
 18a:	0014899b          	addiw	s3,s1,1
 18e:	84ce                	mv	s1,s3
 190:	0349d563          	bge	s3,s4,1ba <gets+0x60>
    cc = read(0, &c, 1);
 194:	8656                	mv	a2,s5
 196:	85da                	mv	a1,s6
 198:	4501                	li	a0,0
 19a:	26c000ef          	jal	406 <read>
    if (cc < 1)
 19e:	00a05e63          	blez	a0,1ba <gets+0x60>
    buf[i++] = c;
 1a2:	f9f44783          	lbu	a5,-97(s0)
 1a6:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1aa:	01778763          	beq	a5,s7,1b8 <gets+0x5e>
 1ae:	0905                	addi	s2,s2,1
 1b0:	fd879ce3          	bne	a5,s8,188 <gets+0x2e>
    buf[i++] = c;
 1b4:	8d4e                	mv	s10,s3
 1b6:	a011                	j	1ba <gets+0x60>
 1b8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1ba:	9d66                	add	s10,s10,s9
 1bc:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1c0:	8566                	mv	a0,s9
 1c2:	70a6                	ld	ra,104(sp)
 1c4:	7406                	ld	s0,96(sp)
 1c6:	64e6                	ld	s1,88(sp)
 1c8:	6946                	ld	s2,80(sp)
 1ca:	69a6                	ld	s3,72(sp)
 1cc:	6a06                	ld	s4,64(sp)
 1ce:	7ae2                	ld	s5,56(sp)
 1d0:	7b42                	ld	s6,48(sp)
 1d2:	7ba2                	ld	s7,40(sp)
 1d4:	7c02                	ld	s8,32(sp)
 1d6:	6ce2                	ld	s9,24(sp)
 1d8:	6d42                	ld	s10,16(sp)
 1da:	6165                	addi	sp,sp,112
 1dc:	8082                	ret

00000000000001de <stat>:

int stat(const char *n, struct stat *st)
{
 1de:	1101                	addi	sp,sp,-32
 1e0:	ec06                	sd	ra,24(sp)
 1e2:	e822                	sd	s0,16(sp)
 1e4:	e04a                	sd	s2,0(sp)
 1e6:	1000                	addi	s0,sp,32
 1e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ea:	4581                	li	a1,0
 1ec:	242000ef          	jal	42e <open>
  if (fd < 0)
 1f0:	02054263          	bltz	a0,214 <stat+0x36>
 1f4:	e426                	sd	s1,8(sp)
 1f6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1f8:	85ca                	mv	a1,s2
 1fa:	24c000ef          	jal	446 <fstat>
 1fe:	892a                	mv	s2,a0
  close(fd);
 200:	8526                	mv	a0,s1
 202:	214000ef          	jal	416 <close>
  return r;
 206:	64a2                	ld	s1,8(sp)
}
 208:	854a                	mv	a0,s2
 20a:	60e2                	ld	ra,24(sp)
 20c:	6442                	ld	s0,16(sp)
 20e:	6902                	ld	s2,0(sp)
 210:	6105                	addi	sp,sp,32
 212:	8082                	ret
    return -1;
 214:	597d                	li	s2,-1
 216:	bfcd                	j	208 <stat+0x2a>

0000000000000218 <atoi>:

int atoi(const char *s)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e406                	sd	ra,8(sp)
 21c:	e022                	sd	s0,0(sp)
 21e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 220:	00054683          	lbu	a3,0(a0)
 224:	fd06879b          	addiw	a5,a3,-48
 228:	0ff7f793          	zext.b	a5,a5
 22c:	4625                	li	a2,9
 22e:	02f66963          	bltu	a2,a5,260 <atoi+0x48>
 232:	872a                	mv	a4,a0
  n = 0;
 234:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 236:	0705                	addi	a4,a4,1
 238:	0025179b          	slliw	a5,a0,0x2
 23c:	9fa9                	addw	a5,a5,a0
 23e:	0017979b          	slliw	a5,a5,0x1
 242:	9fb5                	addw	a5,a5,a3
 244:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 248:	00074683          	lbu	a3,0(a4)
 24c:	fd06879b          	addiw	a5,a3,-48
 250:	0ff7f793          	zext.b	a5,a5
 254:	fef671e3          	bgeu	a2,a5,236 <atoi+0x1e>
  return n;
}
 258:	60a2                	ld	ra,8(sp)
 25a:	6402                	ld	s0,0(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
  n = 0;
 260:	4501                	li	a0,0
 262:	bfdd                	j	258 <atoi+0x40>

0000000000000264 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 264:	1141                	addi	sp,sp,-16
 266:	e406                	sd	ra,8(sp)
 268:	e022                	sd	s0,0(sp)
 26a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 26c:	02b57563          	bgeu	a0,a1,296 <memmove+0x32>
  {
    while (n-- > 0)
 270:	00c05f63          	blez	a2,28e <memmove+0x2a>
 274:	1602                	slli	a2,a2,0x20
 276:	9201                	srli	a2,a2,0x20
 278:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 27c:	872a                	mv	a4,a0
      *dst++ = *src++;
 27e:	0585                	addi	a1,a1,1
 280:	0705                	addi	a4,a4,1
 282:	fff5c683          	lbu	a3,-1(a1)
 286:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 28a:	fee79ae3          	bne	a5,a4,27e <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28e:	60a2                	ld	ra,8(sp)
 290:	6402                	ld	s0,0(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
    dst += n;
 296:	00c50733          	add	a4,a0,a2
    src += n;
 29a:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 29c:	fec059e3          	blez	a2,28e <memmove+0x2a>
 2a0:	fff6079b          	addiw	a5,a2,-1
 2a4:	1782                	slli	a5,a5,0x20
 2a6:	9381                	srli	a5,a5,0x20
 2a8:	fff7c793          	not	a5,a5
 2ac:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ae:	15fd                	addi	a1,a1,-1
 2b0:	177d                	addi	a4,a4,-1
 2b2:	0005c683          	lbu	a3,0(a1)
 2b6:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2ba:	fef71ae3          	bne	a4,a5,2ae <memmove+0x4a>
 2be:	bfc1                	j	28e <memmove+0x2a>

00000000000002c0 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e406                	sd	ra,8(sp)
 2c4:	e022                	sd	s0,0(sp)
 2c6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2c8:	ca0d                	beqz	a2,2fa <memcmp+0x3a>
 2ca:	fff6069b          	addiw	a3,a2,-1
 2ce:	1682                	slli	a3,a3,0x20
 2d0:	9281                	srli	a3,a3,0x20
 2d2:	0685                	addi	a3,a3,1
 2d4:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 2d6:	00054783          	lbu	a5,0(a0)
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	00e79863          	bne	a5,a4,2ee <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 2e2:	0505                	addi	a0,a0,1
    p2++;
 2e4:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2e6:	fed518e3          	bne	a0,a3,2d6 <memcmp+0x16>
  }
  return 0;
 2ea:	4501                	li	a0,0
 2ec:	a019                	j	2f2 <memcmp+0x32>
      return *p1 - *p2;
 2ee:	40e7853b          	subw	a0,a5,a4
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret
  return 0;
 2fa:	4501                	li	a0,0
 2fc:	bfdd                	j	2f2 <memcmp+0x32>

00000000000002fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e406                	sd	ra,8(sp)
 302:	e022                	sd	s0,0(sp)
 304:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 306:	f5fff0ef          	jal	264 <memmove>
}
 30a:	60a2                	ld	ra,8(sp)
 30c:	6402                	ld	s0,0(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <strcat>:

char *strcat(char *dst, const char *src)
{
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 31a:	00054783          	lbu	a5,0(a0)
 31e:	c795                	beqz	a5,34a <strcat+0x38>
  char *p = dst;
 320:	87aa                	mv	a5,a0
    p++;
 322:	0785                	addi	a5,a5,1
  while (*p)
 324:	0007c703          	lbu	a4,0(a5)
 328:	ff6d                	bnez	a4,322 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 32a:	0005c703          	lbu	a4,0(a1)
 32e:	cb01                	beqz	a4,33e <strcat+0x2c>
  {
    *p = *src;
 330:	00e78023          	sb	a4,0(a5)
    p++;
 334:	0785                	addi	a5,a5,1
    src++;
 336:	0585                	addi	a1,a1,1
  while (*src)
 338:	0005c703          	lbu	a4,0(a1)
 33c:	fb75                	bnez	a4,330 <strcat+0x1e>
  }

  *p = 0;
 33e:	00078023          	sb	zero,0(a5)

  return dst;
}
 342:	60a2                	ld	ra,8(sp)
 344:	6402                	ld	s0,0(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret
  char *p = dst;
 34a:	87aa                	mv	a5,a0
 34c:	bff9                	j	32a <strcat+0x18>

000000000000034e <isdir>:

int isdir(char *path)
{
 34e:	7179                	addi	sp,sp,-48
 350:	f406                	sd	ra,40(sp)
 352:	f022                	sd	s0,32(sp)
 354:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 356:	fd840593          	addi	a1,s0,-40
 35a:	e85ff0ef          	jal	1de <stat>
 35e:	00054b63          	bltz	a0,374 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 362:	fe041503          	lh	a0,-32(s0)
 366:	157d                	addi	a0,a0,-1
 368:	00153513          	seqz	a0,a0
}
 36c:	70a2                	ld	ra,40(sp)
 36e:	7402                	ld	s0,32(sp)
 370:	6145                	addi	sp,sp,48
 372:	8082                	ret
    return 0;
 374:	4501                	li	a0,0
 376:	bfdd                	j	36c <isdir+0x1e>

0000000000000378 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 378:	7139                	addi	sp,sp,-64
 37a:	fc06                	sd	ra,56(sp)
 37c:	f822                	sd	s0,48(sp)
 37e:	f426                	sd	s1,40(sp)
 380:	f04a                	sd	s2,32(sp)
 382:	ec4e                	sd	s3,24(sp)
 384:	e852                	sd	s4,16(sp)
 386:	e456                	sd	s5,8(sp)
 388:	0080                	addi	s0,sp,64
 38a:	89aa                	mv	s3,a0
 38c:	8aae                	mv	s5,a1
 38e:	84b2                	mv	s1,a2
 390:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 392:	d4dff0ef          	jal	de <strlen>
 396:	892a                	mv	s2,a0
  int nn = strlen(filename);
 398:	8556                	mv	a0,s5
 39a:	d45ff0ef          	jal	de <strlen>
  int need = dn + 1 + nn + 1;
 39e:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 3a2:	9fa9                	addw	a5,a5,a0
    return 0;
 3a4:	4501                	li	a0,0
  if (need > bufsize)
 3a6:	0347d763          	bge	a5,s4,3d4 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 3aa:	85ce                	mv	a1,s3
 3ac:	8526                	mv	a0,s1
 3ae:	ce1ff0ef          	jal	8e <strcpy>
  if (dir[dn - 1] != '/')
 3b2:	99ca                	add	s3,s3,s2
 3b4:	fff9c703          	lbu	a4,-1(s3)
 3b8:	02f00793          	li	a5,47
 3bc:	00f70763          	beq	a4,a5,3ca <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 3c0:	9926                	add	s2,s2,s1
 3c2:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 3c6:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 3ca:	85d6                	mv	a1,s5
 3cc:	8526                	mv	a0,s1
 3ce:	f45ff0ef          	jal	312 <strcat>
  return out_buffer;
 3d2:	8526                	mv	a0,s1
}
 3d4:	70e2                	ld	ra,56(sp)
 3d6:	7442                	ld	s0,48(sp)
 3d8:	74a2                	ld	s1,40(sp)
 3da:	7902                	ld	s2,32(sp)
 3dc:	69e2                	ld	s3,24(sp)
 3de:	6a42                	ld	s4,16(sp)
 3e0:	6aa2                	ld	s5,8(sp)
 3e2:	6121                	addi	sp,sp,64
 3e4:	8082                	ret

00000000000003e6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e6:	4885                	li	a7,1
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ee:	4889                	li	a7,2
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f6:	488d                	li	a7,3
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3fe:	4891                	li	a7,4
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <read>:
.global read
read:
 li a7, SYS_read
 406:	4895                	li	a7,5
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <write>:
.global write
write:
 li a7, SYS_write
 40e:	48c1                	li	a7,16
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <close>:
.global close
close:
 li a7, SYS_close
 416:	48d5                	li	a7,21
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <kill>:
.global kill
kill:
 li a7, SYS_kill
 41e:	4899                	li	a7,6
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <exec>:
.global exec
exec:
 li a7, SYS_exec
 426:	489d                	li	a7,7
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <open>:
.global open
open:
 li a7, SYS_open
 42e:	48bd                	li	a7,15
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 436:	48c5                	li	a7,17
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 43e:	48c9                	li	a7,18
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 446:	48a1                	li	a7,8
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <link>:
.global link
link:
 li a7, SYS_link
 44e:	48cd                	li	a7,19
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 456:	48d1                	li	a7,20
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 45e:	48a5                	li	a7,9
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <dup>:
.global dup
dup:
 li a7, SYS_dup
 466:	48a9                	li	a7,10
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 46e:	48ad                	li	a7,11
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 476:	48b1                	li	a7,12
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 47e:	48b5                	li	a7,13
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 486:	48b9                	li	a7,14
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 48e:	48d9                	li	a7,22
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 496:	1101                	addi	sp,sp,-32
 498:	ec06                	sd	ra,24(sp)
 49a:	e822                	sd	s0,16(sp)
 49c:	1000                	addi	s0,sp,32
 49e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a2:	4605                	li	a2,1
 4a4:	fef40593          	addi	a1,s0,-17
 4a8:	f67ff0ef          	jal	40e <write>
}
 4ac:	60e2                	ld	ra,24(sp)
 4ae:	6442                	ld	s0,16(sp)
 4b0:	6105                	addi	sp,sp,32
 4b2:	8082                	ret

00000000000004b4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b4:	7139                	addi	sp,sp,-64
 4b6:	fc06                	sd	ra,56(sp)
 4b8:	f822                	sd	s0,48(sp)
 4ba:	f426                	sd	s1,40(sp)
 4bc:	f04a                	sd	s2,32(sp)
 4be:	ec4e                	sd	s3,24(sp)
 4c0:	0080                	addi	s0,sp,64
 4c2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c4:	c299                	beqz	a3,4ca <printint+0x16>
 4c6:	0605ce63          	bltz	a1,542 <printint+0x8e>
  neg = 0;
 4ca:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4cc:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4d0:	869a                	mv	a3,t1
  i = 0;
 4d2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4d4:	00000817          	auipc	a6,0x0
 4d8:	4f480813          	addi	a6,a6,1268 # 9c8 <digits>
 4dc:	88be                	mv	a7,a5
 4de:	0017851b          	addiw	a0,a5,1
 4e2:	87aa                	mv	a5,a0
 4e4:	02c5f73b          	remuw	a4,a1,a2
 4e8:	1702                	slli	a4,a4,0x20
 4ea:	9301                	srli	a4,a4,0x20
 4ec:	9742                	add	a4,a4,a6
 4ee:	00074703          	lbu	a4,0(a4)
 4f2:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4f6:	872e                	mv	a4,a1
 4f8:	02c5d5bb          	divuw	a1,a1,a2
 4fc:	0685                	addi	a3,a3,1
 4fe:	fcc77fe3          	bgeu	a4,a2,4dc <printint+0x28>
  if(neg)
 502:	000e0c63          	beqz	t3,51a <printint+0x66>
    buf[i++] = '-';
 506:	fd050793          	addi	a5,a0,-48
 50a:	00878533          	add	a0,a5,s0
 50e:	02d00793          	li	a5,45
 512:	fef50823          	sb	a5,-16(a0)
 516:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 51a:	fff7899b          	addiw	s3,a5,-1
 51e:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 522:	fff4c583          	lbu	a1,-1(s1)
 526:	854a                	mv	a0,s2
 528:	f6fff0ef          	jal	496 <putc>
  while(--i >= 0)
 52c:	39fd                	addiw	s3,s3,-1
 52e:	14fd                	addi	s1,s1,-1
 530:	fe09d9e3          	bgez	s3,522 <printint+0x6e>
}
 534:	70e2                	ld	ra,56(sp)
 536:	7442                	ld	s0,48(sp)
 538:	74a2                	ld	s1,40(sp)
 53a:	7902                	ld	s2,32(sp)
 53c:	69e2                	ld	s3,24(sp)
 53e:	6121                	addi	sp,sp,64
 540:	8082                	ret
    x = -xx;
 542:	40b005bb          	negw	a1,a1
    neg = 1;
 546:	4e05                	li	t3,1
    x = -xx;
 548:	b751                	j	4cc <printint+0x18>

000000000000054a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 54a:	711d                	addi	sp,sp,-96
 54c:	ec86                	sd	ra,88(sp)
 54e:	e8a2                	sd	s0,80(sp)
 550:	e4a6                	sd	s1,72(sp)
 552:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 554:	0005c483          	lbu	s1,0(a1)
 558:	26048663          	beqz	s1,7c4 <vprintf+0x27a>
 55c:	e0ca                	sd	s2,64(sp)
 55e:	fc4e                	sd	s3,56(sp)
 560:	f852                	sd	s4,48(sp)
 562:	f456                	sd	s5,40(sp)
 564:	f05a                	sd	s6,32(sp)
 566:	ec5e                	sd	s7,24(sp)
 568:	e862                	sd	s8,16(sp)
 56a:	e466                	sd	s9,8(sp)
 56c:	8b2a                	mv	s6,a0
 56e:	8a2e                	mv	s4,a1
 570:	8bb2                	mv	s7,a2
  state = 0;
 572:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 574:	4901                	li	s2,0
 576:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 578:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 57c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 580:	06c00c93          	li	s9,108
 584:	a00d                	j	5a6 <vprintf+0x5c>
        putc(fd, c0);
 586:	85a6                	mv	a1,s1
 588:	855a                	mv	a0,s6
 58a:	f0dff0ef          	jal	496 <putc>
 58e:	a019                	j	594 <vprintf+0x4a>
    } else if(state == '%'){
 590:	03598363          	beq	s3,s5,5b6 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 594:	0019079b          	addiw	a5,s2,1
 598:	893e                	mv	s2,a5
 59a:	873e                	mv	a4,a5
 59c:	97d2                	add	a5,a5,s4
 59e:	0007c483          	lbu	s1,0(a5)
 5a2:	20048963          	beqz	s1,7b4 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 5a6:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5aa:	fe0993e3          	bnez	s3,590 <vprintf+0x46>
      if(c0 == '%'){
 5ae:	fd579ce3          	bne	a5,s5,586 <vprintf+0x3c>
        state = '%';
 5b2:	89be                	mv	s3,a5
 5b4:	b7c5                	j	594 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5b6:	00ea06b3          	add	a3,s4,a4
 5ba:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5be:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5c0:	c681                	beqz	a3,5c8 <vprintf+0x7e>
 5c2:	9752                	add	a4,a4,s4
 5c4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5c8:	03878e63          	beq	a5,s8,604 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 5cc:	05978863          	beq	a5,s9,61c <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5d0:	07500713          	li	a4,117
 5d4:	0ee78263          	beq	a5,a4,6b8 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5d8:	07800713          	li	a4,120
 5dc:	12e78463          	beq	a5,a4,704 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5e0:	07000713          	li	a4,112
 5e4:	14e78963          	beq	a5,a4,736 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5e8:	07300713          	li	a4,115
 5ec:	18e78863          	beq	a5,a4,77c <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5f0:	02500713          	li	a4,37
 5f4:	04e79463          	bne	a5,a4,63c <vprintf+0xf2>
        putc(fd, '%');
 5f8:	85ba                	mv	a1,a4
 5fa:	855a                	mv	a0,s6
 5fc:	e9bff0ef          	jal	496 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 600:	4981                	li	s3,0
 602:	bf49                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 604:	008b8493          	addi	s1,s7,8
 608:	4685                	li	a3,1
 60a:	4629                	li	a2,10
 60c:	000ba583          	lw	a1,0(s7)
 610:	855a                	mv	a0,s6
 612:	ea3ff0ef          	jal	4b4 <printint>
 616:	8ba6                	mv	s7,s1
      state = 0;
 618:	4981                	li	s3,0
 61a:	bfad                	j	594 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 61c:	06400793          	li	a5,100
 620:	02f68963          	beq	a3,a5,652 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 624:	06c00793          	li	a5,108
 628:	04f68263          	beq	a3,a5,66c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 62c:	07500793          	li	a5,117
 630:	0af68063          	beq	a3,a5,6d0 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 634:	07800793          	li	a5,120
 638:	0ef68263          	beq	a3,a5,71c <vprintf+0x1d2>
        putc(fd, '%');
 63c:	02500593          	li	a1,37
 640:	855a                	mv	a0,s6
 642:	e55ff0ef          	jal	496 <putc>
        putc(fd, c0);
 646:	85a6                	mv	a1,s1
 648:	855a                	mv	a0,s6
 64a:	e4dff0ef          	jal	496 <putc>
      state = 0;
 64e:	4981                	li	s3,0
 650:	b791                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 652:	008b8493          	addi	s1,s7,8
 656:	4685                	li	a3,1
 658:	4629                	li	a2,10
 65a:	000ba583          	lw	a1,0(s7)
 65e:	855a                	mv	a0,s6
 660:	e55ff0ef          	jal	4b4 <printint>
        i += 1;
 664:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 666:	8ba6                	mv	s7,s1
      state = 0;
 668:	4981                	li	s3,0
        i += 1;
 66a:	b72d                	j	594 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 66c:	06400793          	li	a5,100
 670:	02f60763          	beq	a2,a5,69e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 674:	07500793          	li	a5,117
 678:	06f60963          	beq	a2,a5,6ea <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 67c:	07800793          	li	a5,120
 680:	faf61ee3          	bne	a2,a5,63c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 684:	008b8493          	addi	s1,s7,8
 688:	4681                	li	a3,0
 68a:	4641                	li	a2,16
 68c:	000ba583          	lw	a1,0(s7)
 690:	855a                	mv	a0,s6
 692:	e23ff0ef          	jal	4b4 <printint>
        i += 2;
 696:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 698:	8ba6                	mv	s7,s1
      state = 0;
 69a:	4981                	li	s3,0
        i += 2;
 69c:	bde5                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 69e:	008b8493          	addi	s1,s7,8
 6a2:	4685                	li	a3,1
 6a4:	4629                	li	a2,10
 6a6:	000ba583          	lw	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	e09ff0ef          	jal	4b4 <printint>
        i += 2;
 6b0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b2:	8ba6                	mv	s7,s1
      state = 0;
 6b4:	4981                	li	s3,0
        i += 2;
 6b6:	bdf9                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 6b8:	008b8493          	addi	s1,s7,8
 6bc:	4681                	li	a3,0
 6be:	4629                	li	a2,10
 6c0:	000ba583          	lw	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	defff0ef          	jal	4b4 <printint>
 6ca:	8ba6                	mv	s7,s1
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b5d9                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d0:	008b8493          	addi	s1,s7,8
 6d4:	4681                	li	a3,0
 6d6:	4629                	li	a2,10
 6d8:	000ba583          	lw	a1,0(s7)
 6dc:	855a                	mv	a0,s6
 6de:	dd7ff0ef          	jal	4b4 <printint>
        i += 1;
 6e2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e4:	8ba6                	mv	s7,s1
      state = 0;
 6e6:	4981                	li	s3,0
        i += 1;
 6e8:	b575                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ea:	008b8493          	addi	s1,s7,8
 6ee:	4681                	li	a3,0
 6f0:	4629                	li	a2,10
 6f2:	000ba583          	lw	a1,0(s7)
 6f6:	855a                	mv	a0,s6
 6f8:	dbdff0ef          	jal	4b4 <printint>
        i += 2;
 6fc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6fe:	8ba6                	mv	s7,s1
      state = 0;
 700:	4981                	li	s3,0
        i += 2;
 702:	bd49                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 704:	008b8493          	addi	s1,s7,8
 708:	4681                	li	a3,0
 70a:	4641                	li	a2,16
 70c:	000ba583          	lw	a1,0(s7)
 710:	855a                	mv	a0,s6
 712:	da3ff0ef          	jal	4b4 <printint>
 716:	8ba6                	mv	s7,s1
      state = 0;
 718:	4981                	li	s3,0
 71a:	bdad                	j	594 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 71c:	008b8493          	addi	s1,s7,8
 720:	4681                	li	a3,0
 722:	4641                	li	a2,16
 724:	000ba583          	lw	a1,0(s7)
 728:	855a                	mv	a0,s6
 72a:	d8bff0ef          	jal	4b4 <printint>
        i += 1;
 72e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 730:	8ba6                	mv	s7,s1
      state = 0;
 732:	4981                	li	s3,0
        i += 1;
 734:	b585                	j	594 <vprintf+0x4a>
 736:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 738:	008b8d13          	addi	s10,s7,8
 73c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 740:	03000593          	li	a1,48
 744:	855a                	mv	a0,s6
 746:	d51ff0ef          	jal	496 <putc>
  putc(fd, 'x');
 74a:	07800593          	li	a1,120
 74e:	855a                	mv	a0,s6
 750:	d47ff0ef          	jal	496 <putc>
 754:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 756:	00000b97          	auipc	s7,0x0
 75a:	272b8b93          	addi	s7,s7,626 # 9c8 <digits>
 75e:	03c9d793          	srli	a5,s3,0x3c
 762:	97de                	add	a5,a5,s7
 764:	0007c583          	lbu	a1,0(a5)
 768:	855a                	mv	a0,s6
 76a:	d2dff0ef          	jal	496 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76e:	0992                	slli	s3,s3,0x4
 770:	34fd                	addiw	s1,s1,-1
 772:	f4f5                	bnez	s1,75e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 774:	8bea                	mv	s7,s10
      state = 0;
 776:	4981                	li	s3,0
 778:	6d02                	ld	s10,0(sp)
 77a:	bd29                	j	594 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 77c:	008b8993          	addi	s3,s7,8
 780:	000bb483          	ld	s1,0(s7)
 784:	cc91                	beqz	s1,7a0 <vprintf+0x256>
        for(; *s; s++)
 786:	0004c583          	lbu	a1,0(s1)
 78a:	c195                	beqz	a1,7ae <vprintf+0x264>
          putc(fd, *s);
 78c:	855a                	mv	a0,s6
 78e:	d09ff0ef          	jal	496 <putc>
        for(; *s; s++)
 792:	0485                	addi	s1,s1,1
 794:	0004c583          	lbu	a1,0(s1)
 798:	f9f5                	bnez	a1,78c <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 79a:	8bce                	mv	s7,s3
      state = 0;
 79c:	4981                	li	s3,0
 79e:	bbdd                	j	594 <vprintf+0x4a>
          s = "(null)";
 7a0:	00000497          	auipc	s1,0x0
 7a4:	22048493          	addi	s1,s1,544 # 9c0 <malloc+0x110>
        for(; *s; s++)
 7a8:	02800593          	li	a1,40
 7ac:	b7c5                	j	78c <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 7ae:	8bce                	mv	s7,s3
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	b3cd                	j	594 <vprintf+0x4a>
 7b4:	6906                	ld	s2,64(sp)
 7b6:	79e2                	ld	s3,56(sp)
 7b8:	7a42                	ld	s4,48(sp)
 7ba:	7aa2                	ld	s5,40(sp)
 7bc:	7b02                	ld	s6,32(sp)
 7be:	6be2                	ld	s7,24(sp)
 7c0:	6c42                	ld	s8,16(sp)
 7c2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7c4:	60e6                	ld	ra,88(sp)
 7c6:	6446                	ld	s0,80(sp)
 7c8:	64a6                	ld	s1,72(sp)
 7ca:	6125                	addi	sp,sp,96
 7cc:	8082                	ret

00000000000007ce <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ce:	715d                	addi	sp,sp,-80
 7d0:	ec06                	sd	ra,24(sp)
 7d2:	e822                	sd	s0,16(sp)
 7d4:	1000                	addi	s0,sp,32
 7d6:	e010                	sd	a2,0(s0)
 7d8:	e414                	sd	a3,8(s0)
 7da:	e818                	sd	a4,16(s0)
 7dc:	ec1c                	sd	a5,24(s0)
 7de:	03043023          	sd	a6,32(s0)
 7e2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e6:	8622                	mv	a2,s0
 7e8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ec:	d5fff0ef          	jal	54a <vprintf>
}
 7f0:	60e2                	ld	ra,24(sp)
 7f2:	6442                	ld	s0,16(sp)
 7f4:	6161                	addi	sp,sp,80
 7f6:	8082                	ret

00000000000007f8 <printf>:

void
printf(const char *fmt, ...)
{
 7f8:	711d                	addi	sp,sp,-96
 7fa:	ec06                	sd	ra,24(sp)
 7fc:	e822                	sd	s0,16(sp)
 7fe:	1000                	addi	s0,sp,32
 800:	e40c                	sd	a1,8(s0)
 802:	e810                	sd	a2,16(s0)
 804:	ec14                	sd	a3,24(s0)
 806:	f018                	sd	a4,32(s0)
 808:	f41c                	sd	a5,40(s0)
 80a:	03043823          	sd	a6,48(s0)
 80e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 812:	00840613          	addi	a2,s0,8
 816:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 81a:	85aa                	mv	a1,a0
 81c:	4505                	li	a0,1
 81e:	d2dff0ef          	jal	54a <vprintf>
}
 822:	60e2                	ld	ra,24(sp)
 824:	6442                	ld	s0,16(sp)
 826:	6125                	addi	sp,sp,96
 828:	8082                	ret

000000000000082a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82a:	1141                	addi	sp,sp,-16
 82c:	e406                	sd	ra,8(sp)
 82e:	e022                	sd	s0,0(sp)
 830:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 832:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 836:	00000797          	auipc	a5,0x0
 83a:	7ca7b783          	ld	a5,1994(a5) # 1000 <freep>
 83e:	a02d                	j	868 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 840:	4618                	lw	a4,8(a2)
 842:	9f2d                	addw	a4,a4,a1
 844:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 848:	6398                	ld	a4,0(a5)
 84a:	6310                	ld	a2,0(a4)
 84c:	a83d                	j	88a <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84e:	ff852703          	lw	a4,-8(a0)
 852:	9f31                	addw	a4,a4,a2
 854:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 856:	ff053683          	ld	a3,-16(a0)
 85a:	a091                	j	89e <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85c:	6398                	ld	a4,0(a5)
 85e:	00e7e463          	bltu	a5,a4,866 <free+0x3c>
 862:	00e6ea63          	bltu	a3,a4,876 <free+0x4c>
{
 866:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 868:	fed7fae3          	bgeu	a5,a3,85c <free+0x32>
 86c:	6398                	ld	a4,0(a5)
 86e:	00e6e463          	bltu	a3,a4,876 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 872:	fee7eae3          	bltu	a5,a4,866 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 876:	ff852583          	lw	a1,-8(a0)
 87a:	6390                	ld	a2,0(a5)
 87c:	02059813          	slli	a6,a1,0x20
 880:	01c85713          	srli	a4,a6,0x1c
 884:	9736                	add	a4,a4,a3
 886:	fae60de3          	beq	a2,a4,840 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 88a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88e:	4790                	lw	a2,8(a5)
 890:	02061593          	slli	a1,a2,0x20
 894:	01c5d713          	srli	a4,a1,0x1c
 898:	973e                	add	a4,a4,a5
 89a:	fae68ae3          	beq	a3,a4,84e <free+0x24>
    p->s.ptr = bp->s.ptr;
 89e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8a0:	00000717          	auipc	a4,0x0
 8a4:	76f73023          	sd	a5,1888(a4) # 1000 <freep>
}
 8a8:	60a2                	ld	ra,8(sp)
 8aa:	6402                	ld	s0,0(sp)
 8ac:	0141                	addi	sp,sp,16
 8ae:	8082                	ret

00000000000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	7139                	addi	sp,sp,-64
 8b2:	fc06                	sd	ra,56(sp)
 8b4:	f822                	sd	s0,48(sp)
 8b6:	f04a                	sd	s2,32(sp)
 8b8:	ec4e                	sd	s3,24(sp)
 8ba:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8bc:	02051993          	slli	s3,a0,0x20
 8c0:	0209d993          	srli	s3,s3,0x20
 8c4:	09bd                	addi	s3,s3,15
 8c6:	0049d993          	srli	s3,s3,0x4
 8ca:	2985                	addiw	s3,s3,1
 8cc:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8ce:	00000517          	auipc	a0,0x0
 8d2:	73253503          	ld	a0,1842(a0) # 1000 <freep>
 8d6:	c905                	beqz	a0,906 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	09377663          	bgeu	a4,s3,968 <malloc+0xb8>
 8e0:	f426                	sd	s1,40(sp)
 8e2:	e852                	sd	s4,16(sp)
 8e4:	e456                	sd	s5,8(sp)
 8e6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8e8:	8a4e                	mv	s4,s3
 8ea:	6705                	lui	a4,0x1
 8ec:	00e9f363          	bgeu	s3,a4,8f2 <malloc+0x42>
 8f0:	6a05                	lui	s4,0x1
 8f2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8fa:	00000497          	auipc	s1,0x0
 8fe:	70648493          	addi	s1,s1,1798 # 1000 <freep>
  if(p == (char*)-1)
 902:	5afd                	li	s5,-1
 904:	a83d                	j	942 <malloc+0x92>
 906:	f426                	sd	s1,40(sp)
 908:	e852                	sd	s4,16(sp)
 90a:	e456                	sd	s5,8(sp)
 90c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 90e:	00000797          	auipc	a5,0x0
 912:	70278793          	addi	a5,a5,1794 # 1010 <base>
 916:	00000717          	auipc	a4,0x0
 91a:	6ef73523          	sd	a5,1770(a4) # 1000 <freep>
 91e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 920:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 924:	b7d1                	j	8e8 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 926:	6398                	ld	a4,0(a5)
 928:	e118                	sd	a4,0(a0)
 92a:	a899                	j	980 <malloc+0xd0>
  hp->s.size = nu;
 92c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 930:	0541                	addi	a0,a0,16
 932:	ef9ff0ef          	jal	82a <free>
  return freep;
 936:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 938:	c125                	beqz	a0,998 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93c:	4798                	lw	a4,8(a5)
 93e:	03277163          	bgeu	a4,s2,960 <malloc+0xb0>
    if(p == freep)
 942:	6098                	ld	a4,0(s1)
 944:	853e                	mv	a0,a5
 946:	fef71ae3          	bne	a4,a5,93a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 94a:	8552                	mv	a0,s4
 94c:	b2bff0ef          	jal	476 <sbrk>
  if(p == (char*)-1)
 950:	fd551ee3          	bne	a0,s5,92c <malloc+0x7c>
        return 0;
 954:	4501                	li	a0,0
 956:	74a2                	ld	s1,40(sp)
 958:	6a42                	ld	s4,16(sp)
 95a:	6aa2                	ld	s5,8(sp)
 95c:	6b02                	ld	s6,0(sp)
 95e:	a03d                	j	98c <malloc+0xdc>
 960:	74a2                	ld	s1,40(sp)
 962:	6a42                	ld	s4,16(sp)
 964:	6aa2                	ld	s5,8(sp)
 966:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 968:	fae90fe3          	beq	s2,a4,926 <malloc+0x76>
        p->s.size -= nunits;
 96c:	4137073b          	subw	a4,a4,s3
 970:	c798                	sw	a4,8(a5)
        p += p->s.size;
 972:	02071693          	slli	a3,a4,0x20
 976:	01c6d713          	srli	a4,a3,0x1c
 97a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 97c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 980:	00000717          	auipc	a4,0x0
 984:	68a73023          	sd	a0,1664(a4) # 1000 <freep>
      return (void*)(p + 1);
 988:	01078513          	addi	a0,a5,16
  }
}
 98c:	70e2                	ld	ra,56(sp)
 98e:	7442                	ld	s0,48(sp)
 990:	7902                	ld	s2,32(sp)
 992:	69e2                	ld	s3,24(sp)
 994:	6121                	addi	sp,sp,64
 996:	8082                	ret
 998:	74a2                	ld	s1,40(sp)
 99a:	6a42                	ld	s4,16(sp)
 99c:	6aa2                	ld	s5,8(sp)
 99e:	6b02                	ld	s6,0(sp)
 9a0:	b7f5                	j	98c <malloc+0xdc>
