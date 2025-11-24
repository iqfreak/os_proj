
user/_mv:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <strcat>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

char *strcat(char *dst, const char *src)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
   6:	00054783          	lbu	a5,0(a0)
   a:	c78d                	beqz	a5,34 <strcat+0x34>
  char *p = dst;
   c:	87aa                	mv	a5,a0
    p++;
   e:	0785                	addi	a5,a5,1
  while (*p)
  10:	0007c703          	lbu	a4,0(a5)
  14:	ff6d                	bnez	a4,e <strcat+0xe>

  // copy src into dst starting at the end
  while (*src)
  16:	0005c703          	lbu	a4,0(a1)
  1a:	cb01                	beqz	a4,2a <strcat+0x2a>
  {
    *p = *src;
  1c:	00e78023          	sb	a4,0(a5)
    p++;
  20:	0785                	addi	a5,a5,1
    src++;
  22:	0585                	addi	a1,a1,1
  while (*src)
  24:	0005c703          	lbu	a4,0(a1)
  28:	fb75                	bnez	a4,1c <strcat+0x1c>
  }

  *p = 0;
  2a:	00078023          	sb	zero,0(a5)

  return dst;
}
  2e:	6422                	ld	s0,8(sp)
  30:	0141                	addi	sp,sp,16
  32:	8082                	ret
  char *p = dst;
  34:	87aa                	mv	a5,a0
  36:	b7c5                	j	16 <strcat+0x16>

0000000000000038 <is_dir>:

int is_dir(char *path)
{
  38:	7179                	addi	sp,sp,-48
  3a:	f406                	sd	ra,40(sp)
  3c:	f022                	sd	s0,32(sp)
  3e:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
  40:	fd840593          	addi	a1,s0,-40
  44:	2fe000ef          	jal	342 <stat>
  48:	00054b63          	bltz	a0,5e <is_dir+0x26>
    return 0;
  return st.type == T_DIR;
  4c:	fe041503          	lh	a0,-32(s0)
  50:	157d                	addi	a0,a0,-1
  52:	00153513          	seqz	a0,a0
}
  56:	70a2                	ld	ra,40(sp)
  58:	7402                	ld	s0,32(sp)
  5a:	6145                	addi	sp,sp,48
  5c:	8082                	ret
    return 0;
  5e:	4501                	li	a0,0
  60:	bfdd                	j	56 <is_dir+0x1e>

0000000000000062 <join_path>:

