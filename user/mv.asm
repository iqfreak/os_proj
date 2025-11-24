
user/_mv:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

/*mv src dst*/
int main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	1c00                	addi	s0,sp,560
  if (argc != 3)
   e:	478d                	li	a5,3
  10:	02f50463          	beq	a0,a5,38 <main+0x38>
  14:	20913c23          	sd	s1,536(sp)
  18:	21213823          	sd	s2,528(sp)
  1c:	21313423          	sd	s3,520(sp)
  20:	21413023          	sd	s4,512(sp)
  {
    fprintf(2, "mv: Incorrect usage, mv src dst\n");
  24:	00001597          	auipc	a1,0x1
  28:	a3c58593          	addi	a1,a1,-1476 # a60 <malloc+0xf6>
  2c:	4509                	li	a0,2
  2e:	05b000ef          	jal	888 <fprintf>
    exit(1);
  32:	4505                	li	a0,1
  34:	474000ef          	jal	4a8 <exit>
  38:	20913c23          	sd	s1,536(sp)
  3c:	21213823          	sd	s2,528(sp)
  40:	21313423          	sd	s3,520(sp)
  44:	21413023          	sd	s4,512(sp)
  48:	84ae                	mv	s1,a1
  }

  char *src = argv[1];
  4a:	0085b903          	ld	s2,8(a1)
  int is_src_dir = isdir(src);
  4e:	854a                	mv	a0,s2
  50:	3b8000ef          	jal	408 <isdir>
  54:	89aa                	mv	s3,a0
  char *dst = argv[2];
  56:	0104ba03          	ld	s4,16(s1)
  int is_dst_dir = isdir(dst);
  5a:	8552                	mv	a0,s4
  5c:	3ac000ef          	jal	408 <isdir>
  60:	84aa                	mv	s1,a0

  char dst_path[500];
  strcpy(dst_path, dst);
  62:	85d2                	mv	a1,s4
  64:	dd840513          	addi	a0,s0,-552
  68:	0e0000ef          	jal	148 <strcpy>
  char *filename = src;

  // Dir to dir
  if (is_src_dir)
  6c:	02099a63          	bnez	s3,a0 <main+0xa0>
  {
    printf("mv: direcotry to directory isn't implemented yet\n");
    exit(0);
  }

  for (char *p = src; *p; p++)
  70:	00094703          	lbu	a4,0(s2)
  74:	00190793          	addi	a5,s2,1
  char *filename = src;
  78:	89ca                	mv	s3,s2
  {
    if (*p == '/')
  7a:	02f00693          	li	a3,47
  for (char *p = src; *p; p++)
  7e:	ef15                	bnez	a4,ba <main+0xba>
      filename = p + 1;
  }

  // File to File
  if (!is_src_dir && is_dst_dir)
  80:	e0a9                	bnez	s1,c2 <main+0xc2>
  {
    joinpath(dst, filename, dst_path, sizeof(dst_path));
    printf("New path: %s, %s\n", filename, dst_path);
  }

  if (link(src, dst_path) < 0)
  82:	dd840593          	addi	a1,s0,-552
  86:	854a                	mv	a0,s2
  88:	480000ef          	jal	508 <link>
  8c:	04054d63          	bltz	a0,e6 <main+0xe6>
  {
    fprintf(2, "mv: link src %s to dst %s failed\n", src, dst_path);
    exit(1);
  }

  if (unlink(src) < 0)
  90:	854a                	mv	a0,s2
  92:	466000ef          	jal	4f8 <unlink>
  96:	06054563          	bltz	a0,100 <main+0x100>
      fprintf(2, "mv: rollback failed for %s\n", dst_path);
    }
    exit(1);
  }

  exit(0);
  9a:	4501                	li	a0,0
  9c:	40c000ef          	jal	4a8 <exit>
    printf("mv: direcotry to directory isn't implemented yet\n");
  a0:	00001517          	auipc	a0,0x1
  a4:	9e850513          	addi	a0,a0,-1560 # a88 <malloc+0x11e>
  a8:	00b000ef          	jal	8b2 <printf>
    exit(0);
  ac:	4501                	li	a0,0
  ae:	3fa000ef          	jal	4a8 <exit>
  for (char *p = src; *p; p++)
  b2:	0785                	addi	a5,a5,1
  b4:	fff7c703          	lbu	a4,-1(a5)
  b8:	d761                	beqz	a4,80 <main+0x80>
    if (*p == '/')
  ba:	fed71ce3          	bne	a4,a3,b2 <main+0xb2>
      filename = p + 1;
  be:	89be                	mv	s3,a5
  c0:	bfcd                	j	b2 <main+0xb2>
    joinpath(dst, filename, dst_path, sizeof(dst_path));
  c2:	dd840493          	addi	s1,s0,-552
  c6:	1f400693          	li	a3,500
  ca:	8626                	mv	a2,s1
  cc:	85ce                	mv	a1,s3
  ce:	8552                	mv	a0,s4
  d0:	362000ef          	jal	432 <joinpath>
    printf("New path: %s, %s\n", filename, dst_path);
  d4:	8626                	mv	a2,s1
  d6:	85ce                	mv	a1,s3
  d8:	00001517          	auipc	a0,0x1
  dc:	9e850513          	addi	a0,a0,-1560 # ac0 <malloc+0x156>
  e0:	7d2000ef          	jal	8b2 <printf>
  e4:	bf79                	j	82 <main+0x82>
    fprintf(2, "mv: link src %s to dst %s failed\n", src, dst_path);
  e6:	dd840693          	addi	a3,s0,-552
  ea:	864a                	mv	a2,s2
  ec:	00001597          	auipc	a1,0x1
  f0:	9ec58593          	addi	a1,a1,-1556 # ad8 <malloc+0x16e>
  f4:	4509                	li	a0,2
  f6:	792000ef          	jal	888 <fprintf>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	3ac000ef          	jal	4a8 <exit>
    fprintf(2, "mv: unlink %s failed\n", src);
 100:	864a                	mv	a2,s2
 102:	00001597          	auipc	a1,0x1
 106:	9fe58593          	addi	a1,a1,-1538 # b00 <malloc+0x196>
 10a:	4509                	li	a0,2
 10c:	77c000ef          	jal	888 <fprintf>
    if (unlink(dst_path) < 0)
 110:	dd840513          	addi	a0,s0,-552
 114:	3e4000ef          	jal	4f8 <unlink>
 118:	00054563          	bltz	a0,122 <main+0x122>
    exit(1);
 11c:	4505                	li	a0,1
 11e:	38a000ef          	jal	4a8 <exit>
      fprintf(2, "mv: rollback failed for %s\n", dst_path);
 122:	dd840613          	addi	a2,s0,-552
 126:	00001597          	auipc	a1,0x1
 12a:	9f258593          	addi	a1,a1,-1550 # b18 <malloc+0x1ae>
 12e:	4509                	li	a0,2
 130:	758000ef          	jal	888 <fprintf>
 134:	b7e5                	j	11c <main+0x11c>

