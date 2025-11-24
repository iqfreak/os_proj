
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
  66:	87e50513          	addi	a0,a0,-1922 # 8e0 <malloc+0xf6>
  6a:	6c8000ef          	jal	732 <printf>
        exit(1);
  6e:	4505                	li	a0,1
  70:	2b8000ef          	jal	328 <exit>
  int sum = 0;
  74:	4a01                	li	s4,0
  }
  printf("%d\n", sum);
  76:	85d2                	mv	a1,s4
  78:	00001517          	auipc	a0,0x1
  7c:	89050513          	addi	a0,a0,-1904 # 908 <malloc+0x11e>
  80:	6b2000ef          	jal	732 <printf>
  exit(0);
  84:	4501                	li	a0,0
  86:	2a2000ef          	jal	328 <exit>

000000000000008a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
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
  98:	290000ef          	jal	328 <exit>

000000000000009c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9c:	1141                	addi	sp,sp,-16
  9e:	e406                	sd	ra,8(sp)
  a0:	e022                	sd	s0,0(sp)
  a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
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

int
strcmp(const char *p, const char *q)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	cb91                	beqz	a5,dc <strcmp+0x20>
  ca:	0005c703          	lbu	a4,0(a1)
  ce:	00f71763          	bne	a4,a5,dc <strcmp+0x20>
    p++, q++;
  d2:	0505                	addi	a0,a0,1
  d4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
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

