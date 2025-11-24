
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	2de000ef          	jal	2ea <strlen>
  10:	02051793          	slli	a5,a0,0x20
  14:	9381                	srli	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	addi	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	2b6000ef          	jal	2ea <strlen>
  38:	47b5                	li	a5,13
  3a:	00a7f863          	bgeu	a5,a0,4a <fmtname+0x4a>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  3e:	8526                	mv	a0,s1
  40:	70a2                	ld	ra,40(sp)
  42:	7402                	ld	s0,32(sp)
  44:	64e2                	ld	s1,24(sp)
  46:	6145                	addi	sp,sp,48
  48:	8082                	ret
  4a:	e84a                	sd	s2,16(sp)
  4c:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  4e:	8526                	mv	a0,s1
  50:	29a000ef          	jal	2ea <strlen>
  54:	862a                	mv	a2,a0
  56:	00002997          	auipc	s3,0x2
  5a:	fba98993          	addi	s3,s3,-70 # 2010 <buf.0>
  5e:	85a6                	mv	a1,s1
  60:	854e                	mv	a0,s3
  62:	40e000ef          	jal	470 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  66:	8526                	mv	a0,s1
  68:	282000ef          	jal	2ea <strlen>
  6c:	892a                	mv	s2,a0
  6e:	8526                	mv	a0,s1
  70:	27a000ef          	jal	2ea <strlen>
  74:	1902                	slli	s2,s2,0x20
  76:	02095913          	srli	s2,s2,0x20
  7a:	4639                	li	a2,14
  7c:	9e09                	subw	a2,a2,a0
  7e:	02000593          	li	a1,32
  82:	01298533          	add	a0,s3,s2
  86:	292000ef          	jal	318 <memset>
  return buf;
  8a:	84ce                	mv	s1,s3
  8c:	6942                	ld	s2,16(sp)
  8e:	69a2                	ld	s3,8(sp)
  90:	b77d                	j	3e <fmtname+0x3e>

0000000000000092 <ls>:

