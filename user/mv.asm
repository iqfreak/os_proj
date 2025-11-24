
user/_mv:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

/*
mv src dst
*/
int main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if (argc != 3)
   8:	478d                	li	a5,3
   a:	00f50c63          	beq	a0,a5,22 <main+0x22>
   e:	e426                	sd	s1,8(sp)
  {
    printf("mv: Incorrect usage, mv src dst\n");
  10:	00001517          	auipc	a0,0x1
  14:	8d050513          	addi	a0,a0,-1840 # 8e0 <malloc+0xfa>
  18:	716000ef          	jal	72e <printf>
    exit(1);
  1c:	4505                	li	a0,1
  1e:	306000ef          	jal	324 <exit>
  22:	e426                	sd	s1,8(sp)
  24:	84ae                	mv	s1,a1
  }

  if (link(argv[1], argv[2]) < 0)
  26:	698c                	ld	a1,16(a1)
  28:	6488                	ld	a0,8(s1)
  2a:	35a000ef          	jal	384 <link>
  2e:	00054a63          	bltz	a0,42 <main+0x42>
  {
    printf("mv: link src %s to dst %s failed\n", argv[1], argv[2]);
    exit(1);
  }

  if (unlink(argv[1]) < 0)
  32:	6488                	ld	a0,8(s1)
  34:	340000ef          	jal	374 <unlink>
  38:	02054063          	bltz	a0,58 <main+0x58>
      printf("mv: rollback failed for %s\n", argv[2]);
    }
    exit(1);
  }

  exit(0);
  3c:	4501                	li	a0,0
  3e:	2e6000ef          	jal	324 <exit>
    printf("mv: link src %s to dst %s failed\n", argv[1], argv[2]);
  42:	6890                	ld	a2,16(s1)
  44:	648c                	ld	a1,8(s1)
  46:	00001517          	auipc	a0,0x1
  4a:	8c250513          	addi	a0,a0,-1854 # 908 <malloc+0x122>
  4e:	6e0000ef          	jal	72e <printf>
    exit(1);
  52:	4505                	li	a0,1
  54:	2d0000ef          	jal	324 <exit>
    printf("mv: unlink %s failed\n", argv[1]);
  58:	648c                	ld	a1,8(s1)
  5a:	00001517          	auipc	a0,0x1
  5e:	8d650513          	addi	a0,a0,-1834 # 930 <malloc+0x14a>
  62:	6cc000ef          	jal	72e <printf>
    if (unlink(argv[2]) < 0)
  66:	6888                	ld	a0,16(s1)
  68:	30c000ef          	jal	374 <unlink>
  6c:	00054563          	bltz	a0,76 <main+0x76>
    exit(1);
  70:	4505                	li	a0,1
  72:	2b2000ef          	jal	324 <exit>
      printf("mv: rollback failed for %s\n", argv[2]);
  76:	688c                	ld	a1,16(s1)
  78:	00001517          	auipc	a0,0x1
  7c:	8d050513          	addi	a0,a0,-1840 # 948 <malloc+0x162>
  80:	6ae000ef          	jal	72e <printf>
  84:	b7f5                	j	70 <main+0x70>

0000000000000086 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  86:	1141                	addi	sp,sp,-16
  88:	e406                	sd	ra,8(sp)
  8a:	e022                	sd	s0,0(sp)
  8c:	0800                	addi	s0,sp,16
  extern int main();
  main();
  8e:	f73ff0ef          	jal	0 <main>
  exit(0);
  92:	4501                	li	a0,0
  94:	290000ef          	jal	324 <exit>

0000000000000098 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  98:	1141                	addi	sp,sp,-16
  9a:	e406                	sd	ra,8(sp)
  9c:	e022                	sd	s0,0(sp)
  9e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a0:	87aa                	mv	a5,a0
  a2:	0585                	addi	a1,a1,1
  a4:	0785                	addi	a5,a5,1
  a6:	fff5c703          	lbu	a4,-1(a1)
  aa:	fee78fa3          	sb	a4,-1(a5)
  ae:	fb75                	bnez	a4,a2 <strcpy+0xa>
    ;
  return os;
}
  b0:	60a2                	ld	ra,8(sp)
  b2:	6402                	ld	s0,0(sp)
  b4:	0141                	addi	sp,sp,16
  b6:	8082                	ret

