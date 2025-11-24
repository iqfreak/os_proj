
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	00001917          	auipc	s2,0x1
  18:	ffc90913          	addi	s2,s2,-4 # 1010 <buf>
  1c:	20000a13          	li	s4,512
    if (write(1, buf, n) != n) {
  20:	4a85                	li	s5,1
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  22:	8652                	mv	a2,s4
  24:	85ca                	mv	a1,s2
  26:	854e                	mv	a0,s3
  28:	458000ef          	jal	480 <read>
  2c:	84aa                	mv	s1,a0
  2e:	02a05363          	blez	a0,54 <cat+0x54>
    if (write(1, buf, n) != n) {
  32:	8626                	mv	a2,s1
  34:	85ca                	mv	a1,s2
  36:	8556                	mv	a0,s5
  38:	450000ef          	jal	488 <write>
  3c:	fe9503e3          	beq	a0,s1,22 <cat+0x22>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	9e058593          	addi	a1,a1,-1568 # a20 <malloc+0xf6>
  48:	4509                	li	a0,2
  4a:	7fe000ef          	jal	848 <fprintf>
      exit(1);
  4e:	4505                	li	a0,1
  50:	418000ef          	jal	468 <exit>
    }
  }
  if(n < 0){
  54:	00054b63          	bltz	a0,6a <cat+0x6a>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  58:	70e2                	ld	ra,56(sp)
  5a:	7442                	ld	s0,48(sp)
  5c:	74a2                	ld	s1,40(sp)
  5e:	7902                	ld	s2,32(sp)
  60:	69e2                	ld	s3,24(sp)
  62:	6a42                	ld	s4,16(sp)
  64:	6aa2                	ld	s5,8(sp)
  66:	6121                	addi	sp,sp,64
  68:	8082                	ret
    fprintf(2, "cat: read error\n");
  6a:	00001597          	auipc	a1,0x1
  6e:	9ce58593          	addi	a1,a1,-1586 # a38 <malloc+0x10e>
  72:	4509                	li	a0,2
  74:	7d4000ef          	jal	848 <fprintf>
    exit(1);
  78:	4505                	li	a0,1
  7a:	3ee000ef          	jal	468 <exit>

000000000000007e <main>:

int
main(int argc, char *argv[])
{
  7e:	7179                	addi	sp,sp,-48
  80:	f406                	sd	ra,40(sp)
  82:	f022                	sd	s0,32(sp)
  84:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  86:	4785                	li	a5,1
  88:	04a7d263          	bge	a5,a0,cc <main+0x4e>
  8c:	ec26                	sd	s1,24(sp)
  8e:	e84a                	sd	s2,16(sp)
  90:	e44e                	sd	s3,8(sp)
  92:	00858913          	addi	s2,a1,8
  96:	ffe5099b          	addiw	s3,a0,-2
  9a:	02099793          	slli	a5,s3,0x20
  9e:	01d7d993          	srli	s3,a5,0x1d
  a2:	05c1                	addi	a1,a1,16
  a4:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  a6:	4581                	li	a1,0
  a8:	00093503          	ld	a0,0(s2)
  ac:	3fc000ef          	jal	4a8 <open>
  b0:	84aa                	mv	s1,a0
  b2:	02054663          	bltz	a0,de <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  b6:	f4bff0ef          	jal	0 <cat>
    close(fd);
  ba:	8526                	mv	a0,s1
  bc:	3d4000ef          	jal	490 <close>
  for(i = 1; i < argc; i++){
  c0:	0921                	addi	s2,s2,8
  c2:	ff3912e3          	bne	s2,s3,a6 <main+0x28>
  }
  exit(0);
  c6:	4501                	li	a0,0
  c8:	3a0000ef          	jal	468 <exit>
  cc:	ec26                	sd	s1,24(sp)
  ce:	e84a                	sd	s2,16(sp)
  d0:	e44e                	sd	s3,8(sp)
    cat(0);
  d2:	4501                	li	a0,0
  d4:	f2dff0ef          	jal	0 <cat>
    exit(0);
  d8:	4501                	li	a0,0
  da:	38e000ef          	jal	468 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  de:	00093603          	ld	a2,0(s2)
  e2:	00001597          	auipc	a1,0x1
  e6:	96e58593          	addi	a1,a1,-1682 # a50 <malloc+0x126>
  ea:	4509                	li	a0,2
  ec:	75c000ef          	jal	848 <fprintf>
      exit(1);
  f0:	4505                	li	a0,1
  f2:	376000ef          	jal	468 <exit>

00000000000000f6 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e406                	sd	ra,8(sp)
  fa:	e022                	sd	s0,0(sp)
  fc:	0800                	addi	s0,sp,16
  extern int main();
  main();
  fe:	f81ff0ef          	jal	7e <main>
  exit(0);
 102:	4501                	li	a0,0
 104:	364000ef          	jal	468 <exit>

0000000000000108 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 110:	87aa                	mv	a5,a0
 112:	0585                	addi	a1,a1,1
 114:	0785                	addi	a5,a5,1
 116:	fff5c703          	lbu	a4,-1(a1)
 11a:	fee78fa3          	sb	a4,-1(a5)
 11e:	fb75                	bnez	a4,112 <strcpy+0xa>
    ;
  return os;
}
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strcmp>:

int strcmp(const char *p, const char *q)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb91                	beqz	a5,148 <strcmp+0x20>
 136:	0005c703          	lbu	a4,0(a1)
 13a:	00f71763          	bne	a4,a5,148 <strcmp+0x20>
    p++, q++;
 13e:	0505                	addi	a0,a0,1
 140:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 142:	00054783          	lbu	a5,0(a0)
 146:	fbe5                	bnez	a5,136 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 148:	0005c503          	lbu	a0,0(a1)
}
 14c:	40a7853b          	subw	a0,a5,a0
 150:	60a2                	ld	ra,8(sp)
 152:	6402                	ld	s0,0(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret

0000000000000158 <strlen>:

uint strlen(const char *s)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e406                	sd	ra,8(sp)
 15c:	e022                	sd	s0,0(sp)
 15e:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf99                	beqz	a5,182 <strlen+0x2a>
 166:	0505                	addi	a0,a0,1
 168:	87aa                	mv	a5,a0
 16a:	86be                	mv	a3,a5
 16c:	0785                	addi	a5,a5,1
 16e:	fff7c703          	lbu	a4,-1(a5)
 172:	ff65                	bnez	a4,16a <strlen+0x12>
 174:	40a6853b          	subw	a0,a3,a0
 178:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 17a:	60a2                	ld	ra,8(sp)
 17c:	6402                	ld	s0,0(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  for (n = 0; s[n]; n++)
 182:	4501                	li	a0,0
 184:	bfdd                	j	17a <strlen+0x22>

0000000000000186 <memset>:

void *
memset(void *dst, int c, uint n)
{
 186:	1141                	addi	sp,sp,-16
 188:	e406                	sd	ra,8(sp)
 18a:	e022                	sd	s0,0(sp)
 18c:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 18e:	ca19                	beqz	a2,1a4 <memset+0x1e>
 190:	87aa                	mv	a5,a0
 192:	1602                	slli	a2,a2,0x20
 194:	9201                	srli	a2,a2,0x20
 196:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 19a:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 19e:	0785                	addi	a5,a5,1
 1a0:	fee79de3          	bne	a5,a4,19a <memset+0x14>
  }
  return dst;
}
 1a4:	60a2                	ld	ra,8(sp)
 1a6:	6402                	ld	s0,0(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <strchr>:

char *
strchr(const char *s, char c)
{
 1ac:	1141                	addi	sp,sp,-16
 1ae:	e406                	sd	ra,8(sp)
 1b0:	e022                	sd	s0,0(sp)
 1b2:	0800                	addi	s0,sp,16
  for (; *s; s++)
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	cf81                	beqz	a5,1d0 <strchr+0x24>
    if (*s == c)
 1ba:	00f58763          	beq	a1,a5,1c8 <strchr+0x1c>
  for (; *s; s++)
 1be:	0505                	addi	a0,a0,1
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	fbfd                	bnez	a5,1ba <strchr+0xe>
      return (char *)s;
  return 0;
 1c6:	4501                	li	a0,0
}
 1c8:	60a2                	ld	ra,8(sp)
 1ca:	6402                	ld	s0,0(sp)
 1cc:	0141                	addi	sp,sp,16
 1ce:	8082                	ret
  return 0;
 1d0:	4501                	li	a0,0
 1d2:	bfdd                	j	1c8 <strchr+0x1c>

00000000000001d4 <gets>:

char *
gets(char *buf, int max)
{
 1d4:	7159                	addi	sp,sp,-112
 1d6:	f486                	sd	ra,104(sp)
 1d8:	f0a2                	sd	s0,96(sp)
 1da:	eca6                	sd	s1,88(sp)
 1dc:	e8ca                	sd	s2,80(sp)
 1de:	e4ce                	sd	s3,72(sp)
 1e0:	e0d2                	sd	s4,64(sp)
 1e2:	fc56                	sd	s5,56(sp)
 1e4:	f85a                	sd	s6,48(sp)
 1e6:	f45e                	sd	s7,40(sp)
 1e8:	f062                	sd	s8,32(sp)
 1ea:	ec66                	sd	s9,24(sp)
 1ec:	e86a                	sd	s10,16(sp)
 1ee:	1880                	addi	s0,sp,112
 1f0:	8caa                	mv	s9,a0
 1f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 1f4:	892a                	mv	s2,a0
 1f6:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 1f8:	f9f40b13          	addi	s6,s0,-97
 1fc:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 1fe:	4ba9                	li	s7,10
 200:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 202:	8d26                	mv	s10,s1
 204:	0014899b          	addiw	s3,s1,1
 208:	84ce                	mv	s1,s3
 20a:	0349d563          	bge	s3,s4,234 <gets+0x60>
    cc = read(0, &c, 1);
 20e:	8656                	mv	a2,s5
 210:	85da                	mv	a1,s6
 212:	4501                	li	a0,0
 214:	26c000ef          	jal	480 <read>
    if (cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x60>
    buf[i++] = c;
 21c:	f9f44783          	lbu	a5,-97(s0)
 220:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 224:	01778763          	beq	a5,s7,232 <gets+0x5e>
 228:	0905                	addi	s2,s2,1
 22a:	fd879ce3          	bne	a5,s8,202 <gets+0x2e>
    buf[i++] = c;
 22e:	8d4e                	mv	s10,s3
 230:	a011                	j	234 <gets+0x60>
 232:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 234:	9d66                	add	s10,s10,s9
 236:	000d0023          	sb	zero,0(s10)
  return buf;
}
 23a:	8566                	mv	a0,s9
 23c:	70a6                	ld	ra,104(sp)
 23e:	7406                	ld	s0,96(sp)
 240:	64e6                	ld	s1,88(sp)
 242:	6946                	ld	s2,80(sp)
 244:	69a6                	ld	s3,72(sp)
 246:	6a06                	ld	s4,64(sp)
 248:	7ae2                	ld	s5,56(sp)
 24a:	7b42                	ld	s6,48(sp)
 24c:	7ba2                	ld	s7,40(sp)
 24e:	7c02                	ld	s8,32(sp)
 250:	6ce2                	ld	s9,24(sp)
 252:	6d42                	ld	s10,16(sp)
 254:	6165                	addi	sp,sp,112
 256:	8082                	ret

0000000000000258 <stat>:

int stat(const char *n, struct stat *st)
{
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e04a                	sd	s2,0(sp)
 260:	1000                	addi	s0,sp,32
 262:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 264:	4581                	li	a1,0
 266:	242000ef          	jal	4a8 <open>
  if (fd < 0)
 26a:	02054263          	bltz	a0,28e <stat+0x36>
 26e:	e426                	sd	s1,8(sp)
 270:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 272:	85ca                	mv	a1,s2
 274:	24c000ef          	jal	4c0 <fstat>
 278:	892a                	mv	s2,a0
  close(fd);
 27a:	8526                	mv	a0,s1
 27c:	214000ef          	jal	490 <close>
  return r;
 280:	64a2                	ld	s1,8(sp)
}
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	6902                	ld	s2,0(sp)
 28a:	6105                	addi	sp,sp,32
 28c:	8082                	ret
    return -1;
 28e:	597d                	li	s2,-1
 290:	bfcd                	j	282 <stat+0x2a>

0000000000000292 <atoi>:

int atoi(const char *s)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 29a:	00054683          	lbu	a3,0(a0)
 29e:	fd06879b          	addiw	a5,a3,-48
 2a2:	0ff7f793          	zext.b	a5,a5
 2a6:	4625                	li	a2,9
 2a8:	02f66963          	bltu	a2,a5,2da <atoi+0x48>
 2ac:	872a                	mv	a4,a0
  n = 0;
 2ae:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 2b0:	0705                	addi	a4,a4,1
 2b2:	0025179b          	slliw	a5,a0,0x2
 2b6:	9fa9                	addw	a5,a5,a0
 2b8:	0017979b          	slliw	a5,a5,0x1
 2bc:	9fb5                	addw	a5,a5,a3
 2be:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 2c2:	00074683          	lbu	a3,0(a4)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	fef671e3          	bgeu	a2,a5,2b0 <atoi+0x1e>
  return n;
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  n = 0;
 2da:	4501                	li	a0,0
 2dc:	bfdd                	j	2d2 <atoi+0x40>

00000000000002de <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e406                	sd	ra,8(sp)
 2e2:	e022                	sd	s0,0(sp)
 2e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 2e6:	02b57563          	bgeu	a0,a1,310 <memmove+0x32>
  {
    while (n-- > 0)
 2ea:	00c05f63          	blez	a2,308 <memmove+0x2a>
 2ee:	1602                	slli	a2,a2,0x20
 2f0:	9201                	srli	a2,a2,0x20
 2f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f8:	0585                	addi	a1,a1,1
 2fa:	0705                	addi	a4,a4,1
 2fc:	fff5c683          	lbu	a3,-1(a1)
 300:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 304:	fee79ae3          	bne	a5,a4,2f8 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 316:	fec059e3          	blez	a2,308 <memmove+0x2a>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 334:	fef71ae3          	bne	a4,a5,328 <memmove+0x4a>
 338:	bfc1                	j	308 <memmove+0x2a>

000000000000033a <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 342:	ca0d                	beqz	a2,374 <memcmp+0x3a>
 344:	fff6069b          	addiw	a3,a2,-1
 348:	1682                	slli	a3,a3,0x20
 34a:	9281                	srli	a3,a3,0x20
 34c:	0685                	addi	a3,a3,1
 34e:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 350:	00054783          	lbu	a5,0(a0)
 354:	0005c703          	lbu	a4,0(a1)
 358:	00e79863          	bne	a5,a4,368 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 35c:	0505                	addi	a0,a0,1
    p2++;
 35e:	0585                	addi	a1,a1,1
  while (n-- > 0)
 360:	fed518e3          	bne	a0,a3,350 <memcmp+0x16>
  }
  return 0;
 364:	4501                	li	a0,0
 366:	a019                	j	36c <memcmp+0x32>
      return *p1 - *p2;
 368:	40e7853b          	subw	a0,a5,a4
}
 36c:	60a2                	ld	ra,8(sp)
 36e:	6402                	ld	s0,0(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfdd                	j	36c <memcmp+0x32>

0000000000000378 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 380:	f5fff0ef          	jal	2de <memmove>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <strcat>:

char *strcat(char *dst, const char *src)
{
 38c:	1141                	addi	sp,sp,-16
 38e:	e406                	sd	ra,8(sp)
 390:	e022                	sd	s0,0(sp)
 392:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 394:	00054783          	lbu	a5,0(a0)
 398:	c795                	beqz	a5,3c4 <strcat+0x38>
  char *p = dst;
 39a:	87aa                	mv	a5,a0
    p++;
 39c:	0785                	addi	a5,a5,1
  while (*p)
 39e:	0007c703          	lbu	a4,0(a5)
 3a2:	ff6d                	bnez	a4,39c <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 3a4:	0005c703          	lbu	a4,0(a1)
 3a8:	cb01                	beqz	a4,3b8 <strcat+0x2c>
  {
    *p = *src;
 3aa:	00e78023          	sb	a4,0(a5)
    p++;
 3ae:	0785                	addi	a5,a5,1
    src++;
 3b0:	0585                	addi	a1,a1,1
  while (*src)
 3b2:	0005c703          	lbu	a4,0(a1)
 3b6:	fb75                	bnez	a4,3aa <strcat+0x1e>
  }

  *p = 0;
 3b8:	00078023          	sb	zero,0(a5)

  return dst;
}
 3bc:	60a2                	ld	ra,8(sp)
 3be:	6402                	ld	s0,0(sp)
 3c0:	0141                	addi	sp,sp,16
 3c2:	8082                	ret
  char *p = dst;
 3c4:	87aa                	mv	a5,a0
 3c6:	bff9                	j	3a4 <strcat+0x18>

00000000000003c8 <isdir>:

int isdir(char *path)
{
 3c8:	7179                	addi	sp,sp,-48
 3ca:	f406                	sd	ra,40(sp)
 3cc:	f022                	sd	s0,32(sp)
 3ce:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 3d0:	fd840593          	addi	a1,s0,-40
 3d4:	e85ff0ef          	jal	258 <stat>
 3d8:	00054b63          	bltz	a0,3ee <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 3dc:	fe041503          	lh	a0,-32(s0)
 3e0:	157d                	addi	a0,a0,-1
 3e2:	00153513          	seqz	a0,a0
}
 3e6:	70a2                	ld	ra,40(sp)
 3e8:	7402                	ld	s0,32(sp)
 3ea:	6145                	addi	sp,sp,48
 3ec:	8082                	ret
    return 0;
 3ee:	4501                	li	a0,0
 3f0:	bfdd                	j	3e6 <isdir+0x1e>

00000000000003f2 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 3f2:	7139                	addi	sp,sp,-64
 3f4:	fc06                	sd	ra,56(sp)
 3f6:	f822                	sd	s0,48(sp)
 3f8:	f426                	sd	s1,40(sp)
 3fa:	f04a                	sd	s2,32(sp)
 3fc:	ec4e                	sd	s3,24(sp)
 3fe:	e852                	sd	s4,16(sp)
 400:	e456                	sd	s5,8(sp)
 402:	0080                	addi	s0,sp,64
 404:	89aa                	mv	s3,a0
 406:	8aae                	mv	s5,a1
 408:	84b2                	mv	s1,a2
 40a:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 40c:	d4dff0ef          	jal	158 <strlen>
 410:	892a                	mv	s2,a0
  int nn = strlen(filename);
 412:	8556                	mv	a0,s5
 414:	d45ff0ef          	jal	158 <strlen>
  int need = dn + 1 + nn + 1;
 418:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 41c:	9fa9                	addw	a5,a5,a0
    return 0;
 41e:	4501                	li	a0,0
  if (need > bufsize)
 420:	0347d763          	bge	a5,s4,44e <joinpath+0x5c>
  strcpy(out_buffer, dir);
 424:	85ce                	mv	a1,s3
 426:	8526                	mv	a0,s1
 428:	ce1ff0ef          	jal	108 <strcpy>
  if (dir[dn - 1] != '/')
 42c:	99ca                	add	s3,s3,s2
 42e:	fff9c703          	lbu	a4,-1(s3)
 432:	02f00793          	li	a5,47
 436:	00f70763          	beq	a4,a5,444 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 43a:	9926                	add	s2,s2,s1
 43c:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 440:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 444:	85d6                	mv	a1,s5
 446:	8526                	mv	a0,s1
 448:	f45ff0ef          	jal	38c <strcat>
  return out_buffer;
 44c:	8526                	mv	a0,s1
}
 44e:	70e2                	ld	ra,56(sp)
 450:	7442                	ld	s0,48(sp)
 452:	74a2                	ld	s1,40(sp)
 454:	7902                	ld	s2,32(sp)
 456:	69e2                	ld	s3,24(sp)
 458:	6a42                	ld	s4,16(sp)
 45a:	6aa2                	ld	s5,8(sp)
 45c:	6121                	addi	sp,sp,64
 45e:	8082                	ret

0000000000000460 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 460:	4885                	li	a7,1
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <exit>:
.global exit
exit:
 li a7, SYS_exit
 468:	4889                	li	a7,2
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <wait>:
.global wait
wait:
 li a7, SYS_wait
 470:	488d                	li	a7,3
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 478:	4891                	li	a7,4
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <read>:
.global read
read:
 li a7, SYS_read
 480:	4895                	li	a7,5
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <write>:
.global write
write:
 li a7, SYS_write
 488:	48c1                	li	a7,16
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <close>:
.global close
close:
 li a7, SYS_close
 490:	48d5                	li	a7,21
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <kill>:
.global kill
kill:
 li a7, SYS_kill
 498:	4899                	li	a7,6
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4a0:	489d                	li	a7,7
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <open>:
.global open
open:
 li a7, SYS_open
 4a8:	48bd                	li	a7,15
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4b0:	48c5                	li	a7,17
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4b8:	48c9                	li	a7,18
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4c0:	48a1                	li	a7,8
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <link>:
.global link
link:
 li a7, SYS_link
 4c8:	48cd                	li	a7,19
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4d0:	48d1                	li	a7,20
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4d8:	48a5                	li	a7,9
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4e0:	48a9                	li	a7,10
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4e8:	48ad                	li	a7,11
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4f0:	48b1                	li	a7,12
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4f8:	48b5                	li	a7,13
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 500:	48b9                	li	a7,14
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 508:	48d9                	li	a7,22
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 510:	1101                	addi	sp,sp,-32
 512:	ec06                	sd	ra,24(sp)
 514:	e822                	sd	s0,16(sp)
 516:	1000                	addi	s0,sp,32
 518:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 51c:	4605                	li	a2,1
 51e:	fef40593          	addi	a1,s0,-17
 522:	f67ff0ef          	jal	488 <write>
}
 526:	60e2                	ld	ra,24(sp)
 528:	6442                	ld	s0,16(sp)
 52a:	6105                	addi	sp,sp,32
 52c:	8082                	ret

000000000000052e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 52e:	7139                	addi	sp,sp,-64
 530:	fc06                	sd	ra,56(sp)
 532:	f822                	sd	s0,48(sp)
 534:	f426                	sd	s1,40(sp)
 536:	f04a                	sd	s2,32(sp)
 538:	ec4e                	sd	s3,24(sp)
 53a:	0080                	addi	s0,sp,64
 53c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53e:	c299                	beqz	a3,544 <printint+0x16>
 540:	0605ce63          	bltz	a1,5bc <printint+0x8e>
  neg = 0;
 544:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 546:	fc040313          	addi	t1,s0,-64
  neg = 0;
 54a:	869a                	mv	a3,t1
  i = 0;
 54c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 54e:	00000817          	auipc	a6,0x0
 552:	52280813          	addi	a6,a6,1314 # a70 <digits>
 556:	88be                	mv	a7,a5
 558:	0017851b          	addiw	a0,a5,1
 55c:	87aa                	mv	a5,a0
 55e:	02c5f73b          	remuw	a4,a1,a2
 562:	1702                	slli	a4,a4,0x20
 564:	9301                	srli	a4,a4,0x20
 566:	9742                	add	a4,a4,a6
 568:	00074703          	lbu	a4,0(a4)
 56c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 570:	872e                	mv	a4,a1
 572:	02c5d5bb          	divuw	a1,a1,a2
 576:	0685                	addi	a3,a3,1
 578:	fcc77fe3          	bgeu	a4,a2,556 <printint+0x28>
  if(neg)
 57c:	000e0c63          	beqz	t3,594 <printint+0x66>
    buf[i++] = '-';
 580:	fd050793          	addi	a5,a0,-48
 584:	00878533          	add	a0,a5,s0
 588:	02d00793          	li	a5,45
 58c:	fef50823          	sb	a5,-16(a0)
 590:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 594:	fff7899b          	addiw	s3,a5,-1
 598:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 59c:	fff4c583          	lbu	a1,-1(s1)
 5a0:	854a                	mv	a0,s2
 5a2:	f6fff0ef          	jal	510 <putc>
  while(--i >= 0)
 5a6:	39fd                	addiw	s3,s3,-1
 5a8:	14fd                	addi	s1,s1,-1
 5aa:	fe09d9e3          	bgez	s3,59c <printint+0x6e>
}
 5ae:	70e2                	ld	ra,56(sp)
 5b0:	7442                	ld	s0,48(sp)
 5b2:	74a2                	ld	s1,40(sp)
 5b4:	7902                	ld	s2,32(sp)
 5b6:	69e2                	ld	s3,24(sp)
 5b8:	6121                	addi	sp,sp,64
 5ba:	8082                	ret
    x = -xx;
 5bc:	40b005bb          	negw	a1,a1
    neg = 1;
 5c0:	4e05                	li	t3,1
    x = -xx;
 5c2:	b751                	j	546 <printint+0x18>

