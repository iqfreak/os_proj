
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	fe2d8d93          	addi	s11,s11,-30 # 1010 <buf>
  36:	20000d13          	li	s10,512
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	a54a0a13          	addi	s4,s4,-1452 # a90 <malloc+0x100>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a035                	j	70 <wc+0x70>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	1ca000ef          	jal	212 <strchr>
  4c:	c919                	beqz	a0,62 <wc+0x62>
        inword = 0;
  4e:	4901                	li	s2,0
    for(i=0; i<n; i++){
  50:	0485                	addi	s1,s1,1
  52:	01348d63          	beq	s1,s3,6c <wc+0x6c>
      if(buf[i] == '\n')
  56:	0004c583          	lbu	a1,0(s1)
  5a:	ff5596e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  5e:	2b85                	addiw	s7,s7,1
  60:	b7dd                	j	46 <wc+0x46>
      else if(!inword){
  62:	fe0917e3          	bnez	s2,50 <wc+0x50>
        w++;
  66:	2c05                	addiw	s8,s8,1
        inword = 1;
  68:	4905                	li	s2,1
  6a:	b7dd                	j	50 <wc+0x50>
  6c:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  70:	866a                	mv	a2,s10
  72:	85ee                	mv	a1,s11
  74:	f8843503          	ld	a0,-120(s0)
  78:	46e000ef          	jal	4e6 <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	addi	s1,s1,-114 # 1010 <buf>
  8a:	009b09b3          	add	s3,s6,s1
  8e:	b7e1                	j	56 <wc+0x56>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86e6                	mv	a3,s9
  9a:	8662                	mv	a2,s8
  9c:	85de                	mv	a1,s7
  9e:	00001517          	auipc	a0,0x1
  a2:	a1250513          	addi	a0,a0,-1518 # ab0 <malloc+0x120>
  a6:	033000ef          	jal	8d8 <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	addi	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	9d850513          	addi	a0,a0,-1576 # aa0 <malloc+0x110>
  d0:	009000ef          	jal	8d8 <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	3f8000ef          	jal	4ce <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	addi	s2,a1,8
  f2:	ffe5099b          	addiw	s3,a0,-2
  f6:	02099793          	slli	a5,s3,0x20
  fa:	01d7d993          	srli	s3,a5,0x1d
  fe:	05c1                	addi	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	406000ef          	jal	50e <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	3da000ef          	jal	4f6 <close>
  for(i = 1; i < argc; i++){
 120:	0921                	addi	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	3a6000ef          	jal	4ce <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
    wc(0, "");
 132:	00001597          	auipc	a1,0x1
 136:	96658593          	addi	a1,a1,-1690 # a98 <malloc+0x108>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
    exit(0);
 140:	4501                	li	a0,0
 142:	38c000ef          	jal	4ce <exit>
      printf("wc: cannot open %s\n", argv[i]);
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	97650513          	addi	a0,a0,-1674 # ac0 <malloc+0x130>
 152:	786000ef          	jal	8d8 <printf>
      exit(1);
 156:	4505                	li	a0,1
 158:	376000ef          	jal	4ce <exit>

000000000000015c <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	addi	s0,sp,16
  extern int main();
  main();
 164:	f77ff0ef          	jal	da <main>
  exit(0);
 168:	4501                	li	a0,0
 16a:	364000ef          	jal	4ce <exit>

000000000000016e <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e406                	sd	ra,8(sp)
 172:	e022                	sd	s0,0(sp)
 174:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 176:	87aa                	mv	a5,a0
 178:	0585                	addi	a1,a1,1
 17a:	0785                	addi	a5,a5,1
 17c:	fff5c703          	lbu	a4,-1(a1)
 180:	fee78fa3          	sb	a4,-1(a5)
 184:	fb75                	bnez	a4,178 <strcpy+0xa>
    ;
  return os;
}
 186:	60a2                	ld	ra,8(sp)
 188:	6402                	ld	s0,0(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <strcmp>:

int strcmp(const char *p, const char *q)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 196:	00054783          	lbu	a5,0(a0)
 19a:	cb91                	beqz	a5,1ae <strcmp+0x20>
 19c:	0005c703          	lbu	a4,0(a1)
 1a0:	00f71763          	bne	a4,a5,1ae <strcmp+0x20>
    p++, q++;
 1a4:	0505                	addi	a0,a0,1
 1a6:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	fbe5                	bnez	a5,19c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1ae:	0005c503          	lbu	a0,0(a1)
}
 1b2:	40a7853b          	subw	a0,a5,a0
 1b6:	60a2                	ld	ra,8(sp)
 1b8:	6402                	ld	s0,0(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strlen>:

uint strlen(const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf99                	beqz	a5,1e8 <strlen+0x2a>
 1cc:	0505                	addi	a0,a0,1
 1ce:	87aa                	mv	a5,a0
 1d0:	86be                	mv	a3,a5
 1d2:	0785                	addi	a5,a5,1
 1d4:	fff7c703          	lbu	a4,-1(a5)
 1d8:	ff65                	bnez	a4,1d0 <strlen+0x12>
 1da:	40a6853b          	subw	a0,a3,a0
 1de:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1e0:	60a2                	ld	ra,8(sp)
 1e2:	6402                	ld	s0,0(sp)
 1e4:	0141                	addi	sp,sp,16
 1e6:	8082                	ret
  for (n = 0; s[n]; n++)
 1e8:	4501                	li	a0,0
 1ea:	bfdd                	j	1e0 <strlen+0x22>

00000000000001ec <memset>:

void *
memset(void *dst, int c, uint n)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e406                	sd	ra,8(sp)
 1f0:	e022                	sd	s0,0(sp)
 1f2:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 1f4:	ca19                	beqz	a2,20a <memset+0x1e>
 1f6:	87aa                	mv	a5,a0
 1f8:	1602                	slli	a2,a2,0x20
 1fa:	9201                	srli	a2,a2,0x20
 1fc:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 200:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 204:	0785                	addi	a5,a5,1
 206:	fee79de3          	bne	a5,a4,200 <memset+0x14>
  }
  return dst;
}
 20a:	60a2                	ld	ra,8(sp)
 20c:	6402                	ld	s0,0(sp)
 20e:	0141                	addi	sp,sp,16
 210:	8082                	ret

0000000000000212 <strchr>:

char *
strchr(const char *s, char c)
{
 212:	1141                	addi	sp,sp,-16
 214:	e406                	sd	ra,8(sp)
 216:	e022                	sd	s0,0(sp)
 218:	0800                	addi	s0,sp,16
  for (; *s; s++)
 21a:	00054783          	lbu	a5,0(a0)
 21e:	cf81                	beqz	a5,236 <strchr+0x24>
    if (*s == c)
 220:	00f58763          	beq	a1,a5,22e <strchr+0x1c>
  for (; *s; s++)
 224:	0505                	addi	a0,a0,1
 226:	00054783          	lbu	a5,0(a0)
 22a:	fbfd                	bnez	a5,220 <strchr+0xe>
      return (char *)s;
  return 0;
 22c:	4501                	li	a0,0
}
 22e:	60a2                	ld	ra,8(sp)
 230:	6402                	ld	s0,0(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret
  return 0;
 236:	4501                	li	a0,0
 238:	bfdd                	j	22e <strchr+0x1c>

000000000000023a <gets>:

char *
gets(char *buf, int max)
{
 23a:	7159                	addi	sp,sp,-112
 23c:	f486                	sd	ra,104(sp)
 23e:	f0a2                	sd	s0,96(sp)
 240:	eca6                	sd	s1,88(sp)
 242:	e8ca                	sd	s2,80(sp)
 244:	e4ce                	sd	s3,72(sp)
 246:	e0d2                	sd	s4,64(sp)
 248:	fc56                	sd	s5,56(sp)
 24a:	f85a                	sd	s6,48(sp)
 24c:	f45e                	sd	s7,40(sp)
 24e:	f062                	sd	s8,32(sp)
 250:	ec66                	sd	s9,24(sp)
 252:	e86a                	sd	s10,16(sp)
 254:	1880                	addi	s0,sp,112
 256:	8caa                	mv	s9,a0
 258:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 25a:	892a                	mv	s2,a0
 25c:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 25e:	f9f40b13          	addi	s6,s0,-97
 262:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 264:	4ba9                	li	s7,10
 266:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 268:	8d26                	mv	s10,s1
 26a:	0014899b          	addiw	s3,s1,1
 26e:	84ce                	mv	s1,s3
 270:	0349d563          	bge	s3,s4,29a <gets+0x60>
    cc = read(0, &c, 1);
 274:	8656                	mv	a2,s5
 276:	85da                	mv	a1,s6
 278:	4501                	li	a0,0
 27a:	26c000ef          	jal	4e6 <read>
    if (cc < 1)
 27e:	00a05e63          	blez	a0,29a <gets+0x60>
    buf[i++] = c;
 282:	f9f44783          	lbu	a5,-97(s0)
 286:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 28a:	01778763          	beq	a5,s7,298 <gets+0x5e>
 28e:	0905                	addi	s2,s2,1
 290:	fd879ce3          	bne	a5,s8,268 <gets+0x2e>
    buf[i++] = c;
 294:	8d4e                	mv	s10,s3
 296:	a011                	j	29a <gets+0x60>
 298:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 29a:	9d66                	add	s10,s10,s9
 29c:	000d0023          	sb	zero,0(s10)
  return buf;
}
 2a0:	8566                	mv	a0,s9
 2a2:	70a6                	ld	ra,104(sp)
 2a4:	7406                	ld	s0,96(sp)
 2a6:	64e6                	ld	s1,88(sp)
 2a8:	6946                	ld	s2,80(sp)
 2aa:	69a6                	ld	s3,72(sp)
 2ac:	6a06                	ld	s4,64(sp)
 2ae:	7ae2                	ld	s5,56(sp)
 2b0:	7b42                	ld	s6,48(sp)
 2b2:	7ba2                	ld	s7,40(sp)
 2b4:	7c02                	ld	s8,32(sp)
 2b6:	6ce2                	ld	s9,24(sp)
 2b8:	6d42                	ld	s10,16(sp)
 2ba:	6165                	addi	sp,sp,112
 2bc:	8082                	ret

00000000000002be <stat>:

int stat(const char *n, struct stat *st)
{
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e04a                	sd	s2,0(sp)
 2c6:	1000                	addi	s0,sp,32
 2c8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ca:	4581                	li	a1,0
 2cc:	242000ef          	jal	50e <open>
  if (fd < 0)
 2d0:	02054263          	bltz	a0,2f4 <stat+0x36>
 2d4:	e426                	sd	s1,8(sp)
 2d6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2d8:	85ca                	mv	a1,s2
 2da:	24c000ef          	jal	526 <fstat>
 2de:	892a                	mv	s2,a0
  close(fd);
 2e0:	8526                	mv	a0,s1
 2e2:	214000ef          	jal	4f6 <close>
  return r;
 2e6:	64a2                	ld	s1,8(sp)
}
 2e8:	854a                	mv	a0,s2
 2ea:	60e2                	ld	ra,24(sp)
 2ec:	6442                	ld	s0,16(sp)
 2ee:	6902                	ld	s2,0(sp)
 2f0:	6105                	addi	sp,sp,32
 2f2:	8082                	ret
    return -1;
 2f4:	597d                	li	s2,-1
 2f6:	bfcd                	j	2e8 <stat+0x2a>

00000000000002f8 <atoi>:

int atoi(const char *s)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e406                	sd	ra,8(sp)
 2fc:	e022                	sd	s0,0(sp)
 2fe:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 300:	00054683          	lbu	a3,0(a0)
 304:	fd06879b          	addiw	a5,a3,-48
 308:	0ff7f793          	zext.b	a5,a5
 30c:	4625                	li	a2,9
 30e:	02f66963          	bltu	a2,a5,340 <atoi+0x48>
 312:	872a                	mv	a4,a0
  n = 0;
 314:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 316:	0705                	addi	a4,a4,1
 318:	0025179b          	slliw	a5,a0,0x2
 31c:	9fa9                	addw	a5,a5,a0
 31e:	0017979b          	slliw	a5,a5,0x1
 322:	9fb5                	addw	a5,a5,a3
 324:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 328:	00074683          	lbu	a3,0(a4)
 32c:	fd06879b          	addiw	a5,a3,-48
 330:	0ff7f793          	zext.b	a5,a5
 334:	fef671e3          	bgeu	a2,a5,316 <atoi+0x1e>
  return n;
}
 338:	60a2                	ld	ra,8(sp)
 33a:	6402                	ld	s0,0(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret
  n = 0;
 340:	4501                	li	a0,0
 342:	bfdd                	j	338 <atoi+0x40>

0000000000000344 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 344:	1141                	addi	sp,sp,-16
 346:	e406                	sd	ra,8(sp)
 348:	e022                	sd	s0,0(sp)
 34a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 34c:	02b57563          	bgeu	a0,a1,376 <memmove+0x32>
  {
    while (n-- > 0)
 350:	00c05f63          	blez	a2,36e <memmove+0x2a>
 354:	1602                	slli	a2,a2,0x20
 356:	9201                	srli	a2,a2,0x20
 358:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 35c:	872a                	mv	a4,a0
      *dst++ = *src++;
 35e:	0585                	addi	a1,a1,1
 360:	0705                	addi	a4,a4,1
 362:	fff5c683          	lbu	a3,-1(a1)
 366:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 36a:	fee79ae3          	bne	a5,a4,35e <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret
    dst += n;
 376:	00c50733          	add	a4,a0,a2
    src += n;
 37a:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 37c:	fec059e3          	blez	a2,36e <memmove+0x2a>
 380:	fff6079b          	addiw	a5,a2,-1
 384:	1782                	slli	a5,a5,0x20
 386:	9381                	srli	a5,a5,0x20
 388:	fff7c793          	not	a5,a5
 38c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 38e:	15fd                	addi	a1,a1,-1
 390:	177d                	addi	a4,a4,-1
 392:	0005c683          	lbu	a3,0(a1)
 396:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 39a:	fef71ae3          	bne	a4,a5,38e <memmove+0x4a>
 39e:	bfc1                	j	36e <memmove+0x2a>

00000000000003a0 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 3a0:	1141                	addi	sp,sp,-16
 3a2:	e406                	sd	ra,8(sp)
 3a4:	e022                	sd	s0,0(sp)
 3a6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 3a8:	ca0d                	beqz	a2,3da <memcmp+0x3a>
 3aa:	fff6069b          	addiw	a3,a2,-1
 3ae:	1682                	slli	a3,a3,0x20
 3b0:	9281                	srli	a3,a3,0x20
 3b2:	0685                	addi	a3,a3,1
 3b4:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 3b6:	00054783          	lbu	a5,0(a0)
 3ba:	0005c703          	lbu	a4,0(a1)
 3be:	00e79863          	bne	a5,a4,3ce <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 3c2:	0505                	addi	a0,a0,1
    p2++;
 3c4:	0585                	addi	a1,a1,1
  while (n-- > 0)
 3c6:	fed518e3          	bne	a0,a3,3b6 <memcmp+0x16>
  }
  return 0;
 3ca:	4501                	li	a0,0
 3cc:	a019                	j	3d2 <memcmp+0x32>
      return *p1 - *p2;
 3ce:	40e7853b          	subw	a0,a5,a4
}
 3d2:	60a2                	ld	ra,8(sp)
 3d4:	6402                	ld	s0,0(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret
  return 0;
 3da:	4501                	li	a0,0
 3dc:	bfdd                	j	3d2 <memcmp+0x32>

00000000000003de <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e406                	sd	ra,8(sp)
 3e2:	e022                	sd	s0,0(sp)
 3e4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3e6:	f5fff0ef          	jal	344 <memmove>
}
 3ea:	60a2                	ld	ra,8(sp)
 3ec:	6402                	ld	s0,0(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret

00000000000003f2 <strcat>:

char *strcat(char *dst, const char *src)
{
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e406                	sd	ra,8(sp)
 3f6:	e022                	sd	s0,0(sp)
 3f8:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	c795                	beqz	a5,42a <strcat+0x38>
  char *p = dst;
 400:	87aa                	mv	a5,a0
    p++;
 402:	0785                	addi	a5,a5,1
  while (*p)
 404:	0007c703          	lbu	a4,0(a5)
 408:	ff6d                	bnez	a4,402 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 40a:	0005c703          	lbu	a4,0(a1)
 40e:	cb01                	beqz	a4,41e <strcat+0x2c>
  {
    *p = *src;
 410:	00e78023          	sb	a4,0(a5)
    p++;
 414:	0785                	addi	a5,a5,1
    src++;
 416:	0585                	addi	a1,a1,1
  while (*src)
 418:	0005c703          	lbu	a4,0(a1)
 41c:	fb75                	bnez	a4,410 <strcat+0x1e>
  }

  *p = 0;
 41e:	00078023          	sb	zero,0(a5)

  return dst;
}
 422:	60a2                	ld	ra,8(sp)
 424:	6402                	ld	s0,0(sp)
 426:	0141                	addi	sp,sp,16
 428:	8082                	ret
  char *p = dst;
 42a:	87aa                	mv	a5,a0
 42c:	bff9                	j	40a <strcat+0x18>

000000000000042e <isdir>:

int isdir(char *path)
{
 42e:	7179                	addi	sp,sp,-48
 430:	f406                	sd	ra,40(sp)
 432:	f022                	sd	s0,32(sp)
 434:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 436:	fd840593          	addi	a1,s0,-40
 43a:	e85ff0ef          	jal	2be <stat>
 43e:	00054b63          	bltz	a0,454 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 442:	fe041503          	lh	a0,-32(s0)
 446:	157d                	addi	a0,a0,-1
 448:	00153513          	seqz	a0,a0
}
 44c:	70a2                	ld	ra,40(sp)
 44e:	7402                	ld	s0,32(sp)
 450:	6145                	addi	sp,sp,48
 452:	8082                	ret
    return 0;
 454:	4501                	li	a0,0
 456:	bfdd                	j	44c <isdir+0x1e>

0000000000000458 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 458:	7139                	addi	sp,sp,-64
 45a:	fc06                	sd	ra,56(sp)
 45c:	f822                	sd	s0,48(sp)
 45e:	f426                	sd	s1,40(sp)
 460:	f04a                	sd	s2,32(sp)
 462:	ec4e                	sd	s3,24(sp)
 464:	e852                	sd	s4,16(sp)
 466:	e456                	sd	s5,8(sp)
 468:	0080                	addi	s0,sp,64
 46a:	89aa                	mv	s3,a0
 46c:	8aae                	mv	s5,a1
 46e:	84b2                	mv	s1,a2
 470:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 472:	d4dff0ef          	jal	1be <strlen>
 476:	892a                	mv	s2,a0
  int nn = strlen(filename);
 478:	8556                	mv	a0,s5
 47a:	d45ff0ef          	jal	1be <strlen>
  int need = dn + 1 + nn + 1;
 47e:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 482:	9fa9                	addw	a5,a5,a0
    return 0;
 484:	4501                	li	a0,0
  if (need > bufsize)
 486:	0347d763          	bge	a5,s4,4b4 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 48a:	85ce                	mv	a1,s3
 48c:	8526                	mv	a0,s1
 48e:	ce1ff0ef          	jal	16e <strcpy>
  if (dir[dn - 1] != '/')
 492:	99ca                	add	s3,s3,s2
 494:	fff9c703          	lbu	a4,-1(s3)
 498:	02f00793          	li	a5,47
 49c:	00f70763          	beq	a4,a5,4aa <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 4a0:	9926                	add	s2,s2,s1
 4a2:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 4a6:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 4aa:	85d6                	mv	a1,s5
 4ac:	8526                	mv	a0,s1
 4ae:	f45ff0ef          	jal	3f2 <strcat>
  return out_buffer;
 4b2:	8526                	mv	a0,s1
}
 4b4:	70e2                	ld	ra,56(sp)
 4b6:	7442                	ld	s0,48(sp)
 4b8:	74a2                	ld	s1,40(sp)
 4ba:	7902                	ld	s2,32(sp)
 4bc:	69e2                	ld	s3,24(sp)
 4be:	6a42                	ld	s4,16(sp)
 4c0:	6aa2                	ld	s5,8(sp)
 4c2:	6121                	addi	sp,sp,64
 4c4:	8082                	ret

00000000000004c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4c6:	4885                	li	a7,1
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 4ce:	4889                	li	a7,2
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4d6:	488d                	li	a7,3
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4de:	4891                	li	a7,4
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <read>:
.global read
read:
 li a7, SYS_read
 4e6:	4895                	li	a7,5
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <write>:
.global write
write:
 li a7, SYS_write
 4ee:	48c1                	li	a7,16
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <close>:
.global close
close:
 li a7, SYS_close
 4f6:	48d5                	li	a7,21
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 4fe:	4899                	li	a7,6
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <exec>:
.global exec
exec:
 li a7, SYS_exec
 506:	489d                	li	a7,7
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <open>:
.global open
open:
 li a7, SYS_open
 50e:	48bd                	li	a7,15
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 516:	48c5                	li	a7,17
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 51e:	48c9                	li	a7,18
 ecall
 520:	00000073          	ecall
 ret
 524:	8082                	ret

0000000000000526 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 526:	48a1                	li	a7,8
 ecall
 528:	00000073          	ecall
 ret
 52c:	8082                	ret

000000000000052e <link>:
.global link
link:
 li a7, SYS_link
 52e:	48cd                	li	a7,19
 ecall
 530:	00000073          	ecall
 ret
 534:	8082                	ret

0000000000000536 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 536:	48d1                	li	a7,20
 ecall
 538:	00000073          	ecall
 ret
 53c:	8082                	ret

000000000000053e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 53e:	48a5                	li	a7,9
 ecall
 540:	00000073          	ecall
 ret
 544:	8082                	ret

0000000000000546 <dup>:
.global dup
dup:
 li a7, SYS_dup
 546:	48a9                	li	a7,10
 ecall
 548:	00000073          	ecall
 ret
 54c:	8082                	ret

000000000000054e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 54e:	48ad                	li	a7,11
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 556:	48b1                	li	a7,12
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 55e:	48b5                	li	a7,13
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 566:	48b9                	li	a7,14
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 56e:	48d9                	li	a7,22
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 576:	1101                	addi	sp,sp,-32
 578:	ec06                	sd	ra,24(sp)
 57a:	e822                	sd	s0,16(sp)
 57c:	1000                	addi	s0,sp,32
 57e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 582:	4605                	li	a2,1
 584:	fef40593          	addi	a1,s0,-17
 588:	f67ff0ef          	jal	4ee <write>
}
 58c:	60e2                	ld	ra,24(sp)
 58e:	6442                	ld	s0,16(sp)
 590:	6105                	addi	sp,sp,32
 592:	8082                	ret

0000000000000594 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 594:	7139                	addi	sp,sp,-64
 596:	fc06                	sd	ra,56(sp)
 598:	f822                	sd	s0,48(sp)
 59a:	f426                	sd	s1,40(sp)
 59c:	f04a                	sd	s2,32(sp)
 59e:	ec4e                	sd	s3,24(sp)
 5a0:	0080                	addi	s0,sp,64
 5a2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5a4:	c299                	beqz	a3,5aa <printint+0x16>
 5a6:	0605ce63          	bltz	a1,622 <printint+0x8e>
  neg = 0;
 5aa:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5ac:	fc040313          	addi	t1,s0,-64
  neg = 0;
 5b0:	869a                	mv	a3,t1
  i = 0;
 5b2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5b4:	00000817          	auipc	a6,0x0
 5b8:	52c80813          	addi	a6,a6,1324 # ae0 <digits>
 5bc:	88be                	mv	a7,a5
 5be:	0017851b          	addiw	a0,a5,1
 5c2:	87aa                	mv	a5,a0
 5c4:	02c5f73b          	remuw	a4,a1,a2
 5c8:	1702                	slli	a4,a4,0x20
 5ca:	9301                	srli	a4,a4,0x20
 5cc:	9742                	add	a4,a4,a6
 5ce:	00074703          	lbu	a4,0(a4)
 5d2:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5d6:	872e                	mv	a4,a1
 5d8:	02c5d5bb          	divuw	a1,a1,a2
 5dc:	0685                	addi	a3,a3,1
 5de:	fcc77fe3          	bgeu	a4,a2,5bc <printint+0x28>
  if(neg)
 5e2:	000e0c63          	beqz	t3,5fa <printint+0x66>
    buf[i++] = '-';
 5e6:	fd050793          	addi	a5,a0,-48
 5ea:	00878533          	add	a0,a5,s0
 5ee:	02d00793          	li	a5,45
 5f2:	fef50823          	sb	a5,-16(a0)
 5f6:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 5fa:	fff7899b          	addiw	s3,a5,-1
 5fe:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 602:	fff4c583          	lbu	a1,-1(s1)
 606:	854a                	mv	a0,s2
 608:	f6fff0ef          	jal	576 <putc>
  while(--i >= 0)
 60c:	39fd                	addiw	s3,s3,-1
 60e:	14fd                	addi	s1,s1,-1
 610:	fe09d9e3          	bgez	s3,602 <printint+0x6e>
}
 614:	70e2                	ld	ra,56(sp)
 616:	7442                	ld	s0,48(sp)
 618:	74a2                	ld	s1,40(sp)
 61a:	7902                	ld	s2,32(sp)
 61c:	69e2                	ld	s3,24(sp)
 61e:	6121                	addi	sp,sp,64
 620:	8082                	ret
    x = -xx;
 622:	40b005bb          	negw	a1,a1
    neg = 1;
 626:	4e05                	li	t3,1
    x = -xx;
 628:	b751                	j	5ac <printint+0x18>

