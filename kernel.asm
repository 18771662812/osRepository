
kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	f1402573          	csrr	a0,mhartid
    80000004:	e11d                	bnez	a0,8000002a <park>
    80000006:	00002117          	auipc	sp,0x2
    8000000a:	ffa10113          	addi	sp,sp,-6 # 80002000 <pmm_manager>
    8000000e:	00002517          	auipc	a0,0x2
    80000012:	ff250513          	addi	a0,a0,-14 # 80002000 <pmm_manager>
    80000016:	00002597          	auipc	a1,0x2
    8000001a:	01a58593          	addi	a1,a1,26 # 80002030 <kernel_pagetable>
    8000001e:	012000ef          	jal	ra,80000030 <clear_bss>
    80000022:	4329                	li	t1,10
    80000024:	00628023          	sb	t1,0(t0)
    80000028:	a821                	j	80000040 <start>

000000008000002a <park>:
    8000002a:	10500073          	wfi
    8000002e:	bff5                	j	8000002a <park>

0000000080000030 <clear_bss>:
    80000030:	00b57763          	bgeu	a0,a1,8000003e <bss_done>
    80000034:	00053023          	sd	zero,0(a0)
    80000038:	0521                	addi	a0,a0,8
    8000003a:	feb56de3          	bltu	a0,a1,80000034 <clear_bss+0x4>

000000008000003e <bss_done>:
    8000003e:	8082                	ret

0000000080000040 <start>:
    80000040:	1141                	addi	sp,sp,-16
    80000042:	e406                	sd	ra,8(sp)
    80000044:	00001617          	auipc	a2,0x1
    80000048:	b9c60613          	addi	a2,a2,-1124 # 80000be0 <_text_end+0x4>
    8000004c:	05200693          	li	a3,82
    80000050:	10000737          	lui	a4,0x10000
    80000054:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000058:	0407f793          	andi	a5,a5,64
    8000005c:	dfe5                	beqz	a5,80000054 <start+0x14>
    8000005e:	00d70023          	sb	a3,0(a4)
    80000062:	00164683          	lbu	a3,1(a2)
    80000066:	0605                	addi	a2,a2,1
    80000068:	f6f5                	bnez	a3,80000054 <start+0x14>
    8000006a:	198000ef          	jal	ra,80000202 <main>
    8000006e:	10500073          	wfi
    80000072:	10500073          	wfi
    80000076:	bfe5                	j	8000006e <start+0x2e>

0000000080000078 <assert>:
    80000078:	c111                	beqz	a0,8000007c <assert+0x4>
    8000007a:	8082                	ret
    8000007c:	1141                	addi	sp,sp,-16
    8000007e:	00001517          	auipc	a0,0x1
    80000082:	b7a50513          	addi	a0,a0,-1158 # 80000bf8 <_text_end+0x1c>
    80000086:	e406                	sd	ra,8(sp)
    80000088:	24c000ef          	jal	ra,800002d4 <printf>
    8000008c:	10500073          	wfi
    80000090:	10500073          	wfi
    80000094:	bfe5                	j	8000008c <assert+0x14>

0000000080000096 <test_physical_memory>:
    80000096:	1101                	addi	sp,sp,-32
    80000098:	e822                	sd	s0,16(sp)
    8000009a:	ec06                	sd	ra,24(sp)
    8000009c:	e426                	sd	s1,8(sp)
    8000009e:	52e000ef          	jal	ra,800005cc <alloc_page>
    800000a2:	842a                	mv	s0,a0
    800000a4:	528000ef          	jal	ra,800005cc <alloc_page>
    800000a8:	04a40763          	beq	s0,a0,800000f6 <test_physical_memory+0x60>
    800000ac:	03441793          	slli	a5,s0,0x34
    800000b0:	eb85                	bnez	a5,800000e0 <test_physical_memory+0x4a>
    800000b2:	123457b7          	lui	a5,0x12345
    800000b6:	67878793          	addi	a5,a5,1656 # 12345678 <_entry-0x6dcba988>
    800000ba:	c01c                	sw	a5,0(s0)
    800000bc:	84aa                	mv	s1,a0
    800000be:	8522                	mv	a0,s0
    800000c0:	556000ef          	jal	ra,80000616 <free_page>
    800000c4:	508000ef          	jal	ra,800005cc <alloc_page>
    800000c8:	842a                	mv	s0,a0
    800000ca:	8526                	mv	a0,s1
    800000cc:	54a000ef          	jal	ra,80000616 <free_page>
    800000d0:	8522                	mv	a0,s0
    800000d2:	544000ef          	jal	ra,80000616 <free_page>
    800000d6:	6442                	ld	s0,16(sp)
    800000d8:	60e2                	ld	ra,24(sp)
    800000da:	64a2                	ld	s1,8(sp)
    800000dc:	6105                	addi	sp,sp,32
    800000de:	ad71                	j	8000077a <pmm_info>
    800000e0:	00001517          	auipc	a0,0x1
    800000e4:	b1850513          	addi	a0,a0,-1256 # 80000bf8 <_text_end+0x1c>
    800000e8:	1ec000ef          	jal	ra,800002d4 <printf>
    800000ec:	10500073          	wfi
    800000f0:	10500073          	wfi
    800000f4:	bfe5                	j	800000ec <test_physical_memory+0x56>
    800000f6:	00001517          	auipc	a0,0x1
    800000fa:	b0250513          	addi	a0,a0,-1278 # 80000bf8 <_text_end+0x1c>
    800000fe:	1d6000ef          	jal	ra,800002d4 <printf>
    80000102:	10500073          	wfi
    80000106:	10500073          	wfi
    8000010a:	bfe5                	j	80000102 <test_physical_memory+0x6c>

000000008000010c <test_pagetable>:
    8000010c:	1101                	addi	sp,sp,-32
    8000010e:	ec06                	sd	ra,24(sp)
    80000110:	e822                	sd	s0,16(sp)
    80000112:	e426                	sd	s1,8(sp)
    80000114:	e04a                	sd	s2,0(sp)
    80000116:	7de000ef          	jal	ra,800008f4 <create_pagetable>
    8000011a:	842a                	mv	s0,a0
    8000011c:	4b0000ef          	jal	ra,800005cc <alloc_page>
    80000120:	84aa                	mv	s1,a0
    80000122:	862a                	mv	a2,a0
    80000124:	4699                	li	a3,6
    80000126:	010005b7          	lui	a1,0x1000
    8000012a:	8522                	mv	a0,s0
    8000012c:	041000ef          	jal	ra,8000096c <map_page>
    80000130:	e135                	bnez	a0,80000194 <test_pagetable+0x88>
    80000132:	010005b7          	lui	a1,0x1000
    80000136:	8522                	mv	a0,s0
    80000138:	7e8000ef          	jal	ra,80000920 <walk_lookup>
    8000013c:	c945                	beqz	a0,800001ec <test_pagetable+0xe0>
    8000013e:	611c                	ld	a5,0(a0)
    80000140:	0017f713          	andi	a4,a5,1
    80000144:	c745                	beqz	a4,800001ec <test_pagetable+0xe0>
    80000146:	fff00737          	lui	a4,0xfff00
    8000014a:	00279913          	slli	s2,a5,0x2
    8000014e:	8321                	srli	a4,a4,0x8
    80000150:	00e97933          	and	s2,s2,a4
    80000154:	02991563          	bne	s2,s1,8000017e <test_pagetable+0x72>
    80000158:	0027f713          	andi	a4,a5,2
    8000015c:	0007869b          	sext.w	a3,a5
    80000160:	c325                	beqz	a4,800001c0 <test_pagetable+0xb4>
    80000162:	8a91                	andi	a3,a3,4
    80000164:	caad                	beqz	a3,800001d6 <test_pagetable+0xca>
    80000166:	8ba1                	andi	a5,a5,8
    80000168:	e3a9                	bnez	a5,800001aa <test_pagetable+0x9e>
    8000016a:	8522                	mv	a0,s0
    8000016c:	041000ef          	jal	ra,800009ac <destroy_pagetable>
    80000170:	6442                	ld	s0,16(sp)
    80000172:	60e2                	ld	ra,24(sp)
    80000174:	64a2                	ld	s1,8(sp)
    80000176:	854a                	mv	a0,s2
    80000178:	6902                	ld	s2,0(sp)
    8000017a:	6105                	addi	sp,sp,32
    8000017c:	a969                	j	80000616 <free_page>
    8000017e:	00001517          	auipc	a0,0x1
    80000182:	a7a50513          	addi	a0,a0,-1414 # 80000bf8 <_text_end+0x1c>
    80000186:	14e000ef          	jal	ra,800002d4 <printf>
    8000018a:	10500073          	wfi
    8000018e:	10500073          	wfi
    80000192:	bfe5                	j	8000018a <test_pagetable+0x7e>
    80000194:	00001517          	auipc	a0,0x1
    80000198:	a6450513          	addi	a0,a0,-1436 # 80000bf8 <_text_end+0x1c>
    8000019c:	138000ef          	jal	ra,800002d4 <printf>
    800001a0:	10500073          	wfi
    800001a4:	10500073          	wfi
    800001a8:	bfe5                	j	800001a0 <test_pagetable+0x94>
    800001aa:	00001517          	auipc	a0,0x1
    800001ae:	a4e50513          	addi	a0,a0,-1458 # 80000bf8 <_text_end+0x1c>
    800001b2:	122000ef          	jal	ra,800002d4 <printf>
    800001b6:	10500073          	wfi
    800001ba:	10500073          	wfi
    800001be:	bfe5                	j	800001b6 <test_pagetable+0xaa>
    800001c0:	00001517          	auipc	a0,0x1
    800001c4:	a3850513          	addi	a0,a0,-1480 # 80000bf8 <_text_end+0x1c>
    800001c8:	10c000ef          	jal	ra,800002d4 <printf>
    800001cc:	10500073          	wfi
    800001d0:	10500073          	wfi
    800001d4:	bfe5                	j	800001cc <test_pagetable+0xc0>
    800001d6:	00001517          	auipc	a0,0x1
    800001da:	a2250513          	addi	a0,a0,-1502 # 80000bf8 <_text_end+0x1c>
    800001de:	0f6000ef          	jal	ra,800002d4 <printf>
    800001e2:	10500073          	wfi
    800001e6:	10500073          	wfi
    800001ea:	bfe5                	j	800001e2 <test_pagetable+0xd6>
    800001ec:	00001517          	auipc	a0,0x1
    800001f0:	a0c50513          	addi	a0,a0,-1524 # 80000bf8 <_text_end+0x1c>
    800001f4:	0e0000ef          	jal	ra,800002d4 <printf>
    800001f8:	10500073          	wfi
    800001fc:	10500073          	wfi
    80000200:	bfe5                	j	800001f8 <test_pagetable+0xec>