0000000000000136 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
 136:	1141                	addi	sp,sp,-16
 138:	e406                	sd	ra,8(sp)
 13a:	e022                	sd	s0,0(sp)
 13c:	0800                	addi	s0,sp,16
  extern int main();
  main();
 13e:	ec3ff0ef          	jal	0 <main>
  exit(0);
 142:	4501                	li	a0,0
 144:	364000ef          	jal	4a8 <exit>

0000000000000148 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e406                	sd	ra,8(sp)
 14c:	e022                	sd	s0,0(sp)
 14e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 150:	87aa                	mv	a5,a0
 152:	0585                	addi	a1,a1,1
 154:	0785                	addi	a5,a5,1
 156:	fff5c703          	lbu	a4,-1(a1)
 15a:	fee78fa3          	sb	a4,-1(a5)
 15e:	fb75                	bnez	a4,152 <strcpy+0xa>
    ;
  return os;
}
 160:	60a2                	ld	ra,8(sp)
 162:	6402                	ld	s0,0(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <strcmp>:

int strcmp(const char *p, const char *q)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e406                	sd	ra,8(sp)
 16c:	e022                	sd	s0,0(sp)
 16e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 170:	00054783          	lbu	a5,0(a0)
 174:	cb91                	beqz	a5,188 <strcmp+0x20>
 176:	0005c703          	lbu	a4,0(a1)
 17a:	00f71763          	bne	a4,a5,188 <strcmp+0x20>
    p++, q++;
 17e:	0505                	addi	a0,a0,1
 180:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 182:	00054783          	lbu	a5,0(a0)
 186:	fbe5                	bnez	a5,176 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 188:	0005c503          	lbu	a0,0(a1)
}
 18c:	40a7853b          	subw	a0,a5,a0
 190:	60a2                	ld	ra,8(sp)
 192:	6402                	ld	s0,0(sp)
 194:	0141                	addi	sp,sp,16
 196:	8082                	ret

0000000000000198 <strlen>:

uint strlen(const char *s)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e406                	sd	ra,8(sp)
 19c:	e022                	sd	s0,0(sp)
 19e:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	cf99                	beqz	a5,1c2 <strlen+0x2a>
 1a6:	0505                	addi	a0,a0,1
 1a8:	87aa                	mv	a5,a0
 1aa:	86be                	mv	a3,a5
 1ac:	0785                	addi	a5,a5,1
 1ae:	fff7c703          	lbu	a4,-1(a5)
 1b2:	ff65                	bnez	a4,1aa <strlen+0x12>
 1b4:	40a6853b          	subw	a0,a3,a0
 1b8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1ba:	60a2                	ld	ra,8(sp)
 1bc:	6402                	ld	s0,0(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret
  for (n = 0; s[n]; n++)
 1c2:	4501                	li	a0,0
 1c4:	bfdd                	j	1ba <strlen+0x22>

00000000000001c6 <memset>:

void *
memset(void *dst, int c, uint n)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e406                	sd	ra,8(sp)
 1ca:	e022                	sd	s0,0(sp)
 1cc:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 1ce:	ca19                	beqz	a2,1e4 <memset+0x1e>
 1d0:	87aa                	mv	a5,a0
 1d2:	1602                	slli	a2,a2,0x20
 1d4:	9201                	srli	a2,a2,0x20
 1d6:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 1da:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 1de:	0785                	addi	a5,a5,1
 1e0:	fee79de3          	bne	a5,a4,1da <memset+0x14>
  }
  return dst;
}
 1e4:	60a2                	ld	ra,8(sp)
 1e6:	6402                	ld	s0,0(sp)
 1e8:	0141                	addi	sp,sp,16
 1ea:	8082                	ret

00000000000001ec <strchr>:

char *
strchr(const char *s, char c)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e406                	sd	ra,8(sp)
 1f0:	e022                	sd	s0,0(sp)
 1f2:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1f4:	00054783          	lbu	a5,0(a0)
 1f8:	cf81                	beqz	a5,210 <strchr+0x24>
    if (*s == c)
 1fa:	00f58763          	beq	a1,a5,208 <strchr+0x1c>
  for (; *s; s++)
 1fe:	0505                	addi	a0,a0,1
 200:	00054783          	lbu	a5,0(a0)
 204:	fbfd                	bnez	a5,1fa <strchr+0xe>
      return (char *)s;
  return 0;
 206:	4501                	li	a0,0
}
 208:	60a2                	ld	ra,8(sp)
 20a:	6402                	ld	s0,0(sp)
 20c:	0141                	addi	sp,sp,16
 20e:	8082                	ret
  return 0;
 210:	4501                	li	a0,0
 212:	bfdd                	j	208 <strchr+0x1c>

0000000000000214 <gets>:

char *
gets(char *buf, int max)
{
 214:	7159                	addi	sp,sp,-112
 216:	f486                	sd	ra,104(sp)
 218:	f0a2                	sd	s0,96(sp)
 21a:	eca6                	sd	s1,88(sp)
 21c:	e8ca                	sd	s2,80(sp)
 21e:	e4ce                	sd	s3,72(sp)
 220:	e0d2                	sd	s4,64(sp)
 222:	fc56                	sd	s5,56(sp)
 224:	f85a                	sd	s6,48(sp)
 226:	f45e                	sd	s7,40(sp)
 228:	f062                	sd	s8,32(sp)
 22a:	ec66                	sd	s9,24(sp)
 22c:	e86a                	sd	s10,16(sp)
 22e:	1880                	addi	s0,sp,112
 230:	8caa                	mv	s9,a0
 232:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 234:	892a                	mv	s2,a0
 236:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 238:	f9f40b13          	addi	s6,s0,-97
 23c:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 23e:	4ba9                	li	s7,10
 240:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 242:	8d26                	mv	s10,s1
 244:	0014899b          	addiw	s3,s1,1
 248:	84ce                	mv	s1,s3
 24a:	0349d563          	bge	s3,s4,274 <gets+0x60>
    cc = read(0, &c, 1);
 24e:	8656                	mv	a2,s5
 250:	85da                	mv	a1,s6
 252:	4501                	li	a0,0
 254:	26c000ef          	jal	4c0 <read>
    if (cc < 1)
 258:	00a05e63          	blez	a0,274 <gets+0x60>
    buf[i++] = c;
 25c:	f9f44783          	lbu	a5,-97(s0)
 260:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 264:	01778763          	beq	a5,s7,272 <gets+0x5e>
 268:	0905                	addi	s2,s2,1
 26a:	fd879ce3          	bne	a5,s8,242 <gets+0x2e>
    buf[i++] = c;
 26e:	8d4e                	mv	s10,s3
 270:	a011                	j	274 <gets+0x60>
 272:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 274:	9d66                	add	s10,s10,s9
 276:	000d0023          	sb	zero,0(s10)
  return buf;
}
 27a:	8566                	mv	a0,s9
 27c:	70a6                	ld	ra,104(sp)
 27e:	7406                	ld	s0,96(sp)
 280:	64e6                	ld	s1,88(sp)
 282:	6946                	ld	s2,80(sp)
 284:	69a6                	ld	s3,72(sp)
 286:	6a06                	ld	s4,64(sp)
 288:	7ae2                	ld	s5,56(sp)
 28a:	7b42                	ld	s6,48(sp)
 28c:	7ba2                	ld	s7,40(sp)
 28e:	7c02                	ld	s8,32(sp)
 290:	6ce2                	ld	s9,24(sp)
 292:	6d42                	ld	s10,16(sp)
 294:	6165                	addi	sp,sp,112
 296:	8082                	ret

0000000000000298 <stat>:

int stat(const char *n, struct stat *st)
{
 298:	1101                	addi	sp,sp,-32
 29a:	ec06                	sd	ra,24(sp)
 29c:	e822                	sd	s0,16(sp)
 29e:	e04a                	sd	s2,0(sp)
 2a0:	1000                	addi	s0,sp,32
 2a2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a4:	4581                	li	a1,0
 2a6:	242000ef          	jal	4e8 <open>
  if (fd < 0)
 2aa:	02054263          	bltz	a0,2ce <stat+0x36>
 2ae:	e426                	sd	s1,8(sp)
 2b0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2b2:	85ca                	mv	a1,s2
 2b4:	24c000ef          	jal	500 <fstat>
 2b8:	892a                	mv	s2,a0
  close(fd);
 2ba:	8526                	mv	a0,s1
 2bc:	214000ef          	jal	4d0 <close>
  return r;
 2c0:	64a2                	ld	s1,8(sp)
}
 2c2:	854a                	mv	a0,s2
 2c4:	60e2                	ld	ra,24(sp)
 2c6:	6442                	ld	s0,16(sp)
 2c8:	6902                	ld	s2,0(sp)
 2ca:	6105                	addi	sp,sp,32
 2cc:	8082                	ret
    return -1;
 2ce:	597d                	li	s2,-1
 2d0:	bfcd                	j	2c2 <stat+0x2a>

00000000000002d2 <atoi>:

int atoi(const char *s)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 2da:	00054683          	lbu	a3,0(a0)
 2de:	fd06879b          	addiw	a5,a3,-48
 2e2:	0ff7f793          	zext.b	a5,a5
 2e6:	4625                	li	a2,9
 2e8:	02f66963          	bltu	a2,a5,31a <atoi+0x48>
 2ec:	872a                	mv	a4,a0
  n = 0;
 2ee:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 2f0:	0705                	addi	a4,a4,1
 2f2:	0025179b          	slliw	a5,a0,0x2
 2f6:	9fa9                	addw	a5,a5,a0
 2f8:	0017979b          	slliw	a5,a5,0x1
 2fc:	9fb5                	addw	a5,a5,a3
 2fe:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 302:	00074683          	lbu	a3,0(a4)
 306:	fd06879b          	addiw	a5,a3,-48
 30a:	0ff7f793          	zext.b	a5,a5
 30e:	fef671e3          	bgeu	a2,a5,2f0 <atoi+0x1e>
  return n;
}
 312:	60a2                	ld	ra,8(sp)
 314:	6402                	ld	s0,0(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret
  n = 0;
 31a:	4501                	li	a0,0
 31c:	bfdd                	j	312 <atoi+0x40>

000000000000031e <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 31e:	1141                	addi	sp,sp,-16
 320:	e406                	sd	ra,8(sp)
 322:	e022                	sd	s0,0(sp)
 324:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 326:	02b57563          	bgeu	a0,a1,350 <memmove+0x32>
  {
    while (n-- > 0)
 32a:	00c05f63          	blez	a2,348 <memmove+0x2a>
 32e:	1602                	slli	a2,a2,0x20
 330:	9201                	srli	a2,a2,0x20
 332:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 336:	872a                	mv	a4,a0
      *dst++ = *src++;
 338:	0585                	addi	a1,a1,1
 33a:	0705                	addi	a4,a4,1
 33c:	fff5c683          	lbu	a3,-1(a1)
 340:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 344:	fee79ae3          	bne	a5,a4,338 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
    dst += n;
 350:	00c50733          	add	a4,a0,a2
    src += n;
 354:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 356:	fec059e3          	blez	a2,348 <memmove+0x2a>
 35a:	fff6079b          	addiw	a5,a2,-1
 35e:	1782                	slli	a5,a5,0x20
 360:	9381                	srli	a5,a5,0x20
 362:	fff7c793          	not	a5,a5
 366:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 368:	15fd                	addi	a1,a1,-1
 36a:	177d                	addi	a4,a4,-1
 36c:	0005c683          	lbu	a3,0(a1)
 370:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 374:	fef71ae3          	bne	a4,a5,368 <memmove+0x4a>
 378:	bfc1                	j	348 <memmove+0x2a>

000000000000037a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 37a:	1141                	addi	sp,sp,-16
 37c:	e406                	sd	ra,8(sp)
 37e:	e022                	sd	s0,0(sp)
 380:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 382:	ca0d                	beqz	a2,3b4 <memcmp+0x3a>
 384:	fff6069b          	addiw	a3,a2,-1
 388:	1682                	slli	a3,a3,0x20
 38a:	9281                	srli	a3,a3,0x20
 38c:	0685                	addi	a3,a3,1
 38e:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 390:	00054783          	lbu	a5,0(a0)
 394:	0005c703          	lbu	a4,0(a1)
 398:	00e79863          	bne	a5,a4,3a8 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 39c:	0505                	addi	a0,a0,1
    p2++;
 39e:	0585                	addi	a1,a1,1
  while (n-- > 0)
 3a0:	fed518e3          	bne	a0,a3,390 <memcmp+0x16>
  }
  return 0;
 3a4:	4501                	li	a0,0
 3a6:	a019                	j	3ac <memcmp+0x32>
      return *p1 - *p2;
 3a8:	40e7853b          	subw	a0,a5,a4
}
 3ac:	60a2                	ld	ra,8(sp)
 3ae:	6402                	ld	s0,0(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret
  return 0;
 3b4:	4501                	li	a0,0
 3b6:	bfdd                	j	3ac <memcmp+0x32>

00000000000003b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3b8:	1141                	addi	sp,sp,-16
 3ba:	e406                	sd	ra,8(sp)
 3bc:	e022                	sd	s0,0(sp)
 3be:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3c0:	f5fff0ef          	jal	31e <memmove>
}
 3c4:	60a2                	ld	ra,8(sp)
 3c6:	6402                	ld	s0,0(sp)
 3c8:	0141                	addi	sp,sp,16
 3ca:	8082                	ret

