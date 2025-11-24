
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	f852                	sd	s4,48(sp)
       e:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
      10:	00007797          	auipc	a5,0x7
      14:	71878793          	addi	a5,a5,1816 # 7728 <malloc+0x2490>
      18:	638c                	ld	a1,0(a5)
      1a:	6790                	ld	a2,8(a5)
      1c:	6b94                	ld	a3,16(a5)
      1e:	6f98                	ld	a4,24(a5)
      20:	739c                	ld	a5,32(a5)
      22:	fab43423          	sd	a1,-88(s0)
      26:	fac43823          	sd	a2,-80(s0)
      2a:	fad43c23          	sd	a3,-72(s0)
      2e:	fce43023          	sd	a4,-64(s0)
      32:	fcf43423          	sd	a5,-56(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      36:	fa840493          	addi	s1,s0,-88
      3a:	fd040a13          	addi	s4,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      3e:	20100993          	li	s3,513
      42:	0004b903          	ld	s2,0(s1)
      46:	85ce                	mv	a1,s3
      48:	854a                	mv	a0,s2
      4a:	5cd040ef          	jal	4e16 <open>
    if(fd >= 0){
      4e:	00055d63          	bgez	a0,68 <copyinstr1+0x68>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      52:	04a1                	addi	s1,s1,8
      54:	ff4497e3          	bne	s1,s4,42 <copyinstr1+0x42>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      exit(1);
    }
  }
}
      58:	60e6                	ld	ra,88(sp)
      5a:	6446                	ld	s0,80(sp)
      5c:	64a6                	ld	s1,72(sp)
      5e:	6906                	ld	s2,64(sp)
      60:	79e2                	ld	s3,56(sp)
      62:	7a42                	ld	s4,48(sp)
      64:	6125                	addi	sp,sp,96
      66:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      68:	862a                	mv	a2,a0
      6a:	85ca                	mv	a1,s2
      6c:	00005517          	auipc	a0,0x5
      70:	32450513          	addi	a0,a0,804 # 5390 <malloc+0xf8>
      74:	16c050ef          	jal	51e0 <printf>
      exit(1);
      78:	4505                	li	a0,1
      7a:	55d040ef          	jal	4dd6 <exit>

000000000000007e <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      7e:	0000a797          	auipc	a5,0xa
      82:	4ea78793          	addi	a5,a5,1258 # a568 <uninit>
      86:	0000d697          	auipc	a3,0xd
      8a:	bf268693          	addi	a3,a3,-1038 # cc78 <buf>
    if(uninit[i] != '\0'){
      8e:	0007c703          	lbu	a4,0(a5)
      92:	e709                	bnez	a4,9c <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      94:	0785                	addi	a5,a5,1
      96:	fed79ce3          	bne	a5,a3,8e <bsstest+0x10>
      9a:	8082                	ret
{
      9c:	1141                	addi	sp,sp,-16
      9e:	e406                	sd	ra,8(sp)
      a0:	e022                	sd	s0,0(sp)
      a2:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      a4:	85aa                	mv	a1,a0
      a6:	00005517          	auipc	a0,0x5
      aa:	30a50513          	addi	a0,a0,778 # 53b0 <malloc+0x118>
      ae:	132050ef          	jal	51e0 <printf>
      exit(1);
      b2:	4505                	li	a0,1
      b4:	523040ef          	jal	4dd6 <exit>

00000000000000b8 <opentest>:
{
      b8:	1101                	addi	sp,sp,-32
      ba:	ec06                	sd	ra,24(sp)
      bc:	e822                	sd	s0,16(sp)
      be:	e426                	sd	s1,8(sp)
      c0:	1000                	addi	s0,sp,32
      c2:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      c4:	4581                	li	a1,0
      c6:	00005517          	auipc	a0,0x5
      ca:	30250513          	addi	a0,a0,770 # 53c8 <malloc+0x130>
      ce:	549040ef          	jal	4e16 <open>
  if(fd < 0){
      d2:	02054263          	bltz	a0,f6 <opentest+0x3e>
  close(fd);
      d6:	529040ef          	jal	4dfe <close>
  fd = open("doesnotexist", 0);
      da:	4581                	li	a1,0
      dc:	00005517          	auipc	a0,0x5
      e0:	30c50513          	addi	a0,a0,780 # 53e8 <malloc+0x150>
      e4:	533040ef          	jal	4e16 <open>
  if(fd >= 0){
      e8:	02055163          	bgez	a0,10a <opentest+0x52>
}
      ec:	60e2                	ld	ra,24(sp)
      ee:	6442                	ld	s0,16(sp)
      f0:	64a2                	ld	s1,8(sp)
      f2:	6105                	addi	sp,sp,32
      f4:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f6:	85a6                	mv	a1,s1
      f8:	00005517          	auipc	a0,0x5
      fc:	2d850513          	addi	a0,a0,728 # 53d0 <malloc+0x138>
     100:	0e0050ef          	jal	51e0 <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	4d1040ef          	jal	4dd6 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     10a:	85a6                	mv	a1,s1
     10c:	00005517          	auipc	a0,0x5
     110:	2ec50513          	addi	a0,a0,748 # 53f8 <malloc+0x160>
     114:	0cc050ef          	jal	51e0 <printf>
    exit(1);
     118:	4505                	li	a0,1
     11a:	4bd040ef          	jal	4dd6 <exit>

000000000000011e <truncate2>:
{
     11e:	7179                	addi	sp,sp,-48
     120:	f406                	sd	ra,40(sp)
     122:	f022                	sd	s0,32(sp)
     124:	ec26                	sd	s1,24(sp)
     126:	e84a                	sd	s2,16(sp)
     128:	e44e                	sd	s3,8(sp)
     12a:	1800                	addi	s0,sp,48
     12c:	89aa                	mv	s3,a0
  unlink("truncfile");
     12e:	00005517          	auipc	a0,0x5
     132:	2f250513          	addi	a0,a0,754 # 5420 <malloc+0x188>
     136:	4f1040ef          	jal	4e26 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13a:	60100593          	li	a1,1537
     13e:	00005517          	auipc	a0,0x5
     142:	2e250513          	addi	a0,a0,738 # 5420 <malloc+0x188>
     146:	4d1040ef          	jal	4e16 <open>
     14a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     14c:	4611                	li	a2,4
     14e:	00005597          	auipc	a1,0x5
     152:	2e258593          	addi	a1,a1,738 # 5430 <malloc+0x198>
     156:	4a1040ef          	jal	4df6 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     15a:	40100593          	li	a1,1025
     15e:	00005517          	auipc	a0,0x5
     162:	2c250513          	addi	a0,a0,706 # 5420 <malloc+0x188>
     166:	4b1040ef          	jal	4e16 <open>
     16a:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     16c:	4605                	li	a2,1
     16e:	00005597          	auipc	a1,0x5
     172:	2ca58593          	addi	a1,a1,714 # 5438 <malloc+0x1a0>
     176:	8526                	mv	a0,s1
     178:	47f040ef          	jal	4df6 <write>
  if(n != -1){
     17c:	57fd                	li	a5,-1
     17e:	02f51563          	bne	a0,a5,1a8 <truncate2+0x8a>
  unlink("truncfile");
     182:	00005517          	auipc	a0,0x5
     186:	29e50513          	addi	a0,a0,670 # 5420 <malloc+0x188>
     18a:	49d040ef          	jal	4e26 <unlink>
  close(fd1);
     18e:	8526                	mv	a0,s1
     190:	46f040ef          	jal	4dfe <close>
  close(fd2);
     194:	854a                	mv	a0,s2
     196:	469040ef          	jal	4dfe <close>
}
     19a:	70a2                	ld	ra,40(sp)
     19c:	7402                	ld	s0,32(sp)
     19e:	64e2                	ld	s1,24(sp)
     1a0:	6942                	ld	s2,16(sp)
     1a2:	69a2                	ld	s3,8(sp)
     1a4:	6145                	addi	sp,sp,48
     1a6:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a8:	862a                	mv	a2,a0
     1aa:	85ce                	mv	a1,s3
     1ac:	00005517          	auipc	a0,0x5
     1b0:	29450513          	addi	a0,a0,660 # 5440 <malloc+0x1a8>
     1b4:	02c050ef          	jal	51e0 <printf>
    exit(1);
     1b8:	4505                	li	a0,1
     1ba:	41d040ef          	jal	4dd6 <exit>

00000000000001be <createtest>:
{
     1be:	7139                	addi	sp,sp,-64
     1c0:	fc06                	sd	ra,56(sp)
     1c2:	f822                	sd	s0,48(sp)
     1c4:	f426                	sd	s1,40(sp)
     1c6:	f04a                	sd	s2,32(sp)
     1c8:	ec4e                	sd	s3,24(sp)
     1ca:	e852                	sd	s4,16(sp)
     1cc:	0080                	addi	s0,sp,64
  name[0] = 'a';
     1ce:	06100793          	li	a5,97
     1d2:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     1d6:	fc040523          	sb	zero,-54(s0)
     1da:	03000493          	li	s1,48
    fd = open(name, O_CREATE|O_RDWR);
     1de:	fc840a13          	addi	s4,s0,-56
     1e2:	20200993          	li	s3,514
  for(i = 0; i < N; i++){
     1e6:	06400913          	li	s2,100
    name[1] = '0' + i;
     1ea:	fc9404a3          	sb	s1,-55(s0)
    fd = open(name, O_CREATE|O_RDWR);
     1ee:	85ce                	mv	a1,s3
     1f0:	8552                	mv	a0,s4
     1f2:	425040ef          	jal	4e16 <open>
    close(fd);
     1f6:	409040ef          	jal	4dfe <close>
  for(i = 0; i < N; i++){
     1fa:	2485                	addiw	s1,s1,1
     1fc:	0ff4f493          	zext.b	s1,s1
     200:	ff2495e3          	bne	s1,s2,1ea <createtest+0x2c>
  name[0] = 'a';
     204:	06100793          	li	a5,97
     208:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     20c:	fc040523          	sb	zero,-54(s0)
     210:	03000493          	li	s1,48
    unlink(name);
     214:	fc840993          	addi	s3,s0,-56
  for(i = 0; i < N; i++){
     218:	06400913          	li	s2,100
    name[1] = '0' + i;
     21c:	fc9404a3          	sb	s1,-55(s0)
    unlink(name);
     220:	854e                	mv	a0,s3
     222:	405040ef          	jal	4e26 <unlink>
  for(i = 0; i < N; i++){
     226:	2485                	addiw	s1,s1,1
     228:	0ff4f493          	zext.b	s1,s1
     22c:	ff2498e3          	bne	s1,s2,21c <createtest+0x5e>
}
     230:	70e2                	ld	ra,56(sp)
     232:	7442                	ld	s0,48(sp)
     234:	74a2                	ld	s1,40(sp)
     236:	7902                	ld	s2,32(sp)
     238:	69e2                	ld	s3,24(sp)
     23a:	6a42                	ld	s4,16(sp)
     23c:	6121                	addi	sp,sp,64
     23e:	8082                	ret

0000000000000240 <bigwrite>:
{
     240:	715d                	addi	sp,sp,-80
     242:	e486                	sd	ra,72(sp)
     244:	e0a2                	sd	s0,64(sp)
     246:	fc26                	sd	s1,56(sp)
     248:	f84a                	sd	s2,48(sp)
     24a:	f44e                	sd	s3,40(sp)
     24c:	f052                	sd	s4,32(sp)
     24e:	ec56                	sd	s5,24(sp)
     250:	e85a                	sd	s6,16(sp)
     252:	e45e                	sd	s7,8(sp)
     254:	e062                	sd	s8,0(sp)
     256:	0880                	addi	s0,sp,80
     258:	8c2a                	mv	s8,a0
  unlink("bigwrite");
     25a:	00005517          	auipc	a0,0x5
     25e:	20e50513          	addi	a0,a0,526 # 5468 <malloc+0x1d0>
     262:	3c5040ef          	jal	4e26 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     266:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26a:	20200b93          	li	s7,514
     26e:	00005a97          	auipc	s5,0x5
     272:	1faa8a93          	addi	s5,s5,506 # 5468 <malloc+0x1d0>
      int cc = write(fd, buf, sz);
     276:	0000da17          	auipc	s4,0xd
     27a:	a02a0a13          	addi	s4,s4,-1534 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     27e:	6b0d                	lui	s6,0x3
     280:	1c9b0b13          	addi	s6,s6,457 # 31c9 <subdir+0x4cd>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     284:	85de                	mv	a1,s7
     286:	8556                	mv	a0,s5
     288:	38f040ef          	jal	4e16 <open>
     28c:	892a                	mv	s2,a0
    if(fd < 0){
     28e:	04054663          	bltz	a0,2da <bigwrite+0x9a>
      int cc = write(fd, buf, sz);
     292:	8626                	mv	a2,s1
     294:	85d2                	mv	a1,s4
     296:	361040ef          	jal	4df6 <write>
     29a:	89aa                	mv	s3,a0
      if(cc != sz){
     29c:	04a49963          	bne	s1,a0,2ee <bigwrite+0xae>
      int cc = write(fd, buf, sz);
     2a0:	8626                	mv	a2,s1
     2a2:	85d2                	mv	a1,s4
     2a4:	854a                	mv	a0,s2
     2a6:	351040ef          	jal	4df6 <write>
      if(cc != sz){
     2aa:	04951363          	bne	a0,s1,2f0 <bigwrite+0xb0>
    close(fd);
     2ae:	854a                	mv	a0,s2
     2b0:	34f040ef          	jal	4dfe <close>
    unlink("bigwrite");
     2b4:	8556                	mv	a0,s5
     2b6:	371040ef          	jal	4e26 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2ba:	1d74849b          	addiw	s1,s1,471
     2be:	fd6493e3          	bne	s1,s6,284 <bigwrite+0x44>
}
     2c2:	60a6                	ld	ra,72(sp)
     2c4:	6406                	ld	s0,64(sp)
     2c6:	74e2                	ld	s1,56(sp)
     2c8:	7942                	ld	s2,48(sp)
     2ca:	79a2                	ld	s3,40(sp)
     2cc:	7a02                	ld	s4,32(sp)
     2ce:	6ae2                	ld	s5,24(sp)
     2d0:	6b42                	ld	s6,16(sp)
     2d2:	6ba2                	ld	s7,8(sp)
     2d4:	6c02                	ld	s8,0(sp)
     2d6:	6161                	addi	sp,sp,80
     2d8:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2da:	85e2                	mv	a1,s8
     2dc:	00005517          	auipc	a0,0x5
     2e0:	19c50513          	addi	a0,a0,412 # 5478 <malloc+0x1e0>
     2e4:	6fd040ef          	jal	51e0 <printf>
      exit(1);
     2e8:	4505                	li	a0,1
     2ea:	2ed040ef          	jal	4dd6 <exit>
      if(cc != sz){
     2ee:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2f0:	86aa                	mv	a3,a0
     2f2:	864e                	mv	a2,s3
     2f4:	85e2                	mv	a1,s8
     2f6:	00005517          	auipc	a0,0x5
     2fa:	1a250513          	addi	a0,a0,418 # 5498 <malloc+0x200>
     2fe:	6e3040ef          	jal	51e0 <printf>
        exit(1);
     302:	4505                	li	a0,1
     304:	2d3040ef          	jal	4dd6 <exit>

0000000000000308 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     308:	7139                	addi	sp,sp,-64
     30a:	fc06                	sd	ra,56(sp)
     30c:	f822                	sd	s0,48(sp)
     30e:	f426                	sd	s1,40(sp)
     310:	f04a                	sd	s2,32(sp)
     312:	ec4e                	sd	s3,24(sp)
     314:	e852                	sd	s4,16(sp)
     316:	e456                	sd	s5,8(sp)
     318:	e05a                	sd	s6,0(sp)
     31a:	0080                	addi	s0,sp,64
  int assumed_free = 600;
  
  unlink("junk");
     31c:	00005517          	auipc	a0,0x5
     320:	19450513          	addi	a0,a0,404 # 54b0 <malloc+0x218>
     324:	303040ef          	jal	4e26 <unlink>
     328:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     32c:	20100a93          	li	s5,513
     330:	00005997          	auipc	s3,0x5
     334:	18098993          	addi	s3,s3,384 # 54b0 <malloc+0x218>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     338:	4b05                	li	s6,1
     33a:	5a7d                	li	s4,-1
     33c:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     340:	85d6                	mv	a1,s5
     342:	854e                	mv	a0,s3
     344:	2d3040ef          	jal	4e16 <open>
     348:	84aa                	mv	s1,a0
    if(fd < 0){
     34a:	04054d63          	bltz	a0,3a4 <badwrite+0x9c>
    write(fd, (char*)0xffffffffffL, 1);
     34e:	865a                	mv	a2,s6
     350:	85d2                	mv	a1,s4
     352:	2a5040ef          	jal	4df6 <write>
    close(fd);
     356:	8526                	mv	a0,s1
     358:	2a7040ef          	jal	4dfe <close>
    unlink("junk");
     35c:	854e                	mv	a0,s3
     35e:	2c9040ef          	jal	4e26 <unlink>
  for(int i = 0; i < assumed_free; i++){
     362:	397d                	addiw	s2,s2,-1
     364:	fc091ee3          	bnez	s2,340 <badwrite+0x38>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     368:	20100593          	li	a1,513
     36c:	00005517          	auipc	a0,0x5
     370:	14450513          	addi	a0,a0,324 # 54b0 <malloc+0x218>
     374:	2a3040ef          	jal	4e16 <open>
     378:	84aa                	mv	s1,a0
  if(fd < 0){
     37a:	02054e63          	bltz	a0,3b6 <badwrite+0xae>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     37e:	4605                	li	a2,1
     380:	00005597          	auipc	a1,0x5
     384:	0b858593          	addi	a1,a1,184 # 5438 <malloc+0x1a0>
     388:	26f040ef          	jal	4df6 <write>
     38c:	4785                	li	a5,1
     38e:	02f50d63          	beq	a0,a5,3c8 <badwrite+0xc0>
    printf("write failed\n");
     392:	00005517          	auipc	a0,0x5
     396:	13e50513          	addi	a0,a0,318 # 54d0 <malloc+0x238>
     39a:	647040ef          	jal	51e0 <printf>
    exit(1);
     39e:	4505                	li	a0,1
     3a0:	237040ef          	jal	4dd6 <exit>
      printf("open junk failed\n");
     3a4:	00005517          	auipc	a0,0x5
     3a8:	11450513          	addi	a0,a0,276 # 54b8 <malloc+0x220>
     3ac:	635040ef          	jal	51e0 <printf>
      exit(1);
     3b0:	4505                	li	a0,1
     3b2:	225040ef          	jal	4dd6 <exit>
    printf("open junk failed\n");
     3b6:	00005517          	auipc	a0,0x5
     3ba:	10250513          	addi	a0,a0,258 # 54b8 <malloc+0x220>
     3be:	623040ef          	jal	51e0 <printf>
    exit(1);
     3c2:	4505                	li	a0,1
     3c4:	213040ef          	jal	4dd6 <exit>
  }
  close(fd);
     3c8:	8526                	mv	a0,s1
     3ca:	235040ef          	jal	4dfe <close>
  unlink("junk");
     3ce:	00005517          	auipc	a0,0x5
     3d2:	0e250513          	addi	a0,a0,226 # 54b0 <malloc+0x218>
     3d6:	251040ef          	jal	4e26 <unlink>

  exit(0);
     3da:	4501                	li	a0,0
     3dc:	1fb040ef          	jal	4dd6 <exit>

00000000000003e0 <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3e0:	711d                	addi	sp,sp,-96
     3e2:	ec86                	sd	ra,88(sp)
     3e4:	e8a2                	sd	s0,80(sp)
     3e6:	e4a6                	sd	s1,72(sp)
     3e8:	e0ca                	sd	s2,64(sp)
     3ea:	fc4e                	sd	s3,56(sp)
     3ec:	f852                	sd	s4,48(sp)
     3ee:	f456                	sd	s5,40(sp)
     3f0:	1080                	addi	s0,sp,96
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     3f2:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3f4:	07a00993          	li	s3,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     3f8:	fa040913          	addi	s2,s0,-96
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     3fc:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
     400:	40000a93          	li	s5,1024
    name[0] = 'z';
     404:	fb340023          	sb	s3,-96(s0)
    name[1] = 'z';
     408:	fb3400a3          	sb	s3,-95(s0)
    name[2] = '0' + (i / 32);
     40c:	41f4d71b          	sraiw	a4,s1,0x1f
     410:	01b7571b          	srliw	a4,a4,0x1b
     414:	009707bb          	addw	a5,a4,s1
     418:	4057d69b          	sraiw	a3,a5,0x5
     41c:	0306869b          	addiw	a3,a3,48
     420:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     424:	8bfd                	andi	a5,a5,31
     426:	9f99                	subw	a5,a5,a4
     428:	0307879b          	addiw	a5,a5,48
     42c:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     430:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     434:	854a                	mv	a0,s2
     436:	1f1040ef          	jal	4e26 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     43a:	85d2                	mv	a1,s4
     43c:	854a                	mv	a0,s2
     43e:	1d9040ef          	jal	4e16 <open>
    if(fd < 0){
     442:	00054763          	bltz	a0,450 <outofinodes+0x70>
      // failure is eventually expected.
      break;
    }
    close(fd);
     446:	1b9040ef          	jal	4dfe <close>
  for(int i = 0; i < nzz; i++){
     44a:	2485                	addiw	s1,s1,1
     44c:	fb549ce3          	bne	s1,s5,404 <outofinodes+0x24>
     450:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     452:	07a00913          	li	s2,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     456:	fa040a13          	addi	s4,s0,-96
  for(int i = 0; i < nzz; i++){
     45a:	40000993          	li	s3,1024
    name[0] = 'z';
     45e:	fb240023          	sb	s2,-96(s0)
    name[1] = 'z';
     462:	fb2400a3          	sb	s2,-95(s0)
    name[2] = '0' + (i / 32);
     466:	41f4d71b          	sraiw	a4,s1,0x1f
     46a:	01b7571b          	srliw	a4,a4,0x1b
     46e:	009707bb          	addw	a5,a4,s1
     472:	4057d69b          	sraiw	a3,a5,0x5
     476:	0306869b          	addiw	a3,a3,48
     47a:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     47e:	8bfd                	andi	a5,a5,31
     480:	9f99                	subw	a5,a5,a4
     482:	0307879b          	addiw	a5,a5,48
     486:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     48a:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     48e:	8552                	mv	a0,s4
     490:	197040ef          	jal	4e26 <unlink>
  for(int i = 0; i < nzz; i++){
     494:	2485                	addiw	s1,s1,1
     496:	fd3494e3          	bne	s1,s3,45e <outofinodes+0x7e>
  }
}
     49a:	60e6                	ld	ra,88(sp)
     49c:	6446                	ld	s0,80(sp)
     49e:	64a6                	ld	s1,72(sp)
     4a0:	6906                	ld	s2,64(sp)
     4a2:	79e2                	ld	s3,56(sp)
     4a4:	7a42                	ld	s4,48(sp)
     4a6:	7aa2                	ld	s5,40(sp)
     4a8:	6125                	addi	sp,sp,96
     4aa:	8082                	ret

00000000000004ac <copyin>:
{
     4ac:	7175                	addi	sp,sp,-144
     4ae:	e506                	sd	ra,136(sp)
     4b0:	e122                	sd	s0,128(sp)
     4b2:	fca6                	sd	s1,120(sp)
     4b4:	f8ca                	sd	s2,112(sp)
     4b6:	f4ce                	sd	s3,104(sp)
     4b8:	f0d2                	sd	s4,96(sp)
     4ba:	ecd6                	sd	s5,88(sp)
     4bc:	e8da                	sd	s6,80(sp)
     4be:	e4de                	sd	s7,72(sp)
     4c0:	e0e2                	sd	s8,64(sp)
     4c2:	fc66                	sd	s9,56(sp)
     4c4:	0900                	addi	s0,sp,144
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     4c6:	00007797          	auipc	a5,0x7
     4ca:	26278793          	addi	a5,a5,610 # 7728 <malloc+0x2490>
     4ce:	638c                	ld	a1,0(a5)
     4d0:	6790                	ld	a2,8(a5)
     4d2:	6b94                	ld	a3,16(a5)
     4d4:	6f98                	ld	a4,24(a5)
     4d6:	739c                	ld	a5,32(a5)
     4d8:	f6b43c23          	sd	a1,-136(s0)
     4dc:	f8c43023          	sd	a2,-128(s0)
     4e0:	f8d43423          	sd	a3,-120(s0)
     4e4:	f8e43823          	sd	a4,-112(s0)
     4e8:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     4ec:	f7840913          	addi	s2,s0,-136
     4f0:	fa040c93          	addi	s9,s0,-96
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4f4:	20100b13          	li	s6,513
     4f8:	00005a97          	auipc	s5,0x5
     4fc:	fe8a8a93          	addi	s5,s5,-24 # 54e0 <malloc+0x248>
    int n = write(fd, (void*)addr, 8192);
     500:	6a09                	lui	s4,0x2
    n = write(1, (char*)addr, 8192);
     502:	4c05                	li	s8,1
    if(pipe(fds) < 0){
     504:	f7040b93          	addi	s7,s0,-144
    uint64 addr = addrs[ai];
     508:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     50c:	85da                	mv	a1,s6
     50e:	8556                	mv	a0,s5
     510:	107040ef          	jal	4e16 <open>
     514:	84aa                	mv	s1,a0
    if(fd < 0){
     516:	06054a63          	bltz	a0,58a <copyin+0xde>
    int n = write(fd, (void*)addr, 8192);
     51a:	8652                	mv	a2,s4
     51c:	85ce                	mv	a1,s3
     51e:	0d9040ef          	jal	4df6 <write>
    if(n >= 0){
     522:	06055d63          	bgez	a0,59c <copyin+0xf0>
    close(fd);
     526:	8526                	mv	a0,s1
     528:	0d7040ef          	jal	4dfe <close>
    unlink("copyin1");
     52c:	8556                	mv	a0,s5
     52e:	0f9040ef          	jal	4e26 <unlink>
    n = write(1, (char*)addr, 8192);
     532:	8652                	mv	a2,s4
     534:	85ce                	mv	a1,s3
     536:	8562                	mv	a0,s8
     538:	0bf040ef          	jal	4df6 <write>
    if(n > 0){
     53c:	06a04b63          	bgtz	a0,5b2 <copyin+0x106>
    if(pipe(fds) < 0){
     540:	855e                	mv	a0,s7
     542:	0a5040ef          	jal	4de6 <pipe>
     546:	08054163          	bltz	a0,5c8 <copyin+0x11c>
    n = write(fds[1], (char*)addr, 8192);
     54a:	8652                	mv	a2,s4
     54c:	85ce                	mv	a1,s3
     54e:	f7442503          	lw	a0,-140(s0)
     552:	0a5040ef          	jal	4df6 <write>
    if(n > 0){
     556:	08a04263          	bgtz	a0,5da <copyin+0x12e>
    close(fds[0]);
     55a:	f7042503          	lw	a0,-144(s0)
     55e:	0a1040ef          	jal	4dfe <close>
    close(fds[1]);
     562:	f7442503          	lw	a0,-140(s0)
     566:	099040ef          	jal	4dfe <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     56a:	0921                	addi	s2,s2,8
     56c:	f9991ee3          	bne	s2,s9,508 <copyin+0x5c>
}
     570:	60aa                	ld	ra,136(sp)
     572:	640a                	ld	s0,128(sp)
     574:	74e6                	ld	s1,120(sp)
     576:	7946                	ld	s2,112(sp)
     578:	79a6                	ld	s3,104(sp)
     57a:	7a06                	ld	s4,96(sp)
     57c:	6ae6                	ld	s5,88(sp)
     57e:	6b46                	ld	s6,80(sp)
     580:	6ba6                	ld	s7,72(sp)
     582:	6c06                	ld	s8,64(sp)
     584:	7ce2                	ld	s9,56(sp)
     586:	6149                	addi	sp,sp,144
     588:	8082                	ret
      printf("open(copyin1) failed\n");
     58a:	00005517          	auipc	a0,0x5
     58e:	f5e50513          	addi	a0,a0,-162 # 54e8 <malloc+0x250>
     592:	44f040ef          	jal	51e0 <printf>
      exit(1);
     596:	4505                	li	a0,1
     598:	03f040ef          	jal	4dd6 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
     59c:	862a                	mv	a2,a0
     59e:	85ce                	mv	a1,s3
     5a0:	00005517          	auipc	a0,0x5
     5a4:	f6050513          	addi	a0,a0,-160 # 5500 <malloc+0x268>
     5a8:	439040ef          	jal	51e0 <printf>
      exit(1);
     5ac:	4505                	li	a0,1
     5ae:	029040ef          	jal	4dd6 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5b2:	862a                	mv	a2,a0
     5b4:	85ce                	mv	a1,s3
     5b6:	00005517          	auipc	a0,0x5
     5ba:	f7a50513          	addi	a0,a0,-134 # 5530 <malloc+0x298>
     5be:	423040ef          	jal	51e0 <printf>
      exit(1);
     5c2:	4505                	li	a0,1
     5c4:	013040ef          	jal	4dd6 <exit>
      printf("pipe() failed\n");
     5c8:	00005517          	auipc	a0,0x5
     5cc:	f9850513          	addi	a0,a0,-104 # 5560 <malloc+0x2c8>
     5d0:	411040ef          	jal	51e0 <printf>
      exit(1);
     5d4:	4505                	li	a0,1
     5d6:	001040ef          	jal	4dd6 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5da:	862a                	mv	a2,a0
     5dc:	85ce                	mv	a1,s3
     5de:	00005517          	auipc	a0,0x5
     5e2:	f9250513          	addi	a0,a0,-110 # 5570 <malloc+0x2d8>
     5e6:	3fb040ef          	jal	51e0 <printf>
      exit(1);
     5ea:	4505                	li	a0,1
     5ec:	7ea040ef          	jal	4dd6 <exit>

00000000000005f0 <copyout>:
{
     5f0:	7135                	addi	sp,sp,-160
     5f2:	ed06                	sd	ra,152(sp)
     5f4:	e922                	sd	s0,144(sp)
     5f6:	e526                	sd	s1,136(sp)
     5f8:	e14a                	sd	s2,128(sp)
     5fa:	fcce                	sd	s3,120(sp)
     5fc:	f8d2                	sd	s4,112(sp)
     5fe:	f4d6                	sd	s5,104(sp)
     600:	f0da                	sd	s6,96(sp)
     602:	ecde                	sd	s7,88(sp)
     604:	e8e2                	sd	s8,80(sp)
     606:	e4e6                	sd	s9,72(sp)
     608:	1100                	addi	s0,sp,160
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     60a:	00007797          	auipc	a5,0x7
     60e:	11e78793          	addi	a5,a5,286 # 7728 <malloc+0x2490>
     612:	7788                	ld	a0,40(a5)
     614:	7b8c                	ld	a1,48(a5)
     616:	7f90                	ld	a2,56(a5)
     618:	63b4                	ld	a3,64(a5)
     61a:	67b8                	ld	a4,72(a5)
     61c:	6bbc                	ld	a5,80(a5)
     61e:	f6a43823          	sd	a0,-144(s0)
     622:	f6b43c23          	sd	a1,-136(s0)
     626:	f8c43023          	sd	a2,-128(s0)
     62a:	f8d43423          	sd	a3,-120(s0)
     62e:	f8e43823          	sd	a4,-112(s0)
     632:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     636:	f7040913          	addi	s2,s0,-144
     63a:	fa040c93          	addi	s9,s0,-96
    int fd = open("README", 0);
     63e:	00005b17          	auipc	s6,0x5
     642:	f62b0b13          	addi	s6,s6,-158 # 55a0 <malloc+0x308>
    int n = read(fd, (void*)addr, 8192);
     646:	6a89                	lui	s5,0x2
    if(pipe(fds) < 0){
     648:	f6840c13          	addi	s8,s0,-152
    n = write(fds[1], "x", 1);
     64c:	4a05                	li	s4,1
     64e:	00005b97          	auipc	s7,0x5
     652:	deab8b93          	addi	s7,s7,-534 # 5438 <malloc+0x1a0>
    uint64 addr = addrs[ai];
     656:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     65a:	4581                	li	a1,0
     65c:	855a                	mv	a0,s6
     65e:	7b8040ef          	jal	4e16 <open>
     662:	84aa                	mv	s1,a0
    if(fd < 0){
     664:	06054863          	bltz	a0,6d4 <copyout+0xe4>
    int n = read(fd, (void*)addr, 8192);
     668:	8656                	mv	a2,s5
     66a:	85ce                	mv	a1,s3
     66c:	782040ef          	jal	4dee <read>
    if(n > 0){
     670:	06a04b63          	bgtz	a0,6e6 <copyout+0xf6>
    close(fd);
     674:	8526                	mv	a0,s1
     676:	788040ef          	jal	4dfe <close>
    if(pipe(fds) < 0){
     67a:	8562                	mv	a0,s8
     67c:	76a040ef          	jal	4de6 <pipe>
     680:	06054e63          	bltz	a0,6fc <copyout+0x10c>
    n = write(fds[1], "x", 1);
     684:	8652                	mv	a2,s4
     686:	85de                	mv	a1,s7
     688:	f6c42503          	lw	a0,-148(s0)
     68c:	76a040ef          	jal	4df6 <write>
    if(n != 1){
     690:	07451f63          	bne	a0,s4,70e <copyout+0x11e>
    n = read(fds[0], (void*)addr, 8192);
     694:	8656                	mv	a2,s5
     696:	85ce                	mv	a1,s3
     698:	f6842503          	lw	a0,-152(s0)
     69c:	752040ef          	jal	4dee <read>
    if(n > 0){
     6a0:	08a04063          	bgtz	a0,720 <copyout+0x130>
    close(fds[0]);
     6a4:	f6842503          	lw	a0,-152(s0)
     6a8:	756040ef          	jal	4dfe <close>
    close(fds[1]);
     6ac:	f6c42503          	lw	a0,-148(s0)
     6b0:	74e040ef          	jal	4dfe <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     6b4:	0921                	addi	s2,s2,8
     6b6:	fb9910e3          	bne	s2,s9,656 <copyout+0x66>
}
     6ba:	60ea                	ld	ra,152(sp)
     6bc:	644a                	ld	s0,144(sp)
     6be:	64aa                	ld	s1,136(sp)
     6c0:	690a                	ld	s2,128(sp)
     6c2:	79e6                	ld	s3,120(sp)
     6c4:	7a46                	ld	s4,112(sp)
     6c6:	7aa6                	ld	s5,104(sp)
     6c8:	7b06                	ld	s6,96(sp)
     6ca:	6be6                	ld	s7,88(sp)
     6cc:	6c46                	ld	s8,80(sp)
     6ce:	6ca6                	ld	s9,72(sp)
     6d0:	610d                	addi	sp,sp,160
     6d2:	8082                	ret
      printf("open(README) failed\n");
     6d4:	00005517          	auipc	a0,0x5
     6d8:	ed450513          	addi	a0,a0,-300 # 55a8 <malloc+0x310>
     6dc:	305040ef          	jal	51e0 <printf>
      exit(1);
     6e0:	4505                	li	a0,1
     6e2:	6f4040ef          	jal	4dd6 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     6e6:	862a                	mv	a2,a0
     6e8:	85ce                	mv	a1,s3
     6ea:	00005517          	auipc	a0,0x5
     6ee:	ed650513          	addi	a0,a0,-298 # 55c0 <malloc+0x328>
     6f2:	2ef040ef          	jal	51e0 <printf>
      exit(1);
     6f6:	4505                	li	a0,1
     6f8:	6de040ef          	jal	4dd6 <exit>
      printf("pipe() failed\n");
     6fc:	00005517          	auipc	a0,0x5
     700:	e6450513          	addi	a0,a0,-412 # 5560 <malloc+0x2c8>
     704:	2dd040ef          	jal	51e0 <printf>
      exit(1);
     708:	4505                	li	a0,1
     70a:	6cc040ef          	jal	4dd6 <exit>
      printf("pipe write failed\n");
     70e:	00005517          	auipc	a0,0x5
     712:	ee250513          	addi	a0,a0,-286 # 55f0 <malloc+0x358>
     716:	2cb040ef          	jal	51e0 <printf>
      exit(1);
     71a:	4505                	li	a0,1
     71c:	6ba040ef          	jal	4dd6 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     720:	862a                	mv	a2,a0
     722:	85ce                	mv	a1,s3
     724:	00005517          	auipc	a0,0x5
     728:	ee450513          	addi	a0,a0,-284 # 5608 <malloc+0x370>
     72c:	2b5040ef          	jal	51e0 <printf>
      exit(1);
     730:	4505                	li	a0,1
     732:	6a4040ef          	jal	4dd6 <exit>

0000000000000736 <truncate1>:
{
     736:	711d                	addi	sp,sp,-96
     738:	ec86                	sd	ra,88(sp)
     73a:	e8a2                	sd	s0,80(sp)
     73c:	e4a6                	sd	s1,72(sp)
     73e:	e0ca                	sd	s2,64(sp)
     740:	fc4e                	sd	s3,56(sp)
     742:	f852                	sd	s4,48(sp)
     744:	f456                	sd	s5,40(sp)
     746:	1080                	addi	s0,sp,96
     748:	8aaa                	mv	s5,a0
  unlink("truncfile");
     74a:	00005517          	auipc	a0,0x5
     74e:	cd650513          	addi	a0,a0,-810 # 5420 <malloc+0x188>
     752:	6d4040ef          	jal	4e26 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     756:	60100593          	li	a1,1537
     75a:	00005517          	auipc	a0,0x5
     75e:	cc650513          	addi	a0,a0,-826 # 5420 <malloc+0x188>
     762:	6b4040ef          	jal	4e16 <open>
     766:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     768:	4611                	li	a2,4
     76a:	00005597          	auipc	a1,0x5
     76e:	cc658593          	addi	a1,a1,-826 # 5430 <malloc+0x198>
     772:	684040ef          	jal	4df6 <write>
  close(fd1);
     776:	8526                	mv	a0,s1
     778:	686040ef          	jal	4dfe <close>
  int fd2 = open("truncfile", O_RDONLY);
     77c:	4581                	li	a1,0
     77e:	00005517          	auipc	a0,0x5
     782:	ca250513          	addi	a0,a0,-862 # 5420 <malloc+0x188>
     786:	690040ef          	jal	4e16 <open>
     78a:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     78c:	02000613          	li	a2,32
     790:	fa040593          	addi	a1,s0,-96
     794:	65a040ef          	jal	4dee <read>
  if(n != 4){
     798:	4791                	li	a5,4
     79a:	0af51863          	bne	a0,a5,84a <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     79e:	40100593          	li	a1,1025
     7a2:	00005517          	auipc	a0,0x5
     7a6:	c7e50513          	addi	a0,a0,-898 # 5420 <malloc+0x188>
     7aa:	66c040ef          	jal	4e16 <open>
     7ae:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     7b0:	4581                	li	a1,0
     7b2:	00005517          	auipc	a0,0x5
     7b6:	c6e50513          	addi	a0,a0,-914 # 5420 <malloc+0x188>
     7ba:	65c040ef          	jal	4e16 <open>
     7be:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     7c0:	02000613          	li	a2,32
     7c4:	fa040593          	addi	a1,s0,-96
     7c8:	626040ef          	jal	4dee <read>
     7cc:	8a2a                	mv	s4,a0
  if(n != 0){
     7ce:	e949                	bnez	a0,860 <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     7d0:	02000613          	li	a2,32
     7d4:	fa040593          	addi	a1,s0,-96
     7d8:	8526                	mv	a0,s1
     7da:	614040ef          	jal	4dee <read>
     7de:	8a2a                	mv	s4,a0
  if(n != 0){
     7e0:	e155                	bnez	a0,884 <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     7e2:	4619                	li	a2,6
     7e4:	00005597          	auipc	a1,0x5
     7e8:	eb458593          	addi	a1,a1,-332 # 5698 <malloc+0x400>
     7ec:	854e                	mv	a0,s3
     7ee:	608040ef          	jal	4df6 <write>
  n = read(fd3, buf, sizeof(buf));
     7f2:	02000613          	li	a2,32
     7f6:	fa040593          	addi	a1,s0,-96
     7fa:	854a                	mv	a0,s2
     7fc:	5f2040ef          	jal	4dee <read>
  if(n != 6){
     800:	4799                	li	a5,6
     802:	0af51363          	bne	a0,a5,8a8 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     806:	02000613          	li	a2,32
     80a:	fa040593          	addi	a1,s0,-96
     80e:	8526                	mv	a0,s1
     810:	5de040ef          	jal	4dee <read>
  if(n != 2){
     814:	4789                	li	a5,2
     816:	0af51463          	bne	a0,a5,8be <truncate1+0x188>
  unlink("truncfile");
     81a:	00005517          	auipc	a0,0x5
     81e:	c0650513          	addi	a0,a0,-1018 # 5420 <malloc+0x188>
     822:	604040ef          	jal	4e26 <unlink>
  close(fd1);
     826:	854e                	mv	a0,s3
     828:	5d6040ef          	jal	4dfe <close>
  close(fd2);
     82c:	8526                	mv	a0,s1
     82e:	5d0040ef          	jal	4dfe <close>
  close(fd3);
     832:	854a                	mv	a0,s2
     834:	5ca040ef          	jal	4dfe <close>
}
     838:	60e6                	ld	ra,88(sp)
     83a:	6446                	ld	s0,80(sp)
     83c:	64a6                	ld	s1,72(sp)
     83e:	6906                	ld	s2,64(sp)
     840:	79e2                	ld	s3,56(sp)
     842:	7a42                	ld	s4,48(sp)
     844:	7aa2                	ld	s5,40(sp)
     846:	6125                	addi	sp,sp,96
     848:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     84a:	862a                	mv	a2,a0
     84c:	85d6                	mv	a1,s5
     84e:	00005517          	auipc	a0,0x5
     852:	dea50513          	addi	a0,a0,-534 # 5638 <malloc+0x3a0>
     856:	18b040ef          	jal	51e0 <printf>
    exit(1);
     85a:	4505                	li	a0,1
     85c:	57a040ef          	jal	4dd6 <exit>
    printf("aaa fd3=%d\n", fd3);
     860:	85ca                	mv	a1,s2
     862:	00005517          	auipc	a0,0x5
     866:	df650513          	addi	a0,a0,-522 # 5658 <malloc+0x3c0>
     86a:	177040ef          	jal	51e0 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     86e:	8652                	mv	a2,s4
     870:	85d6                	mv	a1,s5
     872:	00005517          	auipc	a0,0x5
     876:	df650513          	addi	a0,a0,-522 # 5668 <malloc+0x3d0>
     87a:	167040ef          	jal	51e0 <printf>
    exit(1);
     87e:	4505                	li	a0,1
     880:	556040ef          	jal	4dd6 <exit>
    printf("bbb fd2=%d\n", fd2);
     884:	85a6                	mv	a1,s1
     886:	00005517          	auipc	a0,0x5
     88a:	e0250513          	addi	a0,a0,-510 # 5688 <malloc+0x3f0>
     88e:	153040ef          	jal	51e0 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     892:	8652                	mv	a2,s4
     894:	85d6                	mv	a1,s5
     896:	00005517          	auipc	a0,0x5
     89a:	dd250513          	addi	a0,a0,-558 # 5668 <malloc+0x3d0>
     89e:	143040ef          	jal	51e0 <printf>
    exit(1);
     8a2:	4505                	li	a0,1
     8a4:	532040ef          	jal	4dd6 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8a8:	862a                	mv	a2,a0
     8aa:	85d6                	mv	a1,s5
     8ac:	00005517          	auipc	a0,0x5
     8b0:	df450513          	addi	a0,a0,-524 # 56a0 <malloc+0x408>
     8b4:	12d040ef          	jal	51e0 <printf>
    exit(1);
     8b8:	4505                	li	a0,1
     8ba:	51c040ef          	jal	4dd6 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8be:	862a                	mv	a2,a0
     8c0:	85d6                	mv	a1,s5
     8c2:	00005517          	auipc	a0,0x5
     8c6:	dfe50513          	addi	a0,a0,-514 # 56c0 <malloc+0x428>
     8ca:	117040ef          	jal	51e0 <printf>
    exit(1);
     8ce:	4505                	li	a0,1
     8d0:	506040ef          	jal	4dd6 <exit>

00000000000008d4 <writetest>:
{
     8d4:	715d                	addi	sp,sp,-80
     8d6:	e486                	sd	ra,72(sp)
     8d8:	e0a2                	sd	s0,64(sp)
     8da:	fc26                	sd	s1,56(sp)
     8dc:	f84a                	sd	s2,48(sp)
     8de:	f44e                	sd	s3,40(sp)
     8e0:	f052                	sd	s4,32(sp)
     8e2:	ec56                	sd	s5,24(sp)
     8e4:	e85a                	sd	s6,16(sp)
     8e6:	e45e                	sd	s7,8(sp)
     8e8:	0880                	addi	s0,sp,80
     8ea:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     8ec:	20200593          	li	a1,514
     8f0:	00005517          	auipc	a0,0x5
     8f4:	df050513          	addi	a0,a0,-528 # 56e0 <malloc+0x448>
     8f8:	51e040ef          	jal	4e16 <open>
  if(fd < 0){
     8fc:	08054f63          	bltz	a0,99a <writetest+0xc6>
     900:	89aa                	mv	s3,a0
     902:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     904:	44a9                	li	s1,10
     906:	00005a17          	auipc	s4,0x5
     90a:	e02a0a13          	addi	s4,s4,-510 # 5708 <malloc+0x470>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     90e:	00005b17          	auipc	s6,0x5
     912:	e32b0b13          	addi	s6,s6,-462 # 5740 <malloc+0x4a8>
  for(i = 0; i < N; i++){
     916:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     91a:	8626                	mv	a2,s1
     91c:	85d2                	mv	a1,s4
     91e:	854e                	mv	a0,s3
     920:	4d6040ef          	jal	4df6 <write>
     924:	08951563          	bne	a0,s1,9ae <writetest+0xda>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     928:	8626                	mv	a2,s1
     92a:	85da                	mv	a1,s6
     92c:	854e                	mv	a0,s3
     92e:	4c8040ef          	jal	4df6 <write>
     932:	08951963          	bne	a0,s1,9c4 <writetest+0xf0>
  for(i = 0; i < N; i++){
     936:	2905                	addiw	s2,s2,1
     938:	ff5911e3          	bne	s2,s5,91a <writetest+0x46>
  close(fd);
     93c:	854e                	mv	a0,s3
     93e:	4c0040ef          	jal	4dfe <close>
  fd = open("small", O_RDONLY);
     942:	4581                	li	a1,0
     944:	00005517          	auipc	a0,0x5
     948:	d9c50513          	addi	a0,a0,-612 # 56e0 <malloc+0x448>
     94c:	4ca040ef          	jal	4e16 <open>
     950:	84aa                	mv	s1,a0
  if(fd < 0){
     952:	08054463          	bltz	a0,9da <writetest+0x106>
  i = read(fd, buf, N*SZ*2);
     956:	7d000613          	li	a2,2000
     95a:	0000c597          	auipc	a1,0xc
     95e:	31e58593          	addi	a1,a1,798 # cc78 <buf>
     962:	48c040ef          	jal	4dee <read>
  if(i != N*SZ*2){
     966:	7d000793          	li	a5,2000
     96a:	08f51263          	bne	a0,a5,9ee <writetest+0x11a>
  close(fd);
     96e:	8526                	mv	a0,s1
     970:	48e040ef          	jal	4dfe <close>
  if(unlink("small") < 0){
     974:	00005517          	auipc	a0,0x5
     978:	d6c50513          	addi	a0,a0,-660 # 56e0 <malloc+0x448>
     97c:	4aa040ef          	jal	4e26 <unlink>
     980:	08054163          	bltz	a0,a02 <writetest+0x12e>
}
     984:	60a6                	ld	ra,72(sp)
     986:	6406                	ld	s0,64(sp)
     988:	74e2                	ld	s1,56(sp)
     98a:	7942                	ld	s2,48(sp)
     98c:	79a2                	ld	s3,40(sp)
     98e:	7a02                	ld	s4,32(sp)
     990:	6ae2                	ld	s5,24(sp)
     992:	6b42                	ld	s6,16(sp)
     994:	6ba2                	ld	s7,8(sp)
     996:	6161                	addi	sp,sp,80
     998:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     99a:	85de                	mv	a1,s7
     99c:	00005517          	auipc	a0,0x5
     9a0:	d4c50513          	addi	a0,a0,-692 # 56e8 <malloc+0x450>
     9a4:	03d040ef          	jal	51e0 <printf>
    exit(1);
     9a8:	4505                	li	a0,1
     9aa:	42c040ef          	jal	4dd6 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     9ae:	864a                	mv	a2,s2
     9b0:	85de                	mv	a1,s7
     9b2:	00005517          	auipc	a0,0x5
     9b6:	d6650513          	addi	a0,a0,-666 # 5718 <malloc+0x480>
     9ba:	027040ef          	jal	51e0 <printf>
      exit(1);
     9be:	4505                	li	a0,1
     9c0:	416040ef          	jal	4dd6 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     9c4:	864a                	mv	a2,s2
     9c6:	85de                	mv	a1,s7
     9c8:	00005517          	auipc	a0,0x5
     9cc:	d8850513          	addi	a0,a0,-632 # 5750 <malloc+0x4b8>
     9d0:	011040ef          	jal	51e0 <printf>
      exit(1);
     9d4:	4505                	li	a0,1
     9d6:	400040ef          	jal	4dd6 <exit>
    printf("%s: error: open small failed!\n", s);
     9da:	85de                	mv	a1,s7
     9dc:	00005517          	auipc	a0,0x5
     9e0:	d9c50513          	addi	a0,a0,-612 # 5778 <malloc+0x4e0>
     9e4:	7fc040ef          	jal	51e0 <printf>
    exit(1);
     9e8:	4505                	li	a0,1
     9ea:	3ec040ef          	jal	4dd6 <exit>
    printf("%s: read failed\n", s);
     9ee:	85de                	mv	a1,s7
     9f0:	00005517          	auipc	a0,0x5
     9f4:	da850513          	addi	a0,a0,-600 # 5798 <malloc+0x500>
     9f8:	7e8040ef          	jal	51e0 <printf>
    exit(1);
     9fc:	4505                	li	a0,1
     9fe:	3d8040ef          	jal	4dd6 <exit>
    printf("%s: unlink small failed\n", s);
     a02:	85de                	mv	a1,s7
     a04:	00005517          	auipc	a0,0x5
     a08:	dac50513          	addi	a0,a0,-596 # 57b0 <malloc+0x518>
     a0c:	7d4040ef          	jal	51e0 <printf>
    exit(1);
     a10:	4505                	li	a0,1
     a12:	3c4040ef          	jal	4dd6 <exit>

0000000000000a16 <writebig>:
{
     a16:	7139                	addi	sp,sp,-64
     a18:	fc06                	sd	ra,56(sp)
     a1a:	f822                	sd	s0,48(sp)
     a1c:	f426                	sd	s1,40(sp)
     a1e:	f04a                	sd	s2,32(sp)
     a20:	ec4e                	sd	s3,24(sp)
     a22:	e852                	sd	s4,16(sp)
     a24:	e456                	sd	s5,8(sp)
     a26:	e05a                	sd	s6,0(sp)
     a28:	0080                	addi	s0,sp,64
     a2a:	8b2a                	mv	s6,a0
  fd = open("big", O_CREATE|O_RDWR);
     a2c:	20200593          	li	a1,514
     a30:	00005517          	auipc	a0,0x5
     a34:	da050513          	addi	a0,a0,-608 # 57d0 <malloc+0x538>
     a38:	3de040ef          	jal	4e16 <open>
  if(fd < 0){
     a3c:	06054a63          	bltz	a0,ab0 <writebig+0x9a>
     a40:	8a2a                	mv	s4,a0
     a42:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     a44:	0000c997          	auipc	s3,0xc
     a48:	23498993          	addi	s3,s3,564 # cc78 <buf>
    if(write(fd, buf, BSIZE) != BSIZE){
     a4c:	40000913          	li	s2,1024
  for(i = 0; i < MAXFILE; i++){
     a50:	10c00a93          	li	s5,268
    ((int*)buf)[0] = i;
     a54:	0099a023          	sw	s1,0(s3)
    if(write(fd, buf, BSIZE) != BSIZE){
     a58:	864a                	mv	a2,s2
     a5a:	85ce                	mv	a1,s3
     a5c:	8552                	mv	a0,s4
     a5e:	398040ef          	jal	4df6 <write>
     a62:	07251163          	bne	a0,s2,ac4 <writebig+0xae>
  for(i = 0; i < MAXFILE; i++){
     a66:	2485                	addiw	s1,s1,1
     a68:	ff5496e3          	bne	s1,s5,a54 <writebig+0x3e>
  close(fd);
     a6c:	8552                	mv	a0,s4
     a6e:	390040ef          	jal	4dfe <close>
  fd = open("big", O_RDONLY);
     a72:	4581                	li	a1,0
     a74:	00005517          	auipc	a0,0x5
     a78:	d5c50513          	addi	a0,a0,-676 # 57d0 <malloc+0x538>
     a7c:	39a040ef          	jal	4e16 <open>
     a80:	8a2a                	mv	s4,a0
  n = 0;
     a82:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a84:	40000993          	li	s3,1024
     a88:	0000c917          	auipc	s2,0xc
     a8c:	1f090913          	addi	s2,s2,496 # cc78 <buf>
  if(fd < 0){
     a90:	04054563          	bltz	a0,ada <writebig+0xc4>
    i = read(fd, buf, BSIZE);
     a94:	864e                	mv	a2,s3
     a96:	85ca                	mv	a1,s2
     a98:	8552                	mv	a0,s4
     a9a:	354040ef          	jal	4dee <read>
    if(i == 0){
     a9e:	c921                	beqz	a0,aee <writebig+0xd8>
    } else if(i != BSIZE){
     aa0:	09351b63          	bne	a0,s3,b36 <writebig+0x120>
    if(((int*)buf)[0] != n){
     aa4:	00092683          	lw	a3,0(s2)
     aa8:	0a969263          	bne	a3,s1,b4c <writebig+0x136>
    n++;
     aac:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     aae:	b7dd                	j	a94 <writebig+0x7e>
    printf("%s: error: creat big failed!\n", s);
     ab0:	85da                	mv	a1,s6
     ab2:	00005517          	auipc	a0,0x5
     ab6:	d2650513          	addi	a0,a0,-730 # 57d8 <malloc+0x540>
     aba:	726040ef          	jal	51e0 <printf>
    exit(1);
     abe:	4505                	li	a0,1
     ac0:	316040ef          	jal	4dd6 <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     ac4:	8626                	mv	a2,s1
     ac6:	85da                	mv	a1,s6
     ac8:	00005517          	auipc	a0,0x5
     acc:	d3050513          	addi	a0,a0,-720 # 57f8 <malloc+0x560>
     ad0:	710040ef          	jal	51e0 <printf>
      exit(1);
     ad4:	4505                	li	a0,1
     ad6:	300040ef          	jal	4dd6 <exit>
    printf("%s: error: open big failed!\n", s);
     ada:	85da                	mv	a1,s6
     adc:	00005517          	auipc	a0,0x5
     ae0:	d4450513          	addi	a0,a0,-700 # 5820 <malloc+0x588>
     ae4:	6fc040ef          	jal	51e0 <printf>
    exit(1);
     ae8:	4505                	li	a0,1
     aea:	2ec040ef          	jal	4dd6 <exit>
      if(n != MAXFILE){
     aee:	10c00793          	li	a5,268
     af2:	02f49763          	bne	s1,a5,b20 <writebig+0x10a>
  close(fd);
     af6:	8552                	mv	a0,s4
     af8:	306040ef          	jal	4dfe <close>
  if(unlink("big") < 0){
     afc:	00005517          	auipc	a0,0x5
     b00:	cd450513          	addi	a0,a0,-812 # 57d0 <malloc+0x538>
     b04:	322040ef          	jal	4e26 <unlink>
     b08:	04054d63          	bltz	a0,b62 <writebig+0x14c>
}
     b0c:	70e2                	ld	ra,56(sp)
     b0e:	7442                	ld	s0,48(sp)
     b10:	74a2                	ld	s1,40(sp)
     b12:	7902                	ld	s2,32(sp)
     b14:	69e2                	ld	s3,24(sp)
     b16:	6a42                	ld	s4,16(sp)
     b18:	6aa2                	ld	s5,8(sp)
     b1a:	6b02                	ld	s6,0(sp)
     b1c:	6121                	addi	sp,sp,64
     b1e:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     b20:	8626                	mv	a2,s1
     b22:	85da                	mv	a1,s6
     b24:	00005517          	auipc	a0,0x5
     b28:	d1c50513          	addi	a0,a0,-740 # 5840 <malloc+0x5a8>
     b2c:	6b4040ef          	jal	51e0 <printf>
        exit(1);
     b30:	4505                	li	a0,1
     b32:	2a4040ef          	jal	4dd6 <exit>
      printf("%s: read failed %d\n", s, i);
     b36:	862a                	mv	a2,a0
     b38:	85da                	mv	a1,s6
     b3a:	00005517          	auipc	a0,0x5
     b3e:	d2e50513          	addi	a0,a0,-722 # 5868 <malloc+0x5d0>
     b42:	69e040ef          	jal	51e0 <printf>
      exit(1);
     b46:	4505                	li	a0,1
     b48:	28e040ef          	jal	4dd6 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b4c:	8626                	mv	a2,s1
     b4e:	85da                	mv	a1,s6
     b50:	00005517          	auipc	a0,0x5
     b54:	d3050513          	addi	a0,a0,-720 # 5880 <malloc+0x5e8>
     b58:	688040ef          	jal	51e0 <printf>
      exit(1);
     b5c:	4505                	li	a0,1
     b5e:	278040ef          	jal	4dd6 <exit>
    printf("%s: unlink big failed\n", s);
     b62:	85da                	mv	a1,s6
     b64:	00005517          	auipc	a0,0x5
     b68:	d4450513          	addi	a0,a0,-700 # 58a8 <malloc+0x610>
     b6c:	674040ef          	jal	51e0 <printf>
    exit(1);
     b70:	4505                	li	a0,1
     b72:	264040ef          	jal	4dd6 <exit>

0000000000000b76 <unlinkread>:
{
     b76:	7179                	addi	sp,sp,-48
     b78:	f406                	sd	ra,40(sp)
     b7a:	f022                	sd	s0,32(sp)
     b7c:	ec26                	sd	s1,24(sp)
     b7e:	e84a                	sd	s2,16(sp)
     b80:	e44e                	sd	s3,8(sp)
     b82:	1800                	addi	s0,sp,48
     b84:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b86:	20200593          	li	a1,514
     b8a:	00005517          	auipc	a0,0x5
     b8e:	d3650513          	addi	a0,a0,-714 # 58c0 <malloc+0x628>
     b92:	284040ef          	jal	4e16 <open>
  if(fd < 0){
     b96:	0a054f63          	bltz	a0,c54 <unlinkread+0xde>
     b9a:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b9c:	4615                	li	a2,5
     b9e:	00005597          	auipc	a1,0x5
     ba2:	d5258593          	addi	a1,a1,-686 # 58f0 <malloc+0x658>
     ba6:	250040ef          	jal	4df6 <write>
  close(fd);
     baa:	8526                	mv	a0,s1
     bac:	252040ef          	jal	4dfe <close>
  fd = open("unlinkread", O_RDWR);
     bb0:	4589                	li	a1,2
     bb2:	00005517          	auipc	a0,0x5
     bb6:	d0e50513          	addi	a0,a0,-754 # 58c0 <malloc+0x628>
     bba:	25c040ef          	jal	4e16 <open>
     bbe:	84aa                	mv	s1,a0
  if(fd < 0){
     bc0:	0a054463          	bltz	a0,c68 <unlinkread+0xf2>
  if(unlink("unlinkread") != 0){
     bc4:	00005517          	auipc	a0,0x5
     bc8:	cfc50513          	addi	a0,a0,-772 # 58c0 <malloc+0x628>
     bcc:	25a040ef          	jal	4e26 <unlink>
     bd0:	e555                	bnez	a0,c7c <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd2:	20200593          	li	a1,514
     bd6:	00005517          	auipc	a0,0x5
     bda:	cea50513          	addi	a0,a0,-790 # 58c0 <malloc+0x628>
     bde:	238040ef          	jal	4e16 <open>
     be2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be4:	460d                	li	a2,3
     be6:	00005597          	auipc	a1,0x5
     bea:	d5258593          	addi	a1,a1,-686 # 5938 <malloc+0x6a0>
     bee:	208040ef          	jal	4df6 <write>
  close(fd1);
     bf2:	854a                	mv	a0,s2
     bf4:	20a040ef          	jal	4dfe <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     bf8:	660d                	lui	a2,0x3
     bfa:	0000c597          	auipc	a1,0xc
     bfe:	07e58593          	addi	a1,a1,126 # cc78 <buf>
     c02:	8526                	mv	a0,s1
     c04:	1ea040ef          	jal	4dee <read>
     c08:	4795                	li	a5,5
     c0a:	08f51363          	bne	a0,a5,c90 <unlinkread+0x11a>
  if(buf[0] != 'h'){
     c0e:	0000c717          	auipc	a4,0xc
     c12:	06a74703          	lbu	a4,106(a4) # cc78 <buf>
     c16:	06800793          	li	a5,104
     c1a:	08f71563          	bne	a4,a5,ca4 <unlinkread+0x12e>
  if(write(fd, buf, 10) != 10){
     c1e:	4629                	li	a2,10
     c20:	0000c597          	auipc	a1,0xc
     c24:	05858593          	addi	a1,a1,88 # cc78 <buf>
     c28:	8526                	mv	a0,s1
     c2a:	1cc040ef          	jal	4df6 <write>
     c2e:	47a9                	li	a5,10
     c30:	08f51463          	bne	a0,a5,cb8 <unlinkread+0x142>
  close(fd);
     c34:	8526                	mv	a0,s1
     c36:	1c8040ef          	jal	4dfe <close>
  unlink("unlinkread");
     c3a:	00005517          	auipc	a0,0x5
     c3e:	c8650513          	addi	a0,a0,-890 # 58c0 <malloc+0x628>
     c42:	1e4040ef          	jal	4e26 <unlink>
}
     c46:	70a2                	ld	ra,40(sp)
     c48:	7402                	ld	s0,32(sp)
     c4a:	64e2                	ld	s1,24(sp)
     c4c:	6942                	ld	s2,16(sp)
     c4e:	69a2                	ld	s3,8(sp)
     c50:	6145                	addi	sp,sp,48
     c52:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c54:	85ce                	mv	a1,s3
     c56:	00005517          	auipc	a0,0x5
     c5a:	c7a50513          	addi	a0,a0,-902 # 58d0 <malloc+0x638>
     c5e:	582040ef          	jal	51e0 <printf>
    exit(1);
     c62:	4505                	li	a0,1
     c64:	172040ef          	jal	4dd6 <exit>
    printf("%s: open unlinkread failed\n", s);
     c68:	85ce                	mv	a1,s3
     c6a:	00005517          	auipc	a0,0x5
     c6e:	c8e50513          	addi	a0,a0,-882 # 58f8 <malloc+0x660>
     c72:	56e040ef          	jal	51e0 <printf>
    exit(1);
     c76:	4505                	li	a0,1
     c78:	15e040ef          	jal	4dd6 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c7c:	85ce                	mv	a1,s3
     c7e:	00005517          	auipc	a0,0x5
     c82:	c9a50513          	addi	a0,a0,-870 # 5918 <malloc+0x680>
     c86:	55a040ef          	jal	51e0 <printf>
    exit(1);
     c8a:	4505                	li	a0,1
     c8c:	14a040ef          	jal	4dd6 <exit>
    printf("%s: unlinkread read failed", s);
     c90:	85ce                	mv	a1,s3
     c92:	00005517          	auipc	a0,0x5
     c96:	cae50513          	addi	a0,a0,-850 # 5940 <malloc+0x6a8>
     c9a:	546040ef          	jal	51e0 <printf>
    exit(1);
     c9e:	4505                	li	a0,1
     ca0:	136040ef          	jal	4dd6 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ca4:	85ce                	mv	a1,s3
     ca6:	00005517          	auipc	a0,0x5
     caa:	cba50513          	addi	a0,a0,-838 # 5960 <malloc+0x6c8>
     cae:	532040ef          	jal	51e0 <printf>
    exit(1);
     cb2:	4505                	li	a0,1
     cb4:	122040ef          	jal	4dd6 <exit>
    printf("%s: unlinkread write failed\n", s);
     cb8:	85ce                	mv	a1,s3
     cba:	00005517          	auipc	a0,0x5
     cbe:	cc650513          	addi	a0,a0,-826 # 5980 <malloc+0x6e8>
     cc2:	51e040ef          	jal	51e0 <printf>
    exit(1);
     cc6:	4505                	li	a0,1
     cc8:	10e040ef          	jal	4dd6 <exit>

0000000000000ccc <linktest>:
{
     ccc:	1101                	addi	sp,sp,-32
     cce:	ec06                	sd	ra,24(sp)
     cd0:	e822                	sd	s0,16(sp)
     cd2:	e426                	sd	s1,8(sp)
     cd4:	e04a                	sd	s2,0(sp)
     cd6:	1000                	addi	s0,sp,32
     cd8:	892a                	mv	s2,a0
  unlink("lf1");
     cda:	00005517          	auipc	a0,0x5
     cde:	cc650513          	addi	a0,a0,-826 # 59a0 <malloc+0x708>
     ce2:	144040ef          	jal	4e26 <unlink>
  unlink("lf2");
     ce6:	00005517          	auipc	a0,0x5
     cea:	cc250513          	addi	a0,a0,-830 # 59a8 <malloc+0x710>
     cee:	138040ef          	jal	4e26 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     cf2:	20200593          	li	a1,514
     cf6:	00005517          	auipc	a0,0x5
     cfa:	caa50513          	addi	a0,a0,-854 # 59a0 <malloc+0x708>
     cfe:	118040ef          	jal	4e16 <open>
  if(fd < 0){
     d02:	0c054f63          	bltz	a0,de0 <linktest+0x114>
     d06:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d08:	4615                	li	a2,5
     d0a:	00005597          	auipc	a1,0x5
     d0e:	be658593          	addi	a1,a1,-1050 # 58f0 <malloc+0x658>
     d12:	0e4040ef          	jal	4df6 <write>
     d16:	4795                	li	a5,5
     d18:	0cf51e63          	bne	a0,a5,df4 <linktest+0x128>
  close(fd);
     d1c:	8526                	mv	a0,s1
     d1e:	0e0040ef          	jal	4dfe <close>
  if(link("lf1", "lf2") < 0){
     d22:	00005597          	auipc	a1,0x5
     d26:	c8658593          	addi	a1,a1,-890 # 59a8 <malloc+0x710>
     d2a:	00005517          	auipc	a0,0x5
     d2e:	c7650513          	addi	a0,a0,-906 # 59a0 <malloc+0x708>
     d32:	104040ef          	jal	4e36 <link>
     d36:	0c054963          	bltz	a0,e08 <linktest+0x13c>
  unlink("lf1");
     d3a:	00005517          	auipc	a0,0x5
     d3e:	c6650513          	addi	a0,a0,-922 # 59a0 <malloc+0x708>
     d42:	0e4040ef          	jal	4e26 <unlink>
  if(open("lf1", 0) >= 0){
     d46:	4581                	li	a1,0
     d48:	00005517          	auipc	a0,0x5
     d4c:	c5850513          	addi	a0,a0,-936 # 59a0 <malloc+0x708>
     d50:	0c6040ef          	jal	4e16 <open>
     d54:	0c055463          	bgez	a0,e1c <linktest+0x150>
  fd = open("lf2", 0);
     d58:	4581                	li	a1,0
     d5a:	00005517          	auipc	a0,0x5
     d5e:	c4e50513          	addi	a0,a0,-946 # 59a8 <malloc+0x710>
     d62:	0b4040ef          	jal	4e16 <open>
     d66:	84aa                	mv	s1,a0
  if(fd < 0){
     d68:	0c054463          	bltz	a0,e30 <linktest+0x164>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d6c:	660d                	lui	a2,0x3
     d6e:	0000c597          	auipc	a1,0xc
     d72:	f0a58593          	addi	a1,a1,-246 # cc78 <buf>
     d76:	078040ef          	jal	4dee <read>
     d7a:	4795                	li	a5,5
     d7c:	0cf51463          	bne	a0,a5,e44 <linktest+0x178>
  close(fd);
     d80:	8526                	mv	a0,s1
     d82:	07c040ef          	jal	4dfe <close>
  if(link("lf2", "lf2") >= 0){
     d86:	00005597          	auipc	a1,0x5
     d8a:	c2258593          	addi	a1,a1,-990 # 59a8 <malloc+0x710>
     d8e:	852e                	mv	a0,a1
     d90:	0a6040ef          	jal	4e36 <link>
     d94:	0c055263          	bgez	a0,e58 <linktest+0x18c>
  unlink("lf2");
     d98:	00005517          	auipc	a0,0x5
     d9c:	c1050513          	addi	a0,a0,-1008 # 59a8 <malloc+0x710>
     da0:	086040ef          	jal	4e26 <unlink>
  if(link("lf2", "lf1") >= 0){
     da4:	00005597          	auipc	a1,0x5
     da8:	bfc58593          	addi	a1,a1,-1028 # 59a0 <malloc+0x708>
     dac:	00005517          	auipc	a0,0x5
     db0:	bfc50513          	addi	a0,a0,-1028 # 59a8 <malloc+0x710>
     db4:	082040ef          	jal	4e36 <link>
     db8:	0a055a63          	bgez	a0,e6c <linktest+0x1a0>
  if(link(".", "lf1") >= 0){
     dbc:	00005597          	auipc	a1,0x5
     dc0:	be458593          	addi	a1,a1,-1052 # 59a0 <malloc+0x708>
     dc4:	00005517          	auipc	a0,0x5
     dc8:	cec50513          	addi	a0,a0,-788 # 5ab0 <malloc+0x818>
     dcc:	06a040ef          	jal	4e36 <link>
     dd0:	0a055863          	bgez	a0,e80 <linktest+0x1b4>
}
     dd4:	60e2                	ld	ra,24(sp)
     dd6:	6442                	ld	s0,16(sp)
     dd8:	64a2                	ld	s1,8(sp)
     dda:	6902                	ld	s2,0(sp)
     ddc:	6105                	addi	sp,sp,32
     dde:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     de0:	85ca                	mv	a1,s2
     de2:	00005517          	auipc	a0,0x5
     de6:	bce50513          	addi	a0,a0,-1074 # 59b0 <malloc+0x718>
     dea:	3f6040ef          	jal	51e0 <printf>
    exit(1);
     dee:	4505                	li	a0,1
     df0:	7e7030ef          	jal	4dd6 <exit>
    printf("%s: write lf1 failed\n", s);
     df4:	85ca                	mv	a1,s2
     df6:	00005517          	auipc	a0,0x5
     dfa:	bd250513          	addi	a0,a0,-1070 # 59c8 <malloc+0x730>
     dfe:	3e2040ef          	jal	51e0 <printf>
    exit(1);
     e02:	4505                	li	a0,1
     e04:	7d3030ef          	jal	4dd6 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e08:	85ca                	mv	a1,s2
     e0a:	00005517          	auipc	a0,0x5
     e0e:	bd650513          	addi	a0,a0,-1066 # 59e0 <malloc+0x748>
     e12:	3ce040ef          	jal	51e0 <printf>
    exit(1);
     e16:	4505                	li	a0,1
     e18:	7bf030ef          	jal	4dd6 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     e1c:	85ca                	mv	a1,s2
     e1e:	00005517          	auipc	a0,0x5
     e22:	be250513          	addi	a0,a0,-1054 # 5a00 <malloc+0x768>
     e26:	3ba040ef          	jal	51e0 <printf>
    exit(1);
     e2a:	4505                	li	a0,1
     e2c:	7ab030ef          	jal	4dd6 <exit>
    printf("%s: open lf2 failed\n", s);
     e30:	85ca                	mv	a1,s2
     e32:	00005517          	auipc	a0,0x5
     e36:	bfe50513          	addi	a0,a0,-1026 # 5a30 <malloc+0x798>
     e3a:	3a6040ef          	jal	51e0 <printf>
    exit(1);
     e3e:	4505                	li	a0,1
     e40:	797030ef          	jal	4dd6 <exit>
    printf("%s: read lf2 failed\n", s);
     e44:	85ca                	mv	a1,s2
     e46:	00005517          	auipc	a0,0x5
     e4a:	c0250513          	addi	a0,a0,-1022 # 5a48 <malloc+0x7b0>
     e4e:	392040ef          	jal	51e0 <printf>
    exit(1);
     e52:	4505                	li	a0,1
     e54:	783030ef          	jal	4dd6 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e58:	85ca                	mv	a1,s2
     e5a:	00005517          	auipc	a0,0x5
     e5e:	c0650513          	addi	a0,a0,-1018 # 5a60 <malloc+0x7c8>
     e62:	37e040ef          	jal	51e0 <printf>
    exit(1);
     e66:	4505                	li	a0,1
     e68:	76f030ef          	jal	4dd6 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e6c:	85ca                	mv	a1,s2
     e6e:	00005517          	auipc	a0,0x5
     e72:	c1a50513          	addi	a0,a0,-998 # 5a88 <malloc+0x7f0>
     e76:	36a040ef          	jal	51e0 <printf>
    exit(1);
     e7a:	4505                	li	a0,1
     e7c:	75b030ef          	jal	4dd6 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e80:	85ca                	mv	a1,s2
     e82:	00005517          	auipc	a0,0x5
     e86:	c3650513          	addi	a0,a0,-970 # 5ab8 <malloc+0x820>
     e8a:	356040ef          	jal	51e0 <printf>
    exit(1);
     e8e:	4505                	li	a0,1
     e90:	747030ef          	jal	4dd6 <exit>

0000000000000e94 <validatetest>:
{
     e94:	7139                	addi	sp,sp,-64
     e96:	fc06                	sd	ra,56(sp)
     e98:	f822                	sd	s0,48(sp)
     e9a:	f426                	sd	s1,40(sp)
     e9c:	f04a                	sd	s2,32(sp)
     e9e:	ec4e                	sd	s3,24(sp)
     ea0:	e852                	sd	s4,16(sp)
     ea2:	e456                	sd	s5,8(sp)
     ea4:	e05a                	sd	s6,0(sp)
     ea6:	0080                	addi	s0,sp,64
     ea8:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     eaa:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
     eac:	00005997          	auipc	s3,0x5
     eb0:	c2c98993          	addi	s3,s3,-980 # 5ad8 <malloc+0x840>
     eb4:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     eb6:	6a85                	lui	s5,0x1
     eb8:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
     ebc:	85a6                	mv	a1,s1
     ebe:	854e                	mv	a0,s3
     ec0:	777030ef          	jal	4e36 <link>
     ec4:	01251f63          	bne	a0,s2,ee2 <validatetest+0x4e>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     ec8:	94d6                	add	s1,s1,s5
     eca:	ff4499e3          	bne	s1,s4,ebc <validatetest+0x28>
}
     ece:	70e2                	ld	ra,56(sp)
     ed0:	7442                	ld	s0,48(sp)
     ed2:	74a2                	ld	s1,40(sp)
     ed4:	7902                	ld	s2,32(sp)
     ed6:	69e2                	ld	s3,24(sp)
     ed8:	6a42                	ld	s4,16(sp)
     eda:	6aa2                	ld	s5,8(sp)
     edc:	6b02                	ld	s6,0(sp)
     ede:	6121                	addi	sp,sp,64
     ee0:	8082                	ret
      printf("%s: link should not succeed\n", s);
     ee2:	85da                	mv	a1,s6
     ee4:	00005517          	auipc	a0,0x5
     ee8:	c0450513          	addi	a0,a0,-1020 # 5ae8 <malloc+0x850>
     eec:	2f4040ef          	jal	51e0 <printf>
      exit(1);
     ef0:	4505                	li	a0,1
     ef2:	6e5030ef          	jal	4dd6 <exit>

0000000000000ef6 <bigdir>:
{
     ef6:	711d                	addi	sp,sp,-96
     ef8:	ec86                	sd	ra,88(sp)
     efa:	e8a2                	sd	s0,80(sp)
     efc:	e4a6                	sd	s1,72(sp)
     efe:	e0ca                	sd	s2,64(sp)
     f00:	fc4e                	sd	s3,56(sp)
     f02:	f852                	sd	s4,48(sp)
     f04:	f456                	sd	s5,40(sp)
     f06:	f05a                	sd	s6,32(sp)
     f08:	ec5e                	sd	s7,24(sp)
     f0a:	1080                	addi	s0,sp,96
     f0c:	89aa                	mv	s3,a0
  unlink("bd");
     f0e:	00005517          	auipc	a0,0x5
     f12:	bfa50513          	addi	a0,a0,-1030 # 5b08 <malloc+0x870>
     f16:	711030ef          	jal	4e26 <unlink>
  fd = open("bd", O_CREATE);
     f1a:	20000593          	li	a1,512
     f1e:	00005517          	auipc	a0,0x5
     f22:	bea50513          	addi	a0,a0,-1046 # 5b08 <malloc+0x870>
     f26:	6f1030ef          	jal	4e16 <open>
  if(fd < 0){
     f2a:	0c054463          	bltz	a0,ff2 <bigdir+0xfc>
  close(fd);
     f2e:	6d1030ef          	jal	4dfe <close>
  for(i = 0; i < N; i++){
     f32:	4901                	li	s2,0
    name[0] = 'x';
     f34:	07800b13          	li	s6,120
    if(link("bd", name) != 0){
     f38:	fa040a93          	addi	s5,s0,-96
     f3c:	00005a17          	auipc	s4,0x5
     f40:	bcca0a13          	addi	s4,s4,-1076 # 5b08 <malloc+0x870>
  for(i = 0; i < N; i++){
     f44:	1f400b93          	li	s7,500
    name[0] = 'x';
     f48:	fb640023          	sb	s6,-96(s0)
    name[1] = '0' + (i / 64);
     f4c:	41f9571b          	sraiw	a4,s2,0x1f
     f50:	01a7571b          	srliw	a4,a4,0x1a
     f54:	012707bb          	addw	a5,a4,s2
     f58:	4067d69b          	sraiw	a3,a5,0x6
     f5c:	0306869b          	addiw	a3,a3,48
     f60:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     f64:	03f7f793          	andi	a5,a5,63
     f68:	9f99                	subw	a5,a5,a4
     f6a:	0307879b          	addiw	a5,a5,48
     f6e:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     f72:	fa0401a3          	sb	zero,-93(s0)
    if(link("bd", name) != 0){
     f76:	85d6                	mv	a1,s5
     f78:	8552                	mv	a0,s4
     f7a:	6bd030ef          	jal	4e36 <link>
     f7e:	84aa                	mv	s1,a0
     f80:	e159                	bnez	a0,1006 <bigdir+0x110>
  for(i = 0; i < N; i++){
     f82:	2905                	addiw	s2,s2,1
     f84:	fd7912e3          	bne	s2,s7,f48 <bigdir+0x52>
  unlink("bd");
     f88:	00005517          	auipc	a0,0x5
     f8c:	b8050513          	addi	a0,a0,-1152 # 5b08 <malloc+0x870>
     f90:	697030ef          	jal	4e26 <unlink>
    name[0] = 'x';
     f94:	07800a13          	li	s4,120
    if(unlink(name) != 0){
     f98:	fa040913          	addi	s2,s0,-96
  for(i = 0; i < N; i++){
     f9c:	1f400a93          	li	s5,500
    name[0] = 'x';
     fa0:	fb440023          	sb	s4,-96(s0)
    name[1] = '0' + (i / 64);
     fa4:	41f4d71b          	sraiw	a4,s1,0x1f
     fa8:	01a7571b          	srliw	a4,a4,0x1a
     fac:	009707bb          	addw	a5,a4,s1
     fb0:	4067d69b          	sraiw	a3,a5,0x6
     fb4:	0306869b          	addiw	a3,a3,48
     fb8:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     fbc:	03f7f793          	andi	a5,a5,63
     fc0:	9f99                	subw	a5,a5,a4
     fc2:	0307879b          	addiw	a5,a5,48
     fc6:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     fca:	fa0401a3          	sb	zero,-93(s0)
    if(unlink(name) != 0){
     fce:	854a                	mv	a0,s2
     fd0:	657030ef          	jal	4e26 <unlink>
     fd4:	e531                	bnez	a0,1020 <bigdir+0x12a>
  for(i = 0; i < N; i++){
     fd6:	2485                	addiw	s1,s1,1
     fd8:	fd5494e3          	bne	s1,s5,fa0 <bigdir+0xaa>
}
     fdc:	60e6                	ld	ra,88(sp)
     fde:	6446                	ld	s0,80(sp)
     fe0:	64a6                	ld	s1,72(sp)
     fe2:	6906                	ld	s2,64(sp)
     fe4:	79e2                	ld	s3,56(sp)
     fe6:	7a42                	ld	s4,48(sp)
     fe8:	7aa2                	ld	s5,40(sp)
     fea:	7b02                	ld	s6,32(sp)
     fec:	6be2                	ld	s7,24(sp)
     fee:	6125                	addi	sp,sp,96
     ff0:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     ff2:	85ce                	mv	a1,s3
     ff4:	00005517          	auipc	a0,0x5
     ff8:	b1c50513          	addi	a0,a0,-1252 # 5b10 <malloc+0x878>
     ffc:	1e4040ef          	jal	51e0 <printf>
    exit(1);
    1000:	4505                	li	a0,1
    1002:	5d5030ef          	jal	4dd6 <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
    1006:	fa040693          	addi	a3,s0,-96
    100a:	864a                	mv	a2,s2
    100c:	85ce                	mv	a1,s3
    100e:	00005517          	auipc	a0,0x5
    1012:	b2250513          	addi	a0,a0,-1246 # 5b30 <malloc+0x898>
    1016:	1ca040ef          	jal	51e0 <printf>
      exit(1);
    101a:	4505                	li	a0,1
    101c:	5bb030ef          	jal	4dd6 <exit>
      printf("%s: bigdir unlink failed", s);
    1020:	85ce                	mv	a1,s3
    1022:	00005517          	auipc	a0,0x5
    1026:	b3650513          	addi	a0,a0,-1226 # 5b58 <malloc+0x8c0>
    102a:	1b6040ef          	jal	51e0 <printf>
      exit(1);
    102e:	4505                	li	a0,1
    1030:	5a7030ef          	jal	4dd6 <exit>

0000000000001034 <pgbug>:
{
    1034:	7179                	addi	sp,sp,-48
    1036:	f406                	sd	ra,40(sp)
    1038:	f022                	sd	s0,32(sp)
    103a:	ec26                	sd	s1,24(sp)
    103c:	1800                	addi	s0,sp,48
  argv[0] = 0;
    103e:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1042:	00008497          	auipc	s1,0x8
    1046:	fbe48493          	addi	s1,s1,-66 # 9000 <big>
    104a:	fd840593          	addi	a1,s0,-40
    104e:	6088                	ld	a0,0(s1)
    1050:	5bf030ef          	jal	4e0e <exec>
  pipe(big);
    1054:	6088                	ld	a0,0(s1)
    1056:	591030ef          	jal	4de6 <pipe>
  exit(0);
    105a:	4501                	li	a0,0
    105c:	57b030ef          	jal	4dd6 <exit>

0000000000001060 <badarg>:
{
    1060:	7139                	addi	sp,sp,-64
    1062:	fc06                	sd	ra,56(sp)
    1064:	f822                	sd	s0,48(sp)
    1066:	f426                	sd	s1,40(sp)
    1068:	f04a                	sd	s2,32(sp)
    106a:	ec4e                	sd	s3,24(sp)
    106c:	e852                	sd	s4,16(sp)
    106e:	0080                	addi	s0,sp,64
    1070:	64b1                	lui	s1,0xc
    1072:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1076:	597d                	li	s2,-1
    1078:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    107c:	fc040a13          	addi	s4,s0,-64
    1080:	00004997          	auipc	s3,0x4
    1084:	34898993          	addi	s3,s3,840 # 53c8 <malloc+0x130>
    argv[0] = (char*)0xffffffff;
    1088:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    108c:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1090:	85d2                	mv	a1,s4
    1092:	854e                	mv	a0,s3
    1094:	57b030ef          	jal	4e0e <exec>
  for(int i = 0; i < 50000; i++){
    1098:	34fd                	addiw	s1,s1,-1
    109a:	f4fd                	bnez	s1,1088 <badarg+0x28>
  exit(0);
    109c:	4501                	li	a0,0
    109e:	539030ef          	jal	4dd6 <exit>

00000000000010a2 <copyinstr2>:
{
    10a2:	7155                	addi	sp,sp,-208
    10a4:	e586                	sd	ra,200(sp)
    10a6:	e1a2                	sd	s0,192(sp)
    10a8:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    10aa:	f6840793          	addi	a5,s0,-152
    10ae:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    10b2:	07800713          	li	a4,120
    10b6:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    10ba:	0785                	addi	a5,a5,1
    10bc:	fed79de3          	bne	a5,a3,10b6 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    10c0:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    10c4:	f6840513          	addi	a0,s0,-152
    10c8:	55f030ef          	jal	4e26 <unlink>
  if(ret != -1){
    10cc:	57fd                	li	a5,-1
    10ce:	0cf51263          	bne	a0,a5,1192 <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    10d2:	20100593          	li	a1,513
    10d6:	f6840513          	addi	a0,s0,-152
    10da:	53d030ef          	jal	4e16 <open>
  if(fd != -1){
    10de:	57fd                	li	a5,-1
    10e0:	0cf51563          	bne	a0,a5,11aa <copyinstr2+0x108>
  ret = link(b, b);
    10e4:	f6840513          	addi	a0,s0,-152
    10e8:	85aa                	mv	a1,a0
    10ea:	54d030ef          	jal	4e36 <link>
  if(ret != -1){
    10ee:	57fd                	li	a5,-1
    10f0:	0cf51963          	bne	a0,a5,11c2 <copyinstr2+0x120>
  char *args[] = { "xx", 0 };
    10f4:	00006797          	auipc	a5,0x6
    10f8:	bb478793          	addi	a5,a5,-1100 # 6ca8 <malloc+0x1a10>
    10fc:	f4f43c23          	sd	a5,-168(s0)
    1100:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1104:	f5840593          	addi	a1,s0,-168
    1108:	f6840513          	addi	a0,s0,-152
    110c:	503030ef          	jal	4e0e <exec>
  if(ret != -1){
    1110:	57fd                	li	a5,-1
    1112:	0cf51563          	bne	a0,a5,11dc <copyinstr2+0x13a>
  int pid = fork();
    1116:	4b9030ef          	jal	4dce <fork>
  if(pid < 0){
    111a:	0c054d63          	bltz	a0,11f4 <copyinstr2+0x152>
  if(pid == 0){
    111e:	0e051863          	bnez	a0,120e <copyinstr2+0x16c>
    1122:	00008797          	auipc	a5,0x8
    1126:	43e78793          	addi	a5,a5,1086 # 9560 <big.0>
    112a:	00009697          	auipc	a3,0x9
    112e:	43668693          	addi	a3,a3,1078 # a560 <big.0+0x1000>
      big[i] = 'x';
    1132:	07800713          	li	a4,120
    1136:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    113a:	0785                	addi	a5,a5,1
    113c:	fed79de3          	bne	a5,a3,1136 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    1140:	00009797          	auipc	a5,0x9
    1144:	42078023          	sb	zero,1056(a5) # a560 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    1148:	00006797          	auipc	a5,0x6
    114c:	5e078793          	addi	a5,a5,1504 # 7728 <malloc+0x2490>
    1150:	6fb0                	ld	a2,88(a5)
    1152:	73b4                	ld	a3,96(a5)
    1154:	77b8                	ld	a4,104(a5)
    1156:	7bbc                	ld	a5,112(a5)
    1158:	f2c43823          	sd	a2,-208(s0)
    115c:	f2d43c23          	sd	a3,-200(s0)
    1160:	f4e43023          	sd	a4,-192(s0)
    1164:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1168:	f3040593          	addi	a1,s0,-208
    116c:	00004517          	auipc	a0,0x4
    1170:	25c50513          	addi	a0,a0,604 # 53c8 <malloc+0x130>
    1174:	49b030ef          	jal	4e0e <exec>
    if(ret != -1){
    1178:	57fd                	li	a5,-1
    117a:	08f50663          	beq	a0,a5,1206 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    117e:	85be                	mv	a1,a5
    1180:	00005517          	auipc	a0,0x5
    1184:	a8050513          	addi	a0,a0,-1408 # 5c00 <malloc+0x968>
    1188:	058040ef          	jal	51e0 <printf>
      exit(1);
    118c:	4505                	li	a0,1
    118e:	449030ef          	jal	4dd6 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1192:	862a                	mv	a2,a0
    1194:	f6840593          	addi	a1,s0,-152
    1198:	00005517          	auipc	a0,0x5
    119c:	9e050513          	addi	a0,a0,-1568 # 5b78 <malloc+0x8e0>
    11a0:	040040ef          	jal	51e0 <printf>
    exit(1);
    11a4:	4505                	li	a0,1
    11a6:	431030ef          	jal	4dd6 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    11aa:	862a                	mv	a2,a0
    11ac:	f6840593          	addi	a1,s0,-152
    11b0:	00005517          	auipc	a0,0x5
    11b4:	9e850513          	addi	a0,a0,-1560 # 5b98 <malloc+0x900>
    11b8:	028040ef          	jal	51e0 <printf>
    exit(1);
    11bc:	4505                	li	a0,1
    11be:	419030ef          	jal	4dd6 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    11c2:	f6840593          	addi	a1,s0,-152
    11c6:	86aa                	mv	a3,a0
    11c8:	862e                	mv	a2,a1
    11ca:	00005517          	auipc	a0,0x5
    11ce:	9ee50513          	addi	a0,a0,-1554 # 5bb8 <malloc+0x920>
    11d2:	00e040ef          	jal	51e0 <printf>
    exit(1);
    11d6:	4505                	li	a0,1
    11d8:	3ff030ef          	jal	4dd6 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    11dc:	863e                	mv	a2,a5
    11de:	f6840593          	addi	a1,s0,-152
    11e2:	00005517          	auipc	a0,0x5
    11e6:	9fe50513          	addi	a0,a0,-1538 # 5be0 <malloc+0x948>
    11ea:	7f7030ef          	jal	51e0 <printf>
    exit(1);
    11ee:	4505                	li	a0,1
    11f0:	3e7030ef          	jal	4dd6 <exit>
    printf("fork failed\n");
    11f4:	00006517          	auipc	a0,0x6
    11f8:	fd450513          	addi	a0,a0,-44 # 71c8 <malloc+0x1f30>
    11fc:	7e5030ef          	jal	51e0 <printf>
    exit(1);
    1200:	4505                	li	a0,1
    1202:	3d5030ef          	jal	4dd6 <exit>
    exit(747); // OK
    1206:	2eb00513          	li	a0,747
    120a:	3cd030ef          	jal	4dd6 <exit>
  int st = 0;
    120e:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1212:	f5440513          	addi	a0,s0,-172
    1216:	3c9030ef          	jal	4dde <wait>
  if(st != 747){
    121a:	f5442703          	lw	a4,-172(s0)
    121e:	2eb00793          	li	a5,747
    1222:	00f71663          	bne	a4,a5,122e <copyinstr2+0x18c>
}
    1226:	60ae                	ld	ra,200(sp)
    1228:	640e                	ld	s0,192(sp)
    122a:	6169                	addi	sp,sp,208
    122c:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    122e:	00005517          	auipc	a0,0x5
    1232:	9fa50513          	addi	a0,a0,-1542 # 5c28 <malloc+0x990>
    1236:	7ab030ef          	jal	51e0 <printf>
    exit(1);
    123a:	4505                	li	a0,1
    123c:	39b030ef          	jal	4dd6 <exit>

0000000000001240 <truncate3>:
{
    1240:	7175                	addi	sp,sp,-144
    1242:	e506                	sd	ra,136(sp)
    1244:	e122                	sd	s0,128(sp)
    1246:	ecd6                	sd	s5,88(sp)
    1248:	0900                	addi	s0,sp,144
    124a:	8aaa                	mv	s5,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    124c:	60100593          	li	a1,1537
    1250:	00004517          	auipc	a0,0x4
    1254:	1d050513          	addi	a0,a0,464 # 5420 <malloc+0x188>
    1258:	3bf030ef          	jal	4e16 <open>
    125c:	3a3030ef          	jal	4dfe <close>
  pid = fork();
    1260:	36f030ef          	jal	4dce <fork>
  if(pid < 0){
    1264:	06054d63          	bltz	a0,12de <truncate3+0x9e>
  if(pid == 0){
    1268:	e171                	bnez	a0,132c <truncate3+0xec>
    126a:	fca6                	sd	s1,120(sp)
    126c:	f8ca                	sd	s2,112(sp)
    126e:	f4ce                	sd	s3,104(sp)
    1270:	f0d2                	sd	s4,96(sp)
    1272:	e8da                	sd	s6,80(sp)
    1274:	e4de                	sd	s7,72(sp)
    1276:	e0e2                	sd	s8,64(sp)
    1278:	fc66                	sd	s9,56(sp)
    127a:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    127e:	4b05                	li	s6,1
    1280:	00004997          	auipc	s3,0x4
    1284:	1a098993          	addi	s3,s3,416 # 5420 <malloc+0x188>
      int n = write(fd, "1234567890", 10);
    1288:	4a29                	li	s4,10
    128a:	00005b97          	auipc	s7,0x5
    128e:	9feb8b93          	addi	s7,s7,-1538 # 5c88 <malloc+0x9f0>
      read(fd, buf, sizeof(buf));
    1292:	f7840c93          	addi	s9,s0,-136
    1296:	02000c13          	li	s8,32
      int fd = open("truncfile", O_WRONLY);
    129a:	85da                	mv	a1,s6
    129c:	854e                	mv	a0,s3
    129e:	379030ef          	jal	4e16 <open>
    12a2:	84aa                	mv	s1,a0
      if(fd < 0){
    12a4:	04054f63          	bltz	a0,1302 <truncate3+0xc2>
      int n = write(fd, "1234567890", 10);
    12a8:	8652                	mv	a2,s4
    12aa:	85de                	mv	a1,s7
    12ac:	34b030ef          	jal	4df6 <write>
      if(n != 10){
    12b0:	07451363          	bne	a0,s4,1316 <truncate3+0xd6>
      close(fd);
    12b4:	8526                	mv	a0,s1
    12b6:	349030ef          	jal	4dfe <close>
      fd = open("truncfile", O_RDONLY);
    12ba:	4581                	li	a1,0
    12bc:	854e                	mv	a0,s3
    12be:	359030ef          	jal	4e16 <open>
    12c2:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    12c4:	8662                	mv	a2,s8
    12c6:	85e6                	mv	a1,s9
    12c8:	327030ef          	jal	4dee <read>
      close(fd);
    12cc:	8526                	mv	a0,s1
    12ce:	331030ef          	jal	4dfe <close>
    for(int i = 0; i < 100; i++){
    12d2:	397d                	addiw	s2,s2,-1
    12d4:	fc0913e3          	bnez	s2,129a <truncate3+0x5a>
    exit(0);
    12d8:	4501                	li	a0,0
    12da:	2fd030ef          	jal	4dd6 <exit>
    12de:	fca6                	sd	s1,120(sp)
    12e0:	f8ca                	sd	s2,112(sp)
    12e2:	f4ce                	sd	s3,104(sp)
    12e4:	f0d2                	sd	s4,96(sp)
    12e6:	e8da                	sd	s6,80(sp)
    12e8:	e4de                	sd	s7,72(sp)
    12ea:	e0e2                	sd	s8,64(sp)
    12ec:	fc66                	sd	s9,56(sp)
    printf("%s: fork failed\n", s);
    12ee:	85d6                	mv	a1,s5
    12f0:	00005517          	auipc	a0,0x5
    12f4:	96850513          	addi	a0,a0,-1688 # 5c58 <malloc+0x9c0>
    12f8:	6e9030ef          	jal	51e0 <printf>
    exit(1);
    12fc:	4505                	li	a0,1
    12fe:	2d9030ef          	jal	4dd6 <exit>
        printf("%s: open failed\n", s);
    1302:	85d6                	mv	a1,s5
    1304:	00005517          	auipc	a0,0x5
    1308:	96c50513          	addi	a0,a0,-1684 # 5c70 <malloc+0x9d8>
    130c:	6d5030ef          	jal	51e0 <printf>
        exit(1);
    1310:	4505                	li	a0,1
    1312:	2c5030ef          	jal	4dd6 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1316:	862a                	mv	a2,a0
    1318:	85d6                	mv	a1,s5
    131a:	00005517          	auipc	a0,0x5
    131e:	97e50513          	addi	a0,a0,-1666 # 5c98 <malloc+0xa00>
    1322:	6bf030ef          	jal	51e0 <printf>
        exit(1);
    1326:	4505                	li	a0,1
    1328:	2af030ef          	jal	4dd6 <exit>
    132c:	fca6                	sd	s1,120(sp)
    132e:	f8ca                	sd	s2,112(sp)
    1330:	f4ce                	sd	s3,104(sp)
    1332:	f0d2                	sd	s4,96(sp)
    1334:	e8da                	sd	s6,80(sp)
    1336:	e4de                	sd	s7,72(sp)
    1338:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    133c:	60100b13          	li	s6,1537
    1340:	00004a17          	auipc	s4,0x4
    1344:	0e0a0a13          	addi	s4,s4,224 # 5420 <malloc+0x188>
    int n = write(fd, "xxx", 3);
    1348:	498d                	li	s3,3
    134a:	00005b97          	auipc	s7,0x5
    134e:	96eb8b93          	addi	s7,s7,-1682 # 5cb8 <malloc+0xa20>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1352:	85da                	mv	a1,s6
    1354:	8552                	mv	a0,s4
    1356:	2c1030ef          	jal	4e16 <open>
    135a:	84aa                	mv	s1,a0
    if(fd < 0){
    135c:	02054e63          	bltz	a0,1398 <truncate3+0x158>
    int n = write(fd, "xxx", 3);
    1360:	864e                	mv	a2,s3
    1362:	85de                	mv	a1,s7
    1364:	293030ef          	jal	4df6 <write>
    if(n != 3){
    1368:	05351463          	bne	a0,s3,13b0 <truncate3+0x170>
    close(fd);
    136c:	8526                	mv	a0,s1
    136e:	291030ef          	jal	4dfe <close>
  for(int i = 0; i < 150; i++){
    1372:	397d                	addiw	s2,s2,-1
    1374:	fc091fe3          	bnez	s2,1352 <truncate3+0x112>
    1378:	e0e2                	sd	s8,64(sp)
    137a:	fc66                	sd	s9,56(sp)
  wait(&xstatus);
    137c:	f9c40513          	addi	a0,s0,-100
    1380:	25f030ef          	jal	4dde <wait>
  unlink("truncfile");
    1384:	00004517          	auipc	a0,0x4
    1388:	09c50513          	addi	a0,a0,156 # 5420 <malloc+0x188>
    138c:	29b030ef          	jal	4e26 <unlink>
  exit(xstatus);
    1390:	f9c42503          	lw	a0,-100(s0)
    1394:	243030ef          	jal	4dd6 <exit>
    1398:	e0e2                	sd	s8,64(sp)
    139a:	fc66                	sd	s9,56(sp)
      printf("%s: open failed\n", s);
    139c:	85d6                	mv	a1,s5
    139e:	00005517          	auipc	a0,0x5
    13a2:	8d250513          	addi	a0,a0,-1838 # 5c70 <malloc+0x9d8>
    13a6:	63b030ef          	jal	51e0 <printf>
      exit(1);
    13aa:	4505                	li	a0,1
    13ac:	22b030ef          	jal	4dd6 <exit>
    13b0:	e0e2                	sd	s8,64(sp)
    13b2:	fc66                	sd	s9,56(sp)
      printf("%s: write got %d, expected 3\n", s, n);
    13b4:	862a                	mv	a2,a0
    13b6:	85d6                	mv	a1,s5
    13b8:	00005517          	auipc	a0,0x5
    13bc:	90850513          	addi	a0,a0,-1784 # 5cc0 <malloc+0xa28>
    13c0:	621030ef          	jal	51e0 <printf>
      exit(1);
    13c4:	4505                	li	a0,1
    13c6:	211030ef          	jal	4dd6 <exit>

00000000000013ca <exectest>:
{
    13ca:	715d                	addi	sp,sp,-80
    13cc:	e486                	sd	ra,72(sp)
    13ce:	e0a2                	sd	s0,64(sp)
    13d0:	f84a                	sd	s2,48(sp)
    13d2:	0880                	addi	s0,sp,80
    13d4:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    13d6:	00004797          	auipc	a5,0x4
    13da:	ff278793          	addi	a5,a5,-14 # 53c8 <malloc+0x130>
    13de:	fcf43023          	sd	a5,-64(s0)
    13e2:	00005797          	auipc	a5,0x5
    13e6:	8fe78793          	addi	a5,a5,-1794 # 5ce0 <malloc+0xa48>
    13ea:	fcf43423          	sd	a5,-56(s0)
    13ee:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    13f2:	00005517          	auipc	a0,0x5
    13f6:	8f650513          	addi	a0,a0,-1802 # 5ce8 <malloc+0xa50>
    13fa:	22d030ef          	jal	4e26 <unlink>
  pid = fork();
    13fe:	1d1030ef          	jal	4dce <fork>
  if(pid < 0) {
    1402:	02054f63          	bltz	a0,1440 <exectest+0x76>
    1406:	fc26                	sd	s1,56(sp)
    1408:	84aa                	mv	s1,a0
  if(pid == 0) {
    140a:	e935                	bnez	a0,147e <exectest+0xb4>
    close(1);
    140c:	4505                	li	a0,1
    140e:	1f1030ef          	jal	4dfe <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1412:	20100593          	li	a1,513
    1416:	00005517          	auipc	a0,0x5
    141a:	8d250513          	addi	a0,a0,-1838 # 5ce8 <malloc+0xa50>
    141e:	1f9030ef          	jal	4e16 <open>
    if(fd < 0) {
    1422:	02054a63          	bltz	a0,1456 <exectest+0x8c>
    if(fd != 1) {
    1426:	4785                	li	a5,1
    1428:	04f50163          	beq	a0,a5,146a <exectest+0xa0>
      printf("%s: wrong fd\n", s);
    142c:	85ca                	mv	a1,s2
    142e:	00005517          	auipc	a0,0x5
    1432:	8da50513          	addi	a0,a0,-1830 # 5d08 <malloc+0xa70>
    1436:	5ab030ef          	jal	51e0 <printf>
      exit(1);
    143a:	4505                	li	a0,1
    143c:	19b030ef          	jal	4dd6 <exit>
    1440:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    1442:	85ca                	mv	a1,s2
    1444:	00005517          	auipc	a0,0x5
    1448:	81450513          	addi	a0,a0,-2028 # 5c58 <malloc+0x9c0>
    144c:	595030ef          	jal	51e0 <printf>
     exit(1);
    1450:	4505                	li	a0,1
    1452:	185030ef          	jal	4dd6 <exit>
      printf("%s: create failed\n", s);
    1456:	85ca                	mv	a1,s2
    1458:	00005517          	auipc	a0,0x5
    145c:	89850513          	addi	a0,a0,-1896 # 5cf0 <malloc+0xa58>
    1460:	581030ef          	jal	51e0 <printf>
      exit(1);
    1464:	4505                	li	a0,1
    1466:	171030ef          	jal	4dd6 <exit>
    if(exec("echo", echoargv) < 0){
    146a:	fc040593          	addi	a1,s0,-64
    146e:	00004517          	auipc	a0,0x4
    1472:	f5a50513          	addi	a0,a0,-166 # 53c8 <malloc+0x130>
    1476:	199030ef          	jal	4e0e <exec>
    147a:	00054d63          	bltz	a0,1494 <exectest+0xca>
  if (wait(&xstatus) != pid) {
    147e:	fdc40513          	addi	a0,s0,-36
    1482:	15d030ef          	jal	4dde <wait>
    1486:	02951163          	bne	a0,s1,14a8 <exectest+0xde>
  if(xstatus != 0)
    148a:	fdc42503          	lw	a0,-36(s0)
    148e:	c50d                	beqz	a0,14b8 <exectest+0xee>
    exit(xstatus);
    1490:	147030ef          	jal	4dd6 <exit>
      printf("%s: exec echo failed\n", s);
    1494:	85ca                	mv	a1,s2
    1496:	00005517          	auipc	a0,0x5
    149a:	88250513          	addi	a0,a0,-1918 # 5d18 <malloc+0xa80>
    149e:	543030ef          	jal	51e0 <printf>
      exit(1);
    14a2:	4505                	li	a0,1
    14a4:	133030ef          	jal	4dd6 <exit>
    printf("%s: wait failed!\n", s);
    14a8:	85ca                	mv	a1,s2
    14aa:	00005517          	auipc	a0,0x5
    14ae:	88650513          	addi	a0,a0,-1914 # 5d30 <malloc+0xa98>
    14b2:	52f030ef          	jal	51e0 <printf>
    14b6:	bfd1                	j	148a <exectest+0xc0>
  fd = open("echo-ok", O_RDONLY);
    14b8:	4581                	li	a1,0
    14ba:	00005517          	auipc	a0,0x5
    14be:	82e50513          	addi	a0,a0,-2002 # 5ce8 <malloc+0xa50>
    14c2:	155030ef          	jal	4e16 <open>
  if(fd < 0) {
    14c6:	02054463          	bltz	a0,14ee <exectest+0x124>
  if (read(fd, buf, 2) != 2) {
    14ca:	4609                	li	a2,2
    14cc:	fb840593          	addi	a1,s0,-72
    14d0:	11f030ef          	jal	4dee <read>
    14d4:	4789                	li	a5,2
    14d6:	02f50663          	beq	a0,a5,1502 <exectest+0x138>
    printf("%s: read failed\n", s);
    14da:	85ca                	mv	a1,s2
    14dc:	00004517          	auipc	a0,0x4
    14e0:	2bc50513          	addi	a0,a0,700 # 5798 <malloc+0x500>
    14e4:	4fd030ef          	jal	51e0 <printf>
    exit(1);
    14e8:	4505                	li	a0,1
    14ea:	0ed030ef          	jal	4dd6 <exit>
    printf("%s: open failed\n", s);
    14ee:	85ca                	mv	a1,s2
    14f0:	00004517          	auipc	a0,0x4
    14f4:	78050513          	addi	a0,a0,1920 # 5c70 <malloc+0x9d8>
    14f8:	4e9030ef          	jal	51e0 <printf>
    exit(1);
    14fc:	4505                	li	a0,1
    14fe:	0d9030ef          	jal	4dd6 <exit>
  unlink("echo-ok");
    1502:	00004517          	auipc	a0,0x4
    1506:	7e650513          	addi	a0,a0,2022 # 5ce8 <malloc+0xa50>
    150a:	11d030ef          	jal	4e26 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    150e:	fb844703          	lbu	a4,-72(s0)
    1512:	04f00793          	li	a5,79
    1516:	00f71863          	bne	a4,a5,1526 <exectest+0x15c>
    151a:	fb944703          	lbu	a4,-71(s0)
    151e:	04b00793          	li	a5,75
    1522:	00f70c63          	beq	a4,a5,153a <exectest+0x170>
    printf("%s: wrong output\n", s);
    1526:	85ca                	mv	a1,s2
    1528:	00005517          	auipc	a0,0x5
    152c:	82050513          	addi	a0,a0,-2016 # 5d48 <malloc+0xab0>
    1530:	4b1030ef          	jal	51e0 <printf>
    exit(1);
    1534:	4505                	li	a0,1
    1536:	0a1030ef          	jal	4dd6 <exit>
    exit(0);
    153a:	4501                	li	a0,0
    153c:	09b030ef          	jal	4dd6 <exit>

0000000000001540 <pipe1>:
{
    1540:	711d                	addi	sp,sp,-96
    1542:	ec86                	sd	ra,88(sp)
    1544:	e8a2                	sd	s0,80(sp)
    1546:	e0ca                	sd	s2,64(sp)
    1548:	1080                	addi	s0,sp,96
    154a:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    154c:	fa840513          	addi	a0,s0,-88
    1550:	097030ef          	jal	4de6 <pipe>
    1554:	e53d                	bnez	a0,15c2 <pipe1+0x82>
    1556:	e4a6                	sd	s1,72(sp)
    1558:	f852                	sd	s4,48(sp)
    155a:	84aa                	mv	s1,a0
  pid = fork();
    155c:	073030ef          	jal	4dce <fork>
    1560:	8a2a                	mv	s4,a0
  if(pid == 0){
    1562:	c149                	beqz	a0,15e4 <pipe1+0xa4>
  } else if(pid > 0){
    1564:	14a05f63          	blez	a0,16c2 <pipe1+0x182>
    1568:	fc4e                	sd	s3,56(sp)
    156a:	f456                	sd	s5,40(sp)
    close(fds[1]);
    156c:	fac42503          	lw	a0,-84(s0)
    1570:	08f030ef          	jal	4dfe <close>
    total = 0;
    1574:	8a26                	mv	s4,s1
    cc = 1;
    1576:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1578:	0000ba97          	auipc	s5,0xb
    157c:	700a8a93          	addi	s5,s5,1792 # cc78 <buf>
    1580:	864e                	mv	a2,s3
    1582:	85d6                	mv	a1,s5
    1584:	fa842503          	lw	a0,-88(s0)
    1588:	067030ef          	jal	4dee <read>
    158c:	0ea05963          	blez	a0,167e <pipe1+0x13e>
    1590:	0000b717          	auipc	a4,0xb
    1594:	6e870713          	addi	a4,a4,1768 # cc78 <buf>
    1598:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    159c:	00074683          	lbu	a3,0(a4)
    15a0:	0ff4f793          	zext.b	a5,s1
    15a4:	2485                	addiw	s1,s1,1
    15a6:	0af69c63          	bne	a3,a5,165e <pipe1+0x11e>
      for(i = 0; i < n; i++){
    15aa:	0705                	addi	a4,a4,1
    15ac:	fec498e3          	bne	s1,a2,159c <pipe1+0x5c>
      total += n;
    15b0:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    15b4:	0019999b          	slliw	s3,s3,0x1
      if(cc > sizeof(buf))
    15b8:	678d                	lui	a5,0x3
    15ba:	fd37f3e3          	bgeu	a5,s3,1580 <pipe1+0x40>
        cc = sizeof(buf);
    15be:	89be                	mv	s3,a5
    15c0:	b7c1                	j	1580 <pipe1+0x40>
    15c2:	e4a6                	sd	s1,72(sp)
    15c4:	fc4e                	sd	s3,56(sp)
    15c6:	f852                	sd	s4,48(sp)
    15c8:	f456                	sd	s5,40(sp)
    15ca:	f05a                	sd	s6,32(sp)
    15cc:	ec5e                	sd	s7,24(sp)
    15ce:	e862                	sd	s8,16(sp)
    printf("%s: pipe() failed\n", s);
    15d0:	85ca                	mv	a1,s2
    15d2:	00004517          	auipc	a0,0x4
    15d6:	78e50513          	addi	a0,a0,1934 # 5d60 <malloc+0xac8>
    15da:	407030ef          	jal	51e0 <printf>
    exit(1);
    15de:	4505                	li	a0,1
    15e0:	7f6030ef          	jal	4dd6 <exit>
    15e4:	fc4e                	sd	s3,56(sp)
    15e6:	f456                	sd	s5,40(sp)
    15e8:	f05a                	sd	s6,32(sp)
    15ea:	ec5e                	sd	s7,24(sp)
    15ec:	e862                	sd	s8,16(sp)
    close(fds[0]);
    15ee:	fa842503          	lw	a0,-88(s0)
    15f2:	00d030ef          	jal	4dfe <close>
    for(n = 0; n < N; n++){
    15f6:	0000bb97          	auipc	s7,0xb
    15fa:	682b8b93          	addi	s7,s7,1666 # cc78 <buf>
    15fe:	417004bb          	negw	s1,s7
    1602:	0ff4f493          	zext.b	s1,s1
    1606:	409b8993          	addi	s3,s7,1033
      if(write(fds[1], buf, SZ) != SZ){
    160a:	40900a93          	li	s5,1033
    160e:	8c5e                	mv	s8,s7
    for(n = 0; n < N; n++){
    1610:	6b05                	lui	s6,0x1
    1612:	42db0b13          	addi	s6,s6,1069 # 142d <exectest+0x63>
{
    1616:	87de                	mv	a5,s7
        buf[i] = seq++;
    1618:	0097873b          	addw	a4,a5,s1
    161c:	00e78023          	sb	a4,0(a5) # 3000 <subdir+0x304>
      for(i = 0; i < SZ; i++)
    1620:	0785                	addi	a5,a5,1
    1622:	ff379be3          	bne	a5,s3,1618 <pipe1+0xd8>
    1626:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    162a:	8656                	mv	a2,s5
    162c:	85e2                	mv	a1,s8
    162e:	fac42503          	lw	a0,-84(s0)
    1632:	7c4030ef          	jal	4df6 <write>
    1636:	01551a63          	bne	a0,s5,164a <pipe1+0x10a>
    for(n = 0; n < N; n++){
    163a:	24a5                	addiw	s1,s1,9
    163c:	0ff4f493          	zext.b	s1,s1
    1640:	fd6a1be3          	bne	s4,s6,1616 <pipe1+0xd6>
    exit(0);
    1644:	4501                	li	a0,0
    1646:	790030ef          	jal	4dd6 <exit>
        printf("%s: pipe1 oops 1\n", s);
    164a:	85ca                	mv	a1,s2
    164c:	00004517          	auipc	a0,0x4
    1650:	72c50513          	addi	a0,a0,1836 # 5d78 <malloc+0xae0>
    1654:	38d030ef          	jal	51e0 <printf>
        exit(1);
    1658:	4505                	li	a0,1
    165a:	77c030ef          	jal	4dd6 <exit>
          printf("%s: pipe1 oops 2\n", s);
    165e:	85ca                	mv	a1,s2
    1660:	00004517          	auipc	a0,0x4
    1664:	73050513          	addi	a0,a0,1840 # 5d90 <malloc+0xaf8>
    1668:	379030ef          	jal	51e0 <printf>
          return;
    166c:	64a6                	ld	s1,72(sp)
    166e:	79e2                	ld	s3,56(sp)
    1670:	7a42                	ld	s4,48(sp)
    1672:	7aa2                	ld	s5,40(sp)
}
    1674:	60e6                	ld	ra,88(sp)
    1676:	6446                	ld	s0,80(sp)
    1678:	6906                	ld	s2,64(sp)
    167a:	6125                	addi	sp,sp,96
    167c:	8082                	ret
    if(total != N * SZ){
    167e:	6785                	lui	a5,0x1
    1680:	42d78793          	addi	a5,a5,1069 # 142d <exectest+0x63>
    1684:	02fa0063          	beq	s4,a5,16a4 <pipe1+0x164>
    1688:	f05a                	sd	s6,32(sp)
    168a:	ec5e                	sd	s7,24(sp)
    168c:	e862                	sd	s8,16(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    168e:	8652                	mv	a2,s4
    1690:	85ca                	mv	a1,s2
    1692:	00004517          	auipc	a0,0x4
    1696:	71650513          	addi	a0,a0,1814 # 5da8 <malloc+0xb10>
    169a:	347030ef          	jal	51e0 <printf>
      exit(1);
    169e:	4505                	li	a0,1
    16a0:	736030ef          	jal	4dd6 <exit>
    16a4:	f05a                	sd	s6,32(sp)
    16a6:	ec5e                	sd	s7,24(sp)
    16a8:	e862                	sd	s8,16(sp)
    close(fds[0]);
    16aa:	fa842503          	lw	a0,-88(s0)
    16ae:	750030ef          	jal	4dfe <close>
    wait(&xstatus);
    16b2:	fa440513          	addi	a0,s0,-92
    16b6:	728030ef          	jal	4dde <wait>
    exit(xstatus);
    16ba:	fa442503          	lw	a0,-92(s0)
    16be:	718030ef          	jal	4dd6 <exit>
    16c2:	fc4e                	sd	s3,56(sp)
    16c4:	f456                	sd	s5,40(sp)
    16c6:	f05a                	sd	s6,32(sp)
    16c8:	ec5e                	sd	s7,24(sp)
    16ca:	e862                	sd	s8,16(sp)
    printf("%s: fork() failed\n", s);
    16cc:	85ca                	mv	a1,s2
    16ce:	00004517          	auipc	a0,0x4
    16d2:	6fa50513          	addi	a0,a0,1786 # 5dc8 <malloc+0xb30>
    16d6:	30b030ef          	jal	51e0 <printf>
    exit(1);
    16da:	4505                	li	a0,1
    16dc:	6fa030ef          	jal	4dd6 <exit>

00000000000016e0 <exitwait>:
{
    16e0:	715d                	addi	sp,sp,-80
    16e2:	e486                	sd	ra,72(sp)
    16e4:	e0a2                	sd	s0,64(sp)
    16e6:	fc26                	sd	s1,56(sp)
    16e8:	f84a                	sd	s2,48(sp)
    16ea:	f44e                	sd	s3,40(sp)
    16ec:	f052                	sd	s4,32(sp)
    16ee:	ec56                	sd	s5,24(sp)
    16f0:	0880                	addi	s0,sp,80
    16f2:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    16f4:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    16f6:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    16fa:	06400a13          	li	s4,100
    pid = fork();
    16fe:	6d0030ef          	jal	4dce <fork>
    1702:	84aa                	mv	s1,a0
    if(pid < 0){
    1704:	02054863          	bltz	a0,1734 <exitwait+0x54>
    if(pid){
    1708:	c525                	beqz	a0,1770 <exitwait+0x90>
      if(wait(&xstate) != pid){
    170a:	854e                	mv	a0,s3
    170c:	6d2030ef          	jal	4dde <wait>
    1710:	02951c63          	bne	a0,s1,1748 <exitwait+0x68>
      if(i != xstate) {
    1714:	fbc42783          	lw	a5,-68(s0)
    1718:	05279263          	bne	a5,s2,175c <exitwait+0x7c>
  for(i = 0; i < 100; i++){
    171c:	2905                	addiw	s2,s2,1
    171e:	ff4910e3          	bne	s2,s4,16fe <exitwait+0x1e>
}
    1722:	60a6                	ld	ra,72(sp)
    1724:	6406                	ld	s0,64(sp)
    1726:	74e2                	ld	s1,56(sp)
    1728:	7942                	ld	s2,48(sp)
    172a:	79a2                	ld	s3,40(sp)
    172c:	7a02                	ld	s4,32(sp)
    172e:	6ae2                	ld	s5,24(sp)
    1730:	6161                	addi	sp,sp,80
    1732:	8082                	ret
      printf("%s: fork failed\n", s);
    1734:	85d6                	mv	a1,s5
    1736:	00004517          	auipc	a0,0x4
    173a:	52250513          	addi	a0,a0,1314 # 5c58 <malloc+0x9c0>
    173e:	2a3030ef          	jal	51e0 <printf>
      exit(1);
    1742:	4505                	li	a0,1
    1744:	692030ef          	jal	4dd6 <exit>
        printf("%s: wait wrong pid\n", s);
    1748:	85d6                	mv	a1,s5
    174a:	00004517          	auipc	a0,0x4
    174e:	69650513          	addi	a0,a0,1686 # 5de0 <malloc+0xb48>
    1752:	28f030ef          	jal	51e0 <printf>
        exit(1);
    1756:	4505                	li	a0,1
    1758:	67e030ef          	jal	4dd6 <exit>
        printf("%s: wait wrong exit status\n", s);
    175c:	85d6                	mv	a1,s5
    175e:	00004517          	auipc	a0,0x4
    1762:	69a50513          	addi	a0,a0,1690 # 5df8 <malloc+0xb60>
    1766:	27b030ef          	jal	51e0 <printf>
        exit(1);
    176a:	4505                	li	a0,1
    176c:	66a030ef          	jal	4dd6 <exit>
      exit(i);
    1770:	854a                	mv	a0,s2
    1772:	664030ef          	jal	4dd6 <exit>

0000000000001776 <twochildren>:
{
    1776:	1101                	addi	sp,sp,-32
    1778:	ec06                	sd	ra,24(sp)
    177a:	e822                	sd	s0,16(sp)
    177c:	e426                	sd	s1,8(sp)
    177e:	e04a                	sd	s2,0(sp)
    1780:	1000                	addi	s0,sp,32
    1782:	892a                	mv	s2,a0
    1784:	3e800493          	li	s1,1000
    int pid1 = fork();
    1788:	646030ef          	jal	4dce <fork>
    if(pid1 < 0){
    178c:	02054663          	bltz	a0,17b8 <twochildren+0x42>
    if(pid1 == 0){
    1790:	cd15                	beqz	a0,17cc <twochildren+0x56>
      int pid2 = fork();
    1792:	63c030ef          	jal	4dce <fork>
      if(pid2 < 0){
    1796:	02054d63          	bltz	a0,17d0 <twochildren+0x5a>
      if(pid2 == 0){
    179a:	c529                	beqz	a0,17e4 <twochildren+0x6e>
        wait(0);
    179c:	4501                	li	a0,0
    179e:	640030ef          	jal	4dde <wait>
        wait(0);
    17a2:	4501                	li	a0,0
    17a4:	63a030ef          	jal	4dde <wait>
  for(int i = 0; i < 1000; i++){
    17a8:	34fd                	addiw	s1,s1,-1
    17aa:	fcf9                	bnez	s1,1788 <twochildren+0x12>
}
    17ac:	60e2                	ld	ra,24(sp)
    17ae:	6442                	ld	s0,16(sp)
    17b0:	64a2                	ld	s1,8(sp)
    17b2:	6902                	ld	s2,0(sp)
    17b4:	6105                	addi	sp,sp,32
    17b6:	8082                	ret
      printf("%s: fork failed\n", s);
    17b8:	85ca                	mv	a1,s2
    17ba:	00004517          	auipc	a0,0x4
    17be:	49e50513          	addi	a0,a0,1182 # 5c58 <malloc+0x9c0>
    17c2:	21f030ef          	jal	51e0 <printf>
      exit(1);
    17c6:	4505                	li	a0,1
    17c8:	60e030ef          	jal	4dd6 <exit>
      exit(0);
    17cc:	60a030ef          	jal	4dd6 <exit>
        printf("%s: fork failed\n", s);
    17d0:	85ca                	mv	a1,s2
    17d2:	00004517          	auipc	a0,0x4
    17d6:	48650513          	addi	a0,a0,1158 # 5c58 <malloc+0x9c0>
    17da:	207030ef          	jal	51e0 <printf>
        exit(1);
    17de:	4505                	li	a0,1
    17e0:	5f6030ef          	jal	4dd6 <exit>
        exit(0);
    17e4:	5f2030ef          	jal	4dd6 <exit>

00000000000017e8 <forkfork>:
{
    17e8:	7179                	addi	sp,sp,-48
    17ea:	f406                	sd	ra,40(sp)
    17ec:	f022                	sd	s0,32(sp)
    17ee:	ec26                	sd	s1,24(sp)
    17f0:	1800                	addi	s0,sp,48
    17f2:	84aa                	mv	s1,a0
    int pid = fork();
    17f4:	5da030ef          	jal	4dce <fork>
    if(pid < 0){
    17f8:	02054b63          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    17fc:	c139                	beqz	a0,1842 <forkfork+0x5a>
    int pid = fork();
    17fe:	5d0030ef          	jal	4dce <fork>
    if(pid < 0){
    1802:	02054663          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    1806:	cd15                	beqz	a0,1842 <forkfork+0x5a>
    wait(&xstatus);
    1808:	fdc40513          	addi	a0,s0,-36
    180c:	5d2030ef          	jal	4dde <wait>
    if(xstatus != 0) {
    1810:	fdc42783          	lw	a5,-36(s0)
    1814:	ebb9                	bnez	a5,186a <forkfork+0x82>
    wait(&xstatus);
    1816:	fdc40513          	addi	a0,s0,-36
    181a:	5c4030ef          	jal	4dde <wait>
    if(xstatus != 0) {
    181e:	fdc42783          	lw	a5,-36(s0)
    1822:	e7a1                	bnez	a5,186a <forkfork+0x82>
}
    1824:	70a2                	ld	ra,40(sp)
    1826:	7402                	ld	s0,32(sp)
    1828:	64e2                	ld	s1,24(sp)
    182a:	6145                	addi	sp,sp,48
    182c:	8082                	ret
      printf("%s: fork failed", s);
    182e:	85a6                	mv	a1,s1
    1830:	00004517          	auipc	a0,0x4
    1834:	5e850513          	addi	a0,a0,1512 # 5e18 <malloc+0xb80>
    1838:	1a9030ef          	jal	51e0 <printf>
      exit(1);
    183c:	4505                	li	a0,1
    183e:	598030ef          	jal	4dd6 <exit>
{
    1842:	0c800493          	li	s1,200
        int pid1 = fork();
    1846:	588030ef          	jal	4dce <fork>
        if(pid1 < 0){
    184a:	00054b63          	bltz	a0,1860 <forkfork+0x78>
        if(pid1 == 0){
    184e:	cd01                	beqz	a0,1866 <forkfork+0x7e>
        wait(0);
    1850:	4501                	li	a0,0
    1852:	58c030ef          	jal	4dde <wait>
      for(int j = 0; j < 200; j++){
    1856:	34fd                	addiw	s1,s1,-1
    1858:	f4fd                	bnez	s1,1846 <forkfork+0x5e>
      exit(0);
    185a:	4501                	li	a0,0
    185c:	57a030ef          	jal	4dd6 <exit>
          exit(1);
    1860:	4505                	li	a0,1
    1862:	574030ef          	jal	4dd6 <exit>
          exit(0);
    1866:	570030ef          	jal	4dd6 <exit>
      printf("%s: fork in child failed", s);
    186a:	85a6                	mv	a1,s1
    186c:	00004517          	auipc	a0,0x4
    1870:	5bc50513          	addi	a0,a0,1468 # 5e28 <malloc+0xb90>
    1874:	16d030ef          	jal	51e0 <printf>
      exit(1);
    1878:	4505                	li	a0,1
    187a:	55c030ef          	jal	4dd6 <exit>

000000000000187e <reparent2>:
{
    187e:	1101                	addi	sp,sp,-32
    1880:	ec06                	sd	ra,24(sp)
    1882:	e822                	sd	s0,16(sp)
    1884:	e426                	sd	s1,8(sp)
    1886:	1000                	addi	s0,sp,32
    1888:	32000493          	li	s1,800
    int pid1 = fork();
    188c:	542030ef          	jal	4dce <fork>
    if(pid1 < 0){
    1890:	00054b63          	bltz	a0,18a6 <reparent2+0x28>
    if(pid1 == 0){
    1894:	c115                	beqz	a0,18b8 <reparent2+0x3a>
    wait(0);
    1896:	4501                	li	a0,0
    1898:	546030ef          	jal	4dde <wait>
  for(int i = 0; i < 800; i++){
    189c:	34fd                	addiw	s1,s1,-1
    189e:	f4fd                	bnez	s1,188c <reparent2+0xe>
  exit(0);
    18a0:	4501                	li	a0,0
    18a2:	534030ef          	jal	4dd6 <exit>
      printf("fork failed\n");
    18a6:	00006517          	auipc	a0,0x6
    18aa:	92250513          	addi	a0,a0,-1758 # 71c8 <malloc+0x1f30>
    18ae:	133030ef          	jal	51e0 <printf>
      exit(1);
    18b2:	4505                	li	a0,1
    18b4:	522030ef          	jal	4dd6 <exit>
      fork();
    18b8:	516030ef          	jal	4dce <fork>
      fork();
    18bc:	512030ef          	jal	4dce <fork>
      exit(0);
    18c0:	4501                	li	a0,0
    18c2:	514030ef          	jal	4dd6 <exit>

00000000000018c6 <createdelete>:
{
    18c6:	7175                	addi	sp,sp,-144
    18c8:	e506                	sd	ra,136(sp)
    18ca:	e122                	sd	s0,128(sp)
    18cc:	fca6                	sd	s1,120(sp)
    18ce:	f8ca                	sd	s2,112(sp)
    18d0:	f4ce                	sd	s3,104(sp)
    18d2:	f0d2                	sd	s4,96(sp)
    18d4:	ecd6                	sd	s5,88(sp)
    18d6:	e8da                	sd	s6,80(sp)
    18d8:	e4de                	sd	s7,72(sp)
    18da:	e0e2                	sd	s8,64(sp)
    18dc:	fc66                	sd	s9,56(sp)
    18de:	f86a                	sd	s10,48(sp)
    18e0:	0900                	addi	s0,sp,144
    18e2:	8d2a                	mv	s10,a0
  for(pi = 0; pi < NCHILD; pi++){
    18e4:	4901                	li	s2,0
    18e6:	4991                	li	s3,4
    pid = fork();
    18e8:	4e6030ef          	jal	4dce <fork>
    18ec:	84aa                	mv	s1,a0
    if(pid < 0){
    18ee:	02054e63          	bltz	a0,192a <createdelete+0x64>
    if(pid == 0){
    18f2:	c531                	beqz	a0,193e <createdelete+0x78>
  for(pi = 0; pi < NCHILD; pi++){
    18f4:	2905                	addiw	s2,s2,1
    18f6:	ff3919e3          	bne	s2,s3,18e8 <createdelete+0x22>
    18fa:	4491                	li	s1,4
    wait(&xstatus);
    18fc:	f7c40993          	addi	s3,s0,-132
    1900:	854e                	mv	a0,s3
    1902:	4dc030ef          	jal	4dde <wait>
    if(xstatus != 0)
    1906:	f7c42903          	lw	s2,-132(s0)
    190a:	0c091063          	bnez	s2,19ca <createdelete+0x104>
  for(pi = 0; pi < NCHILD; pi++){
    190e:	34fd                	addiw	s1,s1,-1
    1910:	f8e5                	bnez	s1,1900 <createdelete+0x3a>
  name[0] = name[1] = name[2] = 0;
    1912:	f8040123          	sb	zero,-126(s0)
    1916:	03000993          	li	s3,48
    191a:	5afd                	li	s5,-1
    191c:	07000c93          	li	s9,112
      if((i == 0 || i >= N/2) && fd < 0){
    1920:	4ba5                	li	s7,9
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1922:	4c21                	li	s8,8
    for(pi = 0; pi < NCHILD; pi++){
    1924:	07400b13          	li	s6,116
    1928:	a205                	j	1a48 <createdelete+0x182>
      printf("%s: fork failed\n", s);
    192a:	85ea                	mv	a1,s10
    192c:	00004517          	auipc	a0,0x4
    1930:	32c50513          	addi	a0,a0,812 # 5c58 <malloc+0x9c0>
    1934:	0ad030ef          	jal	51e0 <printf>
      exit(1);
    1938:	4505                	li	a0,1
    193a:	49c030ef          	jal	4dd6 <exit>
      name[0] = 'p' + pi;
    193e:	0709091b          	addiw	s2,s2,112
    1942:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1946:	f8040123          	sb	zero,-126(s0)
        fd = open(name, O_CREATE | O_RDWR);
    194a:	f8040913          	addi	s2,s0,-128
    194e:	20200993          	li	s3,514
      for(i = 0; i < N; i++){
    1952:	4a51                	li	s4,20
    1954:	a815                	j	1988 <createdelete+0xc2>
          printf("%s: create failed\n", s);
    1956:	85ea                	mv	a1,s10
    1958:	00004517          	auipc	a0,0x4
    195c:	39850513          	addi	a0,a0,920 # 5cf0 <malloc+0xa58>
    1960:	081030ef          	jal	51e0 <printf>
          exit(1);
    1964:	4505                	li	a0,1
    1966:	470030ef          	jal	4dd6 <exit>
          name[1] = '0' + (i / 2);
    196a:	01f4d79b          	srliw	a5,s1,0x1f
    196e:	9fa5                	addw	a5,a5,s1
    1970:	4017d79b          	sraiw	a5,a5,0x1
    1974:	0307879b          	addiw	a5,a5,48
    1978:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    197c:	854a                	mv	a0,s2
    197e:	4a8030ef          	jal	4e26 <unlink>
    1982:	02054a63          	bltz	a0,19b6 <createdelete+0xf0>
      for(i = 0; i < N; i++){
    1986:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
    1988:	0304879b          	addiw	a5,s1,48
    198c:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1990:	85ce                	mv	a1,s3
    1992:	854a                	mv	a0,s2
    1994:	482030ef          	jal	4e16 <open>
        if(fd < 0){
    1998:	fa054fe3          	bltz	a0,1956 <createdelete+0x90>
        close(fd);
    199c:	462030ef          	jal	4dfe <close>
        if(i > 0 && (i % 2 ) == 0){
    19a0:	fe9053e3          	blez	s1,1986 <createdelete+0xc0>
    19a4:	0014f793          	andi	a5,s1,1
    19a8:	d3e9                	beqz	a5,196a <createdelete+0xa4>
      for(i = 0; i < N; i++){
    19aa:	2485                	addiw	s1,s1,1
    19ac:	fd449ee3          	bne	s1,s4,1988 <createdelete+0xc2>
      exit(0);
    19b0:	4501                	li	a0,0
    19b2:	424030ef          	jal	4dd6 <exit>
            printf("%s: unlink failed\n", s);
    19b6:	85ea                	mv	a1,s10
    19b8:	00004517          	auipc	a0,0x4
    19bc:	49050513          	addi	a0,a0,1168 # 5e48 <malloc+0xbb0>
    19c0:	021030ef          	jal	51e0 <printf>
            exit(1);
    19c4:	4505                	li	a0,1
    19c6:	410030ef          	jal	4dd6 <exit>
      exit(1);
    19ca:	4505                	li	a0,1
    19cc:	40a030ef          	jal	4dd6 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    19d0:	f8040613          	addi	a2,s0,-128
    19d4:	85ea                	mv	a1,s10
    19d6:	00004517          	auipc	a0,0x4
    19da:	48a50513          	addi	a0,a0,1162 # 5e60 <malloc+0xbc8>
    19de:	003030ef          	jal	51e0 <printf>
        exit(1);
    19e2:	4505                	li	a0,1
    19e4:	3f2030ef          	jal	4dd6 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    19e8:	035c7a63          	bgeu	s8,s5,1a1c <createdelete+0x156>
      if(fd >= 0)
    19ec:	02055563          	bgez	a0,1a16 <createdelete+0x150>
    for(pi = 0; pi < NCHILD; pi++){
    19f0:	2485                	addiw	s1,s1,1
    19f2:	0ff4f493          	zext.b	s1,s1
    19f6:	05648163          	beq	s1,s6,1a38 <createdelete+0x172>
      name[0] = 'p' + pi;
    19fa:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    19fe:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1a02:	4581                	li	a1,0
    1a04:	8552                	mv	a0,s4
    1a06:	410030ef          	jal	4e16 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1a0a:	00090463          	beqz	s2,1a12 <createdelete+0x14c>
    1a0e:	fd2bdde3          	bge	s7,s2,19e8 <createdelete+0x122>
    1a12:	fa054fe3          	bltz	a0,19d0 <createdelete+0x10a>
        close(fd);
    1a16:	3e8030ef          	jal	4dfe <close>
    1a1a:	bfd9                	j	19f0 <createdelete+0x12a>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1a1c:	fc054ae3          	bltz	a0,19f0 <createdelete+0x12a>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1a20:	f8040613          	addi	a2,s0,-128
    1a24:	85ea                	mv	a1,s10
    1a26:	00004517          	auipc	a0,0x4
    1a2a:	46250513          	addi	a0,a0,1122 # 5e88 <malloc+0xbf0>
    1a2e:	7b2030ef          	jal	51e0 <printf>
        exit(1);
    1a32:	4505                	li	a0,1
    1a34:	3a2030ef          	jal	4dd6 <exit>
  for(i = 0; i < N; i++){
    1a38:	2905                	addiw	s2,s2,1
    1a3a:	2a85                	addiw	s5,s5,1
    1a3c:	2985                	addiw	s3,s3,1
    1a3e:	0ff9f993          	zext.b	s3,s3
    1a42:	47d1                	li	a5,20
    1a44:	00f90663          	beq	s2,a5,1a50 <createdelete+0x18a>
    for(pi = 0; pi < NCHILD; pi++){
    1a48:	84e6                	mv	s1,s9
      fd = open(name, 0);
    1a4a:	f8040a13          	addi	s4,s0,-128
    1a4e:	b775                	j	19fa <createdelete+0x134>
    1a50:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    1a54:	07000b13          	li	s6,112
      unlink(name);
    1a58:	f8040a13          	addi	s4,s0,-128
    for(pi = 0; pi < NCHILD; pi++){
    1a5c:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    1a60:	04400a93          	li	s5,68
  name[0] = name[1] = name[2] = 0;
    1a64:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    1a66:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1a6a:	f92400a3          	sb	s2,-127(s0)
      unlink(name);
    1a6e:	8552                	mv	a0,s4
    1a70:	3b6030ef          	jal	4e26 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1a74:	2485                	addiw	s1,s1,1
    1a76:	0ff4f493          	zext.b	s1,s1
    1a7a:	ff3496e3          	bne	s1,s3,1a66 <createdelete+0x1a0>
  for(i = 0; i < N; i++){
    1a7e:	2905                	addiw	s2,s2,1
    1a80:	0ff97913          	zext.b	s2,s2
    1a84:	ff5910e3          	bne	s2,s5,1a64 <createdelete+0x19e>
}
    1a88:	60aa                	ld	ra,136(sp)
    1a8a:	640a                	ld	s0,128(sp)
    1a8c:	74e6                	ld	s1,120(sp)
    1a8e:	7946                	ld	s2,112(sp)
    1a90:	79a6                	ld	s3,104(sp)
    1a92:	7a06                	ld	s4,96(sp)
    1a94:	6ae6                	ld	s5,88(sp)
    1a96:	6b46                	ld	s6,80(sp)
    1a98:	6ba6                	ld	s7,72(sp)
    1a9a:	6c06                	ld	s8,64(sp)
    1a9c:	7ce2                	ld	s9,56(sp)
    1a9e:	7d42                	ld	s10,48(sp)
    1aa0:	6149                	addi	sp,sp,144
    1aa2:	8082                	ret

0000000000001aa4 <linkunlink>:
{
    1aa4:	711d                	addi	sp,sp,-96
    1aa6:	ec86                	sd	ra,88(sp)
    1aa8:	e8a2                	sd	s0,80(sp)
    1aaa:	e4a6                	sd	s1,72(sp)
    1aac:	e0ca                	sd	s2,64(sp)
    1aae:	fc4e                	sd	s3,56(sp)
    1ab0:	f852                	sd	s4,48(sp)
    1ab2:	f456                	sd	s5,40(sp)
    1ab4:	f05a                	sd	s6,32(sp)
    1ab6:	ec5e                	sd	s7,24(sp)
    1ab8:	e862                	sd	s8,16(sp)
    1aba:	e466                	sd	s9,8(sp)
    1abc:	e06a                	sd	s10,0(sp)
    1abe:	1080                	addi	s0,sp,96
    1ac0:	84aa                	mv	s1,a0
  unlink("x");
    1ac2:	00004517          	auipc	a0,0x4
    1ac6:	97650513          	addi	a0,a0,-1674 # 5438 <malloc+0x1a0>
    1aca:	35c030ef          	jal	4e26 <unlink>
  pid = fork();
    1ace:	300030ef          	jal	4dce <fork>
  if(pid < 0){
    1ad2:	04054363          	bltz	a0,1b18 <linkunlink+0x74>
    1ad6:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    1ad8:	06100913          	li	s2,97
    1adc:	c111                	beqz	a0,1ae0 <linkunlink+0x3c>
    1ade:	4905                	li	s2,1
    1ae0:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1ae4:	41c65ab7          	lui	s5,0x41c65
    1ae8:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <base+0x41c551f5>
    1aec:	6a0d                	lui	s4,0x3
    1aee:	039a0a1b          	addiw	s4,s4,57 # 3039 <subdir+0x33d>
    if((x % 3) == 0){
    1af2:	000ab9b7          	lui	s3,0xab
    1af6:	aab98993          	addi	s3,s3,-1365 # aaaab <base+0x9ae33>
    1afa:	09b2                	slli	s3,s3,0xc
    1afc:	aab98993          	addi	s3,s3,-1365
    } else if((x % 3) == 1){
    1b00:	4b85                	li	s7,1
      unlink("x");
    1b02:	00004b17          	auipc	s6,0x4
    1b06:	936b0b13          	addi	s6,s6,-1738 # 5438 <malloc+0x1a0>
      link("cat", "x");
    1b0a:	00004c97          	auipc	s9,0x4
    1b0e:	3a6c8c93          	addi	s9,s9,934 # 5eb0 <malloc+0xc18>
      close(open("x", O_RDWR | O_CREATE));
    1b12:	20200c13          	li	s8,514
    1b16:	a03d                	j	1b44 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1b18:	85a6                	mv	a1,s1
    1b1a:	00004517          	auipc	a0,0x4
    1b1e:	13e50513          	addi	a0,a0,318 # 5c58 <malloc+0x9c0>
    1b22:	6be030ef          	jal	51e0 <printf>
    exit(1);
    1b26:	4505                	li	a0,1
    1b28:	2ae030ef          	jal	4dd6 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1b2c:	85e2                	mv	a1,s8
    1b2e:	855a                	mv	a0,s6
    1b30:	2e6030ef          	jal	4e16 <open>
    1b34:	2ca030ef          	jal	4dfe <close>
    1b38:	a021                	j	1b40 <linkunlink+0x9c>
      unlink("x");
    1b3a:	855a                	mv	a0,s6
    1b3c:	2ea030ef          	jal	4e26 <unlink>
  for(i = 0; i < 100; i++){
    1b40:	34fd                	addiw	s1,s1,-1
    1b42:	c885                	beqz	s1,1b72 <linkunlink+0xce>
    x = x * 1103515245 + 12345;
    1b44:	035907bb          	mulw	a5,s2,s5
    1b48:	00fa07bb          	addw	a5,s4,a5
    1b4c:	893e                	mv	s2,a5
    if((x % 3) == 0){
    1b4e:	02079713          	slli	a4,a5,0x20
    1b52:	9301                	srli	a4,a4,0x20
    1b54:	03370733          	mul	a4,a4,s3
    1b58:	9305                	srli	a4,a4,0x21
    1b5a:	0017169b          	slliw	a3,a4,0x1
    1b5e:	9f35                	addw	a4,a4,a3
    1b60:	9f99                	subw	a5,a5,a4
    1b62:	d7e9                	beqz	a5,1b2c <linkunlink+0x88>
    } else if((x % 3) == 1){
    1b64:	fd779be3          	bne	a5,s7,1b3a <linkunlink+0x96>
      link("cat", "x");
    1b68:	85da                	mv	a1,s6
    1b6a:	8566                	mv	a0,s9
    1b6c:	2ca030ef          	jal	4e36 <link>
    1b70:	bfc1                	j	1b40 <linkunlink+0x9c>
  if(pid)
    1b72:	020d0363          	beqz	s10,1b98 <linkunlink+0xf4>
    wait(0);
    1b76:	4501                	li	a0,0
    1b78:	266030ef          	jal	4dde <wait>
}
    1b7c:	60e6                	ld	ra,88(sp)
    1b7e:	6446                	ld	s0,80(sp)
    1b80:	64a6                	ld	s1,72(sp)
    1b82:	6906                	ld	s2,64(sp)
    1b84:	79e2                	ld	s3,56(sp)
    1b86:	7a42                	ld	s4,48(sp)
    1b88:	7aa2                	ld	s5,40(sp)
    1b8a:	7b02                	ld	s6,32(sp)
    1b8c:	6be2                	ld	s7,24(sp)
    1b8e:	6c42                	ld	s8,16(sp)
    1b90:	6ca2                	ld	s9,8(sp)
    1b92:	6d02                	ld	s10,0(sp)
    1b94:	6125                	addi	sp,sp,96
    1b96:	8082                	ret
    exit(0);
    1b98:	4501                	li	a0,0
    1b9a:	23c030ef          	jal	4dd6 <exit>

0000000000001b9e <forktest>:
{
    1b9e:	7179                	addi	sp,sp,-48
    1ba0:	f406                	sd	ra,40(sp)
    1ba2:	f022                	sd	s0,32(sp)
    1ba4:	ec26                	sd	s1,24(sp)
    1ba6:	e84a                	sd	s2,16(sp)
    1ba8:	e44e                	sd	s3,8(sp)
    1baa:	1800                	addi	s0,sp,48
    1bac:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1bae:	4481                	li	s1,0
    1bb0:	3e800913          	li	s2,1000
    pid = fork();
    1bb4:	21a030ef          	jal	4dce <fork>
    if(pid < 0)
    1bb8:	06054063          	bltz	a0,1c18 <forktest+0x7a>
    if(pid == 0)
    1bbc:	cd11                	beqz	a0,1bd8 <forktest+0x3a>
  for(n=0; n<N; n++){
    1bbe:	2485                	addiw	s1,s1,1
    1bc0:	ff249ae3          	bne	s1,s2,1bb4 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1bc4:	85ce                	mv	a1,s3
    1bc6:	00004517          	auipc	a0,0x4
    1bca:	33a50513          	addi	a0,a0,826 # 5f00 <malloc+0xc68>
    1bce:	612030ef          	jal	51e0 <printf>
    exit(1);
    1bd2:	4505                	li	a0,1
    1bd4:	202030ef          	jal	4dd6 <exit>
      exit(0);
    1bd8:	1fe030ef          	jal	4dd6 <exit>
    printf("%s: no fork at all!\n", s);
    1bdc:	85ce                	mv	a1,s3
    1bde:	00004517          	auipc	a0,0x4
    1be2:	2da50513          	addi	a0,a0,730 # 5eb8 <malloc+0xc20>
    1be6:	5fa030ef          	jal	51e0 <printf>
    exit(1);
    1bea:	4505                	li	a0,1
    1bec:	1ea030ef          	jal	4dd6 <exit>
      printf("%s: wait stopped early\n", s);
    1bf0:	85ce                	mv	a1,s3
    1bf2:	00004517          	auipc	a0,0x4
    1bf6:	2de50513          	addi	a0,a0,734 # 5ed0 <malloc+0xc38>
    1bfa:	5e6030ef          	jal	51e0 <printf>
      exit(1);
    1bfe:	4505                	li	a0,1
    1c00:	1d6030ef          	jal	4dd6 <exit>
    printf("%s: wait got too many\n", s);
    1c04:	85ce                	mv	a1,s3
    1c06:	00004517          	auipc	a0,0x4
    1c0a:	2e250513          	addi	a0,a0,738 # 5ee8 <malloc+0xc50>
    1c0e:	5d2030ef          	jal	51e0 <printf>
    exit(1);
    1c12:	4505                	li	a0,1
    1c14:	1c2030ef          	jal	4dd6 <exit>
  if (n == 0) {
    1c18:	d0f1                	beqz	s1,1bdc <forktest+0x3e>
    if(wait(0) < 0){
    1c1a:	4501                	li	a0,0
    1c1c:	1c2030ef          	jal	4dde <wait>
    1c20:	fc0548e3          	bltz	a0,1bf0 <forktest+0x52>
  for(; n > 0; n--){
    1c24:	34fd                	addiw	s1,s1,-1
    1c26:	fe904ae3          	bgtz	s1,1c1a <forktest+0x7c>
  if(wait(0) != -1){
    1c2a:	4501                	li	a0,0
    1c2c:	1b2030ef          	jal	4dde <wait>
    1c30:	57fd                	li	a5,-1
    1c32:	fcf519e3          	bne	a0,a5,1c04 <forktest+0x66>
}
    1c36:	70a2                	ld	ra,40(sp)
    1c38:	7402                	ld	s0,32(sp)
    1c3a:	64e2                	ld	s1,24(sp)
    1c3c:	6942                	ld	s2,16(sp)
    1c3e:	69a2                	ld	s3,8(sp)
    1c40:	6145                	addi	sp,sp,48
    1c42:	8082                	ret

0000000000001c44 <kernmem>:
{
    1c44:	715d                	addi	sp,sp,-80
    1c46:	e486                	sd	ra,72(sp)
    1c48:	e0a2                	sd	s0,64(sp)
    1c4a:	fc26                	sd	s1,56(sp)
    1c4c:	f84a                	sd	s2,48(sp)
    1c4e:	f44e                	sd	s3,40(sp)
    1c50:	f052                	sd	s4,32(sp)
    1c52:	ec56                	sd	s5,24(sp)
    1c54:	e85a                	sd	s6,16(sp)
    1c56:	0880                	addi	s0,sp,80
    1c58:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c5a:	4485                	li	s1,1
    1c5c:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
    1c5e:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    1c62:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c64:	69b1                	lui	s3,0xc
    1c66:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    1c6a:	1003d937          	lui	s2,0x1003d
    1c6e:	090e                	slli	s2,s2,0x3
    1c70:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    1c74:	15a030ef          	jal	4dce <fork>
    if(pid < 0){
    1c78:	02054763          	bltz	a0,1ca6 <kernmem+0x62>
    if(pid == 0){
    1c7c:	cd1d                	beqz	a0,1cba <kernmem+0x76>
    wait(&xstatus);
    1c7e:	8556                	mv	a0,s5
    1c80:	15e030ef          	jal	4dde <wait>
    if(xstatus != -1)  // did kernel kill child?
    1c84:	fbc42783          	lw	a5,-68(s0)
    1c88:	05479663          	bne	a5,s4,1cd4 <kernmem+0x90>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c8c:	94ce                	add	s1,s1,s3
    1c8e:	ff2493e3          	bne	s1,s2,1c74 <kernmem+0x30>
}
    1c92:	60a6                	ld	ra,72(sp)
    1c94:	6406                	ld	s0,64(sp)
    1c96:	74e2                	ld	s1,56(sp)
    1c98:	7942                	ld	s2,48(sp)
    1c9a:	79a2                	ld	s3,40(sp)
    1c9c:	7a02                	ld	s4,32(sp)
    1c9e:	6ae2                	ld	s5,24(sp)
    1ca0:	6b42                	ld	s6,16(sp)
    1ca2:	6161                	addi	sp,sp,80
    1ca4:	8082                	ret
      printf("%s: fork failed\n", s);
    1ca6:	85da                	mv	a1,s6
    1ca8:	00004517          	auipc	a0,0x4
    1cac:	fb050513          	addi	a0,a0,-80 # 5c58 <malloc+0x9c0>
    1cb0:	530030ef          	jal	51e0 <printf>
      exit(1);
    1cb4:	4505                	li	a0,1
    1cb6:	120030ef          	jal	4dd6 <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1cba:	0004c683          	lbu	a3,0(s1)
    1cbe:	8626                	mv	a2,s1
    1cc0:	85da                	mv	a1,s6
    1cc2:	00004517          	auipc	a0,0x4
    1cc6:	26650513          	addi	a0,a0,614 # 5f28 <malloc+0xc90>
    1cca:	516030ef          	jal	51e0 <printf>
      exit(1);
    1cce:	4505                	li	a0,1
    1cd0:	106030ef          	jal	4dd6 <exit>
      exit(1);
    1cd4:	4505                	li	a0,1
    1cd6:	100030ef          	jal	4dd6 <exit>

0000000000001cda <MAXVAplus>:
{
    1cda:	7139                	addi	sp,sp,-64
    1cdc:	fc06                	sd	ra,56(sp)
    1cde:	f822                	sd	s0,48(sp)
    1ce0:	0080                	addi	s0,sp,64
  volatile uint64 a = MAXVA;
    1ce2:	4785                	li	a5,1
    1ce4:	179a                	slli	a5,a5,0x26
    1ce6:	fcf43423          	sd	a5,-56(s0)
  for( ; a != 0; a <<= 1){
    1cea:	fc843783          	ld	a5,-56(s0)
    1cee:	cf9d                	beqz	a5,1d2c <MAXVAplus+0x52>
    1cf0:	f426                	sd	s1,40(sp)
    1cf2:	f04a                	sd	s2,32(sp)
    1cf4:	ec4e                	sd	s3,24(sp)
    1cf6:	89aa                	mv	s3,a0
    wait(&xstatus);
    1cf8:	fc440913          	addi	s2,s0,-60
    if(xstatus != -1)  // did kernel kill child?
    1cfc:	54fd                	li	s1,-1
    pid = fork();
    1cfe:	0d0030ef          	jal	4dce <fork>
    if(pid < 0){
    1d02:	02054963          	bltz	a0,1d34 <MAXVAplus+0x5a>
    if(pid == 0){
    1d06:	c129                	beqz	a0,1d48 <MAXVAplus+0x6e>
    wait(&xstatus);
    1d08:	854a                	mv	a0,s2
    1d0a:	0d4030ef          	jal	4dde <wait>
    if(xstatus != -1)  // did kernel kill child?
    1d0e:	fc442783          	lw	a5,-60(s0)
    1d12:	04979d63          	bne	a5,s1,1d6c <MAXVAplus+0x92>
  for( ; a != 0; a <<= 1){
    1d16:	fc843783          	ld	a5,-56(s0)
    1d1a:	0786                	slli	a5,a5,0x1
    1d1c:	fcf43423          	sd	a5,-56(s0)
    1d20:	fc843783          	ld	a5,-56(s0)
    1d24:	ffe9                	bnez	a5,1cfe <MAXVAplus+0x24>
    1d26:	74a2                	ld	s1,40(sp)
    1d28:	7902                	ld	s2,32(sp)
    1d2a:	69e2                	ld	s3,24(sp)
}
    1d2c:	70e2                	ld	ra,56(sp)
    1d2e:	7442                	ld	s0,48(sp)
    1d30:	6121                	addi	sp,sp,64
    1d32:	8082                	ret
      printf("%s: fork failed\n", s);
    1d34:	85ce                	mv	a1,s3
    1d36:	00004517          	auipc	a0,0x4
    1d3a:	f2250513          	addi	a0,a0,-222 # 5c58 <malloc+0x9c0>
    1d3e:	4a2030ef          	jal	51e0 <printf>
      exit(1);
    1d42:	4505                	li	a0,1
    1d44:	092030ef          	jal	4dd6 <exit>
      *(char*)a = 99;
    1d48:	fc843783          	ld	a5,-56(s0)
    1d4c:	06300713          	li	a4,99
    1d50:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void*)a);
    1d54:	fc843603          	ld	a2,-56(s0)
    1d58:	85ce                	mv	a1,s3
    1d5a:	00004517          	auipc	a0,0x4
    1d5e:	1ee50513          	addi	a0,a0,494 # 5f48 <malloc+0xcb0>
    1d62:	47e030ef          	jal	51e0 <printf>
      exit(1);
    1d66:	4505                	li	a0,1
    1d68:	06e030ef          	jal	4dd6 <exit>
      exit(1);
    1d6c:	4505                	li	a0,1
    1d6e:	068030ef          	jal	4dd6 <exit>

0000000000001d72 <stacktest>:
{
    1d72:	7179                	addi	sp,sp,-48
    1d74:	f406                	sd	ra,40(sp)
    1d76:	f022                	sd	s0,32(sp)
    1d78:	ec26                	sd	s1,24(sp)
    1d7a:	1800                	addi	s0,sp,48
    1d7c:	84aa                	mv	s1,a0
  pid = fork();
    1d7e:	050030ef          	jal	4dce <fork>
  if(pid == 0) {
    1d82:	cd11                	beqz	a0,1d9e <stacktest+0x2c>
  } else if(pid < 0){
    1d84:	02054c63          	bltz	a0,1dbc <stacktest+0x4a>
  wait(&xstatus);
    1d88:	fdc40513          	addi	a0,s0,-36
    1d8c:	052030ef          	jal	4dde <wait>
  if(xstatus == -1)  // kernel killed child?
    1d90:	fdc42503          	lw	a0,-36(s0)
    1d94:	57fd                	li	a5,-1
    1d96:	02f50d63          	beq	a0,a5,1dd0 <stacktest+0x5e>
    exit(xstatus);
    1d9a:	03c030ef          	jal	4dd6 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1d9e:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1da0:	77fd                	lui	a5,0xfffff
    1da2:	97ba                	add	a5,a5,a4
    1da4:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    1da8:	85a6                	mv	a1,s1
    1daa:	00004517          	auipc	a0,0x4
    1dae:	1b650513          	addi	a0,a0,438 # 5f60 <malloc+0xcc8>
    1db2:	42e030ef          	jal	51e0 <printf>
    exit(1);
    1db6:	4505                	li	a0,1
    1db8:	01e030ef          	jal	4dd6 <exit>
    printf("%s: fork failed\n", s);
    1dbc:	85a6                	mv	a1,s1
    1dbe:	00004517          	auipc	a0,0x4
    1dc2:	e9a50513          	addi	a0,a0,-358 # 5c58 <malloc+0x9c0>
    1dc6:	41a030ef          	jal	51e0 <printf>
    exit(1);
    1dca:	4505                	li	a0,1
    1dcc:	00a030ef          	jal	4dd6 <exit>
    exit(0);
    1dd0:	4501                	li	a0,0
    1dd2:	004030ef          	jal	4dd6 <exit>

0000000000001dd6 <nowrite>:
{
    1dd6:	7159                	addi	sp,sp,-112
    1dd8:	f486                	sd	ra,104(sp)
    1dda:	f0a2                	sd	s0,96(sp)
    1ddc:	eca6                	sd	s1,88(sp)
    1dde:	e8ca                	sd	s2,80(sp)
    1de0:	e4ce                	sd	s3,72(sp)
    1de2:	e0d2                	sd	s4,64(sp)
    1de4:	1880                	addi	s0,sp,112
    1de6:	8a2a                	mv	s4,a0
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    1de8:	00006797          	auipc	a5,0x6
    1dec:	94078793          	addi	a5,a5,-1728 # 7728 <malloc+0x2490>
    1df0:	7788                	ld	a0,40(a5)
    1df2:	7b8c                	ld	a1,48(a5)
    1df4:	7f90                	ld	a2,56(a5)
    1df6:	63b4                	ld	a3,64(a5)
    1df8:	67b8                	ld	a4,72(a5)
    1dfa:	6bbc                	ld	a5,80(a5)
    1dfc:	f8a43c23          	sd	a0,-104(s0)
    1e00:	fab43023          	sd	a1,-96(s0)
    1e04:	fac43423          	sd	a2,-88(s0)
    1e08:	fad43823          	sd	a3,-80(s0)
    1e0c:	fae43c23          	sd	a4,-72(s0)
    1e10:	fcf43023          	sd	a5,-64(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e14:	4481                	li	s1,0
    wait(&xstatus);
    1e16:	fcc40913          	addi	s2,s0,-52
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e1a:	4999                	li	s3,6
    pid = fork();
    1e1c:	7b3020ef          	jal	4dce <fork>
    if(pid == 0) {
    1e20:	cd19                	beqz	a0,1e3e <nowrite+0x68>
    } else if(pid < 0){
    1e22:	04054163          	bltz	a0,1e64 <nowrite+0x8e>
    wait(&xstatus);
    1e26:	854a                	mv	a0,s2
    1e28:	7b7020ef          	jal	4dde <wait>
    if(xstatus == 0){
    1e2c:	fcc42783          	lw	a5,-52(s0)
    1e30:	c7a1                	beqz	a5,1e78 <nowrite+0xa2>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e32:	2485                	addiw	s1,s1,1
    1e34:	ff3494e3          	bne	s1,s3,1e1c <nowrite+0x46>
  exit(0);
    1e38:	4501                	li	a0,0
    1e3a:	79d020ef          	jal	4dd6 <exit>
      volatile int *addr = (int *) addrs[ai];
    1e3e:	048e                	slli	s1,s1,0x3
    1e40:	fd048793          	addi	a5,s1,-48
    1e44:	008784b3          	add	s1,a5,s0
    1e48:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1e4c:	47a9                	li	a5,10
    1e4e:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1e50:	85d2                	mv	a1,s4
    1e52:	00004517          	auipc	a0,0x4
    1e56:	13650513          	addi	a0,a0,310 # 5f88 <malloc+0xcf0>
    1e5a:	386030ef          	jal	51e0 <printf>
      exit(0);
    1e5e:	4501                	li	a0,0
    1e60:	777020ef          	jal	4dd6 <exit>
      printf("%s: fork failed\n", s);
    1e64:	85d2                	mv	a1,s4
    1e66:	00004517          	auipc	a0,0x4
    1e6a:	df250513          	addi	a0,a0,-526 # 5c58 <malloc+0x9c0>
    1e6e:	372030ef          	jal	51e0 <printf>
      exit(1);
    1e72:	4505                	li	a0,1
    1e74:	763020ef          	jal	4dd6 <exit>
      exit(1);
    1e78:	4505                	li	a0,1
    1e7a:	75d020ef          	jal	4dd6 <exit>

0000000000001e7e <manywrites>:
{
    1e7e:	7159                	addi	sp,sp,-112
    1e80:	f486                	sd	ra,104(sp)
    1e82:	f0a2                	sd	s0,96(sp)
    1e84:	eca6                	sd	s1,88(sp)
    1e86:	e8ca                	sd	s2,80(sp)
    1e88:	e4ce                	sd	s3,72(sp)
    1e8a:	fc56                	sd	s5,56(sp)
    1e8c:	1880                	addi	s0,sp,112
    1e8e:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1e90:	4901                	li	s2,0
    1e92:	4991                	li	s3,4
    int pid = fork();
    1e94:	73b020ef          	jal	4dce <fork>
    1e98:	84aa                	mv	s1,a0
    if(pid < 0){
    1e9a:	02054d63          	bltz	a0,1ed4 <manywrites+0x56>
    if(pid == 0){
    1e9e:	c931                	beqz	a0,1ef2 <manywrites+0x74>
  for(int ci = 0; ci < nchildren; ci++){
    1ea0:	2905                	addiw	s2,s2,1
    1ea2:	ff3919e3          	bne	s2,s3,1e94 <manywrites+0x16>
    1ea6:	4491                	li	s1,4
    wait(&st);
    1ea8:	f9840913          	addi	s2,s0,-104
    int st = 0;
    1eac:	f8042c23          	sw	zero,-104(s0)
    wait(&st);
    1eb0:	854a                	mv	a0,s2
    1eb2:	72d020ef          	jal	4dde <wait>
    if(st != 0)
    1eb6:	f9842503          	lw	a0,-104(s0)
    1eba:	0e051463          	bnez	a0,1fa2 <manywrites+0x124>
  for(int ci = 0; ci < nchildren; ci++){
    1ebe:	34fd                	addiw	s1,s1,-1
    1ec0:	f4f5                	bnez	s1,1eac <manywrites+0x2e>
    1ec2:	e0d2                	sd	s4,64(sp)
    1ec4:	f85a                	sd	s6,48(sp)
    1ec6:	f45e                	sd	s7,40(sp)
    1ec8:	f062                	sd	s8,32(sp)
    1eca:	ec66                	sd	s9,24(sp)
    1ecc:	e86a                	sd	s10,16(sp)
  exit(0);
    1ece:	4501                	li	a0,0
    1ed0:	707020ef          	jal	4dd6 <exit>
    1ed4:	e0d2                	sd	s4,64(sp)
    1ed6:	f85a                	sd	s6,48(sp)
    1ed8:	f45e                	sd	s7,40(sp)
    1eda:	f062                	sd	s8,32(sp)
    1edc:	ec66                	sd	s9,24(sp)
    1ede:	e86a                	sd	s10,16(sp)
      printf("fork failed\n");
    1ee0:	00005517          	auipc	a0,0x5
    1ee4:	2e850513          	addi	a0,a0,744 # 71c8 <malloc+0x1f30>
    1ee8:	2f8030ef          	jal	51e0 <printf>
      exit(1);
    1eec:	4505                	li	a0,1
    1eee:	6e9020ef          	jal	4dd6 <exit>
    1ef2:	e0d2                	sd	s4,64(sp)
    1ef4:	f85a                	sd	s6,48(sp)
    1ef6:	f45e                	sd	s7,40(sp)
    1ef8:	f062                	sd	s8,32(sp)
    1efa:	ec66                	sd	s9,24(sp)
    1efc:	e86a                	sd	s10,16(sp)
      name[0] = 'b';
    1efe:	06200793          	li	a5,98
    1f02:	f8f40c23          	sb	a5,-104(s0)
      name[1] = 'a' + ci;
    1f06:	0619079b          	addiw	a5,s2,97
    1f0a:	f8f40ca3          	sb	a5,-103(s0)
      name[2] = '\0';
    1f0e:	f8040d23          	sb	zero,-102(s0)
      unlink(name);
    1f12:	f9840513          	addi	a0,s0,-104
    1f16:	711020ef          	jal	4e26 <unlink>
    1f1a:	4d79                	li	s10,30
          int fd = open(name, O_CREATE | O_RDWR);
    1f1c:	f9840c13          	addi	s8,s0,-104
    1f20:	20200b93          	li	s7,514
          int cc = write(fd, buf, sz);
    1f24:	6b0d                	lui	s6,0x3
    1f26:	0000bc97          	auipc	s9,0xb
    1f2a:	d52c8c93          	addi	s9,s9,-686 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    1f2e:	8a26                	mv	s4,s1
          int fd = open(name, O_CREATE | O_RDWR);
    1f30:	85de                	mv	a1,s7
    1f32:	8562                	mv	a0,s8
    1f34:	6e3020ef          	jal	4e16 <open>
    1f38:	89aa                	mv	s3,a0
          if(fd < 0){
    1f3a:	02054c63          	bltz	a0,1f72 <manywrites+0xf4>
          int cc = write(fd, buf, sz);
    1f3e:	865a                	mv	a2,s6
    1f40:	85e6                	mv	a1,s9
    1f42:	6b5020ef          	jal	4df6 <write>
          if(cc != sz){
    1f46:	05651263          	bne	a0,s6,1f8a <manywrites+0x10c>
          close(fd);
    1f4a:	854e                	mv	a0,s3
    1f4c:	6b3020ef          	jal	4dfe <close>
        for(int i = 0; i < ci+1; i++){
    1f50:	2a05                	addiw	s4,s4,1
    1f52:	fd495fe3          	bge	s2,s4,1f30 <manywrites+0xb2>
        unlink(name);
    1f56:	f9840513          	addi	a0,s0,-104
    1f5a:	6cd020ef          	jal	4e26 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f5e:	3d7d                	addiw	s10,s10,-1
    1f60:	fc0d17e3          	bnez	s10,1f2e <manywrites+0xb0>
      unlink(name);
    1f64:	f9840513          	addi	a0,s0,-104
    1f68:	6bf020ef          	jal	4e26 <unlink>
      exit(0);
    1f6c:	4501                	li	a0,0
    1f6e:	669020ef          	jal	4dd6 <exit>
            printf("%s: cannot create %s\n", s, name);
    1f72:	f9840613          	addi	a2,s0,-104
    1f76:	85d6                	mv	a1,s5
    1f78:	00004517          	auipc	a0,0x4
    1f7c:	03050513          	addi	a0,a0,48 # 5fa8 <malloc+0xd10>
    1f80:	260030ef          	jal	51e0 <printf>
            exit(1);
    1f84:	4505                	li	a0,1
    1f86:	651020ef          	jal	4dd6 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1f8a:	86aa                	mv	a3,a0
    1f8c:	660d                	lui	a2,0x3
    1f8e:	85d6                	mv	a1,s5
    1f90:	00003517          	auipc	a0,0x3
    1f94:	50850513          	addi	a0,a0,1288 # 5498 <malloc+0x200>
    1f98:	248030ef          	jal	51e0 <printf>
            exit(1);
    1f9c:	4505                	li	a0,1
    1f9e:	639020ef          	jal	4dd6 <exit>
    1fa2:	e0d2                	sd	s4,64(sp)
    1fa4:	f85a                	sd	s6,48(sp)
    1fa6:	f45e                	sd	s7,40(sp)
    1fa8:	f062                	sd	s8,32(sp)
    1faa:	ec66                	sd	s9,24(sp)
    1fac:	e86a                	sd	s10,16(sp)
      exit(st);
    1fae:	629020ef          	jal	4dd6 <exit>

0000000000001fb2 <copyinstr3>:
{
    1fb2:	7179                	addi	sp,sp,-48
    1fb4:	f406                	sd	ra,40(sp)
    1fb6:	f022                	sd	s0,32(sp)
    1fb8:	ec26                	sd	s1,24(sp)
    1fba:	1800                	addi	s0,sp,48
  sbrk(8192);
    1fbc:	6509                	lui	a0,0x2
    1fbe:	6a1020ef          	jal	4e5e <sbrk>
  uint64 top = (uint64) sbrk(0);
    1fc2:	4501                	li	a0,0
    1fc4:	69b020ef          	jal	4e5e <sbrk>
  if((top % PGSIZE) != 0){
    1fc8:	03451793          	slli	a5,a0,0x34
    1fcc:	e7bd                	bnez	a5,203a <copyinstr3+0x88>
  top = (uint64) sbrk(0);
    1fce:	4501                	li	a0,0
    1fd0:	68f020ef          	jal	4e5e <sbrk>
  if(top % PGSIZE){
    1fd4:	03451793          	slli	a5,a0,0x34
    1fd8:	ebb5                	bnez	a5,204c <copyinstr3+0x9a>
  char *b = (char *) (top - 1);
    1fda:	fff50493          	addi	s1,a0,-1 # 1fff <copyinstr3+0x4d>
  *b = 'x';
    1fde:	07800793          	li	a5,120
    1fe2:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1fe6:	8526                	mv	a0,s1
    1fe8:	63f020ef          	jal	4e26 <unlink>
  if(ret != -1){
    1fec:	57fd                	li	a5,-1
    1fee:	06f51863          	bne	a0,a5,205e <copyinstr3+0xac>
  int fd = open(b, O_CREATE | O_WRONLY);
    1ff2:	20100593          	li	a1,513
    1ff6:	8526                	mv	a0,s1
    1ff8:	61f020ef          	jal	4e16 <open>
  if(fd != -1){
    1ffc:	57fd                	li	a5,-1
    1ffe:	06f51b63          	bne	a0,a5,2074 <copyinstr3+0xc2>
  ret = link(b, b);
    2002:	85a6                	mv	a1,s1
    2004:	8526                	mv	a0,s1
    2006:	631020ef          	jal	4e36 <link>
  if(ret != -1){
    200a:	57fd                	li	a5,-1
    200c:	06f51f63          	bne	a0,a5,208a <copyinstr3+0xd8>
  char *args[] = { "xx", 0 };
    2010:	00005797          	auipc	a5,0x5
    2014:	c9878793          	addi	a5,a5,-872 # 6ca8 <malloc+0x1a10>
    2018:	fcf43823          	sd	a5,-48(s0)
    201c:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2020:	fd040593          	addi	a1,s0,-48
    2024:	8526                	mv	a0,s1
    2026:	5e9020ef          	jal	4e0e <exec>
  if(ret != -1){
    202a:	57fd                	li	a5,-1
    202c:	06f51b63          	bne	a0,a5,20a2 <copyinstr3+0xf0>
}
    2030:	70a2                	ld	ra,40(sp)
    2032:	7402                	ld	s0,32(sp)
    2034:	64e2                	ld	s1,24(sp)
    2036:	6145                	addi	sp,sp,48
    2038:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    203a:	6785                	lui	a5,0x1
    203c:	fff78713          	addi	a4,a5,-1 # fff <bigdir+0x109>
    2040:	8d79                	and	a0,a0,a4
    2042:	40a7853b          	subw	a0,a5,a0
    2046:	619020ef          	jal	4e5e <sbrk>
    204a:	b751                	j	1fce <copyinstr3+0x1c>
    printf("oops\n");
    204c:	00004517          	auipc	a0,0x4
    2050:	f7450513          	addi	a0,a0,-140 # 5fc0 <malloc+0xd28>
    2054:	18c030ef          	jal	51e0 <printf>
    exit(1);
    2058:	4505                	li	a0,1
    205a:	57d020ef          	jal	4dd6 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    205e:	862a                	mv	a2,a0
    2060:	85a6                	mv	a1,s1
    2062:	00004517          	auipc	a0,0x4
    2066:	b1650513          	addi	a0,a0,-1258 # 5b78 <malloc+0x8e0>
    206a:	176030ef          	jal	51e0 <printf>
    exit(1);
    206e:	4505                	li	a0,1
    2070:	567020ef          	jal	4dd6 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2074:	862a                	mv	a2,a0
    2076:	85a6                	mv	a1,s1
    2078:	00004517          	auipc	a0,0x4
    207c:	b2050513          	addi	a0,a0,-1248 # 5b98 <malloc+0x900>
    2080:	160030ef          	jal	51e0 <printf>
    exit(1);
    2084:	4505                	li	a0,1
    2086:	551020ef          	jal	4dd6 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    208a:	86aa                	mv	a3,a0
    208c:	8626                	mv	a2,s1
    208e:	85a6                	mv	a1,s1
    2090:	00004517          	auipc	a0,0x4
    2094:	b2850513          	addi	a0,a0,-1240 # 5bb8 <malloc+0x920>
    2098:	148030ef          	jal	51e0 <printf>
    exit(1);
    209c:	4505                	li	a0,1
    209e:	539020ef          	jal	4dd6 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    20a2:	863e                	mv	a2,a5
    20a4:	85a6                	mv	a1,s1
    20a6:	00004517          	auipc	a0,0x4
    20aa:	b3a50513          	addi	a0,a0,-1222 # 5be0 <malloc+0x948>
    20ae:	132030ef          	jal	51e0 <printf>
    exit(1);
    20b2:	4505                	li	a0,1
    20b4:	523020ef          	jal	4dd6 <exit>

00000000000020b8 <rwsbrk>:
{
    20b8:	1101                	addi	sp,sp,-32
    20ba:	ec06                	sd	ra,24(sp)
    20bc:	e822                	sd	s0,16(sp)
    20be:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    20c0:	6509                	lui	a0,0x2
    20c2:	59d020ef          	jal	4e5e <sbrk>
  if(a == 0xffffffffffffffffLL) {
    20c6:	57fd                	li	a5,-1
    20c8:	04f50a63          	beq	a0,a5,211c <rwsbrk+0x64>
    20cc:	e426                	sd	s1,8(sp)
    20ce:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    20d0:	7579                	lui	a0,0xffffe
    20d2:	58d020ef          	jal	4e5e <sbrk>
    20d6:	57fd                	li	a5,-1
    20d8:	04f50d63          	beq	a0,a5,2132 <rwsbrk+0x7a>
    20dc:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    20de:	20100593          	li	a1,513
    20e2:	00004517          	auipc	a0,0x4
    20e6:	f1e50513          	addi	a0,a0,-226 # 6000 <malloc+0xd68>
    20ea:	52d020ef          	jal	4e16 <open>
    20ee:	892a                	mv	s2,a0
  if(fd < 0){
    20f0:	04054b63          	bltz	a0,2146 <rwsbrk+0x8e>
  n = write(fd, (void*)(a+4096), 1024);
    20f4:	6785                	lui	a5,0x1
    20f6:	94be                	add	s1,s1,a5
    20f8:	40000613          	li	a2,1024
    20fc:	85a6                	mv	a1,s1
    20fe:	4f9020ef          	jal	4df6 <write>
    2102:	862a                	mv	a2,a0
  if(n >= 0){
    2104:	04054a63          	bltz	a0,2158 <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+4096, n);
    2108:	85a6                	mv	a1,s1
    210a:	00004517          	auipc	a0,0x4
    210e:	f1650513          	addi	a0,a0,-234 # 6020 <malloc+0xd88>
    2112:	0ce030ef          	jal	51e0 <printf>
    exit(1);
    2116:	4505                	li	a0,1
    2118:	4bf020ef          	jal	4dd6 <exit>
    211c:	e426                	sd	s1,8(sp)
    211e:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    2120:	00004517          	auipc	a0,0x4
    2124:	ea850513          	addi	a0,a0,-344 # 5fc8 <malloc+0xd30>
    2128:	0b8030ef          	jal	51e0 <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	4a9020ef          	jal	4dd6 <exit>
    2132:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    2134:	00004517          	auipc	a0,0x4
    2138:	eac50513          	addi	a0,a0,-340 # 5fe0 <malloc+0xd48>
    213c:	0a4030ef          	jal	51e0 <printf>
    exit(1);
    2140:	4505                	li	a0,1
    2142:	495020ef          	jal	4dd6 <exit>
    printf("open(rwsbrk) failed\n");
    2146:	00004517          	auipc	a0,0x4
    214a:	ec250513          	addi	a0,a0,-318 # 6008 <malloc+0xd70>
    214e:	092030ef          	jal	51e0 <printf>
    exit(1);
    2152:	4505                	li	a0,1
    2154:	483020ef          	jal	4dd6 <exit>
  close(fd);
    2158:	854a                	mv	a0,s2
    215a:	4a5020ef          	jal	4dfe <close>
  unlink("rwsbrk");
    215e:	00004517          	auipc	a0,0x4
    2162:	ea250513          	addi	a0,a0,-350 # 6000 <malloc+0xd68>
    2166:	4c1020ef          	jal	4e26 <unlink>
  fd = open("README", O_RDONLY);
    216a:	4581                	li	a1,0
    216c:	00003517          	auipc	a0,0x3
    2170:	43450513          	addi	a0,a0,1076 # 55a0 <malloc+0x308>
    2174:	4a3020ef          	jal	4e16 <open>
    2178:	892a                	mv	s2,a0
  if(fd < 0){
    217a:	02054363          	bltz	a0,21a0 <rwsbrk+0xe8>
  n = read(fd, (void*)(a+4096), 10);
    217e:	4629                	li	a2,10
    2180:	85a6                	mv	a1,s1
    2182:	46d020ef          	jal	4dee <read>
    2186:	862a                	mv	a2,a0
  if(n >= 0){
    2188:	02054563          	bltz	a0,21b2 <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+4096, n);
    218c:	85a6                	mv	a1,s1
    218e:	00004517          	auipc	a0,0x4
    2192:	ec250513          	addi	a0,a0,-318 # 6050 <malloc+0xdb8>
    2196:	04a030ef          	jal	51e0 <printf>
    exit(1);
    219a:	4505                	li	a0,1
    219c:	43b020ef          	jal	4dd6 <exit>
    printf("open(rwsbrk) failed\n");
    21a0:	00004517          	auipc	a0,0x4
    21a4:	e6850513          	addi	a0,a0,-408 # 6008 <malloc+0xd70>
    21a8:	038030ef          	jal	51e0 <printf>
    exit(1);
    21ac:	4505                	li	a0,1
    21ae:	429020ef          	jal	4dd6 <exit>
  close(fd);
    21b2:	854a                	mv	a0,s2
    21b4:	44b020ef          	jal	4dfe <close>
  exit(0);
    21b8:	4501                	li	a0,0
    21ba:	41d020ef          	jal	4dd6 <exit>

00000000000021be <sbrkbasic>:
{
    21be:	715d                	addi	sp,sp,-80
    21c0:	e486                	sd	ra,72(sp)
    21c2:	e0a2                	sd	s0,64(sp)
    21c4:	ec56                	sd	s5,24(sp)
    21c6:	0880                	addi	s0,sp,80
    21c8:	8aaa                	mv	s5,a0
  pid = fork();
    21ca:	405020ef          	jal	4dce <fork>
  if(pid < 0){
    21ce:	02054c63          	bltz	a0,2206 <sbrkbasic+0x48>
  if(pid == 0){
    21d2:	ed31                	bnez	a0,222e <sbrkbasic+0x70>
    a = sbrk(TOOMUCH);
    21d4:	40000537          	lui	a0,0x40000
    21d8:	487020ef          	jal	4e5e <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    21dc:	57fd                	li	a5,-1
    21de:	04f50163          	beq	a0,a5,2220 <sbrkbasic+0x62>
    21e2:	fc26                	sd	s1,56(sp)
    21e4:	f84a                	sd	s2,48(sp)
    21e6:	f44e                	sd	s3,40(sp)
    21e8:	f052                	sd	s4,32(sp)
    for(b = a; b < a+TOOMUCH; b += 4096){
    21ea:	400007b7          	lui	a5,0x40000
    21ee:	97aa                	add	a5,a5,a0
      *b = 99;
    21f0:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    21f4:	6705                	lui	a4,0x1
      *b = 99;
    21f6:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    21fa:	953a                	add	a0,a0,a4
    21fc:	fef51de3          	bne	a0,a5,21f6 <sbrkbasic+0x38>
    exit(1);
    2200:	4505                	li	a0,1
    2202:	3d5020ef          	jal	4dd6 <exit>
    2206:	fc26                	sd	s1,56(sp)
    2208:	f84a                	sd	s2,48(sp)
    220a:	f44e                	sd	s3,40(sp)
    220c:	f052                	sd	s4,32(sp)
    printf("fork failed in sbrkbasic\n");
    220e:	00004517          	auipc	a0,0x4
    2212:	e6a50513          	addi	a0,a0,-406 # 6078 <malloc+0xde0>
    2216:	7cb020ef          	jal	51e0 <printf>
    exit(1);
    221a:	4505                	li	a0,1
    221c:	3bb020ef          	jal	4dd6 <exit>
    2220:	fc26                	sd	s1,56(sp)
    2222:	f84a                	sd	s2,48(sp)
    2224:	f44e                	sd	s3,40(sp)
    2226:	f052                	sd	s4,32(sp)
      exit(0);
    2228:	4501                	li	a0,0
    222a:	3ad020ef          	jal	4dd6 <exit>
  wait(&xstatus);
    222e:	fbc40513          	addi	a0,s0,-68
    2232:	3ad020ef          	jal	4dde <wait>
  if(xstatus == 1){
    2236:	fbc42703          	lw	a4,-68(s0)
    223a:	4785                	li	a5,1
    223c:	02f70063          	beq	a4,a5,225c <sbrkbasic+0x9e>
    2240:	fc26                	sd	s1,56(sp)
    2242:	f84a                	sd	s2,48(sp)
    2244:	f44e                	sd	s3,40(sp)
    2246:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    2248:	4501                	li	a0,0
    224a:	415020ef          	jal	4e5e <sbrk>
    224e:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2250:	4901                	li	s2,0
    b = sbrk(1);
    2252:	4985                	li	s3,1
  for(i = 0; i < 5000; i++){
    2254:	6a05                	lui	s4,0x1
    2256:	388a0a13          	addi	s4,s4,904 # 1388 <truncate3+0x148>
    225a:	a005                	j	227a <sbrkbasic+0xbc>
    225c:	fc26                	sd	s1,56(sp)
    225e:	f84a                	sd	s2,48(sp)
    2260:	f44e                	sd	s3,40(sp)
    2262:	f052                	sd	s4,32(sp)
    printf("%s: too much memory allocated!\n", s);
    2264:	85d6                	mv	a1,s5
    2266:	00004517          	auipc	a0,0x4
    226a:	e3250513          	addi	a0,a0,-462 # 6098 <malloc+0xe00>
    226e:	773020ef          	jal	51e0 <printf>
    exit(1);
    2272:	4505                	li	a0,1
    2274:	363020ef          	jal	4dd6 <exit>
    2278:	84be                	mv	s1,a5
    b = sbrk(1);
    227a:	854e                	mv	a0,s3
    227c:	3e3020ef          	jal	4e5e <sbrk>
    if(b != a){
    2280:	04951163          	bne	a0,s1,22c2 <sbrkbasic+0x104>
    *b = 1;
    2284:	01348023          	sb	s3,0(s1)
    a = b + 1;
    2288:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    228c:	2905                	addiw	s2,s2,1
    228e:	ff4915e3          	bne	s2,s4,2278 <sbrkbasic+0xba>
  pid = fork();
    2292:	33d020ef          	jal	4dce <fork>
    2296:	892a                	mv	s2,a0
  if(pid < 0){
    2298:	04054263          	bltz	a0,22dc <sbrkbasic+0x11e>
  c = sbrk(1);
    229c:	4505                	li	a0,1
    229e:	3c1020ef          	jal	4e5e <sbrk>
  c = sbrk(1);
    22a2:	4505                	li	a0,1
    22a4:	3bb020ef          	jal	4e5e <sbrk>
  if(c != a + 1){
    22a8:	0489                	addi	s1,s1,2
    22aa:	04a48363          	beq	s1,a0,22f0 <sbrkbasic+0x132>
    printf("%s: sbrk test failed post-fork\n", s);
    22ae:	85d6                	mv	a1,s5
    22b0:	00004517          	auipc	a0,0x4
    22b4:	e4850513          	addi	a0,a0,-440 # 60f8 <malloc+0xe60>
    22b8:	729020ef          	jal	51e0 <printf>
    exit(1);
    22bc:	4505                	li	a0,1
    22be:	319020ef          	jal	4dd6 <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    22c2:	872a                	mv	a4,a0
    22c4:	86a6                	mv	a3,s1
    22c6:	864a                	mv	a2,s2
    22c8:	85d6                	mv	a1,s5
    22ca:	00004517          	auipc	a0,0x4
    22ce:	dee50513          	addi	a0,a0,-530 # 60b8 <malloc+0xe20>
    22d2:	70f020ef          	jal	51e0 <printf>
      exit(1);
    22d6:	4505                	li	a0,1
    22d8:	2ff020ef          	jal	4dd6 <exit>
    printf("%s: sbrk test fork failed\n", s);
    22dc:	85d6                	mv	a1,s5
    22de:	00004517          	auipc	a0,0x4
    22e2:	dfa50513          	addi	a0,a0,-518 # 60d8 <malloc+0xe40>
    22e6:	6fb020ef          	jal	51e0 <printf>
    exit(1);
    22ea:	4505                	li	a0,1
    22ec:	2eb020ef          	jal	4dd6 <exit>
  if(pid == 0)
    22f0:	00091563          	bnez	s2,22fa <sbrkbasic+0x13c>
    exit(0);
    22f4:	4501                	li	a0,0
    22f6:	2e1020ef          	jal	4dd6 <exit>
  wait(&xstatus);
    22fa:	fbc40513          	addi	a0,s0,-68
    22fe:	2e1020ef          	jal	4dde <wait>
  exit(xstatus);
    2302:	fbc42503          	lw	a0,-68(s0)
    2306:	2d1020ef          	jal	4dd6 <exit>

000000000000230a <sbrkmuch>:
{
    230a:	7179                	addi	sp,sp,-48
    230c:	f406                	sd	ra,40(sp)
    230e:	f022                	sd	s0,32(sp)
    2310:	ec26                	sd	s1,24(sp)
    2312:	e84a                	sd	s2,16(sp)
    2314:	e44e                	sd	s3,8(sp)
    2316:	e052                	sd	s4,0(sp)
    2318:	1800                	addi	s0,sp,48
    231a:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    231c:	4501                	li	a0,0
    231e:	341020ef          	jal	4e5e <sbrk>
    2322:	892a                	mv	s2,a0
  a = sbrk(0);
    2324:	4501                	li	a0,0
    2326:	339020ef          	jal	4e5e <sbrk>
    232a:	84aa                	mv	s1,a0
  p = sbrk(amt);
    232c:	06400537          	lui	a0,0x6400
    2330:	9d05                	subw	a0,a0,s1
    2332:	32d020ef          	jal	4e5e <sbrk>
  if (p != a) {
    2336:	0aa49463          	bne	s1,a0,23de <sbrkmuch+0xd4>
  char *eee = sbrk(0);
    233a:	4501                	li	a0,0
    233c:	323020ef          	jal	4e5e <sbrk>
    2340:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2342:	00a4f963          	bgeu	s1,a0,2354 <sbrkmuch+0x4a>
    *pp = 1;
    2346:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2348:	6705                	lui	a4,0x1
    *pp = 1;
    234a:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    234e:	94ba                	add	s1,s1,a4
    2350:	fef4ede3          	bltu	s1,a5,234a <sbrkmuch+0x40>
  *lastaddr = 99;
    2354:	064007b7          	lui	a5,0x6400
    2358:	06300713          	li	a4,99
    235c:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2360:	4501                	li	a0,0
    2362:	2fd020ef          	jal	4e5e <sbrk>
    2366:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2368:	757d                	lui	a0,0xfffff
    236a:	2f5020ef          	jal	4e5e <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    236e:	57fd                	li	a5,-1
    2370:	08f50163          	beq	a0,a5,23f2 <sbrkmuch+0xe8>
  c = sbrk(0);
    2374:	4501                	li	a0,0
    2376:	2e9020ef          	jal	4e5e <sbrk>
  if(c != a - PGSIZE){
    237a:	77fd                	lui	a5,0xfffff
    237c:	97a6                	add	a5,a5,s1
    237e:	08f51463          	bne	a0,a5,2406 <sbrkmuch+0xfc>
  a = sbrk(0);
    2382:	4501                	li	a0,0
    2384:	2db020ef          	jal	4e5e <sbrk>
    2388:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    238a:	6505                	lui	a0,0x1
    238c:	2d3020ef          	jal	4e5e <sbrk>
    2390:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2392:	08a49663          	bne	s1,a0,241e <sbrkmuch+0x114>
    2396:	4501                	li	a0,0
    2398:	2c7020ef          	jal	4e5e <sbrk>
    239c:	6785                	lui	a5,0x1
    239e:	97a6                	add	a5,a5,s1
    23a0:	06f51f63          	bne	a0,a5,241e <sbrkmuch+0x114>
  if(*lastaddr == 99){
    23a4:	064007b7          	lui	a5,0x6400
    23a8:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    23ac:	06300793          	li	a5,99
    23b0:	08f70363          	beq	a4,a5,2436 <sbrkmuch+0x12c>
  a = sbrk(0);
    23b4:	4501                	li	a0,0
    23b6:	2a9020ef          	jal	4e5e <sbrk>
    23ba:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    23bc:	4501                	li	a0,0
    23be:	2a1020ef          	jal	4e5e <sbrk>
    23c2:	40a9053b          	subw	a0,s2,a0
    23c6:	299020ef          	jal	4e5e <sbrk>
  if(c != a){
    23ca:	08a49063          	bne	s1,a0,244a <sbrkmuch+0x140>
}
    23ce:	70a2                	ld	ra,40(sp)
    23d0:	7402                	ld	s0,32(sp)
    23d2:	64e2                	ld	s1,24(sp)
    23d4:	6942                	ld	s2,16(sp)
    23d6:	69a2                	ld	s3,8(sp)
    23d8:	6a02                	ld	s4,0(sp)
    23da:	6145                	addi	sp,sp,48
    23dc:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    23de:	85ce                	mv	a1,s3
    23e0:	00004517          	auipc	a0,0x4
    23e4:	d3850513          	addi	a0,a0,-712 # 6118 <malloc+0xe80>
    23e8:	5f9020ef          	jal	51e0 <printf>
    exit(1);
    23ec:	4505                	li	a0,1
    23ee:	1e9020ef          	jal	4dd6 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    23f2:	85ce                	mv	a1,s3
    23f4:	00004517          	auipc	a0,0x4
    23f8:	d6c50513          	addi	a0,a0,-660 # 6160 <malloc+0xec8>
    23fc:	5e5020ef          	jal	51e0 <printf>
    exit(1);
    2400:	4505                	li	a0,1
    2402:	1d5020ef          	jal	4dd6 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    2406:	86aa                	mv	a3,a0
    2408:	8626                	mv	a2,s1
    240a:	85ce                	mv	a1,s3
    240c:	00004517          	auipc	a0,0x4
    2410:	d7450513          	addi	a0,a0,-652 # 6180 <malloc+0xee8>
    2414:	5cd020ef          	jal	51e0 <printf>
    exit(1);
    2418:	4505                	li	a0,1
    241a:	1bd020ef          	jal	4dd6 <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    241e:	86d2                	mv	a3,s4
    2420:	8626                	mv	a2,s1
    2422:	85ce                	mv	a1,s3
    2424:	00004517          	auipc	a0,0x4
    2428:	d9c50513          	addi	a0,a0,-612 # 61c0 <malloc+0xf28>
    242c:	5b5020ef          	jal	51e0 <printf>
    exit(1);
    2430:	4505                	li	a0,1
    2432:	1a5020ef          	jal	4dd6 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2436:	85ce                	mv	a1,s3
    2438:	00004517          	auipc	a0,0x4
    243c:	db850513          	addi	a0,a0,-584 # 61f0 <malloc+0xf58>
    2440:	5a1020ef          	jal	51e0 <printf>
    exit(1);
    2444:	4505                	li	a0,1
    2446:	191020ef          	jal	4dd6 <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    244a:	86aa                	mv	a3,a0
    244c:	8626                	mv	a2,s1
    244e:	85ce                	mv	a1,s3
    2450:	00004517          	auipc	a0,0x4
    2454:	dd850513          	addi	a0,a0,-552 # 6228 <malloc+0xf90>
    2458:	589020ef          	jal	51e0 <printf>
    exit(1);
    245c:	4505                	li	a0,1
    245e:	179020ef          	jal	4dd6 <exit>

0000000000002462 <sbrkarg>:
{
    2462:	7179                	addi	sp,sp,-48
    2464:	f406                	sd	ra,40(sp)
    2466:	f022                	sd	s0,32(sp)
    2468:	ec26                	sd	s1,24(sp)
    246a:	e84a                	sd	s2,16(sp)
    246c:	e44e                	sd	s3,8(sp)
    246e:	1800                	addi	s0,sp,48
    2470:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2472:	6505                	lui	a0,0x1
    2474:	1eb020ef          	jal	4e5e <sbrk>
    2478:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    247a:	20100593          	li	a1,513
    247e:	00004517          	auipc	a0,0x4
    2482:	dd250513          	addi	a0,a0,-558 # 6250 <malloc+0xfb8>
    2486:	191020ef          	jal	4e16 <open>
    248a:	84aa                	mv	s1,a0
  unlink("sbrk");
    248c:	00004517          	auipc	a0,0x4
    2490:	dc450513          	addi	a0,a0,-572 # 6250 <malloc+0xfb8>
    2494:	193020ef          	jal	4e26 <unlink>
  if(fd < 0)  {
    2498:	0204c963          	bltz	s1,24ca <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    249c:	6605                	lui	a2,0x1
    249e:	85ca                	mv	a1,s2
    24a0:	8526                	mv	a0,s1
    24a2:	155020ef          	jal	4df6 <write>
    24a6:	02054c63          	bltz	a0,24de <sbrkarg+0x7c>
  close(fd);
    24aa:	8526                	mv	a0,s1
    24ac:	153020ef          	jal	4dfe <close>
  a = sbrk(PGSIZE);
    24b0:	6505                	lui	a0,0x1
    24b2:	1ad020ef          	jal	4e5e <sbrk>
  if(pipe((int *) a) != 0){
    24b6:	131020ef          	jal	4de6 <pipe>
    24ba:	ed05                	bnez	a0,24f2 <sbrkarg+0x90>
}
    24bc:	70a2                	ld	ra,40(sp)
    24be:	7402                	ld	s0,32(sp)
    24c0:	64e2                	ld	s1,24(sp)
    24c2:	6942                	ld	s2,16(sp)
    24c4:	69a2                	ld	s3,8(sp)
    24c6:	6145                	addi	sp,sp,48
    24c8:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    24ca:	85ce                	mv	a1,s3
    24cc:	00004517          	auipc	a0,0x4
    24d0:	d8c50513          	addi	a0,a0,-628 # 6258 <malloc+0xfc0>
    24d4:	50d020ef          	jal	51e0 <printf>
    exit(1);
    24d8:	4505                	li	a0,1
    24da:	0fd020ef          	jal	4dd6 <exit>
    printf("%s: write sbrk failed\n", s);
    24de:	85ce                	mv	a1,s3
    24e0:	00004517          	auipc	a0,0x4
    24e4:	d9050513          	addi	a0,a0,-624 # 6270 <malloc+0xfd8>
    24e8:	4f9020ef          	jal	51e0 <printf>
    exit(1);
    24ec:	4505                	li	a0,1
    24ee:	0e9020ef          	jal	4dd6 <exit>
    printf("%s: pipe() failed\n", s);
    24f2:	85ce                	mv	a1,s3
    24f4:	00004517          	auipc	a0,0x4
    24f8:	86c50513          	addi	a0,a0,-1940 # 5d60 <malloc+0xac8>
    24fc:	4e5020ef          	jal	51e0 <printf>
    exit(1);
    2500:	4505                	li	a0,1
    2502:	0d5020ef          	jal	4dd6 <exit>

0000000000002506 <argptest>:
{
    2506:	1101                	addi	sp,sp,-32
    2508:	ec06                	sd	ra,24(sp)
    250a:	e822                	sd	s0,16(sp)
    250c:	e426                	sd	s1,8(sp)
    250e:	e04a                	sd	s2,0(sp)
    2510:	1000                	addi	s0,sp,32
    2512:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2514:	4581                	li	a1,0
    2516:	00004517          	auipc	a0,0x4
    251a:	d7250513          	addi	a0,a0,-654 # 6288 <malloc+0xff0>
    251e:	0f9020ef          	jal	4e16 <open>
  if (fd < 0) {
    2522:	02054563          	bltz	a0,254c <argptest+0x46>
    2526:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2528:	4501                	li	a0,0
    252a:	135020ef          	jal	4e5e <sbrk>
    252e:	567d                	li	a2,-1
    2530:	00c505b3          	add	a1,a0,a2
    2534:	8526                	mv	a0,s1
    2536:	0b9020ef          	jal	4dee <read>
  close(fd);
    253a:	8526                	mv	a0,s1
    253c:	0c3020ef          	jal	4dfe <close>
}
    2540:	60e2                	ld	ra,24(sp)
    2542:	6442                	ld	s0,16(sp)
    2544:	64a2                	ld	s1,8(sp)
    2546:	6902                	ld	s2,0(sp)
    2548:	6105                	addi	sp,sp,32
    254a:	8082                	ret
    printf("%s: open failed\n", s);
    254c:	85ca                	mv	a1,s2
    254e:	00003517          	auipc	a0,0x3
    2552:	72250513          	addi	a0,a0,1826 # 5c70 <malloc+0x9d8>
    2556:	48b020ef          	jal	51e0 <printf>
    exit(1);
    255a:	4505                	li	a0,1
    255c:	07b020ef          	jal	4dd6 <exit>

0000000000002560 <sbrkbugs>:
{
    2560:	1141                	addi	sp,sp,-16
    2562:	e406                	sd	ra,8(sp)
    2564:	e022                	sd	s0,0(sp)
    2566:	0800                	addi	s0,sp,16
  int pid = fork();
    2568:	067020ef          	jal	4dce <fork>
  if(pid < 0){
    256c:	00054c63          	bltz	a0,2584 <sbrkbugs+0x24>
  if(pid == 0){
    2570:	e11d                	bnez	a0,2596 <sbrkbugs+0x36>
    int sz = (uint64) sbrk(0);
    2572:	0ed020ef          	jal	4e5e <sbrk>
    sbrk(-sz);
    2576:	40a0053b          	negw	a0,a0
    257a:	0e5020ef          	jal	4e5e <sbrk>
    exit(0);
    257e:	4501                	li	a0,0
    2580:	057020ef          	jal	4dd6 <exit>
    printf("fork failed\n");
    2584:	00005517          	auipc	a0,0x5
    2588:	c4450513          	addi	a0,a0,-956 # 71c8 <malloc+0x1f30>
    258c:	455020ef          	jal	51e0 <printf>
    exit(1);
    2590:	4505                	li	a0,1
    2592:	045020ef          	jal	4dd6 <exit>
  wait(0);
    2596:	4501                	li	a0,0
    2598:	047020ef          	jal	4dde <wait>
  pid = fork();
    259c:	033020ef          	jal	4dce <fork>
  if(pid < 0){
    25a0:	00054f63          	bltz	a0,25be <sbrkbugs+0x5e>
  if(pid == 0){
    25a4:	e515                	bnez	a0,25d0 <sbrkbugs+0x70>
    int sz = (uint64) sbrk(0);
    25a6:	0b9020ef          	jal	4e5e <sbrk>
    sbrk(-(sz - 3500));
    25aa:	6785                	lui	a5,0x1
    25ac:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0xe0>
    25b0:	40a7853b          	subw	a0,a5,a0
    25b4:	0ab020ef          	jal	4e5e <sbrk>
    exit(0);
    25b8:	4501                	li	a0,0
    25ba:	01d020ef          	jal	4dd6 <exit>
    printf("fork failed\n");
    25be:	00005517          	auipc	a0,0x5
    25c2:	c0a50513          	addi	a0,a0,-1014 # 71c8 <malloc+0x1f30>
    25c6:	41b020ef          	jal	51e0 <printf>
    exit(1);
    25ca:	4505                	li	a0,1
    25cc:	00b020ef          	jal	4dd6 <exit>
  wait(0);
    25d0:	4501                	li	a0,0
    25d2:	00d020ef          	jal	4dde <wait>
  pid = fork();
    25d6:	7f8020ef          	jal	4dce <fork>
  if(pid < 0){
    25da:	02054263          	bltz	a0,25fe <sbrkbugs+0x9e>
  if(pid == 0){
    25de:	e90d                	bnez	a0,2610 <sbrkbugs+0xb0>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    25e0:	07f020ef          	jal	4e5e <sbrk>
    25e4:	67ad                	lui	a5,0xb
    25e6:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x298>
    25ea:	40a7853b          	subw	a0,a5,a0
    25ee:	071020ef          	jal	4e5e <sbrk>
    sbrk(-10);
    25f2:	5559                	li	a0,-10
    25f4:	06b020ef          	jal	4e5e <sbrk>
    exit(0);
    25f8:	4501                	li	a0,0
    25fa:	7dc020ef          	jal	4dd6 <exit>
    printf("fork failed\n");
    25fe:	00005517          	auipc	a0,0x5
    2602:	bca50513          	addi	a0,a0,-1078 # 71c8 <malloc+0x1f30>
    2606:	3db020ef          	jal	51e0 <printf>
    exit(1);
    260a:	4505                	li	a0,1
    260c:	7ca020ef          	jal	4dd6 <exit>
  wait(0);
    2610:	4501                	li	a0,0
    2612:	7cc020ef          	jal	4dde <wait>
  exit(0);
    2616:	4501                	li	a0,0
    2618:	7be020ef          	jal	4dd6 <exit>

000000000000261c <sbrklast>:
{
    261c:	7179                	addi	sp,sp,-48
    261e:	f406                	sd	ra,40(sp)
    2620:	f022                	sd	s0,32(sp)
    2622:	ec26                	sd	s1,24(sp)
    2624:	e84a                	sd	s2,16(sp)
    2626:	e44e                	sd	s3,8(sp)
    2628:	e052                	sd	s4,0(sp)
    262a:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    262c:	4501                	li	a0,0
    262e:	031020ef          	jal	4e5e <sbrk>
  if((top % 4096) != 0)
    2632:	03451793          	slli	a5,a0,0x34
    2636:	ebad                	bnez	a5,26a8 <sbrklast+0x8c>
  sbrk(4096);
    2638:	6505                	lui	a0,0x1
    263a:	025020ef          	jal	4e5e <sbrk>
  sbrk(10);
    263e:	4529                	li	a0,10
    2640:	01f020ef          	jal	4e5e <sbrk>
  sbrk(-20);
    2644:	5531                	li	a0,-20
    2646:	019020ef          	jal	4e5e <sbrk>
  top = (uint64) sbrk(0);
    264a:	4501                	li	a0,0
    264c:	013020ef          	jal	4e5e <sbrk>
    2650:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2652:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0xca>
  p[0] = 'x';
    2656:	07800a13          	li	s4,120
    265a:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    265e:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2662:	20200593          	li	a1,514
    2666:	854a                	mv	a0,s2
    2668:	7ae020ef          	jal	4e16 <open>
    266c:	89aa                	mv	s3,a0
  write(fd, p, 1);
    266e:	4605                	li	a2,1
    2670:	85ca                	mv	a1,s2
    2672:	784020ef          	jal	4df6 <write>
  close(fd);
    2676:	854e                	mv	a0,s3
    2678:	786020ef          	jal	4dfe <close>
  fd = open(p, O_RDWR);
    267c:	4589                	li	a1,2
    267e:	854a                	mv	a0,s2
    2680:	796020ef          	jal	4e16 <open>
  p[0] = '\0';
    2684:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2688:	4605                	li	a2,1
    268a:	85ca                	mv	a1,s2
    268c:	762020ef          	jal	4dee <read>
  if(p[0] != 'x')
    2690:	fc04c783          	lbu	a5,-64(s1)
    2694:	03479363          	bne	a5,s4,26ba <sbrklast+0x9e>
}
    2698:	70a2                	ld	ra,40(sp)
    269a:	7402                	ld	s0,32(sp)
    269c:	64e2                	ld	s1,24(sp)
    269e:	6942                	ld	s2,16(sp)
    26a0:	69a2                	ld	s3,8(sp)
    26a2:	6a02                	ld	s4,0(sp)
    26a4:	6145                	addi	sp,sp,48
    26a6:	8082                	ret
    sbrk(4096 - (top % 4096));
    26a8:	6785                	lui	a5,0x1
    26aa:	fff78713          	addi	a4,a5,-1 # fff <bigdir+0x109>
    26ae:	8d79                	and	a0,a0,a4
    26b0:	40a7853b          	subw	a0,a5,a0
    26b4:	7aa020ef          	jal	4e5e <sbrk>
    26b8:	b741                	j	2638 <sbrklast+0x1c>
    exit(1);
    26ba:	4505                	li	a0,1
    26bc:	71a020ef          	jal	4dd6 <exit>

00000000000026c0 <sbrk8000>:
{
    26c0:	1141                	addi	sp,sp,-16
    26c2:	e406                	sd	ra,8(sp)
    26c4:	e022                	sd	s0,0(sp)
    26c6:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    26c8:	80000537          	lui	a0,0x80000
    26cc:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7fff038c>
    26ce:	790020ef          	jal	4e5e <sbrk>
  volatile char *top = sbrk(0);
    26d2:	4501                	li	a0,0
    26d4:	78a020ef          	jal	4e5e <sbrk>
  *(top-1) = *(top-1) + 1;
    26d8:	fff54783          	lbu	a5,-1(a0)
    26dc:	0785                	addi	a5,a5,1
    26de:	0ff7f793          	zext.b	a5,a5
    26e2:	fef50fa3          	sb	a5,-1(a0)
}
    26e6:	60a2                	ld	ra,8(sp)
    26e8:	6402                	ld	s0,0(sp)
    26ea:	0141                	addi	sp,sp,16
    26ec:	8082                	ret

00000000000026ee <execout>:
{
    26ee:	711d                	addi	sp,sp,-96
    26f0:	ec86                	sd	ra,88(sp)
    26f2:	e8a2                	sd	s0,80(sp)
    26f4:	e4a6                	sd	s1,72(sp)
    26f6:	e0ca                	sd	s2,64(sp)
    26f8:	fc4e                	sd	s3,56(sp)
    26fa:	1080                	addi	s0,sp,96
  for(int avail = 0; avail < 15; avail++){
    26fc:	4901                	li	s2,0
    26fe:	49bd                	li	s3,15
    int pid = fork();
    2700:	6ce020ef          	jal	4dce <fork>
    2704:	84aa                	mv	s1,a0
    if(pid < 0){
    2706:	00054e63          	bltz	a0,2722 <execout+0x34>
    } else if(pid == 0){
    270a:	c51d                	beqz	a0,2738 <execout+0x4a>
      wait((int*)0);
    270c:	4501                	li	a0,0
    270e:	6d0020ef          	jal	4dde <wait>
  for(int avail = 0; avail < 15; avail++){
    2712:	2905                	addiw	s2,s2,1
    2714:	ff3916e3          	bne	s2,s3,2700 <execout+0x12>
    2718:	f852                	sd	s4,48(sp)
    271a:	f456                	sd	s5,40(sp)
  exit(0);
    271c:	4501                	li	a0,0
    271e:	6b8020ef          	jal	4dd6 <exit>
    2722:	f852                	sd	s4,48(sp)
    2724:	f456                	sd	s5,40(sp)
      printf("fork failed\n");
    2726:	00005517          	auipc	a0,0x5
    272a:	aa250513          	addi	a0,a0,-1374 # 71c8 <malloc+0x1f30>
    272e:	2b3020ef          	jal	51e0 <printf>
      exit(1);
    2732:	4505                	li	a0,1
    2734:	6a2020ef          	jal	4dd6 <exit>
    2738:	f852                	sd	s4,48(sp)
    273a:	f456                	sd	s5,40(sp)
        uint64 a = (uint64) sbrk(4096);
    273c:	6985                	lui	s3,0x1
        if(a == 0xffffffffffffffffLL)
    273e:	5a7d                	li	s4,-1
        *(char*)(a + 4096 - 1) = 1;
    2740:	4a85                	li	s5,1
        uint64 a = (uint64) sbrk(4096);
    2742:	854e                	mv	a0,s3
    2744:	71a020ef          	jal	4e5e <sbrk>
        if(a == 0xffffffffffffffffLL)
    2748:	01450663          	beq	a0,s4,2754 <execout+0x66>
        *(char*)(a + 4096 - 1) = 1;
    274c:	954e                	add	a0,a0,s3
    274e:	ff550fa3          	sb	s5,-1(a0)
      while(1){
    2752:	bfc5                	j	2742 <execout+0x54>
        sbrk(-4096);
    2754:	79fd                	lui	s3,0xfffff
      for(int i = 0; i < avail; i++)
    2756:	01205863          	blez	s2,2766 <execout+0x78>
        sbrk(-4096);
    275a:	854e                	mv	a0,s3
    275c:	702020ef          	jal	4e5e <sbrk>
      for(int i = 0; i < avail; i++)
    2760:	2485                	addiw	s1,s1,1
    2762:	ff249ce3          	bne	s1,s2,275a <execout+0x6c>
      close(1);
    2766:	4505                	li	a0,1
    2768:	696020ef          	jal	4dfe <close>
      char *args[] = { "echo", "x", 0 };
    276c:	00003517          	auipc	a0,0x3
    2770:	c5c50513          	addi	a0,a0,-932 # 53c8 <malloc+0x130>
    2774:	faa43423          	sd	a0,-88(s0)
    2778:	00003797          	auipc	a5,0x3
    277c:	cc078793          	addi	a5,a5,-832 # 5438 <malloc+0x1a0>
    2780:	faf43823          	sd	a5,-80(s0)
    2784:	fa043c23          	sd	zero,-72(s0)
      exec("echo", args);
    2788:	fa840593          	addi	a1,s0,-88
    278c:	682020ef          	jal	4e0e <exec>
      exit(0);
    2790:	4501                	li	a0,0
    2792:	644020ef          	jal	4dd6 <exit>

0000000000002796 <fourteen>:
{
    2796:	1101                	addi	sp,sp,-32
    2798:	ec06                	sd	ra,24(sp)
    279a:	e822                	sd	s0,16(sp)
    279c:	e426                	sd	s1,8(sp)
    279e:	1000                	addi	s0,sp,32
    27a0:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    27a2:	00004517          	auipc	a0,0x4
    27a6:	cbe50513          	addi	a0,a0,-834 # 6460 <malloc+0x11c8>
    27aa:	694020ef          	jal	4e3e <mkdir>
    27ae:	e555                	bnez	a0,285a <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    27b0:	00004517          	auipc	a0,0x4
    27b4:	b0850513          	addi	a0,a0,-1272 # 62b8 <malloc+0x1020>
    27b8:	686020ef          	jal	4e3e <mkdir>
    27bc:	e94d                	bnez	a0,286e <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    27be:	20000593          	li	a1,512
    27c2:	00004517          	auipc	a0,0x4
    27c6:	b4e50513          	addi	a0,a0,-1202 # 6310 <malloc+0x1078>
    27ca:	64c020ef          	jal	4e16 <open>
  if(fd < 0){
    27ce:	0a054a63          	bltz	a0,2882 <fourteen+0xec>
  close(fd);
    27d2:	62c020ef          	jal	4dfe <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27d6:	4581                	li	a1,0
    27d8:	00004517          	auipc	a0,0x4
    27dc:	bb050513          	addi	a0,a0,-1104 # 6388 <malloc+0x10f0>
    27e0:	636020ef          	jal	4e16 <open>
  if(fd < 0){
    27e4:	0a054963          	bltz	a0,2896 <fourteen+0x100>
  close(fd);
    27e8:	616020ef          	jal	4dfe <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    27ec:	00004517          	auipc	a0,0x4
    27f0:	c0c50513          	addi	a0,a0,-1012 # 63f8 <malloc+0x1160>
    27f4:	64a020ef          	jal	4e3e <mkdir>
    27f8:	c94d                	beqz	a0,28aa <fourteen+0x114>
  if(mkdir("123456789012345/12345678901234") == 0){
    27fa:	00004517          	auipc	a0,0x4
    27fe:	c5650513          	addi	a0,a0,-938 # 6450 <malloc+0x11b8>
    2802:	63c020ef          	jal	4e3e <mkdir>
    2806:	cd45                	beqz	a0,28be <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    2808:	00004517          	auipc	a0,0x4
    280c:	c4850513          	addi	a0,a0,-952 # 6450 <malloc+0x11b8>
    2810:	616020ef          	jal	4e26 <unlink>
  unlink("12345678901234/12345678901234");
    2814:	00004517          	auipc	a0,0x4
    2818:	be450513          	addi	a0,a0,-1052 # 63f8 <malloc+0x1160>
    281c:	60a020ef          	jal	4e26 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2820:	00004517          	auipc	a0,0x4
    2824:	b6850513          	addi	a0,a0,-1176 # 6388 <malloc+0x10f0>
    2828:	5fe020ef          	jal	4e26 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    282c:	00004517          	auipc	a0,0x4
    2830:	ae450513          	addi	a0,a0,-1308 # 6310 <malloc+0x1078>
    2834:	5f2020ef          	jal	4e26 <unlink>
  unlink("12345678901234/123456789012345");
    2838:	00004517          	auipc	a0,0x4
    283c:	a8050513          	addi	a0,a0,-1408 # 62b8 <malloc+0x1020>
    2840:	5e6020ef          	jal	4e26 <unlink>
  unlink("12345678901234");
    2844:	00004517          	auipc	a0,0x4
    2848:	c1c50513          	addi	a0,a0,-996 # 6460 <malloc+0x11c8>
    284c:	5da020ef          	jal	4e26 <unlink>
}
    2850:	60e2                	ld	ra,24(sp)
    2852:	6442                	ld	s0,16(sp)
    2854:	64a2                	ld	s1,8(sp)
    2856:	6105                	addi	sp,sp,32
    2858:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    285a:	85a6                	mv	a1,s1
    285c:	00004517          	auipc	a0,0x4
    2860:	a3450513          	addi	a0,a0,-1484 # 6290 <malloc+0xff8>
    2864:	17d020ef          	jal	51e0 <printf>
    exit(1);
    2868:	4505                	li	a0,1
    286a:	56c020ef          	jal	4dd6 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    286e:	85a6                	mv	a1,s1
    2870:	00004517          	auipc	a0,0x4
    2874:	a6850513          	addi	a0,a0,-1432 # 62d8 <malloc+0x1040>
    2878:	169020ef          	jal	51e0 <printf>
    exit(1);
    287c:	4505                	li	a0,1
    287e:	558020ef          	jal	4dd6 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2882:	85a6                	mv	a1,s1
    2884:	00004517          	auipc	a0,0x4
    2888:	abc50513          	addi	a0,a0,-1348 # 6340 <malloc+0x10a8>
    288c:	155020ef          	jal	51e0 <printf>
    exit(1);
    2890:	4505                	li	a0,1
    2892:	544020ef          	jal	4dd6 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2896:	85a6                	mv	a1,s1
    2898:	00004517          	auipc	a0,0x4
    289c:	b2050513          	addi	a0,a0,-1248 # 63b8 <malloc+0x1120>
    28a0:	141020ef          	jal	51e0 <printf>
    exit(1);
    28a4:	4505                	li	a0,1
    28a6:	530020ef          	jal	4dd6 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    28aa:	85a6                	mv	a1,s1
    28ac:	00004517          	auipc	a0,0x4
    28b0:	b6c50513          	addi	a0,a0,-1172 # 6418 <malloc+0x1180>
    28b4:	12d020ef          	jal	51e0 <printf>
    exit(1);
    28b8:	4505                	li	a0,1
    28ba:	51c020ef          	jal	4dd6 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    28be:	85a6                	mv	a1,s1
    28c0:	00004517          	auipc	a0,0x4
    28c4:	bb050513          	addi	a0,a0,-1104 # 6470 <malloc+0x11d8>
    28c8:	119020ef          	jal	51e0 <printf>
    exit(1);
    28cc:	4505                	li	a0,1
    28ce:	508020ef          	jal	4dd6 <exit>

00000000000028d2 <diskfull>:
{
    28d2:	b6010113          	addi	sp,sp,-1184
    28d6:	48113c23          	sd	ra,1176(sp)
    28da:	48813823          	sd	s0,1168(sp)
    28de:	48913423          	sd	s1,1160(sp)
    28e2:	49213023          	sd	s2,1152(sp)
    28e6:	47313c23          	sd	s3,1144(sp)
    28ea:	47413823          	sd	s4,1136(sp)
    28ee:	47513423          	sd	s5,1128(sp)
    28f2:	47613023          	sd	s6,1120(sp)
    28f6:	45713c23          	sd	s7,1112(sp)
    28fa:	45813823          	sd	s8,1104(sp)
    28fe:	45913423          	sd	s9,1096(sp)
    2902:	45a13023          	sd	s10,1088(sp)
    2906:	43b13c23          	sd	s11,1080(sp)
    290a:	4a010413          	addi	s0,sp,1184
    290e:	b6a43423          	sd	a0,-1176(s0)
  unlink("diskfulldir");
    2912:	00004517          	auipc	a0,0x4
    2916:	b9650513          	addi	a0,a0,-1130 # 64a8 <malloc+0x1210>
    291a:	50c020ef          	jal	4e26 <unlink>
    291e:	03000a93          	li	s5,48
    name[0] = 'b';
    2922:	06200d13          	li	s10,98
    name[1] = 'i';
    2926:	06900c93          	li	s9,105
    name[2] = 'g';
    292a:	06700c13          	li	s8,103
    unlink(name);
    292e:	b7040b13          	addi	s6,s0,-1168
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2932:	60200b93          	li	s7,1538
    2936:	10c00d93          	li	s11,268
      if(write(fd, buf, BSIZE) != BSIZE){
    293a:	b9040a13          	addi	s4,s0,-1136
    293e:	aa8d                	j	2ab0 <diskfull+0x1de>
      printf("%s: could not create file %s\n", s, name);
    2940:	b7040613          	addi	a2,s0,-1168
    2944:	b6843583          	ld	a1,-1176(s0)
    2948:	00004517          	auipc	a0,0x4
    294c:	b7050513          	addi	a0,a0,-1168 # 64b8 <malloc+0x1220>
    2950:	091020ef          	jal	51e0 <printf>
      break;
    2954:	a039                	j	2962 <diskfull+0x90>
        close(fd);
    2956:	854e                	mv	a0,s3
    2958:	4a6020ef          	jal	4dfe <close>
    close(fd);
    295c:	854e                	mv	a0,s3
    295e:	4a0020ef          	jal	4dfe <close>
  for(int i = 0; i < nzz; i++){
    2962:	4481                	li	s1,0
    name[0] = 'z';
    2964:	07a00993          	li	s3,122
    unlink(name);
    2968:	b9040913          	addi	s2,s0,-1136
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    296c:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
    2970:	08000a93          	li	s5,128
    name[0] = 'z';
    2974:	b9340823          	sb	s3,-1136(s0)
    name[1] = 'z';
    2978:	b93408a3          	sb	s3,-1135(s0)
    name[2] = '0' + (i / 32);
    297c:	41f4d71b          	sraiw	a4,s1,0x1f
    2980:	01b7571b          	srliw	a4,a4,0x1b
    2984:	009707bb          	addw	a5,a4,s1
    2988:	4057d69b          	sraiw	a3,a5,0x5
    298c:	0306869b          	addiw	a3,a3,48
    2990:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    2994:	8bfd                	andi	a5,a5,31
    2996:	9f99                	subw	a5,a5,a4
    2998:	0307879b          	addiw	a5,a5,48
    299c:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    29a0:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    29a4:	854a                	mv	a0,s2
    29a6:	480020ef          	jal	4e26 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    29aa:	85d2                	mv	a1,s4
    29ac:	854a                	mv	a0,s2
    29ae:	468020ef          	jal	4e16 <open>
    if(fd < 0)
    29b2:	00054763          	bltz	a0,29c0 <diskfull+0xee>
    close(fd);
    29b6:	448020ef          	jal	4dfe <close>
  for(int i = 0; i < nzz; i++){
    29ba:	2485                	addiw	s1,s1,1
    29bc:	fb549ce3          	bne	s1,s5,2974 <diskfull+0xa2>
  if(mkdir("diskfulldir") == 0)
    29c0:	00004517          	auipc	a0,0x4
    29c4:	ae850513          	addi	a0,a0,-1304 # 64a8 <malloc+0x1210>
    29c8:	476020ef          	jal	4e3e <mkdir>
    29cc:	12050363          	beqz	a0,2af2 <diskfull+0x220>
  unlink("diskfulldir");
    29d0:	00004517          	auipc	a0,0x4
    29d4:	ad850513          	addi	a0,a0,-1320 # 64a8 <malloc+0x1210>
    29d8:	44e020ef          	jal	4e26 <unlink>
  for(int i = 0; i < nzz; i++){
    29dc:	4481                	li	s1,0
    name[0] = 'z';
    29de:	07a00913          	li	s2,122
    unlink(name);
    29e2:	b9040a13          	addi	s4,s0,-1136
  for(int i = 0; i < nzz; i++){
    29e6:	08000993          	li	s3,128
    name[0] = 'z';
    29ea:	b9240823          	sb	s2,-1136(s0)
    name[1] = 'z';
    29ee:	b92408a3          	sb	s2,-1135(s0)
    name[2] = '0' + (i / 32);
    29f2:	41f4d71b          	sraiw	a4,s1,0x1f
    29f6:	01b7571b          	srliw	a4,a4,0x1b
    29fa:	009707bb          	addw	a5,a4,s1
    29fe:	4057d69b          	sraiw	a3,a5,0x5
    2a02:	0306869b          	addiw	a3,a3,48
    2a06:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    2a0a:	8bfd                	andi	a5,a5,31
    2a0c:	9f99                	subw	a5,a5,a4
    2a0e:	0307879b          	addiw	a5,a5,48
    2a12:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    2a16:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a1a:	8552                	mv	a0,s4
    2a1c:	40a020ef          	jal	4e26 <unlink>
  for(int i = 0; i < nzz; i++){
    2a20:	2485                	addiw	s1,s1,1
    2a22:	fd3494e3          	bne	s1,s3,29ea <diskfull+0x118>
    2a26:	03000493          	li	s1,48
    name[0] = 'b';
    2a2a:	06200b13          	li	s6,98
    name[1] = 'i';
    2a2e:	06900a93          	li	s5,105
    name[2] = 'g';
    2a32:	06700a13          	li	s4,103
    unlink(name);
    2a36:	b9040993          	addi	s3,s0,-1136
  for(int i = 0; '0' + i < 0177; i++){
    2a3a:	07f00913          	li	s2,127
    name[0] = 'b';
    2a3e:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    2a42:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    2a46:	b9440923          	sb	s4,-1134(s0)
    name[3] = '0' + i;
    2a4a:	b89409a3          	sb	s1,-1133(s0)
    name[4] = '\0';
    2a4e:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a52:	854e                	mv	a0,s3
    2a54:	3d2020ef          	jal	4e26 <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    2a58:	2485                	addiw	s1,s1,1
    2a5a:	0ff4f493          	zext.b	s1,s1
    2a5e:	ff2490e3          	bne	s1,s2,2a3e <diskfull+0x16c>
}
    2a62:	49813083          	ld	ra,1176(sp)
    2a66:	49013403          	ld	s0,1168(sp)
    2a6a:	48813483          	ld	s1,1160(sp)
    2a6e:	48013903          	ld	s2,1152(sp)
    2a72:	47813983          	ld	s3,1144(sp)
    2a76:	47013a03          	ld	s4,1136(sp)
    2a7a:	46813a83          	ld	s5,1128(sp)
    2a7e:	46013b03          	ld	s6,1120(sp)
    2a82:	45813b83          	ld	s7,1112(sp)
    2a86:	45013c03          	ld	s8,1104(sp)
    2a8a:	44813c83          	ld	s9,1096(sp)
    2a8e:	44013d03          	ld	s10,1088(sp)
    2a92:	43813d83          	ld	s11,1080(sp)
    2a96:	4a010113          	addi	sp,sp,1184
    2a9a:	8082                	ret
    close(fd);
    2a9c:	854e                	mv	a0,s3
    2a9e:	360020ef          	jal	4dfe <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    2aa2:	2a85                	addiw	s5,s5,1
    2aa4:	0ffafa93          	zext.b	s5,s5
    2aa8:	07f00793          	li	a5,127
    2aac:	eafa8be3          	beq	s5,a5,2962 <diskfull+0x90>
    name[0] = 'b';
    2ab0:	b7a40823          	sb	s10,-1168(s0)
    name[1] = 'i';
    2ab4:	b79408a3          	sb	s9,-1167(s0)
    name[2] = 'g';
    2ab8:	b7840923          	sb	s8,-1166(s0)
    name[3] = '0' + fi;
    2abc:	b75409a3          	sb	s5,-1165(s0)
    name[4] = '\0';
    2ac0:	b6040a23          	sb	zero,-1164(s0)
    unlink(name);
    2ac4:	855a                	mv	a0,s6
    2ac6:	360020ef          	jal	4e26 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2aca:	85de                	mv	a1,s7
    2acc:	855a                	mv	a0,s6
    2ace:	348020ef          	jal	4e16 <open>
    2ad2:	89aa                	mv	s3,a0
    if(fd < 0){
    2ad4:	e60546e3          	bltz	a0,2940 <diskfull+0x6e>
    2ad8:	84ee                	mv	s1,s11
      if(write(fd, buf, BSIZE) != BSIZE){
    2ada:	40000913          	li	s2,1024
    2ade:	864a                	mv	a2,s2
    2ae0:	85d2                	mv	a1,s4
    2ae2:	854e                	mv	a0,s3
    2ae4:	312020ef          	jal	4df6 <write>
    2ae8:	e72517e3          	bne	a0,s2,2956 <diskfull+0x84>
    for(int i = 0; i < MAXFILE; i++){
    2aec:	34fd                	addiw	s1,s1,-1
    2aee:	f8e5                	bnez	s1,2ade <diskfull+0x20c>
    2af0:	b775                	j	2a9c <diskfull+0x1ca>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    2af2:	b6843583          	ld	a1,-1176(s0)
    2af6:	00004517          	auipc	a0,0x4
    2afa:	9e250513          	addi	a0,a0,-1566 # 64d8 <malloc+0x1240>
    2afe:	6e2020ef          	jal	51e0 <printf>
    2b02:	b5f9                	j	29d0 <diskfull+0xfe>

0000000000002b04 <iputtest>:
{
    2b04:	1101                	addi	sp,sp,-32
    2b06:	ec06                	sd	ra,24(sp)
    2b08:	e822                	sd	s0,16(sp)
    2b0a:	e426                	sd	s1,8(sp)
    2b0c:	1000                	addi	s0,sp,32
    2b0e:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2b10:	00004517          	auipc	a0,0x4
    2b14:	9f850513          	addi	a0,a0,-1544 # 6508 <malloc+0x1270>
    2b18:	326020ef          	jal	4e3e <mkdir>
    2b1c:	02054f63          	bltz	a0,2b5a <iputtest+0x56>
  if(chdir("iputdir") < 0){
    2b20:	00004517          	auipc	a0,0x4
    2b24:	9e850513          	addi	a0,a0,-1560 # 6508 <malloc+0x1270>
    2b28:	31e020ef          	jal	4e46 <chdir>
    2b2c:	04054163          	bltz	a0,2b6e <iputtest+0x6a>
  if(unlink("../iputdir") < 0){
    2b30:	00004517          	auipc	a0,0x4
    2b34:	a1850513          	addi	a0,a0,-1512 # 6548 <malloc+0x12b0>
    2b38:	2ee020ef          	jal	4e26 <unlink>
    2b3c:	04054363          	bltz	a0,2b82 <iputtest+0x7e>
  if(chdir("/") < 0){
    2b40:	00004517          	auipc	a0,0x4
    2b44:	a3850513          	addi	a0,a0,-1480 # 6578 <malloc+0x12e0>
    2b48:	2fe020ef          	jal	4e46 <chdir>
    2b4c:	04054563          	bltz	a0,2b96 <iputtest+0x92>
}
    2b50:	60e2                	ld	ra,24(sp)
    2b52:	6442                	ld	s0,16(sp)
    2b54:	64a2                	ld	s1,8(sp)
    2b56:	6105                	addi	sp,sp,32
    2b58:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b5a:	85a6                	mv	a1,s1
    2b5c:	00004517          	auipc	a0,0x4
    2b60:	9b450513          	addi	a0,a0,-1612 # 6510 <malloc+0x1278>
    2b64:	67c020ef          	jal	51e0 <printf>
    exit(1);
    2b68:	4505                	li	a0,1
    2b6a:	26c020ef          	jal	4dd6 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2b6e:	85a6                	mv	a1,s1
    2b70:	00004517          	auipc	a0,0x4
    2b74:	9b850513          	addi	a0,a0,-1608 # 6528 <malloc+0x1290>
    2b78:	668020ef          	jal	51e0 <printf>
    exit(1);
    2b7c:	4505                	li	a0,1
    2b7e:	258020ef          	jal	4dd6 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2b82:	85a6                	mv	a1,s1
    2b84:	00004517          	auipc	a0,0x4
    2b88:	9d450513          	addi	a0,a0,-1580 # 6558 <malloc+0x12c0>
    2b8c:	654020ef          	jal	51e0 <printf>
    exit(1);
    2b90:	4505                	li	a0,1
    2b92:	244020ef          	jal	4dd6 <exit>
    printf("%s: chdir / failed\n", s);
    2b96:	85a6                	mv	a1,s1
    2b98:	00004517          	auipc	a0,0x4
    2b9c:	9e850513          	addi	a0,a0,-1560 # 6580 <malloc+0x12e8>
    2ba0:	640020ef          	jal	51e0 <printf>
    exit(1);
    2ba4:	4505                	li	a0,1
    2ba6:	230020ef          	jal	4dd6 <exit>

0000000000002baa <exitiputtest>:
{
    2baa:	7179                	addi	sp,sp,-48
    2bac:	f406                	sd	ra,40(sp)
    2bae:	f022                	sd	s0,32(sp)
    2bb0:	ec26                	sd	s1,24(sp)
    2bb2:	1800                	addi	s0,sp,48
    2bb4:	84aa                	mv	s1,a0
  pid = fork();
    2bb6:	218020ef          	jal	4dce <fork>
  if(pid < 0){
    2bba:	02054e63          	bltz	a0,2bf6 <exitiputtest+0x4c>
  if(pid == 0){
    2bbe:	e541                	bnez	a0,2c46 <exitiputtest+0x9c>
    if(mkdir("iputdir") < 0){
    2bc0:	00004517          	auipc	a0,0x4
    2bc4:	94850513          	addi	a0,a0,-1720 # 6508 <malloc+0x1270>
    2bc8:	276020ef          	jal	4e3e <mkdir>
    2bcc:	02054f63          	bltz	a0,2c0a <exitiputtest+0x60>
    if(chdir("iputdir") < 0){
    2bd0:	00004517          	auipc	a0,0x4
    2bd4:	93850513          	addi	a0,a0,-1736 # 6508 <malloc+0x1270>
    2bd8:	26e020ef          	jal	4e46 <chdir>
    2bdc:	04054163          	bltz	a0,2c1e <exitiputtest+0x74>
    if(unlink("../iputdir") < 0){
    2be0:	00004517          	auipc	a0,0x4
    2be4:	96850513          	addi	a0,a0,-1688 # 6548 <malloc+0x12b0>
    2be8:	23e020ef          	jal	4e26 <unlink>
    2bec:	04054363          	bltz	a0,2c32 <exitiputtest+0x88>
    exit(0);
    2bf0:	4501                	li	a0,0
    2bf2:	1e4020ef          	jal	4dd6 <exit>
    printf("%s: fork failed\n", s);
    2bf6:	85a6                	mv	a1,s1
    2bf8:	00003517          	auipc	a0,0x3
    2bfc:	06050513          	addi	a0,a0,96 # 5c58 <malloc+0x9c0>
    2c00:	5e0020ef          	jal	51e0 <printf>
    exit(1);
    2c04:	4505                	li	a0,1
    2c06:	1d0020ef          	jal	4dd6 <exit>
      printf("%s: mkdir failed\n", s);
    2c0a:	85a6                	mv	a1,s1
    2c0c:	00004517          	auipc	a0,0x4
    2c10:	90450513          	addi	a0,a0,-1788 # 6510 <malloc+0x1278>
    2c14:	5cc020ef          	jal	51e0 <printf>
      exit(1);
    2c18:	4505                	li	a0,1
    2c1a:	1bc020ef          	jal	4dd6 <exit>
      printf("%s: child chdir failed\n", s);
    2c1e:	85a6                	mv	a1,s1
    2c20:	00004517          	auipc	a0,0x4
    2c24:	97850513          	addi	a0,a0,-1672 # 6598 <malloc+0x1300>
    2c28:	5b8020ef          	jal	51e0 <printf>
      exit(1);
    2c2c:	4505                	li	a0,1
    2c2e:	1a8020ef          	jal	4dd6 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2c32:	85a6                	mv	a1,s1
    2c34:	00004517          	auipc	a0,0x4
    2c38:	92450513          	addi	a0,a0,-1756 # 6558 <malloc+0x12c0>
    2c3c:	5a4020ef          	jal	51e0 <printf>
      exit(1);
    2c40:	4505                	li	a0,1
    2c42:	194020ef          	jal	4dd6 <exit>
  wait(&xstatus);
    2c46:	fdc40513          	addi	a0,s0,-36
    2c4a:	194020ef          	jal	4dde <wait>
  exit(xstatus);
    2c4e:	fdc42503          	lw	a0,-36(s0)
    2c52:	184020ef          	jal	4dd6 <exit>

0000000000002c56 <dirtest>:
{
    2c56:	1101                	addi	sp,sp,-32
    2c58:	ec06                	sd	ra,24(sp)
    2c5a:	e822                	sd	s0,16(sp)
    2c5c:	e426                	sd	s1,8(sp)
    2c5e:	1000                	addi	s0,sp,32
    2c60:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2c62:	00004517          	auipc	a0,0x4
    2c66:	94e50513          	addi	a0,a0,-1714 # 65b0 <malloc+0x1318>
    2c6a:	1d4020ef          	jal	4e3e <mkdir>
    2c6e:	02054f63          	bltz	a0,2cac <dirtest+0x56>
  if(chdir("dir0") < 0){
    2c72:	00004517          	auipc	a0,0x4
    2c76:	93e50513          	addi	a0,a0,-1730 # 65b0 <malloc+0x1318>
    2c7a:	1cc020ef          	jal	4e46 <chdir>
    2c7e:	04054163          	bltz	a0,2cc0 <dirtest+0x6a>
  if(chdir("..") < 0){
    2c82:	00004517          	auipc	a0,0x4
    2c86:	94e50513          	addi	a0,a0,-1714 # 65d0 <malloc+0x1338>
    2c8a:	1bc020ef          	jal	4e46 <chdir>
    2c8e:	04054363          	bltz	a0,2cd4 <dirtest+0x7e>
  if(unlink("dir0") < 0){
    2c92:	00004517          	auipc	a0,0x4
    2c96:	91e50513          	addi	a0,a0,-1762 # 65b0 <malloc+0x1318>
    2c9a:	18c020ef          	jal	4e26 <unlink>
    2c9e:	04054563          	bltz	a0,2ce8 <dirtest+0x92>
}
    2ca2:	60e2                	ld	ra,24(sp)
    2ca4:	6442                	ld	s0,16(sp)
    2ca6:	64a2                	ld	s1,8(sp)
    2ca8:	6105                	addi	sp,sp,32
    2caa:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2cac:	85a6                	mv	a1,s1
    2cae:	00004517          	auipc	a0,0x4
    2cb2:	86250513          	addi	a0,a0,-1950 # 6510 <malloc+0x1278>
    2cb6:	52a020ef          	jal	51e0 <printf>
    exit(1);
    2cba:	4505                	li	a0,1
    2cbc:	11a020ef          	jal	4dd6 <exit>
    printf("%s: chdir dir0 failed\n", s);
    2cc0:	85a6                	mv	a1,s1
    2cc2:	00004517          	auipc	a0,0x4
    2cc6:	8f650513          	addi	a0,a0,-1802 # 65b8 <malloc+0x1320>
    2cca:	516020ef          	jal	51e0 <printf>
    exit(1);
    2cce:	4505                	li	a0,1
    2cd0:	106020ef          	jal	4dd6 <exit>
    printf("%s: chdir .. failed\n", s);
    2cd4:	85a6                	mv	a1,s1
    2cd6:	00004517          	auipc	a0,0x4
    2cda:	90250513          	addi	a0,a0,-1790 # 65d8 <malloc+0x1340>
    2cde:	502020ef          	jal	51e0 <printf>
    exit(1);
    2ce2:	4505                	li	a0,1
    2ce4:	0f2020ef          	jal	4dd6 <exit>
    printf("%s: unlink dir0 failed\n", s);
    2ce8:	85a6                	mv	a1,s1
    2cea:	00004517          	auipc	a0,0x4
    2cee:	90650513          	addi	a0,a0,-1786 # 65f0 <malloc+0x1358>
    2cf2:	4ee020ef          	jal	51e0 <printf>
    exit(1);
    2cf6:	4505                	li	a0,1
    2cf8:	0de020ef          	jal	4dd6 <exit>

0000000000002cfc <subdir>:
{
    2cfc:	1101                	addi	sp,sp,-32
    2cfe:	ec06                	sd	ra,24(sp)
    2d00:	e822                	sd	s0,16(sp)
    2d02:	e426                	sd	s1,8(sp)
    2d04:	e04a                	sd	s2,0(sp)
    2d06:	1000                	addi	s0,sp,32
    2d08:	892a                	mv	s2,a0
  unlink("ff");
    2d0a:	00004517          	auipc	a0,0x4
    2d0e:	a2e50513          	addi	a0,a0,-1490 # 6738 <malloc+0x14a0>
    2d12:	114020ef          	jal	4e26 <unlink>
  if(mkdir("dd") != 0){
    2d16:	00004517          	auipc	a0,0x4
    2d1a:	8f250513          	addi	a0,a0,-1806 # 6608 <malloc+0x1370>
    2d1e:	120020ef          	jal	4e3e <mkdir>
    2d22:	2e051263          	bnez	a0,3006 <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2d26:	20200593          	li	a1,514
    2d2a:	00004517          	auipc	a0,0x4
    2d2e:	8fe50513          	addi	a0,a0,-1794 # 6628 <malloc+0x1390>
    2d32:	0e4020ef          	jal	4e16 <open>
    2d36:	84aa                	mv	s1,a0
  if(fd < 0){
    2d38:	2e054163          	bltz	a0,301a <subdir+0x31e>
  write(fd, "ff", 2);
    2d3c:	4609                	li	a2,2
    2d3e:	00004597          	auipc	a1,0x4
    2d42:	9fa58593          	addi	a1,a1,-1542 # 6738 <malloc+0x14a0>
    2d46:	0b0020ef          	jal	4df6 <write>
  close(fd);
    2d4a:	8526                	mv	a0,s1
    2d4c:	0b2020ef          	jal	4dfe <close>
  if(unlink("dd") >= 0){
    2d50:	00004517          	auipc	a0,0x4
    2d54:	8b850513          	addi	a0,a0,-1864 # 6608 <malloc+0x1370>
    2d58:	0ce020ef          	jal	4e26 <unlink>
    2d5c:	2c055963          	bgez	a0,302e <subdir+0x332>
  if(mkdir("/dd/dd") != 0){
    2d60:	00004517          	auipc	a0,0x4
    2d64:	92050513          	addi	a0,a0,-1760 # 6680 <malloc+0x13e8>
    2d68:	0d6020ef          	jal	4e3e <mkdir>
    2d6c:	2c051b63          	bnez	a0,3042 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2d70:	20200593          	li	a1,514
    2d74:	00004517          	auipc	a0,0x4
    2d78:	93450513          	addi	a0,a0,-1740 # 66a8 <malloc+0x1410>
    2d7c:	09a020ef          	jal	4e16 <open>
    2d80:	84aa                	mv	s1,a0
  if(fd < 0){
    2d82:	2c054a63          	bltz	a0,3056 <subdir+0x35a>
  write(fd, "FF", 2);
    2d86:	4609                	li	a2,2
    2d88:	00004597          	auipc	a1,0x4
    2d8c:	95058593          	addi	a1,a1,-1712 # 66d8 <malloc+0x1440>
    2d90:	066020ef          	jal	4df6 <write>
  close(fd);
    2d94:	8526                	mv	a0,s1
    2d96:	068020ef          	jal	4dfe <close>
  fd = open("dd/dd/../ff", 0);
    2d9a:	4581                	li	a1,0
    2d9c:	00004517          	auipc	a0,0x4
    2da0:	94450513          	addi	a0,a0,-1724 # 66e0 <malloc+0x1448>
    2da4:	072020ef          	jal	4e16 <open>
    2da8:	84aa                	mv	s1,a0
  if(fd < 0){
    2daa:	2c054063          	bltz	a0,306a <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2dae:	660d                	lui	a2,0x3
    2db0:	0000a597          	auipc	a1,0xa
    2db4:	ec858593          	addi	a1,a1,-312 # cc78 <buf>
    2db8:	036020ef          	jal	4dee <read>
  if(cc != 2 || buf[0] != 'f'){
    2dbc:	4789                	li	a5,2
    2dbe:	2cf51063          	bne	a0,a5,307e <subdir+0x382>
    2dc2:	0000a717          	auipc	a4,0xa
    2dc6:	eb674703          	lbu	a4,-330(a4) # cc78 <buf>
    2dca:	06600793          	li	a5,102
    2dce:	2af71863          	bne	a4,a5,307e <subdir+0x382>
  close(fd);
    2dd2:	8526                	mv	a0,s1
    2dd4:	02a020ef          	jal	4dfe <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2dd8:	00004597          	auipc	a1,0x4
    2ddc:	95858593          	addi	a1,a1,-1704 # 6730 <malloc+0x1498>
    2de0:	00004517          	auipc	a0,0x4
    2de4:	8c850513          	addi	a0,a0,-1848 # 66a8 <malloc+0x1410>
    2de8:	04e020ef          	jal	4e36 <link>
    2dec:	2a051363          	bnez	a0,3092 <subdir+0x396>
  if(unlink("dd/dd/ff") != 0){
    2df0:	00004517          	auipc	a0,0x4
    2df4:	8b850513          	addi	a0,a0,-1864 # 66a8 <malloc+0x1410>
    2df8:	02e020ef          	jal	4e26 <unlink>
    2dfc:	2a051563          	bnez	a0,30a6 <subdir+0x3aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e00:	4581                	li	a1,0
    2e02:	00004517          	auipc	a0,0x4
    2e06:	8a650513          	addi	a0,a0,-1882 # 66a8 <malloc+0x1410>
    2e0a:	00c020ef          	jal	4e16 <open>
    2e0e:	2a055663          	bgez	a0,30ba <subdir+0x3be>
  if(chdir("dd") != 0){
    2e12:	00003517          	auipc	a0,0x3
    2e16:	7f650513          	addi	a0,a0,2038 # 6608 <malloc+0x1370>
    2e1a:	02c020ef          	jal	4e46 <chdir>
    2e1e:	2a051863          	bnez	a0,30ce <subdir+0x3d2>
  if(chdir("dd/../../dd") != 0){
    2e22:	00004517          	auipc	a0,0x4
    2e26:	9a650513          	addi	a0,a0,-1626 # 67c8 <malloc+0x1530>
    2e2a:	01c020ef          	jal	4e46 <chdir>
    2e2e:	2a051a63          	bnez	a0,30e2 <subdir+0x3e6>
  if(chdir("dd/../../../dd") != 0){
    2e32:	00004517          	auipc	a0,0x4
    2e36:	9c650513          	addi	a0,a0,-1594 # 67f8 <malloc+0x1560>
    2e3a:	00c020ef          	jal	4e46 <chdir>
    2e3e:	2a051c63          	bnez	a0,30f6 <subdir+0x3fa>
  if(chdir("./..") != 0){
    2e42:	00004517          	auipc	a0,0x4
    2e46:	9ee50513          	addi	a0,a0,-1554 # 6830 <malloc+0x1598>
    2e4a:	7fd010ef          	jal	4e46 <chdir>
    2e4e:	2a051e63          	bnez	a0,310a <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2e52:	4581                	li	a1,0
    2e54:	00004517          	auipc	a0,0x4
    2e58:	8dc50513          	addi	a0,a0,-1828 # 6730 <malloc+0x1498>
    2e5c:	7bb010ef          	jal	4e16 <open>
    2e60:	84aa                	mv	s1,a0
  if(fd < 0){
    2e62:	2a054e63          	bltz	a0,311e <subdir+0x422>
  if(read(fd, buf, sizeof(buf)) != 2){
    2e66:	660d                	lui	a2,0x3
    2e68:	0000a597          	auipc	a1,0xa
    2e6c:	e1058593          	addi	a1,a1,-496 # cc78 <buf>
    2e70:	77f010ef          	jal	4dee <read>
    2e74:	4789                	li	a5,2
    2e76:	2af51e63          	bne	a0,a5,3132 <subdir+0x436>
  close(fd);
    2e7a:	8526                	mv	a0,s1
    2e7c:	783010ef          	jal	4dfe <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e80:	4581                	li	a1,0
    2e82:	00004517          	auipc	a0,0x4
    2e86:	82650513          	addi	a0,a0,-2010 # 66a8 <malloc+0x1410>
    2e8a:	78d010ef          	jal	4e16 <open>
    2e8e:	2a055c63          	bgez	a0,3146 <subdir+0x44a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2e92:	20200593          	li	a1,514
    2e96:	00004517          	auipc	a0,0x4
    2e9a:	a2a50513          	addi	a0,a0,-1494 # 68c0 <malloc+0x1628>
    2e9e:	779010ef          	jal	4e16 <open>
    2ea2:	2a055c63          	bgez	a0,315a <subdir+0x45e>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2ea6:	20200593          	li	a1,514
    2eaa:	00004517          	auipc	a0,0x4
    2eae:	a4650513          	addi	a0,a0,-1466 # 68f0 <malloc+0x1658>
    2eb2:	765010ef          	jal	4e16 <open>
    2eb6:	2a055c63          	bgez	a0,316e <subdir+0x472>
  if(open("dd", O_CREATE) >= 0){
    2eba:	20000593          	li	a1,512
    2ebe:	00003517          	auipc	a0,0x3
    2ec2:	74a50513          	addi	a0,a0,1866 # 6608 <malloc+0x1370>
    2ec6:	751010ef          	jal	4e16 <open>
    2eca:	2a055c63          	bgez	a0,3182 <subdir+0x486>
  if(open("dd", O_RDWR) >= 0){
    2ece:	4589                	li	a1,2
    2ed0:	00003517          	auipc	a0,0x3
    2ed4:	73850513          	addi	a0,a0,1848 # 6608 <malloc+0x1370>
    2ed8:	73f010ef          	jal	4e16 <open>
    2edc:	2a055d63          	bgez	a0,3196 <subdir+0x49a>
  if(open("dd", O_WRONLY) >= 0){
    2ee0:	4585                	li	a1,1
    2ee2:	00003517          	auipc	a0,0x3
    2ee6:	72650513          	addi	a0,a0,1830 # 6608 <malloc+0x1370>
    2eea:	72d010ef          	jal	4e16 <open>
    2eee:	2a055e63          	bgez	a0,31aa <subdir+0x4ae>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2ef2:	00004597          	auipc	a1,0x4
    2ef6:	a8e58593          	addi	a1,a1,-1394 # 6980 <malloc+0x16e8>
    2efa:	00004517          	auipc	a0,0x4
    2efe:	9c650513          	addi	a0,a0,-1594 # 68c0 <malloc+0x1628>
    2f02:	735010ef          	jal	4e36 <link>
    2f06:	2a050c63          	beqz	a0,31be <subdir+0x4c2>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2f0a:	00004597          	auipc	a1,0x4
    2f0e:	a7658593          	addi	a1,a1,-1418 # 6980 <malloc+0x16e8>
    2f12:	00004517          	auipc	a0,0x4
    2f16:	9de50513          	addi	a0,a0,-1570 # 68f0 <malloc+0x1658>
    2f1a:	71d010ef          	jal	4e36 <link>
    2f1e:	2a050a63          	beqz	a0,31d2 <subdir+0x4d6>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2f22:	00004597          	auipc	a1,0x4
    2f26:	80e58593          	addi	a1,a1,-2034 # 6730 <malloc+0x1498>
    2f2a:	00003517          	auipc	a0,0x3
    2f2e:	6fe50513          	addi	a0,a0,1790 # 6628 <malloc+0x1390>
    2f32:	705010ef          	jal	4e36 <link>
    2f36:	2a050863          	beqz	a0,31e6 <subdir+0x4ea>
  if(mkdir("dd/ff/ff") == 0){
    2f3a:	00004517          	auipc	a0,0x4
    2f3e:	98650513          	addi	a0,a0,-1658 # 68c0 <malloc+0x1628>
    2f42:	6fd010ef          	jal	4e3e <mkdir>
    2f46:	2a050a63          	beqz	a0,31fa <subdir+0x4fe>
  if(mkdir("dd/xx/ff") == 0){
    2f4a:	00004517          	auipc	a0,0x4
    2f4e:	9a650513          	addi	a0,a0,-1626 # 68f0 <malloc+0x1658>
    2f52:	6ed010ef          	jal	4e3e <mkdir>
    2f56:	2a050c63          	beqz	a0,320e <subdir+0x512>
  if(mkdir("dd/dd/ffff") == 0){
    2f5a:	00003517          	auipc	a0,0x3
    2f5e:	7d650513          	addi	a0,a0,2006 # 6730 <malloc+0x1498>
    2f62:	6dd010ef          	jal	4e3e <mkdir>
    2f66:	2a050e63          	beqz	a0,3222 <subdir+0x526>
  if(unlink("dd/xx/ff") == 0){
    2f6a:	00004517          	auipc	a0,0x4
    2f6e:	98650513          	addi	a0,a0,-1658 # 68f0 <malloc+0x1658>
    2f72:	6b5010ef          	jal	4e26 <unlink>
    2f76:	2c050063          	beqz	a0,3236 <subdir+0x53a>
  if(unlink("dd/ff/ff") == 0){
    2f7a:	00004517          	auipc	a0,0x4
    2f7e:	94650513          	addi	a0,a0,-1722 # 68c0 <malloc+0x1628>
    2f82:	6a5010ef          	jal	4e26 <unlink>
    2f86:	2c050263          	beqz	a0,324a <subdir+0x54e>
  if(chdir("dd/ff") == 0){
    2f8a:	00003517          	auipc	a0,0x3
    2f8e:	69e50513          	addi	a0,a0,1694 # 6628 <malloc+0x1390>
    2f92:	6b5010ef          	jal	4e46 <chdir>
    2f96:	2c050463          	beqz	a0,325e <subdir+0x562>
  if(chdir("dd/xx") == 0){
    2f9a:	00004517          	auipc	a0,0x4
    2f9e:	b3650513          	addi	a0,a0,-1226 # 6ad0 <malloc+0x1838>
    2fa2:	6a5010ef          	jal	4e46 <chdir>
    2fa6:	2c050663          	beqz	a0,3272 <subdir+0x576>
  if(unlink("dd/dd/ffff") != 0){
    2faa:	00003517          	auipc	a0,0x3
    2fae:	78650513          	addi	a0,a0,1926 # 6730 <malloc+0x1498>
    2fb2:	675010ef          	jal	4e26 <unlink>
    2fb6:	2c051863          	bnez	a0,3286 <subdir+0x58a>
  if(unlink("dd/ff") != 0){
    2fba:	00003517          	auipc	a0,0x3
    2fbe:	66e50513          	addi	a0,a0,1646 # 6628 <malloc+0x1390>
    2fc2:	665010ef          	jal	4e26 <unlink>
    2fc6:	2c051a63          	bnez	a0,329a <subdir+0x59e>
  if(unlink("dd") == 0){
    2fca:	00003517          	auipc	a0,0x3
    2fce:	63e50513          	addi	a0,a0,1598 # 6608 <malloc+0x1370>
    2fd2:	655010ef          	jal	4e26 <unlink>
    2fd6:	2c050c63          	beqz	a0,32ae <subdir+0x5b2>
  if(unlink("dd/dd") < 0){
    2fda:	00004517          	auipc	a0,0x4
    2fde:	b6650513          	addi	a0,a0,-1178 # 6b40 <malloc+0x18a8>
    2fe2:	645010ef          	jal	4e26 <unlink>
    2fe6:	2c054e63          	bltz	a0,32c2 <subdir+0x5c6>
  if(unlink("dd") < 0){
    2fea:	00003517          	auipc	a0,0x3
    2fee:	61e50513          	addi	a0,a0,1566 # 6608 <malloc+0x1370>
    2ff2:	635010ef          	jal	4e26 <unlink>
    2ff6:	2e054063          	bltz	a0,32d6 <subdir+0x5da>
}
    2ffa:	60e2                	ld	ra,24(sp)
    2ffc:	6442                	ld	s0,16(sp)
    2ffe:	64a2                	ld	s1,8(sp)
    3000:	6902                	ld	s2,0(sp)
    3002:	6105                	addi	sp,sp,32
    3004:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3006:	85ca                	mv	a1,s2
    3008:	00003517          	auipc	a0,0x3
    300c:	60850513          	addi	a0,a0,1544 # 6610 <malloc+0x1378>
    3010:	1d0020ef          	jal	51e0 <printf>
    exit(1);
    3014:	4505                	li	a0,1
    3016:	5c1010ef          	jal	4dd6 <exit>
    printf("%s: create dd/ff failed\n", s);
    301a:	85ca                	mv	a1,s2
    301c:	00003517          	auipc	a0,0x3
    3020:	61450513          	addi	a0,a0,1556 # 6630 <malloc+0x1398>
    3024:	1bc020ef          	jal	51e0 <printf>
    exit(1);
    3028:	4505                	li	a0,1
    302a:	5ad010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    302e:	85ca                	mv	a1,s2
    3030:	00003517          	auipc	a0,0x3
    3034:	62050513          	addi	a0,a0,1568 # 6650 <malloc+0x13b8>
    3038:	1a8020ef          	jal	51e0 <printf>
    exit(1);
    303c:	4505                	li	a0,1
    303e:	599010ef          	jal	4dd6 <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    3042:	85ca                	mv	a1,s2
    3044:	00003517          	auipc	a0,0x3
    3048:	64450513          	addi	a0,a0,1604 # 6688 <malloc+0x13f0>
    304c:	194020ef          	jal	51e0 <printf>
    exit(1);
    3050:	4505                	li	a0,1
    3052:	585010ef          	jal	4dd6 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3056:	85ca                	mv	a1,s2
    3058:	00003517          	auipc	a0,0x3
    305c:	66050513          	addi	a0,a0,1632 # 66b8 <malloc+0x1420>
    3060:	180020ef          	jal	51e0 <printf>
    exit(1);
    3064:	4505                	li	a0,1
    3066:	571010ef          	jal	4dd6 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    306a:	85ca                	mv	a1,s2
    306c:	00003517          	auipc	a0,0x3
    3070:	68450513          	addi	a0,a0,1668 # 66f0 <malloc+0x1458>
    3074:	16c020ef          	jal	51e0 <printf>
    exit(1);
    3078:	4505                	li	a0,1
    307a:	55d010ef          	jal	4dd6 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    307e:	85ca                	mv	a1,s2
    3080:	00003517          	auipc	a0,0x3
    3084:	69050513          	addi	a0,a0,1680 # 6710 <malloc+0x1478>
    3088:	158020ef          	jal	51e0 <printf>
    exit(1);
    308c:	4505                	li	a0,1
    308e:	549010ef          	jal	4dd6 <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    3092:	85ca                	mv	a1,s2
    3094:	00003517          	auipc	a0,0x3
    3098:	6ac50513          	addi	a0,a0,1708 # 6740 <malloc+0x14a8>
    309c:	144020ef          	jal	51e0 <printf>
    exit(1);
    30a0:	4505                	li	a0,1
    30a2:	535010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    30a6:	85ca                	mv	a1,s2
    30a8:	00003517          	auipc	a0,0x3
    30ac:	6c050513          	addi	a0,a0,1728 # 6768 <malloc+0x14d0>
    30b0:	130020ef          	jal	51e0 <printf>
    exit(1);
    30b4:	4505                	li	a0,1
    30b6:	521010ef          	jal	4dd6 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    30ba:	85ca                	mv	a1,s2
    30bc:	00003517          	auipc	a0,0x3
    30c0:	6cc50513          	addi	a0,a0,1740 # 6788 <malloc+0x14f0>
    30c4:	11c020ef          	jal	51e0 <printf>
    exit(1);
    30c8:	4505                	li	a0,1
    30ca:	50d010ef          	jal	4dd6 <exit>
    printf("%s: chdir dd failed\n", s);
    30ce:	85ca                	mv	a1,s2
    30d0:	00003517          	auipc	a0,0x3
    30d4:	6e050513          	addi	a0,a0,1760 # 67b0 <malloc+0x1518>
    30d8:	108020ef          	jal	51e0 <printf>
    exit(1);
    30dc:	4505                	li	a0,1
    30de:	4f9010ef          	jal	4dd6 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    30e2:	85ca                	mv	a1,s2
    30e4:	00003517          	auipc	a0,0x3
    30e8:	6f450513          	addi	a0,a0,1780 # 67d8 <malloc+0x1540>
    30ec:	0f4020ef          	jal	51e0 <printf>
    exit(1);
    30f0:	4505                	li	a0,1
    30f2:	4e5010ef          	jal	4dd6 <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    30f6:	85ca                	mv	a1,s2
    30f8:	00003517          	auipc	a0,0x3
    30fc:	71050513          	addi	a0,a0,1808 # 6808 <malloc+0x1570>
    3100:	0e0020ef          	jal	51e0 <printf>
    exit(1);
    3104:	4505                	li	a0,1
    3106:	4d1010ef          	jal	4dd6 <exit>
    printf("%s: chdir ./.. failed\n", s);
    310a:	85ca                	mv	a1,s2
    310c:	00003517          	auipc	a0,0x3
    3110:	72c50513          	addi	a0,a0,1836 # 6838 <malloc+0x15a0>
    3114:	0cc020ef          	jal	51e0 <printf>
    exit(1);
    3118:	4505                	li	a0,1
    311a:	4bd010ef          	jal	4dd6 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    311e:	85ca                	mv	a1,s2
    3120:	00003517          	auipc	a0,0x3
    3124:	73050513          	addi	a0,a0,1840 # 6850 <malloc+0x15b8>
    3128:	0b8020ef          	jal	51e0 <printf>
    exit(1);
    312c:	4505                	li	a0,1
    312e:	4a9010ef          	jal	4dd6 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3132:	85ca                	mv	a1,s2
    3134:	00003517          	auipc	a0,0x3
    3138:	73c50513          	addi	a0,a0,1852 # 6870 <malloc+0x15d8>
    313c:	0a4020ef          	jal	51e0 <printf>
    exit(1);
    3140:	4505                	li	a0,1
    3142:	495010ef          	jal	4dd6 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3146:	85ca                	mv	a1,s2
    3148:	00003517          	auipc	a0,0x3
    314c:	74850513          	addi	a0,a0,1864 # 6890 <malloc+0x15f8>
    3150:	090020ef          	jal	51e0 <printf>
    exit(1);
    3154:	4505                	li	a0,1
    3156:	481010ef          	jal	4dd6 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    315a:	85ca                	mv	a1,s2
    315c:	00003517          	auipc	a0,0x3
    3160:	77450513          	addi	a0,a0,1908 # 68d0 <malloc+0x1638>
    3164:	07c020ef          	jal	51e0 <printf>
    exit(1);
    3168:	4505                	li	a0,1
    316a:	46d010ef          	jal	4dd6 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    316e:	85ca                	mv	a1,s2
    3170:	00003517          	auipc	a0,0x3
    3174:	79050513          	addi	a0,a0,1936 # 6900 <malloc+0x1668>
    3178:	068020ef          	jal	51e0 <printf>
    exit(1);
    317c:	4505                	li	a0,1
    317e:	459010ef          	jal	4dd6 <exit>
    printf("%s: create dd succeeded!\n", s);
    3182:	85ca                	mv	a1,s2
    3184:	00003517          	auipc	a0,0x3
    3188:	79c50513          	addi	a0,a0,1948 # 6920 <malloc+0x1688>
    318c:	054020ef          	jal	51e0 <printf>
    exit(1);
    3190:	4505                	li	a0,1
    3192:	445010ef          	jal	4dd6 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3196:	85ca                	mv	a1,s2
    3198:	00003517          	auipc	a0,0x3
    319c:	7a850513          	addi	a0,a0,1960 # 6940 <malloc+0x16a8>
    31a0:	040020ef          	jal	51e0 <printf>
    exit(1);
    31a4:	4505                	li	a0,1
    31a6:	431010ef          	jal	4dd6 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    31aa:	85ca                	mv	a1,s2
    31ac:	00003517          	auipc	a0,0x3
    31b0:	7b450513          	addi	a0,a0,1972 # 6960 <malloc+0x16c8>
    31b4:	02c020ef          	jal	51e0 <printf>
    exit(1);
    31b8:	4505                	li	a0,1
    31ba:	41d010ef          	jal	4dd6 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    31be:	85ca                	mv	a1,s2
    31c0:	00003517          	auipc	a0,0x3
    31c4:	7d050513          	addi	a0,a0,2000 # 6990 <malloc+0x16f8>
    31c8:	018020ef          	jal	51e0 <printf>
    exit(1);
    31cc:	4505                	li	a0,1
    31ce:	409010ef          	jal	4dd6 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    31d2:	85ca                	mv	a1,s2
    31d4:	00003517          	auipc	a0,0x3
    31d8:	7e450513          	addi	a0,a0,2020 # 69b8 <malloc+0x1720>
    31dc:	004020ef          	jal	51e0 <printf>
    exit(1);
    31e0:	4505                	li	a0,1
    31e2:	3f5010ef          	jal	4dd6 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    31e6:	85ca                	mv	a1,s2
    31e8:	00003517          	auipc	a0,0x3
    31ec:	7f850513          	addi	a0,a0,2040 # 69e0 <malloc+0x1748>
    31f0:	7f1010ef          	jal	51e0 <printf>
    exit(1);
    31f4:	4505                	li	a0,1
    31f6:	3e1010ef          	jal	4dd6 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    31fa:	85ca                	mv	a1,s2
    31fc:	00004517          	auipc	a0,0x4
    3200:	80c50513          	addi	a0,a0,-2036 # 6a08 <malloc+0x1770>
    3204:	7dd010ef          	jal	51e0 <printf>
    exit(1);
    3208:	4505                	li	a0,1
    320a:	3cd010ef          	jal	4dd6 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    320e:	85ca                	mv	a1,s2
    3210:	00004517          	auipc	a0,0x4
    3214:	81850513          	addi	a0,a0,-2024 # 6a28 <malloc+0x1790>
    3218:	7c9010ef          	jal	51e0 <printf>
    exit(1);
    321c:	4505                	li	a0,1
    321e:	3b9010ef          	jal	4dd6 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3222:	85ca                	mv	a1,s2
    3224:	00004517          	auipc	a0,0x4
    3228:	82450513          	addi	a0,a0,-2012 # 6a48 <malloc+0x17b0>
    322c:	7b5010ef          	jal	51e0 <printf>
    exit(1);
    3230:	4505                	li	a0,1
    3232:	3a5010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3236:	85ca                	mv	a1,s2
    3238:	00004517          	auipc	a0,0x4
    323c:	83850513          	addi	a0,a0,-1992 # 6a70 <malloc+0x17d8>
    3240:	7a1010ef          	jal	51e0 <printf>
    exit(1);
    3244:	4505                	li	a0,1
    3246:	391010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    324a:	85ca                	mv	a1,s2
    324c:	00004517          	auipc	a0,0x4
    3250:	84450513          	addi	a0,a0,-1980 # 6a90 <malloc+0x17f8>
    3254:	78d010ef          	jal	51e0 <printf>
    exit(1);
    3258:	4505                	li	a0,1
    325a:	37d010ef          	jal	4dd6 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    325e:	85ca                	mv	a1,s2
    3260:	00004517          	auipc	a0,0x4
    3264:	85050513          	addi	a0,a0,-1968 # 6ab0 <malloc+0x1818>
    3268:	779010ef          	jal	51e0 <printf>
    exit(1);
    326c:	4505                	li	a0,1
    326e:	369010ef          	jal	4dd6 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3272:	85ca                	mv	a1,s2
    3274:	00004517          	auipc	a0,0x4
    3278:	86450513          	addi	a0,a0,-1948 # 6ad8 <malloc+0x1840>
    327c:	765010ef          	jal	51e0 <printf>
    exit(1);
    3280:	4505                	li	a0,1
    3282:	355010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3286:	85ca                	mv	a1,s2
    3288:	00003517          	auipc	a0,0x3
    328c:	4e050513          	addi	a0,a0,1248 # 6768 <malloc+0x14d0>
    3290:	751010ef          	jal	51e0 <printf>
    exit(1);
    3294:	4505                	li	a0,1
    3296:	341010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    329a:	85ca                	mv	a1,s2
    329c:	00004517          	auipc	a0,0x4
    32a0:	85c50513          	addi	a0,a0,-1956 # 6af8 <malloc+0x1860>
    32a4:	73d010ef          	jal	51e0 <printf>
    exit(1);
    32a8:	4505                	li	a0,1
    32aa:	32d010ef          	jal	4dd6 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    32ae:	85ca                	mv	a1,s2
    32b0:	00004517          	auipc	a0,0x4
    32b4:	86850513          	addi	a0,a0,-1944 # 6b18 <malloc+0x1880>
    32b8:	729010ef          	jal	51e0 <printf>
    exit(1);
    32bc:	4505                	li	a0,1
    32be:	319010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    32c2:	85ca                	mv	a1,s2
    32c4:	00004517          	auipc	a0,0x4
    32c8:	88450513          	addi	a0,a0,-1916 # 6b48 <malloc+0x18b0>
    32cc:	715010ef          	jal	51e0 <printf>
    exit(1);
    32d0:	4505                	li	a0,1
    32d2:	305010ef          	jal	4dd6 <exit>
    printf("%s: unlink dd failed\n", s);
    32d6:	85ca                	mv	a1,s2
    32d8:	00004517          	auipc	a0,0x4
    32dc:	89050513          	addi	a0,a0,-1904 # 6b68 <malloc+0x18d0>
    32e0:	701010ef          	jal	51e0 <printf>
    exit(1);
    32e4:	4505                	li	a0,1
    32e6:	2f1010ef          	jal	4dd6 <exit>

00000000000032ea <rmdot>:
{
    32ea:	1101                	addi	sp,sp,-32
    32ec:	ec06                	sd	ra,24(sp)
    32ee:	e822                	sd	s0,16(sp)
    32f0:	e426                	sd	s1,8(sp)
    32f2:	1000                	addi	s0,sp,32
    32f4:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    32f6:	00004517          	auipc	a0,0x4
    32fa:	88a50513          	addi	a0,a0,-1910 # 6b80 <malloc+0x18e8>
    32fe:	341010ef          	jal	4e3e <mkdir>
    3302:	e53d                	bnez	a0,3370 <rmdot+0x86>
  if(chdir("dots") != 0){
    3304:	00004517          	auipc	a0,0x4
    3308:	87c50513          	addi	a0,a0,-1924 # 6b80 <malloc+0x18e8>
    330c:	33b010ef          	jal	4e46 <chdir>
    3310:	e935                	bnez	a0,3384 <rmdot+0x9a>
  if(unlink(".") == 0){
    3312:	00002517          	auipc	a0,0x2
    3316:	79e50513          	addi	a0,a0,1950 # 5ab0 <malloc+0x818>
    331a:	30d010ef          	jal	4e26 <unlink>
    331e:	cd2d                	beqz	a0,3398 <rmdot+0xae>
  if(unlink("..") == 0){
    3320:	00003517          	auipc	a0,0x3
    3324:	2b050513          	addi	a0,a0,688 # 65d0 <malloc+0x1338>
    3328:	2ff010ef          	jal	4e26 <unlink>
    332c:	c141                	beqz	a0,33ac <rmdot+0xc2>
  if(chdir("/") != 0){
    332e:	00003517          	auipc	a0,0x3
    3332:	24a50513          	addi	a0,a0,586 # 6578 <malloc+0x12e0>
    3336:	311010ef          	jal	4e46 <chdir>
    333a:	e159                	bnez	a0,33c0 <rmdot+0xd6>
  if(unlink("dots/.") == 0){
    333c:	00004517          	auipc	a0,0x4
    3340:	8ac50513          	addi	a0,a0,-1876 # 6be8 <malloc+0x1950>
    3344:	2e3010ef          	jal	4e26 <unlink>
    3348:	c551                	beqz	a0,33d4 <rmdot+0xea>
  if(unlink("dots/..") == 0){
    334a:	00004517          	auipc	a0,0x4
    334e:	8c650513          	addi	a0,a0,-1850 # 6c10 <malloc+0x1978>
    3352:	2d5010ef          	jal	4e26 <unlink>
    3356:	c949                	beqz	a0,33e8 <rmdot+0xfe>
  if(unlink("dots") != 0){
    3358:	00004517          	auipc	a0,0x4
    335c:	82850513          	addi	a0,a0,-2008 # 6b80 <malloc+0x18e8>
    3360:	2c7010ef          	jal	4e26 <unlink>
    3364:	ed41                	bnez	a0,33fc <rmdot+0x112>
}
    3366:	60e2                	ld	ra,24(sp)
    3368:	6442                	ld	s0,16(sp)
    336a:	64a2                	ld	s1,8(sp)
    336c:	6105                	addi	sp,sp,32
    336e:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3370:	85a6                	mv	a1,s1
    3372:	00004517          	auipc	a0,0x4
    3376:	81650513          	addi	a0,a0,-2026 # 6b88 <malloc+0x18f0>
    337a:	667010ef          	jal	51e0 <printf>
    exit(1);
    337e:	4505                	li	a0,1
    3380:	257010ef          	jal	4dd6 <exit>
    printf("%s: chdir dots failed\n", s);
    3384:	85a6                	mv	a1,s1
    3386:	00004517          	auipc	a0,0x4
    338a:	81a50513          	addi	a0,a0,-2022 # 6ba0 <malloc+0x1908>
    338e:	653010ef          	jal	51e0 <printf>
    exit(1);
    3392:	4505                	li	a0,1
    3394:	243010ef          	jal	4dd6 <exit>
    printf("%s: rm . worked!\n", s);
    3398:	85a6                	mv	a1,s1
    339a:	00004517          	auipc	a0,0x4
    339e:	81e50513          	addi	a0,a0,-2018 # 6bb8 <malloc+0x1920>
    33a2:	63f010ef          	jal	51e0 <printf>
    exit(1);
    33a6:	4505                	li	a0,1
    33a8:	22f010ef          	jal	4dd6 <exit>
    printf("%s: rm .. worked!\n", s);
    33ac:	85a6                	mv	a1,s1
    33ae:	00004517          	auipc	a0,0x4
    33b2:	82250513          	addi	a0,a0,-2014 # 6bd0 <malloc+0x1938>
    33b6:	62b010ef          	jal	51e0 <printf>
    exit(1);
    33ba:	4505                	li	a0,1
    33bc:	21b010ef          	jal	4dd6 <exit>
    printf("%s: chdir / failed\n", s);
    33c0:	85a6                	mv	a1,s1
    33c2:	00003517          	auipc	a0,0x3
    33c6:	1be50513          	addi	a0,a0,446 # 6580 <malloc+0x12e8>
    33ca:	617010ef          	jal	51e0 <printf>
    exit(1);
    33ce:	4505                	li	a0,1
    33d0:	207010ef          	jal	4dd6 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    33d4:	85a6                	mv	a1,s1
    33d6:	00004517          	auipc	a0,0x4
    33da:	81a50513          	addi	a0,a0,-2022 # 6bf0 <malloc+0x1958>
    33de:	603010ef          	jal	51e0 <printf>
    exit(1);
    33e2:	4505                	li	a0,1
    33e4:	1f3010ef          	jal	4dd6 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    33e8:	85a6                	mv	a1,s1
    33ea:	00004517          	auipc	a0,0x4
    33ee:	82e50513          	addi	a0,a0,-2002 # 6c18 <malloc+0x1980>
    33f2:	5ef010ef          	jal	51e0 <printf>
    exit(1);
    33f6:	4505                	li	a0,1
    33f8:	1df010ef          	jal	4dd6 <exit>
    printf("%s: unlink dots failed!\n", s);
    33fc:	85a6                	mv	a1,s1
    33fe:	00004517          	auipc	a0,0x4
    3402:	83a50513          	addi	a0,a0,-1990 # 6c38 <malloc+0x19a0>
    3406:	5db010ef          	jal	51e0 <printf>
    exit(1);
    340a:	4505                	li	a0,1
    340c:	1cb010ef          	jal	4dd6 <exit>

0000000000003410 <dirfile>:
{
    3410:	1101                	addi	sp,sp,-32
    3412:	ec06                	sd	ra,24(sp)
    3414:	e822                	sd	s0,16(sp)
    3416:	e426                	sd	s1,8(sp)
    3418:	e04a                	sd	s2,0(sp)
    341a:	1000                	addi	s0,sp,32
    341c:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    341e:	20000593          	li	a1,512
    3422:	00004517          	auipc	a0,0x4
    3426:	83650513          	addi	a0,a0,-1994 # 6c58 <malloc+0x19c0>
    342a:	1ed010ef          	jal	4e16 <open>
  if(fd < 0){
    342e:	0c054563          	bltz	a0,34f8 <dirfile+0xe8>
  close(fd);
    3432:	1cd010ef          	jal	4dfe <close>
  if(chdir("dirfile") == 0){
    3436:	00004517          	auipc	a0,0x4
    343a:	82250513          	addi	a0,a0,-2014 # 6c58 <malloc+0x19c0>
    343e:	209010ef          	jal	4e46 <chdir>
    3442:	c569                	beqz	a0,350c <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    3444:	4581                	li	a1,0
    3446:	00004517          	auipc	a0,0x4
    344a:	85a50513          	addi	a0,a0,-1958 # 6ca0 <malloc+0x1a08>
    344e:	1c9010ef          	jal	4e16 <open>
  if(fd >= 0){
    3452:	0c055763          	bgez	a0,3520 <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    3456:	20000593          	li	a1,512
    345a:	00004517          	auipc	a0,0x4
    345e:	84650513          	addi	a0,a0,-1978 # 6ca0 <malloc+0x1a08>
    3462:	1b5010ef          	jal	4e16 <open>
  if(fd >= 0){
    3466:	0c055763          	bgez	a0,3534 <dirfile+0x124>
  if(mkdir("dirfile/xx") == 0){
    346a:	00004517          	auipc	a0,0x4
    346e:	83650513          	addi	a0,a0,-1994 # 6ca0 <malloc+0x1a08>
    3472:	1cd010ef          	jal	4e3e <mkdir>
    3476:	0c050963          	beqz	a0,3548 <dirfile+0x138>
  if(unlink("dirfile/xx") == 0){
    347a:	00004517          	auipc	a0,0x4
    347e:	82650513          	addi	a0,a0,-2010 # 6ca0 <malloc+0x1a08>
    3482:	1a5010ef          	jal	4e26 <unlink>
    3486:	0c050b63          	beqz	a0,355c <dirfile+0x14c>
  if(link("README", "dirfile/xx") == 0){
    348a:	00004597          	auipc	a1,0x4
    348e:	81658593          	addi	a1,a1,-2026 # 6ca0 <malloc+0x1a08>
    3492:	00002517          	auipc	a0,0x2
    3496:	10e50513          	addi	a0,a0,270 # 55a0 <malloc+0x308>
    349a:	19d010ef          	jal	4e36 <link>
    349e:	0c050963          	beqz	a0,3570 <dirfile+0x160>
  if(unlink("dirfile") != 0){
    34a2:	00003517          	auipc	a0,0x3
    34a6:	7b650513          	addi	a0,a0,1974 # 6c58 <malloc+0x19c0>
    34aa:	17d010ef          	jal	4e26 <unlink>
    34ae:	0c051b63          	bnez	a0,3584 <dirfile+0x174>
  fd = open(".", O_RDWR);
    34b2:	4589                	li	a1,2
    34b4:	00002517          	auipc	a0,0x2
    34b8:	5fc50513          	addi	a0,a0,1532 # 5ab0 <malloc+0x818>
    34bc:	15b010ef          	jal	4e16 <open>
  if(fd >= 0){
    34c0:	0c055c63          	bgez	a0,3598 <dirfile+0x188>
  fd = open(".", 0);
    34c4:	4581                	li	a1,0
    34c6:	00002517          	auipc	a0,0x2
    34ca:	5ea50513          	addi	a0,a0,1514 # 5ab0 <malloc+0x818>
    34ce:	149010ef          	jal	4e16 <open>
    34d2:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    34d4:	4605                	li	a2,1
    34d6:	00002597          	auipc	a1,0x2
    34da:	f6258593          	addi	a1,a1,-158 # 5438 <malloc+0x1a0>
    34de:	119010ef          	jal	4df6 <write>
    34e2:	0ca04563          	bgtz	a0,35ac <dirfile+0x19c>
  close(fd);
    34e6:	8526                	mv	a0,s1
    34e8:	117010ef          	jal	4dfe <close>
}
    34ec:	60e2                	ld	ra,24(sp)
    34ee:	6442                	ld	s0,16(sp)
    34f0:	64a2                	ld	s1,8(sp)
    34f2:	6902                	ld	s2,0(sp)
    34f4:	6105                	addi	sp,sp,32
    34f6:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    34f8:	85ca                	mv	a1,s2
    34fa:	00003517          	auipc	a0,0x3
    34fe:	76650513          	addi	a0,a0,1894 # 6c60 <malloc+0x19c8>
    3502:	4df010ef          	jal	51e0 <printf>
    exit(1);
    3506:	4505                	li	a0,1
    3508:	0cf010ef          	jal	4dd6 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    350c:	85ca                	mv	a1,s2
    350e:	00003517          	auipc	a0,0x3
    3512:	77250513          	addi	a0,a0,1906 # 6c80 <malloc+0x19e8>
    3516:	4cb010ef          	jal	51e0 <printf>
    exit(1);
    351a:	4505                	li	a0,1
    351c:	0bb010ef          	jal	4dd6 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3520:	85ca                	mv	a1,s2
    3522:	00003517          	auipc	a0,0x3
    3526:	78e50513          	addi	a0,a0,1934 # 6cb0 <malloc+0x1a18>
    352a:	4b7010ef          	jal	51e0 <printf>
    exit(1);
    352e:	4505                	li	a0,1
    3530:	0a7010ef          	jal	4dd6 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3534:	85ca                	mv	a1,s2
    3536:	00003517          	auipc	a0,0x3
    353a:	77a50513          	addi	a0,a0,1914 # 6cb0 <malloc+0x1a18>
    353e:	4a3010ef          	jal	51e0 <printf>
    exit(1);
    3542:	4505                	li	a0,1
    3544:	093010ef          	jal	4dd6 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3548:	85ca                	mv	a1,s2
    354a:	00003517          	auipc	a0,0x3
    354e:	78e50513          	addi	a0,a0,1934 # 6cd8 <malloc+0x1a40>
    3552:	48f010ef          	jal	51e0 <printf>
    exit(1);
    3556:	4505                	li	a0,1
    3558:	07f010ef          	jal	4dd6 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    355c:	85ca                	mv	a1,s2
    355e:	00003517          	auipc	a0,0x3
    3562:	7a250513          	addi	a0,a0,1954 # 6d00 <malloc+0x1a68>
    3566:	47b010ef          	jal	51e0 <printf>
    exit(1);
    356a:	4505                	li	a0,1
    356c:	06b010ef          	jal	4dd6 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3570:	85ca                	mv	a1,s2
    3572:	00003517          	auipc	a0,0x3
    3576:	7b650513          	addi	a0,a0,1974 # 6d28 <malloc+0x1a90>
    357a:	467010ef          	jal	51e0 <printf>
    exit(1);
    357e:	4505                	li	a0,1
    3580:	057010ef          	jal	4dd6 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3584:	85ca                	mv	a1,s2
    3586:	00003517          	auipc	a0,0x3
    358a:	7ca50513          	addi	a0,a0,1994 # 6d50 <malloc+0x1ab8>
    358e:	453010ef          	jal	51e0 <printf>
    exit(1);
    3592:	4505                	li	a0,1
    3594:	043010ef          	jal	4dd6 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3598:	85ca                	mv	a1,s2
    359a:	00003517          	auipc	a0,0x3
    359e:	7d650513          	addi	a0,a0,2006 # 6d70 <malloc+0x1ad8>
    35a2:	43f010ef          	jal	51e0 <printf>
    exit(1);
    35a6:	4505                	li	a0,1
    35a8:	02f010ef          	jal	4dd6 <exit>
    printf("%s: write . succeeded!\n", s);
    35ac:	85ca                	mv	a1,s2
    35ae:	00003517          	auipc	a0,0x3
    35b2:	7ea50513          	addi	a0,a0,2026 # 6d98 <malloc+0x1b00>
    35b6:	42b010ef          	jal	51e0 <printf>
    exit(1);
    35ba:	4505                	li	a0,1
    35bc:	01b010ef          	jal	4dd6 <exit>

00000000000035c0 <iref>:
{
    35c0:	715d                	addi	sp,sp,-80
    35c2:	e486                	sd	ra,72(sp)
    35c4:	e0a2                	sd	s0,64(sp)
    35c6:	fc26                	sd	s1,56(sp)
    35c8:	f84a                	sd	s2,48(sp)
    35ca:	f44e                	sd	s3,40(sp)
    35cc:	f052                	sd	s4,32(sp)
    35ce:	ec56                	sd	s5,24(sp)
    35d0:	e85a                	sd	s6,16(sp)
    35d2:	e45e                	sd	s7,8(sp)
    35d4:	0880                	addi	s0,sp,80
    35d6:	8baa                	mv	s7,a0
    35d8:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    35dc:	00003a97          	auipc	s5,0x3
    35e0:	7d4a8a93          	addi	s5,s5,2004 # 6db0 <malloc+0x1b18>
    mkdir("");
    35e4:	00003497          	auipc	s1,0x3
    35e8:	2d448493          	addi	s1,s1,724 # 68b8 <malloc+0x1620>
    link("README", "");
    35ec:	00002b17          	auipc	s6,0x2
    35f0:	fb4b0b13          	addi	s6,s6,-76 # 55a0 <malloc+0x308>
    fd = open("", O_CREATE);
    35f4:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    35f8:	00003997          	auipc	s3,0x3
    35fc:	6b098993          	addi	s3,s3,1712 # 6ca8 <malloc+0x1a10>
    3600:	a835                	j	363c <iref+0x7c>
      printf("%s: mkdir irefd failed\n", s);
    3602:	85de                	mv	a1,s7
    3604:	00003517          	auipc	a0,0x3
    3608:	7b450513          	addi	a0,a0,1972 # 6db8 <malloc+0x1b20>
    360c:	3d5010ef          	jal	51e0 <printf>
      exit(1);
    3610:	4505                	li	a0,1
    3612:	7c4010ef          	jal	4dd6 <exit>
      printf("%s: chdir irefd failed\n", s);
    3616:	85de                	mv	a1,s7
    3618:	00003517          	auipc	a0,0x3
    361c:	7b850513          	addi	a0,a0,1976 # 6dd0 <malloc+0x1b38>
    3620:	3c1010ef          	jal	51e0 <printf>
      exit(1);
    3624:	4505                	li	a0,1
    3626:	7b0010ef          	jal	4dd6 <exit>
      close(fd);
    362a:	7d4010ef          	jal	4dfe <close>
    362e:	a825                	j	3666 <iref+0xa6>
    unlink("xx");
    3630:	854e                	mv	a0,s3
    3632:	7f4010ef          	jal	4e26 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3636:	397d                	addiw	s2,s2,-1
    3638:	04090063          	beqz	s2,3678 <iref+0xb8>
    if(mkdir("irefd") != 0){
    363c:	8556                	mv	a0,s5
    363e:	001010ef          	jal	4e3e <mkdir>
    3642:	f161                	bnez	a0,3602 <iref+0x42>
    if(chdir("irefd") != 0){
    3644:	8556                	mv	a0,s5
    3646:	001010ef          	jal	4e46 <chdir>
    364a:	f571                	bnez	a0,3616 <iref+0x56>
    mkdir("");
    364c:	8526                	mv	a0,s1
    364e:	7f0010ef          	jal	4e3e <mkdir>
    link("README", "");
    3652:	85a6                	mv	a1,s1
    3654:	855a                	mv	a0,s6
    3656:	7e0010ef          	jal	4e36 <link>
    fd = open("", O_CREATE);
    365a:	85d2                	mv	a1,s4
    365c:	8526                	mv	a0,s1
    365e:	7b8010ef          	jal	4e16 <open>
    if(fd >= 0)
    3662:	fc0554e3          	bgez	a0,362a <iref+0x6a>
    fd = open("xx", O_CREATE);
    3666:	85d2                	mv	a1,s4
    3668:	854e                	mv	a0,s3
    366a:	7ac010ef          	jal	4e16 <open>
    if(fd >= 0)
    366e:	fc0541e3          	bltz	a0,3630 <iref+0x70>
      close(fd);
    3672:	78c010ef          	jal	4dfe <close>
    3676:	bf6d                	j	3630 <iref+0x70>
    3678:	03300493          	li	s1,51
    chdir("..");
    367c:	00003997          	auipc	s3,0x3
    3680:	f5498993          	addi	s3,s3,-172 # 65d0 <malloc+0x1338>
    unlink("irefd");
    3684:	00003917          	auipc	s2,0x3
    3688:	72c90913          	addi	s2,s2,1836 # 6db0 <malloc+0x1b18>
    chdir("..");
    368c:	854e                	mv	a0,s3
    368e:	7b8010ef          	jal	4e46 <chdir>
    unlink("irefd");
    3692:	854a                	mv	a0,s2
    3694:	792010ef          	jal	4e26 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3698:	34fd                	addiw	s1,s1,-1
    369a:	f8ed                	bnez	s1,368c <iref+0xcc>
  chdir("/");
    369c:	00003517          	auipc	a0,0x3
    36a0:	edc50513          	addi	a0,a0,-292 # 6578 <malloc+0x12e0>
    36a4:	7a2010ef          	jal	4e46 <chdir>
}
    36a8:	60a6                	ld	ra,72(sp)
    36aa:	6406                	ld	s0,64(sp)
    36ac:	74e2                	ld	s1,56(sp)
    36ae:	7942                	ld	s2,48(sp)
    36b0:	79a2                	ld	s3,40(sp)
    36b2:	7a02                	ld	s4,32(sp)
    36b4:	6ae2                	ld	s5,24(sp)
    36b6:	6b42                	ld	s6,16(sp)
    36b8:	6ba2                	ld	s7,8(sp)
    36ba:	6161                	addi	sp,sp,80
    36bc:	8082                	ret

00000000000036be <openiputtest>:
{
    36be:	7179                	addi	sp,sp,-48
    36c0:	f406                	sd	ra,40(sp)
    36c2:	f022                	sd	s0,32(sp)
    36c4:	ec26                	sd	s1,24(sp)
    36c6:	1800                	addi	s0,sp,48
    36c8:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    36ca:	00003517          	auipc	a0,0x3
    36ce:	71e50513          	addi	a0,a0,1822 # 6de8 <malloc+0x1b50>
    36d2:	76c010ef          	jal	4e3e <mkdir>
    36d6:	02054a63          	bltz	a0,370a <openiputtest+0x4c>
  pid = fork();
    36da:	6f4010ef          	jal	4dce <fork>
  if(pid < 0){
    36de:	04054063          	bltz	a0,371e <openiputtest+0x60>
  if(pid == 0){
    36e2:	e939                	bnez	a0,3738 <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    36e4:	4589                	li	a1,2
    36e6:	00003517          	auipc	a0,0x3
    36ea:	70250513          	addi	a0,a0,1794 # 6de8 <malloc+0x1b50>
    36ee:	728010ef          	jal	4e16 <open>
    if(fd >= 0){
    36f2:	04054063          	bltz	a0,3732 <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    36f6:	85a6                	mv	a1,s1
    36f8:	00003517          	auipc	a0,0x3
    36fc:	71050513          	addi	a0,a0,1808 # 6e08 <malloc+0x1b70>
    3700:	2e1010ef          	jal	51e0 <printf>
      exit(1);
    3704:	4505                	li	a0,1
    3706:	6d0010ef          	jal	4dd6 <exit>
    printf("%s: mkdir oidir failed\n", s);
    370a:	85a6                	mv	a1,s1
    370c:	00003517          	auipc	a0,0x3
    3710:	6e450513          	addi	a0,a0,1764 # 6df0 <malloc+0x1b58>
    3714:	2cd010ef          	jal	51e0 <printf>
    exit(1);
    3718:	4505                	li	a0,1
    371a:	6bc010ef          	jal	4dd6 <exit>
    printf("%s: fork failed\n", s);
    371e:	85a6                	mv	a1,s1
    3720:	00002517          	auipc	a0,0x2
    3724:	53850513          	addi	a0,a0,1336 # 5c58 <malloc+0x9c0>
    3728:	2b9010ef          	jal	51e0 <printf>
    exit(1);
    372c:	4505                	li	a0,1
    372e:	6a8010ef          	jal	4dd6 <exit>
    exit(0);
    3732:	4501                	li	a0,0
    3734:	6a2010ef          	jal	4dd6 <exit>
  sleep(1);
    3738:	4505                	li	a0,1
    373a:	72c010ef          	jal	4e66 <sleep>
  if(unlink("oidir") != 0){
    373e:	00003517          	auipc	a0,0x3
    3742:	6aa50513          	addi	a0,a0,1706 # 6de8 <malloc+0x1b50>
    3746:	6e0010ef          	jal	4e26 <unlink>
    374a:	c919                	beqz	a0,3760 <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    374c:	85a6                	mv	a1,s1
    374e:	00002517          	auipc	a0,0x2
    3752:	6fa50513          	addi	a0,a0,1786 # 5e48 <malloc+0xbb0>
    3756:	28b010ef          	jal	51e0 <printf>
    exit(1);
    375a:	4505                	li	a0,1
    375c:	67a010ef          	jal	4dd6 <exit>
  wait(&xstatus);
    3760:	fdc40513          	addi	a0,s0,-36
    3764:	67a010ef          	jal	4dde <wait>
  exit(xstatus);
    3768:	fdc42503          	lw	a0,-36(s0)
    376c:	66a010ef          	jal	4dd6 <exit>

0000000000003770 <forkforkfork>:
{
    3770:	1101                	addi	sp,sp,-32
    3772:	ec06                	sd	ra,24(sp)
    3774:	e822                	sd	s0,16(sp)
    3776:	e426                	sd	s1,8(sp)
    3778:	1000                	addi	s0,sp,32
    377a:	84aa                	mv	s1,a0
  unlink("stopforking");
    377c:	00003517          	auipc	a0,0x3
    3780:	6b450513          	addi	a0,a0,1716 # 6e30 <malloc+0x1b98>
    3784:	6a2010ef          	jal	4e26 <unlink>
  int pid = fork();
    3788:	646010ef          	jal	4dce <fork>
  if(pid < 0){
    378c:	02054b63          	bltz	a0,37c2 <forkforkfork+0x52>
  if(pid == 0){
    3790:	c139                	beqz	a0,37d6 <forkforkfork+0x66>
  sleep(20); // two seconds
    3792:	4551                	li	a0,20
    3794:	6d2010ef          	jal	4e66 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3798:	20200593          	li	a1,514
    379c:	00003517          	auipc	a0,0x3
    37a0:	69450513          	addi	a0,a0,1684 # 6e30 <malloc+0x1b98>
    37a4:	672010ef          	jal	4e16 <open>
    37a8:	656010ef          	jal	4dfe <close>
  wait(0);
    37ac:	4501                	li	a0,0
    37ae:	630010ef          	jal	4dde <wait>
  sleep(10); // one second
    37b2:	4529                	li	a0,10
    37b4:	6b2010ef          	jal	4e66 <sleep>
}
    37b8:	60e2                	ld	ra,24(sp)
    37ba:	6442                	ld	s0,16(sp)
    37bc:	64a2                	ld	s1,8(sp)
    37be:	6105                	addi	sp,sp,32
    37c0:	8082                	ret
    printf("%s: fork failed", s);
    37c2:	85a6                	mv	a1,s1
    37c4:	00002517          	auipc	a0,0x2
    37c8:	65450513          	addi	a0,a0,1620 # 5e18 <malloc+0xb80>
    37cc:	215010ef          	jal	51e0 <printf>
    exit(1);
    37d0:	4505                	li	a0,1
    37d2:	604010ef          	jal	4dd6 <exit>
      int fd = open("stopforking", 0);
    37d6:	00003497          	auipc	s1,0x3
    37da:	65a48493          	addi	s1,s1,1626 # 6e30 <malloc+0x1b98>
    37de:	4581                	li	a1,0
    37e0:	8526                	mv	a0,s1
    37e2:	634010ef          	jal	4e16 <open>
      if(fd >= 0){
    37e6:	02055163          	bgez	a0,3808 <forkforkfork+0x98>
      if(fork() < 0){
    37ea:	5e4010ef          	jal	4dce <fork>
    37ee:	fe0558e3          	bgez	a0,37de <forkforkfork+0x6e>
        close(open("stopforking", O_CREATE|O_RDWR));
    37f2:	20200593          	li	a1,514
    37f6:	00003517          	auipc	a0,0x3
    37fa:	63a50513          	addi	a0,a0,1594 # 6e30 <malloc+0x1b98>
    37fe:	618010ef          	jal	4e16 <open>
    3802:	5fc010ef          	jal	4dfe <close>
    3806:	bfe1                	j	37de <forkforkfork+0x6e>
        exit(0);
    3808:	4501                	li	a0,0
    380a:	5cc010ef          	jal	4dd6 <exit>

000000000000380e <killstatus>:
{
    380e:	715d                	addi	sp,sp,-80
    3810:	e486                	sd	ra,72(sp)
    3812:	e0a2                	sd	s0,64(sp)
    3814:	fc26                	sd	s1,56(sp)
    3816:	f84a                	sd	s2,48(sp)
    3818:	f44e                	sd	s3,40(sp)
    381a:	f052                	sd	s4,32(sp)
    381c:	ec56                	sd	s5,24(sp)
    381e:	e85a                	sd	s6,16(sp)
    3820:	0880                	addi	s0,sp,80
    3822:	8b2a                	mv	s6,a0
    3824:	06400913          	li	s2,100
    sleep(1);
    3828:	4a85                	li	s5,1
    wait(&xst);
    382a:	fbc40a13          	addi	s4,s0,-68
    if(xst != -1) {
    382e:	59fd                	li	s3,-1
    int pid1 = fork();
    3830:	59e010ef          	jal	4dce <fork>
    3834:	84aa                	mv	s1,a0
    if(pid1 < 0){
    3836:	02054663          	bltz	a0,3862 <killstatus+0x54>
    if(pid1 == 0){
    383a:	cd15                	beqz	a0,3876 <killstatus+0x68>
    sleep(1);
    383c:	8556                	mv	a0,s5
    383e:	628010ef          	jal	4e66 <sleep>
    kill(pid1);
    3842:	8526                	mv	a0,s1
    3844:	5c2010ef          	jal	4e06 <kill>
    wait(&xst);
    3848:	8552                	mv	a0,s4
    384a:	594010ef          	jal	4dde <wait>
    if(xst != -1) {
    384e:	fbc42783          	lw	a5,-68(s0)
    3852:	03379563          	bne	a5,s3,387c <killstatus+0x6e>
  for(int i = 0; i < 100; i++){
    3856:	397d                	addiw	s2,s2,-1
    3858:	fc091ce3          	bnez	s2,3830 <killstatus+0x22>
  exit(0);
    385c:	4501                	li	a0,0
    385e:	578010ef          	jal	4dd6 <exit>
      printf("%s: fork failed\n", s);
    3862:	85da                	mv	a1,s6
    3864:	00002517          	auipc	a0,0x2
    3868:	3f450513          	addi	a0,a0,1012 # 5c58 <malloc+0x9c0>
    386c:	175010ef          	jal	51e0 <printf>
      exit(1);
    3870:	4505                	li	a0,1
    3872:	564010ef          	jal	4dd6 <exit>
        getpid();
    3876:	5e0010ef          	jal	4e56 <getpid>
      while(1) {
    387a:	bff5                	j	3876 <killstatus+0x68>
       printf("%s: status should be -1\n", s);
    387c:	85da                	mv	a1,s6
    387e:	00003517          	auipc	a0,0x3
    3882:	5c250513          	addi	a0,a0,1474 # 6e40 <malloc+0x1ba8>
    3886:	15b010ef          	jal	51e0 <printf>
       exit(1);
    388a:	4505                	li	a0,1
    388c:	54a010ef          	jal	4dd6 <exit>

0000000000003890 <preempt>:
{
    3890:	7139                	addi	sp,sp,-64
    3892:	fc06                	sd	ra,56(sp)
    3894:	f822                	sd	s0,48(sp)
    3896:	f426                	sd	s1,40(sp)
    3898:	f04a                	sd	s2,32(sp)
    389a:	ec4e                	sd	s3,24(sp)
    389c:	e852                	sd	s4,16(sp)
    389e:	0080                	addi	s0,sp,64
    38a0:	892a                	mv	s2,a0
  pid1 = fork();
    38a2:	52c010ef          	jal	4dce <fork>
  if(pid1 < 0) {
    38a6:	00054563          	bltz	a0,38b0 <preempt+0x20>
    38aa:	84aa                	mv	s1,a0
  if(pid1 == 0)
    38ac:	ed01                	bnez	a0,38c4 <preempt+0x34>
    for(;;)
    38ae:	a001                	j	38ae <preempt+0x1e>
    printf("%s: fork failed", s);
    38b0:	85ca                	mv	a1,s2
    38b2:	00002517          	auipc	a0,0x2
    38b6:	56650513          	addi	a0,a0,1382 # 5e18 <malloc+0xb80>
    38ba:	127010ef          	jal	51e0 <printf>
    exit(1);
    38be:	4505                	li	a0,1
    38c0:	516010ef          	jal	4dd6 <exit>
  pid2 = fork();
    38c4:	50a010ef          	jal	4dce <fork>
    38c8:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    38ca:	00054463          	bltz	a0,38d2 <preempt+0x42>
  if(pid2 == 0)
    38ce:	ed01                	bnez	a0,38e6 <preempt+0x56>
    for(;;)
    38d0:	a001                	j	38d0 <preempt+0x40>
    printf("%s: fork failed\n", s);
    38d2:	85ca                	mv	a1,s2
    38d4:	00002517          	auipc	a0,0x2
    38d8:	38450513          	addi	a0,a0,900 # 5c58 <malloc+0x9c0>
    38dc:	105010ef          	jal	51e0 <printf>
    exit(1);
    38e0:	4505                	li	a0,1
    38e2:	4f4010ef          	jal	4dd6 <exit>
  pipe(pfds);
    38e6:	fc840513          	addi	a0,s0,-56
    38ea:	4fc010ef          	jal	4de6 <pipe>
  pid3 = fork();
    38ee:	4e0010ef          	jal	4dce <fork>
    38f2:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    38f4:	02054863          	bltz	a0,3924 <preempt+0x94>
  if(pid3 == 0){
    38f8:	e921                	bnez	a0,3948 <preempt+0xb8>
    close(pfds[0]);
    38fa:	fc842503          	lw	a0,-56(s0)
    38fe:	500010ef          	jal	4dfe <close>
    if(write(pfds[1], "x", 1) != 1)
    3902:	4605                	li	a2,1
    3904:	00002597          	auipc	a1,0x2
    3908:	b3458593          	addi	a1,a1,-1228 # 5438 <malloc+0x1a0>
    390c:	fcc42503          	lw	a0,-52(s0)
    3910:	4e6010ef          	jal	4df6 <write>
    3914:	4785                	li	a5,1
    3916:	02f51163          	bne	a0,a5,3938 <preempt+0xa8>
    close(pfds[1]);
    391a:	fcc42503          	lw	a0,-52(s0)
    391e:	4e0010ef          	jal	4dfe <close>
    for(;;)
    3922:	a001                	j	3922 <preempt+0x92>
     printf("%s: fork failed\n", s);
    3924:	85ca                	mv	a1,s2
    3926:	00002517          	auipc	a0,0x2
    392a:	33250513          	addi	a0,a0,818 # 5c58 <malloc+0x9c0>
    392e:	0b3010ef          	jal	51e0 <printf>
     exit(1);
    3932:	4505                	li	a0,1
    3934:	4a2010ef          	jal	4dd6 <exit>
      printf("%s: preempt write error", s);
    3938:	85ca                	mv	a1,s2
    393a:	00003517          	auipc	a0,0x3
    393e:	52650513          	addi	a0,a0,1318 # 6e60 <malloc+0x1bc8>
    3942:	09f010ef          	jal	51e0 <printf>
    3946:	bfd1                	j	391a <preempt+0x8a>
  close(pfds[1]);
    3948:	fcc42503          	lw	a0,-52(s0)
    394c:	4b2010ef          	jal	4dfe <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    3950:	660d                	lui	a2,0x3
    3952:	00009597          	auipc	a1,0x9
    3956:	32658593          	addi	a1,a1,806 # cc78 <buf>
    395a:	fc842503          	lw	a0,-56(s0)
    395e:	490010ef          	jal	4dee <read>
    3962:	4785                	li	a5,1
    3964:	02f50163          	beq	a0,a5,3986 <preempt+0xf6>
    printf("%s: preempt read error", s);
    3968:	85ca                	mv	a1,s2
    396a:	00003517          	auipc	a0,0x3
    396e:	50e50513          	addi	a0,a0,1294 # 6e78 <malloc+0x1be0>
    3972:	06f010ef          	jal	51e0 <printf>
}
    3976:	70e2                	ld	ra,56(sp)
    3978:	7442                	ld	s0,48(sp)
    397a:	74a2                	ld	s1,40(sp)
    397c:	7902                	ld	s2,32(sp)
    397e:	69e2                	ld	s3,24(sp)
    3980:	6a42                	ld	s4,16(sp)
    3982:	6121                	addi	sp,sp,64
    3984:	8082                	ret
  close(pfds[0]);
    3986:	fc842503          	lw	a0,-56(s0)
    398a:	474010ef          	jal	4dfe <close>
  printf("kill... ");
    398e:	00003517          	auipc	a0,0x3
    3992:	50250513          	addi	a0,a0,1282 # 6e90 <malloc+0x1bf8>
    3996:	04b010ef          	jal	51e0 <printf>
  kill(pid1);
    399a:	8526                	mv	a0,s1
    399c:	46a010ef          	jal	4e06 <kill>
  kill(pid2);
    39a0:	854e                	mv	a0,s3
    39a2:	464010ef          	jal	4e06 <kill>
  kill(pid3);
    39a6:	8552                	mv	a0,s4
    39a8:	45e010ef          	jal	4e06 <kill>
  printf("wait... ");
    39ac:	00003517          	auipc	a0,0x3
    39b0:	4f450513          	addi	a0,a0,1268 # 6ea0 <malloc+0x1c08>
    39b4:	02d010ef          	jal	51e0 <printf>
  wait(0);
    39b8:	4501                	li	a0,0
    39ba:	424010ef          	jal	4dde <wait>
  wait(0);
    39be:	4501                	li	a0,0
    39c0:	41e010ef          	jal	4dde <wait>
  wait(0);
    39c4:	4501                	li	a0,0
    39c6:	418010ef          	jal	4dde <wait>
    39ca:	b775                	j	3976 <preempt+0xe6>

00000000000039cc <reparent>:
{
    39cc:	7179                	addi	sp,sp,-48
    39ce:	f406                	sd	ra,40(sp)
    39d0:	f022                	sd	s0,32(sp)
    39d2:	ec26                	sd	s1,24(sp)
    39d4:	e84a                	sd	s2,16(sp)
    39d6:	e44e                	sd	s3,8(sp)
    39d8:	e052                	sd	s4,0(sp)
    39da:	1800                	addi	s0,sp,48
    39dc:	89aa                	mv	s3,a0
  int master_pid = getpid();
    39de:	478010ef          	jal	4e56 <getpid>
    39e2:	8a2a                	mv	s4,a0
    39e4:	0c800913          	li	s2,200
    int pid = fork();
    39e8:	3e6010ef          	jal	4dce <fork>
    39ec:	84aa                	mv	s1,a0
    if(pid < 0){
    39ee:	00054e63          	bltz	a0,3a0a <reparent+0x3e>
    if(pid){
    39f2:	c121                	beqz	a0,3a32 <reparent+0x66>
      if(wait(0) != pid){
    39f4:	4501                	li	a0,0
    39f6:	3e8010ef          	jal	4dde <wait>
    39fa:	02951263          	bne	a0,s1,3a1e <reparent+0x52>
  for(int i = 0; i < 200; i++){
    39fe:	397d                	addiw	s2,s2,-1
    3a00:	fe0914e3          	bnez	s2,39e8 <reparent+0x1c>
  exit(0);
    3a04:	4501                	li	a0,0
    3a06:	3d0010ef          	jal	4dd6 <exit>
      printf("%s: fork failed\n", s);
    3a0a:	85ce                	mv	a1,s3
    3a0c:	00002517          	auipc	a0,0x2
    3a10:	24c50513          	addi	a0,a0,588 # 5c58 <malloc+0x9c0>
    3a14:	7cc010ef          	jal	51e0 <printf>
      exit(1);
    3a18:	4505                	li	a0,1
    3a1a:	3bc010ef          	jal	4dd6 <exit>
        printf("%s: wait wrong pid\n", s);
    3a1e:	85ce                	mv	a1,s3
    3a20:	00002517          	auipc	a0,0x2
    3a24:	3c050513          	addi	a0,a0,960 # 5de0 <malloc+0xb48>
    3a28:	7b8010ef          	jal	51e0 <printf>
        exit(1);
    3a2c:	4505                	li	a0,1
    3a2e:	3a8010ef          	jal	4dd6 <exit>
      int pid2 = fork();
    3a32:	39c010ef          	jal	4dce <fork>
      if(pid2 < 0){
    3a36:	00054563          	bltz	a0,3a40 <reparent+0x74>
      exit(0);
    3a3a:	4501                	li	a0,0
    3a3c:	39a010ef          	jal	4dd6 <exit>
        kill(master_pid);
    3a40:	8552                	mv	a0,s4
    3a42:	3c4010ef          	jal	4e06 <kill>
        exit(1);
    3a46:	4505                	li	a0,1
    3a48:	38e010ef          	jal	4dd6 <exit>

0000000000003a4c <sbrkfail>:
{
    3a4c:	7175                	addi	sp,sp,-144
    3a4e:	e506                	sd	ra,136(sp)
    3a50:	e122                	sd	s0,128(sp)
    3a52:	fca6                	sd	s1,120(sp)
    3a54:	f8ca                	sd	s2,112(sp)
    3a56:	f4ce                	sd	s3,104(sp)
    3a58:	f0d2                	sd	s4,96(sp)
    3a5a:	ecd6                	sd	s5,88(sp)
    3a5c:	e8da                	sd	s6,80(sp)
    3a5e:	e4de                	sd	s7,72(sp)
    3a60:	0900                	addi	s0,sp,144
    3a62:	8baa                	mv	s7,a0
  if(pipe(fds) != 0){
    3a64:	fa040513          	addi	a0,s0,-96
    3a68:	37e010ef          	jal	4de6 <pipe>
    3a6c:	e919                	bnez	a0,3a82 <sbrkfail+0x36>
    3a6e:	f7040493          	addi	s1,s0,-144
    3a72:	f9840993          	addi	s3,s0,-104
    3a76:	8926                	mv	s2,s1
    if(pids[i] != -1)
    3a78:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    3a7a:	f9f40b13          	addi	s6,s0,-97
    3a7e:	4a85                	li	s5,1
    3a80:	a0a9                	j	3aca <sbrkfail+0x7e>
    printf("%s: pipe() failed\n", s);
    3a82:	85de                	mv	a1,s7
    3a84:	00002517          	auipc	a0,0x2
    3a88:	2dc50513          	addi	a0,a0,732 # 5d60 <malloc+0xac8>
    3a8c:	754010ef          	jal	51e0 <printf>
    exit(1);
    3a90:	4505                	li	a0,1
    3a92:	344010ef          	jal	4dd6 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    3a96:	3c8010ef          	jal	4e5e <sbrk>
    3a9a:	064007b7          	lui	a5,0x6400
    3a9e:	40a7853b          	subw	a0,a5,a0
    3aa2:	3bc010ef          	jal	4e5e <sbrk>
      write(fds[1], "x", 1);
    3aa6:	4605                	li	a2,1
    3aa8:	00002597          	auipc	a1,0x2
    3aac:	99058593          	addi	a1,a1,-1648 # 5438 <malloc+0x1a0>
    3ab0:	fa442503          	lw	a0,-92(s0)
    3ab4:	342010ef          	jal	4df6 <write>
      for(;;) sleep(1000);
    3ab8:	3e800493          	li	s1,1000
    3abc:	8526                	mv	a0,s1
    3abe:	3a8010ef          	jal	4e66 <sleep>
    3ac2:	bfed                	j	3abc <sbrkfail+0x70>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3ac4:	0911                	addi	s2,s2,4
    3ac6:	03390063          	beq	s2,s3,3ae6 <sbrkfail+0x9a>
    if((pids[i] = fork()) == 0){
    3aca:	304010ef          	jal	4dce <fork>
    3ace:	00a92023          	sw	a0,0(s2)
    3ad2:	d171                	beqz	a0,3a96 <sbrkfail+0x4a>
    if(pids[i] != -1)
    3ad4:	ff4508e3          	beq	a0,s4,3ac4 <sbrkfail+0x78>
      read(fds[0], &scratch, 1);
    3ad8:	8656                	mv	a2,s5
    3ada:	85da                	mv	a1,s6
    3adc:	fa042503          	lw	a0,-96(s0)
    3ae0:	30e010ef          	jal	4dee <read>
    3ae4:	b7c5                	j	3ac4 <sbrkfail+0x78>
  c = sbrk(PGSIZE);
    3ae6:	6505                	lui	a0,0x1
    3ae8:	376010ef          	jal	4e5e <sbrk>
    3aec:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    3aee:	597d                	li	s2,-1
    3af0:	a021                	j	3af8 <sbrkfail+0xac>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3af2:	0491                	addi	s1,s1,4
    3af4:	01348b63          	beq	s1,s3,3b0a <sbrkfail+0xbe>
    if(pids[i] == -1)
    3af8:	4088                	lw	a0,0(s1)
    3afa:	ff250ce3          	beq	a0,s2,3af2 <sbrkfail+0xa6>
    kill(pids[i]);
    3afe:	308010ef          	jal	4e06 <kill>
    wait(0);
    3b02:	4501                	li	a0,0
    3b04:	2da010ef          	jal	4dde <wait>
    3b08:	b7ed                	j	3af2 <sbrkfail+0xa6>
  if(c == (char*)0xffffffffffffffffL){
    3b0a:	57fd                	li	a5,-1
    3b0c:	02fa0f63          	beq	s4,a5,3b4a <sbrkfail+0xfe>
  pid = fork();
    3b10:	2be010ef          	jal	4dce <fork>
    3b14:	84aa                	mv	s1,a0
  if(pid < 0){
    3b16:	04054463          	bltz	a0,3b5e <sbrkfail+0x112>
  if(pid == 0){
    3b1a:	cd21                	beqz	a0,3b72 <sbrkfail+0x126>
  wait(&xstatus);
    3b1c:	fac40513          	addi	a0,s0,-84
    3b20:	2be010ef          	jal	4dde <wait>
  if(xstatus != -1 && xstatus != 2)
    3b24:	fac42783          	lw	a5,-84(s0)
    3b28:	577d                	li	a4,-1
    3b2a:	00e78563          	beq	a5,a4,3b34 <sbrkfail+0xe8>
    3b2e:	4709                	li	a4,2
    3b30:	06e79f63          	bne	a5,a4,3bae <sbrkfail+0x162>
}
    3b34:	60aa                	ld	ra,136(sp)
    3b36:	640a                	ld	s0,128(sp)
    3b38:	74e6                	ld	s1,120(sp)
    3b3a:	7946                	ld	s2,112(sp)
    3b3c:	79a6                	ld	s3,104(sp)
    3b3e:	7a06                	ld	s4,96(sp)
    3b40:	6ae6                	ld	s5,88(sp)
    3b42:	6b46                	ld	s6,80(sp)
    3b44:	6ba6                	ld	s7,72(sp)
    3b46:	6149                	addi	sp,sp,144
    3b48:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    3b4a:	85de                	mv	a1,s7
    3b4c:	00003517          	auipc	a0,0x3
    3b50:	36450513          	addi	a0,a0,868 # 6eb0 <malloc+0x1c18>
    3b54:	68c010ef          	jal	51e0 <printf>
    exit(1);
    3b58:	4505                	li	a0,1
    3b5a:	27c010ef          	jal	4dd6 <exit>
    printf("%s: fork failed\n", s);
    3b5e:	85de                	mv	a1,s7
    3b60:	00002517          	auipc	a0,0x2
    3b64:	0f850513          	addi	a0,a0,248 # 5c58 <malloc+0x9c0>
    3b68:	678010ef          	jal	51e0 <printf>
    exit(1);
    3b6c:	4505                	li	a0,1
    3b6e:	268010ef          	jal	4dd6 <exit>
    a = sbrk(0);
    3b72:	4501                	li	a0,0
    3b74:	2ea010ef          	jal	4e5e <sbrk>
    3b78:	892a                	mv	s2,a0
    sbrk(10*BIG);
    3b7a:	3e800537          	lui	a0,0x3e800
    3b7e:	2e0010ef          	jal	4e5e <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3b82:	87ca                	mv	a5,s2
    3b84:	3e800737          	lui	a4,0x3e800
    3b88:	993a                	add	s2,s2,a4
    3b8a:	6705                	lui	a4,0x1
      n += *(a+i);
    3b8c:	0007c603          	lbu	a2,0(a5) # 6400000 <base+0x63f0388>
    3b90:	9e25                	addw	a2,a2,s1
    3b92:	84b2                	mv	s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    3b94:	97ba                	add	a5,a5,a4
    3b96:	fef91be3          	bne	s2,a5,3b8c <sbrkfail+0x140>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    3b9a:	85de                	mv	a1,s7
    3b9c:	00003517          	auipc	a0,0x3
    3ba0:	33450513          	addi	a0,a0,820 # 6ed0 <malloc+0x1c38>
    3ba4:	63c010ef          	jal	51e0 <printf>
    exit(1);
    3ba8:	4505                	li	a0,1
    3baa:	22c010ef          	jal	4dd6 <exit>
    exit(1);
    3bae:	4505                	li	a0,1
    3bb0:	226010ef          	jal	4dd6 <exit>

0000000000003bb4 <mem>:
{
    3bb4:	7139                	addi	sp,sp,-64
    3bb6:	fc06                	sd	ra,56(sp)
    3bb8:	f822                	sd	s0,48(sp)
    3bba:	f426                	sd	s1,40(sp)
    3bbc:	f04a                	sd	s2,32(sp)
    3bbe:	ec4e                	sd	s3,24(sp)
    3bc0:	0080                	addi	s0,sp,64
    3bc2:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    3bc4:	20a010ef          	jal	4dce <fork>
    m1 = 0;
    3bc8:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    3bca:	6909                	lui	s2,0x2
    3bcc:	71190913          	addi	s2,s2,1809 # 2711 <execout+0x23>
  if((pid = fork()) == 0){
    3bd0:	cd11                	beqz	a0,3bec <mem+0x38>
    wait(&xstatus);
    3bd2:	fcc40513          	addi	a0,s0,-52
    3bd6:	208010ef          	jal	4dde <wait>
    if(xstatus == -1){
    3bda:	fcc42503          	lw	a0,-52(s0)
    3bde:	57fd                	li	a5,-1
    3be0:	04f50363          	beq	a0,a5,3c26 <mem+0x72>
    exit(xstatus);
    3be4:	1f2010ef          	jal	4dd6 <exit>
      *(char**)m2 = m1;
    3be8:	e104                	sd	s1,0(a0)
      m1 = m2;
    3bea:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3bec:	854a                	mv	a0,s2
    3bee:	6aa010ef          	jal	5298 <malloc>
    3bf2:	f97d                	bnez	a0,3be8 <mem+0x34>
    while(m1){
    3bf4:	c491                	beqz	s1,3c00 <mem+0x4c>
      m2 = *(char**)m1;
    3bf6:	8526                	mv	a0,s1
    3bf8:	6084                	ld	s1,0(s1)
      free(m1);
    3bfa:	618010ef          	jal	5212 <free>
    while(m1){
    3bfe:	fce5                	bnez	s1,3bf6 <mem+0x42>
    m1 = malloc(1024*20);
    3c00:	6515                	lui	a0,0x5
    3c02:	696010ef          	jal	5298 <malloc>
    if(m1 == 0){
    3c06:	c511                	beqz	a0,3c12 <mem+0x5e>
    free(m1);
    3c08:	60a010ef          	jal	5212 <free>
    exit(0);
    3c0c:	4501                	li	a0,0
    3c0e:	1c8010ef          	jal	4dd6 <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3c12:	85ce                	mv	a1,s3
    3c14:	00003517          	auipc	a0,0x3
    3c18:	2ec50513          	addi	a0,a0,748 # 6f00 <malloc+0x1c68>
    3c1c:	5c4010ef          	jal	51e0 <printf>
      exit(1);
    3c20:	4505                	li	a0,1
    3c22:	1b4010ef          	jal	4dd6 <exit>
      exit(0);
    3c26:	4501                	li	a0,0
    3c28:	1ae010ef          	jal	4dd6 <exit>

0000000000003c2c <sharedfd>:
{
    3c2c:	7119                	addi	sp,sp,-128
    3c2e:	fc86                	sd	ra,120(sp)
    3c30:	f8a2                	sd	s0,112(sp)
    3c32:	e0da                	sd	s6,64(sp)
    3c34:	0100                	addi	s0,sp,128
    3c36:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    3c38:	00003517          	auipc	a0,0x3
    3c3c:	2e850513          	addi	a0,a0,744 # 6f20 <malloc+0x1c88>
    3c40:	1e6010ef          	jal	4e26 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3c44:	20200593          	li	a1,514
    3c48:	00003517          	auipc	a0,0x3
    3c4c:	2d850513          	addi	a0,a0,728 # 6f20 <malloc+0x1c88>
    3c50:	1c6010ef          	jal	4e16 <open>
  if(fd < 0){
    3c54:	04054b63          	bltz	a0,3caa <sharedfd+0x7e>
    3c58:	f4a6                	sd	s1,104(sp)
    3c5a:	f0ca                	sd	s2,96(sp)
    3c5c:	ecce                	sd	s3,88(sp)
    3c5e:	e8d2                	sd	s4,80(sp)
    3c60:	e4d6                	sd	s5,72(sp)
    3c62:	89aa                	mv	s3,a0
  pid = fork();
    3c64:	16a010ef          	jal	4dce <fork>
    3c68:	8aaa                	mv	s5,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    3c6a:	07000593          	li	a1,112
    3c6e:	e119                	bnez	a0,3c74 <sharedfd+0x48>
    3c70:	06300593          	li	a1,99
    3c74:	4629                	li	a2,10
    3c76:	f9040513          	addi	a0,s0,-112
    3c7a:	67b000ef          	jal	4af4 <memset>
    3c7e:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3c82:	f9040a13          	addi	s4,s0,-112
    3c86:	4929                	li	s2,10
    3c88:	864a                	mv	a2,s2
    3c8a:	85d2                	mv	a1,s4
    3c8c:	854e                	mv	a0,s3
    3c8e:	168010ef          	jal	4df6 <write>
    3c92:	03251e63          	bne	a0,s2,3cce <sharedfd+0xa2>
  for(i = 0; i < N; i++){
    3c96:	34fd                	addiw	s1,s1,-1
    3c98:	f8e5                	bnez	s1,3c88 <sharedfd+0x5c>
  if(pid == 0) {
    3c9a:	040a9763          	bnez	s5,3ce8 <sharedfd+0xbc>
    3c9e:	fc5e                	sd	s7,56(sp)
    3ca0:	f862                	sd	s8,48(sp)
    3ca2:	f466                	sd	s9,40(sp)
    exit(0);
    3ca4:	4501                	li	a0,0
    3ca6:	130010ef          	jal	4dd6 <exit>
    3caa:	f4a6                	sd	s1,104(sp)
    3cac:	f0ca                	sd	s2,96(sp)
    3cae:	ecce                	sd	s3,88(sp)
    3cb0:	e8d2                	sd	s4,80(sp)
    3cb2:	e4d6                	sd	s5,72(sp)
    3cb4:	fc5e                	sd	s7,56(sp)
    3cb6:	f862                	sd	s8,48(sp)
    3cb8:	f466                	sd	s9,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3cba:	85da                	mv	a1,s6
    3cbc:	00003517          	auipc	a0,0x3
    3cc0:	27450513          	addi	a0,a0,628 # 6f30 <malloc+0x1c98>
    3cc4:	51c010ef          	jal	51e0 <printf>
    exit(1);
    3cc8:	4505                	li	a0,1
    3cca:	10c010ef          	jal	4dd6 <exit>
    3cce:	fc5e                	sd	s7,56(sp)
    3cd0:	f862                	sd	s8,48(sp)
    3cd2:	f466                	sd	s9,40(sp)
      printf("%s: write sharedfd failed\n", s);
    3cd4:	85da                	mv	a1,s6
    3cd6:	00003517          	auipc	a0,0x3
    3cda:	28250513          	addi	a0,a0,642 # 6f58 <malloc+0x1cc0>
    3cde:	502010ef          	jal	51e0 <printf>
      exit(1);
    3ce2:	4505                	li	a0,1
    3ce4:	0f2010ef          	jal	4dd6 <exit>
    wait(&xstatus);
    3ce8:	f8c40513          	addi	a0,s0,-116
    3cec:	0f2010ef          	jal	4dde <wait>
    if(xstatus != 0)
    3cf0:	f8c42a03          	lw	s4,-116(s0)
    3cf4:	000a0863          	beqz	s4,3d04 <sharedfd+0xd8>
    3cf8:	fc5e                	sd	s7,56(sp)
    3cfa:	f862                	sd	s8,48(sp)
    3cfc:	f466                	sd	s9,40(sp)
      exit(xstatus);
    3cfe:	8552                	mv	a0,s4
    3d00:	0d6010ef          	jal	4dd6 <exit>
    3d04:	fc5e                	sd	s7,56(sp)
  close(fd);
    3d06:	854e                	mv	a0,s3
    3d08:	0f6010ef          	jal	4dfe <close>
  fd = open("sharedfd", 0);
    3d0c:	4581                	li	a1,0
    3d0e:	00003517          	auipc	a0,0x3
    3d12:	21250513          	addi	a0,a0,530 # 6f20 <malloc+0x1c88>
    3d16:	100010ef          	jal	4e16 <open>
    3d1a:	8baa                	mv	s7,a0
  nc = np = 0;
    3d1c:	89d2                	mv	s3,s4
  if(fd < 0){
    3d1e:	02054763          	bltz	a0,3d4c <sharedfd+0x120>
    3d22:	f862                	sd	s8,48(sp)
    3d24:	f466                	sd	s9,40(sp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3d26:	f9040c93          	addi	s9,s0,-112
    3d2a:	4c29                	li	s8,10
    3d2c:	f9a40913          	addi	s2,s0,-102
      if(buf[i] == 'c')
    3d30:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3d34:	07000a93          	li	s5,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3d38:	8662                	mv	a2,s8
    3d3a:	85e6                	mv	a1,s9
    3d3c:	855e                	mv	a0,s7
    3d3e:	0b0010ef          	jal	4dee <read>
    3d42:	02a05d63          	blez	a0,3d7c <sharedfd+0x150>
    3d46:	f9040793          	addi	a5,s0,-112
    3d4a:	a00d                	j	3d6c <sharedfd+0x140>
    3d4c:	f862                	sd	s8,48(sp)
    3d4e:	f466                	sd	s9,40(sp)
    printf("%s: cannot open sharedfd for reading\n", s);
    3d50:	85da                	mv	a1,s6
    3d52:	00003517          	auipc	a0,0x3
    3d56:	22650513          	addi	a0,a0,550 # 6f78 <malloc+0x1ce0>
    3d5a:	486010ef          	jal	51e0 <printf>
    exit(1);
    3d5e:	4505                	li	a0,1
    3d60:	076010ef          	jal	4dd6 <exit>
        nc++;
    3d64:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    3d66:	0785                	addi	a5,a5,1
    3d68:	fd2788e3          	beq	a5,s2,3d38 <sharedfd+0x10c>
      if(buf[i] == 'c')
    3d6c:	0007c703          	lbu	a4,0(a5)
    3d70:	fe970ae3          	beq	a4,s1,3d64 <sharedfd+0x138>
      if(buf[i] == 'p')
    3d74:	ff5719e3          	bne	a4,s5,3d66 <sharedfd+0x13a>
        np++;
    3d78:	2985                	addiw	s3,s3,1
    3d7a:	b7f5                	j	3d66 <sharedfd+0x13a>
  close(fd);
    3d7c:	855e                	mv	a0,s7
    3d7e:	080010ef          	jal	4dfe <close>
  unlink("sharedfd");
    3d82:	00003517          	auipc	a0,0x3
    3d86:	19e50513          	addi	a0,a0,414 # 6f20 <malloc+0x1c88>
    3d8a:	09c010ef          	jal	4e26 <unlink>
  if(nc == N*SZ && np == N*SZ){
    3d8e:	6789                	lui	a5,0x2
    3d90:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x22>
    3d94:	00fa1763          	bne	s4,a5,3da2 <sharedfd+0x176>
    3d98:	6789                	lui	a5,0x2
    3d9a:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x22>
    3d9e:	00f98c63          	beq	s3,a5,3db6 <sharedfd+0x18a>
    printf("%s: nc/np test fails\n", s);
    3da2:	85da                	mv	a1,s6
    3da4:	00003517          	auipc	a0,0x3
    3da8:	1fc50513          	addi	a0,a0,508 # 6fa0 <malloc+0x1d08>
    3dac:	434010ef          	jal	51e0 <printf>
    exit(1);
    3db0:	4505                	li	a0,1
    3db2:	024010ef          	jal	4dd6 <exit>
    exit(0);
    3db6:	4501                	li	a0,0
    3db8:	01e010ef          	jal	4dd6 <exit>

0000000000003dbc <fourfiles>:
{
    3dbc:	7135                	addi	sp,sp,-160
    3dbe:	ed06                	sd	ra,152(sp)
    3dc0:	e922                	sd	s0,144(sp)
    3dc2:	e526                	sd	s1,136(sp)
    3dc4:	e14a                	sd	s2,128(sp)
    3dc6:	fcce                	sd	s3,120(sp)
    3dc8:	f8d2                	sd	s4,112(sp)
    3dca:	f4d6                	sd	s5,104(sp)
    3dcc:	f0da                	sd	s6,96(sp)
    3dce:	ecde                	sd	s7,88(sp)
    3dd0:	e8e2                	sd	s8,80(sp)
    3dd2:	e4e6                	sd	s9,72(sp)
    3dd4:	e0ea                	sd	s10,64(sp)
    3dd6:	fc6e                	sd	s11,56(sp)
    3dd8:	1100                	addi	s0,sp,160
    3dda:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    3ddc:	00003797          	auipc	a5,0x3
    3de0:	1dc78793          	addi	a5,a5,476 # 6fb8 <malloc+0x1d20>
    3de4:	f6f43823          	sd	a5,-144(s0)
    3de8:	00003797          	auipc	a5,0x3
    3dec:	1d878793          	addi	a5,a5,472 # 6fc0 <malloc+0x1d28>
    3df0:	f6f43c23          	sd	a5,-136(s0)
    3df4:	00003797          	auipc	a5,0x3
    3df8:	1d478793          	addi	a5,a5,468 # 6fc8 <malloc+0x1d30>
    3dfc:	f8f43023          	sd	a5,-128(s0)
    3e00:	00003797          	auipc	a5,0x3
    3e04:	1d078793          	addi	a5,a5,464 # 6fd0 <malloc+0x1d38>
    3e08:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3e0c:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3e10:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    3e12:	4481                	li	s1,0
    3e14:	4a11                	li	s4,4
    fname = names[pi];
    3e16:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3e1a:	854e                	mv	a0,s3
    3e1c:	00a010ef          	jal	4e26 <unlink>
    pid = fork();
    3e20:	7af000ef          	jal	4dce <fork>
    if(pid < 0){
    3e24:	04054063          	bltz	a0,3e64 <fourfiles+0xa8>
    if(pid == 0){
    3e28:	c921                	beqz	a0,3e78 <fourfiles+0xbc>
  for(pi = 0; pi < NCHILD; pi++){
    3e2a:	2485                	addiw	s1,s1,1
    3e2c:	0921                	addi	s2,s2,8
    3e2e:	ff4494e3          	bne	s1,s4,3e16 <fourfiles+0x5a>
    3e32:	4491                	li	s1,4
    wait(&xstatus);
    3e34:	f6c40913          	addi	s2,s0,-148
    3e38:	854a                	mv	a0,s2
    3e3a:	7a5000ef          	jal	4dde <wait>
    if(xstatus != 0)
    3e3e:	f6c42b03          	lw	s6,-148(s0)
    3e42:	0a0b1463          	bnez	s6,3eea <fourfiles+0x12e>
  for(pi = 0; pi < NCHILD; pi++){
    3e46:	34fd                	addiw	s1,s1,-1
    3e48:	f8e5                	bnez	s1,3e38 <fourfiles+0x7c>
    3e4a:	03000493          	li	s1,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3e4e:	6a8d                	lui	s5,0x3
    3e50:	00009a17          	auipc	s4,0x9
    3e54:	e28a0a13          	addi	s4,s4,-472 # cc78 <buf>
    if(total != N*SZ){
    3e58:	6d05                	lui	s10,0x1
    3e5a:	770d0d13          	addi	s10,s10,1904 # 1770 <exitwait+0x90>
  for(i = 0; i < NCHILD; i++){
    3e5e:	03400d93          	li	s11,52
    3e62:	a86d                	j	3f1c <fourfiles+0x160>
      printf("%s: fork failed\n", s);
    3e64:	85e6                	mv	a1,s9
    3e66:	00002517          	auipc	a0,0x2
    3e6a:	df250513          	addi	a0,a0,-526 # 5c58 <malloc+0x9c0>
    3e6e:	372010ef          	jal	51e0 <printf>
      exit(1);
    3e72:	4505                	li	a0,1
    3e74:	763000ef          	jal	4dd6 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3e78:	20200593          	li	a1,514
    3e7c:	854e                	mv	a0,s3
    3e7e:	799000ef          	jal	4e16 <open>
    3e82:	892a                	mv	s2,a0
      if(fd < 0){
    3e84:	04054063          	bltz	a0,3ec4 <fourfiles+0x108>
      memset(buf, '0'+pi, SZ);
    3e88:	1f400613          	li	a2,500
    3e8c:	0304859b          	addiw	a1,s1,48
    3e90:	00009517          	auipc	a0,0x9
    3e94:	de850513          	addi	a0,a0,-536 # cc78 <buf>
    3e98:	45d000ef          	jal	4af4 <memset>
    3e9c:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3e9e:	1f400993          	li	s3,500
    3ea2:	00009a17          	auipc	s4,0x9
    3ea6:	dd6a0a13          	addi	s4,s4,-554 # cc78 <buf>
    3eaa:	864e                	mv	a2,s3
    3eac:	85d2                	mv	a1,s4
    3eae:	854a                	mv	a0,s2
    3eb0:	747000ef          	jal	4df6 <write>
    3eb4:	85aa                	mv	a1,a0
    3eb6:	03351163          	bne	a0,s3,3ed8 <fourfiles+0x11c>
      for(i = 0; i < N; i++){
    3eba:	34fd                	addiw	s1,s1,-1
    3ebc:	f4fd                	bnez	s1,3eaa <fourfiles+0xee>
      exit(0);
    3ebe:	4501                	li	a0,0
    3ec0:	717000ef          	jal	4dd6 <exit>
        printf("%s: create failed\n", s);
    3ec4:	85e6                	mv	a1,s9
    3ec6:	00002517          	auipc	a0,0x2
    3eca:	e2a50513          	addi	a0,a0,-470 # 5cf0 <malloc+0xa58>
    3ece:	312010ef          	jal	51e0 <printf>
        exit(1);
    3ed2:	4505                	li	a0,1
    3ed4:	703000ef          	jal	4dd6 <exit>
          printf("write failed %d\n", n);
    3ed8:	00003517          	auipc	a0,0x3
    3edc:	10050513          	addi	a0,a0,256 # 6fd8 <malloc+0x1d40>
    3ee0:	300010ef          	jal	51e0 <printf>
          exit(1);
    3ee4:	4505                	li	a0,1
    3ee6:	6f1000ef          	jal	4dd6 <exit>
      exit(xstatus);
    3eea:	855a                	mv	a0,s6
    3eec:	6eb000ef          	jal	4dd6 <exit>
          printf("%s: wrong char\n", s);
    3ef0:	85e6                	mv	a1,s9
    3ef2:	00003517          	auipc	a0,0x3
    3ef6:	0fe50513          	addi	a0,a0,254 # 6ff0 <malloc+0x1d58>
    3efa:	2e6010ef          	jal	51e0 <printf>
          exit(1);
    3efe:	4505                	li	a0,1
    3f00:	6d7000ef          	jal	4dd6 <exit>
    close(fd);
    3f04:	854e                	mv	a0,s3
    3f06:	6f9000ef          	jal	4dfe <close>
    if(total != N*SZ){
    3f0a:	05a91863          	bne	s2,s10,3f5a <fourfiles+0x19e>
    unlink(fname);
    3f0e:	8562                	mv	a0,s8
    3f10:	717000ef          	jal	4e26 <unlink>
  for(i = 0; i < NCHILD; i++){
    3f14:	0ba1                	addi	s7,s7,8
    3f16:	2485                	addiw	s1,s1,1
    3f18:	05b48b63          	beq	s1,s11,3f6e <fourfiles+0x1b2>
    fname = names[i];
    3f1c:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3f20:	4581                	li	a1,0
    3f22:	8562                	mv	a0,s8
    3f24:	6f3000ef          	jal	4e16 <open>
    3f28:	89aa                	mv	s3,a0
    total = 0;
    3f2a:	895a                	mv	s2,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3f2c:	8656                	mv	a2,s5
    3f2e:	85d2                	mv	a1,s4
    3f30:	854e                	mv	a0,s3
    3f32:	6bd000ef          	jal	4dee <read>
    3f36:	fca057e3          	blez	a0,3f04 <fourfiles+0x148>
    3f3a:	00009797          	auipc	a5,0x9
    3f3e:	d3e78793          	addi	a5,a5,-706 # cc78 <buf>
    3f42:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    3f46:	0007c703          	lbu	a4,0(a5)
    3f4a:	fa9713e3          	bne	a4,s1,3ef0 <fourfiles+0x134>
      for(j = 0; j < n; j++){
    3f4e:	0785                	addi	a5,a5,1
    3f50:	fed79be3          	bne	a5,a3,3f46 <fourfiles+0x18a>
      total += n;
    3f54:	00a9093b          	addw	s2,s2,a0
    3f58:	bfd1                	j	3f2c <fourfiles+0x170>
      printf("wrong length %d\n", total);
    3f5a:	85ca                	mv	a1,s2
    3f5c:	00003517          	auipc	a0,0x3
    3f60:	0a450513          	addi	a0,a0,164 # 7000 <malloc+0x1d68>
    3f64:	27c010ef          	jal	51e0 <printf>
      exit(1);
    3f68:	4505                	li	a0,1
    3f6a:	66d000ef          	jal	4dd6 <exit>
}
    3f6e:	60ea                	ld	ra,152(sp)
    3f70:	644a                	ld	s0,144(sp)
    3f72:	64aa                	ld	s1,136(sp)
    3f74:	690a                	ld	s2,128(sp)
    3f76:	79e6                	ld	s3,120(sp)
    3f78:	7a46                	ld	s4,112(sp)
    3f7a:	7aa6                	ld	s5,104(sp)
    3f7c:	7b06                	ld	s6,96(sp)
    3f7e:	6be6                	ld	s7,88(sp)
    3f80:	6c46                	ld	s8,80(sp)
    3f82:	6ca6                	ld	s9,72(sp)
    3f84:	6d06                	ld	s10,64(sp)
    3f86:	7de2                	ld	s11,56(sp)
    3f88:	610d                	addi	sp,sp,160
    3f8a:	8082                	ret

0000000000003f8c <concreate>:
{
    3f8c:	7171                	addi	sp,sp,-176
    3f8e:	f506                	sd	ra,168(sp)
    3f90:	f122                	sd	s0,160(sp)
    3f92:	ed26                	sd	s1,152(sp)
    3f94:	e94a                	sd	s2,144(sp)
    3f96:	e54e                	sd	s3,136(sp)
    3f98:	e152                	sd	s4,128(sp)
    3f9a:	fcd6                	sd	s5,120(sp)
    3f9c:	f8da                	sd	s6,112(sp)
    3f9e:	f4de                	sd	s7,104(sp)
    3fa0:	f0e2                	sd	s8,96(sp)
    3fa2:	ece6                	sd	s9,88(sp)
    3fa4:	e8ea                	sd	s10,80(sp)
    3fa6:	1900                	addi	s0,sp,176
    3fa8:	8baa                	mv	s7,a0
  file[0] = 'C';
    3faa:	04300793          	li	a5,67
    3fae:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    3fb2:	f8040d23          	sb	zero,-102(s0)
  for(i = 0; i < N; i++){
    3fb6:	4901                	li	s2,0
    unlink(file);
    3fb8:	f9840993          	addi	s3,s0,-104
    if(pid && (i % 3) == 1){
    3fbc:	55555b37          	lui	s6,0x55555
    3fc0:	556b0b13          	addi	s6,s6,1366 # 55555556 <base+0x555458de>
    3fc4:	4c05                	li	s8,1
      fd = open(file, O_CREATE | O_RDWR);
    3fc6:	20200c93          	li	s9,514
      link("C0", file);
    3fca:	00003d17          	auipc	s10,0x3
    3fce:	04ed0d13          	addi	s10,s10,78 # 7018 <malloc+0x1d80>
      wait(&xstatus);
    3fd2:	f5c40a93          	addi	s5,s0,-164
  for(i = 0; i < N; i++){
    3fd6:	02800a13          	li	s4,40
    3fda:	ac2d                	j	4214 <concreate+0x288>
      link("C0", file);
    3fdc:	85ce                	mv	a1,s3
    3fde:	856a                	mv	a0,s10
    3fe0:	657000ef          	jal	4e36 <link>
    if(pid == 0) {
    3fe4:	ac31                	j	4200 <concreate+0x274>
    } else if(pid == 0 && (i % 5) == 1){
    3fe6:	666667b7          	lui	a5,0x66666
    3fea:	66778793          	addi	a5,a5,1639 # 66666667 <base+0x666569ef>
    3fee:	02f907b3          	mul	a5,s2,a5
    3ff2:	9785                	srai	a5,a5,0x21
    3ff4:	41f9571b          	sraiw	a4,s2,0x1f
    3ff8:	9f99                	subw	a5,a5,a4
    3ffa:	0027971b          	slliw	a4,a5,0x2
    3ffe:	9fb9                	addw	a5,a5,a4
    4000:	40f9093b          	subw	s2,s2,a5
    4004:	4785                	li	a5,1
    4006:	02f90563          	beq	s2,a5,4030 <concreate+0xa4>
      fd = open(file, O_CREATE | O_RDWR);
    400a:	20200593          	li	a1,514
    400e:	f9840513          	addi	a0,s0,-104
    4012:	605000ef          	jal	4e16 <open>
      if(fd < 0){
    4016:	1e055063          	bgez	a0,41f6 <concreate+0x26a>
        printf("concreate create %s failed\n", file);
    401a:	f9840593          	addi	a1,s0,-104
    401e:	00003517          	auipc	a0,0x3
    4022:	00250513          	addi	a0,a0,2 # 7020 <malloc+0x1d88>
    4026:	1ba010ef          	jal	51e0 <printf>
        exit(1);
    402a:	4505                	li	a0,1
    402c:	5ab000ef          	jal	4dd6 <exit>
      link("C0", file);
    4030:	f9840593          	addi	a1,s0,-104
    4034:	00003517          	auipc	a0,0x3
    4038:	fe450513          	addi	a0,a0,-28 # 7018 <malloc+0x1d80>
    403c:	5fb000ef          	jal	4e36 <link>
      exit(0);
    4040:	4501                	li	a0,0
    4042:	595000ef          	jal	4dd6 <exit>
        exit(1);
    4046:	4505                	li	a0,1
    4048:	58f000ef          	jal	4dd6 <exit>
  memset(fa, 0, sizeof(fa));
    404c:	02800613          	li	a2,40
    4050:	4581                	li	a1,0
    4052:	f7040513          	addi	a0,s0,-144
    4056:	29f000ef          	jal	4af4 <memset>
  fd = open(".", 0);
    405a:	4581                	li	a1,0
    405c:	00002517          	auipc	a0,0x2
    4060:	a5450513          	addi	a0,a0,-1452 # 5ab0 <malloc+0x818>
    4064:	5b3000ef          	jal	4e16 <open>
    4068:	892a                	mv	s2,a0
  n = 0;
    406a:	8b26                	mv	s6,s1
  while(read(fd, &de, sizeof(de)) > 0){
    406c:	f6040a13          	addi	s4,s0,-160
    4070:	49c1                	li	s3,16
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4072:	04300a93          	li	s5,67
      if(i < 0 || i >= sizeof(fa)){
    4076:	02700c13          	li	s8,39
      fa[i] = 1;
    407a:	4c85                	li	s9,1
  while(read(fd, &de, sizeof(de)) > 0){
    407c:	864e                	mv	a2,s3
    407e:	85d2                	mv	a1,s4
    4080:	854a                	mv	a0,s2
    4082:	56d000ef          	jal	4dee <read>
    4086:	06a05763          	blez	a0,40f4 <concreate+0x168>
    if(de.inum == 0)
    408a:	f6045783          	lhu	a5,-160(s0)
    408e:	d7fd                	beqz	a5,407c <concreate+0xf0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4090:	f6244783          	lbu	a5,-158(s0)
    4094:	ff5794e3          	bne	a5,s5,407c <concreate+0xf0>
    4098:	f6444783          	lbu	a5,-156(s0)
    409c:	f3e5                	bnez	a5,407c <concreate+0xf0>
      i = de.name[1] - '0';
    409e:	f6344783          	lbu	a5,-157(s0)
    40a2:	fd07879b          	addiw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    40a6:	00fc6f63          	bltu	s8,a5,40c4 <concreate+0x138>
      if(fa[i]){
    40aa:	fa078713          	addi	a4,a5,-96
    40ae:	9722                	add	a4,a4,s0
    40b0:	fd074703          	lbu	a4,-48(a4) # fd0 <bigdir+0xda>
    40b4:	e705                	bnez	a4,40dc <concreate+0x150>
      fa[i] = 1;
    40b6:	fa078793          	addi	a5,a5,-96
    40ba:	97a2                	add	a5,a5,s0
    40bc:	fd978823          	sb	s9,-48(a5)
      n++;
    40c0:	2b05                	addiw	s6,s6,1
    40c2:	bf6d                	j	407c <concreate+0xf0>
        printf("%s: concreate weird file %s\n", s, de.name);
    40c4:	f6240613          	addi	a2,s0,-158
    40c8:	85de                	mv	a1,s7
    40ca:	00003517          	auipc	a0,0x3
    40ce:	f7650513          	addi	a0,a0,-138 # 7040 <malloc+0x1da8>
    40d2:	10e010ef          	jal	51e0 <printf>
        exit(1);
    40d6:	4505                	li	a0,1
    40d8:	4ff000ef          	jal	4dd6 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    40dc:	f6240613          	addi	a2,s0,-158
    40e0:	85de                	mv	a1,s7
    40e2:	00003517          	auipc	a0,0x3
    40e6:	f7e50513          	addi	a0,a0,-130 # 7060 <malloc+0x1dc8>
    40ea:	0f6010ef          	jal	51e0 <printf>
        exit(1);
    40ee:	4505                	li	a0,1
    40f0:	4e7000ef          	jal	4dd6 <exit>
  close(fd);
    40f4:	854a                	mv	a0,s2
    40f6:	509000ef          	jal	4dfe <close>
  if(n != N){
    40fa:	02800793          	li	a5,40
    40fe:	00fb1b63          	bne	s6,a5,4114 <concreate+0x188>
    if(((i % 3) == 0 && pid == 0) ||
    4102:	55555a37          	lui	s4,0x55555
    4106:	556a0a13          	addi	s4,s4,1366 # 55555556 <base+0x555458de>
      close(open(file, 0));
    410a:	f9840993          	addi	s3,s0,-104
    if(((i % 3) == 0 && pid == 0) ||
    410e:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4110:	8abe                	mv	s5,a5
    4112:	a049                	j	4194 <concreate+0x208>
    printf("%s: concreate not enough files in directory listing\n", s);
    4114:	85de                	mv	a1,s7
    4116:	00003517          	auipc	a0,0x3
    411a:	f7250513          	addi	a0,a0,-142 # 7088 <malloc+0x1df0>
    411e:	0c2010ef          	jal	51e0 <printf>
    exit(1);
    4122:	4505                	li	a0,1
    4124:	4b3000ef          	jal	4dd6 <exit>
      printf("%s: fork failed\n", s);
    4128:	85de                	mv	a1,s7
    412a:	00002517          	auipc	a0,0x2
    412e:	b2e50513          	addi	a0,a0,-1234 # 5c58 <malloc+0x9c0>
    4132:	0ae010ef          	jal	51e0 <printf>
      exit(1);
    4136:	4505                	li	a0,1
    4138:	49f000ef          	jal	4dd6 <exit>
      close(open(file, 0));
    413c:	4581                	li	a1,0
    413e:	854e                	mv	a0,s3
    4140:	4d7000ef          	jal	4e16 <open>
    4144:	4bb000ef          	jal	4dfe <close>
      close(open(file, 0));
    4148:	4581                	li	a1,0
    414a:	854e                	mv	a0,s3
    414c:	4cb000ef          	jal	4e16 <open>
    4150:	4af000ef          	jal	4dfe <close>
      close(open(file, 0));
    4154:	4581                	li	a1,0
    4156:	854e                	mv	a0,s3
    4158:	4bf000ef          	jal	4e16 <open>
    415c:	4a3000ef          	jal	4dfe <close>
      close(open(file, 0));
    4160:	4581                	li	a1,0
    4162:	854e                	mv	a0,s3
    4164:	4b3000ef          	jal	4e16 <open>
    4168:	497000ef          	jal	4dfe <close>
      close(open(file, 0));
    416c:	4581                	li	a1,0
    416e:	854e                	mv	a0,s3
    4170:	4a7000ef          	jal	4e16 <open>
    4174:	48b000ef          	jal	4dfe <close>
      close(open(file, 0));
    4178:	4581                	li	a1,0
    417a:	854e                	mv	a0,s3
    417c:	49b000ef          	jal	4e16 <open>
    4180:	47f000ef          	jal	4dfe <close>
    if(pid == 0)
    4184:	06090663          	beqz	s2,41f0 <concreate+0x264>
      wait(0);
    4188:	4501                	li	a0,0
    418a:	455000ef          	jal	4dde <wait>
  for(i = 0; i < N; i++){
    418e:	2485                	addiw	s1,s1,1
    4190:	0d548163          	beq	s1,s5,4252 <concreate+0x2c6>
    file[1] = '0' + i;
    4194:	0304879b          	addiw	a5,s1,48
    4198:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    419c:	433000ef          	jal	4dce <fork>
    41a0:	892a                	mv	s2,a0
    if(pid < 0){
    41a2:	f80543e3          	bltz	a0,4128 <concreate+0x19c>
    if(((i % 3) == 0 && pid == 0) ||
    41a6:	03448733          	mul	a4,s1,s4
    41aa:	9301                	srli	a4,a4,0x20
    41ac:	41f4d79b          	sraiw	a5,s1,0x1f
    41b0:	9f1d                	subw	a4,a4,a5
    41b2:	0017179b          	slliw	a5,a4,0x1
    41b6:	9fb9                	addw	a5,a5,a4
    41b8:	40f487bb          	subw	a5,s1,a5
    41bc:	873e                	mv	a4,a5
    41be:	8fc9                	or	a5,a5,a0
    41c0:	2781                	sext.w	a5,a5
    41c2:	dfad                	beqz	a5,413c <concreate+0x1b0>
    41c4:	01671363          	bne	a4,s6,41ca <concreate+0x23e>
       ((i % 3) == 1 && pid != 0)){
    41c8:	f935                	bnez	a0,413c <concreate+0x1b0>
      unlink(file);
    41ca:	854e                	mv	a0,s3
    41cc:	45b000ef          	jal	4e26 <unlink>
      unlink(file);
    41d0:	854e                	mv	a0,s3
    41d2:	455000ef          	jal	4e26 <unlink>
      unlink(file);
    41d6:	854e                	mv	a0,s3
    41d8:	44f000ef          	jal	4e26 <unlink>
      unlink(file);
    41dc:	854e                	mv	a0,s3
    41de:	449000ef          	jal	4e26 <unlink>
      unlink(file);
    41e2:	854e                	mv	a0,s3
    41e4:	443000ef          	jal	4e26 <unlink>
      unlink(file);
    41e8:	854e                	mv	a0,s3
    41ea:	43d000ef          	jal	4e26 <unlink>
    41ee:	bf59                	j	4184 <concreate+0x1f8>
      exit(0);
    41f0:	4501                	li	a0,0
    41f2:	3e5000ef          	jal	4dd6 <exit>
      close(fd);
    41f6:	409000ef          	jal	4dfe <close>
    if(pid == 0) {
    41fa:	b599                	j	4040 <concreate+0xb4>
      close(fd);
    41fc:	403000ef          	jal	4dfe <close>
      wait(&xstatus);
    4200:	8556                	mv	a0,s5
    4202:	3dd000ef          	jal	4dde <wait>
      if(xstatus != 0)
    4206:	f5c42483          	lw	s1,-164(s0)
    420a:	e2049ee3          	bnez	s1,4046 <concreate+0xba>
  for(i = 0; i < N; i++){
    420e:	2905                	addiw	s2,s2,1
    4210:	e3490ee3          	beq	s2,s4,404c <concreate+0xc0>
    file[1] = '0' + i;
    4214:	0309079b          	addiw	a5,s2,48
    4218:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    421c:	854e                	mv	a0,s3
    421e:	409000ef          	jal	4e26 <unlink>
    pid = fork();
    4222:	3ad000ef          	jal	4dce <fork>
    if(pid && (i % 3) == 1){
    4226:	dc0500e3          	beqz	a0,3fe6 <concreate+0x5a>
    422a:	036907b3          	mul	a5,s2,s6
    422e:	9381                	srli	a5,a5,0x20
    4230:	41f9571b          	sraiw	a4,s2,0x1f
    4234:	9f99                	subw	a5,a5,a4
    4236:	0017971b          	slliw	a4,a5,0x1
    423a:	9fb9                	addw	a5,a5,a4
    423c:	40f907bb          	subw	a5,s2,a5
    4240:	d9878ee3          	beq	a5,s8,3fdc <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    4244:	85e6                	mv	a1,s9
    4246:	854e                	mv	a0,s3
    4248:	3cf000ef          	jal	4e16 <open>
      if(fd < 0){
    424c:	fa0558e3          	bgez	a0,41fc <concreate+0x270>
    4250:	b3e9                	j	401a <concreate+0x8e>
}
    4252:	70aa                	ld	ra,168(sp)
    4254:	740a                	ld	s0,160(sp)
    4256:	64ea                	ld	s1,152(sp)
    4258:	694a                	ld	s2,144(sp)
    425a:	69aa                	ld	s3,136(sp)
    425c:	6a0a                	ld	s4,128(sp)
    425e:	7ae6                	ld	s5,120(sp)
    4260:	7b46                	ld	s6,112(sp)
    4262:	7ba6                	ld	s7,104(sp)
    4264:	7c06                	ld	s8,96(sp)
    4266:	6ce6                	ld	s9,88(sp)
    4268:	6d46                	ld	s10,80(sp)
    426a:	614d                	addi	sp,sp,176
    426c:	8082                	ret

000000000000426e <bigfile>:
{
    426e:	7139                	addi	sp,sp,-64
    4270:	fc06                	sd	ra,56(sp)
    4272:	f822                	sd	s0,48(sp)
    4274:	f426                	sd	s1,40(sp)
    4276:	f04a                	sd	s2,32(sp)
    4278:	ec4e                	sd	s3,24(sp)
    427a:	e852                	sd	s4,16(sp)
    427c:	e456                	sd	s5,8(sp)
    427e:	e05a                	sd	s6,0(sp)
    4280:	0080                	addi	s0,sp,64
    4282:	8b2a                	mv	s6,a0
  unlink("bigfile.dat");
    4284:	00003517          	auipc	a0,0x3
    4288:	e3c50513          	addi	a0,a0,-452 # 70c0 <malloc+0x1e28>
    428c:	39b000ef          	jal	4e26 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4290:	20200593          	li	a1,514
    4294:	00003517          	auipc	a0,0x3
    4298:	e2c50513          	addi	a0,a0,-468 # 70c0 <malloc+0x1e28>
    429c:	37b000ef          	jal	4e16 <open>
  if(fd < 0){
    42a0:	08054a63          	bltz	a0,4334 <bigfile+0xc6>
    42a4:	8a2a                	mv	s4,a0
    42a6:	4481                	li	s1,0
    memset(buf, i, SZ);
    42a8:	25800913          	li	s2,600
    42ac:	00009997          	auipc	s3,0x9
    42b0:	9cc98993          	addi	s3,s3,-1588 # cc78 <buf>
  for(i = 0; i < N; i++){
    42b4:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    42b6:	864a                	mv	a2,s2
    42b8:	85a6                	mv	a1,s1
    42ba:	854e                	mv	a0,s3
    42bc:	039000ef          	jal	4af4 <memset>
    if(write(fd, buf, SZ) != SZ){
    42c0:	864a                	mv	a2,s2
    42c2:	85ce                	mv	a1,s3
    42c4:	8552                	mv	a0,s4
    42c6:	331000ef          	jal	4df6 <write>
    42ca:	07251f63          	bne	a0,s2,4348 <bigfile+0xda>
  for(i = 0; i < N; i++){
    42ce:	2485                	addiw	s1,s1,1
    42d0:	ff5493e3          	bne	s1,s5,42b6 <bigfile+0x48>
  close(fd);
    42d4:	8552                	mv	a0,s4
    42d6:	329000ef          	jal	4dfe <close>
  fd = open("bigfile.dat", 0);
    42da:	4581                	li	a1,0
    42dc:	00003517          	auipc	a0,0x3
    42e0:	de450513          	addi	a0,a0,-540 # 70c0 <malloc+0x1e28>
    42e4:	333000ef          	jal	4e16 <open>
    42e8:	8aaa                	mv	s5,a0
  total = 0;
    42ea:	4a01                	li	s4,0
  for(i = 0; ; i++){
    42ec:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    42ee:	12c00993          	li	s3,300
    42f2:	00009917          	auipc	s2,0x9
    42f6:	98690913          	addi	s2,s2,-1658 # cc78 <buf>
  if(fd < 0){
    42fa:	06054163          	bltz	a0,435c <bigfile+0xee>
    cc = read(fd, buf, SZ/2);
    42fe:	864e                	mv	a2,s3
    4300:	85ca                	mv	a1,s2
    4302:	8556                	mv	a0,s5
    4304:	2eb000ef          	jal	4dee <read>
    if(cc < 0){
    4308:	06054463          	bltz	a0,4370 <bigfile+0x102>
    if(cc == 0)
    430c:	c145                	beqz	a0,43ac <bigfile+0x13e>
    if(cc != SZ/2){
    430e:	07351b63          	bne	a0,s3,4384 <bigfile+0x116>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4312:	01f4d79b          	srliw	a5,s1,0x1f
    4316:	9fa5                	addw	a5,a5,s1
    4318:	4017d79b          	sraiw	a5,a5,0x1
    431c:	00094703          	lbu	a4,0(s2)
    4320:	06f71c63          	bne	a4,a5,4398 <bigfile+0x12a>
    4324:	12b94703          	lbu	a4,299(s2)
    4328:	06f71863          	bne	a4,a5,4398 <bigfile+0x12a>
    total += cc;
    432c:	12ca0a1b          	addiw	s4,s4,300
  for(i = 0; ; i++){
    4330:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4332:	b7f1                	j	42fe <bigfile+0x90>
    printf("%s: cannot create bigfile", s);
    4334:	85da                	mv	a1,s6
    4336:	00003517          	auipc	a0,0x3
    433a:	d9a50513          	addi	a0,a0,-614 # 70d0 <malloc+0x1e38>
    433e:	6a3000ef          	jal	51e0 <printf>
    exit(1);
    4342:	4505                	li	a0,1
    4344:	293000ef          	jal	4dd6 <exit>
      printf("%s: write bigfile failed\n", s);
    4348:	85da                	mv	a1,s6
    434a:	00003517          	auipc	a0,0x3
    434e:	da650513          	addi	a0,a0,-602 # 70f0 <malloc+0x1e58>
    4352:	68f000ef          	jal	51e0 <printf>
      exit(1);
    4356:	4505                	li	a0,1
    4358:	27f000ef          	jal	4dd6 <exit>
    printf("%s: cannot open bigfile\n", s);
    435c:	85da                	mv	a1,s6
    435e:	00003517          	auipc	a0,0x3
    4362:	db250513          	addi	a0,a0,-590 # 7110 <malloc+0x1e78>
    4366:	67b000ef          	jal	51e0 <printf>
    exit(1);
    436a:	4505                	li	a0,1
    436c:	26b000ef          	jal	4dd6 <exit>
      printf("%s: read bigfile failed\n", s);
    4370:	85da                	mv	a1,s6
    4372:	00003517          	auipc	a0,0x3
    4376:	dbe50513          	addi	a0,a0,-578 # 7130 <malloc+0x1e98>
    437a:	667000ef          	jal	51e0 <printf>
      exit(1);
    437e:	4505                	li	a0,1
    4380:	257000ef          	jal	4dd6 <exit>
      printf("%s: short read bigfile\n", s);
    4384:	85da                	mv	a1,s6
    4386:	00003517          	auipc	a0,0x3
    438a:	dca50513          	addi	a0,a0,-566 # 7150 <malloc+0x1eb8>
    438e:	653000ef          	jal	51e0 <printf>
      exit(1);
    4392:	4505                	li	a0,1
    4394:	243000ef          	jal	4dd6 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4398:	85da                	mv	a1,s6
    439a:	00003517          	auipc	a0,0x3
    439e:	dce50513          	addi	a0,a0,-562 # 7168 <malloc+0x1ed0>
    43a2:	63f000ef          	jal	51e0 <printf>
      exit(1);
    43a6:	4505                	li	a0,1
    43a8:	22f000ef          	jal	4dd6 <exit>
  close(fd);
    43ac:	8556                	mv	a0,s5
    43ae:	251000ef          	jal	4dfe <close>
  if(total != N*SZ){
    43b2:	678d                	lui	a5,0x3
    43b4:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x1e4>
    43b8:	02fa1263          	bne	s4,a5,43dc <bigfile+0x16e>
  unlink("bigfile.dat");
    43bc:	00003517          	auipc	a0,0x3
    43c0:	d0450513          	addi	a0,a0,-764 # 70c0 <malloc+0x1e28>
    43c4:	263000ef          	jal	4e26 <unlink>
}
    43c8:	70e2                	ld	ra,56(sp)
    43ca:	7442                	ld	s0,48(sp)
    43cc:	74a2                	ld	s1,40(sp)
    43ce:	7902                	ld	s2,32(sp)
    43d0:	69e2                	ld	s3,24(sp)
    43d2:	6a42                	ld	s4,16(sp)
    43d4:	6aa2                	ld	s5,8(sp)
    43d6:	6b02                	ld	s6,0(sp)
    43d8:	6121                	addi	sp,sp,64
    43da:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    43dc:	85da                	mv	a1,s6
    43de:	00003517          	auipc	a0,0x3
    43e2:	daa50513          	addi	a0,a0,-598 # 7188 <malloc+0x1ef0>
    43e6:	5fb000ef          	jal	51e0 <printf>
    exit(1);
    43ea:	4505                	li	a0,1
    43ec:	1eb000ef          	jal	4dd6 <exit>

00000000000043f0 <bigargtest>:
{
    43f0:	7121                	addi	sp,sp,-448
    43f2:	ff06                	sd	ra,440(sp)
    43f4:	fb22                	sd	s0,432(sp)
    43f6:	f726                	sd	s1,424(sp)
    43f8:	0380                	addi	s0,sp,448
    43fa:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    43fc:	00003517          	auipc	a0,0x3
    4400:	dac50513          	addi	a0,a0,-596 # 71a8 <malloc+0x1f10>
    4404:	223000ef          	jal	4e26 <unlink>
  pid = fork();
    4408:	1c7000ef          	jal	4dce <fork>
  if(pid == 0){
    440c:	c915                	beqz	a0,4440 <bigargtest+0x50>
  } else if(pid < 0){
    440e:	08054a63          	bltz	a0,44a2 <bigargtest+0xb2>
  wait(&xstatus);
    4412:	fdc40513          	addi	a0,s0,-36
    4416:	1c9000ef          	jal	4dde <wait>
  if(xstatus != 0)
    441a:	fdc42503          	lw	a0,-36(s0)
    441e:	ed41                	bnez	a0,44b6 <bigargtest+0xc6>
  fd = open("bigarg-ok", 0);
    4420:	4581                	li	a1,0
    4422:	00003517          	auipc	a0,0x3
    4426:	d8650513          	addi	a0,a0,-634 # 71a8 <malloc+0x1f10>
    442a:	1ed000ef          	jal	4e16 <open>
  if(fd < 0){
    442e:	08054663          	bltz	a0,44ba <bigargtest+0xca>
  close(fd);
    4432:	1cd000ef          	jal	4dfe <close>
}
    4436:	70fa                	ld	ra,440(sp)
    4438:	745a                	ld	s0,432(sp)
    443a:	74ba                	ld	s1,424(sp)
    443c:	6139                	addi	sp,sp,448
    443e:	8082                	ret
    memset(big, ' ', sizeof(big));
    4440:	19000613          	li	a2,400
    4444:	02000593          	li	a1,32
    4448:	e4840513          	addi	a0,s0,-440
    444c:	6a8000ef          	jal	4af4 <memset>
    big[sizeof(big)-1] = '\0';
    4450:	fc040ba3          	sb	zero,-41(s0)
    for(i = 0; i < MAXARG-1; i++)
    4454:	00005797          	auipc	a5,0x5
    4458:	00c78793          	addi	a5,a5,12 # 9460 <args.1>
    445c:	00005697          	auipc	a3,0x5
    4460:	0fc68693          	addi	a3,a3,252 # 9558 <args.1+0xf8>
      args[i] = big;
    4464:	e4840713          	addi	a4,s0,-440
    4468:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    446a:	07a1                	addi	a5,a5,8
    446c:	fed79ee3          	bne	a5,a3,4468 <bigargtest+0x78>
    args[MAXARG-1] = 0;
    4470:	00005597          	auipc	a1,0x5
    4474:	ff058593          	addi	a1,a1,-16 # 9460 <args.1>
    4478:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    447c:	00001517          	auipc	a0,0x1
    4480:	f4c50513          	addi	a0,a0,-180 # 53c8 <malloc+0x130>
    4484:	18b000ef          	jal	4e0e <exec>
    fd = open("bigarg-ok", O_CREATE);
    4488:	20000593          	li	a1,512
    448c:	00003517          	auipc	a0,0x3
    4490:	d1c50513          	addi	a0,a0,-740 # 71a8 <malloc+0x1f10>
    4494:	183000ef          	jal	4e16 <open>
    close(fd);
    4498:	167000ef          	jal	4dfe <close>
    exit(0);
    449c:	4501                	li	a0,0
    449e:	139000ef          	jal	4dd6 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    44a2:	85a6                	mv	a1,s1
    44a4:	00003517          	auipc	a0,0x3
    44a8:	d1450513          	addi	a0,a0,-748 # 71b8 <malloc+0x1f20>
    44ac:	535000ef          	jal	51e0 <printf>
    exit(1);
    44b0:	4505                	li	a0,1
    44b2:	125000ef          	jal	4dd6 <exit>
    exit(xstatus);
    44b6:	121000ef          	jal	4dd6 <exit>
    printf("%s: bigarg test failed!\n", s);
    44ba:	85a6                	mv	a1,s1
    44bc:	00003517          	auipc	a0,0x3
    44c0:	d1c50513          	addi	a0,a0,-740 # 71d8 <malloc+0x1f40>
    44c4:	51d000ef          	jal	51e0 <printf>
    exit(1);
    44c8:	4505                	li	a0,1
    44ca:	10d000ef          	jal	4dd6 <exit>

00000000000044ce <fsfull>:
{
    44ce:	7171                	addi	sp,sp,-176
    44d0:	f506                	sd	ra,168(sp)
    44d2:	f122                	sd	s0,160(sp)
    44d4:	ed26                	sd	s1,152(sp)
    44d6:	e94a                	sd	s2,144(sp)
    44d8:	e54e                	sd	s3,136(sp)
    44da:	e152                	sd	s4,128(sp)
    44dc:	fcd6                	sd	s5,120(sp)
    44de:	f8da                	sd	s6,112(sp)
    44e0:	f4de                	sd	s7,104(sp)
    44e2:	f0e2                	sd	s8,96(sp)
    44e4:	ece6                	sd	s9,88(sp)
    44e6:	e8ea                	sd	s10,80(sp)
    44e8:	e4ee                	sd	s11,72(sp)
    44ea:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    44ec:	00003517          	auipc	a0,0x3
    44f0:	d0c50513          	addi	a0,a0,-756 # 71f8 <malloc+0x1f60>
    44f4:	4ed000ef          	jal	51e0 <printf>
  for(nfiles = 0; ; nfiles++){
    44f8:	4481                	li	s1,0
    name[0] = 'f';
    44fa:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    44fe:	10625cb7          	lui	s9,0x10625
    4502:	dd3c8c93          	addi	s9,s9,-557 # 10624dd3 <base+0x1061515b>
    name[2] = '0' + (nfiles % 1000) / 100;
    4506:	51eb8ab7          	lui	s5,0x51eb8
    450a:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <base+0x51ea88a7>
    name[3] = '0' + (nfiles % 100) / 10;
    450e:	66666a37          	lui	s4,0x66666
    4512:	667a0a13          	addi	s4,s4,1639 # 66666667 <base+0x666569ef>
    printf("writing %s\n", name);
    4516:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    451a:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    451e:	039487b3          	mul	a5,s1,s9
    4522:	9799                	srai	a5,a5,0x26
    4524:	41f4d69b          	sraiw	a3,s1,0x1f
    4528:	9f95                	subw	a5,a5,a3
    452a:	0307871b          	addiw	a4,a5,48
    452e:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4532:	3e800713          	li	a4,1000
    4536:	02f707bb          	mulw	a5,a4,a5
    453a:	40f487bb          	subw	a5,s1,a5
    453e:	03578733          	mul	a4,a5,s5
    4542:	9715                	srai	a4,a4,0x25
    4544:	41f7d79b          	sraiw	a5,a5,0x1f
    4548:	40f707bb          	subw	a5,a4,a5
    454c:	0307879b          	addiw	a5,a5,48
    4550:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4554:	035487b3          	mul	a5,s1,s5
    4558:	9795                	srai	a5,a5,0x25
    455a:	9f95                	subw	a5,a5,a3
    455c:	06400713          	li	a4,100
    4560:	02f707bb          	mulw	a5,a4,a5
    4564:	40f487bb          	subw	a5,s1,a5
    4568:	03478733          	mul	a4,a5,s4
    456c:	9709                	srai	a4,a4,0x22
    456e:	41f7d79b          	sraiw	a5,a5,0x1f
    4572:	40f707bb          	subw	a5,a4,a5
    4576:	0307879b          	addiw	a5,a5,48
    457a:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    457e:	03448733          	mul	a4,s1,s4
    4582:	9709                	srai	a4,a4,0x22
    4584:	9f15                	subw	a4,a4,a3
    4586:	0027179b          	slliw	a5,a4,0x2
    458a:	9fb9                	addw	a5,a5,a4
    458c:	0017979b          	slliw	a5,a5,0x1
    4590:	40f487bb          	subw	a5,s1,a5
    4594:	0307879b          	addiw	a5,a5,48
    4598:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    459c:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    45a0:	85ea                	mv	a1,s10
    45a2:	00003517          	auipc	a0,0x3
    45a6:	c6650513          	addi	a0,a0,-922 # 7208 <malloc+0x1f70>
    45aa:	437000ef          	jal	51e0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    45ae:	20200593          	li	a1,514
    45b2:	856a                	mv	a0,s10
    45b4:	063000ef          	jal	4e16 <open>
    45b8:	892a                	mv	s2,a0
    if(fd < 0){
    45ba:	0e055863          	bgez	a0,46aa <fsfull+0x1dc>
      printf("open %s failed\n", name);
    45be:	f5040593          	addi	a1,s0,-176
    45c2:	00003517          	auipc	a0,0x3
    45c6:	c5650513          	addi	a0,a0,-938 # 7218 <malloc+0x1f80>
    45ca:	417000ef          	jal	51e0 <printf>
    name[0] = 'f';
    45ce:	06600c13          	li	s8,102
    name[1] = '0' + nfiles / 1000;
    45d2:	10625a37          	lui	s4,0x10625
    45d6:	dd3a0a13          	addi	s4,s4,-557 # 10624dd3 <base+0x1061515b>
    name[2] = '0' + (nfiles % 1000) / 100;
    45da:	3e800b93          	li	s7,1000
    45de:	51eb89b7          	lui	s3,0x51eb8
    45e2:	51f98993          	addi	s3,s3,1311 # 51eb851f <base+0x51ea88a7>
    name[3] = '0' + (nfiles % 100) / 10;
    45e6:	06400b13          	li	s6,100
    45ea:	66666937          	lui	s2,0x66666
    45ee:	66790913          	addi	s2,s2,1639 # 66666667 <base+0x666569ef>
    unlink(name);
    45f2:	f5040a93          	addi	s5,s0,-176
    name[0] = 'f';
    45f6:	f5840823          	sb	s8,-176(s0)
    name[1] = '0' + nfiles / 1000;
    45fa:	034487b3          	mul	a5,s1,s4
    45fe:	9799                	srai	a5,a5,0x26
    4600:	41f4d69b          	sraiw	a3,s1,0x1f
    4604:	9f95                	subw	a5,a5,a3
    4606:	0307871b          	addiw	a4,a5,48
    460a:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    460e:	02fb87bb          	mulw	a5,s7,a5
    4612:	40f487bb          	subw	a5,s1,a5
    4616:	03378733          	mul	a4,a5,s3
    461a:	9715                	srai	a4,a4,0x25
    461c:	41f7d79b          	sraiw	a5,a5,0x1f
    4620:	40f707bb          	subw	a5,a4,a5
    4624:	0307879b          	addiw	a5,a5,48
    4628:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    462c:	033487b3          	mul	a5,s1,s3
    4630:	9795                	srai	a5,a5,0x25
    4632:	9f95                	subw	a5,a5,a3
    4634:	02fb07bb          	mulw	a5,s6,a5
    4638:	40f487bb          	subw	a5,s1,a5
    463c:	03278733          	mul	a4,a5,s2
    4640:	9709                	srai	a4,a4,0x22
    4642:	41f7d79b          	sraiw	a5,a5,0x1f
    4646:	40f707bb          	subw	a5,a4,a5
    464a:	0307879b          	addiw	a5,a5,48
    464e:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4652:	03248733          	mul	a4,s1,s2
    4656:	9709                	srai	a4,a4,0x22
    4658:	9f15                	subw	a4,a4,a3
    465a:	0027179b          	slliw	a5,a4,0x2
    465e:	9fb9                	addw	a5,a5,a4
    4660:	0017979b          	slliw	a5,a5,0x1
    4664:	40f487bb          	subw	a5,s1,a5
    4668:	0307879b          	addiw	a5,a5,48
    466c:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4670:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    4674:	8556                	mv	a0,s5
    4676:	7b0000ef          	jal	4e26 <unlink>
    nfiles--;
    467a:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    467c:	f604dde3          	bgez	s1,45f6 <fsfull+0x128>
  printf("fsfull test finished\n");
    4680:	00003517          	auipc	a0,0x3
    4684:	bb850513          	addi	a0,a0,-1096 # 7238 <malloc+0x1fa0>
    4688:	359000ef          	jal	51e0 <printf>
}
    468c:	70aa                	ld	ra,168(sp)
    468e:	740a                	ld	s0,160(sp)
    4690:	64ea                	ld	s1,152(sp)
    4692:	694a                	ld	s2,144(sp)
    4694:	69aa                	ld	s3,136(sp)
    4696:	6a0a                	ld	s4,128(sp)
    4698:	7ae6                	ld	s5,120(sp)
    469a:	7b46                	ld	s6,112(sp)
    469c:	7ba6                	ld	s7,104(sp)
    469e:	7c06                	ld	s8,96(sp)
    46a0:	6ce6                	ld	s9,88(sp)
    46a2:	6d46                	ld	s10,80(sp)
    46a4:	6da6                	ld	s11,72(sp)
    46a6:	614d                	addi	sp,sp,176
    46a8:	8082                	ret
    int total = 0;
    46aa:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    46ac:	40000c13          	li	s8,1024
    46b0:	00008b97          	auipc	s7,0x8
    46b4:	5c8b8b93          	addi	s7,s7,1480 # cc78 <buf>
      if(cc < BSIZE)
    46b8:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    46bc:	8662                	mv	a2,s8
    46be:	85de                	mv	a1,s7
    46c0:	854a                	mv	a0,s2
    46c2:	734000ef          	jal	4df6 <write>
      if(cc < BSIZE)
    46c6:	00ab5563          	bge	s6,a0,46d0 <fsfull+0x202>
      total += cc;
    46ca:	00a989bb          	addw	s3,s3,a0
    while(1){
    46ce:	b7fd                	j	46bc <fsfull+0x1ee>
    printf("wrote %d bytes\n", total);
    46d0:	85ce                	mv	a1,s3
    46d2:	00003517          	auipc	a0,0x3
    46d6:	b5650513          	addi	a0,a0,-1194 # 7228 <malloc+0x1f90>
    46da:	307000ef          	jal	51e0 <printf>
    close(fd);
    46de:	854a                	mv	a0,s2
    46e0:	71e000ef          	jal	4dfe <close>
    if(total == 0)
    46e4:	ee0985e3          	beqz	s3,45ce <fsfull+0x100>
  for(nfiles = 0; ; nfiles++){
    46e8:	2485                	addiw	s1,s1,1
    46ea:	bd05                	j	451a <fsfull+0x4c>

00000000000046ec <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    46ec:	7179                	addi	sp,sp,-48
    46ee:	f406                	sd	ra,40(sp)
    46f0:	f022                	sd	s0,32(sp)
    46f2:	ec26                	sd	s1,24(sp)
    46f4:	e84a                	sd	s2,16(sp)
    46f6:	1800                	addi	s0,sp,48
    46f8:	84aa                	mv	s1,a0
    46fa:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    46fc:	00003517          	auipc	a0,0x3
    4700:	b5450513          	addi	a0,a0,-1196 # 7250 <malloc+0x1fb8>
    4704:	2dd000ef          	jal	51e0 <printf>
  if((pid = fork()) < 0) {
    4708:	6c6000ef          	jal	4dce <fork>
    470c:	02054a63          	bltz	a0,4740 <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    4710:	c129                	beqz	a0,4752 <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    4712:	fdc40513          	addi	a0,s0,-36
    4716:	6c8000ef          	jal	4dde <wait>
    if(xstatus != 0) 
    471a:	fdc42783          	lw	a5,-36(s0)
    471e:	cf9d                	beqz	a5,475c <run+0x70>
      printf("FAILED\n");
    4720:	00003517          	auipc	a0,0x3
    4724:	b5850513          	addi	a0,a0,-1192 # 7278 <malloc+0x1fe0>
    4728:	2b9000ef          	jal	51e0 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    472c:	fdc42503          	lw	a0,-36(s0)
  }
}
    4730:	00153513          	seqz	a0,a0
    4734:	70a2                	ld	ra,40(sp)
    4736:	7402                	ld	s0,32(sp)
    4738:	64e2                	ld	s1,24(sp)
    473a:	6942                	ld	s2,16(sp)
    473c:	6145                	addi	sp,sp,48
    473e:	8082                	ret
    printf("runtest: fork error\n");
    4740:	00003517          	auipc	a0,0x3
    4744:	b2050513          	addi	a0,a0,-1248 # 7260 <malloc+0x1fc8>
    4748:	299000ef          	jal	51e0 <printf>
    exit(1);
    474c:	4505                	li	a0,1
    474e:	688000ef          	jal	4dd6 <exit>
    f(s);
    4752:	854a                	mv	a0,s2
    4754:	9482                	jalr	s1
    exit(0);
    4756:	4501                	li	a0,0
    4758:	67e000ef          	jal	4dd6 <exit>
      printf("OK\n");
    475c:	00003517          	auipc	a0,0x3
    4760:	b2450513          	addi	a0,a0,-1244 # 7280 <malloc+0x1fe8>
    4764:	27d000ef          	jal	51e0 <printf>
    4768:	b7d1                	j	472c <run+0x40>

000000000000476a <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    476a:	7139                	addi	sp,sp,-64
    476c:	fc06                	sd	ra,56(sp)
    476e:	f822                	sd	s0,48(sp)
    4770:	f04a                	sd	s2,32(sp)
    4772:	0080                	addi	s0,sp,64
  for (struct test *t = tests; t->s != 0; t++) {
    4774:	00853903          	ld	s2,8(a0)
    4778:	06090463          	beqz	s2,47e0 <runtests+0x76>
    477c:	f426                	sd	s1,40(sp)
    477e:	ec4e                	sd	s3,24(sp)
    4780:	e852                	sd	s4,16(sp)
    4782:	e456                	sd	s5,8(sp)
    4784:	84aa                	mv	s1,a0
    4786:	89ae                	mv	s3,a1
    4788:	8a32                	mv	s4,a2
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s)){
        if(continuous != 2){
    478a:	4a89                	li	s5,2
    478c:	a031                	j	4798 <runtests+0x2e>
  for (struct test *t = tests; t->s != 0; t++) {
    478e:	04c1                	addi	s1,s1,16
    4790:	0084b903          	ld	s2,8(s1)
    4794:	02090c63          	beqz	s2,47cc <runtests+0x62>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    4798:	00098763          	beqz	s3,47a6 <runtests+0x3c>
    479c:	85ce                	mv	a1,s3
    479e:	854a                	mv	a0,s2
    47a0:	2f6000ef          	jal	4a96 <strcmp>
    47a4:	f56d                	bnez	a0,478e <runtests+0x24>
      if(!run(t->f, t->s)){
    47a6:	85ca                	mv	a1,s2
    47a8:	6088                	ld	a0,0(s1)
    47aa:	f43ff0ef          	jal	46ec <run>
    47ae:	f165                	bnez	a0,478e <runtests+0x24>
        if(continuous != 2){
    47b0:	fd5a0fe3          	beq	s4,s5,478e <runtests+0x24>
          printf("SOME TESTS FAILED\n");
    47b4:	00003517          	auipc	a0,0x3
    47b8:	ad450513          	addi	a0,a0,-1324 # 7288 <malloc+0x1ff0>
    47bc:	225000ef          	jal	51e0 <printf>
          return 1;
    47c0:	4505                	li	a0,1
    47c2:	74a2                	ld	s1,40(sp)
    47c4:	69e2                	ld	s3,24(sp)
    47c6:	6a42                	ld	s4,16(sp)
    47c8:	6aa2                	ld	s5,8(sp)
    47ca:	a031                	j	47d6 <runtests+0x6c>
        }
      }
    }
  }
  return 0;
    47cc:	4501                	li	a0,0
    47ce:	74a2                	ld	s1,40(sp)
    47d0:	69e2                	ld	s3,24(sp)
    47d2:	6a42                	ld	s4,16(sp)
    47d4:	6aa2                	ld	s5,8(sp)
}
    47d6:	70e2                	ld	ra,56(sp)
    47d8:	7442                	ld	s0,48(sp)
    47da:	7902                	ld	s2,32(sp)
    47dc:	6121                	addi	sp,sp,64
    47de:	8082                	ret
  return 0;
    47e0:	4501                	li	a0,0
    47e2:	bfd5                	j	47d6 <runtests+0x6c>

00000000000047e4 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    47e4:	7139                	addi	sp,sp,-64
    47e6:	fc06                	sd	ra,56(sp)
    47e8:	f822                	sd	s0,48(sp)
    47ea:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    47ec:	fc840513          	addi	a0,s0,-56
    47f0:	5f6000ef          	jal	4de6 <pipe>
    47f4:	04054f63          	bltz	a0,4852 <countfree+0x6e>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    47f8:	5d6000ef          	jal	4dce <fork>

  if(pid < 0){
    47fc:	06054863          	bltz	a0,486c <countfree+0x88>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    4800:	e551                	bnez	a0,488c <countfree+0xa8>
    4802:	f426                	sd	s1,40(sp)
    4804:	f04a                	sd	s2,32(sp)
    4806:	ec4e                	sd	s3,24(sp)
    4808:	e852                	sd	s4,16(sp)
    close(fds[0]);
    480a:	fc842503          	lw	a0,-56(s0)
    480e:	5f0000ef          	jal	4dfe <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
    4812:	6905                	lui	s2,0x1
      if(a == 0xffffffffffffffff){
    4814:	59fd                	li	s3,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    4816:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    4818:	00001a17          	auipc	s4,0x1
    481c:	c20a0a13          	addi	s4,s4,-992 # 5438 <malloc+0x1a0>
      uint64 a = (uint64) sbrk(4096);
    4820:	854a                	mv	a0,s2
    4822:	63c000ef          	jal	4e5e <sbrk>
      if(a == 0xffffffffffffffff){
    4826:	07350063          	beq	a0,s3,4886 <countfree+0xa2>
      *(char *)(a + 4096 - 1) = 1;
    482a:	954a                	add	a0,a0,s2
    482c:	fe950fa3          	sb	s1,-1(a0)
      if(write(fds[1], "x", 1) != 1){
    4830:	8626                	mv	a2,s1
    4832:	85d2                	mv	a1,s4
    4834:	fcc42503          	lw	a0,-52(s0)
    4838:	5be000ef          	jal	4df6 <write>
    483c:	fe9502e3          	beq	a0,s1,4820 <countfree+0x3c>
        printf("write() failed in countfree()\n");
    4840:	00003517          	auipc	a0,0x3
    4844:	aa050513          	addi	a0,a0,-1376 # 72e0 <malloc+0x2048>
    4848:	199000ef          	jal	51e0 <printf>
        exit(1);
    484c:	4505                	li	a0,1
    484e:	588000ef          	jal	4dd6 <exit>
    4852:	f426                	sd	s1,40(sp)
    4854:	f04a                	sd	s2,32(sp)
    4856:	ec4e                	sd	s3,24(sp)
    4858:	e852                	sd	s4,16(sp)
    printf("pipe() failed in countfree()\n");
    485a:	00003517          	auipc	a0,0x3
    485e:	a4650513          	addi	a0,a0,-1466 # 72a0 <malloc+0x2008>
    4862:	17f000ef          	jal	51e0 <printf>
    exit(1);
    4866:	4505                	li	a0,1
    4868:	56e000ef          	jal	4dd6 <exit>
    486c:	f426                	sd	s1,40(sp)
    486e:	f04a                	sd	s2,32(sp)
    4870:	ec4e                	sd	s3,24(sp)
    4872:	e852                	sd	s4,16(sp)
    printf("fork failed in countfree()\n");
    4874:	00003517          	auipc	a0,0x3
    4878:	a4c50513          	addi	a0,a0,-1460 # 72c0 <malloc+0x2028>
    487c:	165000ef          	jal	51e0 <printf>
    exit(1);
    4880:	4505                	li	a0,1
    4882:	554000ef          	jal	4dd6 <exit>
      }
    }

    exit(0);
    4886:	4501                	li	a0,0
    4888:	54e000ef          	jal	4dd6 <exit>
    488c:	f426                	sd	s1,40(sp)
    488e:	f04a                	sd	s2,32(sp)
    4890:	ec4e                	sd	s3,24(sp)
  }

  close(fds[1]);
    4892:	fcc42503          	lw	a0,-52(s0)
    4896:	568000ef          	jal	4dfe <close>

  int n = 0;
    489a:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    489c:	fc740993          	addi	s3,s0,-57
    48a0:	4905                	li	s2,1
    48a2:	864a                	mv	a2,s2
    48a4:	85ce                	mv	a1,s3
    48a6:	fc842503          	lw	a0,-56(s0)
    48aa:	544000ef          	jal	4dee <read>
    if(cc < 0){
    48ae:	00054563          	bltz	a0,48b8 <countfree+0xd4>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    48b2:	cd09                	beqz	a0,48cc <countfree+0xe8>
      break;
    n += 1;
    48b4:	2485                	addiw	s1,s1,1
  while(1){
    48b6:	b7f5                	j	48a2 <countfree+0xbe>
    48b8:	e852                	sd	s4,16(sp)
      printf("read() failed in countfree()\n");
    48ba:	00003517          	auipc	a0,0x3
    48be:	a4650513          	addi	a0,a0,-1466 # 7300 <malloc+0x2068>
    48c2:	11f000ef          	jal	51e0 <printf>
      exit(1);
    48c6:	4505                	li	a0,1
    48c8:	50e000ef          	jal	4dd6 <exit>
  }

  close(fds[0]);
    48cc:	fc842503          	lw	a0,-56(s0)
    48d0:	52e000ef          	jal	4dfe <close>
  wait((int*)0);
    48d4:	4501                	li	a0,0
    48d6:	508000ef          	jal	4dde <wait>
  
  return n;
}
    48da:	8526                	mv	a0,s1
    48dc:	74a2                	ld	s1,40(sp)
    48de:	7902                	ld	s2,32(sp)
    48e0:	69e2                	ld	s3,24(sp)
    48e2:	70e2                	ld	ra,56(sp)
    48e4:	7442                	ld	s0,48(sp)
    48e6:	6121                	addi	sp,sp,64
    48e8:	8082                	ret

00000000000048ea <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    48ea:	711d                	addi	sp,sp,-96
    48ec:	ec86                	sd	ra,88(sp)
    48ee:	e8a2                	sd	s0,80(sp)
    48f0:	e4a6                	sd	s1,72(sp)
    48f2:	e0ca                	sd	s2,64(sp)
    48f4:	fc4e                	sd	s3,56(sp)
    48f6:	f852                	sd	s4,48(sp)
    48f8:	f456                	sd	s5,40(sp)
    48fa:	f05a                	sd	s6,32(sp)
    48fc:	ec5e                	sd	s7,24(sp)
    48fe:	e862                	sd	s8,16(sp)
    4900:	e466                	sd	s9,8(sp)
    4902:	e06a                	sd	s10,0(sp)
    4904:	1080                	addi	s0,sp,96
    4906:	8aaa                	mv	s5,a0
    4908:	892e                	mv	s2,a1
    490a:	89b2                	mv	s3,a2
  do {
    printf("usertests starting\n");
    490c:	00003b97          	auipc	s7,0x3
    4910:	a14b8b93          	addi	s7,s7,-1516 # 7320 <malloc+0x2088>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone, continuous)) {
    4914:	00004b17          	auipc	s6,0x4
    4918:	6fcb0b13          	addi	s6,s6,1788 # 9010 <quicktests>
      if(continuous != 2) {
    491c:	4a09                	li	s4,2
      }
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      if (runtests(slowtests, justone, continuous)) {
    491e:	00005c17          	auipc	s8,0x5
    4922:	ac2c0c13          	addi	s8,s8,-1342 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    4926:	00003d17          	auipc	s10,0x3
    492a:	a12d0d13          	addi	s10,s10,-1518 # 7338 <malloc+0x20a0>
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    492e:	00003c97          	auipc	s9,0x3
    4932:	a2ac8c93          	addi	s9,s9,-1494 # 7358 <malloc+0x20c0>
    4936:	a819                	j	494c <drivetests+0x62>
        printf("usertests slow tests starting\n");
    4938:	856a                	mv	a0,s10
    493a:	0a7000ef          	jal	51e0 <printf>
    493e:	a80d                	j	4970 <drivetests+0x86>
    if((free1 = countfree()) < free0) {
    4940:	ea5ff0ef          	jal	47e4 <countfree>
    4944:	04954063          	blt	a0,s1,4984 <drivetests+0x9a>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    4948:	04090963          	beqz	s2,499a <drivetests+0xb0>
    printf("usertests starting\n");
    494c:	855e                	mv	a0,s7
    494e:	093000ef          	jal	51e0 <printf>
    int free0 = countfree();
    4952:	e93ff0ef          	jal	47e4 <countfree>
    4956:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone, continuous)) {
    4958:	864a                	mv	a2,s2
    495a:	85ce                	mv	a1,s3
    495c:	855a                	mv	a0,s6
    495e:	e0dff0ef          	jal	476a <runtests>
    4962:	c119                	beqz	a0,4968 <drivetests+0x7e>
      if(continuous != 2) {
    4964:	03491963          	bne	s2,s4,4996 <drivetests+0xac>
    if(!quick) {
    4968:	fc0a9ce3          	bnez	s5,4940 <drivetests+0x56>
      if (justone == 0)
    496c:	fc0986e3          	beqz	s3,4938 <drivetests+0x4e>
      if (runtests(slowtests, justone, continuous)) {
    4970:	864a                	mv	a2,s2
    4972:	85ce                	mv	a1,s3
    4974:	8562                	mv	a0,s8
    4976:	df5ff0ef          	jal	476a <runtests>
    497a:	d179                	beqz	a0,4940 <drivetests+0x56>
        if(continuous != 2) {
    497c:	fd4902e3          	beq	s2,s4,4940 <drivetests+0x56>
          return 1;
    4980:	4505                	li	a0,1
    4982:	a829                	j	499c <drivetests+0xb2>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4984:	8626                	mv	a2,s1
    4986:	85aa                	mv	a1,a0
    4988:	8566                	mv	a0,s9
    498a:	057000ef          	jal	51e0 <printf>
      if(continuous != 2) {
    498e:	fb490fe3          	beq	s2,s4,494c <drivetests+0x62>
        return 1;
    4992:	4505                	li	a0,1
    4994:	a021                	j	499c <drivetests+0xb2>
        return 1;
    4996:	4505                	li	a0,1
    4998:	a011                	j	499c <drivetests+0xb2>
  return 0;
    499a:	854a                	mv	a0,s2
}
    499c:	60e6                	ld	ra,88(sp)
    499e:	6446                	ld	s0,80(sp)
    49a0:	64a6                	ld	s1,72(sp)
    49a2:	6906                	ld	s2,64(sp)
    49a4:	79e2                	ld	s3,56(sp)
    49a6:	7a42                	ld	s4,48(sp)
    49a8:	7aa2                	ld	s5,40(sp)
    49aa:	7b02                	ld	s6,32(sp)
    49ac:	6be2                	ld	s7,24(sp)
    49ae:	6c42                	ld	s8,16(sp)
    49b0:	6ca2                	ld	s9,8(sp)
    49b2:	6d02                	ld	s10,0(sp)
    49b4:	6125                	addi	sp,sp,96
    49b6:	8082                	ret

00000000000049b8 <main>:

int
main(int argc, char *argv[])
{
    49b8:	1101                	addi	sp,sp,-32
    49ba:	ec06                	sd	ra,24(sp)
    49bc:	e822                	sd	s0,16(sp)
    49be:	e426                	sd	s1,8(sp)
    49c0:	e04a                	sd	s2,0(sp)
    49c2:	1000                	addi	s0,sp,32
    49c4:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    49c6:	4789                	li	a5,2
    49c8:	00f50f63          	beq	a0,a5,49e6 <main+0x2e>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    49cc:	4785                	li	a5,1
    49ce:	06a7c063          	blt	a5,a0,4a2e <main+0x76>
  char *justone = 0;
    49d2:	4901                	li	s2,0
  int quick = 0;
    49d4:	4501                	li	a0,0
  int continuous = 0;
    49d6:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    49d8:	864a                	mv	a2,s2
    49da:	f11ff0ef          	jal	48ea <drivetests>
    49de:	c935                	beqz	a0,4a52 <main+0x9a>
    exit(1);
    49e0:	4505                	li	a0,1
    49e2:	3f4000ef          	jal	4dd6 <exit>
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    49e6:	0085b903          	ld	s2,8(a1)
    49ea:	00003597          	auipc	a1,0x3
    49ee:	99e58593          	addi	a1,a1,-1634 # 7388 <malloc+0x20f0>
    49f2:	854a                	mv	a0,s2
    49f4:	0a2000ef          	jal	4a96 <strcmp>
    49f8:	85aa                	mv	a1,a0
    49fa:	c139                	beqz	a0,4a40 <main+0x88>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    49fc:	00003597          	auipc	a1,0x3
    4a00:	99458593          	addi	a1,a1,-1644 # 7390 <malloc+0x20f8>
    4a04:	854a                	mv	a0,s2
    4a06:	090000ef          	jal	4a96 <strcmp>
    4a0a:	cd15                	beqz	a0,4a46 <main+0x8e>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    4a0c:	00003597          	auipc	a1,0x3
    4a10:	98c58593          	addi	a1,a1,-1652 # 7398 <malloc+0x2100>
    4a14:	854a                	mv	a0,s2
    4a16:	080000ef          	jal	4a96 <strcmp>
    4a1a:	c90d                	beqz	a0,4a4c <main+0x94>
  } else if(argc == 2 && argv[1][0] != '-'){
    4a1c:	00094703          	lbu	a4,0(s2) # 1000 <bigdir+0x10a>
    4a20:	02d00793          	li	a5,45
    4a24:	00f70563          	beq	a4,a5,4a2e <main+0x76>
  int quick = 0;
    4a28:	4501                	li	a0,0
  int continuous = 0;
    4a2a:	4581                	li	a1,0
    4a2c:	b775                	j	49d8 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    4a2e:	00003517          	auipc	a0,0x3
    4a32:	97250513          	addi	a0,a0,-1678 # 73a0 <malloc+0x2108>
    4a36:	7aa000ef          	jal	51e0 <printf>
    exit(1);
    4a3a:	4505                	li	a0,1
    4a3c:	39a000ef          	jal	4dd6 <exit>
  char *justone = 0;
    4a40:	4901                	li	s2,0
    quick = 1;
    4a42:	4505                	li	a0,1
    4a44:	bf51                	j	49d8 <main+0x20>
  char *justone = 0;
    4a46:	4901                	li	s2,0
    continuous = 1;
    4a48:	4585                	li	a1,1
    4a4a:	b779                	j	49d8 <main+0x20>
    continuous = 2;
    4a4c:	85a6                	mv	a1,s1
  char *justone = 0;
    4a4e:	4901                	li	s2,0
    4a50:	b761                	j	49d8 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4a52:	00003517          	auipc	a0,0x3
    4a56:	97e50513          	addi	a0,a0,-1666 # 73d0 <malloc+0x2138>
    4a5a:	786000ef          	jal	51e0 <printf>
  exit(0);
    4a5e:	4501                	li	a0,0
    4a60:	376000ef          	jal	4dd6 <exit>

0000000000004a64 <start>:

//
// wrapper so that it's OK if main() does not call exit().
//
void start()
{
    4a64:	1141                	addi	sp,sp,-16
    4a66:	e406                	sd	ra,8(sp)
    4a68:	e022                	sd	s0,0(sp)
    4a6a:	0800                	addi	s0,sp,16
  extern int main();
  main();
    4a6c:	f4dff0ef          	jal	49b8 <main>
  exit(0);
    4a70:	4501                	li	a0,0
    4a72:	364000ef          	jal	4dd6 <exit>

0000000000004a76 <strcpy>:
}

char *
strcpy(char *s, const char *t)
{
    4a76:	1141                	addi	sp,sp,-16
    4a78:	e406                	sd	ra,8(sp)
    4a7a:	e022                	sd	s0,0(sp)
    4a7c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while ((*s++ = *t++) != 0)
    4a7e:	87aa                	mv	a5,a0
    4a80:	0585                	addi	a1,a1,1
    4a82:	0785                	addi	a5,a5,1
    4a84:	fff5c703          	lbu	a4,-1(a1)
    4a88:	fee78fa3          	sb	a4,-1(a5)
    4a8c:	fb75                	bnez	a4,4a80 <strcpy+0xa>
    ;
  return os;
}
    4a8e:	60a2                	ld	ra,8(sp)
    4a90:	6402                	ld	s0,0(sp)
    4a92:	0141                	addi	sp,sp,16
    4a94:	8082                	ret

0000000000004a96 <strcmp>:

int strcmp(const char *p, const char *q)
{
    4a96:	1141                	addi	sp,sp,-16
    4a98:	e406                	sd	ra,8(sp)
    4a9a:	e022                	sd	s0,0(sp)
    4a9c:	0800                	addi	s0,sp,16
  while (*p && *p == *q)
    4a9e:	00054783          	lbu	a5,0(a0)
    4aa2:	cb91                	beqz	a5,4ab6 <strcmp+0x20>
    4aa4:	0005c703          	lbu	a4,0(a1)
    4aa8:	00f71763          	bne	a4,a5,4ab6 <strcmp+0x20>
    p++, q++;
    4aac:	0505                	addi	a0,a0,1
    4aae:	0585                	addi	a1,a1,1
  while (*p && *p == *q)
    4ab0:	00054783          	lbu	a5,0(a0)
    4ab4:	fbe5                	bnez	a5,4aa4 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    4ab6:	0005c503          	lbu	a0,0(a1)
}
    4aba:	40a7853b          	subw	a0,a5,a0
    4abe:	60a2                	ld	ra,8(sp)
    4ac0:	6402                	ld	s0,0(sp)
    4ac2:	0141                	addi	sp,sp,16
    4ac4:	8082                	ret

0000000000004ac6 <strlen>:

uint strlen(const char *s)
{
    4ac6:	1141                	addi	sp,sp,-16
    4ac8:	e406                	sd	ra,8(sp)
    4aca:	e022                	sd	s0,0(sp)
    4acc:	0800                	addi	s0,sp,16
  int n;

  for (n = 0; s[n]; n++)
    4ace:	00054783          	lbu	a5,0(a0)
    4ad2:	cf99                	beqz	a5,4af0 <strlen+0x2a>
    4ad4:	0505                	addi	a0,a0,1
    4ad6:	87aa                	mv	a5,a0
    4ad8:	86be                	mv	a3,a5
    4ada:	0785                	addi	a5,a5,1
    4adc:	fff7c703          	lbu	a4,-1(a5)
    4ae0:	ff65                	bnez	a4,4ad8 <strlen+0x12>
    4ae2:	40a6853b          	subw	a0,a3,a0
    4ae6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    4ae8:	60a2                	ld	ra,8(sp)
    4aea:	6402                	ld	s0,0(sp)
    4aec:	0141                	addi	sp,sp,16
    4aee:	8082                	ret
  for (n = 0; s[n]; n++)
    4af0:	4501                	li	a0,0
    4af2:	bfdd                	j	4ae8 <strlen+0x22>

0000000000004af4 <memset>:

void *
memset(void *dst, int c, uint n)
{
    4af4:	1141                	addi	sp,sp,-16
    4af6:	e406                	sd	ra,8(sp)
    4af8:	e022                	sd	s0,0(sp)
    4afa:	0800                	addi	s0,sp,16
  char *cdst = (char *)dst;
  int i;
  for (i = 0; i < n; i++)
    4afc:	ca19                	beqz	a2,4b12 <memset+0x1e>
    4afe:	87aa                	mv	a5,a0
    4b00:	1602                	slli	a2,a2,0x20
    4b02:	9201                	srli	a2,a2,0x20
    4b04:	00a60733          	add	a4,a2,a0
  {
    cdst[i] = c;
    4b08:	00b78023          	sb	a1,0(a5)
  for (i = 0; i < n; i++)
    4b0c:	0785                	addi	a5,a5,1
    4b0e:	fee79de3          	bne	a5,a4,4b08 <memset+0x14>
  }
  return dst;
}
    4b12:	60a2                	ld	ra,8(sp)
    4b14:	6402                	ld	s0,0(sp)
    4b16:	0141                	addi	sp,sp,16
    4b18:	8082                	ret

0000000000004b1a <strchr>:

char *
strchr(const char *s, char c)
{
    4b1a:	1141                	addi	sp,sp,-16
    4b1c:	e406                	sd	ra,8(sp)
    4b1e:	e022                	sd	s0,0(sp)
    4b20:	0800                	addi	s0,sp,16
  for (; *s; s++)
    4b22:	00054783          	lbu	a5,0(a0)
    4b26:	cf81                	beqz	a5,4b3e <strchr+0x24>
    if (*s == c)
    4b28:	00f58763          	beq	a1,a5,4b36 <strchr+0x1c>
  for (; *s; s++)
    4b2c:	0505                	addi	a0,a0,1
    4b2e:	00054783          	lbu	a5,0(a0)
    4b32:	fbfd                	bnez	a5,4b28 <strchr+0xe>
      return (char *)s;
  return 0;
    4b34:	4501                	li	a0,0
}
    4b36:	60a2                	ld	ra,8(sp)
    4b38:	6402                	ld	s0,0(sp)
    4b3a:	0141                	addi	sp,sp,16
    4b3c:	8082                	ret
  return 0;
    4b3e:	4501                	li	a0,0
    4b40:	bfdd                	j	4b36 <strchr+0x1c>

0000000000004b42 <gets>:

char *
gets(char *buf, int max)
{
    4b42:	7159                	addi	sp,sp,-112
    4b44:	f486                	sd	ra,104(sp)
    4b46:	f0a2                	sd	s0,96(sp)
    4b48:	eca6                	sd	s1,88(sp)
    4b4a:	e8ca                	sd	s2,80(sp)
    4b4c:	e4ce                	sd	s3,72(sp)
    4b4e:	e0d2                	sd	s4,64(sp)
    4b50:	fc56                	sd	s5,56(sp)
    4b52:	f85a                	sd	s6,48(sp)
    4b54:	f45e                	sd	s7,40(sp)
    4b56:	f062                	sd	s8,32(sp)
    4b58:	ec66                	sd	s9,24(sp)
    4b5a:	e86a                	sd	s10,16(sp)
    4b5c:	1880                	addi	s0,sp,112
    4b5e:	8caa                	mv	s9,a0
    4b60:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for (i = 0; i + 1 < max;)
    4b62:	892a                	mv	s2,a0
    4b64:	4481                	li	s1,0
  {
    cc = read(0, &c, 1);
    4b66:	f9f40b13          	addi	s6,s0,-97
    4b6a:	4a85                	li	s5,1
    if (cc < 1)
      break;
    buf[i++] = c;
    if (c == '\n' || c == '\r')
    4b6c:	4ba9                	li	s7,10
    4b6e:	4c35                	li	s8,13
  for (i = 0; i + 1 < max;)
    4b70:	8d26                	mv	s10,s1
    4b72:	0014899b          	addiw	s3,s1,1
    4b76:	84ce                	mv	s1,s3
    4b78:	0349d563          	bge	s3,s4,4ba2 <gets+0x60>
    cc = read(0, &c, 1);
    4b7c:	8656                	mv	a2,s5
    4b7e:	85da                	mv	a1,s6
    4b80:	4501                	li	a0,0
    4b82:	26c000ef          	jal	4dee <read>
    if (cc < 1)
    4b86:	00a05e63          	blez	a0,4ba2 <gets+0x60>
    buf[i++] = c;
    4b8a:	f9f44783          	lbu	a5,-97(s0)
    4b8e:	00f90023          	sb	a5,0(s2)
    if (c == '\n' || c == '\r')
    4b92:	01778763          	beq	a5,s7,4ba0 <gets+0x5e>
    4b96:	0905                	addi	s2,s2,1
    4b98:	fd879ce3          	bne	a5,s8,4b70 <gets+0x2e>
    buf[i++] = c;
    4b9c:	8d4e                	mv	s10,s3
    4b9e:	a011                	j	4ba2 <gets+0x60>
    4ba0:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
    4ba2:	9d66                	add	s10,s10,s9
    4ba4:	000d0023          	sb	zero,0(s10)
  return buf;
}
    4ba8:	8566                	mv	a0,s9
    4baa:	70a6                	ld	ra,104(sp)
    4bac:	7406                	ld	s0,96(sp)
    4bae:	64e6                	ld	s1,88(sp)
    4bb0:	6946                	ld	s2,80(sp)
    4bb2:	69a6                	ld	s3,72(sp)
    4bb4:	6a06                	ld	s4,64(sp)
    4bb6:	7ae2                	ld	s5,56(sp)
    4bb8:	7b42                	ld	s6,48(sp)
    4bba:	7ba2                	ld	s7,40(sp)
    4bbc:	7c02                	ld	s8,32(sp)
    4bbe:	6ce2                	ld	s9,24(sp)
    4bc0:	6d42                	ld	s10,16(sp)
    4bc2:	6165                	addi	sp,sp,112
    4bc4:	8082                	ret

0000000000004bc6 <stat>:

int stat(const char *n, struct stat *st)
{
    4bc6:	1101                	addi	sp,sp,-32
    4bc8:	ec06                	sd	ra,24(sp)
    4bca:	e822                	sd	s0,16(sp)
    4bcc:	e04a                	sd	s2,0(sp)
    4bce:	1000                	addi	s0,sp,32
    4bd0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4bd2:	4581                	li	a1,0
    4bd4:	242000ef          	jal	4e16 <open>
  if (fd < 0)
    4bd8:	02054263          	bltz	a0,4bfc <stat+0x36>
    4bdc:	e426                	sd	s1,8(sp)
    4bde:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    4be0:	85ca                	mv	a1,s2
    4be2:	24c000ef          	jal	4e2e <fstat>
    4be6:	892a                	mv	s2,a0
  close(fd);
    4be8:	8526                	mv	a0,s1
    4bea:	214000ef          	jal	4dfe <close>
  return r;
    4bee:	64a2                	ld	s1,8(sp)
}
    4bf0:	854a                	mv	a0,s2
    4bf2:	60e2                	ld	ra,24(sp)
    4bf4:	6442                	ld	s0,16(sp)
    4bf6:	6902                	ld	s2,0(sp)
    4bf8:	6105                	addi	sp,sp,32
    4bfa:	8082                	ret
    return -1;
    4bfc:	597d                	li	s2,-1
    4bfe:	bfcd                	j	4bf0 <stat+0x2a>

0000000000004c00 <atoi>:

int atoi(const char *s)
{
    4c00:	1141                	addi	sp,sp,-16
    4c02:	e406                	sd	ra,8(sp)
    4c04:	e022                	sd	s0,0(sp)
    4c06:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while ('0' <= *s && *s <= '9')
    4c08:	00054683          	lbu	a3,0(a0)
    4c0c:	fd06879b          	addiw	a5,a3,-48
    4c10:	0ff7f793          	zext.b	a5,a5
    4c14:	4625                	li	a2,9
    4c16:	02f66963          	bltu	a2,a5,4c48 <atoi+0x48>
    4c1a:	872a                	mv	a4,a0
  n = 0;
    4c1c:	4501                	li	a0,0
    n = n * 10 + *s++ - '0';
    4c1e:	0705                	addi	a4,a4,1
    4c20:	0025179b          	slliw	a5,a0,0x2
    4c24:	9fa9                	addw	a5,a5,a0
    4c26:	0017979b          	slliw	a5,a5,0x1
    4c2a:	9fb5                	addw	a5,a5,a3
    4c2c:	fd07851b          	addiw	a0,a5,-48
  while ('0' <= *s && *s <= '9')
    4c30:	00074683          	lbu	a3,0(a4)
    4c34:	fd06879b          	addiw	a5,a3,-48
    4c38:	0ff7f793          	zext.b	a5,a5
    4c3c:	fef671e3          	bgeu	a2,a5,4c1e <atoi+0x1e>
  return n;
}
    4c40:	60a2                	ld	ra,8(sp)
    4c42:	6402                	ld	s0,0(sp)
    4c44:	0141                	addi	sp,sp,16
    4c46:	8082                	ret
  n = 0;
    4c48:	4501                	li	a0,0
    4c4a:	bfdd                	j	4c40 <atoi+0x40>

0000000000004c4c <memmove>:

void *
memmove(void *vdst, const void *vsrc, int n)
{
    4c4c:	1141                	addi	sp,sp,-16
    4c4e:	e406                	sd	ra,8(sp)
    4c50:	e022                	sd	s0,0(sp)
    4c52:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst)
    4c54:	02b57563          	bgeu	a0,a1,4c7e <memmove+0x32>
  {
    while (n-- > 0)
    4c58:	00c05f63          	blez	a2,4c76 <memmove+0x2a>
    4c5c:	1602                	slli	a2,a2,0x20
    4c5e:	9201                	srli	a2,a2,0x20
    4c60:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    4c64:	872a                	mv	a4,a0
      *dst++ = *src++;
    4c66:	0585                	addi	a1,a1,1
    4c68:	0705                	addi	a4,a4,1
    4c6a:	fff5c683          	lbu	a3,-1(a1)
    4c6e:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0)
    4c72:	fee79ae3          	bne	a5,a4,4c66 <memmove+0x1a>
    src += n;
    while (n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    4c76:	60a2                	ld	ra,8(sp)
    4c78:	6402                	ld	s0,0(sp)
    4c7a:	0141                	addi	sp,sp,16
    4c7c:	8082                	ret
    dst += n;
    4c7e:	00c50733          	add	a4,a0,a2
    src += n;
    4c82:	95b2                	add	a1,a1,a2
    while (n-- > 0)
    4c84:	fec059e3          	blez	a2,4c76 <memmove+0x2a>
    4c88:	fff6079b          	addiw	a5,a2,-1 # 2fff <subdir+0x303>
    4c8c:	1782                	slli	a5,a5,0x20
    4c8e:	9381                	srli	a5,a5,0x20
    4c90:	fff7c793          	not	a5,a5
    4c94:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4c96:	15fd                	addi	a1,a1,-1
    4c98:	177d                	addi	a4,a4,-1
    4c9a:	0005c683          	lbu	a3,0(a1)
    4c9e:	00d70023          	sb	a3,0(a4)
    while (n-- > 0)
    4ca2:	fef71ae3          	bne	a4,a5,4c96 <memmove+0x4a>
    4ca6:	bfc1                	j	4c76 <memmove+0x2a>

0000000000004ca8 <memcmp>:

int memcmp(const void *s1, const void *s2, uint n)
{
    4ca8:	1141                	addi	sp,sp,-16
    4caa:	e406                	sd	ra,8(sp)
    4cac:	e022                	sd	s0,0(sp)
    4cae:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0)
    4cb0:	ca0d                	beqz	a2,4ce2 <memcmp+0x3a>
    4cb2:	fff6069b          	addiw	a3,a2,-1
    4cb6:	1682                	slli	a3,a3,0x20
    4cb8:	9281                	srli	a3,a3,0x20
    4cba:	0685                	addi	a3,a3,1
    4cbc:	96aa                	add	a3,a3,a0
  {
    if (*p1 != *p2)
    4cbe:	00054783          	lbu	a5,0(a0)
    4cc2:	0005c703          	lbu	a4,0(a1)
    4cc6:	00e79863          	bne	a5,a4,4cd6 <memcmp+0x2e>
    {
      return *p1 - *p2;
    }
    p1++;
    4cca:	0505                	addi	a0,a0,1
    p2++;
    4ccc:	0585                	addi	a1,a1,1
  while (n-- > 0)
    4cce:	fed518e3          	bne	a0,a3,4cbe <memcmp+0x16>
  }
  return 0;
    4cd2:	4501                	li	a0,0
    4cd4:	a019                	j	4cda <memcmp+0x32>
      return *p1 - *p2;
    4cd6:	40e7853b          	subw	a0,a5,a4
}
    4cda:	60a2                	ld	ra,8(sp)
    4cdc:	6402                	ld	s0,0(sp)
    4cde:	0141                	addi	sp,sp,16
    4ce0:	8082                	ret
  return 0;
    4ce2:	4501                	li	a0,0
    4ce4:	bfdd                	j	4cda <memcmp+0x32>

0000000000004ce6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4ce6:	1141                	addi	sp,sp,-16
    4ce8:	e406                	sd	ra,8(sp)
    4cea:	e022                	sd	s0,0(sp)
    4cec:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    4cee:	f5fff0ef          	jal	4c4c <memmove>
}
    4cf2:	60a2                	ld	ra,8(sp)
    4cf4:	6402                	ld	s0,0(sp)
    4cf6:	0141                	addi	sp,sp,16
    4cf8:	8082                	ret

0000000000004cfa <strcat>:

char *strcat(char *dst, const char *src)
{
    4cfa:	1141                	addi	sp,sp,-16
    4cfc:	e406                	sd	ra,8(sp)
    4cfe:	e022                	sd	s0,0(sp)
    4d00:	0800                	addi	s0,sp,16
  char *p = dst;

  while (*p)
    4d02:	00054783          	lbu	a5,0(a0)
    4d06:	c795                	beqz	a5,4d32 <strcat+0x38>
  char *p = dst;
    4d08:	87aa                	mv	a5,a0
    p++;
    4d0a:	0785                	addi	a5,a5,1
  while (*p)
    4d0c:	0007c703          	lbu	a4,0(a5)
    4d10:	ff6d                	bnez	a4,4d0a <strcat+0x10>

  // copy src into dst starting at the end
  while (*src)
    4d12:	0005c703          	lbu	a4,0(a1)
    4d16:	cb01                	beqz	a4,4d26 <strcat+0x2c>
  {
    *p = *src;
    4d18:	00e78023          	sb	a4,0(a5)
    p++;
    4d1c:	0785                	addi	a5,a5,1
    src++;
    4d1e:	0585                	addi	a1,a1,1
  while (*src)
    4d20:	0005c703          	lbu	a4,0(a1)
    4d24:	fb75                	bnez	a4,4d18 <strcat+0x1e>
  }

  *p = 0;
    4d26:	00078023          	sb	zero,0(a5)

  return dst;
}
    4d2a:	60a2                	ld	ra,8(sp)
    4d2c:	6402                	ld	s0,0(sp)
    4d2e:	0141                	addi	sp,sp,16
    4d30:	8082                	ret
  char *p = dst;
    4d32:	87aa                	mv	a5,a0
    4d34:	bff9                	j	4d12 <strcat+0x18>

0000000000004d36 <isdir>:

int isdir(char *path)
{
    4d36:	7179                	addi	sp,sp,-48
    4d38:	f406                	sd	ra,40(sp)
    4d3a:	f022                	sd	s0,32(sp)
    4d3c:	1800                	addi	s0,sp,48
  struct stat st;
  if (stat(path, &st) < 0)
    4d3e:	fd840593          	addi	a1,s0,-40
    4d42:	e85ff0ef          	jal	4bc6 <stat>
    4d46:	00054b63          	bltz	a0,4d5c <isdir+0x26>
    return 0;
  return st.type == T_DIR;
    4d4a:	fe041503          	lh	a0,-32(s0)
    4d4e:	157d                	addi	a0,a0,-1
    4d50:	00153513          	seqz	a0,a0
}
    4d54:	70a2                	ld	ra,40(sp)
    4d56:	7402                	ld	s0,32(sp)
    4d58:	6145                	addi	sp,sp,48
    4d5a:	8082                	ret
    return 0;
    4d5c:	4501                	li	a0,0
    4d5e:	bfdd                	j	4d54 <isdir+0x1e>

0000000000004d60 <joinpath>:

char *joinpath(char *dir, char *filename, char *out_buffer, int bufsize)
{
    4d60:	7139                	addi	sp,sp,-64
    4d62:	fc06                	sd	ra,56(sp)
    4d64:	f822                	sd	s0,48(sp)
    4d66:	f426                	sd	s1,40(sp)
    4d68:	f04a                	sd	s2,32(sp)
    4d6a:	ec4e                	sd	s3,24(sp)
    4d6c:	e852                	sd	s4,16(sp)
    4d6e:	e456                	sd	s5,8(sp)
    4d70:	0080                	addi	s0,sp,64
    4d72:	89aa                	mv	s3,a0
    4d74:	8aae                	mv	s5,a1
    4d76:	84b2                	mv	s1,a2
    4d78:	8a36                	mv	s4,a3
  int dn = strlen(dir);
    4d7a:	d4dff0ef          	jal	4ac6 <strlen>
    4d7e:	892a                	mv	s2,a0
  int nn = strlen(filename);
    4d80:	8556                	mv	a0,s5
    4d82:	d45ff0ef          	jal	4ac6 <strlen>
  int need = dn + 1 + nn + 1;
    4d86:	0019079b          	addiw	a5,s2,1
  if (need > bufsize)
    4d8a:	9fa9                	addw	a5,a5,a0
    return 0;
    4d8c:	4501                	li	a0,0
  if (need > bufsize)
    4d8e:	0347d763          	bge	a5,s4,4dbc <joinpath+0x5c>
  strcpy(out_buffer, dir);
    4d92:	85ce                	mv	a1,s3
    4d94:	8526                	mv	a0,s1
    4d96:	ce1ff0ef          	jal	4a76 <strcpy>
  if (dir[dn - 1] != '/')
    4d9a:	99ca                	add	s3,s3,s2
    4d9c:	fff9c703          	lbu	a4,-1(s3)
    4da0:	02f00793          	li	a5,47
    4da4:	00f70763          	beq	a4,a5,4db2 <joinpath+0x52>
  {
    out_buffer[dn] = '/';
    4da8:	9926                	add	s2,s2,s1
    4daa:	00f90023          	sb	a5,0(s2)
    out_buffer[dn + 1] = 0;
    4dae:	000900a3          	sb	zero,1(s2)
  }
  strcat(out_buffer, filename);
    4db2:	85d6                	mv	a1,s5
    4db4:	8526                	mv	a0,s1
    4db6:	f45ff0ef          	jal	4cfa <strcat>
  return out_buffer;
    4dba:	8526                	mv	a0,s1
}
    4dbc:	70e2                	ld	ra,56(sp)
    4dbe:	7442                	ld	s0,48(sp)
    4dc0:	74a2                	ld	s1,40(sp)
    4dc2:	7902                	ld	s2,32(sp)
    4dc4:	69e2                	ld	s3,24(sp)
    4dc6:	6a42                	ld	s4,16(sp)
    4dc8:	6aa2                	ld	s5,8(sp)
    4dca:	6121                	addi	sp,sp,64
    4dcc:	8082                	ret

0000000000004dce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    4dce:	4885                	li	a7,1
 ecall
    4dd0:	00000073          	ecall
 ret
    4dd4:	8082                	ret

0000000000004dd6 <exit>:
.global exit
exit:
 li a7, SYS_exit
    4dd6:	4889                	li	a7,2
 ecall
    4dd8:	00000073          	ecall
 ret
    4ddc:	8082                	ret

0000000000004dde <wait>:
.global wait
wait:
 li a7, SYS_wait
    4dde:	488d                	li	a7,3
 ecall
    4de0:	00000073          	ecall
 ret
    4de4:	8082                	ret

0000000000004de6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4de6:	4891                	li	a7,4
 ecall
    4de8:	00000073          	ecall
 ret
    4dec:	8082                	ret

0000000000004dee <read>:
.global read
read:
 li a7, SYS_read
    4dee:	4895                	li	a7,5
 ecall
    4df0:	00000073          	ecall
 ret
    4df4:	8082                	ret

0000000000004df6 <write>:
.global write
write:
 li a7, SYS_write
    4df6:	48c1                	li	a7,16
 ecall
    4df8:	00000073          	ecall
 ret
    4dfc:	8082                	ret

0000000000004dfe <close>:
.global close
close:
 li a7, SYS_close
    4dfe:	48d5                	li	a7,21
 ecall
    4e00:	00000073          	ecall
 ret
    4e04:	8082                	ret

0000000000004e06 <kill>:
.global kill
kill:
 li a7, SYS_kill
    4e06:	4899                	li	a7,6
 ecall
    4e08:	00000073          	ecall
 ret
    4e0c:	8082                	ret

0000000000004e0e <exec>:
.global exec
exec:
 li a7, SYS_exec
    4e0e:	489d                	li	a7,7
 ecall
    4e10:	00000073          	ecall
 ret
    4e14:	8082                	ret

0000000000004e16 <open>:
.global open
open:
 li a7, SYS_open
    4e16:	48bd                	li	a7,15
 ecall
    4e18:	00000073          	ecall
 ret
    4e1c:	8082                	ret

0000000000004e1e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4e1e:	48c5                	li	a7,17
 ecall
    4e20:	00000073          	ecall
 ret
    4e24:	8082                	ret

0000000000004e26 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4e26:	48c9                	li	a7,18
 ecall
    4e28:	00000073          	ecall
 ret
    4e2c:	8082                	ret

0000000000004e2e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4e2e:	48a1                	li	a7,8
 ecall
    4e30:	00000073          	ecall
 ret
    4e34:	8082                	ret

0000000000004e36 <link>:
.global link
link:
 li a7, SYS_link
    4e36:	48cd                	li	a7,19
 ecall
    4e38:	00000073          	ecall
 ret
    4e3c:	8082                	ret

0000000000004e3e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4e3e:	48d1                	li	a7,20
 ecall
    4e40:	00000073          	ecall
 ret
    4e44:	8082                	ret

0000000000004e46 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4e46:	48a5                	li	a7,9
 ecall
    4e48:	00000073          	ecall
 ret
    4e4c:	8082                	ret

0000000000004e4e <dup>:
.global dup
dup:
 li a7, SYS_dup
    4e4e:	48a9                	li	a7,10
 ecall
    4e50:	00000073          	ecall
 ret
    4e54:	8082                	ret

0000000000004e56 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4e56:	48ad                	li	a7,11
 ecall
    4e58:	00000073          	ecall
 ret
    4e5c:	8082                	ret

0000000000004e5e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    4e5e:	48b1                	li	a7,12
 ecall
    4e60:	00000073          	ecall
 ret
    4e64:	8082                	ret

0000000000004e66 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    4e66:	48b5                	li	a7,13
 ecall
    4e68:	00000073          	ecall
 ret
    4e6c:	8082                	ret

0000000000004e6e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4e6e:	48b9                	li	a7,14
 ecall
    4e70:	00000073          	ecall
 ret
    4e74:	8082                	ret

0000000000004e76 <get_keystrokes_count>:
.global get_keystrokes_count
get_keystrokes_count:
 li a7, SYS_get_keystrokes_count
    4e76:	48d9                	li	a7,22
 ecall
    4e78:	00000073          	ecall
 ret
    4e7c:	8082                	ret

0000000000004e7e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4e7e:	1101                	addi	sp,sp,-32
    4e80:	ec06                	sd	ra,24(sp)
    4e82:	e822                	sd	s0,16(sp)
    4e84:	1000                	addi	s0,sp,32
    4e86:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4e8a:	4605                	li	a2,1
    4e8c:	fef40593          	addi	a1,s0,-17
    4e90:	f67ff0ef          	jal	4df6 <write>
}
    4e94:	60e2                	ld	ra,24(sp)
    4e96:	6442                	ld	s0,16(sp)
    4e98:	6105                	addi	sp,sp,32
    4e9a:	8082                	ret

0000000000004e9c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4e9c:	7139                	addi	sp,sp,-64
    4e9e:	fc06                	sd	ra,56(sp)
    4ea0:	f822                	sd	s0,48(sp)
    4ea2:	f426                	sd	s1,40(sp)
    4ea4:	f04a                	sd	s2,32(sp)
    4ea6:	ec4e                	sd	s3,24(sp)
    4ea8:	0080                	addi	s0,sp,64
    4eaa:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4eac:	c299                	beqz	a3,4eb2 <printint+0x16>
    4eae:	0605ce63          	bltz	a1,4f2a <printint+0x8e>
  neg = 0;
    4eb2:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    4eb4:	fc040313          	addi	t1,s0,-64
  neg = 0;
    4eb8:	869a                	mv	a3,t1
  i = 0;
    4eba:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
    4ebc:	00003817          	auipc	a6,0x3
    4ec0:	8e480813          	addi	a6,a6,-1820 # 77a0 <digits>
    4ec4:	88be                	mv	a7,a5
    4ec6:	0017851b          	addiw	a0,a5,1
    4eca:	87aa                	mv	a5,a0
    4ecc:	02c5f73b          	remuw	a4,a1,a2
    4ed0:	1702                	slli	a4,a4,0x20
    4ed2:	9301                	srli	a4,a4,0x20
    4ed4:	9742                	add	a4,a4,a6
    4ed6:	00074703          	lbu	a4,0(a4)
    4eda:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
    4ede:	872e                	mv	a4,a1
    4ee0:	02c5d5bb          	divuw	a1,a1,a2
    4ee4:	0685                	addi	a3,a3,1
    4ee6:	fcc77fe3          	bgeu	a4,a2,4ec4 <printint+0x28>
  if(neg)
    4eea:	000e0c63          	beqz	t3,4f02 <printint+0x66>
    buf[i++] = '-';
    4eee:	fd050793          	addi	a5,a0,-48
    4ef2:	00878533          	add	a0,a5,s0
    4ef6:	02d00793          	li	a5,45
    4efa:	fef50823          	sb	a5,-16(a0)
    4efe:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    4f02:	fff7899b          	addiw	s3,a5,-1
    4f06:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
    4f0a:	fff4c583          	lbu	a1,-1(s1)
    4f0e:	854a                	mv	a0,s2
    4f10:	f6fff0ef          	jal	4e7e <putc>
  while(--i >= 0)
    4f14:	39fd                	addiw	s3,s3,-1
    4f16:	14fd                	addi	s1,s1,-1
    4f18:	fe09d9e3          	bgez	s3,4f0a <printint+0x6e>
}
    4f1c:	70e2                	ld	ra,56(sp)
    4f1e:	7442                	ld	s0,48(sp)
    4f20:	74a2                	ld	s1,40(sp)
    4f22:	7902                	ld	s2,32(sp)
    4f24:	69e2                	ld	s3,24(sp)
    4f26:	6121                	addi	sp,sp,64
    4f28:	8082                	ret
    x = -xx;
    4f2a:	40b005bb          	negw	a1,a1
    neg = 1;
    4f2e:	4e05                	li	t3,1
    x = -xx;
    4f30:	b751                	j	4eb4 <printint+0x18>

0000000000004f32 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    4f32:	711d                	addi	sp,sp,-96
    4f34:	ec86                	sd	ra,88(sp)
    4f36:	e8a2                	sd	s0,80(sp)
    4f38:	e4a6                	sd	s1,72(sp)
    4f3a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    4f3c:	0005c483          	lbu	s1,0(a1)
    4f40:	26048663          	beqz	s1,51ac <vprintf+0x27a>
    4f44:	e0ca                	sd	s2,64(sp)
    4f46:	fc4e                	sd	s3,56(sp)
    4f48:	f852                	sd	s4,48(sp)
    4f4a:	f456                	sd	s5,40(sp)
    4f4c:	f05a                	sd	s6,32(sp)
    4f4e:	ec5e                	sd	s7,24(sp)
    4f50:	e862                	sd	s8,16(sp)
    4f52:	e466                	sd	s9,8(sp)
    4f54:	8b2a                	mv	s6,a0
    4f56:	8a2e                	mv	s4,a1
    4f58:	8bb2                	mv	s7,a2
  state = 0;
    4f5a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    4f5c:	4901                	li	s2,0
    4f5e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    4f60:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    4f64:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    4f68:	06c00c93          	li	s9,108
    4f6c:	a00d                	j	4f8e <vprintf+0x5c>
        putc(fd, c0);
    4f6e:	85a6                	mv	a1,s1
    4f70:	855a                	mv	a0,s6
    4f72:	f0dff0ef          	jal	4e7e <putc>
    4f76:	a019                	j	4f7c <vprintf+0x4a>
    } else if(state == '%'){
    4f78:	03598363          	beq	s3,s5,4f9e <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
    4f7c:	0019079b          	addiw	a5,s2,1
    4f80:	893e                	mv	s2,a5
    4f82:	873e                	mv	a4,a5
    4f84:	97d2                	add	a5,a5,s4
    4f86:	0007c483          	lbu	s1,0(a5)
    4f8a:	20048963          	beqz	s1,519c <vprintf+0x26a>
    c0 = fmt[i] & 0xff;
    4f8e:	0004879b          	sext.w	a5,s1
    if(state == 0){
    4f92:	fe0993e3          	bnez	s3,4f78 <vprintf+0x46>
      if(c0 == '%'){
    4f96:	fd579ce3          	bne	a5,s5,4f6e <vprintf+0x3c>
        state = '%';
    4f9a:	89be                	mv	s3,a5
    4f9c:	b7c5                	j	4f7c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    4f9e:	00ea06b3          	add	a3,s4,a4
    4fa2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    4fa6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    4fa8:	c681                	beqz	a3,4fb0 <vprintf+0x7e>
    4faa:	9752                	add	a4,a4,s4
    4fac:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    4fb0:	03878e63          	beq	a5,s8,4fec <vprintf+0xba>
      } else if(c0 == 'l' && c1 == 'd'){
    4fb4:	05978863          	beq	a5,s9,5004 <vprintf+0xd2>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    4fb8:	07500713          	li	a4,117
    4fbc:	0ee78263          	beq	a5,a4,50a0 <vprintf+0x16e>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    4fc0:	07800713          	li	a4,120
    4fc4:	12e78463          	beq	a5,a4,50ec <vprintf+0x1ba>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    4fc8:	07000713          	li	a4,112
    4fcc:	14e78963          	beq	a5,a4,511e <vprintf+0x1ec>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 's'){
    4fd0:	07300713          	li	a4,115
    4fd4:	18e78863          	beq	a5,a4,5164 <vprintf+0x232>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    4fd8:	02500713          	li	a4,37
    4fdc:	04e79463          	bne	a5,a4,5024 <vprintf+0xf2>
        putc(fd, '%');
    4fe0:	85ba                	mv	a1,a4
    4fe2:	855a                	mv	a0,s6
    4fe4:	e9bff0ef          	jal	4e7e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
#endif
      state = 0;
    4fe8:	4981                	li	s3,0
    4fea:	bf49                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    4fec:	008b8493          	addi	s1,s7,8
    4ff0:	4685                	li	a3,1
    4ff2:	4629                	li	a2,10
    4ff4:	000ba583          	lw	a1,0(s7)
    4ff8:	855a                	mv	a0,s6
    4ffa:	ea3ff0ef          	jal	4e9c <printint>
    4ffe:	8ba6                	mv	s7,s1
      state = 0;
    5000:	4981                	li	s3,0
    5002:	bfad                	j	4f7c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    5004:	06400793          	li	a5,100
    5008:	02f68963          	beq	a3,a5,503a <vprintf+0x108>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    500c:	06c00793          	li	a5,108
    5010:	04f68263          	beq	a3,a5,5054 <vprintf+0x122>
      } else if(c0 == 'l' && c1 == 'u'){
    5014:	07500793          	li	a5,117
    5018:	0af68063          	beq	a3,a5,50b8 <vprintf+0x186>
      } else if(c0 == 'l' && c1 == 'x'){
    501c:	07800793          	li	a5,120
    5020:	0ef68263          	beq	a3,a5,5104 <vprintf+0x1d2>
        putc(fd, '%');
    5024:	02500593          	li	a1,37
    5028:	855a                	mv	a0,s6
    502a:	e55ff0ef          	jal	4e7e <putc>
        putc(fd, c0);
    502e:	85a6                	mv	a1,s1
    5030:	855a                	mv	a0,s6
    5032:	e4dff0ef          	jal	4e7e <putc>
      state = 0;
    5036:	4981                	li	s3,0
    5038:	b791                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    503a:	008b8493          	addi	s1,s7,8
    503e:	4685                	li	a3,1
    5040:	4629                	li	a2,10
    5042:	000ba583          	lw	a1,0(s7)
    5046:	855a                	mv	a0,s6
    5048:	e55ff0ef          	jal	4e9c <printint>
        i += 1;
    504c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    504e:	8ba6                	mv	s7,s1
      state = 0;
    5050:	4981                	li	s3,0
        i += 1;
    5052:	b72d                	j	4f7c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    5054:	06400793          	li	a5,100
    5058:	02f60763          	beq	a2,a5,5086 <vprintf+0x154>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    505c:	07500793          	li	a5,117
    5060:	06f60963          	beq	a2,a5,50d2 <vprintf+0x1a0>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    5064:	07800793          	li	a5,120
    5068:	faf61ee3          	bne	a2,a5,5024 <vprintf+0xf2>
        printint(fd, va_arg(ap, uint64), 16, 0);
    506c:	008b8493          	addi	s1,s7,8
    5070:	4681                	li	a3,0
    5072:	4641                	li	a2,16
    5074:	000ba583          	lw	a1,0(s7)
    5078:	855a                	mv	a0,s6
    507a:	e23ff0ef          	jal	4e9c <printint>
        i += 2;
    507e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    5080:	8ba6                	mv	s7,s1
      state = 0;
    5082:	4981                	li	s3,0
        i += 2;
    5084:	bde5                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5086:	008b8493          	addi	s1,s7,8
    508a:	4685                	li	a3,1
    508c:	4629                	li	a2,10
    508e:	000ba583          	lw	a1,0(s7)
    5092:	855a                	mv	a0,s6
    5094:	e09ff0ef          	jal	4e9c <printint>
        i += 2;
    5098:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    509a:	8ba6                	mv	s7,s1
      state = 0;
    509c:	4981                	li	s3,0
        i += 2;
    509e:	bdf9                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 0);
    50a0:	008b8493          	addi	s1,s7,8
    50a4:	4681                	li	a3,0
    50a6:	4629                	li	a2,10
    50a8:	000ba583          	lw	a1,0(s7)
    50ac:	855a                	mv	a0,s6
    50ae:	defff0ef          	jal	4e9c <printint>
    50b2:	8ba6                	mv	s7,s1
      state = 0;
    50b4:	4981                	li	s3,0
    50b6:	b5d9                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    50b8:	008b8493          	addi	s1,s7,8
    50bc:	4681                	li	a3,0
    50be:	4629                	li	a2,10
    50c0:	000ba583          	lw	a1,0(s7)
    50c4:	855a                	mv	a0,s6
    50c6:	dd7ff0ef          	jal	4e9c <printint>
        i += 1;
    50ca:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    50cc:	8ba6                	mv	s7,s1
      state = 0;
    50ce:	4981                	li	s3,0
        i += 1;
    50d0:	b575                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    50d2:	008b8493          	addi	s1,s7,8
    50d6:	4681                	li	a3,0
    50d8:	4629                	li	a2,10
    50da:	000ba583          	lw	a1,0(s7)
    50de:	855a                	mv	a0,s6
    50e0:	dbdff0ef          	jal	4e9c <printint>
        i += 2;
    50e4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    50e6:	8ba6                	mv	s7,s1
      state = 0;
    50e8:	4981                	li	s3,0
        i += 2;
    50ea:	bd49                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 16, 0);
    50ec:	008b8493          	addi	s1,s7,8
    50f0:	4681                	li	a3,0
    50f2:	4641                	li	a2,16
    50f4:	000ba583          	lw	a1,0(s7)
    50f8:	855a                	mv	a0,s6
    50fa:	da3ff0ef          	jal	4e9c <printint>
    50fe:	8ba6                	mv	s7,s1
      state = 0;
    5100:	4981                	li	s3,0
    5102:	bdad                	j	4f7c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    5104:	008b8493          	addi	s1,s7,8
    5108:	4681                	li	a3,0
    510a:	4641                	li	a2,16
    510c:	000ba583          	lw	a1,0(s7)
    5110:	855a                	mv	a0,s6
    5112:	d8bff0ef          	jal	4e9c <printint>
        i += 1;
    5116:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    5118:	8ba6                	mv	s7,s1
      state = 0;
    511a:	4981                	li	s3,0
        i += 1;
    511c:	b585                	j	4f7c <vprintf+0x4a>
    511e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    5120:	008b8d13          	addi	s10,s7,8
    5124:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5128:	03000593          	li	a1,48
    512c:	855a                	mv	a0,s6
    512e:	d51ff0ef          	jal	4e7e <putc>
  putc(fd, 'x');
    5132:	07800593          	li	a1,120
    5136:	855a                	mv	a0,s6
    5138:	d47ff0ef          	jal	4e7e <putc>
    513c:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    513e:	00002b97          	auipc	s7,0x2
    5142:	662b8b93          	addi	s7,s7,1634 # 77a0 <digits>
    5146:	03c9d793          	srli	a5,s3,0x3c
    514a:	97de                	add	a5,a5,s7
    514c:	0007c583          	lbu	a1,0(a5)
    5150:	855a                	mv	a0,s6
    5152:	d2dff0ef          	jal	4e7e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5156:	0992                	slli	s3,s3,0x4
    5158:	34fd                	addiw	s1,s1,-1
    515a:	f4f5                	bnez	s1,5146 <vprintf+0x214>
        printptr(fd, va_arg(ap, uint64));
    515c:	8bea                	mv	s7,s10
      state = 0;
    515e:	4981                	li	s3,0
    5160:	6d02                	ld	s10,0(sp)
    5162:	bd29                	j	4f7c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    5164:	008b8993          	addi	s3,s7,8
    5168:	000bb483          	ld	s1,0(s7)
    516c:	cc91                	beqz	s1,5188 <vprintf+0x256>
        for(; *s; s++)
    516e:	0004c583          	lbu	a1,0(s1)
    5172:	c195                	beqz	a1,5196 <vprintf+0x264>
          putc(fd, *s);
    5174:	855a                	mv	a0,s6
    5176:	d09ff0ef          	jal	4e7e <putc>
        for(; *s; s++)
    517a:	0485                	addi	s1,s1,1
    517c:	0004c583          	lbu	a1,0(s1)
    5180:	f9f5                	bnez	a1,5174 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
    5182:	8bce                	mv	s7,s3
      state = 0;
    5184:	4981                	li	s3,0
    5186:	bbdd                	j	4f7c <vprintf+0x4a>
          s = "(null)";
    5188:	00002497          	auipc	s1,0x2
    518c:	59848493          	addi	s1,s1,1432 # 7720 <malloc+0x2488>
        for(; *s; s++)
    5190:	02800593          	li	a1,40
    5194:	b7c5                	j	5174 <vprintf+0x242>
        if((s = va_arg(ap, char*)) == 0)
    5196:	8bce                	mv	s7,s3
      state = 0;
    5198:	4981                	li	s3,0
    519a:	b3cd                	j	4f7c <vprintf+0x4a>
    519c:	6906                	ld	s2,64(sp)
    519e:	79e2                	ld	s3,56(sp)
    51a0:	7a42                	ld	s4,48(sp)
    51a2:	7aa2                	ld	s5,40(sp)
    51a4:	7b02                	ld	s6,32(sp)
    51a6:	6be2                	ld	s7,24(sp)
    51a8:	6c42                	ld	s8,16(sp)
    51aa:	6ca2                	ld	s9,8(sp)
    }
  }
}
    51ac:	60e6                	ld	ra,88(sp)
    51ae:	6446                	ld	s0,80(sp)
    51b0:	64a6                	ld	s1,72(sp)
    51b2:	6125                	addi	sp,sp,96
    51b4:	8082                	ret

00000000000051b6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    51b6:	715d                	addi	sp,sp,-80
    51b8:	ec06                	sd	ra,24(sp)
    51ba:	e822                	sd	s0,16(sp)
    51bc:	1000                	addi	s0,sp,32
    51be:	e010                	sd	a2,0(s0)
    51c0:	e414                	sd	a3,8(s0)
    51c2:	e818                	sd	a4,16(s0)
    51c4:	ec1c                	sd	a5,24(s0)
    51c6:	03043023          	sd	a6,32(s0)
    51ca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    51ce:	8622                	mv	a2,s0
    51d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    51d4:	d5fff0ef          	jal	4f32 <vprintf>
}
    51d8:	60e2                	ld	ra,24(sp)
    51da:	6442                	ld	s0,16(sp)
    51dc:	6161                	addi	sp,sp,80
    51de:	8082                	ret

00000000000051e0 <printf>:

void
printf(const char *fmt, ...)
{
    51e0:	711d                	addi	sp,sp,-96
    51e2:	ec06                	sd	ra,24(sp)
    51e4:	e822                	sd	s0,16(sp)
    51e6:	1000                	addi	s0,sp,32
    51e8:	e40c                	sd	a1,8(s0)
    51ea:	e810                	sd	a2,16(s0)
    51ec:	ec14                	sd	a3,24(s0)
    51ee:	f018                	sd	a4,32(s0)
    51f0:	f41c                	sd	a5,40(s0)
    51f2:	03043823          	sd	a6,48(s0)
    51f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    51fa:	00840613          	addi	a2,s0,8
    51fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5202:	85aa                	mv	a1,a0
    5204:	4505                	li	a0,1
    5206:	d2dff0ef          	jal	4f32 <vprintf>
}
    520a:	60e2                	ld	ra,24(sp)
    520c:	6442                	ld	s0,16(sp)
    520e:	6125                	addi	sp,sp,96
    5210:	8082                	ret

0000000000005212 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5212:	1141                	addi	sp,sp,-16
    5214:	e406                	sd	ra,8(sp)
    5216:	e022                	sd	s0,0(sp)
    5218:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    521a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    521e:	00004797          	auipc	a5,0x4
    5222:	2327b783          	ld	a5,562(a5) # 9450 <freep>
    5226:	a02d                	j	5250 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5228:	4618                	lw	a4,8(a2)
    522a:	9f2d                	addw	a4,a4,a1
    522c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5230:	6398                	ld	a4,0(a5)
    5232:	6310                	ld	a2,0(a4)
    5234:	a83d                	j	5272 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5236:	ff852703          	lw	a4,-8(a0)
    523a:	9f31                	addw	a4,a4,a2
    523c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    523e:	ff053683          	ld	a3,-16(a0)
    5242:	a091                	j	5286 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5244:	6398                	ld	a4,0(a5)
    5246:	00e7e463          	bltu	a5,a4,524e <free+0x3c>
    524a:	00e6ea63          	bltu	a3,a4,525e <free+0x4c>
{
    524e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5250:	fed7fae3          	bgeu	a5,a3,5244 <free+0x32>
    5254:	6398                	ld	a4,0(a5)
    5256:	00e6e463          	bltu	a3,a4,525e <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    525a:	fee7eae3          	bltu	a5,a4,524e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
    525e:	ff852583          	lw	a1,-8(a0)
    5262:	6390                	ld	a2,0(a5)
    5264:	02059813          	slli	a6,a1,0x20
    5268:	01c85713          	srli	a4,a6,0x1c
    526c:	9736                	add	a4,a4,a3
    526e:	fae60de3          	beq	a2,a4,5228 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
    5272:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5276:	4790                	lw	a2,8(a5)
    5278:	02061593          	slli	a1,a2,0x20
    527c:	01c5d713          	srli	a4,a1,0x1c
    5280:	973e                	add	a4,a4,a5
    5282:	fae68ae3          	beq	a3,a4,5236 <free+0x24>
    p->s.ptr = bp->s.ptr;
    5286:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5288:	00004717          	auipc	a4,0x4
    528c:	1cf73423          	sd	a5,456(a4) # 9450 <freep>
}
    5290:	60a2                	ld	ra,8(sp)
    5292:	6402                	ld	s0,0(sp)
    5294:	0141                	addi	sp,sp,16
    5296:	8082                	ret

0000000000005298 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5298:	7139                	addi	sp,sp,-64
    529a:	fc06                	sd	ra,56(sp)
    529c:	f822                	sd	s0,48(sp)
    529e:	f04a                	sd	s2,32(sp)
    52a0:	ec4e                	sd	s3,24(sp)
    52a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    52a4:	02051993          	slli	s3,a0,0x20
    52a8:	0209d993          	srli	s3,s3,0x20
    52ac:	09bd                	addi	s3,s3,15
    52ae:	0049d993          	srli	s3,s3,0x4
    52b2:	2985                	addiw	s3,s3,1
    52b4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    52b6:	00004517          	auipc	a0,0x4
    52ba:	19a53503          	ld	a0,410(a0) # 9450 <freep>
    52be:	c905                	beqz	a0,52ee <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    52c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    52c2:	4798                	lw	a4,8(a5)
    52c4:	09377663          	bgeu	a4,s3,5350 <malloc+0xb8>
    52c8:	f426                	sd	s1,40(sp)
    52ca:	e852                	sd	s4,16(sp)
    52cc:	e456                	sd	s5,8(sp)
    52ce:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    52d0:	8a4e                	mv	s4,s3
    52d2:	6705                	lui	a4,0x1
    52d4:	00e9f363          	bgeu	s3,a4,52da <malloc+0x42>
    52d8:	6a05                	lui	s4,0x1
    52da:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    52de:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    52e2:	00004497          	auipc	s1,0x4
    52e6:	16e48493          	addi	s1,s1,366 # 9450 <freep>
  if(p == (char*)-1)
    52ea:	5afd                	li	s5,-1
    52ec:	a83d                	j	532a <malloc+0x92>
    52ee:	f426                	sd	s1,40(sp)
    52f0:	e852                	sd	s4,16(sp)
    52f2:	e456                	sd	s5,8(sp)
    52f4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    52f6:	0000b797          	auipc	a5,0xb
    52fa:	98278793          	addi	a5,a5,-1662 # fc78 <base>
    52fe:	00004717          	auipc	a4,0x4
    5302:	14f73923          	sd	a5,338(a4) # 9450 <freep>
    5306:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5308:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    530c:	b7d1                	j	52d0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    530e:	6398                	ld	a4,0(a5)
    5310:	e118                	sd	a4,0(a0)
    5312:	a899                	j	5368 <malloc+0xd0>
  hp->s.size = nu;
    5314:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5318:	0541                	addi	a0,a0,16
    531a:	ef9ff0ef          	jal	5212 <free>
  return freep;
    531e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    5320:	c125                	beqz	a0,5380 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5322:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5324:	4798                	lw	a4,8(a5)
    5326:	03277163          	bgeu	a4,s2,5348 <malloc+0xb0>
    if(p == freep)
    532a:	6098                	ld	a4,0(s1)
    532c:	853e                	mv	a0,a5
    532e:	fef71ae3          	bne	a4,a5,5322 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    5332:	8552                	mv	a0,s4
    5334:	b2bff0ef          	jal	4e5e <sbrk>
  if(p == (char*)-1)
    5338:	fd551ee3          	bne	a0,s5,5314 <malloc+0x7c>
        return 0;
    533c:	4501                	li	a0,0
    533e:	74a2                	ld	s1,40(sp)
    5340:	6a42                	ld	s4,16(sp)
    5342:	6aa2                	ld	s5,8(sp)
    5344:	6b02                	ld	s6,0(sp)
    5346:	a03d                	j	5374 <malloc+0xdc>
    5348:	74a2                	ld	s1,40(sp)
    534a:	6a42                	ld	s4,16(sp)
    534c:	6aa2                	ld	s5,8(sp)
    534e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5350:	fae90fe3          	beq	s2,a4,530e <malloc+0x76>
        p->s.size -= nunits;
    5354:	4137073b          	subw	a4,a4,s3
    5358:	c798                	sw	a4,8(a5)
        p += p->s.size;
    535a:	02071693          	slli	a3,a4,0x20
    535e:	01c6d713          	srli	a4,a3,0x1c
    5362:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5364:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5368:	00004717          	auipc	a4,0x4
    536c:	0ea73423          	sd	a0,232(a4) # 9450 <freep>
      return (void*)(p + 1);
    5370:	01078513          	addi	a0,a5,16
  }
}
    5374:	70e2                	ld	ra,56(sp)
    5376:	7442                	ld	s0,48(sp)
    5378:	7902                	ld	s2,32(sp)
    537a:	69e2                	ld	s3,24(sp)
    537c:	6121                	addi	sp,sp,64
    537e:	8082                	ret
    5380:	74a2                	ld	s1,40(sp)
    5382:	6a42                	ld	s4,16(sp)
    5384:	6aa2                	ld	s5,8(sp)
    5386:	6b02                	ld	s6,0(sp)
    5388:	b7f5                	j	5374 <malloc+0xdc>
