
user/_mkdir:     file format elf64-littleriscv


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
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	418000ef          	jal	440 <mkdir>
  2c:	02054463          	bltz	a0,54 <main+0x54>
  for(i = 1; i < argc; i++){
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit(0);
  36:	4501                	li	a0,0
  38:	3a0000ef          	jal	3d8 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: mkdir files...\n");
  40:	00001597          	auipc	a1,0x1
  44:	95058593          	addi	a1,a1,-1712 # 990 <malloc+0xf6>
  48:	4509                	li	a0,2
  4a:	76e000ef          	jal	7b8 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	388000ef          	jal	3d8 <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  54:	6090                	ld	a2,0(s1)
  56:	00001597          	auipc	a1,0x1
  5a:	95258593          	addi	a1,a1,-1710 # 9a8 <malloc+0x10e>
  5e:	4509                	li	a0,2
  60:	758000ef          	jal	7b8 <fprintf>
      break;
  64:	bfc9                	j	36 <main+0x36>

0000000000000066 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  extern int main();
  main();
  6e:	f93ff0ef          	jal	0 <main>
  exit(0);
  72:	4501                	li	a0,0
  74:	364000ef          	jal	3d8 <exit>

0000000000000078 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e406                	sd	ra,8(sp)
  7c:	e022                	sd	s0,0(sp)
  7e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
  80:	87aa                	mv	a5,a0
  82:	0585                	addi	a1,a1,1
  84:	0785                	addi	a5,a5,1
  86:	fff5c703          	lbu	a4,-1(a1)
  8a:	fee78fa3          	sb	a4,-1(a5)
  8e:	fb75                	bnez	a4,82 <strcpy+0xa>
    ;
  return os;
}
  90:	60a2                	ld	ra,8(sp)
  92:	6402                	ld	s0,0(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <strcmp>:

int strcmp(const char *p, const char *q)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e406                	sd	ra,8(sp)
  9c:	e022                	sd	s0,0(sp)
  9e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	cb91                	beqz	a5,b8 <strcmp+0x20>
  a6:	0005c703          	lbu	a4,0(a1)
  aa:	00f71763          	bne	a4,a5,b8 <strcmp+0x20>
    p++, q++;
  ae:	0505                	addi	a0,a0,1
  b0:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	fbe5                	bnez	a5,a6 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  b8:	0005c503          	lbu	a0,0(a1)
}
  bc:	40a7853b          	subw	a0,a5,a0
  c0:	60a2                	ld	ra,8(sp)
  c2:	6402                	ld	s0,0(sp)
  c4:	0141                	addi	sp,sp,16
  c6:	8082                	ret

00000000000000c8 <strlen>:

uint strlen(const char *s)
{
  c8:	1141                	addi	sp,sp,-16
  ca:	e406                	sd	ra,8(sp)
  cc:	e022                	sd	s0,0(sp)
  ce:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
  d0:	00054783          	lbu	a5,0(a0)
  d4:	cf99                	beqz	a5,f2 <strlen+0x2a>
  d6:	0505                	addi	a0,a0,1
  d8:	87aa                	mv	a5,a0
  da:	86be                	mv	a3,a5
  dc:	0785                	addi	a5,a5,1
  de:	fff7c703          	lbu	a4,-1(a5)
  e2:	ff65                	bnez	a4,da <strlen+0x12>
  e4:	40a6853b          	subw	a0,a3,a0
  e8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  ea:	60a2                	ld	ra,8(sp)
  ec:	6402                	ld	s0,0(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret
  for (n = 0; s[n]; n++)
  f2:	4501                	li	a0,0
  f4:	bfdd                	j	ea <strlen+0x22>

00000000000000f6 <memset>:

void *
memset(void *dst, int c, uint n)
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e406                	sd	ra,8(sp)
  fa:	e022                	sd	s0,0(sp)
  fc:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
  fe:	ca19                	beqz	a2,114 <memset+0x1e>
 100:	87aa                	mv	a5,a0
 102:	1602                	slli	a2,a2,0x20
 104:	9201                	srli	a2,a2,0x20
 106:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 10a:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 10e:	0785                	addi	a5,a5,1
 110:	fee79de3          	bne	a5,a4,10a <memset+0x14>
  }
  return dst;
}
 114:	60a2                	ld	ra,8(sp)
 116:	6402                	ld	s0,0(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret

000000000000011c <strchr>:

char *
strchr(const char *s, char c)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e406                	sd	ra,8(sp)
 120:	e022                	sd	s0,0(sp)
 122:	0800                	addi	s0,sp,16
  for (; *s; s++)
 124:	00054783          	lbu	a5,0(a0)
 128:	cf81                	beqz	a5,140 <strchr+0x24>
    if (*s == c)
 12a:	00f58763          	beq	a1,a5,138 <strchr+0x1c>
  for (; *s; s++)
 12e:	0505                	addi	a0,a0,1
 130:	00054783          	lbu	a5,0(a0)
 134:	fbfd                	bnez	a5,12a <strchr+0xe>
      return (char *)s;
  return 0;
 136:	4501                	li	a0,0
}
 138:	60a2                	ld	ra,8(sp)
 13a:	6402                	ld	s0,0(sp)
 13c:	0141                	addi	sp,sp,16
 13e:	8082                	ret
  return 0;
 140:	4501                	li	a0,0
 142:	bfdd                	j	138 <strchr+0x1c>

0000000000000144 <gets>:

char *
gets(char *buf, int max)
{
 144:	7159                	addi	sp,sp,-112
 146:	f486                	sd	ra,104(sp)
 148:	f0a2                	sd	s0,96(sp)
 14a:	eca6                	sd	s1,88(sp)
 14c:	e8ca                	sd	s2,80(sp)
 14e:	e4ce                	sd	s3,72(sp)
 150:	e0d2                	sd	s4,64(sp)
 152:	fc56                	sd	s5,56(sp)
 154:	f85a                	sd	s6,48(sp)
 156:	f45e                	sd	s7,40(sp)
 158:	f062                	sd	s8,32(sp)
 15a:	ec66                	sd	s9,24(sp)
 15c:	e86a                	sd	s10,16(sp)
 15e:	1880                	addi	s0,sp,112
 160:	8caa                	mv	s9,a0
 162:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 164:	892a                	mv	s2,a0
 166:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 168:	f9f40b13          	addi	s6,s0,-97
 16c:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 16e:	4ba9                	li	s7,10
 170:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 172:	8d26                	mv	s10,s1
 174:	0014899b          	addiw	s3,s1,1
 178:	84ce                	mv	s1,s3
 17a:	0349d563          	bge	s3,s4,1a4 <gets+0x60>
    cc = read(0, &c, 1);
 17e:	8656                	mv	a2,s5
 180:	85da                	mv	a1,s6
 182:	4501                	li	a0,0
 184:	26c000ef          	jal	3f0 <read>
    if (cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x60>
    buf[i++] = c;
 18c:	f9f44783          	lbu	a5,-97(s0)
 190:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 194:	01778763          	beq	a5,s7,1a2 <gets+0x5e>
 198:	0905                	addi	s2,s2,1
 19a:	fd879ce3          	bne	a5,s8,172 <gets+0x2e>
    buf[i++] = c;
 19e:	8d4e                	mv	s10,s3
 1a0:	a011                	j	1a4 <gets+0x60>
 1a2:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1a4:	9d66                	add	s10,s10,s9
 1a6:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1aa:	8566                	mv	a0,s9
 1ac:	70a6                	ld	ra,104(sp)
 1ae:	7406                	ld	s0,96(sp)
 1b0:	64e6                	ld	s1,88(sp)
 1b2:	6946                	ld	s2,80(sp)
 1b4:	69a6                	ld	s3,72(sp)
 1b6:	6a06                	ld	s4,64(sp)
 1b8:	7ae2                	ld	s5,56(sp)
 1ba:	7b42                	ld	s6,48(sp)
 1bc:	7ba2                	ld	s7,40(sp)
 1be:	7c02                	ld	s8,32(sp)
 1c0:	6ce2                	ld	s9,24(sp)
 1c2:	6d42                	ld	s10,16(sp)
 1c4:	6165                	addi	sp,sp,112
 1c6:	8082                	ret

00000000000001c8 <stat>:

int stat(const char *n, struct stat *st)
{
 1c8:	1101                	addi	sp,sp,-32
 1ca:	ec06                	sd	ra,24(sp)
 1cc:	e822                	sd	s0,16(sp)
 1ce:	e04a                	sd	s2,0(sp)
 1d0:	1000                	addi	s0,sp,32
 1d2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d4:	4581                	li	a1,0
 1d6:	242000ef          	jal	418 <open>
  if (fd < 0)
 1da:	02054263          	bltz	a0,1fe <stat+0x36>
 1de:	e426                	sd	s1,8(sp)
 1e0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1e2:	85ca                	mv	a1,s2
 1e4:	24c000ef          	jal	430 <fstat>
 1e8:	892a                	mv	s2,a0
  close(fd);
 1ea:	8526                	mv	a0,s1
 1ec:	214000ef          	jal	400 <close>
  return r;
 1f0:	64a2                	ld	s1,8(sp)
}
 1f2:	854a                	mv	a0,s2
 1f4:	60e2                	ld	ra,24(sp)
 1f6:	6442                	ld	s0,16(sp)
 1f8:	6902                	ld	s2,0(sp)
 1fa:	6105                	addi	sp,sp,32
 1fc:	8082                	ret
    return -1;
 1fe:	597d                	li	s2,-1
 200:	bfcd                	j	1f2 <stat+0x2a>

0000000000000202 <atoi>:

int atoi(const char *s)
{
 202:	1141                	addi	sp,sp,-16
 204:	e406                	sd	ra,8(sp)
 206:	e022                	sd	s0,0(sp)
 208:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 20a:	00054683          	lbu	a3,0(a0)
 20e:	fd06879b          	addiw	a5,a3,-48
 212:	0ff7f793          	zext.b	a5,a5
 216:	4625                	li	a2,9
 218:	02f66963          	bltu	a2,a5,24a <atoi+0x48>
 21c:	872a                	mv	a4,a0
  n = 0;
 21e:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 220:	0705                	addi	a4,a4,1
 222:	0025179b          	slliw	a5,a0,0x2
 226:	9fa9                	addw	a5,a5,a0
 228:	0017979b          	slliw	a5,a5,0x1
 22c:	9fb5                	addw	a5,a5,a3
 22e:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 232:	00074683          	lbu	a3,0(a4)
 236:	fd06879b          	addiw	a5,a3,-48
 23a:	0ff7f793          	zext.b	a5,a5
 23e:	fef671e3          	bgeu	a2,a5,220 <atoi+0x1e>
  return n;
}
 242:	60a2                	ld	ra,8(sp)
 244:	6402                	ld	s0,0(sp)
 246:	0141                	addi	sp,sp,16
 248:	8082                	ret
  n = 0;
 24a:	4501                	li	a0,0
 24c:	bfdd                	j	242 <atoi+0x40>

000000000000024e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 24e:	1141                	addi	sp,sp,-16
 250:	e406                	sd	ra,8(sp)
 252:	e022                	sd	s0,0(sp)
 254:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 256:	02b57563          	bgeu	a0,a1,280 <memmove+0x32>
  {
    while (n-- > 0)
 25a:	00c05f63          	blez	a2,278 <memmove+0x2a>
 25e:	1602                	slli	a2,a2,0x20
 260:	9201                	srli	a2,a2,0x20
 262:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 266:	872a                	mv	a4,a0
      *dst++ = *src++;
 268:	0585                	addi	a1,a1,1
 26a:	0705                	addi	a4,a4,1
 26c:	fff5c683          	lbu	a3,-1(a1)
 270:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 274:	fee79ae3          	bne	a5,a4,268 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 278:	60a2                	ld	ra,8(sp)
 27a:	6402                	ld	s0,0(sp)
 27c:	0141                	addi	sp,sp,16
 27e:	8082                	ret
    dst += n;
 280:	00c50733          	add	a4,a0,a2
    src += n;
 284:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 286:	fec059e3          	blez	a2,278 <memmove+0x2a>
 28a:	fff6079b          	addiw	a5,a2,-1
 28e:	1782                	slli	a5,a5,0x20
 290:	9381                	srli	a5,a5,0x20
 292:	fff7c793          	not	a5,a5
 296:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 298:	15fd                	addi	a1,a1,-1
 29a:	177d                	addi	a4,a4,-1
 29c:	0005c683          	lbu	a3,0(a1)
 2a0:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 2a4:	fef71ae3          	bne	a4,a5,298 <memmove+0x4a>
 2a8:	bfc1                	j	278 <memmove+0x2a>

00000000000002aa <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 2b2:	ca0d                	beqz	a2,2e4 <memcmp+0x3a>
 2b4:	fff6069b          	addiw	a3,a2,-1
 2b8:	1682                	slli	a3,a3,0x20
 2ba:	9281                	srli	a3,a3,0x20
 2bc:	0685                	addi	a3,a3,1
 2be:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	0005c703          	lbu	a4,0(a1)
 2c8:	00e79863          	bne	a5,a4,2d8 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 2cc:	0505                	addi	a0,a0,1
    p2++;
 2ce:	0585                	addi	a1,a1,1
  while (n-- > 0)
 2d0:	fed518e3          	bne	a0,a3,2c0 <memcmp+0x16>
  }
  return 0;
 2d4:	4501                	li	a0,0
 2d6:	a019                	j	2dc <memcmp+0x32>
      return *p1 - *p2;
 2d8:	40e7853b          	subw	a0,a5,a4
}
 2dc:	60a2                	ld	ra,8(sp)
 2de:	6402                	ld	s0,0(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret
  return 0;
 2e4:	4501                	li	a0,0
 2e6:	bfdd                	j	2dc <memcmp+0x32>

00000000000002e8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e406                	sd	ra,8(sp)
 2ec:	e022                	sd	s0,0(sp)
 2ee:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2f0:	f5fff0ef          	jal	24e <memmove>
}
 2f4:	60a2                	ld	ra,8(sp)
 2f6:	6402                	ld	s0,0(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret

00000000000002fc <strcat>:

char *strcat(char *dst, const char *src)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 304:	00054783          	lbu	a5,0(a0)
 308:	c795                	beqz	a5,334 <strcat+0x38>
  char *p = dst;
 30a:	87aa                	mv	a5,a0
    p++;
 30c:	0785                	addi	a5,a5,1
  while (*p)
 30e:	0007c703          	lbu	a4,0(a5)
 312:	ff6d                	bnez	a4,30c <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 314:	0005c703          	lbu	a4,0(a1)
 318:	cb01                	beqz	a4,328 <strcat+0x2c>
  {
    *p = *src;
 31a:	00e78023          	sb	a4,0(a5)
    p++;
 31e:	0785                	addi	a5,a5,1
    src++;
 320:	0585                	addi	a1,a1,1
  while (*src)
 322:	0005c703          	lbu	a4,0(a1)
 326:	fb75                	bnez	a4,31a <strcat+0x1e>
  }

  *p = 0;
 328:	00078023          	sb	zero,0(a5)

  return dst;
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  char *p = dst;
 334:	87aa                	mv	a5,a0
 336:	bff9                	j	314 <strcat+0x18>

0000000000000338 <isdir>:

int isdir(char *path)
{
 338:	7179                	addi	sp,sp,-48
 33a:	f406                	sd	ra,40(sp)
 33c:	f022                	sd	s0,32(sp)
 33e:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 340:	fd840593          	addi	a1,s0,-40
 344:	e85ff0ef          	jal	1c8 <stat>
 348:	00054b63          	bltz	a0,35e <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 34c:	fe041503          	lh	a0,-32(s0)
 350:	157d                	addi	a0,a0,-1
 352:	00153513          	seqz	a0,a0
}
 356:	70a2                	ld	ra,40(sp)
 358:	7402                	ld	s0,32(sp)
 35a:	6145                	addi	sp,sp,48
 35c:	8082                	ret
    return 0;
 35e:	4501                	li	a0,0
 360:	bfdd                	j	356 <isdir+0x1e>

0000000000000362 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 362:	7139                	addi	sp,sp,-64
 364:	fc06                	sd	ra,56(sp)
 366:	f822                	sd	s0,48(sp)
 368:	f426                	sd	s1,40(sp)
 36a:	f04a                	sd	s2,32(sp)
 36c:	ec4e                	sd	s3,24(sp)
 36e:	e852                	sd	s4,16(sp)
 370:	e456                	sd	s5,8(sp)
 372:	0080                	addi	s0,sp,64
 374:	89aa                	mv	s3,a0
 376:	8aae                	mv	s5,a1
 378:	84b2                	mv	s1,a2
 37a:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 37c:	d4dff0ef          	jal	c8 <strlen>
 380:	892a                	mv	s2,a0
  int nn = strlen(filename);
 382:	8556                	mv	a0,s5
 384:	d45ff0ef          	jal	c8 <strlen>
  int need = dn + 1 + nn + 1;
 388:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 38c:	9fa9                	addw	a5,a5,a0
    return 0;
 38e:	4501                	li	a0,0
  if (need > bufsize)
 390:	0347d763          	bge	a5,s4,3be <joinpath+0x5c>
  strcpy(out_buffer, dir);
 394:	85ce                	mv	a1,s3
 396:	8526                	mv	a0,s1
 398:	ce1ff0ef          	jal	78 <strcpy>
  if (dir[dn - 1] != '/')
 39c:	99ca                	add	s3,s3,s2
 39e:	fff9c703          	lbu	a4,-1(s3)
 3a2:	02f00793          	li	a5,47
 3a6:	00f70763          	beq	a4,a5,3b4 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 3aa:	9926                	add	s2,s2,s1
 3ac:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 3b0:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 3b4:	85d6                	mv	a1,s5
 3b6:	8526                	mv	a0,s1
 3b8:	f45ff0ef          	jal	2fc <strcat>
  return out_buffer;
 3bc:	8526                	mv	a0,s1
}
 3be:	70e2                	ld	ra,56(sp)
 3c0:	7442                	ld	s0,48(sp)
 3c2:	74a2                	ld	s1,40(sp)
 3c4:	7902                	ld	s2,32(sp)
 3c6:	69e2                	ld	s3,24(sp)
 3c8:	6a42                	ld	s4,16(sp)
 3ca:	6aa2                	ld	s5,8(sp)
 3cc:	6121                	addi	sp,sp,64
 3ce:	8082                	ret

00000000000003d0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d0:	4885                	li	a7,1
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3d8:	4889                	li	a7,2
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e0:	488d                	li	a7,3
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3e8:	4891                	li	a7,4
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <read>:
.global read
read:
 li a7, SYS_read
 3f0:	4895                	li	a7,5
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <write>:
.global write
write:
 li a7, SYS_write
 3f8:	48c1                	li	a7,16
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <close>:
.global close
close:
 li a7, SYS_close
 400:	48d5                	li	a7,21
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <kill>:
.global kill
kill:
 li a7, SYS_kill
 408:	4899                	li	a7,6
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <exec>:
.global exec
exec:
 li a7, SYS_exec
 410:	489d                	li	a7,7
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <open>:
.global open
open:
 li a7, SYS_open
 418:	48bd                	li	a7,15
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 420:	48c5                	li	a7,17
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 428:	48c9                	li	a7,18
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 430:	48a1                	li	a7,8
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <link>:
.global link
link:
 li a7, SYS_link
 438:	48cd                	li	a7,19
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 440:	48d1                	li	a7,20
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 448:	48a5                	li	a7,9
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <dup>:
.global dup
dup:
 li a7, SYS_dup
 450:	48a9                	li	a7,10
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 458:	48ad                	li	a7,11
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 460:	48b1                	li	a7,12
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 468:	48b5                	li	a7,13
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 470:	48b9                	li	a7,14
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 478:	48d9                	li	a7,22
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 480:	1101                	addi	sp,sp,-32
 482:	ec06                	sd	ra,24(sp)
 484:	e822                	sd	s0,16(sp)
 486:	1000                	addi	s0,sp,32
 488:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 48c:	4605                	li	a2,1
 48e:	fef40593          	addi	a1,s0,-17
 492:	f67ff0ef          	jal	3f8 <write>
}
 496:	60e2                	ld	ra,24(sp)
 498:	6442                	ld	s0,16(sp)
 49a:	6105                	addi	sp,sp,32
 49c:	8082                	ret

