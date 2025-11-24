
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
  1c:	30e000ef          	jal	32a <open>
    if(fd >= 0) {
  20:	02055e63          	bgez	a0,5c <main+0x5c>
        close(fd);
        printf("error: file '%s' already exists\n", path);
    }

    fd = open(path, O_CREATE | O_RDWR);
  24:	20200593          	li	a1,514
  28:	854a                	mv	a0,s2
  2a:	300000ef          	jal	32a <open>
  2e:	84aa                	mv	s1,a0
    if(fd < 0) {
  30:	04054063          	bltz	a0,70 <main+0x70>
        printf("error: failed to create file '%s'\n", path);
    }

    printf("created file '%s'\n", path);
  34:	85ca                	mv	a1,s2
  36:	00001517          	auipc	a0,0x1
  3a:	8ea50513          	addi	a0,a0,-1814 # 920 <malloc+0x16a>
  3e:	6c4000ef          	jal	702 <printf>
    close(fd);
  42:	8526                	mv	a0,s1
  44:	2ce000ef          	jal	312 <close>
    exit(0);
  48:	4501                	li	a0,0
  4a:	2a0000ef          	jal	2ea <exit>
        printf("usage: create <filename>\n");
  4e:	00001517          	auipc	a0,0x1
  52:	86250513          	addi	a0,a0,-1950 # 8b0 <malloc+0xfa>
  56:	6ac000ef          	jal	702 <printf>
  5a:	bf6d                	j	14 <main+0x14>
        close(fd);
  5c:	2b6000ef          	jal	312 <close>
        printf("error: file '%s' already exists\n", path);
  60:	85ca                	mv	a1,s2
  62:	00001517          	auipc	a0,0x1
  66:	86e50513          	addi	a0,a0,-1938 # 8d0 <malloc+0x11a>
  6a:	698000ef          	jal	702 <printf>
  6e:	bf5d                	j	24 <main+0x24>
        printf("error: failed to create file '%s'\n", path);
  70:	85ca                	mv	a1,s2
  72:	00001517          	auipc	a0,0x1
  76:	88650513          	addi	a0,a0,-1914 # 8f8 <malloc+0x142>
  7a:	688000ef          	jal	702 <printf>
  7e:	bf5d                	j	34 <main+0x34>

0000000000000080 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
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
  8e:	25c000ef          	jal	2ea <exit>

0000000000000092 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  92:	1141                	addi	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  98:	87aa                	mv	a5,a0
  9a:	0585                	addi	a1,a1,1
  9c:	0785                	addi	a5,a5,1
  9e:	fff5c703          	lbu	a4,-1(a1)
  a2:	fee78fa3          	sb	a4,-1(a5)
  a6:	fb75                	bnez	a4,9a <strcpy+0x8>
    ;
  return os;
}
  a8:	6422                	ld	s0,8(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e422                	sd	s0,8(sp)
  b2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	cb91                	beqz	a5,cc <strcmp+0x1e>
  ba:	0005c703          	lbu	a4,0(a1)
  be:	00f71763          	bne	a4,a5,cc <strcmp+0x1e>
    p++, q++;
  c2:	0505                	addi	a0,a0,1
  c4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	fbe5                	bnez	a5,ba <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  cc:	0005c503          	lbu	a0,0(a1)
}
  d0:	40a7853b          	subw	a0,a5,a0
  d4:	6422                	ld	s0,8(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret

00000000000000da <strlen>:

uint
strlen(const char *s)
{
  da:	1141                	addi	sp,sp,-16
  dc:	e422                	sd	s0,8(sp)
  de:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e0:	00054783          	lbu	a5,0(a0)
  e4:	cf91                	beqz	a5,100 <strlen+0x26>
  e6:	0505                	addi	a0,a0,1
  e8:	87aa                	mv	a5,a0
  ea:	86be                	mv	a3,a5
  ec:	0785                	addi	a5,a5,1
  ee:	fff7c703          	lbu	a4,-1(a5)
  f2:	ff65                	bnez	a4,ea <strlen+0x10>
  f4:	40a6853b          	subw	a0,a3,a0
  f8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  fa:	6422                	ld	s0,8(sp)
  fc:	0141                	addi	sp,sp,16
  fe:	8082                	ret
  for(n = 0; s[n]; n++)
 100:	4501                	li	a0,0
 102:	bfe5                	j	fa <strlen+0x20>

0000000000000104 <memset>:

void*
memset(void *dst, int c, uint n)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 10a:	ca19                	beqz	a2,120 <memset+0x1c>
 10c:	87aa                	mv	a5,a0
 10e:	1602                	slli	a2,a2,0x20
 110:	9201                	srli	a2,a2,0x20
 112:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 116:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 11a:	0785                	addi	a5,a5,1
 11c:	fee79de3          	bne	a5,a4,116 <memset+0x12>
  }
  return dst;
}
 120:	6422                	ld	s0,8(sp)
 122:	0141                	addi	sp,sp,16
 124:	8082                	ret