0000000080000202 <main>:
    80000202:	1141                	addi	sp,sp,-16
    80000204:	00001517          	auipc	a0,0x1
    80000208:	a0c50513          	addi	a0,a0,-1524 # 80000c10 <_text_end+0x34>
    8000020c:	e406                	sd	ra,8(sp)
    8000020e:	0c6000ef          	jal	ra,800002d4 <printf>
    80000212:	31a000ef          	jal	ra,8000052c <pmm_init>
    80000216:	0d9000ef          	jal	ra,80000aee <kvminit>
    8000021a:	191000ef          	jal	ra,80000baa <kvminithart>
    8000021e:	e79ff0ef          	jal	ra,80000096 <test_physical_memory>
    80000222:	60a2                	ld	ra,8(sp)
    80000224:	0141                	addi	sp,sp,16
    80000226:	b5dd                	j	8000010c <test_pagetable>

0000000080000228 <uart_putc>:
    80000228:	10000737          	lui	a4,0x10000
    8000022c:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80000230:	0207f793          	andi	a5,a5,32
    80000234:	dfe5                	beqz	a5,8000022c <uart_putc+0x4>
    80000236:	00a70023          	sb	a0,0(a4)
    8000023a:	8082                	ret

000000008000023c <uart_puts>:
    8000023c:	00054683          	lbu	a3,0(a0)
    80000240:	ce91                	beqz	a3,8000025c <uart_puts+0x20>
    80000242:	10000737          	lui	a4,0x10000
    80000246:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000024a:	0207f793          	andi	a5,a5,32
    8000024e:	dfe5                	beqz	a5,80000246 <uart_puts+0xa>
    80000250:	00d70023          	sb	a3,0(a4)
    80000254:	00154683          	lbu	a3,1(a0)
    80000258:	0505                	addi	a0,a0,1
    8000025a:	f6f5                	bnez	a3,80000246 <uart_puts+0xa>
    8000025c:	8082                	ret

000000008000025e <printint>:
    8000025e:	7139                	addi	sp,sp,-64
    80000260:	fc06                	sd	ra,56(sp)
    80000262:	f822                	sd	s0,48(sp)
    80000264:	f426                	sd	s1,40(sp)
    80000266:	87aa                	mv	a5,a0
    80000268:	c219                	beqz	a2,8000026e <printint+0x10>
    8000026a:	06054263          	bltz	a0,800002ce <printint+0x70>
    8000026e:	4601                	li	a2,0
    80000270:	0034                	addi	a3,sp,8
    80000272:	4801                	li	a6,0
    80000274:	00001317          	auipc	t1,0x1
    80000278:	9b430313          	addi	t1,t1,-1612 # 80000c28 <digits>
    8000027c:	02b7f733          	remu	a4,a5,a1
    80000280:	0685                	addi	a3,a3,1
    80000282:	88be                	mv	a7,a5
    80000284:	8442                	mv	s0,a6
    80000286:	2805                	addiw	a6,a6,1
    80000288:	971a                	add	a4,a4,t1
    8000028a:	00074503          	lbu	a0,0(a4)
    8000028e:	02b7d7b3          	divu	a5,a5,a1
    80000292:	fea68fa3          	sb	a0,-1(a3)
    80000296:	feb8f3e3          	bgeu	a7,a1,8000027c <printint+0x1e>
    8000029a:	ca11                	beqz	a2,800002ae <printint+0x50>
    8000029c:	101c                	addi	a5,sp,32
    8000029e:	97c2                	add	a5,a5,a6
    800002a0:	02d00713          	li	a4,45
    800002a4:	fee78423          	sb	a4,-24(a5)
    800002a8:	8442                	mv	s0,a6
    800002aa:	02d00513          	li	a0,45
    800002ae:	003c                	addi	a5,sp,8
    800002b0:	943e                	add	s0,s0,a5
    800002b2:	84be                	mv	s1,a5
    800002b4:	a021                	j	800002bc <printint+0x5e>
    800002b6:	fff44503          	lbu	a0,-1(s0)
    800002ba:	147d                	addi	s0,s0,-1
    800002bc:	f6dff0ef          	jal	ra,80000228 <uart_putc>
    800002c0:	fe941be3          	bne	s0,s1,800002b6 <printint+0x58>
    800002c4:	70e2                	ld	ra,56(sp)
    800002c6:	7442                	ld	s0,48(sp)
    800002c8:	74a2                	ld	s1,40(sp)
    800002ca:	6121                	addi	sp,sp,64
    800002cc:	8082                	ret
    800002ce:	40a007b3          	neg	a5,a0
    800002d2:	bf79                	j	80000270 <printint+0x12>