char *join_path(char *dir, char *filename, char *out_buffer, int bufsize)
{
  62:	7139                	addi	sp,sp,-64
  64:	fc06                	sd	ra,56(sp)
  66:	f822                	sd	s0,48(sp)
  68:	f426                	sd	s1,40(sp)
  6a:	f04a                	sd	s2,32(sp)
  6c:	ec4e                	sd	s3,24(sp)
  6e:	e852                	sd	s4,16(sp)
  70:	e456                	sd	s5,8(sp)
  72:	0080                	addi	s0,sp,64
  74:	89aa                	mv	s3,a0
  76:	8aae                	mv	s5,a1
  78:	84b2                	mv	s1,a2
  7a:	8a36                	mv	s4,a3
  int dn = strlen(dir);
  7c:	1e6000ef          	jal	262 <strlen>
  80:	0005091b          	sext.w	s2,a0
  int nn = strlen(filename);
  84:	8556                	mv	a0,s5
  86:	1dc000ef          	jal	262 <strlen>
  int need = dn + 1 + nn + 1;
  8a:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
  8e:	9fa9                	addw	a5,a5,a0
    return 0;
  90:	4501                	li	a0,0
  if (need > bufsize)
  92:	0347d763          	bge	a5,s4,c0 <join_path+0x5e>
  strcpy(out_buffer, dir);
  96:	85ce                	mv	a1,s3
  98:	8526                	mv	a0,s1
  9a:	180000ef          	jal	21a <strcpy>
  if (dir[dn - 1] != '/')
  9e:	99ca                	add	s3,s3,s2
  a0:	fff9c703          	lbu	a4,-1(s3)
  a4:	02f00793          	li	a5,47
  a8:	00f70763          	beq	a4,a5,b6 <join_path+0x54>
  {
    out_buffer[dn] = '/';
  ac:	9926                	add	s2,s2,s1
  ae:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
  b2:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
  b6:	85d6                	mv	a1,s5
  b8:	8526                	mv	a0,s1
  ba:	f47ff0ef          	jal	0 <strcat>
  return out_buffer;
  be:	8526                	mv	a0,s1
}
  c0:	70e2                	ld	ra,56(sp)
  c2:	7442                	ld	s0,48(sp)
  c4:	74a2                	ld	s1,40(sp)
  c6:	7902                	ld	s2,32(sp)
  c8:	69e2                	ld	s3,24(sp)
  ca:	6a42                	ld	s4,16(sp)
  cc:	6aa2                	ld	s5,8(sp)
  ce:	6121                	addi	sp,sp,64
  d0:	8082                	ret

00000000000000d2 <main>:

/*mv src dst*/
int main(int argc, char *argv[])
{
  d2:	dd010113          	addi	sp,sp,-560
  d6:	22113423          	sd	ra,552(sp)
  da:	22813023          	sd	s0,544(sp)
  de:	1c00                	addi	s0,sp,560
  if (argc != 3)
  e0:	478d                	li	a5,3
  e2:	02f50463          	beq	a0,a5,10a <main+0x38>
  e6:	20913c23          	sd	s1,536(sp)
  ea:	21213823          	sd	s2,528(sp)
  ee:	21313423          	sd	s3,520(sp)
  f2:	21413023          	sd	s4,512(sp)
  {
    fprintf(2, "mv: Incorrect usage, mv src dst\n");
  f6:	00001597          	auipc	a1,0x1
  fa:	94a58593          	addi	a1,a1,-1718 # a40 <malloc+0x102>
  fe:	4509                	li	a0,2
 100:	760000ef          	jal	860 <fprintf>
    exit(1);
 104:	4505                	li	a0,1
 106:	36c000ef          	jal	472 <exit>
 10a:	20913c23          	sd	s1,536(sp)
 10e:	21213823          	sd	s2,528(sp)
 112:	21313423          	sd	s3,520(sp)
 116:	21413023          	sd	s4,512(sp)
 11a:	84ae                	mv	s1,a1
  }

  char *src = argv[1];
 11c:	0085b903          	ld	s2,8(a1)
  int is_src_dir = is_dir(src);
 120:	854a                	mv	a0,s2
 122:	f17ff0ef          	jal	38 <is_dir>
 126:	89aa                	mv	s3,a0
  char *dst = argv[2];
 128:	0104ba03          	ld	s4,16(s1)
  int is_dst_dir = is_dir(dst);
 12c:	8552                	mv	a0,s4
 12e:	f0bff0ef          	jal	38 <is_dir>
 132:	84aa                	mv	s1,a0

  char dst_path[500];
  strcpy(dst_path, dst);
 134:	85d2                	mv	a1,s4
 136:	dd840513          	addi	a0,s0,-552
 13a:	0e0000ef          	jal	21a <strcpy>
  char *filename = src;

  // Dir to dir
  if (is_src_dir)
 13e:	02099a63          	bnez	s3,172 <main+0xa0>
  {
    printf("mv: direcotry to directory isn't implemented yet\n");
    exit(0);
  }

  for (char *p = src; *p; p++)
 142:	00094703          	lbu	a4,0(s2)
 146:	00190793          	addi	a5,s2,1
  char *filename = src;
 14a:	89ca                	mv	s3,s2
  {
    if (*p == '/')
 14c:	02f00693          	li	a3,47
  for (char *p = src; *p; p++)
 150:	ef15                	bnez	a4,18c <main+0xba>
      filename = p + 1;
  }

  // File to File
  if (!is_src_dir && is_dst_dir)
 152:	e0a9                	bnez	s1,194 <main+0xc2>
  {
    join_path(dst, filename, dst_path, sizeof(dst_path));
    printf("New path: %s, %s\n", filename, dst_path);
  }

  if (link(src, dst_path) < 0)
 154:	dd840593          	addi	a1,s0,-552
 158:	854a                	mv	a0,s2
 15a:	378000ef          	jal	4d2 <link>
 15e:	04054d63          	bltz	a0,1b8 <main+0xe6>
  {
    fprintf(2, "mv: link src %s to dst %s failed\n", src, dst_path);
    exit(1);
  }

  if (unlink(src) < 0)
 162:	854a                	mv	a0,s2
 164:	35e000ef          	jal	4c2 <unlink>
 168:	06054563          	bltz	a0,1d2 <main+0x100>
      fprintf(2, "mv: rollback failed for %s\n", dst_path);
    }
    exit(1);
  }

  exit(0);
 16c:	4501                	li	a0,0
 16e:	304000ef          	jal	472 <exit>
    printf("mv: direcotry to directory isn't implemented yet\n");
 172:	00001517          	auipc	a0,0x1
 176:	8f650513          	addi	a0,a0,-1802 # a68 <malloc+0x12a>
 17a:	710000ef          	jal	88a <printf>
    exit(0);
 17e:	4501                	li	a0,0
 180:	2f2000ef          	jal	472 <exit>
  for (char *p = src; *p; p++)
 184:	0785                	addi	a5,a5,1
 186:	fff7c703          	lbu	a4,-1(a5)
 18a:	d761                	beqz	a4,152 <main+0x80>
    if (*p == '/')
 18c:	fed71ce3          	bne	a4,a3,184 <main+0xb2>
      filename = p + 1;
 190:	89be                	mv	s3,a5
 192:	bfcd                	j	184 <main+0xb2>
    join_path(dst, filename, dst_path, sizeof(dst_path));
 194:	1f400693          	li	a3,500
 198:	dd840613          	addi	a2,s0,-552
 19c:	85ce                	mv	a1,s3
 19e:	8552                	mv	a0,s4
 1a0:	ec3ff0ef          	jal	62 <join_path>
    printf("New path: %s, %s\n", filename, dst_path);
 1a4:	dd840613          	addi	a2,s0,-552
 1a8:	85ce                	mv	a1,s3
 1aa:	00001517          	auipc	a0,0x1
 1ae:	8f650513          	addi	a0,a0,-1802 # aa0 <malloc+0x162>
 1b2:	6d8000ef          	jal	88a <printf>
 1b6:	bf79                	j	154 <main+0x82>
    fprintf(2, "mv: link src %s to dst %s failed\n", src, dst_path);
 1b8:	dd840693          	addi	a3,s0,-552
 1bc:	864a                	mv	a2,s2
 1be:	00001597          	auipc	a1,0x1
 1c2:	8fa58593          	addi	a1,a1,-1798 # ab8 <malloc+0x17a>
 1c6:	4509                	li	a0,2
 1c8:	698000ef          	jal	860 <fprintf>
    exit(1);
 1cc:	4505                	li	a0,1
 1ce:	2a4000ef          	jal	472 <exit>
    fprintf(2, "mv: unlink %s failed\n", src);
 1d2:	864a                	mv	a2,s2
 1d4:	00001597          	auipc	a1,0x1
 1d8:	90c58593          	addi	a1,a1,-1780 # ae0 <malloc+0x1a2>
 1dc:	4509                	li	a0,2
 1de:	682000ef          	jal	860 <fprintf>
    if (unlink(dst_path) < 0)
 1e2:	dd840513          	addi	a0,s0,-552
 1e6:	2dc000ef          	jal	4c2 <unlink>
 1ea:	00054563          	bltz	a0,1f4 <main+0x122>
    exit(1);
 1ee:	4505                	li	a0,1
 1f0:	282000ef          	jal	472 <exit>
      fprintf(2, "mv: rollback failed for %s\n", dst_path);
 1f4:	dd840613          	addi	a2,s0,-552
 1f8:	00001597          	auipc	a1,0x1
 1fc:	90058593          	addi	a1,a1,-1792 # af8 <malloc+0x1ba>
 200:	4509                	li	a0,2
 202:	65e000ef          	jal	860 <fprintf>
 206:	b7e5                	j	1ee <main+0x11c>

0000000000000208 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 208:	1141                	addi	sp,sp,-16
 20a:	e406                	sd	ra,8(sp)
 20c:	e022                	sd	s0,0(sp)
 20e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 210:	ec3ff0ef          	jal	d2 <main>
  exit(0);
 214:	4501                	li	a0,0
 216:	25c000ef          	jal	472 <exit>