00000000000003cc <strcat>:

char *strcat(char *dst, const char *src)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e406                	sd	ra,8(sp)
 3d0:	e022                	sd	s0,0(sp)
 3d2:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 3d4:	00054783          	lbu	a5,0(a0)
 3d8:	c795                	beqz	a5,404 <strcat+0x38>
  char *p = dst;
 3da:	87aa                	mv	a5,a0
    p++;
 3dc:	0785                	addi	a5,a5,1
  while (*p)
 3de:	0007c703          	lbu	a4,0(a5)
 3e2:	ff6d                	bnez	a4,3dc <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 3e4:	0005c703          	lbu	a4,0(a1)
 3e8:	cb01                	beqz	a4,3f8 <strcat+0x2c>
  {
    *p = *src;
 3ea:	00e78023          	sb	a4,0(a5)
    p++;
 3ee:	0785                	addi	a5,a5,1
    src++;
 3f0:	0585                	addi	a1,a1,1
  while (*src)
 3f2:	0005c703          	lbu	a4,0(a1)
 3f6:	fb75                	bnez	a4,3ea <strcat+0x1e>
  }

  *p = 0;
 3f8:	00078023          	sb	zero,0(a5)

  return dst;
}
 3fc:	60a2                	ld	ra,8(sp)
 3fe:	6402                	ld	s0,0(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret
  char *p = dst;
 404:	87aa                	mv	a5,a0
 406:	bff9                	j	3e4 <strcat+0x18>

0000000000000408 <isdir>:

int isdir(char *path)
{
 408:	7179                	addi	sp,sp,-48
 40a:	f406                	sd	ra,40(sp)
 40c:	f022                	sd	s0,32(sp)
 40e:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 410:	fd840593          	addi	a1,s0,-40
 414:	e85ff0ef          	jal	298 <stat>
 418:	00054b63          	bltz	a0,42e <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 41c:	fe041503          	lh	a0,-32(s0)
 420:	157d                	addi	a0,a0,-1
 422:	00153513          	seqz	a0,a0
}
 426:	70a2                	ld	ra,40(sp)
 428:	7402                	ld	s0,32(sp)
 42a:	6145                	addi	sp,sp,48
 42c:	8082                	ret
    return 0;
 42e:	4501                	li	a0,0
 430:	bfdd                	j	426 <isdir+0x1e>

0000000000000432 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 432:	7139                	addi	sp,sp,-64
 434:	fc06                	sd	ra,56(sp)
 436:	f822                	sd	s0,48(sp)
 438:	f426                	sd	s1,40(sp)
 43a:	f04a                	sd	s2,32(sp)
 43c:	ec4e                	sd	s3,24(sp)
 43e:	e852                	sd	s4,16(sp)
 440:	e456                	sd	s5,8(sp)
 442:	0080                	addi	s0,sp,64
 444:	89aa                	mv	s3,a0
 446:	8aae                	mv	s5,a1
 448:	84b2                	mv	s1,a2
 44a:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 44c:	d4dff0ef          	jal	198 <strlen>
 450:	892a                	mv	s2,a0
  int nn = strlen(filename);
 452:	8556                	mv	a0,s5
 454:	d45ff0ef          	jal	198 <strlen>
  int need = dn + 1 + nn + 1;
 458:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 45c:	9fa9                	addw	a5,a5,a0
    return 0;
 45e:	4501                	li	a0,0
  if (need > bufsize)
 460:	0347d763          	bge	a5,s4,48e <joinpath+0x5c>
  strcpy(out_buffer, dir);
 464:	85ce                	mv	a1,s3
 466:	8526                	mv	a0,s1
 468:	ce1ff0ef          	jal	148 <strcpy>
  if (dir[dn - 1] != '/')
 46c:	99ca                	add	s3,s3,s2
 46e:	fff9c703          	lbu	a4,-1(s3)
 472:	02f00793          	li	a5,47
 476:	00f70763          	beq	a4,a5,484 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 47a:	9926                	add	s2,s2,s1
 47c:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 480:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 484:	85d6                	mv	a1,s5
 486:	8526                	mv	a0,s1
 488:	f45ff0ef          	jal	3cc <strcat>
  return out_buffer;
 48c:	8526                	mv	a0,s1
}
 48e:	70e2                	ld	ra,56(sp)
 490:	7442                	ld	s0,48(sp)
 492:	74a2                	ld	s1,40(sp)
 494:	7902                	ld	s2,32(sp)
 496:	69e2                	ld	s3,24(sp)
 498:	6a42                	ld	s4,16(sp)
 49a:	6aa2                	ld	s5,8(sp)
 49c:	6121                	addi	sp,sp,64
 49e:	8082                	ret