000000000000062a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 62a:	711d                	addi	sp,sp,-96
 62c:	ec86                	sd	ra,88(sp)
 62e:	e8a2                	sd	s0,80(sp)
 630:	e4a6                	sd	s1,72(sp)
 632:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 634:	0005c483          	lbu	s1,0(a1)
 638:	26048663          	beqz	s1,8a4 <vprintf+0x27a>
 63c:	e0ca                	sd	s2,64(sp)
 63e:	fc4e                	sd	s3,56(sp)
 640:	f852                	sd	s4,48(sp)
 642:	f456                	sd	s5,40(sp)
 644:	f05a                	sd	s6,32(sp)
 646:	ec5e                	sd	s7,24(sp)
 648:	e862                	sd	s8,16(sp)
 64a:	e466                	sd	s9,8(sp)
 64c:	8b2a                	mv	s6,a0
 64e:	8a2e                	mv	s4,a1
 650:	8bb2                	mv	s7,a2
  state = 0;
 652:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 654:	4901                	li	s2,0
 656:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 658:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 65c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 660:	06c00c93          	li	s9,108
 664:	a00d                	j	686 <vprintf+0x5c>
        putc(fd, c0);
 666:	85a6                	mv	a1,s1
 668:	855a                	mv	a0,s6
 66a:	f0dff0ef          	jal	576 <putc>
 66e:	a019                	j	674 <vprintf+0x4a>
    } else if(state == '%'){
 670:	03598363          	beq	s3,s5,696 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 674:	0019079b          	addiw	a5,s2,1
 678:	893e                	mv	s2,a5
 67a:	873e                	mv	a4,a5
 67c:	97d2                	add	a5,a5,s4
 67e:	0007c483          	lbu	s1,0(a5)
 682:	20048963          	beqz	s1,894 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 686:	0004879b          	sext.w	a5,s1
    if(state == 0){
 68a:	fe0993e3          	bnez	s3,670 <vprintf+0x46>
      if(c0 == '%'){
 68e:	fd579ce3          	bne	a5,s5,666 <vprintf+0x3c>
        state = '%';
 692:	89be                	mv	s3,a5
 694:	b7c5                	j	674 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 696:	00ea06b3          	add	a3,s4,a4
 69a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 69e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6a0:	c681                	beqz	a3,6a8 <vprintf+0x7e>
 6a2:	9752                	add	a4,a4,s4
 6a4:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6a8:	03878e63          	beq	a5,s8,6e4 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 6ac:	05978863          	beq	a5,s9,6fc <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6b0:	07500713          	li	a4,117
 6b4:	0ee78263          	beq	a5,a4,798 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6b8:	07800713          	li	a4,120
 6bc:	12e78463          	beq	a5,a4,7e4 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6c0:	07000713          	li	a4,112
 6c4:	14e78963          	beq	a5,a4,816 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 6c8:	07300713          	li	a4,115
 6cc:	18e78863          	beq	a5,a4,85c <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6d0:	02500713          	li	a4,37
 6d4:	04e79463          	bne	a5,a4,71c <vprintf+0xf2>
        putc(fd, '%');
 6d8:	85ba                	mv	a1,a4
 6da:	855a                	mv	a0,s6
 6dc:	e9bff0ef          	jal	576 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	bf49                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6e4:	008b8493          	addi	s1,s7,8
 6e8:	4685                	li	a3,1
 6ea:	4629                	li	a2,10
 6ec:	000ba583          	lw	a1,0(s7)
 6f0:	855a                	mv	a0,s6
 6f2:	ea3ff0ef          	jal	594 <printint>
 6f6:	8ba6                	mv	s7,s1
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	bfad                	j	674 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6fc:	06400793          	li	a5,100
 700:	02f68963          	beq	a3,a5,732 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 704:	06c00793          	li	a5,108
 708:	04f68263          	beq	a3,a5,74c <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 70c:	07500793          	li	a5,117
 710:	0af68063          	beq	a3,a5,7b0 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 714:	07800793          	li	a5,120
 718:	0ef68263          	beq	a3,a5,7fc <vprintf+0x1d2>
        putc(fd, '%');
 71c:	02500593          	li	a1,37
 720:	855a                	mv	a0,s6
 722:	e55ff0ef          	jal	576 <putc>
        putc(fd, c0);
 726:	85a6                	mv	a1,s1
 728:	855a                	mv	a0,s6
 72a:	e4dff0ef          	jal	576 <putc>
      state = 0;
 72e:	4981                	li	s3,0
 730:	b791                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 732:	008b8493          	addi	s1,s7,8
 736:	4685                	li	a3,1
 738:	4629                	li	a2,10
 73a:	000ba583          	lw	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	e55ff0ef          	jal	594 <printint>
        i += 1;
 744:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 746:	8ba6                	mv	s7,s1
      state = 0;
 748:	4981                	li	s3,0
        i += 1;
 74a:	b72d                	j	674 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 74c:	06400793          	li	a5,100
 750:	02f60763          	beq	a2,a5,77e <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 754:	07500793          	li	a5,117
 758:	06f60963          	beq	a2,a5,7ca <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 75c:	07800793          	li	a5,120
 760:	faf61ee3          	bne	a2,a5,71c <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 764:	008b8493          	addi	s1,s7,8
 768:	4681                	li	a3,0
 76a:	4641                	li	a2,16
 76c:	000ba583          	lw	a1,0(s7)
 770:	855a                	mv	a0,s6
 772:	e23ff0ef          	jal	594 <printint>
        i += 2;
 776:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 778:	8ba6                	mv	s7,s1
      state = 0;
 77a:	4981                	li	s3,0
        i += 2;
 77c:	bde5                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 77e:	008b8493          	addi	s1,s7,8
 782:	4685                	li	a3,1
 784:	4629                	li	a2,10
 786:	000ba583          	lw	a1,0(s7)
 78a:	855a                	mv	a0,s6
 78c:	e09ff0ef          	jal	594 <printint>
        i += 2;
 790:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 792:	8ba6                	mv	s7,s1
      state = 0;
 794:	4981                	li	s3,0
        i += 2;
 796:	bdf9                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 798:	008b8493          	addi	s1,s7,8
 79c:	4681                	li	a3,0
 79e:	4629                	li	a2,10
 7a0:	000ba583          	lw	a1,0(s7)
 7a4:	855a                	mv	a0,s6
 7a6:	defff0ef          	jal	594 <printint>
 7aa:	8ba6                	mv	s7,s1
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	b5d9                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b0:	008b8493          	addi	s1,s7,8
 7b4:	4681                	li	a3,0
 7b6:	4629                	li	a2,10
 7b8:	000ba583          	lw	a1,0(s7)
 7bc:	855a                	mv	a0,s6
 7be:	dd7ff0ef          	jal	594 <printint>
        i += 1;
 7c2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c4:	8ba6                	mv	s7,s1
      state = 0;
 7c6:	4981                	li	s3,0
        i += 1;
 7c8:	b575                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ca:	008b8493          	addi	s1,s7,8
 7ce:	4681                	li	a3,0
 7d0:	4629                	li	a2,10
 7d2:	000ba583          	lw	a1,0(s7)
 7d6:	855a                	mv	a0,s6
 7d8:	dbdff0ef          	jal	594 <printint>
        i += 2;
 7dc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7de:	8ba6                	mv	s7,s1
      state = 0;
 7e0:	4981                	li	s3,0
        i += 2;
 7e2:	bd49                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 7e4:	008b8493          	addi	s1,s7,8
 7e8:	4681                	li	a3,0
 7ea:	4641                	li	a2,16
 7ec:	000ba583          	lw	a1,0(s7)
 7f0:	855a                	mv	a0,s6
 7f2:	da3ff0ef          	jal	594 <printint>
 7f6:	8ba6                	mv	s7,s1
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	bdad                	j	674 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7fc:	008b8493          	addi	s1,s7,8
 800:	4681                	li	a3,0
 802:	4641                	li	a2,16
 804:	000ba583          	lw	a1,0(s7)
 808:	855a                	mv	a0,s6
 80a:	d8bff0ef          	jal	594 <printint>
        i += 1;
 80e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 810:	8ba6                	mv	s7,s1
      state = 0;
 812:	4981                	li	s3,0
        i += 1;
 814:	b585                	j	674 <vprintf+0x4a>
 816:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 818:	008b8d13          	addi	s10,s7,8
 81c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 820:	03000593          	li	a1,48
 824:	855a                	mv	a0,s6
 826:	d51ff0ef          	jal	576 <putc>
  putc(fd, 'x');
 82a:	07800593          	li	a1,120
 82e:	855a                	mv	a0,s6
 830:	d47ff0ef          	jal	576 <putc>
 834:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 836:	00000b97          	auipc	s7,0x0
 83a:	2aab8b93          	addi	s7,s7,682 # ae0 <digits>
 83e:	03c9d793          	srli	a5,s3,0x3c
 842:	97de                	add	a5,a5,s7
 844:	0007c583          	lbu	a1,0(a5)
 848:	855a                	mv	a0,s6
 84a:	d2dff0ef          	jal	576 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 84e:	0992                	slli	s3,s3,0x4
 850:	34fd                	addiw	s1,s1,-1
 852:	f4f5                	bnez	s1,83e <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 854:	8bea                	mv	s7,s10
      state = 0;
 856:	4981                	li	s3,0
 858:	6d02                	ld	s10,0(sp)
 85a:	bd29                	j	674 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 85c:	008b8993          	addi	s3,s7,8
 860:	000bb483          	ld	s1,0(s7)
 864:	cc91                	beqz	s1,880 <vprintf+0x256>
        for(; *s; s++)
 866:	0004c583          	lbu	a1,0(s1)
 86a:	c195                	beqz	a1,88e <vprintf+0x264>
          putc(fd, *s);
 86c:	855a                	mv	a0,s6
 86e:	d09ff0ef          	jal	576 <putc>
        for(; *s; s++)
 872:	0485                	addi	s1,s1,1
 874:	0004c583          	lbu	a1,0(s1)
 878:	f9f5                	bnez	a1,86c <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 87a:	8bce                	mv	s7,s3
      state = 0;
 87c:	4981                	li	s3,0
 87e:	bbdd                	j	674 <vprintf+0x4a>
          s = "(null)";
 880:	00000497          	auipc	s1,0x0
 884:	25848493          	addi	s1,s1,600 # ad8 <malloc+0x148>
        for(; *s; s++)
 888:	02800593          	li	a1,40
 88c:	b7c5                	j	86c <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 88e:	8bce                	mv	s7,s3
      state = 0;
 890:	4981                	li	s3,0
 892:	b3cd                	j	674 <vprintf+0x4a>
 894:	6906                	ld	s2,64(sp)
 896:	79e2                	ld	s3,56(sp)
 898:	7a42                	ld	s4,48(sp)
 89a:	7aa2                	ld	s5,40(sp)
 89c:	7b02                	ld	s6,32(sp)
 89e:	6be2                	ld	s7,24(sp)
 8a0:	6c42                	ld	s8,16(sp)
 8a2:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8a4:	60e6                	ld	ra,88(sp)
 8a6:	6446                	ld	s0,80(sp)
 8a8:	64a6                	ld	s1,72(sp)
 8aa:	6125                	addi	sp,sp,96
 8ac:	8082                	ret

00000000000008ae <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8ae:	715d                	addi	sp,sp,-80
 8b0:	ec06                	sd	ra,24(sp)
 8b2:	e822                	sd	s0,16(sp)
 8b4:	1000                	addi	s0,sp,32
 8b6:	e010                	sd	a2,0(s0)
 8b8:	e414                	sd	a3,8(s0)
 8ba:	e818                	sd	a4,16(s0)
 8bc:	ec1c                	sd	a5,24(s0)
 8be:	03043023          	sd	a6,32(s0)
 8c2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8c6:	8622                	mv	a2,s0
 8c8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8cc:	d5fff0ef          	jal	62a <vprintf>
}
 8d0:	60e2                	ld	ra,24(sp)
 8d2:	6442                	ld	s0,16(sp)
 8d4:	6161                	addi	sp,sp,80
 8d6:	8082                	ret

00000000000008d8 <printf>:

void
printf(const char *fmt, ...)
{
 8d8:	711d                	addi	sp,sp,-96
 8da:	ec06                	sd	ra,24(sp)
 8dc:	e822                	sd	s0,16(sp)
 8de:	1000                	addi	s0,sp,32
 8e0:	e40c                	sd	a1,8(s0)
 8e2:	e810                	sd	a2,16(s0)
 8e4:	ec14                	sd	a3,24(s0)
 8e6:	f018                	sd	a4,32(s0)
 8e8:	f41c                	sd	a5,40(s0)
 8ea:	03043823          	sd	a6,48(s0)
 8ee:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8f2:	00840613          	addi	a2,s0,8
 8f6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8fa:	85aa                	mv	a1,a0
 8fc:	4505                	li	a0,1
 8fe:	d2dff0ef          	jal	62a <vprintf>
}
 902:	60e2                	ld	ra,24(sp)
 904:	6442                	ld	s0,16(sp)
 906:	6125                	addi	sp,sp,96
 908:	8082                	ret

000000000000090a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 90a:	1141                	addi	sp,sp,-16
 90c:	e406                	sd	ra,8(sp)
 90e:	e022                	sd	s0,0(sp)
 910:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 912:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 916:	00000797          	auipc	a5,0x0
 91a:	6ea7b783          	ld	a5,1770(a5) # 1000 <freep>
 91e:	a02d                	j	948 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 920:	4618                	lw	a4,8(a2)
 922:	9f2d                	addw	a4,a4,a1
 924:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 928:	6398                	ld	a4,0(a5)
 92a:	6310                	ld	a2,0(a4)
 92c:	a83d                	j	96a <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 92e:	ff852703          	lw	a4,-8(a0)
 932:	9f31                	addw	a4,a4,a2
 934:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 936:	ff053683          	ld	a3,-16(a0)
 93a:	a091                	j	97e <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93c:	6398                	ld	a4,0(a5)
 93e:	00e7e463          	bltu	a5,a4,946 <free+0x3c>
 942:	00e6ea63          	bltu	a3,a4,956 <free+0x4c>
{
 946:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 948:	fed7fae3          	bgeu	a5,a3,93c <free+0x32>
 94c:	6398                	ld	a4,0(a5)
 94e:	00e6e463          	bltu	a3,a4,956 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 952:	fee7eae3          	bltu	a5,a4,946 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 956:	ff852583          	lw	a1,-8(a0)
 95a:	6390                	ld	a2,0(a5)
 95c:	02059813          	slli	a6,a1,0x20
 960:	01c85713          	srli	a4,a6,0x1c
 964:	9736                	add	a4,a4,a3
 966:	fae60de3          	beq	a2,a4,920 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 96a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 96e:	4790                	lw	a2,8(a5)
 970:	02061593          	slli	a1,a2,0x20
 974:	01c5d713          	srli	a4,a1,0x1c
 978:	973e                	add	a4,a4,a5
 97a:	fae68ae3          	beq	a3,a4,92e <free+0x24>
    p->s.ptr = bp->s.ptr;
 97e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 980:	00000717          	auipc	a4,0x0
 984:	68f73023          	sd	a5,1664(a4) # 1000 <freep>
}
 988:	60a2                	ld	ra,8(sp)
 98a:	6402                	ld	s0,0(sp)
 98c:	0141                	addi	sp,sp,16
 98e:	8082                	ret

0000000000000990 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 990:	7139                	addi	sp,sp,-64
 992:	fc06                	sd	ra,56(sp)
 994:	f822                	sd	s0,48(sp)
 996:	f04a                	sd	s2,32(sp)
 998:	ec4e                	sd	s3,24(sp)
 99a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99c:	02051993          	slli	s3,a0,0x20
 9a0:	0209d993          	srli	s3,s3,0x20
 9a4:	09bd                	addi	s3,s3,15
 9a6:	0049d993          	srli	s3,s3,0x4
 9aa:	2985                	addiw	s3,s3,1
 9ac:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 9ae:	00000517          	auipc	a0,0x0
 9b2:	65253503          	ld	a0,1618(a0) # 1000 <freep>
 9b6:	c905                	beqz	a0,9e6 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ba:	4798                	lw	a4,8(a5)
 9bc:	09377663          	bgeu	a4,s3,a48 <malloc+0xb8>
 9c0:	f426                	sd	s1,40(sp)
 9c2:	e852                	sd	s4,16(sp)
 9c4:	e456                	sd	s5,8(sp)
 9c6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9c8:	8a4e                	mv	s4,s3
 9ca:	6705                	lui	a4,0x1
 9cc:	00e9f363          	bgeu	s3,a4,9d2 <malloc+0x42>
 9d0:	6a05                	lui	s4,0x1
 9d2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9da:	00000497          	auipc	s1,0x0
 9de:	62648493          	addi	s1,s1,1574 # 1000 <freep>
  if(p == (char*)-1)
 9e2:	5afd                	li	s5,-1
 9e4:	a83d                	j	a22 <malloc+0x92>
 9e6:	f426                	sd	s1,40(sp)
 9e8:	e852                	sd	s4,16(sp)
 9ea:	e456                	sd	s5,8(sp)
 9ec:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9ee:	00001797          	auipc	a5,0x1
 9f2:	82278793          	addi	a5,a5,-2014 # 1210 <base>
 9f6:	00000717          	auipc	a4,0x0
 9fa:	60f73523          	sd	a5,1546(a4) # 1000 <freep>
 9fe:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a00:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a04:	b7d1                	j	9c8 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a06:	6398                	ld	a4,0(a5)
 a08:	e118                	sd	a4,0(a0)
 a0a:	a899                	j	a60 <malloc+0xd0>
  hp->s.size = nu;
 a0c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a10:	0541                	addi	a0,a0,16
 a12:	ef9ff0ef          	jal	90a <free>
  return freep;
 a16:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a18:	c125                	beqz	a0,a78 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1c:	4798                	lw	a4,8(a5)
 a1e:	03277163          	bgeu	a4,s2,a40 <malloc+0xb0>
    if(p == freep)
 a22:	6098                	ld	a4,0(s1)
 a24:	853e                	mv	a0,a5
 a26:	fef71ae3          	bne	a4,a5,a1a <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 a2a:	8552                	mv	a0,s4
 a2c:	b2bff0ef          	jal	556 <sbrk>
  if(p == (char*)-1)
 a30:	fd551ee3          	bne	a0,s5,a0c <malloc+0x7c>
        return 0;
 a34:	4501                	li	a0,0
 a36:	74a2                	ld	s1,40(sp)
 a38:	6a42                	ld	s4,16(sp)
 a3a:	6aa2                	ld	s5,8(sp)
 a3c:	6b02                	ld	s6,0(sp)
 a3e:	a03d                	j	a6c <malloc+0xdc>
 a40:	74a2                	ld	s1,40(sp)
 a42:	6a42                	ld	s4,16(sp)
 a44:	6aa2                	ld	s5,8(sp)
 a46:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a48:	fae90fe3          	beq	s2,a4,a06 <malloc+0x76>
        p->s.size -= nunits;
 a4c:	4137073b          	subw	a4,a4,s3
 a50:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a52:	02071693          	slli	a3,a4,0x20
 a56:	01c6d713          	srli	a4,a3,0x1c
 a5a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a5c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a60:	00000717          	auipc	a4,0x0
 a64:	5aa73023          	sd	a0,1440(a4) # 1000 <freep>
      return (void*)(p + 1);
 a68:	01078513          	addi	a0,a5,16
  }
}
 a6c:	70e2                	ld	ra,56(sp)
 a6e:	7442                	ld	s0,48(sp)
 a70:	7902                	ld	s2,32(sp)
 a72:	69e2                	ld	s3,24(sp)
 a74:	6121                	addi	sp,sp,64
 a76:	8082                	ret
 a78:	74a2                	ld	s1,40(sp)
 a7a:	6a42                	ld	s4,16(sp)
 a7c:	6aa2                	ld	s5,8(sp)
 a7e:	6b02                	ld	s6,0(sp)
 a80:	b7f5                	j	a6c <malloc+0xdc>