00000000800002d4 <printf>:
    800002d4:	7131                	addi	sp,sp,-192
    800002d6:	f0ca                	sd	s2,96(sp)
    800002d8:	fc86                	sd	ra,120(sp)
    800002da:	f8a2                	sd	s0,112(sp)
    800002dc:	f4a6                	sd	s1,104(sp)
    800002de:	ecce                	sd	s3,88(sp)
    800002e0:	e8d2                	sd	s4,80(sp)
    800002e2:	e4d6                	sd	s5,72(sp)
    800002e4:	e0da                	sd	s6,64(sp)
    800002e6:	fc5e                	sd	s7,56(sp)
    800002e8:	f862                	sd	s8,48(sp)
    800002ea:	f466                	sd	s9,40(sp)
    800002ec:	f06a                	sd	s10,32(sp)
    800002ee:	ec6e                	sd	s11,24(sp)
    800002f0:	892a                	mv	s2,a0
    800002f2:	00054503          	lbu	a0,0(a0)
    800002f6:	f53e                	sd	a5,168(sp)
    800002f8:	013c                	addi	a5,sp,136
    800002fa:	e52e                	sd	a1,136(sp)
    800002fc:	e932                	sd	a2,144(sp)
    800002fe:	ed36                	sd	a3,152(sp)
    80000300:	f13a                	sd	a4,160(sp)
    80000302:	f942                	sd	a6,176(sp)
    80000304:	fd46                	sd	a7,184(sp)
    80000306:	e43e                	sd	a5,8(sp)
    80000308:	c129                	beqz	a0,8000034a <printf+0x76>
    8000030a:	4481                	li	s1,0
    8000030c:	00148d1b          	addiw	s10,s1,1
    80000310:	01a90433          	add	s0,s2,s10
    80000314:	0005079b          	sext.w	a5,a0
    80000318:	02500993          	li	s3,37
    8000031c:	06400a93          	li	s5,100
    80000320:	06c00b93          	li	s7,108
    80000324:	07500c93          	li	s9,117
    80000328:	07800b13          	li	s6,120
    8000032c:	07000c13          	li	s8,112
    80000330:	00001a17          	auipc	s4,0x1
    80000334:	8f8a0a13          	addi	s4,s4,-1800 # 80000c28 <digits>
    80000338:	8722                	mv	a4,s0
    8000033a:	0b379163          	bne	a5,s3,800003dc <printf+0x108>
    8000033e:	00044d83          	lbu	s11,0(s0)
    80000342:	000d879b          	sext.w	a5,s11
    80000346:	020d9263          	bnez	s11,8000036a <printf+0x96>
    8000034a:	70e6                	ld	ra,120(sp)
    8000034c:	7446                	ld	s0,112(sp)
    8000034e:	74a6                	ld	s1,104(sp)
    80000350:	7906                	ld	s2,96(sp)
    80000352:	69e6                	ld	s3,88(sp)
    80000354:	6a46                	ld	s4,80(sp)
    80000356:	6aa6                	ld	s5,72(sp)
    80000358:	6b06                	ld	s6,64(sp)
    8000035a:	7be2                	ld	s7,56(sp)
    8000035c:	7c42                	ld	s8,48(sp)
    8000035e:	7ca2                	ld	s9,40(sp)
    80000360:	7d02                	ld	s10,32(sp)
    80000362:	6de2                	ld	s11,24(sp)
    80000364:	4501                	li	a0,0
    80000366:	6129                	addi	sp,sp,192
    80000368:	8082                	ret
    8000036a:	001d0413          	addi	s0,s10,1
    8000036e:	944a                	add	s0,s0,s2
    80000370:	00044683          	lbu	a3,0(s0)
    80000374:	4601                	li	a2,0
    80000376:	c299                	beqz	a3,8000037c <printf+0xa8>
    80000378:	00274603          	lbu	a2,2(a4)
    8000037c:	07578463          	beq	a5,s5,800003e4 <printf+0x110>
    80000380:	09778763          	beq	a5,s7,8000040e <printf+0x13a>
    80000384:	07978a63          	beq	a5,s9,800003f8 <printf+0x124>
    80000388:	0b678863          	beq	a5,s6,80000438 <printf+0x164>
    8000038c:	0d878c63          	beq	a5,s8,80000464 <printf+0x190>
    80000390:	06300713          	li	a4,99
    80000394:	10e78363          	beq	a5,a4,8000049a <printf+0x1c6>
    80000398:	07300713          	li	a4,115
    8000039c:	10e78c63          	beq	a5,a4,800004b4 <printf+0x1e0>
    800003a0:	01379a63          	bne	a5,s3,800003b4 <printf+0xe0>
    800003a4:	02500513          	li	a0,37
    800003a8:	e81ff0ef          	jal	ra,80000228 <uart_putc>
    800003ac:	2489                	addiw	s1,s1,2
    800003ae:	a819                	j	800003c4 <printf+0xf0>
    800003b0:	0f668e63          	beq	a3,s6,800004ac <printf+0x1d8>
    800003b4:	02500513          	li	a0,37
    800003b8:	e71ff0ef          	jal	ra,80000228 <uart_putc>
    800003bc:	856e                	mv	a0,s11
    800003be:	e6bff0ef          	jal	ra,80000228 <uart_putc>
    800003c2:	2489                	addiw	s1,s1,2
    800003c4:	00044503          	lbu	a0,0(s0)
    800003c8:	0005079b          	sext.w	a5,a0
    800003cc:	dd3d                	beqz	a0,8000034a <printf+0x76>
    800003ce:	00148d1b          	addiw	s10,s1,1
    800003d2:	01a90433          	add	s0,s2,s10
    800003d6:	8722                	mv	a4,s0
    800003d8:	f73783e3          	beq	a5,s3,8000033e <printf+0x6a>
    800003dc:	e4dff0ef          	jal	ra,80000228 <uart_putc>
    800003e0:	84ea                	mv	s1,s10
    800003e2:	b7cd                	j	800003c4 <printf+0xf0>
    800003e4:	67a2                	ld	a5,8(sp)
    800003e6:	4605                	li	a2,1
    800003e8:	45a9                	li	a1,10
    800003ea:	4388                	lw	a0,0(a5)
    800003ec:	07a1                	addi	a5,a5,8
    800003ee:	e43e                	sd	a5,8(sp)
    800003f0:	2489                	addiw	s1,s1,2
    800003f2:	e6dff0ef          	jal	ra,8000025e <printint>
    800003f6:	b7f9                	j	800003c4 <printf+0xf0>
    800003f8:	67a2                	ld	a5,8(sp)
    800003fa:	4601                	li	a2,0
    800003fc:	45a9                	li	a1,10
    800003fe:	0007e503          	lwu	a0,0(a5)
    80000402:	07a1                	addi	a5,a5,8
    80000404:	e43e                	sd	a5,8(sp)
    80000406:	2489                	addiw	s1,s1,2
    80000408:	e57ff0ef          	jal	ra,8000025e <printint>
    8000040c:	bf65                	j	800003c4 <printf+0xf0>
    8000040e:	01569e63          	bne	a3,s5,8000042a <printf+0x156>
    80000412:	67a2                	ld	a5,8(sp)
    80000414:	4605                	li	a2,1
    80000416:	45a9                	li	a1,10
    80000418:	6388                	ld	a0,0(a5)
    8000041a:	248d                	addiw	s1,s1,3
    8000041c:	07a1                	addi	a5,a5,8
    8000041e:	e43e                	sd	a5,8(sp)
    80000420:	00990433          	add	s0,s2,s1
    80000424:	e3bff0ef          	jal	ra,8000025e <printint>
    80000428:	bf71                	j	800003c4 <printf+0xf0>
    8000042a:	01768b63          	beq	a3,s7,80000440 <printf+0x16c>
    8000042e:	f99691e3          	bne	a3,s9,800003b0 <printf+0xdc>
    80000432:	67a2                	ld	a5,8(sp)
    80000434:	4601                	li	a2,0
    80000436:	b7c5                	j	80000416 <printf+0x142>
    80000438:	67a2                	ld	a5,8(sp)
    8000043a:	4601                	li	a2,0
    8000043c:	45c1                	li	a1,16
    8000043e:	b7c1                	j	800003fe <printf+0x12a>
    80000440:	09560a63          	beq	a2,s5,800004d4 <printf+0x200>
    80000444:	09960c63          	beq	a2,s9,800004dc <printf+0x208>
    80000448:	f76616e3          	bne	a2,s6,800003b4 <printf+0xe0>
    8000044c:	67a2                	ld	a5,8(sp)
    8000044e:	4601                	li	a2,0
    80000450:	45c1                	li	a1,16
    80000452:	6388                	ld	a0,0(a5)
    80000454:	2491                	addiw	s1,s1,4
    80000456:	07a1                	addi	a5,a5,8
    80000458:	e43e                	sd	a5,8(sp)
    8000045a:	00990433          	add	s0,s2,s1
    8000045e:	e01ff0ef          	jal	ra,8000025e <printint>
    80000462:	b78d                	j	800003c4 <printf+0xf0>
    80000464:	67a2                	ld	a5,8(sp)
    80000466:	03000513          	li	a0,48
    8000046a:	4dc1                	li	s11,16
    8000046c:	00878713          	addi	a4,a5,8
    80000470:	0007bd03          	ld	s10,0(a5)
    80000474:	e43a                	sd	a4,8(sp)
    80000476:	db3ff0ef          	jal	ra,80000228 <uart_putc>
    8000047a:	07800513          	li	a0,120
    8000047e:	dabff0ef          	jal	ra,80000228 <uart_putc>
    80000482:	03cd5793          	srli	a5,s10,0x3c
    80000486:	97d2                	add	a5,a5,s4
    80000488:	0007c503          	lbu	a0,0(a5)
    8000048c:	3dfd                	addiw	s11,s11,-1
    8000048e:	0d12                	slli	s10,s10,0x4
    80000490:	d99ff0ef          	jal	ra,80000228 <uart_putc>
    80000494:	fe0d97e3          	bnez	s11,80000482 <printf+0x1ae>
    80000498:	b72d                	j	800003c2 <printf+0xee>
    8000049a:	67a2                	ld	a5,8(sp)
    8000049c:	2489                	addiw	s1,s1,2
    8000049e:	0007c503          	lbu	a0,0(a5)
    800004a2:	07a1                	addi	a5,a5,8
    800004a4:	e43e                	sd	a5,8(sp)
    800004a6:	d83ff0ef          	jal	ra,80000228 <uart_putc>
    800004aa:	bf29                	j	800003c4 <printf+0xf0>
    800004ac:	67a2                	ld	a5,8(sp)
    800004ae:	4601                	li	a2,0
    800004b0:	45c1                	li	a1,16
    800004b2:	b79d                	j	80000418 <printf+0x144>
    800004b4:	67a2                	ld	a5,8(sp)
    800004b6:	2489                	addiw	s1,s1,2
    800004b8:	0007bd03          	ld	s10,0(a5)
    800004bc:	07a1                	addi	a5,a5,8
    800004be:	e43e                	sd	a5,8(sp)
    800004c0:	000d1663          	bnez	s10,800004cc <printf+0x1f8>
    800004c4:	a005                	j	800004e4 <printf+0x210>
    800004c6:	0d05                	addi	s10,s10,1
    800004c8:	d61ff0ef          	jal	ra,80000228 <uart_putc>
    800004cc:	000d4503          	lbu	a0,0(s10)
    800004d0:	f97d                	bnez	a0,800004c6 <printf+0x1f2>
    800004d2:	bdcd                	j	800003c4 <printf+0xf0>
    800004d4:	67a2                	ld	a5,8(sp)
    800004d6:	4605                	li	a2,1
    800004d8:	45a9                	li	a1,10
    800004da:	bfa5                	j	80000452 <printf+0x17e>
    800004dc:	67a2                	ld	a5,8(sp)
    800004de:	4601                	li	a2,0
    800004e0:	45a9                	li	a1,10
    800004e2:	bf85                	j	80000452 <printf+0x17e>
    800004e4:	00000d17          	auipc	s10,0x0
    800004e8:	73cd0d13          	addi	s10,s10,1852 # 80000c20 <_text_end+0x44>
    800004ec:	02800513          	li	a0,40
    800004f0:	bfd9                	j	800004c6 <printf+0x1f2>