000000000000021a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e422                	sd	s0,8(sp)
 21e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 220:	87aa                	mv	a5,a0
 222:	0585                	addi	a1,a1,1
 224:	0785                	addi	a5,a5,1
 226:	fff5c703          	lbu	a4,-1(a1)
 22a:	fee78fa3          	sb	a4,-1(a5)
 22e:	fb75                	bnez	a4,222 <strcpy+0x8>
    ;
  return os;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret

0000000000000236 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cb91                	beqz	a5,254 <strcmp+0x1e>
 242:	0005c703          	lbu	a4,0(a1)
 246:	00f71763          	bne	a4,a5,254 <strcmp+0x1e>
    p++, q++;
 24a:	0505                	addi	a0,a0,1
 24c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 24e:	00054783          	lbu	a5,0(a0)
 252:	fbe5                	bnez	a5,242 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 254:	0005c503          	lbu	a0,0(a1)
}
 258:	40a7853b          	subw	a0,a5,a0
 25c:	6422                	ld	s0,8(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret

0000000000000262 <strlen>:

uint
strlen(const char *s)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 268:	00054783          	lbu	a5,0(a0)
 26c:	cf91                	beqz	a5,288 <strlen+0x26>
 26e:	0505                	addi	a0,a0,1
 270:	87aa                	mv	a5,a0
 272:	86be                	mv	a3,a5
 274:	0785                	addi	a5,a5,1
 276:	fff7c703          	lbu	a4,-1(a5)
 27a:	ff65                	bnez	a4,272 <strlen+0x10>
 27c:	40a6853b          	subw	a0,a3,a0
 280:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret
  for(n = 0; s[n]; n++)
 288:	4501                	li	a0,0
 28a:	bfe5                	j	282 <strlen+0x20>

000000000000028c <memset>:

void*
memset(void *dst, int c, uint n)
{
 28c:	1141                	addi	sp,sp,-16
 28e:	e422                	sd	s0,8(sp)
 290:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 292:	ca19                	beqz	a2,2a8 <memset+0x1c>
 294:	87aa                	mv	a5,a0
 296:	1602                	slli	a2,a2,0x20
 298:	9201                	srli	a2,a2,0x20
 29a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 29e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2a2:	0785                	addi	a5,a5,1
 2a4:	fee79de3          	bne	a5,a4,29e <memset+0x12>
  }
  return dst;
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <strchr>:

char*
strchr(const char *s, char c)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2b4:	00054783          	lbu	a5,0(a0)
 2b8:	cb99                	beqz	a5,2ce <strchr+0x20>
    if(*s == c)
 2ba:	00f58763          	beq	a1,a5,2c8 <strchr+0x1a>
  for(; *s; s++)
 2be:	0505                	addi	a0,a0,1
 2c0:	00054783          	lbu	a5,0(a0)
 2c4:	fbfd                	bnez	a5,2ba <strchr+0xc>
      return (char*)s;
  return 0;
 2c6:	4501                	li	a0,0
}
 2c8:	6422                	ld	s0,8(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret
  return 0;
 2ce:	4501                	li	a0,0
 2d0:	bfe5                	j	2c8 <strchr+0x1a>

00000000000002d2 <gets>:

char*
gets(char *buf, int max)
{
 2d2:	711d                	addi	sp,sp,-96
 2d4:	ec86                	sd	ra,88(sp)
 2d6:	e8a2                	sd	s0,80(sp)
 2d8:	e4a6                	sd	s1,72(sp)
 2da:	e0ca                	sd	s2,64(sp)
 2dc:	fc4e                	sd	s3,56(sp)
 2de:	f852                	sd	s4,48(sp)
 2e0:	f456                	sd	s5,40(sp)
 2e2:	f05a                	sd	s6,32(sp)
 2e4:	ec5e                	sd	s7,24(sp)
 2e6:	1080                	addi	s0,sp,96
 2e8:	8baa                	mv	s7,a0
 2ea:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ec:	892a                	mv	s2,a0
 2ee:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2f0:	4aa9                	li	s5,10
 2f2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 2f4:	89a6                	mv	s3,s1
 2f6:	2485                	addiw	s1,s1,1
 2f8:	0344d663          	bge	s1,s4,324 <gets+0x52>
    cc = read(0, &c, 1);
 2fc:	4605                	li	a2,1
 2fe:	faf40593          	addi	a1,s0,-81
 302:	4501                	li	a0,0
 304:	186000ef          	jal	48a <read>
    if(cc < 1)
 308:	00a05e63          	blez	a0,324 <gets+0x52>
    buf[i++] = c;
 30c:	faf44783          	lbu	a5,-81(s0)
 310:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 314:	01578763          	beq	a5,s5,322 <gets+0x50>
 318:	0905                	addi	s2,s2,1
 31a:	fd679de3          	bne	a5,s6,2f4 <gets+0x22>
    buf[i++] = c;
 31e:	89a6                	mv	s3,s1
 320:	a011                	j	324 <gets+0x52>
 322:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 324:	99de                	add	s3,s3,s7
 326:	00098023          	sb	zero,0(s3)
  return buf;
}
 32a:	855e                	mv	a0,s7
 32c:	60e6                	ld	ra,88(sp)
 32e:	6446                	ld	s0,80(sp)
 330:	64a6                	ld	s1,72(sp)
 332:	6906                	ld	s2,64(sp)
 334:	79e2                	ld	s3,56(sp)
 336:	7a42                	ld	s4,48(sp)
 338:	7aa2                	ld	s5,40(sp)
 33a:	7b02                	ld	s6,32(sp)
 33c:	6be2                	ld	s7,24(sp)
 33e:	6125                	addi	sp,sp,96
 340:	8082                	ret

0000000000000342 <stat>:

int
stat(const char *n, struct stat *st)
{
 342:	1101                	addi	sp,sp,-32
 344:	ec06                	sd	ra,24(sp)
 346:	e822                	sd	s0,16(sp)
 348:	e04a                	sd	s2,0(sp)
 34a:	1000                	addi	s0,sp,32
 34c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 34e:	4581                	li	a1,0
 350:	162000ef          	jal	4b2 <open>
  if(fd < 0)
 354:	02054263          	bltz	a0,378 <stat+0x36>
 358:	e426                	sd	s1,8(sp)
 35a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 35c:	85ca                	mv	a1,s2
 35e:	16c000ef          	jal	4ca <fstat>
 362:	892a                	mv	s2,a0
  close(fd);
 364:	8526                	mv	a0,s1
 366:	134000ef          	jal	49a <close>
  return r;
 36a:	64a2                	ld	s1,8(sp)
}
 36c:	854a                	mv	a0,s2
 36e:	60e2                	ld	ra,24(sp)
 370:	6442                	ld	s0,16(sp)
 372:	6902                	ld	s2,0(sp)
 374:	6105                	addi	sp,sp,32
 376:	8082                	ret
    return -1;
 378:	597d                	li	s2,-1
 37a:	bfcd                	j	36c <stat+0x2a>

000000000000037c <atoi>:

int
atoi(const char *s)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 382:	00054683          	lbu	a3,0(a0)
 386:	fd06879b          	addiw	a5,a3,-48
 38a:	0ff7f793          	zext.b	a5,a5
 38e:	4625                	li	a2,9
 390:	02f66863          	bltu	a2,a5,3c0 <atoi+0x44>
 394:	872a                	mv	a4,a0
  n = 0;
 396:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 398:	0705                	addi	a4,a4,1
 39a:	0025179b          	slliw	a5,a0,0x2
 39e:	9fa9                	addw	a5,a5,a0
 3a0:	0017979b          	slliw	a5,a5,0x1
 3a4:	9fb5                	addw	a5,a5,a3
 3a6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3aa:	00074683          	lbu	a3,0(a4)
 3ae:	fd06879b          	addiw	a5,a3,-48
 3b2:	0ff7f793          	zext.b	a5,a5
 3b6:	fef671e3          	bgeu	a2,a5,398 <atoi+0x1c>
  return n;
}
 3ba:	6422                	ld	s0,8(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
  n = 0;
 3c0:	4501                	li	a0,0
 3c2:	bfe5                	j	3ba <atoi+0x3e>

00000000000003c4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e422                	sd	s0,8(sp)
 3c8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3ca:	02b57463          	bgeu	a0,a1,3f2 <memmove+0x2e>
    while(n-- > 0)
 3ce:	00c05f63          	blez	a2,3ec <memmove+0x28>
 3d2:	1602                	slli	a2,a2,0x20
 3d4:	9201                	srli	a2,a2,0x20
 3d6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3da:	872a                	mv	a4,a0
      *dst++ = *src++;
 3dc:	0585                	addi	a1,a1,1
 3de:	0705                	addi	a4,a4,1
 3e0:	fff5c683          	lbu	a3,-1(a1)
 3e4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3e8:	fef71ae3          	bne	a4,a5,3dc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3ec:	6422                	ld	s0,8(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret
    dst += n;
 3f2:	00c50733          	add	a4,a0,a2
    src += n;
 3f6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3f8:	fec05ae3          	blez	a2,3ec <memmove+0x28>
 3fc:	fff6079b          	addiw	a5,a2,-1
 400:	1782                	slli	a5,a5,0x20
 402:	9381                	srli	a5,a5,0x20
 404:	fff7c793          	not	a5,a5
 408:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 40a:	15fd                	addi	a1,a1,-1
 40c:	177d                	addi	a4,a4,-1
 40e:	0005c683          	lbu	a3,0(a1)
 412:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 416:	fee79ae3          	bne	a5,a4,40a <memmove+0x46>
 41a:	bfc9                	j	3ec <memmove+0x28>

000000000000041c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 41c:	1141                	addi	sp,sp,-16
 41e:	e422                	sd	s0,8(sp)
 420:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 422:	ca05                	beqz	a2,452 <memcmp+0x36>
 424:	fff6069b          	addiw	a3,a2,-1
 428:	1682                	slli	a3,a3,0x20
 42a:	9281                	srli	a3,a3,0x20
 42c:	0685                	addi	a3,a3,1
 42e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 430:	00054783          	lbu	a5,0(a0)
 434:	0005c703          	lbu	a4,0(a1)
 438:	00e79863          	bne	a5,a4,448 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 43c:	0505                	addi	a0,a0,1
    p2++;
 43e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 440:	fed518e3          	bne	a0,a3,430 <memcmp+0x14>
  }
  return 0;
 444:	4501                	li	a0,0
 446:	a019                	j	44c <memcmp+0x30>
      return *p1 - *p2;
 448:	40e7853b          	subw	a0,a5,a4
}
 44c:	6422                	ld	s0,8(sp)
 44e:	0141                	addi	sp,sp,16
 450:	8082                	ret
  return 0;
 452:	4501                	li	a0,0
 454:	bfe5                	j	44c <memcmp+0x30>