void
ls(char *path)
{
  92:	d7010113          	addi	sp,sp,-656
  96:	28113423          	sd	ra,648(sp)
  9a:	28813023          	sd	s0,640(sp)
  9e:	27213823          	sd	s2,624(sp)
  a2:	0d00                	addi	s0,sp,656
  a4:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  a6:	4581                	li	a1,0
  a8:	592000ef          	jal	63a <open>
  ac:	06054363          	bltz	a0,112 <ls+0x80>
  b0:	26913c23          	sd	s1,632(sp)
  b4:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b6:	d7840593          	addi	a1,s0,-648
  ba:	598000ef          	jal	652 <fstat>
  be:	06054363          	bltz	a0,124 <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c2:	d8041783          	lh	a5,-640(s0)
  c6:	4705                	li	a4,1
  c8:	06e78c63          	beq	a5,a4,140 <ls+0xae>
  cc:	37f9                	addiw	a5,a5,-2
  ce:	17c2                	slli	a5,a5,0x30
  d0:	93c1                	srli	a5,a5,0x30
  d2:	02f76263          	bltu	a4,a5,f6 <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  d6:	854a                	mv	a0,s2
  d8:	f29ff0ef          	jal	0 <fmtname>
  dc:	85aa                	mv	a1,a0
  de:	d8842703          	lw	a4,-632(s0)
  e2:	d7c42683          	lw	a3,-644(s0)
  e6:	d8041603          	lh	a2,-640(s0)
  ea:	00001517          	auipc	a0,0x1
  ee:	af650513          	addi	a0,a0,-1290 # be0 <malloc+0x124>
  f2:	113000ef          	jal	a04 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
  f6:	8526                	mv	a0,s1
  f8:	52a000ef          	jal	622 <close>
  fc:	27813483          	ld	s1,632(sp)
}
 100:	28813083          	ld	ra,648(sp)
 104:	28013403          	ld	s0,640(sp)
 108:	27013903          	ld	s2,624(sp)
 10c:	29010113          	addi	sp,sp,656
 110:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 112:	864a                	mv	a2,s2
 114:	00001597          	auipc	a1,0x1
 118:	a9c58593          	addi	a1,a1,-1380 # bb0 <malloc+0xf4>
 11c:	4509                	li	a0,2
 11e:	0bd000ef          	jal	9da <fprintf>
    return;
 122:	bff9                	j	100 <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 124:	864a                	mv	a2,s2
 126:	00001597          	auipc	a1,0x1
 12a:	aa258593          	addi	a1,a1,-1374 # bc8 <malloc+0x10c>
 12e:	4509                	li	a0,2
 130:	0ab000ef          	jal	9da <fprintf>
    close(fd);
 134:	8526                	mv	a0,s1
 136:	4ec000ef          	jal	622 <close>
    return;
 13a:	27813483          	ld	s1,632(sp)
 13e:	b7c9                	j	100 <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 140:	854a                	mv	a0,s2
 142:	1a8000ef          	jal	2ea <strlen>
 146:	2541                	addiw	a0,a0,16
 148:	20000793          	li	a5,512
 14c:	00a7f963          	bgeu	a5,a0,15e <ls+0xcc>
      printf("ls: path too long\n");
 150:	00001517          	auipc	a0,0x1
 154:	aa050513          	addi	a0,a0,-1376 # bf0 <malloc+0x134>
 158:	0ad000ef          	jal	a04 <printf>
      break;
 15c:	bf69                	j	f6 <ls+0x64>
 15e:	27313423          	sd	s3,616(sp)
 162:	27413023          	sd	s4,608(sp)
 166:	25513c23          	sd	s5,600(sp)
 16a:	25613823          	sd	s6,592(sp)
 16e:	25713423          	sd	s7,584(sp)
 172:	25813023          	sd	s8,576(sp)
 176:	23913c23          	sd	s9,568(sp)
 17a:	23a13823          	sd	s10,560(sp)
    strcpy(buf, path);
 17e:	da040993          	addi	s3,s0,-608
 182:	85ca                	mv	a1,s2
 184:	854e                	mv	a0,s3
 186:	114000ef          	jal	29a <strcpy>
    p = buf+strlen(buf);
 18a:	854e                	mv	a0,s3
 18c:	15e000ef          	jal	2ea <strlen>
 190:	1502                	slli	a0,a0,0x20
 192:	9101                	srli	a0,a0,0x20
 194:	99aa                	add	s3,s3,a0
    *p++ = '/';
 196:	00198c93          	addi	s9,s3,1
 19a:	02f00793          	li	a5,47
 19e:	00f98023          	sb	a5,0(s3)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a2:	d9040a13          	addi	s4,s0,-624
 1a6:	4941                	li	s2,16
      memmove(p, de.name, DIRSIZ);
 1a8:	d9240c13          	addi	s8,s0,-622
 1ac:	4bb9                	li	s7,14
      if(stat(buf, &st) < 0){
 1ae:	d7840b13          	addi	s6,s0,-648
 1b2:	da040a93          	addi	s5,s0,-608
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1b6:	00001d17          	auipc	s10,0x1
 1ba:	a2ad0d13          	addi	s10,s10,-1494 # be0 <malloc+0x124>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1be:	a801                	j	1ce <ls+0x13c>
        printf("ls: cannot stat %s\n", buf);
 1c0:	85d6                	mv	a1,s5
 1c2:	00001517          	auipc	a0,0x1
 1c6:	a0650513          	addi	a0,a0,-1530 # bc8 <malloc+0x10c>
 1ca:	03b000ef          	jal	a04 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ce:	864a                	mv	a2,s2
 1d0:	85d2                	mv	a1,s4
 1d2:	8526                	mv	a0,s1
 1d4:	43e000ef          	jal	612 <read>
 1d8:	05251063          	bne	a0,s2,218 <ls+0x186>
      if(de.inum == 0)
 1dc:	d9045783          	lhu	a5,-624(s0)
 1e0:	d7fd                	beqz	a5,1ce <ls+0x13c>
      memmove(p, de.name, DIRSIZ);
 1e2:	865e                	mv	a2,s7
 1e4:	85e2                	mv	a1,s8
 1e6:	8566                	mv	a0,s9
 1e8:	288000ef          	jal	470 <memmove>
      p[DIRSIZ] = 0;
 1ec:	000987a3          	sb	zero,15(s3)
      if(stat(buf, &st) < 0){
 1f0:	85da                	mv	a1,s6
 1f2:	8556                	mv	a0,s5
 1f4:	1f6000ef          	jal	3ea <stat>
 1f8:	fc0544e3          	bltz	a0,1c0 <ls+0x12e>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1fc:	8556                	mv	a0,s5
 1fe:	e03ff0ef          	jal	0 <fmtname>
 202:	85aa                	mv	a1,a0
 204:	d8842703          	lw	a4,-632(s0)
 208:	d7c42683          	lw	a3,-644(s0)
 20c:	d8041603          	lh	a2,-640(s0)
 210:	856a                	mv	a0,s10
 212:	7f2000ef          	jal	a04 <printf>
 216:	bf65                	j	1ce <ls+0x13c>
 218:	26813983          	ld	s3,616(sp)
 21c:	26013a03          	ld	s4,608(sp)
 220:	25813a83          	ld	s5,600(sp)
 224:	25013b03          	ld	s6,592(sp)
 228:	24813b83          	ld	s7,584(sp)
 22c:	24013c03          	ld	s8,576(sp)
 230:	23813c83          	ld	s9,568(sp)
 234:	23013d03          	ld	s10,560(sp)
 238:	bd7d                	j	f6 <ls+0x64>

000000000000023a <main>:

int
main(int argc, char *argv[])
{
 23a:	1101                	addi	sp,sp,-32
 23c:	ec06                	sd	ra,24(sp)
 23e:	e822                	sd	s0,16(sp)
 240:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 242:	4785                	li	a5,1
 244:	02a7d763          	bge	a5,a0,272 <main+0x38>
 248:	e426                	sd	s1,8(sp)
 24a:	e04a                	sd	s2,0(sp)
 24c:	00858493          	addi	s1,a1,8
 250:	ffe5091b          	addiw	s2,a0,-2
 254:	02091793          	slli	a5,s2,0x20
 258:	01d7d913          	srli	s2,a5,0x1d
 25c:	05c1                	addi	a1,a1,16
 25e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 260:	6088                	ld	a0,0(s1)
 262:	e31ff0ef          	jal	92 <ls>
  for(i=1; i<argc; i++)
 266:	04a1                	addi	s1,s1,8
 268:	ff249ce3          	bne	s1,s2,260 <main+0x26>
  exit(0);
 26c:	4501                	li	a0,0
 26e:	38c000ef          	jal	5fa <exit>
 272:	e426                	sd	s1,8(sp)
 274:	e04a                	sd	s2,0(sp)
    ls(".");
 276:	00001517          	auipc	a0,0x1
 27a:	99250513          	addi	a0,a0,-1646 # c08 <malloc+0x14c>
 27e:	e15ff0ef          	jal	92 <ls>
    exit(0);
 282:	4501                	li	a0,0
 284:	376000ef          	jal	5fa <exit>

0000000000000288 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
 288:	1141                	addi	sp,sp,-16
 28a:	e406                	sd	ra,8(sp)
 28c:	e022                	sd	s0,0(sp)
 28e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 290:	fabff0ef          	jal	23a <main>
  exit(0);
 294:	4501                	li	a0,0
 296:	364000ef          	jal	5fa <exit>

000000000000029a <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
 2a2:	87aa                	mv	a5,a0
 2a4:	0585                	addi	a1,a1,1
 2a6:	0785                	addi	a5,a5,1
 2a8:	fff5c703          	lbu	a4,-1(a1)
 2ac:	fee78fa3          	sb	a4,-1(a5)
 2b0:	fb75                	bnez	a4,2a4 <strcpy+0xa>
    ;
  return os;
}
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strcmp>:

int strcmp(const char *p, const char *q)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e406                	sd	ra,8(sp)
 2be:	e022                	sd	s0,0(sp)
 2c0:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cb91                	beqz	a5,2da <strcmp+0x20>
 2c8:	0005c703          	lbu	a4,0(a1)
 2cc:	00f71763          	bne	a4,a5,2da <strcmp+0x20>
    p++, q++;
 2d0:	0505                	addi	a0,a0,1
 2d2:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	fbe5                	bnez	a5,2c8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2da:	0005c503          	lbu	a0,0(a1)
}
 2de:	40a7853b          	subw	a0,a5,a0
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <strlen>:

uint strlen(const char *s)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
 2f2:	00054783          	lbu	a5,0(a0)
 2f6:	cf99                	beqz	a5,314 <strlen+0x2a>
 2f8:	0505                	addi	a0,a0,1
 2fa:	87aa                	mv	a5,a0
 2fc:	86be                	mv	a3,a5
 2fe:	0785                	addi	a5,a5,1
 300:	fff7c703          	lbu	a4,-1(a5)
 304:	ff65                	bnez	a4,2fc <strlen+0x12>
 306:	40a6853b          	subw	a0,a3,a0
 30a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 30c:	60a2                	ld	ra,8(sp)
 30e:	6402                	ld	s0,0(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret
  for (n = 0; s[n]; n++)
 314:	4501                	li	a0,0
 316:	bfdd                	j	30c <strlen+0x22>

0000000000000318 <memset>:

void *
memset(void *dst, int c, uint n)
{
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
 320:	ca19                	beqz	a2,336 <memset+0x1e>
 322:	87aa                	mv	a5,a0
 324:	1602                	slli	a2,a2,0x20
 326:	9201                	srli	a2,a2,0x20
 328:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
 32c:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
 330:	0785                	addi	a5,a5,1
 332:	fee79de3          	bne	a5,a4,32c <memset+0x14>
  }
  return dst;
}
 336:	60a2                	ld	ra,8(sp)
 338:	6402                	ld	s0,0(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret

000000000000033e <strchr>:

char *
strchr(const char *s, char c)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e406                	sd	ra,8(sp)
 342:	e022                	sd	s0,0(sp)
 344:	0800                	addi	s0,sp,16
  for (; *s; s++)
 346:	00054783          	lbu	a5,0(a0)
 34a:	cf81                	beqz	a5,362 <strchr+0x24>
    if (*s == c)
 34c:	00f58763          	beq	a1,a5,35a <strchr+0x1c>
  for (; *s; s++)
 350:	0505                	addi	a0,a0,1
 352:	00054783          	lbu	a5,0(a0)
 356:	fbfd                	bnez	a5,34c <strchr+0xe>
      return (char *)s;
  return 0;
 358:	4501                	li	a0,0
}
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
  return 0;
 362:	4501                	li	a0,0
 364:	bfdd                	j	35a <strchr+0x1c>

0000000000000366 <gets>:

char *
gets(char *buf, int max)
{
 366:	7159                	addi	sp,sp,-112
 368:	f486                	sd	ra,104(sp)
 36a:	f0a2                	sd	s0,96(sp)
 36c:	eca6                	sd	s1,88(sp)
 36e:	e8ca                	sd	s2,80(sp)
 370:	e4ce                	sd	s3,72(sp)
 372:	e0d2                	sd	s4,64(sp)
 374:	fc56                	sd	s5,56(sp)
 376:	f85a                	sd	s6,48(sp)
 378:	f45e                	sd	s7,40(sp)
 37a:	f062                	sd	s8,32(sp)
 37c:	ec66                	sd	s9,24(sp)
 37e:	e86a                	sd	s10,16(sp)
 380:	1880                	addi	s0,sp,112
 382:	8caa                	mv	s9,a0
 384:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
 386:	892a                	mv	s2,a0
 388:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
 38a:	f9f40b13          	addi	s6,s0,-97
 38e:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
 390:	4ba9                	li	s7,10
 392:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
 394:	8d26                	mv	s10,s1
 396:	0014899b          	addiw	s3,s1,1
 39a:	84ce                	mv	s1,s3
 39c:	0349d563          	bge	s3,s4,3c6 <gets+0x60>
    cc = read(0, &c, 1);
 3a0:	8656                	mv	a2,s5
 3a2:	85da                	mv	a1,s6
 3a4:	4501                	li	a0,0
 3a6:	26c000ef          	jal	612 <read>
    if (cc < 1)
 3aa:	00a05e63          	blez	a0,3c6 <gets+0x60>
    buf[i++] = c;
 3ae:	f9f44783          	lbu	a5,-97(s0)
 3b2:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
 3b6:	01778763          	beq	a5,s7,3c4 <gets+0x5e>
 3ba:	0905                	addi	s2,s2,1
 3bc:	fd879ce3          	bne	a5,s8,394 <gets+0x2e>
    buf[i++] = c;
 3c0:	8d4e                	mv	s10,s3
 3c2:	a011                	j	3c6 <gets+0x60>
 3c4:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 3c6:	9d66                	add	s10,s10,s9
 3c8:	000d0023          	sb	zero,0(s10)
  return buf;
}
 3cc:	8566                	mv	a0,s9
 3ce:	70a6                	ld	ra,104(sp)
 3d0:	7406                	ld	s0,96(sp)
 3d2:	64e6                	ld	s1,88(sp)
 3d4:	6946                	ld	s2,80(sp)
 3d6:	69a6                	ld	s3,72(sp)
 3d8:	6a06                	ld	s4,64(sp)
 3da:	7ae2                	ld	s5,56(sp)
 3dc:	7b42                	ld	s6,48(sp)
 3de:	7ba2                	ld	s7,40(sp)
 3e0:	7c02                	ld	s8,32(sp)
 3e2:	6ce2                	ld	s9,24(sp)
 3e4:	6d42                	ld	s10,16(sp)
 3e6:	6165                	addi	sp,sp,112
 3e8:	8082                	ret

00000000000003ea <stat>:

int stat(const char *n, struct stat *st)
{
 3ea:	1101                	addi	sp,sp,-32
 3ec:	ec06                	sd	ra,24(sp)
 3ee:	e822                	sd	s0,16(sp)
 3f0:	e04a                	sd	s2,0(sp)
 3f2:	1000                	addi	s0,sp,32
 3f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f6:	4581                	li	a1,0
 3f8:	242000ef          	jal	63a <open>
  if (fd < 0)
 3fc:	02054263          	bltz	a0,420 <stat+0x36>
 400:	e426                	sd	s1,8(sp)
 402:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 404:	85ca                	mv	a1,s2
 406:	24c000ef          	jal	652 <fstat>
 40a:	892a                	mv	s2,a0
  close(fd);
 40c:	8526                	mv	a0,s1
 40e:	214000ef          	jal	622 <close>
  return r;
 412:	64a2                	ld	s1,8(sp)
}
 414:	854a                	mv	a0,s2
 416:	60e2                	ld	ra,24(sp)
 418:	6442                	ld	s0,16(sp)
 41a:	6902                	ld	s2,0(sp)
 41c:	6105                	addi	sp,sp,32
 41e:	8082                	ret
    return -1;
 420:	597d                	li	s2,-1
 422:	bfcd                	j	414 <stat+0x2a>

0000000000000424 <atoi>:

int atoi(const char *s)
{
 424:	1141                	addi	sp,sp,-16
 426:	e406                	sd	ra,8(sp)
 428:	e022                	sd	s0,0(sp)
 42a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
 42c:	00054683          	lbu	a3,0(a0)
 430:	fd06879b          	addiw	a5,a3,-48
 434:	0ff7f793          	zext.b	a5,a5
 438:	4625                	li	a2,9
 43a:	02f66963          	bltu	a2,a5,46c <atoi+0x48>
 43e:	872a                	mv	a4,a0
  n = 0;
 440:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
 442:	0705                	addi	a4,a4,1
 444:	0025179b          	slliw	a5,a0,0x2
 448:	9fa9                	addw	a5,a5,a0
 44a:	0017979b          	slliw	a5,a5,0x1
 44e:	9fb5                	addw	a5,a5,a3
 450:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
 454:	00074683          	lbu	a3,0(a4)
 458:	fd06879b          	addiw	a5,a3,-48
 45c:	0ff7f793          	zext.b	a5,a5
 460:	fef671e3          	bgeu	a2,a5,442 <atoi+0x1e>
  return n;
}
 464:	60a2                	ld	ra,8(sp)
 466:	6402                	ld	s0,0(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret
  n = 0;
 46c:	4501                	li	a0,0
 46e:	bfdd                	j	464 <atoi+0x40>

0000000000000470 <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
 470:	1141                	addi	sp,sp,-16
 472:	e406                	sd	ra,8(sp)
 474:	e022                	sd	s0,0(sp)
 476:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
 478:	02b57563          	bgeu	a0,a1,4a2 <memmove+0x32>
  {
    while (n-- > 0)
 47c:	00c05f63          	blez	a2,49a <memmove+0x2a>
 480:	1602                	slli	a2,a2,0x20
 482:	9201                	srli	a2,a2,0x20
 484:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 488:	872a                	mv	a4,a0
      *dst++ = *src++;
 48a:	0585                	addi	a1,a1,1
 48c:	0705                	addi	a4,a4,1
 48e:	fff5c683          	lbu	a3,-1(a1)
 492:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
 496:	fee79ae3          	bne	a5,a4,48a <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 49a:	60a2                	ld	ra,8(sp)
 49c:	6402                	ld	s0,0(sp)
 49e:	0141                	addi	sp,sp,16
 4a0:	8082                	ret
    dst += n;
 4a2:	00c50733          	add	a4,a0,a2
    src += n;
 4a6:	95b2                	add	a1,a1,a2
    while (n-- > 0)
 4a8:	fec059e3          	blez	a2,49a <memmove+0x2a>
 4ac:	fff6079b          	addiw	a5,a2,-1
 4b0:	1782                	slli	a5,a5,0x20
 4b2:	9381                	srli	a5,a5,0x20
 4b4:	fff7c793          	not	a5,a5
 4b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4ba:	15fd                	addi	a1,a1,-1
 4bc:	177d                	addi	a4,a4,-1
 4be:	0005c683          	lbu	a3,0(a1)
 4c2:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
 4c6:	fef71ae3          	bne	a4,a5,4ba <memmove+0x4a>
 4ca:	bfc1                	j	49a <memmove+0x2a>

00000000000004cc <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
 4d4:	ca0d                	beqz	a2,506 <memcmp+0x3a>
 4d6:	fff6069b          	addiw	a3,a2,-1
 4da:	1682                	slli	a3,a3,0x20
 4dc:	9281                	srli	a3,a3,0x20
 4de:	0685                	addi	a3,a3,1
 4e0:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	0005c703          	lbu	a4,0(a1)
 4ea:	00e79863          	bne	a5,a4,4fa <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
 4ee:	0505                	addi	a0,a0,1
    p2++;
 4f0:	0585                	addi	a1,a1,1
  while (n-- > 0)
 4f2:	fed518e3          	bne	a0,a3,4e2 <memcmp+0x16>
  }
  return 0;
 4f6:	4501                	li	a0,0
 4f8:	a019                	j	4fe <memcmp+0x32>
      return *p1 - *p2;
 4fa:	40e7853b          	subw	a0,a5,a4
}
 4fe:	60a2                	ld	ra,8(sp)
 500:	6402                	ld	s0,0(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret
  return 0;
 506:	4501                	li	a0,0
 508:	bfdd                	j	4fe <memcmp+0x32>

000000000000050a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 50a:	1141                	addi	sp,sp,-16
 50c:	e406                	sd	ra,8(sp)
 50e:	e022                	sd	s0,0(sp)
 510:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 512:	f5fff0ef          	jal	470 <memmove>
}
 516:	60a2                	ld	ra,8(sp)
 518:	6402                	ld	s0,0(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret

000000000000051e <strcat>:

char *strcat(char *dst, const char *src)
{
 51e:	1141                	addi	sp,sp,-16
 520:	e406                	sd	ra,8(sp)
 522:	e022                	sd	s0,0(sp)
 524:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
 526:	00054783          	lbu	a5,0(a0)
 52a:	c795                	beqz	a5,556 <strcat+0x38>
  char *p = dst;
 52c:	87aa                	mv	a5,a0
    p++;
 52e:	0785                	addi	a5,a5,1
  while (*p)
 530:	0007c703          	lbu	a4,0(a5)
 534:	ff6d                	bnez	a4,52e <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
 536:	0005c703          	lbu	a4,0(a1)
 53a:	cb01                	beqz	a4,54a <strcat+0x2c>
  {
    *p = *src;
 53c:	00e78023          	sb	a4,0(a5)
    p++;
 540:	0785                	addi	a5,a5,1
    src++;
 542:	0585                	addi	a1,a1,1
  while (*src)
 544:	0005c703          	lbu	a4,0(a1)
 548:	fb75                	bnez	a4,53c <strcat+0x1e>
  }

  *p = 0;
 54a:	00078023          	sb	zero,0(a5)

  return dst;
}
 54e:	60a2                	ld	ra,8(sp)
 550:	6402                	ld	s0,0(sp)
 552:	0141                	addi	sp,sp,16
 554:	8082                	ret
  char *p = dst;
 556:	87aa                	mv	a5,a0
 558:	bff9                	j	536 <strcat+0x18>

000000000000055a <isdir>:

int isdir(char *path)
{
 55a:	7179                	addi	sp,sp,-48
 55c:	f406                	sd	ra,40(sp)
 55e:	f022                	sd	s0,32(sp)
 560:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
 562:	fd840593          	addi	a1,s0,-40
 566:	e85ff0ef          	jal	3ea <stat>
 56a:	00054b63          	bltz	a0,580 <isdir+0x26>
    return 0;
  return st.type == T_DIR;
 56e:	fe041503          	lh	a0,-32(s0)
 572:	157d                	addi	a0,a0,-1
 574:	00153513          	seqz	a0,a0
}
 578:	70a2                	ld	ra,40(sp)
 57a:	7402                	ld	s0,32(sp)
 57c:	6145                	addi	sp,sp,48
 57e:	8082                	ret
    return 0;
 580:	4501                	li	a0,0
 582:	bfdd                	j	578 <isdir+0x1e>

0000000000000584 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
 584:	7139                	addi	sp,sp,-64
 586:	fc06                	sd	ra,56(sp)
 588:	f822                	sd	s0,48(sp)
 58a:	f426                	sd	s1,40(sp)
 58c:	f04a                	sd	s2,32(sp)
 58e:	ec4e                	sd	s3,24(sp)
 590:	e852                	sd	s4,16(sp)
 592:	e456                	sd	s5,8(sp)
 594:	0080                	addi	s0,sp,64
 596:	89aa                	mv	s3,a0
 598:	8aae                	mv	s5,a1
 59a:	84b2                	mv	s1,a2
 59c:	8a36                	mv	s4,a3
  int dn = strlen(dir);
 59e:	d4dff0ef          	jal	2ea <strlen>
 5a2:	892a                	mv	s2,a0
  int nn = strlen(filename);
 5a4:	8556                	mv	a0,s5
 5a6:	d45ff0ef          	jal	2ea <strlen>
  int need = dn + 1 + nn + 1;
 5aa:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
 5ae:	9fa9                	addw	a5,a5,a0
    return 0;
 5b0:	4501                	li	a0,0
  if (need > bufsize)
 5b2:	0347d763          	bge	a5,s4,5e0 <joinpath+0x5c>
  strcpy(out_buffer, dir);
 5b6:	85ce                	mv	a1,s3
 5b8:	8526                	mv	a0,s1
 5ba:	ce1ff0ef          	jal	29a <strcpy>
  if (dir[dn - 1] != '/')
 5be:	99ca                	add	s3,s3,s2
 5c0:	fff9c703          	lbu	a4,-1(s3)
 5c4:	02f00793          	li	a5,47
 5c8:	00f70763          	beq	a4,a5,5d6 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
 5cc:	9926                	add	s2,s2,s1
 5ce:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
 5d2:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
 5d6:	85d6                	mv	a1,s5
 5d8:	8526                	mv	a0,s1
 5da:	f45ff0ef          	jal	51e <strcat>
  return out_buffer;
 5de:	8526                	mv	a0,s1
}
 5e0:	70e2                	ld	ra,56(sp)
 5e2:	7442                	ld	s0,48(sp)
 5e4:	74a2                	ld	s1,40(sp)
 5e6:	7902                	ld	s2,32(sp)
 5e8:	69e2                	ld	s3,24(sp)
 5ea:	6a42                	ld	s4,16(sp)
 5ec:	6aa2                	ld	s5,8(sp)
 5ee:	6121                	addi	sp,sp,64
 5f0:	8082                	ret

00000000000005f2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5f2:	4885                	li	a7,1
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <exit>:
.global exit
exit:
 li a7, SYS_exit
 5fa:	4889                	li	a7,2
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <wait>:
.global wait
wait:
 li a7, SYS_wait
 602:	488d                	li	a7,3
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 60a:	4891                	li	a7,4
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <read>:
.global read
read:
 li a7, SYS_read
 612:	4895                	li	a7,5
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <write>:
.global write
write:
 li a7, SYS_write
 61a:	48c1                	li	a7,16
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <close>:
.global close
close:
 li a7, SYS_close
 622:	48d5                	li	a7,21
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <kill>:
.global kill
kill:
 li a7, SYS_kill
 62a:	4899                	li	a7,6
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <exec>:
.global exec
exec:
 li a7, SYS_exec
 632:	489d                	li	a7,7
 ecall
 634:	00000073          	ecall
 ret
 638:	8082                	ret

000000000000063a <open>:
.global open
open:
 li a7, SYS_open
 63a:	48bd                	li	a7,15
 ecall
 63c:	00000073          	ecall
 ret
 640:	8082                	ret

0000000000000642 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 642:	48c5                	li	a7,17
 ecall
 644:	00000073          	ecall
 ret
 648:	8082                	ret

000000000000064a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 64a:	48c9                	li	a7,18
 ecall
 64c:	00000073          	ecall
 ret
 650:	8082                	ret

0000000000000652 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 652:	48a1                	li	a7,8
 ecall
 654:	00000073          	ecall
 ret
 658:	8082                	ret

000000000000065a <link>:
.global link
link:
 li a7, SYS_link
 65a:	48cd                	li	a7,19
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 662:	48d1                	li	a7,20
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 66a:	48a5                	li	a7,9
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <dup>:
.global dup
dup:
 li a7, SYS_dup
 672:	48a9                	li	a7,10
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 67a:	48ad                	li	a7,11
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 682:	48b1                	li	a7,12
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 68a:	48b5                	li	a7,13
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 692:	48b9                	li	a7,14
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
 69a:	48d9                	li	a7,22
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6a2:	1101                	addi	sp,sp,-32
 6a4:	ec06                	sd	ra,24(sp)
 6a6:	e822                	sd	s0,16(sp)
 6a8:	1000                	addi	s0,sp,32
 6aa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6ae:	4605                	li	a2,1
 6b0:	fef40593          	addi	a1,s0,-17
 6b4:	f67ff0ef          	jal	61a <write>
}
 6b8:	60e2                	ld	ra,24(sp)
 6ba:	6442                	ld	s0,16(sp)
 6bc:	6105                	addi	sp,sp,32
 6be:	8082                	ret