00000000800004f2 <clear_screen>:
    800004f2:	1141                	addi	sp,sp,-16
    800004f4:	456d                	li	a0,27
    800004f6:	e406                	sd	ra,8(sp)
    800004f8:	d31ff0ef          	jal	ra,80000228 <uart_putc>
    800004fc:	05b00513          	li	a0,91
    80000500:	d29ff0ef          	jal	ra,80000228 <uart_putc>
    80000504:	03200513          	li	a0,50
    80000508:	d21ff0ef          	jal	ra,80000228 <uart_putc>
    8000050c:	04a00513          	li	a0,74
    80000510:	d19ff0ef          	jal	ra,80000228 <uart_putc>
    80000514:	456d                	li	a0,27
    80000516:	d13ff0ef          	jal	ra,80000228 <uart_putc>
    8000051a:	05b00513          	li	a0,91
    8000051e:	d0bff0ef          	jal	ra,80000228 <uart_putc>
    80000522:	60a2                	ld	ra,8(sp)
    80000524:	04800513          	li	a0,72
    80000528:	0141                	addi	sp,sp,16
    8000052a:	b9fd                	j	80000228 <uart_putc>

000000008000052c <pmm_init>:
    8000052c:	1141                	addi	sp,sp,-16
    8000052e:	4705                	li	a4,1
    80000530:	077e                	slli	a4,a4,0x1f
    80000532:	e022                	sd	s0,0(sp)
    80000534:	00002417          	auipc	s0,0x2
    80000538:	acc40413          	addi	s0,s0,-1332 # 80002000 <pmm_manager>
    8000053c:	f018                	sd	a4,32(s0)
    8000053e:	4745                	li	a4,17
    80000540:	076e                	slli	a4,a4,0x1b
    80000542:	f418                	sd	a4,40(s0)
    80000544:	6721                	lui	a4,0x8
    80000546:	177d                	addi	a4,a4,-1
    80000548:	e418                	sd	a4,8(s0)
    8000054a:	000887b7          	lui	a5,0x88
    8000054e:	00002717          	auipc	a4,0x2
    80000552:	ac073123          	sd	zero,-1342(a4) # 80002010 <pmm_manager+0x10>
    80000556:	00002717          	auipc	a4,0x2
    8000055a:	ac073123          	sd	zero,-1342(a4) # 80002018 <pmm_manager+0x18>
    8000055e:	00002717          	auipc	a4,0x2
    80000562:	aa073123          	sd	zero,-1374(a4) # 80002000 <pmm_manager>
    80000566:	00004617          	auipc	a2,0x4
    8000056a:	ac960613          	addi	a2,a2,-1335 # 8000402f <kernel_pagetable+0x1fff>
    8000056e:	777d                	lui	a4,0xfffff
    80000570:	17fd                	addi	a5,a5,-1
    80000572:	e406                	sd	ra,8(sp)
    80000574:	8e79                	and	a2,a2,a4
    80000576:	07b2                	slli	a5,a5,0xc
    80000578:	00c7ee63          	bltu	a5,a2,80000594 <pmm_init+0x68>
    8000057c:	4685                	li	a3,1
    8000057e:	4701                	li	a4,0
    80000580:	757d                	lui	a0,0xfffff
    80000582:	e398                	sd	a4,0(a5)
    80000584:	873e                	mv	a4,a5
    80000586:	97aa                	add	a5,a5,a0
    80000588:	85b6                	mv	a1,a3
    8000058a:	0685                	addi	a3,a3,1
    8000058c:	fec7fbe3          	bgeu	a5,a2,80000582 <pmm_init+0x56>
    80000590:	e018                	sd	a4,0(s0)
    80000592:	e80c                	sd	a1,16(s0)
    80000594:	00000517          	auipc	a0,0x0
    80000598:	6ac50513          	addi	a0,a0,1708 # 80000c40 <digits+0x18>
    8000059c:	d39ff0ef          	jal	ra,800002d4 <printf>
    800005a0:	00000517          	auipc	a0,0x0
    800005a4:	6c850513          	addi	a0,a0,1736 # 80000c68 <digits+0x40>
    800005a8:	d2dff0ef          	jal	ra,800002d4 <printf>
    800005ac:	640c                	ld	a1,8(s0)
    800005ae:	00000517          	auipc	a0,0x0
    800005b2:	6d250513          	addi	a0,a0,1746 # 80000c80 <digits+0x58>
    800005b6:	d1fff0ef          	jal	ra,800002d4 <printf>
    800005ba:	680c                	ld	a1,16(s0)
    800005bc:	6402                	ld	s0,0(sp)
    800005be:	60a2                	ld	ra,8(sp)
    800005c0:	00000517          	auipc	a0,0x0
    800005c4:	6d850513          	addi	a0,a0,1752 # 80000c98 <digits+0x70>
    800005c8:	0141                	addi	sp,sp,16
    800005ca:	b329                	j	800002d4 <printf>

00000000800005cc <alloc_page>:
    800005cc:	1141                	addi	sp,sp,-16
    800005ce:	00002797          	auipc	a5,0x2
    800005d2:	a3278793          	addi	a5,a5,-1486 # 80002000 <pmm_manager>
    800005d6:	e022                	sd	s0,0(sp)
    800005d8:	6380                	ld	s0,0(a5)
    800005da:	e406                	sd	ra,8(sp)
    800005dc:	c415                	beqz	s0,80000608 <alloc_page+0x3c>
    800005de:	6f98                	ld	a4,24(a5)
    800005e0:	6b94                	ld	a3,16(a5)
    800005e2:	6010                	ld	a2,0(s0)
    800005e4:	0705                	addi	a4,a4,1
    800005e6:	ef98                	sd	a4,24(a5)
    800005e8:	16fd                	addi	a3,a3,-1
    800005ea:	6705                	lui	a4,0x1
    800005ec:	e390                	sd	a2,0(a5)
    800005ee:	eb94                	sd	a3,16(a5)
    800005f0:	9722                	add	a4,a4,s0
    800005f2:	87a2                	mv	a5,s0
    800005f4:	00078023          	sb	zero,0(a5)
    800005f8:	0785                	addi	a5,a5,1
    800005fa:	fee79de3          	bne	a5,a4,800005f4 <alloc_page+0x28>
    800005fe:	60a2                	ld	ra,8(sp)
    80000600:	8522                	mv	a0,s0
    80000602:	6402                	ld	s0,0(sp)
    80000604:	0141                	addi	sp,sp,16
    80000606:	8082                	ret
    80000608:	00000517          	auipc	a0,0x0
    8000060c:	6a850513          	addi	a0,a0,1704 # 80000cb0 <digits+0x88>
    80000610:	cc5ff0ef          	jal	ra,800002d4 <printf>
    80000614:	b7ed                	j	800005fe <alloc_page+0x32>

0000000080000616 <free_page>:
    80000616:	c51d                	beqz	a0,80000644 <free_page+0x2e>
    80000618:	00002797          	auipc	a5,0x2
    8000061c:	9e878793          	addi	a5,a5,-1560 # 80002000 <pmm_manager>
    80000620:	7398                	ld	a4,32(a5)
    80000622:	02e56263          	bltu	a0,a4,80000646 <free_page+0x30>
    80000626:	7798                	ld	a4,40(a5)
    80000628:	00e57f63          	bgeu	a0,a4,80000646 <free_page+0x30>
    8000062c:	03451713          	slli	a4,a0,0x34
    80000630:	e305                	bnez	a4,80000650 <free_page+0x3a>
    80000632:	6b94                	ld	a3,16(a5)
    80000634:	6f98                	ld	a4,24(a5)
    80000636:	6390                	ld	a2,0(a5)
    80000638:	0685                	addi	a3,a3,1
    8000063a:	177d                	addi	a4,a4,-1
    8000063c:	e110                	sd	a2,0(a0)
    8000063e:	e388                	sd	a0,0(a5)
    80000640:	eb94                	sd	a3,16(a5)
    80000642:	ef98                	sd	a4,24(a5)
    80000644:	8082                	ret
    80000646:	00000517          	auipc	a0,0x0
    8000064a:	69250513          	addi	a0,a0,1682 # 80000cd8 <digits+0xb0>
    8000064e:	b159                	j	800002d4 <printf>
    80000650:	00000517          	auipc	a0,0x0
    80000654:	6b050513          	addi	a0,a0,1712 # 80000d00 <digits+0xd8>
    80000658:	b9b5                	j	800002d4 <printf>