0000000000000456 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 456:	1141                	addi	sp,sp,-16
 458:	e406                	sd	ra,8(sp)
 45a:	e022                	sd	s0,0(sp)
 45c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 45e:	f67ff0ef          	jal	3c4 <memmove>
}
 462:	60a2                	ld	ra,8(sp)
 464:	6402                	ld	s0,0(sp)
 466:	0141                	addi	sp,sp,16
 468:	8082                	ret

000000000000046a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 46a:	4885                	li	a7,1
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <exit>:
.global exit
exit:
 li a7, SYS_exit
 472:	4889                	li	a7,2
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <wait>:
.global wait
wait:
 li a7, SYS_wait
 47a:	488d                	li	a7,3
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 482:	4891                	li	a7,4
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <read>:
.global read
read:
 li a7, SYS_read
 48a:	4895                	li	a7,5
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <write>:
.global write
write:
 li a7, SYS_write
 492:	48c1                	li	a7,16
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <close>:
.global close
close:
 li a7, SYS_close
 49a:	48d5                	li	a7,21
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4a2:	4899                	li	a7,6
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <exec>:
.global exec
exec:
 li a7, SYS_exec
 4aa:	489d                	li	a7,7
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <open>:
.global open
open:
 li a7, SYS_open
 4b2:	48bd                	li	a7,15
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4ba:	48c5                	li	a7,17
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4c2:	48c9                	li	a7,18
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4ca:	48a1                	li	a7,8
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <link>:
.global link
link:
 li a7, SYS_link
 4d2:	48cd                	li	a7,19
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4da:	48d1                	li	a7,20
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4e2:	48a5                	li	a7,9
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ea:	48a9                	li	a7,10
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4f2:	48ad                	li	a7,11
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4fa:	48b1                	li	a7,12
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 502:	48b5                	li	a7,13
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 50a:	48b9                	li	a7,14
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 512:	1101                	addi	sp,sp,-32
 514:	ec06                	sd	ra,24(sp)
 516:	e822                	sd	s0,16(sp)
 518:	1000                	addi	s0,sp,32
 51a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 51e:	4605                	li	a2,1
 520:	fef40593          	addi	a1,s0,-17
 524:	f6fff0ef          	jal	492 <write>
}
 528:	60e2                	ld	ra,24(sp)
 52a:	6442                	ld	s0,16(sp)
 52c:	6105                	addi	sp,sp,32
 52e:	8082                	ret