00000000000006c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6c0:	7139                	addi	sp,sp,-64
 6c2:	fc06                	sd	ra,56(sp)
 6c4:	f822                	sd	s0,48(sp)
 6c6:	f426                	sd	s1,40(sp)
 6c8:	f04a                	sd	s2,32(sp)
 6ca:	ec4e                	sd	s3,24(sp)
 6cc:	0080                	addi	s0,sp,64
 6ce:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6d0:	c299                	beqz	a3,6d6 <printint+0x16>
 6d2:	0605ce63          	bltz	a1,74e <printint+0x8e>
  neg = 0;
 6d6:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 6d8:	fc040313          	addi	t1,s0,-64
  neg = 0;
 6dc:	869a                	mv	a3,t1
  i = 0;
 6de:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6e0:	00000817          	auipc	a6,0x0
 6e4:	53880813          	addi	a6,a6,1336 # c18 <digits>
 6e8:	88be                	mv	a7,a5
 6ea:	0017851b          	addiw	a0,a5,1
 6ee:	87aa                	mv	a5,a0
 6f0:	02c5f73b          	remuw	a4,a1,a2
 6f4:	1702                	slli	a4,a4,0x20
 6f6:	9301                	srli	a4,a4,0x20
 6f8:	9742                	add	a4,a4,a6
 6fa:	00074703          	lbu	a4,0(a4)
 6fe:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 702:	872e                	mv	a4,a1
 704:	02c5d5bb          	divuw	a1,a1,a2
 708:	0685                	addi	a3,a3,1
 70a:	fcc77fe3          	bgeu	a4,a2,6e8 <printint+0x28>
  if(neg)
 70e:	000e0c63          	beqz	t3,726 <printint+0x66>
    buf[i++] = '-';
 712:	fd050793          	addi	a5,a0,-48
 716:	00878533          	add	a0,a5,s0
 71a:	02d00793          	li	a5,45
 71e:	fef50823          	sb	a5,-16(a0)
 722:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 726:	fff7899b          	addiw	s3,a5,-1
 72a:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 72e:	fff4c583          	lbu	a1,-1(s1)
 732:	854a                	mv	a0,s2
 734:	f6fff0ef          	jal	6a2 <putc>
  while(--i >= 0)
 738:	39fd                	addiw	s3,s3,-1
 73a:	14fd                	addi	s1,s1,-1
 73c:	fe09d9e3          	bgez	s3,72e <printint+0x6e>
}
 740:	70e2                	ld	ra,56(sp)
 742:	7442                	ld	s0,48(sp)
 744:	74a2                	ld	s1,40(sp)
 746:	7902                	ld	s2,32(sp)
 748:	69e2                	ld	s3,24(sp)
 74a:	6121                	addi	sp,sp,64
 74c:	8082                	ret
    x = -xx;
 74e:	40b005bb          	negw	a1,a1
    neg = 1;
 752:	4e05                	li	t3,1
    x = -xx;
 754:	b751                	j	6d8 <printint+0x18>