uint
strlen(const char *s)
{
  ec:	1141                	addi	sp,sp,-16
  ee:	e406                	sd	ra,8(sp)
  f0:	e022                	sd	s0,0(sp)
  f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
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
  for(n = 0; s[n]; n++)
 116:	4501                	li	a0,0
 118:	bfdd                	j	10e <strlen+0x22>

000000000000011a <memset>:

void*
memset(void *dst, int c, uint n)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 122:	ca19                	beqz	a2,138 <memset+0x1e>
 124:	87aa                	mv	a5,a0
 126:	1602                	slli	a2,a2,0x20
 128:	9201                	srli	a2,a2,0x20
 12a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
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

char*
strchr(const char *s, char c)
{
 140:	1141                	addi	sp,sp,-16
 142:	e406                	sd	ra,8(sp)
 144:	e022                	sd	s0,0(sp)
 146:	0800                	addi	s0,sp,16
  for(; *s; s++)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cf81                	beqz	a5,164 <strchr+0x24>
    if(*s == c)
 14e:	00f58763          	beq	a1,a5,15c <strchr+0x1c>
  for(; *s; s++)
 152:	0505                	addi	a0,a0,1
 154:	00054783          	lbu	a5,0(a0)
 158:	fbfd                	bnez	a5,14e <strchr+0xe>
      return (char*)s;
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

char*
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

  for(i=0; i+1 < max; ){
 188:	892a                	mv	s2,a0
 18a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 18c:	f9f40b13          	addi	s6,s0,-97
 190:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 192:	4ba9                	li	s7,10
 194:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 196:	8d26                	mv	s10,s1
 198:	0014899b          	addiw	s3,s1,1
 19c:	84ce                	mv	s1,s3
 19e:	0349d563          	bge	s3,s4,1c8 <gets+0x60>
    cc = read(0, &c, 1);
 1a2:	8656                	mv	a2,s5
 1a4:	85da                	mv	a1,s6
 1a6:	4501                	li	a0,0
 1a8:	198000ef          	jal	340 <read>
    if(cc < 1)
 1ac:	00a05e63          	blez	a0,1c8 <gets+0x60>
    buf[i++] = c;
 1b0:	f9f44783          	lbu	a5,-97(s0)
 1b4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
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

int
stat(const char *n, struct stat *st)
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
 1fa:	16e000ef          	jal	368 <open>
  if(fd < 0)
 1fe:	02054263          	bltz	a0,222 <stat+0x36>
 202:	e426                	sd	s1,8(sp)
 204:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 206:	85ca                	mv	a1,s2
 208:	178000ef          	jal	380 <fstat>
 20c:	892a                	mv	s2,a0
  close(fd);
 20e:	8526                	mv	a0,s1
 210:	140000ef          	jal	350 <close>
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

int
atoi(const char *s)
{
 226:	1141                	addi	sp,sp,-16
 228:	e406                	sd	ra,8(sp)
 22a:	e022                	sd	s0,0(sp)
 22c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22e:	00054683          	lbu	a3,0(a0)
 232:	fd06879b          	addiw	a5,a3,-48
 236:	0ff7f793          	zext.b	a5,a5
 23a:	4625                	li	a2,9
 23c:	02f66963          	bltu	a2,a5,26e <atoi+0x48>
 240:	872a                	mv	a4,a0
  n = 0;
 242:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 244:	0705                	addi	a4,a4,1
 246:	0025179b          	slliw	a5,a0,0x2
 24a:	9fa9                	addw	a5,a5,a0
 24c:	0017979b          	slliw	a5,a5,0x1
 250:	9fb5                	addw	a5,a5,a3
 252:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
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

void*
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
  if (src > dst) {
 27a:	02b57563          	bgeu	a0,a1,2a4 <memmove+0x32>
    while(n-- > 0)
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
    while(n-- > 0)
 298:	fee79ae3          	bne	a5,a4,28c <memmove+0x1a>
    src += n;
    while(n-- > 0)
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
    while(n-- > 0)
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
    while(n-- > 0)
 2c8:	fef71ae3          	bne	a4,a5,2bc <memmove+0x4a>
 2cc:	bfc1                	j	29c <memmove+0x2a>

00000000000002ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d6:	ca0d                	beqz	a2,308 <memcmp+0x3a>
 2d8:	fff6069b          	addiw	a3,a2,-1
 2dc:	1682                	slli	a3,a3,0x20
 2de:	9281                	srli	a3,a3,0x20
 2e0:	0685                	addi	a3,a3,1
 2e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e4:	00054783          	lbu	a5,0(a0)
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	00e79863          	bne	a5,a4,2fc <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2f0:	0505                	addi	a0,a0,1
    p2++;
 2f2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
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

0000000000000320 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 320:	4885                	li	a7,1
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <exit>:
.global exit
exit:
 li a7, SYS_exit
 328:	4889                	li	a7,2
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <wait>:
.global wait
wait:
 li a7, SYS_wait
 330:	488d                	li	a7,3
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 338:	4891                	li	a7,4
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <read>:
.global read
read:
 li a7, SYS_read
 340:	4895                	li	a7,5
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <write>:
.global write
write:
 li a7, SYS_write
 348:	48c1                	li	a7,16
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <close>:
.global close
close:
 li a7, SYS_close
 350:	48d5                	li	a7,21
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <kill>:
.global kill
kill:
 li a7, SYS_kill
 358:	4899                	li	a7,6
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <exec>:
.global exec
exec:
 li a7, SYS_exec
 360:	489d                	li	a7,7
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <open>:
.global open
open:
 li a7, SYS_open
 368:	48bd                	li	a7,15
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 370:	48c5                	li	a7,17
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 378:	48c9                	li	a7,18
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 380:	48a1                	li	a7,8
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <link>:
.global link
link:
 li a7, SYS_link
 388:	48cd                	li	a7,19
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 390:	48d1                	li	a7,20
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 398:	48a5                	li	a7,9
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3a0:	48a9                	li	a7,10
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a8:	48ad                	li	a7,11
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3b0:	48b1                	li	a7,12
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b8:	48b5                	li	a7,13
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3c0:	48b9                	li	a7,14
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 3c8:	48d9                	li	a7,22
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3d0:	1101                	addi	sp,sp,-32
 3d2:	ec06                	sd	ra,24(sp)
 3d4:	e822                	sd	s0,16(sp)
 3d6:	1000                	addi	s0,sp,32
 3d8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3dc:	4605                	li	a2,1
 3de:	fef40593          	addi	a1,s0,-17
 3e2:	f67ff0ef          	jal	348 <write>
}
 3e6:	60e2                	ld	ra,24(sp)
 3e8:	6442                	ld	s0,16(sp)
 3ea:	6105                	addi	sp,sp,32
 3ec:	8082                	ret

00000000000003ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ee:	7139                	addi	sp,sp,-64
 3f0:	fc06                	sd	ra,56(sp)
 3f2:	f822                	sd	s0,48(sp)
 3f4:	f426                	sd	s1,40(sp)
 3f6:	f04a                	sd	s2,32(sp)
 3f8:	ec4e                	sd	s3,24(sp)
 3fa:	0080                	addi	s0,sp,64
 3fc:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fe:	c299                	beqz	a3,404 <printint+0x16>
 400:	0605ce63          	bltz	a1,47c <printint+0x8e>
  neg = 0;
 404:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 406:	fc040313          	addi	t1,s0,-64
  neg = 0;
 40a:	869a                	mv	a3,t1
  i = 0;
 40c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 40e:	00000817          	auipc	a6,0x0
 412:	50a80813          	addi	a6,a6,1290 # 918 <digits>
 416:	88be                	mv	a7,a5
 418:	0017851b          	addiw	a0,a5,1
 41c:	87aa                	mv	a5,a0
 41e:	02c5f73b          	remuw	a4,a1,a2
 422:	1702                	slli	a4,a4,0x20
 424:	9301                	srli	a4,a4,0x20
 426:	9742                	add	a4,a4,a6
 428:	00074703          	lbu	a4,0(a4)
 42c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 430:	872e                	mv	a4,a1
 432:	02c5d5bb          	divuw	a1,a1,a2
 436:	0685                	addi	a3,a3,1
 438:	fcc77fe3          	bgeu	a4,a2,416 <printint+0x28>
  if(neg)
 43c:	000e0c63          	beqz	t3,454 <printint+0x66>
    buf[i++] = '-';
 440:	fd050793          	addi	a5,a0,-48
 444:	00878533          	add	a0,a5,s0
 448:	02d00793          	li	a5,45
 44c:	fef50823          	sb	a5,-16(a0)
 450:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 454:	fff7899b          	addiw	s3,a5,-1
 458:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 45c:	fff4c583          	lbu	a1,-1(s1)
 460:	854a                	mv	a0,s2
 462:	f6fff0ef          	jal	3d0 <putc>
  while(--i >= 0)
 466:	39fd                	addiw	s3,s3,-1
 468:	14fd                	addi	s1,s1,-1
 46a:	fe09d9e3          	bgez	s3,45c <printint+0x6e>
}
 46e:	70e2                	ld	ra,56(sp)
 470:	7442                	ld	s0,48(sp)
 472:	74a2                	ld	s1,40(sp)
 474:	7902                	ld	s2,32(sp)
 476:	69e2                	ld	s3,24(sp)
 478:	6121                	addi	sp,sp,64
 47a:	8082                	ret
    x = -xx;
 47c:	40b005bb          	negw	a1,a1
    neg = 1;
 480:	4e05                	li	t3,1
    x = -xx;
 482:	b751                	j	406 <printint+0x18>

0000000000000484 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 484:	711d                	addi	sp,sp,-96
 486:	ec86                	sd	ra,88(sp)
 488:	e8a2                	sd	s0,80(sp)
 48a:	e4a6                	sd	s1,72(sp)
 48c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 48e:	0005c483          	lbu	s1,0(a1)
 492:	26048663          	beqz	s1,6fe <vprintf+0x27a>
 496:	e0ca                	sd	s2,64(sp)
 498:	fc4e                	sd	s3,56(sp)
 49a:	f852                	sd	s4,48(sp)
 49c:	f456                	sd	s5,40(sp)
 49e:	f05a                	sd	s6,32(sp)
 4a0:	ec5e                	sd	s7,24(sp)
 4a2:	e862                	sd	s8,16(sp)
 4a4:	e466                	sd	s9,8(sp)
 4a6:	8b2a                	mv	s6,a0
 4a8:	8a2e                	mv	s4,a1
 4aa:	8bb2                	mv	s7,a2
  state = 0;
 4ac:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4ae:	4901                	li	s2,0
 4b0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4b2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4b6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4ba:	06c00c93          	li	s9,108
 4be:	a00d                	j	4e0 <vprintf+0x5c>
        putc(fd, c0);
 4c0:	85a6                	mv	a1,s1
 4c2:	855a                	mv	a0,s6
 4c4:	f0dff0ef          	jal	3d0 <putc>
 4c8:	a019                	j	4ce <vprintf+0x4a>
    } else if(state == '%'){
 4ca:	03598363          	beq	s3,s5,4f0 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 4ce:	0019079b          	addiw	a5,s2,1
 4d2:	893e                	mv	s2,a5
 4d4:	873e                	mv	a4,a5
 4d6:	97d2                	add	a5,a5,s4
 4d8:	0007c483          	lbu	s1,0(a5)
 4dc:	20048963          	beqz	s1,6ee <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 4e0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4e4:	fe0993e3          	bnez	s3,4ca <vprintf+0x46>
      if(c0 == '%'){
 4e8:	fd579ce3          	bne	a5,s5,4c0 <vprintf+0x3c>
        state = '%';
 4ec:	89be                	mv	s3,a5
 4ee:	b7c5                	j	4ce <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4f0:	00ea06b3          	add	a3,s4,a4
 4f4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4f8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4fa:	c681                	beqz	a3,502 <vprintf+0x7e>
 4fc:	9752                	add	a4,a4,s4
 4fe:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 502:	03878e63          	beq	a5,s8,53e <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 506:	05978863          	beq	a5,s9,556 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 50a:	07500713          	li	a4,117
 50e:	0ee78263          	beq	a5,a4,5f2 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 512:	07800713          	li	a4,120
 516:	12e78463          	beq	a5,a4,63e <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 51a:	07000713          	li	a4,112
 51e:	14e78963          	beq	a5,a4,670 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 522:	07300713          	li	a4,115
 526:	18e78863          	beq	a5,a4,6b6 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 52a:	02500713          	li	a4,37
 52e:	04e79463          	bne	a5,a4,576 <vprintf+0xf2>
        putc(fd, '%');
 532:	85ba                	mv	a1,a4
 534:	855a                	mv	a0,s6
 536:	e9bff0ef          	jal	3d0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 53a:	4981                	li	s3,0
 53c:	bf49                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 53e:	008b8493          	addi	s1,s7,8
 542:	4685                	li	a3,1
 544:	4629                	li	a2,10
 546:	000ba583          	lw	a1,0(s7)
 54a:	855a                	mv	a0,s6
 54c:	ea3ff0ef          	jal	3ee <printint>
 550:	8ba6                	mv	s7,s1
      state = 0;
 552:	4981                	li	s3,0
 554:	bfad                	j	4ce <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 556:	06400793          	li	a5,100
 55a:	02f68963          	beq	a3,a5,58c <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 55e:	06c00793          	li	a5,108
 562:	04f68263          	beq	a3,a5,5a6 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 566:	07500793          	li	a5,117
 56a:	0af68063          	beq	a3,a5,60a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 56e:	07800793          	li	a5,120
 572:	0ef68263          	beq	a3,a5,656 <vprintf+0x1d2>
        putc(fd, '%');
 576:	02500593          	li	a1,37
 57a:	855a                	mv	a0,s6
 57c:	e55ff0ef          	jal	3d0 <putc>
        putc(fd, c0);
 580:	85a6                	mv	a1,s1
 582:	855a                	mv	a0,s6
 584:	e4dff0ef          	jal	3d0 <putc>
      state = 0;
 588:	4981                	li	s3,0
 58a:	b791                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 58c:	008b8493          	addi	s1,s7,8
 590:	4685                	li	a3,1
 592:	4629                	li	a2,10
 594:	000ba583          	lw	a1,0(s7)
 598:	855a                	mv	a0,s6
 59a:	e55ff0ef          	jal	3ee <printint>
        i += 1;
 59e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a0:	8ba6                	mv	s7,s1
      state = 0;
 5a2:	4981                	li	s3,0
        i += 1;
 5a4:	b72d                	j	4ce <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5a6:	06400793          	li	a5,100
 5aa:	02f60763          	beq	a2,a5,5d8 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5ae:	07500793          	li	a5,117
 5b2:	06f60963          	beq	a2,a5,624 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5b6:	07800793          	li	a5,120
 5ba:	faf61ee3          	bne	a2,a5,576 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5be:	008b8493          	addi	s1,s7,8
 5c2:	4681                	li	a3,0
 5c4:	4641                	li	a2,16
 5c6:	000ba583          	lw	a1,0(s7)
 5ca:	855a                	mv	a0,s6
 5cc:	e23ff0ef          	jal	3ee <printint>
        i += 2;
 5d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5d2:	8ba6                	mv	s7,s1
      state = 0;
 5d4:	4981                	li	s3,0
        i += 2;
 5d6:	bde5                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d8:	008b8493          	addi	s1,s7,8
 5dc:	4685                	li	a3,1
 5de:	4629                	li	a2,10
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	e09ff0ef          	jal	3ee <printint>
        i += 2;
 5ea:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ec:	8ba6                	mv	s7,s1
      state = 0;
 5ee:	4981                	li	s3,0
        i += 2;
 5f0:	bdf9                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5f2:	008b8493          	addi	s1,s7,8
 5f6:	4681                	li	a3,0
 5f8:	4629                	li	a2,10
 5fa:	000ba583          	lw	a1,0(s7)
 5fe:	855a                	mv	a0,s6
 600:	defff0ef          	jal	3ee <printint>
 604:	8ba6                	mv	s7,s1
      state = 0;
 606:	4981                	li	s3,0
 608:	b5d9                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60a:	008b8493          	addi	s1,s7,8
 60e:	4681                	li	a3,0
 610:	4629                	li	a2,10
 612:	000ba583          	lw	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	dd7ff0ef          	jal	3ee <printint>
        i += 1;
 61c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 61e:	8ba6                	mv	s7,s1
      state = 0;
 620:	4981                	li	s3,0
        i += 1;
 622:	b575                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 624:	008b8493          	addi	s1,s7,8
 628:	4681                	li	a3,0
 62a:	4629                	li	a2,10
 62c:	000ba583          	lw	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	dbdff0ef          	jal	3ee <printint>
        i += 2;
 636:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 638:	8ba6                	mv	s7,s1
      state = 0;
 63a:	4981                	li	s3,0
        i += 2;
 63c:	bd49                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 63e:	008b8493          	addi	s1,s7,8
 642:	4681                	li	a3,0
 644:	4641                	li	a2,16
 646:	000ba583          	lw	a1,0(s7)
 64a:	855a                	mv	a0,s6
 64c:	da3ff0ef          	jal	3ee <printint>
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
 654:	bdad                	j	4ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 656:	008b8493          	addi	s1,s7,8
 65a:	4681                	li	a3,0
 65c:	4641                	li	a2,16
 65e:	000ba583          	lw	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	d8bff0ef          	jal	3ee <printint>
        i += 1;
 668:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 66a:	8ba6                	mv	s7,s1
      state = 0;
 66c:	4981                	li	s3,0
        i += 1;
 66e:	b585                	j	4ce <vprintf+0x4a>
 670:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 672:	008b8d13          	addi	s10,s7,8
 676:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 67a:	03000593          	li	a1,48
 67e:	855a                	mv	a0,s6
 680:	d51ff0ef          	jal	3d0 <putc>
  putc(fd, 'x');
 684:	07800593          	li	a1,120
 688:	855a                	mv	a0,s6
 68a:	d47ff0ef          	jal	3d0 <putc>
 68e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 690:	00000b97          	auipc	s7,0x0
 694:	288b8b93          	addi	s7,s7,648 # 918 <digits>
 698:	03c9d793          	srli	a5,s3,0x3c
 69c:	97de                	add	a5,a5,s7
 69e:	0007c583          	lbu	a1,0(a5)
 6a2:	855a                	mv	a0,s6
 6a4:	d2dff0ef          	jal	3d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a8:	0992                	slli	s3,s3,0x4
 6aa:	34fd                	addiw	s1,s1,-1
 6ac:	f4f5                	bnez	s1,698 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 6ae:	8bea                	mv	s7,s10
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	6d02                	ld	s10,0(sp)
 6b4:	bd29                	j	4ce <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6b6:	008b8993          	addi	s3,s7,8
 6ba:	000bb483          	ld	s1,0(s7)
 6be:	cc91                	beqz	s1,6da <vprintf+0x256>
        for(; *s; s++)
 6c0:	0004c583          	lbu	a1,0(s1)
 6c4:	c195                	beqz	a1,6e8 <vprintf+0x264>
          putc(fd, *s);
 6c6:	855a                	mv	a0,s6
 6c8:	d09ff0ef          	jal	3d0 <putc>
        for(; *s; s++)
 6cc:	0485                	addi	s1,s1,1
 6ce:	0004c583          	lbu	a1,0(s1)
 6d2:	f9f5                	bnez	a1,6c6 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 6d4:	8bce                	mv	s7,s3
      state = 0;
 6d6:	4981                	li	s3,0
 6d8:	bbdd                	j	4ce <vprintf+0x4a>
          s = "(null)";
 6da:	00000497          	auipc	s1,0x0
 6de:	23648493          	addi	s1,s1,566 # 910 <malloc+0x126>
        for(; *s; s++)
 6e2:	02800593          	li	a1,40
 6e6:	b7c5                	j	6c6 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 6e8:	8bce                	mv	s7,s3
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b3cd                	j	4ce <vprintf+0x4a>
 6ee:	6906                	ld	s2,64(sp)
 6f0:	79e2                	ld	s3,56(sp)
 6f2:	7a42                	ld	s4,48(sp)
 6f4:	7aa2                	ld	s5,40(sp)
 6f6:	7b02                	ld	s6,32(sp)
 6f8:	6be2                	ld	s7,24(sp)
 6fa:	6c42                	ld	s8,16(sp)
 6fc:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6fe:	60e6                	ld	ra,88(sp)
 700:	6446                	ld	s0,80(sp)
 702:	64a6                	ld	s1,72(sp)
 704:	6125                	addi	sp,sp,96
 706:	8082                	ret

0000000000000708 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 708:	715d                	addi	sp,sp,-80
 70a:	ec06                	sd	ra,24(sp)
 70c:	e822                	sd	s0,16(sp)
 70e:	1000                	addi	s0,sp,32
 710:	e010                	sd	a2,0(s0)
 712:	e414                	sd	a3,8(s0)
 714:	e818                	sd	a4,16(s0)
 716:	ec1c                	sd	a5,24(s0)
 718:	03043023          	sd	a6,32(s0)
 71c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 720:	8622                	mv	a2,s0
 722:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 726:	d5fff0ef          	jal	484 <vprintf>
}
 72a:	60e2                	ld	ra,24(sp)
 72c:	6442                	ld	s0,16(sp)
 72e:	6161                	addi	sp,sp,80
 730:	8082                	ret

0000000000000732 <printf>:

void
printf(const char *fmt, ...)
{
 732:	711d                	addi	sp,sp,-96
 734:	ec06                	sd	ra,24(sp)
 736:	e822                	sd	s0,16(sp)
 738:	1000                	addi	s0,sp,32
 73a:	e40c                	sd	a1,8(s0)
 73c:	e810                	sd	a2,16(s0)
 73e:	ec14                	sd	a3,24(s0)
 740:	f018                	sd	a4,32(s0)
 742:	f41c                	sd	a5,40(s0)
 744:	03043823          	sd	a6,48(s0)
 748:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 74c:	00840613          	addi	a2,s0,8
 750:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 754:	85aa                	mv	a1,a0
 756:	4505                	li	a0,1
 758:	d2dff0ef          	jal	484 <vprintf>
}
 75c:	60e2                	ld	ra,24(sp)
 75e:	6442                	ld	s0,16(sp)
 760:	6125                	addi	sp,sp,96
 762:	8082                	ret

0000000000000764 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 764:	1141                	addi	sp,sp,-16
 766:	e406                	sd	ra,8(sp)
 768:	e022                	sd	s0,0(sp)
 76a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 76c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	00001797          	auipc	a5,0x1
 774:	8907b783          	ld	a5,-1904(a5) # 1000 <freep>
 778:	a02d                	j	7a2 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 77a:	4618                	lw	a4,8(a2)
 77c:	9f2d                	addw	a4,a4,a1
 77e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 782:	6398                	ld	a4,0(a5)
 784:	6310                	ld	a2,0(a4)
 786:	a83d                	j	7c4 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 788:	ff852703          	lw	a4,-8(a0)
 78c:	9f31                	addw	a4,a4,a2
 78e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 790:	ff053683          	ld	a3,-16(a0)
 794:	a091                	j	7d8 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 796:	6398                	ld	a4,0(a5)
 798:	00e7e463          	bltu	a5,a4,7a0 <free+0x3c>
 79c:	00e6ea63          	bltu	a3,a4,7b0 <free+0x4c>
{
 7a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	fed7fae3          	bgeu	a5,a3,796 <free+0x32>
 7a6:	6398                	ld	a4,0(a5)
 7a8:	00e6e463          	bltu	a3,a4,7b0 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ac:	fee7eae3          	bltu	a5,a4,7a0 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7b0:	ff852583          	lw	a1,-8(a0)
 7b4:	6390                	ld	a2,0(a5)
 7b6:	02059813          	slli	a6,a1,0x20
 7ba:	01c85713          	srli	a4,a6,0x1c
 7be:	9736                	add	a4,a4,a3
 7c0:	fae60de3          	beq	a2,a4,77a <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c8:	4790                	lw	a2,8(a5)
 7ca:	02061593          	slli	a1,a2,0x20
 7ce:	01c5d713          	srli	a4,a1,0x1c
 7d2:	973e                	add	a4,a4,a5
 7d4:	fae68ae3          	beq	a3,a4,788 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7d8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7da:	00001717          	auipc	a4,0x1
 7de:	82f73323          	sd	a5,-2010(a4) # 1000 <freep>
}
 7e2:	60a2                	ld	ra,8(sp)
 7e4:	6402                	ld	s0,0(sp)
 7e6:	0141                	addi	sp,sp,16
 7e8:	8082                	ret

00000000000007ea <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ea:	7139                	addi	sp,sp,-64
 7ec:	fc06                	sd	ra,56(sp)
 7ee:	f822                	sd	s0,48(sp)
 7f0:	f04a                	sd	s2,32(sp)
 7f2:	ec4e                	sd	s3,24(sp)
 7f4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f6:	02051993          	slli	s3,a0,0x20
 7fa:	0209d993          	srli	s3,s3,0x20
 7fe:	09bd                	addi	s3,s3,15
 800:	0049d993          	srli	s3,s3,0x4
 804:	2985                	addiw	s3,s3,1
 806:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 808:	00000517          	auipc	a0,0x0
 80c:	7f853503          	ld	a0,2040(a0) # 1000 <freep>
 810:	c905                	beqz	a0,840 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 812:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 814:	4798                	lw	a4,8(a5)
 816:	09377663          	bgeu	a4,s3,8a2 <malloc+0xb8>
 81a:	f426                	sd	s1,40(sp)
 81c:	e852                	sd	s4,16(sp)
 81e:	e456                	sd	s5,8(sp)
 820:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 822:	8a4e                	mv	s4,s3
 824:	6705                	lui	a4,0x1
 826:	00e9f363          	bgeu	s3,a4,82c <malloc+0x42>
 82a:	6a05                	lui	s4,0x1
 82c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 830:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 834:	00000497          	auipc	s1,0x0
 838:	7cc48493          	addi	s1,s1,1996 # 1000 <freep>
  if(p == (char*)-1)
 83c:	5afd                	li	s5,-1
 83e:	a83d                	j	87c <malloc+0x92>
 840:	f426                	sd	s1,40(sp)
 842:	e852                	sd	s4,16(sp)
 844:	e456                	sd	s5,8(sp)
 846:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 848:	00000797          	auipc	a5,0x0
 84c:	7c878793          	addi	a5,a5,1992 # 1010 <base>
 850:	00000717          	auipc	a4,0x0
 854:	7af73823          	sd	a5,1968(a4) # 1000 <freep>
 858:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 85a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 85e:	b7d1                	j	822 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 860:	6398                	ld	a4,0(a5)
 862:	e118                	sd	a4,0(a0)
 864:	a899                	j	8ba <malloc+0xd0>
  hp->s.size = nu;
 866:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 86a:	0541                	addi	a0,a0,16
 86c:	ef9ff0ef          	jal	764 <free>
  return freep;
 870:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 872:	c125                	beqz	a0,8d2 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 874:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 876:	4798                	lw	a4,8(a5)
 878:	03277163          	bgeu	a4,s2,89a <malloc+0xb0>
    if(p == freep)
 87c:	6098                	ld	a4,0(s1)
 87e:	853e                	mv	a0,a5
 880:	fef71ae3          	bne	a4,a5,874 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 884:	8552                	mv	a0,s4
 886:	b2bff0ef          	jal	3b0 <sbrk>
  if(p == (char*)-1)
 88a:	fd551ee3          	bne	a0,s5,866 <malloc+0x7c>
        return 0;
 88e:	4501                	li	a0,0
 890:	74a2                	ld	s1,40(sp)
 892:	6a42                	ld	s4,16(sp)
 894:	6aa2                	ld	s5,8(sp)
 896:	6b02                	ld	s6,0(sp)
 898:	a03d                	j	8c6 <malloc+0xdc>
 89a:	74a2                	ld	s1,40(sp)
 89c:	6a42                	ld	s4,16(sp)
 89e:	6aa2                	ld	s5,8(sp)
 8a0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8a2:	fae90fe3          	beq	s2,a4,860 <malloc+0x76>
        p->s.size -= nunits;
 8a6:	4137073b          	subw	a4,a4,s3
 8aa:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8ac:	02071693          	slli	a3,a4,0x20
 8b0:	01c6d713          	srli	a4,a3,0x1c
 8b4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ba:	00000717          	auipc	a4,0x0
 8be:	74a73323          	sd	a0,1862(a4) # 1000 <freep>
      return (void*)(p + 1);
 8c2:	01078513          	addi	a0,a5,16
  }
}
 8c6:	70e2                	ld	ra,56(sp)
 8c8:	7442                	ld	s0,48(sp)
 8ca:	7902                	ld	s2,32(sp)
 8cc:	69e2                	ld	s3,24(sp)
 8ce:	6121                	addi	sp,sp,64
 8d0:	8082                	ret
 8d2:	74a2                	ld	s1,40(sp)
 8d4:	6a42                	ld	s4,16(sp)
 8d6:	6aa2                	ld	s5,8(sp)
 8d8:	6b02                	ld	s6,0(sp)
 8da:	b7f5                	j	8c6 <malloc+0xdc>
