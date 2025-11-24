
user/_touch:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84ae                	mv	s1,a1
    if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7df63          	bge	a5,a0,4e <main+0x4e>
        printf("usage: create <filename>\n");

    }

    char *path = argv[1];
  14:	0084b903          	ld	s2,8(s1)
    int fd;

    fd = open(path, 0);
  18:	4581                	li	a1,0
  1a:	854a                	mv	a0,s2
  1c:	416000ef          	jal	432 <open>
    if(fd >= 0) {
  20:	02055e63          	bgez	a0,5c <main+0x5c>
        close(fd);
        printf("error: file '%s' already exists\n", path);
    }

    fd = open(path, O_CREATE | O_RDWR);
  24:	20200593          	li	a1,514
  28:	854a                	mv	a0,s2
  2a:	408000ef          	jal	432 <open>
  2e:	84aa                	mv	s1,a0
    if(fd < 0) {
  30:	04054063          	bltz	a0,70 <main+0x70>
        printf("error: failed to create file '%s'\n", path);
    }

    printf("created file '%s'\n", path);
  34:	85ca                	mv	a1,s2
  36:	00001517          	auipc	a0,0x1
  3a:	9ea50513          	addi	a0,a0,-1558 # a20 <malloc+0x16c>
  3e:	7be000ef          	jal	7fc <printf>
    close(fd);
  42:	8526                	mv	a0,s1
  44:	3d6000ef          	jal	41a <close>
    exit(0);
  48:	4501                	li	a0,0
  4a:	3a8000ef          	jal	3f2 <exit>
        printf("usage: create <filename>\n");
  4e:	00001517          	auipc	a0,0x1
  52:	96250513          	addi	a0,a0,-1694 # 9b0 <malloc+0xfc>
  56:	7a6000ef          	jal	7fc <printf>
  5a:	bf6d                	j	14 <main+0x14>
        close(fd);
  5c:	3be000ef          	jal	41a <close>
        printf("error: file '%s' already exists\n", path);
  60:	85ca                	mv	a1,s2
  62:	00001517          	auipc	a0,0x1
  66:	96e50513          	addi	a0,a0,-1682 # 9d0 <malloc+0x11c>
  6a:	792000ef          	jal	7fc <printf>
  6e:	bf5d                	j	24 <main+0x24>
        printf("error: failed to create file '%s'\n", path);
  70:	85ca                	mv	a1,s2
  72:	00001517          	auipc	a0,0x1
  76:	98650513          	addi	a0,a0,-1658 # 9f8 <malloc+0x144>
  7a:	782000ef          	jal	7fc <printf>
  7e:	bf5d                	j	34 <main+0x34>

0000000000000080 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  80:	1141                	addi	sp,sp,-16
  82:	e406                	sd	ra,8(sp)
  84:	e022                	sd	s0,0(sp)
  86:	0800                	addi	s0,sp,16
  extern int main();
  main();
  88:	f79ff0ef          	jal	0 <main>
  exit(0);
  8c:	4501                	li	a0,0
  8e:	364000ef          	jal	3f2 <exit>