0000000000000126 <strchr>:

char*
strchr(const char *s, char c)
{
 126:	1141                	addi	sp,sp,-16
 128:	e422                	sd	s0,8(sp)
 12a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 12c:	00054783          	lbu	a5,0(a0)
 130:	cb99                	beqz	a5,146 <strchr+0x20>
    if(*s == c)
 132:	00f58763          	beq	a1,a5,140 <strchr+0x1a>
  for(; *s; s++)
 136:	0505                	addi	a0,a0,1
 138:	00054783          	lbu	a5,0(a0)
 13c:	fbfd                	bnez	a5,132 <strchr+0xc>
      return (char*)s;
  return 0;
 13e:	4501                	li	a0,0
}
 140:	6422                	ld	s0,8(sp)
 142:	0141                	addi	sp,sp,16
 144:	8082                	ret
  return 0;
 146:	4501                	li	a0,0
 148:	bfe5                	j	140 <strchr+0x1a>

000000000000014a <gets>:

char*
gets(char *buf, int max)
{
 14a:	711d                	addi	sp,sp,-96
 14c:	ec86                	sd	ra,88(sp)
 14e:	e8a2                	sd	s0,80(sp)
 150:	e4a6                	sd	s1,72(sp)
 152:	e0ca                	sd	s2,64(sp)
 154:	fc4e                	sd	s3,56(sp)
 156:	f852                	sd	s4,48(sp)
 158:	f456                	sd	s5,40(sp)
 15a:	f05a                	sd	s6,32(sp)
 15c:	ec5e                	sd	s7,24(sp)
 15e:	1080                	addi	s0,sp,96
 160:	8baa                	mv	s7,a0
 162:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 164:	892a                	mv	s2,a0
 166:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 168:	4aa9                	li	s5,10
 16a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 16c:	89a6                	mv	s3,s1
 16e:	2485                	addiw	s1,s1,1
 170:	0344d663          	bge	s1,s4,19c <gets+0x52>
    cc = read(0, &c, 1);
 174:	4605                	li	a2,1
 176:	faf40593          	addi	a1,s0,-81
 17a:	4501                	li	a0,0
 17c:	186000ef          	jal	302 <read>
    if(cc < 1)
 180:	00a05e63          	blez	a0,19c <gets+0x52>
    buf[i++] = c;
 184:	faf44783          	lbu	a5,-81(s0)
 188:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18c:	01578763          	beq	a5,s5,19a <gets+0x50>
 190:	0905                	addi	s2,s2,1
 192:	fd679de3          	bne	a5,s6,16c <gets+0x22>
    buf[i++] = c;
 196:	89a6                	mv	s3,s1
 198:	a011                	j	19c <gets+0x52>
 19a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19c:	99de                	add	s3,s3,s7
 19e:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a2:	855e                	mv	a0,s7
 1a4:	60e6                	ld	ra,88(sp)
 1a6:	6446                	ld	s0,80(sp)
 1a8:	64a6                	ld	s1,72(sp)
 1aa:	6906                	ld	s2,64(sp)
 1ac:	79e2                	ld	s3,56(sp)
 1ae:	7a42                	ld	s4,48(sp)
 1b0:	7aa2                	ld	s5,40(sp)
 1b2:	7b02                	ld	s6,32(sp)
 1b4:	6be2                	ld	s7,24(sp)
 1b6:	6125                	addi	sp,sp,96
 1b8:	8082                	ret

00000000000001ba <stat>:

int
stat(const char *n, struct stat *st)
{
 1ba:	1101                	addi	sp,sp,-32
 1bc:	ec06                	sd	ra,24(sp)
 1be:	e822                	sd	s0,16(sp)
 1c0:	e04a                	sd	s2,0(sp)
 1c2:	1000                	addi	s0,sp,32
 1c4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c6:	4581                	li	a1,0
 1c8:	162000ef          	jal	32a <open>
  if(fd < 0)
 1cc:	02054263          	bltz	a0,1f0 <stat+0x36>
 1d0:	e426                	sd	s1,8(sp)
 1d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d4:	85ca                	mv	a1,s2
 1d6:	16c000ef          	jal	342 <fstat>
 1da:	892a                	mv	s2,a0
  close(fd);
 1dc:	8526                	mv	a0,s1
 1de:	134000ef          	jal	312 <close>
  return r;
 1e2:	64a2                	ld	s1,8(sp)
}
 1e4:	854a                	mv	a0,s2
 1e6:	60e2                	ld	ra,24(sp)
 1e8:	6442                	ld	s0,16(sp)
 1ea:	6902                	ld	s2,0(sp)
 1ec:	6105                	addi	sp,sp,32
 1ee:	8082                	ret
    return -1;
 1f0:	597d                	li	s2,-1
 1f2:	bfcd                	j	1e4 <stat+0x2a>

00000000000001f4 <atoi>:

int
atoi(const char *s)
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e422                	sd	s0,8(sp)
 1f8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1fa:	00054683          	lbu	a3,0(a0)
 1fe:	fd06879b          	addiw	a5,a3,-48
 202:	0ff7f793          	zext.b	a5,a5
 206:	4625                	li	a2,9
 208:	02f66863          	bltu	a2,a5,238 <atoi+0x44>
 20c:	872a                	mv	a4,a0
  n = 0;
 20e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 210:	0705                	addi	a4,a4,1
 212:	0025179b          	slliw	a5,a0,0x2
 216:	9fa9                	addw	a5,a5,a0
 218:	0017979b          	slliw	a5,a5,0x1
 21c:	9fb5                	addw	a5,a5,a3
 21e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 222:	00074683          	lbu	a3,0(a4)
 226:	fd06879b          	addiw	a5,a3,-48
 22a:	0ff7f793          	zext.b	a5,a5
 22e:	fef671e3          	bgeu	a2,a5,210 <atoi+0x1c>
  return n;
}
 232:	6422                	ld	s0,8(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
  n = 0;
 238:	4501                	li	a0,0
 23a:	bfe5                	j	232 <atoi+0x3e>

000000000000023c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e422                	sd	s0,8(sp)
 240:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 242:	02b57463          	bgeu	a0,a1,26a <memmove+0x2e>
    while(n-- > 0)
 246:	00c05f63          	blez	a2,264 <memmove+0x28>
 24a:	1602                	slli	a2,a2,0x20
 24c:	9201                	srli	a2,a2,0x20
 24e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 252:	872a                	mv	a4,a0
      *dst++ = *src++;
 254:	0585                	addi	a1,a1,1
 256:	0705                	addi	a4,a4,1
 258:	fff5c683          	lbu	a3,-1(a1)
 25c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 260:	fef71ae3          	bne	a4,a5,254 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 264:	6422                	ld	s0,8(sp)
 266:	0141                	addi	sp,sp,16
 268:	8082                	ret
    dst += n;
 26a:	00c50733          	add	a4,a0,a2
    src += n;
 26e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 270:	fec05ae3          	blez	a2,264 <memmove+0x28>
 274:	fff6079b          	addiw	a5,a2,-1
 278:	1782                	slli	a5,a5,0x20
 27a:	9381                	srli	a5,a5,0x20
 27c:	fff7c793          	not	a5,a5
 280:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 282:	15fd                	addi	a1,a1,-1
 284:	177d                	addi	a4,a4,-1
 286:	0005c683          	lbu	a3,0(a1)
 28a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 28e:	fee79ae3          	bne	a5,a4,282 <memmove+0x46>
 292:	bfc9                	j	264 <memmove+0x28>

0000000000000294 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 29a:	ca05                	beqz	a2,2ca <memcmp+0x36>
 29c:	fff6069b          	addiw	a3,a2,-1
 2a0:	1682                	slli	a3,a3,0x20
 2a2:	9281                	srli	a3,a3,0x20
 2a4:	0685                	addi	a3,a3,1
 2a6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	0005c703          	lbu	a4,0(a1)
 2b0:	00e79863          	bne	a5,a4,2c0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2b4:	0505                	addi	a0,a0,1
    p2++;
 2b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b8:	fed518e3          	bne	a0,a3,2a8 <memcmp+0x14>
  }
  return 0;
 2bc:	4501                	li	a0,0
 2be:	a019                	j	2c4 <memcmp+0x30>
      return *p1 - *p2;
 2c0:	40e7853b          	subw	a0,a5,a4
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret
  return 0;
 2ca:	4501                	li	a0,0
 2cc:	bfe5                	j	2c4 <memcmp+0x30>