00000000000000b8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b8:	1141                	addi	sp,sp,-16
  ba:	e406                	sd	ra,8(sp)
  bc:	e022                	sd	s0,0(sp)
  be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	cb91                	beqz	a5,d8 <strcmp+0x20>
  c6:	0005c703          	lbu	a4,0(a1)
  ca:	00f71763          	bne	a4,a5,d8 <strcmp+0x20>
    p++, q++;
  ce:	0505                	addi	a0,a0,1
  d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	fbe5                	bnez	a5,c6 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  d8:	0005c503          	lbu	a0,0(a1)
}
  dc:	40a7853b          	subw	a0,a5,a0
  e0:	60a2                	ld	ra,8(sp)
  e2:	6402                	ld	s0,0(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strlen>:

uint
strlen(const char *s)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e406                	sd	ra,8(sp)
  ec:	e022                	sd	s0,0(sp)
  ee:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f0:	00054783          	lbu	a5,0(a0)
  f4:	cf99                	beqz	a5,112 <strlen+0x2a>
  f6:	0505                	addi	a0,a0,1
  f8:	87aa                	mv	a5,a0
  fa:	86be                	mv	a3,a5
  fc:	0785                	addi	a5,a5,1
  fe:	fff7c703          	lbu	a4,-1(a5)
 102:	ff65                	bnez	a4,fa <strlen+0x12>
 104:	40a6853b          	subw	a0,a3,a0
 108:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 10a:	60a2                	ld	ra,8(sp)
 10c:	6402                	ld	s0,0(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret
  for(n = 0; s[n]; n++)
 112:	4501                	li	a0,0
 114:	bfdd                	j	10a <strlen+0x22>

0000000000000116 <memset>:

void*
memset(void *dst, int c, uint n)
{
 116:	1141                	addi	sp,sp,-16
 118:	e406                	sd	ra,8(sp)
 11a:	e022                	sd	s0,0(sp)
 11c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 11e:	ca19                	beqz	a2,134 <memset+0x1e>
 120:	87aa                	mv	a5,a0
 122:	1602                	slli	a2,a2,0x20
 124:	9201                	srli	a2,a2,0x20
 126:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 12a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 12e:	0785                	addi	a5,a5,1
 130:	fee79de3          	bne	a5,a4,12a <memset+0x14>
  }
  return dst;
}
 134:	60a2                	ld	ra,8(sp)
 136:	6402                	ld	s0,0(sp)
 138:	0141                	addi	sp,sp,16
 13a:	8082                	ret

000000000000013c <strchr>:

char*
strchr(const char *s, char c)
{
 13c:	1141                	addi	sp,sp,-16
 13e:	e406                	sd	ra,8(sp)
 140:	e022                	sd	s0,0(sp)
 142:	0800                	addi	s0,sp,16
  for(; *s; s++)
 144:	00054783          	lbu	a5,0(a0)
 148:	cf81                	beqz	a5,160 <strchr+0x24>
    if(*s == c)
 14a:	00f58763          	beq	a1,a5,158 <strchr+0x1c>
  for(; *s; s++)
 14e:	0505                	addi	a0,a0,1
 150:	00054783          	lbu	a5,0(a0)
 154:	fbfd                	bnez	a5,14a <strchr+0xe>
      return (char*)s;
  return 0;
 156:	4501                	li	a0,0
}
 158:	60a2                	ld	ra,8(sp)
 15a:	6402                	ld	s0,0(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret
  return 0;
 160:	4501                	li	a0,0
 162:	bfdd                	j	158 <strchr+0x1c>

0000000000000164 <gets>:

char*
gets(char *buf, int max)
{
 164:	7159                	addi	sp,sp,-112
 166:	f486                	sd	ra,104(sp)
 168:	f0a2                	sd	s0,96(sp)
 16a:	eca6                	sd	s1,88(sp)
 16c:	e8ca                	sd	s2,80(sp)
 16e:	e4ce                	sd	s3,72(sp)
 170:	e0d2                	sd	s4,64(sp)
 172:	fc56                	sd	s5,56(sp)
 174:	f85a                	sd	s6,48(sp)
 176:	f45e                	sd	s7,40(sp)
 178:	f062                	sd	s8,32(sp)
 17a:	ec66                	sd	s9,24(sp)
 17c:	e86a                	sd	s10,16(sp)
 17e:	1880                	addi	s0,sp,112
 180:	8caa                	mv	s9,a0
 182:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 184:	892a                	mv	s2,a0
 186:	4481                	li	s1,0
    cc = read(0, &c, 1);
 188:	f9f40b13          	addi	s6,s0,-97
 18c:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 18e:	4ba9                	li	s7,10
 190:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 192:	8d26                	mv	s10,s1
 194:	0014899b          	addiw	s3,s1,1
 198:	84ce                	mv	s1,s3
 19a:	0349d563          	bge	s3,s4,1c4 <gets+0x60>
    cc = read(0, &c, 1);
 19e:	8656                	mv	a2,s5
 1a0:	85da                	mv	a1,s6
 1a2:	4501                	li	a0,0
 1a4:	198000ef          	jal	33c <read>
    if(cc < 1)
 1a8:	00a05e63          	blez	a0,1c4 <gets+0x60>
    buf[i++] = c;
 1ac:	f9f44783          	lbu	a5,-97(s0)
 1b0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1b4:	01778763          	beq	a5,s7,1c2 <gets+0x5e>
 1b8:	0905                	addi	s2,s2,1
 1ba:	fd879ce3          	bne	a5,s8,192 <gets+0x2e>
    buf[i++] = c;
 1be:	8d4e                	mv	s10,s3
 1c0:	a011                	j	1c4 <gets+0x60>
 1c2:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1c4:	9d66                	add	s10,s10,s9
 1c6:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1ca:	8566                	mv	a0,s9
 1cc:	70a6                	ld	ra,104(sp)
 1ce:	7406                	ld	s0,96(sp)
 1d0:	64e6                	ld	s1,88(sp)
 1d2:	6946                	ld	s2,80(sp)
 1d4:	69a6                	ld	s3,72(sp)
 1d6:	6a06                	ld	s4,64(sp)
 1d8:	7ae2                	ld	s5,56(sp)
 1da:	7b42                	ld	s6,48(sp)
 1dc:	7ba2                	ld	s7,40(sp)
 1de:	7c02                	ld	s8,32(sp)
 1e0:	6ce2                	ld	s9,24(sp)
 1e2:	6d42                	ld	s10,16(sp)
 1e4:	6165                	addi	sp,sp,112
 1e6:	8082                	ret

00000000000001e8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e04a                	sd	s2,0(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f4:	4581                	li	a1,0
 1f6:	16e000ef          	jal	364 <open>
  if(fd < 0)
 1fa:	02054263          	bltz	a0,21e <stat+0x36>
 1fe:	e426                	sd	s1,8(sp)
 200:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 202:	85ca                	mv	a1,s2
 204:	178000ef          	jal	37c <fstat>
 208:	892a                	mv	s2,a0
  close(fd);
 20a:	8526                	mv	a0,s1
 20c:	140000ef          	jal	34c <close>
  return r;
 210:	64a2                	ld	s1,8(sp)
}
 212:	854a                	mv	a0,s2
 214:	60e2                	ld	ra,24(sp)
 216:	6442                	ld	s0,16(sp)
 218:	6902                	ld	s2,0(sp)
 21a:	6105                	addi	sp,sp,32
 21c:	8082                	ret
    return -1;
 21e:	597d                	li	s2,-1
 220:	bfcd                	j	212 <stat+0x2a>

0000000000000222 <atoi>:

int
atoi(const char *s)
{
 222:	1141                	addi	sp,sp,-16
 224:	e406                	sd	ra,8(sp)
 226:	e022                	sd	s0,0(sp)
 228:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 22a:	00054683          	lbu	a3,0(a0)
 22e:	fd06879b          	addiw	a5,a3,-48
 232:	0ff7f793          	zext.b	a5,a5
 236:	4625                	li	a2,9
 238:	02f66963          	bltu	a2,a5,26a <atoi+0x48>
 23c:	872a                	mv	a4,a0
  n = 0;
 23e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 240:	0705                	addi	a4,a4,1
 242:	0025179b          	slliw	a5,a0,0x2
 246:	9fa9                	addw	a5,a5,a0
 248:	0017979b          	slliw	a5,a5,0x1
 24c:	9fb5                	addw	a5,a5,a3
 24e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 252:	00074683          	lbu	a3,0(a4)
 256:	fd06879b          	addiw	a5,a3,-48
 25a:	0ff7f793          	zext.b	a5,a5
 25e:	fef671e3          	bgeu	a2,a5,240 <atoi+0x1e>
  return n;
}
 262:	60a2                	ld	ra,8(sp)
 264:	6402                	ld	s0,0(sp)
 266:	0141                	addi	sp,sp,16
 268:	8082                	ret
  n = 0;
 26a:	4501                	li	a0,0
 26c:	bfdd                	j	262 <atoi+0x40>

000000000000026e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26e:	1141                	addi	sp,sp,-16
 270:	e406                	sd	ra,8(sp)
 272:	e022                	sd	s0,0(sp)
 274:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 276:	02b57563          	bgeu	a0,a1,2a0 <memmove+0x32>
    while(n-- > 0)
 27a:	00c05f63          	blez	a2,298 <memmove+0x2a>
 27e:	1602                	slli	a2,a2,0x20
 280:	9201                	srli	a2,a2,0x20
 282:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 286:	872a                	mv	a4,a0
      *dst++ = *src++;
 288:	0585                	addi	a1,a1,1
 28a:	0705                	addi	a4,a4,1
 28c:	fff5c683          	lbu	a3,-1(a1)
 290:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 294:	fee79ae3          	bne	a5,a4,288 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
    dst += n;
 2a0:	00c50733          	add	a4,a0,a2
    src += n;
 2a4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2a6:	fec059e3          	blez	a2,298 <memmove+0x2a>
 2aa:	fff6079b          	addiw	a5,a2,-1
 2ae:	1782                	slli	a5,a5,0x20
 2b0:	9381                	srli	a5,a5,0x20
 2b2:	fff7c793          	not	a5,a5
 2b6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2b8:	15fd                	addi	a1,a1,-1
 2ba:	177d                	addi	a4,a4,-1
 2bc:	0005c683          	lbu	a3,0(a1)
 2c0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c4:	fef71ae3          	bne	a4,a5,2b8 <memmove+0x4a>
 2c8:	bfc1                	j	298 <memmove+0x2a>

00000000000002ca <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e406                	sd	ra,8(sp)
 2ce:	e022                	sd	s0,0(sp)
 2d0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d2:	ca0d                	beqz	a2,304 <memcmp+0x3a>
 2d4:	fff6069b          	addiw	a3,a2,-1
 2d8:	1682                	slli	a3,a3,0x20
 2da:	9281                	srli	a3,a3,0x20
 2dc:	0685                	addi	a3,a3,1
 2de:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e0:	00054783          	lbu	a5,0(a0)
 2e4:	0005c703          	lbu	a4,0(a1)
 2e8:	00e79863          	bne	a5,a4,2f8 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2ec:	0505                	addi	a0,a0,1
    p2++;
 2ee:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f0:	fed518e3          	bne	a0,a3,2e0 <memcmp+0x16>
  }
  return 0;
 2f4:	4501                	li	a0,0
 2f6:	a019                	j	2fc <memcmp+0x32>
      return *p1 - *p2;
 2f8:	40e7853b          	subw	a0,a5,a4
}
 2fc:	60a2                	ld	ra,8(sp)
 2fe:	6402                	ld	s0,0(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret
  return 0;
 304:	4501                	li	a0,0
 306:	bfdd                	j	2fc <memcmp+0x32>

0000000000000308 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 310:	f5fff0ef          	jal	26e <memmove>
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret

000000000000031c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 31c:	4885                	li	a7,1
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <exit>:
.global exit
exit:
 li a7, SYS_exit
 324:	4889                	li	a7,2
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <wait>:
.global wait
wait:
 li a7, SYS_wait
 32c:	488d                	li	a7,3
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 334:	4891                	li	a7,4
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <read>:
.global read
read:
 li a7, SYS_read
 33c:	4895                	li	a7,5
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <write>:
.global write
write:
 li a7, SYS_write
 344:	48c1                	li	a7,16
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <close>:
.global close
close:
 li a7, SYS_close
 34c:	48d5                	li	a7,21
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <kill>:
.global kill
kill:
 li a7, SYS_kill
 354:	4899                	li	a7,6
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <exec>:
.global exec
exec:
 li a7, SYS_exec
 35c:	489d                	li	a7,7
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <open>:
.global open
open:
 li a7, SYS_open
 364:	48bd                	li	a7,15
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 36c:	48c5                	li	a7,17
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 374:	48c9                	li	a7,18
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 37c:	48a1                	li	a7,8
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <link>:
.global link
link:
 li a7, SYS_link
 384:	48cd                	li	a7,19
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 38c:	48d1                	li	a7,20
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 394:	48a5                	li	a7,9
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <dup>:
.global dup
dup:
 li a7, SYS_dup
 39c:	48a9                	li	a7,10
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3a4:	48ad                	li	a7,11
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3ac:	48b1                	li	a7,12
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3b4:	48b5                	li	a7,13
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3bc:	48b9                	li	a7,14
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 3c4:	48d9                	li	a7,22
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3cc:	1101                	addi	sp,sp,-32
 3ce:	ec06                	sd	ra,24(sp)
 3d0:	e822                	sd	s0,16(sp)
 3d2:	1000                	addi	s0,sp,32
 3d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d8:	4605                	li	a2,1
 3da:	fef40593          	addi	a1,s0,-17
 3de:	f67ff0ef          	jal	344 <write>
}
 3e2:	60e2                	ld	ra,24(sp)
 3e4:	6442                	ld	s0,16(sp)
 3e6:	6105                	addi	sp,sp,32
 3e8:	8082                	ret

00000000000003ea <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ea:	7139                	addi	sp,sp,-64
 3ec:	fc06                	sd	ra,56(sp)
 3ee:	f822                	sd	s0,48(sp)
 3f0:	f426                	sd	s1,40(sp)
 3f2:	f04a                	sd	s2,32(sp)
 3f4:	ec4e                	sd	s3,24(sp)
 3f6:	0080                	addi	s0,sp,64
 3f8:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fa:	c299                	beqz	a3,400 <printint+0x16>
 3fc:	0605ce63          	bltz	a1,478 <printint+0x8e>
  neg = 0;
 400:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 402:	fc040313          	addi	t1,s0,-64
  neg = 0;
 406:	869a                	mv	a3,t1
  i = 0;
 408:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 40a:	00000817          	auipc	a6,0x0
 40e:	56680813          	addi	a6,a6,1382 # 970 <digits>
 412:	88be                	mv	a7,a5
 414:	0017851b          	addiw	a0,a5,1
 418:	87aa                	mv	a5,a0
 41a:	02c5f73b          	remuw	a4,a1,a2
 41e:	1702                	slli	a4,a4,0x20
 420:	9301                	srli	a4,a4,0x20
 422:	9742                	add	a4,a4,a6
 424:	00074703          	lbu	a4,0(a4)
 428:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 42c:	872e                	mv	a4,a1
 42e:	02c5d5bb          	divuw	a1,a1,a2
 432:	0685                	addi	a3,a3,1
 434:	fcc77fe3          	bgeu	a4,a2,412 <printint+0x28>
  if(neg)
 438:	000e0c63          	beqz	t3,450 <printint+0x66>
    buf[i++] = '-';
 43c:	fd050793          	addi	a5,a0,-48
 440:	00878533          	add	a0,a5,s0
 444:	02d00793          	li	a5,45
 448:	fef50823          	sb	a5,-16(a0)
 44c:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 450:	fff7899b          	addiw	s3,a5,-1
 454:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 458:	fff4c583          	lbu	a1,-1(s1)
 45c:	854a                	mv	a0,s2
 45e:	f6fff0ef          	jal	3cc <putc>
  while(--i >= 0)
 462:	39fd                	addiw	s3,s3,-1
 464:	14fd                	addi	s1,s1,-1
 466:	fe09d9e3          	bgez	s3,458 <printint+0x6e>
}
 46a:	70e2                	ld	ra,56(sp)
 46c:	7442                	ld	s0,48(sp)
 46e:	74a2                	ld	s1,40(sp)
 470:	7902                	ld	s2,32(sp)
 472:	69e2                	ld	s3,24(sp)
 474:	6121                	addi	sp,sp,64
 476:	8082                	ret
    x = -xx;
 478:	40b005bb          	negw	a1,a1
    neg = 1;
 47c:	4e05                	li	t3,1
    x = -xx;
 47e:	b751                	j	402 <printint+0x18>

