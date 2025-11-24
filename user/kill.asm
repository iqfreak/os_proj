
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	1c8000ef          	jal	1f0 <atoi>
  2c:	3ca000ef          	jal	3f6 <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	38e000ef          	jal	3c6 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	94058593          	addi	a1,a1,-1728 # 980 <malloc+0xf8>
  48:	4509                	li	a0,2
  4a:	75c000ef          	jal	7a6 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	376000ef          	jal	3c6 <exit>

0000000000000054 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  5c:	fa5ff0ef          	jal	0 <main>
  exit(0);
  60:	4501                	li	a0,0
  62:	364000ef          	jal	3c6 <exit>

0000000000000066 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  6e:	87aa                	mv	a5,a0
  70:	0585                	addi	a1,a1,1
  72:	0785                	addi	a5,a5,1
  74:	fff5c703          	lbu	a4,-1(a1)
  78:	fee78fa3          	sb	a4,-1(a5)
  7c:	fb75                	bnez	a4,70 <strcpy+0xa>
    ;
  return os;
}
  7e:	60a2                	ld	ra,8(sp)
  80:	6402                	ld	s0,0(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <strcmp>:

int strcmp(const char *p, const char *q)
{
  86:	1141                	addi	sp,sp,-16
  88:	e406                	sd	ra,8(sp)
  8a:	e022                	sd	s0,0(sp)
  8c:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  8e:	00054783          	lbu	a5,0(a0)
  92:	cb91                	beqz	a5,a6 <strcmp+0x20>
  94:	0005c703          	lbu	a4,0(a1)
  98:	00f71763          	bne	a4,a5,a6 <strcmp+0x20>
    p++, q++;
  9c:	0505                	addi	a0,a0,1
  9e:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	fbe5                	bnez	a5,94 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	60a2                	ld	ra,8(sp)
  b0:	6402                	ld	s0,0(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strlen>:

uint strlen(const char *s)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e406                	sd	ra,8(sp)
  ba:	e022                	sd	s0,0(sp)
  bc:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  be:	00054783          	lbu	a5,0(a0)
  c2:	cf99                	beqz	a5,e0 <strlen+0x2a>
  c4:	0505                	addi	a0,a0,1
  c6:	87aa                	mv	a5,a0
  c8:	86be                	mv	a3,a5
  ca:	0785                	addi	a5,a5,1
  cc:	fff7c703          	lbu	a4,-1(a5)
  d0:	ff65                	bnez	a4,c8 <strlen+0x12>
  d2:	40a6853b          	subw	a0,a3,a0
  d6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  d8:	60a2                	ld	ra,8(sp)
  da:	6402                	ld	s0,0(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret
  for (n = 0; s[n]; n++)
  e0:	4501                	li	a0,0
  e2:	bfdd                	j	d8 <strlen+0x22>

00000000000000e4 <memset>:

void *
memset(void *dst, int c, uint n)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e406                	sd	ra,8(sp)
  e8:	e022                	sd	s0,0(sp)
  ea:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  ec:	ca19                	beqz	a2,102 <memset+0x1e>
  ee:	87aa                	mv	a5,a0
  f0:	1602                	slli	a2,a2,0x20
  f2:	9201                	srli	a2,a2,0x20
  f4:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
  f8:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
  fc:	0785                	addi	a5,a5,1
  fe:	fee79de3          	bne	a5,a4,f8 <memset+0x14>
  }
  return dst;
}
 102:	60a2                	ld	ra,8(sp)
 104:	6402                	ld	s0,0(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret

000000000000010a <strchr>:

char *
strchr(const char *s, char c)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e406                	sd	ra,8(sp)
 10e:	e022                	sd	s0,0(sp)
 110:	0800                	addi	s0,sp,16
  for (; *s; s++)
 112:	00054783          	lbu	a5,0(a0)
 116:	cf81                	beqz	a5,12e <strchr+0x24>
    if (*s == c)
 118:	00f58763          	beq	a1,a5,126 <strchr+0x1c>
  for (; *s; s++)
 11c:	0505                	addi	a0,a0,1
 11e:	00054783          	lbu	a5,0(a0)
 122:	fbfd                	bnez	a5,118 <strchr+0xe>
      return (char *)s;
  return 0;
 124:	4501                	li	a0,0
}
 126:	60a2                	ld	ra,8(sp)
 128:	6402                	ld	s0,0(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret
  return 0;
 12e:	4501                	li	a0,0
 130:	bfdd                	j	126 <strchr+0x1c>

0000000000000132 <gets>:

char *
gets(char *buf, int max)
{
 132:	7159                	addi	sp,sp,-112
 134:	f486                	sd	ra,104(sp)
 136:	f0a2                	sd	s0,96(sp)
 138:	eca6                	sd	s1,88(sp)
 13a:	e8ca                	sd	s2,80(sp)
 13c:	e4ce                	sd	s3,72(sp)
 13e:	e0d2                	sd	s4,64(sp)
 140:	fc56                	sd	s5,56(sp)
 142:	f85a                	sd	s6,48(sp)
 144:	f45e                	sd	s7,40(sp)
 146:	f062                	sd	s8,32(sp)
 148:	ec66                	sd	s9,24(sp)
 14a:	e86a                	sd	s10,16(sp)
 14c:	1880                	addi	s0,sp,112
 14e:	8caa                	mv	s9,a0
 150:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 152:	892a                	mv	s2,a0
 154:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 156:	f9f40b13          	addi	s6,s0,-97
 15a:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 15c:	4ba9                	li	s7,10
 15e:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 160:	8d26                	mv	s10,s1
 162:	0014899b          	addiw	s3,s1,1
 166:	84ce                	mv	s1,s3
 168:	0349d563          	bge	s3,s4,192 <gets+0x60>
    cc = read(0, &c, 1);
 16c:	8656                	mv	a2,s5
 16e:	85da                	mv	a1,s6
 170:	4501                	li	a0,0
 172:	26c000ef          	jal	3de <read>
    if (cc < 1)
 176:	00a05e63          	blez	a0,192 <gets+0x60>
    buf[i++] = c;
 17a:	f9f44783          	lbu	a5,-97(s0)
 17e:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 182:	01778763          	beq	a5,s7,190 <gets+0x5e>
 186:	0905                	addi	s2,s2,1
 188:	fd879ce3          	bne	a5,s8,160 <gets+0x2e>
    buf[i++] = c;
 18c:	8d4e                	mv	s10,s3
 18e:	a011                	j	192 <gets+0x60>
 190:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 192:	9d66                	add	s10,s10,s9
 194:	000d0023          	sb	zero,0(s10)
  return buf;
}
 198:	8566                	mv	a0,s9
 19a:	70a6                	ld	ra,104(sp)
 19c:	7406                	ld	s0,96(sp)
 19e:	64e6                	ld	s1,88(sp)
 1a0:	6946                	ld	s2,80(sp)
 1a2:	69a6                	ld	s3,72(sp)
 1a4:	6a06                	ld	s4,64(sp)
 1a6:	7ae2                	ld	s5,56(sp)
 1a8:	7b42                	ld	s6,48(sp)
 1aa:	7ba2                	ld	s7,40(sp)
 1ac:	7c02                	ld	s8,32(sp)
 1ae:	6ce2                	ld	s9,24(sp)
 1b0:	6d42                	ld	s10,16(sp)
 1b2:	6165                	addi	sp,sp,112
 1b4:	8082                	ret

00000000000001b6 <stat>:

int stat(const char *n, struct stat *st)
{
 1b6:	1101                	addi	sp,sp,-32
 1b8:	ec06                	sd	ra,24(sp)
 1ba:	e822                	sd	s0,16(sp)
 1bc:	e04a                	sd	s2,0(sp)
 1be:	1000                	addi	s0,sp,32
 1c0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c2:	4581                	li	a1,0
 1c4:	242000ef          	jal	406 <open>
  if (fd < 0)
 1c8:	02054263          	bltz	a0,1ec <stat+0x36>
 1cc:	e426                	sd	s1,8(sp)
 1ce:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d0:	85ca                	mv	a1,s2
 1d2:	24c000ef          	jal	41e <fstat>
 1d6:	892a                	mv	s2,a0
  close(fd);
 1d8:	8526                	mv	a0,s1
 1da:	214000ef          	jal	3ee <close>
  return r;
 1de:	64a2                	ld	s1,8(sp)
}
 1e0:	854a                	mv	a0,s2
 1e2:	60e2                	ld	ra,24(sp)
 1e4:	6442                	ld	s0,16(sp)
 1e6:	6902                	ld	s2,0(sp)
 1e8:	6105                	addi	sp,sp,32
 1ea:	8082                	ret
    return -1;
 1ec:	597d                	li	s2,-1
 1ee:	bfcd                	j	1e0 <stat+0x2a>

00000000000001f0 <atoi>:

int atoi(const char *s)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e406                	sd	ra,8(sp)
 1f4:	e022                	sd	s0,0(sp)
 1f6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 1f8:	00054683          	lbu	a3,0(a0)
 1fc:	fd06879b          	addiw	a5,a3,-48
 200:	0ff7f793          	zext.b	a5,a5
 204:	4625                	li	a2,9
 206:	02f66963          	bltu	a2,a5,238 <atoi+0x48>
 20a:	872a                	mv	a4,a0
  n = 0;
 20c:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 20e:	0705                	addi	a4,a4,1
 210:	0025179b          	slliw	a5,a0,0x2
 214:	9fa9                	addw	a5,a5,a0
 216:	0017979b          	slliw	a5,a5,0x1
 21a:	9fb5                	addw	a5,a5,a3
 21c:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 220:	00074683          	lbu	a3,0(a4)
 224:	fd06879b          	addiw	a5,a3,-48
 228:	0ff7f793          	zext.b	a5,a5
 22c:	fef671e3          	bgeu	a2,a5,20e <atoi+0x1e>
  return n;
}
 230:	60a2                	ld	ra,8(sp)
 232:	6402                	ld	s0,0(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
  n = 0;
 238:	4501                	li	a0,0
 23a:	bfdd                	j	230 <atoi+0x40>

000000000000023c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e406                	sd	ra,8(sp)
 240:	e022                	sd	s0,0(sp)
 242:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 244:	02b57563          	bgeu	a0,a1,26e <memmove+0x32>
  {
    while (n-- > 0)
 248:	00c05f63          	blez	a2,266 <memmove+0x2a>
 24c:	1602                	slli	a2,a2,0x20
 24e:	9201                	srli	a2,a2,0x20
 250:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 254:	872a                	mv	a4,a0
      *dst++ = *src++;
 256:	0585                	addi	a1,a1,1
 258:	0705                	addi	a4,a4,1
 25a:	fff5c683          	lbu	a3,-1(a1)
 25e:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 262:	fee79ae3          	bne	a5,a4,256 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 266:	60a2                	ld	ra,8(sp)
 268:	6402                	ld	s0,0(sp)
 26a:	0141                	addi	sp,sp,16
 26c:	8082                	ret
    dst += n;
 26e:	00c50733          	add	a4,a0,a2
    src += n;
 272:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 274:	fec059e3          	blez	a2,266 <memmove+0x2a>
 278:	fff6079b          	addiw	a5,a2,-1
 27c:	1782                	slli	a5,a5,0x20
 27e:	9381                	srli	a5,a5,0x20
 280:	fff7c793          	not	a5,a5
 284:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 286:	15fd                	addi	a1,a1,-1
 288:	177d                	addi	a4,a4,-1
 28a:	0005c683          	lbu	a3,0(a1)
 28e:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 292:	fef71ae3          	bne	a4,a5,286 <memmove+0x4a>
 296:	bfc1                	j	266 <memmove+0x2a>

0000000000000298 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2a0:	ca0d                	beqz	a2,2d2 <memcmp+0x3a>
 2a2:	fff6069b          	addiw	a3,a2,-1
 2a6:	1682                	slli	a3,a3,0x20
 2a8:	9281                	srli	a3,a3,0x20
 2aa:	0685                	addi	a3,a3,1
 2ac:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	00e79863          	bne	a5,a4,2c6 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 2ba:	0505                	addi	a0,a0,1
    p2++;
 2bc:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2be:	fed518e3          	bne	a0,a3,2ae <memcmp+0x16>
  }
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	a019                	j	2ca <memcmp+0x32>
      return *p1 - *p2;
 2c6:	40e7853b          	subw	a0,a5,a4
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfdd                	j	2ca <memcmp+0x32>

00000000000002d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2de:	f5fff0ef          	jal	23c <memmove>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <strcat>:

char *strcat(char *dst, const char *src)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	c795                	beqz	a5,322 <strcat+0x38>
  char *p = dst;
 2f8:	87aa                	mv	a5,a0
    p++;
 2fa:	0785                	addi	a5,a5,1
  while (*p)
 2fc:	0007c703          	lbu	a4,0(a5)
 300:	ff6d                	bnez	a4,2fa <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 302:	0005c703          	lbu	a4,0(a1)
 306:	cb01                	beqz	a4,316 <strcat+0x2c>
  {
    *p = *src;
 308:	00e78023          	sb	a4,0(a5)
    p++;
 30c:	0785                	addi	a5,a5,1
    src++;
 30e:	0585                	addi	a1,a1,1
  while (*src)
 310:	0005c703          	lbu	a4,0(a1)
 314:	fb75                	bnez	a4,308 <strcat+0x1e>
  }

  *p = 0;
 316:	00078023          	sb	zero,0(a5)

  return dst;
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret
  char *p = dst;
 322:	87aa                	mv	a5,a0
 324:	bff9                	j	302 <strcat+0x18>

0000000000000326 <isdir>:

int isdir(char *path)
{
 326:	7179                	addi	sp,sp,-48
 328:	f406                	sd	ra,40(sp)
 32a:	f022                	sd	s0,32(sp)
 32c:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 32e:	fd840593          	addi	a1,s0,-40
 332:	e85ff0ef          	jal	1b6 <stat>
 336:	00054b63          	bltz	a0,34c <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 33a:	fe041503          	lh	a0,-32(s0)
 33e:	157d                	addi	a0,a0,-1
 340:	00153513          	seqz	a0,a0
}
 344:	70a2                	ld	ra,40(sp)
 346:	7402                	ld	s0,32(sp)
 348:	6145                	addi	sp,sp,48
 34a:	8082                	ret
    return 0;
 34c:	4501                	li	a0,0
 34e:	bfdd                	j	344 <isdir+0x1e>

0000000000000350 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 350:	7139                	addi	sp,sp,-64
 352:	fc06                	sd	ra,56(sp)
 354:	f822                	sd	s0,48(sp)
 356:	f426                	sd	s1,40(sp)
 358:	f04a                	sd	s2,32(sp)
 35a:	ec4e                	sd	s3,24(sp)
 35c:	e852                	sd	s4,16(sp)
 35e:	e456                	sd	s5,8(sp)
 360:	0080                	addi	s0,sp,64
 362:	89aa                	mv	s3,a0
 364:	8aae                	mv	s5,a1
 366:	84b2                	mv	s1,a2
 368:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 36a:	d4dff0ef          	jal	b6 <strlen>
 36e:	892a                	mv	s2,a0
  int nn = strlen(filename);
 370:	8556                	mv	a0,s5
 372:	d45ff0ef          	jal	b6 <strlen>
  int need = dn + 1 + nn + 1;
 376:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 37a:	9fa9                	addw	a5,a5,a0
    return 0;
 37c:	4501                	li	a0,0
  if (need > bufsize)
 37e:	0347d763          	bge	a5,s4,3ac <joinpath+0x5c>
  strcpy(out_buffer, dir);
 382:	85ce                	mv	a1,s3
 384:	8526                	mv	a0,s1
 386:	ce1ff0ef          	jal	66 <strcpy>
  if (dir[dn - 1] != '/')
 38a:	99ca                	add	s3,s3,s2
 38c:	fff9c703          	lbu	a4,-1(s3)
 390:	02f00793          	li	a5,47
 394:	00f70763          	beq	a4,a5,3a2 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 398:	9926                	add	s2,s2,s1
 39a:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 39e:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 3a2:	85d6                	mv	a1,s5
 3a4:	8526                	mv	a0,s1
 3a6:	f45ff0ef          	jal	2ea <strcat>
  return out_buffer;
 3aa:	8526                	mv	a0,s1
}
 3ac:	70e2                	ld	ra,56(sp)
 3ae:	7442                	ld	s0,48(sp)
 3b0:	74a2                	ld	s1,40(sp)
 3b2:	7902                	ld	s2,32(sp)
 3b4:	69e2                	ld	s3,24(sp)
 3b6:	6a42                	ld	s4,16(sp)
 3b8:	6aa2                	ld	s5,8(sp)
 3ba:	6121                	addi	sp,sp,64
 3bc:	8082                	ret

00000000000003be <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3be:	4885                	li	a7,1
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3c6:	4889                	li	a7,2
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ce:	488d                	li	a7,3
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3d6:	4891                	li	a7,4
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <read>:
.global read
read:
 li a7, SYS_read
 3de:	4895                	li	a7,5
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <write>:
.global write
write:
 li a7, SYS_write
 3e6:	48c1                	li	a7,16
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <close>:
.global close
close:
 li a7, SYS_close
 3ee:	48d5                	li	a7,21
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3f6:	4899                	li	a7,6
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <exec>:
.global exec
exec:
 li a7, SYS_exec
 3fe:	489d                	li	a7,7
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <open>:
.global open
open:
 li a7, SYS_open
 406:	48bd                	li	a7,15
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 40e:	48c5                	li	a7,17
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 416:	48c9                	li	a7,18
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 41e:	48a1                	li	a7,8
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <link>:
.global link
link:
 li a7, SYS_link
 426:	48cd                	li	a7,19
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 42e:	48d1                	li	a7,20
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 436:	48a5                	li	a7,9
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <dup>:
.global dup
dup:
 li a7, SYS_dup
 43e:	48a9                	li	a7,10
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 446:	48ad                	li	a7,11
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 44e:	48b1                	li	a7,12
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 456:	48b5                	li	a7,13
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 45e:	48b9                	li	a7,14
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 466:	48d9                	li	a7,22
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 46e:	1101                	addi	sp,sp,-32
 470:	ec06                	sd	ra,24(sp)
 472:	e822                	sd	s0,16(sp)
 474:	1000                	addi	s0,sp,32
 476:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 47a:	4605                	li	a2,1
 47c:	fef40593          	addi	a1,s0,-17
 480:	f67ff0ef          	jal	3e6 <write>
}
 484:	60e2                	ld	ra,24(sp)
 486:	6442                	ld	s0,16(sp)
 488:	6105                	addi	sp,sp,32
 48a:	8082                	ret

000000000000048c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 48c:	7139                	addi	sp,sp,-64
 48e:	fc06                	sd	ra,56(sp)
 490:	f822                	sd	s0,48(sp)
 492:	f426                	sd	s1,40(sp)
 494:	f04a                	sd	s2,32(sp)
 496:	ec4e                	sd	s3,24(sp)
 498:	0080                	addi	s0,sp,64
 49a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 49c:	c299                	beqz	a3,4a2 <printint+0x16>
 49e:	0605ce63          	bltz	a1,51a <printint+0x8e>
  neg = 0;
 4a2:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4a4:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4a8:	869a                	mv	a3,t1
  i = 0;
 4aa:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4ac:	00000817          	auipc	a6,0x0
 4b0:	4f480813          	addi	a6,a6,1268 # 9a0 <digits>
 4b4:	88be                	mv	a7,a5
 4b6:	0017851b          	addiw	a0,a5,1
 4ba:	87aa                	mv	a5,a0
 4bc:	02c5f73b          	remuw	a4,a1,a2
 4c0:	1702                	slli	a4,a4,0x20
 4c2:	9301                	srli	a4,a4,0x20
 4c4:	9742                	add	a4,a4,a6
 4c6:	00074703          	lbu	a4,0(a4)
 4ca:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4ce:	872e                	mv	a4,a1
 4d0:	02c5d5bb          	divuw	a1,a1,a2
 4d4:	0685                	addi	a3,a3,1
 4d6:	fcc77fe3          	bgeu	a4,a2,4b4 <printint+0x28>
  if(neg)
 4da:	000e0c63          	beqz	t3,4f2 <printint+0x66>
    buf[i++] = '-';
 4de:	fd050793          	addi	a5,a0,-48
 4e2:	00878533          	add	a0,a5,s0
 4e6:	02d00793          	li	a5,45
 4ea:	fef50823          	sb	a5,-16(a0)
 4ee:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4f2:	fff7899b          	addiw	s3,a5,-1
 4f6:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4fa:	fff4c583          	lbu	a1,-1(s1)
 4fe:	854a                	mv	a0,s2
 500:	f6fff0ef          	jal	46e <putc>
  while(--i >= 0)
 504:	39fd                	addiw	s3,s3,-1
 506:	14fd                	addi	s1,s1,-1
 508:	fe09d9e3          	bgez	s3,4fa <printint+0x6e>
}
 50c:	70e2                	ld	ra,56(sp)
 50e:	7442                	ld	s0,48(sp)
 510:	74a2                	ld	s1,40(sp)
 512:	7902                	ld	s2,32(sp)
 514:	69e2                	ld	s3,24(sp)
 516:	6121                	addi	sp,sp,64
 518:	8082                	ret
    x = -xx;
 51a:	40b005bb          	negw	a1,a1
    neg = 1;
 51e:	4e05                	li	t3,1
    x = -xx;
 520:	b751                	j	4a4 <printint+0x18>