00000000000002ce <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d6:	f67ff0ef          	jal	23c <memmove>
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e2:	4885                	li	a7,1
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ea:	4889                	li	a7,2
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f2:	488d                	li	a7,3
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2fa:	4891                	li	a7,4
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <read>:
.global read
read:
 li a7, SYS_read
 302:	4895                	li	a7,5
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <write>:
.global write
write:
 li a7, SYS_write
 30a:	48c1                	li	a7,16
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <close>:
.global close
close:
 li a7, SYS_close
 312:	48d5                	li	a7,21
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <kill>:
.global kill
kill:
 li a7, SYS_kill
 31a:	4899                	li	a7,6
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <exec>:
.global exec
exec:
 li a7, SYS_exec
 322:	489d                	li	a7,7
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <open>:
.global open
open:
 li a7, SYS_open
 32a:	48bd                	li	a7,15
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 332:	48c5                	li	a7,17
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 33a:	48c9                	li	a7,18
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 342:	48a1                	li	a7,8
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <link>:
.global link
link:
 li a7, SYS_link
 34a:	48cd                	li	a7,19
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 352:	48d1                	li	a7,20
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 35a:	48a5                	li	a7,9
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <dup>:
.global dup
dup:
 li a7, SYS_dup
 362:	48a9                	li	a7,10
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 36a:	48ad                	li	a7,11
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 372:	48b1                	li	a7,12
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 37a:	48b5                	li	a7,13
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 382:	48b9                	li	a7,14
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 38a:	1101                	addi	sp,sp,-32
 38c:	ec06                	sd	ra,24(sp)
 38e:	e822                	sd	s0,16(sp)
 390:	1000                	addi	s0,sp,32
 392:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 396:	4605                	li	a2,1
 398:	fef40593          	addi	a1,s0,-17
 39c:	f6fff0ef          	jal	30a <write>
}
 3a0:	60e2                	ld	ra,24(sp)
 3a2:	6442                	ld	s0,16(sp)
 3a4:	6105                	addi	sp,sp,32
 3a6:	8082                	ret