000000008000065a <alloc_pages>:
    8000065a:	1101                	addi	sp,sp,-32
    8000065c:	ec06                	sd	ra,24(sp)
    8000065e:	e822                	sd	s0,16(sp)
    80000660:	e426                	sd	s1,8(sp)
    80000662:	e04a                	sd	s2,0(sp)
    80000664:	02a05f63          	blez	a0,800006a2 <alloc_pages+0x48>
    80000668:	4785                	li	a5,1
    8000066a:	892a                	mv	s2,a0
    8000066c:	04f50363          	beq	a0,a5,800006b2 <alloc_pages+0x58>
    80000670:	f5dff0ef          	jal	ra,800005cc <alloc_page>
    80000674:	84aa                	mv	s1,a0
    80000676:	c515                	beqz	a0,800006a2 <alloc_pages+0x48>
    80000678:	4405                	li	s0,1
    8000067a:	a021                	j	80000682 <alloc_pages+0x28>
    8000067c:	2405                	addiw	s0,s0,1
    8000067e:	03245363          	bge	s0,s2,800006a4 <alloc_pages+0x4a>
    80000682:	f4bff0ef          	jal	ra,800005cc <alloc_page>
    80000686:	f97d                	bnez	a0,8000067c <alloc_pages+0x22>
    80000688:	347d                	addiw	s0,s0,-1
    8000068a:	1402                	slli	s0,s0,0x20
    8000068c:	6785                	lui	a5,0x1
    8000068e:	8051                	srli	s0,s0,0x14
    80000690:	97a6                	add	a5,a5,s1
    80000692:	943e                	add	s0,s0,a5
    80000694:	6905                	lui	s2,0x1
    80000696:	8526                	mv	a0,s1
    80000698:	94ca                	add	s1,s1,s2
    8000069a:	f7dff0ef          	jal	ra,80000616 <free_page>
    8000069e:	fe849ce3          	bne	s1,s0,80000696 <alloc_pages+0x3c>
    800006a2:	4481                	li	s1,0
    800006a4:	60e2                	ld	ra,24(sp)
    800006a6:	6442                	ld	s0,16(sp)
    800006a8:	6902                	ld	s2,0(sp)
    800006aa:	8526                	mv	a0,s1
    800006ac:	64a2                	ld	s1,8(sp)
    800006ae:	6105                	addi	sp,sp,32
    800006b0:	8082                	ret
    800006b2:	6442                	ld	s0,16(sp)
    800006b4:	60e2                	ld	ra,24(sp)
    800006b6:	64a2                	ld	s1,8(sp)
    800006b8:	6902                	ld	s2,0(sp)
    800006ba:	6105                	addi	sp,sp,32
    800006bc:	bf01                	j	800005cc <alloc_page>

00000000800006be <free_pages>:
    800006be:	cd51                	beqz	a0,8000075a <free_pages+0x9c>
    800006c0:	08b05d63          	blez	a1,8000075a <free_pages+0x9c>
    800006c4:	7139                	addi	sp,sp,-64
    800006c6:	f04a                	sd	s2,32(sp)
    800006c8:	fff5891b          	addiw	s2,a1,-1
    800006cc:	1902                	slli	s2,s2,0x20
    800006ce:	6785                	lui	a5,0x1
    800006d0:	ec4e                	sd	s3,24(sp)
    800006d2:	01495913          	srli	s2,s2,0x14
    800006d6:	97aa                	add	a5,a5,a0
    800006d8:	6985                	lui	s3,0x1
    800006da:	f822                	sd	s0,48(sp)
    800006dc:	f426                	sd	s1,40(sp)
    800006de:	e852                	sd	s4,16(sp)
    800006e0:	e456                	sd	s5,8(sp)
    800006e2:	e05a                	sd	s6,0(sp)
    800006e4:	fc06                	sd	ra,56(sp)
    800006e6:	842a                	mv	s0,a0
    800006e8:	993e                	add	s2,s2,a5
    800006ea:	00002497          	auipc	s1,0x2
    800006ee:	91648493          	addi	s1,s1,-1770 # 80002000 <pmm_manager>
    800006f2:	00000b17          	auipc	s6,0x0
    800006f6:	5e6b0b13          	addi	s6,s6,1510 # 80000cd8 <digits+0xb0>
    800006fa:	fff98a93          	addi	s5,s3,-1 # fff <_entry-0x7ffff001>
    800006fe:	00000a17          	auipc	s4,0x0
    80000702:	602a0a13          	addi	s4,s4,1538 # 80000d00 <digits+0xd8>
    80000706:	a831                	j	80000722 <free_pages+0x64>
    80000708:	e729                	bnez	a4,80000752 <free_pages+0x94>
    8000070a:	6898                	ld	a4,16(s1)
    8000070c:	6c9c                	ld	a5,24(s1)
    8000070e:	6094                	ld	a3,0(s1)
    80000710:	0705                	addi	a4,a4,1
    80000712:	17fd                	addi	a5,a5,-1
    80000714:	e014                	sd	a3,0(s0)
    80000716:	e080                	sd	s0,0(s1)
    80000718:	e898                	sd	a4,16(s1)
    8000071a:	ec9c                	sd	a5,24(s1)
    8000071c:	944e                	add	s0,s0,s3
    8000071e:	02890063          	beq	s2,s0,8000073e <free_pages+0x80>
    80000722:	709c                	ld	a5,32(s1)
    80000724:	01547733          	and	a4,s0,s5
    80000728:	855a                	mv	a0,s6
    8000072a:	00f46563          	bltu	s0,a5,80000734 <free_pages+0x76>
    8000072e:	749c                	ld	a5,40(s1)
    80000730:	fcf46ce3          	bltu	s0,a5,80000708 <free_pages+0x4a>
    80000734:	ba1ff0ef          	jal	ra,800002d4 <printf>
    80000738:	944e                	add	s0,s0,s3
    8000073a:	fe8914e3          	bne	s2,s0,80000722 <free_pages+0x64>
    8000073e:	70e2                	ld	ra,56(sp)
    80000740:	7442                	ld	s0,48(sp)
    80000742:	74a2                	ld	s1,40(sp)
    80000744:	7902                	ld	s2,32(sp)
    80000746:	69e2                	ld	s3,24(sp)
    80000748:	6a42                	ld	s4,16(sp)
    8000074a:	6aa2                	ld	s5,8(sp)
    8000074c:	6b02                	ld	s6,0(sp)
    8000074e:	6121                	addi	sp,sp,64
    80000750:	8082                	ret
    80000752:	8552                	mv	a0,s4
    80000754:	b81ff0ef          	jal	ra,800002d4 <printf>
    80000758:	b7c5                	j	80000738 <free_pages+0x7a>
    8000075a:	8082                	ret

000000008000075c <get_total_pages>:
    8000075c:	00002517          	auipc	a0,0x2
    80000760:	8ac53503          	ld	a0,-1876(a0) # 80002008 <pmm_manager+0x8>
    80000764:	8082                	ret

0000000080000766 <get_free_pages>:
    80000766:	00002517          	auipc	a0,0x2
    8000076a:	8aa53503          	ld	a0,-1878(a0) # 80002010 <pmm_manager+0x10>
    8000076e:	8082                	ret

0000000080000770 <get_used_pages>:
    80000770:	00002517          	auipc	a0,0x2
    80000774:	8a853503          	ld	a0,-1880(a0) # 80002018 <pmm_manager+0x18>
    80000778:	8082                	ret