0000000000000530 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	7139                	addi	sp,sp,-64
 532:	fc06                	sd	ra,56(sp)
 534:	f822                	sd	s0,48(sp)
 536:	f426                	sd	s1,40(sp)
 538:	0080                	addi	s0,sp,64
 53a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53c:	c299                	beqz	a3,542 <printint+0x12>
 53e:	0805c963          	bltz	a1,5d0 <printint+0xa0>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 542:	2581                	sext.w	a1,a1
  neg = 0;
 544:	4881                	li	a7,0
 546:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 54a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 54c:	2601                	sext.w	a2,a2
 54e:	00000517          	auipc	a0,0x0
 552:	5d250513          	addi	a0,a0,1490 # b20 <digits>
 556:	883a                	mv	a6,a4
 558:	2705                	addiw	a4,a4,1
 55a:	02c5f7bb          	remuw	a5,a1,a2
 55e:	1782                	slli	a5,a5,0x20
 560:	9381                	srli	a5,a5,0x20
 562:	97aa                	add	a5,a5,a0
 564:	0007c783          	lbu	a5,0(a5)
 568:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 56c:	0005879b          	sext.w	a5,a1
 570:	02c5d5bb          	divuw	a1,a1,a2
 574:	0685                	addi	a3,a3,1
 576:	fec7f0e3          	bgeu	a5,a2,556 <printint+0x26>
  if(neg)
 57a:	00088c63          	beqz	a7,592 <printint+0x62>
    buf[i++] = '-';
 57e:	fd070793          	addi	a5,a4,-48
 582:	00878733          	add	a4,a5,s0
 586:	02d00793          	li	a5,45
 58a:	fef70823          	sb	a5,-16(a4)
 58e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 592:	02e05a63          	blez	a4,5c6 <printint+0x96>
 596:	f04a                	sd	s2,32(sp)
 598:	ec4e                	sd	s3,24(sp)
 59a:	fc040793          	addi	a5,s0,-64
 59e:	00e78933          	add	s2,a5,a4
 5a2:	fff78993          	addi	s3,a5,-1
 5a6:	99ba                	add	s3,s3,a4
 5a8:	377d                	addiw	a4,a4,-1
 5aa:	1702                	slli	a4,a4,0x20
 5ac:	9301                	srli	a4,a4,0x20
 5ae:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 5b2:	fff94583          	lbu	a1,-1(s2)
 5b6:	8526                	mv	a0,s1
 5b8:	f5bff0ef          	jal	512 <putc>
  while(--i >= 0)
 5bc:	197d                	addi	s2,s2,-1
 5be:	ff391ae3          	bne	s2,s3,5b2 <printint+0x82>
 5c2:	7902                	ld	s2,32(sp)
 5c4:	69e2                	ld	s3,24(sp)
}
 5c6:	70e2                	ld	ra,56(sp)
 5c8:	7442                	ld	s0,48(sp)
 5ca:	74a2                	ld	s1,40(sp)
 5cc:	6121                	addi	sp,sp,64
 5ce:	8082                	ret
    x = -xx;
 5d0:	40b005bb          	negw	a1,a1
    neg = 1;
 5d4:	4885                	li	a7,1
    x = -xx;
 5d6:	bf85                	j	546 <printint+0x16>