0000000000000522 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 522:	711d                	addi	sp,sp,-96
 524:	ec86                	sd	ra,88(sp)
 526:	e8a2                	sd	s0,80(sp)
 528:	e4a6                	sd	s1,72(sp)
 52a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 52c:	0005c483          	lbu	s1,0(a1)
 530:	26048663          	beqz	s1,79c <vprintf+0x27a>
 534:	e0ca                	sd	s2,64(sp)
 536:	fc4e                	sd	s3,56(sp)
 538:	f852                	sd	s4,48(sp)
 53a:	f456                	sd	s5,40(sp)
 53c:	f05a                	sd	s6,32(sp)
 53e:	ec5e                	sd	s7,24(sp)
 540:	e862                	sd	s8,16(sp)
 542:	e466                	sd	s9,8(sp)
 544:	8b2a                	mv	s6,a0
 546:	8a2e                	mv	s4,a1
 548:	8bb2                	mv	s7,a2
  state = 0;
 54a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 54c:	4901                	li	s2,0
 54e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 550:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 554:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 558:	06c00c93          	li	s9,108
 55c:	a00d                	j	57e <vprintf+0x5c>
        putc(fd, c0);
 55e:	85a6                	mv	a1,s1
 560:	855a                	mv	a0,s6
 562:	f0dff0ef          	jal	46e <putc>
 566:	a019                	j	56c <vprintf+0x4a>
    } else if(state == '%'){
 568:	03598363          	beq	s3,s5,58e <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 56c:	0019079b          	addiw	a5,s2,1
 570:	893e                	mv	s2,a5
 572:	873e                	mv	a4,a5
 574:	97d2                	add	a5,a5,s4
 576:	0007c483          	lbu	s1,0(a5)
 57a:	20048963          	beqz	s1,78c <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 57e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 582:	fe0993e3          	bnez	s3,568 <vprintf+0x46>
      if(c0 == '%'){
 586:	fd579ce3          	bne	a5,s5,55e <vprintf+0x3c>
        state = '%';
 58a:	89be                	mv	s3,a5
 58c:	b7c5                	j	56c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 58e:	00ea06b3          	add	a3,s4,a4
 592:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 596:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 598:	c681                	beqz	a3,5a0 <vprintf+0x7e>
 59a:	9752                	add	a4,a4,s4
 59c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5a0:	03878e63          	beq	a5,s8,5dc <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 5a4:	05978863          	beq	a5,s9,5f4 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5a8:	07500713          	li	a4,117
 5ac:	0ee78263          	beq	a5,a4,690 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5b0:	07800713          	li	a4,120
 5b4:	12e78463          	beq	a5,a4,6dc <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5b8:	07000713          	li	a4,112
 5bc:	14e78963          	beq	a5,a4,70e <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5c0:	07300713          	li	a4,115
 5c4:	18e78863          	beq	a5,a4,754 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5c8:	02500713          	li	a4,37
 5cc:	04e79463          	bne	a5,a4,614 <vprintf+0xf2>
        putc(fd, '%');
 5d0:	85ba                	mv	a1,a4
 5d2:	855a                	mv	a0,s6
 5d4:	e9bff0ef          	jal	46e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5d8:	4981                	li	s3,0
 5da:	bf49                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5dc:	008b8493          	addi	s1,s7,8
 5e0:	4685                	li	a3,1
 5e2:	4629                	li	a2,10
 5e4:	000ba583          	lw	a1,0(s7)
 5e8:	855a                	mv	a0,s6
 5ea:	ea3ff0ef          	jal	48c <printint>
 5ee:	8ba6                	mv	s7,s1
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	bfad                	j	56c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5f4:	06400793          	li	a5,100
 5f8:	02f68963          	beq	a3,a5,62a <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5fc:	06c00793          	li	a5,108
 600:	04f68263          	beq	a3,a5,644 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 604:	07500793          	li	a5,117
 608:	0af68063          	beq	a3,a5,6a8 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 60c:	07800793          	li	a5,120
 610:	0ef68263          	beq	a3,a5,6f4 <vprintf+0x1d2>
        putc(fd, '%');
 614:	02500593          	li	a1,37
 618:	855a                	mv	a0,s6
 61a:	e55ff0ef          	jal	46e <putc>
        putc(fd, c0);
 61e:	85a6                	mv	a1,s1
 620:	855a                	mv	a0,s6
 622:	e4dff0ef          	jal	46e <putc>
      state = 0;
 626:	4981                	li	s3,0
 628:	b791                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 62a:	008b8493          	addi	s1,s7,8
 62e:	4685                	li	a3,1
 630:	4629                	li	a2,10
 632:	000ba583          	lw	a1,0(s7)
 636:	855a                	mv	a0,s6
 638:	e55ff0ef          	jal	48c <printint>
        i += 1;
 63c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 63e:	8ba6                	mv	s7,s1
      state = 0;
 640:	4981                	li	s3,0
        i += 1;
 642:	b72d                	j	56c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 644:	06400793          	li	a5,100
 648:	02f60763          	beq	a2,a5,676 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 64c:	07500793          	li	a5,117
 650:	06f60963          	beq	a2,a5,6c2 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 654:	07800793          	li	a5,120
 658:	faf61ee3          	bne	a2,a5,614 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 65c:	008b8493          	addi	s1,s7,8
 660:	4681                	li	a3,0
 662:	4641                	li	a2,16
 664:	000ba583          	lw	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	e23ff0ef          	jal	48c <printint>
        i += 2;
 66e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 670:	8ba6                	mv	s7,s1
      state = 0;
 672:	4981                	li	s3,0
        i += 2;
 674:	bde5                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 676:	008b8493          	addi	s1,s7,8
 67a:	4685                	li	a3,1
 67c:	4629                	li	a2,10
 67e:	000ba583          	lw	a1,0(s7)
 682:	855a                	mv	a0,s6
 684:	e09ff0ef          	jal	48c <printint>
        i += 2;
 688:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 68a:	8ba6                	mv	s7,s1
      state = 0;
 68c:	4981                	li	s3,0
        i += 2;
 68e:	bdf9                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 690:	008b8493          	addi	s1,s7,8
 694:	4681                	li	a3,0
 696:	4629                	li	a2,10
 698:	000ba583          	lw	a1,0(s7)
 69c:	855a                	mv	a0,s6
 69e:	defff0ef          	jal	48c <printint>
 6a2:	8ba6                	mv	s7,s1
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	b5d9                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a8:	008b8493          	addi	s1,s7,8
 6ac:	4681                	li	a3,0
 6ae:	4629                	li	a2,10
 6b0:	000ba583          	lw	a1,0(s7)
 6b4:	855a                	mv	a0,s6
 6b6:	dd7ff0ef          	jal	48c <printint>
        i += 1;
 6ba:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6bc:	8ba6                	mv	s7,s1
      state = 0;
 6be:	4981                	li	s3,0
        i += 1;
 6c0:	b575                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c2:	008b8493          	addi	s1,s7,8
 6c6:	4681                	li	a3,0
 6c8:	4629                	li	a2,10
 6ca:	000ba583          	lw	a1,0(s7)
 6ce:	855a                	mv	a0,s6
 6d0:	dbdff0ef          	jal	48c <printint>
        i += 2;
 6d4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d6:	8ba6                	mv	s7,s1
      state = 0;
 6d8:	4981                	li	s3,0
        i += 2;
 6da:	bd49                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6dc:	008b8493          	addi	s1,s7,8
 6e0:	4681                	li	a3,0
 6e2:	4641                	li	a2,16
 6e4:	000ba583          	lw	a1,0(s7)
 6e8:	855a                	mv	a0,s6
 6ea:	da3ff0ef          	jal	48c <printint>
 6ee:	8ba6                	mv	s7,s1
      state = 0;
 6f0:	4981                	li	s3,0
 6f2:	bdad                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f4:	008b8493          	addi	s1,s7,8
 6f8:	4681                	li	a3,0
 6fa:	4641                	li	a2,16
 6fc:	000ba583          	lw	a1,0(s7)
 700:	855a                	mv	a0,s6
 702:	d8bff0ef          	jal	48c <printint>
        i += 1;
 706:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 708:	8ba6                	mv	s7,s1
      state = 0;
 70a:	4981                	li	s3,0
        i += 1;
 70c:	b585                	j	56c <vprintf+0x4a>
 70e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 710:	008b8d13          	addi	s10,s7,8
 714:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 718:	03000593          	li	a1,48
 71c:	855a                	mv	a0,s6
 71e:	d51ff0ef          	jal	46e <putc>
  putc(fd, 'x');
 722:	07800593          	li	a1,120
 726:	855a                	mv	a0,s6
 728:	d47ff0ef          	jal	46e <putc>
 72c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72e:	00000b97          	auipc	s7,0x0
 732:	272b8b93          	addi	s7,s7,626 # 9a0 <digits>
 736:	03c9d793          	srli	a5,s3,0x3c
 73a:	97de                	add	a5,a5,s7
 73c:	0007c583          	lbu	a1,0(a5)
 740:	855a                	mv	a0,s6
 742:	d2dff0ef          	jal	46e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 746:	0992                	slli	s3,s3,0x4
 748:	34fd                	addiw	s1,s1,-1
 74a:	f4f5                	bnez	s1,736 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 74c:	8bea                	mv	s7,s10
      state = 0;
 74e:	4981                	li	s3,0
 750:	6d02                	ld	s10,0(sp)
 752:	bd29                	j	56c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 754:	008b8993          	addi	s3,s7,8
 758:	000bb483          	ld	s1,0(s7)
 75c:	cc91                	beqz	s1,778 <vprintf+0x256>
        for(; *s; s++)
 75e:	0004c583          	lbu	a1,0(s1)
 762:	c195                	beqz	a1,786 <vprintf+0x264>
          putc(fd, *s);
 764:	855a                	mv	a0,s6
 766:	d09ff0ef          	jal	46e <putc>
        for(; *s; s++)
 76a:	0485                	addi	s1,s1,1
 76c:	0004c583          	lbu	a1,0(s1)
 770:	f9f5                	bnez	a1,764 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 772:	8bce                	mv	s7,s3
      state = 0;
 774:	4981                	li	s3,0
 776:	bbdd                	j	56c <vprintf+0x4a>
          s = "(null)";
 778:	00000497          	auipc	s1,0x0
 77c:	22048493          	addi	s1,s1,544 # 998 <malloc+0x110>
        for(; *s; s++)
 780:	02800593          	li	a1,40
 784:	b7c5                	j	764 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 786:	8bce                	mv	s7,s3
      state = 0;
 788:	4981                	li	s3,0
 78a:	b3cd                	j	56c <vprintf+0x4a>
 78c:	6906                	ld	s2,64(sp)
 78e:	79e2                	ld	s3,56(sp)
 790:	7a42                	ld	s4,48(sp)
 792:	7aa2                	ld	s5,40(sp)
 794:	7b02                	ld	s6,32(sp)
 796:	6be2                	ld	s7,24(sp)
 798:	6c42                	ld	s8,16(sp)
 79a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 79c:	60e6                	ld	ra,88(sp)
 79e:	6446                	ld	s0,80(sp)
 7a0:	64a6                	ld	s1,72(sp)
 7a2:	6125                	addi	sp,sp,96
 7a4:	8082                	ret

00000000000007a6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7a6:	715d                	addi	sp,sp,-80
 7a8:	ec06                	sd	ra,24(sp)
 7aa:	e822                	sd	s0,16(sp)
 7ac:	1000                	addi	s0,sp,32
 7ae:	e010                	sd	a2,0(s0)
 7b0:	e414                	sd	a3,8(s0)
 7b2:	e818                	sd	a4,16(s0)
 7b4:	ec1c                	sd	a5,24(s0)
 7b6:	03043023          	sd	a6,32(s0)
 7ba:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7be:	8622                	mv	a2,s0
 7c0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7c4:	d5fff0ef          	jal	522 <vprintf>
}
 7c8:	60e2                	ld	ra,24(sp)
 7ca:	6442                	ld	s0,16(sp)
 7cc:	6161                	addi	sp,sp,80
 7ce:	8082                	ret

00000000000007d0 <printf>:

void
printf(const char *fmt, ...)
{
 7d0:	711d                	addi	sp,sp,-96
 7d2:	ec06                	sd	ra,24(sp)
 7d4:	e822                	sd	s0,16(sp)
 7d6:	1000                	addi	s0,sp,32
 7d8:	e40c                	sd	a1,8(s0)
 7da:	e810                	sd	a2,16(s0)
 7dc:	ec14                	sd	a3,24(s0)
 7de:	f018                	sd	a4,32(s0)
 7e0:	f41c                	sd	a5,40(s0)
 7e2:	03043823          	sd	a6,48(s0)
 7e6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ea:	00840613          	addi	a2,s0,8
 7ee:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7f2:	85aa                	mv	a1,a0
 7f4:	4505                	li	a0,1
 7f6:	d2dff0ef          	jal	522 <vprintf>
}
 7fa:	60e2                	ld	ra,24(sp)
 7fc:	6442                	ld	s0,16(sp)
 7fe:	6125                	addi	sp,sp,96
 800:	8082                	ret

0000000000000802 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 802:	1141                	addi	sp,sp,-16
 804:	e406                	sd	ra,8(sp)
 806:	e022                	sd	s0,0(sp)
 808:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 80a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80e:	00000797          	auipc	a5,0x0
 812:	7f27b783          	ld	a5,2034(a5) # 1000 <freep>
 816:	a02d                	j	840 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 818:	4618                	lw	a4,8(a2)
 81a:	9f2d                	addw	a4,a4,a1
 81c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 820:	6398                	ld	a4,0(a5)
 822:	6310                	ld	a2,0(a4)
 824:	a83d                	j	862 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 826:	ff852703          	lw	a4,-8(a0)
 82a:	9f31                	addw	a4,a4,a2
 82c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 82e:	ff053683          	ld	a3,-16(a0)
 832:	a091                	j	876 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 834:	6398                	ld	a4,0(a5)
 836:	00e7e463          	bltu	a5,a4,83e <free+0x3c>
 83a:	00e6ea63          	bltu	a3,a4,84e <free+0x4c>
{
 83e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 840:	fed7fae3          	bgeu	a5,a3,834 <free+0x32>
 844:	6398                	ld	a4,0(a5)
 846:	00e6e463          	bltu	a3,a4,84e <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84a:	fee7eae3          	bltu	a5,a4,83e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 84e:	ff852583          	lw	a1,-8(a0)
 852:	6390                	ld	a2,0(a5)
 854:	02059813          	slli	a6,a1,0x20
 858:	01c85713          	srli	a4,a6,0x1c
 85c:	9736                	add	a4,a4,a3
 85e:	fae60de3          	beq	a2,a4,818 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 862:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 866:	4790                	lw	a2,8(a5)
 868:	02061593          	slli	a1,a2,0x20
 86c:	01c5d713          	srli	a4,a1,0x1c
 870:	973e                	add	a4,a4,a5
 872:	fae68ae3          	beq	a3,a4,826 <free+0x24>
    p->s.ptr = bp->s.ptr;
 876:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 878:	00000717          	auipc	a4,0x0
 87c:	78f73423          	sd	a5,1928(a4) # 1000 <freep>
}
 880:	60a2                	ld	ra,8(sp)
 882:	6402                	ld	s0,0(sp)
 884:	0141                	addi	sp,sp,16
 886:	8082                	ret

0000000000000888 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 888:	7139                	addi	sp,sp,-64
 88a:	fc06                	sd	ra,56(sp)
 88c:	f822                	sd	s0,48(sp)
 88e:	f04a                	sd	s2,32(sp)
 890:	ec4e                	sd	s3,24(sp)
 892:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 894:	02051993          	slli	s3,a0,0x20
 898:	0209d993          	srli	s3,s3,0x20
 89c:	09bd                	addi	s3,s3,15
 89e:	0049d993          	srli	s3,s3,0x4
 8a2:	2985                	addiw	s3,s3,1
 8a4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8a6:	00000517          	auipc	a0,0x0
 8aa:	75a53503          	ld	a0,1882(a0) # 1000 <freep>
 8ae:	c905                	beqz	a0,8de <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b2:	4798                	lw	a4,8(a5)
 8b4:	09377663          	bgeu	a4,s3,940 <malloc+0xb8>
 8b8:	f426                	sd	s1,40(sp)
 8ba:	e852                	sd	s4,16(sp)
 8bc:	e456                	sd	s5,8(sp)
 8be:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8c0:	8a4e                	mv	s4,s3
 8c2:	6705                	lui	a4,0x1
 8c4:	00e9f363          	bgeu	s3,a4,8ca <malloc+0x42>
 8c8:	6a05                	lui	s4,0x1
 8ca:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ce:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8d2:	00000497          	auipc	s1,0x0
 8d6:	72e48493          	addi	s1,s1,1838 # 1000 <freep>
  if(p == (char*)-1)
 8da:	5afd                	li	s5,-1
 8dc:	a83d                	j	91a <malloc+0x92>
 8de:	f426                	sd	s1,40(sp)
 8e0:	e852                	sd	s4,16(sp)
 8e2:	e456                	sd	s5,8(sp)
 8e4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8e6:	00000797          	auipc	a5,0x0
 8ea:	72a78793          	addi	a5,a5,1834 # 1010 <base>
 8ee:	00000717          	auipc	a4,0x0
 8f2:	70f73923          	sd	a5,1810(a4) # 1000 <freep>
 8f6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8f8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8fc:	b7d1                	j	8c0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8fe:	6398                	ld	a4,0(a5)
 900:	e118                	sd	a4,0(a0)
 902:	a899                	j	958 <malloc+0xd0>
  hp->s.size = nu;
 904:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 908:	0541                	addi	a0,a0,16
 90a:	ef9ff0ef          	jal	802 <free>
  return freep;
 90e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 910:	c125                	beqz	a0,970 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 912:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 914:	4798                	lw	a4,8(a5)
 916:	03277163          	bgeu	a4,s2,938 <malloc+0xb0>
    if(p == freep)
 91a:	6098                	ld	a4,0(s1)
 91c:	853e                	mv	a0,a5
 91e:	fef71ae3          	bne	a4,a5,912 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 922:	8552                	mv	a0,s4
 924:	b2bff0ef          	jal	44e <sbrk>
  if(p == (char*)-1)
 928:	fd551ee3          	bne	a0,s5,904 <malloc+0x7c>
        return 0;
 92c:	4501                	li	a0,0
 92e:	74a2                	ld	s1,40(sp)
 930:	6a42                	ld	s4,16(sp)
 932:	6aa2                	ld	s5,8(sp)
 934:	6b02                	ld	s6,0(sp)
 936:	a03d                	j	964 <malloc+0xdc>
 938:	74a2                	ld	s1,40(sp)
 93a:	6a42                	ld	s4,16(sp)
 93c:	6aa2                	ld	s5,8(sp)
 93e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 940:	fae90fe3          	beq	s2,a4,8fe <malloc+0x76>
        p->s.size -= nunits;
 944:	4137073b          	subw	a4,a4,s3
 948:	c798                	sw	a4,8(a5)
        p += p->s.size;
 94a:	02071693          	slli	a3,a4,0x20
 94e:	01c6d713          	srli	a4,a3,0x1c
 952:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 954:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 958:	00000717          	auipc	a4,0x0
 95c:	6aa73423          	sd	a0,1704(a4) # 1000 <freep>
      return (void*)(p + 1);
 960:	01078513          	addi	a0,a5,16
  }
}
 964:	70e2                	ld	ra,56(sp)
 966:	7442                	ld	s0,48(sp)
 968:	7902                	ld	s2,32(sp)
 96a:	69e2                	ld	s3,24(sp)
 96c:	6121                	addi	sp,sp,64
 96e:	8082                	ret
 970:	74a2                	ld	s1,40(sp)
 972:	6a42                	ld	s4,16(sp)
 974:	6aa2                	ld	s5,8(sp)
 976:	6b02                	ld	s6,0(sp)
 978:	b7f5                	j	964 <malloc+0xdc>