000000008000077a <pmm_info>:
    8000077a:	1141                	addi	sp,sp,-16
    8000077c:	00000517          	auipc	a0,0x0
    80000780:	5ac50513          	addi	a0,a0,1452 # 80000d28 <digits+0x100>
    80000784:	e406                	sd	ra,8(sp)
    80000786:	e022                	sd	s0,0(sp)
    80000788:	00002417          	auipc	s0,0x2
    8000078c:	87840413          	addi	s0,s0,-1928 # 80002000 <pmm_manager>
    80000790:	b45ff0ef          	jal	ra,800002d4 <printf>
    80000794:	640c                	ld	a1,8(s0)
    80000796:	00000517          	auipc	a0,0x0
    8000079a:	5ba50513          	addi	a0,a0,1466 # 80000d50 <digits+0x128>
    8000079e:	b37ff0ef          	jal	ra,800002d4 <printf>
    800007a2:	680c                	ld	a1,16(s0)
    800007a4:	00000517          	auipc	a0,0x0
    800007a8:	5c450513          	addi	a0,a0,1476 # 80000d68 <digits+0x140>
    800007ac:	b29ff0ef          	jal	ra,800002d4 <printf>
    800007b0:	6c0c                	ld	a1,24(s0)
    800007b2:	00000517          	auipc	a0,0x0
    800007b6:	5ce50513          	addi	a0,a0,1486 # 80000d80 <digits+0x158>
    800007ba:	b1bff0ef          	jal	ra,800002d4 <printf>
    800007be:	641c                	ld	a5,8(s0)
    800007c0:	e789                	bnez	a5,800007ca <pmm_info+0x50>
    800007c2:	60a2                	ld	ra,8(sp)
    800007c4:	6402                	ld	s0,0(sp)
    800007c6:	0141                	addi	sp,sp,16
    800007c8:	8082                	ret
    800007ca:	6c18                	ld	a4,24(s0)
    800007cc:	06400593          	li	a1,100
    800007d0:	6402                	ld	s0,0(sp)
    800007d2:	02e585b3          	mul	a1,a1,a4
    800007d6:	60a2                	ld	ra,8(sp)
    800007d8:	00000517          	auipc	a0,0x0
    800007dc:	5c050513          	addi	a0,a0,1472 # 80000d98 <digits+0x170>
    800007e0:	0141                	addi	sp,sp,16
    800007e2:	02f5d5b3          	divu	a1,a1,a5
    800007e6:	b4fd                	j	800002d4 <printf>

00000000800007e8 <free_table_recursive>:
    800007e8:	7139                	addi	sp,sp,-64
    800007ea:	f426                	sd	s1,40(sp)
    800007ec:	e852                	sd	s4,16(sp)
    800007ee:	6485                	lui	s1,0x1
    800007f0:	fff00a37          	lui	s4,0xfff00
    800007f4:	f822                	sd	s0,48(sp)
    800007f6:	f04a                	sd	s2,32(sp)
    800007f8:	ec4e                	sd	s3,24(sp)
    800007fa:	e456                	sd	s5,8(sp)
    800007fc:	e05a                	sd	s6,0(sp)
    800007fe:	fc06                	sd	ra,56(sp)
    80000800:	842a                	mv	s0,a0
    80000802:	892e                	mv	s2,a1
    80000804:	8aaa                	mv	s5,a0
    80000806:	94aa                	add	s1,s1,a0
    80000808:	4985                	li	s3,1
    8000080a:	fff58b1b          	addiw	s6,a1,-1
    8000080e:	008a5a13          	srli	s4,s4,0x8
    80000812:	6008                	ld	a0,0(s0)
    80000814:	0421                	addi	s0,s0,8
    80000816:	00157793          	andi	a5,a0,1
    8000081a:	c799                	beqz	a5,80000828 <free_table_recursive+0x40>
    8000081c:	3ff57793          	andi	a5,a0,1023
    80000820:	00090463          	beqz	s2,80000828 <free_table_recursive+0x40>
    80000824:	01378f63          	beq	a5,s3,80000842 <free_table_recursive+0x5a>
    80000828:	fe9415e3          	bne	s0,s1,80000812 <free_table_recursive+0x2a>
    8000082c:	7442                	ld	s0,48(sp)
    8000082e:	70e2                	ld	ra,56(sp)
    80000830:	74a2                	ld	s1,40(sp)
    80000832:	7902                	ld	s2,32(sp)
    80000834:	69e2                	ld	s3,24(sp)
    80000836:	6a42                	ld	s4,16(sp)
    80000838:	6b02                	ld	s6,0(sp)
    8000083a:	8556                	mv	a0,s5
    8000083c:	6aa2                	ld	s5,8(sp)
    8000083e:	6121                	addi	sp,sp,64
    80000840:	bbd9                	j	80000616 <free_page>
    80000842:	050a                	slli	a0,a0,0x2
    80000844:	85da                	mv	a1,s6
    80000846:	01457533          	and	a0,a0,s4
    8000084a:	f9fff0ef          	jal	ra,800007e8 <free_table_recursive>
    8000084e:	fc9412e3          	bne	s0,s1,80000812 <free_table_recursive+0x2a>
    80000852:	bfe9                	j	8000082c <free_table_recursive+0x44>

0000000080000854 <walk_inner>:
    80000854:	7139                	addi	sp,sp,-64
    80000856:	f04a                	sd	s2,32(sp)
    80000858:	fff00937          	lui	s2,0xfff00
    8000085c:	f426                	sd	s1,40(sp)
    8000085e:	ec4e                	sd	s3,24(sp)
    80000860:	e852                	sd	s4,16(sp)
    80000862:	e456                	sd	s5,8(sp)
    80000864:	e05a                	sd	s6,0(sp)
    80000866:	fc06                	sd	ra,56(sp)
    80000868:	f822                	sd	s0,48(sp)
    8000086a:	8a2e                	mv	s4,a1
    8000086c:	84b2                	mv	s1,a2
    8000086e:	4a89                	li	s5,2
    80000870:	4789                	li	a5,2
    80000872:	6985                	lui	s3,0x1
    80000874:	00895913          	srli	s2,s2,0x8
    80000878:	4b05                	li	s6,1
    8000087a:	0037941b          	slliw	s0,a5,0x3
    8000087e:	9c3d                	addw	s0,s0,a5
    80000880:	2431                	addiw	s0,s0,12
    80000882:	008a5433          	srl	s0,s4,s0
    80000886:	1ff47413          	andi	s0,s0,511
    8000088a:	040e                	slli	s0,s0,0x3
    8000088c:	942a                	add	s0,s0,a0
    8000088e:	6008                	ld	a0,0(s0)
    80000890:	00157793          	andi	a5,a0,1
    80000894:	eba9                	bnez	a5,800008e6 <walk_inner+0x92>
    80000896:	cca9                	beqz	s1,800008f0 <walk_inner+0x9c>
    80000898:	d35ff0ef          	jal	ra,800005cc <alloc_page>
    8000089c:	872a                	mv	a4,a0
    8000089e:	c929                	beqz	a0,800008f0 <walk_inner+0x9c>
    800008a0:	013506b3          	add	a3,a0,s3
    800008a4:	87aa                	mv	a5,a0
    800008a6:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    800008aa:	0785                	addi	a5,a5,1
    800008ac:	fef69de3          	bne	a3,a5,800008a6 <walk_inner+0x52>
    800008b0:	00c75793          	srli	a5,a4,0xc
    800008b4:	07aa                	slli	a5,a5,0xa
    800008b6:	0017e793          	ori	a5,a5,1
    800008ba:	e01c                	sd	a5,0(s0)
    800008bc:	4785                	li	a5,1
    800008be:	036a9263          	bne	s5,s6,800008e2 <walk_inner+0x8e>
    800008c2:	00ca5513          	srli	a0,s4,0xc
    800008c6:	1ff57513          	andi	a0,a0,511
    800008ca:	050e                	slli	a0,a0,0x3
    800008cc:	953a                	add	a0,a0,a4
    800008ce:	70e2                	ld	ra,56(sp)
    800008d0:	7442                	ld	s0,48(sp)
    800008d2:	74a2                	ld	s1,40(sp)
    800008d4:	7902                	ld	s2,32(sp)
    800008d6:	69e2                	ld	s3,24(sp)
    800008d8:	6a42                	ld	s4,16(sp)
    800008da:	6aa2                	ld	s5,8(sp)
    800008dc:	6b02                	ld	s6,0(sp)
    800008de:	6121                	addi	sp,sp,64
    800008e0:	8082                	ret
    800008e2:	4a85                	li	s5,1
    800008e4:	bf59                	j	8000087a <walk_inner+0x26>
    800008e6:	050a                	slli	a0,a0,0x2
    800008e8:	01257533          	and	a0,a0,s2
    800008ec:	872a                	mv	a4,a0
    800008ee:	b7f9                	j	800008bc <walk_inner+0x68>
    800008f0:	4501                	li	a0,0
    800008f2:	bff1                	j	800008ce <walk_inner+0x7a>

00000000800008f4 <create_pagetable>:
    800008f4:	1141                	addi	sp,sp,-16
    800008f6:	e406                	sd	ra,8(sp)
    800008f8:	cd5ff0ef          	jal	ra,800005cc <alloc_page>
    800008fc:	cd01                	beqz	a0,80000914 <create_pagetable+0x20>
    800008fe:	6705                	lui	a4,0x1
    80000900:	972a                	add	a4,a4,a0
    80000902:	87aa                	mv	a5,a0
    80000904:	00078023          	sb	zero,0(a5)
    80000908:	0785                	addi	a5,a5,1
    8000090a:	fee79de3          	bne	a5,a4,80000904 <create_pagetable+0x10>
    8000090e:	60a2                	ld	ra,8(sp)
    80000910:	0141                	addi	sp,sp,16
    80000912:	8082                	ret
    80000914:	60a2                	ld	ra,8(sp)
    80000916:	4501                	li	a0,0
    80000918:	0141                	addi	sp,sp,16
    8000091a:	8082                	ret