00000000000005d8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5d8:	711d                	addi	sp,sp,-96
 5da:	ec86                	sd	ra,88(sp)
 5dc:	e8a2                	sd	s0,80(sp)
 5de:	e0ca                	sd	s2,64(sp)
 5e0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5e2:	0005c903          	lbu	s2,0(a1)
 5e6:	26090863          	beqz	s2,856 <vprintf+0x27e>
 5ea:	e4a6                	sd	s1,72(sp)
 5ec:	fc4e                	sd	s3,56(sp)
 5ee:	f852                	sd	s4,48(sp)
 5f0:	f456                	sd	s5,40(sp)
 5f2:	f05a                	sd	s6,32(sp)
 5f4:	ec5e                	sd	s7,24(sp)
 5f6:	e862                	sd	s8,16(sp)
 5f8:	e466                	sd	s9,8(sp)
 5fa:	8b2a                	mv	s6,a0
 5fc:	8a2e                	mv	s4,a1
 5fe:	8bb2                	mv	s7,a2
  state = 0;
 600:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 602:	4481                	li	s1,0
 604:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 606:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 60a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 60e:	06c00c93          	li	s9,108
 612:	a005                	j	632 <vprintf+0x5a>
        putc(fd, c0);
 614:	85ca                	mv	a1,s2
 616:	855a                	mv	a0,s6
 618:	efbff0ef          	jal	512 <putc>
 61c:	a019                	j	622 <vprintf+0x4a>
    } else if(state == '%'){
 61e:	03598263          	beq	s3,s5,642 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 622:	2485                	addiw	s1,s1,1
 624:	8726                	mv	a4,s1
 626:	009a07b3          	add	a5,s4,s1
 62a:	0007c903          	lbu	s2,0(a5)
 62e:	20090c63          	beqz	s2,846 <vprintf+0x26e>
    c0 = fmt[i] & 0xff;
 632:	0009079b          	sext.w	a5,s2
    if(state == 0){
 636:	fe0994e3          	bnez	s3,61e <vprintf+0x46>
      if(c0 == '%'){
 63a:	fd579de3          	bne	a5,s5,614 <vprintf+0x3c>
        state = '%';
 63e:	89be                	mv	s3,a5
 640:	b7cd                	j	622 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 642:	00ea06b3          	add	a3,s4,a4
 646:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 64a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 64c:	c681                	beqz	a3,654 <vprintf+0x7c>
 64e:	9752                	add	a4,a4,s4
 650:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 654:	03878f63          	beq	a5,s8,692 <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
 658:	05978963          	beq	a5,s9,6aa <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 65c:	07500713          	li	a4,117
 660:	0ee78363          	beq	a5,a4,746 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 664:	07800713          	li	a4,120
 668:	12e78563          	beq	a5,a4,792 <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 66c:	07000713          	li	a4,112
 670:	14e78a63          	beq	a5,a4,7c4 <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
 674:	07300713          	li	a4,115
 678:	18e78a63          	beq	a5,a4,80c <vprintf+0x234>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 67c:	02500713          	li	a4,37
 680:	04e79563          	bne	a5,a4,6ca <vprintf+0xf2>
        putc(fd, '%');
 684:	02500593          	li	a1,37
 688:	855a                	mv	a0,s6
 68a:	e89ff0ef          	jal	512 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
 68e:	4981                	li	s3,0
 690:	bf49                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 692:	008b8913          	addi	s2,s7,8
 696:	4685                	li	a3,1
 698:	4629                	li	a2,10
 69a:	000ba583          	lw	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	e91ff0ef          	jal	530 <printint>
 6a4:	8bca                	mv	s7,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bfad                	j	622 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6aa:	06400793          	li	a5,100
 6ae:	02f68963          	beq	a3,a5,6e0 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6b2:	06c00793          	li	a5,108
 6b6:	04f68263          	beq	a3,a5,6fa <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
 6ba:	07500793          	li	a5,117
 6be:	0af68063          	beq	a3,a5,75e <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
 6c2:	07800793          	li	a5,120
 6c6:	0ef68263          	beq	a3,a5,7aa <vprintf+0x1d2>
        putc(fd, '%');
 6ca:	02500593          	li	a1,37
 6ce:	855a                	mv	a0,s6
 6d0:	e43ff0ef          	jal	512 <putc>
        putc(fd, c0);
 6d4:	85ca                	mv	a1,s2
 6d6:	855a                	mv	a0,s6
 6d8:	e3bff0ef          	jal	512 <putc>
      state = 0;
 6dc:	4981                	li	s3,0
 6de:	b791                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e0:	008b8913          	addi	s2,s7,8
 6e4:	4685                	li	a3,1
 6e6:	4629                	li	a2,10
 6e8:	000ba583          	lw	a1,0(s7)
 6ec:	855a                	mv	a0,s6
 6ee:	e43ff0ef          	jal	530 <printint>
        i += 1;
 6f2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f4:	8bca                	mv	s7,s2
      state = 0;
 6f6:	4981                	li	s3,0
        i += 1;
 6f8:	b72d                	j	622 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6fa:	06400793          	li	a5,100
 6fe:	02f60763          	beq	a2,a5,72c <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 702:	07500793          	li	a5,117
 706:	06f60963          	beq	a2,a5,778 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 70a:	07800793          	li	a5,120
 70e:	faf61ee3          	bne	a2,a5,6ca <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
 712:	008b8913          	addi	s2,s7,8
 716:	4681                	li	a3,0
 718:	4641                	li	a2,16
 71a:	000ba583          	lw	a1,0(s7)
 71e:	855a                	mv	a0,s6
 720:	e11ff0ef          	jal	530 <printint>
        i += 2;
 724:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 726:	8bca                	mv	s7,s2
      state = 0;
 728:	4981                	li	s3,0
        i += 2;
 72a:	bde5                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 72c:	008b8913          	addi	s2,s7,8
 730:	4685                	li	a3,1
 732:	4629                	li	a2,10
 734:	000ba583          	lw	a1,0(s7)
 738:	855a                	mv	a0,s6
 73a:	df7ff0ef          	jal	530 <printint>
        i += 2;
 73e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 740:	8bca                	mv	s7,s2
      state = 0;
 742:	4981                	li	s3,0
        i += 2;
 744:	bdf9                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
 746:	008b8913          	addi	s2,s7,8
 74a:	4681                	li	a3,0
 74c:	4629                	li	a2,10
 74e:	000ba583          	lw	a1,0(s7)
 752:	855a                	mv	a0,s6
 754:	dddff0ef          	jal	530 <printint>
 758:	8bca                	mv	s7,s2
      state = 0;
 75a:	4981                	li	s3,0
 75c:	b5d9                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75e:	008b8913          	addi	s2,s7,8
 762:	4681                	li	a3,0
 764:	4629                	li	a2,10
 766:	000ba583          	lw	a1,0(s7)
 76a:	855a                	mv	a0,s6
 76c:	dc5ff0ef          	jal	530 <printint>
        i += 1;
 770:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 772:	8bca                	mv	s7,s2
      state = 0;
 774:	4981                	li	s3,0
        i += 1;
 776:	b575                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 778:	008b8913          	addi	s2,s7,8
 77c:	4681                	li	a3,0
 77e:	4629                	li	a2,10
 780:	000ba583          	lw	a1,0(s7)
 784:	855a                	mv	a0,s6
 786:	dabff0ef          	jal	530 <printint>
        i += 2;
 78a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 78c:	8bca                	mv	s7,s2
      state = 0;
 78e:	4981                	li	s3,0
        i += 2;
 790:	bd49                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
 792:	008b8913          	addi	s2,s7,8
 796:	4681                	li	a3,0
 798:	4641                	li	a2,16
 79a:	000ba583          	lw	a1,0(s7)
 79e:	855a                	mv	a0,s6
 7a0:	d91ff0ef          	jal	530 <printint>
 7a4:	8bca                	mv	s7,s2
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	bdad                	j	622 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7aa:	008b8913          	addi	s2,s7,8
 7ae:	4681                	li	a3,0
 7b0:	4641                	li	a2,16
 7b2:	000ba583          	lw	a1,0(s7)
 7b6:	855a                	mv	a0,s6
 7b8:	d79ff0ef          	jal	530 <printint>
        i += 1;
 7bc:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7be:	8bca                	mv	s7,s2
      state = 0;
 7c0:	4981                	li	s3,0
        i += 1;
 7c2:	b585                	j	622 <vprintf+0x4a>
 7c4:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7c6:	008b8d13          	addi	s10,s7,8
 7ca:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7ce:	03000593          	li	a1,48
 7d2:	855a                	mv	a0,s6
 7d4:	d3fff0ef          	jal	512 <putc>
  putc(fd, 'x');
 7d8:	07800593          	li	a1,120
 7dc:	855a                	mv	a0,s6
 7de:	d35ff0ef          	jal	512 <putc>
 7e2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7e4:	00000b97          	auipc	s7,0x0
 7e8:	33cb8b93          	addi	s7,s7,828 # b20 <digits>
 7ec:	03c9d793          	srli	a5,s3,0x3c
 7f0:	97de                	add	a5,a5,s7
 7f2:	0007c583          	lbu	a1,0(a5)
 7f6:	855a                	mv	a0,s6
 7f8:	d1bff0ef          	jal	512 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7fc:	0992                	slli	s3,s3,0x4
 7fe:	397d                	addiw	s2,s2,-1
 800:	fe0916e3          	bnez	s2,7ec <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
 804:	8bea                	mv	s7,s10
      state = 0;
 806:	4981                	li	s3,0
 808:	6d02                	ld	s10,0(sp)
 80a:	bd21                	j	622 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 80c:	008b8993          	addi	s3,s7,8
 810:	000bb903          	ld	s2,0(s7)
 814:	00090f63          	beqz	s2,832 <vprintf+0x25a>
        for(; *s; s++)
 818:	00094583          	lbu	a1,0(s2)
 81c:	c195                	beqz	a1,840 <vprintf+0x268>
          putc(fd, *s);
 81e:	855a                	mv	a0,s6
 820:	cf3ff0ef          	jal	512 <putc>
        for(; *s; s++)
 824:	0905                	addi	s2,s2,1
 826:	00094583          	lbu	a1,0(s2)
 82a:	f9f5                	bnez	a1,81e <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 82c:	8bce                	mv	s7,s3
      state = 0;
 82e:	4981                	li	s3,0
 830:	bbcd                	j	622 <vprintf+0x4a>
          s = "(null)";
 832:	00000917          	auipc	s2,0x0
 836:	2e690913          	addi	s2,s2,742 # b18 <malloc+0x1da>
        for(; *s; s++)
 83a:	02800593          	li	a1,40
 83e:	b7c5                	j	81e <vprintf+0x246>
        if((s = va_arg(ap, char*)) == 0)
 840:	8bce                	mv	s7,s3
      state = 0;
 842:	4981                	li	s3,0
 844:	bbf9                	j	622 <vprintf+0x4a>
 846:	64a6                	ld	s1,72(sp)
 848:	79e2                	ld	s3,56(sp)
 84a:	7a42                	ld	s4,48(sp)
 84c:	7aa2                	ld	s5,40(sp)
 84e:	7b02                	ld	s6,32(sp)
 850:	6be2                	ld	s7,24(sp)
 852:	6c42                	ld	s8,16(sp)
 854:	6ca2                	ld	s9,8(sp)
    }
  }
}
 856:	60e6                	ld	ra,88(sp)
 858:	6446                	ld	s0,80(sp)
 85a:	6906                	ld	s2,64(sp)
 85c:	6125                	addi	sp,sp,96
 85e:	8082                	ret

