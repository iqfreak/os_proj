
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       8:	611c                	ld	a5,0(a0)
       a:	0017d693          	srli	a3,a5,0x1
       e:	c0000737          	lui	a4,0xc0000
      12:	0705                	addi	a4,a4,1 # ffffffffc0000001 <base+0xffffffffbfffdbf9>
      14:	1706                	slli	a4,a4,0x21
      16:	0725                	addi	a4,a4,9
      18:	02e6b733          	mulhu	a4,a3,a4
      1c:	8375                	srli	a4,a4,0x1d
      1e:	01e71693          	slli	a3,a4,0x1e
      22:	40e68733          	sub	a4,a3,a4
      26:	0706                	slli	a4,a4,0x1
      28:	8f99                	sub	a5,a5,a4
      2a:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      2c:	1fe406b7          	lui	a3,0x1fe40
      30:	b7968693          	addi	a3,a3,-1159 # 1fe3fb79 <base+0x1fe3d771>
      34:	41a70737          	lui	a4,0x41a70
      38:	5af70713          	addi	a4,a4,1455 # 41a705af <base+0x41a6e1a7>
      3c:	1702                	slli	a4,a4,0x20
      3e:	9736                	add	a4,a4,a3
      40:	02e79733          	mulh	a4,a5,a4
      44:	873d                	srai	a4,a4,0xf
      46:	43f7d693          	srai	a3,a5,0x3f
      4a:	8f15                	sub	a4,a4,a3
      4c:	66fd                	lui	a3,0x1f
      4e:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      52:	02d706b3          	mul	a3,a4,a3
      56:	8f95                	sub	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      58:	6691                	lui	a3,0x4
      5a:	1a768693          	addi	a3,a3,423 # 41a7 <base+0x1d9f>
      5e:	02d787b3          	mul	a5,a5,a3
      62:	76fd                	lui	a3,0xfffff
      64:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      68:	02d70733          	mul	a4,a4,a3
      6c:	97ba                	add	a5,a5,a4
    if (x < 0)
      6e:	0007ca63          	bltz	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      72:	17fd                	addi	a5,a5,-1
    *ctx = x;
      74:	e11c                	sd	a5,0(a0)
    return (x);
}
      76:	0007851b          	sext.w	a0,a5
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
        x += 0x7fffffff;
      82:	80000737          	lui	a4,0x80000
      86:	fff74713          	not	a4,a4
      8a:	97ba                	add	a5,a5,a4
      8c:	b7dd                	j	72 <do_rand+0x72>

000000000000008e <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      8e:	1141                	addi	sp,sp,-16
      90:	e406                	sd	ra,8(sp)
      92:	e022                	sd	s0,0(sp)
      94:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      96:	00002517          	auipc	a0,0x2
      9a:	f6a50513          	addi	a0,a0,-150 # 2000 <rand_next>
      9e:	f63ff0ef          	jal	0 <do_rand>
}
      a2:	60a2                	ld	ra,8(sp)
      a4:	6402                	ld	s0,0(sp)
      a6:	0141                	addi	sp,sp,16
      a8:	8082                	ret

00000000000000aa <go>:

void
go(int which_child)
{
      aa:	7171                	addi	sp,sp,-176
      ac:	f506                	sd	ra,168(sp)
      ae:	f122                	sd	s0,160(sp)
      b0:	ed26                	sd	s1,152(sp)
      b2:	1900                	addi	s0,sp,176
      b4:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      b6:	4501                	li	a0,0
      b8:	4c5000ef          	jal	d7c <sbrk>
      bc:	f4a43c23          	sd	a0,-168(s0)
  uint64 iters = 0;

  mkdir("grindir");
      c0:	00001517          	auipc	a0,0x1
      c4:	1f050513          	addi	a0,a0,496 # 12b0 <malloc+0xfa>
      c8:	495000ef          	jal	d5c <mkdir>
  if(chdir("grindir") != 0){
      cc:	00001517          	auipc	a0,0x1
      d0:	1e450513          	addi	a0,a0,484 # 12b0 <malloc+0xfa>
      d4:	491000ef          	jal	d64 <chdir>
      d8:	c505                	beqz	a0,100 <go+0x56>
      da:	e94a                	sd	s2,144(sp)
      dc:	e54e                	sd	s3,136(sp)
      de:	e152                	sd	s4,128(sp)
      e0:	fcd6                	sd	s5,120(sp)
      e2:	f8da                	sd	s6,112(sp)
      e4:	f4de                	sd	s7,104(sp)
      e6:	f0e2                	sd	s8,96(sp)
      e8:	ece6                	sd	s9,88(sp)
      ea:	e8ea                	sd	s10,80(sp)
      ec:	e4ee                	sd	s11,72(sp)
    printf("grind: chdir grindir failed\n");
      ee:	00001517          	auipc	a0,0x1
      f2:	1ca50513          	addi	a0,a0,458 # 12b8 <malloc+0x102>
      f6:	008010ef          	jal	10fe <printf>
    exit(1);
      fa:	4505                	li	a0,1
      fc:	3f9000ef          	jal	cf4 <exit>
     100:	e94a                	sd	s2,144(sp)
     102:	e54e                	sd	s3,136(sp)
     104:	e152                	sd	s4,128(sp)
     106:	fcd6                	sd	s5,120(sp)
     108:	f8da                	sd	s6,112(sp)
     10a:	f4de                	sd	s7,104(sp)
     10c:	f0e2                	sd	s8,96(sp)
     10e:	ece6                	sd	s9,88(sp)
     110:	e8ea                	sd	s10,80(sp)
     112:	e4ee                	sd	s11,72(sp)
  }
  chdir("/");
     114:	00001517          	auipc	a0,0x1
     118:	1cc50513          	addi	a0,a0,460 # 12e0 <malloc+0x12a>
     11c:	449000ef          	jal	d64 <chdir>
     120:	00001c17          	auipc	s8,0x1
     124:	1d0c0c13          	addi	s8,s8,464 # 12f0 <malloc+0x13a>
     128:	c489                	beqz	s1,132 <go+0x88>
     12a:	00001c17          	auipc	s8,0x1
     12e:	1bec0c13          	addi	s8,s8,446 # 12e8 <malloc+0x132>
  uint64 iters = 0;
     132:	4481                	li	s1,0
  int fd = -1;
     134:	5cfd                	li	s9,-1
  
  while(1){
    iters++;
    if((iters % 500) == 0)
     136:	e353f7b7          	lui	a5,0xe353f
     13a:	7cf78793          	addi	a5,a5,1999 # ffffffffe353f7cf <base+0xffffffffe353d3c7>
     13e:	20c4a9b7          	lui	s3,0x20c4a
     142:	ba698993          	addi	s3,s3,-1114 # 20c49ba6 <base+0x20c4779e>
     146:	1982                	slli	s3,s3,0x20
     148:	99be                	add	s3,s3,a5
     14a:	1f400b13          	li	s6,500
      write(1, which_child?"B":"A", 1);
     14e:	4b85                	li	s7,1
    int what = rand() % 23;
     150:	b2164a37          	lui	s4,0xb2164
     154:	2c9a0a13          	addi	s4,s4,713 # ffffffffb21642c9 <base+0xffffffffb2161ec1>
     158:	4ad9                	li	s5,22
     15a:	00001917          	auipc	s2,0x1
     15e:	46690913          	addi	s2,s2,1126 # 15c0 <malloc+0x40a>
      close(fd1);
      unlink("c");
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     162:	f6840d93          	addi	s11,s0,-152
     166:	a819                	j	17c <go+0xd2>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     168:	20200593          	li	a1,514
     16c:	00001517          	auipc	a0,0x1
     170:	18c50513          	addi	a0,a0,396 # 12f8 <malloc+0x142>
     174:	3c1000ef          	jal	d34 <open>
     178:	3a5000ef          	jal	d1c <close>
    iters++;
     17c:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     17e:	0024d793          	srli	a5,s1,0x2
     182:	0337b7b3          	mulhu	a5,a5,s3
     186:	8391                	srli	a5,a5,0x4
     188:	036787b3          	mul	a5,a5,s6
     18c:	00f49763          	bne	s1,a5,19a <go+0xf0>
      write(1, which_child?"B":"A", 1);
     190:	865e                	mv	a2,s7
     192:	85e2                	mv	a1,s8
     194:	855e                	mv	a0,s7
     196:	37f000ef          	jal	d14 <write>
    int what = rand() % 23;
     19a:	ef5ff0ef          	jal	8e <rand>
     19e:	034507b3          	mul	a5,a0,s4
     1a2:	9381                	srli	a5,a5,0x20
     1a4:	9fa9                	addw	a5,a5,a0
     1a6:	4047d79b          	sraiw	a5,a5,0x4
     1aa:	41f5571b          	sraiw	a4,a0,0x1f
     1ae:	9f99                	subw	a5,a5,a4
     1b0:	0017971b          	slliw	a4,a5,0x1
     1b4:	9f3d                	addw	a4,a4,a5
     1b6:	0037171b          	slliw	a4,a4,0x3
     1ba:	40f707bb          	subw	a5,a4,a5
     1be:	9d1d                	subw	a0,a0,a5
     1c0:	faaaeee3          	bltu	s5,a0,17c <go+0xd2>
     1c4:	02051793          	slli	a5,a0,0x20
     1c8:	01e7d513          	srli	a0,a5,0x1e
     1cc:	954a                	add	a0,a0,s2
     1ce:	411c                	lw	a5,0(a0)
     1d0:	97ca                	add	a5,a5,s2
     1d2:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     1d4:	20200593          	li	a1,514
     1d8:	00001517          	auipc	a0,0x1
     1dc:	13050513          	addi	a0,a0,304 # 1308 <malloc+0x152>
     1e0:	355000ef          	jal	d34 <open>
     1e4:	339000ef          	jal	d1c <close>
     1e8:	bf51                	j	17c <go+0xd2>
      unlink("grindir/../a");
     1ea:	00001517          	auipc	a0,0x1
     1ee:	10e50513          	addi	a0,a0,270 # 12f8 <malloc+0x142>
     1f2:	353000ef          	jal	d44 <unlink>
     1f6:	b759                	j	17c <go+0xd2>
      if(chdir("grindir") != 0){
     1f8:	00001517          	auipc	a0,0x1
     1fc:	0b850513          	addi	a0,a0,184 # 12b0 <malloc+0xfa>
     200:	365000ef          	jal	d64 <chdir>
     204:	ed11                	bnez	a0,220 <go+0x176>
      unlink("../b");
     206:	00001517          	auipc	a0,0x1
     20a:	11a50513          	addi	a0,a0,282 # 1320 <malloc+0x16a>
     20e:	337000ef          	jal	d44 <unlink>
      chdir("/");
     212:	00001517          	auipc	a0,0x1
     216:	0ce50513          	addi	a0,a0,206 # 12e0 <malloc+0x12a>
     21a:	34b000ef          	jal	d64 <chdir>
     21e:	bfb9                	j	17c <go+0xd2>
        printf("grind: chdir grindir failed\n");
     220:	00001517          	auipc	a0,0x1
     224:	09850513          	addi	a0,a0,152 # 12b8 <malloc+0x102>
     228:	6d7000ef          	jal	10fe <printf>
        exit(1);
     22c:	4505                	li	a0,1
     22e:	2c7000ef          	jal	cf4 <exit>
      close(fd);
     232:	8566                	mv	a0,s9
     234:	2e9000ef          	jal	d1c <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     238:	20200593          	li	a1,514
     23c:	00001517          	auipc	a0,0x1
     240:	0ec50513          	addi	a0,a0,236 # 1328 <malloc+0x172>
     244:	2f1000ef          	jal	d34 <open>
     248:	8caa                	mv	s9,a0
     24a:	bf0d                	j	17c <go+0xd2>
      close(fd);
     24c:	8566                	mv	a0,s9
     24e:	2cf000ef          	jal	d1c <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     252:	20200593          	li	a1,514
     256:	00001517          	auipc	a0,0x1
     25a:	0e250513          	addi	a0,a0,226 # 1338 <malloc+0x182>
     25e:	2d7000ef          	jal	d34 <open>
     262:	8caa                	mv	s9,a0
     264:	bf21                	j	17c <go+0xd2>
      write(fd, buf, sizeof(buf));
     266:	3e700613          	li	a2,999
     26a:	00002597          	auipc	a1,0x2
     26e:	db658593          	addi	a1,a1,-586 # 2020 <buf.0>
     272:	8566                	mv	a0,s9
     274:	2a1000ef          	jal	d14 <write>
     278:	b711                	j	17c <go+0xd2>
      read(fd, buf, sizeof(buf));
     27a:	3e700613          	li	a2,999
     27e:	00002597          	auipc	a1,0x2
     282:	da258593          	addi	a1,a1,-606 # 2020 <buf.0>
     286:	8566                	mv	a0,s9
     288:	285000ef          	jal	d0c <read>
     28c:	bdc5                	j	17c <go+0xd2>
      mkdir("grindir/../a");
     28e:	00001517          	auipc	a0,0x1
     292:	06a50513          	addi	a0,a0,106 # 12f8 <malloc+0x142>
     296:	2c7000ef          	jal	d5c <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     29a:	20200593          	li	a1,514
     29e:	00001517          	auipc	a0,0x1
     2a2:	0b250513          	addi	a0,a0,178 # 1350 <malloc+0x19a>
     2a6:	28f000ef          	jal	d34 <open>
     2aa:	273000ef          	jal	d1c <close>
      unlink("a/a");
     2ae:	00001517          	auipc	a0,0x1
     2b2:	0b250513          	addi	a0,a0,178 # 1360 <malloc+0x1aa>
     2b6:	28f000ef          	jal	d44 <unlink>
     2ba:	b5c9                	j	17c <go+0xd2>
      mkdir("/../b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	0ac50513          	addi	a0,a0,172 # 1368 <malloc+0x1b2>
     2c4:	299000ef          	jal	d5c <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2c8:	20200593          	li	a1,514
     2cc:	00001517          	auipc	a0,0x1
     2d0:	0a450513          	addi	a0,a0,164 # 1370 <malloc+0x1ba>
     2d4:	261000ef          	jal	d34 <open>
     2d8:	245000ef          	jal	d1c <close>
      unlink("b/b");
     2dc:	00001517          	auipc	a0,0x1
     2e0:	0a450513          	addi	a0,a0,164 # 1380 <malloc+0x1ca>
     2e4:	261000ef          	jal	d44 <unlink>
     2e8:	bd51                	j	17c <go+0xd2>
      unlink("b");
     2ea:	00001517          	auipc	a0,0x1
     2ee:	09e50513          	addi	a0,a0,158 # 1388 <malloc+0x1d2>
     2f2:	253000ef          	jal	d44 <unlink>
      link("../grindir/./../a", "../b");
     2f6:	00001597          	auipc	a1,0x1
     2fa:	02a58593          	addi	a1,a1,42 # 1320 <malloc+0x16a>
     2fe:	00001517          	auipc	a0,0x1
     302:	09250513          	addi	a0,a0,146 # 1390 <malloc+0x1da>
     306:	24f000ef          	jal	d54 <link>
     30a:	bd8d                	j	17c <go+0xd2>
      unlink("../grindir/../a");
     30c:	00001517          	auipc	a0,0x1
     310:	09c50513          	addi	a0,a0,156 # 13a8 <malloc+0x1f2>
     314:	231000ef          	jal	d44 <unlink>
      link(".././b", "/grindir/../a");
     318:	00001597          	auipc	a1,0x1
     31c:	01058593          	addi	a1,a1,16 # 1328 <malloc+0x172>
     320:	00001517          	auipc	a0,0x1
     324:	09850513          	addi	a0,a0,152 # 13b8 <malloc+0x202>
     328:	22d000ef          	jal	d54 <link>
     32c:	bd81                	j	17c <go+0xd2>
      int pid = fork();
     32e:	1bf000ef          	jal	cec <fork>
      if(pid == 0){
     332:	c519                	beqz	a0,340 <go+0x296>
      } else if(pid < 0){
     334:	00054863          	bltz	a0,344 <go+0x29a>
      wait(0);
     338:	4501                	li	a0,0
     33a:	1c3000ef          	jal	cfc <wait>
     33e:	bd3d                	j	17c <go+0xd2>
        exit(0);
     340:	1b5000ef          	jal	cf4 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	07c50513          	addi	a0,a0,124 # 13c0 <malloc+0x20a>
     34c:	5b3000ef          	jal	10fe <printf>
        exit(1);
     350:	4505                	li	a0,1
     352:	1a3000ef          	jal	cf4 <exit>
      int pid = fork();
     356:	197000ef          	jal	cec <fork>
      if(pid == 0){
     35a:	c519                	beqz	a0,368 <go+0x2be>
      } else if(pid < 0){
     35c:	00054d63          	bltz	a0,376 <go+0x2cc>
      wait(0);
     360:	4501                	li	a0,0
     362:	19b000ef          	jal	cfc <wait>
     366:	bd19                	j	17c <go+0xd2>
        fork();
     368:	185000ef          	jal	cec <fork>
        fork();
     36c:	181000ef          	jal	cec <fork>
        exit(0);
     370:	4501                	li	a0,0
     372:	183000ef          	jal	cf4 <exit>
        printf("grind: fork failed\n");
     376:	00001517          	auipc	a0,0x1
     37a:	04a50513          	addi	a0,a0,74 # 13c0 <malloc+0x20a>
     37e:	581000ef          	jal	10fe <printf>
        exit(1);
     382:	4505                	li	a0,1
     384:	171000ef          	jal	cf4 <exit>
      sbrk(6011);
     388:	6505                	lui	a0,0x1
     38a:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x15b>
     38e:	1ef000ef          	jal	d7c <sbrk>
     392:	b3ed                	j	17c <go+0xd2>
      if(sbrk(0) > break0)
     394:	4501                	li	a0,0
     396:	1e7000ef          	jal	d7c <sbrk>
     39a:	f5843783          	ld	a5,-168(s0)
     39e:	dca7ffe3          	bgeu	a5,a0,17c <go+0xd2>
        sbrk(-(sbrk(0) - break0));
     3a2:	4501                	li	a0,0
     3a4:	1d9000ef          	jal	d7c <sbrk>
     3a8:	f5843783          	ld	a5,-168(s0)
     3ac:	40a7853b          	subw	a0,a5,a0
     3b0:	1cd000ef          	jal	d7c <sbrk>
     3b4:	b3e1                	j	17c <go+0xd2>
      int pid = fork();
     3b6:	137000ef          	jal	cec <fork>
     3ba:	8d2a                	mv	s10,a0
      if(pid == 0){
     3bc:	c10d                	beqz	a0,3de <go+0x334>
      } else if(pid < 0){
     3be:	02054d63          	bltz	a0,3f8 <go+0x34e>
      if(chdir("../grindir/..") != 0){
     3c2:	00001517          	auipc	a0,0x1
     3c6:	01e50513          	addi	a0,a0,30 # 13e0 <malloc+0x22a>
     3ca:	19b000ef          	jal	d64 <chdir>
     3ce:	ed15                	bnez	a0,40a <go+0x360>
      kill(pid);
     3d0:	856a                	mv	a0,s10
     3d2:	153000ef          	jal	d24 <kill>
      wait(0);
     3d6:	4501                	li	a0,0
     3d8:	125000ef          	jal	cfc <wait>
     3dc:	b345                	j	17c <go+0xd2>
        close(open("a", O_CREATE|O_RDWR));
     3de:	20200593          	li	a1,514
     3e2:	00001517          	auipc	a0,0x1
     3e6:	ff650513          	addi	a0,a0,-10 # 13d8 <malloc+0x222>
     3ea:	14b000ef          	jal	d34 <open>
     3ee:	12f000ef          	jal	d1c <close>
        exit(0);
     3f2:	4501                	li	a0,0
     3f4:	101000ef          	jal	cf4 <exit>
        printf("grind: fork failed\n");
     3f8:	00001517          	auipc	a0,0x1
     3fc:	fc850513          	addi	a0,a0,-56 # 13c0 <malloc+0x20a>
     400:	4ff000ef          	jal	10fe <printf>
        exit(1);
     404:	4505                	li	a0,1
     406:	0ef000ef          	jal	cf4 <exit>
        printf("grind: chdir failed\n");
     40a:	00001517          	auipc	a0,0x1
     40e:	fe650513          	addi	a0,a0,-26 # 13f0 <malloc+0x23a>
     412:	4ed000ef          	jal	10fe <printf>
        exit(1);
     416:	4505                	li	a0,1
     418:	0dd000ef          	jal	cf4 <exit>
      int pid = fork();
     41c:	0d1000ef          	jal	cec <fork>
      if(pid == 0){
     420:	c519                	beqz	a0,42e <go+0x384>
      } else if(pid < 0){
     422:	00054d63          	bltz	a0,43c <go+0x392>
      wait(0);
     426:	4501                	li	a0,0
     428:	0d5000ef          	jal	cfc <wait>
     42c:	bb81                	j	17c <go+0xd2>
        kill(getpid());
     42e:	147000ef          	jal	d74 <getpid>
     432:	0f3000ef          	jal	d24 <kill>
        exit(0);
     436:	4501                	li	a0,0
     438:	0bd000ef          	jal	cf4 <exit>
        printf("grind: fork failed\n");
     43c:	00001517          	auipc	a0,0x1
     440:	f8450513          	addi	a0,a0,-124 # 13c0 <malloc+0x20a>
     444:	4bb000ef          	jal	10fe <printf>
        exit(1);
     448:	4505                	li	a0,1
     44a:	0ab000ef          	jal	cf4 <exit>
      if(pipe(fds) < 0){
     44e:	f7840513          	addi	a0,s0,-136
     452:	0b3000ef          	jal	d04 <pipe>
     456:	02054363          	bltz	a0,47c <go+0x3d2>
      int pid = fork();
     45a:	093000ef          	jal	cec <fork>
      if(pid == 0){
     45e:	c905                	beqz	a0,48e <go+0x3e4>
      } else if(pid < 0){
     460:	08054263          	bltz	a0,4e4 <go+0x43a>
      close(fds[0]);
     464:	f7842503          	lw	a0,-136(s0)
     468:	0b5000ef          	jal	d1c <close>
      close(fds[1]);
     46c:	f7c42503          	lw	a0,-132(s0)
     470:	0ad000ef          	jal	d1c <close>
      wait(0);
     474:	4501                	li	a0,0
     476:	087000ef          	jal	cfc <wait>
     47a:	b309                	j	17c <go+0xd2>
        printf("grind: pipe failed\n");
     47c:	00001517          	auipc	a0,0x1
     480:	f8c50513          	addi	a0,a0,-116 # 1408 <malloc+0x252>
     484:	47b000ef          	jal	10fe <printf>
        exit(1);
     488:	4505                	li	a0,1
     48a:	06b000ef          	jal	cf4 <exit>
        fork();
     48e:	05f000ef          	jal	cec <fork>
        fork();
     492:	05b000ef          	jal	cec <fork>
        if(write(fds[1], "x", 1) != 1)
     496:	4605                	li	a2,1
     498:	00001597          	auipc	a1,0x1
     49c:	f8858593          	addi	a1,a1,-120 # 1420 <malloc+0x26a>
     4a0:	f7c42503          	lw	a0,-132(s0)
     4a4:	071000ef          	jal	d14 <write>
     4a8:	4785                	li	a5,1
     4aa:	00f51f63          	bne	a0,a5,4c8 <go+0x41e>
        if(read(fds[0], &c, 1) != 1)
     4ae:	4605                	li	a2,1
     4b0:	f7040593          	addi	a1,s0,-144
     4b4:	f7842503          	lw	a0,-136(s0)
     4b8:	055000ef          	jal	d0c <read>
     4bc:	4785                	li	a5,1
     4be:	00f51c63          	bne	a0,a5,4d6 <go+0x42c>
        exit(0);
     4c2:	4501                	li	a0,0
     4c4:	031000ef          	jal	cf4 <exit>
          printf("grind: pipe write failed\n");
     4c8:	00001517          	auipc	a0,0x1
     4cc:	f6050513          	addi	a0,a0,-160 # 1428 <malloc+0x272>
     4d0:	42f000ef          	jal	10fe <printf>
     4d4:	bfe9                	j	4ae <go+0x404>
          printf("grind: pipe read failed\n");
     4d6:	00001517          	auipc	a0,0x1
     4da:	f7250513          	addi	a0,a0,-142 # 1448 <malloc+0x292>
     4de:	421000ef          	jal	10fe <printf>
     4e2:	b7c5                	j	4c2 <go+0x418>
        printf("grind: fork failed\n");
     4e4:	00001517          	auipc	a0,0x1
     4e8:	edc50513          	addi	a0,a0,-292 # 13c0 <malloc+0x20a>
     4ec:	413000ef          	jal	10fe <printf>
        exit(1);
     4f0:	4505                	li	a0,1
     4f2:	003000ef          	jal	cf4 <exit>
      int pid = fork();
     4f6:	7f6000ef          	jal	cec <fork>
      if(pid == 0){
     4fa:	c519                	beqz	a0,508 <go+0x45e>
      } else if(pid < 0){
     4fc:	04054f63          	bltz	a0,55a <go+0x4b0>
      wait(0);
     500:	4501                	li	a0,0
     502:	7fa000ef          	jal	cfc <wait>
     506:	b99d                	j	17c <go+0xd2>
        unlink("a");
     508:	00001517          	auipc	a0,0x1
     50c:	ed050513          	addi	a0,a0,-304 # 13d8 <malloc+0x222>
     510:	035000ef          	jal	d44 <unlink>
        mkdir("a");
     514:	00001517          	auipc	a0,0x1
     518:	ec450513          	addi	a0,a0,-316 # 13d8 <malloc+0x222>
     51c:	041000ef          	jal	d5c <mkdir>
        chdir("a");
     520:	00001517          	auipc	a0,0x1
     524:	eb850513          	addi	a0,a0,-328 # 13d8 <malloc+0x222>
     528:	03d000ef          	jal	d64 <chdir>
        unlink("../a");
     52c:	00001517          	auipc	a0,0x1
     530:	f3c50513          	addi	a0,a0,-196 # 1468 <malloc+0x2b2>
     534:	011000ef          	jal	d44 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     538:	20200593          	li	a1,514
     53c:	00001517          	auipc	a0,0x1
     540:	ee450513          	addi	a0,a0,-284 # 1420 <malloc+0x26a>
     544:	7f0000ef          	jal	d34 <open>
        unlink("x");
     548:	00001517          	auipc	a0,0x1
     54c:	ed850513          	addi	a0,a0,-296 # 1420 <malloc+0x26a>
     550:	7f4000ef          	jal	d44 <unlink>
        exit(0);
     554:	4501                	li	a0,0
     556:	79e000ef          	jal	cf4 <exit>
        printf("grind: fork failed\n");
     55a:	00001517          	auipc	a0,0x1
     55e:	e6650513          	addi	a0,a0,-410 # 13c0 <malloc+0x20a>
     562:	39d000ef          	jal	10fe <printf>
        exit(1);
     566:	4505                	li	a0,1
     568:	78c000ef          	jal	cf4 <exit>
      unlink("c");
     56c:	00001517          	auipc	a0,0x1
     570:	f0450513          	addi	a0,a0,-252 # 1470 <malloc+0x2ba>
     574:	7d0000ef          	jal	d44 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     578:	20200593          	li	a1,514
     57c:	00001517          	auipc	a0,0x1
     580:	ef450513          	addi	a0,a0,-268 # 1470 <malloc+0x2ba>
     584:	7b0000ef          	jal	d34 <open>
     588:	8d2a                	mv	s10,a0
      if(fd1 < 0){
     58a:	04054563          	bltz	a0,5d4 <go+0x52a>
      if(write(fd1, "x", 1) != 1){
     58e:	865e                	mv	a2,s7
     590:	00001597          	auipc	a1,0x1
     594:	e9058593          	addi	a1,a1,-368 # 1420 <malloc+0x26a>
     598:	77c000ef          	jal	d14 <write>
     59c:	05751563          	bne	a0,s7,5e6 <go+0x53c>
      if(fstat(fd1, &st) != 0){
     5a0:	f7840593          	addi	a1,s0,-136
     5a4:	856a                	mv	a0,s10
     5a6:	7a6000ef          	jal	d4c <fstat>
     5aa:	e539                	bnez	a0,5f8 <go+0x54e>
      if(st.size != 1){
     5ac:	f8843583          	ld	a1,-120(s0)
     5b0:	05759d63          	bne	a1,s7,60a <go+0x560>
      if(st.ino > 200){
     5b4:	f7c42583          	lw	a1,-132(s0)
     5b8:	0c800793          	li	a5,200
     5bc:	06b7e163          	bltu	a5,a1,61e <go+0x574>
      close(fd1);
     5c0:	856a                	mv	a0,s10
     5c2:	75a000ef          	jal	d1c <close>
      unlink("c");
     5c6:	00001517          	auipc	a0,0x1
     5ca:	eaa50513          	addi	a0,a0,-342 # 1470 <malloc+0x2ba>
     5ce:	776000ef          	jal	d44 <unlink>
     5d2:	b66d                	j	17c <go+0xd2>
        printf("grind: create c failed\n");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	ea450513          	addi	a0,a0,-348 # 1478 <malloc+0x2c2>
     5dc:	323000ef          	jal	10fe <printf>
        exit(1);
     5e0:	4505                	li	a0,1
     5e2:	712000ef          	jal	cf4 <exit>
        printf("grind: write c failed\n");
     5e6:	00001517          	auipc	a0,0x1
     5ea:	eaa50513          	addi	a0,a0,-342 # 1490 <malloc+0x2da>
     5ee:	311000ef          	jal	10fe <printf>
        exit(1);
     5f2:	4505                	li	a0,1
     5f4:	700000ef          	jal	cf4 <exit>
        printf("grind: fstat failed\n");
     5f8:	00001517          	auipc	a0,0x1
     5fc:	eb050513          	addi	a0,a0,-336 # 14a8 <malloc+0x2f2>
     600:	2ff000ef          	jal	10fe <printf>
        exit(1);
     604:	4505                	li	a0,1
     606:	6ee000ef          	jal	cf4 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     60a:	2581                	sext.w	a1,a1
     60c:	00001517          	auipc	a0,0x1
     610:	eb450513          	addi	a0,a0,-332 # 14c0 <malloc+0x30a>
     614:	2eb000ef          	jal	10fe <printf>
        exit(1);
     618:	4505                	li	a0,1
     61a:	6da000ef          	jal	cf4 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     61e:	00001517          	auipc	a0,0x1
     622:	eca50513          	addi	a0,a0,-310 # 14e8 <malloc+0x332>
     626:	2d9000ef          	jal	10fe <printf>
        exit(1);
     62a:	4505                	li	a0,1
     62c:	6c8000ef          	jal	cf4 <exit>
      if(pipe(aa) < 0){
     630:	856e                	mv	a0,s11
     632:	6d2000ef          	jal	d04 <pipe>
     636:	0a054863          	bltz	a0,6e6 <go+0x63c>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     63a:	f7040513          	addi	a0,s0,-144
     63e:	6c6000ef          	jal	d04 <pipe>
     642:	0a054c63          	bltz	a0,6fa <go+0x650>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     646:	6a6000ef          	jal	cec <fork>
      if(pid1 == 0){
     64a:	0c050263          	beqz	a0,70e <go+0x664>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     64e:	14054463          	bltz	a0,796 <go+0x6ec>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     652:	69a000ef          	jal	cec <fork>
      if(pid2 == 0){
     656:	14050a63          	beqz	a0,7aa <go+0x700>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     65a:	1e054863          	bltz	a0,84a <go+0x7a0>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     65e:	f6842503          	lw	a0,-152(s0)
     662:	6ba000ef          	jal	d1c <close>
      close(aa[1]);
     666:	f6c42503          	lw	a0,-148(s0)
     66a:	6b2000ef          	jal	d1c <close>
      close(bb[1]);
     66e:	f7442503          	lw	a0,-140(s0)
     672:	6aa000ef          	jal	d1c <close>
      char buf[4] = { 0, 0, 0, 0 };
     676:	f6042023          	sw	zero,-160(s0)
      read(bb[0], buf+0, 1);
     67a:	865e                	mv	a2,s7
     67c:	f6040593          	addi	a1,s0,-160
     680:	f7042503          	lw	a0,-144(s0)
     684:	688000ef          	jal	d0c <read>
      read(bb[0], buf+1, 1);
     688:	865e                	mv	a2,s7
     68a:	f6140593          	addi	a1,s0,-159
     68e:	f7042503          	lw	a0,-144(s0)
     692:	67a000ef          	jal	d0c <read>
      read(bb[0], buf+2, 1);
     696:	865e                	mv	a2,s7
     698:	f6240593          	addi	a1,s0,-158
     69c:	f7042503          	lw	a0,-144(s0)
     6a0:	66c000ef          	jal	d0c <read>
      close(bb[0]);
     6a4:	f7042503          	lw	a0,-144(s0)
     6a8:	674000ef          	jal	d1c <close>
      int st1, st2;
      wait(&st1);
     6ac:	f6440513          	addi	a0,s0,-156
     6b0:	64c000ef          	jal	cfc <wait>
      wait(&st2);
     6b4:	f7840513          	addi	a0,s0,-136
     6b8:	644000ef          	jal	cfc <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     6bc:	f6442783          	lw	a5,-156(s0)
     6c0:	f7842703          	lw	a4,-136(s0)
     6c4:	f4e43823          	sd	a4,-176(s0)
     6c8:	00e7ed33          	or	s10,a5,a4
     6cc:	180d1963          	bnez	s10,85e <go+0x7b4>
     6d0:	00001597          	auipc	a1,0x1
     6d4:	eb858593          	addi	a1,a1,-328 # 1588 <malloc+0x3d2>
     6d8:	f6040513          	addi	a0,s0,-160
     6dc:	2d8000ef          	jal	9b4 <strcmp>
     6e0:	a8050ee3          	beqz	a0,17c <go+0xd2>
     6e4:	aab5                	j	860 <go+0x7b6>
        fprintf(2, "grind: pipe failed\n");
     6e6:	00001597          	auipc	a1,0x1
     6ea:	d2258593          	addi	a1,a1,-734 # 1408 <malloc+0x252>
     6ee:	4509                	li	a0,2
     6f0:	1e5000ef          	jal	10d4 <fprintf>
        exit(1);
     6f4:	4505                	li	a0,1
     6f6:	5fe000ef          	jal	cf4 <exit>
        fprintf(2, "grind: pipe failed\n");
     6fa:	00001597          	auipc	a1,0x1
     6fe:	d0e58593          	addi	a1,a1,-754 # 1408 <malloc+0x252>
     702:	4509                	li	a0,2
     704:	1d1000ef          	jal	10d4 <fprintf>
        exit(1);
     708:	4505                	li	a0,1
     70a:	5ea000ef          	jal	cf4 <exit>
        close(bb[0]);
     70e:	f7042503          	lw	a0,-144(s0)
     712:	60a000ef          	jal	d1c <close>
        close(bb[1]);
     716:	f7442503          	lw	a0,-140(s0)
     71a:	602000ef          	jal	d1c <close>
        close(aa[0]);
     71e:	f6842503          	lw	a0,-152(s0)
     722:	5fa000ef          	jal	d1c <close>
        close(1);
     726:	4505                	li	a0,1
     728:	5f4000ef          	jal	d1c <close>
        if(dup(aa[1]) != 1){
     72c:	f6c42503          	lw	a0,-148(s0)
     730:	63c000ef          	jal	d6c <dup>
     734:	4785                	li	a5,1
     736:	00f50c63          	beq	a0,a5,74e <go+0x6a4>
          fprintf(2, "grind: dup failed\n");
     73a:	00001597          	auipc	a1,0x1
     73e:	dd658593          	addi	a1,a1,-554 # 1510 <malloc+0x35a>
     742:	4509                	li	a0,2
     744:	191000ef          	jal	10d4 <fprintf>
          exit(1);
     748:	4505                	li	a0,1
     74a:	5aa000ef          	jal	cf4 <exit>
        close(aa[1]);
     74e:	f6c42503          	lw	a0,-148(s0)
     752:	5ca000ef          	jal	d1c <close>
        char *args[3] = { "echo", "hi", 0 };
     756:	00001797          	auipc	a5,0x1
     75a:	dd278793          	addi	a5,a5,-558 # 1528 <malloc+0x372>
     75e:	f6f43c23          	sd	a5,-136(s0)
     762:	00001797          	auipc	a5,0x1
     766:	dce78793          	addi	a5,a5,-562 # 1530 <malloc+0x37a>
     76a:	f8f43023          	sd	a5,-128(s0)
     76e:	f8043423          	sd	zero,-120(s0)
        exec("grindir/../echo", args);
     772:	f7840593          	addi	a1,s0,-136
     776:	00001517          	auipc	a0,0x1
     77a:	dc250513          	addi	a0,a0,-574 # 1538 <malloc+0x382>
     77e:	5ae000ef          	jal	d2c <exec>
        fprintf(2, "grind: echo: not found\n");
     782:	00001597          	auipc	a1,0x1
     786:	dc658593          	addi	a1,a1,-570 # 1548 <malloc+0x392>
     78a:	4509                	li	a0,2
     78c:	149000ef          	jal	10d4 <fprintf>
        exit(2);
     790:	4509                	li	a0,2
     792:	562000ef          	jal	cf4 <exit>
        fprintf(2, "grind: fork failed\n");
     796:	00001597          	auipc	a1,0x1
     79a:	c2a58593          	addi	a1,a1,-982 # 13c0 <malloc+0x20a>
     79e:	4509                	li	a0,2
     7a0:	135000ef          	jal	10d4 <fprintf>
        exit(3);
     7a4:	450d                	li	a0,3
     7a6:	54e000ef          	jal	cf4 <exit>
        close(aa[1]);
     7aa:	f6c42503          	lw	a0,-148(s0)
     7ae:	56e000ef          	jal	d1c <close>
        close(bb[0]);
     7b2:	f7042503          	lw	a0,-144(s0)
     7b6:	566000ef          	jal	d1c <close>
        close(0);
     7ba:	4501                	li	a0,0
     7bc:	560000ef          	jal	d1c <close>
        if(dup(aa[0]) != 0){
     7c0:	f6842503          	lw	a0,-152(s0)
     7c4:	5a8000ef          	jal	d6c <dup>
     7c8:	c919                	beqz	a0,7de <go+0x734>
          fprintf(2, "grind: dup failed\n");
     7ca:	00001597          	auipc	a1,0x1
     7ce:	d4658593          	addi	a1,a1,-698 # 1510 <malloc+0x35a>
     7d2:	4509                	li	a0,2
     7d4:	101000ef          	jal	10d4 <fprintf>
          exit(4);
     7d8:	4511                	li	a0,4
     7da:	51a000ef          	jal	cf4 <exit>
        close(aa[0]);
     7de:	f6842503          	lw	a0,-152(s0)
     7e2:	53a000ef          	jal	d1c <close>
        close(1);
     7e6:	4505                	li	a0,1
     7e8:	534000ef          	jal	d1c <close>
        if(dup(bb[1]) != 1){
     7ec:	f7442503          	lw	a0,-140(s0)
     7f0:	57c000ef          	jal	d6c <dup>
     7f4:	4785                	li	a5,1
     7f6:	00f50c63          	beq	a0,a5,80e <go+0x764>
          fprintf(2, "grind: dup failed\n");
     7fa:	00001597          	auipc	a1,0x1
     7fe:	d1658593          	addi	a1,a1,-746 # 1510 <malloc+0x35a>
     802:	4509                	li	a0,2
     804:	0d1000ef          	jal	10d4 <fprintf>
          exit(5);
     808:	4515                	li	a0,5
     80a:	4ea000ef          	jal	cf4 <exit>
        close(bb[1]);
     80e:	f7442503          	lw	a0,-140(s0)
     812:	50a000ef          	jal	d1c <close>
        char *args[2] = { "cat", 0 };
     816:	00001797          	auipc	a5,0x1
     81a:	d4a78793          	addi	a5,a5,-694 # 1560 <malloc+0x3aa>
     81e:	f6f43c23          	sd	a5,-136(s0)
     822:	f8043023          	sd	zero,-128(s0)
        exec("/cat", args);
     826:	f7840593          	addi	a1,s0,-136
     82a:	00001517          	auipc	a0,0x1
     82e:	d3e50513          	addi	a0,a0,-706 # 1568 <malloc+0x3b2>
     832:	4fa000ef          	jal	d2c <exec>
        fprintf(2, "grind: cat: not found\n");
     836:	00001597          	auipc	a1,0x1
     83a:	d3a58593          	addi	a1,a1,-710 # 1570 <malloc+0x3ba>
     83e:	4509                	li	a0,2
     840:	095000ef          	jal	10d4 <fprintf>
        exit(6);
     844:	4519                	li	a0,6
     846:	4ae000ef          	jal	cf4 <exit>
        fprintf(2, "grind: fork failed\n");
     84a:	00001597          	auipc	a1,0x1
     84e:	b7658593          	addi	a1,a1,-1162 # 13c0 <malloc+0x20a>
     852:	4509                	li	a0,2
     854:	081000ef          	jal	10d4 <fprintf>
        exit(7);
     858:	451d                	li	a0,7
     85a:	49a000ef          	jal	cf4 <exit>
     85e:	8d3e                	mv	s10,a5
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     860:	f6040693          	addi	a3,s0,-160
     864:	f5043603          	ld	a2,-176(s0)
     868:	85ea                	mv	a1,s10
     86a:	00001517          	auipc	a0,0x1
     86e:	d2650513          	addi	a0,a0,-730 # 1590 <malloc+0x3da>
     872:	08d000ef          	jal	10fe <printf>
        exit(1);
     876:	4505                	li	a0,1
     878:	47c000ef          	jal	cf4 <exit>

000000000000087c <iter>:
  }
}

void
iter()
{
     87c:	7179                	addi	sp,sp,-48
     87e:	f406                	sd	ra,40(sp)
     880:	f022                	sd	s0,32(sp)
     882:	1800                	addi	s0,sp,48
  unlink("a");
     884:	00001517          	auipc	a0,0x1
     888:	b5450513          	addi	a0,a0,-1196 # 13d8 <malloc+0x222>
     88c:	4b8000ef          	jal	d44 <unlink>
  unlink("b");
     890:	00001517          	auipc	a0,0x1
     894:	af850513          	addi	a0,a0,-1288 # 1388 <malloc+0x1d2>
     898:	4ac000ef          	jal	d44 <unlink>
  
  int pid1 = fork();
     89c:	450000ef          	jal	cec <fork>
  if(pid1 < 0){
     8a0:	02054163          	bltz	a0,8c2 <iter+0x46>
     8a4:	ec26                	sd	s1,24(sp)
     8a6:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     8a8:	e905                	bnez	a0,8d8 <iter+0x5c>
     8aa:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     8ac:	00001717          	auipc	a4,0x1
     8b0:	75470713          	addi	a4,a4,1876 # 2000 <rand_next>
     8b4:	631c                	ld	a5,0(a4)
     8b6:	01f7c793          	xori	a5,a5,31
     8ba:	e31c                	sd	a5,0(a4)
    go(0);
     8bc:	4501                	li	a0,0
     8be:	fecff0ef          	jal	aa <go>
     8c2:	ec26                	sd	s1,24(sp)
     8c4:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     8c6:	00001517          	auipc	a0,0x1
     8ca:	afa50513          	addi	a0,a0,-1286 # 13c0 <malloc+0x20a>
     8ce:	031000ef          	jal	10fe <printf>
    exit(1);
     8d2:	4505                	li	a0,1
     8d4:	420000ef          	jal	cf4 <exit>
     8d8:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     8da:	412000ef          	jal	cec <fork>
     8de:	892a                	mv	s2,a0
  if(pid2 < 0){
     8e0:	02054063          	bltz	a0,900 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     8e4:	e51d                	bnez	a0,912 <iter+0x96>
    rand_next ^= 7177;
     8e6:	00001697          	auipc	a3,0x1
     8ea:	71a68693          	addi	a3,a3,1818 # 2000 <rand_next>
     8ee:	629c                	ld	a5,0(a3)
     8f0:	6709                	lui	a4,0x2
     8f2:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x5e9>
     8f6:	8fb9                	xor	a5,a5,a4
     8f8:	e29c                	sd	a5,0(a3)
    go(1);
     8fa:	4505                	li	a0,1
     8fc:	faeff0ef          	jal	aa <go>
    printf("grind: fork failed\n");
     900:	00001517          	auipc	a0,0x1
     904:	ac050513          	addi	a0,a0,-1344 # 13c0 <malloc+0x20a>
     908:	7f6000ef          	jal	10fe <printf>
    exit(1);
     90c:	4505                	li	a0,1
     90e:	3e6000ef          	jal	cf4 <exit>
    exit(0);
  }

  int st1 = -1;
     912:	57fd                	li	a5,-1
     914:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     918:	fdc40513          	addi	a0,s0,-36
     91c:	3e0000ef          	jal	cfc <wait>
  if(st1 != 0){
     920:	fdc42783          	lw	a5,-36(s0)
     924:	eb99                	bnez	a5,93a <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     926:	57fd                	li	a5,-1
     928:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     92c:	fd840513          	addi	a0,s0,-40
     930:	3cc000ef          	jal	cfc <wait>

  exit(0);
     934:	4501                	li	a0,0
     936:	3be000ef          	jal	cf4 <exit>
    kill(pid1);
     93a:	8526                	mv	a0,s1
     93c:	3e8000ef          	jal	d24 <kill>
    kill(pid2);
     940:	854a                	mv	a0,s2
     942:	3e2000ef          	jal	d24 <kill>
     946:	b7c5                	j	926 <iter+0xaa>

0000000000000948 <main>:
}

int
main()
{
     948:	1101                	addi	sp,sp,-32
     94a:	ec06                	sd	ra,24(sp)
     94c:	e822                	sd	s0,16(sp)
     94e:	e426                	sd	s1,8(sp)
     950:	e04a                	sd	s2,0(sp)
     952:	1000                	addi	s0,sp,32
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     954:	4951                	li	s2,20
    rand_next += 1;
     956:	00001497          	auipc	s1,0x1
     95a:	6aa48493          	addi	s1,s1,1706 # 2000 <rand_next>
     95e:	a809                	j	970 <main+0x28>
      iter();
     960:	f1dff0ef          	jal	87c <iter>
    sleep(20);
     964:	854a                	mv	a0,s2
     966:	41e000ef          	jal	d84 <sleep>
    rand_next += 1;
     96a:	609c                	ld	a5,0(s1)
     96c:	0785                	addi	a5,a5,1
     96e:	e09c                	sd	a5,0(s1)
    int pid = fork();
     970:	37c000ef          	jal	cec <fork>
    if(pid == 0){
     974:	d575                	beqz	a0,960 <main+0x18>
    if(pid > 0){
     976:	fea057e3          	blez	a0,964 <main+0x1c>
      wait(0);
     97a:	4501                	li	a0,0
     97c:	380000ef          	jal	cfc <wait>
     980:	b7d5                	j	964 <main+0x1c>

0000000000000982 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
     982:	1141                	addi	sp,sp,-16
     984:	e406                	sd	ra,8(sp)
     986:	e022                	sd	s0,0(sp)
     988:	0800                	addi	s0,sp,16
  extern int main();
  main();
     98a:	fbfff0ef          	jal	948 <main>
  exit(0);
     98e:	4501                	li	a0,0
     990:	364000ef          	jal	cf4 <exit>

0000000000000994 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
     994:	1141                	addi	sp,sp,-16
     996:	e406                	sd	ra,8(sp)
     998:	e022                	sd	s0,0(sp)
     99a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
     99c:	87aa                	mv	a5,a0
     99e:	0585                	addi	a1,a1,1
     9a0:	0785                	addi	a5,a5,1
     9a2:	fff5c703          	lbu	a4,-1(a1)
     9a6:	fee78fa3          	sb	a4,-1(a5)
     9aa:	fb75                	bnez	a4,99e <strcpy+0xa>
    ;
  return os;
}
     9ac:	60a2                	ld	ra,8(sp)
     9ae:	6402                	ld	s0,0(sp)
     9b0:	0141                	addi	sp,sp,16
     9b2:	8082                	ret

00000000000009b4 <strcmp>:

int strcmp(const char *p, const char *q)
{
     9b4:	1141                	addi	sp,sp,-16
     9b6:	e406                	sd	ra,8(sp)
     9b8:	e022                	sd	s0,0(sp)
     9ba:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
     9bc:	00054783          	lbu	a5,0(a0)
     9c0:	cb91                	beqz	a5,9d4 <strcmp+0x20>
     9c2:	0005c703          	lbu	a4,0(a1)
     9c6:	00f71763          	bne	a4,a5,9d4 <strcmp+0x20>
    p++, q++;
     9ca:	0505                	addi	a0,a0,1
     9cc:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
     9ce:	00054783          	lbu	a5,0(a0)
     9d2:	fbe5                	bnez	a5,9c2 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     9d4:	0005c503          	lbu	a0,0(a1)
}
     9d8:	40a7853b          	subw	a0,a5,a0
     9dc:	60a2                	ld	ra,8(sp)
     9de:	6402                	ld	s0,0(sp)
     9e0:	0141                	addi	sp,sp,16
     9e2:	8082                	ret

00000000000009e4 <strlen>:

uint strlen(const char *s)
{
     9e4:	1141                	addi	sp,sp,-16
     9e6:	e406                	sd	ra,8(sp)
     9e8:	e022                	sd	s0,0(sp)
     9ea:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
     9ec:	00054783          	lbu	a5,0(a0)
     9f0:	cf99                	beqz	a5,a0e <strlen+0x2a>
     9f2:	0505                	addi	a0,a0,1
     9f4:	87aa                	mv	a5,a0
     9f6:	86be                	mv	a3,a5
     9f8:	0785                	addi	a5,a5,1
     9fa:	fff7c703          	lbu	a4,-1(a5)
     9fe:	ff65                	bnez	a4,9f6 <strlen+0x12>
     a00:	40a6853b          	subw	a0,a3,a0
     a04:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     a06:	60a2                	ld	ra,8(sp)
     a08:	6402                	ld	s0,0(sp)
     a0a:	0141                	addi	sp,sp,16
     a0c:	8082                	ret
  for (n = 0; s[n]; n++)
     a0e:	4501                	li	a0,0
     a10:	bfdd                	j	a06 <strlen+0x22>

0000000000000a12 <memset>:

void *
memset(void *dst, int c, uint n)
{
     a12:	1141                	addi	sp,sp,-16
     a14:	e406                	sd	ra,8(sp)
     a16:	e022                	sd	s0,0(sp)
     a18:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
     a1a:	ca19                	beqz	a2,a30 <memset+0x1e>
     a1c:	87aa                	mv	a5,a0
     a1e:	1602                	slli	a2,a2,0x20
     a20:	9201                	srli	a2,a2,0x20
     a22:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
     a26:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
     a2a:	0785                	addi	a5,a5,1
     a2c:	fee79de3          	bne	a5,a4,a26 <memset+0x14>
  }
  return dst;
}
     a30:	60a2                	ld	ra,8(sp)
     a32:	6402                	ld	s0,0(sp)
     a34:	0141                	addi	sp,sp,16
     a36:	8082                	ret

0000000000000a38 <strchr>:

char *
strchr(const char *s, char c)
{
     a38:	1141                	addi	sp,sp,-16
     a3a:	e406                	sd	ra,8(sp)
     a3c:	e022                	sd	s0,0(sp)
     a3e:	0800                	addi	s0,sp,16
  for (; *s; s++)
     a40:	00054783          	lbu	a5,0(a0)
     a44:	cf81                	beqz	a5,a5c <strchr+0x24>
    if (*s == c)
     a46:	00f58763          	beq	a1,a5,a54 <strchr+0x1c>
  for (; *s; s++)
     a4a:	0505                	addi	a0,a0,1
     a4c:	00054783          	lbu	a5,0(a0)
     a50:	fbfd                	bnez	a5,a46 <strchr+0xe>
      return (char *)s;
  return 0;
     a52:	4501                	li	a0,0
}
     a54:	60a2                	ld	ra,8(sp)
     a56:	6402                	ld	s0,0(sp)
     a58:	0141                	addi	sp,sp,16
     a5a:	8082                	ret
  return 0;
     a5c:	4501                	li	a0,0
     a5e:	bfdd                	j	a54 <strchr+0x1c>

0000000000000a60 <gets>:

char *
gets(char *buf, int max)
{
     a60:	7159                	addi	sp,sp,-112
     a62:	f486                	sd	ra,104(sp)
     a64:	f0a2                	sd	s0,96(sp)
     a66:	eca6                	sd	s1,88(sp)
     a68:	e8ca                	sd	s2,80(sp)
     a6a:	e4ce                	sd	s3,72(sp)
     a6c:	e0d2                	sd	s4,64(sp)
     a6e:	fc56                	sd	s5,56(sp)
     a70:	f85a                	sd	s6,48(sp)
     a72:	f45e                	sd	s7,40(sp)
     a74:	f062                	sd	s8,32(sp)
     a76:	ec66                	sd	s9,24(sp)
     a78:	e86a                	sd	s10,16(sp)
     a7a:	1880                	addi	s0,sp,112
     a7c:	8caa                	mv	s9,a0
     a7e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
     a80:	892a                	mv	s2,a0
     a82:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
     a84:	f9f40b13          	addi	s6,s0,-97
     a88:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
     a8a:	4ba9                	li	s7,10
     a8c:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
     a8e:	8d26                	mv	s10,s1
     a90:	0014899b          	addiw	s3,s1,1
     a94:	84ce                	mv	s1,s3
     a96:	0349d563          	bge	s3,s4,ac0 <gets+0x60>
    cc = read(0, &c, 1);
     a9a:	8656                	mv	a2,s5
     a9c:	85da                	mv	a1,s6
     a9e:	4501                	li	a0,0
     aa0:	26c000ef          	jal	d0c <read>
    if (cc < 1)
     aa4:	00a05e63          	blez	a0,ac0 <gets+0x60>
    buf[i++] = c;
     aa8:	f9f44783          	lbu	a5,-97(s0)
     aac:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
     ab0:	01778763          	beq	a5,s7,abe <gets+0x5e>
     ab4:	0905                	addi	s2,s2,1
     ab6:	fd879ce3          	bne	a5,s8,a8e <gets+0x2e>
    buf[i++] = c;
     aba:	8d4e                	mv	s10,s3
     abc:	a011                	j	ac0 <gets+0x60>
     abe:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
     ac0:	9d66                	add	s10,s10,s9
     ac2:	000d0023          	sb	zero,0(s10)
  return buf;
}
     ac6:	8566                	mv	a0,s9
     ac8:	70a6                	ld	ra,104(sp)
     aca:	7406                	ld	s0,96(sp)
     acc:	64e6                	ld	s1,88(sp)
     ace:	6946                	ld	s2,80(sp)
     ad0:	69a6                	ld	s3,72(sp)
     ad2:	6a06                	ld	s4,64(sp)
     ad4:	7ae2                	ld	s5,56(sp)
     ad6:	7b42                	ld	s6,48(sp)
     ad8:	7ba2                	ld	s7,40(sp)
     ada:	7c02                	ld	s8,32(sp)
     adc:	6ce2                	ld	s9,24(sp)
     ade:	6d42                	ld	s10,16(sp)
     ae0:	6165                	addi	sp,sp,112
     ae2:	8082                	ret

0000000000000ae4 <stat>:

int stat(const char *n, struct stat *st)
{
     ae4:	1101                	addi	sp,sp,-32
     ae6:	ec06                	sd	ra,24(sp)
     ae8:	e822                	sd	s0,16(sp)
     aea:	e04a                	sd	s2,0(sp)
     aec:	1000                	addi	s0,sp,32
     aee:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     af0:	4581                	li	a1,0
     af2:	242000ef          	jal	d34 <open>
  if (fd < 0)
     af6:	02054263          	bltz	a0,b1a <stat+0x36>
     afa:	e426                	sd	s1,8(sp)
     afc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     afe:	85ca                	mv	a1,s2
     b00:	24c000ef          	jal	d4c <fstat>
     b04:	892a                	mv	s2,a0
  close(fd);
     b06:	8526                	mv	a0,s1
     b08:	214000ef          	jal	d1c <close>
  return r;
     b0c:	64a2                	ld	s1,8(sp)
}
     b0e:	854a                	mv	a0,s2
     b10:	60e2                	ld	ra,24(sp)
     b12:	6442                	ld	s0,16(sp)
     b14:	6902                	ld	s2,0(sp)
     b16:	6105                	addi	sp,sp,32
     b18:	8082                	ret
    return -1;
     b1a:	597d                	li	s2,-1
     b1c:	bfcd                	j	b0e <stat+0x2a>

0000000000000b1e <atoi>:

int atoi(const char *s)
{
     b1e:	1141                	addi	sp,sp,-16
     b20:	e406                	sd	ra,8(sp)
     b22:	e022                	sd	s0,0(sp)
     b24:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
     b26:	00054683          	lbu	a3,0(a0)
     b2a:	fd06879b          	addiw	a5,a3,-48
     b2e:	0ff7f793          	zext.b	a5,a5
     b32:	4625                	li	a2,9
     b34:	02f66963          	bltu	a2,a5,b66 <atoi+0x48>
     b38:	872a                	mv	a4,a0
  n = 0;
     b3a:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
     b3c:	0705                	addi	a4,a4,1
     b3e:	0025179b          	slliw	a5,a0,0x2
     b42:	9fa9                	addw	a5,a5,a0
     b44:	0017979b          	slliw	a5,a5,0x1
     b48:	9fb5                	addw	a5,a5,a3
     b4a:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
     b4e:	00074683          	lbu	a3,0(a4)
     b52:	fd06879b          	addiw	a5,a3,-48
     b56:	0ff7f793          	zext.b	a5,a5
     b5a:	fef671e3          	bgeu	a2,a5,b3c <atoi+0x1e>
  return n;
}
     b5e:	60a2                	ld	ra,8(sp)
     b60:	6402                	ld	s0,0(sp)
     b62:	0141                	addi	sp,sp,16
     b64:	8082                	ret
  n = 0;
     b66:	4501                	li	a0,0
     b68:	bfdd                	j	b5e <atoi+0x40>

0000000000000b6a <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
     b6a:	1141                	addi	sp,sp,-16
     b6c:	e406                	sd	ra,8(sp)
     b6e:	e022                	sd	s0,0(sp)
     b70:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
     b72:	02b57563          	bgeu	a0,a1,b9c <memmove+0x32>
  {
    while (n-- > 0)
     b76:	00c05f63          	blez	a2,b94 <memmove+0x2a>
     b7a:	1602                	slli	a2,a2,0x20
     b7c:	9201                	srli	a2,a2,0x20
     b7e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b82:	872a                	mv	a4,a0
      *dst++ = *src++;
     b84:	0585                	addi	a1,a1,1
     b86:	0705                	addi	a4,a4,1
     b88:	fff5c683          	lbu	a3,-1(a1)
     b8c:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
     b90:	fee79ae3          	bne	a5,a4,b84 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b94:	60a2                	ld	ra,8(sp)
     b96:	6402                	ld	s0,0(sp)
     b98:	0141                	addi	sp,sp,16
     b9a:	8082                	ret
    dst += n;
     b9c:	00c50733          	add	a4,a0,a2
    src += n;
     ba0:	95b2                	add	a1,a1,a2
    while (n-- > 0)
     ba2:	fec059e3          	blez	a2,b94 <memmove+0x2a>
     ba6:	fff6079b          	addiw	a5,a2,-1
     baa:	1782                	slli	a5,a5,0x20
     bac:	9381                	srli	a5,a5,0x20
     bae:	fff7c793          	not	a5,a5
     bb2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     bb4:	15fd                	addi	a1,a1,-1
     bb6:	177d                	addi	a4,a4,-1
     bb8:	0005c683          	lbu	a3,0(a1)
     bbc:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
     bc0:	fef71ae3          	bne	a4,a5,bb4 <memmove+0x4a>
     bc4:	bfc1                	j	b94 <memmove+0x2a>

0000000000000bc6 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
     bc6:	1141                	addi	sp,sp,-16
     bc8:	e406                	sd	ra,8(sp)
     bca:	e022                	sd	s0,0(sp)
     bcc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
     bce:	ca0d                	beqz	a2,c00 <memcmp+0x3a>
     bd0:	fff6069b          	addiw	a3,a2,-1
     bd4:	1682                	slli	a3,a3,0x20
     bd6:	9281                	srli	a3,a3,0x20
     bd8:	0685                	addi	a3,a3,1
     bda:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
     bdc:	00054783          	lbu	a5,0(a0)
     be0:	0005c703          	lbu	a4,0(a1)
     be4:	00e79863          	bne	a5,a4,bf4 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
     be8:	0505                	addi	a0,a0,1
    p2++;
     bea:	0585                	addi	a1,a1,1
  while (n-- > 0)
     bec:	fed518e3          	bne	a0,a3,bdc <memcmp+0x16>
  }
  return 0;
     bf0:	4501                	li	a0,0
     bf2:	a019                	j	bf8 <memcmp+0x32>
      return *p1 - *p2;
     bf4:	40e7853b          	subw	a0,a5,a4
}
     bf8:	60a2                	ld	ra,8(sp)
     bfa:	6402                	ld	s0,0(sp)
     bfc:	0141                	addi	sp,sp,16
     bfe:	8082                	ret
  return 0;
     c00:	4501                	li	a0,0
     c02:	bfdd                	j	bf8 <memcmp+0x32>

0000000000000c04 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c04:	1141                	addi	sp,sp,-16
     c06:	e406                	sd	ra,8(sp)
     c08:	e022                	sd	s0,0(sp)
     c0a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c0c:	f5fff0ef          	jal	b6a <memmove>
}
     c10:	60a2                	ld	ra,8(sp)
     c12:	6402                	ld	s0,0(sp)
     c14:	0141                	addi	sp,sp,16
     c16:	8082                	ret

0000000000000c18 <strcat>:

char *strcat(char *dst, const char *src)
{
     c18:	1141                	addi	sp,sp,-16
     c1a:	e406                	sd	ra,8(sp)
     c1c:	e022                	sd	s0,0(sp)
     c1e:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
     c20:	00054783          	lbu	a5,0(a0)
     c24:	c795                	beqz	a5,c50 <strcat+0x38>
  char *p = dst;
     c26:	87aa                	mv	a5,a0
    p++;
     c28:	0785                	addi	a5,a5,1
  while (*p)
     c2a:	0007c703          	lbu	a4,0(a5)
     c2e:	ff6d                	bnez	a4,c28 <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
     c30:	0005c703          	lbu	a4,0(a1)
     c34:	cb01                	beqz	a4,c44 <strcat+0x2c>
  {
    *p = *src;
     c36:	00e78023          	sb	a4,0(a5)
    p++;
     c3a:	0785                	addi	a5,a5,1
    src++;
     c3c:	0585                	addi	a1,a1,1
  while (*src)
     c3e:	0005c703          	lbu	a4,0(a1)
     c42:	fb75                	bnez	a4,c36 <strcat+0x1e>
  }

  *p = 0;
     c44:	00078023          	sb	zero,0(a5)

  return dst;
}
     c48:	60a2                	ld	ra,8(sp)
     c4a:	6402                	ld	s0,0(sp)
     c4c:	0141                	addi	sp,sp,16
     c4e:	8082                	ret
  char *p = dst;
     c50:	87aa                	mv	a5,a0
     c52:	bff9                	j	c30 <strcat+0x18>

0000000000000c54 <isdir>:

int isdir(char *path)
{
     c54:	7179                	addi	sp,sp,-48
     c56:	f406                	sd	ra,40(sp)
     c58:	f022                	sd	s0,32(sp)
     c5a:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
     c5c:	fd840593          	addi	a1,s0,-40
     c60:	e85ff0ef          	jal	ae4 <stat>
     c64:	00054b63          	bltz	a0,c7a <isdir+0x26>
    return 0;
  return st.type == T_DIR;
     c68:	fe041503          	lh	a0,-32(s0)
     c6c:	157d                	addi	a0,a0,-1
     c6e:	00153513          	seqz	a0,a0
}
     c72:	70a2                	ld	ra,40(sp)
     c74:	7402                	ld	s0,32(sp)
     c76:	6145                	addi	sp,sp,48
     c78:	8082                	ret
    return 0;
     c7a:	4501                	li	a0,0
     c7c:	bfdd                	j	c72 <isdir+0x1e>

0000000000000c7e <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
     c7e:	7139                	addi	sp,sp,-64
     c80:	fc06                	sd	ra,56(sp)
     c82:	f822                	sd	s0,48(sp)
     c84:	f426                	sd	s1,40(sp)
     c86:	f04a                	sd	s2,32(sp)
     c88:	ec4e                	sd	s3,24(sp)
     c8a:	e852                	sd	s4,16(sp)
     c8c:	e456                	sd	s5,8(sp)
     c8e:	0080                	addi	s0,sp,64
     c90:	89aa                	mv	s3,a0
     c92:	8aae                	mv	s5,a1
     c94:	84b2                	mv	s1,a2
     c96:	8a36                	mv	s4,a3
  int dn = strlen(dir);
     c98:	d4dff0ef          	jal	9e4 <strlen>
     c9c:	892a                	mv	s2,a0
  int nn = strlen(filename);
     c9e:	8556                	mv	a0,s5
     ca0:	d45ff0ef          	jal	9e4 <strlen>
  int need = dn + 1 + nn + 1;
     ca4:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
     ca8:	9fa9                	addw	a5,a5,a0
    return 0;
     caa:	4501                	li	a0,0
  if (need > bufsize)
     cac:	0347d763          	bge	a5,s4,cda <joinpath+0x5c>
  strcpy(out_buffer, dir);
     cb0:	85ce                	mv	a1,s3
     cb2:	8526                	mv	a0,s1
     cb4:	ce1ff0ef          	jal	994 <strcpy>
  if (dir[dn - 1] != '/')
     cb8:	99ca                	add	s3,s3,s2
     cba:	fff9c703          	lbu	a4,-1(s3)
     cbe:	02f00793          	li	a5,47
     cc2:	00f70763          	beq	a4,a5,cd0 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
     cc6:	9926                	add	s2,s2,s1
     cc8:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
     ccc:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
     cd0:	85d6                	mv	a1,s5
     cd2:	8526                	mv	a0,s1
     cd4:	f45ff0ef          	jal	c18 <strcat>
  return out_buffer;
     cd8:	8526                	mv	a0,s1
}
     cda:	70e2                	ld	ra,56(sp)
     cdc:	7442                	ld	s0,48(sp)
     cde:	74a2                	ld	s1,40(sp)
     ce0:	7902                	ld	s2,32(sp)
     ce2:	69e2                	ld	s3,24(sp)
     ce4:	6a42                	ld	s4,16(sp)
     ce6:	6aa2                	ld	s5,8(sp)
     ce8:	6121                	addi	sp,sp,64
     cea:	8082                	ret

0000000000000cec <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     cec:	4885                	li	a7,1
 ecall
     cee:	00000073          	ecall
 ret
     cf2:	8082                	ret

0000000000000cf4 <exit>:
.global exit
exit:
 li a7, SYS_exit
     cf4:	4889                	li	a7,2
 ecall
     cf6:	00000073          	ecall
 ret
     cfa:	8082                	ret

0000000000000cfc <wait>:
.global wait
wait:
 li a7, SYS_wait
     cfc:	488d                	li	a7,3
 ecall
     cfe:	00000073          	ecall
 ret
     d02:	8082                	ret

0000000000000d04 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d04:	4891                	li	a7,4
 ecall
     d06:	00000073          	ecall
 ret
     d0a:	8082                	ret

0000000000000d0c <read>:
.global read
read:
 li a7, SYS_read
     d0c:	4895                	li	a7,5
 ecall
     d0e:	00000073          	ecall
 ret
     d12:	8082                	ret

0000000000000d14 <write>:
.global write
write:
 li a7, SYS_write
     d14:	48c1                	li	a7,16
 ecall
     d16:	00000073          	ecall
 ret
     d1a:	8082                	ret

0000000000000d1c <close>:
.global close
close:
 li a7, SYS_close
     d1c:	48d5                	li	a7,21
 ecall
     d1e:	00000073          	ecall
 ret
     d22:	8082                	ret

0000000000000d24 <kill>:
.global kill
kill:
 li a7, SYS_kill
     d24:	4899                	li	a7,6
 ecall
     d26:	00000073          	ecall
 ret
     d2a:	8082                	ret

0000000000000d2c <exec>:
.global exec
exec:
 li a7, SYS_exec
     d2c:	489d                	li	a7,7
 ecall
     d2e:	00000073          	ecall
 ret
     d32:	8082                	ret

0000000000000d34 <open>:
.global open
open:
 li a7, SYS_open
     d34:	48bd                	li	a7,15
 ecall
     d36:	00000073          	ecall
 ret
     d3a:	8082                	ret

0000000000000d3c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     d3c:	48c5                	li	a7,17
 ecall
     d3e:	00000073          	ecall
 ret
     d42:	8082                	ret

0000000000000d44 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     d44:	48c9                	li	a7,18
 ecall
     d46:	00000073          	ecall
 ret
     d4a:	8082                	ret

0000000000000d4c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     d4c:	48a1                	li	a7,8
 ecall
     d4e:	00000073          	ecall
 ret
     d52:	8082                	ret

0000000000000d54 <link>:
.global link
link:
 li a7, SYS_link
     d54:	48cd                	li	a7,19
 ecall
     d56:	00000073          	ecall
 ret
     d5a:	8082                	ret

0000000000000d5c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     d5c:	48d1                	li	a7,20
 ecall
     d5e:	00000073          	ecall
 ret
     d62:	8082                	ret

0000000000000d64 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d64:	48a5                	li	a7,9
 ecall
     d66:	00000073          	ecall
 ret
     d6a:	8082                	ret

0000000000000d6c <dup>:
.global dup
dup:
 li a7, SYS_dup
     d6c:	48a9                	li	a7,10
 ecall
     d6e:	00000073          	ecall
 ret
     d72:	8082                	ret

0000000000000d74 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d74:	48ad                	li	a7,11
 ecall
     d76:	00000073          	ecall
 ret
     d7a:	8082                	ret

0000000000000d7c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     d7c:	48b1                	li	a7,12
 ecall
     d7e:	00000073          	ecall
 ret
     d82:	8082                	ret

0000000000000d84 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     d84:	48b5                	li	a7,13
 ecall
     d86:	00000073          	ecall
 ret
     d8a:	8082                	ret

0000000000000d8c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d8c:	48b9                	li	a7,14
 ecall
     d8e:	00000073          	ecall
 ret
     d92:	8082                	ret

0000000000000d94 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
     d94:	48d9                	li	a7,22
 ecall
     d96:	00000073          	ecall
 ret
     d9a:	8082                	ret

0000000000000d9c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     d9c:	1101                	addi	sp,sp,-32
     d9e:	ec06                	sd	ra,24(sp)
     da0:	e822                	sd	s0,16(sp)
     da2:	1000                	addi	s0,sp,32
     da4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     da8:	4605                	li	a2,1
     daa:	fef40593          	addi	a1,s0,-17
     dae:	f67ff0ef          	jal	d14 <write>
}
     db2:	60e2                	ld	ra,24(sp)
     db4:	6442                	ld	s0,16(sp)
     db6:	6105                	addi	sp,sp,32
     db8:	8082                	ret

0000000000000dba <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     dba:	7139                	addi	sp,sp,-64
     dbc:	fc06                	sd	ra,56(sp)
     dbe:	f822                	sd	s0,48(sp)
     dc0:	f426                	sd	s1,40(sp)
     dc2:	f04a                	sd	s2,32(sp)
     dc4:	ec4e                	sd	s3,24(sp)
     dc6:	0080                	addi	s0,sp,64
     dc8:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     dca:	c299                	beqz	a3,dd0 <printint+0x16>
     dcc:	0605ce63          	bltz	a1,e48 <printint+0x8e>
  neg = 0;
     dd0:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     dd2:	fc040313          	addi	t1,s0,-64
  neg = 0;
     dd6:	869a                	mv	a3,t1
  i = 0;
     dd8:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     dda:	00001817          	auipc	a6,0x1
     dde:	84680813          	addi	a6,a6,-1978 # 1620 <digits>
     de2:	88be                	mv	a7,a5
     de4:	0017851b          	addiw	a0,a5,1
     de8:	87aa                	mv	a5,a0
     dea:	02c5f73b          	remuw	a4,a1,a2
     dee:	1702                	slli	a4,a4,0x20
     df0:	9301                	srli	a4,a4,0x20
     df2:	9742                	add	a4,a4,a6
     df4:	00074703          	lbu	a4,0(a4)
     df8:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     dfc:	872e                	mv	a4,a1
     dfe:	02c5d5bb          	divuw	a1,a1,a2
     e02:	0685                	addi	a3,a3,1
     e04:	fcc77fe3          	bgeu	a4,a2,de2 <printint+0x28>
  if(neg)
     e08:	000e0c63          	beqz	t3,e20 <printint+0x66>
    buf[i++] = '-';
     e0c:	fd050793          	addi	a5,a0,-48
     e10:	00878533          	add	a0,a5,s0
     e14:	02d00793          	li	a5,45
     e18:	fef50823          	sb	a5,-16(a0)
     e1c:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
     e20:	fff7899b          	addiw	s3,a5,-1
     e24:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
     e28:	fff4c583          	lbu	a1,-1(s1)
     e2c:	854a                	mv	a0,s2
     e2e:	f6fff0ef          	jal	d9c <putc>
  while(--i >= 0)
     e32:	39fd                	addiw	s3,s3,-1
     e34:	14fd                	addi	s1,s1,-1
     e36:	fe09d9e3          	bgez	s3,e28 <printint+0x6e>
}
     e3a:	70e2                	ld	ra,56(sp)
     e3c:	7442                	ld	s0,48(sp)
     e3e:	74a2                	ld	s1,40(sp)
     e40:	7902                	ld	s2,32(sp)
     e42:	69e2                	ld	s3,24(sp)
     e44:	6121                	addi	sp,sp,64
     e46:	8082                	ret
    x = -xx;
     e48:	40b005bb          	negw	a1,a1
    neg = 1;
     e4c:	4e05                	li	t3,1
    x = -xx;
     e4e:	b751                	j	dd2 <printint+0x18>

0000000000000e50 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e50:	711d                	addi	sp,sp,-96
     e52:	ec86                	sd	ra,88(sp)
     e54:	e8a2                	sd	s0,80(sp)
     e56:	e4a6                	sd	s1,72(sp)
     e58:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     e5a:	0005c483          	lbu	s1,0(a1)
     e5e:	26048663          	beqz	s1,10ca <vprintf+0x27a>
     e62:	e0ca                	sd	s2,64(sp)
     e64:	fc4e                	sd	s3,56(sp)
     e66:	f852                	sd	s4,48(sp)
     e68:	f456                	sd	s5,40(sp)
     e6a:	f05a                	sd	s6,32(sp)
     e6c:	ec5e                	sd	s7,24(sp)
     e6e:	e862                	sd	s8,16(sp)
     e70:	e466                	sd	s9,8(sp)
     e72:	8b2a                	mv	s6,a0
     e74:	8a2e                	mv	s4,a1
     e76:	8bb2                	mv	s7,a2
  state = 0;
     e78:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     e7a:	4901                	li	s2,0
     e7c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     e7e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     e82:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     e86:	06c00c93          	li	s9,108
     e8a:	a00d                	j	eac <vprintf+0x5c>
        putc(fd, c0);
     e8c:	85a6                	mv	a1,s1
     e8e:	855a                	mv	a0,s6
     e90:	f0dff0ef          	jal	d9c <putc>
     e94:	a019                	j	e9a <vprintf+0x4a>
    } else if(state == '%'){
     e96:	03598363          	beq	s3,s5,ebc <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
     e9a:	0019079b          	addiw	a5,s2,1
     e9e:	893e                	mv	s2,a5
     ea0:	873e                	mv	a4,a5
     ea2:	97d2                	add	a5,a5,s4
     ea4:	0007c483          	lbu	s1,0(a5)
     ea8:	20048963          	beqz	s1,10ba <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
     eac:	0004879b          	sext.w	a5,s1
    if(state == 0){
     eb0:	fe0993e3          	bnez	s3,e96 <vprintf+0x46>
      if(c0 == '%'){
     eb4:	fd579ce3          	bne	a5,s5,e8c <vprintf+0x3c>
        state = '%';
     eb8:	89be                	mv	s3,a5
     eba:	b7c5                	j	e9a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     ebc:	00ea06b3          	add	a3,s4,a4
     ec0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     ec4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     ec6:	c681                	beqz	a3,ece <vprintf+0x7e>
     ec8:	9752                	add	a4,a4,s4
     eca:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     ece:	03878e63          	beq	a5,s8,f0a <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
     ed2:	05978863          	beq	a5,s9,f22 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     ed6:	07500713          	li	a4,117
     eda:	0ee78263          	beq	a5,a4,fbe <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     ede:	07800713          	li	a4,120
     ee2:	12e78463          	beq	a5,a4,100a <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     ee6:	07000713          	li	a4,112
     eea:	14e78963          	beq	a5,a4,103c <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
     eee:	07300713          	li	a4,115
     ef2:	18e78863          	beq	a5,a4,1082 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     ef6:	02500713          	li	a4,37
     efa:	04e79463          	bne	a5,a4,f42 <vprintf+0xf2>
        putc(fd, '%');
     efe:	85ba                	mv	a1,a4
     f00:	855a                	mv	a0,s6
     f02:	e9bff0ef          	jal	d9c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
     f06:	4981                	li	s3,0
     f08:	bf49                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     f0a:	008b8493          	addi	s1,s7,8
     f0e:	4685                	li	a3,1
     f10:	4629                	li	a2,10
     f12:	000ba583          	lw	a1,0(s7)
     f16:	855a                	mv	a0,s6
     f18:	ea3ff0ef          	jal	dba <printint>
     f1c:	8ba6                	mv	s7,s1
      state = 0;
     f1e:	4981                	li	s3,0
     f20:	bfad                	j	e9a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     f22:	06400793          	li	a5,100
     f26:	02f68963          	beq	a3,a5,f58 <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f2a:	06c00793          	li	a5,108
     f2e:	04f68263          	beq	a3,a5,f72 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
     f32:	07500793          	li	a5,117
     f36:	0af68063          	beq	a3,a5,fd6 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
     f3a:	07800793          	li	a5,120
     f3e:	0ef68263          	beq	a3,a5,1022 <vprintf+0x1d2>
        putc(fd, '%');
     f42:	02500593          	li	a1,37
     f46:	855a                	mv	a0,s6
     f48:	e55ff0ef          	jal	d9c <putc>
        putc(fd, c0);
     f4c:	85a6                	mv	a1,s1
     f4e:	855a                	mv	a0,s6
     f50:	e4dff0ef          	jal	d9c <putc>
      state = 0;
     f54:	4981                	li	s3,0
     f56:	b791                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f58:	008b8493          	addi	s1,s7,8
     f5c:	4685                	li	a3,1
     f5e:	4629                	li	a2,10
     f60:	000ba583          	lw	a1,0(s7)
     f64:	855a                	mv	a0,s6
     f66:	e55ff0ef          	jal	dba <printint>
        i += 1;
     f6a:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     f6c:	8ba6                	mv	s7,s1
      state = 0;
     f6e:	4981                	li	s3,0
        i += 1;
     f70:	b72d                	j	e9a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f72:	06400793          	li	a5,100
     f76:	02f60763          	beq	a2,a5,fa4 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     f7a:	07500793          	li	a5,117
     f7e:	06f60963          	beq	a2,a5,ff0 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     f82:	07800793          	li	a5,120
     f86:	faf61ee3          	bne	a2,a5,f42 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f8a:	008b8493          	addi	s1,s7,8
     f8e:	4681                	li	a3,0
     f90:	4641                	li	a2,16
     f92:	000ba583          	lw	a1,0(s7)
     f96:	855a                	mv	a0,s6
     f98:	e23ff0ef          	jal	dba <printint>
        i += 2;
     f9c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     f9e:	8ba6                	mv	s7,s1
      state = 0;
     fa0:	4981                	li	s3,0
        i += 2;
     fa2:	bde5                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     fa4:	008b8493          	addi	s1,s7,8
     fa8:	4685                	li	a3,1
     faa:	4629                	li	a2,10
     fac:	000ba583          	lw	a1,0(s7)
     fb0:	855a                	mv	a0,s6
     fb2:	e09ff0ef          	jal	dba <printint>
        i += 2;
     fb6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     fb8:	8ba6                	mv	s7,s1
      state = 0;
     fba:	4981                	li	s3,0
        i += 2;
     fbc:	bdf9                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
     fbe:	008b8493          	addi	s1,s7,8
     fc2:	4681                	li	a3,0
     fc4:	4629                	li	a2,10
     fc6:	000ba583          	lw	a1,0(s7)
     fca:	855a                	mv	a0,s6
     fcc:	defff0ef          	jal	dba <printint>
     fd0:	8ba6                	mv	s7,s1
      state = 0;
     fd2:	4981                	li	s3,0
     fd4:	b5d9                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     fd6:	008b8493          	addi	s1,s7,8
     fda:	4681                	li	a3,0
     fdc:	4629                	li	a2,10
     fde:	000ba583          	lw	a1,0(s7)
     fe2:	855a                	mv	a0,s6
     fe4:	dd7ff0ef          	jal	dba <printint>
        i += 1;
     fe8:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     fea:	8ba6                	mv	s7,s1
      state = 0;
     fec:	4981                	li	s3,0
        i += 1;
     fee:	b575                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     ff0:	008b8493          	addi	s1,s7,8
     ff4:	4681                	li	a3,0
     ff6:	4629                	li	a2,10
     ff8:	000ba583          	lw	a1,0(s7)
     ffc:	855a                	mv	a0,s6
     ffe:	dbdff0ef          	jal	dba <printint>
        i += 2;
    1002:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1004:	8ba6                	mv	s7,s1
      state = 0;
    1006:	4981                	li	s3,0
        i += 2;
    1008:	bd49                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    100a:	008b8493          	addi	s1,s7,8
    100e:	4681                	li	a3,0
    1010:	4641                	li	a2,16
    1012:	000ba583          	lw	a1,0(s7)
    1016:	855a                	mv	a0,s6
    1018:	da3ff0ef          	jal	dba <printint>
    101c:	8ba6                	mv	s7,s1
      state = 0;
    101e:	4981                	li	s3,0
    1020:	bdad                	j	e9a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1022:	008b8493          	addi	s1,s7,8
    1026:	4681                	li	a3,0
    1028:	4641                	li	a2,16
    102a:	000ba583          	lw	a1,0(s7)
    102e:	855a                	mv	a0,s6
    1030:	d8bff0ef          	jal	dba <printint>
        i += 1;
    1034:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    1036:	8ba6                	mv	s7,s1
      state = 0;
    1038:	4981                	li	s3,0
        i += 1;
    103a:	b585                	j	e9a <vprintf+0x4a>
    103c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    103e:	008b8d13          	addi	s10,s7,8
    1042:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1046:	03000593          	li	a1,48
    104a:	855a                	mv	a0,s6
    104c:	d51ff0ef          	jal	d9c <putc>
  putc(fd, 'x');
    1050:	07800593          	li	a1,120
    1054:	855a                	mv	a0,s6
    1056:	d47ff0ef          	jal	d9c <putc>
    105a:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    105c:	00000b97          	auipc	s7,0x0
    1060:	5c4b8b93          	addi	s7,s7,1476 # 1620 <digits>
    1064:	03c9d793          	srli	a5,s3,0x3c
    1068:	97de                	add	a5,a5,s7
    106a:	0007c583          	lbu	a1,0(a5)
    106e:	855a                	mv	a0,s6
    1070:	d2dff0ef          	jal	d9c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1074:	0992                	slli	s3,s3,0x4
    1076:	34fd                	addiw	s1,s1,-1
    1078:	f4f5                	bnez	s1,1064 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    107a:	8bea                	mv	s7,s10
      state = 0;
    107c:	4981                	li	s3,0
    107e:	6d02                	ld	s10,0(sp)
    1080:	bd29                	j	e9a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    1082:	008b8993          	addi	s3,s7,8
    1086:	000bb483          	ld	s1,0(s7)
    108a:	cc91                	beqz	s1,10a6 <vprintf+0x256>
        for(; *s; s++)
    108c:	0004c583          	lbu	a1,0(s1)
    1090:	c195                	beqz	a1,10b4 <vprintf+0x264>
          putc(fd, *s);
    1092:	855a                	mv	a0,s6
    1094:	d09ff0ef          	jal	d9c <putc>
        for(; *s; s++)
    1098:	0485                	addi	s1,s1,1
    109a:	0004c583          	lbu	a1,0(s1)
    109e:	f9f5                	bnez	a1,1092 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
    10a0:	8bce                	mv	s7,s3
      state = 0;
    10a2:	4981                	li	s3,0
    10a4:	bbdd                	j	e9a <vprintf+0x4a>
          s = "(null)";
    10a6:	00000497          	auipc	s1,0x0
    10aa:	51248493          	addi	s1,s1,1298 # 15b8 <malloc+0x402>
        for(; *s; s++)
    10ae:	02800593          	li	a1,40
    10b2:	b7c5                	j	1092 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
    10b4:	8bce                	mv	s7,s3
      state = 0;
    10b6:	4981                	li	s3,0
    10b8:	b3cd                	j	e9a <vprintf+0x4a>
    10ba:	6906                	ld	s2,64(sp)
    10bc:	79e2                	ld	s3,56(sp)
    10be:	7a42                	ld	s4,48(sp)
    10c0:	7aa2                	ld	s5,40(sp)
    10c2:	7b02                	ld	s6,32(sp)
    10c4:	6be2                	ld	s7,24(sp)
    10c6:	6c42                	ld	s8,16(sp)
    10c8:	6ca2                	ld	s9,8(sp)
    }
  }
}
    10ca:	60e6                	ld	ra,88(sp)
    10cc:	6446                	ld	s0,80(sp)
    10ce:	64a6                	ld	s1,72(sp)
    10d0:	6125                	addi	sp,sp,96
    10d2:	8082                	ret

00000000000010d4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    10d4:	715d                	addi	sp,sp,-80
    10d6:	ec06                	sd	ra,24(sp)
    10d8:	e822                	sd	s0,16(sp)
    10da:	1000                	addi	s0,sp,32
    10dc:	e010                	sd	a2,0(s0)
    10de:	e414                	sd	a3,8(s0)
    10e0:	e818                	sd	a4,16(s0)
    10e2:	ec1c                	sd	a5,24(s0)
    10e4:	03043023          	sd	a6,32(s0)
    10e8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    10ec:	8622                	mv	a2,s0
    10ee:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    10f2:	d5fff0ef          	jal	e50 <vprintf>
}
    10f6:	60e2                	ld	ra,24(sp)
    10f8:	6442                	ld	s0,16(sp)
    10fa:	6161                	addi	sp,sp,80
    10fc:	8082                	ret

00000000000010fe <printf>:

void
printf(const char *fmt, ...)
{
    10fe:	711d                	addi	sp,sp,-96
    1100:	ec06                	sd	ra,24(sp)
    1102:	e822                	sd	s0,16(sp)
    1104:	1000                	addi	s0,sp,32
    1106:	e40c                	sd	a1,8(s0)
    1108:	e810                	sd	a2,16(s0)
    110a:	ec14                	sd	a3,24(s0)
    110c:	f018                	sd	a4,32(s0)
    110e:	f41c                	sd	a5,40(s0)
    1110:	03043823          	sd	a6,48(s0)
    1114:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1118:	00840613          	addi	a2,s0,8
    111c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1120:	85aa                	mv	a1,a0
    1122:	4505                	li	a0,1
    1124:	d2dff0ef          	jal	e50 <vprintf>
}
    1128:	60e2                	ld	ra,24(sp)
    112a:	6442                	ld	s0,16(sp)
    112c:	6125                	addi	sp,sp,96
    112e:	8082                	ret

0000000000001130 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1130:	1141                	addi	sp,sp,-16
    1132:	e406                	sd	ra,8(sp)
    1134:	e022                	sd	s0,0(sp)
    1136:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1138:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    113c:	00001797          	auipc	a5,0x1
    1140:	ed47b783          	ld	a5,-300(a5) # 2010 <freep>
    1144:	a02d                	j	116e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1146:	4618                	lw	a4,8(a2)
    1148:	9f2d                	addw	a4,a4,a1
    114a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    114e:	6398                	ld	a4,0(a5)
    1150:	6310                	ld	a2,0(a4)
    1152:	a83d                	j	1190 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1154:	ff852703          	lw	a4,-8(a0)
    1158:	9f31                	addw	a4,a4,a2
    115a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    115c:	ff053683          	ld	a3,-16(a0)
    1160:	a091                	j	11a4 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1162:	6398                	ld	a4,0(a5)
    1164:	00e7e463          	bltu	a5,a4,116c <free+0x3c>
    1168:	00e6ea63          	bltu	a3,a4,117c <free+0x4c>
{
    116c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    116e:	fed7fae3          	bgeu	a5,a3,1162 <free+0x32>
    1172:	6398                	ld	a4,0(a5)
    1174:	00e6e463          	bltu	a3,a4,117c <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1178:	fee7eae3          	bltu	a5,a4,116c <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
    117c:	ff852583          	lw	a1,-8(a0)
    1180:	6390                	ld	a2,0(a5)
    1182:	02059813          	slli	a6,a1,0x20
    1186:	01c85713          	srli	a4,a6,0x1c
    118a:	9736                	add	a4,a4,a3
    118c:	fae60de3          	beq	a2,a4,1146 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
    1190:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1194:	4790                	lw	a2,8(a5)
    1196:	02061593          	slli	a1,a2,0x20
    119a:	01c5d713          	srli	a4,a1,0x1c
    119e:	973e                	add	a4,a4,a5
    11a0:	fae68ae3          	beq	a3,a4,1154 <free+0x24>
    p->s.ptr = bp->s.ptr;
    11a4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    11a6:	00001717          	auipc	a4,0x1
    11aa:	e6f73523          	sd	a5,-406(a4) # 2010 <freep>
}
    11ae:	60a2                	ld	ra,8(sp)
    11b0:	6402                	ld	s0,0(sp)
    11b2:	0141                	addi	sp,sp,16
    11b4:	8082                	ret

00000000000011b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11b6:	7139                	addi	sp,sp,-64
    11b8:	fc06                	sd	ra,56(sp)
    11ba:	f822                	sd	s0,48(sp)
    11bc:	f04a                	sd	s2,32(sp)
    11be:	ec4e                	sd	s3,24(sp)
    11c0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11c2:	02051993          	slli	s3,a0,0x20
    11c6:	0209d993          	srli	s3,s3,0x20
    11ca:	09bd                	addi	s3,s3,15
    11cc:	0049d993          	srli	s3,s3,0x4
    11d0:	2985                	addiw	s3,s3,1
    11d2:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    11d4:	00001517          	auipc	a0,0x1
    11d8:	e3c53503          	ld	a0,-452(a0) # 2010 <freep>
    11dc:	c905                	beqz	a0,120c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11e0:	4798                	lw	a4,8(a5)
    11e2:	09377663          	bgeu	a4,s3,126e <malloc+0xb8>
    11e6:	f426                	sd	s1,40(sp)
    11e8:	e852                	sd	s4,16(sp)
    11ea:	e456                	sd	s5,8(sp)
    11ec:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    11ee:	8a4e                	mv	s4,s3
    11f0:	6705                	lui	a4,0x1
    11f2:	00e9f363          	bgeu	s3,a4,11f8 <malloc+0x42>
    11f6:	6a05                	lui	s4,0x1
    11f8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    11fc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1200:	00001497          	auipc	s1,0x1
    1204:	e1048493          	addi	s1,s1,-496 # 2010 <freep>
  if(p == (char*)-1)
    1208:	5afd                	li	s5,-1
    120a:	a83d                	j	1248 <malloc+0x92>
    120c:	f426                	sd	s1,40(sp)
    120e:	e852                	sd	s4,16(sp)
    1210:	e456                	sd	s5,8(sp)
    1212:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1214:	00001797          	auipc	a5,0x1
    1218:	1f478793          	addi	a5,a5,500 # 2408 <base>
    121c:	00001717          	auipc	a4,0x1
    1220:	def73a23          	sd	a5,-524(a4) # 2010 <freep>
    1224:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1226:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    122a:	b7d1                	j	11ee <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    122c:	6398                	ld	a4,0(a5)
    122e:	e118                	sd	a4,0(a0)
    1230:	a899                	j	1286 <malloc+0xd0>
  hp->s.size = nu;
    1232:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1236:	0541                	addi	a0,a0,16
    1238:	ef9ff0ef          	jal	1130 <free>
  return freep;
    123c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    123e:	c125                	beqz	a0,129e <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1240:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1242:	4798                	lw	a4,8(a5)
    1244:	03277163          	bgeu	a4,s2,1266 <malloc+0xb0>
    if(p == freep)
    1248:	6098                	ld	a4,0(s1)
    124a:	853e                	mv	a0,a5
    124c:	fef71ae3          	bne	a4,a5,1240 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    1250:	8552                	mv	a0,s4
    1252:	b2bff0ef          	jal	d7c <sbrk>
  if(p == (char*)-1)
    1256:	fd551ee3          	bne	a0,s5,1232 <malloc+0x7c>
        return 0;
    125a:	4501                	li	a0,0
    125c:	74a2                	ld	s1,40(sp)
    125e:	6a42                	ld	s4,16(sp)
    1260:	6aa2                	ld	s5,8(sp)
    1262:	6b02                	ld	s6,0(sp)
    1264:	a03d                	j	1292 <malloc+0xdc>
    1266:	74a2                	ld	s1,40(sp)
    1268:	6a42                	ld	s4,16(sp)
    126a:	6aa2                	ld	s5,8(sp)
    126c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    126e:	fae90fe3          	beq	s2,a4,122c <malloc+0x76>
        p->s.size -= nunits;
    1272:	4137073b          	subw	a4,a4,s3
    1276:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1278:	02071693          	slli	a3,a4,0x20
    127c:	01c6d713          	srli	a4,a3,0x1c
    1280:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1282:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1286:	00001717          	auipc	a4,0x1
    128a:	d8a73523          	sd	a0,-630(a4) # 2010 <freep>
      return (void*)(p + 1);
    128e:	01078513          	addi	a0,a5,16
  }
}
    1292:	70e2                	ld	ra,56(sp)
    1294:	7442                	ld	s0,48(sp)
    1296:	7902                	ld	s2,32(sp)
    1298:	69e2                	ld	s3,24(sp)
    129a:	6121                	addi	sp,sp,64
    129c:	8082                	ret
    129e:	74a2                	ld	s1,40(sp)
    12a0:	6a42                	ld	s4,16(sp)
    12a2:	6aa2                	ld	s5,8(sp)
    12a4:	6b02                	ld	s6,0(sp)
    12a6:	b7f5                	j	1292 <malloc+0xdc>