00000000000003a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a8:	7139                	addi	sp,sp,-64
 3aa:	fc06                	sd	ra,56(sp)
 3ac:	f822                	sd	s0,48(sp)
 3ae:	f426                	sd	s1,40(sp)
 3b0:	0080                	addi	s0,sp,64
 3b2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3b4:	c299                	beqz	a3,3ba <printint+0x12>
 3b6:	0805c963          	bltz	a1,448 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3ba:	2581                	sext.w	a1,a1
  neg = 0;
 3bc:	4881                	li	a7,0
 3be:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3c2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3c4:	2601                	sext.w	a2,a2
 3c6:	00000517          	auipc	a0,0x0
 3ca:	57a50513          	addi	a0,a0,1402 # 940 <digits>
 3ce:	883a                	mv	a6,a4
 3d0:	2705                	addiw	a4,a4,1
 3d2:	02c5f7bb          	remuw	a5,a1,a2
 3d6:	1782                	slli	a5,a5,0x20
 3d8:	9381                	srli	a5,a5,0x20
 3da:	97aa                	add	a5,a5,a0
 3dc:	0007c783          	lbu	a5,0(a5)
 3e0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3e4:	0005879b          	sext.w	a5,a1
 3e8:	02c5d5bb          	divuw	a1,a1,a2
 3ec:	0685                	addi	a3,a3,1
 3ee:	fec7f0e3          	bgeu	a5,a2,3ce <printint+0x26>
  if(neg)
 3f2:	00088c63          	beqz	a7,40a <printint+0x62>
    buf[i++] = '-';
 3f6:	fd070793          	addi	a5,a4,-48
 3fa:	00878733          	add	a4,a5,s0
 3fe:	02d00793          	li	a5,45
 402:	fef70823          	sb	a5,-16(a4)
 406:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 40a:	02e05a63          	blez	a4,43e <printint+0x96>
 40e:	f04a                	sd	s2,32(sp)
 410:	ec4e                	sd	s3,24(sp)
 412:	fc040793          	addi	a5,s0,-64
 416:	00e78933          	add	s2,a5,a4
 41a:	fff78993          	addi	s3,a5,-1
 41e:	99ba                	add	s3,s3,a4
 420:	377d                	addiw	a4,a4,-1
 422:	1702                	slli	a4,a4,0x20
 424:	9301                	srli	a4,a4,0x20
 426:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 42a:	fff94583          	lbu	a1,-1(s2)
 42e:	8526                	mv	a0,s1
 430:	f5bff0ef          	jal	38a <putc>
  while(--i >= 0)
 434:	197d                	addi	s2,s2,-1
 436:	ff391ae3          	bne	s2,s3,42a <printint+0x82>
 43a:	7902                	ld	s2,32(sp)
 43c:	69e2                	ld	s3,24(sp)
}
 43e:	70e2                	ld	ra,56(sp)
 440:	7442                	ld	s0,48(sp)
 442:	74a2                	ld	s1,40(sp)
 444:	6121                	addi	sp,sp,64
 446:	8082                	ret
    x = -xx;
 448:	40b005bb          	negw	a1,a1
    neg = 1;
 44c:	4885                	li	a7,1
    x = -xx;
 44e:	bf85                	j	3be <printint+0x16>

