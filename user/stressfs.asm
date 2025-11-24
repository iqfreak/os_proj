
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	22913423          	sd	s1,552(sp)
  10:	23213023          	sd	s2,544(sp)
  14:	21313c23          	sd	s3,536(sp)
  18:	21413823          	sd	s4,528(sp)
  1c:	0480                	addi	s0,sp,576
  int fd, i;
  char path[] = "stressfs0";
  1e:	00001797          	auipc	a5,0x1
  22:	a2278793          	addi	a5,a5,-1502 # a40 <malloc+0x124>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	9dc50513          	addi	a0,a0,-1572 # a10 <malloc+0xf4>
  3c:	029000ef          	jal	864 <printf>
  memset(data, 'a', sizeof(data));
  40:	20000613          	li	a2,512
  44:	06100593          	li	a1,97
  48:	dc040513          	addi	a0,s0,-576
  4c:	12c000ef          	jal	178 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	3fe000ef          	jal	452 <fork>
  58:	00a04563          	bgtz	a0,62 <main+0x62>
  for(i = 0; i < 4; i++)
  5c:	2485                	addiw	s1,s1,1
  5e:	ff249be3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  62:	85a6                	mv	a1,s1
  64:	00001517          	auipc	a0,0x1
  68:	9c450513          	addi	a0,a0,-1596 # a28 <malloc+0x10c>
  6c:	7f8000ef          	jal	864 <printf>

  path[8] += i;
  70:	fc844783          	lbu	a5,-56(s0)
  74:	9fa5                	addw	a5,a5,s1
  76:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  7a:	20200593          	li	a1,514
  7e:	fc040513          	addi	a0,s0,-64
  82:	418000ef          	jal	49a <open>
  86:	892a                	mv	s2,a0
  88:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  8a:	dc040a13          	addi	s4,s0,-576
  8e:	20000993          	li	s3,512
  92:	864e                	mv	a2,s3
  94:	85d2                	mv	a1,s4
  96:	854a                	mv	a0,s2
  98:	3e2000ef          	jal	47a <write>
  for(i = 0; i < 20; i++)
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <main+0x92>
  close(fd);
  a0:	854a                	mv	a0,s2
  a2:	3e0000ef          	jal	482 <close>

  printf("read\n");
  a6:	00001517          	auipc	a0,0x1
  aa:	99250513          	addi	a0,a0,-1646 # a38 <malloc+0x11c>
  ae:	7b6000ef          	jal	864 <printf>

  fd = open(path, O_RDONLY);
  b2:	4581                	li	a1,0
  b4:	fc040513          	addi	a0,s0,-64
  b8:	3e2000ef          	jal	49a <open>
  bc:	892a                	mv	s2,a0
  be:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  c0:	dc040a13          	addi	s4,s0,-576
  c4:	20000993          	li	s3,512
  c8:	864e                	mv	a2,s3
  ca:	85d2                	mv	a1,s4
  cc:	854a                	mv	a0,s2
  ce:	3a4000ef          	jal	472 <read>
  for (i = 0; i < 20; i++)
  d2:	34fd                	addiw	s1,s1,-1
  d4:	f8f5                	bnez	s1,c8 <main+0xc8>
  close(fd);
  d6:	854a                	mv	a0,s2
  d8:	3aa000ef          	jal	482 <close>

  wait(0);
  dc:	4501                	li	a0,0
  de:	384000ef          	jal	462 <wait>

  exit(0);
  e2:	4501                	li	a0,0
  e4:	376000ef          	jal	45a <exit>

00000000000000e8 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e406                	sd	ra,8(sp)
  ec:	e022                	sd	s0,0(sp)
  ee:	0800                	addi	s0,sp,16
  extern int main();
  main();
  f0:	f11ff0ef          	jal	0 <main>
  exit(0);
  f4:	4501                	li	a0,0
  f6:	364000ef          	jal	45a <exit>

00000000000000fa <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e406                	sd	ra,8(sp)
  fe:	e022                	sd	s0,0(sp)
 100:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 102:	87aa                	mv	a5,a0
 104:	0585                	addi	a1,a1,1
 106:	0785                	addi	a5,a5,1
 108:	fff5c703          	lbu	a4,-1(a1)
 10c:	fee78fa3          	sb	a4,-1(a5)
 110:	fb75                	bnez	a4,104 <strcpy+0xa>
    ;
  return os;
}
 112:	60a2                	ld	ra,8(sp)
 114:	6402                	ld	s0,0(sp)
 116:	0141                	addi	sp,sp,16
 118:	8082                	ret

000000000000011a <strcmp>:

int strcmp(const char *p, const char *q)
{
 11a:	1141                	addi	sp,sp,-16
 11c:	e406                	sd	ra,8(sp)
 11e:	e022                	sd	s0,0(sp)
 120:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 122:	00054783          	lbu	a5,0(a0)
 126:	cb91                	beqz	a5,13a <strcmp+0x20>
 128:	0005c703          	lbu	a4,0(a1)
 12c:	00f71763          	bne	a4,a5,13a <strcmp+0x20>
    p++, q++;
 130:	0505                	addi	a0,a0,1
 132:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 134:	00054783          	lbu	a5,0(a0)
 138:	fbe5                	bnez	a5,128 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 13a:	0005c503          	lbu	a0,0(a1)
}
 13e:	40a7853b          	subw	a0,a5,a0
 142:	60a2                	ld	ra,8(sp)
 144:	6402                	ld	s0,0(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret

000000000000014a <strlen>:

uint strlen(const char *s)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e406                	sd	ra,8(sp)
 14e:	e022                	sd	s0,0(sp)
 150:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 152:	00054783          	lbu	a5,0(a0)
 156:	cf99                	beqz	a5,174 <strlen+0x2a>
 158:	0505                	addi	a0,a0,1
 15a:	87aa                	mv	a5,a0
 15c:	86be                	mv	a3,a5
 15e:	0785                	addi	a5,a5,1
 160:	fff7c703          	lbu	a4,-1(a5)
 164:	ff65                	bnez	a4,15c <strlen+0x12>
 166:	40a6853b          	subw	a0,a3,a0
 16a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 16c:	60a2                	ld	ra,8(sp)
 16e:	6402                	ld	s0,0(sp)
 170:	0141                	addi	sp,sp,16
 172:	8082                	ret
  for (n = 0; s[n]; n++)
 174:	4501                	li	a0,0
 176:	bfdd                	j	16c <strlen+0x22>

0000000000000178 <memset>:

void *
memset(void *dst, int c, uint n)
{
 178:	1141                	addi	sp,sp,-16
 17a:	e406                	sd	ra,8(sp)
 17c:	e022                	sd	s0,0(sp)
 17e:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 180:	ca19                	beqz	a2,196 <memset+0x1e>
 182:	87aa                	mv	a5,a0
 184:	1602                	slli	a2,a2,0x20
 186:	9201                	srli	a2,a2,0x20
 188:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 18c:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 190:	0785                	addi	a5,a5,1
 192:	fee79de3          	bne	a5,a4,18c <memset+0x14>
  }
  return dst;
}
 196:	60a2                	ld	ra,8(sp)
 198:	6402                	ld	s0,0(sp)
 19a:	0141                	addi	sp,sp,16
 19c:	8082                	ret

000000000000019e <strchr>:

char *
strchr(const char *s, char c)
{
 19e:	1141                	addi	sp,sp,-16
 1a0:	e406                	sd	ra,8(sp)
 1a2:	e022                	sd	s0,0(sp)
 1a4:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1a6:	00054783          	lbu	a5,0(a0)
 1aa:	cf81                	beqz	a5,1c2 <strchr+0x24>
    if (*s == c)
 1ac:	00f58763          	beq	a1,a5,1ba <strchr+0x1c>
  for (; *s; s++)
 1b0:	0505                	addi	a0,a0,1
 1b2:	00054783          	lbu	a5,0(a0)
 1b6:	fbfd                	bnez	a5,1ac <strchr+0xe>
      return (char *)s;
  return 0;
 1b8:	4501                	li	a0,0
}
 1ba:	60a2                	ld	ra,8(sp)
 1bc:	6402                	ld	s0,0(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret
  return 0;
 1c2:	4501                	li	a0,0
 1c4:	bfdd                	j	1ba <strchr+0x1c>

00000000000001c6 <gets>:

char *
gets(char *buf, int max)
{
 1c6:	7159                	addi	sp,sp,-112
 1c8:	f486                	sd	ra,104(sp)
 1ca:	f0a2                	sd	s0,96(sp)
 1cc:	eca6                	sd	s1,88(sp)
 1ce:	e8ca                	sd	s2,80(sp)
 1d0:	e4ce                	sd	s3,72(sp)
 1d2:	e0d2                	sd	s4,64(sp)
 1d4:	fc56                	sd	s5,56(sp)
 1d6:	f85a                	sd	s6,48(sp)
 1d8:	f45e                	sd	s7,40(sp)
 1da:	f062                	sd	s8,32(sp)
 1dc:	ec66                	sd	s9,24(sp)
 1de:	e86a                	sd	s10,16(sp)
 1e0:	1880                	addi	s0,sp,112
 1e2:	8caa                	mv	s9,a0
 1e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1e6:	892a                	mv	s2,a0
 1e8:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 1ea:	f9f40b13          	addi	s6,s0,-97
 1ee:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 1f0:	4ba9                	li	s7,10
 1f2:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 1f4:	8d26                	mv	s10,s1
 1f6:	0014899b          	addiw	s3,s1,1
 1fa:	84ce                	mv	s1,s3
 1fc:	0349d563          	bge	s3,s4,226 <gets+0x60>
    cc = read(0, &c, 1);
 200:	8656                	mv	a2,s5
 202:	85da                	mv	a1,s6
 204:	4501                	li	a0,0
 206:	26c000ef          	jal	472 <read>
    if (cc < 1)
 20a:	00a05e63          	blez	a0,226 <gets+0x60>
    buf[i++] = c;
 20e:	f9f44783          	lbu	a5,-97(s0)
 212:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 216:	01778763          	beq	a5,s7,224 <gets+0x5e>
 21a:	0905                	addi	s2,s2,1
 21c:	fd879ce3          	bne	a5,s8,1f4 <gets+0x2e>
    buf[i++] = c;
 220:	8d4e                	mv	s10,s3
 222:	a011                	j	226 <gets+0x60>
 224:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 226:	9d66                	add	s10,s10,s9
 228:	000d0023          	sb	zero,0(s10)
  return buf;
}
 22c:	8566                	mv	a0,s9
 22e:	70a6                	ld	ra,104(sp)
 230:	7406                	ld	s0,96(sp)
 232:	64e6                	ld	s1,88(sp)
 234:	6946                	ld	s2,80(sp)
 236:	69a6                	ld	s3,72(sp)
 238:	6a06                	ld	s4,64(sp)
 23a:	7ae2                	ld	s5,56(sp)
 23c:	7b42                	ld	s6,48(sp)
 23e:	7ba2                	ld	s7,40(sp)
 240:	7c02                	ld	s8,32(sp)
 242:	6ce2                	ld	s9,24(sp)
 244:	6d42                	ld	s10,16(sp)
 246:	6165                	addi	sp,sp,112
 248:	8082                	ret

000000000000024a <stat>:

int stat(const char *n, struct stat *st)
{
 24a:	1101                	addi	sp,sp,-32
 24c:	ec06                	sd	ra,24(sp)
 24e:	e822                	sd	s0,16(sp)
 250:	e04a                	sd	s2,0(sp)
 252:	1000                	addi	s0,sp,32
 254:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 256:	4581                	li	a1,0
 258:	242000ef          	jal	49a <open>
  if (fd < 0)
 25c:	02054263          	bltz	a0,280 <stat+0x36>
 260:	e426                	sd	s1,8(sp)
 262:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 264:	85ca                	mv	a1,s2
 266:	24c000ef          	jal	4b2 <fstat>
 26a:	892a                	mv	s2,a0
  close(fd);
 26c:	8526                	mv	a0,s1
 26e:	214000ef          	jal	482 <close>
  return r;
 272:	64a2                	ld	s1,8(sp)
}
 274:	854a                	mv	a0,s2
 276:	60e2                	ld	ra,24(sp)
 278:	6442                	ld	s0,16(sp)
 27a:	6902                	ld	s2,0(sp)
 27c:	6105                	addi	sp,sp,32
 27e:	8082                	ret
    return -1;
 280:	597d                	li	s2,-1
 282:	bfcd                	j	274 <stat+0x2a>

0000000000000284 <atoi>:

int atoi(const char *s)
{
 284:	1141                	addi	sp,sp,-16
 286:	e406                	sd	ra,8(sp)
 288:	e022                	sd	s0,0(sp)
 28a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 28c:	00054683          	lbu	a3,0(a0)
 290:	fd06879b          	addiw	a5,a3,-48
 294:	0ff7f793          	zext.b	a5,a5
 298:	4625                	li	a2,9
 29a:	02f66963          	bltu	a2,a5,2cc <atoi+0x48>
 29e:	872a                	mv	a4,a0
  n = 0;
 2a0:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 2a2:	0705                	addi	a4,a4,1
 2a4:	0025179b          	slliw	a5,a0,0x2
 2a8:	9fa9                	addw	a5,a5,a0
 2aa:	0017979b          	slliw	a5,a5,0x1
 2ae:	9fb5                	addw	a5,a5,a3
 2b0:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2b4:	00074683          	lbu	a3,0(a4)
 2b8:	fd06879b          	addiw	a5,a3,-48
 2bc:	0ff7f793          	zext.b	a5,a5
 2c0:	fef671e3          	bgeu	a2,a5,2a2 <atoi+0x1e>
  return n;
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  n = 0;
 2cc:	4501                	li	a0,0
 2ce:	bfdd                	j	2c4 <atoi+0x40>

00000000000002d0 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 2d8:	02b57563          	bgeu	a0,a1,302 <memmove+0x32>
  {
    while (n-- > 0)
 2dc:	00c05f63          	blez	a2,2fa <memmove+0x2a>
 2e0:	1602                	slli	a2,a2,0x20
 2e2:	9201                	srli	a2,a2,0x20
 2e4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2e8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2ea:	0585                	addi	a1,a1,1
 2ec:	0705                	addi	a4,a4,1
 2ee:	fff5c683          	lbu	a3,-1(a1)
 2f2:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 2f6:	fee79ae3          	bne	a5,a4,2ea <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2fa:	60a2                	ld	ra,8(sp)
 2fc:	6402                	ld	s0,0(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret
    dst += n;
 302:	00c50733          	add	a4,a0,a2
    src += n;
 306:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 308:	fec059e3          	blez	a2,2fa <memmove+0x2a>
 30c:	fff6079b          	addiw	a5,a2,-1
 310:	1782                	slli	a5,a5,0x20
 312:	9381                	srli	a5,a5,0x20
 314:	fff7c793          	not	a5,a5
 318:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 31a:	15fd                	addi	a1,a1,-1
 31c:	177d                	addi	a4,a4,-1
 31e:	0005c683          	lbu	a3,0(a1)
 322:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 326:	fef71ae3          	bne	a4,a5,31a <memmove+0x4a>
 32a:	bfc1                	j	2fa <memmove+0x2a>

000000000000032c <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e406                	sd	ra,8(sp)
 330:	e022                	sd	s0,0(sp)
 332:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 334:	ca0d                	beqz	a2,366 <memcmp+0x3a>
 336:	fff6069b          	addiw	a3,a2,-1
 33a:	1682                	slli	a3,a3,0x20
 33c:	9281                	srli	a3,a3,0x20
 33e:	0685                	addi	a3,a3,1
 340:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 342:	00054783          	lbu	a5,0(a0)
 346:	0005c703          	lbu	a4,0(a1)
 34a:	00e79863          	bne	a5,a4,35a <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 34e:	0505                	addi	a0,a0,1
    p2++;
 350:	0585                	addi	a1,a1,1
  while (n-- > 0)
 352:	fed518e3          	bne	a0,a3,342 <memcmp+0x16>
  }
  return 0;
 356:	4501                	li	a0,0
 358:	a019                	j	35e <memcmp+0x32>
      return *p1 - *p2;
 35a:	40e7853b          	subw	a0,a5,a4
}
 35e:	60a2                	ld	ra,8(sp)
 360:	6402                	ld	s0,0(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret
  return 0;
 366:	4501                	li	a0,0
 368:	bfdd                	j	35e <memcmp+0x32>

000000000000036a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e406                	sd	ra,8(sp)
 36e:	e022                	sd	s0,0(sp)
 370:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 372:	f5fff0ef          	jal	2d0 <memmove>
}
 376:	60a2                	ld	ra,8(sp)
 378:	6402                	ld	s0,0(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <strcat>:

char *strcat(char *dst, const char *src)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e406                	sd	ra,8(sp)
 382:	e022                	sd	s0,0(sp)
 384:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 386:	00054783          	lbu	a5,0(a0)
 38a:	c795                	beqz	a5,3b6 <strcat+0x38>
  char *p = dst;
 38c:	87aa                	mv	a5,a0
    p++;
 38e:	0785                	addi	a5,a5,1
  while (*p)
 390:	0007c703          	lbu	a4,0(a5)
 394:	ff6d                	bnez	a4,38e <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 396:	0005c703          	lbu	a4,0(a1)
 39a:	cb01                	beqz	a4,3aa <strcat+0x2c>
  {
    *p = *src;
 39c:	00e78023          	sb	a4,0(a5)
    p++;
 3a0:	0785                	addi	a5,a5,1
    src++;
 3a2:	0585                	addi	a1,a1,1
  while (*src)
 3a4:	0005c703          	lbu	a4,0(a1)
 3a8:	fb75                	bnez	a4,39c <strcat+0x1e>
  }

  *p = 0;
 3aa:	00078023          	sb	zero,0(a5)

  return dst;
}
 3ae:	60a2                	ld	ra,8(sp)
 3b0:	6402                	ld	s0,0(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret
  char *p = dst;
 3b6:	87aa                	mv	a5,a0
 3b8:	bff9                	j	396 <strcat+0x18>

00000000000003ba <isdir>:

int isdir(char *path)
{
 3ba:	7179                	addi	sp,sp,-48
 3bc:	f406                	sd	ra,40(sp)
 3be:	f022                	sd	s0,32(sp)
 3c0:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 3c2:	fd840593          	addi	a1,s0,-40
 3c6:	e85ff0ef          	jal	24a <stat>
 3ca:	00054b63          	bltz	a0,3e0 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 3ce:	fe041503          	lh	a0,-32(s0)
 3d2:	157d                	addi	a0,a0,-1
 3d4:	00153513          	seqz	a0,a0
}
 3d8:	70a2                	ld	ra,40(sp)
 3da:	7402                	ld	s0,32(sp)
 3dc:	6145                	addi	sp,sp,48
 3de:	8082                	ret
    return 0;
 3e0:	4501                	li	a0,0
 3e2:	bfdd                	j	3d8 <isdir+0x1e>

00000000000003e4 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 3e4:	7139                	addi	sp,sp,-64
 3e6:	fc06                	sd	ra,56(sp)
 3e8:	f822                	sd	s0,48(sp)
 3ea:	f426                	sd	s1,40(sp)
 3ec:	f04a                	sd	s2,32(sp)
 3ee:	ec4e                	sd	s3,24(sp)
 3f0:	e852                	sd	s4,16(sp)
 3f2:	e456                	sd	s5,8(sp)
 3f4:	0080                	addi	s0,sp,64
 3f6:	89aa                	mv	s3,a0
 3f8:	8aae                	mv	s5,a1
 3fa:	84b2                	mv	s1,a2
 3fc:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 3fe:	d4dff0ef          	jal	14a <strlen>
 402:	892a                	mv	s2,a0
  int nn = strlen(filename);
 404:	8556                	mv	a0,s5
 406:	d45ff0ef          	jal	14a <strlen>
  int need = dn + 1 + nn + 1;
 40a:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 40e:	9fa9                	addw	a5,a5,a0
    return 0;
 410:	4501                	li	a0,0
  if (need > bufsize)
 412:	0347d763          	bge	a5,s4,440 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 416:	85ce                	mv	a1,s3
 418:	8526                	mv	a0,s1
 41a:	ce1ff0ef          	jal	fa <strcpy>
  if (dir[dn - 1] != '/')
 41e:	99ca                	add	s3,s3,s2
 420:	fff9c703          	lbu	a4,-1(s3)
 424:	02f00793          	li	a5,47
 428:	00f70763          	beq	a4,a5,436 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 42c:	9926                	add	s2,s2,s1
 42e:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 432:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 436:	85d6                	mv	a1,s5
 438:	8526                	mv	a0,s1
 43a:	f45ff0ef          	jal	37e <strcat>
  return out_buffer;
 43e:	8526                	mv	a0,s1
}
 440:	70e2                	ld	ra,56(sp)
 442:	7442                	ld	s0,48(sp)
 444:	74a2                	ld	s1,40(sp)
 446:	7902                	ld	s2,32(sp)
 448:	69e2                	ld	s3,24(sp)
 44a:	6a42                	ld	s4,16(sp)
 44c:	6aa2                	ld	s5,8(sp)
 44e:	6121                	addi	sp,sp,64
 450:	8082                	ret

0000000000000452 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 452:	4885                	li	a7,1
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <exit>:
.global exit
exit:
 li a7, SYS_exit
 45a:	4889                	li	a7,2
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <wait>:
.global wait
wait:
 li a7, SYS_wait
 462:	488d                	li	a7,3
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 46a:	4891                	li	a7,4
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <read>:
.global read
read:
 li a7, SYS_read
 472:	4895                	li	a7,5
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <write>:
.global write
write:
 li a7, SYS_write
 47a:	48c1                	li	a7,16
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <close>:
.global close
close:
 li a7, SYS_close
 482:	48d5                	li	a7,21
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <kill>:
.global kill
kill:
 li a7, SYS_kill
 48a:	4899                	li	a7,6
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <exec>:
.global exec
exec:
 li a7, SYS_exec
 492:	489d                	li	a7,7
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <open>:
.global open
open:
 li a7, SYS_open
 49a:	48bd                	li	a7,15
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4a2:	48c5                	li	a7,17
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4aa:	48c9                	li	a7,18
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4b2:	48a1                	li	a7,8
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <link>:
.global link
link:
 li a7, SYS_link
 4ba:	48cd                	li	a7,19
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4c2:	48d1                	li	a7,20
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4ca:	48a5                	li	a7,9
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4d2:	48a9                	li	a7,10
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4da:	48ad                	li	a7,11
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4e2:	48b1                	li	a7,12
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4ea:	48b5                	li	a7,13
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4f2:	48b9                	li	a7,14
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 4fa:	48d9                	li	a7,22
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 502:	1101                	addi	sp,sp,-32
 504:	ec06                	sd	ra,24(sp)
 506:	e822                	sd	s0,16(sp)
 508:	1000                	addi	s0,sp,32
 50a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 50e:	4605                	li	a2,1
 510:	fef40593          	addi	a1,s0,-17
 514:	f67ff0ef          	jal	47a <write>
}
 518:	60e2                	ld	ra,24(sp)
 51a:	6442                	ld	s0,16(sp)
 51c:	6105                	addi	sp,sp,32
 51e:	8082                	ret

0000000000000520 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	7139                	addi	sp,sp,-64
 522:	fc06                	sd	ra,56(sp)
 524:	f822                	sd	s0,48(sp)
 526:	f426                	sd	s1,40(sp)
 528:	f04a                	sd	s2,32(sp)
 52a:	ec4e                	sd	s3,24(sp)
 52c:	0080                	addi	s0,sp,64
 52e:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 530:	c299                	beqz	a3,536 <printint+0x16>
 532:	0605ce63          	bltz	a1,5ae <printint+0x8e>
  neg = 0;
 536:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 538:	fc040313          	addi	t1,s0,-64
  neg = 0;
 53c:	869a                	mv	a3,t1
  i = 0;
 53e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 540:	00000817          	auipc	a6,0x0
 544:	51880813          	addi	a6,a6,1304 # a58 <digits>
 548:	88be                	mv	a7,a5
 54a:	0017851b          	addiw	a0,a5,1
 54e:	87aa                	mv	a5,a0
 550:	02c5f73b          	remuw	a4,a1,a2
 554:	1702                	slli	a4,a4,0x20
 556:	9301                	srli	a4,a4,0x20
 558:	9742                	add	a4,a4,a6
 55a:	00074703          	lbu	a4,0(a4)
 55e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 562:	872e                	mv	a4,a1
 564:	02c5d5bb          	divuw	a1,a1,a2
 568:	0685                	addi	a3,a3,1
 56a:	fcc77fe3          	bgeu	a4,a2,548 <printint+0x28>
  if(neg)
 56e:	000e0c63          	beqz	t3,586 <printint+0x66>
    buf[i++] = '-';
 572:	fd050793          	addi	a5,a0,-48
 576:	00878533          	add	a0,a5,s0
 57a:	02d00793          	li	a5,45
 57e:	fef50823          	sb	a5,-16(a0)
 582:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 586:	fff7899b          	addiw	s3,a5,-1
 58a:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 58e:	fff4c583          	lbu	a1,-1(s1)
 592:	854a                	mv	a0,s2
 594:	f6fff0ef          	jal	502 <putc>
  while(--i >= 0)
 598:	39fd                	addiw	s3,s3,-1
 59a:	14fd                	addi	s1,s1,-1
 59c:	fe09d9e3          	bgez	s3,58e <printint+0x6e>
}
 5a0:	70e2                	ld	ra,56(sp)
 5a2:	7442                	ld	s0,48(sp)
 5a4:	74a2                	ld	s1,40(sp)
 5a6:	7902                	ld	s2,32(sp)
 5a8:	69e2                	ld	s3,24(sp)
 5aa:	6121                	addi	sp,sp,64
 5ac:	8082                	ret
    x = -xx;
 5ae:	40b005bb          	negw	a1,a1
    neg = 1;
 5b2:	4e05                	li	t3,1
    x = -xx;
 5b4:	b751                	j	538 <printint+0x18>