00000000000004a0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4a0:	4885                	li	a7,1
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4a8:	4889                	li	a7,2
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4b0:	488d                	li	a7,3
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4b8:	4891                	li	a7,4
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <read>:
.global read
read:
 li a7, SYS_read
 4c0:	4895                	li	a7,5
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <write>:
.global write
write:
 li a7, SYS_write
 4c8:	48c1                	li	a7,16
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <close>:
.global close
close:
 li a7, SYS_close
 4d0:	48d5                	li	a7,21
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4d8:	4899                	li	a7,6
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4e0:	489d                	li	a7,7
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <open>:
.global open
open:
 li a7, SYS_open
 4e8:	48bd                	li	a7,15
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4f0:	48c5                	li	a7,17
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4f8:	48c9                	li	a7,18
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 500:	48a1                	li	a7,8
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <link>:
.global link
link:
 li a7, SYS_link
 508:	48cd                	li	a7,19
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 510:	48d1                	li	a7,20
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 518:	48a5                	li	a7,9
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <dup>:
.global dup
dup:
 li a7, SYS_dup
 520:	48a9                	li	a7,10
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 528:	48ad                	li	a7,11
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 530:	48b1                	li	a7,12
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 538:	48b5                	li	a7,13
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 540:	48b9                	li	a7,14
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 548:	48d9                	li	a7,22
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 550:	1101                	addi	sp,sp,-32
 552:	ec06                	sd	ra,24(sp)
 554:	e822                	sd	s0,16(sp)
 556:	1000                	addi	s0,sp,32
 558:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 55c:	4605                	li	a2,1
 55e:	fef40593          	addi	a1,s0,-17
 562:	f67ff0ef          	jal	4c8 <write>
}
 566:	60e2                	ld	ra,24(sp)
 568:	6442                	ld	s0,16(sp)
 56a:	6105                	addi	sp,sp,32
 56c:	8082                	ret

000000000000056e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 56e:	7139                	addi	sp,sp,-64
 570:	fc06                	sd	ra,56(sp)
 572:	f822                	sd	s0,48(sp)
 574:	f426                	sd	s1,40(sp)
 576:	f04a                	sd	s2,32(sp)
 578:	ec4e                	sd	s3,24(sp)
 57a:	0080                	addi	s0,sp,64
 57c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57e:	c299                	beqz	a3,584 <printint+0x16>
 580:	0605ce63          	bltz	a1,5fc <printint+0x8e>
  neg = 0;
 584:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 586:	fc040313          	addi	t1,s0,-64
  neg = 0;
 58a:	869a                	mv	a3,t1
  i = 0;
 58c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 58e:	00000817          	auipc	a6,0x0
 592:	5b280813          	addi	a6,a6,1458 # b40 <digits>
 596:	88be                	mv	a7,a5
 598:	0017851b          	addiw	a0,a5,1
 59c:	87aa                	mv	a5,a0
 59e:	02c5f73b          	remuw	a4,a1,a2
 5a2:	1702                	slli	a4,a4,0x20
 5a4:	9301                	srli	a4,a4,0x20
 5a6:	9742                	add	a4,a4,a6
 5a8:	00074703          	lbu	a4,0(a4)
 5ac:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5b0:	872e                	mv	a4,a1
 5b2:	02c5d5bb          	divuw	a1,a1,a2
 5b6:	0685                	addi	a3,a3,1
 5b8:	fcc77fe3          	bgeu	a4,a2,596 <printint+0x28>
  if(neg)
 5bc:	000e0c63          	beqz	t3,5d4 <printint+0x66>
    buf[i++] = '-';
 5c0:	fd050793          	addi	a5,a0,-48
 5c4:	00878533          	add	a0,a5,s0
 5c8:	02d00793          	li	a5,45
 5cc:	fef50823          	sb	a5,-16(a0)
 5d0:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 5d4:	fff7899b          	addiw	s3,a5,-1
 5d8:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 5dc:	fff4c583          	lbu	a1,-1(s1)
 5e0:	854a                	mv	a0,s2
 5e2:	f6fff0ef          	jal	550 <putc>
  while(--i >= 0)
 5e6:	39fd                	addiw	s3,s3,-1
 5e8:	14fd                	addi	s1,s1,-1
 5ea:	fe09d9e3          	bgez	s3,5dc <printint+0x6e>
}
 5ee:	70e2                	ld	ra,56(sp)
 5f0:	7442                	ld	s0,48(sp)
 5f2:	74a2                	ld	s1,40(sp)
 5f4:	7902                	ld	s2,32(sp)
 5f6:	69e2                	ld	s3,24(sp)
 5f8:	6121                	addi	sp,sp,64
 5fa:	8082                	ret
    x = -xx;
 5fc:	40b005bb          	negw	a1,a1
    neg = 1;
 600:	4e05                	li	t3,1
    x = -xx;
 602:	b751                	j	586 <printint+0x18>