000000000000049e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49e:	7139                	addi	sp,sp,-64
 4a0:	fc06                	sd	ra,56(sp)
 4a2:	f822                	sd	s0,48(sp)
 4a4:	f426                	sd	s1,40(sp)
 4a6:	f04a                	sd	s2,32(sp)
 4a8:	ec4e                	sd	s3,24(sp)
 4aa:	0080                	addi	s0,sp,64
 4ac:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ae:	c299                	beqz	a3,4b4 <printint+0x16>
 4b0:	0605ce63          	bltz	a1,52c <printint+0x8e>
  neg = 0;
 4b4:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4b6:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4ba:	869a                	mv	a3,t1
  i = 0;
 4bc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4be:	00000817          	auipc	a6,0x0
 4c2:	51280813          	addi	a6,a6,1298 # 9d0 <digits>
 4c6:	88be                	mv	a7,a5
 4c8:	0017851b          	addiw	a0,a5,1
 4cc:	87aa                	mv	a5,a0
 4ce:	02c5f73b          	remuw	a4,a1,a2
 4d2:	1702                	slli	a4,a4,0x20
 4d4:	9301                	srli	a4,a4,0x20
 4d6:	9742                	add	a4,a4,a6
 4d8:	00074703          	lbu	a4,0(a4)
 4dc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4e0:	872e                	mv	a4,a1
 4e2:	02c5d5bb          	divuw	a1,a1,a2
 4e6:	0685                	addi	a3,a3,1
 4e8:	fcc77fe3          	bgeu	a4,a2,4c6 <printint+0x28>
  if(neg)
 4ec:	000e0c63          	beqz	t3,504 <printint+0x66>
    buf[i++] = '-';
 4f0:	fd050793          	addi	a5,a0,-48
 4f4:	00878533          	add	a0,a5,s0
 4f8:	02d00793          	li	a5,45
 4fc:	fef50823          	sb	a5,-16(a0)
 500:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 504:	fff7899b          	addiw	s3,a5,-1
 508:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 50c:	fff4c583          	lbu	a1,-1(s1)
 510:	854a                	mv	a0,s2
 512:	f6fff0ef          	jal	480 <putc>
  while(--i >= 0)
 516:	39fd                	addiw	s3,s3,-1
 518:	14fd                	addi	s1,s1,-1
 51a:	fe09d9e3          	bgez	s3,50c <printint+0x6e>
}
 51e:	70e2                	ld	ra,56(sp)
 520:	7442                	ld	s0,48(sp)
 522:	74a2                	ld	s1,40(sp)
 524:	7902                	ld	s2,32(sp)
 526:	69e2                	ld	s3,24(sp)
 528:	6121                	addi	sp,sp,64
 52a:	8082                	ret
    x = -xx;
 52c:	40b005bb          	negw	a1,a1
    neg = 1;
 530:	4e05                	li	t3,1
    x = -xx;
 532:	b751                	j	4b6 <printint+0x18>