0000000000000092 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  92:	1141                	addi	sp,sp,-16
  94:	e406                	sd	ra,8(sp)
  96:	e022                	sd	s0,0(sp)
  98:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  9a:	87aa                	mv	a5,a0
  9c:	0585                	addi	a1,a1,1
  9e:	0785                	addi	a5,a5,1
  a0:	fff5c703          	lbu	a4,-1(a1)
  a4:	fee78fa3          	sb	a4,-1(a5)
  a8:	fb75                	bnez	a4,9c <strcpy+0xa>
    ;
  return os;
}
  aa:	60a2                	ld	ra,8(sp)
  ac:	6402                	ld	s0,0(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret

00000000000000b2 <strcmp>:

int strcmp(const char *p, const char *q)
{
  b2:	1141                	addi	sp,sp,-16
  b4:	e406                	sd	ra,8(sp)
  b6:	e022                	sd	s0,0(sp)
  b8:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cb91                	beqz	a5,d2 <strcmp+0x20>
  c0:	0005c703          	lbu	a4,0(a1)
  c4:	00f71763          	bne	a4,a5,d2 <strcmp+0x20>
    p++, q++;
  c8:	0505                	addi	a0,a0,1
  ca:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  cc:	00054783          	lbu	a5,0(a0)
  d0:	fbe5                	bnez	a5,c0 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  d2:	0005c503          	lbu	a0,0(a1)
}
  d6:	40a7853b          	subw	a0,a5,a0
  da:	60a2                	ld	ra,8(sp)
  dc:	6402                	ld	s0,0(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strlen>:

uint strlen(const char *s)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e406                	sd	ra,8(sp)
  e6:	e022                	sd	s0,0(sp)
  e8:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  ea:	00054783          	lbu	a5,0(a0)
  ee:	cf99                	beqz	a5,10c <strlen+0x2a>
  f0:	0505                	addi	a0,a0,1
  f2:	87aa                	mv	a5,a0
  f4:	86be                	mv	a3,a5
  f6:	0785                	addi	a5,a5,1
  f8:	fff7c703          	lbu	a4,-1(a5)
  fc:	ff65                	bnez	a4,f4 <strlen+0x12>
  fe:	40a6853b          	subw	a0,a3,a0
 102:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 104:	60a2                	ld	ra,8(sp)
 106:	6402                	ld	s0,0(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret
  for (n = 0; s[n]; n++)
 10c:	4501                	li	a0,0
 10e:	bfdd                	j	104 <strlen+0x22>

0000000000000110 <memset>:

void *
memset(void *dst, int c, uint n)
{
 110:	1141                	addi	sp,sp,-16
 112:	e406                	sd	ra,8(sp)
 114:	e022                	sd	s0,0(sp)
 116:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 118:	ca19                	beqz	a2,12e <memset+0x1e>
 11a:	87aa                	mv	a5,a0
 11c:	1602                	slli	a2,a2,0x20
 11e:	9201                	srli	a2,a2,0x20
 120:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 124:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 128:	0785                	addi	a5,a5,1
 12a:	fee79de3          	bne	a5,a4,124 <memset+0x14>
  }
  return dst;
}
 12e:	60a2                	ld	ra,8(sp)
 130:	6402                	ld	s0,0(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strchr>:

char *
strchr(const char *s, char c)
{
 136:	1141                	addi	sp,sp,-16
 138:	e406                	sd	ra,8(sp)
 13a:	e022                	sd	s0,0(sp)
 13c:	0800                	addi	s0,sp,16
  for (; *s; s++)
 13e:	00054783          	lbu	a5,0(a0)
 142:	cf81                	beqz	a5,15a <strchr+0x24>
    if (*s == c)
 144:	00f58763          	beq	a1,a5,152 <strchr+0x1c>
  for (; *s; s++)
 148:	0505                	addi	a0,a0,1
 14a:	00054783          	lbu	a5,0(a0)
 14e:	fbfd                	bnez	a5,144 <strchr+0xe>
      return (char *)s;
  return 0;
 150:	4501                	li	a0,0
}
 152:	60a2                	ld	ra,8(sp)
 154:	6402                	ld	s0,0(sp)
 156:	0141                	addi	sp,sp,16
 158:	8082                	ret
  return 0;
 15a:	4501                	li	a0,0
 15c:	bfdd                	j	152 <strchr+0x1c>

000000000000015e <gets>:

char *
gets(char *buf, int max)
{
 15e:	7159                	addi	sp,sp,-112
 160:	f486                	sd	ra,104(sp)
 162:	f0a2                	sd	s0,96(sp)
 164:	eca6                	sd	s1,88(sp)
 166:	e8ca                	sd	s2,80(sp)
 168:	e4ce                	sd	s3,72(sp)
 16a:	e0d2                	sd	s4,64(sp)
 16c:	fc56                	sd	s5,56(sp)
 16e:	f85a                	sd	s6,48(sp)
 170:	f45e                	sd	s7,40(sp)
 172:	f062                	sd	s8,32(sp)
 174:	ec66                	sd	s9,24(sp)
 176:	e86a                	sd	s10,16(sp)
 178:	1880                	addi	s0,sp,112
 17a:	8caa                	mv	s9,a0
 17c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 17e:	892a                	mv	s2,a0
 180:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 182:	f9f40b13          	addi	s6,s0,-97
 186:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 188:	4ba9                	li	s7,10
 18a:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 18c:	8d26                	mv	s10,s1
 18e:	0014899b          	addiw	s3,s1,1
 192:	84ce                	mv	s1,s3
 194:	0349d563          	bge	s3,s4,1be <gets+0x60>
    cc = read(0, &c, 1);
 198:	8656                	mv	a2,s5
 19a:	85da                	mv	a1,s6
 19c:	4501                	li	a0,0
 19e:	26c000ef          	jal	40a <read>
    if (cc < 1)
 1a2:	00a05e63          	blez	a0,1be <gets+0x60>
    buf[i++] = c;
 1a6:	f9f44783          	lbu	a5,-97(s0)
 1aa:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 1ae:	01778763          	beq	a5,s7,1bc <gets+0x5e>
 1b2:	0905                	addi	s2,s2,1
 1b4:	fd879ce3          	bne	a5,s8,18c <gets+0x2e>
    buf[i++] = c;
 1b8:	8d4e                	mv	s10,s3
 1ba:	a011                	j	1be <gets+0x60>
 1bc:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1be:	9d66                	add	s10,s10,s9
 1c0:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1c4:	8566                	mv	a0,s9
 1c6:	70a6                	ld	ra,104(sp)
 1c8:	7406                	ld	s0,96(sp)
 1ca:	64e6                	ld	s1,88(sp)
 1cc:	6946                	ld	s2,80(sp)
 1ce:	69a6                	ld	s3,72(sp)
 1d0:	6a06                	ld	s4,64(sp)
 1d2:	7ae2                	ld	s5,56(sp)
 1d4:	7b42                	ld	s6,48(sp)
 1d6:	7ba2                	ld	s7,40(sp)
 1d8:	7c02                	ld	s8,32(sp)
 1da:	6ce2                	ld	s9,24(sp)
 1dc:	6d42                	ld	s10,16(sp)
 1de:	6165                	addi	sp,sp,112
 1e0:	8082                	ret

00000000000001e2 <stat>:

int stat(const char *n, struct stat *st)
{
 1e2:	1101                	addi	sp,sp,-32
 1e4:	ec06                	sd	ra,24(sp)
 1e6:	e822                	sd	s0,16(sp)
 1e8:	e04a                	sd	s2,0(sp)
 1ea:	1000                	addi	s0,sp,32
 1ec:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ee:	4581                	li	a1,0
 1f0:	242000ef          	jal	432 <open>
  if (fd < 0)
 1f4:	02054263          	bltz	a0,218 <stat+0x36>
 1f8:	e426                	sd	s1,8(sp)
 1fa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1fc:	85ca                	mv	a1,s2
 1fe:	24c000ef          	jal	44a <fstat>
 202:	892a                	mv	s2,a0
  close(fd);
 204:	8526                	mv	a0,s1
 206:	214000ef          	jal	41a <close>
  return r;
 20a:	64a2                	ld	s1,8(sp)
}
 20c:	854a                	mv	a0,s2
 20e:	60e2                	ld	ra,24(sp)
 210:	6442                	ld	s0,16(sp)
 212:	6902                	ld	s2,0(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret
    return -1;
 218:	597d                	li	s2,-1
 21a:	bfcd                	j	20c <stat+0x2a>

000000000000021c <atoi>:

int atoi(const char *s)
{
 21c:	1141                	addi	sp,sp,-16
 21e:	e406                	sd	ra,8(sp)
 220:	e022                	sd	s0,0(sp)
 222:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 224:	00054683          	lbu	a3,0(a0)
 228:	fd06879b          	addiw	a5,a3,-48
 22c:	0ff7f793          	zext.b	a5,a5
 230:	4625                	li	a2,9
 232:	02f66963          	bltu	a2,a5,264 <atoi+0x48>
 236:	872a                	mv	a4,a0
  n = 0;
 238:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 23a:	0705                	addi	a4,a4,1
 23c:	0025179b          	slliw	a5,a0,0x2
 240:	9fa9                	addw	a5,a5,a0
 242:	0017979b          	slliw	a5,a5,0x1
 246:	9fb5                	addw	a5,a5,a3
 248:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 24c:	00074683          	lbu	a3,0(a4)
 250:	fd06879b          	addiw	a5,a3,-48
 254:	0ff7f793          	zext.b	a5,a5
 258:	fef671e3          	bgeu	a2,a5,23a <atoi+0x1e>
  return n;
}
 25c:	60a2                	ld	ra,8(sp)
 25e:	6402                	ld	s0,0(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret
  n = 0;
 264:	4501                	li	a0,0
 266:	bfdd                	j	25c <atoi+0x40>

0000000000000268 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 268:	1141                	addi	sp,sp,-16
 26a:	e406                	sd	ra,8(sp)
 26c:	e022                	sd	s0,0(sp)
 26e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 270:	02b57563          	bgeu	a0,a1,29a <memmove+0x32>
  {
    while (n-- > 0)
 274:	00c05f63          	blez	a2,292 <memmove+0x2a>
 278:	1602                	slli	a2,a2,0x20
 27a:	9201                	srli	a2,a2,0x20
 27c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 280:	872a                	mv	a4,a0
      *dst++ = *src++;
 282:	0585                	addi	a1,a1,1
 284:	0705                	addi	a4,a4,1
 286:	fff5c683          	lbu	a3,-1(a1)
 28a:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 28e:	fee79ae3          	bne	a5,a4,282 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 292:	60a2                	ld	ra,8(sp)
 294:	6402                	ld	s0,0(sp)
 296:	0141                	addi	sp,sp,16
 298:	8082                	ret
    dst += n;
 29a:	00c50733          	add	a4,a0,a2
    src += n;
 29e:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 2a0:	fec059e3          	blez	a2,292 <memmove+0x2a>
 2a4:	fff6079b          	addiw	a5,a2,-1
 2a8:	1782                	slli	a5,a5,0x20
 2aa:	9381                	srli	a5,a5,0x20
 2ac:	fff7c793          	not	a5,a5
 2b0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b2:	15fd                	addi	a1,a1,-1
 2b4:	177d                	addi	a4,a4,-1
 2b6:	0005c683          	lbu	a3,0(a1)
 2ba:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2be:	fef71ae3          	bne	a4,a5,2b2 <memmove+0x4a>
 2c2:	bfc1                	j	292 <memmove+0x2a>

00000000000002c4 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2cc:	ca0d                	beqz	a2,2fe <memcmp+0x3a>
 2ce:	fff6069b          	addiw	a3,a2,-1
 2d2:	1682                	slli	a3,a3,0x20
 2d4:	9281                	srli	a3,a3,0x20
 2d6:	0685                	addi	a3,a3,1
 2d8:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	0005c703          	lbu	a4,0(a1)
 2e2:	00e79863          	bne	a5,a4,2f2 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 2e6:	0505                	addi	a0,a0,1
    p2++;
 2e8:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2ea:	fed518e3          	bne	a0,a3,2da <memcmp+0x16>
  }
  return 0;
 2ee:	4501                	li	a0,0
 2f0:	a019                	j	2f6 <memcmp+0x32>
      return *p1 - *p2;
 2f2:	40e7853b          	subw	a0,a5,a4
}
 2f6:	60a2                	ld	ra,8(sp)
 2f8:	6402                	ld	s0,0(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
  return 0;
 2fe:	4501                	li	a0,0
 300:	bfdd                	j	2f6 <memcmp+0x32>

0000000000000302 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 30a:	f5fff0ef          	jal	268 <memmove>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <strcat>:

char *strcat(char *dst, const char *src)
{
 316:	1141                	addi	sp,sp,-16
 318:	e406                	sd	ra,8(sp)
 31a:	e022                	sd	s0,0(sp)
 31c:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 31e:	00054783          	lbu	a5,0(a0)
 322:	c795                	beqz	a5,34e <strcat+0x38>
  char *p = dst;
 324:	87aa                	mv	a5,a0
    p++;
 326:	0785                	addi	a5,a5,1
  while (*p)
 328:	0007c703          	lbu	a4,0(a5)
 32c:	ff6d                	bnez	a4,326 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 32e:	0005c703          	lbu	a4,0(a1)
 332:	cb01                	beqz	a4,342 <strcat+0x2c>
  {
    *p = *src;
 334:	00e78023          	sb	a4,0(a5)
    p++;
 338:	0785                	addi	a5,a5,1
    src++;
 33a:	0585                	addi	a1,a1,1
  while (*src)
 33c:	0005c703          	lbu	a4,0(a1)
 340:	fb75                	bnez	a4,334 <strcat+0x1e>
  }

  *p = 0;
 342:	00078023          	sb	zero,0(a5)

  return dst;
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret
  char *p = dst;
 34e:	87aa                	mv	a5,a0
 350:	bff9                	j	32e <strcat+0x18>

0000000000000352 <isdir>:

int isdir(char *path)
{
 352:	7179                	addi	sp,sp,-48
 354:	f406                	sd	ra,40(sp)
 356:	f022                	sd	s0,32(sp)
 358:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 35a:	fd840593          	addi	a1,s0,-40
 35e:	e85ff0ef          	jal	1e2 <stat>
 362:	00054b63          	bltz	a0,378 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 366:	fe041503          	lh	a0,-32(s0)
 36a:	157d                	addi	a0,a0,-1
 36c:	00153513          	seqz	a0,a0
}
 370:	70a2                	ld	ra,40(sp)
 372:	7402                	ld	s0,32(sp)
 374:	6145                	addi	sp,sp,48
 376:	8082                	ret
    return 0;
 378:	4501                	li	a0,0
 37a:	bfdd                	j	370 <isdir+0x1e>

000000000000037c <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 37c:	7139                	addi	sp,sp,-64
 37e:	fc06                	sd	ra,56(sp)
 380:	f822                	sd	s0,48(sp)
 382:	f426                	sd	s1,40(sp)
 384:	f04a                	sd	s2,32(sp)
 386:	ec4e                	sd	s3,24(sp)
 388:	e852                	sd	s4,16(sp)
 38a:	e456                	sd	s5,8(sp)
 38c:	0080                	addi	s0,sp,64
 38e:	89aa                	mv	s3,a0
 390:	8aae                	mv	s5,a1
 392:	84b2                	mv	s1,a2
 394:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 396:	d4dff0ef          	jal	e2 <strlen>
 39a:	892a                	mv	s2,a0
  int nn = strlen(filename);
 39c:	8556                	mv	a0,s5
 39e:	d45ff0ef          	jal	e2 <strlen>
  int need = dn + 1 + nn + 1;
 3a2:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 3a6:	9fa9                	addw	a5,a5,a0
    return 0;
 3a8:	4501                	li	a0,0
  if (need > bufsize)
 3aa:	0347d763          	bge	a5,s4,3d8 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 3ae:	85ce                	mv	a1,s3
 3b0:	8526                	mv	a0,s1
 3b2:	ce1ff0ef          	jal	92 <strcpy>
  if (dir[dn - 1] != '/')
 3b6:	99ca                	add	s3,s3,s2
 3b8:	fff9c703          	lbu	a4,-1(s3)
 3bc:	02f00793          	li	a5,47
 3c0:	00f70763          	beq	a4,a5,3ce <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 3c4:	9926                	add	s2,s2,s1
 3c6:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 3ca:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 3ce:	85d6                	mv	a1,s5
 3d0:	8526                	mv	a0,s1
 3d2:	f45ff0ef          	jal	316 <strcat>
  return out_buffer;
 3d6:	8526                	mv	a0,s1
}
 3d8:	70e2                	ld	ra,56(sp)
 3da:	7442                	ld	s0,48(sp)
 3dc:	74a2                	ld	s1,40(sp)
 3de:	7902                	ld	s2,32(sp)
 3e0:	69e2                	ld	s3,24(sp)
 3e2:	6a42                	ld	s4,16(sp)
 3e4:	6aa2                	ld	s5,8(sp)
 3e6:	6121                	addi	sp,sp,64
 3e8:	8082                	ret

00000000000003ea <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ea:	4885                	li	a7,1
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3f2:	4889                	li	a7,2
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <wait>:
.global wait
wait:
 li a7, SYS_wait
 3fa:	488d                	li	a7,3
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 402:	4891                	li	a7,4
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <read>:
.global read
read:
 li a7, SYS_read
 40a:	4895                	li	a7,5
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <write>:
.global write
write:
 li a7, SYS_write
 412:	48c1                	li	a7,16
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <close>:
.global close
close:
 li a7, SYS_close
 41a:	48d5                	li	a7,21
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <kill>:
.global kill
kill:
 li a7, SYS_kill
 422:	4899                	li	a7,6
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <exec>:
.global exec
exec:
 li a7, SYS_exec
 42a:	489d                	li	a7,7
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <open>:
.global open
open:
 li a7, SYS_open
 432:	48bd                	li	a7,15
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 43a:	48c5                	li	a7,17
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 442:	48c9                	li	a7,18
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 44a:	48a1                	li	a7,8
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <link>:
.global link
link:
 li a7, SYS_link
 452:	48cd                	li	a7,19
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 45a:	48d1                	li	a7,20
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 462:	48a5                	li	a7,9
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <dup>:
.global dup
dup:
 li a7, SYS_dup
 46a:	48a9                	li	a7,10
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 472:	48ad                	li	a7,11
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 47a:	48b1                	li	a7,12
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 482:	48b5                	li	a7,13
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 48a:	48b9                	li	a7,14
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 492:	48d9                	li	a7,22
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 49a:	1101                	addi	sp,sp,-32
 49c:	ec06                	sd	ra,24(sp)
 49e:	e822                	sd	s0,16(sp)
 4a0:	1000                	addi	s0,sp,32
 4a2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4a6:	4605                	li	a2,1
 4a8:	fef40593          	addi	a1,s0,-17
 4ac:	f67ff0ef          	jal	412 <write>
}
 4b0:	60e2                	ld	ra,24(sp)
 4b2:	6442                	ld	s0,16(sp)
 4b4:	6105                	addi	sp,sp,32
 4b6:	8082                	ret

00000000000004b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b8:	7139                	addi	sp,sp,-64
 4ba:	fc06                	sd	ra,56(sp)
 4bc:	f822                	sd	s0,48(sp)
 4be:	f426                	sd	s1,40(sp)
 4c0:	f04a                	sd	s2,32(sp)
 4c2:	ec4e                	sd	s3,24(sp)
 4c4:	0080                	addi	s0,sp,64
 4c6:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4c8:	c299                	beqz	a3,4ce <printint+0x16>
 4ca:	0605ce63          	bltz	a1,546 <printint+0x8e>
  neg = 0;
 4ce:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4d0:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4d4:	869a                	mv	a3,t1
  i = 0;
 4d6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4d8:	00000817          	auipc	a6,0x0
 4dc:	56880813          	addi	a6,a6,1384 # a40 <digits>
 4e0:	88be                	mv	a7,a5
 4e2:	0017851b          	addiw	a0,a5,1
 4e6:	87aa                	mv	a5,a0
 4e8:	02c5f73b          	remuw	a4,a1,a2
 4ec:	1702                	slli	a4,a4,0x20
 4ee:	9301                	srli	a4,a4,0x20
 4f0:	9742                	add	a4,a4,a6
 4f2:	00074703          	lbu	a4,0(a4)
 4f6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4fa:	872e                	mv	a4,a1
 4fc:	02c5d5bb          	divuw	a1,a1,a2
 500:	0685                	addi	a3,a3,1
 502:	fcc77fe3          	bgeu	a4,a2,4e0 <printint+0x28>
  if(neg)
 506:	000e0c63          	beqz	t3,51e <printint+0x66>
    buf[i++] = '-';
 50a:	fd050793          	addi	a5,a0,-48
 50e:	00878533          	add	a0,a5,s0
 512:	02d00793          	li	a5,45
 516:	fef50823          	sb	a5,-16(a0)
 51a:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 51e:	fff7899b          	addiw	s3,a5,-1
 522:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 526:	fff4c583          	lbu	a1,-1(s1)
 52a:	854a                	mv	a0,s2
 52c:	f6fff0ef          	jal	49a <putc>
  while(--i >= 0)
 530:	39fd                	addiw	s3,s3,-1
 532:	14fd                	addi	s1,s1,-1
 534:	fe09d9e3          	bgez	s3,526 <printint+0x6e>
}
 538:	70e2                	ld	ra,56(sp)
 53a:	7442                	ld	s0,48(sp)
 53c:	74a2                	ld	s1,40(sp)
 53e:	7902                	ld	s2,32(sp)
 540:	69e2                	ld	s3,24(sp)
 542:	6121                	addi	sp,sp,64
 544:	8082                	ret
    x = -xx;
 546:	40b005bb          	negw	a1,a1
    neg = 1;
 54a:	4e05                	li	t3,1
    x = -xx;
 54c:	b751                	j	4d0 <printint+0x18>

000000000000054e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 54e:	711d                	addi	sp,sp,-96
 550:	ec86                	sd	ra,88(sp)
 552:	e8a2                	sd	s0,80(sp)
 554:	e4a6                	sd	s1,72(sp)
 556:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 558:	0005c483          	lbu	s1,0(a1)
 55c:	26048663          	beqz	s1,7c8 <vprintf+0x27a>
 560:	e0ca                	sd	s2,64(sp)
 562:	fc4e                	sd	s3,56(sp)
 564:	f852                	sd	s4,48(sp)
 566:	f456                	sd	s5,40(sp)
 568:	f05a                	sd	s6,32(sp)
 56a:	ec5e                	sd	s7,24(sp)
 56c:	e862                	sd	s8,16(sp)
 56e:	e466                	sd	s9,8(sp)
 570:	8b2a                	mv	s6,a0
 572:	8a2e                	mv	s4,a1
 574:	8bb2                	mv	s7,a2
  state = 0;
 576:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 578:	4901                	li	s2,0
 57a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 57c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 580:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 584:	06c00c93          	li	s9,108
 588:	a00d                	j	5aa <vprintf+0x5c>
        putc(fd, c0);
 58a:	85a6                	mv	a1,s1
 58c:	855a                	mv	a0,s6
 58e:	f0dff0ef          	jal	49a <putc>
 592:	a019                	j	598 <vprintf+0x4a>
    } else if(state == '%'){
 594:	03598363          	beq	s3,s5,5ba <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 598:	0019079b          	addiw	a5,s2,1
 59c:	893e                	mv	s2,a5
 59e:	873e                	mv	a4,a5
 5a0:	97d2                	add	a5,a5,s4
 5a2:	0007c483          	lbu	s1,0(a5)
 5a6:	20048963          	beqz	s1,7b8 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 5aa:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5ae:	fe0993e3          	bnez	s3,594 <vprintf+0x46>
      if(c0 == '%'){
 5b2:	fd579ce3          	bne	a5,s5,58a <vprintf+0x3c>
        state = '%';
 5b6:	89be                	mv	s3,a5
 5b8:	b7c5                	j	598 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5ba:	00ea06b3          	add	a3,s4,a4
 5be:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5c2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5c4:	c681                	beqz	a3,5cc <vprintf+0x7e>
 5c6:	9752                	add	a4,a4,s4
 5c8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5cc:	03878e63          	beq	a5,s8,608 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 5d0:	05978863          	beq	a5,s9,620 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5d4:	07500713          	li	a4,117
 5d8:	0ee78263          	beq	a5,a4,6bc <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5dc:	07800713          	li	a4,120
 5e0:	12e78463          	beq	a5,a4,708 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5e4:	07000713          	li	a4,112
 5e8:	14e78963          	beq	a5,a4,73a <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5ec:	07300713          	li	a4,115
 5f0:	18e78863          	beq	a5,a4,780 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5f4:	02500713          	li	a4,37
 5f8:	04e79463          	bne	a5,a4,640 <vprintf+0xf2>
        putc(fd, '%');
 5fc:	85ba                	mv	a1,a4
 5fe:	855a                	mv	a0,s6
 600:	e9bff0ef          	jal	49a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 604:	4981                	li	s3,0
 606:	bf49                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 608:	008b8493          	addi	s1,s7,8
 60c:	4685                	li	a3,1
 60e:	4629                	li	a2,10
 610:	000ba583          	lw	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	ea3ff0ef          	jal	4b8 <printint>
 61a:	8ba6                	mv	s7,s1
      state = 0;
 61c:	4981                	li	s3,0
 61e:	bfad                	j	598 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 620:	06400793          	li	a5,100
 624:	02f68963          	beq	a3,a5,656 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 628:	06c00793          	li	a5,108
 62c:	04f68263          	beq	a3,a5,670 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 630:	07500793          	li	a5,117
 634:	0af68063          	beq	a3,a5,6d4 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 638:	07800793          	li	a5,120
 63c:	0ef68263          	beq	a3,a5,720 <vprintf+0x1d2>
        putc(fd, '%');
 640:	02500593          	li	a1,37
 644:	855a                	mv	a0,s6
 646:	e55ff0ef          	jal	49a <putc>
        putc(fd, c0);
 64a:	85a6                	mv	a1,s1
 64c:	855a                	mv	a0,s6
 64e:	e4dff0ef          	jal	49a <putc>
      state = 0;
 652:	4981                	li	s3,0
 654:	b791                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 656:	008b8493          	addi	s1,s7,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000ba583          	lw	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	e55ff0ef          	jal	4b8 <printint>
        i += 1;
 668:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 66a:	8ba6                	mv	s7,s1
      state = 0;
 66c:	4981                	li	s3,0
        i += 1;
 66e:	b72d                	j	598 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 670:	06400793          	li	a5,100
 674:	02f60763          	beq	a2,a5,6a2 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 678:	07500793          	li	a5,117
 67c:	06f60963          	beq	a2,a5,6ee <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 680:	07800793          	li	a5,120
 684:	faf61ee3          	bne	a2,a5,640 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 688:	008b8493          	addi	s1,s7,8
 68c:	4681                	li	a3,0
 68e:	4641                	li	a2,16
 690:	000ba583          	lw	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	e23ff0ef          	jal	4b8 <printint>
        i += 2;
 69a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 69c:	8ba6                	mv	s7,s1
      state = 0;
 69e:	4981                	li	s3,0
        i += 2;
 6a0:	bde5                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	4685                	li	a3,1
 6a8:	4629                	li	a2,10
 6aa:	000ba583          	lw	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	e09ff0ef          	jal	4b8 <printint>
        i += 2;
 6b4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b6:	8ba6                	mv	s7,s1
      state = 0;
 6b8:	4981                	li	s3,0
        i += 2;
 6ba:	bdf9                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 6bc:	008b8493          	addi	s1,s7,8
 6c0:	4681                	li	a3,0
 6c2:	4629                	li	a2,10
 6c4:	000ba583          	lw	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	defff0ef          	jal	4b8 <printint>
 6ce:	8ba6                	mv	s7,s1
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	b5d9                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b8493          	addi	s1,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000ba583          	lw	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	dd7ff0ef          	jal	4b8 <printint>
        i += 1;
 6e6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e8:	8ba6                	mv	s7,s1
      state = 0;
 6ea:	4981                	li	s3,0
        i += 1;
 6ec:	b575                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ee:	008b8493          	addi	s1,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4629                	li	a2,10
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	dbdff0ef          	jal	4b8 <printint>
        i += 2;
 700:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 702:	8ba6                	mv	s7,s1
      state = 0;
 704:	4981                	li	s3,0
        i += 2;
 706:	bd49                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 708:	008b8493          	addi	s1,s7,8
 70c:	4681                	li	a3,0
 70e:	4641                	li	a2,16
 710:	000ba583          	lw	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	da3ff0ef          	jal	4b8 <printint>
 71a:	8ba6                	mv	s7,s1
      state = 0;
 71c:	4981                	li	s3,0
 71e:	bdad                	j	598 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 720:	008b8493          	addi	s1,s7,8
 724:	4681                	li	a3,0
 726:	4641                	li	a2,16
 728:	000ba583          	lw	a1,0(s7)
 72c:	855a                	mv	a0,s6
 72e:	d8bff0ef          	jal	4b8 <printint>
        i += 1;
 732:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 734:	8ba6                	mv	s7,s1
      state = 0;
 736:	4981                	li	s3,0
        i += 1;
 738:	b585                	j	598 <vprintf+0x4a>
 73a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 73c:	008b8d13          	addi	s10,s7,8
 740:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 744:	03000593          	li	a1,48
 748:	855a                	mv	a0,s6
 74a:	d51ff0ef          	jal	49a <putc>
  putc(fd, 'x');
 74e:	07800593          	li	a1,120
 752:	855a                	mv	a0,s6
 754:	d47ff0ef          	jal	49a <putc>
 758:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75a:	00000b97          	auipc	s7,0x0
 75e:	2e6b8b93          	addi	s7,s7,742 # a40 <digits>
 762:	03c9d793          	srli	a5,s3,0x3c
 766:	97de                	add	a5,a5,s7
 768:	0007c583          	lbu	a1,0(a5)
 76c:	855a                	mv	a0,s6
 76e:	d2dff0ef          	jal	49a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 772:	0992                	slli	s3,s3,0x4
 774:	34fd                	addiw	s1,s1,-1
 776:	f4f5                	bnez	s1,762 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 778:	8bea                	mv	s7,s10
      state = 0;
 77a:	4981                	li	s3,0
 77c:	6d02                	ld	s10,0(sp)
 77e:	bd29                	j	598 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 780:	008b8993          	addi	s3,s7,8
 784:	000bb483          	ld	s1,0(s7)
 788:	cc91                	beqz	s1,7a4 <vprintf+0x256>
        for(; *s; s++)
 78a:	0004c583          	lbu	a1,0(s1)
 78e:	c195                	beqz	a1,7b2 <vprintf+0x264>
          putc(fd, *s);
 790:	855a                	mv	a0,s6
 792:	d09ff0ef          	jal	49a <putc>
        for(; *s; s++)
 796:	0485                	addi	s1,s1,1
 798:	0004c583          	lbu	a1,0(s1)
 79c:	f9f5                	bnez	a1,790 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 79e:	8bce                	mv	s7,s3
      state = 0;
 7a0:	4981                	li	s3,0
 7a2:	bbdd                	j	598 <vprintf+0x4a>
          s = "(null)";
 7a4:	00000497          	auipc	s1,0x0
 7a8:	29448493          	addi	s1,s1,660 # a38 <malloc+0x184>
        for(; *s; s++)
 7ac:	02800593          	li	a1,40
 7b0:	b7c5                	j	790 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 7b2:	8bce                	mv	s7,s3
      state = 0;
 7b4:	4981                	li	s3,0
 7b6:	b3cd                	j	598 <vprintf+0x4a>
 7b8:	6906                	ld	s2,64(sp)
 7ba:	79e2                	ld	s3,56(sp)
 7bc:	7a42                	ld	s4,48(sp)
 7be:	7aa2                	ld	s5,40(sp)
 7c0:	7b02                	ld	s6,32(sp)
 7c2:	6be2                	ld	s7,24(sp)
 7c4:	6c42                	ld	s8,16(sp)
 7c6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7c8:	60e6                	ld	ra,88(sp)
 7ca:	6446                	ld	s0,80(sp)
 7cc:	64a6                	ld	s1,72(sp)
 7ce:	6125                	addi	sp,sp,96
 7d0:	8082                	ret

00000000000007d2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7d2:	715d                	addi	sp,sp,-80
 7d4:	ec06                	sd	ra,24(sp)
 7d6:	e822                	sd	s0,16(sp)
 7d8:	1000                	addi	s0,sp,32
 7da:	e010                	sd	a2,0(s0)
 7dc:	e414                	sd	a3,8(s0)
 7de:	e818                	sd	a4,16(s0)
 7e0:	ec1c                	sd	a5,24(s0)
 7e2:	03043023          	sd	a6,32(s0)
 7e6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ea:	8622                	mv	a2,s0
 7ec:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7f0:	d5fff0ef          	jal	54e <vprintf>
}
 7f4:	60e2                	ld	ra,24(sp)
 7f6:	6442                	ld	s0,16(sp)
 7f8:	6161                	addi	sp,sp,80
 7fa:	8082                	ret

00000000000007fc <printf>:

void
printf(const char *fmt, ...)
{
 7fc:	711d                	addi	sp,sp,-96
 7fe:	ec06                	sd	ra,24(sp)
 800:	e822                	sd	s0,16(sp)
 802:	1000                	addi	s0,sp,32
 804:	e40c                	sd	a1,8(s0)
 806:	e810                	sd	a2,16(s0)
 808:	ec14                	sd	a3,24(s0)
 80a:	f018                	sd	a4,32(s0)
 80c:	f41c                	sd	a5,40(s0)
 80e:	03043823          	sd	a6,48(s0)
 812:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 816:	00840613          	addi	a2,s0,8
 81a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 81e:	85aa                	mv	a1,a0
 820:	4505                	li	a0,1
 822:	d2dff0ef          	jal	54e <vprintf>
}
 826:	60e2                	ld	ra,24(sp)
 828:	6442                	ld	s0,16(sp)
 82a:	6125                	addi	sp,sp,96
 82c:	8082                	ret

000000000000082e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82e:	1141                	addi	sp,sp,-16
 830:	e406                	sd	ra,8(sp)
 832:	e022                	sd	s0,0(sp)
 834:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 836:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 83a:	00000797          	auipc	a5,0x0
 83e:	7c67b783          	ld	a5,1990(a5) # 1000 <freep>
 842:	a02d                	j	86c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 844:	4618                	lw	a4,8(a2)
 846:	9f2d                	addw	a4,a4,a1
 848:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 84c:	6398                	ld	a4,0(a5)
 84e:	6310                	ld	a2,0(a4)
 850:	a83d                	j	88e <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 852:	ff852703          	lw	a4,-8(a0)
 856:	9f31                	addw	a4,a4,a2
 858:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 85a:	ff053683          	ld	a3,-16(a0)
 85e:	a091                	j	8a2 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 860:	6398                	ld	a4,0(a5)
 862:	00e7e463          	bltu	a5,a4,86a <free+0x3c>
 866:	00e6ea63          	bltu	a3,a4,87a <free+0x4c>
{
 86a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86c:	fed7fae3          	bgeu	a5,a3,860 <free+0x32>
 870:	6398                	ld	a4,0(a5)
 872:	00e6e463          	bltu	a3,a4,87a <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 876:	fee7eae3          	bltu	a5,a4,86a <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 87a:	ff852583          	lw	a1,-8(a0)
 87e:	6390                	ld	a2,0(a5)
 880:	02059813          	slli	a6,a1,0x20
 884:	01c85713          	srli	a4,a6,0x1c
 888:	9736                	add	a4,a4,a3
 88a:	fae60de3          	beq	a2,a4,844 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 88e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 892:	4790                	lw	a2,8(a5)
 894:	02061593          	slli	a1,a2,0x20
 898:	01c5d713          	srli	a4,a1,0x1c
 89c:	973e                	add	a4,a4,a5
 89e:	fae68ae3          	beq	a3,a4,852 <free+0x24>
    p->s.ptr = bp->s.ptr;
 8a2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8a4:	00000717          	auipc	a4,0x0
 8a8:	74f73e23          	sd	a5,1884(a4) # 1000 <freep>
}
 8ac:	60a2                	ld	ra,8(sp)
 8ae:	6402                	ld	s0,0(sp)
 8b0:	0141                	addi	sp,sp,16
 8b2:	8082                	ret

00000000000008b4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b4:	7139                	addi	sp,sp,-64
 8b6:	fc06                	sd	ra,56(sp)
 8b8:	f822                	sd	s0,48(sp)
 8ba:	f04a                	sd	s2,32(sp)
 8bc:	ec4e                	sd	s3,24(sp)
 8be:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c0:	02051993          	slli	s3,a0,0x20
 8c4:	0209d993          	srli	s3,s3,0x20
 8c8:	09bd                	addi	s3,s3,15
 8ca:	0049d993          	srli	s3,s3,0x4
 8ce:	2985                	addiw	s3,s3,1
 8d0:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8d2:	00000517          	auipc	a0,0x0
 8d6:	72e53503          	ld	a0,1838(a0) # 1000 <freep>
 8da:	c905                	beqz	a0,90a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8dc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8de:	4798                	lw	a4,8(a5)
 8e0:	09377663          	bgeu	a4,s3,96c <malloc+0xb8>
 8e4:	f426                	sd	s1,40(sp)
 8e6:	e852                	sd	s4,16(sp)
 8e8:	e456                	sd	s5,8(sp)
 8ea:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ec:	8a4e                	mv	s4,s3
 8ee:	6705                	lui	a4,0x1
 8f0:	00e9f363          	bgeu	s3,a4,8f6 <malloc+0x42>
 8f4:	6a05                	lui	s4,0x1
 8f6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8fa:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8fe:	00000497          	auipc	s1,0x0
 902:	70248493          	addi	s1,s1,1794 # 1000 <freep>
  if(p == (char*)-1)
 906:	5afd                	li	s5,-1
 908:	a83d                	j	946 <malloc+0x92>
 90a:	f426                	sd	s1,40(sp)
 90c:	e852                	sd	s4,16(sp)
 90e:	e456                	sd	s5,8(sp)
 910:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 912:	00000797          	auipc	a5,0x0
 916:	6fe78793          	addi	a5,a5,1790 # 1010 <base>
 91a:	00000717          	auipc	a4,0x0
 91e:	6ef73323          	sd	a5,1766(a4) # 1000 <freep>
 922:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 924:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 928:	b7d1                	j	8ec <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 92a:	6398                	ld	a4,0(a5)
 92c:	e118                	sd	a4,0(a0)
 92e:	a899                	j	984 <malloc+0xd0>
  hp->s.size = nu;
 930:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 934:	0541                	addi	a0,a0,16
 936:	ef9ff0ef          	jal	82e <free>
  return freep;
 93a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 93c:	c125                	beqz	a0,99c <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 940:	4798                	lw	a4,8(a5)
 942:	03277163          	bgeu	a4,s2,964 <malloc+0xb0>
    if(p == freep)
 946:	6098                	ld	a4,0(s1)
 948:	853e                	mv	a0,a5
 94a:	fef71ae3          	bne	a4,a5,93e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 94e:	8552                	mv	a0,s4
 950:	b2bff0ef          	jal	47a <sbrk>
  if(p == (char*)-1)
 954:	fd551ee3          	bne	a0,s5,930 <malloc+0x7c>
        return 0;
 958:	4501                	li	a0,0
 95a:	74a2                	ld	s1,40(sp)
 95c:	6a42                	ld	s4,16(sp)
 95e:	6aa2                	ld	s5,8(sp)
 960:	6b02                	ld	s6,0(sp)
 962:	a03d                	j	990 <malloc+0xdc>
 964:	74a2                	ld	s1,40(sp)
 966:	6a42                	ld	s4,16(sp)
 968:	6aa2                	ld	s5,8(sp)
 96a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 96c:	fae90fe3          	beq	s2,a4,92a <malloc+0x76>
        p->s.size -= nunits;
 970:	4137073b          	subw	a4,a4,s3
 974:	c798                	sw	a4,8(a5)
        p += p->s.size;
 976:	02071693          	slli	a3,a4,0x20
 97a:	01c6d713          	srli	a4,a3,0x1c
 97e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 980:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 984:	00000717          	auipc	a4,0x0
 988:	66a73e23          	sd	a0,1660(a4) # 1000 <freep>
      return (void*)(p + 1);
 98c:	01078513          	addi	a0,a5,16
  }
}
 990:	70e2                	ld	ra,56(sp)
 992:	7442                	ld	s0,48(sp)
 994:	7902                	ld	s2,32(sp)
 996:	69e2                	ld	s3,24(sp)
 998:	6121                	addi	sp,sp,64
 99a:	8082                	ret
 99c:	74a2                	ld	s1,40(sp)
 99e:	6a42                	ld	s4,16(sp)
 9a0:	6aa2                	ld	s5,8(sp)
 9a2:	6b02                	ld	s6,0(sp)
 9a4:	b7f5                	j	990 <malloc+0xdc>