0000000000000604 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 604:	711d                	addi	sp,sp,-96
 606:	ec86                	sd	ra,88(sp)
 608:	e8a2                	sd	s0,80(sp)
 60a:	e4a6                	sd	s1,72(sp)
 60c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 60e:	0005c483          	lbu	s1,0(a1)
 612:	26048663          	beqz	s1,87e <vprintf+0x27a>
 616:	e0ca                	sd	s2,64(sp)
 618:	fc4e                	sd	s3,56(sp)
 61a:	f852                	sd	s4,48(sp)
 61c:	f456                	sd	s5,40(sp)
 61e:	f05a                	sd	s6,32(sp)
 620:	ec5e                	sd	s7,24(sp)
 622:	e862                	sd	s8,16(sp)
 624:	e466                	sd	s9,8(sp)
 626:	8b2a                	mv	s6,a0
 628:	8a2e                	mv	s4,a1
 62a:	8bb2                	mv	s7,a2
  state = 0;
 62c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 62e:	4901                	li	s2,0
 630:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 632:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 636:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 63a:	06c00c93          	li	s9,108
 63e:	a00d                	j	660 <vprintf+0x5c>
        putc(fd, c0);
 640:	85a6                	mv	a1,s1
 642:	855a                	mv	a0,s6
 644:	f0dff0ef          	jal	550 <putc>
 648:	a019                	j	64e <vprintf+0x4a>
    } else if(state == '%'){
 64a:	03598363          	beq	s3,s5,670 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 64e:	0019079b          	addiw	a5,s2,1
 652:	893e                	mv	s2,a5
 654:	873e                	mv	a4,a5
 656:	97d2                	add	a5,a5,s4
 658:	0007c483          	lbu	s1,0(a5)
 65c:	20048963          	beqz	s1,86e <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 660:	0004879b          	sext.w	a5,s1
    if(state == 0){
 664:	fe0993e3          	bnez	s3,64a <vprintf+0x46>
      if(c0 == '%'){
 668:	fd579ce3          	bne	a5,s5,640 <vprintf+0x3c>
        state = '%';
 66c:	89be                	mv	s3,a5
 66e:	b7c5                	j	64e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 670:	00ea06b3          	add	a3,s4,a4
 674:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 678:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 67a:	c681                	beqz	a3,682 <vprintf+0x7e>
 67c:	9752                	add	a4,a4,s4
 67e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 682:	03878e63          	beq	a5,s8,6be <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 686:	05978863          	beq	a5,s9,6d6 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 68a:	07500713          	li	a4,117
 68e:	0ee78263          	beq	a5,a4,772 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 692:	07800713          	li	a4,120
 696:	12e78463          	beq	a5,a4,7be <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 69a:	07000713          	li	a4,112
 69e:	14e78963          	beq	a5,a4,7f0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 6a2:	07300713          	li	a4,115
 6a6:	18e78863          	beq	a5,a4,836 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6aa:	02500713          	li	a4,37
 6ae:	04e79463          	bne	a5,a4,6f6 <vprintf+0xf2>
        putc(fd, '%');
 6b2:	85ba                	mv	a1,a4
 6b4:	855a                	mv	a0,s6
 6b6:	e9bff0ef          	jal	550 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bf49                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4685                	li	a3,1
 6c4:	4629                	li	a2,10
 6c6:	000ba583          	lw	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	ea3ff0ef          	jal	56e <printint>
 6d0:	8ba6                	mv	s7,s1
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bfad                	j	64e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6d6:	06400793          	li	a5,100
 6da:	02f68963          	beq	a3,a5,70c <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6de:	06c00793          	li	a5,108
 6e2:	04f68263          	beq	a3,a5,726 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 6e6:	07500793          	li	a5,117
 6ea:	0af68063          	beq	a3,a5,78a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 6ee:	07800793          	li	a5,120
 6f2:	0ef68263          	beq	a3,a5,7d6 <vprintf+0x1d2>
        putc(fd, '%');
 6f6:	02500593          	li	a1,37
 6fa:	855a                	mv	a0,s6
 6fc:	e55ff0ef          	jal	550 <putc>
        putc(fd, c0);
 700:	85a6                	mv	a1,s1
 702:	855a                	mv	a0,s6
 704:	e4dff0ef          	jal	550 <putc>
      state = 0;
 708:	4981                	li	s3,0
 70a:	b791                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 70c:	008b8493          	addi	s1,s7,8
 710:	4685                	li	a3,1
 712:	4629                	li	a2,10
 714:	000ba583          	lw	a1,0(s7)
 718:	855a                	mv	a0,s6
 71a:	e55ff0ef          	jal	56e <printint>
        i += 1;
 71e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 720:	8ba6                	mv	s7,s1
      state = 0;
 722:	4981                	li	s3,0
        i += 1;
 724:	b72d                	j	64e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 726:	06400793          	li	a5,100
 72a:	02f60763          	beq	a2,a5,758 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 72e:	07500793          	li	a5,117
 732:	06f60963          	beq	a2,a5,7a4 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 736:	07800793          	li	a5,120
 73a:	faf61ee3          	bne	a2,a5,6f6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 73e:	008b8493          	addi	s1,s7,8
 742:	4681                	li	a3,0
 744:	4641                	li	a2,16
 746:	000ba583          	lw	a1,0(s7)
 74a:	855a                	mv	a0,s6
 74c:	e23ff0ef          	jal	56e <printint>
        i += 2;
 750:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 752:	8ba6                	mv	s7,s1
      state = 0;
 754:	4981                	li	s3,0
        i += 2;
 756:	bde5                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 758:	008b8493          	addi	s1,s7,8
 75c:	4685                	li	a3,1
 75e:	4629                	li	a2,10
 760:	000ba583          	lw	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	e09ff0ef          	jal	56e <printint>
        i += 2;
 76a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 76c:	8ba6                	mv	s7,s1
      state = 0;
 76e:	4981                	li	s3,0
        i += 2;
 770:	bdf9                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 772:	008b8493          	addi	s1,s7,8
 776:	4681                	li	a3,0
 778:	4629                	li	a2,10
 77a:	000ba583          	lw	a1,0(s7)
 77e:	855a                	mv	a0,s6
 780:	defff0ef          	jal	56e <printint>
 784:	8ba6                	mv	s7,s1
      state = 0;
 786:	4981                	li	s3,0
 788:	b5d9                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 78a:	008b8493          	addi	s1,s7,8
 78e:	4681                	li	a3,0
 790:	4629                	li	a2,10
 792:	000ba583          	lw	a1,0(s7)
 796:	855a                	mv	a0,s6
 798:	dd7ff0ef          	jal	56e <printint>
        i += 1;
 79c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 79e:	8ba6                	mv	s7,s1
      state = 0;
 7a0:	4981                	li	s3,0
        i += 1;
 7a2:	b575                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a4:	008b8493          	addi	s1,s7,8
 7a8:	4681                	li	a3,0
 7aa:	4629                	li	a2,10
 7ac:	000ba583          	lw	a1,0(s7)
 7b0:	855a                	mv	a0,s6
 7b2:	dbdff0ef          	jal	56e <printint>
        i += 2;
 7b6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b8:	8ba6                	mv	s7,s1
      state = 0;
 7ba:	4981                	li	s3,0
        i += 2;
 7bc:	bd49                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 7be:	008b8493          	addi	s1,s7,8
 7c2:	4681                	li	a3,0
 7c4:	4641                	li	a2,16
 7c6:	000ba583          	lw	a1,0(s7)
 7ca:	855a                	mv	a0,s6
 7cc:	da3ff0ef          	jal	56e <printint>
 7d0:	8ba6                	mv	s7,s1
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	bdad                	j	64e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d6:	008b8493          	addi	s1,s7,8
 7da:	4681                	li	a3,0
 7dc:	4641                	li	a2,16
 7de:	000ba583          	lw	a1,0(s7)
 7e2:	855a                	mv	a0,s6
 7e4:	d8bff0ef          	jal	56e <printint>
        i += 1;
 7e8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ea:	8ba6                	mv	s7,s1
      state = 0;
 7ec:	4981                	li	s3,0
        i += 1;
 7ee:	b585                	j	64e <vprintf+0x4a>
 7f0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7f2:	008b8d13          	addi	s10,s7,8
 7f6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7fa:	03000593          	li	a1,48
 7fe:	855a                	mv	a0,s6
 800:	d51ff0ef          	jal	550 <putc>
  putc(fd, 'x');
 804:	07800593          	li	a1,120
 808:	855a                	mv	a0,s6
 80a:	d47ff0ef          	jal	550 <putc>
 80e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 810:	00000b97          	auipc	s7,0x0
 814:	330b8b93          	addi	s7,s7,816 # b40 <digits>
 818:	03c9d793          	srli	a5,s3,0x3c
 81c:	97de                	add	a5,a5,s7
 81e:	0007c583          	lbu	a1,0(a5)
 822:	855a                	mv	a0,s6
 824:	d2dff0ef          	jal	550 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 828:	0992                	slli	s3,s3,0x4
 82a:	34fd                	addiw	s1,s1,-1
 82c:	f4f5                	bnez	s1,818 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 82e:	8bea                	mv	s7,s10
      state = 0;
 830:	4981                	li	s3,0
 832:	6d02                	ld	s10,0(sp)
 834:	bd29                	j	64e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 836:	008b8993          	addi	s3,s7,8
 83a:	000bb483          	ld	s1,0(s7)
 83e:	cc91                	beqz	s1,85a <vprintf+0x256>
        for(; *s; s++)
 840:	0004c583          	lbu	a1,0(s1)
 844:	c195                	beqz	a1,868 <vprintf+0x264>
          putc(fd, *s);
 846:	855a                	mv	a0,s6
 848:	d09ff0ef          	jal	550 <putc>
        for(; *s; s++)
 84c:	0485                	addi	s1,s1,1
 84e:	0004c583          	lbu	a1,0(s1)
 852:	f9f5                	bnez	a1,846 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 854:	8bce                	mv	s7,s3
      state = 0;
 856:	4981                	li	s3,0
 858:	bbdd                	j	64e <vprintf+0x4a>
          s = "(null)";
 85a:	00000497          	auipc	s1,0x0
 85e:	2de48493          	addi	s1,s1,734 # b38 <malloc+0x1ce>
        for(; *s; s++)
 862:	02800593          	li	a1,40
 866:	b7c5                	j	846 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 868:	8bce                	mv	s7,s3
      state = 0;
 86a:	4981                	li	s3,0
 86c:	b3cd                	j	64e <vprintf+0x4a>
 86e:	6906                	ld	s2,64(sp)
 870:	79e2                	ld	s3,56(sp)
 872:	7a42                	ld	s4,48(sp)
 874:	7aa2                	ld	s5,40(sp)
 876:	7b02                	ld	s6,32(sp)
 878:	6be2                	ld	s7,24(sp)
 87a:	6c42                	ld	s8,16(sp)
 87c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 87e:	60e6                	ld	ra,88(sp)
 880:	6446                	ld	s0,80(sp)
 882:	64a6                	ld	s1,72(sp)
 884:	6125                	addi	sp,sp,96
 886:	8082                	ret

0000000000000888 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 888:	715d                	addi	sp,sp,-80
 88a:	ec06                	sd	ra,24(sp)
 88c:	e822                	sd	s0,16(sp)
 88e:	1000                	addi	s0,sp,32
 890:	e010                	sd	a2,0(s0)
 892:	e414                	sd	a3,8(s0)
 894:	e818                	sd	a4,16(s0)
 896:	ec1c                	sd	a5,24(s0)
 898:	03043023          	sd	a6,32(s0)
 89c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8a0:	8622                	mv	a2,s0
 8a2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a6:	d5fff0ef          	jal	604 <vprintf>
}
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	6161                	addi	sp,sp,80
 8b0:	8082                	ret

00000000000008b2 <printf>:

void
printf(const char *fmt, ...)
{
 8b2:	711d                	addi	sp,sp,-96
 8b4:	ec06                	sd	ra,24(sp)
 8b6:	e822                	sd	s0,16(sp)
 8b8:	1000                	addi	s0,sp,32
 8ba:	e40c                	sd	a1,8(s0)
 8bc:	e810                	sd	a2,16(s0)
 8be:	ec14                	sd	a3,24(s0)
 8c0:	f018                	sd	a4,32(s0)
 8c2:	f41c                	sd	a5,40(s0)
 8c4:	03043823          	sd	a6,48(s0)
 8c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8cc:	00840613          	addi	a2,s0,8
 8d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d4:	85aa                	mv	a1,a0
 8d6:	4505                	li	a0,1
 8d8:	d2dff0ef          	jal	604 <vprintf>
}
 8dc:	60e2                	ld	ra,24(sp)
 8de:	6442                	ld	s0,16(sp)
 8e0:	6125                	addi	sp,sp,96
 8e2:	8082                	ret

00000000000008e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e4:	1141                	addi	sp,sp,-16
 8e6:	e406                	sd	ra,8(sp)
 8e8:	e022                	sd	s0,0(sp)
 8ea:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ec:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	00001797          	auipc	a5,0x1
 8f4:	7107b783          	ld	a5,1808(a5) # 2000 <freep>
 8f8:	a02d                	j	922 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fa:	4618                	lw	a4,8(a2)
 8fc:	9f2d                	addw	a4,a4,a1
 8fe:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 902:	6398                	ld	a4,0(a5)
 904:	6310                	ld	a2,0(a4)
 906:	a83d                	j	944 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 908:	ff852703          	lw	a4,-8(a0)
 90c:	9f31                	addw	a4,a4,a2
 90e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 910:	ff053683          	ld	a3,-16(a0)
 914:	a091                	j	958 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 916:	6398                	ld	a4,0(a5)
 918:	00e7e463          	bltu	a5,a4,920 <free+0x3c>
 91c:	00e6ea63          	bltu	a3,a4,930 <free+0x4c>
{
 920:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 922:	fed7fae3          	bgeu	a5,a3,916 <free+0x32>
 926:	6398                	ld	a4,0(a5)
 928:	00e6e463          	bltu	a3,a4,930 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92c:	fee7eae3          	bltu	a5,a4,920 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 930:	ff852583          	lw	a1,-8(a0)
 934:	6390                	ld	a2,0(a5)
 936:	02059813          	slli	a6,a1,0x20
 93a:	01c85713          	srli	a4,a6,0x1c
 93e:	9736                	add	a4,a4,a3
 940:	fae60de3          	beq	a2,a4,8fa <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 944:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 948:	4790                	lw	a2,8(a5)
 94a:	02061593          	slli	a1,a2,0x20
 94e:	01c5d713          	srli	a4,a1,0x1c
 952:	973e                	add	a4,a4,a5
 954:	fae68ae3          	beq	a3,a4,908 <free+0x24>
    p->s.ptr = bp->s.ptr;
 958:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 95a:	00001717          	auipc	a4,0x1
 95e:	6af73323          	sd	a5,1702(a4) # 2000 <freep>
}
 962:	60a2                	ld	ra,8(sp)
 964:	6402                	ld	s0,0(sp)
 966:	0141                	addi	sp,sp,16
 968:	8082                	ret

000000000000096a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 96a:	7139                	addi	sp,sp,-64
 96c:	fc06                	sd	ra,56(sp)
 96e:	f822                	sd	s0,48(sp)
 970:	f04a                	sd	s2,32(sp)
 972:	ec4e                	sd	s3,24(sp)
 974:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 976:	02051993          	slli	s3,a0,0x20
 97a:	0209d993          	srli	s3,s3,0x20
 97e:	09bd                	addi	s3,s3,15
 980:	0049d993          	srli	s3,s3,0x4
 984:	2985                	addiw	s3,s3,1
 986:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 988:	00001517          	auipc	a0,0x1
 98c:	67853503          	ld	a0,1656(a0) # 2000 <freep>
 990:	c905                	beqz	a0,9c0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 992:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 994:	4798                	lw	a4,8(a5)
 996:	09377663          	bgeu	a4,s3,a22 <malloc+0xb8>
 99a:	f426                	sd	s1,40(sp)
 99c:	e852                	sd	s4,16(sp)
 99e:	e456                	sd	s5,8(sp)
 9a0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9a2:	8a4e                	mv	s4,s3
 9a4:	6705                	lui	a4,0x1
 9a6:	00e9f363          	bgeu	s3,a4,9ac <malloc+0x42>
 9aa:	6a05                	lui	s4,0x1
 9ac:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9b0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b4:	00001497          	auipc	s1,0x1
 9b8:	64c48493          	addi	s1,s1,1612 # 2000 <freep>
  if(p == (char*)-1)
 9bc:	5afd                	li	s5,-1
 9be:	a83d                	j	9fc <malloc+0x92>
 9c0:	f426                	sd	s1,40(sp)
 9c2:	e852                	sd	s4,16(sp)
 9c4:	e456                	sd	s5,8(sp)
 9c6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9c8:	00001797          	auipc	a5,0x1
 9cc:	64878793          	addi	a5,a5,1608 # 2010 <base>
 9d0:	00001717          	auipc	a4,0x1
 9d4:	62f73823          	sd	a5,1584(a4) # 2000 <freep>
 9d8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9da:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9de:	b7d1                	j	9a2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9e0:	6398                	ld	a4,0(a5)
 9e2:	e118                	sd	a4,0(a0)
 9e4:	a899                	j	a3a <malloc+0xd0>
  hp->s.size = nu;
 9e6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ea:	0541                	addi	a0,a0,16
 9ec:	ef9ff0ef          	jal	8e4 <free>
  return freep;
 9f0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9f2:	c125                	beqz	a0,a52 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9f6:	4798                	lw	a4,8(a5)
 9f8:	03277163          	bgeu	a4,s2,a1a <malloc+0xb0>
    if(p == freep)
 9fc:	6098                	ld	a4,0(s1)
 9fe:	853e                	mv	a0,a5
 a00:	fef71ae3          	bne	a4,a5,9f4 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 a04:	8552                	mv	a0,s4
 a06:	b2bff0ef          	jal	530 <sbrk>
  if(p == (char*)-1)
 a0a:	fd551ee3          	bne	a0,s5,9e6 <malloc+0x7c>
        return 0;
 a0e:	4501                	li	a0,0
 a10:	74a2                	ld	s1,40(sp)
 a12:	6a42                	ld	s4,16(sp)
 a14:	6aa2                	ld	s5,8(sp)
 a16:	6b02                	ld	s6,0(sp)
 a18:	a03d                	j	a46 <malloc+0xdc>
 a1a:	74a2                	ld	s1,40(sp)
 a1c:	6a42                	ld	s4,16(sp)
 a1e:	6aa2                	ld	s5,8(sp)
 a20:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a22:	fae90fe3          	beq	s2,a4,9e0 <malloc+0x76>
        p->s.size -= nunits;
 a26:	4137073b          	subw	a4,a4,s3
 a2a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a2c:	02071693          	slli	a3,a4,0x20
 a30:	01c6d713          	srli	a4,a3,0x1c
 a34:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a36:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a3a:	00001717          	auipc	a4,0x1
 a3e:	5ca73323          	sd	a0,1478(a4) # 2000 <freep>
      return (void*)(p + 1);
 a42:	01078513          	addi	a0,a5,16
  }
}
 a46:	70e2                	ld	ra,56(sp)
 a48:	7442                	ld	s0,48(sp)
 a4a:	7902                	ld	s2,32(sp)
 a4c:	69e2                	ld	s3,24(sp)
 a4e:	6121                	addi	sp,sp,64
 a50:	8082                	ret
 a52:	74a2                	ld	s1,40(sp)
 a54:	6a42                	ld	s4,16(sp)
 a56:	6aa2                	ld	s5,8(sp)
 a58:	6b02                	ld	s6,0(sp)
 a5a:	b7f5                	j	a46 <malloc+0xdc>