0000000000000756 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 756:	711d                	addi	sp,sp,-96
 758:	ec86                	sd	ra,88(sp)
 75a:	e8a2                	sd	s0,80(sp)
 75c:	e4a6                	sd	s1,72(sp)
 75e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 760:	0005c483          	lbu	s1,0(a1)
 764:	26048663          	beqz	s1,9d0 <vprintf+0x27a>
 768:	e0ca                	sd	s2,64(sp)
 76a:	fc4e                	sd	s3,56(sp)
 76c:	f852                	sd	s4,48(sp)
 76e:	f456                	sd	s5,40(sp)
 770:	f05a                	sd	s6,32(sp)
 772:	ec5e                	sd	s7,24(sp)
 774:	e862                	sd	s8,16(sp)
 776:	e466                	sd	s9,8(sp)
 778:	8b2a                	mv	s6,a0
 77a:	8a2e                	mv	s4,a1
 77c:	8bb2                	mv	s7,a2
  state = 0;
 77e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 780:	4901                	li	s2,0
 782:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 784:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 788:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 78c:	06c00c93          	li	s9,108
 790:	a00d                	j	7b2 <vprintf+0x5c>
        putc(fd, c0);
 792:	85a6                	mv	a1,s1
 794:	855a                	mv	a0,s6
 796:	f0dff0ef          	jal	6a2 <putc>
 79a:	a019                	j	7a0 <vprintf+0x4a>
    } else if(state == '%'){
 79c:	03598363          	beq	s3,s5,7c2 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 7a0:	0019079b          	addiw	a5,s2,1
 7a4:	893e                	mv	s2,a5
 7a6:	873e                	mv	a4,a5
 7a8:	97d2                	add	a5,a5,s4
 7aa:	0007c483          	lbu	s1,0(a5)
 7ae:	20048963          	beqz	s1,9c0 <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
 7b2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 7b6:	fe0993e3          	bnez	s3,79c <vprintf+0x46>
      if(c0 == '%'){
 7ba:	fd579ce3          	bne	a5,s5,792 <vprintf+0x3c>
        state = '%';
 7be:	89be                	mv	s3,a5
 7c0:	b7c5                	j	7a0 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 7c2:	00ea06b3          	add	a3,s4,a4
 7c6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 7ca:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 7cc:	c681                	beqz	a3,7d4 <vprintf+0x7e>
 7ce:	9752                	add	a4,a4,s4
 7d0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 7d4:	03878e63          	beq	a5,s8,810 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 7d8:	05978863          	beq	a5,s9,828 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7dc:	07500713          	li	a4,117
 7e0:	0ee78263          	beq	a5,a4,8c4 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7e4:	07800713          	li	a4,120
 7e8:	12e78463          	beq	a5,a4,910 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7ec:	07000713          	li	a4,112
 7f0:	14e78963          	beq	a5,a4,942 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 7f4:	07300713          	li	a4,115
 7f8:	18e78863          	beq	a5,a4,988 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7fc:	02500713          	li	a4,37
 800:	04e79463          	bne	a5,a4,848 <vprintf+0xf2>
        putc(fd, '%');
 804:	85ba                	mv	a1,a4
 806:	855a                	mv	a0,s6
 808:	e9bff0ef          	jal	6a2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 80c:	4981                	li	s3,0
 80e:	bf49                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 810:	008b8493          	addi	s1,s7,8
 814:	4685                	li	a3,1
 816:	4629                	li	a2,10
 818:	000ba583          	lw	a1,0(s7)
 81c:	855a                	mv	a0,s6
 81e:	ea3ff0ef          	jal	6c0 <printint>
 822:	8ba6                	mv	s7,s1
      state = 0;
 824:	4981                	li	s3,0
 826:	bfad                	j	7a0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 828:	06400793          	li	a5,100
 82c:	02f68963          	beq	a3,a5,85e <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 830:	06c00793          	li	a5,108
 834:	04f68263          	beq	a3,a5,878 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 838:	07500793          	li	a5,117
 83c:	0af68063          	beq	a3,a5,8dc <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 840:	07800793          	li	a5,120
 844:	0ef68263          	beq	a3,a5,928 <vprintf+0x1d2>
        putc(fd, '%');
 848:	02500593          	li	a1,37
 84c:	855a                	mv	a0,s6
 84e:	e55ff0ef          	jal	6a2 <putc>
        putc(fd, c0);
 852:	85a6                	mv	a1,s1
 854:	855a                	mv	a0,s6
 856:	e4dff0ef          	jal	6a2 <putc>
      state = 0;
 85a:	4981                	li	s3,0
 85c:	b791                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 85e:	008b8493          	addi	s1,s7,8
 862:	4685                	li	a3,1
 864:	4629                	li	a2,10
 866:	000ba583          	lw	a1,0(s7)
 86a:	855a                	mv	a0,s6
 86c:	e55ff0ef          	jal	6c0 <printint>
        i += 1;
 870:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 872:	8ba6                	mv	s7,s1
      state = 0;
 874:	4981                	li	s3,0
        i += 1;
 876:	b72d                	j	7a0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 878:	06400793          	li	a5,100
 87c:	02f60763          	beq	a2,a5,8aa <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 880:	07500793          	li	a5,117
 884:	06f60963          	beq	a2,a5,8f6 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 888:	07800793          	li	a5,120
 88c:	faf61ee3          	bne	a2,a5,848 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 890:	008b8493          	addi	s1,s7,8
 894:	4681                	li	a3,0
 896:	4641                	li	a2,16
 898:	000ba583          	lw	a1,0(s7)
 89c:	855a                	mv	a0,s6
 89e:	e23ff0ef          	jal	6c0 <printint>
        i += 2;
 8a2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 8a4:	8ba6                	mv	s7,s1
      state = 0;
 8a6:	4981                	li	s3,0
        i += 2;
 8a8:	bde5                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 8aa:	008b8493          	addi	s1,s7,8
 8ae:	4685                	li	a3,1
 8b0:	4629                	li	a2,10
 8b2:	000ba583          	lw	a1,0(s7)
 8b6:	855a                	mv	a0,s6
 8b8:	e09ff0ef          	jal	6c0 <printint>
        i += 2;
 8bc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 8be:	8ba6                	mv	s7,s1
      state = 0;
 8c0:	4981                	li	s3,0
        i += 2;
 8c2:	bdf9                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 8c4:	008b8493          	addi	s1,s7,8
 8c8:	4681                	li	a3,0
 8ca:	4629                	li	a2,10
 8cc:	000ba583          	lw	a1,0(s7)
 8d0:	855a                	mv	a0,s6
 8d2:	defff0ef          	jal	6c0 <printint>
 8d6:	8ba6                	mv	s7,s1
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	b5d9                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8dc:	008b8493          	addi	s1,s7,8
 8e0:	4681                	li	a3,0
 8e2:	4629                	li	a2,10
 8e4:	000ba583          	lw	a1,0(s7)
 8e8:	855a                	mv	a0,s6
 8ea:	dd7ff0ef          	jal	6c0 <printint>
        i += 1;
 8ee:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8f0:	8ba6                	mv	s7,s1
      state = 0;
 8f2:	4981                	li	s3,0
        i += 1;
 8f4:	b575                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8f6:	008b8493          	addi	s1,s7,8
 8fa:	4681                	li	a3,0
 8fc:	4629                	li	a2,10
 8fe:	000ba583          	lw	a1,0(s7)
 902:	855a                	mv	a0,s6
 904:	dbdff0ef          	jal	6c0 <printint>
        i += 2;
 908:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 90a:	8ba6                	mv	s7,s1
      state = 0;
 90c:	4981                	li	s3,0
        i += 2;
 90e:	bd49                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 910:	008b8493          	addi	s1,s7,8
 914:	4681                	li	a3,0
 916:	4641                	li	a2,16
 918:	000ba583          	lw	a1,0(s7)
 91c:	855a                	mv	a0,s6
 91e:	da3ff0ef          	jal	6c0 <printint>
 922:	8ba6                	mv	s7,s1
      state = 0;
 924:	4981                	li	s3,0
 926:	bdad                	j	7a0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 928:	008b8493          	addi	s1,s7,8
 92c:	4681                	li	a3,0
 92e:	4641                	li	a2,16
 930:	000ba583          	lw	a1,0(s7)
 934:	855a                	mv	a0,s6
 936:	d8bff0ef          	jal	6c0 <printint>
        i += 1;
 93a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 93c:	8ba6                	mv	s7,s1
      state = 0;
 93e:	4981                	li	s3,0
        i += 1;
 940:	b585                	j	7a0 <vprintf+0x4a>
 942:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 944:	008b8d13          	addi	s10,s7,8
 948:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 94c:	03000593          	li	a1,48
 950:	855a                	mv	a0,s6
 952:	d51ff0ef          	jal	6a2 <putc>
  putc(fd, 'x');
 956:	07800593          	li	a1,120
 95a:	855a                	mv	a0,s6
 95c:	d47ff0ef          	jal	6a2 <putc>
 960:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 962:	00000b97          	auipc	s7,0x0
 966:	2b6b8b93          	addi	s7,s7,694 # c18 <digits>
 96a:	03c9d793          	srli	a5,s3,0x3c
 96e:	97de                	add	a5,a5,s7
 970:	0007c583          	lbu	a1,0(a5)
 974:	855a                	mv	a0,s6
 976:	d2dff0ef          	jal	6a2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 97a:	0992                	slli	s3,s3,0x4
 97c:	34fd                	addiw	s1,s1,-1
 97e:	f4f5                	bnez	s1,96a <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 980:	8bea                	mv	s7,s10
      state = 0;
 982:	4981                	li	s3,0
 984:	6d02                	ld	s10,0(sp)
 986:	bd29                	j	7a0 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 988:	008b8993          	addi	s3,s7,8
 98c:	000bb483          	ld	s1,0(s7)
 990:	cc91                	beqz	s1,9ac <vprintf+0x256>
        for(; *s; s++)
 992:	0004c583          	lbu	a1,0(s1)
 996:	c195                	beqz	a1,9ba <vprintf+0x264>
          putc(fd, *s);
 998:	855a                	mv	a0,s6
 99a:	d09ff0ef          	jal	6a2 <putc>
        for(; *s; s++)
 99e:	0485                	addi	s1,s1,1
 9a0:	0004c583          	lbu	a1,0(s1)
 9a4:	f9f5                	bnez	a1,998 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 9a6:	8bce                	mv	s7,s3
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	bbdd                	j	7a0 <vprintf+0x4a>
          s = "(null)";
 9ac:	00000497          	auipc	s1,0x0
 9b0:	26448493          	addi	s1,s1,612 # c10 <malloc+0x154>
        for(; *s; s++)
 9b4:	02800593          	li	a1,40
 9b8:	b7c5                	j	998 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
 9ba:	8bce                	mv	s7,s3
      state = 0;
 9bc:	4981                	li	s3,0
 9be:	b3cd                	j	7a0 <vprintf+0x4a>
 9c0:	6906                	ld	s2,64(sp)
 9c2:	79e2                	ld	s3,56(sp)
 9c4:	7a42                	ld	s4,48(sp)
 9c6:	7aa2                	ld	s5,40(sp)
 9c8:	7b02                	ld	s6,32(sp)
 9ca:	6be2                	ld	s7,24(sp)
 9cc:	6c42                	ld	s8,16(sp)
 9ce:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9d0:	60e6                	ld	ra,88(sp)
 9d2:	6446                	ld	s0,80(sp)
 9d4:	64a6                	ld	s1,72(sp)
 9d6:	6125                	addi	sp,sp,96
 9d8:	8082                	ret

00000000000009da <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9da:	715d                	addi	sp,sp,-80
 9dc:	ec06                	sd	ra,24(sp)
 9de:	e822                	sd	s0,16(sp)
 9e0:	1000                	addi	s0,sp,32
 9e2:	e010                	sd	a2,0(s0)
 9e4:	e414                	sd	a3,8(s0)
 9e6:	e818                	sd	a4,16(s0)
 9e8:	ec1c                	sd	a5,24(s0)
 9ea:	03043023          	sd	a6,32(s0)
 9ee:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9f2:	8622                	mv	a2,s0
 9f4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9f8:	d5fff0ef          	jal	756 <vprintf>
}
 9fc:	60e2                	ld	ra,24(sp)
 9fe:	6442                	ld	s0,16(sp)
 a00:	6161                	addi	sp,sp,80
 a02:	8082                	ret

0000000000000a04 <printf>:

void
printf(const char *fmt, ...)
{
 a04:	711d                	addi	sp,sp,-96
 a06:	ec06                	sd	ra,24(sp)
 a08:	e822                	sd	s0,16(sp)
 a0a:	1000                	addi	s0,sp,32
 a0c:	e40c                	sd	a1,8(s0)
 a0e:	e810                	sd	a2,16(s0)
 a10:	ec14                	sd	a3,24(s0)
 a12:	f018                	sd	a4,32(s0)
 a14:	f41c                	sd	a5,40(s0)
 a16:	03043823          	sd	a6,48(s0)
 a1a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a1e:	00840613          	addi	a2,s0,8
 a22:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a26:	85aa                	mv	a1,a0
 a28:	4505                	li	a0,1
 a2a:	d2dff0ef          	jal	756 <vprintf>
}
 a2e:	60e2                	ld	ra,24(sp)
 a30:	6442                	ld	s0,16(sp)
 a32:	6125                	addi	sp,sp,96
 a34:	8082                	ret

0000000000000a36 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a36:	1141                	addi	sp,sp,-16
 a38:	e406                	sd	ra,8(sp)
 a3a:	e022                	sd	s0,0(sp)
 a3c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a3e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a42:	00001797          	auipc	a5,0x1
 a46:	5be7b783          	ld	a5,1470(a5) # 2000 <freep>
 a4a:	a02d                	j	a74 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a4c:	4618                	lw	a4,8(a2)
 a4e:	9f2d                	addw	a4,a4,a1
 a50:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a54:	6398                	ld	a4,0(a5)
 a56:	6310                	ld	a2,0(a4)
 a58:	a83d                	j	a96 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a5a:	ff852703          	lw	a4,-8(a0)
 a5e:	9f31                	addw	a4,a4,a2
 a60:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a62:	ff053683          	ld	a3,-16(a0)
 a66:	a091                	j	aaa <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a68:	6398                	ld	a4,0(a5)
 a6a:	00e7e463          	bltu	a5,a4,a72 <free+0x3c>
 a6e:	00e6ea63          	bltu	a3,a4,a82 <free+0x4c>
{
 a72:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a74:	fed7fae3          	bgeu	a5,a3,a68 <free+0x32>
 a78:	6398                	ld	a4,0(a5)
 a7a:	00e6e463          	bltu	a3,a4,a82 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a7e:	fee7eae3          	bltu	a5,a4,a72 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 a82:	ff852583          	lw	a1,-8(a0)
 a86:	6390                	ld	a2,0(a5)
 a88:	02059813          	slli	a6,a1,0x20
 a8c:	01c85713          	srli	a4,a6,0x1c
 a90:	9736                	add	a4,a4,a3
 a92:	fae60de3          	beq	a2,a4,a4c <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 a96:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a9a:	4790                	lw	a2,8(a5)
 a9c:	02061593          	slli	a1,a2,0x20
 aa0:	01c5d713          	srli	a4,a1,0x1c
 aa4:	973e                	add	a4,a4,a5
 aa6:	fae68ae3          	beq	a3,a4,a5a <free+0x24>
    p->s.ptr = bp->s.ptr;
 aaa:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 aac:	00001717          	auipc	a4,0x1
 ab0:	54f73a23          	sd	a5,1364(a4) # 2000 <freep>
}
 ab4:	60a2                	ld	ra,8(sp)
 ab6:	6402                	ld	s0,0(sp)
 ab8:	0141                	addi	sp,sp,16
 aba:	8082                	ret

0000000000000abc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 abc:	7139                	addi	sp,sp,-64
 abe:	fc06                	sd	ra,56(sp)
 ac0:	f822                	sd	s0,48(sp)
 ac2:	f04a                	sd	s2,32(sp)
 ac4:	ec4e                	sd	s3,24(sp)
 ac6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ac8:	02051993          	slli	s3,a0,0x20
 acc:	0209d993          	srli	s3,s3,0x20
 ad0:	09bd                	addi	s3,s3,15
 ad2:	0049d993          	srli	s3,s3,0x4
 ad6:	2985                	addiw	s3,s3,1
 ad8:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 ada:	00001517          	auipc	a0,0x1
 ade:	52653503          	ld	a0,1318(a0) # 2000 <freep>
 ae2:	c905                	beqz	a0,b12 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae6:	4798                	lw	a4,8(a5)
 ae8:	09377663          	bgeu	a4,s3,b74 <malloc+0xb8>
 aec:	f426                	sd	s1,40(sp)
 aee:	e852                	sd	s4,16(sp)
 af0:	e456                	sd	s5,8(sp)
 af2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 af4:	8a4e                	mv	s4,s3
 af6:	6705                	lui	a4,0x1
 af8:	00e9f363          	bgeu	s3,a4,afe <malloc+0x42>
 afc:	6a05                	lui	s4,0x1
 afe:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b02:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b06:	00001497          	auipc	s1,0x1
 b0a:	4fa48493          	addi	s1,s1,1274 # 2000 <freep>
  if(p == (char*)-1)
 b0e:	5afd                	li	s5,-1
 b10:	a83d                	j	b4e <malloc+0x92>
 b12:	f426                	sd	s1,40(sp)
 b14:	e852                	sd	s4,16(sp)
 b16:	e456                	sd	s5,8(sp)
 b18:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b1a:	00001797          	auipc	a5,0x1
 b1e:	50678793          	addi	a5,a5,1286 # 2020 <base>
 b22:	00001717          	auipc	a4,0x1
 b26:	4cf73f23          	sd	a5,1246(a4) # 2000 <freep>
 b2a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b2c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b30:	b7d1                	j	af4 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 b32:	6398                	ld	a4,0(a5)
 b34:	e118                	sd	a4,0(a0)
 b36:	a899                	j	b8c <malloc+0xd0>
  hp->s.size = nu;
 b38:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b3c:	0541                	addi	a0,a0,16
 b3e:	ef9ff0ef          	jal	a36 <free>
  return freep;
 b42:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 b44:	c125                	beqz	a0,ba4 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b46:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b48:	4798                	lw	a4,8(a5)
 b4a:	03277163          	bgeu	a4,s2,b6c <malloc+0xb0>
    if(p == freep)
 b4e:	6098                	ld	a4,0(s1)
 b50:	853e                	mv	a0,a5
 b52:	fef71ae3          	bne	a4,a5,b46 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 b56:	8552                	mv	a0,s4
 b58:	b2bff0ef          	jal	682 <sbrk>
  if(p == (char*)-1)
 b5c:	fd551ee3          	bne	a0,s5,b38 <malloc+0x7c>
        return 0;
 b60:	4501                	li	a0,0
 b62:	74a2                	ld	s1,40(sp)
 b64:	6a42                	ld	s4,16(sp)
 b66:	6aa2                	ld	s5,8(sp)
 b68:	6b02                	ld	s6,0(sp)
 b6a:	a03d                	j	b98 <malloc+0xdc>
 b6c:	74a2                	ld	s1,40(sp)
 b6e:	6a42                	ld	s4,16(sp)
 b70:	6aa2                	ld	s5,8(sp)
 b72:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b74:	fae90fe3          	beq	s2,a4,b32 <malloc+0x76>
        p->s.size -= nunits;
 b78:	4137073b          	subw	a4,a4,s3
 b7c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b7e:	02071693          	slli	a3,a4,0x20
 b82:	01c6d713          	srli	a4,a3,0x1c
 b86:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b88:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b8c:	00001717          	auipc	a4,0x1
 b90:	46a73a23          	sd	a0,1140(a4) # 2000 <freep>
      return (void*)(p + 1);
 b94:	01078513          	addi	a0,a5,16
  }
}
 b98:	70e2                	ld	ra,56(sp)
 b9a:	7442                	ld	s0,48(sp)
 b9c:	7902                	ld	s2,32(sp)
 b9e:	69e2                	ld	s3,24(sp)
 ba0:	6121                	addi	sp,sp,64
 ba2:	8082                	ret
 ba4:	74a2                	ld	s1,40(sp)
 ba6:	6a42                	ld	s4,16(sp)
 ba8:	6aa2                	ld	s5,8(sp)
 baa:	6b02                	ld	s6,0(sp)
 bac:	b7f5                	j	b98 <malloc+0xdc>