00000000000005b6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b6:	711d                	addi	sp,sp,-96
 5b8:	ec86                	sd	ra,88(sp)
 5ba:	e8a2                	sd	s0,80(sp)
 5bc:	e4a6                	sd	s1,72(sp)
 5be:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c0:	0005c483          	lbu	s1,0(a1)
 5c4:	26048663          	beqz	s1,830 <vprintf+0x27a>
 5c8:	e0ca                	sd	s2,64(sp)
 5ca:	fc4e                	sd	s3,56(sp)
 5cc:	f852                	sd	s4,48(sp)
 5ce:	f456                	sd	s5,40(sp)
 5d0:	f05a                	sd	s6,32(sp)
 5d2:	ec5e                	sd	s7,24(sp)
 5d4:	e862                	sd	s8,16(sp)
 5d6:	e466                	sd	s9,8(sp)
 5d8:	8b2a                	mv	s6,a0
 5da:	8a2e                	mv	s4,a1
 5dc:	8bb2                	mv	s7,a2
  state = 0;
 5de:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5e0:	4901                	li	s2,0
 5e2:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5e4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5e8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5ec:	06c00c93          	li	s9,108
 5f0:	a00d                	j	612 <vprintf+0x5c>
        putc(fd, c0);
 5f2:	85a6                	mv	a1,s1
 5f4:	855a                	mv	a0,s6
 5f6:	f0dff0ef          	jal	502 <putc>
 5fa:	a019                	j	600 <vprintf+0x4a>
    } else if(state == '%'){
 5fc:	03598363          	beq	s3,s5,622 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 600:	0019079b          	addiw	a5,s2,1
 604:	893e                	mv	s2,a5
 606:	873e                	mv	a4,a5
 608:	97d2                	add	a5,a5,s4
 60a:	0007c483          	lbu	s1,0(a5)
 60e:	20048963          	beqz	s1,820 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 612:	0004879b          	sext.w	a5,s1
    if(state == 0){
 616:	fe0993e3          	bnez	s3,5fc <vprintf+0x46>
      if(c0 == '%'){
 61a:	fd579ce3          	bne	a5,s5,5f2 <vprintf+0x3c>
        state = '%';
 61e:	89be                	mv	s3,a5
 620:	b7c5                	j	600 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 622:	00ea06b3          	add	a3,s4,a4
 626:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 62a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 62c:	c681                	beqz	a3,634 <vprintf+0x7e>
 62e:	9752                	add	a4,a4,s4
 630:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 634:	03878e63          	beq	a5,s8,670 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 638:	05978863          	beq	a5,s9,688 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 63c:	07500713          	li	a4,117
 640:	0ee78263          	beq	a5,a4,724 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 644:	07800713          	li	a4,120
 648:	12e78463          	beq	a5,a4,770 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 64c:	07000713          	li	a4,112
 650:	14e78963          	beq	a5,a4,7a2 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 654:	07300713          	li	a4,115
 658:	18e78863          	beq	a5,a4,7e8 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 65c:	02500713          	li	a4,37
 660:	04e79463          	bne	a5,a4,6a8 <vprintf+0xf2>
        putc(fd, '%');
 664:	85ba                	mv	a1,a4
 666:	855a                	mv	a0,s6
 668:	e9bff0ef          	jal	502 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bf49                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 670:	008b8493          	addi	s1,s7,8
 674:	4685                	li	a3,1
 676:	4629                	li	a2,10
 678:	000ba583          	lw	a1,0(s7)
 67c:	855a                	mv	a0,s6
 67e:	ea3ff0ef          	jal	520 <printint>
 682:	8ba6                	mv	s7,s1
      state = 0;
 684:	4981                	li	s3,0
 686:	bfad                	j	600 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 688:	06400793          	li	a5,100
 68c:	02f68963          	beq	a3,a5,6be <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 690:	06c00793          	li	a5,108
 694:	04f68263          	beq	a3,a5,6d8 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 698:	07500793          	li	a5,117
 69c:	0af68063          	beq	a3,a5,73c <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 6a0:	07800793          	li	a5,120
 6a4:	0ef68263          	beq	a3,a5,788 <vprintf+0x1d2>
        putc(fd, '%');
 6a8:	02500593          	li	a1,37
 6ac:	855a                	mv	a0,s6
 6ae:	e55ff0ef          	jal	502 <putc>
        putc(fd, c0);
 6b2:	85a6                	mv	a1,s1
 6b4:	855a                	mv	a0,s6
 6b6:	e4dff0ef          	jal	502 <putc>
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	b791                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4685                	li	a3,1
 6c4:	4629                	li	a2,10
 6c6:	000ba583          	lw	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	e55ff0ef          	jal	520 <printint>
        i += 1;
 6d0:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
        i += 1;
 6d6:	b72d                	j	600 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6d8:	06400793          	li	a5,100
 6dc:	02f60763          	beq	a2,a5,70a <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6e0:	07500793          	li	a5,117
 6e4:	06f60963          	beq	a2,a5,756 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6e8:	07800793          	li	a5,120
 6ec:	faf61ee3          	bne	a2,a5,6a8 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f0:	008b8493          	addi	s1,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000ba583          	lw	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	e23ff0ef          	jal	520 <printint>
        i += 2;
 702:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 704:	8ba6                	mv	s7,s1
      state = 0;
 706:	4981                	li	s3,0
        i += 2;
 708:	bde5                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 70a:	008b8493          	addi	s1,s7,8
 70e:	4685                	li	a3,1
 710:	4629                	li	a2,10
 712:	000ba583          	lw	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	e09ff0ef          	jal	520 <printint>
        i += 2;
 71c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 71e:	8ba6                	mv	s7,s1
      state = 0;
 720:	4981                	li	s3,0
        i += 2;
 722:	bdf9                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 724:	008b8493          	addi	s1,s7,8
 728:	4681                	li	a3,0
 72a:	4629                	li	a2,10
 72c:	000ba583          	lw	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	defff0ef          	jal	520 <printint>
 736:	8ba6                	mv	s7,s1
      state = 0;
 738:	4981                	li	s3,0
 73a:	b5d9                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 73c:	008b8493          	addi	s1,s7,8
 740:	4681                	li	a3,0
 742:	4629                	li	a2,10
 744:	000ba583          	lw	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	dd7ff0ef          	jal	520 <printint>
        i += 1;
 74e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 750:	8ba6                	mv	s7,s1
      state = 0;
 752:	4981                	li	s3,0
        i += 1;
 754:	b575                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 756:	008b8493          	addi	s1,s7,8
 75a:	4681                	li	a3,0
 75c:	4629                	li	a2,10
 75e:	000ba583          	lw	a1,0(s7)
 762:	855a                	mv	a0,s6
 764:	dbdff0ef          	jal	520 <printint>
        i += 2;
 768:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 76a:	8ba6                	mv	s7,s1
      state = 0;
 76c:	4981                	li	s3,0
        i += 2;
 76e:	bd49                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 770:	008b8493          	addi	s1,s7,8
 774:	4681                	li	a3,0
 776:	4641                	li	a2,16
 778:	000ba583          	lw	a1,0(s7)
 77c:	855a                	mv	a0,s6
 77e:	da3ff0ef          	jal	520 <printint>
 782:	8ba6                	mv	s7,s1
      state = 0;
 784:	4981                	li	s3,0
 786:	bdad                	j	600 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 788:	008b8493          	addi	s1,s7,8
 78c:	4681                	li	a3,0
 78e:	4641                	li	a2,16
 790:	000ba583          	lw	a1,0(s7)
 794:	855a                	mv	a0,s6
 796:	d8bff0ef          	jal	520 <printint>
        i += 1;
 79a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 79c:	8ba6                	mv	s7,s1
      state = 0;
 79e:	4981                	li	s3,0
        i += 1;
 7a0:	b585                	j	600 <vprintf+0x4a>
 7a2:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7a4:	008b8d13          	addi	s10,s7,8
 7a8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7ac:	03000593          	li	a1,48
 7b0:	855a                	mv	a0,s6
 7b2:	d51ff0ef          	jal	502 <putc>
  putc(fd, 'x');
 7b6:	07800593          	li	a1,120
 7ba:	855a                	mv	a0,s6
 7bc:	d47ff0ef          	jal	502 <putc>
 7c0:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c2:	00000b97          	auipc	s7,0x0
 7c6:	296b8b93          	addi	s7,s7,662 # a58 <digits>
 7ca:	03c9d793          	srli	a5,s3,0x3c
 7ce:	97de                	add	a5,a5,s7
 7d0:	0007c583          	lbu	a1,0(a5)
 7d4:	855a                	mv	a0,s6
 7d6:	d2dff0ef          	jal	502 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7da:	0992                	slli	s3,s3,0x4
 7dc:	34fd                	addiw	s1,s1,-1
 7de:	f4f5                	bnez	s1,7ca <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 7e0:	8bea                	mv	s7,s10
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	6d02                	ld	s10,0(sp)
 7e6:	bd29                	j	600 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7e8:	008b8993          	addi	s3,s7,8
 7ec:	000bb483          	ld	s1,0(s7)
 7f0:	cc91                	beqz	s1,80c <vprintf+0x256>
        for(; *s; s++)
 7f2:	0004c583          	lbu	a1,0(s1)
 7f6:	c195                	beqz	a1,81a <vprintf+0x264>
          putc(fd, *s);
 7f8:	855a                	mv	a0,s6
 7fa:	d09ff0ef          	jal	502 <putc>
        for(; *s; s++)
 7fe:	0485                	addi	s1,s1,1
 800:	0004c583          	lbu	a1,0(s1)
 804:	f9f5                	bnez	a1,7f8 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 806:	8bce                	mv	s7,s3
      state = 0;
 808:	4981                	li	s3,0
 80a:	bbdd                	j	600 <vprintf+0x4a>
          s = "(null)";
 80c:	00000497          	auipc	s1,0x0
 810:	24448493          	addi	s1,s1,580 # a50 <malloc+0x134>
        for(; *s; s++)
 814:	02800593          	li	a1,40
 818:	b7c5                	j	7f8 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 81a:	8bce                	mv	s7,s3
      state = 0;
 81c:	4981                	li	s3,0
 81e:	b3cd                	j	600 <vprintf+0x4a>
 820:	6906                	ld	s2,64(sp)
 822:	79e2                	ld	s3,56(sp)
 824:	7a42                	ld	s4,48(sp)
 826:	7aa2                	ld	s5,40(sp)
 828:	7b02                	ld	s6,32(sp)
 82a:	6be2                	ld	s7,24(sp)
 82c:	6c42                	ld	s8,16(sp)
 82e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 830:	60e6                	ld	ra,88(sp)
 832:	6446                	ld	s0,80(sp)
 834:	64a6                	ld	s1,72(sp)
 836:	6125                	addi	sp,sp,96
 838:	8082                	ret

000000000000083a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 83a:	715d                	addi	sp,sp,-80
 83c:	ec06                	sd	ra,24(sp)
 83e:	e822                	sd	s0,16(sp)
 840:	1000                	addi	s0,sp,32
 842:	e010                	sd	a2,0(s0)
 844:	e414                	sd	a3,8(s0)
 846:	e818                	sd	a4,16(s0)
 848:	ec1c                	sd	a5,24(s0)
 84a:	03043023          	sd	a6,32(s0)
 84e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 852:	8622                	mv	a2,s0
 854:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 858:	d5fff0ef          	jal	5b6 <vprintf>
}
 85c:	60e2                	ld	ra,24(sp)
 85e:	6442                	ld	s0,16(sp)
 860:	6161                	addi	sp,sp,80
 862:	8082                	ret

0000000000000864 <printf>:

void
printf(const char *fmt, ...)
{
 864:	711d                	addi	sp,sp,-96
 866:	ec06                	sd	ra,24(sp)
 868:	e822                	sd	s0,16(sp)
 86a:	1000                	addi	s0,sp,32
 86c:	e40c                	sd	a1,8(s0)
 86e:	e810                	sd	a2,16(s0)
 870:	ec14                	sd	a3,24(s0)
 872:	f018                	sd	a4,32(s0)
 874:	f41c                	sd	a5,40(s0)
 876:	03043823          	sd	a6,48(s0)
 87a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	00840613          	addi	a2,s0,8
 882:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 886:	85aa                	mv	a1,a0
 888:	4505                	li	a0,1
 88a:	d2dff0ef          	jal	5b6 <vprintf>
}
 88e:	60e2                	ld	ra,24(sp)
 890:	6442                	ld	s0,16(sp)
 892:	6125                	addi	sp,sp,96
 894:	8082                	ret

0000000000000896 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 896:	1141                	addi	sp,sp,-16
 898:	e406                	sd	ra,8(sp)
 89a:	e022                	sd	s0,0(sp)
 89c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a2:	00000797          	auipc	a5,0x0
 8a6:	75e7b783          	ld	a5,1886(a5) # 1000 <freep>
 8aa:	a02d                	j	8d4 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ac:	4618                	lw	a4,8(a2)
 8ae:	9f2d                	addw	a4,a4,a1
 8b0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b4:	6398                	ld	a4,0(a5)
 8b6:	6310                	ld	a2,0(a4)
 8b8:	a83d                	j	8f6 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8ba:	ff852703          	lw	a4,-8(a0)
 8be:	9f31                	addw	a4,a4,a2
 8c0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8c2:	ff053683          	ld	a3,-16(a0)
 8c6:	a091                	j	90a <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c8:	6398                	ld	a4,0(a5)
 8ca:	00e7e463          	bltu	a5,a4,8d2 <free+0x3c>
 8ce:	00e6ea63          	bltu	a3,a4,8e2 <free+0x4c>
{
 8d2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d4:	fed7fae3          	bgeu	a5,a3,8c8 <free+0x32>
 8d8:	6398                	ld	a4,0(a5)
 8da:	00e6e463          	bltu	a3,a4,8e2 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8de:	fee7eae3          	bltu	a5,a4,8d2 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 8e2:	ff852583          	lw	a1,-8(a0)
 8e6:	6390                	ld	a2,0(a5)
 8e8:	02059813          	slli	a6,a1,0x20
 8ec:	01c85713          	srli	a4,a6,0x1c
 8f0:	9736                	add	a4,a4,a3
 8f2:	fae60de3          	beq	a2,a4,8ac <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 8f6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8fa:	4790                	lw	a2,8(a5)
 8fc:	02061593          	slli	a1,a2,0x20
 900:	01c5d713          	srli	a4,a1,0x1c
 904:	973e                	add	a4,a4,a5
 906:	fae68ae3          	beq	a3,a4,8ba <free+0x24>
    p->s.ptr = bp->s.ptr;
 90a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 90c:	00000717          	auipc	a4,0x0
 910:	6ef73a23          	sd	a5,1780(a4) # 1000 <freep>
}
 914:	60a2                	ld	ra,8(sp)
 916:	6402                	ld	s0,0(sp)
 918:	0141                	addi	sp,sp,16
 91a:	8082                	ret

000000000000091c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 91c:	7139                	addi	sp,sp,-64
 91e:	fc06                	sd	ra,56(sp)
 920:	f822                	sd	s0,48(sp)
 922:	f04a                	sd	s2,32(sp)
 924:	ec4e                	sd	s3,24(sp)
 926:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 928:	02051993          	slli	s3,a0,0x20
 92c:	0209d993          	srli	s3,s3,0x20
 930:	09bd                	addi	s3,s3,15
 932:	0049d993          	srli	s3,s3,0x4
 936:	2985                	addiw	s3,s3,1
 938:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 93a:	00000517          	auipc	a0,0x0
 93e:	6c653503          	ld	a0,1734(a0) # 1000 <freep>
 942:	c905                	beqz	a0,972 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 944:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 946:	4798                	lw	a4,8(a5)
 948:	09377663          	bgeu	a4,s3,9d4 <malloc+0xb8>
 94c:	f426                	sd	s1,40(sp)
 94e:	e852                	sd	s4,16(sp)
 950:	e456                	sd	s5,8(sp)
 952:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 954:	8a4e                	mv	s4,s3
 956:	6705                	lui	a4,0x1
 958:	00e9f363          	bgeu	s3,a4,95e <malloc+0x42>
 95c:	6a05                	lui	s4,0x1
 95e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 962:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 966:	00000497          	auipc	s1,0x0
 96a:	69a48493          	addi	s1,s1,1690 # 1000 <freep>
  if(p == (char*)-1)
 96e:	5afd                	li	s5,-1
 970:	a83d                	j	9ae <malloc+0x92>
 972:	f426                	sd	s1,40(sp)
 974:	e852                	sd	s4,16(sp)
 976:	e456                	sd	s5,8(sp)
 978:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 97a:	00000797          	auipc	a5,0x0
 97e:	69678793          	addi	a5,a5,1686 # 1010 <base>
 982:	00000717          	auipc	a4,0x0
 986:	66f73f23          	sd	a5,1662(a4) # 1000 <freep>
 98a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 98c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 990:	b7d1                	j	954 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 992:	6398                	ld	a4,0(a5)
 994:	e118                	sd	a4,0(a0)
 996:	a899                	j	9ec <malloc+0xd0>
  hp->s.size = nu;
 998:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 99c:	0541                	addi	a0,a0,16
 99e:	ef9ff0ef          	jal	896 <free>
  return freep;
 9a2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9a4:	c125                	beqz	a0,a04 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a8:	4798                	lw	a4,8(a5)
 9aa:	03277163          	bgeu	a4,s2,9cc <malloc+0xb0>
    if(p == freep)
 9ae:	6098                	ld	a4,0(s1)
 9b0:	853e                	mv	a0,a5
 9b2:	fef71ae3          	bne	a4,a5,9a6 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 9b6:	8552                	mv	a0,s4
 9b8:	b2bff0ef          	jal	4e2 <sbrk>
  if(p == (char*)-1)
 9bc:	fd551ee3          	bne	a0,s5,998 <malloc+0x7c>
        return 0;
 9c0:	4501                	li	a0,0
 9c2:	74a2                	ld	s1,40(sp)
 9c4:	6a42                	ld	s4,16(sp)
 9c6:	6aa2                	ld	s5,8(sp)
 9c8:	6b02                	ld	s6,0(sp)
 9ca:	a03d                	j	9f8 <malloc+0xdc>
 9cc:	74a2                	ld	s1,40(sp)
 9ce:	6a42                	ld	s4,16(sp)
 9d0:	6aa2                	ld	s5,8(sp)
 9d2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9d4:	fae90fe3          	beq	s2,a4,992 <malloc+0x76>
        p->s.size -= nunits;
 9d8:	4137073b          	subw	a4,a4,s3
 9dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9de:	02071693          	slli	a3,a4,0x20
 9e2:	01c6d713          	srli	a4,a3,0x1c
 9e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ec:	00000717          	auipc	a4,0x0
 9f0:	60a73a23          	sd	a0,1556(a4) # 1000 <freep>
      return (void*)(p + 1);
 9f4:	01078513          	addi	a0,a5,16
  }
}
 9f8:	70e2                	ld	ra,56(sp)
 9fa:	7442                	ld	s0,48(sp)
 9fc:	7902                	ld	s2,32(sp)
 9fe:	69e2                	ld	s3,24(sp)
 a00:	6121                	addi	sp,sp,64
 a02:	8082                	ret
 a04:	74a2                	ld	s1,40(sp)
 a06:	6a42                	ld	s4,16(sp)
 a08:	6aa2                	ld	s5,8(sp)
 a0a:	6b02                	ld	s6,0(sp)
 a0c:	b7f5                	j	9f8 <malloc+0xdc>