0000000000000860 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 860:	715d                	addi	sp,sp,-80
 862:	ec06                	sd	ra,24(sp)
 864:	e822                	sd	s0,16(sp)
 866:	1000                	addi	s0,sp,32
 868:	e010                	sd	a2,0(s0)
 86a:	e414                	sd	a3,8(s0)
 86c:	e818                	sd	a4,16(s0)
 86e:	ec1c                	sd	a5,24(s0)
 870:	03043023          	sd	a6,32(s0)
 874:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 878:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 87c:	8622                	mv	a2,s0
 87e:	d5bff0ef          	jal	5d8 <vprintf>
}
 882:	60e2                	ld	ra,24(sp)
 884:	6442                	ld	s0,16(sp)
 886:	6161                	addi	sp,sp,80
 888:	8082                	ret

000000000000088a <printf>:

void
printf(const char *fmt, ...)
{
 88a:	711d                	addi	sp,sp,-96
 88c:	ec06                	sd	ra,24(sp)
 88e:	e822                	sd	s0,16(sp)
 890:	1000                	addi	s0,sp,32
 892:	e40c                	sd	a1,8(s0)
 894:	e810                	sd	a2,16(s0)
 896:	ec14                	sd	a3,24(s0)
 898:	f018                	sd	a4,32(s0)
 89a:	f41c                	sd	a5,40(s0)
 89c:	03043823          	sd	a6,48(s0)
 8a0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8a4:	00840613          	addi	a2,s0,8
 8a8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ac:	85aa                	mv	a1,a0
 8ae:	4505                	li	a0,1
 8b0:	d29ff0ef          	jal	5d8 <vprintf>
}
 8b4:	60e2                	ld	ra,24(sp)
 8b6:	6442                	ld	s0,16(sp)
 8b8:	6125                	addi	sp,sp,96
 8ba:	8082                	ret