0000000000000450 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 450:	711d                	addi	sp,sp,-96
 452:	ec86                	sd	ra,88(sp)
 454:	e8a2                	sd	s0,80(sp)
 456:	e0ca                	sd	s2,64(sp)
 458:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 45a:	0005c903          	lbu	s2,0(a1)
 45e:	26090863          	beqz	s2,6ce <vprintf+0x27e>
 462:	e4a6                	sd	s1,72(sp)
 464:	fc4e                	sd	s3,56(sp)
 466:	f852                	sd	s4,48(sp)
 468:	f456                	sd	s5,40(sp)
 46a:	f05a                	sd	s6,32(sp)
 46c:	ec5e                	sd	s7,24(sp)
 46e:	e862                	sd	s8,16(sp)
 470:	e466                	sd	s9,8(sp)
 472:	8b2a                	mv	s6,a0
 474:	8a2e                	mv	s4,a1
 476:	8bb2                	mv	s7,a2
  state = 0;
 478:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 47a:	4481                	li	s1,0
 47c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 47e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 482:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 486:	06c00c93          	li	s9,108
 48a:	a005                	j	4aa <vprintf+0x5a>
        putc(fd, c0);
 48c:	85ca                	mv	a1,s2
 48e:	855a                	mv	a0,s6
 490:	efbff0ef          	jal	38a <putc>
 494:	a019                	j	49a <vprintf+0x4a>
    } else if(state == '%'){
 496:	03598263          	beq	s3,s5,4ba <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 49a:	2485                	addiw	s1,s1,1
 49c:	8726                	mv	a4,s1
 49e:	009a07b3          	add	a5,s4,s1
 4a2:	0007c903          	lbu	s2,0(a5)
 4a6:	20090c63          	beqz	s2,6be <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 4aa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4ae:	fe0994e3          	bnez	s3,496 <vprintf+0x46>
      if(c0 == '%'){
 4b2:	fd579de3          	bne	a5,s5,48c <vprintf+0x3c>
        state = '%';
 4b6:	89be                	mv	s3,a5
 4b8:	b7cd                	j	49a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4ba:	00ea06b3          	add	a3,s4,a4
 4be:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4c2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4c4:	c681                	beqz	a3,4cc <vprintf+0x7c>
 4c6:	9752                	add	a4,a4,s4
 4c8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4cc:	03878f63          	beq	a5,s8,50a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 4d0:	05978963          	beq	a5,s9,522 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4d4:	07500713          	li	a4,117
 4d8:	0ee78363          	beq	a5,a4,5be <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4dc:	07800713          	li	a4,120
 4e0:	12e78563          	beq	a5,a4,60a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4e4:	07000713          	li	a4,112
 4e8:	14e78a63          	beq	a5,a4,63c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 4ec:	07300713          	li	a4,115
 4f0:	18e78a63          	beq	a5,a4,684 <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 4f4:	02500713          	li	a4,37
 4f8:	04e79563          	bne	a5,a4,542 <vprintf+0xf2>
        putc(fd, '%');
 4fc:	02500593          	li	a1,37
 500:	855a                	mv	a0,s6
 502:	e89ff0ef          	jal	38a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 506:	4981                	li	s3,0
 508:	bf49                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 50a:	008b8913          	addi	s2,s7,8
 50e:	4685                	li	a3,1
 510:	4629                	li	a2,10
 512:	000ba583          	lw	a1,0(s7)
 516:	855a                	mv	a0,s6
 518:	e91ff0ef          	jal	3a8 <printint>
 51c:	8bca                	mv	s7,s2
      state = 0;
 51e:	4981                	li	s3,0
 520:	bfad                	j	49a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 522:	06400793          	li	a5,100
 526:	02f68963          	beq	a3,a5,558 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 52a:	06c00793          	li	a5,108
 52e:	04f68263          	beq	a3,a5,572 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 532:	07500793          	li	a5,117
 536:	0af68063          	beq	a3,a5,5d6 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 53a:	07800793          	li	a5,120
 53e:	0ef68263          	beq	a3,a5,622 <vprintf+0x1d2>
        putc(fd, '%');
 542:	02500593          	li	a1,37
 546:	855a                	mv	a0,s6
 548:	e43ff0ef          	jal	38a <putc>
        putc(fd, c0);
 54c:	85ca                	mv	a1,s2
 54e:	855a                	mv	a0,s6
 550:	e3bff0ef          	jal	38a <putc>
      state = 0;
 554:	4981                	li	s3,0
 556:	b791                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 558:	008b8913          	addi	s2,s7,8
 55c:	4685                	li	a3,1
 55e:	4629                	li	a2,10
 560:	000ba583          	lw	a1,0(s7)
 564:	855a                	mv	a0,s6
 566:	e43ff0ef          	jal	3a8 <printint>
        i += 1;
 56a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 56c:	8bca                	mv	s7,s2
      state = 0;
 56e:	4981                	li	s3,0
        i += 1;
 570:	b72d                	j	49a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 572:	06400793          	li	a5,100
 576:	02f60763          	beq	a2,a5,5a4 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 57a:	07500793          	li	a5,117
 57e:	06f60963          	beq	a2,a5,5f0 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 582:	07800793          	li	a5,120
 586:	faf61ee3          	bne	a2,a5,542 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 58a:	008b8913          	addi	s2,s7,8
 58e:	4681                	li	a3,0
 590:	4641                	li	a2,16
 592:	000ba583          	lw	a1,0(s7)
 596:	855a                	mv	a0,s6
 598:	e11ff0ef          	jal	3a8 <printint>
        i += 2;
 59c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 59e:	8bca                	mv	s7,s2
      state = 0;
 5a0:	4981                	li	s3,0
        i += 2;
 5a2:	bde5                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5a4:	008b8913          	addi	s2,s7,8
 5a8:	4685                	li	a3,1
 5aa:	4629                	li	a2,10
 5ac:	000ba583          	lw	a1,0(s7)
 5b0:	855a                	mv	a0,s6
 5b2:	df7ff0ef          	jal	3a8 <printint>
        i += 2;
 5b6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5b8:	8bca                	mv	s7,s2
      state = 0;
 5ba:	4981                	li	s3,0
        i += 2;
 5bc:	bdf9                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 5be:	008b8913          	addi	s2,s7,8
 5c2:	4681                	li	a3,0
 5c4:	4629                	li	a2,10
 5c6:	000ba583          	lw	a1,0(s7)
 5ca:	855a                	mv	a0,s6
 5cc:	dddff0ef          	jal	3a8 <printint>
 5d0:	8bca                	mv	s7,s2
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	b5d9                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d6:	008b8913          	addi	s2,s7,8
 5da:	4681                	li	a3,0
 5dc:	4629                	li	a2,10
 5de:	000ba583          	lw	a1,0(s7)
 5e2:	855a                	mv	a0,s6
 5e4:	dc5ff0ef          	jal	3a8 <printint>
        i += 1;
 5e8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 5ea:	8bca                	mv	s7,s2
      state = 0;
 5ec:	4981                	li	s3,0
        i += 1;
 5ee:	b575                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f0:	008b8913          	addi	s2,s7,8
 5f4:	4681                	li	a3,0
 5f6:	4629                	li	a2,10
 5f8:	000ba583          	lw	a1,0(s7)
 5fc:	855a                	mv	a0,s6
 5fe:	dabff0ef          	jal	3a8 <printint>
        i += 2;
 602:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 604:	8bca                	mv	s7,s2
      state = 0;
 606:	4981                	li	s3,0
        i += 2;
 608:	bd49                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 60a:	008b8913          	addi	s2,s7,8
 60e:	4681                	li	a3,0
 610:	4641                	li	a2,16
 612:	000ba583          	lw	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	d91ff0ef          	jal	3a8 <printint>
 61c:	8bca                	mv	s7,s2
      state = 0;
 61e:	4981                	li	s3,0
 620:	bdad                	j	49a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 622:	008b8913          	addi	s2,s7,8
 626:	4681                	li	a3,0
 628:	4641                	li	a2,16
 62a:	000ba583          	lw	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	d79ff0ef          	jal	3a8 <printint>
        i += 1;
 634:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 636:	8bca                	mv	s7,s2
      state = 0;
 638:	4981                	li	s3,0
        i += 1;
 63a:	b585                	j	49a <vprintf+0x4a>
 63c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 63e:	008b8d13          	addi	s10,s7,8
 642:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 646:	03000593          	li	a1,48
 64a:	855a                	mv	a0,s6
 64c:	d3fff0ef          	jal	38a <putc>
  putc(fd, 'x');
 650:	07800593          	li	a1,120
 654:	855a                	mv	a0,s6
 656:	d35ff0ef          	jal	38a <putc>
 65a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 65c:	00000b97          	auipc	s7,0x0
 660:	2e4b8b93          	addi	s7,s7,740 # 940 <digits>
 664:	03c9d793          	srli	a5,s3,0x3c
 668:	97de                	add	a5,a5,s7
 66a:	0007c583          	lbu	a1,0(a5)
 66e:	855a                	mv	a0,s6
 670:	d1bff0ef          	jal	38a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 674:	0992                	slli	s3,s3,0x4
 676:	397d                	addiw	s2,s2,-1
 678:	fe0916e3          	bnez	s2,664 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 67c:	8bea                	mv	s7,s10
      state = 0;
 67e:	4981                	li	s3,0
 680:	6d02                	ld	s10,0(sp)
 682:	bd21                	j	49a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 684:	008b8993          	addi	s3,s7,8
 688:	000bb903          	ld	s2,0(s7)
 68c:	00090f63          	beqz	s2,6aa <vprintf+0x25a>
        for(; *s; s++)
 690:	00094583          	lbu	a1,0(s2)
 694:	c195                	beqz	a1,6b8 <vprintf+0x268>
          putc(fd, *s);
 696:	855a                	mv	a0,s6
 698:	cf3ff0ef          	jal	38a <putc>
        for(; *s; s++)
 69c:	0905                	addi	s2,s2,1
 69e:	00094583          	lbu	a1,0(s2)
 6a2:	f9f5                	bnez	a1,696 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6a4:	8bce                	mv	s7,s3
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bbcd                	j	49a <vprintf+0x4a>
          s = "(null)";
 6aa:	00000917          	auipc	s2,0x0
 6ae:	28e90913          	addi	s2,s2,654 # 938 <malloc+0x182>
        for(; *s; s++)
 6b2:	02800593          	li	a1,40
 6b6:	b7c5                	j	696 <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 6b8:	8bce                	mv	s7,s3
      state = 0;
 6ba:	4981                	li	s3,0
 6bc:	bbf9                	j	49a <vprintf+0x4a>
 6be:	64a6                	ld	s1,72(sp)
 6c0:	79e2                	ld	s3,56(sp)
 6c2:	7a42                	ld	s4,48(sp)
 6c4:	7aa2                	ld	s5,40(sp)
 6c6:	7b02                	ld	s6,32(sp)
 6c8:	6be2                	ld	s7,24(sp)
 6ca:	6c42                	ld	s8,16(sp)
 6cc:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6ce:	60e6                	ld	ra,88(sp)
 6d0:	6446                	ld	s0,80(sp)
 6d2:	6906                	ld	s2,64(sp)
 6d4:	6125                	addi	sp,sp,96
 6d6:	8082                	ret

00000000000006d8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6d8:	715d                	addi	sp,sp,-80
 6da:	ec06                	sd	ra,24(sp)
 6dc:	e822                	sd	s0,16(sp)
 6de:	1000                	addi	s0,sp,32
 6e0:	e010                	sd	a2,0(s0)
 6e2:	e414                	sd	a3,8(s0)
 6e4:	e818                	sd	a4,16(s0)
 6e6:	ec1c                	sd	a5,24(s0)
 6e8:	03043023          	sd	a6,32(s0)
 6ec:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6f4:	8622                	mv	a2,s0
 6f6:	d5bff0ef          	jal	450 <vprintf>
}
 6fa:	60e2                	ld	ra,24(sp)
 6fc:	6442                	ld	s0,16(sp)
 6fe:	6161                	addi	sp,sp,80
 700:	8082                	ret

0000000000000702 <printf>:

void
printf(const char *fmt, ...)
{
 702:	711d                	addi	sp,sp,-96
 704:	ec06                	sd	ra,24(sp)
 706:	e822                	sd	s0,16(sp)
 708:	1000                	addi	s0,sp,32
 70a:	e40c                	sd	a1,8(s0)
 70c:	e810                	sd	a2,16(s0)
 70e:	ec14                	sd	a3,24(s0)
 710:	f018                	sd	a4,32(s0)
 712:	f41c                	sd	a5,40(s0)
 714:	03043823          	sd	a6,48(s0)
 718:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 71c:	00840613          	addi	a2,s0,8
 720:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 724:	85aa                	mv	a1,a0
 726:	4505                	li	a0,1
 728:	d29ff0ef          	jal	450 <vprintf>
}
 72c:	60e2                	ld	ra,24(sp)
 72e:	6442                	ld	s0,16(sp)
 730:	6125                	addi	sp,sp,96
 732:	8082                	ret

0000000000000734 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 734:	1141                	addi	sp,sp,-16
 736:	e422                	sd	s0,8(sp)
 738:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 73a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 73e:	00001797          	auipc	a5,0x1
 742:	8c27b783          	ld	a5,-1854(a5) # 1000 <freep>
 746:	a02d                	j	770 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 748:	4618                	lw	a4,8(a2)
 74a:	9f2d                	addw	a4,a4,a1
 74c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 750:	6398                	ld	a4,0(a5)
 752:	6310                	ld	a2,0(a4)
 754:	a83d                	j	792 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 756:	ff852703          	lw	a4,-8(a0)
 75a:	9f31                	addw	a4,a4,a2
 75c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 75e:	ff053683          	ld	a3,-16(a0)
 762:	a091                	j	7a6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	6398                	ld	a4,0(a5)
 766:	00e7e463          	bltu	a5,a4,76e <free+0x3a>
 76a:	00e6ea63          	bltu	a3,a4,77e <free+0x4a>
{
 76e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	fed7fae3          	bgeu	a5,a3,764 <free+0x30>
 774:	6398                	ld	a4,0(a5)
 776:	00e6e463          	bltu	a3,a4,77e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77a:	fee7eae3          	bltu	a5,a4,76e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 77e:	ff852583          	lw	a1,-8(a0)
 782:	6390                	ld	a2,0(a5)
 784:	02059813          	slli	a6,a1,0x20
 788:	01c85713          	srli	a4,a6,0x1c
 78c:	9736                	add	a4,a4,a3
 78e:	fae60de3          	beq	a2,a4,748 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 792:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 796:	4790                	lw	a2,8(a5)
 798:	02061593          	slli	a1,a2,0x20
 79c:	01c5d713          	srli	a4,a1,0x1c
 7a0:	973e                	add	a4,a4,a5
 7a2:	fae68ae3          	beq	a3,a4,756 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7a6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7a8:	00001717          	auipc	a4,0x1
 7ac:	84f73c23          	sd	a5,-1960(a4) # 1000 <freep>
}
 7b0:	6422                	ld	s0,8(sp)
 7b2:	0141                	addi	sp,sp,16
 7b4:	8082                	ret

00000000000007b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b6:	7139                	addi	sp,sp,-64
 7b8:	fc06                	sd	ra,56(sp)
 7ba:	f822                	sd	s0,48(sp)
 7bc:	f426                	sd	s1,40(sp)
 7be:	ec4e                	sd	s3,24(sp)
 7c0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	02051493          	slli	s1,a0,0x20
 7c6:	9081                	srli	s1,s1,0x20
 7c8:	04bd                	addi	s1,s1,15
 7ca:	8091                	srli	s1,s1,0x4
 7cc:	0014899b          	addiw	s3,s1,1
 7d0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7d2:	00001517          	auipc	a0,0x1
 7d6:	82e53503          	ld	a0,-2002(a0) # 1000 <freep>
 7da:	c915                	beqz	a0,80e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7dc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7de:	4798                	lw	a4,8(a5)
 7e0:	08977a63          	bgeu	a4,s1,874 <malloc+0xbe>
 7e4:	f04a                	sd	s2,32(sp)
 7e6:	e852                	sd	s4,16(sp)
 7e8:	e456                	sd	s5,8(sp)
 7ea:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7ec:	8a4e                	mv	s4,s3
 7ee:	0009871b          	sext.w	a4,s3
 7f2:	6685                	lui	a3,0x1
 7f4:	00d77363          	bgeu	a4,a3,7fa <malloc+0x44>
 7f8:	6a05                	lui	s4,0x1
 7fa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7fe:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 802:	00000917          	auipc	s2,0x0
 806:	7fe90913          	addi	s2,s2,2046 # 1000 <freep>
  if(p == (char*)-1)
 80a:	5afd                	li	s5,-1
 80c:	a081                	j	84c <malloc+0x96>
 80e:	f04a                	sd	s2,32(sp)
 810:	e852                	sd	s4,16(sp)
 812:	e456                	sd	s5,8(sp)
 814:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 816:	00000797          	auipc	a5,0x0
 81a:	7fa78793          	addi	a5,a5,2042 # 1010 <base>
 81e:	00000717          	auipc	a4,0x0
 822:	7ef73123          	sd	a5,2018(a4) # 1000 <freep>
 826:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 828:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 82c:	b7c1                	j	7ec <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 82e:	6398                	ld	a4,0(a5)
 830:	e118                	sd	a4,0(a0)
 832:	a8a9                	j	88c <malloc+0xd6>
  hp->s.size = nu;
 834:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 838:	0541                	addi	a0,a0,16
 83a:	efbff0ef          	jal	734 <free>
  return freep;
 83e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 842:	c12d                	beqz	a0,8a4 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 844:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 846:	4798                	lw	a4,8(a5)
 848:	02977263          	bgeu	a4,s1,86c <malloc+0xb6>
    if(p == freep)
 84c:	00093703          	ld	a4,0(s2)
 850:	853e                	mv	a0,a5
 852:	fef719e3          	bne	a4,a5,844 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 856:	8552                	mv	a0,s4
 858:	b1bff0ef          	jal	372 <sbrk>
  if(p == (char*)-1)
 85c:	fd551ce3          	bne	a0,s5,834 <malloc+0x7e>
        return 0;
 860:	4501                	li	a0,0
 862:	7902                	ld	s2,32(sp)
 864:	6a42                	ld	s4,16(sp)
 866:	6aa2                	ld	s5,8(sp)
 868:	6b02                	ld	s6,0(sp)
 86a:	a03d                	j	898 <malloc+0xe2>
 86c:	7902                	ld	s2,32(sp)
 86e:	6a42                	ld	s4,16(sp)
 870:	6aa2                	ld	s5,8(sp)
 872:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 874:	fae48de3          	beq	s1,a4,82e <malloc+0x78>
        p->s.size -= nunits;
 878:	4137073b          	subw	a4,a4,s3
 87c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 87e:	02071693          	slli	a3,a4,0x20
 882:	01c6d713          	srli	a4,a3,0x1c
 886:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 888:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 88c:	00000717          	auipc	a4,0x0
 890:	76a73a23          	sd	a0,1908(a4) # 1000 <freep>
      return (void*)(p + 1);
 894:	01078513          	addi	a0,a5,16
  }
}
 898:	70e2                	ld	ra,56(sp)
 89a:	7442                	ld	s0,48(sp)
 89c:	74a2                	ld	s1,40(sp)
 89e:	69e2                	ld	s3,24(sp)
 8a0:	6121                	addi	sp,sp,64
 8a2:	8082                	ret
 8a4:	7902                	ld	s2,32(sp)
 8a6:	6a42                	ld	s4,16(sp)
 8a8:	6aa2                	ld	s5,8(sp)
 8aa:	6b02                	ld	s6,0(sp)
 8ac:	b7f5                	j	898 <malloc+0xe2>