0000000000000534 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 534:	711d                	addi	sp,sp,-96
 536:	ec86                	sd	ra,88(sp)
 538:	e8a2                	sd	s0,80(sp)
 53a:	e4a6                	sd	s1,72(sp)
 53c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53e:	0005c483          	lbu	s1,0(a1)
 542:	26048663          	beqz	s1,7ae <vprintf+0x27a>
 546:	e0ca                	sd	s2,64(sp)
 548:	fc4e                	sd	s3,56(sp)
 54a:	f852                	sd	s4,48(sp)
 54c:	f456                	sd	s5,40(sp)
 54e:	f05a                	sd	s6,32(sp)
 550:	ec5e                	sd	s7,24(sp)
 552:	e862                	sd	s8,16(sp)
 554:	e466                	sd	s9,8(sp)
 556:	8b2a                	mv	s6,a0
 558:	8a2e                	mv	s4,a1
 55a:	8bb2                	mv	s7,a2
  state = 0;
 55c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 55e:	4901                	li	s2,0
 560:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 562:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 566:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 56a:	06c00c93          	li	s9,108
 56e:	a00d                	j	590 <vprintf+0x5c>
        putc(fd, c0);
 570:	85a6                	mv	a1,s1
 572:	855a                	mv	a0,s6
 574:	f0dff0ef          	jal	480 <putc>
 578:	a019                	j	57e <vprintf+0x4a>
    } else if(state == '%'){
 57a:	03598363          	beq	s3,s5,5a0 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 57e:	0019079b          	addiw	a5,s2,1
 582:	893e                	mv	s2,a5
 584:	873e                	mv	a4,a5
 586:	97d2                	add	a5,a5,s4
 588:	0007c483          	lbu	s1,0(a5)
 58c:	20048963          	beqz	s1,79e <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 590:	0004879b          	sext.w	a5,s1
    if(state == 0){
 594:	fe0993e3          	bnez	s3,57a <vprintf+0x46>
      if(c0 == '%'){
 598:	fd579ce3          	bne	a5,s5,570 <vprintf+0x3c>
        state = '%';
 59c:	89be                	mv	s3,a5
 59e:	b7c5                	j	57e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5a0:	00ea06b3          	add	a3,s4,a4
 5a4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5a8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5aa:	c681                	beqz	a3,5b2 <vprintf+0x7e>
 5ac:	9752                	add	a4,a4,s4
 5ae:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5b2:	03878e63          	beq	a5,s8,5ee <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 5b6:	05978863          	beq	a5,s9,606 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ba:	07500713          	li	a4,117
 5be:	0ee78263          	beq	a5,a4,6a2 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5c2:	07800713          	li	a4,120
 5c6:	12e78463          	beq	a5,a4,6ee <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5ca:	07000713          	li	a4,112
 5ce:	14e78963          	beq	a5,a4,720 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 5d2:	07300713          	li	a4,115
 5d6:	18e78863          	beq	a5,a4,766 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5da:	02500713          	li	a4,37
 5de:	04e79463          	bne	a5,a4,626 <vprintf+0xf2>
        putc(fd, '%');
 5e2:	85ba                	mv	a1,a4
 5e4:	855a                	mv	a0,s6
 5e6:	e9bff0ef          	jal	480 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	bf49                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5ee:	008b8493          	addi	s1,s7,8
 5f2:	4685                	li	a3,1
 5f4:	4629                	li	a2,10
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	ea3ff0ef          	jal	49e <printint>
 600:	8ba6                	mv	s7,s1
      state = 0;
 602:	4981                	li	s3,0
 604:	bfad                	j	57e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 606:	06400793          	li	a5,100
 60a:	02f68963          	beq	a3,a5,63c <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 60e:	06c00793          	li	a5,108
 612:	04f68263          	beq	a3,a5,656 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 616:	07500793          	li	a5,117
 61a:	0af68063          	beq	a3,a5,6ba <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 61e:	07800793          	li	a5,120
 622:	0ef68263          	beq	a3,a5,706 <vprintf+0x1d2>
        putc(fd, '%');
 626:	02500593          	li	a1,37
 62a:	855a                	mv	a0,s6
 62c:	e55ff0ef          	jal	480 <putc>
        putc(fd, c0);
 630:	85a6                	mv	a1,s1
 632:	855a                	mv	a0,s6
 634:	e4dff0ef          	jal	480 <putc>
      state = 0;
 638:	4981                	li	s3,0
 63a:	b791                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 63c:	008b8493          	addi	s1,s7,8
 640:	4685                	li	a3,1
 642:	4629                	li	a2,10
 644:	000ba583          	lw	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	e55ff0ef          	jal	49e <printint>
        i += 1;
 64e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
        i += 1;
 654:	b72d                	j	57e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 656:	06400793          	li	a5,100
 65a:	02f60763          	beq	a2,a5,688 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 65e:	07500793          	li	a5,117
 662:	06f60963          	beq	a2,a5,6d4 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 666:	07800793          	li	a5,120
 66a:	faf61ee3          	bne	a2,a5,626 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 66e:	008b8493          	addi	s1,s7,8
 672:	4681                	li	a3,0
 674:	4641                	li	a2,16
 676:	000ba583          	lw	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	e23ff0ef          	jal	49e <printint>
        i += 2;
 680:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 682:	8ba6                	mv	s7,s1
      state = 0;
 684:	4981                	li	s3,0
        i += 2;
 686:	bde5                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 688:	008b8493          	addi	s1,s7,8
 68c:	4685                	li	a3,1
 68e:	4629                	li	a2,10
 690:	000ba583          	lw	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	e09ff0ef          	jal	49e <printint>
        i += 2;
 69a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 69c:	8ba6                	mv	s7,s1
      state = 0;
 69e:	4981                	li	s3,0
        i += 2;
 6a0:	bdf9                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 6a2:	008b8493          	addi	s1,s7,8
 6a6:	4681                	li	a3,0
 6a8:	4629                	li	a2,10
 6aa:	000ba583          	lw	a1,0(s7)
 6ae:	855a                	mv	a0,s6
 6b0:	defff0ef          	jal	49e <printint>
 6b4:	8ba6                	mv	s7,s1
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b5d9                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ba:	008b8493          	addi	s1,s7,8
 6be:	4681                	li	a3,0
 6c0:	4629                	li	a2,10
 6c2:	000ba583          	lw	a1,0(s7)
 6c6:	855a                	mv	a0,s6
 6c8:	dd7ff0ef          	jal	49e <printint>
        i += 1;
 6cc:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	8ba6                	mv	s7,s1
      state = 0;
 6d0:	4981                	li	s3,0
        i += 1;
 6d2:	b575                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b8493          	addi	s1,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000ba583          	lw	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	dbdff0ef          	jal	49e <printint>
        i += 2;
 6e6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e8:	8ba6                	mv	s7,s1
      state = 0;
 6ea:	4981                	li	s3,0
        i += 2;
 6ec:	bd49                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 6ee:	008b8493          	addi	s1,s7,8
 6f2:	4681                	li	a3,0
 6f4:	4641                	li	a2,16
 6f6:	000ba583          	lw	a1,0(s7)
 6fa:	855a                	mv	a0,s6
 6fc:	da3ff0ef          	jal	49e <printint>
 700:	8ba6                	mv	s7,s1
      state = 0;
 702:	4981                	li	s3,0
 704:	bdad                	j	57e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 706:	008b8493          	addi	s1,s7,8
 70a:	4681                	li	a3,0
 70c:	4641                	li	a2,16
 70e:	000ba583          	lw	a1,0(s7)
 712:	855a                	mv	a0,s6
 714:	d8bff0ef          	jal	49e <printint>
        i += 1;
 718:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 71a:	8ba6                	mv	s7,s1
      state = 0;
 71c:	4981                	li	s3,0
        i += 1;
 71e:	b585                	j	57e <vprintf+0x4a>
 720:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 722:	008b8d13          	addi	s10,s7,8
 726:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 72a:	03000593          	li	a1,48
 72e:	855a                	mv	a0,s6
 730:	d51ff0ef          	jal	480 <putc>
  putc(fd, 'x');
 734:	07800593          	li	a1,120
 738:	855a                	mv	a0,s6
 73a:	d47ff0ef          	jal	480 <putc>
 73e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 740:	00000b97          	auipc	s7,0x0
 744:	290b8b93          	addi	s7,s7,656 # 9d0 <digits>
 748:	03c9d793          	srli	a5,s3,0x3c
 74c:	97de                	add	a5,a5,s7
 74e:	0007c583          	lbu	a1,0(a5)
 752:	855a                	mv	a0,s6
 754:	d2dff0ef          	jal	480 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 758:	0992                	slli	s3,s3,0x4
 75a:	34fd                	addiw	s1,s1,-1
 75c:	f4f5                	bnez	s1,748 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 75e:	8bea                	mv	s7,s10
      state = 0;
 760:	4981                	li	s3,0
 762:	6d02                	ld	s10,0(sp)
 764:	bd29                	j	57e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 766:	008b8993          	addi	s3,s7,8
 76a:	000bb483          	ld	s1,0(s7)
 76e:	cc91                	beqz	s1,78a <vprintf+0x256>
        for(; *s; s++)
 770:	0004c583          	lbu	a1,0(s1)
 774:	c195                	beqz	a1,798 <vprintf+0x264>
          putc(fd, *s);
 776:	855a                	mv	a0,s6
 778:	d09ff0ef          	jal	480 <putc>
        for(; *s; s++)
 77c:	0485                	addi	s1,s1,1
 77e:	0004c583          	lbu	a1,0(s1)
 782:	f9f5                	bnez	a1,776 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 784:	8bce                	mv	s7,s3
      state = 0;
 786:	4981                	li	s3,0
 788:	bbdd                	j	57e <vprintf+0x4a>
          s = "(null)";
 78a:	00000497          	auipc	s1,0x0
 78e:	23e48493          	addi	s1,s1,574 # 9c8 <malloc+0x12e>
        for(; *s; s++)
 792:	02800593          	li	a1,40
 796:	b7c5                	j	776 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 798:	8bce                	mv	s7,s3
      state = 0;
 79a:	4981                	li	s3,0
 79c:	b3cd                	j	57e <vprintf+0x4a>
 79e:	6906                	ld	s2,64(sp)
 7a0:	79e2                	ld	s3,56(sp)
 7a2:	7a42                	ld	s4,48(sp)
 7a4:	7aa2                	ld	s5,40(sp)
 7a6:	7b02                	ld	s6,32(sp)
 7a8:	6be2                	ld	s7,24(sp)
 7aa:	6c42                	ld	s8,16(sp)
 7ac:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7ae:	60e6                	ld	ra,88(sp)
 7b0:	6446                	ld	s0,80(sp)
 7b2:	64a6                	ld	s1,72(sp)
 7b4:	6125                	addi	sp,sp,96
 7b6:	8082                	ret

00000000000007b8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b8:	715d                	addi	sp,sp,-80
 7ba:	ec06                	sd	ra,24(sp)
 7bc:	e822                	sd	s0,16(sp)
 7be:	1000                	addi	s0,sp,32
 7c0:	e010                	sd	a2,0(s0)
 7c2:	e414                	sd	a3,8(s0)
 7c4:	e818                	sd	a4,16(s0)
 7c6:	ec1c                	sd	a5,24(s0)
 7c8:	03043023          	sd	a6,32(s0)
 7cc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7d0:	8622                	mv	a2,s0
 7d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d6:	d5fff0ef          	jal	534 <vprintf>
}
 7da:	60e2                	ld	ra,24(sp)
 7dc:	6442                	ld	s0,16(sp)
 7de:	6161                	addi	sp,sp,80
 7e0:	8082                	ret

00000000000007e2 <printf>:

void
printf(const char *fmt, ...)
{
 7e2:	711d                	addi	sp,sp,-96
 7e4:	ec06                	sd	ra,24(sp)
 7e6:	e822                	sd	s0,16(sp)
 7e8:	1000                	addi	s0,sp,32
 7ea:	e40c                	sd	a1,8(s0)
 7ec:	e810                	sd	a2,16(s0)
 7ee:	ec14                	sd	a3,24(s0)
 7f0:	f018                	sd	a4,32(s0)
 7f2:	f41c                	sd	a5,40(s0)
 7f4:	03043823          	sd	a6,48(s0)
 7f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7fc:	00840613          	addi	a2,s0,8
 800:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 804:	85aa                	mv	a1,a0
 806:	4505                	li	a0,1
 808:	d2dff0ef          	jal	534 <vprintf>
}
 80c:	60e2                	ld	ra,24(sp)
 80e:	6442                	ld	s0,16(sp)
 810:	6125                	addi	sp,sp,96
 812:	8082                	ret

0000000000000814 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 814:	1141                	addi	sp,sp,-16
 816:	e406                	sd	ra,8(sp)
 818:	e022                	sd	s0,0(sp)
 81a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 81c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 820:	00000797          	auipc	a5,0x0
 824:	7e07b783          	ld	a5,2016(a5) # 1000 <freep>
 828:	a02d                	j	852 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 82a:	4618                	lw	a4,8(a2)
 82c:	9f2d                	addw	a4,a4,a1
 82e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 832:	6398                	ld	a4,0(a5)
 834:	6310                	ld	a2,0(a4)
 836:	a83d                	j	874 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 838:	ff852703          	lw	a4,-8(a0)
 83c:	9f31                	addw	a4,a4,a2
 83e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 840:	ff053683          	ld	a3,-16(a0)
 844:	a091                	j	888 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 846:	6398                	ld	a4,0(a5)
 848:	00e7e463          	bltu	a5,a4,850 <free+0x3c>
 84c:	00e6ea63          	bltu	a3,a4,860 <free+0x4c>
{
 850:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 852:	fed7fae3          	bgeu	a5,a3,846 <free+0x32>
 856:	6398                	ld	a4,0(a5)
 858:	00e6e463          	bltu	a3,a4,860 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85c:	fee7eae3          	bltu	a5,a4,850 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 860:	ff852583          	lw	a1,-8(a0)
 864:	6390                	ld	a2,0(a5)
 866:	02059813          	slli	a6,a1,0x20
 86a:	01c85713          	srli	a4,a6,0x1c
 86e:	9736                	add	a4,a4,a3
 870:	fae60de3          	beq	a2,a4,82a <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 874:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 878:	4790                	lw	a2,8(a5)
 87a:	02061593          	slli	a1,a2,0x20
 87e:	01c5d713          	srli	a4,a1,0x1c
 882:	973e                	add	a4,a4,a5
 884:	fae68ae3          	beq	a3,a4,838 <free+0x24>
    p->s.ptr = bp->s.ptr;
 888:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 88a:	00000717          	auipc	a4,0x0
 88e:	76f73b23          	sd	a5,1910(a4) # 1000 <freep>
}
 892:	60a2                	ld	ra,8(sp)
 894:	6402                	ld	s0,0(sp)
 896:	0141                	addi	sp,sp,16
 898:	8082                	ret

000000000000089a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 89a:	7139                	addi	sp,sp,-64
 89c:	fc06                	sd	ra,56(sp)
 89e:	f822                	sd	s0,48(sp)
 8a0:	f04a                	sd	s2,32(sp)
 8a2:	ec4e                	sd	s3,24(sp)
 8a4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a6:	02051993          	slli	s3,a0,0x20
 8aa:	0209d993          	srli	s3,s3,0x20
 8ae:	09bd                	addi	s3,s3,15
 8b0:	0049d993          	srli	s3,s3,0x4
 8b4:	2985                	addiw	s3,s3,1
 8b6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8b8:	00000517          	auipc	a0,0x0
 8bc:	74853503          	ld	a0,1864(a0) # 1000 <freep>
 8c0:	c905                	beqz	a0,8f0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c4:	4798                	lw	a4,8(a5)
 8c6:	09377663          	bgeu	a4,s3,952 <malloc+0xb8>
 8ca:	f426                	sd	s1,40(sp)
 8cc:	e852                	sd	s4,16(sp)
 8ce:	e456                	sd	s5,8(sp)
 8d0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8d2:	8a4e                	mv	s4,s3
 8d4:	6705                	lui	a4,0x1
 8d6:	00e9f363          	bgeu	s3,a4,8dc <malloc+0x42>
 8da:	6a05                	lui	s4,0x1
 8dc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8e0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e4:	00000497          	auipc	s1,0x0
 8e8:	71c48493          	addi	s1,s1,1820 # 1000 <freep>
  if(p == (char*)-1)
 8ec:	5afd                	li	s5,-1
 8ee:	a83d                	j	92c <malloc+0x92>
 8f0:	f426                	sd	s1,40(sp)
 8f2:	e852                	sd	s4,16(sp)
 8f4:	e456                	sd	s5,8(sp)
 8f6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8f8:	00000797          	auipc	a5,0x0
 8fc:	71878793          	addi	a5,a5,1816 # 1010 <base>
 900:	00000717          	auipc	a4,0x0
 904:	70f73023          	sd	a5,1792(a4) # 1000 <freep>
 908:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 90a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 90e:	b7d1                	j	8d2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 910:	6398                	ld	a4,0(a5)
 912:	e118                	sd	a4,0(a0)
 914:	a899                	j	96a <malloc+0xd0>
  hp->s.size = nu;
 916:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 91a:	0541                	addi	a0,a0,16
 91c:	ef9ff0ef          	jal	814 <free>
  return freep;
 920:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 922:	c125                	beqz	a0,982 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 924:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 926:	4798                	lw	a4,8(a5)
 928:	03277163          	bgeu	a4,s2,94a <malloc+0xb0>
    if(p == freep)
 92c:	6098                	ld	a4,0(s1)
 92e:	853e                	mv	a0,a5
 930:	fef71ae3          	bne	a4,a5,924 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 934:	8552                	mv	a0,s4
 936:	b2bff0ef          	jal	460 <sbrk>
  if(p == (char*)-1)
 93a:	fd551ee3          	bne	a0,s5,916 <malloc+0x7c>
        return 0;
 93e:	4501                	li	a0,0
 940:	74a2                	ld	s1,40(sp)
 942:	6a42                	ld	s4,16(sp)
 944:	6aa2                	ld	s5,8(sp)
 946:	6b02                	ld	s6,0(sp)
 948:	a03d                	j	976 <malloc+0xdc>
 94a:	74a2                	ld	s1,40(sp)
 94c:	6a42                	ld	s4,16(sp)
 94e:	6aa2                	ld	s5,8(sp)
 950:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 952:	fae90fe3          	beq	s2,a4,910 <malloc+0x76>
        p->s.size -= nunits;
 956:	4137073b          	subw	a4,a4,s3
 95a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 95c:	02071693          	slli	a3,a4,0x20
 960:	01c6d713          	srli	a4,a3,0x1c
 964:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 966:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 96a:	00000717          	auipc	a4,0x0
 96e:	68a73b23          	sd	a0,1686(a4) # 1000 <freep>
      return (void*)(p + 1);
 972:	01078513          	addi	a0,a5,16
  }
}
 976:	70e2                	ld	ra,56(sp)
 978:	7442                	ld	s0,48(sp)
 97a:	7902                	ld	s2,32(sp)
 97c:	69e2                	ld	s3,24(sp)
 97e:	6121                	addi	sp,sp,64
 980:	8082                	ret
 982:	74a2                	ld	s1,40(sp)
 984:	6a42                	ld	s4,16(sp)
 986:	6aa2                	ld	s5,8(sp)
 988:	6b02                	ld	s6,0(sp)
 98a:	b7f5                	j	976 <malloc+0xdc>