00000000000008bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8bc:	1141                	addi	sp,sp,-16
 8be:	e422                	sd	s0,8(sp)
 8c0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c6:	00000797          	auipc	a5,0x0
 8ca:	73a7b783          	ld	a5,1850(a5) # 1000 <freep>
 8ce:	a02d                	j	8f8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8d0:	4618                	lw	a4,8(a2)
 8d2:	9f2d                	addw	a4,a4,a1
 8d4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d8:	6398                	ld	a4,0(a5)
 8da:	6310                	ld	a2,0(a4)
 8dc:	a83d                	j	91a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8de:	ff852703          	lw	a4,-8(a0)
 8e2:	9f31                	addw	a4,a4,a2
 8e4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8e6:	ff053683          	ld	a3,-16(a0)
 8ea:	a091                	j	92e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ec:	6398                	ld	a4,0(a5)
 8ee:	00e7e463          	bltu	a5,a4,8f6 <free+0x3a>
 8f2:	00e6ea63          	bltu	a3,a4,906 <free+0x4a>
{
 8f6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f8:	fed7fae3          	bgeu	a5,a3,8ec <free+0x30>
 8fc:	6398                	ld	a4,0(a5)
 8fe:	00e6e463          	bltu	a3,a4,906 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 902:	fee7eae3          	bltu	a5,a4,8f6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 906:	ff852583          	lw	a1,-8(a0)
 90a:	6390                	ld	a2,0(a5)
 90c:	02059813          	slli	a6,a1,0x20
 910:	01c85713          	srli	a4,a6,0x1c
 914:	9736                	add	a4,a4,a3
 916:	fae60de3          	beq	a2,a4,8d0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 91a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 91e:	4790                	lw	a2,8(a5)
 920:	02061593          	slli	a1,a2,0x20
 924:	01c5d713          	srli	a4,a1,0x1c
 928:	973e                	add	a4,a4,a5
 92a:	fae68ae3          	beq	a3,a4,8de <free+0x22>
    p->s.ptr = bp->s.ptr;
 92e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 930:	00000717          	auipc	a4,0x0
 934:	6cf73823          	sd	a5,1744(a4) # 1000 <freep>
}
 938:	6422                	ld	s0,8(sp)
 93a:	0141                	addi	sp,sp,16
 93c:	8082                	ret

000000000000093e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 93e:	7139                	addi	sp,sp,-64
 940:	fc06                	sd	ra,56(sp)
 942:	f822                	sd	s0,48(sp)
 944:	f426                	sd	s1,40(sp)
 946:	ec4e                	sd	s3,24(sp)
 948:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 94a:	02051493          	slli	s1,a0,0x20
 94e:	9081                	srli	s1,s1,0x20
 950:	04bd                	addi	s1,s1,15
 952:	8091                	srli	s1,s1,0x4
 954:	0014899b          	addiw	s3,s1,1
 958:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 95a:	00000517          	auipc	a0,0x0
 95e:	6a653503          	ld	a0,1702(a0) # 1000 <freep>
 962:	c915                	beqz	a0,996 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 964:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 966:	4798                	lw	a4,8(a5)
 968:	08977a63          	bgeu	a4,s1,9fc <malloc+0xbe>
 96c:	f04a                	sd	s2,32(sp)
 96e:	e852                	sd	s4,16(sp)
 970:	e456                	sd	s5,8(sp)
 972:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 974:	8a4e                	mv	s4,s3
 976:	0009871b          	sext.w	a4,s3
 97a:	6685                	lui	a3,0x1
 97c:	00d77363          	bgeu	a4,a3,982 <malloc+0x44>
 980:	6a05                	lui	s4,0x1
 982:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 986:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 98a:	00000917          	auipc	s2,0x0
 98e:	67690913          	addi	s2,s2,1654 # 1000 <freep>
  if(p == (char*)-1)
 992:	5afd                	li	s5,-1
 994:	a081                	j	9d4 <malloc+0x96>
 996:	f04a                	sd	s2,32(sp)
 998:	e852                	sd	s4,16(sp)
 99a:	e456                	sd	s5,8(sp)
 99c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 99e:	00000797          	auipc	a5,0x0
 9a2:	67278793          	addi	a5,a5,1650 # 1010 <base>
 9a6:	00000717          	auipc	a4,0x0
 9aa:	64f73d23          	sd	a5,1626(a4) # 1000 <freep>
 9ae:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9b0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9b4:	b7c1                	j	974 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9b6:	6398                	ld	a4,0(a5)
 9b8:	e118                	sd	a4,0(a0)
 9ba:	a8a9                	j	a14 <malloc+0xd6>
  hp->s.size = nu;
 9bc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c0:	0541                	addi	a0,a0,16
 9c2:	efbff0ef          	jal	8bc <free>
  return freep;
 9c6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9ca:	c12d                	beqz	a0,a2c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ce:	4798                	lw	a4,8(a5)
 9d0:	02977263          	bgeu	a4,s1,9f4 <malloc+0xb6>
    if(p == freep)
 9d4:	00093703          	ld	a4,0(s2)
 9d8:	853e                	mv	a0,a5
 9da:	fef719e3          	bne	a4,a5,9cc <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9de:	8552                	mv	a0,s4
 9e0:	b1bff0ef          	jal	4fa <sbrk>
  if(p == (char*)-1)
 9e4:	fd551ce3          	bne	a0,s5,9bc <malloc+0x7e>
        return 0;
 9e8:	4501                	li	a0,0
 9ea:	7902                	ld	s2,32(sp)
 9ec:	6a42                	ld	s4,16(sp)
 9ee:	6aa2                	ld	s5,8(sp)
 9f0:	6b02                	ld	s6,0(sp)
 9f2:	a03d                	j	a20 <malloc+0xe2>
 9f4:	7902                	ld	s2,32(sp)
 9f6:	6a42                	ld	s4,16(sp)
 9f8:	6aa2                	ld	s5,8(sp)
 9fa:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9fc:	fae48de3          	beq	s1,a4,9b6 <malloc+0x78>
        p->s.size -= nunits;
 a00:	4137073b          	subw	a4,a4,s3
 a04:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a06:	02071693          	slli	a3,a4,0x20
 a0a:	01c6d713          	srli	a4,a3,0x1c
 a0e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a10:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a14:	00000717          	auipc	a4,0x0
 a18:	5ea73623          	sd	a0,1516(a4) # 1000 <freep>
      return (void*)(p + 1);
 a1c:	01078513          	addi	a0,a5,16
  }
}
 a20:	70e2                	ld	ra,56(sp)
 a22:	7442                	ld	s0,48(sp)
 a24:	74a2                	ld	s1,40(sp)
 a26:	69e2                	ld	s3,24(sp)
 a28:	6121                	addi	sp,sp,64
 a2a:	8082                	ret
 a2c:	7902                	ld	s2,32(sp)
 a2e:	6a42                	ld	s4,16(sp)
 a30:	6aa2                	ld	s5,8(sp)
 a32:	6b02                	ld	s6,0(sp)
 a34:	b7f5                	j	a20 <malloc+0xe2>