000000008000091c <walk_create>:
    8000091c:	4605                	li	a2,1
    8000091e:	bf1d                	j	80000854 <walk_inner>

0000000080000920 <walk_lookup>:
    80000920:	01e5d793          	srli	a5,a1,0x1e
    80000924:	1ff7f793          	andi	a5,a5,511
    80000928:	078e                	slli	a5,a5,0x3
    8000092a:	97aa                	add	a5,a5,a0
    8000092c:	6398                	ld	a4,0(a5)
    8000092e:	4501                	li	a0,0
    80000930:	00177793          	andi	a5,a4,1
    80000934:	e391                	bnez	a5,80000938 <walk_lookup+0x18>
    80000936:	8082                	ret
    80000938:	0155d793          	srli	a5,a1,0x15
    8000093c:	fff006b7          	lui	a3,0xfff00
    80000940:	070a                	slli	a4,a4,0x2
    80000942:	82a1                	srli	a3,a3,0x8
    80000944:	1ff7f793          	andi	a5,a5,511
    80000948:	8f75                	and	a4,a4,a3
    8000094a:	078e                	slli	a5,a5,0x3
    8000094c:	97ba                	add	a5,a5,a4
    8000094e:	639c                	ld	a5,0(a5)
    80000950:	4501                	li	a0,0
    80000952:	0017f713          	andi	a4,a5,1
    80000956:	d365                	beqz	a4,80000936 <walk_lookup+0x16>
    80000958:	00c5d513          	srli	a0,a1,0xc
    8000095c:	83a9                	srli	a5,a5,0xa
    8000095e:	07b2                	slli	a5,a5,0xc
    80000960:	1ff57513          	andi	a0,a0,511
    80000964:	8ff5                	and	a5,a5,a3
    80000966:	050e                	slli	a0,a0,0x3
    80000968:	953e                	add	a0,a0,a5
    8000096a:	8082                	ret

000000008000096c <map_page>:
    8000096c:	1101                	addi	sp,sp,-32
    8000096e:	e822                	sd	s0,16(sp)
    80000970:	8432                	mv	s0,a2
    80000972:	4605                	li	a2,1
    80000974:	e426                	sd	s1,8(sp)
    80000976:	ec06                	sd	ra,24(sp)
    80000978:	84b6                	mv	s1,a3
    8000097a:	edbff0ef          	jal	ra,80000854 <walk_inner>
    8000097e:	c50d                	beqz	a0,800009a8 <map_page+0x3c>
    80000980:	611c                	ld	a5,0(a0)
    80000982:	8b85                	andi	a5,a5,1
    80000984:	e385                	bnez	a5,800009a4 <map_page+0x38>
    80000986:	00c45793          	srli	a5,s0,0xc
    8000098a:	07aa                	slli	a5,a5,0xa
    8000098c:	0ff4f693          	andi	a3,s1,255
    80000990:	8fd5                	or	a5,a5,a3
    80000992:	0c17e793          	ori	a5,a5,193
    80000996:	e11c                	sd	a5,0(a0)
    80000998:	4501                	li	a0,0
    8000099a:	60e2                	ld	ra,24(sp)
    8000099c:	6442                	ld	s0,16(sp)
    8000099e:	64a2                	ld	s1,8(sp)
    800009a0:	6105                	addi	sp,sp,32
    800009a2:	8082                	ret
    800009a4:	5579                	li	a0,-2
    800009a6:	bfd5                	j	8000099a <map_page+0x2e>
    800009a8:	557d                	li	a0,-1
    800009aa:	bfc5                	j	8000099a <map_page+0x2e>

00000000800009ac <destroy_pagetable>:
    800009ac:	e111                	bnez	a0,800009b0 <destroy_pagetable+0x4>
    800009ae:	8082                	ret
    800009b0:	4589                	li	a1,2
    800009b2:	bd1d                	j	800007e8 <free_table_recursive>

00000000800009b4 <dump_pagetable>:
    800009b4:	711d                	addi	sp,sp,-96
    800009b6:	ec5e                	sd	s7,24(sp)
    800009b8:	fff00bb7          	lui	s7,0xfff00
    800009bc:	e4a6                	sd	s1,72(sp)
    800009be:	e0ca                	sd	s2,64(sp)
    800009c0:	fc4e                	sd	s3,56(sp)
    800009c2:	f456                	sd	s5,40(sp)
    800009c4:	f05a                	sd	s6,32(sp)
    800009c6:	e862                	sd	s8,16(sp)
    800009c8:	e466                	sd	s9,8(sp)
    800009ca:	ec86                	sd	ra,88(sp)
    800009cc:	e8a2                	sd	s0,80(sp)
    800009ce:	f852                	sd	s4,48(sp)
    800009d0:	e06a                	sd	s10,0(sp)
    800009d2:	84ae                	mv	s1,a1
    800009d4:	8aaa                	mv	s5,a0
    800009d6:	4981                	li	s3,0
    800009d8:	008bdb93          	srli	s7,s7,0x8
    800009dc:	00000c17          	auipc	s8,0x0
    800009e0:	3dcc0c13          	addi	s8,s8,988 # 80000db8 <digits+0x190>
    800009e4:	4b05                	li	s6,1
    800009e6:	00158c9b          	addiw	s9,a1,1
    800009ea:	00000917          	auipc	s2,0x0
    800009ee:	3c690913          	addi	s2,s2,966 # 80000db0 <digits+0x188>
    800009f2:	a039                	j	80000a00 <dump_pagetable+0x4c>
    800009f4:	2985                	addiw	s3,s3,1
    800009f6:	20000793          	li	a5,512
    800009fa:	0aa1                	addi	s5,s5,8
    800009fc:	04f98b63          	beq	s3,a5,80000a52 <dump_pagetable+0x9e>
    80000a00:	000aba03          	ld	s4,0(s5)
    80000a04:	001a7793          	andi	a5,s4,1
    80000a08:	d7f5                	beqz	a5,800009f4 <dump_pagetable+0x40>
    80000a0a:	002a1d13          	slli	s10,s4,0x2
    80000a0e:	017d7d33          	and	s10,s10,s7
    80000a12:	04905e63          	blez	s1,80000a6e <dump_pagetable+0xba>
    80000a16:	4401                	li	s0,0
    80000a18:	2405                	addiw	s0,s0,1
    80000a1a:	854a                	mv	a0,s2
    80000a1c:	8b9ff0ef          	jal	ra,800002d4 <printf>
    80000a20:	fe849ce3          	bne	s1,s0,80000a18 <dump_pagetable+0x64>
    80000a24:	3ffa7413          	andi	s0,s4,1023
    80000a28:	8722                	mv	a4,s0
    80000a2a:	86ea                	mv	a3,s10
    80000a2c:	8652                	mv	a2,s4
    80000a2e:	85ce                	mv	a1,s3
    80000a30:	8562                	mv	a0,s8
    80000a32:	8a3ff0ef          	jal	ra,800002d4 <printf>
    80000a36:	fa9b4fe3          	blt	s6,s1,800009f4 <dump_pagetable+0x40>
    80000a3a:	fb641de3          	bne	s0,s6,800009f4 <dump_pagetable+0x40>
    80000a3e:	85e6                	mv	a1,s9
    80000a40:	856a                	mv	a0,s10
    80000a42:	f73ff0ef          	jal	ra,800009b4 <dump_pagetable>
    80000a46:	2985                	addiw	s3,s3,1
    80000a48:	20000793          	li	a5,512
    80000a4c:	0aa1                	addi	s5,s5,8
    80000a4e:	faf999e3          	bne	s3,a5,80000a00 <dump_pagetable+0x4c>
    80000a52:	60e6                	ld	ra,88(sp)
    80000a54:	6446                	ld	s0,80(sp)
    80000a56:	64a6                	ld	s1,72(sp)
    80000a58:	6906                	ld	s2,64(sp)
    80000a5a:	79e2                	ld	s3,56(sp)
    80000a5c:	7a42                	ld	s4,48(sp)
    80000a5e:	7aa2                	ld	s5,40(sp)
    80000a60:	7b02                	ld	s6,32(sp)
    80000a62:	6be2                	ld	s7,24(sp)
    80000a64:	6c42                	ld	s8,16(sp)
    80000a66:	6ca2                	ld	s9,8(sp)
    80000a68:	6d02                	ld	s10,0(sp)
    80000a6a:	6125                	addi	sp,sp,96
    80000a6c:	8082                	ret
    80000a6e:	3ffa7413          	andi	s0,s4,1023
    80000a72:	8722                	mv	a4,s0
    80000a74:	86ea                	mv	a3,s10
    80000a76:	8652                	mv	a2,s4
    80000a78:	85ce                	mv	a1,s3
    80000a7a:	8562                	mv	a0,s8
    80000a7c:	859ff0ef          	jal	ra,800002d4 <printf>
    80000a80:	f7641ae3          	bne	s0,s6,800009f4 <dump_pagetable+0x40>
    80000a84:	bf6d                	j	80000a3e <dump_pagetable+0x8a>

