
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	2d013103          	ld	sp,720(sp) # 8000a2d0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	04e000ef          	jal	80000064 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e406                	sd	ra,8(sp)
    80000020:	e022                	sd	s0,0(sp)
    80000022:	0800                	addi	s0,sp,16
#define MIE_STIE (1L << 5)  // supervisor timer
static inline uint64
r_mie()
{
  uint64 x;
  asm volatile("csrr %0, mie" : "=r" (x) );
    80000024:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80000028:	0207e793          	ori	a5,a5,32
}

static inline void 
w_mie(uint64 x)
{
  asm volatile("csrw mie, %0" : : "r" (x));
    8000002c:	30479073          	csrw	mie,a5
static inline uint64
r_menvcfg()
{
  uint64 x;
  // asm volatile("csrr %0, menvcfg" : "=r" (x) );
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80000030:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80000034:	577d                	li	a4,-1
    80000036:	177e                	slli	a4,a4,0x3f
    80000038:	8fd9                	or	a5,a5,a4

static inline void 
w_menvcfg(uint64 x)
{
  // asm volatile("csrw menvcfg, %0" : : "r" (x));
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    8000003a:	30a79073          	csrw	0x30a,a5

static inline uint64
r_mcounteren()
{
  uint64 x;
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    8000003e:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80000042:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80000046:	30679073          	csrw	mcounteren,a5
// machine-mode cycle counter
static inline uint64
r_time()
{
  uint64 x;
  asm volatile("csrr %0, time" : "=r" (x) );
    8000004a:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    8000004e:	000f4737          	lui	a4,0xf4
    80000052:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80000056:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80000058:	14d79073          	csrw	stimecmp,a5
}
    8000005c:	60a2                	ld	ra,8(sp)
    8000005e:	6402                	ld	s0,0(sp)
    80000060:	0141                	addi	sp,sp,16
    80000062:	8082                	ret

0000000080000064 <start>:
{
    80000064:	1141                	addi	sp,sp,-16
    80000066:	e406                	sd	ra,8(sp)
    80000068:	e022                	sd	s0,0(sp)
    8000006a:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000006c:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80000070:	7779                	lui	a4,0xffffe
    80000072:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdb19f>
    80000076:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80000078:	6705                	lui	a4,0x1
    8000007a:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    8000007e:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000080:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80000084:	00001797          	auipc	a5,0x1
    80000088:	e4478793          	addi	a5,a5,-444 # 80000ec8 <main>
    8000008c:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80000090:	4781                	li	a5,0
    80000092:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80000096:	67c1                	lui	a5,0x10
    80000098:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000009a:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    8000009e:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000a2:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000a6:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000aa:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000ae:	57fd                	li	a5,-1
    800000b0:	83a9                	srli	a5,a5,0xa
    800000b2:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000b6:	47bd                	li	a5,15
    800000b8:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    800000bc:	f61ff0ef          	jal	8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000c0:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000c4:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000c6:	823e                	mv	tp,a5
  asm volatile("mret");
    800000c8:	30200073          	mret
}
    800000cc:	60a2                	ld	ra,8(sp)
    800000ce:	6402                	ld	s0,0(sp)
    800000d0:	0141                	addi	sp,sp,16
    800000d2:	8082                	ret

00000000800000d4 <consolewrite>:

//
// user write()s to the console go here.
//
int consolewrite(int user_src, uint64 src, int n)
{
    800000d4:	711d                	addi	sp,sp,-96
    800000d6:	ec86                	sd	ra,88(sp)
    800000d8:	e8a2                	sd	s0,80(sp)
    800000da:	e0ca                	sd	s2,64(sp)
    800000dc:	1080                	addi	s0,sp,96
  int i;

  for (i = 0; i < n; i++)
    800000de:	04c05863          	blez	a2,8000012e <consolewrite+0x5a>
    800000e2:	e4a6                	sd	s1,72(sp)
    800000e4:	fc4e                	sd	s3,56(sp)
    800000e6:	f852                	sd	s4,48(sp)
    800000e8:	f456                	sd	s5,40(sp)
    800000ea:	f05a                	sd	s6,32(sp)
    800000ec:	ec5e                	sd	s7,24(sp)
    800000ee:	8a2a                	mv	s4,a0
    800000f0:	84ae                	mv	s1,a1
    800000f2:	89b2                	mv	s3,a2
    800000f4:	4901                	li	s2,0
  {
    char c;
    if (either_copyin(&c, user_src, src + i, 1) == -1)
    800000f6:	faf40b93          	addi	s7,s0,-81
    800000fa:	4b05                	li	s6,1
    800000fc:	5afd                	li	s5,-1
    800000fe:	86da                	mv	a3,s6
    80000100:	8626                	mv	a2,s1
    80000102:	85d2                	mv	a1,s4
    80000104:	855e                	mv	a0,s7
    80000106:	188020ef          	jal	8000228e <either_copyin>
    8000010a:	03550463          	beq	a0,s5,80000132 <consolewrite+0x5e>
      break;
    uartputc(c);
    8000010e:	faf44503          	lbu	a0,-81(s0)
    80000112:	071000ef          	jal	80000982 <uartputc>
  for (i = 0; i < n; i++)
    80000116:	2905                	addiw	s2,s2,1
    80000118:	0485                	addi	s1,s1,1
    8000011a:	ff2992e3          	bne	s3,s2,800000fe <consolewrite+0x2a>
    8000011e:	894e                	mv	s2,s3
    80000120:	64a6                	ld	s1,72(sp)
    80000122:	79e2                	ld	s3,56(sp)
    80000124:	7a42                	ld	s4,48(sp)
    80000126:	7aa2                	ld	s5,40(sp)
    80000128:	7b02                	ld	s6,32(sp)
    8000012a:	6be2                	ld	s7,24(sp)
    8000012c:	a809                	j	8000013e <consolewrite+0x6a>
    8000012e:	4901                	li	s2,0
    80000130:	a039                	j	8000013e <consolewrite+0x6a>
    80000132:	64a6                	ld	s1,72(sp)
    80000134:	79e2                	ld	s3,56(sp)
    80000136:	7a42                	ld	s4,48(sp)
    80000138:	7aa2                	ld	s5,40(sp)
    8000013a:	7b02                	ld	s6,32(sp)
    8000013c:	6be2                	ld	s7,24(sp)
  }

  return i;
}
    8000013e:	854a                	mv	a0,s2
    80000140:	60e6                	ld	ra,88(sp)
    80000142:	6446                	ld	s0,80(sp)
    80000144:	6906                	ld	s2,64(sp)
    80000146:	6125                	addi	sp,sp,96
    80000148:	8082                	ret

000000008000014a <consoleread>:
// copy (up to) a whole input line to dst.
// user_dist indicates whether dst is a user
// or kernel address.
//
int consoleread(int user_dst, uint64 dst, int n)
{
    8000014a:	711d                	addi	sp,sp,-96
    8000014c:	ec86                	sd	ra,88(sp)
    8000014e:	e8a2                	sd	s0,80(sp)
    80000150:	e4a6                	sd	s1,72(sp)
    80000152:	e0ca                	sd	s2,64(sp)
    80000154:	fc4e                	sd	s3,56(sp)
    80000156:	f852                	sd	s4,48(sp)
    80000158:	f456                	sd	s5,40(sp)
    8000015a:	f05a                	sd	s6,32(sp)
    8000015c:	1080                	addi	s0,sp,96
    8000015e:	8aaa                	mv	s5,a0
    80000160:	8a2e                	mv	s4,a1
    80000162:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000164:	8b32                	mv	s6,a2
  acquire(&cons.lock);
    80000166:	00012517          	auipc	a0,0x12
    8000016a:	1ca50513          	addi	a0,a0,458 # 80012330 <cons>
    8000016e:	2d5000ef          	jal	80000c42 <acquire>
  while (n > 0)
  {
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while (cons.r == cons.w)
    80000172:	00012497          	auipc	s1,0x12
    80000176:	1be48493          	addi	s1,s1,446 # 80012330 <cons>
      if (killed(myproc()))
      {
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    8000017a:	00012917          	auipc	s2,0x12
    8000017e:	24e90913          	addi	s2,s2,590 # 800123c8 <cons+0x98>
  while (n > 0)
    80000182:	0b305b63          	blez	s3,80000238 <consoleread+0xee>
    while (cons.r == cons.w)
    80000186:	0984a783          	lw	a5,152(s1)
    8000018a:	09c4a703          	lw	a4,156(s1)
    8000018e:	0af71063          	bne	a4,a5,8000022e <consoleread+0xe4>
      if (killed(myproc()))
    80000192:	78e010ef          	jal	80001920 <myproc>
    80000196:	791010ef          	jal	80002126 <killed>
    8000019a:	e12d                	bnez	a0,800001fc <consoleread+0xb2>
      sleep(&cons.r, &cons.lock);
    8000019c:	85a6                	mv	a1,s1
    8000019e:	854a                	mv	a0,s2
    800001a0:	54f010ef          	jal	80001eee <sleep>
    while (cons.r == cons.w)
    800001a4:	0984a783          	lw	a5,152(s1)
    800001a8:	09c4a703          	lw	a4,156(s1)
    800001ac:	fef703e3          	beq	a4,a5,80000192 <consoleread+0x48>
    800001b0:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    800001b2:	00012717          	auipc	a4,0x12
    800001b6:	17e70713          	addi	a4,a4,382 # 80012330 <cons>
    800001ba:	0017869b          	addiw	a3,a5,1
    800001be:	08d72c23          	sw	a3,152(a4)
    800001c2:	07f7f693          	andi	a3,a5,127
    800001c6:	9736                	add	a4,a4,a3
    800001c8:	01874703          	lbu	a4,24(a4)
    800001cc:	00070b9b          	sext.w	s7,a4

    if (c == C('D'))
    800001d0:	4691                	li	a3,4
    800001d2:	04db8663          	beq	s7,a3,8000021e <consoleread+0xd4>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    800001d6:	fae407a3          	sb	a4,-81(s0)
    if (either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001da:	4685                	li	a3,1
    800001dc:	faf40613          	addi	a2,s0,-81
    800001e0:	85d2                	mv	a1,s4
    800001e2:	8556                	mv	a0,s5
    800001e4:	060020ef          	jal	80002244 <either_copyout>
    800001e8:	57fd                	li	a5,-1
    800001ea:	04f50663          	beq	a0,a5,80000236 <consoleread+0xec>
      break;

    dst++;
    800001ee:	0a05                	addi	s4,s4,1
    --n;
    800001f0:	39fd                	addiw	s3,s3,-1

    if (c == '\n')
    800001f2:	47a9                	li	a5,10
    800001f4:	04fb8b63          	beq	s7,a5,8000024a <consoleread+0x100>
    800001f8:	6be2                	ld	s7,24(sp)
    800001fa:	b761                	j	80000182 <consoleread+0x38>
        release(&cons.lock);
    800001fc:	00012517          	auipc	a0,0x12
    80000200:	13450513          	addi	a0,a0,308 # 80012330 <cons>
    80000204:	2d3000ef          	jal	80000cd6 <release>
        return -1;
    80000208:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    8000020a:	60e6                	ld	ra,88(sp)
    8000020c:	6446                	ld	s0,80(sp)
    8000020e:	64a6                	ld	s1,72(sp)
    80000210:	6906                	ld	s2,64(sp)
    80000212:	79e2                	ld	s3,56(sp)
    80000214:	7a42                	ld	s4,48(sp)
    80000216:	7aa2                	ld	s5,40(sp)
    80000218:	7b02                	ld	s6,32(sp)
    8000021a:	6125                	addi	sp,sp,96
    8000021c:	8082                	ret
      if (n < target)
    8000021e:	0169fa63          	bgeu	s3,s6,80000232 <consoleread+0xe8>
        cons.r--;
    80000222:	00012717          	auipc	a4,0x12
    80000226:	1af72323          	sw	a5,422(a4) # 800123c8 <cons+0x98>
    8000022a:	6be2                	ld	s7,24(sp)
    8000022c:	a031                	j	80000238 <consoleread+0xee>
    8000022e:	ec5e                	sd	s7,24(sp)
    80000230:	b749                	j	800001b2 <consoleread+0x68>
    80000232:	6be2                	ld	s7,24(sp)
    80000234:	a011                	j	80000238 <consoleread+0xee>
    80000236:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80000238:	00012517          	auipc	a0,0x12
    8000023c:	0f850513          	addi	a0,a0,248 # 80012330 <cons>
    80000240:	297000ef          	jal	80000cd6 <release>
  return target - n;
    80000244:	413b053b          	subw	a0,s6,s3
    80000248:	b7c9                	j	8000020a <consoleread+0xc0>
    8000024a:	6be2                	ld	s7,24(sp)
    8000024c:	b7f5                	j	80000238 <consoleread+0xee>

000000008000024e <consputc>:
{
    8000024e:	1141                	addi	sp,sp,-16
    80000250:	e406                	sd	ra,8(sp)
    80000252:	e022                	sd	s0,0(sp)
    80000254:	0800                	addi	s0,sp,16
  if (c == BACKSPACE)
    80000256:	10000793          	li	a5,256
    8000025a:	00f50863          	beq	a0,a5,8000026a <consputc+0x1c>
    uartputc_sync(c);
    8000025e:	642000ef          	jal	800008a0 <uartputc_sync>
}
    80000262:	60a2                	ld	ra,8(sp)
    80000264:	6402                	ld	s0,0(sp)
    80000266:	0141                	addi	sp,sp,16
    80000268:	8082                	ret
    uartputc_sync('\b');
    8000026a:	4521                	li	a0,8
    8000026c:	634000ef          	jal	800008a0 <uartputc_sync>
    uartputc_sync(' ');
    80000270:	02000513          	li	a0,32
    80000274:	62c000ef          	jal	800008a0 <uartputc_sync>
    uartputc_sync('\b');
    80000278:	4521                	li	a0,8
    8000027a:	626000ef          	jal	800008a0 <uartputc_sync>
    8000027e:	b7d5                	j	80000262 <consputc+0x14>

0000000080000280 <consoleintr>:
// uartintr() calls this for input character.
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void consoleintr(int c)
{
    80000280:	7179                	addi	sp,sp,-48
    80000282:	f406                	sd	ra,40(sp)
    80000284:	f022                	sd	s0,32(sp)
    80000286:	ec26                	sd	s1,24(sp)
    80000288:	1800                	addi	s0,sp,48
    8000028a:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    8000028c:	00012517          	auipc	a0,0x12
    80000290:	0a450513          	addi	a0,a0,164 # 80012330 <cons>
    80000294:	1af000ef          	jal	80000c42 <acquire>
  ++consoleIntrCounter;
    80000298:	0000a717          	auipc	a4,0xa
    8000029c:	05870713          	addi	a4,a4,88 # 8000a2f0 <consoleIntrCounter>
    800002a0:	631c                	ld	a5,0(a4)
    800002a2:	0785                	addi	a5,a5,1
    800002a4:	e31c                	sd	a5,0(a4)

  switch (c)
    800002a6:	47d5                	li	a5,21
    800002a8:	08f48e63          	beq	s1,a5,80000344 <consoleintr+0xc4>
    800002ac:	0297c563          	blt	a5,s1,800002d6 <consoleintr+0x56>
    800002b0:	47a1                	li	a5,8
    800002b2:	0ef48863          	beq	s1,a5,800003a2 <consoleintr+0x122>
    800002b6:	47c1                	li	a5,16
    800002b8:	10f49963          	bne	s1,a5,800003ca <consoleintr+0x14a>
  {
  case C('P'): // Print process list.
    procdump();
    800002bc:	01c020ef          	jal	800022d8 <procdump>
      }
    }
    break;
  }

  release(&cons.lock);
    800002c0:	00012517          	auipc	a0,0x12
    800002c4:	07050513          	addi	a0,a0,112 # 80012330 <cons>
    800002c8:	20f000ef          	jal	80000cd6 <release>
}
    800002cc:	70a2                	ld	ra,40(sp)
    800002ce:	7402                	ld	s0,32(sp)
    800002d0:	64e2                	ld	s1,24(sp)
    800002d2:	6145                	addi	sp,sp,48
    800002d4:	8082                	ret
  switch (c)
    800002d6:	07f00793          	li	a5,127
    800002da:	0cf48463          	beq	s1,a5,800003a2 <consoleintr+0x122>
    if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE)
    800002de:	00012717          	auipc	a4,0x12
    800002e2:	05270713          	addi	a4,a4,82 # 80012330 <cons>
    800002e6:	0a072783          	lw	a5,160(a4)
    800002ea:	09872703          	lw	a4,152(a4)
    800002ee:	9f99                	subw	a5,a5,a4
    800002f0:	07f00713          	li	a4,127
    800002f4:	fcf766e3          	bltu	a4,a5,800002c0 <consoleintr+0x40>
      c = (c == '\r') ? '\n' : c;
    800002f8:	47b5                	li	a5,13
    800002fa:	0cf48b63          	beq	s1,a5,800003d0 <consoleintr+0x150>
      consputc(c);
    800002fe:	8526                	mv	a0,s1
    80000300:	f4fff0ef          	jal	8000024e <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80000304:	00012797          	auipc	a5,0x12
    80000308:	02c78793          	addi	a5,a5,44 # 80012330 <cons>
    8000030c:	0a07a683          	lw	a3,160(a5)
    80000310:	0016871b          	addiw	a4,a3,1
    80000314:	863a                	mv	a2,a4
    80000316:	0ae7a023          	sw	a4,160(a5)
    8000031a:	07f6f693          	andi	a3,a3,127
    8000031e:	97b6                	add	a5,a5,a3
    80000320:	00978c23          	sb	s1,24(a5)
      if (c == '\n' || c == C('D') || cons.e - cons.r == INPUT_BUF_SIZE)
    80000324:	47a9                	li	a5,10
    80000326:	0cf48963          	beq	s1,a5,800003f8 <consoleintr+0x178>
    8000032a:	4791                	li	a5,4
    8000032c:	0cf48663          	beq	s1,a5,800003f8 <consoleintr+0x178>
    80000330:	00012797          	auipc	a5,0x12
    80000334:	0987a783          	lw	a5,152(a5) # 800123c8 <cons+0x98>
    80000338:	9f1d                	subw	a4,a4,a5
    8000033a:	08000793          	li	a5,128
    8000033e:	f8f711e3          	bne	a4,a5,800002c0 <consoleintr+0x40>
    80000342:	a85d                	j	800003f8 <consoleintr+0x178>
    80000344:	e84a                	sd	s2,16(sp)
    80000346:	e44e                	sd	s3,8(sp)
    while (cons.e != cons.w &&
    80000348:	00012717          	auipc	a4,0x12
    8000034c:	fe870713          	addi	a4,a4,-24 # 80012330 <cons>
    80000350:	0a072783          	lw	a5,160(a4)
    80000354:	09c72703          	lw	a4,156(a4)
           cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n')
    80000358:	00012497          	auipc	s1,0x12
    8000035c:	fd848493          	addi	s1,s1,-40 # 80012330 <cons>
    while (cons.e != cons.w &&
    80000360:	4929                	li	s2,10
      consputc(BACKSPACE);
    80000362:	10000993          	li	s3,256
    while (cons.e != cons.w &&
    80000366:	02f70863          	beq	a4,a5,80000396 <consoleintr+0x116>
           cons.buf[(cons.e - 1) % INPUT_BUF_SIZE] != '\n')
    8000036a:	37fd                	addiw	a5,a5,-1
    8000036c:	07f7f713          	andi	a4,a5,127
    80000370:	9726                	add	a4,a4,s1
    while (cons.e != cons.w &&
    80000372:	01874703          	lbu	a4,24(a4)
    80000376:	03270363          	beq	a4,s2,8000039c <consoleintr+0x11c>
      cons.e--;
    8000037a:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    8000037e:	854e                	mv	a0,s3
    80000380:	ecfff0ef          	jal	8000024e <consputc>
    while (cons.e != cons.w &&
    80000384:	0a04a783          	lw	a5,160(s1)
    80000388:	09c4a703          	lw	a4,156(s1)
    8000038c:	fcf71fe3          	bne	a4,a5,8000036a <consoleintr+0xea>
    80000390:	6942                	ld	s2,16(sp)
    80000392:	69a2                	ld	s3,8(sp)
    80000394:	b735                	j	800002c0 <consoleintr+0x40>
    80000396:	6942                	ld	s2,16(sp)
    80000398:	69a2                	ld	s3,8(sp)
    8000039a:	b71d                	j	800002c0 <consoleintr+0x40>
    8000039c:	6942                	ld	s2,16(sp)
    8000039e:	69a2                	ld	s3,8(sp)
    800003a0:	b705                	j	800002c0 <consoleintr+0x40>
    if (cons.e != cons.w)
    800003a2:	00012717          	auipc	a4,0x12
    800003a6:	f8e70713          	addi	a4,a4,-114 # 80012330 <cons>
    800003aa:	0a072783          	lw	a5,160(a4)
    800003ae:	09c72703          	lw	a4,156(a4)
    800003b2:	f0f707e3          	beq	a4,a5,800002c0 <consoleintr+0x40>
      cons.e--;
    800003b6:	37fd                	addiw	a5,a5,-1
    800003b8:	00012717          	auipc	a4,0x12
    800003bc:	00f72c23          	sw	a5,24(a4) # 800123d0 <cons+0xa0>
      consputc(BACKSPACE);
    800003c0:	10000513          	li	a0,256
    800003c4:	e8bff0ef          	jal	8000024e <consputc>
    800003c8:	bde5                	j	800002c0 <consoleintr+0x40>
    if (c != 0 && cons.e - cons.r < INPUT_BUF_SIZE)
    800003ca:	ee048be3          	beqz	s1,800002c0 <consoleintr+0x40>
    800003ce:	bf01                	j	800002de <consoleintr+0x5e>
      consputc(c);
    800003d0:	4529                	li	a0,10
    800003d2:	e7dff0ef          	jal	8000024e <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800003d6:	00012797          	auipc	a5,0x12
    800003da:	f5a78793          	addi	a5,a5,-166 # 80012330 <cons>
    800003de:	0a07a703          	lw	a4,160(a5)
    800003e2:	0017069b          	addiw	a3,a4,1
    800003e6:	8636                	mv	a2,a3
    800003e8:	0ad7a023          	sw	a3,160(a5)
    800003ec:	07f77713          	andi	a4,a4,127
    800003f0:	97ba                	add	a5,a5,a4
    800003f2:	4729                	li	a4,10
    800003f4:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    800003f8:	00012797          	auipc	a5,0x12
    800003fc:	fcc7aa23          	sw	a2,-44(a5) # 800123cc <cons+0x9c>
        wakeup(&cons.r);
    80000400:	00012517          	auipc	a0,0x12
    80000404:	fc850513          	addi	a0,a0,-56 # 800123c8 <cons+0x98>
    80000408:	333010ef          	jal	80001f3a <wakeup>
    8000040c:	bd55                	j	800002c0 <consoleintr+0x40>

000000008000040e <consoleinit>:

void consoleinit(void)
{
    8000040e:	1141                	addi	sp,sp,-16
    80000410:	e406                	sd	ra,8(sp)
    80000412:	e022                	sd	s0,0(sp)
    80000414:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000416:	00007597          	auipc	a1,0x7
    8000041a:	bea58593          	addi	a1,a1,-1046 # 80007000 <etext>
    8000041e:	00012517          	auipc	a0,0x12
    80000422:	f1250513          	addi	a0,a0,-238 # 80012330 <cons>
    80000426:	798000ef          	jal	80000bbe <initlock>

  uartinit();
    8000042a:	420000ef          	jal	8000084a <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000042e:	00022797          	auipc	a5,0x22
    80000432:	09a78793          	addi	a5,a5,154 # 800224c8 <devsw>
    80000436:	00000717          	auipc	a4,0x0
    8000043a:	d1470713          	addi	a4,a4,-748 # 8000014a <consoleread>
    8000043e:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000440:	00000717          	auipc	a4,0x0
    80000444:	c9470713          	addi	a4,a4,-876 # 800000d4 <consolewrite>
    80000448:	ef98                	sd	a4,24(a5)
}
    8000044a:	60a2                	ld	ra,8(sp)
    8000044c:	6402                	ld	s0,0(sp)
    8000044e:	0141                	addi	sp,sp,16
    80000450:	8082                	ret

0000000080000452 <get_keystrokes_count>:

uint64
get_keystrokes_count(void)
{
    80000452:	1101                	addi	sp,sp,-32
    80000454:	ec06                	sd	ra,24(sp)
    80000456:	e822                	sd	s0,16(sp)
    80000458:	e426                	sd	s1,8(sp)
    8000045a:	e04a                	sd	s2,0(sp)
    8000045c:	1000                	addi	s0,sp,32
  uint64 val;
  acquire(&cons.lock);
    8000045e:	00012497          	auipc	s1,0x12
    80000462:	ed248493          	addi	s1,s1,-302 # 80012330 <cons>
    80000466:	8526                	mv	a0,s1
    80000468:	7da000ef          	jal	80000c42 <acquire>
  val = consoleIntrCounter;
    8000046c:	0000a917          	auipc	s2,0xa
    80000470:	e8493903          	ld	s2,-380(s2) # 8000a2f0 <consoleIntrCounter>
  release(&cons.lock);
    80000474:	8526                	mv	a0,s1
    80000476:	061000ef          	jal	80000cd6 <release>
  return val;
}
    8000047a:	854a                	mv	a0,s2
    8000047c:	60e2                	ld	ra,24(sp)
    8000047e:	6442                	ld	s0,16(sp)
    80000480:	64a2                	ld	s1,8(sp)
    80000482:	6902                	ld	s2,0(sp)
    80000484:	6105                	addi	sp,sp,32
    80000486:	8082                	ret

0000000080000488 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80000488:	7179                	addi	sp,sp,-48
    8000048a:	f406                	sd	ra,40(sp)
    8000048c:	f022                	sd	s0,32(sp)
    8000048e:	ec26                	sd	s1,24(sp)
    80000490:	e84a                	sd	s2,16(sp)
    80000492:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    80000494:	c219                	beqz	a2,8000049a <printint+0x12>
    80000496:	06054a63          	bltz	a0,8000050a <printint+0x82>
    x = -xx;
  else
    x = xx;
    8000049a:	4e01                	li	t3,0

  i = 0;
    8000049c:	fd040313          	addi	t1,s0,-48
    x = xx;
    800004a0:	869a                	mv	a3,t1
  i = 0;
    800004a2:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    800004a4:	00007817          	auipc	a6,0x7
    800004a8:	2cc80813          	addi	a6,a6,716 # 80007770 <digits>
    800004ac:	88be                	mv	a7,a5
    800004ae:	0017861b          	addiw	a2,a5,1
    800004b2:	87b2                	mv	a5,a2
    800004b4:	02b57733          	remu	a4,a0,a1
    800004b8:	9742                	add	a4,a4,a6
    800004ba:	00074703          	lbu	a4,0(a4)
    800004be:	00e68023          	sb	a4,0(a3)
  } while((x /= base) != 0);
    800004c2:	872a                	mv	a4,a0
    800004c4:	02b55533          	divu	a0,a0,a1
    800004c8:	0685                	addi	a3,a3,1
    800004ca:	feb771e3          	bgeu	a4,a1,800004ac <printint+0x24>

  if(sign)
    800004ce:	000e0c63          	beqz	t3,800004e6 <printint+0x5e>
    buf[i++] = '-';
    800004d2:	fe060793          	addi	a5,a2,-32
    800004d6:	00878633          	add	a2,a5,s0
    800004da:	02d00793          	li	a5,45
    800004de:	fef60823          	sb	a5,-16(a2)
    800004e2:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    800004e6:	fff7891b          	addiw	s2,a5,-1
    800004ea:	006784b3          	add	s1,a5,t1
    consputc(buf[i]);
    800004ee:	fff4c503          	lbu	a0,-1(s1)
    800004f2:	d5dff0ef          	jal	8000024e <consputc>
  while(--i >= 0)
    800004f6:	397d                	addiw	s2,s2,-1
    800004f8:	14fd                	addi	s1,s1,-1
    800004fa:	fe095ae3          	bgez	s2,800004ee <printint+0x66>
}
    800004fe:	70a2                	ld	ra,40(sp)
    80000500:	7402                	ld	s0,32(sp)
    80000502:	64e2                	ld	s1,24(sp)
    80000504:	6942                	ld	s2,16(sp)
    80000506:	6145                	addi	sp,sp,48
    80000508:	8082                	ret
    x = -xx;
    8000050a:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    8000050e:	4e05                	li	t3,1
    x = -xx;
    80000510:	b771                	j	8000049c <printint+0x14>

0000000080000512 <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    80000512:	7155                	addi	sp,sp,-208
    80000514:	e506                	sd	ra,136(sp)
    80000516:	e122                	sd	s0,128(sp)
    80000518:	f0d2                	sd	s4,96(sp)
    8000051a:	0900                	addi	s0,sp,144
    8000051c:	8a2a                	mv	s4,a0
    8000051e:	e40c                	sd	a1,8(s0)
    80000520:	e810                	sd	a2,16(s0)
    80000522:	ec14                	sd	a3,24(s0)
    80000524:	f018                	sd	a4,32(s0)
    80000526:	f41c                	sd	a5,40(s0)
    80000528:	03043823          	sd	a6,48(s0)
    8000052c:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2, locking;
  char *s;

  locking = pr.locking;
    80000530:	00012797          	auipc	a5,0x12
    80000534:	ec07a783          	lw	a5,-320(a5) # 800123f0 <pr+0x18>
    80000538:	f6f43c23          	sd	a5,-136(s0)
  if(locking)
    8000053c:	e3a1                	bnez	a5,8000057c <printf+0x6a>
    acquire(&pr.lock);

  va_start(ap, fmt);
    8000053e:	00840793          	addi	a5,s0,8
    80000542:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80000546:	00054503          	lbu	a0,0(a0)
    8000054a:	26050663          	beqz	a0,800007b6 <printf+0x2a4>
    8000054e:	fca6                	sd	s1,120(sp)
    80000550:	f8ca                	sd	s2,112(sp)
    80000552:	f4ce                	sd	s3,104(sp)
    80000554:	ecd6                	sd	s5,88(sp)
    80000556:	e8da                	sd	s6,80(sp)
    80000558:	e0e2                	sd	s8,64(sp)
    8000055a:	fc66                	sd	s9,56(sp)
    8000055c:	f86a                	sd	s10,48(sp)
    8000055e:	f46e                	sd	s11,40(sp)
    80000560:	4981                	li	s3,0
    if(cx != '%'){
    80000562:	02500a93          	li	s5,37
    i++;
    c0 = fmt[i+0] & 0xff;
    c1 = c2 = 0;
    if(c0) c1 = fmt[i+1] & 0xff;
    if(c1) c2 = fmt[i+2] & 0xff;
    if(c0 == 'd'){
    80000566:	06400b13          	li	s6,100
      printint(va_arg(ap, int), 10, 1);
    } else if(c0 == 'l' && c1 == 'd'){
    8000056a:	06c00c13          	li	s8,108
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    8000056e:	07500c93          	li	s9,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    80000572:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    80000576:	07000d93          	li	s11,112
    8000057a:	a80d                	j	800005ac <printf+0x9a>
    acquire(&pr.lock);
    8000057c:	00012517          	auipc	a0,0x12
    80000580:	e5c50513          	addi	a0,a0,-420 # 800123d8 <pr>
    80000584:	6be000ef          	jal	80000c42 <acquire>
  va_start(ap, fmt);
    80000588:	00840793          	addi	a5,s0,8
    8000058c:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    80000590:	000a4503          	lbu	a0,0(s4)
    80000594:	fd4d                	bnez	a0,8000054e <printf+0x3c>
    80000596:	ac3d                	j	800007d4 <printf+0x2c2>
      consputc(cx);
    80000598:	cb7ff0ef          	jal	8000024e <consputc>
      continue;
    8000059c:	84ce                	mv	s1,s3
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    8000059e:	2485                	addiw	s1,s1,1
    800005a0:	89a6                	mv	s3,s1
    800005a2:	94d2                	add	s1,s1,s4
    800005a4:	0004c503          	lbu	a0,0(s1)
    800005a8:	1e050b63          	beqz	a0,8000079e <printf+0x28c>
    if(cx != '%'){
    800005ac:	ff5516e3          	bne	a0,s5,80000598 <printf+0x86>
    i++;
    800005b0:	0019879b          	addiw	a5,s3,1
    800005b4:	84be                	mv	s1,a5
    c0 = fmt[i+0] & 0xff;
    800005b6:	00fa0733          	add	a4,s4,a5
    800005ba:	00074903          	lbu	s2,0(a4)
    if(c0) c1 = fmt[i+1] & 0xff;
    800005be:	1e090063          	beqz	s2,8000079e <printf+0x28c>
    800005c2:	00174703          	lbu	a4,1(a4)
    c1 = c2 = 0;
    800005c6:	86ba                	mv	a3,a4
    if(c1) c2 = fmt[i+2] & 0xff;
    800005c8:	c701                	beqz	a4,800005d0 <printf+0xbe>
    800005ca:	97d2                	add	a5,a5,s4
    800005cc:	0027c683          	lbu	a3,2(a5)
    if(c0 == 'd'){
    800005d0:	03690763          	beq	s2,s6,800005fe <printf+0xec>
    } else if(c0 == 'l' && c1 == 'd'){
    800005d4:	05890163          	beq	s2,s8,80000616 <printf+0x104>
    } else if(c0 == 'u'){
    800005d8:	0d990b63          	beq	s2,s9,800006ae <printf+0x19c>
    } else if(c0 == 'x'){
    800005dc:	13a90163          	beq	s2,s10,800006fe <printf+0x1ec>
    } else if(c0 == 'p'){
    800005e0:	13b90b63          	beq	s2,s11,80000716 <printf+0x204>
      printptr(va_arg(ap, uint64));
    } else if(c0 == 's'){
    800005e4:	07300793          	li	a5,115
    800005e8:	16f90a63          	beq	s2,a5,8000075c <printf+0x24a>
      if((s = va_arg(ap, char*)) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
    } else if(c0 == '%'){
    800005ec:	1b590463          	beq	s2,s5,80000794 <printf+0x282>
      consputc('%');
    } else if(c0 == 0){
      break;
    } else {
      // Print unknown % sequence to draw attention.
      consputc('%');
    800005f0:	8556                	mv	a0,s5
    800005f2:	c5dff0ef          	jal	8000024e <consputc>
      consputc(c0);
    800005f6:	854a                	mv	a0,s2
    800005f8:	c57ff0ef          	jal	8000024e <consputc>
    800005fc:	b74d                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, int), 10, 1);
    800005fe:	f8843783          	ld	a5,-120(s0)
    80000602:	00878713          	addi	a4,a5,8
    80000606:	f8e43423          	sd	a4,-120(s0)
    8000060a:	4605                	li	a2,1
    8000060c:	45a9                	li	a1,10
    8000060e:	4388                	lw	a0,0(a5)
    80000610:	e79ff0ef          	jal	80000488 <printint>
    80000614:	b769                	j	8000059e <printf+0x8c>
    } else if(c0 == 'l' && c1 == 'd'){
    80000616:	03670663          	beq	a4,s6,80000642 <printf+0x130>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000061a:	05870263          	beq	a4,s8,8000065e <printf+0x14c>
    } else if(c0 == 'l' && c1 == 'u'){
    8000061e:	0b970463          	beq	a4,s9,800006c6 <printf+0x1b4>
    } else if(c0 == 'l' && c1 == 'x'){
    80000622:	fda717e3          	bne	a4,s10,800005f0 <printf+0xde>
      printint(va_arg(ap, uint64), 16, 0);
    80000626:	f8843783          	ld	a5,-120(s0)
    8000062a:	00878713          	addi	a4,a5,8
    8000062e:	f8e43423          	sd	a4,-120(s0)
    80000632:	4601                	li	a2,0
    80000634:	45c1                	li	a1,16
    80000636:	6388                	ld	a0,0(a5)
    80000638:	e51ff0ef          	jal	80000488 <printint>
      i += 1;
    8000063c:	0029849b          	addiw	s1,s3,2
    80000640:	bfb9                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 1);
    80000642:	f8843783          	ld	a5,-120(s0)
    80000646:	00878713          	addi	a4,a5,8
    8000064a:	f8e43423          	sd	a4,-120(s0)
    8000064e:	4605                	li	a2,1
    80000650:	45a9                	li	a1,10
    80000652:	6388                	ld	a0,0(a5)
    80000654:	e35ff0ef          	jal	80000488 <printint>
      i += 1;
    80000658:	0029849b          	addiw	s1,s3,2
    8000065c:	b789                	j	8000059e <printf+0x8c>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    8000065e:	06400793          	li	a5,100
    80000662:	02f68863          	beq	a3,a5,80000692 <printf+0x180>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    80000666:	07500793          	li	a5,117
    8000066a:	06f68c63          	beq	a3,a5,800006e2 <printf+0x1d0>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    8000066e:	07800793          	li	a5,120
    80000672:	f6f69fe3          	bne	a3,a5,800005f0 <printf+0xde>
      printint(va_arg(ap, uint64), 16, 0);
    80000676:	f8843783          	ld	a5,-120(s0)
    8000067a:	00878713          	addi	a4,a5,8
    8000067e:	f8e43423          	sd	a4,-120(s0)
    80000682:	4601                	li	a2,0
    80000684:	45c1                	li	a1,16
    80000686:	6388                	ld	a0,0(a5)
    80000688:	e01ff0ef          	jal	80000488 <printint>
      i += 2;
    8000068c:	0039849b          	addiw	s1,s3,3
    80000690:	b739                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 1);
    80000692:	f8843783          	ld	a5,-120(s0)
    80000696:	00878713          	addi	a4,a5,8
    8000069a:	f8e43423          	sd	a4,-120(s0)
    8000069e:	4605                	li	a2,1
    800006a0:	45a9                	li	a1,10
    800006a2:	6388                	ld	a0,0(a5)
    800006a4:	de5ff0ef          	jal	80000488 <printint>
      i += 2;
    800006a8:	0039849b          	addiw	s1,s3,3
    800006ac:	bdcd                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, int), 10, 0);
    800006ae:	f8843783          	ld	a5,-120(s0)
    800006b2:	00878713          	addi	a4,a5,8
    800006b6:	f8e43423          	sd	a4,-120(s0)
    800006ba:	4601                	li	a2,0
    800006bc:	45a9                	li	a1,10
    800006be:	4388                	lw	a0,0(a5)
    800006c0:	dc9ff0ef          	jal	80000488 <printint>
    800006c4:	bde9                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 0);
    800006c6:	f8843783          	ld	a5,-120(s0)
    800006ca:	00878713          	addi	a4,a5,8
    800006ce:	f8e43423          	sd	a4,-120(s0)
    800006d2:	4601                	li	a2,0
    800006d4:	45a9                	li	a1,10
    800006d6:	6388                	ld	a0,0(a5)
    800006d8:	db1ff0ef          	jal	80000488 <printint>
      i += 1;
    800006dc:	0029849b          	addiw	s1,s3,2
    800006e0:	bd7d                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, uint64), 10, 0);
    800006e2:	f8843783          	ld	a5,-120(s0)
    800006e6:	00878713          	addi	a4,a5,8
    800006ea:	f8e43423          	sd	a4,-120(s0)
    800006ee:	4601                	li	a2,0
    800006f0:	45a9                	li	a1,10
    800006f2:	6388                	ld	a0,0(a5)
    800006f4:	d95ff0ef          	jal	80000488 <printint>
      i += 2;
    800006f8:	0039849b          	addiw	s1,s3,3
    800006fc:	b54d                	j	8000059e <printf+0x8c>
      printint(va_arg(ap, int), 16, 0);
    800006fe:	f8843783          	ld	a5,-120(s0)
    80000702:	00878713          	addi	a4,a5,8
    80000706:	f8e43423          	sd	a4,-120(s0)
    8000070a:	4601                	li	a2,0
    8000070c:	45c1                	li	a1,16
    8000070e:	4388                	lw	a0,0(a5)
    80000710:	d79ff0ef          	jal	80000488 <printint>
    80000714:	b569                	j	8000059e <printf+0x8c>
    80000716:	e4de                	sd	s7,72(sp)
      printptr(va_arg(ap, uint64));
    80000718:	f8843783          	ld	a5,-120(s0)
    8000071c:	00878713          	addi	a4,a5,8
    80000720:	f8e43423          	sd	a4,-120(s0)
    80000724:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80000728:	03000513          	li	a0,48
    8000072c:	b23ff0ef          	jal	8000024e <consputc>
  consputc('x');
    80000730:	07800513          	li	a0,120
    80000734:	b1bff0ef          	jal	8000024e <consputc>
    80000738:	4941                	li	s2,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000073a:	00007b97          	auipc	s7,0x7
    8000073e:	036b8b93          	addi	s7,s7,54 # 80007770 <digits>
    80000742:	03c9d793          	srli	a5,s3,0x3c
    80000746:	97de                	add	a5,a5,s7
    80000748:	0007c503          	lbu	a0,0(a5)
    8000074c:	b03ff0ef          	jal	8000024e <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80000750:	0992                	slli	s3,s3,0x4
    80000752:	397d                	addiw	s2,s2,-1
    80000754:	fe0917e3          	bnez	s2,80000742 <printf+0x230>
    80000758:	6ba6                	ld	s7,72(sp)
    8000075a:	b591                	j	8000059e <printf+0x8c>
      if((s = va_arg(ap, char*)) == 0)
    8000075c:	f8843783          	ld	a5,-120(s0)
    80000760:	00878713          	addi	a4,a5,8
    80000764:	f8e43423          	sd	a4,-120(s0)
    80000768:	0007b903          	ld	s2,0(a5)
    8000076c:	00090d63          	beqz	s2,80000786 <printf+0x274>
      for(; *s; s++)
    80000770:	00094503          	lbu	a0,0(s2)
    80000774:	e20505e3          	beqz	a0,8000059e <printf+0x8c>
        consputc(*s);
    80000778:	ad7ff0ef          	jal	8000024e <consputc>
      for(; *s; s++)
    8000077c:	0905                	addi	s2,s2,1
    8000077e:	00094503          	lbu	a0,0(s2)
    80000782:	f97d                	bnez	a0,80000778 <printf+0x266>
    80000784:	bd29                	j	8000059e <printf+0x8c>
        s = "(null)";
    80000786:	00007917          	auipc	s2,0x7
    8000078a:	88290913          	addi	s2,s2,-1918 # 80007008 <etext+0x8>
      for(; *s; s++)
    8000078e:	02800513          	li	a0,40
    80000792:	b7dd                	j	80000778 <printf+0x266>
      consputc('%');
    80000794:	02500513          	li	a0,37
    80000798:	ab7ff0ef          	jal	8000024e <consputc>
    8000079c:	b509                	j	8000059e <printf+0x8c>
    }
#endif
  }
  va_end(ap);

  if(locking)
    8000079e:	f7843783          	ld	a5,-136(s0)
    800007a2:	e385                	bnez	a5,800007c2 <printf+0x2b0>
    800007a4:	74e6                	ld	s1,120(sp)
    800007a6:	7946                	ld	s2,112(sp)
    800007a8:	79a6                	ld	s3,104(sp)
    800007aa:	6ae6                	ld	s5,88(sp)
    800007ac:	6b46                	ld	s6,80(sp)
    800007ae:	6c06                	ld	s8,64(sp)
    800007b0:	7ce2                	ld	s9,56(sp)
    800007b2:	7d42                	ld	s10,48(sp)
    800007b4:	7da2                	ld	s11,40(sp)
    release(&pr.lock);

  return 0;
}
    800007b6:	4501                	li	a0,0
    800007b8:	60aa                	ld	ra,136(sp)
    800007ba:	640a                	ld	s0,128(sp)
    800007bc:	7a06                	ld	s4,96(sp)
    800007be:	6169                	addi	sp,sp,208
    800007c0:	8082                	ret
    800007c2:	74e6                	ld	s1,120(sp)
    800007c4:	7946                	ld	s2,112(sp)
    800007c6:	79a6                	ld	s3,104(sp)
    800007c8:	6ae6                	ld	s5,88(sp)
    800007ca:	6b46                	ld	s6,80(sp)
    800007cc:	6c06                	ld	s8,64(sp)
    800007ce:	7ce2                	ld	s9,56(sp)
    800007d0:	7d42                	ld	s10,48(sp)
    800007d2:	7da2                	ld	s11,40(sp)
    release(&pr.lock);
    800007d4:	00012517          	auipc	a0,0x12
    800007d8:	c0450513          	addi	a0,a0,-1020 # 800123d8 <pr>
    800007dc:	4fa000ef          	jal	80000cd6 <release>
    800007e0:	bfd9                	j	800007b6 <printf+0x2a4>

00000000800007e2 <panic>:

void
panic(char *s)
{
    800007e2:	1101                	addi	sp,sp,-32
    800007e4:	ec06                	sd	ra,24(sp)
    800007e6:	e822                	sd	s0,16(sp)
    800007e8:	e426                	sd	s1,8(sp)
    800007ea:	1000                	addi	s0,sp,32
    800007ec:	84aa                	mv	s1,a0
  pr.locking = 0;
    800007ee:	00012797          	auipc	a5,0x12
    800007f2:	c007a123          	sw	zero,-1022(a5) # 800123f0 <pr+0x18>
  printf("panic: ");
    800007f6:	00007517          	auipc	a0,0x7
    800007fa:	82250513          	addi	a0,a0,-2014 # 80007018 <etext+0x18>
    800007fe:	d15ff0ef          	jal	80000512 <printf>
  printf("%s\n", s);
    80000802:	85a6                	mv	a1,s1
    80000804:	00007517          	auipc	a0,0x7
    80000808:	81c50513          	addi	a0,a0,-2020 # 80007020 <etext+0x20>
    8000080c:	d07ff0ef          	jal	80000512 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000810:	4785                	li	a5,1
    80000812:	0000a717          	auipc	a4,0xa
    80000816:	aef72323          	sw	a5,-1306(a4) # 8000a2f8 <panicked>
  for(;;)
    8000081a:	a001                	j	8000081a <panic+0x38>

000000008000081c <printfinit>:
    ;
}

void
printfinit(void)
{
    8000081c:	1101                	addi	sp,sp,-32
    8000081e:	ec06                	sd	ra,24(sp)
    80000820:	e822                	sd	s0,16(sp)
    80000822:	e426                	sd	s1,8(sp)
    80000824:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80000826:	00012497          	auipc	s1,0x12
    8000082a:	bb248493          	addi	s1,s1,-1102 # 800123d8 <pr>
    8000082e:	00006597          	auipc	a1,0x6
    80000832:	7fa58593          	addi	a1,a1,2042 # 80007028 <etext+0x28>
    80000836:	8526                	mv	a0,s1
    80000838:	386000ef          	jal	80000bbe <initlock>
  pr.locking = 1;
    8000083c:	4785                	li	a5,1
    8000083e:	cc9c                	sw	a5,24(s1)
}
    80000840:	60e2                	ld	ra,24(sp)
    80000842:	6442                	ld	s0,16(sp)
    80000844:	64a2                	ld	s1,8(sp)
    80000846:	6105                	addi	sp,sp,32
    80000848:	8082                	ret

000000008000084a <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000084a:	1141                	addi	sp,sp,-16
    8000084c:	e406                	sd	ra,8(sp)
    8000084e:	e022                	sd	s0,0(sp)
    80000850:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000852:	100007b7          	lui	a5,0x10000
    80000856:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000085a:	10000737          	lui	a4,0x10000
    8000085e:	f8000693          	li	a3,-128
    80000862:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000866:	468d                	li	a3,3
    80000868:	10000637          	lui	a2,0x10000
    8000086c:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000870:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000874:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000878:	8732                	mv	a4,a2
    8000087a:	461d                	li	a2,7
    8000087c:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000880:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    80000884:	00006597          	auipc	a1,0x6
    80000888:	7ac58593          	addi	a1,a1,1964 # 80007030 <etext+0x30>
    8000088c:	00012517          	auipc	a0,0x12
    80000890:	b6c50513          	addi	a0,a0,-1172 # 800123f8 <uart_tx_lock>
    80000894:	32a000ef          	jal	80000bbe <initlock>
}
    80000898:	60a2                	ld	ra,8(sp)
    8000089a:	6402                	ld	s0,0(sp)
    8000089c:	0141                	addi	sp,sp,16
    8000089e:	8082                	ret

00000000800008a0 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800008a0:	1101                	addi	sp,sp,-32
    800008a2:	ec06                	sd	ra,24(sp)
    800008a4:	e822                	sd	s0,16(sp)
    800008a6:	e426                	sd	s1,8(sp)
    800008a8:	1000                	addi	s0,sp,32
    800008aa:	84aa                	mv	s1,a0
  push_off();
    800008ac:	356000ef          	jal	80000c02 <push_off>

  if(panicked){
    800008b0:	0000a797          	auipc	a5,0xa
    800008b4:	a487a783          	lw	a5,-1464(a5) # 8000a2f8 <panicked>
    800008b8:	e795                	bnez	a5,800008e4 <uartputc_sync+0x44>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800008ba:	10000737          	lui	a4,0x10000
    800008be:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    800008c0:	00074783          	lbu	a5,0(a4)
    800008c4:	0207f793          	andi	a5,a5,32
    800008c8:	dfe5                	beqz	a5,800008c0 <uartputc_sync+0x20>
    ;
  WriteReg(THR, c);
    800008ca:	0ff4f513          	zext.b	a0,s1
    800008ce:	100007b7          	lui	a5,0x10000
    800008d2:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    800008d6:	3b0000ef          	jal	80000c86 <pop_off>
}
    800008da:	60e2                	ld	ra,24(sp)
    800008dc:	6442                	ld	s0,16(sp)
    800008de:	64a2                	ld	s1,8(sp)
    800008e0:	6105                	addi	sp,sp,32
    800008e2:	8082                	ret
    for(;;)
    800008e4:	a001                	j	800008e4 <uartputc_sync+0x44>

00000000800008e6 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    800008e6:	0000a797          	auipc	a5,0xa
    800008ea:	a1a7b783          	ld	a5,-1510(a5) # 8000a300 <uart_tx_r>
    800008ee:	0000a717          	auipc	a4,0xa
    800008f2:	a1a73703          	ld	a4,-1510(a4) # 8000a308 <uart_tx_w>
    800008f6:	08f70163          	beq	a4,a5,80000978 <uartstart+0x92>
{
    800008fa:	7139                	addi	sp,sp,-64
    800008fc:	fc06                	sd	ra,56(sp)
    800008fe:	f822                	sd	s0,48(sp)
    80000900:	f426                	sd	s1,40(sp)
    80000902:	f04a                	sd	s2,32(sp)
    80000904:	ec4e                	sd	s3,24(sp)
    80000906:	e852                	sd	s4,16(sp)
    80000908:	e456                	sd	s5,8(sp)
    8000090a:	e05a                	sd	s6,0(sp)
    8000090c:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      ReadReg(ISR);
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000090e:	10000937          	lui	s2,0x10000
    80000912:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000914:	00012a97          	auipc	s5,0x12
    80000918:	ae4a8a93          	addi	s5,s5,-1308 # 800123f8 <uart_tx_lock>
    uart_tx_r += 1;
    8000091c:	0000a497          	auipc	s1,0xa
    80000920:	9e448493          	addi	s1,s1,-1564 # 8000a300 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    80000924:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    80000928:	0000a997          	auipc	s3,0xa
    8000092c:	9e098993          	addi	s3,s3,-1568 # 8000a308 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000930:	00094703          	lbu	a4,0(s2)
    80000934:	02077713          	andi	a4,a4,32
    80000938:	c715                	beqz	a4,80000964 <uartstart+0x7e>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000093a:	01f7f713          	andi	a4,a5,31
    8000093e:	9756                	add	a4,a4,s5
    80000940:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    80000944:	0785                	addi	a5,a5,1
    80000946:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    80000948:	8526                	mv	a0,s1
    8000094a:	5f0010ef          	jal	80001f3a <wakeup>
    WriteReg(THR, c);
    8000094e:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    80000952:	609c                	ld	a5,0(s1)
    80000954:	0009b703          	ld	a4,0(s3)
    80000958:	fcf71ce3          	bne	a4,a5,80000930 <uartstart+0x4a>
      ReadReg(ISR);
    8000095c:	100007b7          	lui	a5,0x10000
    80000960:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>
  }
}
    80000964:	70e2                	ld	ra,56(sp)
    80000966:	7442                	ld	s0,48(sp)
    80000968:	74a2                	ld	s1,40(sp)
    8000096a:	7902                	ld	s2,32(sp)
    8000096c:	69e2                	ld	s3,24(sp)
    8000096e:	6a42                	ld	s4,16(sp)
    80000970:	6aa2                	ld	s5,8(sp)
    80000972:	6b02                	ld	s6,0(sp)
    80000974:	6121                	addi	sp,sp,64
    80000976:	8082                	ret
      ReadReg(ISR);
    80000978:	100007b7          	lui	a5,0x10000
    8000097c:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>
      return;
    80000980:	8082                	ret

0000000080000982 <uartputc>:
{
    80000982:	7179                	addi	sp,sp,-48
    80000984:	f406                	sd	ra,40(sp)
    80000986:	f022                	sd	s0,32(sp)
    80000988:	ec26                	sd	s1,24(sp)
    8000098a:	e84a                	sd	s2,16(sp)
    8000098c:	e44e                	sd	s3,8(sp)
    8000098e:	e052                	sd	s4,0(sp)
    80000990:	1800                	addi	s0,sp,48
    80000992:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80000994:	00012517          	auipc	a0,0x12
    80000998:	a6450513          	addi	a0,a0,-1436 # 800123f8 <uart_tx_lock>
    8000099c:	2a6000ef          	jal	80000c42 <acquire>
  if(panicked){
    800009a0:	0000a797          	auipc	a5,0xa
    800009a4:	9587a783          	lw	a5,-1704(a5) # 8000a2f8 <panicked>
    800009a8:	efbd                	bnez	a5,80000a26 <uartputc+0xa4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800009aa:	0000a717          	auipc	a4,0xa
    800009ae:	95e73703          	ld	a4,-1698(a4) # 8000a308 <uart_tx_w>
    800009b2:	0000a797          	auipc	a5,0xa
    800009b6:	94e7b783          	ld	a5,-1714(a5) # 8000a300 <uart_tx_r>
    800009ba:	02078793          	addi	a5,a5,32
    sleep(&uart_tx_r, &uart_tx_lock);
    800009be:	00012997          	auipc	s3,0x12
    800009c2:	a3a98993          	addi	s3,s3,-1478 # 800123f8 <uart_tx_lock>
    800009c6:	0000a497          	auipc	s1,0xa
    800009ca:	93a48493          	addi	s1,s1,-1734 # 8000a300 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800009ce:	0000a917          	auipc	s2,0xa
    800009d2:	93a90913          	addi	s2,s2,-1734 # 8000a308 <uart_tx_w>
    800009d6:	00e79d63          	bne	a5,a4,800009f0 <uartputc+0x6e>
    sleep(&uart_tx_r, &uart_tx_lock);
    800009da:	85ce                	mv	a1,s3
    800009dc:	8526                	mv	a0,s1
    800009de:	510010ef          	jal	80001eee <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800009e2:	00093703          	ld	a4,0(s2)
    800009e6:	609c                	ld	a5,0(s1)
    800009e8:	02078793          	addi	a5,a5,32
    800009ec:	fee787e3          	beq	a5,a4,800009da <uartputc+0x58>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800009f0:	00012497          	auipc	s1,0x12
    800009f4:	a0848493          	addi	s1,s1,-1528 # 800123f8 <uart_tx_lock>
    800009f8:	01f77793          	andi	a5,a4,31
    800009fc:	97a6                	add	a5,a5,s1
    800009fe:	01478c23          	sb	s4,24(a5)
  uart_tx_w += 1;
    80000a02:	0705                	addi	a4,a4,1
    80000a04:	0000a797          	auipc	a5,0xa
    80000a08:	90e7b223          	sd	a4,-1788(a5) # 8000a308 <uart_tx_w>
  uartstart();
    80000a0c:	edbff0ef          	jal	800008e6 <uartstart>
  release(&uart_tx_lock);
    80000a10:	8526                	mv	a0,s1
    80000a12:	2c4000ef          	jal	80000cd6 <release>
}
    80000a16:	70a2                	ld	ra,40(sp)
    80000a18:	7402                	ld	s0,32(sp)
    80000a1a:	64e2                	ld	s1,24(sp)
    80000a1c:	6942                	ld	s2,16(sp)
    80000a1e:	69a2                	ld	s3,8(sp)
    80000a20:	6a02                	ld	s4,0(sp)
    80000a22:	6145                	addi	sp,sp,48
    80000a24:	8082                	ret
    for(;;)
    80000a26:	a001                	j	80000a26 <uartputc+0xa4>

0000000080000a28 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000a28:	1141                	addi	sp,sp,-16
    80000a2a:	e406                	sd	ra,8(sp)
    80000a2c:	e022                	sd	s0,0(sp)
    80000a2e:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000a30:	100007b7          	lui	a5,0x10000
    80000a34:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80000a38:	8b85                	andi	a5,a5,1
    80000a3a:	cb89                	beqz	a5,80000a4c <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80000a3c:	100007b7          	lui	a5,0x10000
    80000a40:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80000a44:	60a2                	ld	ra,8(sp)
    80000a46:	6402                	ld	s0,0(sp)
    80000a48:	0141                	addi	sp,sp,16
    80000a4a:	8082                	ret
    return -1;
    80000a4c:	557d                	li	a0,-1
    80000a4e:	bfdd                	j	80000a44 <uartgetc+0x1c>

0000000080000a50 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80000a50:	1101                	addi	sp,sp,-32
    80000a52:	ec06                	sd	ra,24(sp)
    80000a54:	e822                	sd	s0,16(sp)
    80000a56:	e426                	sd	s1,8(sp)
    80000a58:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80000a5a:	54fd                	li	s1,-1
    int c = uartgetc();
    80000a5c:	fcdff0ef          	jal	80000a28 <uartgetc>
    if(c == -1)
    80000a60:	00950563          	beq	a0,s1,80000a6a <uartintr+0x1a>
      break;
    consoleintr(c);
    80000a64:	81dff0ef          	jal	80000280 <consoleintr>
  while(1){
    80000a68:	bfd5                	j	80000a5c <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000a6a:	00012497          	auipc	s1,0x12
    80000a6e:	98e48493          	addi	s1,s1,-1650 # 800123f8 <uart_tx_lock>
    80000a72:	8526                	mv	a0,s1
    80000a74:	1ce000ef          	jal	80000c42 <acquire>
  uartstart();
    80000a78:	e6fff0ef          	jal	800008e6 <uartstart>
  release(&uart_tx_lock);
    80000a7c:	8526                	mv	a0,s1
    80000a7e:	258000ef          	jal	80000cd6 <release>
}
    80000a82:	60e2                	ld	ra,24(sp)
    80000a84:	6442                	ld	s0,16(sp)
    80000a86:	64a2                	ld	s1,8(sp)
    80000a88:	6105                	addi	sp,sp,32
    80000a8a:	8082                	ret

0000000080000a8c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80000a8c:	1101                	addi	sp,sp,-32
    80000a8e:	ec06                	sd	ra,24(sp)
    80000a90:	e822                	sd	s0,16(sp)
    80000a92:	e426                	sd	s1,8(sp)
    80000a94:	e04a                	sd	s2,0(sp)
    80000a96:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000a98:	03451793          	slli	a5,a0,0x34
    80000a9c:	e7a9                	bnez	a5,80000ae6 <kfree+0x5a>
    80000a9e:	84aa                	mv	s1,a0
    80000aa0:	00023797          	auipc	a5,0x23
    80000aa4:	bc078793          	addi	a5,a5,-1088 # 80023660 <end>
    80000aa8:	02f56f63          	bltu	a0,a5,80000ae6 <kfree+0x5a>
    80000aac:	47c5                	li	a5,17
    80000aae:	07ee                	slli	a5,a5,0x1b
    80000ab0:	02f57b63          	bgeu	a0,a5,80000ae6 <kfree+0x5a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000ab4:	6605                	lui	a2,0x1
    80000ab6:	4585                	li	a1,1
    80000ab8:	25a000ef          	jal	80000d12 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000abc:	00012917          	auipc	s2,0x12
    80000ac0:	97490913          	addi	s2,s2,-1676 # 80012430 <kmem>
    80000ac4:	854a                	mv	a0,s2
    80000ac6:	17c000ef          	jal	80000c42 <acquire>
  r->next = kmem.freelist;
    80000aca:	01893783          	ld	a5,24(s2)
    80000ace:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000ad0:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000ad4:	854a                	mv	a0,s2
    80000ad6:	200000ef          	jal	80000cd6 <release>
}
    80000ada:	60e2                	ld	ra,24(sp)
    80000adc:	6442                	ld	s0,16(sp)
    80000ade:	64a2                	ld	s1,8(sp)
    80000ae0:	6902                	ld	s2,0(sp)
    80000ae2:	6105                	addi	sp,sp,32
    80000ae4:	8082                	ret
    panic("kfree");
    80000ae6:	00006517          	auipc	a0,0x6
    80000aea:	55250513          	addi	a0,a0,1362 # 80007038 <etext+0x38>
    80000aee:	cf5ff0ef          	jal	800007e2 <panic>

0000000080000af2 <freerange>:
{
    80000af2:	7179                	addi	sp,sp,-48
    80000af4:	f406                	sd	ra,40(sp)
    80000af6:	f022                	sd	s0,32(sp)
    80000af8:	ec26                	sd	s1,24(sp)
    80000afa:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000afc:	6785                	lui	a5,0x1
    80000afe:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000b02:	00e504b3          	add	s1,a0,a4
    80000b06:	777d                	lui	a4,0xfffff
    80000b08:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b0a:	94be                	add	s1,s1,a5
    80000b0c:	0295e263          	bltu	a1,s1,80000b30 <freerange+0x3e>
    80000b10:	e84a                	sd	s2,16(sp)
    80000b12:	e44e                	sd	s3,8(sp)
    80000b14:	e052                	sd	s4,0(sp)
    80000b16:	892e                	mv	s2,a1
    kfree(p);
    80000b18:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b1a:	89be                	mv	s3,a5
    kfree(p);
    80000b1c:	01448533          	add	a0,s1,s4
    80000b20:	f6dff0ef          	jal	80000a8c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000b24:	94ce                	add	s1,s1,s3
    80000b26:	fe997be3          	bgeu	s2,s1,80000b1c <freerange+0x2a>
    80000b2a:	6942                	ld	s2,16(sp)
    80000b2c:	69a2                	ld	s3,8(sp)
    80000b2e:	6a02                	ld	s4,0(sp)
}
    80000b30:	70a2                	ld	ra,40(sp)
    80000b32:	7402                	ld	s0,32(sp)
    80000b34:	64e2                	ld	s1,24(sp)
    80000b36:	6145                	addi	sp,sp,48
    80000b38:	8082                	ret

0000000080000b3a <kinit>:
{
    80000b3a:	1141                	addi	sp,sp,-16
    80000b3c:	e406                	sd	ra,8(sp)
    80000b3e:	e022                	sd	s0,0(sp)
    80000b40:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000b42:	00006597          	auipc	a1,0x6
    80000b46:	4fe58593          	addi	a1,a1,1278 # 80007040 <etext+0x40>
    80000b4a:	00012517          	auipc	a0,0x12
    80000b4e:	8e650513          	addi	a0,a0,-1818 # 80012430 <kmem>
    80000b52:	06c000ef          	jal	80000bbe <initlock>
  freerange(end, (void*)PHYSTOP);
    80000b56:	45c5                	li	a1,17
    80000b58:	05ee                	slli	a1,a1,0x1b
    80000b5a:	00023517          	auipc	a0,0x23
    80000b5e:	b0650513          	addi	a0,a0,-1274 # 80023660 <end>
    80000b62:	f91ff0ef          	jal	80000af2 <freerange>
}
    80000b66:	60a2                	ld	ra,8(sp)
    80000b68:	6402                	ld	s0,0(sp)
    80000b6a:	0141                	addi	sp,sp,16
    80000b6c:	8082                	ret

0000000080000b6e <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000b6e:	1101                	addi	sp,sp,-32
    80000b70:	ec06                	sd	ra,24(sp)
    80000b72:	e822                	sd	s0,16(sp)
    80000b74:	e426                	sd	s1,8(sp)
    80000b76:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000b78:	00012497          	auipc	s1,0x12
    80000b7c:	8b848493          	addi	s1,s1,-1864 # 80012430 <kmem>
    80000b80:	8526                	mv	a0,s1
    80000b82:	0c0000ef          	jal	80000c42 <acquire>
  r = kmem.freelist;
    80000b86:	6c84                	ld	s1,24(s1)
  if(r)
    80000b88:	c485                	beqz	s1,80000bb0 <kalloc+0x42>
    kmem.freelist = r->next;
    80000b8a:	609c                	ld	a5,0(s1)
    80000b8c:	00012517          	auipc	a0,0x12
    80000b90:	8a450513          	addi	a0,a0,-1884 # 80012430 <kmem>
    80000b94:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b96:	140000ef          	jal	80000cd6 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000b9a:	6605                	lui	a2,0x1
    80000b9c:	4595                	li	a1,5
    80000b9e:	8526                	mv	a0,s1
    80000ba0:	172000ef          	jal	80000d12 <memset>
  return (void*)r;
}
    80000ba4:	8526                	mv	a0,s1
    80000ba6:	60e2                	ld	ra,24(sp)
    80000ba8:	6442                	ld	s0,16(sp)
    80000baa:	64a2                	ld	s1,8(sp)
    80000bac:	6105                	addi	sp,sp,32
    80000bae:	8082                	ret
  release(&kmem.lock);
    80000bb0:	00012517          	auipc	a0,0x12
    80000bb4:	88050513          	addi	a0,a0,-1920 # 80012430 <kmem>
    80000bb8:	11e000ef          	jal	80000cd6 <release>
  if(r)
    80000bbc:	b7e5                	j	80000ba4 <kalloc+0x36>

0000000080000bbe <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000bbe:	1141                	addi	sp,sp,-16
    80000bc0:	e406                	sd	ra,8(sp)
    80000bc2:	e022                	sd	s0,0(sp)
    80000bc4:	0800                	addi	s0,sp,16
  lk->name = name;
    80000bc6:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000bc8:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000bcc:	00053823          	sd	zero,16(a0)
}
    80000bd0:	60a2                	ld	ra,8(sp)
    80000bd2:	6402                	ld	s0,0(sp)
    80000bd4:	0141                	addi	sp,sp,16
    80000bd6:	8082                	ret

0000000080000bd8 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000bd8:	411c                	lw	a5,0(a0)
    80000bda:	e399                	bnez	a5,80000be0 <holding+0x8>
    80000bdc:	4501                	li	a0,0
  return r;
}
    80000bde:	8082                	ret
{
    80000be0:	1101                	addi	sp,sp,-32
    80000be2:	ec06                	sd	ra,24(sp)
    80000be4:	e822                	sd	s0,16(sp)
    80000be6:	e426                	sd	s1,8(sp)
    80000be8:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000bea:	6904                	ld	s1,16(a0)
    80000bec:	515000ef          	jal	80001900 <mycpu>
    80000bf0:	40a48533          	sub	a0,s1,a0
    80000bf4:	00153513          	seqz	a0,a0
}
    80000bf8:	60e2                	ld	ra,24(sp)
    80000bfa:	6442                	ld	s0,16(sp)
    80000bfc:	64a2                	ld	s1,8(sp)
    80000bfe:	6105                	addi	sp,sp,32
    80000c00:	8082                	ret

0000000080000c02 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000c02:	1101                	addi	sp,sp,-32
    80000c04:	ec06                	sd	ra,24(sp)
    80000c06:	e822                	sd	s0,16(sp)
    80000c08:	e426                	sd	s1,8(sp)
    80000c0a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c0c:	100024f3          	csrr	s1,sstatus
    80000c10:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000c14:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c16:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000c1a:	4e7000ef          	jal	80001900 <mycpu>
    80000c1e:	5d3c                	lw	a5,120(a0)
    80000c20:	cb99                	beqz	a5,80000c36 <push_off+0x34>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000c22:	4df000ef          	jal	80001900 <mycpu>
    80000c26:	5d3c                	lw	a5,120(a0)
    80000c28:	2785                	addiw	a5,a5,1
    80000c2a:	dd3c                	sw	a5,120(a0)
}
    80000c2c:	60e2                	ld	ra,24(sp)
    80000c2e:	6442                	ld	s0,16(sp)
    80000c30:	64a2                	ld	s1,8(sp)
    80000c32:	6105                	addi	sp,sp,32
    80000c34:	8082                	ret
    mycpu()->intena = old;
    80000c36:	4cb000ef          	jal	80001900 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000c3a:	8085                	srli	s1,s1,0x1
    80000c3c:	8885                	andi	s1,s1,1
    80000c3e:	dd64                	sw	s1,124(a0)
    80000c40:	b7cd                	j	80000c22 <push_off+0x20>

0000000080000c42 <acquire>:
{
    80000c42:	1101                	addi	sp,sp,-32
    80000c44:	ec06                	sd	ra,24(sp)
    80000c46:	e822                	sd	s0,16(sp)
    80000c48:	e426                	sd	s1,8(sp)
    80000c4a:	1000                	addi	s0,sp,32
    80000c4c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000c4e:	fb5ff0ef          	jal	80000c02 <push_off>
  if(holding(lk))
    80000c52:	8526                	mv	a0,s1
    80000c54:	f85ff0ef          	jal	80000bd8 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c58:	4705                	li	a4,1
  if(holding(lk))
    80000c5a:	e105                	bnez	a0,80000c7a <acquire+0x38>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000c5c:	87ba                	mv	a5,a4
    80000c5e:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000c62:	2781                	sext.w	a5,a5
    80000c64:	ffe5                	bnez	a5,80000c5c <acquire+0x1a>
  __sync_synchronize();
    80000c66:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    80000c6a:	497000ef          	jal	80001900 <mycpu>
    80000c6e:	e888                	sd	a0,16(s1)
}
    80000c70:	60e2                	ld	ra,24(sp)
    80000c72:	6442                	ld	s0,16(sp)
    80000c74:	64a2                	ld	s1,8(sp)
    80000c76:	6105                	addi	sp,sp,32
    80000c78:	8082                	ret
    panic("acquire");
    80000c7a:	00006517          	auipc	a0,0x6
    80000c7e:	3ce50513          	addi	a0,a0,974 # 80007048 <etext+0x48>
    80000c82:	b61ff0ef          	jal	800007e2 <panic>

0000000080000c86 <pop_off>:

void
pop_off(void)
{
    80000c86:	1141                	addi	sp,sp,-16
    80000c88:	e406                	sd	ra,8(sp)
    80000c8a:	e022                	sd	s0,0(sp)
    80000c8c:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c8e:	473000ef          	jal	80001900 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c92:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c96:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000c98:	e39d                	bnez	a5,80000cbe <pop_off+0x38>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c9a:	5d3c                	lw	a5,120(a0)
    80000c9c:	02f05763          	blez	a5,80000cca <pop_off+0x44>
    panic("pop_off");
  c->noff -= 1;
    80000ca0:	37fd                	addiw	a5,a5,-1
    80000ca2:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000ca4:	eb89                	bnez	a5,80000cb6 <pop_off+0x30>
    80000ca6:	5d7c                	lw	a5,124(a0)
    80000ca8:	c799                	beqz	a5,80000cb6 <pop_off+0x30>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000caa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000cae:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000cb2:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000cb6:	60a2                	ld	ra,8(sp)
    80000cb8:	6402                	ld	s0,0(sp)
    80000cba:	0141                	addi	sp,sp,16
    80000cbc:	8082                	ret
    panic("pop_off - interruptible");
    80000cbe:	00006517          	auipc	a0,0x6
    80000cc2:	39250513          	addi	a0,a0,914 # 80007050 <etext+0x50>
    80000cc6:	b1dff0ef          	jal	800007e2 <panic>
    panic("pop_off");
    80000cca:	00006517          	auipc	a0,0x6
    80000cce:	39e50513          	addi	a0,a0,926 # 80007068 <etext+0x68>
    80000cd2:	b11ff0ef          	jal	800007e2 <panic>

0000000080000cd6 <release>:
{
    80000cd6:	1101                	addi	sp,sp,-32
    80000cd8:	ec06                	sd	ra,24(sp)
    80000cda:	e822                	sd	s0,16(sp)
    80000cdc:	e426                	sd	s1,8(sp)
    80000cde:	1000                	addi	s0,sp,32
    80000ce0:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000ce2:	ef7ff0ef          	jal	80000bd8 <holding>
    80000ce6:	c105                	beqz	a0,80000d06 <release+0x30>
  lk->cpu = 0;
    80000ce8:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000cec:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80000cf0:	0310000f          	fence	rw,w
    80000cf4:	0004a023          	sw	zero,0(s1)
  pop_off();
    80000cf8:	f8fff0ef          	jal	80000c86 <pop_off>
}
    80000cfc:	60e2                	ld	ra,24(sp)
    80000cfe:	6442                	ld	s0,16(sp)
    80000d00:	64a2                	ld	s1,8(sp)
    80000d02:	6105                	addi	sp,sp,32
    80000d04:	8082                	ret
    panic("release");
    80000d06:	00006517          	auipc	a0,0x6
    80000d0a:	36a50513          	addi	a0,a0,874 # 80007070 <etext+0x70>
    80000d0e:	ad5ff0ef          	jal	800007e2 <panic>

0000000080000d12 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000d12:	1141                	addi	sp,sp,-16
    80000d14:	e406                	sd	ra,8(sp)
    80000d16:	e022                	sd	s0,0(sp)
    80000d18:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000d1a:	ca19                	beqz	a2,80000d30 <memset+0x1e>
    80000d1c:	87aa                	mv	a5,a0
    80000d1e:	1602                	slli	a2,a2,0x20
    80000d20:	9201                	srli	a2,a2,0x20
    80000d22:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000d26:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000d2a:	0785                	addi	a5,a5,1
    80000d2c:	fee79de3          	bne	a5,a4,80000d26 <memset+0x14>
  }
  return dst;
}
    80000d30:	60a2                	ld	ra,8(sp)
    80000d32:	6402                	ld	s0,0(sp)
    80000d34:	0141                	addi	sp,sp,16
    80000d36:	8082                	ret

0000000080000d38 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000d38:	1141                	addi	sp,sp,-16
    80000d3a:	e406                	sd	ra,8(sp)
    80000d3c:	e022                	sd	s0,0(sp)
    80000d3e:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000d40:	ca0d                	beqz	a2,80000d72 <memcmp+0x3a>
    80000d42:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    80000d46:	1682                	slli	a3,a3,0x20
    80000d48:	9281                	srli	a3,a3,0x20
    80000d4a:	0685                	addi	a3,a3,1
    80000d4c:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000d4e:	00054783          	lbu	a5,0(a0)
    80000d52:	0005c703          	lbu	a4,0(a1)
    80000d56:	00e79863          	bne	a5,a4,80000d66 <memcmp+0x2e>
      return *s1 - *s2;
    s1++, s2++;
    80000d5a:	0505                	addi	a0,a0,1
    80000d5c:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000d5e:	fed518e3          	bne	a0,a3,80000d4e <memcmp+0x16>
  }

  return 0;
    80000d62:	4501                	li	a0,0
    80000d64:	a019                	j	80000d6a <memcmp+0x32>
      return *s1 - *s2;
    80000d66:	40e7853b          	subw	a0,a5,a4
}
    80000d6a:	60a2                	ld	ra,8(sp)
    80000d6c:	6402                	ld	s0,0(sp)
    80000d6e:	0141                	addi	sp,sp,16
    80000d70:	8082                	ret
  return 0;
    80000d72:	4501                	li	a0,0
    80000d74:	bfdd                	j	80000d6a <memcmp+0x32>

0000000080000d76 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000d76:	1141                	addi	sp,sp,-16
    80000d78:	e406                	sd	ra,8(sp)
    80000d7a:	e022                	sd	s0,0(sp)
    80000d7c:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    80000d7e:	c205                	beqz	a2,80000d9e <memmove+0x28>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    80000d80:	02a5e363          	bltu	a1,a0,80000da6 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000d84:	1602                	slli	a2,a2,0x20
    80000d86:	9201                	srli	a2,a2,0x20
    80000d88:	00c587b3          	add	a5,a1,a2
{
    80000d8c:	872a                	mv	a4,a0
      *d++ = *s++;
    80000d8e:	0585                	addi	a1,a1,1
    80000d90:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdb9a1>
    80000d92:	fff5c683          	lbu	a3,-1(a1)
    80000d96:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000d9a:	feb79ae3          	bne	a5,a1,80000d8e <memmove+0x18>

  return dst;
}
    80000d9e:	60a2                	ld	ra,8(sp)
    80000da0:	6402                	ld	s0,0(sp)
    80000da2:	0141                	addi	sp,sp,16
    80000da4:	8082                	ret
  if(s < d && s + n > d){
    80000da6:	02061693          	slli	a3,a2,0x20
    80000daa:	9281                	srli	a3,a3,0x20
    80000dac:	00d58733          	add	a4,a1,a3
    80000db0:	fce57ae3          	bgeu	a0,a4,80000d84 <memmove+0xe>
    d += n;
    80000db4:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000db6:	fff6079b          	addiw	a5,a2,-1
    80000dba:	1782                	slli	a5,a5,0x20
    80000dbc:	9381                	srli	a5,a5,0x20
    80000dbe:	fff7c793          	not	a5,a5
    80000dc2:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000dc4:	177d                	addi	a4,a4,-1
    80000dc6:	16fd                	addi	a3,a3,-1
    80000dc8:	00074603          	lbu	a2,0(a4)
    80000dcc:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000dd0:	fee79ae3          	bne	a5,a4,80000dc4 <memmove+0x4e>
    80000dd4:	b7e9                	j	80000d9e <memmove+0x28>

0000000080000dd6 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000dd6:	1141                	addi	sp,sp,-16
    80000dd8:	e406                	sd	ra,8(sp)
    80000dda:	e022                	sd	s0,0(sp)
    80000ddc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000dde:	f99ff0ef          	jal	80000d76 <memmove>
}
    80000de2:	60a2                	ld	ra,8(sp)
    80000de4:	6402                	ld	s0,0(sp)
    80000de6:	0141                	addi	sp,sp,16
    80000de8:	8082                	ret

0000000080000dea <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000dea:	1141                	addi	sp,sp,-16
    80000dec:	e406                	sd	ra,8(sp)
    80000dee:	e022                	sd	s0,0(sp)
    80000df0:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000df2:	ce11                	beqz	a2,80000e0e <strncmp+0x24>
    80000df4:	00054783          	lbu	a5,0(a0)
    80000df8:	cf89                	beqz	a5,80000e12 <strncmp+0x28>
    80000dfa:	0005c703          	lbu	a4,0(a1)
    80000dfe:	00f71a63          	bne	a4,a5,80000e12 <strncmp+0x28>
    n--, p++, q++;
    80000e02:	367d                	addiw	a2,a2,-1
    80000e04:	0505                	addi	a0,a0,1
    80000e06:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000e08:	f675                	bnez	a2,80000df4 <strncmp+0xa>
  if(n == 0)
    return 0;
    80000e0a:	4501                	li	a0,0
    80000e0c:	a801                	j	80000e1c <strncmp+0x32>
    80000e0e:	4501                	li	a0,0
    80000e10:	a031                	j	80000e1c <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    80000e12:	00054503          	lbu	a0,0(a0)
    80000e16:	0005c783          	lbu	a5,0(a1)
    80000e1a:	9d1d                	subw	a0,a0,a5
}
    80000e1c:	60a2                	ld	ra,8(sp)
    80000e1e:	6402                	ld	s0,0(sp)
    80000e20:	0141                	addi	sp,sp,16
    80000e22:	8082                	ret

0000000080000e24 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000e24:	1141                	addi	sp,sp,-16
    80000e26:	e406                	sd	ra,8(sp)
    80000e28:	e022                	sd	s0,0(sp)
    80000e2a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000e2c:	87aa                	mv	a5,a0
    80000e2e:	86b2                	mv	a3,a2
    80000e30:	367d                	addiw	a2,a2,-1
    80000e32:	02d05563          	blez	a3,80000e5c <strncpy+0x38>
    80000e36:	0785                	addi	a5,a5,1
    80000e38:	0005c703          	lbu	a4,0(a1)
    80000e3c:	fee78fa3          	sb	a4,-1(a5)
    80000e40:	0585                	addi	a1,a1,1
    80000e42:	f775                	bnez	a4,80000e2e <strncpy+0xa>
    ;
  while(n-- > 0)
    80000e44:	873e                	mv	a4,a5
    80000e46:	00c05b63          	blez	a2,80000e5c <strncpy+0x38>
    80000e4a:	9fb5                	addw	a5,a5,a3
    80000e4c:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    80000e4e:	0705                	addi	a4,a4,1
    80000e50:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000e54:	40e786bb          	subw	a3,a5,a4
    80000e58:	fed04be3          	bgtz	a3,80000e4e <strncpy+0x2a>
  return os;
}
    80000e5c:	60a2                	ld	ra,8(sp)
    80000e5e:	6402                	ld	s0,0(sp)
    80000e60:	0141                	addi	sp,sp,16
    80000e62:	8082                	ret

0000000080000e64 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000e64:	1141                	addi	sp,sp,-16
    80000e66:	e406                	sd	ra,8(sp)
    80000e68:	e022                	sd	s0,0(sp)
    80000e6a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000e6c:	02c05363          	blez	a2,80000e92 <safestrcpy+0x2e>
    80000e70:	fff6069b          	addiw	a3,a2,-1
    80000e74:	1682                	slli	a3,a3,0x20
    80000e76:	9281                	srli	a3,a3,0x20
    80000e78:	96ae                	add	a3,a3,a1
    80000e7a:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000e7c:	00d58963          	beq	a1,a3,80000e8e <safestrcpy+0x2a>
    80000e80:	0585                	addi	a1,a1,1
    80000e82:	0785                	addi	a5,a5,1
    80000e84:	fff5c703          	lbu	a4,-1(a1)
    80000e88:	fee78fa3          	sb	a4,-1(a5)
    80000e8c:	fb65                	bnez	a4,80000e7c <safestrcpy+0x18>
    ;
  *s = 0;
    80000e8e:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e92:	60a2                	ld	ra,8(sp)
    80000e94:	6402                	ld	s0,0(sp)
    80000e96:	0141                	addi	sp,sp,16
    80000e98:	8082                	ret

0000000080000e9a <strlen>:

int
strlen(const char *s)
{
    80000e9a:	1141                	addi	sp,sp,-16
    80000e9c:	e406                	sd	ra,8(sp)
    80000e9e:	e022                	sd	s0,0(sp)
    80000ea0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000ea2:	00054783          	lbu	a5,0(a0)
    80000ea6:	cf99                	beqz	a5,80000ec4 <strlen+0x2a>
    80000ea8:	0505                	addi	a0,a0,1
    80000eaa:	87aa                	mv	a5,a0
    80000eac:	86be                	mv	a3,a5
    80000eae:	0785                	addi	a5,a5,1
    80000eb0:	fff7c703          	lbu	a4,-1(a5)
    80000eb4:	ff65                	bnez	a4,80000eac <strlen+0x12>
    80000eb6:	40a6853b          	subw	a0,a3,a0
    80000eba:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    80000ebc:	60a2                	ld	ra,8(sp)
    80000ebe:	6402                	ld	s0,0(sp)
    80000ec0:	0141                	addi	sp,sp,16
    80000ec2:	8082                	ret
  for(n = 0; s[n]; n++)
    80000ec4:	4501                	li	a0,0
    80000ec6:	bfdd                	j	80000ebc <strlen+0x22>

0000000080000ec8 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000ec8:	1141                	addi	sp,sp,-16
    80000eca:	e406                	sd	ra,8(sp)
    80000ecc:	e022                	sd	s0,0(sp)
    80000ece:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000ed0:	21d000ef          	jal	800018ec <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000ed4:	00009717          	auipc	a4,0x9
    80000ed8:	43c70713          	addi	a4,a4,1084 # 8000a310 <started>
  if(cpuid() == 0){
    80000edc:	c51d                	beqz	a0,80000f0a <main+0x42>
    while(started == 0)
    80000ede:	431c                	lw	a5,0(a4)
    80000ee0:	2781                	sext.w	a5,a5
    80000ee2:	dff5                	beqz	a5,80000ede <main+0x16>
      ;
    __sync_synchronize();
    80000ee4:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000ee8:	205000ef          	jal	800018ec <cpuid>
    80000eec:	85aa                	mv	a1,a0
    80000eee:	00006517          	auipc	a0,0x6
    80000ef2:	1aa50513          	addi	a0,a0,426 # 80007098 <etext+0x98>
    80000ef6:	e1cff0ef          	jal	80000512 <printf>
    kvminithart();    // turn on paging
    80000efa:	080000ef          	jal	80000f7a <kvminithart>
    trapinithart();   // install kernel trap vector
    80000efe:	50c010ef          	jal	8000240a <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000f02:	3e6040ef          	jal	800052e8 <plicinithart>
  }

  scheduler();        
    80000f06:	64f000ef          	jal	80001d54 <scheduler>
    consoleinit();
    80000f0a:	d04ff0ef          	jal	8000040e <consoleinit>
    printfinit();
    80000f0e:	90fff0ef          	jal	8000081c <printfinit>
    printf("\n");
    80000f12:	00006517          	auipc	a0,0x6
    80000f16:	16650513          	addi	a0,a0,358 # 80007078 <etext+0x78>
    80000f1a:	df8ff0ef          	jal	80000512 <printf>
    printf("xv6 kernel is booting\n");
    80000f1e:	00006517          	auipc	a0,0x6
    80000f22:	16250513          	addi	a0,a0,354 # 80007080 <etext+0x80>
    80000f26:	decff0ef          	jal	80000512 <printf>
    printf("\n");
    80000f2a:	00006517          	auipc	a0,0x6
    80000f2e:	14e50513          	addi	a0,a0,334 # 80007078 <etext+0x78>
    80000f32:	de0ff0ef          	jal	80000512 <printf>
    kinit();         // physical page allocator
    80000f36:	c05ff0ef          	jal	80000b3a <kinit>
    kvminit();       // create kernel page table
    80000f3a:	2ce000ef          	jal	80001208 <kvminit>
    kvminithart();   // turn on paging
    80000f3e:	03c000ef          	jal	80000f7a <kvminithart>
    procinit();      // process table
    80000f42:	0fb000ef          	jal	8000183c <procinit>
    trapinit();      // trap vectors
    80000f46:	4a0010ef          	jal	800023e6 <trapinit>
    trapinithart();  // install kernel trap vector
    80000f4a:	4c0010ef          	jal	8000240a <trapinithart>
    plicinit();      // set up interrupt controller
    80000f4e:	380040ef          	jal	800052ce <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f52:	396040ef          	jal	800052e8 <plicinithart>
    binit();         // buffer cache
    80000f56:	2fd010ef          	jal	80002a52 <binit>
    iinit();         // inode table
    80000f5a:	0c8020ef          	jal	80003022 <iinit>
    fileinit();      // file table
    80000f5e:	697020ef          	jal	80003df4 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f62:	476040ef          	jal	800053d8 <virtio_disk_init>
    userinit();      // first user process
    80000f66:	423000ef          	jal	80001b88 <userinit>
    __sync_synchronize();
    80000f6a:	0330000f          	fence	rw,rw
    started = 1;
    80000f6e:	4785                	li	a5,1
    80000f70:	00009717          	auipc	a4,0x9
    80000f74:	3af72023          	sw	a5,928(a4) # 8000a310 <started>
    80000f78:	b779                	j	80000f06 <main+0x3e>

0000000080000f7a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000f7a:	1141                	addi	sp,sp,-16
    80000f7c:	e406                	sd	ra,8(sp)
    80000f7e:	e022                	sd	s0,0(sp)
    80000f80:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000f82:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000f86:	00009797          	auipc	a5,0x9
    80000f8a:	3927b783          	ld	a5,914(a5) # 8000a318 <kernel_pagetable>
    80000f8e:	83b1                	srli	a5,a5,0xc
    80000f90:	577d                	li	a4,-1
    80000f92:	177e                	slli	a4,a4,0x3f
    80000f94:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000f96:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    80000f9a:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    80000f9e:	60a2                	ld	ra,8(sp)
    80000fa0:	6402                	ld	s0,0(sp)
    80000fa2:	0141                	addi	sp,sp,16
    80000fa4:	8082                	ret

0000000080000fa6 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000fa6:	7139                	addi	sp,sp,-64
    80000fa8:	fc06                	sd	ra,56(sp)
    80000faa:	f822                	sd	s0,48(sp)
    80000fac:	f426                	sd	s1,40(sp)
    80000fae:	f04a                	sd	s2,32(sp)
    80000fb0:	ec4e                	sd	s3,24(sp)
    80000fb2:	e852                	sd	s4,16(sp)
    80000fb4:	e456                	sd	s5,8(sp)
    80000fb6:	e05a                	sd	s6,0(sp)
    80000fb8:	0080                	addi	s0,sp,64
    80000fba:	84aa                	mv	s1,a0
    80000fbc:	89ae                	mv	s3,a1
    80000fbe:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000fc0:	57fd                	li	a5,-1
    80000fc2:	83e9                	srli	a5,a5,0x1a
    80000fc4:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000fc6:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000fc8:	04b7e263          	bltu	a5,a1,8000100c <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    80000fcc:	0149d933          	srl	s2,s3,s4
    80000fd0:	1ff97913          	andi	s2,s2,511
    80000fd4:	090e                	slli	s2,s2,0x3
    80000fd6:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000fd8:	00093483          	ld	s1,0(s2)
    80000fdc:	0014f793          	andi	a5,s1,1
    80000fe0:	cf85                	beqz	a5,80001018 <walk+0x72>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80000fe2:	80a9                	srli	s1,s1,0xa
    80000fe4:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    80000fe6:	3a5d                	addiw	s4,s4,-9
    80000fe8:	ff6a12e3          	bne	s4,s6,80000fcc <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    80000fec:	00c9d513          	srli	a0,s3,0xc
    80000ff0:	1ff57513          	andi	a0,a0,511
    80000ff4:	050e                	slli	a0,a0,0x3
    80000ff6:	9526                	add	a0,a0,s1
}
    80000ff8:	70e2                	ld	ra,56(sp)
    80000ffa:	7442                	ld	s0,48(sp)
    80000ffc:	74a2                	ld	s1,40(sp)
    80000ffe:	7902                	ld	s2,32(sp)
    80001000:	69e2                	ld	s3,24(sp)
    80001002:	6a42                	ld	s4,16(sp)
    80001004:	6aa2                	ld	s5,8(sp)
    80001006:	6b02                	ld	s6,0(sp)
    80001008:	6121                	addi	sp,sp,64
    8000100a:	8082                	ret
    panic("walk");
    8000100c:	00006517          	auipc	a0,0x6
    80001010:	0a450513          	addi	a0,a0,164 # 800070b0 <etext+0xb0>
    80001014:	fceff0ef          	jal	800007e2 <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001018:	020a8263          	beqz	s5,8000103c <walk+0x96>
    8000101c:	b53ff0ef          	jal	80000b6e <kalloc>
    80001020:	84aa                	mv	s1,a0
    80001022:	d979                	beqz	a0,80000ff8 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    80001024:	6605                	lui	a2,0x1
    80001026:	4581                	li	a1,0
    80001028:	cebff0ef          	jal	80000d12 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    8000102c:	00c4d793          	srli	a5,s1,0xc
    80001030:	07aa                	slli	a5,a5,0xa
    80001032:	0017e793          	ori	a5,a5,1
    80001036:	00f93023          	sd	a5,0(s2)
    8000103a:	b775                	j	80000fe6 <walk+0x40>
        return 0;
    8000103c:	4501                	li	a0,0
    8000103e:	bf6d                	j	80000ff8 <walk+0x52>

0000000080001040 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80001040:	57fd                	li	a5,-1
    80001042:	83e9                	srli	a5,a5,0x1a
    80001044:	00b7f463          	bgeu	a5,a1,8000104c <walkaddr+0xc>
    return 0;
    80001048:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000104a:	8082                	ret
{
    8000104c:	1141                	addi	sp,sp,-16
    8000104e:	e406                	sd	ra,8(sp)
    80001050:	e022                	sd	s0,0(sp)
    80001052:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80001054:	4601                	li	a2,0
    80001056:	f51ff0ef          	jal	80000fa6 <walk>
  if(pte == 0)
    8000105a:	c105                	beqz	a0,8000107a <walkaddr+0x3a>
  if((*pte & PTE_V) == 0)
    8000105c:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000105e:	0117f693          	andi	a3,a5,17
    80001062:	4745                	li	a4,17
    return 0;
    80001064:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80001066:	00e68663          	beq	a3,a4,80001072 <walkaddr+0x32>
}
    8000106a:	60a2                	ld	ra,8(sp)
    8000106c:	6402                	ld	s0,0(sp)
    8000106e:	0141                	addi	sp,sp,16
    80001070:	8082                	ret
  pa = PTE2PA(*pte);
    80001072:	83a9                	srli	a5,a5,0xa
    80001074:	00c79513          	slli	a0,a5,0xc
  return pa;
    80001078:	bfcd                	j	8000106a <walkaddr+0x2a>
    return 0;
    8000107a:	4501                	li	a0,0
    8000107c:	b7fd                	j	8000106a <walkaddr+0x2a>

000000008000107e <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000107e:	715d                	addi	sp,sp,-80
    80001080:	e486                	sd	ra,72(sp)
    80001082:	e0a2                	sd	s0,64(sp)
    80001084:	fc26                	sd	s1,56(sp)
    80001086:	f84a                	sd	s2,48(sp)
    80001088:	f44e                	sd	s3,40(sp)
    8000108a:	f052                	sd	s4,32(sp)
    8000108c:	ec56                	sd	s5,24(sp)
    8000108e:	e85a                	sd	s6,16(sp)
    80001090:	e45e                	sd	s7,8(sp)
    80001092:	e062                	sd	s8,0(sp)
    80001094:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001096:	03459793          	slli	a5,a1,0x34
    8000109a:	e7b1                	bnez	a5,800010e6 <mappages+0x68>
    8000109c:	8aaa                	mv	s5,a0
    8000109e:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800010a0:	03461793          	slli	a5,a2,0x34
    800010a4:	e7b9                	bnez	a5,800010f2 <mappages+0x74>
    panic("mappages: size not aligned");

  if(size == 0)
    800010a6:	ce21                	beqz	a2,800010fe <mappages+0x80>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800010a8:	77fd                	lui	a5,0xfffff
    800010aa:	963e                	add	a2,a2,a5
    800010ac:	00b609b3          	add	s3,a2,a1
  a = va;
    800010b0:	892e                	mv	s2,a1
    800010b2:	40b68a33          	sub	s4,a3,a1
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    800010b6:	4b85                	li	s7,1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800010b8:	6c05                	lui	s8,0x1
    800010ba:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    800010be:	865e                	mv	a2,s7
    800010c0:	85ca                	mv	a1,s2
    800010c2:	8556                	mv	a0,s5
    800010c4:	ee3ff0ef          	jal	80000fa6 <walk>
    800010c8:	c539                	beqz	a0,80001116 <mappages+0x98>
    if(*pte & PTE_V)
    800010ca:	611c                	ld	a5,0(a0)
    800010cc:	8b85                	andi	a5,a5,1
    800010ce:	ef95                	bnez	a5,8000110a <mappages+0x8c>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800010d0:	80b1                	srli	s1,s1,0xc
    800010d2:	04aa                	slli	s1,s1,0xa
    800010d4:	0164e4b3          	or	s1,s1,s6
    800010d8:	0014e493          	ori	s1,s1,1
    800010dc:	e104                	sd	s1,0(a0)
    if(a == last)
    800010de:	05390963          	beq	s2,s3,80001130 <mappages+0xb2>
    a += PGSIZE;
    800010e2:	9962                	add	s2,s2,s8
    if((pte = walk(pagetable, a, 1)) == 0)
    800010e4:	bfd9                	j	800010ba <mappages+0x3c>
    panic("mappages: va not aligned");
    800010e6:	00006517          	auipc	a0,0x6
    800010ea:	fd250513          	addi	a0,a0,-46 # 800070b8 <etext+0xb8>
    800010ee:	ef4ff0ef          	jal	800007e2 <panic>
    panic("mappages: size not aligned");
    800010f2:	00006517          	auipc	a0,0x6
    800010f6:	fe650513          	addi	a0,a0,-26 # 800070d8 <etext+0xd8>
    800010fa:	ee8ff0ef          	jal	800007e2 <panic>
    panic("mappages: size");
    800010fe:	00006517          	auipc	a0,0x6
    80001102:	ffa50513          	addi	a0,a0,-6 # 800070f8 <etext+0xf8>
    80001106:	edcff0ef          	jal	800007e2 <panic>
      panic("mappages: remap");
    8000110a:	00006517          	auipc	a0,0x6
    8000110e:	ffe50513          	addi	a0,a0,-2 # 80007108 <etext+0x108>
    80001112:	ed0ff0ef          	jal	800007e2 <panic>
      return -1;
    80001116:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80001118:	60a6                	ld	ra,72(sp)
    8000111a:	6406                	ld	s0,64(sp)
    8000111c:	74e2                	ld	s1,56(sp)
    8000111e:	7942                	ld	s2,48(sp)
    80001120:	79a2                	ld	s3,40(sp)
    80001122:	7a02                	ld	s4,32(sp)
    80001124:	6ae2                	ld	s5,24(sp)
    80001126:	6b42                	ld	s6,16(sp)
    80001128:	6ba2                	ld	s7,8(sp)
    8000112a:	6c02                	ld	s8,0(sp)
    8000112c:	6161                	addi	sp,sp,80
    8000112e:	8082                	ret
  return 0;
    80001130:	4501                	li	a0,0
    80001132:	b7dd                	j	80001118 <mappages+0x9a>

0000000080001134 <kvmmap>:
{
    80001134:	1141                	addi	sp,sp,-16
    80001136:	e406                	sd	ra,8(sp)
    80001138:	e022                	sd	s0,0(sp)
    8000113a:	0800                	addi	s0,sp,16
    8000113c:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000113e:	86b2                	mv	a3,a2
    80001140:	863e                	mv	a2,a5
    80001142:	f3dff0ef          	jal	8000107e <mappages>
    80001146:	e509                	bnez	a0,80001150 <kvmmap+0x1c>
}
    80001148:	60a2                	ld	ra,8(sp)
    8000114a:	6402                	ld	s0,0(sp)
    8000114c:	0141                	addi	sp,sp,16
    8000114e:	8082                	ret
    panic("kvmmap");
    80001150:	00006517          	auipc	a0,0x6
    80001154:	fc850513          	addi	a0,a0,-56 # 80007118 <etext+0x118>
    80001158:	e8aff0ef          	jal	800007e2 <panic>

000000008000115c <kvmmake>:
{
    8000115c:	1101                	addi	sp,sp,-32
    8000115e:	ec06                	sd	ra,24(sp)
    80001160:	e822                	sd	s0,16(sp)
    80001162:	e426                	sd	s1,8(sp)
    80001164:	e04a                	sd	s2,0(sp)
    80001166:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80001168:	a07ff0ef          	jal	80000b6e <kalloc>
    8000116c:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000116e:	6605                	lui	a2,0x1
    80001170:	4581                	li	a1,0
    80001172:	ba1ff0ef          	jal	80000d12 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001176:	4719                	li	a4,6
    80001178:	6685                	lui	a3,0x1
    8000117a:	10000637          	lui	a2,0x10000
    8000117e:	85b2                	mv	a1,a2
    80001180:	8526                	mv	a0,s1
    80001182:	fb3ff0ef          	jal	80001134 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001186:	4719                	li	a4,6
    80001188:	6685                	lui	a3,0x1
    8000118a:	10001637          	lui	a2,0x10001
    8000118e:	85b2                	mv	a1,a2
    80001190:	8526                	mv	a0,s1
    80001192:	fa3ff0ef          	jal	80001134 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    80001196:	4719                	li	a4,6
    80001198:	040006b7          	lui	a3,0x4000
    8000119c:	0c000637          	lui	a2,0xc000
    800011a0:	85b2                	mv	a1,a2
    800011a2:	8526                	mv	a0,s1
    800011a4:	f91ff0ef          	jal	80001134 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800011a8:	00006917          	auipc	s2,0x6
    800011ac:	e5890913          	addi	s2,s2,-424 # 80007000 <etext>
    800011b0:	4729                	li	a4,10
    800011b2:	80006697          	auipc	a3,0x80006
    800011b6:	e4e68693          	addi	a3,a3,-434 # 7000 <_entry-0x7fff9000>
    800011ba:	4605                	li	a2,1
    800011bc:	067e                	slli	a2,a2,0x1f
    800011be:	85b2                	mv	a1,a2
    800011c0:	8526                	mv	a0,s1
    800011c2:	f73ff0ef          	jal	80001134 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800011c6:	4719                	li	a4,6
    800011c8:	46c5                	li	a3,17
    800011ca:	06ee                	slli	a3,a3,0x1b
    800011cc:	412686b3          	sub	a3,a3,s2
    800011d0:	864a                	mv	a2,s2
    800011d2:	85ca                	mv	a1,s2
    800011d4:	8526                	mv	a0,s1
    800011d6:	f5fff0ef          	jal	80001134 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800011da:	4729                	li	a4,10
    800011dc:	6685                	lui	a3,0x1
    800011de:	00005617          	auipc	a2,0x5
    800011e2:	e2260613          	addi	a2,a2,-478 # 80006000 <_trampoline>
    800011e6:	040005b7          	lui	a1,0x4000
    800011ea:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800011ec:	05b2                	slli	a1,a1,0xc
    800011ee:	8526                	mv	a0,s1
    800011f0:	f45ff0ef          	jal	80001134 <kvmmap>
  proc_mapstacks(kpgtbl);
    800011f4:	8526                	mv	a0,s1
    800011f6:	5a8000ef          	jal	8000179e <proc_mapstacks>
}
    800011fa:	8526                	mv	a0,s1
    800011fc:	60e2                	ld	ra,24(sp)
    800011fe:	6442                	ld	s0,16(sp)
    80001200:	64a2                	ld	s1,8(sp)
    80001202:	6902                	ld	s2,0(sp)
    80001204:	6105                	addi	sp,sp,32
    80001206:	8082                	ret

0000000080001208 <kvminit>:
{
    80001208:	1141                	addi	sp,sp,-16
    8000120a:	e406                	sd	ra,8(sp)
    8000120c:	e022                	sd	s0,0(sp)
    8000120e:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001210:	f4dff0ef          	jal	8000115c <kvmmake>
    80001214:	00009797          	auipc	a5,0x9
    80001218:	10a7b223          	sd	a0,260(a5) # 8000a318 <kernel_pagetable>
}
    8000121c:	60a2                	ld	ra,8(sp)
    8000121e:	6402                	ld	s0,0(sp)
    80001220:	0141                	addi	sp,sp,16
    80001222:	8082                	ret

0000000080001224 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001224:	715d                	addi	sp,sp,-80
    80001226:	e486                	sd	ra,72(sp)
    80001228:	e0a2                	sd	s0,64(sp)
    8000122a:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000122c:	03459793          	slli	a5,a1,0x34
    80001230:	e39d                	bnez	a5,80001256 <uvmunmap+0x32>
    80001232:	f84a                	sd	s2,48(sp)
    80001234:	f44e                	sd	s3,40(sp)
    80001236:	f052                	sd	s4,32(sp)
    80001238:	ec56                	sd	s5,24(sp)
    8000123a:	e85a                	sd	s6,16(sp)
    8000123c:	e45e                	sd	s7,8(sp)
    8000123e:	8a2a                	mv	s4,a0
    80001240:	892e                	mv	s2,a1
    80001242:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001244:	0632                	slli	a2,a2,0xc
    80001246:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000124a:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000124c:	6b05                	lui	s6,0x1
    8000124e:	0735ff63          	bgeu	a1,s3,800012cc <uvmunmap+0xa8>
    80001252:	fc26                	sd	s1,56(sp)
    80001254:	a0a9                	j	8000129e <uvmunmap+0x7a>
    80001256:	fc26                	sd	s1,56(sp)
    80001258:	f84a                	sd	s2,48(sp)
    8000125a:	f44e                	sd	s3,40(sp)
    8000125c:	f052                	sd	s4,32(sp)
    8000125e:	ec56                	sd	s5,24(sp)
    80001260:	e85a                	sd	s6,16(sp)
    80001262:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    80001264:	00006517          	auipc	a0,0x6
    80001268:	ebc50513          	addi	a0,a0,-324 # 80007120 <etext+0x120>
    8000126c:	d76ff0ef          	jal	800007e2 <panic>
      panic("uvmunmap: walk");
    80001270:	00006517          	auipc	a0,0x6
    80001274:	ec850513          	addi	a0,a0,-312 # 80007138 <etext+0x138>
    80001278:	d6aff0ef          	jal	800007e2 <panic>
      panic("uvmunmap: not mapped");
    8000127c:	00006517          	auipc	a0,0x6
    80001280:	ecc50513          	addi	a0,a0,-308 # 80007148 <etext+0x148>
    80001284:	d5eff0ef          	jal	800007e2 <panic>
      panic("uvmunmap: not a leaf");
    80001288:	00006517          	auipc	a0,0x6
    8000128c:	ed850513          	addi	a0,a0,-296 # 80007160 <etext+0x160>
    80001290:	d52ff0ef          	jal	800007e2 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    80001294:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001298:	995a                	add	s2,s2,s6
    8000129a:	03397863          	bgeu	s2,s3,800012ca <uvmunmap+0xa6>
    if((pte = walk(pagetable, a, 0)) == 0)
    8000129e:	4601                	li	a2,0
    800012a0:	85ca                	mv	a1,s2
    800012a2:	8552                	mv	a0,s4
    800012a4:	d03ff0ef          	jal	80000fa6 <walk>
    800012a8:	84aa                	mv	s1,a0
    800012aa:	d179                	beqz	a0,80001270 <uvmunmap+0x4c>
    if((*pte & PTE_V) == 0)
    800012ac:	6108                	ld	a0,0(a0)
    800012ae:	00157793          	andi	a5,a0,1
    800012b2:	d7e9                	beqz	a5,8000127c <uvmunmap+0x58>
    if(PTE_FLAGS(*pte) == PTE_V)
    800012b4:	3ff57793          	andi	a5,a0,1023
    800012b8:	fd7788e3          	beq	a5,s7,80001288 <uvmunmap+0x64>
    if(do_free){
    800012bc:	fc0a8ce3          	beqz	s5,80001294 <uvmunmap+0x70>
      uint64 pa = PTE2PA(*pte);
    800012c0:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800012c2:	0532                	slli	a0,a0,0xc
    800012c4:	fc8ff0ef          	jal	80000a8c <kfree>
    800012c8:	b7f1                	j	80001294 <uvmunmap+0x70>
    800012ca:	74e2                	ld	s1,56(sp)
    800012cc:	7942                	ld	s2,48(sp)
    800012ce:	79a2                	ld	s3,40(sp)
    800012d0:	7a02                	ld	s4,32(sp)
    800012d2:	6ae2                	ld	s5,24(sp)
    800012d4:	6b42                	ld	s6,16(sp)
    800012d6:	6ba2                	ld	s7,8(sp)
  }
}
    800012d8:	60a6                	ld	ra,72(sp)
    800012da:	6406                	ld	s0,64(sp)
    800012dc:	6161                	addi	sp,sp,80
    800012de:	8082                	ret

00000000800012e0 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800012e0:	1101                	addi	sp,sp,-32
    800012e2:	ec06                	sd	ra,24(sp)
    800012e4:	e822                	sd	s0,16(sp)
    800012e6:	e426                	sd	s1,8(sp)
    800012e8:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800012ea:	885ff0ef          	jal	80000b6e <kalloc>
    800012ee:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800012f0:	c509                	beqz	a0,800012fa <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800012f2:	6605                	lui	a2,0x1
    800012f4:	4581                	li	a1,0
    800012f6:	a1dff0ef          	jal	80000d12 <memset>
  return pagetable;
}
    800012fa:	8526                	mv	a0,s1
    800012fc:	60e2                	ld	ra,24(sp)
    800012fe:	6442                	ld	s0,16(sp)
    80001300:	64a2                	ld	s1,8(sp)
    80001302:	6105                	addi	sp,sp,32
    80001304:	8082                	ret

0000000080001306 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80001306:	7179                	addi	sp,sp,-48
    80001308:	f406                	sd	ra,40(sp)
    8000130a:	f022                	sd	s0,32(sp)
    8000130c:	ec26                	sd	s1,24(sp)
    8000130e:	e84a                	sd	s2,16(sp)
    80001310:	e44e                	sd	s3,8(sp)
    80001312:	e052                	sd	s4,0(sp)
    80001314:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80001316:	6785                	lui	a5,0x1
    80001318:	04f67063          	bgeu	a2,a5,80001358 <uvmfirst+0x52>
    8000131c:	8a2a                	mv	s4,a0
    8000131e:	89ae                	mv	s3,a1
    80001320:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80001322:	84dff0ef          	jal	80000b6e <kalloc>
    80001326:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001328:	6605                	lui	a2,0x1
    8000132a:	4581                	li	a1,0
    8000132c:	9e7ff0ef          	jal	80000d12 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001330:	4779                	li	a4,30
    80001332:	86ca                	mv	a3,s2
    80001334:	6605                	lui	a2,0x1
    80001336:	4581                	li	a1,0
    80001338:	8552                	mv	a0,s4
    8000133a:	d45ff0ef          	jal	8000107e <mappages>
  memmove(mem, src, sz);
    8000133e:	8626                	mv	a2,s1
    80001340:	85ce                	mv	a1,s3
    80001342:	854a                	mv	a0,s2
    80001344:	a33ff0ef          	jal	80000d76 <memmove>
}
    80001348:	70a2                	ld	ra,40(sp)
    8000134a:	7402                	ld	s0,32(sp)
    8000134c:	64e2                	ld	s1,24(sp)
    8000134e:	6942                	ld	s2,16(sp)
    80001350:	69a2                	ld	s3,8(sp)
    80001352:	6a02                	ld	s4,0(sp)
    80001354:	6145                	addi	sp,sp,48
    80001356:	8082                	ret
    panic("uvmfirst: more than a page");
    80001358:	00006517          	auipc	a0,0x6
    8000135c:	e2050513          	addi	a0,a0,-480 # 80007178 <etext+0x178>
    80001360:	c82ff0ef          	jal	800007e2 <panic>

0000000080001364 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80001364:	1101                	addi	sp,sp,-32
    80001366:	ec06                	sd	ra,24(sp)
    80001368:	e822                	sd	s0,16(sp)
    8000136a:	e426                	sd	s1,8(sp)
    8000136c:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    8000136e:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80001370:	00b67d63          	bgeu	a2,a1,8000138a <uvmdealloc+0x26>
    80001374:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80001376:	6785                	lui	a5,0x1
    80001378:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000137a:	00f60733          	add	a4,a2,a5
    8000137e:	76fd                	lui	a3,0xfffff
    80001380:	8f75                	and	a4,a4,a3
    80001382:	97ae                	add	a5,a5,a1
    80001384:	8ff5                	and	a5,a5,a3
    80001386:	00f76863          	bltu	a4,a5,80001396 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    8000138a:	8526                	mv	a0,s1
    8000138c:	60e2                	ld	ra,24(sp)
    8000138e:	6442                	ld	s0,16(sp)
    80001390:	64a2                	ld	s1,8(sp)
    80001392:	6105                	addi	sp,sp,32
    80001394:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80001396:	8f99                	sub	a5,a5,a4
    80001398:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    8000139a:	4685                	li	a3,1
    8000139c:	0007861b          	sext.w	a2,a5
    800013a0:	85ba                	mv	a1,a4
    800013a2:	e83ff0ef          	jal	80001224 <uvmunmap>
    800013a6:	b7d5                	j	8000138a <uvmdealloc+0x26>

00000000800013a8 <uvmalloc>:
  if(newsz < oldsz)
    800013a8:	0ab66363          	bltu	a2,a1,8000144e <uvmalloc+0xa6>
{
    800013ac:	715d                	addi	sp,sp,-80
    800013ae:	e486                	sd	ra,72(sp)
    800013b0:	e0a2                	sd	s0,64(sp)
    800013b2:	f052                	sd	s4,32(sp)
    800013b4:	ec56                	sd	s5,24(sp)
    800013b6:	e85a                	sd	s6,16(sp)
    800013b8:	0880                	addi	s0,sp,80
    800013ba:	8b2a                	mv	s6,a0
    800013bc:	8ab2                	mv	s5,a2
  oldsz = PGROUNDUP(oldsz);
    800013be:	6785                	lui	a5,0x1
    800013c0:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800013c2:	95be                	add	a1,a1,a5
    800013c4:	77fd                	lui	a5,0xfffff
    800013c6:	00f5fa33          	and	s4,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    800013ca:	08ca7463          	bgeu	s4,a2,80001452 <uvmalloc+0xaa>
    800013ce:	fc26                	sd	s1,56(sp)
    800013d0:	f84a                	sd	s2,48(sp)
    800013d2:	f44e                	sd	s3,40(sp)
    800013d4:	e45e                	sd	s7,8(sp)
    800013d6:	8952                	mv	s2,s4
    memset(mem, 0, PGSIZE);
    800013d8:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    800013da:	0126eb93          	ori	s7,a3,18
    mem = kalloc();
    800013de:	f90ff0ef          	jal	80000b6e <kalloc>
    800013e2:	84aa                	mv	s1,a0
    if(mem == 0){
    800013e4:	c515                	beqz	a0,80001410 <uvmalloc+0x68>
    memset(mem, 0, PGSIZE);
    800013e6:	864e                	mv	a2,s3
    800013e8:	4581                	li	a1,0
    800013ea:	929ff0ef          	jal	80000d12 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    800013ee:	875e                	mv	a4,s7
    800013f0:	86a6                	mv	a3,s1
    800013f2:	864e                	mv	a2,s3
    800013f4:	85ca                	mv	a1,s2
    800013f6:	855a                	mv	a0,s6
    800013f8:	c87ff0ef          	jal	8000107e <mappages>
    800013fc:	e91d                	bnez	a0,80001432 <uvmalloc+0x8a>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800013fe:	994e                	add	s2,s2,s3
    80001400:	fd596fe3          	bltu	s2,s5,800013de <uvmalloc+0x36>
  return newsz;
    80001404:	8556                	mv	a0,s5
    80001406:	74e2                	ld	s1,56(sp)
    80001408:	7942                	ld	s2,48(sp)
    8000140a:	79a2                	ld	s3,40(sp)
    8000140c:	6ba2                	ld	s7,8(sp)
    8000140e:	a819                	j	80001424 <uvmalloc+0x7c>
      uvmdealloc(pagetable, a, oldsz);
    80001410:	8652                	mv	a2,s4
    80001412:	85ca                	mv	a1,s2
    80001414:	855a                	mv	a0,s6
    80001416:	f4fff0ef          	jal	80001364 <uvmdealloc>
      return 0;
    8000141a:	4501                	li	a0,0
    8000141c:	74e2                	ld	s1,56(sp)
    8000141e:	7942                	ld	s2,48(sp)
    80001420:	79a2                	ld	s3,40(sp)
    80001422:	6ba2                	ld	s7,8(sp)
}
    80001424:	60a6                	ld	ra,72(sp)
    80001426:	6406                	ld	s0,64(sp)
    80001428:	7a02                	ld	s4,32(sp)
    8000142a:	6ae2                	ld	s5,24(sp)
    8000142c:	6b42                	ld	s6,16(sp)
    8000142e:	6161                	addi	sp,sp,80
    80001430:	8082                	ret
      kfree(mem);
    80001432:	8526                	mv	a0,s1
    80001434:	e58ff0ef          	jal	80000a8c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80001438:	8652                	mv	a2,s4
    8000143a:	85ca                	mv	a1,s2
    8000143c:	855a                	mv	a0,s6
    8000143e:	f27ff0ef          	jal	80001364 <uvmdealloc>
      return 0;
    80001442:	4501                	li	a0,0
    80001444:	74e2                	ld	s1,56(sp)
    80001446:	7942                	ld	s2,48(sp)
    80001448:	79a2                	ld	s3,40(sp)
    8000144a:	6ba2                	ld	s7,8(sp)
    8000144c:	bfe1                	j	80001424 <uvmalloc+0x7c>
    return oldsz;
    8000144e:	852e                	mv	a0,a1
}
    80001450:	8082                	ret
  return newsz;
    80001452:	8532                	mv	a0,a2
    80001454:	bfc1                	j	80001424 <uvmalloc+0x7c>

0000000080001456 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80001456:	7179                	addi	sp,sp,-48
    80001458:	f406                	sd	ra,40(sp)
    8000145a:	f022                	sd	s0,32(sp)
    8000145c:	ec26                	sd	s1,24(sp)
    8000145e:	e84a                	sd	s2,16(sp)
    80001460:	e44e                	sd	s3,8(sp)
    80001462:	e052                	sd	s4,0(sp)
    80001464:	1800                	addi	s0,sp,48
    80001466:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80001468:	84aa                	mv	s1,a0
    8000146a:	6905                	lui	s2,0x1
    8000146c:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000146e:	4985                	li	s3,1
    80001470:	a819                	j	80001486 <freewalk+0x30>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80001472:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80001474:	00c79513          	slli	a0,a5,0xc
    80001478:	fdfff0ef          	jal	80001456 <freewalk>
      pagetable[i] = 0;
    8000147c:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80001480:	04a1                	addi	s1,s1,8
    80001482:	01248f63          	beq	s1,s2,800014a0 <freewalk+0x4a>
    pte_t pte = pagetable[i];
    80001486:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80001488:	00f7f713          	andi	a4,a5,15
    8000148c:	ff3703e3          	beq	a4,s3,80001472 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80001490:	8b85                	andi	a5,a5,1
    80001492:	d7fd                	beqz	a5,80001480 <freewalk+0x2a>
      panic("freewalk: leaf");
    80001494:	00006517          	auipc	a0,0x6
    80001498:	d0450513          	addi	a0,a0,-764 # 80007198 <etext+0x198>
    8000149c:	b46ff0ef          	jal	800007e2 <panic>
    }
  }
  kfree((void*)pagetable);
    800014a0:	8552                	mv	a0,s4
    800014a2:	deaff0ef          	jal	80000a8c <kfree>
}
    800014a6:	70a2                	ld	ra,40(sp)
    800014a8:	7402                	ld	s0,32(sp)
    800014aa:	64e2                	ld	s1,24(sp)
    800014ac:	6942                	ld	s2,16(sp)
    800014ae:	69a2                	ld	s3,8(sp)
    800014b0:	6a02                	ld	s4,0(sp)
    800014b2:	6145                	addi	sp,sp,48
    800014b4:	8082                	ret

00000000800014b6 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800014b6:	1101                	addi	sp,sp,-32
    800014b8:	ec06                	sd	ra,24(sp)
    800014ba:	e822                	sd	s0,16(sp)
    800014bc:	e426                	sd	s1,8(sp)
    800014be:	1000                	addi	s0,sp,32
    800014c0:	84aa                	mv	s1,a0
  if(sz > 0)
    800014c2:	e989                	bnez	a1,800014d4 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800014c4:	8526                	mv	a0,s1
    800014c6:	f91ff0ef          	jal	80001456 <freewalk>
}
    800014ca:	60e2                	ld	ra,24(sp)
    800014cc:	6442                	ld	s0,16(sp)
    800014ce:	64a2                	ld	s1,8(sp)
    800014d0:	6105                	addi	sp,sp,32
    800014d2:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800014d4:	6785                	lui	a5,0x1
    800014d6:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800014d8:	95be                	add	a1,a1,a5
    800014da:	4685                	li	a3,1
    800014dc:	00c5d613          	srli	a2,a1,0xc
    800014e0:	4581                	li	a1,0
    800014e2:	d43ff0ef          	jal	80001224 <uvmunmap>
    800014e6:	bff9                	j	800014c4 <uvmfree+0xe>

00000000800014e8 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800014e8:	ca4d                	beqz	a2,8000159a <uvmcopy+0xb2>
{
    800014ea:	715d                	addi	sp,sp,-80
    800014ec:	e486                	sd	ra,72(sp)
    800014ee:	e0a2                	sd	s0,64(sp)
    800014f0:	fc26                	sd	s1,56(sp)
    800014f2:	f84a                	sd	s2,48(sp)
    800014f4:	f44e                	sd	s3,40(sp)
    800014f6:	f052                	sd	s4,32(sp)
    800014f8:	ec56                	sd	s5,24(sp)
    800014fa:	e85a                	sd	s6,16(sp)
    800014fc:	e45e                	sd	s7,8(sp)
    800014fe:	e062                	sd	s8,0(sp)
    80001500:	0880                	addi	s0,sp,80
    80001502:	8baa                	mv	s7,a0
    80001504:	8b2e                	mv	s6,a1
    80001506:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += PGSIZE){
    80001508:	4981                	li	s3,0
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    8000150a:	6a05                	lui	s4,0x1
    if((pte = walk(old, i, 0)) == 0)
    8000150c:	4601                	li	a2,0
    8000150e:	85ce                	mv	a1,s3
    80001510:	855e                	mv	a0,s7
    80001512:	a95ff0ef          	jal	80000fa6 <walk>
    80001516:	cd1d                	beqz	a0,80001554 <uvmcopy+0x6c>
    if((*pte & PTE_V) == 0)
    80001518:	6118                	ld	a4,0(a0)
    8000151a:	00177793          	andi	a5,a4,1
    8000151e:	c3a9                	beqz	a5,80001560 <uvmcopy+0x78>
    pa = PTE2PA(*pte);
    80001520:	00a75593          	srli	a1,a4,0xa
    80001524:	00c59c13          	slli	s8,a1,0xc
    flags = PTE_FLAGS(*pte);
    80001528:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    8000152c:	e42ff0ef          	jal	80000b6e <kalloc>
    80001530:	892a                	mv	s2,a0
    80001532:	c121                	beqz	a0,80001572 <uvmcopy+0x8a>
    memmove(mem, (char*)pa, PGSIZE);
    80001534:	8652                	mv	a2,s4
    80001536:	85e2                	mv	a1,s8
    80001538:	83fff0ef          	jal	80000d76 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    8000153c:	8726                	mv	a4,s1
    8000153e:	86ca                	mv	a3,s2
    80001540:	8652                	mv	a2,s4
    80001542:	85ce                	mv	a1,s3
    80001544:	855a                	mv	a0,s6
    80001546:	b39ff0ef          	jal	8000107e <mappages>
    8000154a:	e10d                	bnez	a0,8000156c <uvmcopy+0x84>
  for(i = 0; i < sz; i += PGSIZE){
    8000154c:	99d2                	add	s3,s3,s4
    8000154e:	fb59efe3          	bltu	s3,s5,8000150c <uvmcopy+0x24>
    80001552:	a805                	j	80001582 <uvmcopy+0x9a>
      panic("uvmcopy: pte should exist");
    80001554:	00006517          	auipc	a0,0x6
    80001558:	c5450513          	addi	a0,a0,-940 # 800071a8 <etext+0x1a8>
    8000155c:	a86ff0ef          	jal	800007e2 <panic>
      panic("uvmcopy: page not present");
    80001560:	00006517          	auipc	a0,0x6
    80001564:	c6850513          	addi	a0,a0,-920 # 800071c8 <etext+0x1c8>
    80001568:	a7aff0ef          	jal	800007e2 <panic>
      kfree(mem);
    8000156c:	854a                	mv	a0,s2
    8000156e:	d1eff0ef          	jal	80000a8c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80001572:	4685                	li	a3,1
    80001574:	00c9d613          	srli	a2,s3,0xc
    80001578:	4581                	li	a1,0
    8000157a:	855a                	mv	a0,s6
    8000157c:	ca9ff0ef          	jal	80001224 <uvmunmap>
  return -1;
    80001580:	557d                	li	a0,-1
}
    80001582:	60a6                	ld	ra,72(sp)
    80001584:	6406                	ld	s0,64(sp)
    80001586:	74e2                	ld	s1,56(sp)
    80001588:	7942                	ld	s2,48(sp)
    8000158a:	79a2                	ld	s3,40(sp)
    8000158c:	7a02                	ld	s4,32(sp)
    8000158e:	6ae2                	ld	s5,24(sp)
    80001590:	6b42                	ld	s6,16(sp)
    80001592:	6ba2                	ld	s7,8(sp)
    80001594:	6c02                	ld	s8,0(sp)
    80001596:	6161                	addi	sp,sp,80
    80001598:	8082                	ret
  return 0;
    8000159a:	4501                	li	a0,0
}
    8000159c:	8082                	ret

000000008000159e <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000159e:	1141                	addi	sp,sp,-16
    800015a0:	e406                	sd	ra,8(sp)
    800015a2:	e022                	sd	s0,0(sp)
    800015a4:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800015a6:	4601                	li	a2,0
    800015a8:	9ffff0ef          	jal	80000fa6 <walk>
  if(pte == 0)
    800015ac:	c901                	beqz	a0,800015bc <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    800015ae:	611c                	ld	a5,0(a0)
    800015b0:	9bbd                	andi	a5,a5,-17
    800015b2:	e11c                	sd	a5,0(a0)
}
    800015b4:	60a2                	ld	ra,8(sp)
    800015b6:	6402                	ld	s0,0(sp)
    800015b8:	0141                	addi	sp,sp,16
    800015ba:	8082                	ret
    panic("uvmclear");
    800015bc:	00006517          	auipc	a0,0x6
    800015c0:	c2c50513          	addi	a0,a0,-980 # 800071e8 <etext+0x1e8>
    800015c4:	a1eff0ef          	jal	800007e2 <panic>

00000000800015c8 <copyout>:
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;
  pte_t *pte;

  while(len > 0){
    800015c8:	c2d9                	beqz	a3,8000164e <copyout+0x86>
{
    800015ca:	711d                	addi	sp,sp,-96
    800015cc:	ec86                	sd	ra,88(sp)
    800015ce:	e8a2                	sd	s0,80(sp)
    800015d0:	e4a6                	sd	s1,72(sp)
    800015d2:	e0ca                	sd	s2,64(sp)
    800015d4:	fc4e                	sd	s3,56(sp)
    800015d6:	f852                	sd	s4,48(sp)
    800015d8:	f456                	sd	s5,40(sp)
    800015da:	f05a                	sd	s6,32(sp)
    800015dc:	ec5e                	sd	s7,24(sp)
    800015de:	e862                	sd	s8,16(sp)
    800015e0:	e466                	sd	s9,8(sp)
    800015e2:	e06a                	sd	s10,0(sp)
    800015e4:	1080                	addi	s0,sp,96
    800015e6:	8c2a                	mv	s8,a0
    800015e8:	892e                	mv	s2,a1
    800015ea:	8ab2                	mv	s5,a2
    800015ec:	8a36                	mv	s4,a3
    va0 = PGROUNDDOWN(dstva);
    800015ee:	7cfd                	lui	s9,0xfffff
    if(va0 >= MAXVA)
    800015f0:	5bfd                	li	s7,-1
    800015f2:	01abdb93          	srli	s7,s7,0x1a
      return -1;
    pte = walk(pagetable, va0, 0);
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    800015f6:	4d55                	li	s10,21
       (*pte & PTE_W) == 0)
      return -1;
    pa0 = PTE2PA(*pte);
    n = PGSIZE - (dstva - va0);
    800015f8:	6b05                	lui	s6,0x1
    800015fa:	a015                	j	8000161e <copyout+0x56>
    pa0 = PTE2PA(*pte);
    800015fc:	83a9                	srli	a5,a5,0xa
    800015fe:	07b2                	slli	a5,a5,0xc
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001600:	41390533          	sub	a0,s2,s3
    80001604:	0004861b          	sext.w	a2,s1
    80001608:	85d6                	mv	a1,s5
    8000160a:	953e                	add	a0,a0,a5
    8000160c:	f6aff0ef          	jal	80000d76 <memmove>

    len -= n;
    80001610:	409a0a33          	sub	s4,s4,s1
    src += n;
    80001614:	9aa6                	add	s5,s5,s1
    dstva = va0 + PGSIZE;
    80001616:	01698933          	add	s2,s3,s6
  while(len > 0){
    8000161a:	020a0863          	beqz	s4,8000164a <copyout+0x82>
    va0 = PGROUNDDOWN(dstva);
    8000161e:	019979b3          	and	s3,s2,s9
    if(va0 >= MAXVA)
    80001622:	033be863          	bltu	s7,s3,80001652 <copyout+0x8a>
    pte = walk(pagetable, va0, 0);
    80001626:	4601                	li	a2,0
    80001628:	85ce                	mv	a1,s3
    8000162a:	8562                	mv	a0,s8
    8000162c:	97bff0ef          	jal	80000fa6 <walk>
    if(pte == 0 || (*pte & PTE_V) == 0 || (*pte & PTE_U) == 0 ||
    80001630:	c121                	beqz	a0,80001670 <copyout+0xa8>
    80001632:	611c                	ld	a5,0(a0)
    80001634:	0157f713          	andi	a4,a5,21
    80001638:	03a71e63          	bne	a4,s10,80001674 <copyout+0xac>
    n = PGSIZE - (dstva - va0);
    8000163c:	412984b3          	sub	s1,s3,s2
    80001640:	94da                	add	s1,s1,s6
    if(n > len)
    80001642:	fa9a7de3          	bgeu	s4,s1,800015fc <copyout+0x34>
    80001646:	84d2                	mv	s1,s4
    80001648:	bf55                	j	800015fc <copyout+0x34>
  }
  return 0;
    8000164a:	4501                	li	a0,0
    8000164c:	a021                	j	80001654 <copyout+0x8c>
    8000164e:	4501                	li	a0,0
}
    80001650:	8082                	ret
      return -1;
    80001652:	557d                	li	a0,-1
}
    80001654:	60e6                	ld	ra,88(sp)
    80001656:	6446                	ld	s0,80(sp)
    80001658:	64a6                	ld	s1,72(sp)
    8000165a:	6906                	ld	s2,64(sp)
    8000165c:	79e2                	ld	s3,56(sp)
    8000165e:	7a42                	ld	s4,48(sp)
    80001660:	7aa2                	ld	s5,40(sp)
    80001662:	7b02                	ld	s6,32(sp)
    80001664:	6be2                	ld	s7,24(sp)
    80001666:	6c42                	ld	s8,16(sp)
    80001668:	6ca2                	ld	s9,8(sp)
    8000166a:	6d02                	ld	s10,0(sp)
    8000166c:	6125                	addi	sp,sp,96
    8000166e:	8082                	ret
      return -1;
    80001670:	557d                	li	a0,-1
    80001672:	b7cd                	j	80001654 <copyout+0x8c>
    80001674:	557d                	li	a0,-1
    80001676:	bff9                	j	80001654 <copyout+0x8c>

0000000080001678 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80001678:	c6a5                	beqz	a3,800016e0 <copyin+0x68>
{
    8000167a:	715d                	addi	sp,sp,-80
    8000167c:	e486                	sd	ra,72(sp)
    8000167e:	e0a2                	sd	s0,64(sp)
    80001680:	fc26                	sd	s1,56(sp)
    80001682:	f84a                	sd	s2,48(sp)
    80001684:	f44e                	sd	s3,40(sp)
    80001686:	f052                	sd	s4,32(sp)
    80001688:	ec56                	sd	s5,24(sp)
    8000168a:	e85a                	sd	s6,16(sp)
    8000168c:	e45e                	sd	s7,8(sp)
    8000168e:	e062                	sd	s8,0(sp)
    80001690:	0880                	addi	s0,sp,80
    80001692:	8b2a                	mv	s6,a0
    80001694:	8a2e                	mv	s4,a1
    80001696:	8c32                	mv	s8,a2
    80001698:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    8000169a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    8000169c:	6a85                	lui	s5,0x1
    8000169e:	a00d                	j	800016c0 <copyin+0x48>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    800016a0:	018505b3          	add	a1,a0,s8
    800016a4:	0004861b          	sext.w	a2,s1
    800016a8:	412585b3          	sub	a1,a1,s2
    800016ac:	8552                	mv	a0,s4
    800016ae:	ec8ff0ef          	jal	80000d76 <memmove>

    len -= n;
    800016b2:	409989b3          	sub	s3,s3,s1
    dst += n;
    800016b6:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    800016b8:	01590c33          	add	s8,s2,s5
  while(len > 0){
    800016bc:	02098063          	beqz	s3,800016dc <copyin+0x64>
    va0 = PGROUNDDOWN(srcva);
    800016c0:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    800016c4:	85ca                	mv	a1,s2
    800016c6:	855a                	mv	a0,s6
    800016c8:	979ff0ef          	jal	80001040 <walkaddr>
    if(pa0 == 0)
    800016cc:	cd01                	beqz	a0,800016e4 <copyin+0x6c>
    n = PGSIZE - (srcva - va0);
    800016ce:	418904b3          	sub	s1,s2,s8
    800016d2:	94d6                	add	s1,s1,s5
    if(n > len)
    800016d4:	fc99f6e3          	bgeu	s3,s1,800016a0 <copyin+0x28>
    800016d8:	84ce                	mv	s1,s3
    800016da:	b7d9                	j	800016a0 <copyin+0x28>
  }
  return 0;
    800016dc:	4501                	li	a0,0
    800016de:	a021                	j	800016e6 <copyin+0x6e>
    800016e0:	4501                	li	a0,0
}
    800016e2:	8082                	ret
      return -1;
    800016e4:	557d                	li	a0,-1
}
    800016e6:	60a6                	ld	ra,72(sp)
    800016e8:	6406                	ld	s0,64(sp)
    800016ea:	74e2                	ld	s1,56(sp)
    800016ec:	7942                	ld	s2,48(sp)
    800016ee:	79a2                	ld	s3,40(sp)
    800016f0:	7a02                	ld	s4,32(sp)
    800016f2:	6ae2                	ld	s5,24(sp)
    800016f4:	6b42                	ld	s6,16(sp)
    800016f6:	6ba2                	ld	s7,8(sp)
    800016f8:	6c02                	ld	s8,0(sp)
    800016fa:	6161                	addi	sp,sp,80
    800016fc:	8082                	ret

00000000800016fe <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    800016fe:	715d                	addi	sp,sp,-80
    80001700:	e486                	sd	ra,72(sp)
    80001702:	e0a2                	sd	s0,64(sp)
    80001704:	fc26                	sd	s1,56(sp)
    80001706:	f84a                	sd	s2,48(sp)
    80001708:	f44e                	sd	s3,40(sp)
    8000170a:	f052                	sd	s4,32(sp)
    8000170c:	ec56                	sd	s5,24(sp)
    8000170e:	e85a                	sd	s6,16(sp)
    80001710:	e45e                	sd	s7,8(sp)
    80001712:	0880                	addi	s0,sp,80
    80001714:	8aaa                	mv	s5,a0
    80001716:	89ae                	mv	s3,a1
    80001718:	8bb2                	mv	s7,a2
    8000171a:	84b6                	mv	s1,a3
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    va0 = PGROUNDDOWN(srcva);
    8000171c:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    8000171e:	6a05                	lui	s4,0x1
    80001720:	a02d                	j	8000174a <copyinstr+0x4c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80001722:	00078023          	sb	zero,0(a5)
    80001726:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80001728:	0017c793          	xori	a5,a5,1
    8000172c:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80001730:	60a6                	ld	ra,72(sp)
    80001732:	6406                	ld	s0,64(sp)
    80001734:	74e2                	ld	s1,56(sp)
    80001736:	7942                	ld	s2,48(sp)
    80001738:	79a2                	ld	s3,40(sp)
    8000173a:	7a02                	ld	s4,32(sp)
    8000173c:	6ae2                	ld	s5,24(sp)
    8000173e:	6b42                	ld	s6,16(sp)
    80001740:	6ba2                	ld	s7,8(sp)
    80001742:	6161                	addi	sp,sp,80
    80001744:	8082                	ret
    srcva = va0 + PGSIZE;
    80001746:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    8000174a:	c4b1                	beqz	s1,80001796 <copyinstr+0x98>
    va0 = PGROUNDDOWN(srcva);
    8000174c:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80001750:	85ca                	mv	a1,s2
    80001752:	8556                	mv	a0,s5
    80001754:	8edff0ef          	jal	80001040 <walkaddr>
    if(pa0 == 0)
    80001758:	c129                	beqz	a0,8000179a <copyinstr+0x9c>
    n = PGSIZE - (srcva - va0);
    8000175a:	41790633          	sub	a2,s2,s7
    8000175e:	9652                	add	a2,a2,s4
    if(n > max)
    80001760:	00c4f363          	bgeu	s1,a2,80001766 <copyinstr+0x68>
    80001764:	8626                	mv	a2,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80001766:	412b8bb3          	sub	s7,s7,s2
    8000176a:	9baa                	add	s7,s7,a0
    while(n > 0){
    8000176c:	de69                	beqz	a2,80001746 <copyinstr+0x48>
    8000176e:	87ce                	mv	a5,s3
      if(*p == '\0'){
    80001770:	413b86b3          	sub	a3,s7,s3
    while(n > 0){
    80001774:	964e                	add	a2,a2,s3
    80001776:	85be                	mv	a1,a5
      if(*p == '\0'){
    80001778:	00f68733          	add	a4,a3,a5
    8000177c:	00074703          	lbu	a4,0(a4)
    80001780:	d34d                	beqz	a4,80001722 <copyinstr+0x24>
        *dst = *p;
    80001782:	00e78023          	sb	a4,0(a5)
      dst++;
    80001786:	0785                	addi	a5,a5,1
    while(n > 0){
    80001788:	fec797e3          	bne	a5,a2,80001776 <copyinstr+0x78>
    8000178c:	14fd                	addi	s1,s1,-1
    8000178e:	94ce                	add	s1,s1,s3
      --max;
    80001790:	8c8d                	sub	s1,s1,a1
    80001792:	89be                	mv	s3,a5
    80001794:	bf4d                	j	80001746 <copyinstr+0x48>
    80001796:	4781                	li	a5,0
    80001798:	bf41                	j	80001728 <copyinstr+0x2a>
      return -1;
    8000179a:	557d                	li	a0,-1
    8000179c:	bf51                	j	80001730 <copyinstr+0x32>

000000008000179e <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    8000179e:	715d                	addi	sp,sp,-80
    800017a0:	e486                	sd	ra,72(sp)
    800017a2:	e0a2                	sd	s0,64(sp)
    800017a4:	fc26                	sd	s1,56(sp)
    800017a6:	f84a                	sd	s2,48(sp)
    800017a8:	f44e                	sd	s3,40(sp)
    800017aa:	f052                	sd	s4,32(sp)
    800017ac:	ec56                	sd	s5,24(sp)
    800017ae:	e85a                	sd	s6,16(sp)
    800017b0:	e45e                	sd	s7,8(sp)
    800017b2:	e062                	sd	s8,0(sp)
    800017b4:	0880                	addi	s0,sp,80
    800017b6:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    800017b8:	00011497          	auipc	s1,0x11
    800017bc:	0c848493          	addi	s1,s1,200 # 80012880 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    800017c0:	8c26                	mv	s8,s1
    800017c2:	a4fa57b7          	lui	a5,0xa4fa5
    800017c6:	fa578793          	addi	a5,a5,-91 # ffffffffa4fa4fa5 <end+0xffffffff24f81945>
    800017ca:	4fa50937          	lui	s2,0x4fa50
    800017ce:	a5090913          	addi	s2,s2,-1456 # 4fa4fa50 <_entry-0x305b05b0>
    800017d2:	1902                	slli	s2,s2,0x20
    800017d4:	993e                	add	s2,s2,a5
    800017d6:	040009b7          	lui	s3,0x4000
    800017da:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    800017dc:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800017de:	4b99                	li	s7,6
    800017e0:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    800017e2:	00017a97          	auipc	s5,0x17
    800017e6:	a9ea8a93          	addi	s5,s5,-1378 # 80018280 <tickslock>
    char *pa = kalloc();
    800017ea:	b84ff0ef          	jal	80000b6e <kalloc>
    800017ee:	862a                	mv	a2,a0
    if(pa == 0)
    800017f0:	c121                	beqz	a0,80001830 <proc_mapstacks+0x92>
    uint64 va = KSTACK((int) (p - proc));
    800017f2:	418485b3          	sub	a1,s1,s8
    800017f6:	858d                	srai	a1,a1,0x3
    800017f8:	032585b3          	mul	a1,a1,s2
    800017fc:	2585                	addiw	a1,a1,1
    800017fe:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80001802:	875e                	mv	a4,s7
    80001804:	86da                	mv	a3,s6
    80001806:	40b985b3          	sub	a1,s3,a1
    8000180a:	8552                	mv	a0,s4
    8000180c:	929ff0ef          	jal	80001134 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001810:	16848493          	addi	s1,s1,360
    80001814:	fd549be3          	bne	s1,s5,800017ea <proc_mapstacks+0x4c>
  }
}
    80001818:	60a6                	ld	ra,72(sp)
    8000181a:	6406                	ld	s0,64(sp)
    8000181c:	74e2                	ld	s1,56(sp)
    8000181e:	7942                	ld	s2,48(sp)
    80001820:	79a2                	ld	s3,40(sp)
    80001822:	7a02                	ld	s4,32(sp)
    80001824:	6ae2                	ld	s5,24(sp)
    80001826:	6b42                	ld	s6,16(sp)
    80001828:	6ba2                	ld	s7,8(sp)
    8000182a:	6c02                	ld	s8,0(sp)
    8000182c:	6161                	addi	sp,sp,80
    8000182e:	8082                	ret
      panic("kalloc");
    80001830:	00006517          	auipc	a0,0x6
    80001834:	9c850513          	addi	a0,a0,-1592 # 800071f8 <etext+0x1f8>
    80001838:	fabfe0ef          	jal	800007e2 <panic>

000000008000183c <procinit>:

// initialize the proc table.
void
procinit(void)
{
    8000183c:	7139                	addi	sp,sp,-64
    8000183e:	fc06                	sd	ra,56(sp)
    80001840:	f822                	sd	s0,48(sp)
    80001842:	f426                	sd	s1,40(sp)
    80001844:	f04a                	sd	s2,32(sp)
    80001846:	ec4e                	sd	s3,24(sp)
    80001848:	e852                	sd	s4,16(sp)
    8000184a:	e456                	sd	s5,8(sp)
    8000184c:	e05a                	sd	s6,0(sp)
    8000184e:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80001850:	00006597          	auipc	a1,0x6
    80001854:	9b058593          	addi	a1,a1,-1616 # 80007200 <etext+0x200>
    80001858:	00011517          	auipc	a0,0x11
    8000185c:	bf850513          	addi	a0,a0,-1032 # 80012450 <pid_lock>
    80001860:	b5eff0ef          	jal	80000bbe <initlock>
  initlock(&wait_lock, "wait_lock");
    80001864:	00006597          	auipc	a1,0x6
    80001868:	9a458593          	addi	a1,a1,-1628 # 80007208 <etext+0x208>
    8000186c:	00011517          	auipc	a0,0x11
    80001870:	bfc50513          	addi	a0,a0,-1028 # 80012468 <wait_lock>
    80001874:	b4aff0ef          	jal	80000bbe <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001878:	00011497          	auipc	s1,0x11
    8000187c:	00848493          	addi	s1,s1,8 # 80012880 <proc>
      initlock(&p->lock, "proc");
    80001880:	00006b17          	auipc	s6,0x6
    80001884:	998b0b13          	addi	s6,s6,-1640 # 80007218 <etext+0x218>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80001888:	8aa6                	mv	s5,s1
    8000188a:	a4fa57b7          	lui	a5,0xa4fa5
    8000188e:	fa578793          	addi	a5,a5,-91 # ffffffffa4fa4fa5 <end+0xffffffff24f81945>
    80001892:	4fa50937          	lui	s2,0x4fa50
    80001896:	a5090913          	addi	s2,s2,-1456 # 4fa4fa50 <_entry-0x305b05b0>
    8000189a:	1902                	slli	s2,s2,0x20
    8000189c:	993e                	add	s2,s2,a5
    8000189e:	040009b7          	lui	s3,0x4000
    800018a2:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    800018a4:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    800018a6:	00017a17          	auipc	s4,0x17
    800018aa:	9daa0a13          	addi	s4,s4,-1574 # 80018280 <tickslock>
      initlock(&p->lock, "proc");
    800018ae:	85da                	mv	a1,s6
    800018b0:	8526                	mv	a0,s1
    800018b2:	b0cff0ef          	jal	80000bbe <initlock>
      p->state = UNUSED;
    800018b6:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    800018ba:	415487b3          	sub	a5,s1,s5
    800018be:	878d                	srai	a5,a5,0x3
    800018c0:	032787b3          	mul	a5,a5,s2
    800018c4:	2785                	addiw	a5,a5,1
    800018c6:	00d7979b          	slliw	a5,a5,0xd
    800018ca:	40f987b3          	sub	a5,s3,a5
    800018ce:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    800018d0:	16848493          	addi	s1,s1,360
    800018d4:	fd449de3          	bne	s1,s4,800018ae <procinit+0x72>
  }
}
    800018d8:	70e2                	ld	ra,56(sp)
    800018da:	7442                	ld	s0,48(sp)
    800018dc:	74a2                	ld	s1,40(sp)
    800018de:	7902                	ld	s2,32(sp)
    800018e0:	69e2                	ld	s3,24(sp)
    800018e2:	6a42                	ld	s4,16(sp)
    800018e4:	6aa2                	ld	s5,8(sp)
    800018e6:	6b02                	ld	s6,0(sp)
    800018e8:	6121                	addi	sp,sp,64
    800018ea:	8082                	ret

00000000800018ec <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800018ec:	1141                	addi	sp,sp,-16
    800018ee:	e406                	sd	ra,8(sp)
    800018f0:	e022                	sd	s0,0(sp)
    800018f2:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    800018f4:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    800018f6:	2501                	sext.w	a0,a0
    800018f8:	60a2                	ld	ra,8(sp)
    800018fa:	6402                	ld	s0,0(sp)
    800018fc:	0141                	addi	sp,sp,16
    800018fe:	8082                	ret

0000000080001900 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80001900:	1141                	addi	sp,sp,-16
    80001902:	e406                	sd	ra,8(sp)
    80001904:	e022                	sd	s0,0(sp)
    80001906:	0800                	addi	s0,sp,16
    80001908:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    8000190a:	2781                	sext.w	a5,a5
    8000190c:	079e                	slli	a5,a5,0x7
  return c;
}
    8000190e:	00011517          	auipc	a0,0x11
    80001912:	b7250513          	addi	a0,a0,-1166 # 80012480 <cpus>
    80001916:	953e                	add	a0,a0,a5
    80001918:	60a2                	ld	ra,8(sp)
    8000191a:	6402                	ld	s0,0(sp)
    8000191c:	0141                	addi	sp,sp,16
    8000191e:	8082                	ret

0000000080001920 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80001920:	1101                	addi	sp,sp,-32
    80001922:	ec06                	sd	ra,24(sp)
    80001924:	e822                	sd	s0,16(sp)
    80001926:	e426                	sd	s1,8(sp)
    80001928:	1000                	addi	s0,sp,32
  push_off();
    8000192a:	ad8ff0ef          	jal	80000c02 <push_off>
    8000192e:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001930:	2781                	sext.w	a5,a5
    80001932:	079e                	slli	a5,a5,0x7
    80001934:	00011717          	auipc	a4,0x11
    80001938:	b1c70713          	addi	a4,a4,-1252 # 80012450 <pid_lock>
    8000193c:	97ba                	add	a5,a5,a4
    8000193e:	7b84                	ld	s1,48(a5)
  pop_off();
    80001940:	b46ff0ef          	jal	80000c86 <pop_off>
  return p;
}
    80001944:	8526                	mv	a0,s1
    80001946:	60e2                	ld	ra,24(sp)
    80001948:	6442                	ld	s0,16(sp)
    8000194a:	64a2                	ld	s1,8(sp)
    8000194c:	6105                	addi	sp,sp,32
    8000194e:	8082                	ret

0000000080001950 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001950:	1141                	addi	sp,sp,-16
    80001952:	e406                	sd	ra,8(sp)
    80001954:	e022                	sd	s0,0(sp)
    80001956:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001958:	fc9ff0ef          	jal	80001920 <myproc>
    8000195c:	b7aff0ef          	jal	80000cd6 <release>

  if (first) {
    80001960:	00009797          	auipc	a5,0x9
    80001964:	9207a783          	lw	a5,-1760(a5) # 8000a280 <first.1>
    80001968:	e799                	bnez	a5,80001976 <forkret+0x26>
    first = 0;
    // ensure other cores see first=0.
    __sync_synchronize();
  }

  usertrapret();
    8000196a:	2bd000ef          	jal	80002426 <usertrapret>
}
    8000196e:	60a2                	ld	ra,8(sp)
    80001970:	6402                	ld	s0,0(sp)
    80001972:	0141                	addi	sp,sp,16
    80001974:	8082                	ret
    fsinit(ROOTDEV);
    80001976:	4505                	li	a0,1
    80001978:	63e010ef          	jal	80002fb6 <fsinit>
    first = 0;
    8000197c:	00009797          	auipc	a5,0x9
    80001980:	9007a223          	sw	zero,-1788(a5) # 8000a280 <first.1>
    __sync_synchronize();
    80001984:	0330000f          	fence	rw,rw
    80001988:	b7cd                	j	8000196a <forkret+0x1a>

000000008000198a <allocpid>:
{
    8000198a:	1101                	addi	sp,sp,-32
    8000198c:	ec06                	sd	ra,24(sp)
    8000198e:	e822                	sd	s0,16(sp)
    80001990:	e426                	sd	s1,8(sp)
    80001992:	e04a                	sd	s2,0(sp)
    80001994:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001996:	00011917          	auipc	s2,0x11
    8000199a:	aba90913          	addi	s2,s2,-1350 # 80012450 <pid_lock>
    8000199e:	854a                	mv	a0,s2
    800019a0:	aa2ff0ef          	jal	80000c42 <acquire>
  pid = nextpid;
    800019a4:	00009797          	auipc	a5,0x9
    800019a8:	8e078793          	addi	a5,a5,-1824 # 8000a284 <nextpid>
    800019ac:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    800019ae:	0014871b          	addiw	a4,s1,1
    800019b2:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    800019b4:	854a                	mv	a0,s2
    800019b6:	b20ff0ef          	jal	80000cd6 <release>
}
    800019ba:	8526                	mv	a0,s1
    800019bc:	60e2                	ld	ra,24(sp)
    800019be:	6442                	ld	s0,16(sp)
    800019c0:	64a2                	ld	s1,8(sp)
    800019c2:	6902                	ld	s2,0(sp)
    800019c4:	6105                	addi	sp,sp,32
    800019c6:	8082                	ret

00000000800019c8 <proc_pagetable>:
{
    800019c8:	1101                	addi	sp,sp,-32
    800019ca:	ec06                	sd	ra,24(sp)
    800019cc:	e822                	sd	s0,16(sp)
    800019ce:	e426                	sd	s1,8(sp)
    800019d0:	e04a                	sd	s2,0(sp)
    800019d2:	1000                	addi	s0,sp,32
    800019d4:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    800019d6:	90bff0ef          	jal	800012e0 <uvmcreate>
    800019da:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800019dc:	cd05                	beqz	a0,80001a14 <proc_pagetable+0x4c>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    800019de:	4729                	li	a4,10
    800019e0:	00004697          	auipc	a3,0x4
    800019e4:	62068693          	addi	a3,a3,1568 # 80006000 <_trampoline>
    800019e8:	6605                	lui	a2,0x1
    800019ea:	040005b7          	lui	a1,0x4000
    800019ee:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800019f0:	05b2                	slli	a1,a1,0xc
    800019f2:	e8cff0ef          	jal	8000107e <mappages>
    800019f6:	02054663          	bltz	a0,80001a22 <proc_pagetable+0x5a>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    800019fa:	4719                	li	a4,6
    800019fc:	05893683          	ld	a3,88(s2)
    80001a00:	6605                	lui	a2,0x1
    80001a02:	020005b7          	lui	a1,0x2000
    80001a06:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001a08:	05b6                	slli	a1,a1,0xd
    80001a0a:	8526                	mv	a0,s1
    80001a0c:	e72ff0ef          	jal	8000107e <mappages>
    80001a10:	00054f63          	bltz	a0,80001a2e <proc_pagetable+0x66>
}
    80001a14:	8526                	mv	a0,s1
    80001a16:	60e2                	ld	ra,24(sp)
    80001a18:	6442                	ld	s0,16(sp)
    80001a1a:	64a2                	ld	s1,8(sp)
    80001a1c:	6902                	ld	s2,0(sp)
    80001a1e:	6105                	addi	sp,sp,32
    80001a20:	8082                	ret
    uvmfree(pagetable, 0);
    80001a22:	4581                	li	a1,0
    80001a24:	8526                	mv	a0,s1
    80001a26:	a91ff0ef          	jal	800014b6 <uvmfree>
    return 0;
    80001a2a:	4481                	li	s1,0
    80001a2c:	b7e5                	j	80001a14 <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001a2e:	4681                	li	a3,0
    80001a30:	4605                	li	a2,1
    80001a32:	040005b7          	lui	a1,0x4000
    80001a36:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001a38:	05b2                	slli	a1,a1,0xc
    80001a3a:	8526                	mv	a0,s1
    80001a3c:	fe8ff0ef          	jal	80001224 <uvmunmap>
    uvmfree(pagetable, 0);
    80001a40:	4581                	li	a1,0
    80001a42:	8526                	mv	a0,s1
    80001a44:	a73ff0ef          	jal	800014b6 <uvmfree>
    return 0;
    80001a48:	4481                	li	s1,0
    80001a4a:	b7e9                	j	80001a14 <proc_pagetable+0x4c>

0000000080001a4c <proc_freepagetable>:
{
    80001a4c:	1101                	addi	sp,sp,-32
    80001a4e:	ec06                	sd	ra,24(sp)
    80001a50:	e822                	sd	s0,16(sp)
    80001a52:	e426                	sd	s1,8(sp)
    80001a54:	e04a                	sd	s2,0(sp)
    80001a56:	1000                	addi	s0,sp,32
    80001a58:	84aa                	mv	s1,a0
    80001a5a:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001a5c:	4681                	li	a3,0
    80001a5e:	4605                	li	a2,1
    80001a60:	040005b7          	lui	a1,0x4000
    80001a64:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001a66:	05b2                	slli	a1,a1,0xc
    80001a68:	fbcff0ef          	jal	80001224 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001a6c:	4681                	li	a3,0
    80001a6e:	4605                	li	a2,1
    80001a70:	020005b7          	lui	a1,0x2000
    80001a74:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001a76:	05b6                	slli	a1,a1,0xd
    80001a78:	8526                	mv	a0,s1
    80001a7a:	faaff0ef          	jal	80001224 <uvmunmap>
  uvmfree(pagetable, sz);
    80001a7e:	85ca                	mv	a1,s2
    80001a80:	8526                	mv	a0,s1
    80001a82:	a35ff0ef          	jal	800014b6 <uvmfree>
}
    80001a86:	60e2                	ld	ra,24(sp)
    80001a88:	6442                	ld	s0,16(sp)
    80001a8a:	64a2                	ld	s1,8(sp)
    80001a8c:	6902                	ld	s2,0(sp)
    80001a8e:	6105                	addi	sp,sp,32
    80001a90:	8082                	ret

0000000080001a92 <freeproc>:
{
    80001a92:	1101                	addi	sp,sp,-32
    80001a94:	ec06                	sd	ra,24(sp)
    80001a96:	e822                	sd	s0,16(sp)
    80001a98:	e426                	sd	s1,8(sp)
    80001a9a:	1000                	addi	s0,sp,32
    80001a9c:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001a9e:	6d28                	ld	a0,88(a0)
    80001aa0:	c119                	beqz	a0,80001aa6 <freeproc+0x14>
    kfree((void*)p->trapframe);
    80001aa2:	febfe0ef          	jal	80000a8c <kfree>
  p->trapframe = 0;
    80001aa6:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001aaa:	68a8                	ld	a0,80(s1)
    80001aac:	c501                	beqz	a0,80001ab4 <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80001aae:	64ac                	ld	a1,72(s1)
    80001ab0:	f9dff0ef          	jal	80001a4c <proc_freepagetable>
  p->pagetable = 0;
    80001ab4:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001ab8:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001abc:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001ac0:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001ac4:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001ac8:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001acc:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001ad0:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001ad4:	0004ac23          	sw	zero,24(s1)
}
    80001ad8:	60e2                	ld	ra,24(sp)
    80001ada:	6442                	ld	s0,16(sp)
    80001adc:	64a2                	ld	s1,8(sp)
    80001ade:	6105                	addi	sp,sp,32
    80001ae0:	8082                	ret

0000000080001ae2 <allocproc>:
{
    80001ae2:	1101                	addi	sp,sp,-32
    80001ae4:	ec06                	sd	ra,24(sp)
    80001ae6:	e822                	sd	s0,16(sp)
    80001ae8:	e426                	sd	s1,8(sp)
    80001aea:	e04a                	sd	s2,0(sp)
    80001aec:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001aee:	00011497          	auipc	s1,0x11
    80001af2:	d9248493          	addi	s1,s1,-622 # 80012880 <proc>
    80001af6:	00016917          	auipc	s2,0x16
    80001afa:	78a90913          	addi	s2,s2,1930 # 80018280 <tickslock>
    acquire(&p->lock);
    80001afe:	8526                	mv	a0,s1
    80001b00:	942ff0ef          	jal	80000c42 <acquire>
    if(p->state == UNUSED) {
    80001b04:	4c9c                	lw	a5,24(s1)
    80001b06:	cb91                	beqz	a5,80001b1a <allocproc+0x38>
      release(&p->lock);
    80001b08:	8526                	mv	a0,s1
    80001b0a:	9ccff0ef          	jal	80000cd6 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001b0e:	16848493          	addi	s1,s1,360
    80001b12:	ff2496e3          	bne	s1,s2,80001afe <allocproc+0x1c>
  return 0;
    80001b16:	4481                	li	s1,0
    80001b18:	a089                	j	80001b5a <allocproc+0x78>
  p->pid = allocpid();
    80001b1a:	e71ff0ef          	jal	8000198a <allocpid>
    80001b1e:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001b20:	4785                	li	a5,1
    80001b22:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001b24:	84aff0ef          	jal	80000b6e <kalloc>
    80001b28:	892a                	mv	s2,a0
    80001b2a:	eca8                	sd	a0,88(s1)
    80001b2c:	cd15                	beqz	a0,80001b68 <allocproc+0x86>
  p->pagetable = proc_pagetable(p);
    80001b2e:	8526                	mv	a0,s1
    80001b30:	e99ff0ef          	jal	800019c8 <proc_pagetable>
    80001b34:	892a                	mv	s2,a0
    80001b36:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001b38:	c121                	beqz	a0,80001b78 <allocproc+0x96>
  memset(&p->context, 0, sizeof(p->context));
    80001b3a:	07000613          	li	a2,112
    80001b3e:	4581                	li	a1,0
    80001b40:	06048513          	addi	a0,s1,96
    80001b44:	9ceff0ef          	jal	80000d12 <memset>
  p->context.ra = (uint64)forkret;
    80001b48:	00000797          	auipc	a5,0x0
    80001b4c:	e0878793          	addi	a5,a5,-504 # 80001950 <forkret>
    80001b50:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001b52:	60bc                	ld	a5,64(s1)
    80001b54:	6705                	lui	a4,0x1
    80001b56:	97ba                	add	a5,a5,a4
    80001b58:	f4bc                	sd	a5,104(s1)
}
    80001b5a:	8526                	mv	a0,s1
    80001b5c:	60e2                	ld	ra,24(sp)
    80001b5e:	6442                	ld	s0,16(sp)
    80001b60:	64a2                	ld	s1,8(sp)
    80001b62:	6902                	ld	s2,0(sp)
    80001b64:	6105                	addi	sp,sp,32
    80001b66:	8082                	ret
    freeproc(p);
    80001b68:	8526                	mv	a0,s1
    80001b6a:	f29ff0ef          	jal	80001a92 <freeproc>
    release(&p->lock);
    80001b6e:	8526                	mv	a0,s1
    80001b70:	966ff0ef          	jal	80000cd6 <release>
    return 0;
    80001b74:	84ca                	mv	s1,s2
    80001b76:	b7d5                	j	80001b5a <allocproc+0x78>
    freeproc(p);
    80001b78:	8526                	mv	a0,s1
    80001b7a:	f19ff0ef          	jal	80001a92 <freeproc>
    release(&p->lock);
    80001b7e:	8526                	mv	a0,s1
    80001b80:	956ff0ef          	jal	80000cd6 <release>
    return 0;
    80001b84:	84ca                	mv	s1,s2
    80001b86:	bfd1                	j	80001b5a <allocproc+0x78>

0000000080001b88 <userinit>:
{
    80001b88:	1101                	addi	sp,sp,-32
    80001b8a:	ec06                	sd	ra,24(sp)
    80001b8c:	e822                	sd	s0,16(sp)
    80001b8e:	e426                	sd	s1,8(sp)
    80001b90:	1000                	addi	s0,sp,32
  p = allocproc();
    80001b92:	f51ff0ef          	jal	80001ae2 <allocproc>
    80001b96:	84aa                	mv	s1,a0
  initproc = p;
    80001b98:	00008797          	auipc	a5,0x8
    80001b9c:	78a7b423          	sd	a0,1928(a5) # 8000a320 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    80001ba0:	03400613          	li	a2,52
    80001ba4:	00008597          	auipc	a1,0x8
    80001ba8:	6ec58593          	addi	a1,a1,1772 # 8000a290 <initcode>
    80001bac:	6928                	ld	a0,80(a0)
    80001bae:	f58ff0ef          	jal	80001306 <uvmfirst>
  p->sz = PGSIZE;
    80001bb2:	6785                	lui	a5,0x1
    80001bb4:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001bb6:	6cb8                	ld	a4,88(s1)
    80001bb8:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001bbc:	6cb8                	ld	a4,88(s1)
    80001bbe:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001bc0:	4641                	li	a2,16
    80001bc2:	00005597          	auipc	a1,0x5
    80001bc6:	65e58593          	addi	a1,a1,1630 # 80007220 <etext+0x220>
    80001bca:	15848513          	addi	a0,s1,344
    80001bce:	a96ff0ef          	jal	80000e64 <safestrcpy>
  p->cwd = namei("/");
    80001bd2:	00005517          	auipc	a0,0x5
    80001bd6:	65e50513          	addi	a0,a0,1630 # 80007230 <etext+0x230>
    80001bda:	501010ef          	jal	800038da <namei>
    80001bde:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001be2:	478d                	li	a5,3
    80001be4:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001be6:	8526                	mv	a0,s1
    80001be8:	8eeff0ef          	jal	80000cd6 <release>
}
    80001bec:	60e2                	ld	ra,24(sp)
    80001bee:	6442                	ld	s0,16(sp)
    80001bf0:	64a2                	ld	s1,8(sp)
    80001bf2:	6105                	addi	sp,sp,32
    80001bf4:	8082                	ret

0000000080001bf6 <growproc>:
{
    80001bf6:	1101                	addi	sp,sp,-32
    80001bf8:	ec06                	sd	ra,24(sp)
    80001bfa:	e822                	sd	s0,16(sp)
    80001bfc:	e426                	sd	s1,8(sp)
    80001bfe:	e04a                	sd	s2,0(sp)
    80001c00:	1000                	addi	s0,sp,32
    80001c02:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001c04:	d1dff0ef          	jal	80001920 <myproc>
    80001c08:	84aa                	mv	s1,a0
  sz = p->sz;
    80001c0a:	652c                	ld	a1,72(a0)
  if(n > 0){
    80001c0c:	01204c63          	bgtz	s2,80001c24 <growproc+0x2e>
  } else if(n < 0){
    80001c10:	02094463          	bltz	s2,80001c38 <growproc+0x42>
  p->sz = sz;
    80001c14:	e4ac                	sd	a1,72(s1)
  return 0;
    80001c16:	4501                	li	a0,0
}
    80001c18:	60e2                	ld	ra,24(sp)
    80001c1a:	6442                	ld	s0,16(sp)
    80001c1c:	64a2                	ld	s1,8(sp)
    80001c1e:	6902                	ld	s2,0(sp)
    80001c20:	6105                	addi	sp,sp,32
    80001c22:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    80001c24:	4691                	li	a3,4
    80001c26:	00b90633          	add	a2,s2,a1
    80001c2a:	6928                	ld	a0,80(a0)
    80001c2c:	f7cff0ef          	jal	800013a8 <uvmalloc>
    80001c30:	85aa                	mv	a1,a0
    80001c32:	f16d                	bnez	a0,80001c14 <growproc+0x1e>
      return -1;
    80001c34:	557d                	li	a0,-1
    80001c36:	b7cd                	j	80001c18 <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001c38:	00b90633          	add	a2,s2,a1
    80001c3c:	6928                	ld	a0,80(a0)
    80001c3e:	f26ff0ef          	jal	80001364 <uvmdealloc>
    80001c42:	85aa                	mv	a1,a0
    80001c44:	bfc1                	j	80001c14 <growproc+0x1e>

0000000080001c46 <fork>:
{
    80001c46:	7139                	addi	sp,sp,-64
    80001c48:	fc06                	sd	ra,56(sp)
    80001c4a:	f822                	sd	s0,48(sp)
    80001c4c:	f04a                	sd	s2,32(sp)
    80001c4e:	e456                	sd	s5,8(sp)
    80001c50:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001c52:	ccfff0ef          	jal	80001920 <myproc>
    80001c56:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001c58:	e8bff0ef          	jal	80001ae2 <allocproc>
    80001c5c:	0e050a63          	beqz	a0,80001d50 <fork+0x10a>
    80001c60:	e852                	sd	s4,16(sp)
    80001c62:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001c64:	048ab603          	ld	a2,72(s5)
    80001c68:	692c                	ld	a1,80(a0)
    80001c6a:	050ab503          	ld	a0,80(s5)
    80001c6e:	87bff0ef          	jal	800014e8 <uvmcopy>
    80001c72:	04054a63          	bltz	a0,80001cc6 <fork+0x80>
    80001c76:	f426                	sd	s1,40(sp)
    80001c78:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001c7a:	048ab783          	ld	a5,72(s5)
    80001c7e:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001c82:	058ab683          	ld	a3,88(s5)
    80001c86:	87b6                	mv	a5,a3
    80001c88:	058a3703          	ld	a4,88(s4)
    80001c8c:	12068693          	addi	a3,a3,288
    80001c90:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001c94:	6788                	ld	a0,8(a5)
    80001c96:	6b8c                	ld	a1,16(a5)
    80001c98:	6f90                	ld	a2,24(a5)
    80001c9a:	01073023          	sd	a6,0(a4)
    80001c9e:	e708                	sd	a0,8(a4)
    80001ca0:	eb0c                	sd	a1,16(a4)
    80001ca2:	ef10                	sd	a2,24(a4)
    80001ca4:	02078793          	addi	a5,a5,32
    80001ca8:	02070713          	addi	a4,a4,32
    80001cac:	fed792e3          	bne	a5,a3,80001c90 <fork+0x4a>
  np->trapframe->a0 = 0;
    80001cb0:	058a3783          	ld	a5,88(s4)
    80001cb4:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001cb8:	0d0a8493          	addi	s1,s5,208
    80001cbc:	0d0a0913          	addi	s2,s4,208
    80001cc0:	150a8993          	addi	s3,s5,336
    80001cc4:	a831                	j	80001ce0 <fork+0x9a>
    freeproc(np);
    80001cc6:	8552                	mv	a0,s4
    80001cc8:	dcbff0ef          	jal	80001a92 <freeproc>
    release(&np->lock);
    80001ccc:	8552                	mv	a0,s4
    80001cce:	808ff0ef          	jal	80000cd6 <release>
    return -1;
    80001cd2:	597d                	li	s2,-1
    80001cd4:	6a42                	ld	s4,16(sp)
    80001cd6:	a0b5                	j	80001d42 <fork+0xfc>
  for(i = 0; i < NOFILE; i++)
    80001cd8:	04a1                	addi	s1,s1,8
    80001cda:	0921                	addi	s2,s2,8
    80001cdc:	01348963          	beq	s1,s3,80001cee <fork+0xa8>
    if(p->ofile[i])
    80001ce0:	6088                	ld	a0,0(s1)
    80001ce2:	d97d                	beqz	a0,80001cd8 <fork+0x92>
      np->ofile[i] = filedup(p->ofile[i]);
    80001ce4:	192020ef          	jal	80003e76 <filedup>
    80001ce8:	00a93023          	sd	a0,0(s2)
    80001cec:	b7f5                	j	80001cd8 <fork+0x92>
  np->cwd = idup(p->cwd);
    80001cee:	150ab503          	ld	a0,336(s5)
    80001cf2:	4c2010ef          	jal	800031b4 <idup>
    80001cf6:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001cfa:	4641                	li	a2,16
    80001cfc:	158a8593          	addi	a1,s5,344
    80001d00:	158a0513          	addi	a0,s4,344
    80001d04:	960ff0ef          	jal	80000e64 <safestrcpy>
  pid = np->pid;
    80001d08:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001d0c:	8552                	mv	a0,s4
    80001d0e:	fc9fe0ef          	jal	80000cd6 <release>
  acquire(&wait_lock);
    80001d12:	00010497          	auipc	s1,0x10
    80001d16:	75648493          	addi	s1,s1,1878 # 80012468 <wait_lock>
    80001d1a:	8526                	mv	a0,s1
    80001d1c:	f27fe0ef          	jal	80000c42 <acquire>
  np->parent = p;
    80001d20:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001d24:	8526                	mv	a0,s1
    80001d26:	fb1fe0ef          	jal	80000cd6 <release>
  acquire(&np->lock);
    80001d2a:	8552                	mv	a0,s4
    80001d2c:	f17fe0ef          	jal	80000c42 <acquire>
  np->state = RUNNABLE;
    80001d30:	478d                	li	a5,3
    80001d32:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001d36:	8552                	mv	a0,s4
    80001d38:	f9ffe0ef          	jal	80000cd6 <release>
  return pid;
    80001d3c:	74a2                	ld	s1,40(sp)
    80001d3e:	69e2                	ld	s3,24(sp)
    80001d40:	6a42                	ld	s4,16(sp)
}
    80001d42:	854a                	mv	a0,s2
    80001d44:	70e2                	ld	ra,56(sp)
    80001d46:	7442                	ld	s0,48(sp)
    80001d48:	7902                	ld	s2,32(sp)
    80001d4a:	6aa2                	ld	s5,8(sp)
    80001d4c:	6121                	addi	sp,sp,64
    80001d4e:	8082                	ret
    return -1;
    80001d50:	597d                	li	s2,-1
    80001d52:	bfc5                	j	80001d42 <fork+0xfc>

0000000080001d54 <scheduler>:
{
    80001d54:	715d                	addi	sp,sp,-80
    80001d56:	e486                	sd	ra,72(sp)
    80001d58:	e0a2                	sd	s0,64(sp)
    80001d5a:	fc26                	sd	s1,56(sp)
    80001d5c:	f84a                	sd	s2,48(sp)
    80001d5e:	f44e                	sd	s3,40(sp)
    80001d60:	f052                	sd	s4,32(sp)
    80001d62:	ec56                	sd	s5,24(sp)
    80001d64:	e85a                	sd	s6,16(sp)
    80001d66:	e45e                	sd	s7,8(sp)
    80001d68:	e062                	sd	s8,0(sp)
    80001d6a:	0880                	addi	s0,sp,80
    80001d6c:	8792                	mv	a5,tp
  int id = r_tp();
    80001d6e:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001d70:	00779b13          	slli	s6,a5,0x7
    80001d74:	00010717          	auipc	a4,0x10
    80001d78:	6dc70713          	addi	a4,a4,1756 # 80012450 <pid_lock>
    80001d7c:	975a                	add	a4,a4,s6
    80001d7e:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001d82:	00010717          	auipc	a4,0x10
    80001d86:	70670713          	addi	a4,a4,1798 # 80012488 <cpus+0x8>
    80001d8a:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    80001d8c:	4c11                	li	s8,4
        c->proc = p;
    80001d8e:	079e                	slli	a5,a5,0x7
    80001d90:	00010a17          	auipc	s4,0x10
    80001d94:	6c0a0a13          	addi	s4,s4,1728 # 80012450 <pid_lock>
    80001d98:	9a3e                	add	s4,s4,a5
        found = 1;
    80001d9a:	4b85                	li	s7,1
    80001d9c:	a0a9                	j	80001de6 <scheduler+0x92>
      release(&p->lock);
    80001d9e:	8526                	mv	a0,s1
    80001da0:	f37fe0ef          	jal	80000cd6 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001da4:	16848493          	addi	s1,s1,360
    80001da8:	03248563          	beq	s1,s2,80001dd2 <scheduler+0x7e>
      acquire(&p->lock);
    80001dac:	8526                	mv	a0,s1
    80001dae:	e95fe0ef          	jal	80000c42 <acquire>
      if(p->state == RUNNABLE) {
    80001db2:	4c9c                	lw	a5,24(s1)
    80001db4:	ff3795e3          	bne	a5,s3,80001d9e <scheduler+0x4a>
        p->state = RUNNING;
    80001db8:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    80001dbc:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001dc0:	06048593          	addi	a1,s1,96
    80001dc4:	855a                	mv	a0,s6
    80001dc6:	5b6000ef          	jal	8000237c <swtch>
        c->proc = 0;
    80001dca:	020a3823          	sd	zero,48(s4)
        found = 1;
    80001dce:	8ade                	mv	s5,s7
    80001dd0:	b7f9                	j	80001d9e <scheduler+0x4a>
    if(found == 0) {
    80001dd2:	000a9a63          	bnez	s5,80001de6 <scheduler+0x92>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dd6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001dda:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dde:	10079073          	csrw	sstatus,a5
      asm volatile("wfi");
    80001de2:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001de6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001dea:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dee:	10079073          	csrw	sstatus,a5
    int found = 0;
    80001df2:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    80001df4:	00011497          	auipc	s1,0x11
    80001df8:	a8c48493          	addi	s1,s1,-1396 # 80012880 <proc>
      if(p->state == RUNNABLE) {
    80001dfc:	498d                	li	s3,3
    for(p = proc; p < &proc[NPROC]; p++) {
    80001dfe:	00016917          	auipc	s2,0x16
    80001e02:	48290913          	addi	s2,s2,1154 # 80018280 <tickslock>
    80001e06:	b75d                	j	80001dac <scheduler+0x58>

0000000080001e08 <sched>:
{
    80001e08:	7179                	addi	sp,sp,-48
    80001e0a:	f406                	sd	ra,40(sp)
    80001e0c:	f022                	sd	s0,32(sp)
    80001e0e:	ec26                	sd	s1,24(sp)
    80001e10:	e84a                	sd	s2,16(sp)
    80001e12:	e44e                	sd	s3,8(sp)
    80001e14:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001e16:	b0bff0ef          	jal	80001920 <myproc>
    80001e1a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001e1c:	dbdfe0ef          	jal	80000bd8 <holding>
    80001e20:	c92d                	beqz	a0,80001e92 <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001e22:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001e24:	2781                	sext.w	a5,a5
    80001e26:	079e                	slli	a5,a5,0x7
    80001e28:	00010717          	auipc	a4,0x10
    80001e2c:	62870713          	addi	a4,a4,1576 # 80012450 <pid_lock>
    80001e30:	97ba                	add	a5,a5,a4
    80001e32:	0a87a703          	lw	a4,168(a5)
    80001e36:	4785                	li	a5,1
    80001e38:	06f71363          	bne	a4,a5,80001e9e <sched+0x96>
  if(p->state == RUNNING)
    80001e3c:	4c98                	lw	a4,24(s1)
    80001e3e:	4791                	li	a5,4
    80001e40:	06f70563          	beq	a4,a5,80001eaa <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e44:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001e48:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001e4a:	e7b5                	bnez	a5,80001eb6 <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001e4c:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001e4e:	00010917          	auipc	s2,0x10
    80001e52:	60290913          	addi	s2,s2,1538 # 80012450 <pid_lock>
    80001e56:	2781                	sext.w	a5,a5
    80001e58:	079e                	slli	a5,a5,0x7
    80001e5a:	97ca                	add	a5,a5,s2
    80001e5c:	0ac7a983          	lw	s3,172(a5)
    80001e60:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001e62:	2781                	sext.w	a5,a5
    80001e64:	079e                	slli	a5,a5,0x7
    80001e66:	00010597          	auipc	a1,0x10
    80001e6a:	62258593          	addi	a1,a1,1570 # 80012488 <cpus+0x8>
    80001e6e:	95be                	add	a1,a1,a5
    80001e70:	06048513          	addi	a0,s1,96
    80001e74:	508000ef          	jal	8000237c <swtch>
    80001e78:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001e7a:	2781                	sext.w	a5,a5
    80001e7c:	079e                	slli	a5,a5,0x7
    80001e7e:	993e                	add	s2,s2,a5
    80001e80:	0b392623          	sw	s3,172(s2)
}
    80001e84:	70a2                	ld	ra,40(sp)
    80001e86:	7402                	ld	s0,32(sp)
    80001e88:	64e2                	ld	s1,24(sp)
    80001e8a:	6942                	ld	s2,16(sp)
    80001e8c:	69a2                	ld	s3,8(sp)
    80001e8e:	6145                	addi	sp,sp,48
    80001e90:	8082                	ret
    panic("sched p->lock");
    80001e92:	00005517          	auipc	a0,0x5
    80001e96:	3a650513          	addi	a0,a0,934 # 80007238 <etext+0x238>
    80001e9a:	949fe0ef          	jal	800007e2 <panic>
    panic("sched locks");
    80001e9e:	00005517          	auipc	a0,0x5
    80001ea2:	3aa50513          	addi	a0,a0,938 # 80007248 <etext+0x248>
    80001ea6:	93dfe0ef          	jal	800007e2 <panic>
    panic("sched running");
    80001eaa:	00005517          	auipc	a0,0x5
    80001eae:	3ae50513          	addi	a0,a0,942 # 80007258 <etext+0x258>
    80001eb2:	931fe0ef          	jal	800007e2 <panic>
    panic("sched interruptible");
    80001eb6:	00005517          	auipc	a0,0x5
    80001eba:	3b250513          	addi	a0,a0,946 # 80007268 <etext+0x268>
    80001ebe:	925fe0ef          	jal	800007e2 <panic>

0000000080001ec2 <yield>:
{
    80001ec2:	1101                	addi	sp,sp,-32
    80001ec4:	ec06                	sd	ra,24(sp)
    80001ec6:	e822                	sd	s0,16(sp)
    80001ec8:	e426                	sd	s1,8(sp)
    80001eca:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001ecc:	a55ff0ef          	jal	80001920 <myproc>
    80001ed0:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001ed2:	d71fe0ef          	jal	80000c42 <acquire>
  p->state = RUNNABLE;
    80001ed6:	478d                	li	a5,3
    80001ed8:	cc9c                	sw	a5,24(s1)
  sched();
    80001eda:	f2fff0ef          	jal	80001e08 <sched>
  release(&p->lock);
    80001ede:	8526                	mv	a0,s1
    80001ee0:	df7fe0ef          	jal	80000cd6 <release>
}
    80001ee4:	60e2                	ld	ra,24(sp)
    80001ee6:	6442                	ld	s0,16(sp)
    80001ee8:	64a2                	ld	s1,8(sp)
    80001eea:	6105                	addi	sp,sp,32
    80001eec:	8082                	ret

0000000080001eee <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001eee:	7179                	addi	sp,sp,-48
    80001ef0:	f406                	sd	ra,40(sp)
    80001ef2:	f022                	sd	s0,32(sp)
    80001ef4:	ec26                	sd	s1,24(sp)
    80001ef6:	e84a                	sd	s2,16(sp)
    80001ef8:	e44e                	sd	s3,8(sp)
    80001efa:	1800                	addi	s0,sp,48
    80001efc:	89aa                	mv	s3,a0
    80001efe:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001f00:	a21ff0ef          	jal	80001920 <myproc>
    80001f04:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001f06:	d3dfe0ef          	jal	80000c42 <acquire>
  release(lk);
    80001f0a:	854a                	mv	a0,s2
    80001f0c:	dcbfe0ef          	jal	80000cd6 <release>

  // Go to sleep.
  p->chan = chan;
    80001f10:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001f14:	4789                	li	a5,2
    80001f16:	cc9c                	sw	a5,24(s1)

  sched();
    80001f18:	ef1ff0ef          	jal	80001e08 <sched>

  // Tidy up.
  p->chan = 0;
    80001f1c:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001f20:	8526                	mv	a0,s1
    80001f22:	db5fe0ef          	jal	80000cd6 <release>
  acquire(lk);
    80001f26:	854a                	mv	a0,s2
    80001f28:	d1bfe0ef          	jal	80000c42 <acquire>
}
    80001f2c:	70a2                	ld	ra,40(sp)
    80001f2e:	7402                	ld	s0,32(sp)
    80001f30:	64e2                	ld	s1,24(sp)
    80001f32:	6942                	ld	s2,16(sp)
    80001f34:	69a2                	ld	s3,8(sp)
    80001f36:	6145                	addi	sp,sp,48
    80001f38:	8082                	ret

0000000080001f3a <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001f3a:	7139                	addi	sp,sp,-64
    80001f3c:	fc06                	sd	ra,56(sp)
    80001f3e:	f822                	sd	s0,48(sp)
    80001f40:	f426                	sd	s1,40(sp)
    80001f42:	f04a                	sd	s2,32(sp)
    80001f44:	ec4e                	sd	s3,24(sp)
    80001f46:	e852                	sd	s4,16(sp)
    80001f48:	e456                	sd	s5,8(sp)
    80001f4a:	0080                	addi	s0,sp,64
    80001f4c:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001f4e:	00011497          	auipc	s1,0x11
    80001f52:	93248493          	addi	s1,s1,-1742 # 80012880 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001f56:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001f58:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001f5a:	00016917          	auipc	s2,0x16
    80001f5e:	32690913          	addi	s2,s2,806 # 80018280 <tickslock>
    80001f62:	a801                	j	80001f72 <wakeup+0x38>
      }
      release(&p->lock);
    80001f64:	8526                	mv	a0,s1
    80001f66:	d71fe0ef          	jal	80000cd6 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001f6a:	16848493          	addi	s1,s1,360
    80001f6e:	03248263          	beq	s1,s2,80001f92 <wakeup+0x58>
    if(p != myproc()){
    80001f72:	9afff0ef          	jal	80001920 <myproc>
    80001f76:	fea48ae3          	beq	s1,a0,80001f6a <wakeup+0x30>
      acquire(&p->lock);
    80001f7a:	8526                	mv	a0,s1
    80001f7c:	cc7fe0ef          	jal	80000c42 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001f80:	4c9c                	lw	a5,24(s1)
    80001f82:	ff3791e3          	bne	a5,s3,80001f64 <wakeup+0x2a>
    80001f86:	709c                	ld	a5,32(s1)
    80001f88:	fd479ee3          	bne	a5,s4,80001f64 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001f8c:	0154ac23          	sw	s5,24(s1)
    80001f90:	bfd1                	j	80001f64 <wakeup+0x2a>
    }
  }
}
    80001f92:	70e2                	ld	ra,56(sp)
    80001f94:	7442                	ld	s0,48(sp)
    80001f96:	74a2                	ld	s1,40(sp)
    80001f98:	7902                	ld	s2,32(sp)
    80001f9a:	69e2                	ld	s3,24(sp)
    80001f9c:	6a42                	ld	s4,16(sp)
    80001f9e:	6aa2                	ld	s5,8(sp)
    80001fa0:	6121                	addi	sp,sp,64
    80001fa2:	8082                	ret

0000000080001fa4 <reparent>:
{
    80001fa4:	7179                	addi	sp,sp,-48
    80001fa6:	f406                	sd	ra,40(sp)
    80001fa8:	f022                	sd	s0,32(sp)
    80001faa:	ec26                	sd	s1,24(sp)
    80001fac:	e84a                	sd	s2,16(sp)
    80001fae:	e44e                	sd	s3,8(sp)
    80001fb0:	e052                	sd	s4,0(sp)
    80001fb2:	1800                	addi	s0,sp,48
    80001fb4:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001fb6:	00011497          	auipc	s1,0x11
    80001fba:	8ca48493          	addi	s1,s1,-1846 # 80012880 <proc>
      pp->parent = initproc;
    80001fbe:	00008a17          	auipc	s4,0x8
    80001fc2:	362a0a13          	addi	s4,s4,866 # 8000a320 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001fc6:	00016997          	auipc	s3,0x16
    80001fca:	2ba98993          	addi	s3,s3,698 # 80018280 <tickslock>
    80001fce:	a029                	j	80001fd8 <reparent+0x34>
    80001fd0:	16848493          	addi	s1,s1,360
    80001fd4:	01348b63          	beq	s1,s3,80001fea <reparent+0x46>
    if(pp->parent == p){
    80001fd8:	7c9c                	ld	a5,56(s1)
    80001fda:	ff279be3          	bne	a5,s2,80001fd0 <reparent+0x2c>
      pp->parent = initproc;
    80001fde:	000a3503          	ld	a0,0(s4)
    80001fe2:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001fe4:	f57ff0ef          	jal	80001f3a <wakeup>
    80001fe8:	b7e5                	j	80001fd0 <reparent+0x2c>
}
    80001fea:	70a2                	ld	ra,40(sp)
    80001fec:	7402                	ld	s0,32(sp)
    80001fee:	64e2                	ld	s1,24(sp)
    80001ff0:	6942                	ld	s2,16(sp)
    80001ff2:	69a2                	ld	s3,8(sp)
    80001ff4:	6a02                	ld	s4,0(sp)
    80001ff6:	6145                	addi	sp,sp,48
    80001ff8:	8082                	ret

0000000080001ffa <exit>:
{
    80001ffa:	7179                	addi	sp,sp,-48
    80001ffc:	f406                	sd	ra,40(sp)
    80001ffe:	f022                	sd	s0,32(sp)
    80002000:	ec26                	sd	s1,24(sp)
    80002002:	e84a                	sd	s2,16(sp)
    80002004:	e44e                	sd	s3,8(sp)
    80002006:	e052                	sd	s4,0(sp)
    80002008:	1800                	addi	s0,sp,48
    8000200a:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000200c:	915ff0ef          	jal	80001920 <myproc>
    80002010:	89aa                	mv	s3,a0
  if(p == initproc)
    80002012:	00008797          	auipc	a5,0x8
    80002016:	30e7b783          	ld	a5,782(a5) # 8000a320 <initproc>
    8000201a:	0d050493          	addi	s1,a0,208
    8000201e:	15050913          	addi	s2,a0,336
    80002022:	00a79b63          	bne	a5,a0,80002038 <exit+0x3e>
    panic("init exiting");
    80002026:	00005517          	auipc	a0,0x5
    8000202a:	25a50513          	addi	a0,a0,602 # 80007280 <etext+0x280>
    8000202e:	fb4fe0ef          	jal	800007e2 <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    80002032:	04a1                	addi	s1,s1,8
    80002034:	01248963          	beq	s1,s2,80002046 <exit+0x4c>
    if(p->ofile[fd]){
    80002038:	6088                	ld	a0,0(s1)
    8000203a:	dd65                	beqz	a0,80002032 <exit+0x38>
      fileclose(f);
    8000203c:	681010ef          	jal	80003ebc <fileclose>
      p->ofile[fd] = 0;
    80002040:	0004b023          	sd	zero,0(s1)
    80002044:	b7fd                	j	80002032 <exit+0x38>
  begin_op();
    80002046:	257010ef          	jal	80003a9c <begin_op>
  iput(p->cwd);
    8000204a:	1509b503          	ld	a0,336(s3)
    8000204e:	31e010ef          	jal	8000336c <iput>
  end_op();
    80002052:	2b5010ef          	jal	80003b06 <end_op>
  p->cwd = 0;
    80002056:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    8000205a:	00010497          	auipc	s1,0x10
    8000205e:	40e48493          	addi	s1,s1,1038 # 80012468 <wait_lock>
    80002062:	8526                	mv	a0,s1
    80002064:	bdffe0ef          	jal	80000c42 <acquire>
  reparent(p);
    80002068:	854e                	mv	a0,s3
    8000206a:	f3bff0ef          	jal	80001fa4 <reparent>
  wakeup(p->parent);
    8000206e:	0389b503          	ld	a0,56(s3)
    80002072:	ec9ff0ef          	jal	80001f3a <wakeup>
  acquire(&p->lock);
    80002076:	854e                	mv	a0,s3
    80002078:	bcbfe0ef          	jal	80000c42 <acquire>
  p->xstate = status;
    8000207c:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80002080:	4795                	li	a5,5
    80002082:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002086:	8526                	mv	a0,s1
    80002088:	c4ffe0ef          	jal	80000cd6 <release>
  sched();
    8000208c:	d7dff0ef          	jal	80001e08 <sched>
  panic("zombie exit");
    80002090:	00005517          	auipc	a0,0x5
    80002094:	20050513          	addi	a0,a0,512 # 80007290 <etext+0x290>
    80002098:	f4afe0ef          	jal	800007e2 <panic>

000000008000209c <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    8000209c:	7179                	addi	sp,sp,-48
    8000209e:	f406                	sd	ra,40(sp)
    800020a0:	f022                	sd	s0,32(sp)
    800020a2:	ec26                	sd	s1,24(sp)
    800020a4:	e84a                	sd	s2,16(sp)
    800020a6:	e44e                	sd	s3,8(sp)
    800020a8:	1800                	addi	s0,sp,48
    800020aa:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800020ac:	00010497          	auipc	s1,0x10
    800020b0:	7d448493          	addi	s1,s1,2004 # 80012880 <proc>
    800020b4:	00016997          	auipc	s3,0x16
    800020b8:	1cc98993          	addi	s3,s3,460 # 80018280 <tickslock>
    acquire(&p->lock);
    800020bc:	8526                	mv	a0,s1
    800020be:	b85fe0ef          	jal	80000c42 <acquire>
    if(p->pid == pid){
    800020c2:	589c                	lw	a5,48(s1)
    800020c4:	01278b63          	beq	a5,s2,800020da <kill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800020c8:	8526                	mv	a0,s1
    800020ca:	c0dfe0ef          	jal	80000cd6 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800020ce:	16848493          	addi	s1,s1,360
    800020d2:	ff3495e3          	bne	s1,s3,800020bc <kill+0x20>
  }
  return -1;
    800020d6:	557d                	li	a0,-1
    800020d8:	a819                	j	800020ee <kill+0x52>
      p->killed = 1;
    800020da:	4785                	li	a5,1
    800020dc:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800020de:	4c98                	lw	a4,24(s1)
    800020e0:	4789                	li	a5,2
    800020e2:	00f70d63          	beq	a4,a5,800020fc <kill+0x60>
      release(&p->lock);
    800020e6:	8526                	mv	a0,s1
    800020e8:	beffe0ef          	jal	80000cd6 <release>
      return 0;
    800020ec:	4501                	li	a0,0
}
    800020ee:	70a2                	ld	ra,40(sp)
    800020f0:	7402                	ld	s0,32(sp)
    800020f2:	64e2                	ld	s1,24(sp)
    800020f4:	6942                	ld	s2,16(sp)
    800020f6:	69a2                	ld	s3,8(sp)
    800020f8:	6145                	addi	sp,sp,48
    800020fa:	8082                	ret
        p->state = RUNNABLE;
    800020fc:	478d                	li	a5,3
    800020fe:	cc9c                	sw	a5,24(s1)
    80002100:	b7dd                	j	800020e6 <kill+0x4a>

0000000080002102 <setkilled>:

void
setkilled(struct proc *p)
{
    80002102:	1101                	addi	sp,sp,-32
    80002104:	ec06                	sd	ra,24(sp)
    80002106:	e822                	sd	s0,16(sp)
    80002108:	e426                	sd	s1,8(sp)
    8000210a:	1000                	addi	s0,sp,32
    8000210c:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000210e:	b35fe0ef          	jal	80000c42 <acquire>
  p->killed = 1;
    80002112:	4785                	li	a5,1
    80002114:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80002116:	8526                	mv	a0,s1
    80002118:	bbffe0ef          	jal	80000cd6 <release>
}
    8000211c:	60e2                	ld	ra,24(sp)
    8000211e:	6442                	ld	s0,16(sp)
    80002120:	64a2                	ld	s1,8(sp)
    80002122:	6105                	addi	sp,sp,32
    80002124:	8082                	ret

0000000080002126 <killed>:

int
killed(struct proc *p)
{
    80002126:	1101                	addi	sp,sp,-32
    80002128:	ec06                	sd	ra,24(sp)
    8000212a:	e822                	sd	s0,16(sp)
    8000212c:	e426                	sd	s1,8(sp)
    8000212e:	e04a                	sd	s2,0(sp)
    80002130:	1000                	addi	s0,sp,32
    80002132:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    80002134:	b0ffe0ef          	jal	80000c42 <acquire>
  k = p->killed;
    80002138:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    8000213c:	8526                	mv	a0,s1
    8000213e:	b99fe0ef          	jal	80000cd6 <release>
  return k;
}
    80002142:	854a                	mv	a0,s2
    80002144:	60e2                	ld	ra,24(sp)
    80002146:	6442                	ld	s0,16(sp)
    80002148:	64a2                	ld	s1,8(sp)
    8000214a:	6902                	ld	s2,0(sp)
    8000214c:	6105                	addi	sp,sp,32
    8000214e:	8082                	ret

0000000080002150 <wait>:
{
    80002150:	715d                	addi	sp,sp,-80
    80002152:	e486                	sd	ra,72(sp)
    80002154:	e0a2                	sd	s0,64(sp)
    80002156:	fc26                	sd	s1,56(sp)
    80002158:	f84a                	sd	s2,48(sp)
    8000215a:	f44e                	sd	s3,40(sp)
    8000215c:	f052                	sd	s4,32(sp)
    8000215e:	ec56                	sd	s5,24(sp)
    80002160:	e85a                	sd	s6,16(sp)
    80002162:	e45e                	sd	s7,8(sp)
    80002164:	0880                	addi	s0,sp,80
    80002166:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80002168:	fb8ff0ef          	jal	80001920 <myproc>
    8000216c:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000216e:	00010517          	auipc	a0,0x10
    80002172:	2fa50513          	addi	a0,a0,762 # 80012468 <wait_lock>
    80002176:	acdfe0ef          	jal	80000c42 <acquire>
        if(pp->state == ZOMBIE){
    8000217a:	4a15                	li	s4,5
        havekids = 1;
    8000217c:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000217e:	00016997          	auipc	s3,0x16
    80002182:	10298993          	addi	s3,s3,258 # 80018280 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002186:	00010b97          	auipc	s7,0x10
    8000218a:	2e2b8b93          	addi	s7,s7,738 # 80012468 <wait_lock>
    8000218e:	a869                	j	80002228 <wait+0xd8>
          pid = pp->pid;
    80002190:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80002194:	000b0c63          	beqz	s6,800021ac <wait+0x5c>
    80002198:	4691                	li	a3,4
    8000219a:	02c48613          	addi	a2,s1,44
    8000219e:	85da                	mv	a1,s6
    800021a0:	05093503          	ld	a0,80(s2)
    800021a4:	c24ff0ef          	jal	800015c8 <copyout>
    800021a8:	02054a63          	bltz	a0,800021dc <wait+0x8c>
          freeproc(pp);
    800021ac:	8526                	mv	a0,s1
    800021ae:	8e5ff0ef          	jal	80001a92 <freeproc>
          release(&pp->lock);
    800021b2:	8526                	mv	a0,s1
    800021b4:	b23fe0ef          	jal	80000cd6 <release>
          release(&wait_lock);
    800021b8:	00010517          	auipc	a0,0x10
    800021bc:	2b050513          	addi	a0,a0,688 # 80012468 <wait_lock>
    800021c0:	b17fe0ef          	jal	80000cd6 <release>
}
    800021c4:	854e                	mv	a0,s3
    800021c6:	60a6                	ld	ra,72(sp)
    800021c8:	6406                	ld	s0,64(sp)
    800021ca:	74e2                	ld	s1,56(sp)
    800021cc:	7942                	ld	s2,48(sp)
    800021ce:	79a2                	ld	s3,40(sp)
    800021d0:	7a02                	ld	s4,32(sp)
    800021d2:	6ae2                	ld	s5,24(sp)
    800021d4:	6b42                	ld	s6,16(sp)
    800021d6:	6ba2                	ld	s7,8(sp)
    800021d8:	6161                	addi	sp,sp,80
    800021da:	8082                	ret
            release(&pp->lock);
    800021dc:	8526                	mv	a0,s1
    800021de:	af9fe0ef          	jal	80000cd6 <release>
            release(&wait_lock);
    800021e2:	00010517          	auipc	a0,0x10
    800021e6:	28650513          	addi	a0,a0,646 # 80012468 <wait_lock>
    800021ea:	aedfe0ef          	jal	80000cd6 <release>
            return -1;
    800021ee:	59fd                	li	s3,-1
    800021f0:	bfd1                	j	800021c4 <wait+0x74>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800021f2:	16848493          	addi	s1,s1,360
    800021f6:	03348063          	beq	s1,s3,80002216 <wait+0xc6>
      if(pp->parent == p){
    800021fa:	7c9c                	ld	a5,56(s1)
    800021fc:	ff279be3          	bne	a5,s2,800021f2 <wait+0xa2>
        acquire(&pp->lock);
    80002200:	8526                	mv	a0,s1
    80002202:	a41fe0ef          	jal	80000c42 <acquire>
        if(pp->state == ZOMBIE){
    80002206:	4c9c                	lw	a5,24(s1)
    80002208:	f94784e3          	beq	a5,s4,80002190 <wait+0x40>
        release(&pp->lock);
    8000220c:	8526                	mv	a0,s1
    8000220e:	ac9fe0ef          	jal	80000cd6 <release>
        havekids = 1;
    80002212:	8756                	mv	a4,s5
    80002214:	bff9                	j	800021f2 <wait+0xa2>
    if(!havekids || killed(p)){
    80002216:	cf19                	beqz	a4,80002234 <wait+0xe4>
    80002218:	854a                	mv	a0,s2
    8000221a:	f0dff0ef          	jal	80002126 <killed>
    8000221e:	e919                	bnez	a0,80002234 <wait+0xe4>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80002220:	85de                	mv	a1,s7
    80002222:	854a                	mv	a0,s2
    80002224:	ccbff0ef          	jal	80001eee <sleep>
    havekids = 0;
    80002228:	4701                	li	a4,0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000222a:	00010497          	auipc	s1,0x10
    8000222e:	65648493          	addi	s1,s1,1622 # 80012880 <proc>
    80002232:	b7e1                	j	800021fa <wait+0xaa>
      release(&wait_lock);
    80002234:	00010517          	auipc	a0,0x10
    80002238:	23450513          	addi	a0,a0,564 # 80012468 <wait_lock>
    8000223c:	a9bfe0ef          	jal	80000cd6 <release>
      return -1;
    80002240:	59fd                	li	s3,-1
    80002242:	b749                	j	800021c4 <wait+0x74>

0000000080002244 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80002244:	7179                	addi	sp,sp,-48
    80002246:	f406                	sd	ra,40(sp)
    80002248:	f022                	sd	s0,32(sp)
    8000224a:	ec26                	sd	s1,24(sp)
    8000224c:	e84a                	sd	s2,16(sp)
    8000224e:	e44e                	sd	s3,8(sp)
    80002250:	e052                	sd	s4,0(sp)
    80002252:	1800                	addi	s0,sp,48
    80002254:	84aa                	mv	s1,a0
    80002256:	892e                	mv	s2,a1
    80002258:	89b2                	mv	s3,a2
    8000225a:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000225c:	ec4ff0ef          	jal	80001920 <myproc>
  if(user_dst){
    80002260:	cc99                	beqz	s1,8000227e <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    80002262:	86d2                	mv	a3,s4
    80002264:	864e                	mv	a2,s3
    80002266:	85ca                	mv	a1,s2
    80002268:	6928                	ld	a0,80(a0)
    8000226a:	b5eff0ef          	jal	800015c8 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000226e:	70a2                	ld	ra,40(sp)
    80002270:	7402                	ld	s0,32(sp)
    80002272:	64e2                	ld	s1,24(sp)
    80002274:	6942                	ld	s2,16(sp)
    80002276:	69a2                	ld	s3,8(sp)
    80002278:	6a02                	ld	s4,0(sp)
    8000227a:	6145                	addi	sp,sp,48
    8000227c:	8082                	ret
    memmove((char *)dst, src, len);
    8000227e:	000a061b          	sext.w	a2,s4
    80002282:	85ce                	mv	a1,s3
    80002284:	854a                	mv	a0,s2
    80002286:	af1fe0ef          	jal	80000d76 <memmove>
    return 0;
    8000228a:	8526                	mv	a0,s1
    8000228c:	b7cd                	j	8000226e <either_copyout+0x2a>

000000008000228e <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000228e:	7179                	addi	sp,sp,-48
    80002290:	f406                	sd	ra,40(sp)
    80002292:	f022                	sd	s0,32(sp)
    80002294:	ec26                	sd	s1,24(sp)
    80002296:	e84a                	sd	s2,16(sp)
    80002298:	e44e                	sd	s3,8(sp)
    8000229a:	e052                	sd	s4,0(sp)
    8000229c:	1800                	addi	s0,sp,48
    8000229e:	892a                	mv	s2,a0
    800022a0:	84ae                	mv	s1,a1
    800022a2:	89b2                	mv	s3,a2
    800022a4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800022a6:	e7aff0ef          	jal	80001920 <myproc>
  if(user_src){
    800022aa:	cc99                	beqz	s1,800022c8 <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    800022ac:	86d2                	mv	a3,s4
    800022ae:	864e                	mv	a2,s3
    800022b0:	85ca                	mv	a1,s2
    800022b2:	6928                	ld	a0,80(a0)
    800022b4:	bc4ff0ef          	jal	80001678 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800022b8:	70a2                	ld	ra,40(sp)
    800022ba:	7402                	ld	s0,32(sp)
    800022bc:	64e2                	ld	s1,24(sp)
    800022be:	6942                	ld	s2,16(sp)
    800022c0:	69a2                	ld	s3,8(sp)
    800022c2:	6a02                	ld	s4,0(sp)
    800022c4:	6145                	addi	sp,sp,48
    800022c6:	8082                	ret
    memmove(dst, (char*)src, len);
    800022c8:	000a061b          	sext.w	a2,s4
    800022cc:	85ce                	mv	a1,s3
    800022ce:	854a                	mv	a0,s2
    800022d0:	aa7fe0ef          	jal	80000d76 <memmove>
    return 0;
    800022d4:	8526                	mv	a0,s1
    800022d6:	b7cd                	j	800022b8 <either_copyin+0x2a>

00000000800022d8 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800022d8:	715d                	addi	sp,sp,-80
    800022da:	e486                	sd	ra,72(sp)
    800022dc:	e0a2                	sd	s0,64(sp)
    800022de:	fc26                	sd	s1,56(sp)
    800022e0:	f84a                	sd	s2,48(sp)
    800022e2:	f44e                	sd	s3,40(sp)
    800022e4:	f052                	sd	s4,32(sp)
    800022e6:	ec56                	sd	s5,24(sp)
    800022e8:	e85a                	sd	s6,16(sp)
    800022ea:	e45e                	sd	s7,8(sp)
    800022ec:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800022ee:	00005517          	auipc	a0,0x5
    800022f2:	d8a50513          	addi	a0,a0,-630 # 80007078 <etext+0x78>
    800022f6:	a1cfe0ef          	jal	80000512 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800022fa:	00010497          	auipc	s1,0x10
    800022fe:	6de48493          	addi	s1,s1,1758 # 800129d8 <proc+0x158>
    80002302:	00016917          	auipc	s2,0x16
    80002306:	0d690913          	addi	s2,s2,214 # 800183d8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000230a:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    8000230c:	00005997          	auipc	s3,0x5
    80002310:	f9498993          	addi	s3,s3,-108 # 800072a0 <etext+0x2a0>
    printf("%d %s %s", p->pid, state, p->name);
    80002314:	00005a97          	auipc	s5,0x5
    80002318:	f94a8a93          	addi	s5,s5,-108 # 800072a8 <etext+0x2a8>
    printf("\n");
    8000231c:	00005a17          	auipc	s4,0x5
    80002320:	d5ca0a13          	addi	s4,s4,-676 # 80007078 <etext+0x78>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002324:	00005b97          	auipc	s7,0x5
    80002328:	464b8b93          	addi	s7,s7,1124 # 80007788 <states.0>
    8000232c:	a829                	j	80002346 <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    8000232e:	ed86a583          	lw	a1,-296(a3)
    80002332:	8556                	mv	a0,s5
    80002334:	9defe0ef          	jal	80000512 <printf>
    printf("\n");
    80002338:	8552                	mv	a0,s4
    8000233a:	9d8fe0ef          	jal	80000512 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000233e:	16848493          	addi	s1,s1,360
    80002342:	03248263          	beq	s1,s2,80002366 <procdump+0x8e>
    if(p->state == UNUSED)
    80002346:	86a6                	mv	a3,s1
    80002348:	ec04a783          	lw	a5,-320(s1)
    8000234c:	dbed                	beqz	a5,8000233e <procdump+0x66>
      state = "???";
    8000234e:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80002350:	fcfb6fe3          	bltu	s6,a5,8000232e <procdump+0x56>
    80002354:	02079713          	slli	a4,a5,0x20
    80002358:	01d75793          	srli	a5,a4,0x1d
    8000235c:	97de                	add	a5,a5,s7
    8000235e:	6390                	ld	a2,0(a5)
    80002360:	f679                	bnez	a2,8000232e <procdump+0x56>
      state = "???";
    80002362:	864e                	mv	a2,s3
    80002364:	b7e9                	j	8000232e <procdump+0x56>
  }
}
    80002366:	60a6                	ld	ra,72(sp)
    80002368:	6406                	ld	s0,64(sp)
    8000236a:	74e2                	ld	s1,56(sp)
    8000236c:	7942                	ld	s2,48(sp)
    8000236e:	79a2                	ld	s3,40(sp)
    80002370:	7a02                	ld	s4,32(sp)
    80002372:	6ae2                	ld	s5,24(sp)
    80002374:	6b42                	ld	s6,16(sp)
    80002376:	6ba2                	ld	s7,8(sp)
    80002378:	6161                	addi	sp,sp,80
    8000237a:	8082                	ret

000000008000237c <swtch>:
    8000237c:	00153023          	sd	ra,0(a0)
    80002380:	00253423          	sd	sp,8(a0)
    80002384:	e900                	sd	s0,16(a0)
    80002386:	ed04                	sd	s1,24(a0)
    80002388:	03253023          	sd	s2,32(a0)
    8000238c:	03353423          	sd	s3,40(a0)
    80002390:	03453823          	sd	s4,48(a0)
    80002394:	03553c23          	sd	s5,56(a0)
    80002398:	05653023          	sd	s6,64(a0)
    8000239c:	05753423          	sd	s7,72(a0)
    800023a0:	05853823          	sd	s8,80(a0)
    800023a4:	05953c23          	sd	s9,88(a0)
    800023a8:	07a53023          	sd	s10,96(a0)
    800023ac:	07b53423          	sd	s11,104(a0)
    800023b0:	0005b083          	ld	ra,0(a1)
    800023b4:	0085b103          	ld	sp,8(a1)
    800023b8:	6980                	ld	s0,16(a1)
    800023ba:	6d84                	ld	s1,24(a1)
    800023bc:	0205b903          	ld	s2,32(a1)
    800023c0:	0285b983          	ld	s3,40(a1)
    800023c4:	0305ba03          	ld	s4,48(a1)
    800023c8:	0385ba83          	ld	s5,56(a1)
    800023cc:	0405bb03          	ld	s6,64(a1)
    800023d0:	0485bb83          	ld	s7,72(a1)
    800023d4:	0505bc03          	ld	s8,80(a1)
    800023d8:	0585bc83          	ld	s9,88(a1)
    800023dc:	0605bd03          	ld	s10,96(a1)
    800023e0:	0685bd83          	ld	s11,104(a1)
    800023e4:	8082                	ret

00000000800023e6 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    800023e6:	1141                	addi	sp,sp,-16
    800023e8:	e406                	sd	ra,8(sp)
    800023ea:	e022                	sd	s0,0(sp)
    800023ec:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    800023ee:	00005597          	auipc	a1,0x5
    800023f2:	efa58593          	addi	a1,a1,-262 # 800072e8 <etext+0x2e8>
    800023f6:	00016517          	auipc	a0,0x16
    800023fa:	e8a50513          	addi	a0,a0,-374 # 80018280 <tickslock>
    800023fe:	fc0fe0ef          	jal	80000bbe <initlock>
}
    80002402:	60a2                	ld	ra,8(sp)
    80002404:	6402                	ld	s0,0(sp)
    80002406:	0141                	addi	sp,sp,16
    80002408:	8082                	ret

000000008000240a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    8000240a:	1141                	addi	sp,sp,-16
    8000240c:	e406                	sd	ra,8(sp)
    8000240e:	e022                	sd	s0,0(sp)
    80002410:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002412:	00003797          	auipc	a5,0x3
    80002416:	e5e78793          	addi	a5,a5,-418 # 80005270 <kernelvec>
    8000241a:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    8000241e:	60a2                	ld	ra,8(sp)
    80002420:	6402                	ld	s0,0(sp)
    80002422:	0141                	addi	sp,sp,16
    80002424:	8082                	ret

0000000080002426 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80002426:	1141                	addi	sp,sp,-16
    80002428:	e406                	sd	ra,8(sp)
    8000242a:	e022                	sd	s0,0(sp)
    8000242c:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    8000242e:	cf2ff0ef          	jal	80001920 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002432:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80002436:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002438:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    8000243c:	00004697          	auipc	a3,0x4
    80002440:	bc468693          	addi	a3,a3,-1084 # 80006000 <_trampoline>
    80002444:	00004717          	auipc	a4,0x4
    80002448:	bbc70713          	addi	a4,a4,-1092 # 80006000 <_trampoline>
    8000244c:	8f15                	sub	a4,a4,a3
    8000244e:	040007b7          	lui	a5,0x4000
    80002452:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80002454:	07b2                	slli	a5,a5,0xc
    80002456:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002458:	10571073          	csrw	stvec,a4
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000245c:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    8000245e:	18002673          	csrr	a2,satp
    80002462:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002464:	6d30                	ld	a2,88(a0)
    80002466:	6138                	ld	a4,64(a0)
    80002468:	6585                	lui	a1,0x1
    8000246a:	972e                	add	a4,a4,a1
    8000246c:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8000246e:	6d38                	ld	a4,88(a0)
    80002470:	00000617          	auipc	a2,0x0
    80002474:	11060613          	addi	a2,a2,272 # 80002580 <usertrap>
    80002478:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    8000247a:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8000247c:	8612                	mv	a2,tp
    8000247e:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002480:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002484:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002488:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000248c:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80002490:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002492:	6f18                	ld	a4,24(a4)
    80002494:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002498:	6928                	ld	a0,80(a0)
    8000249a:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    8000249c:	00004717          	auipc	a4,0x4
    800024a0:	c0070713          	addi	a4,a4,-1024 # 8000609c <userret>
    800024a4:	8f15                	sub	a4,a4,a3
    800024a6:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    800024a8:	577d                	li	a4,-1
    800024aa:	177e                	slli	a4,a4,0x3f
    800024ac:	8d59                	or	a0,a0,a4
    800024ae:	9782                	jalr	a5
}
    800024b0:	60a2                	ld	ra,8(sp)
    800024b2:	6402                	ld	s0,0(sp)
    800024b4:	0141                	addi	sp,sp,16
    800024b6:	8082                	ret

00000000800024b8 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    800024b8:	1101                	addi	sp,sp,-32
    800024ba:	ec06                	sd	ra,24(sp)
    800024bc:	e822                	sd	s0,16(sp)
    800024be:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    800024c0:	c2cff0ef          	jal	800018ec <cpuid>
    800024c4:	cd11                	beqz	a0,800024e0 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    800024c6:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    800024ca:	000f4737          	lui	a4,0xf4
    800024ce:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    800024d2:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    800024d4:	14d79073          	csrw	stimecmp,a5
}
    800024d8:	60e2                	ld	ra,24(sp)
    800024da:	6442                	ld	s0,16(sp)
    800024dc:	6105                	addi	sp,sp,32
    800024de:	8082                	ret
    800024e0:	e426                	sd	s1,8(sp)
    acquire(&tickslock);
    800024e2:	00016497          	auipc	s1,0x16
    800024e6:	d9e48493          	addi	s1,s1,-610 # 80018280 <tickslock>
    800024ea:	8526                	mv	a0,s1
    800024ec:	f56fe0ef          	jal	80000c42 <acquire>
    ticks++;
    800024f0:	00008517          	auipc	a0,0x8
    800024f4:	e3850513          	addi	a0,a0,-456 # 8000a328 <ticks>
    800024f8:	411c                	lw	a5,0(a0)
    800024fa:	2785                	addiw	a5,a5,1
    800024fc:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    800024fe:	a3dff0ef          	jal	80001f3a <wakeup>
    release(&tickslock);
    80002502:	8526                	mv	a0,s1
    80002504:	fd2fe0ef          	jal	80000cd6 <release>
    80002508:	64a2                	ld	s1,8(sp)
    8000250a:	bf75                	j	800024c6 <clockintr+0xe>

000000008000250c <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000250c:	1101                	addi	sp,sp,-32
    8000250e:	ec06                	sd	ra,24(sp)
    80002510:	e822                	sd	s0,16(sp)
    80002512:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002514:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    80002518:	57fd                	li	a5,-1
    8000251a:	17fe                	slli	a5,a5,0x3f
    8000251c:	07a5                	addi	a5,a5,9
    8000251e:	00f70c63          	beq	a4,a5,80002536 <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80002522:	57fd                	li	a5,-1
    80002524:	17fe                	slli	a5,a5,0x3f
    80002526:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    80002528:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    8000252a:	04f70763          	beq	a4,a5,80002578 <devintr+0x6c>
  }
}
    8000252e:	60e2                	ld	ra,24(sp)
    80002530:	6442                	ld	s0,16(sp)
    80002532:	6105                	addi	sp,sp,32
    80002534:	8082                	ret
    80002536:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80002538:	5e5020ef          	jal	8000531c <plic_claim>
    8000253c:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    8000253e:	47a9                	li	a5,10
    80002540:	00f50963          	beq	a0,a5,80002552 <devintr+0x46>
    } else if(irq == VIRTIO0_IRQ){
    80002544:	4785                	li	a5,1
    80002546:	00f50963          	beq	a0,a5,80002558 <devintr+0x4c>
    return 1;
    8000254a:	4505                	li	a0,1
    } else if(irq){
    8000254c:	e889                	bnez	s1,8000255e <devintr+0x52>
    8000254e:	64a2                	ld	s1,8(sp)
    80002550:	bff9                	j	8000252e <devintr+0x22>
      uartintr();
    80002552:	cfefe0ef          	jal	80000a50 <uartintr>
    if(irq)
    80002556:	a819                	j	8000256c <devintr+0x60>
      virtio_disk_intr();
    80002558:	254030ef          	jal	800057ac <virtio_disk_intr>
    if(irq)
    8000255c:	a801                	j	8000256c <devintr+0x60>
      printf("unexpected interrupt irq=%d\n", irq);
    8000255e:	85a6                	mv	a1,s1
    80002560:	00005517          	auipc	a0,0x5
    80002564:	d9050513          	addi	a0,a0,-624 # 800072f0 <etext+0x2f0>
    80002568:	fabfd0ef          	jal	80000512 <printf>
      plic_complete(irq);
    8000256c:	8526                	mv	a0,s1
    8000256e:	5cf020ef          	jal	8000533c <plic_complete>
    return 1;
    80002572:	4505                	li	a0,1
    80002574:	64a2                	ld	s1,8(sp)
    80002576:	bf65                	j	8000252e <devintr+0x22>
    clockintr();
    80002578:	f41ff0ef          	jal	800024b8 <clockintr>
    return 2;
    8000257c:	4509                	li	a0,2
    8000257e:	bf45                	j	8000252e <devintr+0x22>

0000000080002580 <usertrap>:
{
    80002580:	1101                	addi	sp,sp,-32
    80002582:	ec06                	sd	ra,24(sp)
    80002584:	e822                	sd	s0,16(sp)
    80002586:	e426                	sd	s1,8(sp)
    80002588:	e04a                	sd	s2,0(sp)
    8000258a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000258c:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002590:	1007f793          	andi	a5,a5,256
    80002594:	ef85                	bnez	a5,800025cc <usertrap+0x4c>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002596:	00003797          	auipc	a5,0x3
    8000259a:	cda78793          	addi	a5,a5,-806 # 80005270 <kernelvec>
    8000259e:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    800025a2:	b7eff0ef          	jal	80001920 <myproc>
    800025a6:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    800025a8:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800025aa:	14102773          	csrr	a4,sepc
    800025ae:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    800025b0:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    800025b4:	47a1                	li	a5,8
    800025b6:	02f70163          	beq	a4,a5,800025d8 <usertrap+0x58>
  } else if((which_dev = devintr()) != 0){
    800025ba:	f53ff0ef          	jal	8000250c <devintr>
    800025be:	892a                	mv	s2,a0
    800025c0:	c135                	beqz	a0,80002624 <usertrap+0xa4>
  if(killed(p))
    800025c2:	8526                	mv	a0,s1
    800025c4:	b63ff0ef          	jal	80002126 <killed>
    800025c8:	cd1d                	beqz	a0,80002606 <usertrap+0x86>
    800025ca:	a81d                	j	80002600 <usertrap+0x80>
    panic("usertrap: not from user mode");
    800025cc:	00005517          	auipc	a0,0x5
    800025d0:	d4450513          	addi	a0,a0,-700 # 80007310 <etext+0x310>
    800025d4:	a0efe0ef          	jal	800007e2 <panic>
    if(killed(p))
    800025d8:	b4fff0ef          	jal	80002126 <killed>
    800025dc:	e121                	bnez	a0,8000261c <usertrap+0x9c>
    p->trapframe->epc += 4;
    800025de:	6cb8                	ld	a4,88(s1)
    800025e0:	6f1c                	ld	a5,24(a4)
    800025e2:	0791                	addi	a5,a5,4
    800025e4:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800025e6:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800025ea:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025ee:	10079073          	csrw	sstatus,a5
    syscall();
    800025f2:	240000ef          	jal	80002832 <syscall>
  if(killed(p))
    800025f6:	8526                	mv	a0,s1
    800025f8:	b2fff0ef          	jal	80002126 <killed>
    800025fc:	c901                	beqz	a0,8000260c <usertrap+0x8c>
    800025fe:	4901                	li	s2,0
    exit(-1);
    80002600:	557d                	li	a0,-1
    80002602:	9f9ff0ef          	jal	80001ffa <exit>
  if(which_dev == 2)
    80002606:	4789                	li	a5,2
    80002608:	04f90563          	beq	s2,a5,80002652 <usertrap+0xd2>
  usertrapret();
    8000260c:	e1bff0ef          	jal	80002426 <usertrapret>
}
    80002610:	60e2                	ld	ra,24(sp)
    80002612:	6442                	ld	s0,16(sp)
    80002614:	64a2                	ld	s1,8(sp)
    80002616:	6902                	ld	s2,0(sp)
    80002618:	6105                	addi	sp,sp,32
    8000261a:	8082                	ret
      exit(-1);
    8000261c:	557d                	li	a0,-1
    8000261e:	9ddff0ef          	jal	80001ffa <exit>
    80002622:	bf75                	j	800025de <usertrap+0x5e>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002624:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80002628:	5890                	lw	a2,48(s1)
    8000262a:	00005517          	auipc	a0,0x5
    8000262e:	d0650513          	addi	a0,a0,-762 # 80007330 <etext+0x330>
    80002632:	ee1fd0ef          	jal	80000512 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002636:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    8000263a:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    8000263e:	00005517          	auipc	a0,0x5
    80002642:	d2250513          	addi	a0,a0,-734 # 80007360 <etext+0x360>
    80002646:	ecdfd0ef          	jal	80000512 <printf>
    setkilled(p);
    8000264a:	8526                	mv	a0,s1
    8000264c:	ab7ff0ef          	jal	80002102 <setkilled>
    80002650:	b75d                	j	800025f6 <usertrap+0x76>
    yield();
    80002652:	871ff0ef          	jal	80001ec2 <yield>
    80002656:	bf5d                	j	8000260c <usertrap+0x8c>

0000000080002658 <kerneltrap>:
{
    80002658:	7179                	addi	sp,sp,-48
    8000265a:	f406                	sd	ra,40(sp)
    8000265c:	f022                	sd	s0,32(sp)
    8000265e:	ec26                	sd	s1,24(sp)
    80002660:	e84a                	sd	s2,16(sp)
    80002662:	e44e                	sd	s3,8(sp)
    80002664:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002666:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000266a:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000266e:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002672:	1004f793          	andi	a5,s1,256
    80002676:	c795                	beqz	a5,800026a2 <kerneltrap+0x4a>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002678:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000267c:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    8000267e:	eb85                	bnez	a5,800026ae <kerneltrap+0x56>
  if((which_dev = devintr()) == 0){
    80002680:	e8dff0ef          	jal	8000250c <devintr>
    80002684:	c91d                	beqz	a0,800026ba <kerneltrap+0x62>
  if(which_dev == 2 && myproc() != 0)
    80002686:	4789                	li	a5,2
    80002688:	04f50a63          	beq	a0,a5,800026dc <kerneltrap+0x84>
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000268c:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002690:	10049073          	csrw	sstatus,s1
}
    80002694:	70a2                	ld	ra,40(sp)
    80002696:	7402                	ld	s0,32(sp)
    80002698:	64e2                	ld	s1,24(sp)
    8000269a:	6942                	ld	s2,16(sp)
    8000269c:	69a2                	ld	s3,8(sp)
    8000269e:	6145                	addi	sp,sp,48
    800026a0:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    800026a2:	00005517          	auipc	a0,0x5
    800026a6:	ce650513          	addi	a0,a0,-794 # 80007388 <etext+0x388>
    800026aa:	938fe0ef          	jal	800007e2 <panic>
    panic("kerneltrap: interrupts enabled");
    800026ae:	00005517          	auipc	a0,0x5
    800026b2:	d0250513          	addi	a0,a0,-766 # 800073b0 <etext+0x3b0>
    800026b6:	92cfe0ef          	jal	800007e2 <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800026ba:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800026be:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    800026c2:	85ce                	mv	a1,s3
    800026c4:	00005517          	auipc	a0,0x5
    800026c8:	d0c50513          	addi	a0,a0,-756 # 800073d0 <etext+0x3d0>
    800026cc:	e47fd0ef          	jal	80000512 <printf>
    panic("kerneltrap");
    800026d0:	00005517          	auipc	a0,0x5
    800026d4:	d2850513          	addi	a0,a0,-728 # 800073f8 <etext+0x3f8>
    800026d8:	90afe0ef          	jal	800007e2 <panic>
  if(which_dev == 2 && myproc() != 0)
    800026dc:	a44ff0ef          	jal	80001920 <myproc>
    800026e0:	d555                	beqz	a0,8000268c <kerneltrap+0x34>
    yield();
    800026e2:	fe0ff0ef          	jal	80001ec2 <yield>
    800026e6:	b75d                	j	8000268c <kerneltrap+0x34>

00000000800026e8 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    800026e8:	1101                	addi	sp,sp,-32
    800026ea:	ec06                	sd	ra,24(sp)
    800026ec:	e822                	sd	s0,16(sp)
    800026ee:	e426                	sd	s1,8(sp)
    800026f0:	1000                	addi	s0,sp,32
    800026f2:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800026f4:	a2cff0ef          	jal	80001920 <myproc>
  switch (n)
    800026f8:	4795                	li	a5,5
    800026fa:	0497e163          	bltu	a5,s1,8000273c <argraw+0x54>
    800026fe:	048a                	slli	s1,s1,0x2
    80002700:	00005717          	auipc	a4,0x5
    80002704:	0b870713          	addi	a4,a4,184 # 800077b8 <states.0+0x30>
    80002708:	94ba                	add	s1,s1,a4
    8000270a:	409c                	lw	a5,0(s1)
    8000270c:	97ba                	add	a5,a5,a4
    8000270e:	8782                	jr	a5
  {
  case 0:
    return p->trapframe->a0;
    80002710:	6d3c                	ld	a5,88(a0)
    80002712:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002714:	60e2                	ld	ra,24(sp)
    80002716:	6442                	ld	s0,16(sp)
    80002718:	64a2                	ld	s1,8(sp)
    8000271a:	6105                	addi	sp,sp,32
    8000271c:	8082                	ret
    return p->trapframe->a1;
    8000271e:	6d3c                	ld	a5,88(a0)
    80002720:	7fa8                	ld	a0,120(a5)
    80002722:	bfcd                	j	80002714 <argraw+0x2c>
    return p->trapframe->a2;
    80002724:	6d3c                	ld	a5,88(a0)
    80002726:	63c8                	ld	a0,128(a5)
    80002728:	b7f5                	j	80002714 <argraw+0x2c>
    return p->trapframe->a3;
    8000272a:	6d3c                	ld	a5,88(a0)
    8000272c:	67c8                	ld	a0,136(a5)
    8000272e:	b7dd                	j	80002714 <argraw+0x2c>
    return p->trapframe->a4;
    80002730:	6d3c                	ld	a5,88(a0)
    80002732:	6bc8                	ld	a0,144(a5)
    80002734:	b7c5                	j	80002714 <argraw+0x2c>
    return p->trapframe->a5;
    80002736:	6d3c                	ld	a5,88(a0)
    80002738:	6fc8                	ld	a0,152(a5)
    8000273a:	bfe9                	j	80002714 <argraw+0x2c>
  panic("argraw");
    8000273c:	00005517          	auipc	a0,0x5
    80002740:	ccc50513          	addi	a0,a0,-820 # 80007408 <etext+0x408>
    80002744:	89efe0ef          	jal	800007e2 <panic>

0000000080002748 <fetchaddr>:
{
    80002748:	1101                	addi	sp,sp,-32
    8000274a:	ec06                	sd	ra,24(sp)
    8000274c:	e822                	sd	s0,16(sp)
    8000274e:	e426                	sd	s1,8(sp)
    80002750:	e04a                	sd	s2,0(sp)
    80002752:	1000                	addi	s0,sp,32
    80002754:	84aa                	mv	s1,a0
    80002756:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002758:	9c8ff0ef          	jal	80001920 <myproc>
  if (addr >= p->sz || addr + sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    8000275c:	653c                	ld	a5,72(a0)
    8000275e:	02f4f663          	bgeu	s1,a5,8000278a <fetchaddr+0x42>
    80002762:	00848713          	addi	a4,s1,8
    80002766:	02e7e463          	bltu	a5,a4,8000278e <fetchaddr+0x46>
  if (copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    8000276a:	46a1                	li	a3,8
    8000276c:	8626                	mv	a2,s1
    8000276e:	85ca                	mv	a1,s2
    80002770:	6928                	ld	a0,80(a0)
    80002772:	f07fe0ef          	jal	80001678 <copyin>
    80002776:	00a03533          	snez	a0,a0
    8000277a:	40a0053b          	negw	a0,a0
}
    8000277e:	60e2                	ld	ra,24(sp)
    80002780:	6442                	ld	s0,16(sp)
    80002782:	64a2                	ld	s1,8(sp)
    80002784:	6902                	ld	s2,0(sp)
    80002786:	6105                	addi	sp,sp,32
    80002788:	8082                	ret
    return -1;
    8000278a:	557d                	li	a0,-1
    8000278c:	bfcd                	j	8000277e <fetchaddr+0x36>
    8000278e:	557d                	li	a0,-1
    80002790:	b7fd                	j	8000277e <fetchaddr+0x36>

0000000080002792 <fetchstr>:
{
    80002792:	7179                	addi	sp,sp,-48
    80002794:	f406                	sd	ra,40(sp)
    80002796:	f022                	sd	s0,32(sp)
    80002798:	ec26                	sd	s1,24(sp)
    8000279a:	e84a                	sd	s2,16(sp)
    8000279c:	e44e                	sd	s3,8(sp)
    8000279e:	1800                	addi	s0,sp,48
    800027a0:	892a                	mv	s2,a0
    800027a2:	84ae                	mv	s1,a1
    800027a4:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800027a6:	97aff0ef          	jal	80001920 <myproc>
  if (copyinstr(p->pagetable, buf, addr, max) < 0)
    800027aa:	86ce                	mv	a3,s3
    800027ac:	864a                	mv	a2,s2
    800027ae:	85a6                	mv	a1,s1
    800027b0:	6928                	ld	a0,80(a0)
    800027b2:	f4dfe0ef          	jal	800016fe <copyinstr>
    800027b6:	00054c63          	bltz	a0,800027ce <fetchstr+0x3c>
  return strlen(buf);
    800027ba:	8526                	mv	a0,s1
    800027bc:	edefe0ef          	jal	80000e9a <strlen>
}
    800027c0:	70a2                	ld	ra,40(sp)
    800027c2:	7402                	ld	s0,32(sp)
    800027c4:	64e2                	ld	s1,24(sp)
    800027c6:	6942                	ld	s2,16(sp)
    800027c8:	69a2                	ld	s3,8(sp)
    800027ca:	6145                	addi	sp,sp,48
    800027cc:	8082                	ret
    return -1;
    800027ce:	557d                	li	a0,-1
    800027d0:	bfc5                	j	800027c0 <fetchstr+0x2e>

00000000800027d2 <argint>:

// Fetch the nth 32-bit system call argument.
void argint(int n, int *ip)
{
    800027d2:	1101                	addi	sp,sp,-32
    800027d4:	ec06                	sd	ra,24(sp)
    800027d6:	e822                	sd	s0,16(sp)
    800027d8:	e426                	sd	s1,8(sp)
    800027da:	1000                	addi	s0,sp,32
    800027dc:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800027de:	f0bff0ef          	jal	800026e8 <argraw>
    800027e2:	c088                	sw	a0,0(s1)
}
    800027e4:	60e2                	ld	ra,24(sp)
    800027e6:	6442                	ld	s0,16(sp)
    800027e8:	64a2                	ld	s1,8(sp)
    800027ea:	6105                	addi	sp,sp,32
    800027ec:	8082                	ret

00000000800027ee <argaddr>:

// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void argaddr(int n, uint64 *ip)
{
    800027ee:	1101                	addi	sp,sp,-32
    800027f0:	ec06                	sd	ra,24(sp)
    800027f2:	e822                	sd	s0,16(sp)
    800027f4:	e426                	sd	s1,8(sp)
    800027f6:	1000                	addi	s0,sp,32
    800027f8:	84ae                	mv	s1,a1
  *ip = argraw(n);
    800027fa:	eefff0ef          	jal	800026e8 <argraw>
    800027fe:	e088                	sd	a0,0(s1)
}
    80002800:	60e2                	ld	ra,24(sp)
    80002802:	6442                	ld	s0,16(sp)
    80002804:	64a2                	ld	s1,8(sp)
    80002806:	6105                	addi	sp,sp,32
    80002808:	8082                	ret

000000008000280a <argstr>:

// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int argstr(int n, char *buf, int max)
{
    8000280a:	1101                	addi	sp,sp,-32
    8000280c:	ec06                	sd	ra,24(sp)
    8000280e:	e822                	sd	s0,16(sp)
    80002810:	e426                	sd	s1,8(sp)
    80002812:	e04a                	sd	s2,0(sp)
    80002814:	1000                	addi	s0,sp,32
    80002816:	84ae                	mv	s1,a1
    80002818:	8932                	mv	s2,a2
  *ip = argraw(n);
    8000281a:	ecfff0ef          	jal	800026e8 <argraw>
  uint64 addr;
  argaddr(n, &addr);
  return fetchstr(addr, buf, max);
    8000281e:	864a                	mv	a2,s2
    80002820:	85a6                	mv	a1,s1
    80002822:	f71ff0ef          	jal	80002792 <fetchstr>
}
    80002826:	60e2                	ld	ra,24(sp)
    80002828:	6442                	ld	s0,16(sp)
    8000282a:	64a2                	ld	s1,8(sp)
    8000282c:	6902                	ld	s2,0(sp)
    8000282e:	6105                	addi	sp,sp,32
    80002830:	8082                	ret

0000000080002832 <syscall>:
    [SYS_close] sys_close,
    [SYS_get_keystrokes_count] sys_get_keystrokes_count,
};

void syscall(void)
{
    80002832:	1101                	addi	sp,sp,-32
    80002834:	ec06                	sd	ra,24(sp)
    80002836:	e822                	sd	s0,16(sp)
    80002838:	e426                	sd	s1,8(sp)
    8000283a:	e04a                	sd	s2,0(sp)
    8000283c:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    8000283e:	8e2ff0ef          	jal	80001920 <myproc>
    80002842:	84aa                	mv	s1,a0

  num = p->trapframe->a7; // syscall number (RISC-V ABI)
    80002844:	05853903          	ld	s2,88(a0)
    80002848:	0a893783          	ld	a5,168(s2)
    8000284c:	0007869b          	sext.w	a3,a5
  if (num > 0 && num < (int)(sizeof(syscalls) / sizeof(syscalls[0])) && syscalls[num])
    80002850:	37fd                	addiw	a5,a5,-1
    80002852:	4755                	li	a4,21
    80002854:	00f76f63          	bltu	a4,a5,80002872 <syscall+0x40>
    80002858:	00369713          	slli	a4,a3,0x3
    8000285c:	00005797          	auipc	a5,0x5
    80002860:	f7478793          	addi	a5,a5,-140 # 800077d0 <syscalls>
    80002864:	97ba                	add	a5,a5,a4
    80002866:	639c                	ld	a5,0(a5)
    80002868:	c385                	beqz	a5,80002888 <syscall+0x56>
  {
    p->trapframe->a0 = syscalls[num]();
    8000286a:	9782                	jalr	a5
    8000286c:	06a93823          	sd	a0,112(s2)
    80002870:	a031                	j	8000287c <syscall+0x4a>
  }
  else
  {
    if (num > 0)
    80002872:	00d04b63          	bgtz	a3,80002888 <syscall+0x56>
    {
      printf("%d %s: unknown sys call %d\n", p->pid, p->name, num);
    }
    p->trapframe->a0 = -1;
    80002876:	6cbc                	ld	a5,88(s1)
    80002878:	577d                	li	a4,-1
    8000287a:	fbb8                	sd	a4,112(a5)
  }
}
    8000287c:	60e2                	ld	ra,24(sp)
    8000287e:	6442                	ld	s0,16(sp)
    80002880:	64a2                	ld	s1,8(sp)
    80002882:	6902                	ld	s2,0(sp)
    80002884:	6105                	addi	sp,sp,32
    80002886:	8082                	ret
      printf("%d %s: unknown sys call %d\n", p->pid, p->name, num);
    80002888:	15848613          	addi	a2,s1,344
    8000288c:	588c                	lw	a1,48(s1)
    8000288e:	00005517          	auipc	a0,0x5
    80002892:	b8250513          	addi	a0,a0,-1150 # 80007410 <etext+0x410>
    80002896:	c7dfd0ef          	jal	80000512 <printf>
    8000289a:	bff1                	j	80002876 <syscall+0x44>

000000008000289c <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000289c:	1101                	addi	sp,sp,-32
    8000289e:	ec06                	sd	ra,24(sp)
    800028a0:	e822                	sd	s0,16(sp)
    800028a2:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    800028a4:	fec40593          	addi	a1,s0,-20
    800028a8:	4501                	li	a0,0
    800028aa:	f29ff0ef          	jal	800027d2 <argint>
  exit(n);
    800028ae:	fec42503          	lw	a0,-20(s0)
    800028b2:	f48ff0ef          	jal	80001ffa <exit>
  return 0; // not reached
}
    800028b6:	4501                	li	a0,0
    800028b8:	60e2                	ld	ra,24(sp)
    800028ba:	6442                	ld	s0,16(sp)
    800028bc:	6105                	addi	sp,sp,32
    800028be:	8082                	ret

00000000800028c0 <sys_getpid>:

uint64
sys_getpid(void)
{
    800028c0:	1141                	addi	sp,sp,-16
    800028c2:	e406                	sd	ra,8(sp)
    800028c4:	e022                	sd	s0,0(sp)
    800028c6:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800028c8:	858ff0ef          	jal	80001920 <myproc>
}
    800028cc:	5908                	lw	a0,48(a0)
    800028ce:	60a2                	ld	ra,8(sp)
    800028d0:	6402                	ld	s0,0(sp)
    800028d2:	0141                	addi	sp,sp,16
    800028d4:	8082                	ret

00000000800028d6 <sys_fork>:

uint64
sys_fork(void)
{
    800028d6:	1141                	addi	sp,sp,-16
    800028d8:	e406                	sd	ra,8(sp)
    800028da:	e022                	sd	s0,0(sp)
    800028dc:	0800                	addi	s0,sp,16
  return fork();
    800028de:	b68ff0ef          	jal	80001c46 <fork>
}
    800028e2:	60a2                	ld	ra,8(sp)
    800028e4:	6402                	ld	s0,0(sp)
    800028e6:	0141                	addi	sp,sp,16
    800028e8:	8082                	ret

00000000800028ea <sys_wait>:

uint64
sys_wait(void)
{
    800028ea:	1101                	addi	sp,sp,-32
    800028ec:	ec06                	sd	ra,24(sp)
    800028ee:	e822                	sd	s0,16(sp)
    800028f0:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    800028f2:	fe840593          	addi	a1,s0,-24
    800028f6:	4501                	li	a0,0
    800028f8:	ef7ff0ef          	jal	800027ee <argaddr>
  return wait(p);
    800028fc:	fe843503          	ld	a0,-24(s0)
    80002900:	851ff0ef          	jal	80002150 <wait>
}
    80002904:	60e2                	ld	ra,24(sp)
    80002906:	6442                	ld	s0,16(sp)
    80002908:	6105                	addi	sp,sp,32
    8000290a:	8082                	ret

000000008000290c <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000290c:	7179                	addi	sp,sp,-48
    8000290e:	f406                	sd	ra,40(sp)
    80002910:	f022                	sd	s0,32(sp)
    80002912:	ec26                	sd	s1,24(sp)
    80002914:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    80002916:	fdc40593          	addi	a1,s0,-36
    8000291a:	4501                	li	a0,0
    8000291c:	eb7ff0ef          	jal	800027d2 <argint>
  addr = myproc()->sz;
    80002920:	800ff0ef          	jal	80001920 <myproc>
    80002924:	6524                	ld	s1,72(a0)
  if (growproc(n) < 0)
    80002926:	fdc42503          	lw	a0,-36(s0)
    8000292a:	accff0ef          	jal	80001bf6 <growproc>
    8000292e:	00054863          	bltz	a0,8000293e <sys_sbrk+0x32>
    return -1;
  return addr;
}
    80002932:	8526                	mv	a0,s1
    80002934:	70a2                	ld	ra,40(sp)
    80002936:	7402                	ld	s0,32(sp)
    80002938:	64e2                	ld	s1,24(sp)
    8000293a:	6145                	addi	sp,sp,48
    8000293c:	8082                	ret
    return -1;
    8000293e:	54fd                	li	s1,-1
    80002940:	bfcd                	j	80002932 <sys_sbrk+0x26>

0000000080002942 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002942:	7139                	addi	sp,sp,-64
    80002944:	fc06                	sd	ra,56(sp)
    80002946:	f822                	sd	s0,48(sp)
    80002948:	f04a                	sd	s2,32(sp)
    8000294a:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    8000294c:	fcc40593          	addi	a1,s0,-52
    80002950:	4501                	li	a0,0
    80002952:	e81ff0ef          	jal	800027d2 <argint>
  if (n < 0)
    80002956:	fcc42783          	lw	a5,-52(s0)
    8000295a:	0607c763          	bltz	a5,800029c8 <sys_sleep+0x86>
    n = 0;
  acquire(&tickslock);
    8000295e:	00016517          	auipc	a0,0x16
    80002962:	92250513          	addi	a0,a0,-1758 # 80018280 <tickslock>
    80002966:	adcfe0ef          	jal	80000c42 <acquire>
  ticks0 = ticks;
    8000296a:	00008917          	auipc	s2,0x8
    8000296e:	9be92903          	lw	s2,-1602(s2) # 8000a328 <ticks>
  while (ticks - ticks0 < n)
    80002972:	fcc42783          	lw	a5,-52(s0)
    80002976:	cf8d                	beqz	a5,800029b0 <sys_sleep+0x6e>
    80002978:	f426                	sd	s1,40(sp)
    8000297a:	ec4e                	sd	s3,24(sp)
    if (killed(myproc()))
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    8000297c:	00016997          	auipc	s3,0x16
    80002980:	90498993          	addi	s3,s3,-1788 # 80018280 <tickslock>
    80002984:	00008497          	auipc	s1,0x8
    80002988:	9a448493          	addi	s1,s1,-1628 # 8000a328 <ticks>
    if (killed(myproc()))
    8000298c:	f95fe0ef          	jal	80001920 <myproc>
    80002990:	f96ff0ef          	jal	80002126 <killed>
    80002994:	ed0d                	bnez	a0,800029ce <sys_sleep+0x8c>
    sleep(&ticks, &tickslock);
    80002996:	85ce                	mv	a1,s3
    80002998:	8526                	mv	a0,s1
    8000299a:	d54ff0ef          	jal	80001eee <sleep>
  while (ticks - ticks0 < n)
    8000299e:	409c                	lw	a5,0(s1)
    800029a0:	412787bb          	subw	a5,a5,s2
    800029a4:	fcc42703          	lw	a4,-52(s0)
    800029a8:	fee7e2e3          	bltu	a5,a4,8000298c <sys_sleep+0x4a>
    800029ac:	74a2                	ld	s1,40(sp)
    800029ae:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    800029b0:	00016517          	auipc	a0,0x16
    800029b4:	8d050513          	addi	a0,a0,-1840 # 80018280 <tickslock>
    800029b8:	b1efe0ef          	jal	80000cd6 <release>
  return 0;
    800029bc:	4501                	li	a0,0
}
    800029be:	70e2                	ld	ra,56(sp)
    800029c0:	7442                	ld	s0,48(sp)
    800029c2:	7902                	ld	s2,32(sp)
    800029c4:	6121                	addi	sp,sp,64
    800029c6:	8082                	ret
    n = 0;
    800029c8:	fc042623          	sw	zero,-52(s0)
    800029cc:	bf49                	j	8000295e <sys_sleep+0x1c>
      release(&tickslock);
    800029ce:	00016517          	auipc	a0,0x16
    800029d2:	8b250513          	addi	a0,a0,-1870 # 80018280 <tickslock>
    800029d6:	b00fe0ef          	jal	80000cd6 <release>
      return -1;
    800029da:	557d                	li	a0,-1
    800029dc:	74a2                	ld	s1,40(sp)
    800029de:	69e2                	ld	s3,24(sp)
    800029e0:	bff9                	j	800029be <sys_sleep+0x7c>

00000000800029e2 <sys_kill>:

uint64
sys_kill(void)
{
    800029e2:	1101                	addi	sp,sp,-32
    800029e4:	ec06                	sd	ra,24(sp)
    800029e6:	e822                	sd	s0,16(sp)
    800029e8:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800029ea:	fec40593          	addi	a1,s0,-20
    800029ee:	4501                	li	a0,0
    800029f0:	de3ff0ef          	jal	800027d2 <argint>
  return kill(pid);
    800029f4:	fec42503          	lw	a0,-20(s0)
    800029f8:	ea4ff0ef          	jal	8000209c <kill>
}
    800029fc:	60e2                	ld	ra,24(sp)
    800029fe:	6442                	ld	s0,16(sp)
    80002a00:	6105                	addi	sp,sp,32
    80002a02:	8082                	ret

0000000080002a04 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002a04:	1101                	addi	sp,sp,-32
    80002a06:	ec06                	sd	ra,24(sp)
    80002a08:	e822                	sd	s0,16(sp)
    80002a0a:	e426                	sd	s1,8(sp)
    80002a0c:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002a0e:	00016517          	auipc	a0,0x16
    80002a12:	87250513          	addi	a0,a0,-1934 # 80018280 <tickslock>
    80002a16:	a2cfe0ef          	jal	80000c42 <acquire>
  xticks = ticks;
    80002a1a:	00008497          	auipc	s1,0x8
    80002a1e:	90e4a483          	lw	s1,-1778(s1) # 8000a328 <ticks>
  release(&tickslock);
    80002a22:	00016517          	auipc	a0,0x16
    80002a26:	85e50513          	addi	a0,a0,-1954 # 80018280 <tickslock>
    80002a2a:	aacfe0ef          	jal	80000cd6 <release>
  return xticks;
}
    80002a2e:	02049513          	slli	a0,s1,0x20
    80002a32:	9101                	srli	a0,a0,0x20
    80002a34:	60e2                	ld	ra,24(sp)
    80002a36:	6442                	ld	s0,16(sp)
    80002a38:	64a2                	ld	s1,8(sp)
    80002a3a:	6105                	addi	sp,sp,32
    80002a3c:	8082                	ret

0000000080002a3e <sys_get_keystrokes_count>:

uint64
sys_get_keystrokes_count(void)
{
    80002a3e:	1141                	addi	sp,sp,-16
    80002a40:	e406                	sd	ra,8(sp)
    80002a42:	e022                	sd	s0,0(sp)
    80002a44:	0800                	addi	s0,sp,16
  return get_keystrokes_count();
    80002a46:	a0dfd0ef          	jal	80000452 <get_keystrokes_count>
}
    80002a4a:	60a2                	ld	ra,8(sp)
    80002a4c:	6402                	ld	s0,0(sp)
    80002a4e:	0141                	addi	sp,sp,16
    80002a50:	8082                	ret

0000000080002a52 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002a52:	7179                	addi	sp,sp,-48
    80002a54:	f406                	sd	ra,40(sp)
    80002a56:	f022                	sd	s0,32(sp)
    80002a58:	ec26                	sd	s1,24(sp)
    80002a5a:	e84a                	sd	s2,16(sp)
    80002a5c:	e44e                	sd	s3,8(sp)
    80002a5e:	e052                	sd	s4,0(sp)
    80002a60:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002a62:	00005597          	auipc	a1,0x5
    80002a66:	9ce58593          	addi	a1,a1,-1586 # 80007430 <etext+0x430>
    80002a6a:	00016517          	auipc	a0,0x16
    80002a6e:	82e50513          	addi	a0,a0,-2002 # 80018298 <bcache>
    80002a72:	94cfe0ef          	jal	80000bbe <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002a76:	0001e797          	auipc	a5,0x1e
    80002a7a:	82278793          	addi	a5,a5,-2014 # 80020298 <bcache+0x8000>
    80002a7e:	0001e717          	auipc	a4,0x1e
    80002a82:	a8270713          	addi	a4,a4,-1406 # 80020500 <bcache+0x8268>
    80002a86:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002a8a:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002a8e:	00016497          	auipc	s1,0x16
    80002a92:	82248493          	addi	s1,s1,-2014 # 800182b0 <bcache+0x18>
    b->next = bcache.head.next;
    80002a96:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002a98:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002a9a:	00005a17          	auipc	s4,0x5
    80002a9e:	99ea0a13          	addi	s4,s4,-1634 # 80007438 <etext+0x438>
    b->next = bcache.head.next;
    80002aa2:	2b893783          	ld	a5,696(s2)
    80002aa6:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002aa8:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002aac:	85d2                	mv	a1,s4
    80002aae:	01048513          	addi	a0,s1,16
    80002ab2:	244010ef          	jal	80003cf6 <initsleeplock>
    bcache.head.next->prev = b;
    80002ab6:	2b893783          	ld	a5,696(s2)
    80002aba:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002abc:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002ac0:	45848493          	addi	s1,s1,1112
    80002ac4:	fd349fe3          	bne	s1,s3,80002aa2 <binit+0x50>
  }
}
    80002ac8:	70a2                	ld	ra,40(sp)
    80002aca:	7402                	ld	s0,32(sp)
    80002acc:	64e2                	ld	s1,24(sp)
    80002ace:	6942                	ld	s2,16(sp)
    80002ad0:	69a2                	ld	s3,8(sp)
    80002ad2:	6a02                	ld	s4,0(sp)
    80002ad4:	6145                	addi	sp,sp,48
    80002ad6:	8082                	ret

0000000080002ad8 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002ad8:	7179                	addi	sp,sp,-48
    80002ada:	f406                	sd	ra,40(sp)
    80002adc:	f022                	sd	s0,32(sp)
    80002ade:	ec26                	sd	s1,24(sp)
    80002ae0:	e84a                	sd	s2,16(sp)
    80002ae2:	e44e                	sd	s3,8(sp)
    80002ae4:	1800                	addi	s0,sp,48
    80002ae6:	892a                	mv	s2,a0
    80002ae8:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002aea:	00015517          	auipc	a0,0x15
    80002aee:	7ae50513          	addi	a0,a0,1966 # 80018298 <bcache>
    80002af2:	950fe0ef          	jal	80000c42 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002af6:	0001e497          	auipc	s1,0x1e
    80002afa:	a5a4b483          	ld	s1,-1446(s1) # 80020550 <bcache+0x82b8>
    80002afe:	0001e797          	auipc	a5,0x1e
    80002b02:	a0278793          	addi	a5,a5,-1534 # 80020500 <bcache+0x8268>
    80002b06:	02f48b63          	beq	s1,a5,80002b3c <bread+0x64>
    80002b0a:	873e                	mv	a4,a5
    80002b0c:	a021                	j	80002b14 <bread+0x3c>
    80002b0e:	68a4                	ld	s1,80(s1)
    80002b10:	02e48663          	beq	s1,a4,80002b3c <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    80002b14:	449c                	lw	a5,8(s1)
    80002b16:	ff279ce3          	bne	a5,s2,80002b0e <bread+0x36>
    80002b1a:	44dc                	lw	a5,12(s1)
    80002b1c:	ff3799e3          	bne	a5,s3,80002b0e <bread+0x36>
      b->refcnt++;
    80002b20:	40bc                	lw	a5,64(s1)
    80002b22:	2785                	addiw	a5,a5,1
    80002b24:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002b26:	00015517          	auipc	a0,0x15
    80002b2a:	77250513          	addi	a0,a0,1906 # 80018298 <bcache>
    80002b2e:	9a8fe0ef          	jal	80000cd6 <release>
      acquiresleep(&b->lock);
    80002b32:	01048513          	addi	a0,s1,16
    80002b36:	1f6010ef          	jal	80003d2c <acquiresleep>
      return b;
    80002b3a:	a889                	j	80002b8c <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002b3c:	0001e497          	auipc	s1,0x1e
    80002b40:	a0c4b483          	ld	s1,-1524(s1) # 80020548 <bcache+0x82b0>
    80002b44:	0001e797          	auipc	a5,0x1e
    80002b48:	9bc78793          	addi	a5,a5,-1604 # 80020500 <bcache+0x8268>
    80002b4c:	00f48863          	beq	s1,a5,80002b5c <bread+0x84>
    80002b50:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002b52:	40bc                	lw	a5,64(s1)
    80002b54:	cb91                	beqz	a5,80002b68 <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002b56:	64a4                	ld	s1,72(s1)
    80002b58:	fee49de3          	bne	s1,a4,80002b52 <bread+0x7a>
  panic("bget: no buffers");
    80002b5c:	00005517          	auipc	a0,0x5
    80002b60:	8e450513          	addi	a0,a0,-1820 # 80007440 <etext+0x440>
    80002b64:	c7ffd0ef          	jal	800007e2 <panic>
      b->dev = dev;
    80002b68:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002b6c:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002b70:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002b74:	4785                	li	a5,1
    80002b76:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002b78:	00015517          	auipc	a0,0x15
    80002b7c:	72050513          	addi	a0,a0,1824 # 80018298 <bcache>
    80002b80:	956fe0ef          	jal	80000cd6 <release>
      acquiresleep(&b->lock);
    80002b84:	01048513          	addi	a0,s1,16
    80002b88:	1a4010ef          	jal	80003d2c <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002b8c:	409c                	lw	a5,0(s1)
    80002b8e:	cb89                	beqz	a5,80002ba0 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002b90:	8526                	mv	a0,s1
    80002b92:	70a2                	ld	ra,40(sp)
    80002b94:	7402                	ld	s0,32(sp)
    80002b96:	64e2                	ld	s1,24(sp)
    80002b98:	6942                	ld	s2,16(sp)
    80002b9a:	69a2                	ld	s3,8(sp)
    80002b9c:	6145                	addi	sp,sp,48
    80002b9e:	8082                	ret
    virtio_disk_rw(b, 0);
    80002ba0:	4581                	li	a1,0
    80002ba2:	8526                	mv	a0,s1
    80002ba4:	1fd020ef          	jal	800055a0 <virtio_disk_rw>
    b->valid = 1;
    80002ba8:	4785                	li	a5,1
    80002baa:	c09c                	sw	a5,0(s1)
  return b;
    80002bac:	b7d5                	j	80002b90 <bread+0xb8>

0000000080002bae <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002bae:	1101                	addi	sp,sp,-32
    80002bb0:	ec06                	sd	ra,24(sp)
    80002bb2:	e822                	sd	s0,16(sp)
    80002bb4:	e426                	sd	s1,8(sp)
    80002bb6:	1000                	addi	s0,sp,32
    80002bb8:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002bba:	0541                	addi	a0,a0,16
    80002bbc:	1ee010ef          	jal	80003daa <holdingsleep>
    80002bc0:	c911                	beqz	a0,80002bd4 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002bc2:	4585                	li	a1,1
    80002bc4:	8526                	mv	a0,s1
    80002bc6:	1db020ef          	jal	800055a0 <virtio_disk_rw>
}
    80002bca:	60e2                	ld	ra,24(sp)
    80002bcc:	6442                	ld	s0,16(sp)
    80002bce:	64a2                	ld	s1,8(sp)
    80002bd0:	6105                	addi	sp,sp,32
    80002bd2:	8082                	ret
    panic("bwrite");
    80002bd4:	00005517          	auipc	a0,0x5
    80002bd8:	88450513          	addi	a0,a0,-1916 # 80007458 <etext+0x458>
    80002bdc:	c07fd0ef          	jal	800007e2 <panic>

0000000080002be0 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002be0:	1101                	addi	sp,sp,-32
    80002be2:	ec06                	sd	ra,24(sp)
    80002be4:	e822                	sd	s0,16(sp)
    80002be6:	e426                	sd	s1,8(sp)
    80002be8:	e04a                	sd	s2,0(sp)
    80002bea:	1000                	addi	s0,sp,32
    80002bec:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002bee:	01050913          	addi	s2,a0,16
    80002bf2:	854a                	mv	a0,s2
    80002bf4:	1b6010ef          	jal	80003daa <holdingsleep>
    80002bf8:	c125                	beqz	a0,80002c58 <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    80002bfa:	854a                	mv	a0,s2
    80002bfc:	176010ef          	jal	80003d72 <releasesleep>

  acquire(&bcache.lock);
    80002c00:	00015517          	auipc	a0,0x15
    80002c04:	69850513          	addi	a0,a0,1688 # 80018298 <bcache>
    80002c08:	83afe0ef          	jal	80000c42 <acquire>
  b->refcnt--;
    80002c0c:	40bc                	lw	a5,64(s1)
    80002c0e:	37fd                	addiw	a5,a5,-1
    80002c10:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002c12:	e79d                	bnez	a5,80002c40 <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002c14:	68b8                	ld	a4,80(s1)
    80002c16:	64bc                	ld	a5,72(s1)
    80002c18:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    80002c1a:	68b8                	ld	a4,80(s1)
    80002c1c:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002c1e:	0001d797          	auipc	a5,0x1d
    80002c22:	67a78793          	addi	a5,a5,1658 # 80020298 <bcache+0x8000>
    80002c26:	2b87b703          	ld	a4,696(a5)
    80002c2a:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002c2c:	0001e717          	auipc	a4,0x1e
    80002c30:	8d470713          	addi	a4,a4,-1836 # 80020500 <bcache+0x8268>
    80002c34:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002c36:	2b87b703          	ld	a4,696(a5)
    80002c3a:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002c3c:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80002c40:	00015517          	auipc	a0,0x15
    80002c44:	65850513          	addi	a0,a0,1624 # 80018298 <bcache>
    80002c48:	88efe0ef          	jal	80000cd6 <release>
}
    80002c4c:	60e2                	ld	ra,24(sp)
    80002c4e:	6442                	ld	s0,16(sp)
    80002c50:	64a2                	ld	s1,8(sp)
    80002c52:	6902                	ld	s2,0(sp)
    80002c54:	6105                	addi	sp,sp,32
    80002c56:	8082                	ret
    panic("brelse");
    80002c58:	00005517          	auipc	a0,0x5
    80002c5c:	80850513          	addi	a0,a0,-2040 # 80007460 <etext+0x460>
    80002c60:	b83fd0ef          	jal	800007e2 <panic>

0000000080002c64 <bpin>:

void
bpin(struct buf *b) {
    80002c64:	1101                	addi	sp,sp,-32
    80002c66:	ec06                	sd	ra,24(sp)
    80002c68:	e822                	sd	s0,16(sp)
    80002c6a:	e426                	sd	s1,8(sp)
    80002c6c:	1000                	addi	s0,sp,32
    80002c6e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002c70:	00015517          	auipc	a0,0x15
    80002c74:	62850513          	addi	a0,a0,1576 # 80018298 <bcache>
    80002c78:	fcbfd0ef          	jal	80000c42 <acquire>
  b->refcnt++;
    80002c7c:	40bc                	lw	a5,64(s1)
    80002c7e:	2785                	addiw	a5,a5,1
    80002c80:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002c82:	00015517          	auipc	a0,0x15
    80002c86:	61650513          	addi	a0,a0,1558 # 80018298 <bcache>
    80002c8a:	84cfe0ef          	jal	80000cd6 <release>
}
    80002c8e:	60e2                	ld	ra,24(sp)
    80002c90:	6442                	ld	s0,16(sp)
    80002c92:	64a2                	ld	s1,8(sp)
    80002c94:	6105                	addi	sp,sp,32
    80002c96:	8082                	ret

0000000080002c98 <bunpin>:

void
bunpin(struct buf *b) {
    80002c98:	1101                	addi	sp,sp,-32
    80002c9a:	ec06                	sd	ra,24(sp)
    80002c9c:	e822                	sd	s0,16(sp)
    80002c9e:	e426                	sd	s1,8(sp)
    80002ca0:	1000                	addi	s0,sp,32
    80002ca2:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002ca4:	00015517          	auipc	a0,0x15
    80002ca8:	5f450513          	addi	a0,a0,1524 # 80018298 <bcache>
    80002cac:	f97fd0ef          	jal	80000c42 <acquire>
  b->refcnt--;
    80002cb0:	40bc                	lw	a5,64(s1)
    80002cb2:	37fd                	addiw	a5,a5,-1
    80002cb4:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002cb6:	00015517          	auipc	a0,0x15
    80002cba:	5e250513          	addi	a0,a0,1506 # 80018298 <bcache>
    80002cbe:	818fe0ef          	jal	80000cd6 <release>
}
    80002cc2:	60e2                	ld	ra,24(sp)
    80002cc4:	6442                	ld	s0,16(sp)
    80002cc6:	64a2                	ld	s1,8(sp)
    80002cc8:	6105                	addi	sp,sp,32
    80002cca:	8082                	ret

0000000080002ccc <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002ccc:	1101                	addi	sp,sp,-32
    80002cce:	ec06                	sd	ra,24(sp)
    80002cd0:	e822                	sd	s0,16(sp)
    80002cd2:	e426                	sd	s1,8(sp)
    80002cd4:	e04a                	sd	s2,0(sp)
    80002cd6:	1000                	addi	s0,sp,32
    80002cd8:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002cda:	00d5d79b          	srliw	a5,a1,0xd
    80002cde:	0001e597          	auipc	a1,0x1e
    80002ce2:	c965a583          	lw	a1,-874(a1) # 80020974 <sb+0x1c>
    80002ce6:	9dbd                	addw	a1,a1,a5
    80002ce8:	df1ff0ef          	jal	80002ad8 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002cec:	0074f713          	andi	a4,s1,7
    80002cf0:	4785                	li	a5,1
    80002cf2:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    80002cf6:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    80002cf8:	90d9                	srli	s1,s1,0x36
    80002cfa:	00950733          	add	a4,a0,s1
    80002cfe:	05874703          	lbu	a4,88(a4)
    80002d02:	00e7f6b3          	and	a3,a5,a4
    80002d06:	c29d                	beqz	a3,80002d2c <bfree+0x60>
    80002d08:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002d0a:	94aa                	add	s1,s1,a0
    80002d0c:	fff7c793          	not	a5,a5
    80002d10:	8f7d                	and	a4,a4,a5
    80002d12:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002d16:	711000ef          	jal	80003c26 <log_write>
  brelse(bp);
    80002d1a:	854a                	mv	a0,s2
    80002d1c:	ec5ff0ef          	jal	80002be0 <brelse>
}
    80002d20:	60e2                	ld	ra,24(sp)
    80002d22:	6442                	ld	s0,16(sp)
    80002d24:	64a2                	ld	s1,8(sp)
    80002d26:	6902                	ld	s2,0(sp)
    80002d28:	6105                	addi	sp,sp,32
    80002d2a:	8082                	ret
    panic("freeing free block");
    80002d2c:	00004517          	auipc	a0,0x4
    80002d30:	73c50513          	addi	a0,a0,1852 # 80007468 <etext+0x468>
    80002d34:	aaffd0ef          	jal	800007e2 <panic>

0000000080002d38 <balloc>:
{
    80002d38:	715d                	addi	sp,sp,-80
    80002d3a:	e486                	sd	ra,72(sp)
    80002d3c:	e0a2                	sd	s0,64(sp)
    80002d3e:	fc26                	sd	s1,56(sp)
    80002d40:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    80002d42:	0001e797          	auipc	a5,0x1e
    80002d46:	c1a7a783          	lw	a5,-998(a5) # 8002095c <sb+0x4>
    80002d4a:	0e078863          	beqz	a5,80002e3a <balloc+0x102>
    80002d4e:	f84a                	sd	s2,48(sp)
    80002d50:	f44e                	sd	s3,40(sp)
    80002d52:	f052                	sd	s4,32(sp)
    80002d54:	ec56                	sd	s5,24(sp)
    80002d56:	e85a                	sd	s6,16(sp)
    80002d58:	e45e                	sd	s7,8(sp)
    80002d5a:	e062                	sd	s8,0(sp)
    80002d5c:	8baa                	mv	s7,a0
    80002d5e:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002d60:	0001eb17          	auipc	s6,0x1e
    80002d64:	bf8b0b13          	addi	s6,s6,-1032 # 80020958 <sb>
      m = 1 << (bi % 8);
    80002d68:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002d6a:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002d6c:	6c09                	lui	s8,0x2
    80002d6e:	a09d                	j	80002dd4 <balloc+0x9c>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002d70:	97ca                	add	a5,a5,s2
    80002d72:	8e55                	or	a2,a2,a3
    80002d74:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002d78:	854a                	mv	a0,s2
    80002d7a:	6ad000ef          	jal	80003c26 <log_write>
        brelse(bp);
    80002d7e:	854a                	mv	a0,s2
    80002d80:	e61ff0ef          	jal	80002be0 <brelse>
  bp = bread(dev, bno);
    80002d84:	85a6                	mv	a1,s1
    80002d86:	855e                	mv	a0,s7
    80002d88:	d51ff0ef          	jal	80002ad8 <bread>
    80002d8c:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002d8e:	40000613          	li	a2,1024
    80002d92:	4581                	li	a1,0
    80002d94:	05850513          	addi	a0,a0,88
    80002d98:	f7bfd0ef          	jal	80000d12 <memset>
  log_write(bp);
    80002d9c:	854a                	mv	a0,s2
    80002d9e:	689000ef          	jal	80003c26 <log_write>
  brelse(bp);
    80002da2:	854a                	mv	a0,s2
    80002da4:	e3dff0ef          	jal	80002be0 <brelse>
}
    80002da8:	7942                	ld	s2,48(sp)
    80002daa:	79a2                	ld	s3,40(sp)
    80002dac:	7a02                	ld	s4,32(sp)
    80002dae:	6ae2                	ld	s5,24(sp)
    80002db0:	6b42                	ld	s6,16(sp)
    80002db2:	6ba2                	ld	s7,8(sp)
    80002db4:	6c02                	ld	s8,0(sp)
}
    80002db6:	8526                	mv	a0,s1
    80002db8:	60a6                	ld	ra,72(sp)
    80002dba:	6406                	ld	s0,64(sp)
    80002dbc:	74e2                	ld	s1,56(sp)
    80002dbe:	6161                	addi	sp,sp,80
    80002dc0:	8082                	ret
    brelse(bp);
    80002dc2:	854a                	mv	a0,s2
    80002dc4:	e1dff0ef          	jal	80002be0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002dc8:	015c0abb          	addw	s5,s8,s5
    80002dcc:	004b2783          	lw	a5,4(s6)
    80002dd0:	04fafe63          	bgeu	s5,a5,80002e2c <balloc+0xf4>
    bp = bread(dev, BBLOCK(b, sb));
    80002dd4:	41fad79b          	sraiw	a5,s5,0x1f
    80002dd8:	0137d79b          	srliw	a5,a5,0x13
    80002ddc:	015787bb          	addw	a5,a5,s5
    80002de0:	40d7d79b          	sraiw	a5,a5,0xd
    80002de4:	01cb2583          	lw	a1,28(s6)
    80002de8:	9dbd                	addw	a1,a1,a5
    80002dea:	855e                	mv	a0,s7
    80002dec:	cedff0ef          	jal	80002ad8 <bread>
    80002df0:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002df2:	004b2503          	lw	a0,4(s6)
    80002df6:	84d6                	mv	s1,s5
    80002df8:	4701                	li	a4,0
    80002dfa:	fca4f4e3          	bgeu	s1,a0,80002dc2 <balloc+0x8a>
      m = 1 << (bi % 8);
    80002dfe:	00777693          	andi	a3,a4,7
    80002e02:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002e06:	41f7579b          	sraiw	a5,a4,0x1f
    80002e0a:	01d7d79b          	srliw	a5,a5,0x1d
    80002e0e:	9fb9                	addw	a5,a5,a4
    80002e10:	4037d79b          	sraiw	a5,a5,0x3
    80002e14:	00f90633          	add	a2,s2,a5
    80002e18:	05864603          	lbu	a2,88(a2)
    80002e1c:	00c6f5b3          	and	a1,a3,a2
    80002e20:	d9a1                	beqz	a1,80002d70 <balloc+0x38>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002e22:	2705                	addiw	a4,a4,1
    80002e24:	2485                	addiw	s1,s1,1
    80002e26:	fd471ae3          	bne	a4,s4,80002dfa <balloc+0xc2>
    80002e2a:	bf61                	j	80002dc2 <balloc+0x8a>
    80002e2c:	7942                	ld	s2,48(sp)
    80002e2e:	79a2                	ld	s3,40(sp)
    80002e30:	7a02                	ld	s4,32(sp)
    80002e32:	6ae2                	ld	s5,24(sp)
    80002e34:	6b42                	ld	s6,16(sp)
    80002e36:	6ba2                	ld	s7,8(sp)
    80002e38:	6c02                	ld	s8,0(sp)
  printf("balloc: out of blocks\n");
    80002e3a:	00004517          	auipc	a0,0x4
    80002e3e:	64650513          	addi	a0,a0,1606 # 80007480 <etext+0x480>
    80002e42:	ed0fd0ef          	jal	80000512 <printf>
  return 0;
    80002e46:	4481                	li	s1,0
    80002e48:	b7bd                	j	80002db6 <balloc+0x7e>

0000000080002e4a <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    80002e4a:	7179                	addi	sp,sp,-48
    80002e4c:	f406                	sd	ra,40(sp)
    80002e4e:	f022                	sd	s0,32(sp)
    80002e50:	ec26                	sd	s1,24(sp)
    80002e52:	e84a                	sd	s2,16(sp)
    80002e54:	e44e                	sd	s3,8(sp)
    80002e56:	1800                	addi	s0,sp,48
    80002e58:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002e5a:	47ad                	li	a5,11
    80002e5c:	02b7e363          	bltu	a5,a1,80002e82 <bmap+0x38>
    if((addr = ip->addrs[bn]) == 0){
    80002e60:	02059793          	slli	a5,a1,0x20
    80002e64:	01e7d593          	srli	a1,a5,0x1e
    80002e68:	00b504b3          	add	s1,a0,a1
    80002e6c:	0504a903          	lw	s2,80(s1)
    80002e70:	06091363          	bnez	s2,80002ed6 <bmap+0x8c>
      addr = balloc(ip->dev);
    80002e74:	4108                	lw	a0,0(a0)
    80002e76:	ec3ff0ef          	jal	80002d38 <balloc>
    80002e7a:	892a                	mv	s2,a0
      if(addr == 0)
    80002e7c:	cd29                	beqz	a0,80002ed6 <bmap+0x8c>
        return 0;
      ip->addrs[bn] = addr;
    80002e7e:	c8a8                	sw	a0,80(s1)
    80002e80:	a899                	j	80002ed6 <bmap+0x8c>
    }
    return addr;
  }
  bn -= NDIRECT;
    80002e82:	ff45849b          	addiw	s1,a1,-12

  if(bn < NINDIRECT){
    80002e86:	0ff00793          	li	a5,255
    80002e8a:	0697e963          	bltu	a5,s1,80002efc <bmap+0xb2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002e8e:	08052903          	lw	s2,128(a0)
    80002e92:	00091b63          	bnez	s2,80002ea8 <bmap+0x5e>
      addr = balloc(ip->dev);
    80002e96:	4108                	lw	a0,0(a0)
    80002e98:	ea1ff0ef          	jal	80002d38 <balloc>
    80002e9c:	892a                	mv	s2,a0
      if(addr == 0)
    80002e9e:	cd05                	beqz	a0,80002ed6 <bmap+0x8c>
    80002ea0:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002ea2:	08a9a023          	sw	a0,128(s3)
    80002ea6:	a011                	j	80002eaa <bmap+0x60>
    80002ea8:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    80002eaa:	85ca                	mv	a1,s2
    80002eac:	0009a503          	lw	a0,0(s3)
    80002eb0:	c29ff0ef          	jal	80002ad8 <bread>
    80002eb4:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002eb6:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002eba:	02049713          	slli	a4,s1,0x20
    80002ebe:	01e75593          	srli	a1,a4,0x1e
    80002ec2:	00b784b3          	add	s1,a5,a1
    80002ec6:	0004a903          	lw	s2,0(s1)
    80002eca:	00090e63          	beqz	s2,80002ee6 <bmap+0x9c>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002ece:	8552                	mv	a0,s4
    80002ed0:	d11ff0ef          	jal	80002be0 <brelse>
    return addr;
    80002ed4:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002ed6:	854a                	mv	a0,s2
    80002ed8:	70a2                	ld	ra,40(sp)
    80002eda:	7402                	ld	s0,32(sp)
    80002edc:	64e2                	ld	s1,24(sp)
    80002ede:	6942                	ld	s2,16(sp)
    80002ee0:	69a2                	ld	s3,8(sp)
    80002ee2:	6145                	addi	sp,sp,48
    80002ee4:	8082                	ret
      addr = balloc(ip->dev);
    80002ee6:	0009a503          	lw	a0,0(s3)
    80002eea:	e4fff0ef          	jal	80002d38 <balloc>
    80002eee:	892a                	mv	s2,a0
      if(addr){
    80002ef0:	dd79                	beqz	a0,80002ece <bmap+0x84>
        a[bn] = addr;
    80002ef2:	c088                	sw	a0,0(s1)
        log_write(bp);
    80002ef4:	8552                	mv	a0,s4
    80002ef6:	531000ef          	jal	80003c26 <log_write>
    80002efa:	bfd1                	j	80002ece <bmap+0x84>
    80002efc:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    80002efe:	00004517          	auipc	a0,0x4
    80002f02:	59a50513          	addi	a0,a0,1434 # 80007498 <etext+0x498>
    80002f06:	8ddfd0ef          	jal	800007e2 <panic>

0000000080002f0a <iget>:
{
    80002f0a:	7179                	addi	sp,sp,-48
    80002f0c:	f406                	sd	ra,40(sp)
    80002f0e:	f022                	sd	s0,32(sp)
    80002f10:	ec26                	sd	s1,24(sp)
    80002f12:	e84a                	sd	s2,16(sp)
    80002f14:	e44e                	sd	s3,8(sp)
    80002f16:	e052                	sd	s4,0(sp)
    80002f18:	1800                	addi	s0,sp,48
    80002f1a:	89aa                	mv	s3,a0
    80002f1c:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002f1e:	0001e517          	auipc	a0,0x1e
    80002f22:	a5a50513          	addi	a0,a0,-1446 # 80020978 <itable>
    80002f26:	d1dfd0ef          	jal	80000c42 <acquire>
  empty = 0;
    80002f2a:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002f2c:	0001e497          	auipc	s1,0x1e
    80002f30:	a6448493          	addi	s1,s1,-1436 # 80020990 <itable+0x18>
    80002f34:	0001f697          	auipc	a3,0x1f
    80002f38:	4ec68693          	addi	a3,a3,1260 # 80022420 <log>
    80002f3c:	a039                	j	80002f4a <iget+0x40>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002f3e:	02090963          	beqz	s2,80002f70 <iget+0x66>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002f42:	08848493          	addi	s1,s1,136
    80002f46:	02d48863          	beq	s1,a3,80002f76 <iget+0x6c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002f4a:	449c                	lw	a5,8(s1)
    80002f4c:	fef059e3          	blez	a5,80002f3e <iget+0x34>
    80002f50:	4098                	lw	a4,0(s1)
    80002f52:	ff3716e3          	bne	a4,s3,80002f3e <iget+0x34>
    80002f56:	40d8                	lw	a4,4(s1)
    80002f58:	ff4713e3          	bne	a4,s4,80002f3e <iget+0x34>
      ip->ref++;
    80002f5c:	2785                	addiw	a5,a5,1
    80002f5e:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002f60:	0001e517          	auipc	a0,0x1e
    80002f64:	a1850513          	addi	a0,a0,-1512 # 80020978 <itable>
    80002f68:	d6ffd0ef          	jal	80000cd6 <release>
      return ip;
    80002f6c:	8926                	mv	s2,s1
    80002f6e:	a02d                	j	80002f98 <iget+0x8e>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002f70:	fbe9                	bnez	a5,80002f42 <iget+0x38>
      empty = ip;
    80002f72:	8926                	mv	s2,s1
    80002f74:	b7f9                	j	80002f42 <iget+0x38>
  if(empty == 0)
    80002f76:	02090a63          	beqz	s2,80002faa <iget+0xa0>
  ip->dev = dev;
    80002f7a:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002f7e:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002f82:	4785                	li	a5,1
    80002f84:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002f88:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002f8c:	0001e517          	auipc	a0,0x1e
    80002f90:	9ec50513          	addi	a0,a0,-1556 # 80020978 <itable>
    80002f94:	d43fd0ef          	jal	80000cd6 <release>
}
    80002f98:	854a                	mv	a0,s2
    80002f9a:	70a2                	ld	ra,40(sp)
    80002f9c:	7402                	ld	s0,32(sp)
    80002f9e:	64e2                	ld	s1,24(sp)
    80002fa0:	6942                	ld	s2,16(sp)
    80002fa2:	69a2                	ld	s3,8(sp)
    80002fa4:	6a02                	ld	s4,0(sp)
    80002fa6:	6145                	addi	sp,sp,48
    80002fa8:	8082                	ret
    panic("iget: no inodes");
    80002faa:	00004517          	auipc	a0,0x4
    80002fae:	50650513          	addi	a0,a0,1286 # 800074b0 <etext+0x4b0>
    80002fb2:	831fd0ef          	jal	800007e2 <panic>

0000000080002fb6 <fsinit>:
fsinit(int dev) {
    80002fb6:	7179                	addi	sp,sp,-48
    80002fb8:	f406                	sd	ra,40(sp)
    80002fba:	f022                	sd	s0,32(sp)
    80002fbc:	ec26                	sd	s1,24(sp)
    80002fbe:	e84a                	sd	s2,16(sp)
    80002fc0:	e44e                	sd	s3,8(sp)
    80002fc2:	1800                	addi	s0,sp,48
    80002fc4:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002fc6:	4585                	li	a1,1
    80002fc8:	b11ff0ef          	jal	80002ad8 <bread>
    80002fcc:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002fce:	0001e997          	auipc	s3,0x1e
    80002fd2:	98a98993          	addi	s3,s3,-1654 # 80020958 <sb>
    80002fd6:	02000613          	li	a2,32
    80002fda:	05850593          	addi	a1,a0,88
    80002fde:	854e                	mv	a0,s3
    80002fe0:	d97fd0ef          	jal	80000d76 <memmove>
  brelse(bp);
    80002fe4:	8526                	mv	a0,s1
    80002fe6:	bfbff0ef          	jal	80002be0 <brelse>
  if(sb.magic != FSMAGIC)
    80002fea:	0009a703          	lw	a4,0(s3)
    80002fee:	102037b7          	lui	a5,0x10203
    80002ff2:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002ff6:	02f71063          	bne	a4,a5,80003016 <fsinit+0x60>
  initlog(dev, &sb);
    80002ffa:	0001e597          	auipc	a1,0x1e
    80002ffe:	95e58593          	addi	a1,a1,-1698 # 80020958 <sb>
    80003002:	854a                	mv	a0,s2
    80003004:	215000ef          	jal	80003a18 <initlog>
}
    80003008:	70a2                	ld	ra,40(sp)
    8000300a:	7402                	ld	s0,32(sp)
    8000300c:	64e2                	ld	s1,24(sp)
    8000300e:	6942                	ld	s2,16(sp)
    80003010:	69a2                	ld	s3,8(sp)
    80003012:	6145                	addi	sp,sp,48
    80003014:	8082                	ret
    panic("invalid file system");
    80003016:	00004517          	auipc	a0,0x4
    8000301a:	4aa50513          	addi	a0,a0,1194 # 800074c0 <etext+0x4c0>
    8000301e:	fc4fd0ef          	jal	800007e2 <panic>

0000000080003022 <iinit>:
{
    80003022:	7179                	addi	sp,sp,-48
    80003024:	f406                	sd	ra,40(sp)
    80003026:	f022                	sd	s0,32(sp)
    80003028:	ec26                	sd	s1,24(sp)
    8000302a:	e84a                	sd	s2,16(sp)
    8000302c:	e44e                	sd	s3,8(sp)
    8000302e:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80003030:	00004597          	auipc	a1,0x4
    80003034:	4a858593          	addi	a1,a1,1192 # 800074d8 <etext+0x4d8>
    80003038:	0001e517          	auipc	a0,0x1e
    8000303c:	94050513          	addi	a0,a0,-1728 # 80020978 <itable>
    80003040:	b7ffd0ef          	jal	80000bbe <initlock>
  for(i = 0; i < NINODE; i++) {
    80003044:	0001e497          	auipc	s1,0x1e
    80003048:	95c48493          	addi	s1,s1,-1700 # 800209a0 <itable+0x28>
    8000304c:	0001f997          	auipc	s3,0x1f
    80003050:	3e498993          	addi	s3,s3,996 # 80022430 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80003054:	00004917          	auipc	s2,0x4
    80003058:	48c90913          	addi	s2,s2,1164 # 800074e0 <etext+0x4e0>
    8000305c:	85ca                	mv	a1,s2
    8000305e:	8526                	mv	a0,s1
    80003060:	497000ef          	jal	80003cf6 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80003064:	08848493          	addi	s1,s1,136
    80003068:	ff349ae3          	bne	s1,s3,8000305c <iinit+0x3a>
}
    8000306c:	70a2                	ld	ra,40(sp)
    8000306e:	7402                	ld	s0,32(sp)
    80003070:	64e2                	ld	s1,24(sp)
    80003072:	6942                	ld	s2,16(sp)
    80003074:	69a2                	ld	s3,8(sp)
    80003076:	6145                	addi	sp,sp,48
    80003078:	8082                	ret

000000008000307a <ialloc>:
{
    8000307a:	7139                	addi	sp,sp,-64
    8000307c:	fc06                	sd	ra,56(sp)
    8000307e:	f822                	sd	s0,48(sp)
    80003080:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80003082:	0001e717          	auipc	a4,0x1e
    80003086:	8e272703          	lw	a4,-1822(a4) # 80020964 <sb+0xc>
    8000308a:	4785                	li	a5,1
    8000308c:	06e7f063          	bgeu	a5,a4,800030ec <ialloc+0x72>
    80003090:	f426                	sd	s1,40(sp)
    80003092:	f04a                	sd	s2,32(sp)
    80003094:	ec4e                	sd	s3,24(sp)
    80003096:	e852                	sd	s4,16(sp)
    80003098:	e456                	sd	s5,8(sp)
    8000309a:	e05a                	sd	s6,0(sp)
    8000309c:	8aaa                	mv	s5,a0
    8000309e:	8b2e                	mv	s6,a1
    800030a0:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    800030a2:	0001ea17          	auipc	s4,0x1e
    800030a6:	8b6a0a13          	addi	s4,s4,-1866 # 80020958 <sb>
    800030aa:	00495593          	srli	a1,s2,0x4
    800030ae:	018a2783          	lw	a5,24(s4)
    800030b2:	9dbd                	addw	a1,a1,a5
    800030b4:	8556                	mv	a0,s5
    800030b6:	a23ff0ef          	jal	80002ad8 <bread>
    800030ba:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800030bc:	05850993          	addi	s3,a0,88
    800030c0:	00f97793          	andi	a5,s2,15
    800030c4:	079a                	slli	a5,a5,0x6
    800030c6:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800030c8:	00099783          	lh	a5,0(s3)
    800030cc:	cb9d                	beqz	a5,80003102 <ialloc+0x88>
    brelse(bp);
    800030ce:	b13ff0ef          	jal	80002be0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800030d2:	0905                	addi	s2,s2,1
    800030d4:	00ca2703          	lw	a4,12(s4)
    800030d8:	0009079b          	sext.w	a5,s2
    800030dc:	fce7e7e3          	bltu	a5,a4,800030aa <ialloc+0x30>
    800030e0:	74a2                	ld	s1,40(sp)
    800030e2:	7902                	ld	s2,32(sp)
    800030e4:	69e2                	ld	s3,24(sp)
    800030e6:	6a42                	ld	s4,16(sp)
    800030e8:	6aa2                	ld	s5,8(sp)
    800030ea:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    800030ec:	00004517          	auipc	a0,0x4
    800030f0:	3fc50513          	addi	a0,a0,1020 # 800074e8 <etext+0x4e8>
    800030f4:	c1efd0ef          	jal	80000512 <printf>
  return 0;
    800030f8:	4501                	li	a0,0
}
    800030fa:	70e2                	ld	ra,56(sp)
    800030fc:	7442                	ld	s0,48(sp)
    800030fe:	6121                	addi	sp,sp,64
    80003100:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    80003102:	04000613          	li	a2,64
    80003106:	4581                	li	a1,0
    80003108:	854e                	mv	a0,s3
    8000310a:	c09fd0ef          	jal	80000d12 <memset>
      dip->type = type;
    8000310e:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80003112:	8526                	mv	a0,s1
    80003114:	313000ef          	jal	80003c26 <log_write>
      brelse(bp);
    80003118:	8526                	mv	a0,s1
    8000311a:	ac7ff0ef          	jal	80002be0 <brelse>
      return iget(dev, inum);
    8000311e:	0009059b          	sext.w	a1,s2
    80003122:	8556                	mv	a0,s5
    80003124:	de7ff0ef          	jal	80002f0a <iget>
    80003128:	74a2                	ld	s1,40(sp)
    8000312a:	7902                	ld	s2,32(sp)
    8000312c:	69e2                	ld	s3,24(sp)
    8000312e:	6a42                	ld	s4,16(sp)
    80003130:	6aa2                	ld	s5,8(sp)
    80003132:	6b02                	ld	s6,0(sp)
    80003134:	b7d9                	j	800030fa <ialloc+0x80>

0000000080003136 <iupdate>:
{
    80003136:	1101                	addi	sp,sp,-32
    80003138:	ec06                	sd	ra,24(sp)
    8000313a:	e822                	sd	s0,16(sp)
    8000313c:	e426                	sd	s1,8(sp)
    8000313e:	e04a                	sd	s2,0(sp)
    80003140:	1000                	addi	s0,sp,32
    80003142:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003144:	415c                	lw	a5,4(a0)
    80003146:	0047d79b          	srliw	a5,a5,0x4
    8000314a:	0001e597          	auipc	a1,0x1e
    8000314e:	8265a583          	lw	a1,-2010(a1) # 80020970 <sb+0x18>
    80003152:	9dbd                	addw	a1,a1,a5
    80003154:	4108                	lw	a0,0(a0)
    80003156:	983ff0ef          	jal	80002ad8 <bread>
    8000315a:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000315c:	05850793          	addi	a5,a0,88
    80003160:	40d8                	lw	a4,4(s1)
    80003162:	8b3d                	andi	a4,a4,15
    80003164:	071a                	slli	a4,a4,0x6
    80003166:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80003168:	04449703          	lh	a4,68(s1)
    8000316c:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80003170:	04649703          	lh	a4,70(s1)
    80003174:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80003178:	04849703          	lh	a4,72(s1)
    8000317c:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80003180:	04a49703          	lh	a4,74(s1)
    80003184:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80003188:	44f8                	lw	a4,76(s1)
    8000318a:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    8000318c:	03400613          	li	a2,52
    80003190:	05048593          	addi	a1,s1,80
    80003194:	00c78513          	addi	a0,a5,12
    80003198:	bdffd0ef          	jal	80000d76 <memmove>
  log_write(bp);
    8000319c:	854a                	mv	a0,s2
    8000319e:	289000ef          	jal	80003c26 <log_write>
  brelse(bp);
    800031a2:	854a                	mv	a0,s2
    800031a4:	a3dff0ef          	jal	80002be0 <brelse>
}
    800031a8:	60e2                	ld	ra,24(sp)
    800031aa:	6442                	ld	s0,16(sp)
    800031ac:	64a2                	ld	s1,8(sp)
    800031ae:	6902                	ld	s2,0(sp)
    800031b0:	6105                	addi	sp,sp,32
    800031b2:	8082                	ret

00000000800031b4 <idup>:
{
    800031b4:	1101                	addi	sp,sp,-32
    800031b6:	ec06                	sd	ra,24(sp)
    800031b8:	e822                	sd	s0,16(sp)
    800031ba:	e426                	sd	s1,8(sp)
    800031bc:	1000                	addi	s0,sp,32
    800031be:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800031c0:	0001d517          	auipc	a0,0x1d
    800031c4:	7b850513          	addi	a0,a0,1976 # 80020978 <itable>
    800031c8:	a7bfd0ef          	jal	80000c42 <acquire>
  ip->ref++;
    800031cc:	449c                	lw	a5,8(s1)
    800031ce:	2785                	addiw	a5,a5,1
    800031d0:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800031d2:	0001d517          	auipc	a0,0x1d
    800031d6:	7a650513          	addi	a0,a0,1958 # 80020978 <itable>
    800031da:	afdfd0ef          	jal	80000cd6 <release>
}
    800031de:	8526                	mv	a0,s1
    800031e0:	60e2                	ld	ra,24(sp)
    800031e2:	6442                	ld	s0,16(sp)
    800031e4:	64a2                	ld	s1,8(sp)
    800031e6:	6105                	addi	sp,sp,32
    800031e8:	8082                	ret

00000000800031ea <ilock>:
{
    800031ea:	1101                	addi	sp,sp,-32
    800031ec:	ec06                	sd	ra,24(sp)
    800031ee:	e822                	sd	s0,16(sp)
    800031f0:	e426                	sd	s1,8(sp)
    800031f2:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    800031f4:	cd19                	beqz	a0,80003212 <ilock+0x28>
    800031f6:	84aa                	mv	s1,a0
    800031f8:	451c                	lw	a5,8(a0)
    800031fa:	00f05c63          	blez	a5,80003212 <ilock+0x28>
  acquiresleep(&ip->lock);
    800031fe:	0541                	addi	a0,a0,16
    80003200:	32d000ef          	jal	80003d2c <acquiresleep>
  if(ip->valid == 0){
    80003204:	40bc                	lw	a5,64(s1)
    80003206:	cf89                	beqz	a5,80003220 <ilock+0x36>
}
    80003208:	60e2                	ld	ra,24(sp)
    8000320a:	6442                	ld	s0,16(sp)
    8000320c:	64a2                	ld	s1,8(sp)
    8000320e:	6105                	addi	sp,sp,32
    80003210:	8082                	ret
    80003212:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80003214:	00004517          	auipc	a0,0x4
    80003218:	2ec50513          	addi	a0,a0,748 # 80007500 <etext+0x500>
    8000321c:	dc6fd0ef          	jal	800007e2 <panic>
    80003220:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80003222:	40dc                	lw	a5,4(s1)
    80003224:	0047d79b          	srliw	a5,a5,0x4
    80003228:	0001d597          	auipc	a1,0x1d
    8000322c:	7485a583          	lw	a1,1864(a1) # 80020970 <sb+0x18>
    80003230:	9dbd                	addw	a1,a1,a5
    80003232:	4088                	lw	a0,0(s1)
    80003234:	8a5ff0ef          	jal	80002ad8 <bread>
    80003238:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    8000323a:	05850593          	addi	a1,a0,88
    8000323e:	40dc                	lw	a5,4(s1)
    80003240:	8bbd                	andi	a5,a5,15
    80003242:	079a                	slli	a5,a5,0x6
    80003244:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80003246:	00059783          	lh	a5,0(a1)
    8000324a:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    8000324e:	00259783          	lh	a5,2(a1)
    80003252:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003256:	00459783          	lh	a5,4(a1)
    8000325a:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    8000325e:	00659783          	lh	a5,6(a1)
    80003262:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80003266:	459c                	lw	a5,8(a1)
    80003268:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    8000326a:	03400613          	li	a2,52
    8000326e:	05b1                	addi	a1,a1,12
    80003270:	05048513          	addi	a0,s1,80
    80003274:	b03fd0ef          	jal	80000d76 <memmove>
    brelse(bp);
    80003278:	854a                	mv	a0,s2
    8000327a:	967ff0ef          	jal	80002be0 <brelse>
    ip->valid = 1;
    8000327e:	4785                	li	a5,1
    80003280:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003282:	04449783          	lh	a5,68(s1)
    80003286:	c399                	beqz	a5,8000328c <ilock+0xa2>
    80003288:	6902                	ld	s2,0(sp)
    8000328a:	bfbd                	j	80003208 <ilock+0x1e>
      panic("ilock: no type");
    8000328c:	00004517          	auipc	a0,0x4
    80003290:	27c50513          	addi	a0,a0,636 # 80007508 <etext+0x508>
    80003294:	d4efd0ef          	jal	800007e2 <panic>

0000000080003298 <iunlock>:
{
    80003298:	1101                	addi	sp,sp,-32
    8000329a:	ec06                	sd	ra,24(sp)
    8000329c:	e822                	sd	s0,16(sp)
    8000329e:	e426                	sd	s1,8(sp)
    800032a0:	e04a                	sd	s2,0(sp)
    800032a2:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800032a4:	c505                	beqz	a0,800032cc <iunlock+0x34>
    800032a6:	84aa                	mv	s1,a0
    800032a8:	01050913          	addi	s2,a0,16
    800032ac:	854a                	mv	a0,s2
    800032ae:	2fd000ef          	jal	80003daa <holdingsleep>
    800032b2:	cd09                	beqz	a0,800032cc <iunlock+0x34>
    800032b4:	449c                	lw	a5,8(s1)
    800032b6:	00f05b63          	blez	a5,800032cc <iunlock+0x34>
  releasesleep(&ip->lock);
    800032ba:	854a                	mv	a0,s2
    800032bc:	2b7000ef          	jal	80003d72 <releasesleep>
}
    800032c0:	60e2                	ld	ra,24(sp)
    800032c2:	6442                	ld	s0,16(sp)
    800032c4:	64a2                	ld	s1,8(sp)
    800032c6:	6902                	ld	s2,0(sp)
    800032c8:	6105                	addi	sp,sp,32
    800032ca:	8082                	ret
    panic("iunlock");
    800032cc:	00004517          	auipc	a0,0x4
    800032d0:	24c50513          	addi	a0,a0,588 # 80007518 <etext+0x518>
    800032d4:	d0efd0ef          	jal	800007e2 <panic>

00000000800032d8 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    800032d8:	7179                	addi	sp,sp,-48
    800032da:	f406                	sd	ra,40(sp)
    800032dc:	f022                	sd	s0,32(sp)
    800032de:	ec26                	sd	s1,24(sp)
    800032e0:	e84a                	sd	s2,16(sp)
    800032e2:	e44e                	sd	s3,8(sp)
    800032e4:	1800                	addi	s0,sp,48
    800032e6:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800032e8:	05050493          	addi	s1,a0,80
    800032ec:	08050913          	addi	s2,a0,128
    800032f0:	a021                	j	800032f8 <itrunc+0x20>
    800032f2:	0491                	addi	s1,s1,4
    800032f4:	01248b63          	beq	s1,s2,8000330a <itrunc+0x32>
    if(ip->addrs[i]){
    800032f8:	408c                	lw	a1,0(s1)
    800032fa:	dde5                	beqz	a1,800032f2 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    800032fc:	0009a503          	lw	a0,0(s3)
    80003300:	9cdff0ef          	jal	80002ccc <bfree>
      ip->addrs[i] = 0;
    80003304:	0004a023          	sw	zero,0(s1)
    80003308:	b7ed                	j	800032f2 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000330a:	0809a583          	lw	a1,128(s3)
    8000330e:	ed89                	bnez	a1,80003328 <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80003310:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80003314:	854e                	mv	a0,s3
    80003316:	e21ff0ef          	jal	80003136 <iupdate>
}
    8000331a:	70a2                	ld	ra,40(sp)
    8000331c:	7402                	ld	s0,32(sp)
    8000331e:	64e2                	ld	s1,24(sp)
    80003320:	6942                	ld	s2,16(sp)
    80003322:	69a2                	ld	s3,8(sp)
    80003324:	6145                	addi	sp,sp,48
    80003326:	8082                	ret
    80003328:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    8000332a:	0009a503          	lw	a0,0(s3)
    8000332e:	faaff0ef          	jal	80002ad8 <bread>
    80003332:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003334:	05850493          	addi	s1,a0,88
    80003338:	45850913          	addi	s2,a0,1112
    8000333c:	a021                	j	80003344 <itrunc+0x6c>
    8000333e:	0491                	addi	s1,s1,4
    80003340:	01248963          	beq	s1,s2,80003352 <itrunc+0x7a>
      if(a[j])
    80003344:	408c                	lw	a1,0(s1)
    80003346:	dde5                	beqz	a1,8000333e <itrunc+0x66>
        bfree(ip->dev, a[j]);
    80003348:	0009a503          	lw	a0,0(s3)
    8000334c:	981ff0ef          	jal	80002ccc <bfree>
    80003350:	b7fd                	j	8000333e <itrunc+0x66>
    brelse(bp);
    80003352:	8552                	mv	a0,s4
    80003354:	88dff0ef          	jal	80002be0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80003358:	0809a583          	lw	a1,128(s3)
    8000335c:	0009a503          	lw	a0,0(s3)
    80003360:	96dff0ef          	jal	80002ccc <bfree>
    ip->addrs[NDIRECT] = 0;
    80003364:	0809a023          	sw	zero,128(s3)
    80003368:	6a02                	ld	s4,0(sp)
    8000336a:	b75d                	j	80003310 <itrunc+0x38>

000000008000336c <iput>:
{
    8000336c:	1101                	addi	sp,sp,-32
    8000336e:	ec06                	sd	ra,24(sp)
    80003370:	e822                	sd	s0,16(sp)
    80003372:	e426                	sd	s1,8(sp)
    80003374:	1000                	addi	s0,sp,32
    80003376:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003378:	0001d517          	auipc	a0,0x1d
    8000337c:	60050513          	addi	a0,a0,1536 # 80020978 <itable>
    80003380:	8c3fd0ef          	jal	80000c42 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003384:	4498                	lw	a4,8(s1)
    80003386:	4785                	li	a5,1
    80003388:	02f70063          	beq	a4,a5,800033a8 <iput+0x3c>
  ip->ref--;
    8000338c:	449c                	lw	a5,8(s1)
    8000338e:	37fd                	addiw	a5,a5,-1
    80003390:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003392:	0001d517          	auipc	a0,0x1d
    80003396:	5e650513          	addi	a0,a0,1510 # 80020978 <itable>
    8000339a:	93dfd0ef          	jal	80000cd6 <release>
}
    8000339e:	60e2                	ld	ra,24(sp)
    800033a0:	6442                	ld	s0,16(sp)
    800033a2:	64a2                	ld	s1,8(sp)
    800033a4:	6105                	addi	sp,sp,32
    800033a6:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800033a8:	40bc                	lw	a5,64(s1)
    800033aa:	d3ed                	beqz	a5,8000338c <iput+0x20>
    800033ac:	04a49783          	lh	a5,74(s1)
    800033b0:	fff1                	bnez	a5,8000338c <iput+0x20>
    800033b2:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    800033b4:	01048913          	addi	s2,s1,16
    800033b8:	854a                	mv	a0,s2
    800033ba:	173000ef          	jal	80003d2c <acquiresleep>
    release(&itable.lock);
    800033be:	0001d517          	auipc	a0,0x1d
    800033c2:	5ba50513          	addi	a0,a0,1466 # 80020978 <itable>
    800033c6:	911fd0ef          	jal	80000cd6 <release>
    itrunc(ip);
    800033ca:	8526                	mv	a0,s1
    800033cc:	f0dff0ef          	jal	800032d8 <itrunc>
    ip->type = 0;
    800033d0:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800033d4:	8526                	mv	a0,s1
    800033d6:	d61ff0ef          	jal	80003136 <iupdate>
    ip->valid = 0;
    800033da:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800033de:	854a                	mv	a0,s2
    800033e0:	193000ef          	jal	80003d72 <releasesleep>
    acquire(&itable.lock);
    800033e4:	0001d517          	auipc	a0,0x1d
    800033e8:	59450513          	addi	a0,a0,1428 # 80020978 <itable>
    800033ec:	857fd0ef          	jal	80000c42 <acquire>
    800033f0:	6902                	ld	s2,0(sp)
    800033f2:	bf69                	j	8000338c <iput+0x20>

00000000800033f4 <iunlockput>:
{
    800033f4:	1101                	addi	sp,sp,-32
    800033f6:	ec06                	sd	ra,24(sp)
    800033f8:	e822                	sd	s0,16(sp)
    800033fa:	e426                	sd	s1,8(sp)
    800033fc:	1000                	addi	s0,sp,32
    800033fe:	84aa                	mv	s1,a0
  iunlock(ip);
    80003400:	e99ff0ef          	jal	80003298 <iunlock>
  iput(ip);
    80003404:	8526                	mv	a0,s1
    80003406:	f67ff0ef          	jal	8000336c <iput>
}
    8000340a:	60e2                	ld	ra,24(sp)
    8000340c:	6442                	ld	s0,16(sp)
    8000340e:	64a2                	ld	s1,8(sp)
    80003410:	6105                	addi	sp,sp,32
    80003412:	8082                	ret

0000000080003414 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003414:	1141                	addi	sp,sp,-16
    80003416:	e406                	sd	ra,8(sp)
    80003418:	e022                	sd	s0,0(sp)
    8000341a:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    8000341c:	411c                	lw	a5,0(a0)
    8000341e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80003420:	415c                	lw	a5,4(a0)
    80003422:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003424:	04451783          	lh	a5,68(a0)
    80003428:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    8000342c:	04a51783          	lh	a5,74(a0)
    80003430:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003434:	04c56783          	lwu	a5,76(a0)
    80003438:	e99c                	sd	a5,16(a1)
}
    8000343a:	60a2                	ld	ra,8(sp)
    8000343c:	6402                	ld	s0,0(sp)
    8000343e:	0141                	addi	sp,sp,16
    80003440:	8082                	ret

0000000080003442 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003442:	457c                	lw	a5,76(a0)
    80003444:	0ed7e663          	bltu	a5,a3,80003530 <readi+0xee>
{
    80003448:	7159                	addi	sp,sp,-112
    8000344a:	f486                	sd	ra,104(sp)
    8000344c:	f0a2                	sd	s0,96(sp)
    8000344e:	eca6                	sd	s1,88(sp)
    80003450:	e0d2                	sd	s4,64(sp)
    80003452:	fc56                	sd	s5,56(sp)
    80003454:	f85a                	sd	s6,48(sp)
    80003456:	f45e                	sd	s7,40(sp)
    80003458:	1880                	addi	s0,sp,112
    8000345a:	8b2a                	mv	s6,a0
    8000345c:	8bae                	mv	s7,a1
    8000345e:	8a32                	mv	s4,a2
    80003460:	84b6                	mv	s1,a3
    80003462:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80003464:	9f35                	addw	a4,a4,a3
    return 0;
    80003466:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003468:	0ad76b63          	bltu	a4,a3,8000351e <readi+0xdc>
    8000346c:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    8000346e:	00e7f463          	bgeu	a5,a4,80003476 <readi+0x34>
    n = ip->size - off;
    80003472:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003476:	080a8b63          	beqz	s5,8000350c <readi+0xca>
    8000347a:	e8ca                	sd	s2,80(sp)
    8000347c:	f062                	sd	s8,32(sp)
    8000347e:	ec66                	sd	s9,24(sp)
    80003480:	e86a                	sd	s10,16(sp)
    80003482:	e46e                	sd	s11,8(sp)
    80003484:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003486:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000348a:	5c7d                	li	s8,-1
    8000348c:	a80d                	j	800034be <readi+0x7c>
    8000348e:	020d1d93          	slli	s11,s10,0x20
    80003492:	020ddd93          	srli	s11,s11,0x20
    80003496:	05890613          	addi	a2,s2,88
    8000349a:	86ee                	mv	a3,s11
    8000349c:	963e                	add	a2,a2,a5
    8000349e:	85d2                	mv	a1,s4
    800034a0:	855e                	mv	a0,s7
    800034a2:	da3fe0ef          	jal	80002244 <either_copyout>
    800034a6:	05850363          	beq	a0,s8,800034ec <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800034aa:	854a                	mv	a0,s2
    800034ac:	f34ff0ef          	jal	80002be0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800034b0:	013d09bb          	addw	s3,s10,s3
    800034b4:	009d04bb          	addw	s1,s10,s1
    800034b8:	9a6e                	add	s4,s4,s11
    800034ba:	0559f363          	bgeu	s3,s5,80003500 <readi+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    800034be:	00a4d59b          	srliw	a1,s1,0xa
    800034c2:	855a                	mv	a0,s6
    800034c4:	987ff0ef          	jal	80002e4a <bmap>
    800034c8:	85aa                	mv	a1,a0
    if(addr == 0)
    800034ca:	c139                	beqz	a0,80003510 <readi+0xce>
    bp = bread(ip->dev, addr);
    800034cc:	000b2503          	lw	a0,0(s6)
    800034d0:	e08ff0ef          	jal	80002ad8 <bread>
    800034d4:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800034d6:	3ff4f793          	andi	a5,s1,1023
    800034da:	40fc873b          	subw	a4,s9,a5
    800034de:	413a86bb          	subw	a3,s5,s3
    800034e2:	8d3a                	mv	s10,a4
    800034e4:	fae6f5e3          	bgeu	a3,a4,8000348e <readi+0x4c>
    800034e8:	8d36                	mv	s10,a3
    800034ea:	b755                	j	8000348e <readi+0x4c>
      brelse(bp);
    800034ec:	854a                	mv	a0,s2
    800034ee:	ef2ff0ef          	jal	80002be0 <brelse>
      tot = -1;
    800034f2:	59fd                	li	s3,-1
      break;
    800034f4:	6946                	ld	s2,80(sp)
    800034f6:	7c02                	ld	s8,32(sp)
    800034f8:	6ce2                	ld	s9,24(sp)
    800034fa:	6d42                	ld	s10,16(sp)
    800034fc:	6da2                	ld	s11,8(sp)
    800034fe:	a831                	j	8000351a <readi+0xd8>
    80003500:	6946                	ld	s2,80(sp)
    80003502:	7c02                	ld	s8,32(sp)
    80003504:	6ce2                	ld	s9,24(sp)
    80003506:	6d42                	ld	s10,16(sp)
    80003508:	6da2                	ld	s11,8(sp)
    8000350a:	a801                	j	8000351a <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000350c:	89d6                	mv	s3,s5
    8000350e:	a031                	j	8000351a <readi+0xd8>
    80003510:	6946                	ld	s2,80(sp)
    80003512:	7c02                	ld	s8,32(sp)
    80003514:	6ce2                	ld	s9,24(sp)
    80003516:	6d42                	ld	s10,16(sp)
    80003518:	6da2                	ld	s11,8(sp)
  }
  return tot;
    8000351a:	854e                	mv	a0,s3
    8000351c:	69a6                	ld	s3,72(sp)
}
    8000351e:	70a6                	ld	ra,104(sp)
    80003520:	7406                	ld	s0,96(sp)
    80003522:	64e6                	ld	s1,88(sp)
    80003524:	6a06                	ld	s4,64(sp)
    80003526:	7ae2                	ld	s5,56(sp)
    80003528:	7b42                	ld	s6,48(sp)
    8000352a:	7ba2                	ld	s7,40(sp)
    8000352c:	6165                	addi	sp,sp,112
    8000352e:	8082                	ret
    return 0;
    80003530:	4501                	li	a0,0
}
    80003532:	8082                	ret

0000000080003534 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003534:	457c                	lw	a5,76(a0)
    80003536:	0ed7eb63          	bltu	a5,a3,8000362c <writei+0xf8>
{
    8000353a:	7159                	addi	sp,sp,-112
    8000353c:	f486                	sd	ra,104(sp)
    8000353e:	f0a2                	sd	s0,96(sp)
    80003540:	e8ca                	sd	s2,80(sp)
    80003542:	e0d2                	sd	s4,64(sp)
    80003544:	fc56                	sd	s5,56(sp)
    80003546:	f85a                	sd	s6,48(sp)
    80003548:	f45e                	sd	s7,40(sp)
    8000354a:	1880                	addi	s0,sp,112
    8000354c:	8aaa                	mv	s5,a0
    8000354e:	8bae                	mv	s7,a1
    80003550:	8a32                	mv	s4,a2
    80003552:	8936                	mv	s2,a3
    80003554:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80003556:	00e687bb          	addw	a5,a3,a4
    8000355a:	0cd7eb63          	bltu	a5,a3,80003630 <writei+0xfc>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    8000355e:	00043737          	lui	a4,0x43
    80003562:	0cf76963          	bltu	a4,a5,80003634 <writei+0x100>
    80003566:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003568:	0a0b0a63          	beqz	s6,8000361c <writei+0xe8>
    8000356c:	eca6                	sd	s1,88(sp)
    8000356e:	f062                	sd	s8,32(sp)
    80003570:	ec66                	sd	s9,24(sp)
    80003572:	e86a                	sd	s10,16(sp)
    80003574:	e46e                	sd	s11,8(sp)
    80003576:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80003578:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    8000357c:	5c7d                	li	s8,-1
    8000357e:	a825                	j	800035b6 <writei+0x82>
    80003580:	020d1d93          	slli	s11,s10,0x20
    80003584:	020ddd93          	srli	s11,s11,0x20
    80003588:	05848513          	addi	a0,s1,88
    8000358c:	86ee                	mv	a3,s11
    8000358e:	8652                	mv	a2,s4
    80003590:	85de                	mv	a1,s7
    80003592:	953e                	add	a0,a0,a5
    80003594:	cfbfe0ef          	jal	8000228e <either_copyin>
    80003598:	05850663          	beq	a0,s8,800035e4 <writei+0xb0>
      brelse(bp);
      break;
    }
    log_write(bp);
    8000359c:	8526                	mv	a0,s1
    8000359e:	688000ef          	jal	80003c26 <log_write>
    brelse(bp);
    800035a2:	8526                	mv	a0,s1
    800035a4:	e3cff0ef          	jal	80002be0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800035a8:	013d09bb          	addw	s3,s10,s3
    800035ac:	012d093b          	addw	s2,s10,s2
    800035b0:	9a6e                	add	s4,s4,s11
    800035b2:	0369fc63          	bgeu	s3,s6,800035ea <writei+0xb6>
    uint addr = bmap(ip, off/BSIZE);
    800035b6:	00a9559b          	srliw	a1,s2,0xa
    800035ba:	8556                	mv	a0,s5
    800035bc:	88fff0ef          	jal	80002e4a <bmap>
    800035c0:	85aa                	mv	a1,a0
    if(addr == 0)
    800035c2:	c505                	beqz	a0,800035ea <writei+0xb6>
    bp = bread(ip->dev, addr);
    800035c4:	000aa503          	lw	a0,0(s5)
    800035c8:	d10ff0ef          	jal	80002ad8 <bread>
    800035cc:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800035ce:	3ff97793          	andi	a5,s2,1023
    800035d2:	40fc873b          	subw	a4,s9,a5
    800035d6:	413b06bb          	subw	a3,s6,s3
    800035da:	8d3a                	mv	s10,a4
    800035dc:	fae6f2e3          	bgeu	a3,a4,80003580 <writei+0x4c>
    800035e0:	8d36                	mv	s10,a3
    800035e2:	bf79                	j	80003580 <writei+0x4c>
      brelse(bp);
    800035e4:	8526                	mv	a0,s1
    800035e6:	dfaff0ef          	jal	80002be0 <brelse>
  }

  if(off > ip->size)
    800035ea:	04caa783          	lw	a5,76(s5)
    800035ee:	0327f963          	bgeu	a5,s2,80003620 <writei+0xec>
    ip->size = off;
    800035f2:	052aa623          	sw	s2,76(s5)
    800035f6:	64e6                	ld	s1,88(sp)
    800035f8:	7c02                	ld	s8,32(sp)
    800035fa:	6ce2                	ld	s9,24(sp)
    800035fc:	6d42                	ld	s10,16(sp)
    800035fe:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003600:	8556                	mv	a0,s5
    80003602:	b35ff0ef          	jal	80003136 <iupdate>

  return tot;
    80003606:	854e                	mv	a0,s3
    80003608:	69a6                	ld	s3,72(sp)
}
    8000360a:	70a6                	ld	ra,104(sp)
    8000360c:	7406                	ld	s0,96(sp)
    8000360e:	6946                	ld	s2,80(sp)
    80003610:	6a06                	ld	s4,64(sp)
    80003612:	7ae2                	ld	s5,56(sp)
    80003614:	7b42                	ld	s6,48(sp)
    80003616:	7ba2                	ld	s7,40(sp)
    80003618:	6165                	addi	sp,sp,112
    8000361a:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000361c:	89da                	mv	s3,s6
    8000361e:	b7cd                	j	80003600 <writei+0xcc>
    80003620:	64e6                	ld	s1,88(sp)
    80003622:	7c02                	ld	s8,32(sp)
    80003624:	6ce2                	ld	s9,24(sp)
    80003626:	6d42                	ld	s10,16(sp)
    80003628:	6da2                	ld	s11,8(sp)
    8000362a:	bfd9                	j	80003600 <writei+0xcc>
    return -1;
    8000362c:	557d                	li	a0,-1
}
    8000362e:	8082                	ret
    return -1;
    80003630:	557d                	li	a0,-1
    80003632:	bfe1                	j	8000360a <writei+0xd6>
    return -1;
    80003634:	557d                	li	a0,-1
    80003636:	bfd1                	j	8000360a <writei+0xd6>

0000000080003638 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003638:	1141                	addi	sp,sp,-16
    8000363a:	e406                	sd	ra,8(sp)
    8000363c:	e022                	sd	s0,0(sp)
    8000363e:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003640:	4639                	li	a2,14
    80003642:	fa8fd0ef          	jal	80000dea <strncmp>
}
    80003646:	60a2                	ld	ra,8(sp)
    80003648:	6402                	ld	s0,0(sp)
    8000364a:	0141                	addi	sp,sp,16
    8000364c:	8082                	ret

000000008000364e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000364e:	711d                	addi	sp,sp,-96
    80003650:	ec86                	sd	ra,88(sp)
    80003652:	e8a2                	sd	s0,80(sp)
    80003654:	e4a6                	sd	s1,72(sp)
    80003656:	e0ca                	sd	s2,64(sp)
    80003658:	fc4e                	sd	s3,56(sp)
    8000365a:	f852                	sd	s4,48(sp)
    8000365c:	f456                	sd	s5,40(sp)
    8000365e:	f05a                	sd	s6,32(sp)
    80003660:	ec5e                	sd	s7,24(sp)
    80003662:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003664:	04451703          	lh	a4,68(a0)
    80003668:	4785                	li	a5,1
    8000366a:	00f71f63          	bne	a4,a5,80003688 <dirlookup+0x3a>
    8000366e:	892a                	mv	s2,a0
    80003670:	8aae                	mv	s5,a1
    80003672:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003674:	457c                	lw	a5,76(a0)
    80003676:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003678:	fa040a13          	addi	s4,s0,-96
    8000367c:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    8000367e:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003682:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003684:	e39d                	bnez	a5,800036aa <dirlookup+0x5c>
    80003686:	a8b9                	j	800036e4 <dirlookup+0x96>
    panic("dirlookup not DIR");
    80003688:	00004517          	auipc	a0,0x4
    8000368c:	e9850513          	addi	a0,a0,-360 # 80007520 <etext+0x520>
    80003690:	952fd0ef          	jal	800007e2 <panic>
      panic("dirlookup read");
    80003694:	00004517          	auipc	a0,0x4
    80003698:	ea450513          	addi	a0,a0,-348 # 80007538 <etext+0x538>
    8000369c:	946fd0ef          	jal	800007e2 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800036a0:	24c1                	addiw	s1,s1,16
    800036a2:	04c92783          	lw	a5,76(s2)
    800036a6:	02f4fe63          	bgeu	s1,a5,800036e2 <dirlookup+0x94>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800036aa:	874e                	mv	a4,s3
    800036ac:	86a6                	mv	a3,s1
    800036ae:	8652                	mv	a2,s4
    800036b0:	4581                	li	a1,0
    800036b2:	854a                	mv	a0,s2
    800036b4:	d8fff0ef          	jal	80003442 <readi>
    800036b8:	fd351ee3          	bne	a0,s3,80003694 <dirlookup+0x46>
    if(de.inum == 0)
    800036bc:	fa045783          	lhu	a5,-96(s0)
    800036c0:	d3e5                	beqz	a5,800036a0 <dirlookup+0x52>
    if(namecmp(name, de.name) == 0){
    800036c2:	85da                	mv	a1,s6
    800036c4:	8556                	mv	a0,s5
    800036c6:	f73ff0ef          	jal	80003638 <namecmp>
    800036ca:	f979                	bnez	a0,800036a0 <dirlookup+0x52>
      if(poff)
    800036cc:	000b8463          	beqz	s7,800036d4 <dirlookup+0x86>
        *poff = off;
    800036d0:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    800036d4:	fa045583          	lhu	a1,-96(s0)
    800036d8:	00092503          	lw	a0,0(s2)
    800036dc:	82fff0ef          	jal	80002f0a <iget>
    800036e0:	a011                	j	800036e4 <dirlookup+0x96>
  return 0;
    800036e2:	4501                	li	a0,0
}
    800036e4:	60e6                	ld	ra,88(sp)
    800036e6:	6446                	ld	s0,80(sp)
    800036e8:	64a6                	ld	s1,72(sp)
    800036ea:	6906                	ld	s2,64(sp)
    800036ec:	79e2                	ld	s3,56(sp)
    800036ee:	7a42                	ld	s4,48(sp)
    800036f0:	7aa2                	ld	s5,40(sp)
    800036f2:	7b02                	ld	s6,32(sp)
    800036f4:	6be2                	ld	s7,24(sp)
    800036f6:	6125                	addi	sp,sp,96
    800036f8:	8082                	ret

00000000800036fa <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800036fa:	711d                	addi	sp,sp,-96
    800036fc:	ec86                	sd	ra,88(sp)
    800036fe:	e8a2                	sd	s0,80(sp)
    80003700:	e4a6                	sd	s1,72(sp)
    80003702:	e0ca                	sd	s2,64(sp)
    80003704:	fc4e                	sd	s3,56(sp)
    80003706:	f852                	sd	s4,48(sp)
    80003708:	f456                	sd	s5,40(sp)
    8000370a:	f05a                	sd	s6,32(sp)
    8000370c:	ec5e                	sd	s7,24(sp)
    8000370e:	e862                	sd	s8,16(sp)
    80003710:	e466                	sd	s9,8(sp)
    80003712:	e06a                	sd	s10,0(sp)
    80003714:	1080                	addi	s0,sp,96
    80003716:	84aa                	mv	s1,a0
    80003718:	8b2e                	mv	s6,a1
    8000371a:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    8000371c:	00054703          	lbu	a4,0(a0)
    80003720:	02f00793          	li	a5,47
    80003724:	00f70f63          	beq	a4,a5,80003742 <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003728:	9f8fe0ef          	jal	80001920 <myproc>
    8000372c:	15053503          	ld	a0,336(a0)
    80003730:	a85ff0ef          	jal	800031b4 <idup>
    80003734:	8a2a                	mv	s4,a0
  while(*path == '/')
    80003736:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    8000373a:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    8000373c:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    8000373e:	4b85                	li	s7,1
    80003740:	a879                	j	800037de <namex+0xe4>
    ip = iget(ROOTDEV, ROOTINO);
    80003742:	4585                	li	a1,1
    80003744:	852e                	mv	a0,a1
    80003746:	fc4ff0ef          	jal	80002f0a <iget>
    8000374a:	8a2a                	mv	s4,a0
    8000374c:	b7ed                	j	80003736 <namex+0x3c>
      iunlockput(ip);
    8000374e:	8552                	mv	a0,s4
    80003750:	ca5ff0ef          	jal	800033f4 <iunlockput>
      return 0;
    80003754:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003756:	8552                	mv	a0,s4
    80003758:	60e6                	ld	ra,88(sp)
    8000375a:	6446                	ld	s0,80(sp)
    8000375c:	64a6                	ld	s1,72(sp)
    8000375e:	6906                	ld	s2,64(sp)
    80003760:	79e2                	ld	s3,56(sp)
    80003762:	7a42                	ld	s4,48(sp)
    80003764:	7aa2                	ld	s5,40(sp)
    80003766:	7b02                	ld	s6,32(sp)
    80003768:	6be2                	ld	s7,24(sp)
    8000376a:	6c42                	ld	s8,16(sp)
    8000376c:	6ca2                	ld	s9,8(sp)
    8000376e:	6d02                	ld	s10,0(sp)
    80003770:	6125                	addi	sp,sp,96
    80003772:	8082                	ret
      iunlock(ip);
    80003774:	8552                	mv	a0,s4
    80003776:	b23ff0ef          	jal	80003298 <iunlock>
      return ip;
    8000377a:	bff1                	j	80003756 <namex+0x5c>
      iunlockput(ip);
    8000377c:	8552                	mv	a0,s4
    8000377e:	c77ff0ef          	jal	800033f4 <iunlockput>
      return 0;
    80003782:	8a4e                	mv	s4,s3
    80003784:	bfc9                	j	80003756 <namex+0x5c>
  len = path - s;
    80003786:	40998633          	sub	a2,s3,s1
    8000378a:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    8000378e:	09ac5063          	bge	s8,s10,8000380e <namex+0x114>
    memmove(name, s, DIRSIZ);
    80003792:	8666                	mv	a2,s9
    80003794:	85a6                	mv	a1,s1
    80003796:	8556                	mv	a0,s5
    80003798:	ddefd0ef          	jal	80000d76 <memmove>
    8000379c:	84ce                	mv	s1,s3
  while(*path == '/')
    8000379e:	0004c783          	lbu	a5,0(s1)
    800037a2:	01279763          	bne	a5,s2,800037b0 <namex+0xb6>
    path++;
    800037a6:	0485                	addi	s1,s1,1
  while(*path == '/')
    800037a8:	0004c783          	lbu	a5,0(s1)
    800037ac:	ff278de3          	beq	a5,s2,800037a6 <namex+0xac>
    ilock(ip);
    800037b0:	8552                	mv	a0,s4
    800037b2:	a39ff0ef          	jal	800031ea <ilock>
    if(ip->type != T_DIR){
    800037b6:	044a1783          	lh	a5,68(s4)
    800037ba:	f9779ae3          	bne	a5,s7,8000374e <namex+0x54>
    if(nameiparent && *path == '\0'){
    800037be:	000b0563          	beqz	s6,800037c8 <namex+0xce>
    800037c2:	0004c783          	lbu	a5,0(s1)
    800037c6:	d7dd                	beqz	a5,80003774 <namex+0x7a>
    if((next = dirlookup(ip, name, 0)) == 0){
    800037c8:	4601                	li	a2,0
    800037ca:	85d6                	mv	a1,s5
    800037cc:	8552                	mv	a0,s4
    800037ce:	e81ff0ef          	jal	8000364e <dirlookup>
    800037d2:	89aa                	mv	s3,a0
    800037d4:	d545                	beqz	a0,8000377c <namex+0x82>
    iunlockput(ip);
    800037d6:	8552                	mv	a0,s4
    800037d8:	c1dff0ef          	jal	800033f4 <iunlockput>
    ip = next;
    800037dc:	8a4e                	mv	s4,s3
  while(*path == '/')
    800037de:	0004c783          	lbu	a5,0(s1)
    800037e2:	01279763          	bne	a5,s2,800037f0 <namex+0xf6>
    path++;
    800037e6:	0485                	addi	s1,s1,1
  while(*path == '/')
    800037e8:	0004c783          	lbu	a5,0(s1)
    800037ec:	ff278de3          	beq	a5,s2,800037e6 <namex+0xec>
  if(*path == 0)
    800037f0:	cb8d                	beqz	a5,80003822 <namex+0x128>
  while(*path != '/' && *path != 0)
    800037f2:	0004c783          	lbu	a5,0(s1)
    800037f6:	89a6                	mv	s3,s1
  len = path - s;
    800037f8:	4d01                	li	s10,0
    800037fa:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    800037fc:	01278963          	beq	a5,s2,8000380e <namex+0x114>
    80003800:	d3d9                	beqz	a5,80003786 <namex+0x8c>
    path++;
    80003802:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80003804:	0009c783          	lbu	a5,0(s3)
    80003808:	ff279ce3          	bne	a5,s2,80003800 <namex+0x106>
    8000380c:	bfad                	j	80003786 <namex+0x8c>
    memmove(name, s, len);
    8000380e:	2601                	sext.w	a2,a2
    80003810:	85a6                	mv	a1,s1
    80003812:	8556                	mv	a0,s5
    80003814:	d62fd0ef          	jal	80000d76 <memmove>
    name[len] = 0;
    80003818:	9d56                	add	s10,s10,s5
    8000381a:	000d0023          	sb	zero,0(s10)
    8000381e:	84ce                	mv	s1,s3
    80003820:	bfbd                	j	8000379e <namex+0xa4>
  if(nameiparent){
    80003822:	f20b0ae3          	beqz	s6,80003756 <namex+0x5c>
    iput(ip);
    80003826:	8552                	mv	a0,s4
    80003828:	b45ff0ef          	jal	8000336c <iput>
    return 0;
    8000382c:	4a01                	li	s4,0
    8000382e:	b725                	j	80003756 <namex+0x5c>

0000000080003830 <dirlink>:
{
    80003830:	715d                	addi	sp,sp,-80
    80003832:	e486                	sd	ra,72(sp)
    80003834:	e0a2                	sd	s0,64(sp)
    80003836:	f84a                	sd	s2,48(sp)
    80003838:	ec56                	sd	s5,24(sp)
    8000383a:	e85a                	sd	s6,16(sp)
    8000383c:	0880                	addi	s0,sp,80
    8000383e:	892a                	mv	s2,a0
    80003840:	8aae                	mv	s5,a1
    80003842:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003844:	4601                	li	a2,0
    80003846:	e09ff0ef          	jal	8000364e <dirlookup>
    8000384a:	ed1d                	bnez	a0,80003888 <dirlink+0x58>
    8000384c:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000384e:	04c92483          	lw	s1,76(s2)
    80003852:	c4b9                	beqz	s1,800038a0 <dirlink+0x70>
    80003854:	f44e                	sd	s3,40(sp)
    80003856:	f052                	sd	s4,32(sp)
    80003858:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000385a:	fb040a13          	addi	s4,s0,-80
    8000385e:	49c1                	li	s3,16
    80003860:	874e                	mv	a4,s3
    80003862:	86a6                	mv	a3,s1
    80003864:	8652                	mv	a2,s4
    80003866:	4581                	li	a1,0
    80003868:	854a                	mv	a0,s2
    8000386a:	bd9ff0ef          	jal	80003442 <readi>
    8000386e:	03351163          	bne	a0,s3,80003890 <dirlink+0x60>
    if(de.inum == 0)
    80003872:	fb045783          	lhu	a5,-80(s0)
    80003876:	c39d                	beqz	a5,8000389c <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003878:	24c1                	addiw	s1,s1,16
    8000387a:	04c92783          	lw	a5,76(s2)
    8000387e:	fef4e1e3          	bltu	s1,a5,80003860 <dirlink+0x30>
    80003882:	79a2                	ld	s3,40(sp)
    80003884:	7a02                	ld	s4,32(sp)
    80003886:	a829                	j	800038a0 <dirlink+0x70>
    iput(ip);
    80003888:	ae5ff0ef          	jal	8000336c <iput>
    return -1;
    8000388c:	557d                	li	a0,-1
    8000388e:	a83d                	j	800038cc <dirlink+0x9c>
      panic("dirlink read");
    80003890:	00004517          	auipc	a0,0x4
    80003894:	cb850513          	addi	a0,a0,-840 # 80007548 <etext+0x548>
    80003898:	f4bfc0ef          	jal	800007e2 <panic>
    8000389c:	79a2                	ld	s3,40(sp)
    8000389e:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    800038a0:	4639                	li	a2,14
    800038a2:	85d6                	mv	a1,s5
    800038a4:	fb240513          	addi	a0,s0,-78
    800038a8:	d7cfd0ef          	jal	80000e24 <strncpy>
  de.inum = inum;
    800038ac:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800038b0:	4741                	li	a4,16
    800038b2:	86a6                	mv	a3,s1
    800038b4:	fb040613          	addi	a2,s0,-80
    800038b8:	4581                	li	a1,0
    800038ba:	854a                	mv	a0,s2
    800038bc:	c79ff0ef          	jal	80003534 <writei>
    800038c0:	1541                	addi	a0,a0,-16
    800038c2:	00a03533          	snez	a0,a0
    800038c6:	40a0053b          	negw	a0,a0
    800038ca:	74e2                	ld	s1,56(sp)
}
    800038cc:	60a6                	ld	ra,72(sp)
    800038ce:	6406                	ld	s0,64(sp)
    800038d0:	7942                	ld	s2,48(sp)
    800038d2:	6ae2                	ld	s5,24(sp)
    800038d4:	6b42                	ld	s6,16(sp)
    800038d6:	6161                	addi	sp,sp,80
    800038d8:	8082                	ret

00000000800038da <namei>:

struct inode*
namei(char *path)
{
    800038da:	1101                	addi	sp,sp,-32
    800038dc:	ec06                	sd	ra,24(sp)
    800038de:	e822                	sd	s0,16(sp)
    800038e0:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800038e2:	fe040613          	addi	a2,s0,-32
    800038e6:	4581                	li	a1,0
    800038e8:	e13ff0ef          	jal	800036fa <namex>
}
    800038ec:	60e2                	ld	ra,24(sp)
    800038ee:	6442                	ld	s0,16(sp)
    800038f0:	6105                	addi	sp,sp,32
    800038f2:	8082                	ret

00000000800038f4 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800038f4:	1141                	addi	sp,sp,-16
    800038f6:	e406                	sd	ra,8(sp)
    800038f8:	e022                	sd	s0,0(sp)
    800038fa:	0800                	addi	s0,sp,16
    800038fc:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800038fe:	4585                	li	a1,1
    80003900:	dfbff0ef          	jal	800036fa <namex>
}
    80003904:	60a2                	ld	ra,8(sp)
    80003906:	6402                	ld	s0,0(sp)
    80003908:	0141                	addi	sp,sp,16
    8000390a:	8082                	ret

000000008000390c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000390c:	1101                	addi	sp,sp,-32
    8000390e:	ec06                	sd	ra,24(sp)
    80003910:	e822                	sd	s0,16(sp)
    80003912:	e426                	sd	s1,8(sp)
    80003914:	e04a                	sd	s2,0(sp)
    80003916:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003918:	0001f917          	auipc	s2,0x1f
    8000391c:	b0890913          	addi	s2,s2,-1272 # 80022420 <log>
    80003920:	01892583          	lw	a1,24(s2)
    80003924:	02892503          	lw	a0,40(s2)
    80003928:	9b0ff0ef          	jal	80002ad8 <bread>
    8000392c:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    8000392e:	02c92603          	lw	a2,44(s2)
    80003932:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003934:	00c05f63          	blez	a2,80003952 <write_head+0x46>
    80003938:	0001f717          	auipc	a4,0x1f
    8000393c:	b1870713          	addi	a4,a4,-1256 # 80022450 <log+0x30>
    80003940:	87aa                	mv	a5,a0
    80003942:	060a                	slli	a2,a2,0x2
    80003944:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80003946:	4314                	lw	a3,0(a4)
    80003948:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000394a:	0711                	addi	a4,a4,4
    8000394c:	0791                	addi	a5,a5,4
    8000394e:	fec79ce3          	bne	a5,a2,80003946 <write_head+0x3a>
  }
  bwrite(buf);
    80003952:	8526                	mv	a0,s1
    80003954:	a5aff0ef          	jal	80002bae <bwrite>
  brelse(buf);
    80003958:	8526                	mv	a0,s1
    8000395a:	a86ff0ef          	jal	80002be0 <brelse>
}
    8000395e:	60e2                	ld	ra,24(sp)
    80003960:	6442                	ld	s0,16(sp)
    80003962:	64a2                	ld	s1,8(sp)
    80003964:	6902                	ld	s2,0(sp)
    80003966:	6105                	addi	sp,sp,32
    80003968:	8082                	ret

000000008000396a <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000396a:	0001f797          	auipc	a5,0x1f
    8000396e:	ae27a783          	lw	a5,-1310(a5) # 8002244c <log+0x2c>
    80003972:	0af05263          	blez	a5,80003a16 <install_trans+0xac>
{
    80003976:	715d                	addi	sp,sp,-80
    80003978:	e486                	sd	ra,72(sp)
    8000397a:	e0a2                	sd	s0,64(sp)
    8000397c:	fc26                	sd	s1,56(sp)
    8000397e:	f84a                	sd	s2,48(sp)
    80003980:	f44e                	sd	s3,40(sp)
    80003982:	f052                	sd	s4,32(sp)
    80003984:	ec56                	sd	s5,24(sp)
    80003986:	e85a                	sd	s6,16(sp)
    80003988:	e45e                	sd	s7,8(sp)
    8000398a:	0880                	addi	s0,sp,80
    8000398c:	8b2a                	mv	s6,a0
    8000398e:	0001fa97          	auipc	s5,0x1f
    80003992:	ac2a8a93          	addi	s5,s5,-1342 # 80022450 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003996:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003998:	0001f997          	auipc	s3,0x1f
    8000399c:	a8898993          	addi	s3,s3,-1400 # 80022420 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800039a0:	40000b93          	li	s7,1024
    800039a4:	a829                	j	800039be <install_trans+0x54>
    brelse(lbuf);
    800039a6:	854a                	mv	a0,s2
    800039a8:	a38ff0ef          	jal	80002be0 <brelse>
    brelse(dbuf);
    800039ac:	8526                	mv	a0,s1
    800039ae:	a32ff0ef          	jal	80002be0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800039b2:	2a05                	addiw	s4,s4,1
    800039b4:	0a91                	addi	s5,s5,4
    800039b6:	02c9a783          	lw	a5,44(s3)
    800039ba:	04fa5363          	bge	s4,a5,80003a00 <install_trans+0x96>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800039be:	0189a583          	lw	a1,24(s3)
    800039c2:	014585bb          	addw	a1,a1,s4
    800039c6:	2585                	addiw	a1,a1,1
    800039c8:	0289a503          	lw	a0,40(s3)
    800039cc:	90cff0ef          	jal	80002ad8 <bread>
    800039d0:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800039d2:	000aa583          	lw	a1,0(s5)
    800039d6:	0289a503          	lw	a0,40(s3)
    800039da:	8feff0ef          	jal	80002ad8 <bread>
    800039de:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800039e0:	865e                	mv	a2,s7
    800039e2:	05890593          	addi	a1,s2,88
    800039e6:	05850513          	addi	a0,a0,88
    800039ea:	b8cfd0ef          	jal	80000d76 <memmove>
    bwrite(dbuf);  // write dst to disk
    800039ee:	8526                	mv	a0,s1
    800039f0:	9beff0ef          	jal	80002bae <bwrite>
    if(recovering == 0)
    800039f4:	fa0b19e3          	bnez	s6,800039a6 <install_trans+0x3c>
      bunpin(dbuf);
    800039f8:	8526                	mv	a0,s1
    800039fa:	a9eff0ef          	jal	80002c98 <bunpin>
    800039fe:	b765                	j	800039a6 <install_trans+0x3c>
}
    80003a00:	60a6                	ld	ra,72(sp)
    80003a02:	6406                	ld	s0,64(sp)
    80003a04:	74e2                	ld	s1,56(sp)
    80003a06:	7942                	ld	s2,48(sp)
    80003a08:	79a2                	ld	s3,40(sp)
    80003a0a:	7a02                	ld	s4,32(sp)
    80003a0c:	6ae2                	ld	s5,24(sp)
    80003a0e:	6b42                	ld	s6,16(sp)
    80003a10:	6ba2                	ld	s7,8(sp)
    80003a12:	6161                	addi	sp,sp,80
    80003a14:	8082                	ret
    80003a16:	8082                	ret

0000000080003a18 <initlog>:
{
    80003a18:	7179                	addi	sp,sp,-48
    80003a1a:	f406                	sd	ra,40(sp)
    80003a1c:	f022                	sd	s0,32(sp)
    80003a1e:	ec26                	sd	s1,24(sp)
    80003a20:	e84a                	sd	s2,16(sp)
    80003a22:	e44e                	sd	s3,8(sp)
    80003a24:	1800                	addi	s0,sp,48
    80003a26:	892a                	mv	s2,a0
    80003a28:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003a2a:	0001f497          	auipc	s1,0x1f
    80003a2e:	9f648493          	addi	s1,s1,-1546 # 80022420 <log>
    80003a32:	00004597          	auipc	a1,0x4
    80003a36:	b2658593          	addi	a1,a1,-1242 # 80007558 <etext+0x558>
    80003a3a:	8526                	mv	a0,s1
    80003a3c:	982fd0ef          	jal	80000bbe <initlock>
  log.start = sb->logstart;
    80003a40:	0149a583          	lw	a1,20(s3)
    80003a44:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003a46:	0109a783          	lw	a5,16(s3)
    80003a4a:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003a4c:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003a50:	854a                	mv	a0,s2
    80003a52:	886ff0ef          	jal	80002ad8 <bread>
  log.lh.n = lh->n;
    80003a56:	4d30                	lw	a2,88(a0)
    80003a58:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80003a5a:	00c05f63          	blez	a2,80003a78 <initlog+0x60>
    80003a5e:	87aa                	mv	a5,a0
    80003a60:	0001f717          	auipc	a4,0x1f
    80003a64:	9f070713          	addi	a4,a4,-1552 # 80022450 <log+0x30>
    80003a68:	060a                	slli	a2,a2,0x2
    80003a6a:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80003a6c:	4ff4                	lw	a3,92(a5)
    80003a6e:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003a70:	0791                	addi	a5,a5,4
    80003a72:	0711                	addi	a4,a4,4
    80003a74:	fec79ce3          	bne	a5,a2,80003a6c <initlog+0x54>
  brelse(buf);
    80003a78:	968ff0ef          	jal	80002be0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003a7c:	4505                	li	a0,1
    80003a7e:	eedff0ef          	jal	8000396a <install_trans>
  log.lh.n = 0;
    80003a82:	0001f797          	auipc	a5,0x1f
    80003a86:	9c07a523          	sw	zero,-1590(a5) # 8002244c <log+0x2c>
  write_head(); // clear the log
    80003a8a:	e83ff0ef          	jal	8000390c <write_head>
}
    80003a8e:	70a2                	ld	ra,40(sp)
    80003a90:	7402                	ld	s0,32(sp)
    80003a92:	64e2                	ld	s1,24(sp)
    80003a94:	6942                	ld	s2,16(sp)
    80003a96:	69a2                	ld	s3,8(sp)
    80003a98:	6145                	addi	sp,sp,48
    80003a9a:	8082                	ret

0000000080003a9c <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003a9c:	1101                	addi	sp,sp,-32
    80003a9e:	ec06                	sd	ra,24(sp)
    80003aa0:	e822                	sd	s0,16(sp)
    80003aa2:	e426                	sd	s1,8(sp)
    80003aa4:	e04a                	sd	s2,0(sp)
    80003aa6:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003aa8:	0001f517          	auipc	a0,0x1f
    80003aac:	97850513          	addi	a0,a0,-1672 # 80022420 <log>
    80003ab0:	992fd0ef          	jal	80000c42 <acquire>
  while(1){
    if(log.committing){
    80003ab4:	0001f497          	auipc	s1,0x1f
    80003ab8:	96c48493          	addi	s1,s1,-1684 # 80022420 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003abc:	4979                	li	s2,30
    80003abe:	a029                	j	80003ac8 <begin_op+0x2c>
      sleep(&log, &log.lock);
    80003ac0:	85a6                	mv	a1,s1
    80003ac2:	8526                	mv	a0,s1
    80003ac4:	c2afe0ef          	jal	80001eee <sleep>
    if(log.committing){
    80003ac8:	50dc                	lw	a5,36(s1)
    80003aca:	fbfd                	bnez	a5,80003ac0 <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003acc:	5098                	lw	a4,32(s1)
    80003ace:	2705                	addiw	a4,a4,1
    80003ad0:	0027179b          	slliw	a5,a4,0x2
    80003ad4:	9fb9                	addw	a5,a5,a4
    80003ad6:	0017979b          	slliw	a5,a5,0x1
    80003ada:	54d4                	lw	a3,44(s1)
    80003adc:	9fb5                	addw	a5,a5,a3
    80003ade:	00f95763          	bge	s2,a5,80003aec <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003ae2:	85a6                	mv	a1,s1
    80003ae4:	8526                	mv	a0,s1
    80003ae6:	c08fe0ef          	jal	80001eee <sleep>
    80003aea:	bff9                	j	80003ac8 <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    80003aec:	0001f517          	auipc	a0,0x1f
    80003af0:	93450513          	addi	a0,a0,-1740 # 80022420 <log>
    80003af4:	d118                	sw	a4,32(a0)
      release(&log.lock);
    80003af6:	9e0fd0ef          	jal	80000cd6 <release>
      break;
    }
  }
}
    80003afa:	60e2                	ld	ra,24(sp)
    80003afc:	6442                	ld	s0,16(sp)
    80003afe:	64a2                	ld	s1,8(sp)
    80003b00:	6902                	ld	s2,0(sp)
    80003b02:	6105                	addi	sp,sp,32
    80003b04:	8082                	ret

0000000080003b06 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003b06:	7139                	addi	sp,sp,-64
    80003b08:	fc06                	sd	ra,56(sp)
    80003b0a:	f822                	sd	s0,48(sp)
    80003b0c:	f426                	sd	s1,40(sp)
    80003b0e:	f04a                	sd	s2,32(sp)
    80003b10:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003b12:	0001f497          	auipc	s1,0x1f
    80003b16:	90e48493          	addi	s1,s1,-1778 # 80022420 <log>
    80003b1a:	8526                	mv	a0,s1
    80003b1c:	926fd0ef          	jal	80000c42 <acquire>
  log.outstanding -= 1;
    80003b20:	509c                	lw	a5,32(s1)
    80003b22:	37fd                	addiw	a5,a5,-1
    80003b24:	893e                	mv	s2,a5
    80003b26:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003b28:	50dc                	lw	a5,36(s1)
    80003b2a:	ef9d                	bnez	a5,80003b68 <end_op+0x62>
    panic("log.committing");
  if(log.outstanding == 0){
    80003b2c:	04091863          	bnez	s2,80003b7c <end_op+0x76>
    do_commit = 1;
    log.committing = 1;
    80003b30:	0001f497          	auipc	s1,0x1f
    80003b34:	8f048493          	addi	s1,s1,-1808 # 80022420 <log>
    80003b38:	4785                	li	a5,1
    80003b3a:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003b3c:	8526                	mv	a0,s1
    80003b3e:	998fd0ef          	jal	80000cd6 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003b42:	54dc                	lw	a5,44(s1)
    80003b44:	04f04c63          	bgtz	a5,80003b9c <end_op+0x96>
    acquire(&log.lock);
    80003b48:	0001f497          	auipc	s1,0x1f
    80003b4c:	8d848493          	addi	s1,s1,-1832 # 80022420 <log>
    80003b50:	8526                	mv	a0,s1
    80003b52:	8f0fd0ef          	jal	80000c42 <acquire>
    log.committing = 0;
    80003b56:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80003b5a:	8526                	mv	a0,s1
    80003b5c:	bdefe0ef          	jal	80001f3a <wakeup>
    release(&log.lock);
    80003b60:	8526                	mv	a0,s1
    80003b62:	974fd0ef          	jal	80000cd6 <release>
}
    80003b66:	a02d                	j	80003b90 <end_op+0x8a>
    80003b68:	ec4e                	sd	s3,24(sp)
    80003b6a:	e852                	sd	s4,16(sp)
    80003b6c:	e456                	sd	s5,8(sp)
    80003b6e:	e05a                	sd	s6,0(sp)
    panic("log.committing");
    80003b70:	00004517          	auipc	a0,0x4
    80003b74:	9f050513          	addi	a0,a0,-1552 # 80007560 <etext+0x560>
    80003b78:	c6bfc0ef          	jal	800007e2 <panic>
    wakeup(&log);
    80003b7c:	0001f497          	auipc	s1,0x1f
    80003b80:	8a448493          	addi	s1,s1,-1884 # 80022420 <log>
    80003b84:	8526                	mv	a0,s1
    80003b86:	bb4fe0ef          	jal	80001f3a <wakeup>
  release(&log.lock);
    80003b8a:	8526                	mv	a0,s1
    80003b8c:	94afd0ef          	jal	80000cd6 <release>
}
    80003b90:	70e2                	ld	ra,56(sp)
    80003b92:	7442                	ld	s0,48(sp)
    80003b94:	74a2                	ld	s1,40(sp)
    80003b96:	7902                	ld	s2,32(sp)
    80003b98:	6121                	addi	sp,sp,64
    80003b9a:	8082                	ret
    80003b9c:	ec4e                	sd	s3,24(sp)
    80003b9e:	e852                	sd	s4,16(sp)
    80003ba0:	e456                	sd	s5,8(sp)
    80003ba2:	e05a                	sd	s6,0(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80003ba4:	0001fa97          	auipc	s5,0x1f
    80003ba8:	8aca8a93          	addi	s5,s5,-1876 # 80022450 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003bac:	0001fa17          	auipc	s4,0x1f
    80003bb0:	874a0a13          	addi	s4,s4,-1932 # 80022420 <log>
    memmove(to->data, from->data, BSIZE);
    80003bb4:	40000b13          	li	s6,1024
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003bb8:	018a2583          	lw	a1,24(s4)
    80003bbc:	012585bb          	addw	a1,a1,s2
    80003bc0:	2585                	addiw	a1,a1,1
    80003bc2:	028a2503          	lw	a0,40(s4)
    80003bc6:	f13fe0ef          	jal	80002ad8 <bread>
    80003bca:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003bcc:	000aa583          	lw	a1,0(s5)
    80003bd0:	028a2503          	lw	a0,40(s4)
    80003bd4:	f05fe0ef          	jal	80002ad8 <bread>
    80003bd8:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003bda:	865a                	mv	a2,s6
    80003bdc:	05850593          	addi	a1,a0,88
    80003be0:	05848513          	addi	a0,s1,88
    80003be4:	992fd0ef          	jal	80000d76 <memmove>
    bwrite(to);  // write the log
    80003be8:	8526                	mv	a0,s1
    80003bea:	fc5fe0ef          	jal	80002bae <bwrite>
    brelse(from);
    80003bee:	854e                	mv	a0,s3
    80003bf0:	ff1fe0ef          	jal	80002be0 <brelse>
    brelse(to);
    80003bf4:	8526                	mv	a0,s1
    80003bf6:	febfe0ef          	jal	80002be0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003bfa:	2905                	addiw	s2,s2,1
    80003bfc:	0a91                	addi	s5,s5,4
    80003bfe:	02ca2783          	lw	a5,44(s4)
    80003c02:	faf94be3          	blt	s2,a5,80003bb8 <end_op+0xb2>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003c06:	d07ff0ef          	jal	8000390c <write_head>
    install_trans(0); // Now install writes to home locations
    80003c0a:	4501                	li	a0,0
    80003c0c:	d5fff0ef          	jal	8000396a <install_trans>
    log.lh.n = 0;
    80003c10:	0001f797          	auipc	a5,0x1f
    80003c14:	8207ae23          	sw	zero,-1988(a5) # 8002244c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003c18:	cf5ff0ef          	jal	8000390c <write_head>
    80003c1c:	69e2                	ld	s3,24(sp)
    80003c1e:	6a42                	ld	s4,16(sp)
    80003c20:	6aa2                	ld	s5,8(sp)
    80003c22:	6b02                	ld	s6,0(sp)
    80003c24:	b715                	j	80003b48 <end_op+0x42>

0000000080003c26 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80003c26:	1101                	addi	sp,sp,-32
    80003c28:	ec06                	sd	ra,24(sp)
    80003c2a:	e822                	sd	s0,16(sp)
    80003c2c:	e426                	sd	s1,8(sp)
    80003c2e:	e04a                	sd	s2,0(sp)
    80003c30:	1000                	addi	s0,sp,32
    80003c32:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80003c34:	0001e917          	auipc	s2,0x1e
    80003c38:	7ec90913          	addi	s2,s2,2028 # 80022420 <log>
    80003c3c:	854a                	mv	a0,s2
    80003c3e:	804fd0ef          	jal	80000c42 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003c42:	02c92603          	lw	a2,44(s2)
    80003c46:	47f5                	li	a5,29
    80003c48:	06c7c363          	blt	a5,a2,80003cae <log_write+0x88>
    80003c4c:	0001e797          	auipc	a5,0x1e
    80003c50:	7f07a783          	lw	a5,2032(a5) # 8002243c <log+0x1c>
    80003c54:	37fd                	addiw	a5,a5,-1
    80003c56:	04f65c63          	bge	a2,a5,80003cae <log_write+0x88>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003c5a:	0001e797          	auipc	a5,0x1e
    80003c5e:	7e67a783          	lw	a5,2022(a5) # 80022440 <log+0x20>
    80003c62:	04f05c63          	blez	a5,80003cba <log_write+0x94>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003c66:	4781                	li	a5,0
    80003c68:	04c05f63          	blez	a2,80003cc6 <log_write+0xa0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003c6c:	44cc                	lw	a1,12(s1)
    80003c6e:	0001e717          	auipc	a4,0x1e
    80003c72:	7e270713          	addi	a4,a4,2018 # 80022450 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003c76:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003c78:	4314                	lw	a3,0(a4)
    80003c7a:	04b68663          	beq	a3,a1,80003cc6 <log_write+0xa0>
  for (i = 0; i < log.lh.n; i++) {
    80003c7e:	2785                	addiw	a5,a5,1
    80003c80:	0711                	addi	a4,a4,4
    80003c82:	fef61be3          	bne	a2,a5,80003c78 <log_write+0x52>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003c86:	0621                	addi	a2,a2,8
    80003c88:	060a                	slli	a2,a2,0x2
    80003c8a:	0001e797          	auipc	a5,0x1e
    80003c8e:	79678793          	addi	a5,a5,1942 # 80022420 <log>
    80003c92:	97b2                	add	a5,a5,a2
    80003c94:	44d8                	lw	a4,12(s1)
    80003c96:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003c98:	8526                	mv	a0,s1
    80003c9a:	fcbfe0ef          	jal	80002c64 <bpin>
    log.lh.n++;
    80003c9e:	0001e717          	auipc	a4,0x1e
    80003ca2:	78270713          	addi	a4,a4,1922 # 80022420 <log>
    80003ca6:	575c                	lw	a5,44(a4)
    80003ca8:	2785                	addiw	a5,a5,1
    80003caa:	d75c                	sw	a5,44(a4)
    80003cac:	a80d                	j	80003cde <log_write+0xb8>
    panic("too big a transaction");
    80003cae:	00004517          	auipc	a0,0x4
    80003cb2:	8c250513          	addi	a0,a0,-1854 # 80007570 <etext+0x570>
    80003cb6:	b2dfc0ef          	jal	800007e2 <panic>
    panic("log_write outside of trans");
    80003cba:	00004517          	auipc	a0,0x4
    80003cbe:	8ce50513          	addi	a0,a0,-1842 # 80007588 <etext+0x588>
    80003cc2:	b21fc0ef          	jal	800007e2 <panic>
  log.lh.block[i] = b->blockno;
    80003cc6:	00878693          	addi	a3,a5,8
    80003cca:	068a                	slli	a3,a3,0x2
    80003ccc:	0001e717          	auipc	a4,0x1e
    80003cd0:	75470713          	addi	a4,a4,1876 # 80022420 <log>
    80003cd4:	9736                	add	a4,a4,a3
    80003cd6:	44d4                	lw	a3,12(s1)
    80003cd8:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003cda:	faf60fe3          	beq	a2,a5,80003c98 <log_write+0x72>
  }
  release(&log.lock);
    80003cde:	0001e517          	auipc	a0,0x1e
    80003ce2:	74250513          	addi	a0,a0,1858 # 80022420 <log>
    80003ce6:	ff1fc0ef          	jal	80000cd6 <release>
}
    80003cea:	60e2                	ld	ra,24(sp)
    80003cec:	6442                	ld	s0,16(sp)
    80003cee:	64a2                	ld	s1,8(sp)
    80003cf0:	6902                	ld	s2,0(sp)
    80003cf2:	6105                	addi	sp,sp,32
    80003cf4:	8082                	ret

0000000080003cf6 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003cf6:	1101                	addi	sp,sp,-32
    80003cf8:	ec06                	sd	ra,24(sp)
    80003cfa:	e822                	sd	s0,16(sp)
    80003cfc:	e426                	sd	s1,8(sp)
    80003cfe:	e04a                	sd	s2,0(sp)
    80003d00:	1000                	addi	s0,sp,32
    80003d02:	84aa                	mv	s1,a0
    80003d04:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003d06:	00004597          	auipc	a1,0x4
    80003d0a:	8a258593          	addi	a1,a1,-1886 # 800075a8 <etext+0x5a8>
    80003d0e:	0521                	addi	a0,a0,8
    80003d10:	eaffc0ef          	jal	80000bbe <initlock>
  lk->name = name;
    80003d14:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003d18:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003d1c:	0204a423          	sw	zero,40(s1)
}
    80003d20:	60e2                	ld	ra,24(sp)
    80003d22:	6442                	ld	s0,16(sp)
    80003d24:	64a2                	ld	s1,8(sp)
    80003d26:	6902                	ld	s2,0(sp)
    80003d28:	6105                	addi	sp,sp,32
    80003d2a:	8082                	ret

0000000080003d2c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003d2c:	1101                	addi	sp,sp,-32
    80003d2e:	ec06                	sd	ra,24(sp)
    80003d30:	e822                	sd	s0,16(sp)
    80003d32:	e426                	sd	s1,8(sp)
    80003d34:	e04a                	sd	s2,0(sp)
    80003d36:	1000                	addi	s0,sp,32
    80003d38:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003d3a:	00850913          	addi	s2,a0,8
    80003d3e:	854a                	mv	a0,s2
    80003d40:	f03fc0ef          	jal	80000c42 <acquire>
  while (lk->locked) {
    80003d44:	409c                	lw	a5,0(s1)
    80003d46:	c799                	beqz	a5,80003d54 <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    80003d48:	85ca                	mv	a1,s2
    80003d4a:	8526                	mv	a0,s1
    80003d4c:	9a2fe0ef          	jal	80001eee <sleep>
  while (lk->locked) {
    80003d50:	409c                	lw	a5,0(s1)
    80003d52:	fbfd                	bnez	a5,80003d48 <acquiresleep+0x1c>
  }
  lk->locked = 1;
    80003d54:	4785                	li	a5,1
    80003d56:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003d58:	bc9fd0ef          	jal	80001920 <myproc>
    80003d5c:	591c                	lw	a5,48(a0)
    80003d5e:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003d60:	854a                	mv	a0,s2
    80003d62:	f75fc0ef          	jal	80000cd6 <release>
}
    80003d66:	60e2                	ld	ra,24(sp)
    80003d68:	6442                	ld	s0,16(sp)
    80003d6a:	64a2                	ld	s1,8(sp)
    80003d6c:	6902                	ld	s2,0(sp)
    80003d6e:	6105                	addi	sp,sp,32
    80003d70:	8082                	ret

0000000080003d72 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003d72:	1101                	addi	sp,sp,-32
    80003d74:	ec06                	sd	ra,24(sp)
    80003d76:	e822                	sd	s0,16(sp)
    80003d78:	e426                	sd	s1,8(sp)
    80003d7a:	e04a                	sd	s2,0(sp)
    80003d7c:	1000                	addi	s0,sp,32
    80003d7e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003d80:	00850913          	addi	s2,a0,8
    80003d84:	854a                	mv	a0,s2
    80003d86:	ebdfc0ef          	jal	80000c42 <acquire>
  lk->locked = 0;
    80003d8a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003d8e:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003d92:	8526                	mv	a0,s1
    80003d94:	9a6fe0ef          	jal	80001f3a <wakeup>
  release(&lk->lk);
    80003d98:	854a                	mv	a0,s2
    80003d9a:	f3dfc0ef          	jal	80000cd6 <release>
}
    80003d9e:	60e2                	ld	ra,24(sp)
    80003da0:	6442                	ld	s0,16(sp)
    80003da2:	64a2                	ld	s1,8(sp)
    80003da4:	6902                	ld	s2,0(sp)
    80003da6:	6105                	addi	sp,sp,32
    80003da8:	8082                	ret

0000000080003daa <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003daa:	7179                	addi	sp,sp,-48
    80003dac:	f406                	sd	ra,40(sp)
    80003dae:	f022                	sd	s0,32(sp)
    80003db0:	ec26                	sd	s1,24(sp)
    80003db2:	e84a                	sd	s2,16(sp)
    80003db4:	1800                	addi	s0,sp,48
    80003db6:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003db8:	00850913          	addi	s2,a0,8
    80003dbc:	854a                	mv	a0,s2
    80003dbe:	e85fc0ef          	jal	80000c42 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003dc2:	409c                	lw	a5,0(s1)
    80003dc4:	ef81                	bnez	a5,80003ddc <holdingsleep+0x32>
    80003dc6:	4481                	li	s1,0
  release(&lk->lk);
    80003dc8:	854a                	mv	a0,s2
    80003dca:	f0dfc0ef          	jal	80000cd6 <release>
  return r;
}
    80003dce:	8526                	mv	a0,s1
    80003dd0:	70a2                	ld	ra,40(sp)
    80003dd2:	7402                	ld	s0,32(sp)
    80003dd4:	64e2                	ld	s1,24(sp)
    80003dd6:	6942                	ld	s2,16(sp)
    80003dd8:	6145                	addi	sp,sp,48
    80003dda:	8082                	ret
    80003ddc:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80003dde:	0284a983          	lw	s3,40(s1)
    80003de2:	b3ffd0ef          	jal	80001920 <myproc>
    80003de6:	5904                	lw	s1,48(a0)
    80003de8:	413484b3          	sub	s1,s1,s3
    80003dec:	0014b493          	seqz	s1,s1
    80003df0:	69a2                	ld	s3,8(sp)
    80003df2:	bfd9                	j	80003dc8 <holdingsleep+0x1e>

0000000080003df4 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003df4:	1141                	addi	sp,sp,-16
    80003df6:	e406                	sd	ra,8(sp)
    80003df8:	e022                	sd	s0,0(sp)
    80003dfa:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003dfc:	00003597          	auipc	a1,0x3
    80003e00:	7bc58593          	addi	a1,a1,1980 # 800075b8 <etext+0x5b8>
    80003e04:	0001e517          	auipc	a0,0x1e
    80003e08:	76450513          	addi	a0,a0,1892 # 80022568 <ftable>
    80003e0c:	db3fc0ef          	jal	80000bbe <initlock>
}
    80003e10:	60a2                	ld	ra,8(sp)
    80003e12:	6402                	ld	s0,0(sp)
    80003e14:	0141                	addi	sp,sp,16
    80003e16:	8082                	ret

0000000080003e18 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003e18:	1101                	addi	sp,sp,-32
    80003e1a:	ec06                	sd	ra,24(sp)
    80003e1c:	e822                	sd	s0,16(sp)
    80003e1e:	e426                	sd	s1,8(sp)
    80003e20:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003e22:	0001e517          	auipc	a0,0x1e
    80003e26:	74650513          	addi	a0,a0,1862 # 80022568 <ftable>
    80003e2a:	e19fc0ef          	jal	80000c42 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003e2e:	0001e497          	auipc	s1,0x1e
    80003e32:	75248493          	addi	s1,s1,1874 # 80022580 <ftable+0x18>
    80003e36:	0001f717          	auipc	a4,0x1f
    80003e3a:	6ea70713          	addi	a4,a4,1770 # 80023520 <disk>
    if(f->ref == 0){
    80003e3e:	40dc                	lw	a5,4(s1)
    80003e40:	cf89                	beqz	a5,80003e5a <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003e42:	02848493          	addi	s1,s1,40
    80003e46:	fee49ce3          	bne	s1,a4,80003e3e <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003e4a:	0001e517          	auipc	a0,0x1e
    80003e4e:	71e50513          	addi	a0,a0,1822 # 80022568 <ftable>
    80003e52:	e85fc0ef          	jal	80000cd6 <release>
  return 0;
    80003e56:	4481                	li	s1,0
    80003e58:	a809                	j	80003e6a <filealloc+0x52>
      f->ref = 1;
    80003e5a:	4785                	li	a5,1
    80003e5c:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003e5e:	0001e517          	auipc	a0,0x1e
    80003e62:	70a50513          	addi	a0,a0,1802 # 80022568 <ftable>
    80003e66:	e71fc0ef          	jal	80000cd6 <release>
}
    80003e6a:	8526                	mv	a0,s1
    80003e6c:	60e2                	ld	ra,24(sp)
    80003e6e:	6442                	ld	s0,16(sp)
    80003e70:	64a2                	ld	s1,8(sp)
    80003e72:	6105                	addi	sp,sp,32
    80003e74:	8082                	ret

0000000080003e76 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003e76:	1101                	addi	sp,sp,-32
    80003e78:	ec06                	sd	ra,24(sp)
    80003e7a:	e822                	sd	s0,16(sp)
    80003e7c:	e426                	sd	s1,8(sp)
    80003e7e:	1000                	addi	s0,sp,32
    80003e80:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003e82:	0001e517          	auipc	a0,0x1e
    80003e86:	6e650513          	addi	a0,a0,1766 # 80022568 <ftable>
    80003e8a:	db9fc0ef          	jal	80000c42 <acquire>
  if(f->ref < 1)
    80003e8e:	40dc                	lw	a5,4(s1)
    80003e90:	02f05063          	blez	a5,80003eb0 <filedup+0x3a>
    panic("filedup");
  f->ref++;
    80003e94:	2785                	addiw	a5,a5,1
    80003e96:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003e98:	0001e517          	auipc	a0,0x1e
    80003e9c:	6d050513          	addi	a0,a0,1744 # 80022568 <ftable>
    80003ea0:	e37fc0ef          	jal	80000cd6 <release>
  return f;
}
    80003ea4:	8526                	mv	a0,s1
    80003ea6:	60e2                	ld	ra,24(sp)
    80003ea8:	6442                	ld	s0,16(sp)
    80003eaa:	64a2                	ld	s1,8(sp)
    80003eac:	6105                	addi	sp,sp,32
    80003eae:	8082                	ret
    panic("filedup");
    80003eb0:	00003517          	auipc	a0,0x3
    80003eb4:	71050513          	addi	a0,a0,1808 # 800075c0 <etext+0x5c0>
    80003eb8:	92bfc0ef          	jal	800007e2 <panic>

0000000080003ebc <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003ebc:	7139                	addi	sp,sp,-64
    80003ebe:	fc06                	sd	ra,56(sp)
    80003ec0:	f822                	sd	s0,48(sp)
    80003ec2:	f426                	sd	s1,40(sp)
    80003ec4:	0080                	addi	s0,sp,64
    80003ec6:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003ec8:	0001e517          	auipc	a0,0x1e
    80003ecc:	6a050513          	addi	a0,a0,1696 # 80022568 <ftable>
    80003ed0:	d73fc0ef          	jal	80000c42 <acquire>
  if(f->ref < 1)
    80003ed4:	40dc                	lw	a5,4(s1)
    80003ed6:	04f05863          	blez	a5,80003f26 <fileclose+0x6a>
    panic("fileclose");
  if(--f->ref > 0){
    80003eda:	37fd                	addiw	a5,a5,-1
    80003edc:	c0dc                	sw	a5,4(s1)
    80003ede:	04f04e63          	bgtz	a5,80003f3a <fileclose+0x7e>
    80003ee2:	f04a                	sd	s2,32(sp)
    80003ee4:	ec4e                	sd	s3,24(sp)
    80003ee6:	e852                	sd	s4,16(sp)
    80003ee8:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003eea:	0004a903          	lw	s2,0(s1)
    80003eee:	0094ca83          	lbu	s5,9(s1)
    80003ef2:	0104ba03          	ld	s4,16(s1)
    80003ef6:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003efa:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003efe:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003f02:	0001e517          	auipc	a0,0x1e
    80003f06:	66650513          	addi	a0,a0,1638 # 80022568 <ftable>
    80003f0a:	dcdfc0ef          	jal	80000cd6 <release>

  if(ff.type == FD_PIPE){
    80003f0e:	4785                	li	a5,1
    80003f10:	04f90063          	beq	s2,a5,80003f50 <fileclose+0x94>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003f14:	3979                	addiw	s2,s2,-2
    80003f16:	4785                	li	a5,1
    80003f18:	0527f563          	bgeu	a5,s2,80003f62 <fileclose+0xa6>
    80003f1c:	7902                	ld	s2,32(sp)
    80003f1e:	69e2                	ld	s3,24(sp)
    80003f20:	6a42                	ld	s4,16(sp)
    80003f22:	6aa2                	ld	s5,8(sp)
    80003f24:	a00d                	j	80003f46 <fileclose+0x8a>
    80003f26:	f04a                	sd	s2,32(sp)
    80003f28:	ec4e                	sd	s3,24(sp)
    80003f2a:	e852                	sd	s4,16(sp)
    80003f2c:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80003f2e:	00003517          	auipc	a0,0x3
    80003f32:	69a50513          	addi	a0,a0,1690 # 800075c8 <etext+0x5c8>
    80003f36:	8adfc0ef          	jal	800007e2 <panic>
    release(&ftable.lock);
    80003f3a:	0001e517          	auipc	a0,0x1e
    80003f3e:	62e50513          	addi	a0,a0,1582 # 80022568 <ftable>
    80003f42:	d95fc0ef          	jal	80000cd6 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003f46:	70e2                	ld	ra,56(sp)
    80003f48:	7442                	ld	s0,48(sp)
    80003f4a:	74a2                	ld	s1,40(sp)
    80003f4c:	6121                	addi	sp,sp,64
    80003f4e:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003f50:	85d6                	mv	a1,s5
    80003f52:	8552                	mv	a0,s4
    80003f54:	340000ef          	jal	80004294 <pipeclose>
    80003f58:	7902                	ld	s2,32(sp)
    80003f5a:	69e2                	ld	s3,24(sp)
    80003f5c:	6a42                	ld	s4,16(sp)
    80003f5e:	6aa2                	ld	s5,8(sp)
    80003f60:	b7dd                	j	80003f46 <fileclose+0x8a>
    begin_op();
    80003f62:	b3bff0ef          	jal	80003a9c <begin_op>
    iput(ff.ip);
    80003f66:	854e                	mv	a0,s3
    80003f68:	c04ff0ef          	jal	8000336c <iput>
    end_op();
    80003f6c:	b9bff0ef          	jal	80003b06 <end_op>
    80003f70:	7902                	ld	s2,32(sp)
    80003f72:	69e2                	ld	s3,24(sp)
    80003f74:	6a42                	ld	s4,16(sp)
    80003f76:	6aa2                	ld	s5,8(sp)
    80003f78:	b7f9                	j	80003f46 <fileclose+0x8a>

0000000080003f7a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003f7a:	715d                	addi	sp,sp,-80
    80003f7c:	e486                	sd	ra,72(sp)
    80003f7e:	e0a2                	sd	s0,64(sp)
    80003f80:	fc26                	sd	s1,56(sp)
    80003f82:	f44e                	sd	s3,40(sp)
    80003f84:	0880                	addi	s0,sp,80
    80003f86:	84aa                	mv	s1,a0
    80003f88:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003f8a:	997fd0ef          	jal	80001920 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003f8e:	409c                	lw	a5,0(s1)
    80003f90:	37f9                	addiw	a5,a5,-2
    80003f92:	4705                	li	a4,1
    80003f94:	04f76263          	bltu	a4,a5,80003fd8 <filestat+0x5e>
    80003f98:	f84a                	sd	s2,48(sp)
    80003f9a:	f052                	sd	s4,32(sp)
    80003f9c:	892a                	mv	s2,a0
    ilock(f->ip);
    80003f9e:	6c88                	ld	a0,24(s1)
    80003fa0:	a4aff0ef          	jal	800031ea <ilock>
    stati(f->ip, &st);
    80003fa4:	fb840a13          	addi	s4,s0,-72
    80003fa8:	85d2                	mv	a1,s4
    80003faa:	6c88                	ld	a0,24(s1)
    80003fac:	c68ff0ef          	jal	80003414 <stati>
    iunlock(f->ip);
    80003fb0:	6c88                	ld	a0,24(s1)
    80003fb2:	ae6ff0ef          	jal	80003298 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003fb6:	46e1                	li	a3,24
    80003fb8:	8652                	mv	a2,s4
    80003fba:	85ce                	mv	a1,s3
    80003fbc:	05093503          	ld	a0,80(s2)
    80003fc0:	e08fd0ef          	jal	800015c8 <copyout>
    80003fc4:	41f5551b          	sraiw	a0,a0,0x1f
    80003fc8:	7942                	ld	s2,48(sp)
    80003fca:	7a02                	ld	s4,32(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003fcc:	60a6                	ld	ra,72(sp)
    80003fce:	6406                	ld	s0,64(sp)
    80003fd0:	74e2                	ld	s1,56(sp)
    80003fd2:	79a2                	ld	s3,40(sp)
    80003fd4:	6161                	addi	sp,sp,80
    80003fd6:	8082                	ret
  return -1;
    80003fd8:	557d                	li	a0,-1
    80003fda:	bfcd                	j	80003fcc <filestat+0x52>

0000000080003fdc <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003fdc:	7179                	addi	sp,sp,-48
    80003fde:	f406                	sd	ra,40(sp)
    80003fe0:	f022                	sd	s0,32(sp)
    80003fe2:	e84a                	sd	s2,16(sp)
    80003fe4:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003fe6:	00854783          	lbu	a5,8(a0)
    80003fea:	cfd1                	beqz	a5,80004086 <fileread+0xaa>
    80003fec:	ec26                	sd	s1,24(sp)
    80003fee:	e44e                	sd	s3,8(sp)
    80003ff0:	84aa                	mv	s1,a0
    80003ff2:	89ae                	mv	s3,a1
    80003ff4:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003ff6:	411c                	lw	a5,0(a0)
    80003ff8:	4705                	li	a4,1
    80003ffa:	04e78363          	beq	a5,a4,80004040 <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003ffe:	470d                	li	a4,3
    80004000:	04e78763          	beq	a5,a4,8000404e <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80004004:	4709                	li	a4,2
    80004006:	06e79a63          	bne	a5,a4,8000407a <fileread+0x9e>
    ilock(f->ip);
    8000400a:	6d08                	ld	a0,24(a0)
    8000400c:	9deff0ef          	jal	800031ea <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80004010:	874a                	mv	a4,s2
    80004012:	5094                	lw	a3,32(s1)
    80004014:	864e                	mv	a2,s3
    80004016:	4585                	li	a1,1
    80004018:	6c88                	ld	a0,24(s1)
    8000401a:	c28ff0ef          	jal	80003442 <readi>
    8000401e:	892a                	mv	s2,a0
    80004020:	00a05563          	blez	a0,8000402a <fileread+0x4e>
      f->off += r;
    80004024:	509c                	lw	a5,32(s1)
    80004026:	9fa9                	addw	a5,a5,a0
    80004028:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    8000402a:	6c88                	ld	a0,24(s1)
    8000402c:	a6cff0ef          	jal	80003298 <iunlock>
    80004030:	64e2                	ld	s1,24(sp)
    80004032:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    80004034:	854a                	mv	a0,s2
    80004036:	70a2                	ld	ra,40(sp)
    80004038:	7402                	ld	s0,32(sp)
    8000403a:	6942                	ld	s2,16(sp)
    8000403c:	6145                	addi	sp,sp,48
    8000403e:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80004040:	6908                	ld	a0,16(a0)
    80004042:	3a2000ef          	jal	800043e4 <piperead>
    80004046:	892a                	mv	s2,a0
    80004048:	64e2                	ld	s1,24(sp)
    8000404a:	69a2                	ld	s3,8(sp)
    8000404c:	b7e5                	j	80004034 <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    8000404e:	02451783          	lh	a5,36(a0)
    80004052:	03079693          	slli	a3,a5,0x30
    80004056:	92c1                	srli	a3,a3,0x30
    80004058:	4725                	li	a4,9
    8000405a:	02d76863          	bltu	a4,a3,8000408a <fileread+0xae>
    8000405e:	0792                	slli	a5,a5,0x4
    80004060:	0001e717          	auipc	a4,0x1e
    80004064:	46870713          	addi	a4,a4,1128 # 800224c8 <devsw>
    80004068:	97ba                	add	a5,a5,a4
    8000406a:	639c                	ld	a5,0(a5)
    8000406c:	c39d                	beqz	a5,80004092 <fileread+0xb6>
    r = devsw[f->major].read(1, addr, n);
    8000406e:	4505                	li	a0,1
    80004070:	9782                	jalr	a5
    80004072:	892a                	mv	s2,a0
    80004074:	64e2                	ld	s1,24(sp)
    80004076:	69a2                	ld	s3,8(sp)
    80004078:	bf75                	j	80004034 <fileread+0x58>
    panic("fileread");
    8000407a:	00003517          	auipc	a0,0x3
    8000407e:	55e50513          	addi	a0,a0,1374 # 800075d8 <etext+0x5d8>
    80004082:	f60fc0ef          	jal	800007e2 <panic>
    return -1;
    80004086:	597d                	li	s2,-1
    80004088:	b775                	j	80004034 <fileread+0x58>
      return -1;
    8000408a:	597d                	li	s2,-1
    8000408c:	64e2                	ld	s1,24(sp)
    8000408e:	69a2                	ld	s3,8(sp)
    80004090:	b755                	j	80004034 <fileread+0x58>
    80004092:	597d                	li	s2,-1
    80004094:	64e2                	ld	s1,24(sp)
    80004096:	69a2                	ld	s3,8(sp)
    80004098:	bf71                	j	80004034 <fileread+0x58>

000000008000409a <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    8000409a:	00954783          	lbu	a5,9(a0)
    8000409e:	10078e63          	beqz	a5,800041ba <filewrite+0x120>
{
    800040a2:	711d                	addi	sp,sp,-96
    800040a4:	ec86                	sd	ra,88(sp)
    800040a6:	e8a2                	sd	s0,80(sp)
    800040a8:	e0ca                	sd	s2,64(sp)
    800040aa:	f456                	sd	s5,40(sp)
    800040ac:	f05a                	sd	s6,32(sp)
    800040ae:	1080                	addi	s0,sp,96
    800040b0:	892a                	mv	s2,a0
    800040b2:	8b2e                	mv	s6,a1
    800040b4:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    800040b6:	411c                	lw	a5,0(a0)
    800040b8:	4705                	li	a4,1
    800040ba:	02e78963          	beq	a5,a4,800040ec <filewrite+0x52>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    800040be:	470d                	li	a4,3
    800040c0:	02e78a63          	beq	a5,a4,800040f4 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    800040c4:	4709                	li	a4,2
    800040c6:	0ce79e63          	bne	a5,a4,800041a2 <filewrite+0x108>
    800040ca:	f852                	sd	s4,48(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    800040cc:	0ac05963          	blez	a2,8000417e <filewrite+0xe4>
    800040d0:	e4a6                	sd	s1,72(sp)
    800040d2:	fc4e                	sd	s3,56(sp)
    800040d4:	ec5e                	sd	s7,24(sp)
    800040d6:	e862                	sd	s8,16(sp)
    800040d8:	e466                	sd	s9,8(sp)
    int i = 0;
    800040da:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    800040dc:	6b85                	lui	s7,0x1
    800040de:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    800040e2:	6c85                	lui	s9,0x1
    800040e4:	c00c8c9b          	addiw	s9,s9,-1024 # c00 <_entry-0x7ffff400>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800040e8:	4c05                	li	s8,1
    800040ea:	a8ad                	j	80004164 <filewrite+0xca>
    ret = pipewrite(f->pipe, addr, n);
    800040ec:	6908                	ld	a0,16(a0)
    800040ee:	1fe000ef          	jal	800042ec <pipewrite>
    800040f2:	a04d                	j	80004194 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    800040f4:	02451783          	lh	a5,36(a0)
    800040f8:	03079693          	slli	a3,a5,0x30
    800040fc:	92c1                	srli	a3,a3,0x30
    800040fe:	4725                	li	a4,9
    80004100:	0ad76f63          	bltu	a4,a3,800041be <filewrite+0x124>
    80004104:	0792                	slli	a5,a5,0x4
    80004106:	0001e717          	auipc	a4,0x1e
    8000410a:	3c270713          	addi	a4,a4,962 # 800224c8 <devsw>
    8000410e:	97ba                	add	a5,a5,a4
    80004110:	679c                	ld	a5,8(a5)
    80004112:	cbc5                	beqz	a5,800041c2 <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    80004114:	4505                	li	a0,1
    80004116:	9782                	jalr	a5
    80004118:	a8b5                	j	80004194 <filewrite+0xfa>
      if(n1 > max)
    8000411a:	2981                	sext.w	s3,s3
      begin_op();
    8000411c:	981ff0ef          	jal	80003a9c <begin_op>
      ilock(f->ip);
    80004120:	01893503          	ld	a0,24(s2)
    80004124:	8c6ff0ef          	jal	800031ea <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80004128:	874e                	mv	a4,s3
    8000412a:	02092683          	lw	a3,32(s2)
    8000412e:	016a0633          	add	a2,s4,s6
    80004132:	85e2                	mv	a1,s8
    80004134:	01893503          	ld	a0,24(s2)
    80004138:	bfcff0ef          	jal	80003534 <writei>
    8000413c:	84aa                	mv	s1,a0
    8000413e:	00a05763          	blez	a0,8000414c <filewrite+0xb2>
        f->off += r;
    80004142:	02092783          	lw	a5,32(s2)
    80004146:	9fa9                	addw	a5,a5,a0
    80004148:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    8000414c:	01893503          	ld	a0,24(s2)
    80004150:	948ff0ef          	jal	80003298 <iunlock>
      end_op();
    80004154:	9b3ff0ef          	jal	80003b06 <end_op>

      if(r != n1){
    80004158:	02999563          	bne	s3,s1,80004182 <filewrite+0xe8>
        // error from writei
        break;
      }
      i += r;
    8000415c:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    80004160:	015a5963          	bge	s4,s5,80004172 <filewrite+0xd8>
      int n1 = n - i;
    80004164:	414a87bb          	subw	a5,s5,s4
    80004168:	89be                	mv	s3,a5
      if(n1 > max)
    8000416a:	fafbd8e3          	bge	s7,a5,8000411a <filewrite+0x80>
    8000416e:	89e6                	mv	s3,s9
    80004170:	b76d                	j	8000411a <filewrite+0x80>
    80004172:	64a6                	ld	s1,72(sp)
    80004174:	79e2                	ld	s3,56(sp)
    80004176:	6be2                	ld	s7,24(sp)
    80004178:	6c42                	ld	s8,16(sp)
    8000417a:	6ca2                	ld	s9,8(sp)
    8000417c:	a801                	j	8000418c <filewrite+0xf2>
    int i = 0;
    8000417e:	4a01                	li	s4,0
    80004180:	a031                	j	8000418c <filewrite+0xf2>
    80004182:	64a6                	ld	s1,72(sp)
    80004184:	79e2                	ld	s3,56(sp)
    80004186:	6be2                	ld	s7,24(sp)
    80004188:	6c42                	ld	s8,16(sp)
    8000418a:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    8000418c:	034a9d63          	bne	s5,s4,800041c6 <filewrite+0x12c>
    80004190:	8556                	mv	a0,s5
    80004192:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004194:	60e6                	ld	ra,88(sp)
    80004196:	6446                	ld	s0,80(sp)
    80004198:	6906                	ld	s2,64(sp)
    8000419a:	7aa2                	ld	s5,40(sp)
    8000419c:	7b02                	ld	s6,32(sp)
    8000419e:	6125                	addi	sp,sp,96
    800041a0:	8082                	ret
    800041a2:	e4a6                	sd	s1,72(sp)
    800041a4:	fc4e                	sd	s3,56(sp)
    800041a6:	f852                	sd	s4,48(sp)
    800041a8:	ec5e                	sd	s7,24(sp)
    800041aa:	e862                	sd	s8,16(sp)
    800041ac:	e466                	sd	s9,8(sp)
    panic("filewrite");
    800041ae:	00003517          	auipc	a0,0x3
    800041b2:	43a50513          	addi	a0,a0,1082 # 800075e8 <etext+0x5e8>
    800041b6:	e2cfc0ef          	jal	800007e2 <panic>
    return -1;
    800041ba:	557d                	li	a0,-1
}
    800041bc:	8082                	ret
      return -1;
    800041be:	557d                	li	a0,-1
    800041c0:	bfd1                	j	80004194 <filewrite+0xfa>
    800041c2:	557d                	li	a0,-1
    800041c4:	bfc1                	j	80004194 <filewrite+0xfa>
    ret = (i == n ? n : -1);
    800041c6:	557d                	li	a0,-1
    800041c8:	7a42                	ld	s4,48(sp)
    800041ca:	b7e9                	j	80004194 <filewrite+0xfa>

00000000800041cc <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    800041cc:	7179                	addi	sp,sp,-48
    800041ce:	f406                	sd	ra,40(sp)
    800041d0:	f022                	sd	s0,32(sp)
    800041d2:	ec26                	sd	s1,24(sp)
    800041d4:	e052                	sd	s4,0(sp)
    800041d6:	1800                	addi	s0,sp,48
    800041d8:	84aa                	mv	s1,a0
    800041da:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    800041dc:	0005b023          	sd	zero,0(a1)
    800041e0:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    800041e4:	c35ff0ef          	jal	80003e18 <filealloc>
    800041e8:	e088                	sd	a0,0(s1)
    800041ea:	c549                	beqz	a0,80004274 <pipealloc+0xa8>
    800041ec:	c2dff0ef          	jal	80003e18 <filealloc>
    800041f0:	00aa3023          	sd	a0,0(s4)
    800041f4:	cd25                	beqz	a0,8000426c <pipealloc+0xa0>
    800041f6:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    800041f8:	977fc0ef          	jal	80000b6e <kalloc>
    800041fc:	892a                	mv	s2,a0
    800041fe:	c12d                	beqz	a0,80004260 <pipealloc+0x94>
    80004200:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80004202:	4985                	li	s3,1
    80004204:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80004208:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    8000420c:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80004210:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80004214:	00003597          	auipc	a1,0x3
    80004218:	3e458593          	addi	a1,a1,996 # 800075f8 <etext+0x5f8>
    8000421c:	9a3fc0ef          	jal	80000bbe <initlock>
  (*f0)->type = FD_PIPE;
    80004220:	609c                	ld	a5,0(s1)
    80004222:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80004226:	609c                	ld	a5,0(s1)
    80004228:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    8000422c:	609c                	ld	a5,0(s1)
    8000422e:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80004232:	609c                	ld	a5,0(s1)
    80004234:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80004238:	000a3783          	ld	a5,0(s4)
    8000423c:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80004240:	000a3783          	ld	a5,0(s4)
    80004244:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80004248:	000a3783          	ld	a5,0(s4)
    8000424c:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80004250:	000a3783          	ld	a5,0(s4)
    80004254:	0127b823          	sd	s2,16(a5)
  return 0;
    80004258:	4501                	li	a0,0
    8000425a:	6942                	ld	s2,16(sp)
    8000425c:	69a2                	ld	s3,8(sp)
    8000425e:	a01d                	j	80004284 <pipealloc+0xb8>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004260:	6088                	ld	a0,0(s1)
    80004262:	c119                	beqz	a0,80004268 <pipealloc+0x9c>
    80004264:	6942                	ld	s2,16(sp)
    80004266:	a029                	j	80004270 <pipealloc+0xa4>
    80004268:	6942                	ld	s2,16(sp)
    8000426a:	a029                	j	80004274 <pipealloc+0xa8>
    8000426c:	6088                	ld	a0,0(s1)
    8000426e:	c10d                	beqz	a0,80004290 <pipealloc+0xc4>
    fileclose(*f0);
    80004270:	c4dff0ef          	jal	80003ebc <fileclose>
  if(*f1)
    80004274:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004278:	557d                	li	a0,-1
  if(*f1)
    8000427a:	c789                	beqz	a5,80004284 <pipealloc+0xb8>
    fileclose(*f1);
    8000427c:	853e                	mv	a0,a5
    8000427e:	c3fff0ef          	jal	80003ebc <fileclose>
  return -1;
    80004282:	557d                	li	a0,-1
}
    80004284:	70a2                	ld	ra,40(sp)
    80004286:	7402                	ld	s0,32(sp)
    80004288:	64e2                	ld	s1,24(sp)
    8000428a:	6a02                	ld	s4,0(sp)
    8000428c:	6145                	addi	sp,sp,48
    8000428e:	8082                	ret
  return -1;
    80004290:	557d                	li	a0,-1
    80004292:	bfcd                	j	80004284 <pipealloc+0xb8>

0000000080004294 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004294:	1101                	addi	sp,sp,-32
    80004296:	ec06                	sd	ra,24(sp)
    80004298:	e822                	sd	s0,16(sp)
    8000429a:	e426                	sd	s1,8(sp)
    8000429c:	e04a                	sd	s2,0(sp)
    8000429e:	1000                	addi	s0,sp,32
    800042a0:	84aa                	mv	s1,a0
    800042a2:	892e                	mv	s2,a1
  acquire(&pi->lock);
    800042a4:	99ffc0ef          	jal	80000c42 <acquire>
  if(writable){
    800042a8:	02090763          	beqz	s2,800042d6 <pipeclose+0x42>
    pi->writeopen = 0;
    800042ac:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    800042b0:	21848513          	addi	a0,s1,536
    800042b4:	c87fd0ef          	jal	80001f3a <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800042b8:	2204b783          	ld	a5,544(s1)
    800042bc:	e785                	bnez	a5,800042e4 <pipeclose+0x50>
    release(&pi->lock);
    800042be:	8526                	mv	a0,s1
    800042c0:	a17fc0ef          	jal	80000cd6 <release>
    kfree((char*)pi);
    800042c4:	8526                	mv	a0,s1
    800042c6:	fc6fc0ef          	jal	80000a8c <kfree>
  } else
    release(&pi->lock);
}
    800042ca:	60e2                	ld	ra,24(sp)
    800042cc:	6442                	ld	s0,16(sp)
    800042ce:	64a2                	ld	s1,8(sp)
    800042d0:	6902                	ld	s2,0(sp)
    800042d2:	6105                	addi	sp,sp,32
    800042d4:	8082                	ret
    pi->readopen = 0;
    800042d6:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    800042da:	21c48513          	addi	a0,s1,540
    800042de:	c5dfd0ef          	jal	80001f3a <wakeup>
    800042e2:	bfd9                	j	800042b8 <pipeclose+0x24>
    release(&pi->lock);
    800042e4:	8526                	mv	a0,s1
    800042e6:	9f1fc0ef          	jal	80000cd6 <release>
}
    800042ea:	b7c5                	j	800042ca <pipeclose+0x36>

00000000800042ec <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800042ec:	7159                	addi	sp,sp,-112
    800042ee:	f486                	sd	ra,104(sp)
    800042f0:	f0a2                	sd	s0,96(sp)
    800042f2:	eca6                	sd	s1,88(sp)
    800042f4:	e8ca                	sd	s2,80(sp)
    800042f6:	e4ce                	sd	s3,72(sp)
    800042f8:	e0d2                	sd	s4,64(sp)
    800042fa:	fc56                	sd	s5,56(sp)
    800042fc:	1880                	addi	s0,sp,112
    800042fe:	84aa                	mv	s1,a0
    80004300:	8aae                	mv	s5,a1
    80004302:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80004304:	e1cfd0ef          	jal	80001920 <myproc>
    80004308:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    8000430a:	8526                	mv	a0,s1
    8000430c:	937fc0ef          	jal	80000c42 <acquire>
  while(i < n){
    80004310:	0d405263          	blez	s4,800043d4 <pipewrite+0xe8>
    80004314:	f85a                	sd	s6,48(sp)
    80004316:	f45e                	sd	s7,40(sp)
    80004318:	f062                	sd	s8,32(sp)
    8000431a:	ec66                	sd	s9,24(sp)
    8000431c:	e86a                	sd	s10,16(sp)
  int i = 0;
    8000431e:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004320:	f9f40c13          	addi	s8,s0,-97
    80004324:	4b85                	li	s7,1
    80004326:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80004328:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    8000432c:	21c48c93          	addi	s9,s1,540
    80004330:	a82d                	j	8000436a <pipewrite+0x7e>
      release(&pi->lock);
    80004332:	8526                	mv	a0,s1
    80004334:	9a3fc0ef          	jal	80000cd6 <release>
      return -1;
    80004338:	597d                	li	s2,-1
    8000433a:	7b42                	ld	s6,48(sp)
    8000433c:	7ba2                	ld	s7,40(sp)
    8000433e:	7c02                	ld	s8,32(sp)
    80004340:	6ce2                	ld	s9,24(sp)
    80004342:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004344:	854a                	mv	a0,s2
    80004346:	70a6                	ld	ra,104(sp)
    80004348:	7406                	ld	s0,96(sp)
    8000434a:	64e6                	ld	s1,88(sp)
    8000434c:	6946                	ld	s2,80(sp)
    8000434e:	69a6                	ld	s3,72(sp)
    80004350:	6a06                	ld	s4,64(sp)
    80004352:	7ae2                	ld	s5,56(sp)
    80004354:	6165                	addi	sp,sp,112
    80004356:	8082                	ret
      wakeup(&pi->nread);
    80004358:	856a                	mv	a0,s10
    8000435a:	be1fd0ef          	jal	80001f3a <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000435e:	85a6                	mv	a1,s1
    80004360:	8566                	mv	a0,s9
    80004362:	b8dfd0ef          	jal	80001eee <sleep>
  while(i < n){
    80004366:	05495a63          	bge	s2,s4,800043ba <pipewrite+0xce>
    if(pi->readopen == 0 || killed(pr)){
    8000436a:	2204a783          	lw	a5,544(s1)
    8000436e:	d3f1                	beqz	a5,80004332 <pipewrite+0x46>
    80004370:	854e                	mv	a0,s3
    80004372:	db5fd0ef          	jal	80002126 <killed>
    80004376:	fd55                	bnez	a0,80004332 <pipewrite+0x46>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004378:	2184a783          	lw	a5,536(s1)
    8000437c:	21c4a703          	lw	a4,540(s1)
    80004380:	2007879b          	addiw	a5,a5,512
    80004384:	fcf70ae3          	beq	a4,a5,80004358 <pipewrite+0x6c>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004388:	86de                	mv	a3,s7
    8000438a:	01590633          	add	a2,s2,s5
    8000438e:	85e2                	mv	a1,s8
    80004390:	0509b503          	ld	a0,80(s3)
    80004394:	ae4fd0ef          	jal	80001678 <copyin>
    80004398:	05650063          	beq	a0,s6,800043d8 <pipewrite+0xec>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    8000439c:	21c4a783          	lw	a5,540(s1)
    800043a0:	0017871b          	addiw	a4,a5,1
    800043a4:	20e4ae23          	sw	a4,540(s1)
    800043a8:	1ff7f793          	andi	a5,a5,511
    800043ac:	97a6                	add	a5,a5,s1
    800043ae:	f9f44703          	lbu	a4,-97(s0)
    800043b2:	00e78c23          	sb	a4,24(a5)
      i++;
    800043b6:	2905                	addiw	s2,s2,1
    800043b8:	b77d                	j	80004366 <pipewrite+0x7a>
    800043ba:	7b42                	ld	s6,48(sp)
    800043bc:	7ba2                	ld	s7,40(sp)
    800043be:	7c02                	ld	s8,32(sp)
    800043c0:	6ce2                	ld	s9,24(sp)
    800043c2:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    800043c4:	21848513          	addi	a0,s1,536
    800043c8:	b73fd0ef          	jal	80001f3a <wakeup>
  release(&pi->lock);
    800043cc:	8526                	mv	a0,s1
    800043ce:	909fc0ef          	jal	80000cd6 <release>
  return i;
    800043d2:	bf8d                	j	80004344 <pipewrite+0x58>
  int i = 0;
    800043d4:	4901                	li	s2,0
    800043d6:	b7fd                	j	800043c4 <pipewrite+0xd8>
    800043d8:	7b42                	ld	s6,48(sp)
    800043da:	7ba2                	ld	s7,40(sp)
    800043dc:	7c02                	ld	s8,32(sp)
    800043de:	6ce2                	ld	s9,24(sp)
    800043e0:	6d42                	ld	s10,16(sp)
    800043e2:	b7cd                	j	800043c4 <pipewrite+0xd8>

00000000800043e4 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800043e4:	711d                	addi	sp,sp,-96
    800043e6:	ec86                	sd	ra,88(sp)
    800043e8:	e8a2                	sd	s0,80(sp)
    800043ea:	e4a6                	sd	s1,72(sp)
    800043ec:	e0ca                	sd	s2,64(sp)
    800043ee:	fc4e                	sd	s3,56(sp)
    800043f0:	f852                	sd	s4,48(sp)
    800043f2:	f456                	sd	s5,40(sp)
    800043f4:	1080                	addi	s0,sp,96
    800043f6:	84aa                	mv	s1,a0
    800043f8:	892e                	mv	s2,a1
    800043fa:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800043fc:	d24fd0ef          	jal	80001920 <myproc>
    80004400:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004402:	8526                	mv	a0,s1
    80004404:	83ffc0ef          	jal	80000c42 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004408:	2184a703          	lw	a4,536(s1)
    8000440c:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004410:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004414:	02f71763          	bne	a4,a5,80004442 <piperead+0x5e>
    80004418:	2244a783          	lw	a5,548(s1)
    8000441c:	cf85                	beqz	a5,80004454 <piperead+0x70>
    if(killed(pr)){
    8000441e:	8552                	mv	a0,s4
    80004420:	d07fd0ef          	jal	80002126 <killed>
    80004424:	e11d                	bnez	a0,8000444a <piperead+0x66>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004426:	85a6                	mv	a1,s1
    80004428:	854e                	mv	a0,s3
    8000442a:	ac5fd0ef          	jal	80001eee <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000442e:	2184a703          	lw	a4,536(s1)
    80004432:	21c4a783          	lw	a5,540(s1)
    80004436:	fef701e3          	beq	a4,a5,80004418 <piperead+0x34>
    8000443a:	f05a                	sd	s6,32(sp)
    8000443c:	ec5e                	sd	s7,24(sp)
    8000443e:	e862                	sd	s8,16(sp)
    80004440:	a829                	j	8000445a <piperead+0x76>
    80004442:	f05a                	sd	s6,32(sp)
    80004444:	ec5e                	sd	s7,24(sp)
    80004446:	e862                	sd	s8,16(sp)
    80004448:	a809                	j	8000445a <piperead+0x76>
      release(&pi->lock);
    8000444a:	8526                	mv	a0,s1
    8000444c:	88bfc0ef          	jal	80000cd6 <release>
      return -1;
    80004450:	59fd                	li	s3,-1
    80004452:	a0a5                	j	800044ba <piperead+0xd6>
    80004454:	f05a                	sd	s6,32(sp)
    80004456:	ec5e                	sd	s7,24(sp)
    80004458:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000445a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000445c:	faf40c13          	addi	s8,s0,-81
    80004460:	4b85                	li	s7,1
    80004462:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004464:	05505163          	blez	s5,800044a6 <piperead+0xc2>
    if(pi->nread == pi->nwrite)
    80004468:	2184a783          	lw	a5,536(s1)
    8000446c:	21c4a703          	lw	a4,540(s1)
    80004470:	02f70b63          	beq	a4,a5,800044a6 <piperead+0xc2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004474:	0017871b          	addiw	a4,a5,1
    80004478:	20e4ac23          	sw	a4,536(s1)
    8000447c:	1ff7f793          	andi	a5,a5,511
    80004480:	97a6                	add	a5,a5,s1
    80004482:	0187c783          	lbu	a5,24(a5)
    80004486:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000448a:	86de                	mv	a3,s7
    8000448c:	8662                	mv	a2,s8
    8000448e:	85ca                	mv	a1,s2
    80004490:	050a3503          	ld	a0,80(s4)
    80004494:	934fd0ef          	jal	800015c8 <copyout>
    80004498:	01650763          	beq	a0,s6,800044a6 <piperead+0xc2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000449c:	2985                	addiw	s3,s3,1
    8000449e:	0905                	addi	s2,s2,1
    800044a0:	fd3a94e3          	bne	s5,s3,80004468 <piperead+0x84>
    800044a4:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800044a6:	21c48513          	addi	a0,s1,540
    800044aa:	a91fd0ef          	jal	80001f3a <wakeup>
  release(&pi->lock);
    800044ae:	8526                	mv	a0,s1
    800044b0:	827fc0ef          	jal	80000cd6 <release>
    800044b4:	7b02                	ld	s6,32(sp)
    800044b6:	6be2                	ld	s7,24(sp)
    800044b8:	6c42                	ld	s8,16(sp)
  return i;
}
    800044ba:	854e                	mv	a0,s3
    800044bc:	60e6                	ld	ra,88(sp)
    800044be:	6446                	ld	s0,80(sp)
    800044c0:	64a6                	ld	s1,72(sp)
    800044c2:	6906                	ld	s2,64(sp)
    800044c4:	79e2                	ld	s3,56(sp)
    800044c6:	7a42                	ld	s4,48(sp)
    800044c8:	7aa2                	ld	s5,40(sp)
    800044ca:	6125                	addi	sp,sp,96
    800044cc:	8082                	ret

00000000800044ce <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    800044ce:	1141                	addi	sp,sp,-16
    800044d0:	e406                	sd	ra,8(sp)
    800044d2:	e022                	sd	s0,0(sp)
    800044d4:	0800                	addi	s0,sp,16
    800044d6:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    800044d8:	0035151b          	slliw	a0,a0,0x3
    800044dc:	8921                	andi	a0,a0,8
      perm = PTE_X;
    if(flags & 0x2)
    800044de:	8b89                	andi	a5,a5,2
    800044e0:	c399                	beqz	a5,800044e6 <flags2perm+0x18>
      perm |= PTE_W;
    800044e2:	00456513          	ori	a0,a0,4
    return perm;
}
    800044e6:	60a2                	ld	ra,8(sp)
    800044e8:	6402                	ld	s0,0(sp)
    800044ea:	0141                	addi	sp,sp,16
    800044ec:	8082                	ret

00000000800044ee <exec>:

int
exec(char *path, char **argv)
{
    800044ee:	de010113          	addi	sp,sp,-544
    800044f2:	20113c23          	sd	ra,536(sp)
    800044f6:	20813823          	sd	s0,528(sp)
    800044fa:	20913423          	sd	s1,520(sp)
    800044fe:	21213023          	sd	s2,512(sp)
    80004502:	1400                	addi	s0,sp,544
    80004504:	892a                	mv	s2,a0
    80004506:	dea43823          	sd	a0,-528(s0)
    8000450a:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    8000450e:	c12fd0ef          	jal	80001920 <myproc>
    80004512:	84aa                	mv	s1,a0

  begin_op();
    80004514:	d88ff0ef          	jal	80003a9c <begin_op>

  if((ip = namei(path)) == 0){
    80004518:	854a                	mv	a0,s2
    8000451a:	bc0ff0ef          	jal	800038da <namei>
    8000451e:	cd21                	beqz	a0,80004576 <exec+0x88>
    80004520:	fbd2                	sd	s4,496(sp)
    80004522:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004524:	cc7fe0ef          	jal	800031ea <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004528:	04000713          	li	a4,64
    8000452c:	4681                	li	a3,0
    8000452e:	e5040613          	addi	a2,s0,-432
    80004532:	4581                	li	a1,0
    80004534:	8552                	mv	a0,s4
    80004536:	f0dfe0ef          	jal	80003442 <readi>
    8000453a:	04000793          	li	a5,64
    8000453e:	00f51a63          	bne	a0,a5,80004552 <exec+0x64>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    80004542:	e5042703          	lw	a4,-432(s0)
    80004546:	464c47b7          	lui	a5,0x464c4
    8000454a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000454e:	02f70863          	beq	a4,a5,8000457e <exec+0x90>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004552:	8552                	mv	a0,s4
    80004554:	ea1fe0ef          	jal	800033f4 <iunlockput>
    end_op();
    80004558:	daeff0ef          	jal	80003b06 <end_op>
  }
  return -1;
    8000455c:	557d                	li	a0,-1
    8000455e:	7a5e                	ld	s4,496(sp)
}
    80004560:	21813083          	ld	ra,536(sp)
    80004564:	21013403          	ld	s0,528(sp)
    80004568:	20813483          	ld	s1,520(sp)
    8000456c:	20013903          	ld	s2,512(sp)
    80004570:	22010113          	addi	sp,sp,544
    80004574:	8082                	ret
    end_op();
    80004576:	d90ff0ef          	jal	80003b06 <end_op>
    return -1;
    8000457a:	557d                	li	a0,-1
    8000457c:	b7d5                	j	80004560 <exec+0x72>
    8000457e:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80004580:	8526                	mv	a0,s1
    80004582:	c46fd0ef          	jal	800019c8 <proc_pagetable>
    80004586:	8b2a                	mv	s6,a0
    80004588:	26050d63          	beqz	a0,80004802 <exec+0x314>
    8000458c:	ffce                	sd	s3,504(sp)
    8000458e:	f7d6                	sd	s5,488(sp)
    80004590:	efde                	sd	s7,472(sp)
    80004592:	ebe2                	sd	s8,464(sp)
    80004594:	e7e6                	sd	s9,456(sp)
    80004596:	e3ea                	sd	s10,448(sp)
    80004598:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000459a:	e7042683          	lw	a3,-400(s0)
    8000459e:	e8845783          	lhu	a5,-376(s0)
    800045a2:	0e078763          	beqz	a5,80004690 <exec+0x1a2>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800045a6:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800045a8:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800045aa:	03800d93          	li	s11,56
    if(ph.vaddr % PGSIZE != 0)
    800045ae:	6c85                	lui	s9,0x1
    800045b0:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800045b4:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    800045b8:	6a85                	lui	s5,0x1
    800045ba:	a085                	j	8000461a <exec+0x12c>
      panic("loadseg: address should exist");
    800045bc:	00003517          	auipc	a0,0x3
    800045c0:	04450513          	addi	a0,a0,68 # 80007600 <etext+0x600>
    800045c4:	a1efc0ef          	jal	800007e2 <panic>
    if(sz - i < PGSIZE)
    800045c8:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800045ca:	874a                	mv	a4,s2
    800045cc:	009c06bb          	addw	a3,s8,s1
    800045d0:	4581                	li	a1,0
    800045d2:	8552                	mv	a0,s4
    800045d4:	e6ffe0ef          	jal	80003442 <readi>
    800045d8:	22a91963          	bne	s2,a0,8000480a <exec+0x31c>
  for(i = 0; i < sz; i += PGSIZE){
    800045dc:	009a84bb          	addw	s1,s5,s1
    800045e0:	0334f263          	bgeu	s1,s3,80004604 <exec+0x116>
    pa = walkaddr(pagetable, va + i);
    800045e4:	02049593          	slli	a1,s1,0x20
    800045e8:	9181                	srli	a1,a1,0x20
    800045ea:	95de                	add	a1,a1,s7
    800045ec:	855a                	mv	a0,s6
    800045ee:	a53fc0ef          	jal	80001040 <walkaddr>
    800045f2:	862a                	mv	a2,a0
    if(pa == 0)
    800045f4:	d561                	beqz	a0,800045bc <exec+0xce>
    if(sz - i < PGSIZE)
    800045f6:	409987bb          	subw	a5,s3,s1
    800045fa:	893e                	mv	s2,a5
    800045fc:	fcfcf6e3          	bgeu	s9,a5,800045c8 <exec+0xda>
    80004600:	8956                	mv	s2,s5
    80004602:	b7d9                	j	800045c8 <exec+0xda>
    sz = sz1;
    80004604:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004608:	2d05                	addiw	s10,s10,1
    8000460a:	e0843783          	ld	a5,-504(s0)
    8000460e:	0387869b          	addiw	a3,a5,56
    80004612:	e8845783          	lhu	a5,-376(s0)
    80004616:	06fd5e63          	bge	s10,a5,80004692 <exec+0x1a4>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000461a:	e0d43423          	sd	a3,-504(s0)
    8000461e:	876e                	mv	a4,s11
    80004620:	e1840613          	addi	a2,s0,-488
    80004624:	4581                	li	a1,0
    80004626:	8552                	mv	a0,s4
    80004628:	e1bfe0ef          	jal	80003442 <readi>
    8000462c:	1db51d63          	bne	a0,s11,80004806 <exec+0x318>
    if(ph.type != ELF_PROG_LOAD)
    80004630:	e1842783          	lw	a5,-488(s0)
    80004634:	4705                	li	a4,1
    80004636:	fce799e3          	bne	a5,a4,80004608 <exec+0x11a>
    if(ph.memsz < ph.filesz)
    8000463a:	e4043483          	ld	s1,-448(s0)
    8000463e:	e3843783          	ld	a5,-456(s0)
    80004642:	1ef4e263          	bltu	s1,a5,80004826 <exec+0x338>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004646:	e2843783          	ld	a5,-472(s0)
    8000464a:	94be                	add	s1,s1,a5
    8000464c:	1ef4e063          	bltu	s1,a5,8000482c <exec+0x33e>
    if(ph.vaddr % PGSIZE != 0)
    80004650:	de843703          	ld	a4,-536(s0)
    80004654:	8ff9                	and	a5,a5,a4
    80004656:	1c079e63          	bnez	a5,80004832 <exec+0x344>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    8000465a:	e1c42503          	lw	a0,-484(s0)
    8000465e:	e71ff0ef          	jal	800044ce <flags2perm>
    80004662:	86aa                	mv	a3,a0
    80004664:	8626                	mv	a2,s1
    80004666:	85ca                	mv	a1,s2
    80004668:	855a                	mv	a0,s6
    8000466a:	d3ffc0ef          	jal	800013a8 <uvmalloc>
    8000466e:	dea43c23          	sd	a0,-520(s0)
    80004672:	1c050363          	beqz	a0,80004838 <exec+0x34a>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004676:	e2843b83          	ld	s7,-472(s0)
    8000467a:	e2042c03          	lw	s8,-480(s0)
    8000467e:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004682:	00098463          	beqz	s3,8000468a <exec+0x19c>
    80004686:	4481                	li	s1,0
    80004688:	bfb1                	j	800045e4 <exec+0xf6>
    sz = sz1;
    8000468a:	df843903          	ld	s2,-520(s0)
    8000468e:	bfad                	j	80004608 <exec+0x11a>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004690:	4901                	li	s2,0
  iunlockput(ip);
    80004692:	8552                	mv	a0,s4
    80004694:	d61fe0ef          	jal	800033f4 <iunlockput>
  end_op();
    80004698:	c6eff0ef          	jal	80003b06 <end_op>
  p = myproc();
    8000469c:	a84fd0ef          	jal	80001920 <myproc>
    800046a0:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800046a2:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800046a6:	6985                	lui	s3,0x1
    800046a8:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    800046aa:	99ca                	add	s3,s3,s2
    800046ac:	77fd                	lui	a5,0xfffff
    800046ae:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    800046b2:	4691                	li	a3,4
    800046b4:	6609                	lui	a2,0x2
    800046b6:	964e                	add	a2,a2,s3
    800046b8:	85ce                	mv	a1,s3
    800046ba:	855a                	mv	a0,s6
    800046bc:	cedfc0ef          	jal	800013a8 <uvmalloc>
    800046c0:	8a2a                	mv	s4,a0
    800046c2:	e105                	bnez	a0,800046e2 <exec+0x1f4>
    proc_freepagetable(pagetable, sz);
    800046c4:	85ce                	mv	a1,s3
    800046c6:	855a                	mv	a0,s6
    800046c8:	b84fd0ef          	jal	80001a4c <proc_freepagetable>
  return -1;
    800046cc:	557d                	li	a0,-1
    800046ce:	79fe                	ld	s3,504(sp)
    800046d0:	7a5e                	ld	s4,496(sp)
    800046d2:	7abe                	ld	s5,488(sp)
    800046d4:	7b1e                	ld	s6,480(sp)
    800046d6:	6bfe                	ld	s7,472(sp)
    800046d8:	6c5e                	ld	s8,464(sp)
    800046da:	6cbe                	ld	s9,456(sp)
    800046dc:	6d1e                	ld	s10,448(sp)
    800046de:	7dfa                	ld	s11,440(sp)
    800046e0:	b541                	j	80004560 <exec+0x72>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    800046e2:	75f9                	lui	a1,0xffffe
    800046e4:	95aa                	add	a1,a1,a0
    800046e6:	855a                	mv	a0,s6
    800046e8:	eb7fc0ef          	jal	8000159e <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    800046ec:	7bfd                	lui	s7,0xfffff
    800046ee:	9bd2                	add	s7,s7,s4
  for(argc = 0; argv[argc]; argc++) {
    800046f0:	e0043783          	ld	a5,-512(s0)
    800046f4:	6388                	ld	a0,0(a5)
  sp = sz;
    800046f6:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    800046f8:	4481                	li	s1,0
    ustack[argc] = sp;
    800046fa:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    800046fe:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    80004702:	cd21                	beqz	a0,8000475a <exec+0x26c>
    sp -= strlen(argv[argc]) + 1;
    80004704:	f96fc0ef          	jal	80000e9a <strlen>
    80004708:	0015079b          	addiw	a5,a0,1
    8000470c:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004710:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80004714:	13796563          	bltu	s2,s7,8000483e <exec+0x350>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004718:	e0043d83          	ld	s11,-512(s0)
    8000471c:	000db983          	ld	s3,0(s11)
    80004720:	854e                	mv	a0,s3
    80004722:	f78fc0ef          	jal	80000e9a <strlen>
    80004726:	0015069b          	addiw	a3,a0,1
    8000472a:	864e                	mv	a2,s3
    8000472c:	85ca                	mv	a1,s2
    8000472e:	855a                	mv	a0,s6
    80004730:	e99fc0ef          	jal	800015c8 <copyout>
    80004734:	10054763          	bltz	a0,80004842 <exec+0x354>
    ustack[argc] = sp;
    80004738:	00349793          	slli	a5,s1,0x3
    8000473c:	97e6                	add	a5,a5,s9
    8000473e:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffdb9a0>
  for(argc = 0; argv[argc]; argc++) {
    80004742:	0485                	addi	s1,s1,1
    80004744:	008d8793          	addi	a5,s11,8
    80004748:	e0f43023          	sd	a5,-512(s0)
    8000474c:	008db503          	ld	a0,8(s11)
    80004750:	c509                	beqz	a0,8000475a <exec+0x26c>
    if(argc >= MAXARG)
    80004752:	fb8499e3          	bne	s1,s8,80004704 <exec+0x216>
  sz = sz1;
    80004756:	89d2                	mv	s3,s4
    80004758:	b7b5                	j	800046c4 <exec+0x1d6>
  ustack[argc] = 0;
    8000475a:	00349793          	slli	a5,s1,0x3
    8000475e:	f9078793          	addi	a5,a5,-112
    80004762:	97a2                	add	a5,a5,s0
    80004764:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004768:	00148693          	addi	a3,s1,1
    8000476c:	068e                	slli	a3,a3,0x3
    8000476e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004772:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80004776:	89d2                	mv	s3,s4
  if(sp < stackbase)
    80004778:	f57966e3          	bltu	s2,s7,800046c4 <exec+0x1d6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000477c:	e9040613          	addi	a2,s0,-368
    80004780:	85ca                	mv	a1,s2
    80004782:	855a                	mv	a0,s6
    80004784:	e45fc0ef          	jal	800015c8 <copyout>
    80004788:	f2054ee3          	bltz	a0,800046c4 <exec+0x1d6>
  p->trapframe->a1 = sp;
    8000478c:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80004790:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004794:	df043783          	ld	a5,-528(s0)
    80004798:	0007c703          	lbu	a4,0(a5)
    8000479c:	cf11                	beqz	a4,800047b8 <exec+0x2ca>
    8000479e:	0785                	addi	a5,a5,1
    if(*s == '/')
    800047a0:	02f00693          	li	a3,47
    800047a4:	a029                	j	800047ae <exec+0x2c0>
  for(last=s=path; *s; s++)
    800047a6:	0785                	addi	a5,a5,1
    800047a8:	fff7c703          	lbu	a4,-1(a5)
    800047ac:	c711                	beqz	a4,800047b8 <exec+0x2ca>
    if(*s == '/')
    800047ae:	fed71ce3          	bne	a4,a3,800047a6 <exec+0x2b8>
      last = s+1;
    800047b2:	def43823          	sd	a5,-528(s0)
    800047b6:	bfc5                	j	800047a6 <exec+0x2b8>
  safestrcpy(p->name, last, sizeof(p->name));
    800047b8:	4641                	li	a2,16
    800047ba:	df043583          	ld	a1,-528(s0)
    800047be:	158a8513          	addi	a0,s5,344
    800047c2:	ea2fc0ef          	jal	80000e64 <safestrcpy>
  oldpagetable = p->pagetable;
    800047c6:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800047ca:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800047ce:	054ab423          	sd	s4,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800047d2:	058ab783          	ld	a5,88(s5)
    800047d6:	e6843703          	ld	a4,-408(s0)
    800047da:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800047dc:	058ab783          	ld	a5,88(s5)
    800047e0:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800047e4:	85ea                	mv	a1,s10
    800047e6:	a66fd0ef          	jal	80001a4c <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800047ea:	0004851b          	sext.w	a0,s1
    800047ee:	79fe                	ld	s3,504(sp)
    800047f0:	7a5e                	ld	s4,496(sp)
    800047f2:	7abe                	ld	s5,488(sp)
    800047f4:	7b1e                	ld	s6,480(sp)
    800047f6:	6bfe                	ld	s7,472(sp)
    800047f8:	6c5e                	ld	s8,464(sp)
    800047fa:	6cbe                	ld	s9,456(sp)
    800047fc:	6d1e                	ld	s10,448(sp)
    800047fe:	7dfa                	ld	s11,440(sp)
    80004800:	b385                	j	80004560 <exec+0x72>
    80004802:	7b1e                	ld	s6,480(sp)
    80004804:	b3b9                	j	80004552 <exec+0x64>
    80004806:	df243c23          	sd	s2,-520(s0)
    proc_freepagetable(pagetable, sz);
    8000480a:	df843583          	ld	a1,-520(s0)
    8000480e:	855a                	mv	a0,s6
    80004810:	a3cfd0ef          	jal	80001a4c <proc_freepagetable>
  if(ip){
    80004814:	79fe                	ld	s3,504(sp)
    80004816:	7abe                	ld	s5,488(sp)
    80004818:	7b1e                	ld	s6,480(sp)
    8000481a:	6bfe                	ld	s7,472(sp)
    8000481c:	6c5e                	ld	s8,464(sp)
    8000481e:	6cbe                	ld	s9,456(sp)
    80004820:	6d1e                	ld	s10,448(sp)
    80004822:	7dfa                	ld	s11,440(sp)
    80004824:	b33d                	j	80004552 <exec+0x64>
    80004826:	df243c23          	sd	s2,-520(s0)
    8000482a:	b7c5                	j	8000480a <exec+0x31c>
    8000482c:	df243c23          	sd	s2,-520(s0)
    80004830:	bfe9                	j	8000480a <exec+0x31c>
    80004832:	df243c23          	sd	s2,-520(s0)
    80004836:	bfd1                	j	8000480a <exec+0x31c>
    80004838:	df243c23          	sd	s2,-520(s0)
    8000483c:	b7f9                	j	8000480a <exec+0x31c>
  sz = sz1;
    8000483e:	89d2                	mv	s3,s4
    80004840:	b551                	j	800046c4 <exec+0x1d6>
    80004842:	89d2                	mv	s3,s4
    80004844:	b541                	j	800046c4 <exec+0x1d6>

0000000080004846 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80004846:	7179                	addi	sp,sp,-48
    80004848:	f406                	sd	ra,40(sp)
    8000484a:	f022                	sd	s0,32(sp)
    8000484c:	ec26                	sd	s1,24(sp)
    8000484e:	e84a                	sd	s2,16(sp)
    80004850:	1800                	addi	s0,sp,48
    80004852:	892e                	mv	s2,a1
    80004854:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80004856:	fdc40593          	addi	a1,s0,-36
    8000485a:	f79fd0ef          	jal	800027d2 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000485e:	fdc42703          	lw	a4,-36(s0)
    80004862:	47bd                	li	a5,15
    80004864:	02e7e963          	bltu	a5,a4,80004896 <argfd+0x50>
    80004868:	8b8fd0ef          	jal	80001920 <myproc>
    8000486c:	fdc42703          	lw	a4,-36(s0)
    80004870:	01a70793          	addi	a5,a4,26
    80004874:	078e                	slli	a5,a5,0x3
    80004876:	953e                	add	a0,a0,a5
    80004878:	611c                	ld	a5,0(a0)
    8000487a:	c385                	beqz	a5,8000489a <argfd+0x54>
    return -1;
  if(pfd)
    8000487c:	00090463          	beqz	s2,80004884 <argfd+0x3e>
    *pfd = fd;
    80004880:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004884:	4501                	li	a0,0
  if(pf)
    80004886:	c091                	beqz	s1,8000488a <argfd+0x44>
    *pf = f;
    80004888:	e09c                	sd	a5,0(s1)
}
    8000488a:	70a2                	ld	ra,40(sp)
    8000488c:	7402                	ld	s0,32(sp)
    8000488e:	64e2                	ld	s1,24(sp)
    80004890:	6942                	ld	s2,16(sp)
    80004892:	6145                	addi	sp,sp,48
    80004894:	8082                	ret
    return -1;
    80004896:	557d                	li	a0,-1
    80004898:	bfcd                	j	8000488a <argfd+0x44>
    8000489a:	557d                	li	a0,-1
    8000489c:	b7fd                	j	8000488a <argfd+0x44>

000000008000489e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    8000489e:	1101                	addi	sp,sp,-32
    800048a0:	ec06                	sd	ra,24(sp)
    800048a2:	e822                	sd	s0,16(sp)
    800048a4:	e426                	sd	s1,8(sp)
    800048a6:	1000                	addi	s0,sp,32
    800048a8:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800048aa:	876fd0ef          	jal	80001920 <myproc>
    800048ae:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800048b0:	0d050793          	addi	a5,a0,208
    800048b4:	4501                	li	a0,0
    800048b6:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800048b8:	6398                	ld	a4,0(a5)
    800048ba:	cb19                	beqz	a4,800048d0 <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    800048bc:	2505                	addiw	a0,a0,1
    800048be:	07a1                	addi	a5,a5,8
    800048c0:	fed51ce3          	bne	a0,a3,800048b8 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800048c4:	557d                	li	a0,-1
}
    800048c6:	60e2                	ld	ra,24(sp)
    800048c8:	6442                	ld	s0,16(sp)
    800048ca:	64a2                	ld	s1,8(sp)
    800048cc:	6105                	addi	sp,sp,32
    800048ce:	8082                	ret
      p->ofile[fd] = f;
    800048d0:	01a50793          	addi	a5,a0,26
    800048d4:	078e                	slli	a5,a5,0x3
    800048d6:	963e                	add	a2,a2,a5
    800048d8:	e204                	sd	s1,0(a2)
      return fd;
    800048da:	b7f5                	j	800048c6 <fdalloc+0x28>

00000000800048dc <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800048dc:	715d                	addi	sp,sp,-80
    800048de:	e486                	sd	ra,72(sp)
    800048e0:	e0a2                	sd	s0,64(sp)
    800048e2:	fc26                	sd	s1,56(sp)
    800048e4:	f84a                	sd	s2,48(sp)
    800048e6:	f44e                	sd	s3,40(sp)
    800048e8:	ec56                	sd	s5,24(sp)
    800048ea:	e85a                	sd	s6,16(sp)
    800048ec:	0880                	addi	s0,sp,80
    800048ee:	8b2e                	mv	s6,a1
    800048f0:	89b2                	mv	s3,a2
    800048f2:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800048f4:	fb040593          	addi	a1,s0,-80
    800048f8:	ffdfe0ef          	jal	800038f4 <nameiparent>
    800048fc:	84aa                	mv	s1,a0
    800048fe:	10050a63          	beqz	a0,80004a12 <create+0x136>
    return 0;

  ilock(dp);
    80004902:	8e9fe0ef          	jal	800031ea <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004906:	4601                	li	a2,0
    80004908:	fb040593          	addi	a1,s0,-80
    8000490c:	8526                	mv	a0,s1
    8000490e:	d41fe0ef          	jal	8000364e <dirlookup>
    80004912:	8aaa                	mv	s5,a0
    80004914:	c129                	beqz	a0,80004956 <create+0x7a>
    iunlockput(dp);
    80004916:	8526                	mv	a0,s1
    80004918:	addfe0ef          	jal	800033f4 <iunlockput>
    ilock(ip);
    8000491c:	8556                	mv	a0,s5
    8000491e:	8cdfe0ef          	jal	800031ea <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004922:	4789                	li	a5,2
    80004924:	02fb1463          	bne	s6,a5,8000494c <create+0x70>
    80004928:	044ad783          	lhu	a5,68(s5)
    8000492c:	37f9                	addiw	a5,a5,-2
    8000492e:	17c2                	slli	a5,a5,0x30
    80004930:	93c1                	srli	a5,a5,0x30
    80004932:	4705                	li	a4,1
    80004934:	00f76c63          	bltu	a4,a5,8000494c <create+0x70>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80004938:	8556                	mv	a0,s5
    8000493a:	60a6                	ld	ra,72(sp)
    8000493c:	6406                	ld	s0,64(sp)
    8000493e:	74e2                	ld	s1,56(sp)
    80004940:	7942                	ld	s2,48(sp)
    80004942:	79a2                	ld	s3,40(sp)
    80004944:	6ae2                	ld	s5,24(sp)
    80004946:	6b42                	ld	s6,16(sp)
    80004948:	6161                	addi	sp,sp,80
    8000494a:	8082                	ret
    iunlockput(ip);
    8000494c:	8556                	mv	a0,s5
    8000494e:	aa7fe0ef          	jal	800033f4 <iunlockput>
    return 0;
    80004952:	4a81                	li	s5,0
    80004954:	b7d5                	j	80004938 <create+0x5c>
    80004956:	f052                	sd	s4,32(sp)
  if((ip = ialloc(dp->dev, type)) == 0){
    80004958:	85da                	mv	a1,s6
    8000495a:	4088                	lw	a0,0(s1)
    8000495c:	f1efe0ef          	jal	8000307a <ialloc>
    80004960:	8a2a                	mv	s4,a0
    80004962:	cd15                	beqz	a0,8000499e <create+0xc2>
  ilock(ip);
    80004964:	887fe0ef          	jal	800031ea <ilock>
  ip->major = major;
    80004968:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    8000496c:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80004970:	4905                	li	s2,1
    80004972:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80004976:	8552                	mv	a0,s4
    80004978:	fbefe0ef          	jal	80003136 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000497c:	032b0763          	beq	s6,s2,800049aa <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80004980:	004a2603          	lw	a2,4(s4)
    80004984:	fb040593          	addi	a1,s0,-80
    80004988:	8526                	mv	a0,s1
    8000498a:	ea7fe0ef          	jal	80003830 <dirlink>
    8000498e:	06054563          	bltz	a0,800049f8 <create+0x11c>
  iunlockput(dp);
    80004992:	8526                	mv	a0,s1
    80004994:	a61fe0ef          	jal	800033f4 <iunlockput>
  return ip;
    80004998:	8ad2                	mv	s5,s4
    8000499a:	7a02                	ld	s4,32(sp)
    8000499c:	bf71                	j	80004938 <create+0x5c>
    iunlockput(dp);
    8000499e:	8526                	mv	a0,s1
    800049a0:	a55fe0ef          	jal	800033f4 <iunlockput>
    return 0;
    800049a4:	8ad2                	mv	s5,s4
    800049a6:	7a02                	ld	s4,32(sp)
    800049a8:	bf41                	j	80004938 <create+0x5c>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800049aa:	004a2603          	lw	a2,4(s4)
    800049ae:	00003597          	auipc	a1,0x3
    800049b2:	c7258593          	addi	a1,a1,-910 # 80007620 <etext+0x620>
    800049b6:	8552                	mv	a0,s4
    800049b8:	e79fe0ef          	jal	80003830 <dirlink>
    800049bc:	02054e63          	bltz	a0,800049f8 <create+0x11c>
    800049c0:	40d0                	lw	a2,4(s1)
    800049c2:	00003597          	auipc	a1,0x3
    800049c6:	c6658593          	addi	a1,a1,-922 # 80007628 <etext+0x628>
    800049ca:	8552                	mv	a0,s4
    800049cc:	e65fe0ef          	jal	80003830 <dirlink>
    800049d0:	02054463          	bltz	a0,800049f8 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    800049d4:	004a2603          	lw	a2,4(s4)
    800049d8:	fb040593          	addi	a1,s0,-80
    800049dc:	8526                	mv	a0,s1
    800049de:	e53fe0ef          	jal	80003830 <dirlink>
    800049e2:	00054b63          	bltz	a0,800049f8 <create+0x11c>
    dp->nlink++;  // for ".."
    800049e6:	04a4d783          	lhu	a5,74(s1)
    800049ea:	2785                	addiw	a5,a5,1
    800049ec:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    800049f0:	8526                	mv	a0,s1
    800049f2:	f44fe0ef          	jal	80003136 <iupdate>
    800049f6:	bf71                	j	80004992 <create+0xb6>
  ip->nlink = 0;
    800049f8:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    800049fc:	8552                	mv	a0,s4
    800049fe:	f38fe0ef          	jal	80003136 <iupdate>
  iunlockput(ip);
    80004a02:	8552                	mv	a0,s4
    80004a04:	9f1fe0ef          	jal	800033f4 <iunlockput>
  iunlockput(dp);
    80004a08:	8526                	mv	a0,s1
    80004a0a:	9ebfe0ef          	jal	800033f4 <iunlockput>
  return 0;
    80004a0e:	7a02                	ld	s4,32(sp)
    80004a10:	b725                	j	80004938 <create+0x5c>
    return 0;
    80004a12:	8aaa                	mv	s5,a0
    80004a14:	b715                	j	80004938 <create+0x5c>

0000000080004a16 <sys_dup>:
{
    80004a16:	7179                	addi	sp,sp,-48
    80004a18:	f406                	sd	ra,40(sp)
    80004a1a:	f022                	sd	s0,32(sp)
    80004a1c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004a1e:	fd840613          	addi	a2,s0,-40
    80004a22:	4581                	li	a1,0
    80004a24:	4501                	li	a0,0
    80004a26:	e21ff0ef          	jal	80004846 <argfd>
    return -1;
    80004a2a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80004a2c:	02054363          	bltz	a0,80004a52 <sys_dup+0x3c>
    80004a30:	ec26                	sd	s1,24(sp)
    80004a32:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80004a34:	fd843903          	ld	s2,-40(s0)
    80004a38:	854a                	mv	a0,s2
    80004a3a:	e65ff0ef          	jal	8000489e <fdalloc>
    80004a3e:	84aa                	mv	s1,a0
    return -1;
    80004a40:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004a42:	00054d63          	bltz	a0,80004a5c <sys_dup+0x46>
  filedup(f);
    80004a46:	854a                	mv	a0,s2
    80004a48:	c2eff0ef          	jal	80003e76 <filedup>
  return fd;
    80004a4c:	87a6                	mv	a5,s1
    80004a4e:	64e2                	ld	s1,24(sp)
    80004a50:	6942                	ld	s2,16(sp)
}
    80004a52:	853e                	mv	a0,a5
    80004a54:	70a2                	ld	ra,40(sp)
    80004a56:	7402                	ld	s0,32(sp)
    80004a58:	6145                	addi	sp,sp,48
    80004a5a:	8082                	ret
    80004a5c:	64e2                	ld	s1,24(sp)
    80004a5e:	6942                	ld	s2,16(sp)
    80004a60:	bfcd                	j	80004a52 <sys_dup+0x3c>

0000000080004a62 <sys_read>:
{
    80004a62:	7179                	addi	sp,sp,-48
    80004a64:	f406                	sd	ra,40(sp)
    80004a66:	f022                	sd	s0,32(sp)
    80004a68:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004a6a:	fd840593          	addi	a1,s0,-40
    80004a6e:	4505                	li	a0,1
    80004a70:	d7ffd0ef          	jal	800027ee <argaddr>
  argint(2, &n);
    80004a74:	fe440593          	addi	a1,s0,-28
    80004a78:	4509                	li	a0,2
    80004a7a:	d59fd0ef          	jal	800027d2 <argint>
  if(argfd(0, 0, &f) < 0)
    80004a7e:	fe840613          	addi	a2,s0,-24
    80004a82:	4581                	li	a1,0
    80004a84:	4501                	li	a0,0
    80004a86:	dc1ff0ef          	jal	80004846 <argfd>
    80004a8a:	87aa                	mv	a5,a0
    return -1;
    80004a8c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004a8e:	0007ca63          	bltz	a5,80004aa2 <sys_read+0x40>
  return fileread(f, p, n);
    80004a92:	fe442603          	lw	a2,-28(s0)
    80004a96:	fd843583          	ld	a1,-40(s0)
    80004a9a:	fe843503          	ld	a0,-24(s0)
    80004a9e:	d3eff0ef          	jal	80003fdc <fileread>
}
    80004aa2:	70a2                	ld	ra,40(sp)
    80004aa4:	7402                	ld	s0,32(sp)
    80004aa6:	6145                	addi	sp,sp,48
    80004aa8:	8082                	ret

0000000080004aaa <sys_write>:
{
    80004aaa:	7179                	addi	sp,sp,-48
    80004aac:	f406                	sd	ra,40(sp)
    80004aae:	f022                	sd	s0,32(sp)
    80004ab0:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004ab2:	fd840593          	addi	a1,s0,-40
    80004ab6:	4505                	li	a0,1
    80004ab8:	d37fd0ef          	jal	800027ee <argaddr>
  argint(2, &n);
    80004abc:	fe440593          	addi	a1,s0,-28
    80004ac0:	4509                	li	a0,2
    80004ac2:	d11fd0ef          	jal	800027d2 <argint>
  if(argfd(0, 0, &f) < 0)
    80004ac6:	fe840613          	addi	a2,s0,-24
    80004aca:	4581                	li	a1,0
    80004acc:	4501                	li	a0,0
    80004ace:	d79ff0ef          	jal	80004846 <argfd>
    80004ad2:	87aa                	mv	a5,a0
    return -1;
    80004ad4:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004ad6:	0007ca63          	bltz	a5,80004aea <sys_write+0x40>
  return filewrite(f, p, n);
    80004ada:	fe442603          	lw	a2,-28(s0)
    80004ade:	fd843583          	ld	a1,-40(s0)
    80004ae2:	fe843503          	ld	a0,-24(s0)
    80004ae6:	db4ff0ef          	jal	8000409a <filewrite>
}
    80004aea:	70a2                	ld	ra,40(sp)
    80004aec:	7402                	ld	s0,32(sp)
    80004aee:	6145                	addi	sp,sp,48
    80004af0:	8082                	ret

0000000080004af2 <sys_close>:
{
    80004af2:	1101                	addi	sp,sp,-32
    80004af4:	ec06                	sd	ra,24(sp)
    80004af6:	e822                	sd	s0,16(sp)
    80004af8:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004afa:	fe040613          	addi	a2,s0,-32
    80004afe:	fec40593          	addi	a1,s0,-20
    80004b02:	4501                	li	a0,0
    80004b04:	d43ff0ef          	jal	80004846 <argfd>
    return -1;
    80004b08:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004b0a:	02054063          	bltz	a0,80004b2a <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    80004b0e:	e13fc0ef          	jal	80001920 <myproc>
    80004b12:	fec42783          	lw	a5,-20(s0)
    80004b16:	07e9                	addi	a5,a5,26
    80004b18:	078e                	slli	a5,a5,0x3
    80004b1a:	953e                	add	a0,a0,a5
    80004b1c:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80004b20:	fe043503          	ld	a0,-32(s0)
    80004b24:	b98ff0ef          	jal	80003ebc <fileclose>
  return 0;
    80004b28:	4781                	li	a5,0
}
    80004b2a:	853e                	mv	a0,a5
    80004b2c:	60e2                	ld	ra,24(sp)
    80004b2e:	6442                	ld	s0,16(sp)
    80004b30:	6105                	addi	sp,sp,32
    80004b32:	8082                	ret

0000000080004b34 <sys_fstat>:
{
    80004b34:	1101                	addi	sp,sp,-32
    80004b36:	ec06                	sd	ra,24(sp)
    80004b38:	e822                	sd	s0,16(sp)
    80004b3a:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    80004b3c:	fe040593          	addi	a1,s0,-32
    80004b40:	4505                	li	a0,1
    80004b42:	cadfd0ef          	jal	800027ee <argaddr>
  if(argfd(0, 0, &f) < 0)
    80004b46:	fe840613          	addi	a2,s0,-24
    80004b4a:	4581                	li	a1,0
    80004b4c:	4501                	li	a0,0
    80004b4e:	cf9ff0ef          	jal	80004846 <argfd>
    80004b52:	87aa                	mv	a5,a0
    return -1;
    80004b54:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004b56:	0007c863          	bltz	a5,80004b66 <sys_fstat+0x32>
  return filestat(f, st);
    80004b5a:	fe043583          	ld	a1,-32(s0)
    80004b5e:	fe843503          	ld	a0,-24(s0)
    80004b62:	c18ff0ef          	jal	80003f7a <filestat>
}
    80004b66:	60e2                	ld	ra,24(sp)
    80004b68:	6442                	ld	s0,16(sp)
    80004b6a:	6105                	addi	sp,sp,32
    80004b6c:	8082                	ret

0000000080004b6e <sys_link>:
{
    80004b6e:	7169                	addi	sp,sp,-304
    80004b70:	f606                	sd	ra,296(sp)
    80004b72:	f222                	sd	s0,288(sp)
    80004b74:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004b76:	08000613          	li	a2,128
    80004b7a:	ed040593          	addi	a1,s0,-304
    80004b7e:	4501                	li	a0,0
    80004b80:	c8bfd0ef          	jal	8000280a <argstr>
    return -1;
    80004b84:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004b86:	0c054e63          	bltz	a0,80004c62 <sys_link+0xf4>
    80004b8a:	08000613          	li	a2,128
    80004b8e:	f5040593          	addi	a1,s0,-176
    80004b92:	4505                	li	a0,1
    80004b94:	c77fd0ef          	jal	8000280a <argstr>
    return -1;
    80004b98:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004b9a:	0c054463          	bltz	a0,80004c62 <sys_link+0xf4>
    80004b9e:	ee26                	sd	s1,280(sp)
  begin_op();
    80004ba0:	efdfe0ef          	jal	80003a9c <begin_op>
  if((ip = namei(old)) == 0){
    80004ba4:	ed040513          	addi	a0,s0,-304
    80004ba8:	d33fe0ef          	jal	800038da <namei>
    80004bac:	84aa                	mv	s1,a0
    80004bae:	c53d                	beqz	a0,80004c1c <sys_link+0xae>
  ilock(ip);
    80004bb0:	e3afe0ef          	jal	800031ea <ilock>
  if(ip->type == T_DIR){
    80004bb4:	04449703          	lh	a4,68(s1)
    80004bb8:	4785                	li	a5,1
    80004bba:	06f70663          	beq	a4,a5,80004c26 <sys_link+0xb8>
    80004bbe:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80004bc0:	04a4d783          	lhu	a5,74(s1)
    80004bc4:	2785                	addiw	a5,a5,1
    80004bc6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004bca:	8526                	mv	a0,s1
    80004bcc:	d6afe0ef          	jal	80003136 <iupdate>
  iunlock(ip);
    80004bd0:	8526                	mv	a0,s1
    80004bd2:	ec6fe0ef          	jal	80003298 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004bd6:	fd040593          	addi	a1,s0,-48
    80004bda:	f5040513          	addi	a0,s0,-176
    80004bde:	d17fe0ef          	jal	800038f4 <nameiparent>
    80004be2:	892a                	mv	s2,a0
    80004be4:	cd21                	beqz	a0,80004c3c <sys_link+0xce>
  ilock(dp);
    80004be6:	e04fe0ef          	jal	800031ea <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004bea:	00092703          	lw	a4,0(s2)
    80004bee:	409c                	lw	a5,0(s1)
    80004bf0:	04f71363          	bne	a4,a5,80004c36 <sys_link+0xc8>
    80004bf4:	40d0                	lw	a2,4(s1)
    80004bf6:	fd040593          	addi	a1,s0,-48
    80004bfa:	854a                	mv	a0,s2
    80004bfc:	c35fe0ef          	jal	80003830 <dirlink>
    80004c00:	02054b63          	bltz	a0,80004c36 <sys_link+0xc8>
  iunlockput(dp);
    80004c04:	854a                	mv	a0,s2
    80004c06:	feefe0ef          	jal	800033f4 <iunlockput>
  iput(ip);
    80004c0a:	8526                	mv	a0,s1
    80004c0c:	f60fe0ef          	jal	8000336c <iput>
  end_op();
    80004c10:	ef7fe0ef          	jal	80003b06 <end_op>
  return 0;
    80004c14:	4781                	li	a5,0
    80004c16:	64f2                	ld	s1,280(sp)
    80004c18:	6952                	ld	s2,272(sp)
    80004c1a:	a0a1                	j	80004c62 <sys_link+0xf4>
    end_op();
    80004c1c:	eebfe0ef          	jal	80003b06 <end_op>
    return -1;
    80004c20:	57fd                	li	a5,-1
    80004c22:	64f2                	ld	s1,280(sp)
    80004c24:	a83d                	j	80004c62 <sys_link+0xf4>
    iunlockput(ip);
    80004c26:	8526                	mv	a0,s1
    80004c28:	fccfe0ef          	jal	800033f4 <iunlockput>
    end_op();
    80004c2c:	edbfe0ef          	jal	80003b06 <end_op>
    return -1;
    80004c30:	57fd                	li	a5,-1
    80004c32:	64f2                	ld	s1,280(sp)
    80004c34:	a03d                	j	80004c62 <sys_link+0xf4>
    iunlockput(dp);
    80004c36:	854a                	mv	a0,s2
    80004c38:	fbcfe0ef          	jal	800033f4 <iunlockput>
  ilock(ip);
    80004c3c:	8526                	mv	a0,s1
    80004c3e:	dacfe0ef          	jal	800031ea <ilock>
  ip->nlink--;
    80004c42:	04a4d783          	lhu	a5,74(s1)
    80004c46:	37fd                	addiw	a5,a5,-1
    80004c48:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004c4c:	8526                	mv	a0,s1
    80004c4e:	ce8fe0ef          	jal	80003136 <iupdate>
  iunlockput(ip);
    80004c52:	8526                	mv	a0,s1
    80004c54:	fa0fe0ef          	jal	800033f4 <iunlockput>
  end_op();
    80004c58:	eaffe0ef          	jal	80003b06 <end_op>
  return -1;
    80004c5c:	57fd                	li	a5,-1
    80004c5e:	64f2                	ld	s1,280(sp)
    80004c60:	6952                	ld	s2,272(sp)
}
    80004c62:	853e                	mv	a0,a5
    80004c64:	70b2                	ld	ra,296(sp)
    80004c66:	7412                	ld	s0,288(sp)
    80004c68:	6155                	addi	sp,sp,304
    80004c6a:	8082                	ret

0000000080004c6c <sys_unlink>:
{
    80004c6c:	7111                	addi	sp,sp,-256
    80004c6e:	fd86                	sd	ra,248(sp)
    80004c70:	f9a2                	sd	s0,240(sp)
    80004c72:	0200                	addi	s0,sp,256
  if(argstr(0, path, MAXPATH) < 0)
    80004c74:	08000613          	li	a2,128
    80004c78:	f2040593          	addi	a1,s0,-224
    80004c7c:	4501                	li	a0,0
    80004c7e:	b8dfd0ef          	jal	8000280a <argstr>
    80004c82:	16054663          	bltz	a0,80004dee <sys_unlink+0x182>
    80004c86:	f5a6                	sd	s1,232(sp)
  begin_op();
    80004c88:	e15fe0ef          	jal	80003a9c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004c8c:	fa040593          	addi	a1,s0,-96
    80004c90:	f2040513          	addi	a0,s0,-224
    80004c94:	c61fe0ef          	jal	800038f4 <nameiparent>
    80004c98:	84aa                	mv	s1,a0
    80004c9a:	c955                	beqz	a0,80004d4e <sys_unlink+0xe2>
  ilock(dp);
    80004c9c:	d4efe0ef          	jal	800031ea <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004ca0:	00003597          	auipc	a1,0x3
    80004ca4:	98058593          	addi	a1,a1,-1664 # 80007620 <etext+0x620>
    80004ca8:	fa040513          	addi	a0,s0,-96
    80004cac:	98dfe0ef          	jal	80003638 <namecmp>
    80004cb0:	12050463          	beqz	a0,80004dd8 <sys_unlink+0x16c>
    80004cb4:	00003597          	auipc	a1,0x3
    80004cb8:	97458593          	addi	a1,a1,-1676 # 80007628 <etext+0x628>
    80004cbc:	fa040513          	addi	a0,s0,-96
    80004cc0:	979fe0ef          	jal	80003638 <namecmp>
    80004cc4:	10050a63          	beqz	a0,80004dd8 <sys_unlink+0x16c>
    80004cc8:	f1ca                	sd	s2,224(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004cca:	f1c40613          	addi	a2,s0,-228
    80004cce:	fa040593          	addi	a1,s0,-96
    80004cd2:	8526                	mv	a0,s1
    80004cd4:	97bfe0ef          	jal	8000364e <dirlookup>
    80004cd8:	892a                	mv	s2,a0
    80004cda:	0e050e63          	beqz	a0,80004dd6 <sys_unlink+0x16a>
    80004cde:	edce                	sd	s3,216(sp)
  ilock(ip);
    80004ce0:	d0afe0ef          	jal	800031ea <ilock>
  if(ip->nlink < 1)
    80004ce4:	04a91783          	lh	a5,74(s2)
    80004ce8:	06f05863          	blez	a5,80004d58 <sys_unlink+0xec>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004cec:	04491703          	lh	a4,68(s2)
    80004cf0:	4785                	li	a5,1
    80004cf2:	06f70b63          	beq	a4,a5,80004d68 <sys_unlink+0xfc>
  memset(&de, 0, sizeof(de));
    80004cf6:	fb040993          	addi	s3,s0,-80
    80004cfa:	4641                	li	a2,16
    80004cfc:	4581                	li	a1,0
    80004cfe:	854e                	mv	a0,s3
    80004d00:	812fc0ef          	jal	80000d12 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004d04:	4741                	li	a4,16
    80004d06:	f1c42683          	lw	a3,-228(s0)
    80004d0a:	864e                	mv	a2,s3
    80004d0c:	4581                	li	a1,0
    80004d0e:	8526                	mv	a0,s1
    80004d10:	825fe0ef          	jal	80003534 <writei>
    80004d14:	47c1                	li	a5,16
    80004d16:	08f51f63          	bne	a0,a5,80004db4 <sys_unlink+0x148>
  if(ip->type == T_DIR){
    80004d1a:	04491703          	lh	a4,68(s2)
    80004d1e:	4785                	li	a5,1
    80004d20:	0af70263          	beq	a4,a5,80004dc4 <sys_unlink+0x158>
  iunlockput(dp);
    80004d24:	8526                	mv	a0,s1
    80004d26:	ecefe0ef          	jal	800033f4 <iunlockput>
  ip->nlink--;
    80004d2a:	04a95783          	lhu	a5,74(s2)
    80004d2e:	37fd                	addiw	a5,a5,-1
    80004d30:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004d34:	854a                	mv	a0,s2
    80004d36:	c00fe0ef          	jal	80003136 <iupdate>
  iunlockput(ip);
    80004d3a:	854a                	mv	a0,s2
    80004d3c:	eb8fe0ef          	jal	800033f4 <iunlockput>
  end_op();
    80004d40:	dc7fe0ef          	jal	80003b06 <end_op>
  return 0;
    80004d44:	4501                	li	a0,0
    80004d46:	74ae                	ld	s1,232(sp)
    80004d48:	790e                	ld	s2,224(sp)
    80004d4a:	69ee                	ld	s3,216(sp)
    80004d4c:	a869                	j	80004de6 <sys_unlink+0x17a>
    end_op();
    80004d4e:	db9fe0ef          	jal	80003b06 <end_op>
    return -1;
    80004d52:	557d                	li	a0,-1
    80004d54:	74ae                	ld	s1,232(sp)
    80004d56:	a841                	j	80004de6 <sys_unlink+0x17a>
    80004d58:	e9d2                	sd	s4,208(sp)
    80004d5a:	e5d6                	sd	s5,200(sp)
    panic("unlink: nlink < 1");
    80004d5c:	00003517          	auipc	a0,0x3
    80004d60:	8d450513          	addi	a0,a0,-1836 # 80007630 <etext+0x630>
    80004d64:	a7ffb0ef          	jal	800007e2 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004d68:	04c92703          	lw	a4,76(s2)
    80004d6c:	02000793          	li	a5,32
    80004d70:	f8e7f3e3          	bgeu	a5,a4,80004cf6 <sys_unlink+0x8a>
    80004d74:	e9d2                	sd	s4,208(sp)
    80004d76:	e5d6                	sd	s5,200(sp)
    80004d78:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004d7a:	f0840a93          	addi	s5,s0,-248
    80004d7e:	4a41                	li	s4,16
    80004d80:	8752                	mv	a4,s4
    80004d82:	86ce                	mv	a3,s3
    80004d84:	8656                	mv	a2,s5
    80004d86:	4581                	li	a1,0
    80004d88:	854a                	mv	a0,s2
    80004d8a:	eb8fe0ef          	jal	80003442 <readi>
    80004d8e:	01451d63          	bne	a0,s4,80004da8 <sys_unlink+0x13c>
    if(de.inum != 0)
    80004d92:	f0845783          	lhu	a5,-248(s0)
    80004d96:	efb1                	bnez	a5,80004df2 <sys_unlink+0x186>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004d98:	29c1                	addiw	s3,s3,16
    80004d9a:	04c92783          	lw	a5,76(s2)
    80004d9e:	fef9e1e3          	bltu	s3,a5,80004d80 <sys_unlink+0x114>
    80004da2:	6a4e                	ld	s4,208(sp)
    80004da4:	6aae                	ld	s5,200(sp)
    80004da6:	bf81                	j	80004cf6 <sys_unlink+0x8a>
      panic("isdirempty: readi");
    80004da8:	00003517          	auipc	a0,0x3
    80004dac:	8a050513          	addi	a0,a0,-1888 # 80007648 <etext+0x648>
    80004db0:	a33fb0ef          	jal	800007e2 <panic>
    80004db4:	e9d2                	sd	s4,208(sp)
    80004db6:	e5d6                	sd	s5,200(sp)
    panic("unlink: writei");
    80004db8:	00003517          	auipc	a0,0x3
    80004dbc:	8a850513          	addi	a0,a0,-1880 # 80007660 <etext+0x660>
    80004dc0:	a23fb0ef          	jal	800007e2 <panic>
    dp->nlink--;
    80004dc4:	04a4d783          	lhu	a5,74(s1)
    80004dc8:	37fd                	addiw	a5,a5,-1
    80004dca:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004dce:	8526                	mv	a0,s1
    80004dd0:	b66fe0ef          	jal	80003136 <iupdate>
    80004dd4:	bf81                	j	80004d24 <sys_unlink+0xb8>
    80004dd6:	790e                	ld	s2,224(sp)
  iunlockput(dp);
    80004dd8:	8526                	mv	a0,s1
    80004dda:	e1afe0ef          	jal	800033f4 <iunlockput>
  end_op();
    80004dde:	d29fe0ef          	jal	80003b06 <end_op>
  return -1;
    80004de2:	557d                	li	a0,-1
    80004de4:	74ae                	ld	s1,232(sp)
}
    80004de6:	70ee                	ld	ra,248(sp)
    80004de8:	744e                	ld	s0,240(sp)
    80004dea:	6111                	addi	sp,sp,256
    80004dec:	8082                	ret
    return -1;
    80004dee:	557d                	li	a0,-1
    80004df0:	bfdd                	j	80004de6 <sys_unlink+0x17a>
    iunlockput(ip);
    80004df2:	854a                	mv	a0,s2
    80004df4:	e00fe0ef          	jal	800033f4 <iunlockput>
    goto bad;
    80004df8:	790e                	ld	s2,224(sp)
    80004dfa:	69ee                	ld	s3,216(sp)
    80004dfc:	6a4e                	ld	s4,208(sp)
    80004dfe:	6aae                	ld	s5,200(sp)
    80004e00:	bfe1                	j	80004dd8 <sys_unlink+0x16c>

0000000080004e02 <sys_open>:

uint64
sys_open(void)
{
    80004e02:	7131                	addi	sp,sp,-192
    80004e04:	fd06                	sd	ra,184(sp)
    80004e06:	f922                	sd	s0,176(sp)
    80004e08:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004e0a:	f4c40593          	addi	a1,s0,-180
    80004e0e:	4505                	li	a0,1
    80004e10:	9c3fd0ef          	jal	800027d2 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004e14:	08000613          	li	a2,128
    80004e18:	f5040593          	addi	a1,s0,-176
    80004e1c:	4501                	li	a0,0
    80004e1e:	9edfd0ef          	jal	8000280a <argstr>
    80004e22:	87aa                	mv	a5,a0
    return -1;
    80004e24:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004e26:	0a07c363          	bltz	a5,80004ecc <sys_open+0xca>
    80004e2a:	f526                	sd	s1,168(sp)

  begin_op();
    80004e2c:	c71fe0ef          	jal	80003a9c <begin_op>

  if(omode & O_CREATE){
    80004e30:	f4c42783          	lw	a5,-180(s0)
    80004e34:	2007f793          	andi	a5,a5,512
    80004e38:	c3dd                	beqz	a5,80004ede <sys_open+0xdc>
    ip = create(path, T_FILE, 0, 0);
    80004e3a:	4681                	li	a3,0
    80004e3c:	4601                	li	a2,0
    80004e3e:	4589                	li	a1,2
    80004e40:	f5040513          	addi	a0,s0,-176
    80004e44:	a99ff0ef          	jal	800048dc <create>
    80004e48:	84aa                	mv	s1,a0
    if(ip == 0){
    80004e4a:	c549                	beqz	a0,80004ed4 <sys_open+0xd2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004e4c:	04449703          	lh	a4,68(s1)
    80004e50:	478d                	li	a5,3
    80004e52:	00f71763          	bne	a4,a5,80004e60 <sys_open+0x5e>
    80004e56:	0464d703          	lhu	a4,70(s1)
    80004e5a:	47a5                	li	a5,9
    80004e5c:	0ae7ee63          	bltu	a5,a4,80004f18 <sys_open+0x116>
    80004e60:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004e62:	fb7fe0ef          	jal	80003e18 <filealloc>
    80004e66:	892a                	mv	s2,a0
    80004e68:	c561                	beqz	a0,80004f30 <sys_open+0x12e>
    80004e6a:	ed4e                	sd	s3,152(sp)
    80004e6c:	a33ff0ef          	jal	8000489e <fdalloc>
    80004e70:	89aa                	mv	s3,a0
    80004e72:	0a054b63          	bltz	a0,80004f28 <sys_open+0x126>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004e76:	04449703          	lh	a4,68(s1)
    80004e7a:	478d                	li	a5,3
    80004e7c:	0cf70363          	beq	a4,a5,80004f42 <sys_open+0x140>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004e80:	4789                	li	a5,2
    80004e82:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004e86:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004e8a:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004e8e:	f4c42783          	lw	a5,-180(s0)
    80004e92:	0017f713          	andi	a4,a5,1
    80004e96:	00174713          	xori	a4,a4,1
    80004e9a:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004e9e:	0037f713          	andi	a4,a5,3
    80004ea2:	00e03733          	snez	a4,a4
    80004ea6:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004eaa:	4007f793          	andi	a5,a5,1024
    80004eae:	c791                	beqz	a5,80004eba <sys_open+0xb8>
    80004eb0:	04449703          	lh	a4,68(s1)
    80004eb4:	4789                	li	a5,2
    80004eb6:	08f70d63          	beq	a4,a5,80004f50 <sys_open+0x14e>
    itrunc(ip);
  }

  iunlock(ip);
    80004eba:	8526                	mv	a0,s1
    80004ebc:	bdcfe0ef          	jal	80003298 <iunlock>
  end_op();
    80004ec0:	c47fe0ef          	jal	80003b06 <end_op>

  return fd;
    80004ec4:	854e                	mv	a0,s3
    80004ec6:	74aa                	ld	s1,168(sp)
    80004ec8:	790a                	ld	s2,160(sp)
    80004eca:	69ea                	ld	s3,152(sp)
}
    80004ecc:	70ea                	ld	ra,184(sp)
    80004ece:	744a                	ld	s0,176(sp)
    80004ed0:	6129                	addi	sp,sp,192
    80004ed2:	8082                	ret
      end_op();
    80004ed4:	c33fe0ef          	jal	80003b06 <end_op>
      return -1;
    80004ed8:	557d                	li	a0,-1
    80004eda:	74aa                	ld	s1,168(sp)
    80004edc:	bfc5                	j	80004ecc <sys_open+0xca>
    if((ip = namei(path)) == 0){
    80004ede:	f5040513          	addi	a0,s0,-176
    80004ee2:	9f9fe0ef          	jal	800038da <namei>
    80004ee6:	84aa                	mv	s1,a0
    80004ee8:	c11d                	beqz	a0,80004f0e <sys_open+0x10c>
    ilock(ip);
    80004eea:	b00fe0ef          	jal	800031ea <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004eee:	04449703          	lh	a4,68(s1)
    80004ef2:	4785                	li	a5,1
    80004ef4:	f4f71ce3          	bne	a4,a5,80004e4c <sys_open+0x4a>
    80004ef8:	f4c42783          	lw	a5,-180(s0)
    80004efc:	d3b5                	beqz	a5,80004e60 <sys_open+0x5e>
      iunlockput(ip);
    80004efe:	8526                	mv	a0,s1
    80004f00:	cf4fe0ef          	jal	800033f4 <iunlockput>
      end_op();
    80004f04:	c03fe0ef          	jal	80003b06 <end_op>
      return -1;
    80004f08:	557d                	li	a0,-1
    80004f0a:	74aa                	ld	s1,168(sp)
    80004f0c:	b7c1                	j	80004ecc <sys_open+0xca>
      end_op();
    80004f0e:	bf9fe0ef          	jal	80003b06 <end_op>
      return -1;
    80004f12:	557d                	li	a0,-1
    80004f14:	74aa                	ld	s1,168(sp)
    80004f16:	bf5d                	j	80004ecc <sys_open+0xca>
    iunlockput(ip);
    80004f18:	8526                	mv	a0,s1
    80004f1a:	cdafe0ef          	jal	800033f4 <iunlockput>
    end_op();
    80004f1e:	be9fe0ef          	jal	80003b06 <end_op>
    return -1;
    80004f22:	557d                	li	a0,-1
    80004f24:	74aa                	ld	s1,168(sp)
    80004f26:	b75d                	j	80004ecc <sys_open+0xca>
      fileclose(f);
    80004f28:	854a                	mv	a0,s2
    80004f2a:	f93fe0ef          	jal	80003ebc <fileclose>
    80004f2e:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    80004f30:	8526                	mv	a0,s1
    80004f32:	cc2fe0ef          	jal	800033f4 <iunlockput>
    end_op();
    80004f36:	bd1fe0ef          	jal	80003b06 <end_op>
    return -1;
    80004f3a:	557d                	li	a0,-1
    80004f3c:	74aa                	ld	s1,168(sp)
    80004f3e:	790a                	ld	s2,160(sp)
    80004f40:	b771                	j	80004ecc <sys_open+0xca>
    f->type = FD_DEVICE;
    80004f42:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    80004f46:	04649783          	lh	a5,70(s1)
    80004f4a:	02f91223          	sh	a5,36(s2)
    80004f4e:	bf35                	j	80004e8a <sys_open+0x88>
    itrunc(ip);
    80004f50:	8526                	mv	a0,s1
    80004f52:	b86fe0ef          	jal	800032d8 <itrunc>
    80004f56:	b795                	j	80004eba <sys_open+0xb8>

0000000080004f58 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004f58:	7175                	addi	sp,sp,-144
    80004f5a:	e506                	sd	ra,136(sp)
    80004f5c:	e122                	sd	s0,128(sp)
    80004f5e:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004f60:	b3dfe0ef          	jal	80003a9c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004f64:	08000613          	li	a2,128
    80004f68:	f7040593          	addi	a1,s0,-144
    80004f6c:	4501                	li	a0,0
    80004f6e:	89dfd0ef          	jal	8000280a <argstr>
    80004f72:	02054363          	bltz	a0,80004f98 <sys_mkdir+0x40>
    80004f76:	4681                	li	a3,0
    80004f78:	4601                	li	a2,0
    80004f7a:	4585                	li	a1,1
    80004f7c:	f7040513          	addi	a0,s0,-144
    80004f80:	95dff0ef          	jal	800048dc <create>
    80004f84:	c911                	beqz	a0,80004f98 <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f86:	c6efe0ef          	jal	800033f4 <iunlockput>
  end_op();
    80004f8a:	b7dfe0ef          	jal	80003b06 <end_op>
  return 0;
    80004f8e:	4501                	li	a0,0
}
    80004f90:	60aa                	ld	ra,136(sp)
    80004f92:	640a                	ld	s0,128(sp)
    80004f94:	6149                	addi	sp,sp,144
    80004f96:	8082                	ret
    end_op();
    80004f98:	b6ffe0ef          	jal	80003b06 <end_op>
    return -1;
    80004f9c:	557d                	li	a0,-1
    80004f9e:	bfcd                	j	80004f90 <sys_mkdir+0x38>

0000000080004fa0 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004fa0:	7135                	addi	sp,sp,-160
    80004fa2:	ed06                	sd	ra,152(sp)
    80004fa4:	e922                	sd	s0,144(sp)
    80004fa6:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004fa8:	af5fe0ef          	jal	80003a9c <begin_op>
  argint(1, &major);
    80004fac:	f6c40593          	addi	a1,s0,-148
    80004fb0:	4505                	li	a0,1
    80004fb2:	821fd0ef          	jal	800027d2 <argint>
  argint(2, &minor);
    80004fb6:	f6840593          	addi	a1,s0,-152
    80004fba:	4509                	li	a0,2
    80004fbc:	817fd0ef          	jal	800027d2 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fc0:	08000613          	li	a2,128
    80004fc4:	f7040593          	addi	a1,s0,-144
    80004fc8:	4501                	li	a0,0
    80004fca:	841fd0ef          	jal	8000280a <argstr>
    80004fce:	02054563          	bltz	a0,80004ff8 <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004fd2:	f6841683          	lh	a3,-152(s0)
    80004fd6:	f6c41603          	lh	a2,-148(s0)
    80004fda:	458d                	li	a1,3
    80004fdc:	f7040513          	addi	a0,s0,-144
    80004fe0:	8fdff0ef          	jal	800048dc <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fe4:	c911                	beqz	a0,80004ff8 <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004fe6:	c0efe0ef          	jal	800033f4 <iunlockput>
  end_op();
    80004fea:	b1dfe0ef          	jal	80003b06 <end_op>
  return 0;
    80004fee:	4501                	li	a0,0
}
    80004ff0:	60ea                	ld	ra,152(sp)
    80004ff2:	644a                	ld	s0,144(sp)
    80004ff4:	610d                	addi	sp,sp,160
    80004ff6:	8082                	ret
    end_op();
    80004ff8:	b0ffe0ef          	jal	80003b06 <end_op>
    return -1;
    80004ffc:	557d                	li	a0,-1
    80004ffe:	bfcd                	j	80004ff0 <sys_mknod+0x50>

0000000080005000 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005000:	7135                	addi	sp,sp,-160
    80005002:	ed06                	sd	ra,152(sp)
    80005004:	e922                	sd	s0,144(sp)
    80005006:	e14a                	sd	s2,128(sp)
    80005008:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    8000500a:	917fc0ef          	jal	80001920 <myproc>
    8000500e:	892a                	mv	s2,a0
  
  begin_op();
    80005010:	a8dfe0ef          	jal	80003a9c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005014:	08000613          	li	a2,128
    80005018:	f6040593          	addi	a1,s0,-160
    8000501c:	4501                	li	a0,0
    8000501e:	fecfd0ef          	jal	8000280a <argstr>
    80005022:	04054363          	bltz	a0,80005068 <sys_chdir+0x68>
    80005026:	e526                	sd	s1,136(sp)
    80005028:	f6040513          	addi	a0,s0,-160
    8000502c:	8affe0ef          	jal	800038da <namei>
    80005030:	84aa                	mv	s1,a0
    80005032:	c915                	beqz	a0,80005066 <sys_chdir+0x66>
    end_op();
    return -1;
  }
  ilock(ip);
    80005034:	9b6fe0ef          	jal	800031ea <ilock>
  if(ip->type != T_DIR){
    80005038:	04449703          	lh	a4,68(s1)
    8000503c:	4785                	li	a5,1
    8000503e:	02f71963          	bne	a4,a5,80005070 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005042:	8526                	mv	a0,s1
    80005044:	a54fe0ef          	jal	80003298 <iunlock>
  iput(p->cwd);
    80005048:	15093503          	ld	a0,336(s2)
    8000504c:	b20fe0ef          	jal	8000336c <iput>
  end_op();
    80005050:	ab7fe0ef          	jal	80003b06 <end_op>
  p->cwd = ip;
    80005054:	14993823          	sd	s1,336(s2)
  return 0;
    80005058:	4501                	li	a0,0
    8000505a:	64aa                	ld	s1,136(sp)
}
    8000505c:	60ea                	ld	ra,152(sp)
    8000505e:	644a                	ld	s0,144(sp)
    80005060:	690a                	ld	s2,128(sp)
    80005062:	610d                	addi	sp,sp,160
    80005064:	8082                	ret
    80005066:	64aa                	ld	s1,136(sp)
    end_op();
    80005068:	a9ffe0ef          	jal	80003b06 <end_op>
    return -1;
    8000506c:	557d                	li	a0,-1
    8000506e:	b7fd                	j	8000505c <sys_chdir+0x5c>
    iunlockput(ip);
    80005070:	8526                	mv	a0,s1
    80005072:	b82fe0ef          	jal	800033f4 <iunlockput>
    end_op();
    80005076:	a91fe0ef          	jal	80003b06 <end_op>
    return -1;
    8000507a:	557d                	li	a0,-1
    8000507c:	64aa                	ld	s1,136(sp)
    8000507e:	bff9                	j	8000505c <sys_chdir+0x5c>

0000000080005080 <sys_exec>:

uint64
sys_exec(void)
{
    80005080:	7105                	addi	sp,sp,-480
    80005082:	ef86                	sd	ra,472(sp)
    80005084:	eba2                	sd	s0,464(sp)
    80005086:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80005088:	e2840593          	addi	a1,s0,-472
    8000508c:	4505                	li	a0,1
    8000508e:	f60fd0ef          	jal	800027ee <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80005092:	08000613          	li	a2,128
    80005096:	f3040593          	addi	a1,s0,-208
    8000509a:	4501                	li	a0,0
    8000509c:	f6efd0ef          	jal	8000280a <argstr>
    800050a0:	87aa                	mv	a5,a0
    return -1;
    800050a2:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    800050a4:	0e07c063          	bltz	a5,80005184 <sys_exec+0x104>
    800050a8:	e7a6                	sd	s1,456(sp)
    800050aa:	e3ca                	sd	s2,448(sp)
    800050ac:	ff4e                	sd	s3,440(sp)
    800050ae:	fb52                	sd	s4,432(sp)
    800050b0:	f756                	sd	s5,424(sp)
    800050b2:	f35a                	sd	s6,416(sp)
    800050b4:	ef5e                	sd	s7,408(sp)
  }
  memset(argv, 0, sizeof(argv));
    800050b6:	e3040a13          	addi	s4,s0,-464
    800050ba:	10000613          	li	a2,256
    800050be:	4581                	li	a1,0
    800050c0:	8552                	mv	a0,s4
    800050c2:	c51fb0ef          	jal	80000d12 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    800050c6:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    800050c8:	89d2                	mv	s3,s4
    800050ca:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800050cc:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800050d0:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    800050d2:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    800050d6:	00391513          	slli	a0,s2,0x3
    800050da:	85d6                	mv	a1,s5
    800050dc:	e2843783          	ld	a5,-472(s0)
    800050e0:	953e                	add	a0,a0,a5
    800050e2:	e66fd0ef          	jal	80002748 <fetchaddr>
    800050e6:	02054663          	bltz	a0,80005112 <sys_exec+0x92>
    if(uarg == 0){
    800050ea:	e2043783          	ld	a5,-480(s0)
    800050ee:	c7a1                	beqz	a5,80005136 <sys_exec+0xb6>
    argv[i] = kalloc();
    800050f0:	a7ffb0ef          	jal	80000b6e <kalloc>
    800050f4:	85aa                	mv	a1,a0
    800050f6:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800050fa:	cd01                	beqz	a0,80005112 <sys_exec+0x92>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800050fc:	865a                	mv	a2,s6
    800050fe:	e2043503          	ld	a0,-480(s0)
    80005102:	e90fd0ef          	jal	80002792 <fetchstr>
    80005106:	00054663          	bltz	a0,80005112 <sys_exec+0x92>
    if(i >= NELEM(argv)){
    8000510a:	0905                	addi	s2,s2,1
    8000510c:	09a1                	addi	s3,s3,8
    8000510e:	fd7914e3          	bne	s2,s7,800050d6 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005112:	100a0a13          	addi	s4,s4,256
    80005116:	6088                	ld	a0,0(s1)
    80005118:	cd31                	beqz	a0,80005174 <sys_exec+0xf4>
    kfree(argv[i]);
    8000511a:	973fb0ef          	jal	80000a8c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000511e:	04a1                	addi	s1,s1,8
    80005120:	ff449be3          	bne	s1,s4,80005116 <sys_exec+0x96>
  return -1;
    80005124:	557d                	li	a0,-1
    80005126:	64be                	ld	s1,456(sp)
    80005128:	691e                	ld	s2,448(sp)
    8000512a:	79fa                	ld	s3,440(sp)
    8000512c:	7a5a                	ld	s4,432(sp)
    8000512e:	7aba                	ld	s5,424(sp)
    80005130:	7b1a                	ld	s6,416(sp)
    80005132:	6bfa                	ld	s7,408(sp)
    80005134:	a881                	j	80005184 <sys_exec+0x104>
      argv[i] = 0;
    80005136:	0009079b          	sext.w	a5,s2
    8000513a:	e3040593          	addi	a1,s0,-464
    8000513e:	078e                	slli	a5,a5,0x3
    80005140:	97ae                	add	a5,a5,a1
    80005142:	0007b023          	sd	zero,0(a5)
  int ret = exec(path, argv);
    80005146:	f3040513          	addi	a0,s0,-208
    8000514a:	ba4ff0ef          	jal	800044ee <exec>
    8000514e:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005150:	100a0a13          	addi	s4,s4,256
    80005154:	6088                	ld	a0,0(s1)
    80005156:	c511                	beqz	a0,80005162 <sys_exec+0xe2>
    kfree(argv[i]);
    80005158:	935fb0ef          	jal	80000a8c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000515c:	04a1                	addi	s1,s1,8
    8000515e:	ff449be3          	bne	s1,s4,80005154 <sys_exec+0xd4>
  return ret;
    80005162:	854a                	mv	a0,s2
    80005164:	64be                	ld	s1,456(sp)
    80005166:	691e                	ld	s2,448(sp)
    80005168:	79fa                	ld	s3,440(sp)
    8000516a:	7a5a                	ld	s4,432(sp)
    8000516c:	7aba                	ld	s5,424(sp)
    8000516e:	7b1a                	ld	s6,416(sp)
    80005170:	6bfa                	ld	s7,408(sp)
    80005172:	a809                	j	80005184 <sys_exec+0x104>
  return -1;
    80005174:	557d                	li	a0,-1
    80005176:	64be                	ld	s1,456(sp)
    80005178:	691e                	ld	s2,448(sp)
    8000517a:	79fa                	ld	s3,440(sp)
    8000517c:	7a5a                	ld	s4,432(sp)
    8000517e:	7aba                	ld	s5,424(sp)
    80005180:	7b1a                	ld	s6,416(sp)
    80005182:	6bfa                	ld	s7,408(sp)
}
    80005184:	60fe                	ld	ra,472(sp)
    80005186:	645e                	ld	s0,464(sp)
    80005188:	613d                	addi	sp,sp,480
    8000518a:	8082                	ret

000000008000518c <sys_pipe>:

uint64
sys_pipe(void)
{
    8000518c:	7139                	addi	sp,sp,-64
    8000518e:	fc06                	sd	ra,56(sp)
    80005190:	f822                	sd	s0,48(sp)
    80005192:	f426                	sd	s1,40(sp)
    80005194:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005196:	f8afc0ef          	jal	80001920 <myproc>
    8000519a:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    8000519c:	fd840593          	addi	a1,s0,-40
    800051a0:	4501                	li	a0,0
    800051a2:	e4cfd0ef          	jal	800027ee <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    800051a6:	fc840593          	addi	a1,s0,-56
    800051aa:	fd040513          	addi	a0,s0,-48
    800051ae:	81eff0ef          	jal	800041cc <pipealloc>
    return -1;
    800051b2:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    800051b4:	0a054463          	bltz	a0,8000525c <sys_pipe+0xd0>
  fd0 = -1;
    800051b8:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    800051bc:	fd043503          	ld	a0,-48(s0)
    800051c0:	edeff0ef          	jal	8000489e <fdalloc>
    800051c4:	fca42223          	sw	a0,-60(s0)
    800051c8:	08054163          	bltz	a0,8000524a <sys_pipe+0xbe>
    800051cc:	fc843503          	ld	a0,-56(s0)
    800051d0:	eceff0ef          	jal	8000489e <fdalloc>
    800051d4:	fca42023          	sw	a0,-64(s0)
    800051d8:	06054063          	bltz	a0,80005238 <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051dc:	4691                	li	a3,4
    800051de:	fc440613          	addi	a2,s0,-60
    800051e2:	fd843583          	ld	a1,-40(s0)
    800051e6:	68a8                	ld	a0,80(s1)
    800051e8:	be0fc0ef          	jal	800015c8 <copyout>
    800051ec:	00054e63          	bltz	a0,80005208 <sys_pipe+0x7c>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800051f0:	4691                	li	a3,4
    800051f2:	fc040613          	addi	a2,s0,-64
    800051f6:	fd843583          	ld	a1,-40(s0)
    800051fa:	95b6                	add	a1,a1,a3
    800051fc:	68a8                	ld	a0,80(s1)
    800051fe:	bcafc0ef          	jal	800015c8 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005202:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005204:	04055c63          	bgez	a0,8000525c <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    80005208:	fc442783          	lw	a5,-60(s0)
    8000520c:	07e9                	addi	a5,a5,26
    8000520e:	078e                	slli	a5,a5,0x3
    80005210:	97a6                	add	a5,a5,s1
    80005212:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005216:	fc042783          	lw	a5,-64(s0)
    8000521a:	07e9                	addi	a5,a5,26
    8000521c:	078e                	slli	a5,a5,0x3
    8000521e:	94be                	add	s1,s1,a5
    80005220:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80005224:	fd043503          	ld	a0,-48(s0)
    80005228:	c95fe0ef          	jal	80003ebc <fileclose>
    fileclose(wf);
    8000522c:	fc843503          	ld	a0,-56(s0)
    80005230:	c8dfe0ef          	jal	80003ebc <fileclose>
    return -1;
    80005234:	57fd                	li	a5,-1
    80005236:	a01d                	j	8000525c <sys_pipe+0xd0>
    if(fd0 >= 0)
    80005238:	fc442783          	lw	a5,-60(s0)
    8000523c:	0007c763          	bltz	a5,8000524a <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    80005240:	07e9                	addi	a5,a5,26
    80005242:	078e                	slli	a5,a5,0x3
    80005244:	97a6                	add	a5,a5,s1
    80005246:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    8000524a:	fd043503          	ld	a0,-48(s0)
    8000524e:	c6ffe0ef          	jal	80003ebc <fileclose>
    fileclose(wf);
    80005252:	fc843503          	ld	a0,-56(s0)
    80005256:	c67fe0ef          	jal	80003ebc <fileclose>
    return -1;
    8000525a:	57fd                	li	a5,-1
}
    8000525c:	853e                	mv	a0,a5
    8000525e:	70e2                	ld	ra,56(sp)
    80005260:	7442                	ld	s0,48(sp)
    80005262:	74a2                	ld	s1,40(sp)
    80005264:	6121                	addi	sp,sp,64
    80005266:	8082                	ret
	...

0000000080005270 <kernelvec>:
    80005270:	7111                	addi	sp,sp,-256
    80005272:	e006                	sd	ra,0(sp)
    80005274:	e40a                	sd	sp,8(sp)
    80005276:	e80e                	sd	gp,16(sp)
    80005278:	ec12                	sd	tp,24(sp)
    8000527a:	f016                	sd	t0,32(sp)
    8000527c:	f41a                	sd	t1,40(sp)
    8000527e:	f81e                	sd	t2,48(sp)
    80005280:	e4aa                	sd	a0,72(sp)
    80005282:	e8ae                	sd	a1,80(sp)
    80005284:	ecb2                	sd	a2,88(sp)
    80005286:	f0b6                	sd	a3,96(sp)
    80005288:	f4ba                	sd	a4,104(sp)
    8000528a:	f8be                	sd	a5,112(sp)
    8000528c:	fcc2                	sd	a6,120(sp)
    8000528e:	e146                	sd	a7,128(sp)
    80005290:	edf2                	sd	t3,216(sp)
    80005292:	f1f6                	sd	t4,224(sp)
    80005294:	f5fa                	sd	t5,232(sp)
    80005296:	f9fe                	sd	t6,240(sp)
    80005298:	bc0fd0ef          	jal	80002658 <kerneltrap>
    8000529c:	6082                	ld	ra,0(sp)
    8000529e:	6122                	ld	sp,8(sp)
    800052a0:	61c2                	ld	gp,16(sp)
    800052a2:	7282                	ld	t0,32(sp)
    800052a4:	7322                	ld	t1,40(sp)
    800052a6:	73c2                	ld	t2,48(sp)
    800052a8:	6526                	ld	a0,72(sp)
    800052aa:	65c6                	ld	a1,80(sp)
    800052ac:	6666                	ld	a2,88(sp)
    800052ae:	7686                	ld	a3,96(sp)
    800052b0:	7726                	ld	a4,104(sp)
    800052b2:	77c6                	ld	a5,112(sp)
    800052b4:	7866                	ld	a6,120(sp)
    800052b6:	688a                	ld	a7,128(sp)
    800052b8:	6e6e                	ld	t3,216(sp)
    800052ba:	7e8e                	ld	t4,224(sp)
    800052bc:	7f2e                	ld	t5,232(sp)
    800052be:	7fce                	ld	t6,240(sp)
    800052c0:	6111                	addi	sp,sp,256
    800052c2:	10200073          	sret
    800052c6:	00000013          	nop
    800052ca:	00000013          	nop

00000000800052ce <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800052ce:	1141                	addi	sp,sp,-16
    800052d0:	e406                	sd	ra,8(sp)
    800052d2:	e022                	sd	s0,0(sp)
    800052d4:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800052d6:	0c000737          	lui	a4,0xc000
    800052da:	4785                	li	a5,1
    800052dc:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800052de:	c35c                	sw	a5,4(a4)
}
    800052e0:	60a2                	ld	ra,8(sp)
    800052e2:	6402                	ld	s0,0(sp)
    800052e4:	0141                	addi	sp,sp,16
    800052e6:	8082                	ret

00000000800052e8 <plicinithart>:

void
plicinithart(void)
{
    800052e8:	1141                	addi	sp,sp,-16
    800052ea:	e406                	sd	ra,8(sp)
    800052ec:	e022                	sd	s0,0(sp)
    800052ee:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800052f0:	dfcfc0ef          	jal	800018ec <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800052f4:	0085171b          	slliw	a4,a0,0x8
    800052f8:	0c0027b7          	lui	a5,0xc002
    800052fc:	97ba                	add	a5,a5,a4
    800052fe:	40200713          	li	a4,1026
    80005302:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005306:	00d5151b          	slliw	a0,a0,0xd
    8000530a:	0c2017b7          	lui	a5,0xc201
    8000530e:	97aa                	add	a5,a5,a0
    80005310:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005314:	60a2                	ld	ra,8(sp)
    80005316:	6402                	ld	s0,0(sp)
    80005318:	0141                	addi	sp,sp,16
    8000531a:	8082                	ret

000000008000531c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000531c:	1141                	addi	sp,sp,-16
    8000531e:	e406                	sd	ra,8(sp)
    80005320:	e022                	sd	s0,0(sp)
    80005322:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005324:	dc8fc0ef          	jal	800018ec <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005328:	00d5151b          	slliw	a0,a0,0xd
    8000532c:	0c2017b7          	lui	a5,0xc201
    80005330:	97aa                	add	a5,a5,a0
  return irq;
}
    80005332:	43c8                	lw	a0,4(a5)
    80005334:	60a2                	ld	ra,8(sp)
    80005336:	6402                	ld	s0,0(sp)
    80005338:	0141                	addi	sp,sp,16
    8000533a:	8082                	ret

000000008000533c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000533c:	1101                	addi	sp,sp,-32
    8000533e:	ec06                	sd	ra,24(sp)
    80005340:	e822                	sd	s0,16(sp)
    80005342:	e426                	sd	s1,8(sp)
    80005344:	1000                	addi	s0,sp,32
    80005346:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005348:	da4fc0ef          	jal	800018ec <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    8000534c:	00d5179b          	slliw	a5,a0,0xd
    80005350:	0c201737          	lui	a4,0xc201
    80005354:	97ba                	add	a5,a5,a4
    80005356:	c3c4                	sw	s1,4(a5)
}
    80005358:	60e2                	ld	ra,24(sp)
    8000535a:	6442                	ld	s0,16(sp)
    8000535c:	64a2                	ld	s1,8(sp)
    8000535e:	6105                	addi	sp,sp,32
    80005360:	8082                	ret

0000000080005362 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005362:	1141                	addi	sp,sp,-16
    80005364:	e406                	sd	ra,8(sp)
    80005366:	e022                	sd	s0,0(sp)
    80005368:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000536a:	479d                	li	a5,7
    8000536c:	04a7ca63          	blt	a5,a0,800053c0 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80005370:	0001e797          	auipc	a5,0x1e
    80005374:	1b078793          	addi	a5,a5,432 # 80023520 <disk>
    80005378:	97aa                	add	a5,a5,a0
    8000537a:	0187c783          	lbu	a5,24(a5)
    8000537e:	e7b9                	bnez	a5,800053cc <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005380:	00451693          	slli	a3,a0,0x4
    80005384:	0001e797          	auipc	a5,0x1e
    80005388:	19c78793          	addi	a5,a5,412 # 80023520 <disk>
    8000538c:	6398                	ld	a4,0(a5)
    8000538e:	9736                	add	a4,a4,a3
    80005390:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80005394:	6398                	ld	a4,0(a5)
    80005396:	9736                	add	a4,a4,a3
    80005398:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    8000539c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    800053a0:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    800053a4:	97aa                	add	a5,a5,a0
    800053a6:	4705                	li	a4,1
    800053a8:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    800053ac:	0001e517          	auipc	a0,0x1e
    800053b0:	18c50513          	addi	a0,a0,396 # 80023538 <disk+0x18>
    800053b4:	b87fc0ef          	jal	80001f3a <wakeup>
}
    800053b8:	60a2                	ld	ra,8(sp)
    800053ba:	6402                	ld	s0,0(sp)
    800053bc:	0141                	addi	sp,sp,16
    800053be:	8082                	ret
    panic("free_desc 1");
    800053c0:	00002517          	auipc	a0,0x2
    800053c4:	2b050513          	addi	a0,a0,688 # 80007670 <etext+0x670>
    800053c8:	c1afb0ef          	jal	800007e2 <panic>
    panic("free_desc 2");
    800053cc:	00002517          	auipc	a0,0x2
    800053d0:	2b450513          	addi	a0,a0,692 # 80007680 <etext+0x680>
    800053d4:	c0efb0ef          	jal	800007e2 <panic>

00000000800053d8 <virtio_disk_init>:
{
    800053d8:	1101                	addi	sp,sp,-32
    800053da:	ec06                	sd	ra,24(sp)
    800053dc:	e822                	sd	s0,16(sp)
    800053de:	e426                	sd	s1,8(sp)
    800053e0:	e04a                	sd	s2,0(sp)
    800053e2:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800053e4:	00002597          	auipc	a1,0x2
    800053e8:	2ac58593          	addi	a1,a1,684 # 80007690 <etext+0x690>
    800053ec:	0001e517          	auipc	a0,0x1e
    800053f0:	25c50513          	addi	a0,a0,604 # 80023648 <disk+0x128>
    800053f4:	fcafb0ef          	jal	80000bbe <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800053f8:	100017b7          	lui	a5,0x10001
    800053fc:	4398                	lw	a4,0(a5)
    800053fe:	2701                	sext.w	a4,a4
    80005400:	747277b7          	lui	a5,0x74727
    80005404:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005408:	14f71863          	bne	a4,a5,80005558 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    8000540c:	100017b7          	lui	a5,0x10001
    80005410:	43dc                	lw	a5,4(a5)
    80005412:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005414:	4709                	li	a4,2
    80005416:	14e79163          	bne	a5,a4,80005558 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000541a:	100017b7          	lui	a5,0x10001
    8000541e:	479c                	lw	a5,8(a5)
    80005420:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    80005422:	12e79b63          	bne	a5,a4,80005558 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005426:	100017b7          	lui	a5,0x10001
    8000542a:	47d8                	lw	a4,12(a5)
    8000542c:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000542e:	554d47b7          	lui	a5,0x554d4
    80005432:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005436:	12f71163          	bne	a4,a5,80005558 <virtio_disk_init+0x180>
  *R(VIRTIO_MMIO_STATUS) = status;
    8000543a:	100017b7          	lui	a5,0x10001
    8000543e:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005442:	4705                	li	a4,1
    80005444:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005446:	470d                	li	a4,3
    80005448:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    8000544a:	10001737          	lui	a4,0x10001
    8000544e:	4b18                	lw	a4,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005450:	c7ffe6b7          	lui	a3,0xc7ffe
    80005454:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdb0ff>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005458:	8f75                	and	a4,a4,a3
    8000545a:	100016b7          	lui	a3,0x10001
    8000545e:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005460:	472d                	li	a4,11
    80005462:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005464:	07078793          	addi	a5,a5,112
  status = *R(VIRTIO_MMIO_STATUS);
    80005468:	439c                	lw	a5,0(a5)
    8000546a:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    8000546e:	8ba1                	andi	a5,a5,8
    80005470:	0e078a63          	beqz	a5,80005564 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005474:	100017b7          	lui	a5,0x10001
    80005478:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    8000547c:	43fc                	lw	a5,68(a5)
    8000547e:	2781                	sext.w	a5,a5
    80005480:	0e079863          	bnez	a5,80005570 <virtio_disk_init+0x198>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005484:	100017b7          	lui	a5,0x10001
    80005488:	5bdc                	lw	a5,52(a5)
    8000548a:	2781                	sext.w	a5,a5
  if(max == 0)
    8000548c:	0e078863          	beqz	a5,8000557c <virtio_disk_init+0x1a4>
  if(max < NUM)
    80005490:	471d                	li	a4,7
    80005492:	0ef77b63          	bgeu	a4,a5,80005588 <virtio_disk_init+0x1b0>
  disk.desc = kalloc();
    80005496:	ed8fb0ef          	jal	80000b6e <kalloc>
    8000549a:	0001e497          	auipc	s1,0x1e
    8000549e:	08648493          	addi	s1,s1,134 # 80023520 <disk>
    800054a2:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    800054a4:	ecafb0ef          	jal	80000b6e <kalloc>
    800054a8:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    800054aa:	ec4fb0ef          	jal	80000b6e <kalloc>
    800054ae:	87aa                	mv	a5,a0
    800054b0:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    800054b2:	6088                	ld	a0,0(s1)
    800054b4:	0e050063          	beqz	a0,80005594 <virtio_disk_init+0x1bc>
    800054b8:	0001e717          	auipc	a4,0x1e
    800054bc:	07073703          	ld	a4,112(a4) # 80023528 <disk+0x8>
    800054c0:	cb71                	beqz	a4,80005594 <virtio_disk_init+0x1bc>
    800054c2:	cbe9                	beqz	a5,80005594 <virtio_disk_init+0x1bc>
  memset(disk.desc, 0, PGSIZE);
    800054c4:	6605                	lui	a2,0x1
    800054c6:	4581                	li	a1,0
    800054c8:	84bfb0ef          	jal	80000d12 <memset>
  memset(disk.avail, 0, PGSIZE);
    800054cc:	0001e497          	auipc	s1,0x1e
    800054d0:	05448493          	addi	s1,s1,84 # 80023520 <disk>
    800054d4:	6605                	lui	a2,0x1
    800054d6:	4581                	li	a1,0
    800054d8:	6488                	ld	a0,8(s1)
    800054da:	839fb0ef          	jal	80000d12 <memset>
  memset(disk.used, 0, PGSIZE);
    800054de:	6605                	lui	a2,0x1
    800054e0:	4581                	li	a1,0
    800054e2:	6888                	ld	a0,16(s1)
    800054e4:	82ffb0ef          	jal	80000d12 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800054e8:	100017b7          	lui	a5,0x10001
    800054ec:	4721                	li	a4,8
    800054ee:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800054f0:	4098                	lw	a4,0(s1)
    800054f2:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800054f6:	40d8                	lw	a4,4(s1)
    800054f8:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800054fc:	649c                	ld	a5,8(s1)
    800054fe:	0007869b          	sext.w	a3,a5
    80005502:	10001737          	lui	a4,0x10001
    80005506:	08d72823          	sw	a3,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    8000550a:	9781                	srai	a5,a5,0x20
    8000550c:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80005510:	689c                	ld	a5,16(s1)
    80005512:	0007869b          	sext.w	a3,a5
    80005516:	0ad72023          	sw	a3,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    8000551a:	9781                	srai	a5,a5,0x20
    8000551c:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80005520:	4785                	li	a5,1
    80005522:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80005524:	00f48c23          	sb	a5,24(s1)
    80005528:	00f48ca3          	sb	a5,25(s1)
    8000552c:	00f48d23          	sb	a5,26(s1)
    80005530:	00f48da3          	sb	a5,27(s1)
    80005534:	00f48e23          	sb	a5,28(s1)
    80005538:	00f48ea3          	sb	a5,29(s1)
    8000553c:	00f48f23          	sb	a5,30(s1)
    80005540:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80005544:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80005548:	07272823          	sw	s2,112(a4)
}
    8000554c:	60e2                	ld	ra,24(sp)
    8000554e:	6442                	ld	s0,16(sp)
    80005550:	64a2                	ld	s1,8(sp)
    80005552:	6902                	ld	s2,0(sp)
    80005554:	6105                	addi	sp,sp,32
    80005556:	8082                	ret
    panic("could not find virtio disk");
    80005558:	00002517          	auipc	a0,0x2
    8000555c:	14850513          	addi	a0,a0,328 # 800076a0 <etext+0x6a0>
    80005560:	a82fb0ef          	jal	800007e2 <panic>
    panic("virtio disk FEATURES_OK unset");
    80005564:	00002517          	auipc	a0,0x2
    80005568:	15c50513          	addi	a0,a0,348 # 800076c0 <etext+0x6c0>
    8000556c:	a76fb0ef          	jal	800007e2 <panic>
    panic("virtio disk should not be ready");
    80005570:	00002517          	auipc	a0,0x2
    80005574:	17050513          	addi	a0,a0,368 # 800076e0 <etext+0x6e0>
    80005578:	a6afb0ef          	jal	800007e2 <panic>
    panic("virtio disk has no queue 0");
    8000557c:	00002517          	auipc	a0,0x2
    80005580:	18450513          	addi	a0,a0,388 # 80007700 <etext+0x700>
    80005584:	a5efb0ef          	jal	800007e2 <panic>
    panic("virtio disk max queue too short");
    80005588:	00002517          	auipc	a0,0x2
    8000558c:	19850513          	addi	a0,a0,408 # 80007720 <etext+0x720>
    80005590:	a52fb0ef          	jal	800007e2 <panic>
    panic("virtio disk kalloc");
    80005594:	00002517          	auipc	a0,0x2
    80005598:	1ac50513          	addi	a0,a0,428 # 80007740 <etext+0x740>
    8000559c:	a46fb0ef          	jal	800007e2 <panic>

00000000800055a0 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    800055a0:	711d                	addi	sp,sp,-96
    800055a2:	ec86                	sd	ra,88(sp)
    800055a4:	e8a2                	sd	s0,80(sp)
    800055a6:	e4a6                	sd	s1,72(sp)
    800055a8:	e0ca                	sd	s2,64(sp)
    800055aa:	fc4e                	sd	s3,56(sp)
    800055ac:	f852                	sd	s4,48(sp)
    800055ae:	f456                	sd	s5,40(sp)
    800055b0:	f05a                	sd	s6,32(sp)
    800055b2:	ec5e                	sd	s7,24(sp)
    800055b4:	e862                	sd	s8,16(sp)
    800055b6:	1080                	addi	s0,sp,96
    800055b8:	89aa                	mv	s3,a0
    800055ba:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800055bc:	00c52b83          	lw	s7,12(a0)
    800055c0:	001b9b9b          	slliw	s7,s7,0x1
    800055c4:	1b82                	slli	s7,s7,0x20
    800055c6:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    800055ca:	0001e517          	auipc	a0,0x1e
    800055ce:	07e50513          	addi	a0,a0,126 # 80023648 <disk+0x128>
    800055d2:	e70fb0ef          	jal	80000c42 <acquire>
  for(int i = 0; i < NUM; i++){
    800055d6:	44a1                	li	s1,8
      disk.free[i] = 0;
    800055d8:	0001ea97          	auipc	s5,0x1e
    800055dc:	f48a8a93          	addi	s5,s5,-184 # 80023520 <disk>
  for(int i = 0; i < 3; i++){
    800055e0:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    800055e2:	5c7d                	li	s8,-1
    800055e4:	a095                	j	80005648 <virtio_disk_rw+0xa8>
      disk.free[i] = 0;
    800055e6:	00fa8733          	add	a4,s5,a5
    800055ea:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800055ee:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800055f0:	0207c563          	bltz	a5,8000561a <virtio_disk_rw+0x7a>
  for(int i = 0; i < 3; i++){
    800055f4:	2905                	addiw	s2,s2,1
    800055f6:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    800055f8:	05490c63          	beq	s2,s4,80005650 <virtio_disk_rw+0xb0>
    idx[i] = alloc_desc();
    800055fc:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    800055fe:	0001e717          	auipc	a4,0x1e
    80005602:	f2270713          	addi	a4,a4,-222 # 80023520 <disk>
    80005606:	4781                	li	a5,0
    if(disk.free[i]){
    80005608:	01874683          	lbu	a3,24(a4)
    8000560c:	fee9                	bnez	a3,800055e6 <virtio_disk_rw+0x46>
  for(int i = 0; i < NUM; i++){
    8000560e:	2785                	addiw	a5,a5,1
    80005610:	0705                	addi	a4,a4,1
    80005612:	fe979be3          	bne	a5,s1,80005608 <virtio_disk_rw+0x68>
    idx[i] = alloc_desc();
    80005616:	0185a023          	sw	s8,0(a1)
      for(int j = 0; j < i; j++)
    8000561a:	01205d63          	blez	s2,80005634 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    8000561e:	fa042503          	lw	a0,-96(s0)
    80005622:	d41ff0ef          	jal	80005362 <free_desc>
      for(int j = 0; j < i; j++)
    80005626:	4785                	li	a5,1
    80005628:	0127d663          	bge	a5,s2,80005634 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    8000562c:	fa442503          	lw	a0,-92(s0)
    80005630:	d33ff0ef          	jal	80005362 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005634:	0001e597          	auipc	a1,0x1e
    80005638:	01458593          	addi	a1,a1,20 # 80023648 <disk+0x128>
    8000563c:	0001e517          	auipc	a0,0x1e
    80005640:	efc50513          	addi	a0,a0,-260 # 80023538 <disk+0x18>
    80005644:	8abfc0ef          	jal	80001eee <sleep>
  for(int i = 0; i < 3; i++){
    80005648:	fa040613          	addi	a2,s0,-96
    8000564c:	4901                	li	s2,0
    8000564e:	b77d                	j	800055fc <virtio_disk_rw+0x5c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005650:	fa042503          	lw	a0,-96(s0)
    80005654:	00451693          	slli	a3,a0,0x4

  if(write)
    80005658:	0001e797          	auipc	a5,0x1e
    8000565c:	ec878793          	addi	a5,a5,-312 # 80023520 <disk>
    80005660:	00a50713          	addi	a4,a0,10
    80005664:	0712                	slli	a4,a4,0x4
    80005666:	973e                	add	a4,a4,a5
    80005668:	01603633          	snez	a2,s6
    8000566c:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    8000566e:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80005672:	01773823          	sd	s7,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005676:	6398                	ld	a4,0(a5)
    80005678:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000567a:	0a868613          	addi	a2,a3,168 # 100010a8 <_entry-0x6fffef58>
    8000567e:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005680:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80005682:	6390                	ld	a2,0(a5)
    80005684:	00d605b3          	add	a1,a2,a3
    80005688:	4741                	li	a4,16
    8000568a:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000568c:	4805                	li	a6,1
    8000568e:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80005692:	fa442703          	lw	a4,-92(s0)
    80005696:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    8000569a:	0712                	slli	a4,a4,0x4
    8000569c:	963a                	add	a2,a2,a4
    8000569e:	05898593          	addi	a1,s3,88
    800056a2:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    800056a4:	0007b883          	ld	a7,0(a5)
    800056a8:	9746                	add	a4,a4,a7
    800056aa:	40000613          	li	a2,1024
    800056ae:	c710                	sw	a2,8(a4)
  if(write)
    800056b0:	001b3613          	seqz	a2,s6
    800056b4:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800056b8:	01066633          	or	a2,a2,a6
    800056bc:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    800056c0:	fa842583          	lw	a1,-88(s0)
    800056c4:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800056c8:	00250613          	addi	a2,a0,2
    800056cc:	0612                	slli	a2,a2,0x4
    800056ce:	963e                	add	a2,a2,a5
    800056d0:	577d                	li	a4,-1
    800056d2:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800056d6:	0592                	slli	a1,a1,0x4
    800056d8:	98ae                	add	a7,a7,a1
    800056da:	03068713          	addi	a4,a3,48
    800056de:	973e                	add	a4,a4,a5
    800056e0:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    800056e4:	6398                	ld	a4,0(a5)
    800056e6:	972e                	add	a4,a4,a1
    800056e8:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800056ec:	4689                	li	a3,2
    800056ee:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    800056f2:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800056f6:	0109a223          	sw	a6,4(s3)
  disk.info[idx[0]].b = b;
    800056fa:	01363423          	sd	s3,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800056fe:	6794                	ld	a3,8(a5)
    80005700:	0026d703          	lhu	a4,2(a3)
    80005704:	8b1d                	andi	a4,a4,7
    80005706:	0706                	slli	a4,a4,0x1
    80005708:	96ba                	add	a3,a3,a4
    8000570a:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    8000570e:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005712:	6798                	ld	a4,8(a5)
    80005714:	00275783          	lhu	a5,2(a4)
    80005718:	2785                	addiw	a5,a5,1
    8000571a:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    8000571e:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005722:	100017b7          	lui	a5,0x10001
    80005726:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    8000572a:	0049a783          	lw	a5,4(s3)
    sleep(b, &disk.vdisk_lock);
    8000572e:	0001e917          	auipc	s2,0x1e
    80005732:	f1a90913          	addi	s2,s2,-230 # 80023648 <disk+0x128>
  while(b->disk == 1) {
    80005736:	84c2                	mv	s1,a6
    80005738:	01079a63          	bne	a5,a6,8000574c <virtio_disk_rw+0x1ac>
    sleep(b, &disk.vdisk_lock);
    8000573c:	85ca                	mv	a1,s2
    8000573e:	854e                	mv	a0,s3
    80005740:	faefc0ef          	jal	80001eee <sleep>
  while(b->disk == 1) {
    80005744:	0049a783          	lw	a5,4(s3)
    80005748:	fe978ae3          	beq	a5,s1,8000573c <virtio_disk_rw+0x19c>
  }

  disk.info[idx[0]].b = 0;
    8000574c:	fa042903          	lw	s2,-96(s0)
    80005750:	00290713          	addi	a4,s2,2
    80005754:	0712                	slli	a4,a4,0x4
    80005756:	0001e797          	auipc	a5,0x1e
    8000575a:	dca78793          	addi	a5,a5,-566 # 80023520 <disk>
    8000575e:	97ba                	add	a5,a5,a4
    80005760:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80005764:	0001e997          	auipc	s3,0x1e
    80005768:	dbc98993          	addi	s3,s3,-580 # 80023520 <disk>
    8000576c:	00491713          	slli	a4,s2,0x4
    80005770:	0009b783          	ld	a5,0(s3)
    80005774:	97ba                	add	a5,a5,a4
    80005776:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    8000577a:	854a                	mv	a0,s2
    8000577c:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005780:	be3ff0ef          	jal	80005362 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005784:	8885                	andi	s1,s1,1
    80005786:	f0fd                	bnez	s1,8000576c <virtio_disk_rw+0x1cc>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005788:	0001e517          	auipc	a0,0x1e
    8000578c:	ec050513          	addi	a0,a0,-320 # 80023648 <disk+0x128>
    80005790:	d46fb0ef          	jal	80000cd6 <release>
}
    80005794:	60e6                	ld	ra,88(sp)
    80005796:	6446                	ld	s0,80(sp)
    80005798:	64a6                	ld	s1,72(sp)
    8000579a:	6906                	ld	s2,64(sp)
    8000579c:	79e2                	ld	s3,56(sp)
    8000579e:	7a42                	ld	s4,48(sp)
    800057a0:	7aa2                	ld	s5,40(sp)
    800057a2:	7b02                	ld	s6,32(sp)
    800057a4:	6be2                	ld	s7,24(sp)
    800057a6:	6c42                	ld	s8,16(sp)
    800057a8:	6125                	addi	sp,sp,96
    800057aa:	8082                	ret

00000000800057ac <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800057ac:	1101                	addi	sp,sp,-32
    800057ae:	ec06                	sd	ra,24(sp)
    800057b0:	e822                	sd	s0,16(sp)
    800057b2:	e426                	sd	s1,8(sp)
    800057b4:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800057b6:	0001e497          	auipc	s1,0x1e
    800057ba:	d6a48493          	addi	s1,s1,-662 # 80023520 <disk>
    800057be:	0001e517          	auipc	a0,0x1e
    800057c2:	e8a50513          	addi	a0,a0,-374 # 80023648 <disk+0x128>
    800057c6:	c7cfb0ef          	jal	80000c42 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800057ca:	100017b7          	lui	a5,0x10001
    800057ce:	53bc                	lw	a5,96(a5)
    800057d0:	8b8d                	andi	a5,a5,3
    800057d2:	10001737          	lui	a4,0x10001
    800057d6:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800057d8:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800057dc:	689c                	ld	a5,16(s1)
    800057de:	0204d703          	lhu	a4,32(s1)
    800057e2:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    800057e6:	04f70663          	beq	a4,a5,80005832 <virtio_disk_intr+0x86>
    __sync_synchronize();
    800057ea:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800057ee:	6898                	ld	a4,16(s1)
    800057f0:	0204d783          	lhu	a5,32(s1)
    800057f4:	8b9d                	andi	a5,a5,7
    800057f6:	078e                	slli	a5,a5,0x3
    800057f8:	97ba                	add	a5,a5,a4
    800057fa:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    800057fc:	00278713          	addi	a4,a5,2
    80005800:	0712                	slli	a4,a4,0x4
    80005802:	9726                	add	a4,a4,s1
    80005804:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005808:	e321                	bnez	a4,80005848 <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000580a:	0789                	addi	a5,a5,2
    8000580c:	0792                	slli	a5,a5,0x4
    8000580e:	97a6                	add	a5,a5,s1
    80005810:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80005812:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005816:	f24fc0ef          	jal	80001f3a <wakeup>

    disk.used_idx += 1;
    8000581a:	0204d783          	lhu	a5,32(s1)
    8000581e:	2785                	addiw	a5,a5,1
    80005820:	17c2                	slli	a5,a5,0x30
    80005822:	93c1                	srli	a5,a5,0x30
    80005824:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005828:	6898                	ld	a4,16(s1)
    8000582a:	00275703          	lhu	a4,2(a4)
    8000582e:	faf71ee3          	bne	a4,a5,800057ea <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005832:	0001e517          	auipc	a0,0x1e
    80005836:	e1650513          	addi	a0,a0,-490 # 80023648 <disk+0x128>
    8000583a:	c9cfb0ef          	jal	80000cd6 <release>
}
    8000583e:	60e2                	ld	ra,24(sp)
    80005840:	6442                	ld	s0,16(sp)
    80005842:	64a2                	ld	s1,8(sp)
    80005844:	6105                	addi	sp,sp,32
    80005846:	8082                	ret
      panic("virtio_disk_intr status");
    80005848:	00002517          	auipc	a0,0x2
    8000584c:	f1050513          	addi	a0,a0,-240 # 80007758 <etext+0x758>
    80005850:	f93fa0ef          	jal	800007e2 <panic>
	...

0000000080006000 <_trampoline>:
    80006000:	14051073          	csrw	sscratch,a0
    80006004:	02000537          	lui	a0,0x2000
    80006008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000600a:	0536                	slli	a0,a0,0xd
    8000600c:	02153423          	sd	ra,40(a0)
    80006010:	02253823          	sd	sp,48(a0)
    80006014:	02353c23          	sd	gp,56(a0)
    80006018:	04453023          	sd	tp,64(a0)
    8000601c:	04553423          	sd	t0,72(a0)
    80006020:	04653823          	sd	t1,80(a0)
    80006024:	04753c23          	sd	t2,88(a0)
    80006028:	f120                	sd	s0,96(a0)
    8000602a:	f524                	sd	s1,104(a0)
    8000602c:	fd2c                	sd	a1,120(a0)
    8000602e:	e150                	sd	a2,128(a0)
    80006030:	e554                	sd	a3,136(a0)
    80006032:	e958                	sd	a4,144(a0)
    80006034:	ed5c                	sd	a5,152(a0)
    80006036:	0b053023          	sd	a6,160(a0)
    8000603a:	0b153423          	sd	a7,168(a0)
    8000603e:	0b253823          	sd	s2,176(a0)
    80006042:	0b353c23          	sd	s3,184(a0)
    80006046:	0d453023          	sd	s4,192(a0)
    8000604a:	0d553423          	sd	s5,200(a0)
    8000604e:	0d653823          	sd	s6,208(a0)
    80006052:	0d753c23          	sd	s7,216(a0)
    80006056:	0f853023          	sd	s8,224(a0)
    8000605a:	0f953423          	sd	s9,232(a0)
    8000605e:	0fa53823          	sd	s10,240(a0)
    80006062:	0fb53c23          	sd	s11,248(a0)
    80006066:	11c53023          	sd	t3,256(a0)
    8000606a:	11d53423          	sd	t4,264(a0)
    8000606e:	11e53823          	sd	t5,272(a0)
    80006072:	11f53c23          	sd	t6,280(a0)
    80006076:	140022f3          	csrr	t0,sscratch
    8000607a:	06553823          	sd	t0,112(a0)
    8000607e:	00853103          	ld	sp,8(a0)
    80006082:	02053203          	ld	tp,32(a0)
    80006086:	01053283          	ld	t0,16(a0)
    8000608a:	00053303          	ld	t1,0(a0)
    8000608e:	12000073          	sfence.vma
    80006092:	18031073          	csrw	satp,t1
    80006096:	12000073          	sfence.vma
    8000609a:	8282                	jr	t0

000000008000609c <userret>:
    8000609c:	12000073          	sfence.vma
    800060a0:	18051073          	csrw	satp,a0
    800060a4:	12000073          	sfence.vma
    800060a8:	02000537          	lui	a0,0x2000
    800060ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800060ae:	0536                	slli	a0,a0,0xd
    800060b0:	02853083          	ld	ra,40(a0)
    800060b4:	03053103          	ld	sp,48(a0)
    800060b8:	03853183          	ld	gp,56(a0)
    800060bc:	04053203          	ld	tp,64(a0)
    800060c0:	04853283          	ld	t0,72(a0)
    800060c4:	05053303          	ld	t1,80(a0)
    800060c8:	05853383          	ld	t2,88(a0)
    800060cc:	7120                	ld	s0,96(a0)
    800060ce:	7524                	ld	s1,104(a0)
    800060d0:	7d2c                	ld	a1,120(a0)
    800060d2:	6150                	ld	a2,128(a0)
    800060d4:	6554                	ld	a3,136(a0)
    800060d6:	6958                	ld	a4,144(a0)
    800060d8:	6d5c                	ld	a5,152(a0)
    800060da:	0a053803          	ld	a6,160(a0)
    800060de:	0a853883          	ld	a7,168(a0)
    800060e2:	0b053903          	ld	s2,176(a0)
    800060e6:	0b853983          	ld	s3,184(a0)
    800060ea:	0c053a03          	ld	s4,192(a0)
    800060ee:	0c853a83          	ld	s5,200(a0)
    800060f2:	0d053b03          	ld	s6,208(a0)
    800060f6:	0d853b83          	ld	s7,216(a0)
    800060fa:	0e053c03          	ld	s8,224(a0)
    800060fe:	0e853c83          	ld	s9,232(a0)
    80006102:	0f053d03          	ld	s10,240(a0)
    80006106:	0f853d83          	ld	s11,248(a0)
    8000610a:	10053e03          	ld	t3,256(a0)
    8000610e:	10853e83          	ld	t4,264(a0)
    80006112:	11053f03          	ld	t5,272(a0)
    80006116:	11853f83          	ld	t6,280(a0)
    8000611a:	7928                	ld	a0,112(a0)
    8000611c:	10200073          	sret
	...