0000000000000480 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 480:	711d                	addi	sp,sp,-96
 482:	ec86                	sd	ra,88(sp)
 484:	e8a2                	sd	s0,80(sp)
 486:	e4a6                	sd	s1,72(sp)
 488:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 48a:	0005c483          	lbu	s1,0(a1)
 48e:	26048663          	beqz	s1,6fa <vprintf+0x27a>
 492:	e0ca                	sd	s2,64(sp)
 494:	fc4e                	sd	s3,56(sp)
 496:	f852                	sd	s4,48(sp)
 498:	f456                	sd	s5,40(sp)
 49a:	f05a                	sd	s6,32(sp)
 49c:	ec5e                	sd	s7,24(sp)
 49e:	e862                	sd	s8,16(sp)
 4a0:	e466                	sd	s9,8(sp)
 4a2:	8b2a                	mv	s6,a0
 4a4:	8a2e                	mv	s4,a1
 4a6:	8bb2                	mv	s7,a2
  state = 0;
 4a8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4aa:	4901                	li	s2,0
 4ac:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4ae:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4b2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4b6:	06c00c93          	li	s9,108
 4ba:	a00d                	j	4dc <vprintf+0x5c>
        putc(fd, c0);
 4bc:	85a6                	mv	a1,s1
 4be:	855a                	mv	a0,s6
 4c0:	f0dff0ef          	jal	3cc <putc>
 4c4:	a019                	j	4ca <vprintf+0x4a>
    } else if(state == '%'){
 4c6:	03598363          	beq	s3,s5,4ec <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 4ca:	0019079b          	addiw	a5,s2,1
 4ce:	893e                	mv	s2,a5
 4d0:	873e                	mv	a4,a5
 4d2:	97d2                	add	a5,a5,s4
 4d4:	0007c483          	lbu	s1,0(a5)
 4d8:	20048963          	beqz	s1,6ea <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 4dc:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4e0:	fe0993e3          	bnez	s3,4c6 <vprintf+0x46>
      if(c0 == '%'){
 4e4:	fd579ce3          	bne	a5,s5,4bc <vprintf+0x3c>
        state = '%';
 4e8:	89be                	mv	s3,a5
 4ea:	b7c5                	j	4ca <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4ec:	00ea06b3          	add	a3,s4,a4
 4f0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4f4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4f6:	c681                	beqz	a3,4fe <vprintf+0x7e>
 4f8:	9752                	add	a4,a4,s4
 4fa:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4fe:	03878e63          	beq	a5,s8,53a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 502:	05978863          	beq	a5,s9,552 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 506:	07500713          	li	a4,117
 50a:	0ee78263          	beq	a5,a4,5ee <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 50e:	07800713          	li	a4,120
 512:	12e78463          	beq	a5,a4,63a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 516:	07000713          	li	a4,112
 51a:	14e78963          	beq	a5,a4,66c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 51e:	07300713          	li	a4,115
 522:	18e78863          	beq	a5,a4,6b2 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 526:	02500713          	li	a4,37
 52a:	04e79463          	bne	a5,a4,572 <vprintf+0xf2>
        putc(fd, '%');
 52e:	85ba                	mv	a1,a4
 530:	855a                	mv	a0,s6
 532:	e9bff0ef          	jal	3cc <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 536:	4981                	li	s3,0
 538:	bf49                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 53a:	008b8493          	addi	s1,s7,8
 53e:	4685                	li	a3,1
 540:	4629                	li	a2,10
 542:	000ba583          	lw	a1,0(s7)
 546:	855a                	mv	a0,s6
 548:	ea3ff0ef          	jal	3ea <printint>
 54c:	8ba6                	mv	s7,s1
      state = 0;
 54e:	4981                	li	s3,0
 550:	bfad                	j	4ca <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 552:	06400793          	li	a5,100
 556:	02f68963          	beq	a3,a5,588 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 55a:	06c00793          	li	a5,108
 55e:	04f68263          	beq	a3,a5,5a2 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 562:	07500793          	li	a5,117
 566:	0af68063          	beq	a3,a5,606 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 56a:	07800793          	li	a5,120
 56e:	0ef68263          	beq	a3,a5,652 <vprintf+0x1d2>
        putc(fd, '%');
 572:	02500593          	li	a1,37
 576:	855a                	mv	a0,s6
 578:	e55ff0ef          	jal	3cc <putc>
        putc(fd, c0);
 57c:	85a6                	mv	a1,s1
 57e:	855a                	mv	a0,s6
 580:	e4dff0ef          	jal	3cc <putc>
      state = 0;
 584:	4981                	li	s3,0
 586:	b791                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 588:	008b8493          	addi	s1,s7,8
 58c:	4685                	li	a3,1
 58e:	4629                	li	a2,10
 590:	000ba583          	lw	a1,0(s7)
 594:	855a                	mv	a0,s6
 596:	e55ff0ef          	jal	3ea <printint>
        i += 1;
 59a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 59c:	8ba6                	mv	s7,s1
      state = 0;
 59e:	4981                	li	s3,0
        i += 1;
 5a0:	b72d                	j	4ca <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5a2:	06400793          	li	a5,100
 5a6:	02f60763          	beq	a2,a5,5d4 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5aa:	07500793          	li	a5,117
 5ae:	06f60963          	beq	a2,a5,620 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5b2:	07800793          	li	a5,120
 5b6:	faf61ee3          	bne	a2,a5,572 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ba:	008b8493          	addi	s1,s7,8
 5be:	4681                	li	a3,0
 5c0:	4641                	li	a2,16
 5c2:	000ba583          	lw	a1,0(s7)
 5c6:	855a                	mv	a0,s6
 5c8:	e23ff0ef          	jal	3ea <printint>
        i += 2;
 5cc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ce:	8ba6                	mv	s7,s1
      state = 0;
 5d0:	4981                	li	s3,0
        i += 2;
 5d2:	bde5                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d4:	008b8493          	addi	s1,s7,8
 5d8:	4685                	li	a3,1
 5da:	4629                	li	a2,10
 5dc:	000ba583          	lw	a1,0(s7)
 5e0:	855a                	mv	a0,s6
 5e2:	e09ff0ef          	jal	3ea <printint>
        i += 2;
 5e6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e8:	8ba6                	mv	s7,s1
      state = 0;
 5ea:	4981                	li	s3,0
        i += 2;
 5ec:	bdf9                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5ee:	008b8493          	addi	s1,s7,8
 5f2:	4681                	li	a3,0
 5f4:	4629                	li	a2,10
 5f6:	000ba583          	lw	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	defff0ef          	jal	3ea <printint>
 600:	8ba6                	mv	s7,s1
      state = 0;
 602:	4981                	li	s3,0
 604:	b5d9                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 606:	008b8493          	addi	s1,s7,8
 60a:	4681                	li	a3,0
 60c:	4629                	li	a2,10
 60e:	000ba583          	lw	a1,0(s7)
 612:	855a                	mv	a0,s6
 614:	dd7ff0ef          	jal	3ea <printint>
        i += 1;
 618:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 61a:	8ba6                	mv	s7,s1
      state = 0;
 61c:	4981                	li	s3,0
        i += 1;
 61e:	b575                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 620:	008b8493          	addi	s1,s7,8
 624:	4681                	li	a3,0
 626:	4629                	li	a2,10
 628:	000ba583          	lw	a1,0(s7)
 62c:	855a                	mv	a0,s6
 62e:	dbdff0ef          	jal	3ea <printint>
        i += 2;
 632:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 634:	8ba6                	mv	s7,s1
      state = 0;
 636:	4981                	li	s3,0
        i += 2;
 638:	bd49                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 63a:	008b8493          	addi	s1,s7,8
 63e:	4681                	li	a3,0
 640:	4641                	li	a2,16
 642:	000ba583          	lw	a1,0(s7)
 646:	855a                	mv	a0,s6
 648:	da3ff0ef          	jal	3ea <printint>
 64c:	8ba6                	mv	s7,s1
      state = 0;
 64e:	4981                	li	s3,0
 650:	bdad                	j	4ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 652:	008b8493          	addi	s1,s7,8
 656:	4681                	li	a3,0
 658:	4641                	li	a2,16
 65a:	000ba583          	lw	a1,0(s7)
 65e:	855a                	mv	a0,s6
 660:	d8bff0ef          	jal	3ea <printint>
        i += 1;
 664:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 666:	8ba6                	mv	s7,s1
      state = 0;
 668:	4981                	li	s3,0
        i += 1;
 66a:	b585                	j	4ca <vprintf+0x4a>
 66c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 66e:	008b8d13          	addi	s10,s7,8
 672:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 676:	03000593          	li	a1,48
 67a:	855a                	mv	a0,s6
 67c:	d51ff0ef          	jal	3cc <putc>
  putc(fd, 'x');
 680:	07800593          	li	a1,120
 684:	855a                	mv	a0,s6
 686:	d47ff0ef          	jal	3cc <putc>
 68a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 68c:	00000b97          	auipc	s7,0x0
 690:	2e4b8b93          	addi	s7,s7,740 # 970 <digits>
 694:	03c9d793          	srli	a5,s3,0x3c
 698:	97de                	add	a5,a5,s7
 69a:	0007c583          	lbu	a1,0(a5)
 69e:	855a                	mv	a0,s6
 6a0:	d2dff0ef          	jal	3cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a4:	0992                	slli	s3,s3,0x4
 6a6:	34fd                	addiw	s1,s1,-1
 6a8:	f4f5                	bnez	s1,694 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 6aa:	8bea                	mv	s7,s10
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	6d02                	ld	s10,0(sp)
 6b0:	bd29                	j	4ca <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6b2:	008b8993          	addi	s3,s7,8
 6b6:	000bb483          	ld	s1,0(s7)
 6ba:	cc91                	beqz	s1,6d6 <vprintf+0x256>
        for(; *s; s++)
 6bc:	0004c583          	lbu	a1,0(s1)
 6c0:	c195                	beqz	a1,6e4 <vprintf+0x264>
          putc(fd, *s);
 6c2:	855a                	mv	a0,s6
 6c4:	d09ff0ef          	jal	3cc <putc>
        for(; *s; s++)
 6c8:	0485                	addi	s1,s1,1
 6ca:	0004c583          	lbu	a1,0(s1)
 6ce:	f9f5                	bnez	a1,6c2 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 6d0:	8bce                	mv	s7,s3
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bbdd                	j	4ca <vprintf+0x4a>
          s = "(null)";
 6d6:	00000497          	auipc	s1,0x0
 6da:	29248493          	addi	s1,s1,658 # 968 <malloc+0x182>
        for(; *s; s++)
 6de:	02800593          	li	a1,40
 6e2:	b7c5                	j	6c2 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 6e4:	8bce                	mv	s7,s3
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	b3cd                	j	4ca <vprintf+0x4a>
 6ea:	6906                	ld	s2,64(sp)
 6ec:	79e2                	ld	s3,56(sp)
 6ee:	7a42                	ld	s4,48(sp)
 6f0:	7aa2                	ld	s5,40(sp)
 6f2:	7b02                	ld	s6,32(sp)
 6f4:	6be2                	ld	s7,24(sp)
 6f6:	6c42                	ld	s8,16(sp)
 6f8:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6fa:	60e6                	ld	ra,88(sp)
 6fc:	6446                	ld	s0,80(sp)
 6fe:	64a6                	ld	s1,72(sp)
 700:	6125                	addi	sp,sp,96
 702:	8082                	ret

0000000000000704 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 704:	715d                	addi	sp,sp,-80
 706:	ec06                	sd	ra,24(sp)
 708:	e822                	sd	s0,16(sp)
 70a:	1000                	addi	s0,sp,32
 70c:	e010                	sd	a2,0(s0)
 70e:	e414                	sd	a3,8(s0)
 710:	e818                	sd	a4,16(s0)
 712:	ec1c                	sd	a5,24(s0)
 714:	03043023          	sd	a6,32(s0)
 718:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 71c:	8622                	mv	a2,s0
 71e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 722:	d5fff0ef          	jal	480 <vprintf>
}
 726:	60e2                	ld	ra,24(sp)
 728:	6442                	ld	s0,16(sp)
 72a:	6161                	addi	sp,sp,80
 72c:	8082                	ret

000000000000072e <printf>:

void
printf(const char *fmt, ...)
{
 72e:	711d                	addi	sp,sp,-96
 730:	ec06                	sd	ra,24(sp)
 732:	e822                	sd	s0,16(sp)
 734:	1000                	addi	s0,sp,32
 736:	e40c                	sd	a1,8(s0)
 738:	e810                	sd	a2,16(s0)
 73a:	ec14                	sd	a3,24(s0)
 73c:	f018                	sd	a4,32(s0)
 73e:	f41c                	sd	a5,40(s0)
 740:	03043823          	sd	a6,48(s0)
 744:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 748:	00840613          	addi	a2,s0,8
 74c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 750:	85aa                	mv	a1,a0
 752:	4505                	li	a0,1
 754:	d2dff0ef          	jal	480 <vprintf>
}
 758:	60e2                	ld	ra,24(sp)
 75a:	6442                	ld	s0,16(sp)
 75c:	6125                	addi	sp,sp,96
 75e:	8082                	ret

0000000000000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	1141                	addi	sp,sp,-16
 762:	e406                	sd	ra,8(sp)
 764:	e022                	sd	s0,0(sp)
 766:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 768:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76c:	00001797          	auipc	a5,0x1
 770:	8947b783          	ld	a5,-1900(a5) # 1000 <freep>
 774:	a02d                	j	79e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 776:	4618                	lw	a4,8(a2)
 778:	9f2d                	addw	a4,a4,a1
 77a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 77e:	6398                	ld	a4,0(a5)
 780:	6310                	ld	a2,0(a4)
 782:	a83d                	j	7c0 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 784:	ff852703          	lw	a4,-8(a0)
 788:	9f31                	addw	a4,a4,a2
 78a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 78c:	ff053683          	ld	a3,-16(a0)
 790:	a091                	j	7d4 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 792:	6398                	ld	a4,0(a5)
 794:	00e7e463          	bltu	a5,a4,79c <free+0x3c>
 798:	00e6ea63          	bltu	a3,a4,7ac <free+0x4c>
{
 79c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79e:	fed7fae3          	bgeu	a5,a3,792 <free+0x32>
 7a2:	6398                	ld	a4,0(a5)
 7a4:	00e6e463          	bltu	a3,a4,7ac <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	fee7eae3          	bltu	a5,a4,79c <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7ac:	ff852583          	lw	a1,-8(a0)
 7b0:	6390                	ld	a2,0(a5)
 7b2:	02059813          	slli	a6,a1,0x20
 7b6:	01c85713          	srli	a4,a6,0x1c
 7ba:	9736                	add	a4,a4,a3
 7bc:	fae60de3          	beq	a2,a4,776 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c4:	4790                	lw	a2,8(a5)
 7c6:	02061593          	slli	a1,a2,0x20
 7ca:	01c5d713          	srli	a4,a1,0x1c
 7ce:	973e                	add	a4,a4,a5
 7d0:	fae68ae3          	beq	a3,a4,784 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7d4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7d6:	00001717          	auipc	a4,0x1
 7da:	82f73523          	sd	a5,-2006(a4) # 1000 <freep>
}
 7de:	60a2                	ld	ra,8(sp)
 7e0:	6402                	ld	s0,0(sp)
 7e2:	0141                	addi	sp,sp,16
 7e4:	8082                	ret

00000000000007e6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e6:	7139                	addi	sp,sp,-64
 7e8:	fc06                	sd	ra,56(sp)
 7ea:	f822                	sd	s0,48(sp)
 7ec:	f04a                	sd	s2,32(sp)
 7ee:	ec4e                	sd	s3,24(sp)
 7f0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	02051993          	slli	s3,a0,0x20
 7f6:	0209d993          	srli	s3,s3,0x20
 7fa:	09bd                	addi	s3,s3,15
 7fc:	0049d993          	srli	s3,s3,0x4
 800:	2985                	addiw	s3,s3,1
 802:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 804:	00000517          	auipc	a0,0x0
 808:	7fc53503          	ld	a0,2044(a0) # 1000 <freep>
 80c:	c905                	beqz	a0,83c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 810:	4798                	lw	a4,8(a5)
 812:	09377663          	bgeu	a4,s3,89e <malloc+0xb8>
 816:	f426                	sd	s1,40(sp)
 818:	e852                	sd	s4,16(sp)
 81a:	e456                	sd	s5,8(sp)
 81c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 81e:	8a4e                	mv	s4,s3
 820:	6705                	lui	a4,0x1
 822:	00e9f363          	bgeu	s3,a4,828 <malloc+0x42>
 826:	6a05                	lui	s4,0x1
 828:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 82c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 830:	00000497          	auipc	s1,0x0
 834:	7d048493          	addi	s1,s1,2000 # 1000 <freep>
  if(p == (char*)-1)
 838:	5afd                	li	s5,-1
 83a:	a83d                	j	878 <malloc+0x92>
 83c:	f426                	sd	s1,40(sp)
 83e:	e852                	sd	s4,16(sp)
 840:	e456                	sd	s5,8(sp)
 842:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 844:	00000797          	auipc	a5,0x0
 848:	7cc78793          	addi	a5,a5,1996 # 1010 <base>
 84c:	00000717          	auipc	a4,0x0
 850:	7af73a23          	sd	a5,1972(a4) # 1000 <freep>
 854:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 856:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 85a:	b7d1                	j	81e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 85c:	6398                	ld	a4,0(a5)
 85e:	e118                	sd	a4,0(a0)
 860:	a899                	j	8b6 <malloc+0xd0>
  hp->s.size = nu;
 862:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 866:	0541                	addi	a0,a0,16
 868:	ef9ff0ef          	jal	760 <free>
  return freep;
 86c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 86e:	c125                	beqz	a0,8ce <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 870:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 872:	4798                	lw	a4,8(a5)
 874:	03277163          	bgeu	a4,s2,896 <malloc+0xb0>
    if(p == freep)
 878:	6098                	ld	a4,0(s1)
 87a:	853e                	mv	a0,a5
 87c:	fef71ae3          	bne	a4,a5,870 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 880:	8552                	mv	a0,s4
 882:	b2bff0ef          	jal	3ac <sbrk>
  if(p == (char*)-1)
 886:	fd551ee3          	bne	a0,s5,862 <malloc+0x7c>
        return 0;
 88a:	4501                	li	a0,0
 88c:	74a2                	ld	s1,40(sp)
 88e:	6a42                	ld	s4,16(sp)
 890:	6aa2                	ld	s5,8(sp)
 892:	6b02                	ld	s6,0(sp)
 894:	a03d                	j	8c2 <malloc+0xdc>
 896:	74a2                	ld	s1,40(sp)
 898:	6a42                	ld	s4,16(sp)
 89a:	6aa2                	ld	s5,8(sp)
 89c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 89e:	fae90fe3          	beq	s2,a4,85c <malloc+0x76>
        p->s.size -= nunits;
 8a2:	4137073b          	subw	a4,a4,s3
 8a6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a8:	02071693          	slli	a3,a4,0x20
 8ac:	01c6d713          	srli	a4,a3,0x1c
 8b0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b6:	00000717          	auipc	a4,0x0
 8ba:	74a73523          	sd	a0,1866(a4) # 1000 <freep>
      return (void*)(p + 1);
 8be:	01078513          	addi	a0,a5,16
  }
}
 8c2:	70e2                	ld	ra,56(sp)
 8c4:	7442                	ld	s0,48(sp)
 8c6:	7902                	ld	s2,32(sp)
 8c8:	69e2                	ld	s3,24(sp)
 8ca:	6121                	addi	sp,sp,64
 8cc:	8082                	ret
 8ce:	74a2                	ld	s1,40(sp)
 8d0:	6a42                	ld	s4,16(sp)
 8d2:	6aa2                	ld	s5,8(sp)
 8d4:	6b02                	ld	s6,0(sp)
 8d6:	b7f5                	j	8c2 <malloc+0xdc>