00000000000005c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c4:	711d                	addi	sp,sp,-96
 5c6:	ec86                	sd	ra,88(sp)
 5c8:	e8a2                	sd	s0,80(sp)
 5ca:	e4a6                	sd	s1,72(sp)
 5cc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ce:	0005c483          	lbu	s1,0(a1)
 5d2:	26048663          	beqz	s1,83e <vprintf+0x27a>
 5d6:	e0ca                	sd	s2,64(sp)
 5d8:	fc4e                	sd	s3,56(sp)
 5da:	f852                	sd	s4,48(sp)
 5dc:	f456                	sd	s5,40(sp)
 5de:	f05a                	sd	s6,32(sp)
 5e0:	ec5e                	sd	s7,24(sp)
 5e2:	e862                	sd	s8,16(sp)
 5e4:	e466                	sd	s9,8(sp)
 5e6:	8b2a                	mv	s6,a0
 5e8:	8a2e                	mv	s4,a1
 5ea:	8bb2                	mv	s7,a2
  state = 0;
 5ec:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5ee:	4901                	li	s2,0
 5f0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5f2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5f6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5fa:	06c00c93          	li	s9,108
 5fe:	a00d                	j	620 <vprintf+0x5c>
        putc(fd, c0);
 600:	85a6                	mv	a1,s1
 602:	855a                	mv	a0,s6
 604:	f0dff0ef          	jal	510 <putc>
 608:	a019                	j	60e <vprintf+0x4a>
    } else if(state == '%'){
 60a:	03598363          	beq	s3,s5,630 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 60e:	0019079b          	addiw	a5,s2,1
 612:	893e                	mv	s2,a5
 614:	873e                	mv	a4,a5
 616:	97d2                	add	a5,a5,s4
 618:	0007c483          	lbu	s1,0(a5)
 61c:	20048963          	beqz	s1,82e <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 620:	0004879b          	sext.w	a5,s1
    if(state == 0){
 624:	fe0993e3          	bnez	s3,60a <vprintf+0x46>
      if(c0 == '%'){
 628:	fd579ce3          	bne	a5,s5,600 <vprintf+0x3c>
        state = '%';
 62c:	89be                	mv	s3,a5
 62e:	b7c5                	j	60e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 630:	00ea06b3          	add	a3,s4,a4
 634:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 638:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 63a:	c681                	beqz	a3,642 <vprintf+0x7e>
 63c:	9752                	add	a4,a4,s4
 63e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 642:	03878e63          	beq	a5,s8,67e <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 646:	05978863          	beq	a5,s9,696 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 64a:	07500713          	li	a4,117
 64e:	0ee78263          	beq	a5,a4,732 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 652:	07800713          	li	a4,120
 656:	12e78463          	beq	a5,a4,77e <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 65a:	07000713          	li	a4,112
 65e:	14e78963          	beq	a5,a4,7b0 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 662:	07300713          	li	a4,115
 666:	18e78863          	beq	a5,a4,7f6 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 66a:	02500713          	li	a4,37
 66e:	04e79463          	bne	a5,a4,6b6 <vprintf+0xf2>
        putc(fd, '%');
 672:	85ba                	mv	a1,a4
 674:	855a                	mv	a0,s6
 676:	e9bff0ef          	jal	510 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 67a:	4981                	li	s3,0
 67c:	bf49                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 67e:	008b8493          	addi	s1,s7,8
 682:	4685                	li	a3,1
 684:	4629                	li	a2,10
 686:	000ba583          	lw	a1,0(s7)
 68a:	855a                	mv	a0,s6
 68c:	ea3ff0ef          	jal	52e <printint>
 690:	8ba6                	mv	s7,s1
      state = 0;
 692:	4981                	li	s3,0
 694:	bfad                	j	60e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 696:	06400793          	li	a5,100
 69a:	02f68963          	beq	a3,a5,6cc <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 69e:	06c00793          	li	a5,108
 6a2:	04f68263          	beq	a3,a5,6e6 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 6a6:	07500793          	li	a5,117
 6aa:	0af68063          	beq	a3,a5,74a <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 6ae:	07800793          	li	a5,120
 6b2:	0ef68263          	beq	a3,a5,796 <vprintf+0x1d2>
        putc(fd, '%');
 6b6:	02500593          	li	a1,37
 6ba:	855a                	mv	a0,s6
 6bc:	e55ff0ef          	jal	510 <putc>
        putc(fd, c0);
 6c0:	85a6                	mv	a1,s1
 6c2:	855a                	mv	a0,s6
 6c4:	e4dff0ef          	jal	510 <putc>
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	b791                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6cc:	008b8493          	addi	s1,s7,8
 6d0:	4685                	li	a3,1
 6d2:	4629                	li	a2,10
 6d4:	000ba583          	lw	a1,0(s7)
 6d8:	855a                	mv	a0,s6
 6da:	e55ff0ef          	jal	52e <printint>
        i += 1;
 6de:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e0:	8ba6                	mv	s7,s1
      state = 0;
 6e2:	4981                	li	s3,0
        i += 1;
 6e4:	b72d                	j	60e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6e6:	06400793          	li	a5,100
 6ea:	02f60763          	beq	a2,a5,718 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6ee:	07500793          	li	a5,117
 6f2:	06f60963          	beq	a2,a5,764 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6f6:	07800793          	li	a5,120
 6fa:	faf61ee3          	bne	a2,a5,6b6 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fe:	008b8493          	addi	s1,s7,8
 702:	4681                	li	a3,0
 704:	4641                	li	a2,16
 706:	000ba583          	lw	a1,0(s7)
 70a:	855a                	mv	a0,s6
 70c:	e23ff0ef          	jal	52e <printint>
        i += 2;
 710:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 712:	8ba6                	mv	s7,s1
      state = 0;
 714:	4981                	li	s3,0
        i += 2;
 716:	bde5                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 718:	008b8493          	addi	s1,s7,8
 71c:	4685                	li	a3,1
 71e:	4629                	li	a2,10
 720:	000ba583          	lw	a1,0(s7)
 724:	855a                	mv	a0,s6
 726:	e09ff0ef          	jal	52e <printint>
        i += 2;
 72a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 72c:	8ba6                	mv	s7,s1
      state = 0;
 72e:	4981                	li	s3,0
        i += 2;
 730:	bdf9                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 732:	008b8493          	addi	s1,s7,8
 736:	4681                	li	a3,0
 738:	4629                	li	a2,10
 73a:	000ba583          	lw	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	defff0ef          	jal	52e <printint>
 744:	8ba6                	mv	s7,s1
      state = 0;
 746:	4981                	li	s3,0
 748:	b5d9                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 74a:	008b8493          	addi	s1,s7,8
 74e:	4681                	li	a3,0
 750:	4629                	li	a2,10
 752:	000ba583          	lw	a1,0(s7)
 756:	855a                	mv	a0,s6
 758:	dd7ff0ef          	jal	52e <printint>
        i += 1;
 75c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 75e:	8ba6                	mv	s7,s1
      state = 0;
 760:	4981                	li	s3,0
        i += 1;
 762:	b575                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 764:	008b8493          	addi	s1,s7,8
 768:	4681                	li	a3,0
 76a:	4629                	li	a2,10
 76c:	000ba583          	lw	a1,0(s7)
 770:	855a                	mv	a0,s6
 772:	dbdff0ef          	jal	52e <printint>
        i += 2;
 776:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 778:	8ba6                	mv	s7,s1
      state = 0;
 77a:	4981                	li	s3,0
        i += 2;
 77c:	bd49                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 77e:	008b8493          	addi	s1,s7,8
 782:	4681                	li	a3,0
 784:	4641                	li	a2,16
 786:	000ba583          	lw	a1,0(s7)
 78a:	855a                	mv	a0,s6
 78c:	da3ff0ef          	jal	52e <printint>
 790:	8ba6                	mv	s7,s1
      state = 0;
 792:	4981                	li	s3,0
 794:	bdad                	j	60e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 796:	008b8493          	addi	s1,s7,8
 79a:	4681                	li	a3,0
 79c:	4641                	li	a2,16
 79e:	000ba583          	lw	a1,0(s7)
 7a2:	855a                	mv	a0,s6
 7a4:	d8bff0ef          	jal	52e <printint>
        i += 1;
 7a8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7aa:	8ba6                	mv	s7,s1
      state = 0;
 7ac:	4981                	li	s3,0
        i += 1;
 7ae:	b585                	j	60e <vprintf+0x4a>
 7b0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7b2:	008b8d13          	addi	s10,s7,8
 7b6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7ba:	03000593          	li	a1,48
 7be:	855a                	mv	a0,s6
 7c0:	d51ff0ef          	jal	510 <putc>
  putc(fd, 'x');
 7c4:	07800593          	li	a1,120
 7c8:	855a                	mv	a0,s6
 7ca:	d47ff0ef          	jal	510 <putc>
 7ce:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d0:	00000b97          	auipc	s7,0x0
 7d4:	2a0b8b93          	addi	s7,s7,672 # a70 <digits>
 7d8:	03c9d793          	srli	a5,s3,0x3c
 7dc:	97de                	add	a5,a5,s7
 7de:	0007c583          	lbu	a1,0(a5)
 7e2:	855a                	mv	a0,s6
 7e4:	d2dff0ef          	jal	510 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e8:	0992                	slli	s3,s3,0x4
 7ea:	34fd                	addiw	s1,s1,-1
 7ec:	f4f5                	bnez	s1,7d8 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 7ee:	8bea                	mv	s7,s10
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	6d02                	ld	s10,0(sp)
 7f4:	bd29                	j	60e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7f6:	008b8993          	addi	s3,s7,8
 7fa:	000bb483          	ld	s1,0(s7)
 7fe:	cc91                	beqz	s1,81a <vprintf+0x256>
        for(; *s; s++)
 800:	0004c583          	lbu	a1,0(s1)
 804:	c195                	beqz	a1,828 <vprintf+0x264>
          putc(fd, *s);
 806:	855a                	mv	a0,s6
 808:	d09ff0ef          	jal	510 <putc>
        for(; *s; s++)
 80c:	0485                	addi	s1,s1,1
 80e:	0004c583          	lbu	a1,0(s1)
 812:	f9f5                	bnez	a1,806 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 814:	8bce                	mv	s7,s3
      state = 0;
 816:	4981                	li	s3,0
 818:	bbdd                	j	60e <vprintf+0x4a>
          s = "(null)";
 81a:	00000497          	auipc	s1,0x0
 81e:	24e48493          	addi	s1,s1,590 # a68 <malloc+0x13e>
        for(; *s; s++)
 822:	02800593          	li	a1,40
 826:	b7c5                	j	806 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 828:	8bce                	mv	s7,s3
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b3cd                	j	60e <vprintf+0x4a>
 82e:	6906                	ld	s2,64(sp)
 830:	79e2                	ld	s3,56(sp)
 832:	7a42                	ld	s4,48(sp)
 834:	7aa2                	ld	s5,40(sp)
 836:	7b02                	ld	s6,32(sp)
 838:	6be2                	ld	s7,24(sp)
 83a:	6c42                	ld	s8,16(sp)
 83c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 83e:	60e6                	ld	ra,88(sp)
 840:	6446                	ld	s0,80(sp)
 842:	64a6                	ld	s1,72(sp)
 844:	6125                	addi	sp,sp,96
 846:	8082                	ret

0000000000000848 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 848:	715d                	addi	sp,sp,-80
 84a:	ec06                	sd	ra,24(sp)
 84c:	e822                	sd	s0,16(sp)
 84e:	1000                	addi	s0,sp,32
 850:	e010                	sd	a2,0(s0)
 852:	e414                	sd	a3,8(s0)
 854:	e818                	sd	a4,16(s0)
 856:	ec1c                	sd	a5,24(s0)
 858:	03043023          	sd	a6,32(s0)
 85c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 860:	8622                	mv	a2,s0
 862:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 866:	d5fff0ef          	jal	5c4 <vprintf>
}
 86a:	60e2                	ld	ra,24(sp)
 86c:	6442                	ld	s0,16(sp)
 86e:	6161                	addi	sp,sp,80
 870:	8082                	ret

0000000000000872 <printf>:

void
printf(const char *fmt, ...)
{
 872:	711d                	addi	sp,sp,-96
 874:	ec06                	sd	ra,24(sp)
 876:	e822                	sd	s0,16(sp)
 878:	1000                	addi	s0,sp,32
 87a:	e40c                	sd	a1,8(s0)
 87c:	e810                	sd	a2,16(s0)
 87e:	ec14                	sd	a3,24(s0)
 880:	f018                	sd	a4,32(s0)
 882:	f41c                	sd	a5,40(s0)
 884:	03043823          	sd	a6,48(s0)
 888:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 88c:	00840613          	addi	a2,s0,8
 890:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 894:	85aa                	mv	a1,a0
 896:	4505                	li	a0,1
 898:	d2dff0ef          	jal	5c4 <vprintf>
}
 89c:	60e2                	ld	ra,24(sp)
 89e:	6442                	ld	s0,16(sp)
 8a0:	6125                	addi	sp,sp,96
 8a2:	8082                	ret

00000000000008a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a4:	1141                	addi	sp,sp,-16
 8a6:	e406                	sd	ra,8(sp)
 8a8:	e022                	sd	s0,0(sp)
 8aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b0:	00000797          	auipc	a5,0x0
 8b4:	7507b783          	ld	a5,1872(a5) # 1000 <freep>
 8b8:	a02d                	j	8e2 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ba:	4618                	lw	a4,8(a2)
 8bc:	9f2d                	addw	a4,a4,a1
 8be:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c2:	6398                	ld	a4,0(a5)
 8c4:	6310                	ld	a2,0(a4)
 8c6:	a83d                	j	904 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c8:	ff852703          	lw	a4,-8(a0)
 8cc:	9f31                	addw	a4,a4,a2
 8ce:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8d0:	ff053683          	ld	a3,-16(a0)
 8d4:	a091                	j	918 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	6398                	ld	a4,0(a5)
 8d8:	00e7e463          	bltu	a5,a4,8e0 <free+0x3c>
 8dc:	00e6ea63          	bltu	a3,a4,8f0 <free+0x4c>
{
 8e0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e2:	fed7fae3          	bgeu	a5,a3,8d6 <free+0x32>
 8e6:	6398                	ld	a4,0(a5)
 8e8:	00e6e463          	bltu	a3,a4,8f0 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ec:	fee7eae3          	bltu	a5,a4,8e0 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 8f0:	ff852583          	lw	a1,-8(a0)
 8f4:	6390                	ld	a2,0(a5)
 8f6:	02059813          	slli	a6,a1,0x20
 8fa:	01c85713          	srli	a4,a6,0x1c
 8fe:	9736                	add	a4,a4,a3
 900:	fae60de3          	beq	a2,a4,8ba <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 904:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 908:	4790                	lw	a2,8(a5)
 90a:	02061593          	slli	a1,a2,0x20
 90e:	01c5d713          	srli	a4,a1,0x1c
 912:	973e                	add	a4,a4,a5
 914:	fae68ae3          	beq	a3,a4,8c8 <free+0x24>
    p->s.ptr = bp->s.ptr;
 918:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 91a:	00000717          	auipc	a4,0x0
 91e:	6ef73323          	sd	a5,1766(a4) # 1000 <freep>
}
 922:	60a2                	ld	ra,8(sp)
 924:	6402                	ld	s0,0(sp)
 926:	0141                	addi	sp,sp,16
 928:	8082                	ret

000000000000092a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 92a:	7139                	addi	sp,sp,-64
 92c:	fc06                	sd	ra,56(sp)
 92e:	f822                	sd	s0,48(sp)
 930:	f04a                	sd	s2,32(sp)
 932:	ec4e                	sd	s3,24(sp)
 934:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 936:	02051993          	slli	s3,a0,0x20
 93a:	0209d993          	srli	s3,s3,0x20
 93e:	09bd                	addi	s3,s3,15
 940:	0049d993          	srli	s3,s3,0x4
 944:	2985                	addiw	s3,s3,1
 946:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 948:	00000517          	auipc	a0,0x0
 94c:	6b853503          	ld	a0,1720(a0) # 1000 <freep>
 950:	c905                	beqz	a0,980 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 952:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 954:	4798                	lw	a4,8(a5)
 956:	09377663          	bgeu	a4,s3,9e2 <malloc+0xb8>
 95a:	f426                	sd	s1,40(sp)
 95c:	e852                	sd	s4,16(sp)
 95e:	e456                	sd	s5,8(sp)
 960:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 962:	8a4e                	mv	s4,s3
 964:	6705                	lui	a4,0x1
 966:	00e9f363          	bgeu	s3,a4,96c <malloc+0x42>
 96a:	6a05                	lui	s4,0x1
 96c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 970:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 974:	00000497          	auipc	s1,0x0
 978:	68c48493          	addi	s1,s1,1676 # 1000 <freep>
  if(p == (char*)-1)
 97c:	5afd                	li	s5,-1
 97e:	a83d                	j	9bc <malloc+0x92>
 980:	f426                	sd	s1,40(sp)
 982:	e852                	sd	s4,16(sp)
 984:	e456                	sd	s5,8(sp)
 986:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 988:	00001797          	auipc	a5,0x1
 98c:	88878793          	addi	a5,a5,-1912 # 1210 <base>
 990:	00000717          	auipc	a4,0x0
 994:	66f73823          	sd	a5,1648(a4) # 1000 <freep>
 998:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 99a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 99e:	b7d1                	j	962 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9a0:	6398                	ld	a4,0(a5)
 9a2:	e118                	sd	a4,0(a0)
 9a4:	a899                	j	9fa <malloc+0xd0>
  hp->s.size = nu;
 9a6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9aa:	0541                	addi	a0,a0,16
 9ac:	ef9ff0ef          	jal	8a4 <free>
  return freep;
 9b0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9b2:	c125                	beqz	a0,a12 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b6:	4798                	lw	a4,8(a5)
 9b8:	03277163          	bgeu	a4,s2,9da <malloc+0xb0>
    if(p == freep)
 9bc:	6098                	ld	a4,0(s1)
 9be:	853e                	mv	a0,a5
 9c0:	fef71ae3          	bne	a4,a5,9b4 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 9c4:	8552                	mv	a0,s4
 9c6:	b2bff0ef          	jal	4f0 <sbrk>
  if(p == (char*)-1)
 9ca:	fd551ee3          	bne	a0,s5,9a6 <malloc+0x7c>
        return 0;
 9ce:	4501                	li	a0,0
 9d0:	74a2                	ld	s1,40(sp)
 9d2:	6a42                	ld	s4,16(sp)
 9d4:	6aa2                	ld	s5,8(sp)
 9d6:	6b02                	ld	s6,0(sp)
 9d8:	a03d                	j	a06 <malloc+0xdc>
 9da:	74a2                	ld	s1,40(sp)
 9dc:	6a42                	ld	s4,16(sp)
 9de:	6aa2                	ld	s5,8(sp)
 9e0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9e2:	fae90fe3          	beq	s2,a4,9a0 <malloc+0x76>
        p->s.size -= nunits;
 9e6:	4137073b          	subw	a4,a4,s3
 9ea:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ec:	02071693          	slli	a3,a4,0x20
 9f0:	01c6d713          	srli	a4,a3,0x1c
 9f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9fa:	00000717          	auipc	a4,0x0
 9fe:	60a73323          	sd	a0,1542(a4) # 1000 <freep>
      return (void*)(p + 1);
 a02:	01078513          	addi	a0,a5,16
  }
}
 a06:	70e2                	ld	ra,56(sp)
 a08:	7442                	ld	s0,48(sp)
 a0a:	7902                	ld	s2,32(sp)
 a0c:	69e2                	ld	s3,24(sp)
 a0e:	6121                	addi	sp,sp,64
 a10:	8082                	ret
 a12:	74a2                	ld	s1,40(sp)
 a14:	6a42                	ld	s4,16(sp)
 a16:	6aa2                	ld	s5,8(sp)
 a18:	6b02                	ld	s6,0(sp)
 a1a:	b7f5                	j	a06 <malloc+0xdc>