0000000080000a86 <map_region>:
    80000a86:	7139                	addi	sp,sp,-64
    80000a88:	16fd                	addi	a3,a3,-1
    80000a8a:	f822                	sd	s0,48(sp)
    80000a8c:	f04a                	sd	s2,32(sp)
    80000a8e:	fc06                	sd	ra,56(sp)
    80000a90:	f426                	sd	s1,40(sp)
    80000a92:	ec4e                	sd	s3,24(sp)
    80000a94:	e852                	sd	s4,16(sp)
    80000a96:	e456                	sd	s5,8(sp)
    80000a98:	00b68433          	add	s0,a3,a1
    80000a9c:	40b60933          	sub	s2,a2,a1
    80000aa0:	02b46b63          	bltu	s0,a1,80000ad6 <map_region+0x50>
    80000aa4:	8aae                	mv	s5,a1
    80000aa6:	89aa                	mv	s3,a0
    80000aa8:	0ff77493          	andi	s1,a4,255
    80000aac:	6a05                	lui	s4,0x1
    80000aae:	85d6                	mv	a1,s5
    80000ab0:	4605                	li	a2,1
    80000ab2:	854e                	mv	a0,s3
    80000ab4:	da1ff0ef          	jal	ra,80000854 <walk_inner>
    80000ab8:	015907b3          	add	a5,s2,s5
    80000abc:	83b1                	srli	a5,a5,0xc
    80000abe:	07aa                	slli	a5,a5,0xa
    80000ac0:	8fc5                	or	a5,a5,s1
    80000ac2:	0c17e793          	ori	a5,a5,193
    80000ac6:	9ad2                	add	s5,s5,s4
    80000ac8:	c10d                	beqz	a0,80000aea <map_region+0x64>
    80000aca:	6118                	ld	a4,0(a0)
    80000acc:	8b05                	andi	a4,a4,1
    80000ace:	ef11                	bnez	a4,80000aea <map_region+0x64>
    80000ad0:	e11c                	sd	a5,0(a0)
    80000ad2:	fd547ee3          	bgeu	s0,s5,80000aae <map_region+0x28>
    80000ad6:	4501                	li	a0,0
    80000ad8:	70e2                	ld	ra,56(sp)
    80000ada:	7442                	ld	s0,48(sp)
    80000adc:	74a2                	ld	s1,40(sp)
    80000ade:	7902                	ld	s2,32(sp)
    80000ae0:	69e2                	ld	s3,24(sp)
    80000ae2:	6a42                	ld	s4,16(sp)
    80000ae4:	6aa2                	ld	s5,8(sp)
    80000ae6:	6121                	addi	sp,sp,64
    80000ae8:	8082                	ret
    80000aea:	557d                	li	a0,-1
    80000aec:	b7f5                	j	80000ad8 <map_region+0x52>

0000000080000aee <kvminit>:
    80000aee:	1141                	addi	sp,sp,-16
    80000af0:	e406                	sd	ra,8(sp)
    80000af2:	e022                	sd	s0,0(sp)
    80000af4:	ad9ff0ef          	jal	ra,800005cc <alloc_page>
    80000af8:	c52d                	beqz	a0,80000b62 <kvminit+0x74>
    80000afa:	6705                	lui	a4,0x1
    80000afc:	972a                	add	a4,a4,a0
    80000afe:	87aa                	mv	a5,a0
    80000b00:	00078023          	sb	zero,0(a5)
    80000b04:	0785                	addi	a5,a5,1
    80000b06:	fef71de3          	bne	a4,a5,80000b00 <kvminit+0x12>
    80000b0a:	4605                	li	a2,1
    80000b0c:	067e                	slli	a2,a2,0x1f
    80000b0e:	00001417          	auipc	s0,0x1
    80000b12:	52240413          	addi	s0,s0,1314 # 80002030 <kernel_pagetable>
    80000b16:	4729                	li	a4,10
    80000b18:	001006b7          	lui	a3,0x100
    80000b1c:	85b2                	mv	a1,a2
    80000b1e:	e008                	sd	a0,0(s0)
    80000b20:	f67ff0ef          	jal	ra,80000a86 <map_region>
    80000b24:	ed21                	bnez	a0,80000b7c <kvminit+0x8e>
    80000b26:	00801637          	lui	a2,0x801
    80000b2a:	6008                	ld	a0,0(s0)
    80000b2c:	0622                	slli	a2,a2,0x8
    80000b2e:	4719                	li	a4,6
    80000b30:	001006b7          	lui	a3,0x100
    80000b34:	85b2                	mv	a1,a2
    80000b36:	f51ff0ef          	jal	ra,80000a86 <map_region>
    80000b3a:	e931                	bnez	a0,80000b8e <kvminit+0xa0>
    80000b3c:	6008                	ld	a0,0(s0)
    80000b3e:	4719                	li	a4,6
    80000b40:	6685                	lui	a3,0x1
    80000b42:	10000637          	lui	a2,0x10000
    80000b46:	100005b7          	lui	a1,0x10000
    80000b4a:	f3dff0ef          	jal	ra,80000a86 <map_region>
    80000b4e:	e929                	bnez	a0,80000ba0 <kvminit+0xb2>
    80000b50:	6402                	ld	s0,0(sp)
    80000b52:	60a2                	ld	ra,8(sp)
    80000b54:	00000517          	auipc	a0,0x0
    80000b58:	33450513          	addi	a0,a0,820 # 80000e88 <digits+0x260>
    80000b5c:	0141                	addi	sp,sp,16
    80000b5e:	f76ff06f          	j	800002d4 <printf>
    80000b62:	00000517          	auipc	a0,0x0
    80000b66:	28650513          	addi	a0,a0,646 # 80000de8 <digits+0x1c0>
    80000b6a:	00001797          	auipc	a5,0x1
    80000b6e:	4c07b323          	sd	zero,1222(a5) # 80002030 <kernel_pagetable>
    80000b72:	6402                	ld	s0,0(sp)
    80000b74:	60a2                	ld	ra,8(sp)
    80000b76:	0141                	addi	sp,sp,16
    80000b78:	f5cff06f          	j	800002d4 <printf>
    80000b7c:	6402                	ld	s0,0(sp)
    80000b7e:	60a2                	ld	ra,8(sp)
    80000b80:	00000517          	auipc	a0,0x0
    80000b84:	29850513          	addi	a0,a0,664 # 80000e18 <digits+0x1f0>
    80000b88:	0141                	addi	sp,sp,16
    80000b8a:	f4aff06f          	j	800002d4 <printf>
    80000b8e:	6402                	ld	s0,0(sp)
    80000b90:	60a2                	ld	ra,8(sp)
    80000b92:	00000517          	auipc	a0,0x0
    80000b96:	2ae50513          	addi	a0,a0,686 # 80000e40 <digits+0x218>
    80000b9a:	0141                	addi	sp,sp,16
    80000b9c:	f38ff06f          	j	800002d4 <printf>
    80000ba0:	00000517          	auipc	a0,0x0
    80000ba4:	2c850513          	addi	a0,a0,712 # 80000e68 <digits+0x240>
    80000ba8:	b7e9                	j	80000b72 <kvminit+0x84>

0000000080000baa <kvminithart>:
    80000baa:	00001797          	auipc	a5,0x1
    80000bae:	4867b783          	ld	a5,1158(a5) # 80002030 <kernel_pagetable>
    80000bb2:	cf99                	beqz	a5,80000bd0 <kvminithart+0x26>
    80000bb4:	577d                	li	a4,-1
    80000bb6:	177e                	slli	a4,a4,0x3f
    80000bb8:	83b1                	srli	a5,a5,0xc
    80000bba:	8fd9                	or	a5,a5,a4
    80000bbc:	18079073          	csrw	satp,a5
    80000bc0:	12000073          	sfence.vma
    80000bc4:	00000517          	auipc	a0,0x0
    80000bc8:	32450513          	addi	a0,a0,804 # 80000ee8 <digits+0x2c0>
    80000bcc:	f08ff06f          	j	800002d4 <printf>
    80000bd0:	00000517          	auipc	a0,0x0
    80000bd4:	2e850513          	addi	a0,a0,744 # 80000eb8 <digits+0x290>
    80000bd8:	efcff06f          	j	800002d4 <printf>
