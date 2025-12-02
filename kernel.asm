
kernel.elf:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	f1402573          	csrr	a0,mhartid
    80000004:	02051263          	bnez	a0,80000028 <park>
    80000008:	0000a117          	auipc	sp,0xa
    8000000c:	ff810113          	addi	sp,sp,-8 # 8000a000 <next_pid>
    80000010:	0000a517          	auipc	a0,0xa
    80000014:	00050513          	mv	a0,a0
    80000018:	00835597          	auipc	a1,0x835
    8000001c:	9d058593          	addi	a1,a1,-1584 # 808349e8 <panicked>
    80000020:	010000ef          	jal	ra,80000030 <clear_bss>
    80000024:	2900006f          	j	800002b4 <start>

0000000080000028 <park>:
    80000028:	10500073          	wfi
    8000002c:	ffdff06f          	j	80000028 <park>

0000000080000030 <clear_bss>:
    80000030:	00b57863          	bgeu	a0,a1,80000040 <bss_done>
    80000034:	00053023          	sd	zero,0(a0) # 8000a010 <pmm_manager>
    80000038:	00850513          	addi	a0,a0,8
    8000003c:	feb56ce3          	bltu	a0,a1,80000034 <clear_bss+0x4>

0000000080000040 <bss_done>:
    80000040:	00008067          	ret
	...

0000000080000050 <kernelvec>:
    80000050:	f0010113          	addi	sp,sp,-256
    80000054:	00113023          	sd	ra,0(sp)
    80000058:	00313823          	sd	gp,16(sp)
    8000005c:	00413c23          	sd	tp,24(sp)
    80000060:	02513023          	sd	t0,32(sp)
    80000064:	02613423          	sd	t1,40(sp)
    80000068:	02713823          	sd	t2,48(sp)
    8000006c:	04a13423          	sd	a0,72(sp)
    80000070:	04b13823          	sd	a1,80(sp)
    80000074:	04c13c23          	sd	a2,88(sp)
    80000078:	06d13023          	sd	a3,96(sp)
    8000007c:	06e13423          	sd	a4,104(sp)
    80000080:	06f13823          	sd	a5,112(sp)
    80000084:	07013c23          	sd	a6,120(sp)
    80000088:	09113023          	sd	a7,128(sp)
    8000008c:	0dc13c23          	sd	t3,216(sp)
    80000090:	0fd13023          	sd	t4,224(sp)
    80000094:	0fe13423          	sd	t5,232(sp)
    80000098:	0ff13823          	sd	t6,240(sp)
    8000009c:	270020ef          	jal	ra,8000230c <kerneltrap>
    800000a0:	00013083          	ld	ra,0(sp)
    800000a4:	01013183          	ld	gp,16(sp)
    800000a8:	02013283          	ld	t0,32(sp)
    800000ac:	02813303          	ld	t1,40(sp)
    800000b0:	03013383          	ld	t2,48(sp)
    800000b4:	04813503          	ld	a0,72(sp)
    800000b8:	05013583          	ld	a1,80(sp)
    800000bc:	05813603          	ld	a2,88(sp)
    800000c0:	06013683          	ld	a3,96(sp)
    800000c4:	06813703          	ld	a4,104(sp)
    800000c8:	07013783          	ld	a5,112(sp)
    800000cc:	07813803          	ld	a6,120(sp)
    800000d0:	08013883          	ld	a7,128(sp)
    800000d4:	0d813e03          	ld	t3,216(sp)
    800000d8:	0e013e83          	ld	t4,224(sp)
    800000dc:	0e813f03          	ld	t5,232(sp)
    800000e0:	0f013f83          	ld	t6,240(sp)
    800000e4:	10010113          	addi	sp,sp,256
    800000e8:	10200073          	sret
    800000ec:	0000                	unimp
	...

00000000800000f0 <swtch>:
    800000f0:	00153023          	sd	ra,0(a0)
    800000f4:	00253423          	sd	sp,8(a0)
    800000f8:	00853823          	sd	s0,16(a0)
    800000fc:	00953c23          	sd	s1,24(a0)
    80000100:	03253023          	sd	s2,32(a0)
    80000104:	03353423          	sd	s3,40(a0)
    80000108:	03453823          	sd	s4,48(a0)
    8000010c:	03553c23          	sd	s5,56(a0)
    80000110:	05653023          	sd	s6,64(a0)
    80000114:	05753423          	sd	s7,72(a0)
    80000118:	05853823          	sd	s8,80(a0)
    8000011c:	05953c23          	sd	s9,88(a0)
    80000120:	07a53023          	sd	s10,96(a0)
    80000124:	07b53423          	sd	s11,104(a0)
    80000128:	0005b083          	ld	ra,0(a1)
    8000012c:	0085b103          	ld	sp,8(a1)
    80000130:	0105b403          	ld	s0,16(a1)
    80000134:	0185b483          	ld	s1,24(a1)
    80000138:	0205b903          	ld	s2,32(a1)
    8000013c:	0285b983          	ld	s3,40(a1)
    80000140:	0305ba03          	ld	s4,48(a1)
    80000144:	0385ba83          	ld	s5,56(a1)
    80000148:	0405bb03          	ld	s6,64(a1)
    8000014c:	0485bb83          	ld	s7,72(a1)
    80000150:	0505bc03          	ld	s8,80(a1)
    80000154:	0585bc83          	ld	s9,88(a1)
    80000158:	0605bd03          	ld	s10,96(a1)
    8000015c:	0685bd83          	ld	s11,104(a1)
    80000160:	00008067          	ret
	...

0000000080000170 <trampoline>:
    80000170:	14051073          	csrw	sscratch,a0
    80000174:	ffffe537          	lui	a0,0xffffe
    80000178:	02153423          	sd	ra,40(a0) # ffffffffffffe028 <TRAPFRAME+0x28>
    8000017c:	02253823          	sd	sp,48(a0)
    80000180:	02353c23          	sd	gp,56(a0)
    80000184:	04453023          	sd	tp,64(a0)
    80000188:	04553423          	sd	t0,72(a0)
    8000018c:	04653823          	sd	t1,80(a0)
    80000190:	04753c23          	sd	t2,88(a0)
    80000194:	06853023          	sd	s0,96(a0)
    80000198:	06953423          	sd	s1,104(a0)
    8000019c:	06b53c23          	sd	a1,120(a0)
    800001a0:	08c53023          	sd	a2,128(a0)
    800001a4:	08d53423          	sd	a3,136(a0)
    800001a8:	08e53823          	sd	a4,144(a0)
    800001ac:	08f53c23          	sd	a5,152(a0)
    800001b0:	0b053023          	sd	a6,160(a0)
    800001b4:	0b153423          	sd	a7,168(a0)
    800001b8:	0b253823          	sd	s2,176(a0)
    800001bc:	0b353c23          	sd	s3,184(a0)
    800001c0:	0d453023          	sd	s4,192(a0)
    800001c4:	0d553423          	sd	s5,200(a0)
    800001c8:	0d653823          	sd	s6,208(a0)
    800001cc:	0d753c23          	sd	s7,216(a0)
    800001d0:	0f853023          	sd	s8,224(a0)
    800001d4:	0f953423          	sd	s9,232(a0)
    800001d8:	0fa53823          	sd	s10,240(a0)
    800001dc:	0fb53c23          	sd	s11,248(a0)
    800001e0:	11c53023          	sd	t3,256(a0)
    800001e4:	11d53423          	sd	t4,264(a0)
    800001e8:	11e53823          	sd	t5,272(a0)
    800001ec:	11f53c23          	sd	t6,280(a0)
    800001f0:	140022f3          	csrr	t0,sscratch
    800001f4:	06553823          	sd	t0,112(a0)
    800001f8:	00853103          	ld	sp,8(a0)
    800001fc:	02053203          	ld	tp,32(a0)
    80000200:	01053283          	ld	t0,16(a0)
    80000204:	00053303          	ld	t1,0(a0)
    80000208:	12000073          	sfence.vma
    8000020c:	18031073          	csrw	satp,t1
    80000210:	12000073          	sfence.vma
    80000214:	000280e7          	jalr	t0

0000000080000218 <userret>:
    80000218:	12000073          	sfence.vma
    8000021c:	18051073          	csrw	satp,a0
    80000220:	12000073          	sfence.vma
    80000224:	ffffe537          	lui	a0,0xffffe
    80000228:	02853083          	ld	ra,40(a0) # ffffffffffffe028 <TRAPFRAME+0x28>
    8000022c:	03053103          	ld	sp,48(a0)
    80000230:	03853183          	ld	gp,56(a0)
    80000234:	04053203          	ld	tp,64(a0)
    80000238:	04853283          	ld	t0,72(a0)
    8000023c:	05053303          	ld	t1,80(a0)
    80000240:	05853383          	ld	t2,88(a0)
    80000244:	06053403          	ld	s0,96(a0)
    80000248:	06853483          	ld	s1,104(a0)
    8000024c:	07853583          	ld	a1,120(a0)
    80000250:	08053603          	ld	a2,128(a0)
    80000254:	08853683          	ld	a3,136(a0)
    80000258:	09053703          	ld	a4,144(a0)
    8000025c:	09853783          	ld	a5,152(a0)
    80000260:	0a053803          	ld	a6,160(a0)
    80000264:	0a853883          	ld	a7,168(a0)
    80000268:	0b053903          	ld	s2,176(a0)
    8000026c:	0b853983          	ld	s3,184(a0)
    80000270:	0c053a03          	ld	s4,192(a0)
    80000274:	0c853a83          	ld	s5,200(a0)
    80000278:	0d053b03          	ld	s6,208(a0)
    8000027c:	0d853b83          	ld	s7,216(a0)
    80000280:	0e053c03          	ld	s8,224(a0)
    80000284:	0e853c83          	ld	s9,232(a0)
    80000288:	0f053d03          	ld	s10,240(a0)
    8000028c:	0f853d83          	ld	s11,248(a0)
    80000290:	10053e03          	ld	t3,256(a0)
    80000294:	10853e83          	ld	t4,264(a0)
    80000298:	11053f03          	ld	t5,272(a0)
    8000029c:	11853f83          	ld	t6,280(a0)
    800002a0:	07053503          	ld	a0,112(a0)
    800002a4:	10200073          	sret
	...

00000000800002b4 <start>:
    800002b4:	300027f3          	csrr	a5,mstatus
    800002b8:	ffffe737          	lui	a4,0xffffe
    800002bc:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <TRAPFRAME+0x7ff>
    800002c0:	00e7f7b3          	and	a5,a5,a4
    800002c4:	00001737          	lui	a4,0x1
    800002c8:	80070713          	addi	a4,a4,-2048 # 800 <_binary_user_test_basic_bin_size+0xbf>
    800002cc:	00e7e7b3          	or	a5,a5,a4
    800002d0:	30079073          	csrw	mstatus,a5
    800002d4:	00000797          	auipc	a5,0x0
    800002d8:	3d078793          	addi	a5,a5,976 # 800006a4 <main>
    800002dc:	34179073          	csrw	mepc,a5
    800002e0:	00000793          	li	a5,0
    800002e4:	18079073          	csrw	satp,a5
    800002e8:	000107b7          	lui	a5,0x10
    800002ec:	dff78713          	addi	a4,a5,-513 # fdff <_binary_user_test_basic_bin_size+0xf6be>
    800002f0:	30271073          	csrw	medeleg,a4
    800002f4:	fff78793          	addi	a5,a5,-1
    800002f8:	30379073          	csrw	mideleg,a5
    800002fc:	104027f3          	csrr	a5,sie
    80000300:	2207e793          	ori	a5,a5,544
    80000304:	10479073          	csrw	sie,a5
    80000308:	fff00793          	li	a5,-1
    8000030c:	00a7d713          	srli	a4,a5,0xa
    80000310:	3b071073          	csrw	pmpaddr0,a4
    80000314:	00f00713          	li	a4,15
    80000318:	3a071073          	csrw	pmpcfg0,a4
    8000031c:	30402773          	csrr	a4,mie
    80000320:	02076713          	ori	a4,a4,32
    80000324:	30471073          	csrw	mie,a4
    80000328:	30a02773          	csrr	a4,0x30a
    8000032c:	03f79793          	slli	a5,a5,0x3f
    80000330:	00f767b3          	or	a5,a4,a5
    80000334:	30a79073          	csrw	0x30a,a5
    80000338:	306027f3          	csrr	a5,mcounteren
    8000033c:	0027e793          	ori	a5,a5,2
    80000340:	30679073          	csrw	mcounteren,a5
    80000344:	c01027f3          	rdtime	a5
    80000348:	000f4737          	lui	a4,0xf4
    8000034c:	24070713          	addi	a4,a4,576 # f4240 <_binary_user_test_basic_bin_size+0xf3aff>
    80000350:	00e787b3          	add	a5,a5,a4
    80000354:	14d79073          	csrw	0x14d,a5
    80000358:	f14027f3          	csrr	a5,mhartid
    8000035c:	0007879b          	sext.w	a5,a5
    80000360:	00078213          	mv	tp,a5
    80000364:	30200073          	mret
    80000368:	00008067          	ret

000000008000036c <fs_concurrent_runner>:
    8000036c:	fc010113          	addi	sp,sp,-64
    80000370:	00007517          	auipc	a0,0x7
    80000374:	90850513          	addi	a0,a0,-1784 # 80006c78 <_text_end+0x4>
    80000378:	02813823          	sd	s0,48(sp)
    8000037c:	02913423          	sd	s1,40(sp)
    80000380:	03213023          	sd	s2,32(sp)
    80000384:	01313c23          	sd	s3,24(sp)
    80000388:	01413823          	sd	s4,16(sp)
    8000038c:	01513423          	sd	s5,8(sp)
    80000390:	01613023          	sd	s6,0(sp)
    80000394:	02113c23          	sd	ra,56(sp)
    80000398:	00000413          	li	s0,0
    8000039c:	5e8000ef          	jal	ra,80000984 <printf>
    800003a0:	00000493          	li	s1,0
    800003a4:	00007a97          	auipc	s5,0x7
    800003a8:	8fca8a93          	addi	s5,s5,-1796 # 80006ca0 <_text_end+0x2c>
    800003ac:	00000a17          	auipc	s4,0x0
    800003b0:	0a0a0a13          	addi	s4,s4,160 # 8000044c <fs_concurrent_worker>
    800003b4:	00007997          	auipc	s3,0x7
    800003b8:	91498993          	addi	s3,s3,-1772 # 80006cc8 <_text_end+0x54>
    800003bc:	00007b17          	auipc	s6,0x7
    800003c0:	8ecb0b13          	addi	s6,s6,-1812 # 80006ca8 <_text_end+0x34>
    800003c4:	00400913          	li	s2,4
    800003c8:	00040593          	mv	a1,s0
    800003cc:	000a8613          	mv	a2,s5
    800003d0:	000a0513          	mv	a0,s4
    800003d4:	514020ef          	jal	ra,800028e8 <kproc_create>
    800003d8:	00050613          	mv	a2,a0
    800003dc:	0004059b          	sext.w	a1,s0
    800003e0:	00098513          	mv	a0,s3
    800003e4:	04064e63          	bltz	a2,80000440 <fs_concurrent_runner+0xd4>
    800003e8:	59c000ef          	jal	ra,80000984 <printf>
    800003ec:	0014849b          	addiw	s1,s1,1
    800003f0:	00140413          	addi	s0,s0,1
    800003f4:	fd241ae3          	bne	s0,s2,800003c8 <fs_concurrent_runner+0x5c>
    800003f8:	00048c63          	beqz	s1,80000410 <fs_concurrent_runner+0xa4>
    800003fc:	00000413          	li	s0,0
    80000400:	0014041b          	addiw	s0,s0,1
    80000404:	00000513          	li	a0,0
    80000408:	010030ef          	jal	ra,80003418 <wait_process>
    8000040c:	fe849ae3          	bne	s1,s0,80000400 <fs_concurrent_runner+0x94>
    80000410:	03013403          	ld	s0,48(sp)
    80000414:	03813083          	ld	ra,56(sp)
    80000418:	02813483          	ld	s1,40(sp)
    8000041c:	02013903          	ld	s2,32(sp)
    80000420:	01813983          	ld	s3,24(sp)
    80000424:	01013a03          	ld	s4,16(sp)
    80000428:	00813a83          	ld	s5,8(sp)
    8000042c:	00013b03          	ld	s6,0(sp)
    80000430:	00007517          	auipc	a0,0x7
    80000434:	8b850513          	addi	a0,a0,-1864 # 80006ce8 <_text_end+0x74>
    80000438:	04010113          	addi	sp,sp,64
    8000043c:	5480006f          	j	80000984 <printf>
    80000440:	000b0513          	mv	a0,s6
    80000444:	540000ef          	jal	ra,80000984 <printf>
    80000448:	fa9ff06f          	j	800003f0 <fs_concurrent_runner+0x84>

000000008000044c <fs_concurrent_worker>:
    8000044c:	f9010113          	addi	sp,sp,-112
    80000450:	02f00793          	li	a5,47
    80000454:	04913c23          	sd	s1,88(sp)
    80000458:	05213823          	sd	s2,80(sp)
    8000045c:	00f10823          	sb	a5,16(sp)
    80000460:	06113423          	sd	ra,104(sp)
    80000464:	06813023          	sd	s0,96(sp)
    80000468:	05313423          	sd	s3,72(sp)
    8000046c:	05413023          	sd	s4,64(sp)
    80000470:	03513c23          	sd	s5,56(sp)
    80000474:	03613823          	sd	s6,48(sp)
    80000478:	0005091b          	sext.w	s2,a0
    8000047c:	00007617          	auipc	a2,0x7
    80000480:	89660613          	addi	a2,a2,-1898 # 80006d12 <_text_end+0x9e>
    80000484:	00200793          	li	a5,2
    80000488:	07400693          	li	a3,116
    8000048c:	01010493          	addi	s1,sp,16
    80000490:	02000593          	li	a1,32
    80000494:	00c0006f          	j	800004a0 <fs_concurrent_worker+0x54>
    80000498:	00178793          	addi	a5,a5,1
    8000049c:	1eb78c63          	beq	a5,a1,80000694 <fs_concurrent_worker+0x248>
    800004a0:	00f48733          	add	a4,s1,a5
    800004a4:	fed70fa3          	sb	a3,-1(a4)
    800004a8:	00064683          	lbu	a3,0(a2)
    800004ac:	0007871b          	sext.w	a4,a5
    800004b0:	00160613          	addi	a2,a2,1
    800004b4:	fe0692e3          	bnez	a3,80000498 <fs_concurrent_worker+0x4c>
    800004b8:	01f00693          	li	a3,31
    800004bc:	1cd70c63          	beq	a4,a3,80000694 <fs_concurrent_worker+0x248>
    800004c0:	12091263          	bnez	s2,800005e4 <fs_concurrent_worker+0x198>
    800004c4:	03000793          	li	a5,48
    800004c8:	00f10023          	sb	a5,0(sp)
    800004cc:	03000693          	li	a3,48
    800004d0:	00100893          	li	a7,1
    800004d4:	00010613          	mv	a2,sp
    800004d8:	fff8879b          	addiw	a5,a7,-1
    800004dc:	02079793          	slli	a5,a5,0x20
    800004e0:	0017071b          	addiw	a4,a4,1
    800004e4:	0207d793          	srli	a5,a5,0x20
    800004e8:	01160633          	add	a2,a2,a7
    800004ec:	00e787b3          	add	a5,a5,a4
    800004f0:	01e00513          	li	a0,30
    800004f4:	0140006f          	j	80000508 <fs_concurrent_worker+0xbc>
    800004f8:	fff60613          	addi	a2,a2,-1
    800004fc:	1ad54063          	blt	a0,a3,8000069c <fs_concurrent_worker+0x250>
    80000500:	fff64683          	lbu	a3,-1(a2)
    80000504:	00170713          	addi	a4,a4,1
    80000508:	00e485b3          	add	a1,s1,a4
    8000050c:	fed58fa3          	sb	a3,-1(a1)
    80000510:	0007069b          	sext.w	a3,a4
    80000514:	fee792e3          	bne	a5,a4,800004f8 <fs_concurrent_worker+0xac>
    80000518:	03010713          	addi	a4,sp,48
    8000051c:	00f707b3          	add	a5,a4,a5
    80000520:	fe078023          	sb	zero,-32(a5)
    80000524:	00012023          	sw	zero,0(sp)
    80000528:	00007a97          	auipc	s5,0x7
    8000052c:	840a8a93          	addi	s5,s5,-1984 # 80006d68 <_text_end+0xf4>
    80000530:	00007a17          	auipc	s4,0x7
    80000534:	810a0a13          	addi	s4,s4,-2032 # 80006d40 <_text_end+0xcc>
    80000538:	00006b17          	auipc	s6,0x6
    8000053c:	7e0b0b13          	addi	s6,s6,2016 # 80006d18 <_text_end+0xa4>
    80000540:	06300993          	li	s3,99
    80000544:	0180006f          	j	8000055c <fs_concurrent_worker+0x110>
    80000548:	474040ef          	jal	ra,800049bc <end_op>
    8000054c:	00012783          	lw	a5,0(sp)
    80000550:	0017871b          	addiw	a4,a5,1
    80000554:	00e12023          	sw	a4,0(sp)
    80000558:	10e9c263          	blt	s3,a4,8000065c <fs_concurrent_worker+0x210>
    8000055c:	3e0040ef          	jal	ra,8000493c <begin_op>
    80000560:	000085b7          	lui	a1,0x8
    80000564:	00048513          	mv	a0,s1
    80000568:	06c060ef          	jal	ra,800065d4 <fs_create>
    8000056c:	00050413          	mv	s0,a0
    80000570:	0c050463          	beqz	a0,80000638 <fs_concurrent_worker+0x1ec>
    80000574:	534050ef          	jal	ra,80005aa8 <ilock>
    80000578:	00400713          	li	a4,4
    8000057c:	00000593          	li	a1,0
    80000580:	00000693          	li	a3,0
    80000584:	00010613          	mv	a2,sp
    80000588:	00040513          	mv	a0,s0
    8000058c:	770050ef          	jal	ra,80005cfc <writei>
    80000590:	00050713          	mv	a4,a0
    80000594:	00400793          	li	a5,4
    80000598:	00090593          	mv	a1,s2
    8000059c:	000a0513          	mv	a0,s4
    800005a0:	00f70663          	beq	a4,a5,800005ac <fs_concurrent_worker+0x160>
    800005a4:	00012603          	lw	a2,0(sp)
    800005a8:	3dc000ef          	jal	ra,80000984 <printf>
    800005ac:	00040513          	mv	a0,s0
    800005b0:	550050ef          	jal	ra,80005b00 <iunlock>
    800005b4:	00040513          	mv	a0,s0
    800005b8:	2b4050ef          	jal	ra,8000586c <iput>
    800005bc:	400040ef          	jal	ra,800049bc <end_op>
    800005c0:	37c040ef          	jal	ra,8000493c <begin_op>
    800005c4:	00048513          	mv	a0,s1
    800005c8:	2d0060ef          	jal	ra,80006898 <fs_unlink>
    800005cc:	f6055ee3          	bgez	a0,80000548 <fs_concurrent_worker+0xfc>
    800005d0:	00012603          	lw	a2,0(sp)
    800005d4:	00090593          	mv	a1,s2
    800005d8:	000a8513          	mv	a0,s5
    800005dc:	3a8000ef          	jal	ra,80000984 <printf>
    800005e0:	f69ff06f          	j	80000548 <fs_concurrent_worker+0xfc>
    800005e4:	00010613          	mv	a2,sp
    800005e8:	00060593          	mv	a1,a2
    800005ec:	00090513          	mv	a0,s2
    800005f0:	f32054e3          	blez	s2,80000518 <fs_concurrent_worker+0xcc>
    800005f4:	00100313          	li	t1,1
    800005f8:	40c3033b          	subw	t1,t1,a2
    800005fc:	00a00793          	li	a5,10
    80000600:	00900e13          	li	t3,9
    80000604:	02f566bb          	remw	a3,a0,a5
    80000608:	00b308bb          	addw	a7,t1,a1
    8000060c:	00158593          	addi	a1,a1,1 # 8001 <_binary_user_test_basic_bin_size+0x78c0>
    80000610:	00050813          	mv	a6,a0
    80000614:	0306869b          	addiw	a3,a3,48
    80000618:	0ff6f693          	andi	a3,a3,255
    8000061c:	fed58fa3          	sb	a3,-1(a1)
    80000620:	02f5453b          	divw	a0,a0,a5
    80000624:	eb0e5ae3          	bge	t3,a6,800004d8 <fs_concurrent_worker+0x8c>
    80000628:	fcb49ee3          	bne	s1,a1,80000604 <fs_concurrent_worker+0x1b8>
    8000062c:	00f14683          	lbu	a3,15(sp)
    80000630:	01000893          	li	a7,16
    80000634:	ea5ff06f          	j	800004d8 <fs_concurrent_worker+0x8c>
    80000638:	00012603          	lw	a2,0(sp)
    8000063c:	00090593          	mv	a1,s2
    80000640:	000b0513          	mv	a0,s6
    80000644:	340000ef          	jal	ra,80000984 <printf>
    80000648:	374040ef          	jal	ra,800049bc <end_op>
    8000064c:	00012783          	lw	a5,0(sp)
    80000650:	0017871b          	addiw	a4,a5,1
    80000654:	00e12023          	sw	a4,0(sp)
    80000658:	f0e9d2e3          	bge	s3,a4,8000055c <fs_concurrent_worker+0x110>
    8000065c:	00090593          	mv	a1,s2
    80000660:	00006517          	auipc	a0,0x6
    80000664:	73050513          	addi	a0,a0,1840 # 80006d90 <_text_end+0x11c>
    80000668:	31c000ef          	jal	ra,80000984 <printf>
    8000066c:	06813083          	ld	ra,104(sp)
    80000670:	06013403          	ld	s0,96(sp)
    80000674:	05813483          	ld	s1,88(sp)
    80000678:	05013903          	ld	s2,80(sp)
    8000067c:	04813983          	ld	s3,72(sp)
    80000680:	04013a03          	ld	s4,64(sp)
    80000684:	03813a83          	ld	s5,56(sp)
    80000688:	03013b03          	ld	s6,48(sp)
    8000068c:	07010113          	addi	sp,sp,112
    80000690:	00008067          	ret
    80000694:	01f00793          	li	a5,31
    80000698:	e81ff06f          	j	80000518 <fs_concurrent_worker+0xcc>
    8000069c:	00070793          	mv	a5,a4
    800006a0:	e79ff06f          	j	80000518 <fs_concurrent_worker+0xcc>

00000000800006a4 <main>:
    800006a4:	fa010113          	addi	sp,sp,-96
    800006a8:	04113c23          	sd	ra,88(sp)
    800006ac:	04913423          	sd	s1,72(sp)
    800006b0:	04813823          	sd	s0,80(sp)
    800006b4:	79c000ef          	jal	ra,80000e50 <pmm_init>
    800006b8:	65c010ef          	jal	ra,80001d14 <kvminit>
    800006bc:	760010ef          	jal	ra,80001e1c <kvminithart>
    800006c0:	7ec030ef          	jal	ra,80003eac <binit>
    800006c4:	3dc060ef          	jal	ra,80006aa0 <ramdisk_init>
    800006c8:	00100513          	li	a0,1
    800006cc:	731040ef          	jal	ra,800055fc <fs_init>
    800006d0:	00100513          	li	a0,1
    800006d4:	20c040ef          	jal	ra,800048e0 <log_init>
    800006d8:	1e1010ef          	jal	ra,800020b8 <trap_init>
    800006dc:	595010ef          	jal	ra,80002470 <timer_init>
    800006e0:	00006517          	auipc	a0,0x6
    800006e4:	6c050513          	addi	a0,a0,1728 # 80006da0 <_text_end+0x12c>
    800006e8:	29c000ef          	jal	ra,80000984 <printf>
    800006ec:	250040ef          	jal	ra,8000493c <begin_op>
    800006f0:	000085b7          	lui	a1,0x8
    800006f4:	00006517          	auipc	a0,0x6
    800006f8:	6cc50513          	addi	a0,a0,1740 # 80006dc0 <_text_end+0x14c>
    800006fc:	6d9050ef          	jal	ra,800065d4 <fs_create>
    80000700:	00006797          	auipc	a5,0x6
    80000704:	6f078793          	addi	a5,a5,1776 # 80006df0 <_text_end+0x17c>
    80000708:	00100613          	li	a2,1
    8000070c:	40f6063b          	subw	a2,a2,a5
    80000710:	00050493          	mv	s1,a0
    80000714:	16050463          	beqz	a0,8000087c <main+0x1d8>
    80000718:	0017c683          	lbu	a3,1(a5)
    8000071c:	00f6043b          	addw	s0,a2,a5
    80000720:	00178793          	addi	a5,a5,1
    80000724:	fe069ae3          	bnez	a3,80000718 <main+0x74>
    80000728:	00048513          	mv	a0,s1
    8000072c:	37c050ef          	jal	ra,80005aa8 <ilock>
    80000730:	00040713          	mv	a4,s0
    80000734:	00000693          	li	a3,0
    80000738:	00006617          	auipc	a2,0x6
    8000073c:	6b860613          	addi	a2,a2,1720 # 80006df0 <_text_end+0x17c>
    80000740:	00000593          	li	a1,0
    80000744:	00048513          	mv	a0,s1
    80000748:	5b4050ef          	jal	ra,80005cfc <writei>
    8000074c:	0e851263          	bne	a0,s0,80000830 <main+0x18c>
    80000750:	00048513          	mv	a0,s1
    80000754:	3ac050ef          	jal	ra,80005b00 <iunlock>
    80000758:	00048513          	mv	a0,s1
    8000075c:	110050ef          	jal	ra,8000586c <iput>
    80000760:	25c040ef          	jal	ra,800049bc <end_op>
    80000764:	1d8040ef          	jal	ra,8000493c <begin_op>
    80000768:	00006517          	auipc	a0,0x6
    8000076c:	65850513          	addi	a0,a0,1624 # 80006dc0 <_text_end+0x14c>
    80000770:	64d050ef          	jal	ra,800065bc <path_walk>
    80000774:	00050413          	mv	s0,a0
    80000778:	0e050863          	beqz	a0,80000868 <main+0x1c4>
    8000077c:	32c050ef          	jal	ra,80005aa8 <ilock>
    80000780:	03f00713          	li	a4,63
    80000784:	00000693          	li	a3,0
    80000788:	00010613          	mv	a2,sp
    8000078c:	00000593          	li	a1,0
    80000790:	00040513          	mv	a0,s0
    80000794:	3ac050ef          	jal	ra,80005b40 <readi>
    80000798:	00050493          	mv	s1,a0
    8000079c:	00040513          	mv	a0,s0
    800007a0:	360050ef          	jal	ra,80005b00 <iunlock>
    800007a4:	00040513          	mv	a0,s0
    800007a8:	0c4050ef          	jal	ra,8000586c <iput>
    800007ac:	210040ef          	jal	ra,800049bc <end_op>
    800007b0:	08905863          	blez	s1,80000840 <main+0x19c>
    800007b4:	04010793          	addi	a5,sp,64
    800007b8:	009784b3          	add	s1,a5,s1
    800007bc:	fc048023          	sb	zero,-64(s1)
    800007c0:	00010593          	mv	a1,sp
    800007c4:	00006517          	auipc	a0,0x6
    800007c8:	67c50513          	addi	a0,a0,1660 # 80006e40 <_text_end+0x1cc>
    800007cc:	1b8000ef          	jal	ra,80000984 <printf>
    800007d0:	16c040ef          	jal	ra,8000493c <begin_op>
    800007d4:	00006517          	auipc	a0,0x6
    800007d8:	5ec50513          	addi	a0,a0,1516 # 80006dc0 <_text_end+0x14c>
    800007dc:	0bc060ef          	jal	ra,80006898 <fs_unlink>
    800007e0:	06054c63          	bltz	a0,80000858 <main+0x1b4>
    800007e4:	1d8040ef          	jal	ra,800049bc <end_op>
    800007e8:	00006517          	auipc	a0,0x6
    800007ec:	69050513          	addi	a0,a0,1680 # 80006e78 <_text_end+0x204>
    800007f0:	194000ef          	jal	ra,80000984 <printf>
    800007f4:	4d9010ef          	jal	ra,800024cc <proc_init>
    800007f8:	00000517          	auipc	a0,0x0
    800007fc:	b7450513          	addi	a0,a0,-1164 # 8000036c <fs_concurrent_runner>
    80000800:	214020ef          	jal	ra,80002a14 <create_process>
    80000804:	00050593          	mv	a1,a0
    80000808:	04054063          	bltz	a0,80000848 <main+0x1a4>
    8000080c:	00006517          	auipc	a0,0x6
    80000810:	6b450513          	addi	a0,a0,1716 # 80006ec0 <_text_end+0x24c>
    80000814:	170000ef          	jal	ra,80000984 <printf>
    80000818:	214020ef          	jal	ra,80002a2c <userinit>
    8000081c:	05013403          	ld	s0,80(sp)
    80000820:	05813083          	ld	ra,88(sp)
    80000824:	04813483          	ld	s1,72(sp)
    80000828:	06010113          	addi	sp,sp,96
    8000082c:	1d10206f          	j	800031fc <scheduler>
    80000830:	00006517          	auipc	a0,0x6
    80000834:	5d850513          	addi	a0,a0,1496 # 80006e08 <_text_end+0x194>
    80000838:	14c000ef          	jal	ra,80000984 <printf>
    8000083c:	f15ff06f          	j	80000750 <main+0xac>
    80000840:	00010023          	sb	zero,0(sp)
    80000844:	f7dff06f          	j	800007c0 <main+0x11c>
    80000848:	00006517          	auipc	a0,0x6
    8000084c:	65050513          	addi	a0,a0,1616 # 80006e98 <_text_end+0x224>
    80000850:	134000ef          	jal	ra,80000984 <printf>
    80000854:	fc5ff06f          	j	80000818 <main+0x174>
    80000858:	00006517          	auipc	a0,0x6
    8000085c:	60050513          	addi	a0,a0,1536 # 80006e58 <_text_end+0x1e4>
    80000860:	124000ef          	jal	ra,80000984 <printf>
    80000864:	f81ff06f          	j	800007e4 <main+0x140>
    80000868:	00006517          	auipc	a0,0x6
    8000086c:	5b850513          	addi	a0,a0,1464 # 80006e20 <_text_end+0x1ac>
    80000870:	114000ef          	jal	ra,80000984 <printf>
    80000874:	148040ef          	jal	ra,800049bc <end_op>
    80000878:	f7dff06f          	j	800007f4 <main+0x150>
    8000087c:	00006517          	auipc	a0,0x6
    80000880:	55450513          	addi	a0,a0,1364 # 80006dd0 <_text_end+0x15c>
    80000884:	100000ef          	jal	ra,80000984 <printf>
    80000888:	134040ef          	jal	ra,800049bc <end_op>
    8000088c:	f69ff06f          	j	800007f4 <main+0x150>

0000000080000890 <uart_putc>:
    80000890:	10000737          	lui	a4,0x10000
    80000894:	00574783          	lbu	a5,5(a4) # 10000005 <_binary_user_test_basic_bin_size+0xffff8c4>
    80000898:	0207f793          	andi	a5,a5,32
    8000089c:	fe078ce3          	beqz	a5,80000894 <uart_putc+0x4>
    800008a0:	00a70023          	sb	a0,0(a4)
    800008a4:	00008067          	ret

00000000800008a8 <uart_puts>:
    800008a8:	00054683          	lbu	a3,0(a0)
    800008ac:	02068263          	beqz	a3,800008d0 <uart_puts+0x28>
    800008b0:	10000737          	lui	a4,0x10000
    800008b4:	00574783          	lbu	a5,5(a4) # 10000005 <_binary_user_test_basic_bin_size+0xffff8c4>
    800008b8:	0207f793          	andi	a5,a5,32
    800008bc:	fe078ce3          	beqz	a5,800008b4 <uart_puts+0xc>
    800008c0:	00d70023          	sb	a3,0(a4)
    800008c4:	00154683          	lbu	a3,1(a0)
    800008c8:	00150513          	addi	a0,a0,1
    800008cc:	fe0694e3          	bnez	a3,800008b4 <uart_puts+0xc>
    800008d0:	00008067          	ret

00000000800008d4 <printint>:
    800008d4:	fc010113          	addi	sp,sp,-64
    800008d8:	02113c23          	sd	ra,56(sp)
    800008dc:	02813823          	sd	s0,48(sp)
    800008e0:	02913423          	sd	s1,40(sp)
    800008e4:	00050793          	mv	a5,a0
    800008e8:	00060463          	beqz	a2,800008f0 <printint+0x1c>
    800008ec:	08054863          	bltz	a0,8000097c <printint+0xa8>
    800008f0:	00000613          	li	a2,0
    800008f4:	00810693          	addi	a3,sp,8
    800008f8:	00000813          	li	a6,0
    800008fc:	00006317          	auipc	t1,0x6
    80000900:	5fc30313          	addi	t1,t1,1532 # 80006ef8 <digits>
    80000904:	02b7f733          	remu	a4,a5,a1
    80000908:	00168693          	addi	a3,a3,1
    8000090c:	00078893          	mv	a7,a5
    80000910:	00080413          	mv	s0,a6
    80000914:	0018081b          	addiw	a6,a6,1
    80000918:	00e30733          	add	a4,t1,a4
    8000091c:	00074503          	lbu	a0,0(a4)
    80000920:	02b7d7b3          	divu	a5,a5,a1
    80000924:	fea68fa3          	sb	a0,-1(a3)
    80000928:	fcb8fee3          	bgeu	a7,a1,80000904 <printint+0x30>
    8000092c:	00060e63          	beqz	a2,80000948 <printint+0x74>
    80000930:	02010793          	addi	a5,sp,32
    80000934:	010787b3          	add	a5,a5,a6
    80000938:	02d00713          	li	a4,45
    8000093c:	fee78423          	sb	a4,-24(a5)
    80000940:	00080413          	mv	s0,a6
    80000944:	02d00513          	li	a0,45
    80000948:	00810793          	addi	a5,sp,8
    8000094c:	00878433          	add	s0,a5,s0
    80000950:	00078493          	mv	s1,a5
    80000954:	00c0006f          	j	80000960 <printint+0x8c>
    80000958:	fff44503          	lbu	a0,-1(s0)
    8000095c:	fff40413          	addi	s0,s0,-1
    80000960:	f31ff0ef          	jal	ra,80000890 <uart_putc>
    80000964:	fe941ae3          	bne	s0,s1,80000958 <printint+0x84>
    80000968:	03813083          	ld	ra,56(sp)
    8000096c:	03013403          	ld	s0,48(sp)
    80000970:	02813483          	ld	s1,40(sp)
    80000974:	04010113          	addi	sp,sp,64
    80000978:	00008067          	ret
    8000097c:	40a007b3          	neg	a5,a0
    80000980:	f75ff06f          	j	800008f4 <printint+0x20>

0000000080000984 <printf>:
    80000984:	f4010113          	addi	sp,sp,-192
    80000988:	07213023          	sd	s2,96(sp)
    8000098c:	06113c23          	sd	ra,120(sp)
    80000990:	06813823          	sd	s0,112(sp)
    80000994:	06913423          	sd	s1,104(sp)
    80000998:	05313c23          	sd	s3,88(sp)
    8000099c:	05413823          	sd	s4,80(sp)
    800009a0:	05513423          	sd	s5,72(sp)
    800009a4:	05613023          	sd	s6,64(sp)
    800009a8:	03713c23          	sd	s7,56(sp)
    800009ac:	03813823          	sd	s8,48(sp)
    800009b0:	03913423          	sd	s9,40(sp)
    800009b4:	03a13023          	sd	s10,32(sp)
    800009b8:	01b13c23          	sd	s11,24(sp)
    800009bc:	00050913          	mv	s2,a0
    800009c0:	00054503          	lbu	a0,0(a0)
    800009c4:	0af13423          	sd	a5,168(sp)
    800009c8:	08810793          	addi	a5,sp,136
    800009cc:	08b13423          	sd	a1,136(sp)
    800009d0:	08c13823          	sd	a2,144(sp)
    800009d4:	08d13c23          	sd	a3,152(sp)
    800009d8:	0ae13023          	sd	a4,160(sp)
    800009dc:	0b013823          	sd	a6,176(sp)
    800009e0:	0b113c23          	sd	a7,184(sp)
    800009e4:	00f13423          	sd	a5,8(sp)
    800009e8:	04050463          	beqz	a0,80000a30 <printf+0xac>
    800009ec:	00000493          	li	s1,0
    800009f0:	00148d1b          	addiw	s10,s1,1
    800009f4:	01a90433          	add	s0,s2,s10
    800009f8:	0005079b          	sext.w	a5,a0
    800009fc:	02500993          	li	s3,37
    80000a00:	06400a93          	li	s5,100
    80000a04:	06c00b93          	li	s7,108
    80000a08:	07500c93          	li	s9,117
    80000a0c:	07800b13          	li	s6,120
    80000a10:	07000c13          	li	s8,112
    80000a14:	00006a17          	auipc	s4,0x6
    80000a18:	4e4a0a13          	addi	s4,s4,1252 # 80006ef8 <digits>
    80000a1c:	00040713          	mv	a4,s0
    80000a20:	0d379a63          	bne	a5,s3,80000af4 <printf+0x170>
    80000a24:	00044d83          	lbu	s11,0(s0)
    80000a28:	000d879b          	sext.w	a5,s11
    80000a2c:	040d9263          	bnez	s11,80000a70 <printf+0xec>
    80000a30:	07813083          	ld	ra,120(sp)
    80000a34:	07013403          	ld	s0,112(sp)
    80000a38:	06813483          	ld	s1,104(sp)
    80000a3c:	06013903          	ld	s2,96(sp)
    80000a40:	05813983          	ld	s3,88(sp)
    80000a44:	05013a03          	ld	s4,80(sp)
    80000a48:	04813a83          	ld	s5,72(sp)
    80000a4c:	04013b03          	ld	s6,64(sp)
    80000a50:	03813b83          	ld	s7,56(sp)
    80000a54:	03013c03          	ld	s8,48(sp)
    80000a58:	02813c83          	ld	s9,40(sp)
    80000a5c:	02013d03          	ld	s10,32(sp)
    80000a60:	01813d83          	ld	s11,24(sp)
    80000a64:	00000513          	li	a0,0
    80000a68:	0c010113          	addi	sp,sp,192
    80000a6c:	00008067          	ret
    80000a70:	001d0413          	addi	s0,s10,1
    80000a74:	00890433          	add	s0,s2,s0
    80000a78:	00044683          	lbu	a3,0(s0)
    80000a7c:	00000613          	li	a2,0
    80000a80:	00068463          	beqz	a3,80000a88 <printf+0x104>
    80000a84:	00274603          	lbu	a2,2(a4)
    80000a88:	07578c63          	beq	a5,s5,80000b00 <printf+0x17c>
    80000a8c:	0b778e63          	beq	a5,s7,80000b48 <printf+0x1c4>
    80000a90:	09978a63          	beq	a5,s9,80000b24 <printf+0x1a0>
    80000a94:	0f678a63          	beq	a5,s6,80000b88 <printf+0x204>
    80000a98:	13878a63          	beq	a5,s8,80000bcc <printf+0x248>
    80000a9c:	06300713          	li	a4,99
    80000aa0:	16e78863          	beq	a5,a4,80000c10 <printf+0x28c>
    80000aa4:	07300713          	li	a4,115
    80000aa8:	18e78a63          	beq	a5,a4,80000c3c <printf+0x2b8>
    80000aac:	01379c63          	bne	a5,s3,80000ac4 <printf+0x140>
    80000ab0:	02500513          	li	a0,37
    80000ab4:	dddff0ef          	jal	ra,80000890 <uart_putc>
    80000ab8:	0024849b          	addiw	s1,s1,2
    80000abc:	01c0006f          	j	80000ad8 <printf+0x154>
    80000ac0:	17668663          	beq	a3,s6,80000c2c <printf+0x2a8>
    80000ac4:	02500513          	li	a0,37
    80000ac8:	dc9ff0ef          	jal	ra,80000890 <uart_putc>
    80000acc:	000d8513          	mv	a0,s11
    80000ad0:	dc1ff0ef          	jal	ra,80000890 <uart_putc>
    80000ad4:	0024849b          	addiw	s1,s1,2
    80000ad8:	00044503          	lbu	a0,0(s0)
    80000adc:	0005079b          	sext.w	a5,a0
    80000ae0:	f40508e3          	beqz	a0,80000a30 <printf+0xac>
    80000ae4:	00148d1b          	addiw	s10,s1,1
    80000ae8:	01a90433          	add	s0,s2,s10
    80000aec:	00040713          	mv	a4,s0
    80000af0:	f3378ae3          	beq	a5,s3,80000a24 <printf+0xa0>
    80000af4:	d9dff0ef          	jal	ra,80000890 <uart_putc>
    80000af8:	000d0493          	mv	s1,s10
    80000afc:	fddff06f          	j	80000ad8 <printf+0x154>
    80000b00:	00813783          	ld	a5,8(sp)
    80000b04:	00100613          	li	a2,1
    80000b08:	00a00593          	li	a1,10
    80000b0c:	0007a503          	lw	a0,0(a5)
    80000b10:	00878793          	addi	a5,a5,8
    80000b14:	00f13423          	sd	a5,8(sp)
    80000b18:	0024849b          	addiw	s1,s1,2
    80000b1c:	db9ff0ef          	jal	ra,800008d4 <printint>
    80000b20:	fb9ff06f          	j	80000ad8 <printf+0x154>
    80000b24:	00813783          	ld	a5,8(sp)
    80000b28:	00000613          	li	a2,0
    80000b2c:	00a00593          	li	a1,10
    80000b30:	0007e503          	lwu	a0,0(a5)
    80000b34:	00878793          	addi	a5,a5,8
    80000b38:	00f13423          	sd	a5,8(sp)
    80000b3c:	0024849b          	addiw	s1,s1,2
    80000b40:	d95ff0ef          	jal	ra,800008d4 <printint>
    80000b44:	f95ff06f          	j	80000ad8 <printf+0x154>
    80000b48:	03569663          	bne	a3,s5,80000b74 <printf+0x1f0>
    80000b4c:	00813783          	ld	a5,8(sp)
    80000b50:	00100613          	li	a2,1
    80000b54:	00a00593          	li	a1,10
    80000b58:	0007b503          	ld	a0,0(a5)
    80000b5c:	0034849b          	addiw	s1,s1,3
    80000b60:	00878793          	addi	a5,a5,8
    80000b64:	00f13423          	sd	a5,8(sp)
    80000b68:	00990433          	add	s0,s2,s1
    80000b6c:	d69ff0ef          	jal	ra,800008d4 <printint>
    80000b70:	f69ff06f          	j	80000ad8 <printf+0x154>
    80000b74:	03768263          	beq	a3,s7,80000b98 <printf+0x214>
    80000b78:	f59694e3          	bne	a3,s9,80000ac0 <printf+0x13c>
    80000b7c:	00813783          	ld	a5,8(sp)
    80000b80:	00000613          	li	a2,0
    80000b84:	fd1ff06f          	j	80000b54 <printf+0x1d0>
    80000b88:	00813783          	ld	a5,8(sp)
    80000b8c:	00000613          	li	a2,0
    80000b90:	01000593          	li	a1,16
    80000b94:	f9dff06f          	j	80000b30 <printf+0x1ac>
    80000b98:	0d560a63          	beq	a2,s5,80000c6c <printf+0x2e8>
    80000b9c:	0f960063          	beq	a2,s9,80000c7c <printf+0x2f8>
    80000ba0:	f36612e3          	bne	a2,s6,80000ac4 <printf+0x140>
    80000ba4:	00813783          	ld	a5,8(sp)
    80000ba8:	00000613          	li	a2,0
    80000bac:	01000593          	li	a1,16
    80000bb0:	0007b503          	ld	a0,0(a5)
    80000bb4:	0044849b          	addiw	s1,s1,4
    80000bb8:	00878793          	addi	a5,a5,8
    80000bbc:	00f13423          	sd	a5,8(sp)
    80000bc0:	00990433          	add	s0,s2,s1
    80000bc4:	d11ff0ef          	jal	ra,800008d4 <printint>
    80000bc8:	f11ff06f          	j	80000ad8 <printf+0x154>
    80000bcc:	00813783          	ld	a5,8(sp)
    80000bd0:	03000513          	li	a0,48
    80000bd4:	01000d93          	li	s11,16
    80000bd8:	00878713          	addi	a4,a5,8
    80000bdc:	0007bd03          	ld	s10,0(a5)
    80000be0:	00e13423          	sd	a4,8(sp)
    80000be4:	cadff0ef          	jal	ra,80000890 <uart_putc>
    80000be8:	07800513          	li	a0,120
    80000bec:	ca5ff0ef          	jal	ra,80000890 <uart_putc>
    80000bf0:	03cd5793          	srli	a5,s10,0x3c
    80000bf4:	00fa07b3          	add	a5,s4,a5
    80000bf8:	0007c503          	lbu	a0,0(a5)
    80000bfc:	fffd8d9b          	addiw	s11,s11,-1
    80000c00:	004d1d13          	slli	s10,s10,0x4
    80000c04:	c8dff0ef          	jal	ra,80000890 <uart_putc>
    80000c08:	fe0d94e3          	bnez	s11,80000bf0 <printf+0x26c>
    80000c0c:	ec9ff06f          	j	80000ad4 <printf+0x150>
    80000c10:	00813783          	ld	a5,8(sp)
    80000c14:	0024849b          	addiw	s1,s1,2
    80000c18:	0007c503          	lbu	a0,0(a5)
    80000c1c:	00878793          	addi	a5,a5,8
    80000c20:	00f13423          	sd	a5,8(sp)
    80000c24:	c6dff0ef          	jal	ra,80000890 <uart_putc>
    80000c28:	eb1ff06f          	j	80000ad8 <printf+0x154>
    80000c2c:	00813783          	ld	a5,8(sp)
    80000c30:	00000613          	li	a2,0
    80000c34:	01000593          	li	a1,16
    80000c38:	f21ff06f          	j	80000b58 <printf+0x1d4>
    80000c3c:	00813783          	ld	a5,8(sp)
    80000c40:	0024849b          	addiw	s1,s1,2
    80000c44:	0007bd03          	ld	s10,0(a5)
    80000c48:	00878793          	addi	a5,a5,8
    80000c4c:	00f13423          	sd	a5,8(sp)
    80000c50:	000d1863          	bnez	s10,80000c60 <printf+0x2dc>
    80000c54:	0380006f          	j	80000c8c <printf+0x308>
    80000c58:	001d0d13          	addi	s10,s10,1
    80000c5c:	c35ff0ef          	jal	ra,80000890 <uart_putc>
    80000c60:	000d4503          	lbu	a0,0(s10)
    80000c64:	fe051ae3          	bnez	a0,80000c58 <printf+0x2d4>
    80000c68:	e71ff06f          	j	80000ad8 <printf+0x154>
    80000c6c:	00813783          	ld	a5,8(sp)
    80000c70:	00100613          	li	a2,1
    80000c74:	00a00593          	li	a1,10
    80000c78:	f39ff06f          	j	80000bb0 <printf+0x22c>
    80000c7c:	00813783          	ld	a5,8(sp)
    80000c80:	00000613          	li	a2,0
    80000c84:	00a00593          	li	a1,10
    80000c88:	f29ff06f          	j	80000bb0 <printf+0x22c>
    80000c8c:	00006d17          	auipc	s10,0x6
    80000c90:	254d0d13          	addi	s10,s10,596 # 80006ee0 <_text_end+0x26c>
    80000c94:	02800513          	li	a0,40
    80000c98:	fc1ff06f          	j	80000c58 <printf+0x2d4>

0000000080000c9c <panic>:
    80000c9c:	00834797          	auipc	a5,0x834
    80000ca0:	d507a783          	lw	a5,-688(a5) # 808349ec <panicking>
    80000ca4:	00078e63          	beqz	a5,80000cc0 <panic+0x24>
    80000ca8:	00100793          	li	a5,1
    80000cac:	00834717          	auipc	a4,0x834
    80000cb0:	d2f72e23          	sw	a5,-708(a4) # 808349e8 <panicked>
    80000cb4:	10500073          	wfi
    80000cb8:	10500073          	wfi
    80000cbc:	ff9ff06f          	j	80000cb4 <panic+0x18>
    80000cc0:	ff010113          	addi	sp,sp,-16
    80000cc4:	00813023          	sd	s0,0(sp)
    80000cc8:	00050593          	mv	a1,a0
    80000ccc:	00100413          	li	s0,1
    80000cd0:	00006517          	auipc	a0,0x6
    80000cd4:	21850513          	addi	a0,a0,536 # 80006ee8 <_text_end+0x274>
    80000cd8:	00113423          	sd	ra,8(sp)
    80000cdc:	00834797          	auipc	a5,0x834
    80000ce0:	d087a823          	sw	s0,-752(a5) # 808349ec <panicking>
    80000ce4:	ca1ff0ef          	jal	ra,80000984 <printf>
    80000ce8:	00834797          	auipc	a5,0x834
    80000cec:	d087a023          	sw	s0,-768(a5) # 808349e8 <panicked>
    80000cf0:	10500073          	wfi
    80000cf4:	10500073          	wfi
    80000cf8:	ff9ff06f          	j	80000cf0 <panic+0x54>

0000000080000cfc <clear_screen>:
    80000cfc:	ff010113          	addi	sp,sp,-16
    80000d00:	01b00513          	li	a0,27
    80000d04:	00113423          	sd	ra,8(sp)
    80000d08:	b89ff0ef          	jal	ra,80000890 <uart_putc>
    80000d0c:	05b00513          	li	a0,91
    80000d10:	b81ff0ef          	jal	ra,80000890 <uart_putc>
    80000d14:	03200513          	li	a0,50
    80000d18:	b79ff0ef          	jal	ra,80000890 <uart_putc>
    80000d1c:	04a00513          	li	a0,74
    80000d20:	b71ff0ef          	jal	ra,80000890 <uart_putc>
    80000d24:	01b00513          	li	a0,27
    80000d28:	b69ff0ef          	jal	ra,80000890 <uart_putc>
    80000d2c:	05b00513          	li	a0,91
    80000d30:	b61ff0ef          	jal	ra,80000890 <uart_putc>
    80000d34:	00813083          	ld	ra,8(sp)
    80000d38:	04800513          	li	a0,72
    80000d3c:	01010113          	addi	sp,sp,16
    80000d40:	b51ff06f          	j	80000890 <uart_putc>

0000000080000d44 <bitmap_init>:
    80000d44:	00009697          	auipc	a3,0x9
    80000d48:	2cc68693          	addi	a3,a3,716 # 8000a010 <pmm_manager>
    80000d4c:	0086b703          	ld	a4,8(a3)
    80000d50:	0006b783          	ld	a5,0(a3)
    80000d54:	00770713          	addi	a4,a4,7
    80000d58:	00375713          	srli	a4,a4,0x3
    80000d5c:	00834617          	auipc	a2,0x834
    80000d60:	c8e63a23          	sd	a4,-876(a2) # 808349f0 <pmm_bitmap_bytes>
    80000d64:	04078263          	beqz	a5,80000da8 <bitmap_init+0x64>
    80000d68:	0106b583          	ld	a1,16(a3)
    80000d6c:	0186b603          	ld	a2,24(a3)
    80000d70:	0007b503          	ld	a0,0(a5)
    80000d74:	fff58593          	addi	a1,a1,-1 # 7fff <_binary_user_test_basic_bin_size+0x78be>
    80000d78:	00160613          	addi	a2,a2,1
    80000d7c:	00a6b023          	sd	a0,0(a3)
    80000d80:	00b6b823          	sd	a1,16(a3)
    80000d84:	00c6bc23          	sd	a2,24(a3)
    80000d88:	00834697          	auipc	a3,0x834
    80000d8c:	c6f6b823          	sd	a5,-912(a3) # 808349f8 <pmm_bitmap>
    80000d90:	00070a63          	beqz	a4,80000da4 <bitmap_init+0x60>
    80000d94:	00e78733          	add	a4,a5,a4
    80000d98:	00078023          	sb	zero,0(a5)
    80000d9c:	00178793          	addi	a5,a5,1
    80000da0:	fee79ce3          	bne	a5,a4,80000d98 <bitmap_init+0x54>
    80000da4:	00008067          	ret
    80000da8:	00834797          	auipc	a5,0x834
    80000dac:	c407b823          	sd	zero,-944(a5) # 808349f8 <pmm_bitmap>
    80000db0:	00834797          	auipc	a5,0x834
    80000db4:	c407b023          	sd	zero,-960(a5) # 808349f0 <pmm_bitmap_bytes>
    80000db8:	00008067          	ret

0000000080000dbc <bitmap_set_pfn>:
    80000dbc:	00834797          	auipc	a5,0x834
    80000dc0:	c3c7b783          	ld	a5,-964(a5) # 808349f8 <pmm_bitmap>
    80000dc4:	02078263          	beqz	a5,80000de8 <bitmap_set_pfn+0x2c>
    80000dc8:	00355713          	srli	a4,a0,0x3
    80000dcc:	00e787b3          	add	a5,a5,a4
    80000dd0:	0007c683          	lbu	a3,0(a5)
    80000dd4:	00757513          	andi	a0,a0,7
    80000dd8:	00100713          	li	a4,1
    80000ddc:	00a7153b          	sllw	a0,a4,a0
    80000de0:	00d56533          	or	a0,a0,a3
    80000de4:	00a78023          	sb	a0,0(a5)
    80000de8:	00008067          	ret

0000000080000dec <bitmap_clear_pfn>:
    80000dec:	00834797          	auipc	a5,0x834
    80000df0:	c0c7b783          	ld	a5,-1012(a5) # 808349f8 <pmm_bitmap>
    80000df4:	02078463          	beqz	a5,80000e1c <bitmap_clear_pfn+0x30>
    80000df8:	00355713          	srli	a4,a0,0x3
    80000dfc:	00e78733          	add	a4,a5,a4
    80000e00:	00074683          	lbu	a3,0(a4)
    80000e04:	00757513          	andi	a0,a0,7
    80000e08:	00100793          	li	a5,1
    80000e0c:	00a797bb          	sllw	a5,a5,a0
    80000e10:	fff7c793          	not	a5,a5
    80000e14:	00d7f7b3          	and	a5,a5,a3
    80000e18:	00f70023          	sb	a5,0(a4)
    80000e1c:	00008067          	ret

0000000080000e20 <bitmap_test_pfn>:
    80000e20:	00834797          	auipc	a5,0x834
    80000e24:	bd87b783          	ld	a5,-1064(a5) # 808349f8 <pmm_bitmap>
    80000e28:	02078063          	beqz	a5,80000e48 <bitmap_test_pfn+0x28>
    80000e2c:	00355713          	srli	a4,a0,0x3
    80000e30:	00e787b3          	add	a5,a5,a4
    80000e34:	0007c783          	lbu	a5,0(a5)
    80000e38:	00757513          	andi	a0,a0,7
    80000e3c:	40a7d53b          	sraw	a0,a5,a0
    80000e40:	00157513          	andi	a0,a0,1
    80000e44:	00008067          	ret
    80000e48:	00000513          	li	a0,0
    80000e4c:	00008067          	ret

0000000080000e50 <pmm_init>:
    80000e50:	fe010113          	addi	sp,sp,-32
    80000e54:	00100713          	li	a4,1
    80000e58:	01f71713          	slli	a4,a4,0x1f
    80000e5c:	00913423          	sd	s1,8(sp)
    80000e60:	00009497          	auipc	s1,0x9
    80000e64:	1b048493          	addi	s1,s1,432 # 8000a010 <pmm_manager>
    80000e68:	02e4b023          	sd	a4,32(s1)
    80000e6c:	01100713          	li	a4,17
    80000e70:	01b71713          	slli	a4,a4,0x1b
    80000e74:	02e4b423          	sd	a4,40(s1)
    80000e78:	00008737          	lui	a4,0x8
    80000e7c:	fff70713          	addi	a4,a4,-1 # 7fff <_binary_user_test_basic_bin_size+0x78be>
    80000e80:	00e4b423          	sd	a4,8(s1)
    80000e84:	000887b7          	lui	a5,0x88
    80000e88:	00009717          	auipc	a4,0x9
    80000e8c:	18073c23          	sd	zero,408(a4) # 8000a020 <pmm_manager+0x10>
    80000e90:	00009717          	auipc	a4,0x9
    80000e94:	18073c23          	sd	zero,408(a4) # 8000a028 <pmm_manager+0x18>
    80000e98:	00009717          	auipc	a4,0x9
    80000e9c:	16073c23          	sd	zero,376(a4) # 8000a010 <pmm_manager>
    80000ea0:	00813823          	sd	s0,16(sp)
    80000ea4:	fffff737          	lui	a4,0xfffff
    80000ea8:	00836417          	auipc	s0,0x836
    80000eac:	b3f40413          	addi	s0,s0,-1217 # 808369e7 <current+0x1fc7>
    80000eb0:	fff78793          	addi	a5,a5,-1 # 87fff <_binary_user_test_basic_bin_size+0x878be>
    80000eb4:	00113c23          	sd	ra,24(sp)
    80000eb8:	00e47433          	and	s0,s0,a4
    80000ebc:	00c79793          	slli	a5,a5,0xc
    80000ec0:	0287e863          	bltu	a5,s0,80000ef0 <pmm_init+0xa0>
    80000ec4:	00100693          	li	a3,1
    80000ec8:	00000713          	li	a4,0
    80000ecc:	fffff5b7          	lui	a1,0xfffff
    80000ed0:	00e7b023          	sd	a4,0(a5)
    80000ed4:	00078713          	mv	a4,a5
    80000ed8:	00b787b3          	add	a5,a5,a1
    80000edc:	00068613          	mv	a2,a3
    80000ee0:	00168693          	addi	a3,a3,1
    80000ee4:	fe87f6e3          	bgeu	a5,s0,80000ed0 <pmm_init+0x80>
    80000ee8:	00e4b023          	sd	a4,0(s1)
    80000eec:	00c4b823          	sd	a2,16(s1)
    80000ef0:	e55ff0ef          	jal	ra,80000d44 <bitmap_init>
    80000ef4:	0204b783          	ld	a5,32(s1)
    80000ef8:	00000713          	li	a4,0
    80000efc:	00834517          	auipc	a0,0x834
    80000f00:	afc50513          	addi	a0,a0,-1284 # 808349f8 <pmm_bitmap>
    80000f04:	40f40433          	sub	s0,s0,a5
    80000f08:	00c45413          	srli	s0,s0,0xc
    80000f0c:	00100593          	li	a1,1
    80000f10:	02040e63          	beqz	s0,80000f4c <pmm_init+0xfc>
    80000f14:	00053603          	ld	a2,0(a0)
    80000f18:	00375693          	srli	a3,a4,0x3
    80000f1c:	00777793          	andi	a5,a4,7
    80000f20:	00f597bb          	sllw	a5,a1,a5
    80000f24:	00d606b3          	add	a3,a2,a3
    80000f28:	00170713          	addi	a4,a4,1 # fffffffffffff001 <TRAMPOLINE+0x1>
    80000f2c:	00060863          	beqz	a2,80000f3c <pmm_init+0xec>
    80000f30:	0006c603          	lbu	a2,0(a3)
    80000f34:	00c7e7b3          	or	a5,a5,a2
    80000f38:	00f68023          	sb	a5,0(a3)
    80000f3c:	0184b783          	ld	a5,24(s1)
    80000f40:	00178793          	addi	a5,a5,1
    80000f44:	00f4bc23          	sd	a5,24(s1)
    80000f48:	fce416e3          	bne	s0,a4,80000f14 <pmm_init+0xc4>
    80000f4c:	01813083          	ld	ra,24(sp)
    80000f50:	01013403          	ld	s0,16(sp)
    80000f54:	00813483          	ld	s1,8(sp)
    80000f58:	02010113          	addi	sp,sp,32
    80000f5c:	00008067          	ret

0000000080000f60 <alloc_page>:
    80000f60:	ff010113          	addi	sp,sp,-16
    80000f64:	00009797          	auipc	a5,0x9
    80000f68:	0ac78793          	addi	a5,a5,172 # 8000a010 <pmm_manager>
    80000f6c:	00813023          	sd	s0,0(sp)
    80000f70:	0007b403          	ld	s0,0(a5)
    80000f74:	00113423          	sd	ra,8(sp)
    80000f78:	08040463          	beqz	s0,80001000 <alloc_page+0xa0>
    80000f7c:	0107b603          	ld	a2,16(a5)
    80000f80:	0187b683          	ld	a3,24(a5)
    80000f84:	00043583          	ld	a1,0(s0)
    80000f88:	0207b703          	ld	a4,32(a5)
    80000f8c:	fff60613          	addi	a2,a2,-1
    80000f90:	00168693          	addi	a3,a3,1
    80000f94:	00c7b823          	sd	a2,16(a5)
    80000f98:	00d7bc23          	sd	a3,24(a5)
    80000f9c:	40e40733          	sub	a4,s0,a4
    80000fa0:	00b7b023          	sd	a1,0(a5)
    80000fa4:	00834697          	auipc	a3,0x834
    80000fa8:	a546b683          	ld	a3,-1452(a3) # 808349f8 <pmm_bitmap>
    80000fac:	00040793          	mv	a5,s0
    80000fb0:	00c75613          	srli	a2,a4,0xc
    80000fb4:	02068263          	beqz	a3,80000fd8 <alloc_page+0x78>
    80000fb8:	00f75713          	srli	a4,a4,0xf
    80000fbc:	00e68733          	add	a4,a3,a4
    80000fc0:	00074583          	lbu	a1,0(a4)
    80000fc4:	00767613          	andi	a2,a2,7
    80000fc8:	00100693          	li	a3,1
    80000fcc:	00c696bb          	sllw	a3,a3,a2
    80000fd0:	00b6e6b3          	or	a3,a3,a1
    80000fd4:	00d70023          	sb	a3,0(a4)
    80000fd8:	00001737          	lui	a4,0x1
    80000fdc:	00e40733          	add	a4,s0,a4
    80000fe0:	00078023          	sb	zero,0(a5)
    80000fe4:	00178793          	addi	a5,a5,1
    80000fe8:	fef71ce3          	bne	a4,a5,80000fe0 <alloc_page+0x80>
    80000fec:	00813083          	ld	ra,8(sp)
    80000ff0:	00040513          	mv	a0,s0
    80000ff4:	00013403          	ld	s0,0(sp)
    80000ff8:	01010113          	addi	sp,sp,16
    80000ffc:	00008067          	ret
    80001000:	00006517          	auipc	a0,0x6
    80001004:	f1050513          	addi	a0,a0,-240 # 80006f10 <digits+0x18>
    80001008:	97dff0ef          	jal	ra,80000984 <printf>
    8000100c:	fe1ff06f          	j	80000fec <alloc_page+0x8c>

0000000080001010 <free_page>:
    80001010:	08050063          	beqz	a0,80001090 <free_page+0x80>
    80001014:	00009797          	auipc	a5,0x9
    80001018:	ffc78793          	addi	a5,a5,-4 # 8000a010 <pmm_manager>
    8000101c:	0207b703          	ld	a4,32(a5)
    80001020:	06e56a63          	bltu	a0,a4,80001094 <free_page+0x84>
    80001024:	0287b683          	ld	a3,40(a5)
    80001028:	06d57663          	bgeu	a0,a3,80001094 <free_page+0x84>
    8000102c:	03451693          	slli	a3,a0,0x34
    80001030:	06069863          	bnez	a3,800010a0 <free_page+0x90>
    80001034:	0107b603          	ld	a2,16(a5)
    80001038:	0187b683          	ld	a3,24(a5)
    8000103c:	0007b583          	ld	a1,0(a5)
    80001040:	00160613          	addi	a2,a2,1
    80001044:	fff68693          	addi	a3,a3,-1
    80001048:	00b53023          	sd	a1,0(a0)
    8000104c:	00d7bc23          	sd	a3,24(a5)
    80001050:	40e50733          	sub	a4,a0,a4
    80001054:	00a7b023          	sd	a0,0(a5)
    80001058:	00c7b823          	sd	a2,16(a5)
    8000105c:	00834697          	auipc	a3,0x834
    80001060:	99c6b683          	ld	a3,-1636(a3) # 808349f8 <pmm_bitmap>
    80001064:	00c75793          	srli	a5,a4,0xc
    80001068:	02068463          	beqz	a3,80001090 <free_page+0x80>
    8000106c:	00f75713          	srli	a4,a4,0xf
    80001070:	00e68733          	add	a4,a3,a4
    80001074:	00074603          	lbu	a2,0(a4) # 1000 <_binary_user_test_basic_bin_size+0x8bf>
    80001078:	0077f693          	andi	a3,a5,7
    8000107c:	00100793          	li	a5,1
    80001080:	00d797bb          	sllw	a5,a5,a3
    80001084:	fff7c793          	not	a5,a5
    80001088:	00c7f7b3          	and	a5,a5,a2
    8000108c:	00f70023          	sb	a5,0(a4)
    80001090:	00008067          	ret
    80001094:	00006517          	auipc	a0,0x6
    80001098:	ea450513          	addi	a0,a0,-348 # 80006f38 <digits+0x40>
    8000109c:	8e9ff06f          	j	80000984 <printf>
    800010a0:	00006517          	auipc	a0,0x6
    800010a4:	ec050513          	addi	a0,a0,-320 # 80006f60 <digits+0x68>
    800010a8:	8ddff06f          	j	80000984 <printf>

00000000800010ac <alloc_pages>:
    800010ac:	fe010113          	addi	sp,sp,-32
    800010b0:	00113c23          	sd	ra,24(sp)
    800010b4:	00813823          	sd	s0,16(sp)
    800010b8:	00913423          	sd	s1,8(sp)
    800010bc:	01213023          	sd	s2,0(sp)
    800010c0:	06a05063          	blez	a0,80001120 <alloc_pages+0x74>
    800010c4:	00100793          	li	a5,1
    800010c8:	00050913          	mv	s2,a0
    800010cc:	06f50a63          	beq	a0,a5,80001140 <alloc_pages+0x94>
    800010d0:	e91ff0ef          	jal	ra,80000f60 <alloc_page>
    800010d4:	00050493          	mv	s1,a0
    800010d8:	04050463          	beqz	a0,80001120 <alloc_pages+0x74>
    800010dc:	00100413          	li	s0,1
    800010e0:	00c0006f          	j	800010ec <alloc_pages+0x40>
    800010e4:	0014041b          	addiw	s0,s0,1
    800010e8:	03245e63          	bge	s0,s2,80001124 <alloc_pages+0x78>
    800010ec:	e75ff0ef          	jal	ra,80000f60 <alloc_page>
    800010f0:	fe051ae3          	bnez	a0,800010e4 <alloc_pages+0x38>
    800010f4:	fff4041b          	addiw	s0,s0,-1
    800010f8:	02041413          	slli	s0,s0,0x20
    800010fc:	000017b7          	lui	a5,0x1
    80001100:	01445413          	srli	s0,s0,0x14
    80001104:	00f487b3          	add	a5,s1,a5
    80001108:	00f40433          	add	s0,s0,a5
    8000110c:	00001937          	lui	s2,0x1
    80001110:	00048513          	mv	a0,s1
    80001114:	012484b3          	add	s1,s1,s2
    80001118:	ef9ff0ef          	jal	ra,80001010 <free_page>
    8000111c:	fe849ae3          	bne	s1,s0,80001110 <alloc_pages+0x64>
    80001120:	00000493          	li	s1,0
    80001124:	01813083          	ld	ra,24(sp)
    80001128:	01013403          	ld	s0,16(sp)
    8000112c:	00013903          	ld	s2,0(sp)
    80001130:	00048513          	mv	a0,s1
    80001134:	00813483          	ld	s1,8(sp)
    80001138:	02010113          	addi	sp,sp,32
    8000113c:	00008067          	ret
    80001140:	01013403          	ld	s0,16(sp)
    80001144:	01813083          	ld	ra,24(sp)
    80001148:	00813483          	ld	s1,8(sp)
    8000114c:	00013903          	ld	s2,0(sp)
    80001150:	02010113          	addi	sp,sp,32
    80001154:	e0dff06f          	j	80000f60 <alloc_page>

0000000080001158 <free_pages>:
    80001158:	06050263          	beqz	a0,800011bc <free_pages+0x64>
    8000115c:	06b05063          	blez	a1,800011bc <free_pages+0x64>
    80001160:	fe010113          	addi	sp,sp,-32
    80001164:	00913423          	sd	s1,8(sp)
    80001168:	fff5849b          	addiw	s1,a1,-1
    8000116c:	02049493          	slli	s1,s1,0x20
    80001170:	000017b7          	lui	a5,0x1
    80001174:	0144d493          	srli	s1,s1,0x14
    80001178:	00f507b3          	add	a5,a0,a5
    8000117c:	00813823          	sd	s0,16(sp)
    80001180:	01213023          	sd	s2,0(sp)
    80001184:	00113c23          	sd	ra,24(sp)
    80001188:	00050413          	mv	s0,a0
    8000118c:	00f484b3          	add	s1,s1,a5
    80001190:	00001937          	lui	s2,0x1
    80001194:	00040513          	mv	a0,s0
    80001198:	01240433          	add	s0,s0,s2
    8000119c:	e75ff0ef          	jal	ra,80001010 <free_page>
    800011a0:	fe941ae3          	bne	s0,s1,80001194 <free_pages+0x3c>
    800011a4:	01813083          	ld	ra,24(sp)
    800011a8:	01013403          	ld	s0,16(sp)
    800011ac:	00813483          	ld	s1,8(sp)
    800011b0:	00013903          	ld	s2,0(sp)
    800011b4:	02010113          	addi	sp,sp,32
    800011b8:	00008067          	ret
    800011bc:	00008067          	ret

00000000800011c0 <get_total_pages>:
    800011c0:	00009517          	auipc	a0,0x9
    800011c4:	e5853503          	ld	a0,-424(a0) # 8000a018 <pmm_manager+0x8>
    800011c8:	00008067          	ret

00000000800011cc <get_free_pages>:
    800011cc:	00009517          	auipc	a0,0x9
    800011d0:	e5453503          	ld	a0,-428(a0) # 8000a020 <pmm_manager+0x10>
    800011d4:	00008067          	ret

00000000800011d8 <get_used_pages>:
    800011d8:	00009517          	auipc	a0,0x9
    800011dc:	e5053503          	ld	a0,-432(a0) # 8000a028 <pmm_manager+0x18>
    800011e0:	00008067          	ret

00000000800011e4 <pmm_info>:
    800011e4:	ff010113          	addi	sp,sp,-16
    800011e8:	00006517          	auipc	a0,0x6
    800011ec:	da050513          	addi	a0,a0,-608 # 80006f88 <digits+0x90>
    800011f0:	00113423          	sd	ra,8(sp)
    800011f4:	00813023          	sd	s0,0(sp)
    800011f8:	00009417          	auipc	s0,0x9
    800011fc:	e1840413          	addi	s0,s0,-488 # 8000a010 <pmm_manager>
    80001200:	f84ff0ef          	jal	ra,80000984 <printf>
    80001204:	00843583          	ld	a1,8(s0)
    80001208:	00006517          	auipc	a0,0x6
    8000120c:	da850513          	addi	a0,a0,-600 # 80006fb0 <digits+0xb8>
    80001210:	f74ff0ef          	jal	ra,80000984 <printf>
    80001214:	01043583          	ld	a1,16(s0)
    80001218:	00006517          	auipc	a0,0x6
    8000121c:	db050513          	addi	a0,a0,-592 # 80006fc8 <digits+0xd0>
    80001220:	f64ff0ef          	jal	ra,80000984 <printf>
    80001224:	01843583          	ld	a1,24(s0)
    80001228:	00006517          	auipc	a0,0x6
    8000122c:	db850513          	addi	a0,a0,-584 # 80006fe0 <digits+0xe8>
    80001230:	f54ff0ef          	jal	ra,80000984 <printf>
    80001234:	00843783          	ld	a5,8(s0)
    80001238:	00079a63          	bnez	a5,8000124c <pmm_info+0x68>
    8000123c:	00813083          	ld	ra,8(sp)
    80001240:	00013403          	ld	s0,0(sp)
    80001244:	01010113          	addi	sp,sp,16
    80001248:	00008067          	ret
    8000124c:	01843703          	ld	a4,24(s0)
    80001250:	06400593          	li	a1,100
    80001254:	00013403          	ld	s0,0(sp)
    80001258:	02e585b3          	mul	a1,a1,a4
    8000125c:	00813083          	ld	ra,8(sp)
    80001260:	00006517          	auipc	a0,0x6
    80001264:	d9850513          	addi	a0,a0,-616 # 80006ff8 <digits+0x100>
    80001268:	01010113          	addi	sp,sp,16
    8000126c:	02f5d5b3          	divu	a1,a1,a5
    80001270:	f14ff06f          	j	80000984 <printf>

0000000080001274 <free_table_recursive>:
    80001274:	fc010113          	addi	sp,sp,-64
    80001278:	02913423          	sd	s1,40(sp)
    8000127c:	01413823          	sd	s4,16(sp)
    80001280:	000014b7          	lui	s1,0x1
    80001284:	fff00a37          	lui	s4,0xfff00
    80001288:	02813823          	sd	s0,48(sp)
    8000128c:	03213023          	sd	s2,32(sp)
    80001290:	01313c23          	sd	s3,24(sp)
    80001294:	01513423          	sd	s5,8(sp)
    80001298:	01613023          	sd	s6,0(sp)
    8000129c:	02113c23          	sd	ra,56(sp)
    800012a0:	00050413          	mv	s0,a0
    800012a4:	00058913          	mv	s2,a1
    800012a8:	00050a93          	mv	s5,a0
    800012ac:	009504b3          	add	s1,a0,s1
    800012b0:	00100993          	li	s3,1
    800012b4:	fff58b1b          	addiw	s6,a1,-1
    800012b8:	008a5a13          	srli	s4,s4,0x8
    800012bc:	00043503          	ld	a0,0(s0)
    800012c0:	00840413          	addi	s0,s0,8
    800012c4:	00157793          	andi	a5,a0,1
    800012c8:	00078863          	beqz	a5,800012d8 <free_table_recursive+0x64>
    800012cc:	3ff57793          	andi	a5,a0,1023
    800012d0:	00090463          	beqz	s2,800012d8 <free_table_recursive+0x64>
    800012d4:	03378a63          	beq	a5,s3,80001308 <free_table_recursive+0x94>
    800012d8:	fe9412e3          	bne	s0,s1,800012bc <free_table_recursive+0x48>
    800012dc:	03013403          	ld	s0,48(sp)
    800012e0:	03813083          	ld	ra,56(sp)
    800012e4:	02813483          	ld	s1,40(sp)
    800012e8:	02013903          	ld	s2,32(sp)
    800012ec:	01813983          	ld	s3,24(sp)
    800012f0:	01013a03          	ld	s4,16(sp)
    800012f4:	00013b03          	ld	s6,0(sp)
    800012f8:	000a8513          	mv	a0,s5
    800012fc:	00813a83          	ld	s5,8(sp)
    80001300:	04010113          	addi	sp,sp,64
    80001304:	d0dff06f          	j	80001010 <free_page>
    80001308:	00251513          	slli	a0,a0,0x2
    8000130c:	000b0593          	mv	a1,s6
    80001310:	01457533          	and	a0,a0,s4
    80001314:	f61ff0ef          	jal	ra,80001274 <free_table_recursive>
    80001318:	fa9412e3          	bne	s0,s1,800012bc <free_table_recursive+0x48>
    8000131c:	fc1ff06f          	j	800012dc <free_table_recursive+0x68>

0000000080001320 <walk_inner>:
    80001320:	fc010113          	addi	sp,sp,-64
    80001324:	03213023          	sd	s2,32(sp)
    80001328:	fff00937          	lui	s2,0xfff00
    8000132c:	02913423          	sd	s1,40(sp)
    80001330:	01313c23          	sd	s3,24(sp)
    80001334:	01413823          	sd	s4,16(sp)
    80001338:	01513423          	sd	s5,8(sp)
    8000133c:	01613023          	sd	s6,0(sp)
    80001340:	02113c23          	sd	ra,56(sp)
    80001344:	02813823          	sd	s0,48(sp)
    80001348:	00058a13          	mv	s4,a1
    8000134c:	00060493          	mv	s1,a2
    80001350:	00200a93          	li	s5,2
    80001354:	00200793          	li	a5,2
    80001358:	000019b7          	lui	s3,0x1
    8000135c:	00895913          	srli	s2,s2,0x8
    80001360:	00100b13          	li	s6,1
    80001364:	0037941b          	slliw	s0,a5,0x3
    80001368:	00f4043b          	addw	s0,s0,a5
    8000136c:	00c4041b          	addiw	s0,s0,12
    80001370:	008a5433          	srl	s0,s4,s0
    80001374:	1ff47413          	andi	s0,s0,511
    80001378:	00341413          	slli	s0,s0,0x3
    8000137c:	00850433          	add	s0,a0,s0
    80001380:	00043503          	ld	a0,0(s0)
    80001384:	00157793          	andi	a5,a0,1
    80001388:	08079063          	bnez	a5,80001408 <walk_inner+0xe8>
    8000138c:	08048663          	beqz	s1,80001418 <walk_inner+0xf8>
    80001390:	bd1ff0ef          	jal	ra,80000f60 <alloc_page>
    80001394:	00050713          	mv	a4,a0
    80001398:	08050063          	beqz	a0,80001418 <walk_inner+0xf8>
    8000139c:	013506b3          	add	a3,a0,s3
    800013a0:	00050793          	mv	a5,a0
    800013a4:	00078023          	sb	zero,0(a5) # 1000 <_binary_user_test_basic_bin_size+0x8bf>
    800013a8:	00178793          	addi	a5,a5,1
    800013ac:	fef69ce3          	bne	a3,a5,800013a4 <walk_inner+0x84>
    800013b0:	00c75793          	srli	a5,a4,0xc
    800013b4:	00a79793          	slli	a5,a5,0xa
    800013b8:	0017e793          	ori	a5,a5,1
    800013bc:	00f43023          	sd	a5,0(s0)
    800013c0:	00100793          	li	a5,1
    800013c4:	036a9e63          	bne	s5,s6,80001400 <walk_inner+0xe0>
    800013c8:	00ca5513          	srli	a0,s4,0xc
    800013cc:	1ff57513          	andi	a0,a0,511
    800013d0:	00351513          	slli	a0,a0,0x3
    800013d4:	00a70533          	add	a0,a4,a0
    800013d8:	03813083          	ld	ra,56(sp)
    800013dc:	03013403          	ld	s0,48(sp)
    800013e0:	02813483          	ld	s1,40(sp)
    800013e4:	02013903          	ld	s2,32(sp)
    800013e8:	01813983          	ld	s3,24(sp)
    800013ec:	01013a03          	ld	s4,16(sp)
    800013f0:	00813a83          	ld	s5,8(sp)
    800013f4:	00013b03          	ld	s6,0(sp)
    800013f8:	04010113          	addi	sp,sp,64
    800013fc:	00008067          	ret
    80001400:	00100a93          	li	s5,1
    80001404:	f61ff06f          	j	80001364 <walk_inner+0x44>
    80001408:	00251513          	slli	a0,a0,0x2
    8000140c:	01257533          	and	a0,a0,s2
    80001410:	00050713          	mv	a4,a0
    80001414:	fadff06f          	j	800013c0 <walk_inner+0xa0>
    80001418:	00000513          	li	a0,0
    8000141c:	fbdff06f          	j	800013d8 <walk_inner+0xb8>

0000000080001420 <copyin_internal>:
    80001420:	12068063          	beqz	a3,80001540 <copyin_internal+0x120>
    80001424:	fb010113          	addi	sp,sp,-80
    80001428:	02913c23          	sd	s1,56(sp)
    8000142c:	03213823          	sd	s2,48(sp)
    80001430:	fff004b7          	lui	s1,0xfff00
    80001434:	00001937          	lui	s2,0x1
    80001438:	04813023          	sd	s0,64(sp)
    8000143c:	03313423          	sd	s3,40(sp)
    80001440:	03413023          	sd	s4,32(sp)
    80001444:	01513c23          	sd	s5,24(sp)
    80001448:	01613823          	sd	s6,16(sp)
    8000144c:	01713423          	sd	s7,8(sp)
    80001450:	01813023          	sd	s8,0(sp)
    80001454:	04113423          	sd	ra,72(sp)
    80001458:	00068b13          	mv	s6,a3
    8000145c:	00050413          	mv	s0,a0
    80001460:	00058c13          	mv	s8,a1
    80001464:	00060b93          	mv	s7,a2
    80001468:	00070a93          	mv	s5,a4
    8000146c:	01100993          	li	s3,17
    80001470:	fff90a13          	addi	s4,s2,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    80001474:	0084d493          	srli	s1,s1,0x8
    80001478:	00000613          	li	a2,0
    8000147c:	000b8593          	mv	a1,s7
    80001480:	00040513          	mv	a0,s0
    80001484:	e9dff0ef          	jal	ra,80001320 <walk_inner>
    80001488:	06050c63          	beqz	a0,80001500 <copyin_internal+0xe0>
    8000148c:	00053783          	ld	a5,0(a0)
    80001490:	0117f713          	andi	a4,a5,17
    80001494:	07371663          	bne	a4,s3,80001500 <copyin_internal+0xe0>
    80001498:	014bf733          	and	a4,s7,s4
    8000149c:	40e90533          	sub	a0,s2,a4
    800014a0:	00ab7463          	bgeu	s6,a0,800014a8 <copyin_internal+0x88>
    800014a4:	000b0513          	mv	a0,s6
    800014a8:	00279313          	slli	t1,a5,0x2
    800014ac:	00937333          	and	t1,t1,s1
    800014b0:	00e36333          	or	t1,t1,a4
    800014b4:	000c0813          	mv	a6,s8
    800014b8:	00100793          	li	a5,1
    800014bc:	0180006f          	j	800014d4 <copyin_internal+0xb4>
    800014c0:	06088a63          	beqz	a7,80001534 <copyin_internal+0x114>
    800014c4:	01180023          	sb	a7,0(a6)
    800014c8:	02a7fc63          	bgeu	a5,a0,80001500 <copyin_internal+0xe0>
    800014cc:	00178793          	addi	a5,a5,1
    800014d0:	00180813          	addi	a6,a6,1
    800014d4:	00f308b3          	add	a7,t1,a5
    800014d8:	fff8c883          	lbu	a7,-1(a7)
    800014dc:	fe0a92e3          	bnez	s5,800014c0 <copyin_internal+0xa0>
    800014e0:	01180023          	sb	a7,0(a6)
    800014e4:	fea7e4e3          	bltu	a5,a0,800014cc <copyin_internal+0xac>
    800014e8:	40ab0b33          	sub	s6,s6,a0
    800014ec:	00ab8bb3          	add	s7,s7,a0
    800014f0:	00ac0c33          	add	s8,s8,a0
    800014f4:	f80b12e3          	bnez	s6,80001478 <copyin_internal+0x58>
    800014f8:	00000513          	li	a0,0
    800014fc:	0080006f          	j	80001504 <copyin_internal+0xe4>
    80001500:	fff00513          	li	a0,-1
    80001504:	04813083          	ld	ra,72(sp)
    80001508:	04013403          	ld	s0,64(sp)
    8000150c:	03813483          	ld	s1,56(sp)
    80001510:	03013903          	ld	s2,48(sp)
    80001514:	02813983          	ld	s3,40(sp)
    80001518:	02013a03          	ld	s4,32(sp)
    8000151c:	01813a83          	ld	s5,24(sp)
    80001520:	01013b03          	ld	s6,16(sp)
    80001524:	00813b83          	ld	s7,8(sp)
    80001528:	00013c03          	ld	s8,0(sp)
    8000152c:	05010113          	addi	sp,sp,80
    80001530:	00008067          	ret
    80001534:	00080023          	sb	zero,0(a6)
    80001538:	00000513          	li	a0,0
    8000153c:	fc9ff06f          	j	80001504 <copyin_internal+0xe4>
    80001540:	00000513          	li	a0,0
    80001544:	00008067          	ret

0000000080001548 <create_pagetable>:
    80001548:	ff010113          	addi	sp,sp,-16
    8000154c:	00113423          	sd	ra,8(sp)
    80001550:	a11ff0ef          	jal	ra,80000f60 <alloc_page>
    80001554:	02050463          	beqz	a0,8000157c <create_pagetable+0x34>
    80001558:	00001737          	lui	a4,0x1
    8000155c:	00e50733          	add	a4,a0,a4
    80001560:	00050793          	mv	a5,a0
    80001564:	00078023          	sb	zero,0(a5)
    80001568:	00178793          	addi	a5,a5,1
    8000156c:	fee79ce3          	bne	a5,a4,80001564 <create_pagetable+0x1c>
    80001570:	00813083          	ld	ra,8(sp)
    80001574:	01010113          	addi	sp,sp,16
    80001578:	00008067          	ret
    8000157c:	00813083          	ld	ra,8(sp)
    80001580:	00000513          	li	a0,0
    80001584:	01010113          	addi	sp,sp,16
    80001588:	00008067          	ret

000000008000158c <walk_create>:
    8000158c:	00100613          	li	a2,1
    80001590:	d91ff06f          	j	80001320 <walk_inner>

0000000080001594 <walk_lookup>:
    80001594:	01e5d793          	srli	a5,a1,0x1e
    80001598:	1ff7f793          	andi	a5,a5,511
    8000159c:	00379793          	slli	a5,a5,0x3
    800015a0:	00a787b3          	add	a5,a5,a0
    800015a4:	0007b703          	ld	a4,0(a5)
    800015a8:	00000513          	li	a0,0
    800015ac:	00177793          	andi	a5,a4,1
    800015b0:	00079463          	bnez	a5,800015b8 <walk_lookup+0x24>
    800015b4:	00008067          	ret
    800015b8:	0155d793          	srli	a5,a1,0x15
    800015bc:	fff006b7          	lui	a3,0xfff00
    800015c0:	00271713          	slli	a4,a4,0x2
    800015c4:	0086d693          	srli	a3,a3,0x8
    800015c8:	1ff7f793          	andi	a5,a5,511
    800015cc:	00d77733          	and	a4,a4,a3
    800015d0:	00379793          	slli	a5,a5,0x3
    800015d4:	00e787b3          	add	a5,a5,a4
    800015d8:	0007b783          	ld	a5,0(a5)
    800015dc:	00000513          	li	a0,0
    800015e0:	0017f713          	andi	a4,a5,1
    800015e4:	fc0708e3          	beqz	a4,800015b4 <walk_lookup+0x20>
    800015e8:	00c5d513          	srli	a0,a1,0xc
    800015ec:	00a7d793          	srli	a5,a5,0xa
    800015f0:	00c79793          	slli	a5,a5,0xc
    800015f4:	1ff57513          	andi	a0,a0,511
    800015f8:	00d7f7b3          	and	a5,a5,a3
    800015fc:	00351513          	slli	a0,a0,0x3
    80001600:	00a78533          	add	a0,a5,a0
    80001604:	00008067          	ret

0000000080001608 <map_page>:
    80001608:	fe010113          	addi	sp,sp,-32
    8000160c:	00813823          	sd	s0,16(sp)
    80001610:	00060413          	mv	s0,a2
    80001614:	00100613          	li	a2,1
    80001618:	00913423          	sd	s1,8(sp)
    8000161c:	00113c23          	sd	ra,24(sp)
    80001620:	00068493          	mv	s1,a3
    80001624:	cfdff0ef          	jal	ra,80001320 <walk_inner>
    80001628:	04050463          	beqz	a0,80001670 <map_page+0x68>
    8000162c:	00053783          	ld	a5,0(a0)
    80001630:	0017f793          	andi	a5,a5,1
    80001634:	02079a63          	bnez	a5,80001668 <map_page+0x60>
    80001638:	00c45793          	srli	a5,s0,0xc
    8000163c:	00a79793          	slli	a5,a5,0xa
    80001640:	0ff4f693          	andi	a3,s1,255
    80001644:	00d7e7b3          	or	a5,a5,a3
    80001648:	0c17e793          	ori	a5,a5,193
    8000164c:	00f53023          	sd	a5,0(a0)
    80001650:	00000513          	li	a0,0
    80001654:	01813083          	ld	ra,24(sp)
    80001658:	01013403          	ld	s0,16(sp)
    8000165c:	00813483          	ld	s1,8(sp)
    80001660:	02010113          	addi	sp,sp,32
    80001664:	00008067          	ret
    80001668:	ffe00513          	li	a0,-2
    8000166c:	fe9ff06f          	j	80001654 <map_page+0x4c>
    80001670:	fff00513          	li	a0,-1
    80001674:	fe1ff06f          	j	80001654 <map_page+0x4c>

0000000080001678 <destroy_pagetable>:
    80001678:	00051463          	bnez	a0,80001680 <destroy_pagetable+0x8>
    8000167c:	00008067          	ret
    80001680:	00200593          	li	a1,2
    80001684:	bf1ff06f          	j	80001274 <free_table_recursive>

0000000080001688 <uvmcreate>:
    80001688:	ff010113          	addi	sp,sp,-16
    8000168c:	00113423          	sd	ra,8(sp)
    80001690:	8d1ff0ef          	jal	ra,80000f60 <alloc_page>
    80001694:	02050463          	beqz	a0,800016bc <uvmcreate+0x34>
    80001698:	00001737          	lui	a4,0x1
    8000169c:	00e50733          	add	a4,a0,a4
    800016a0:	00050793          	mv	a5,a0
    800016a4:	00078023          	sb	zero,0(a5)
    800016a8:	00178793          	addi	a5,a5,1
    800016ac:	fee79ce3          	bne	a5,a4,800016a4 <uvmcreate+0x1c>
    800016b0:	00813083          	ld	ra,8(sp)
    800016b4:	01010113          	addi	sp,sp,16
    800016b8:	00008067          	ret
    800016bc:	00813083          	ld	ra,8(sp)
    800016c0:	00000513          	li	a0,0
    800016c4:	01010113          	addi	sp,sp,16
    800016c8:	00008067          	ret

00000000800016cc <uvmunmap>:
    800016cc:	fc010113          	addi	sp,sp,-64
    800016d0:	03213023          	sd	s2,32(sp)
    800016d4:	02113c23          	sd	ra,56(sp)
    800016d8:	02813823          	sd	s0,48(sp)
    800016dc:	02913423          	sd	s1,40(sp)
    800016e0:	01313c23          	sd	s3,24(sp)
    800016e4:	01413823          	sd	s4,16(sp)
    800016e8:	01513423          	sd	s5,8(sp)
    800016ec:	00c58933          	add	s2,a1,a2
    800016f0:	0525fa63          	bgeu	a1,s2,80001744 <uvmunmap+0x78>
    800016f4:	fff00a37          	lui	s4,0xfff00
    800016f8:	00058493          	mv	s1,a1
    800016fc:	00050993          	mv	s3,a0
    80001700:	008a5a13          	srli	s4,s4,0x8
    80001704:	00001ab7          	lui	s5,0x1
    80001708:	00048593          	mv	a1,s1
    8000170c:	00000613          	li	a2,0
    80001710:	00098513          	mv	a0,s3
    80001714:	c0dff0ef          	jal	ra,80001320 <walk_inner>
    80001718:	00050413          	mv	s0,a0
    8000171c:	015484b3          	add	s1,s1,s5
    80001720:	02050063          	beqz	a0,80001740 <uvmunmap+0x74>
    80001724:	00053783          	ld	a5,0(a0)
    80001728:	00279513          	slli	a0,a5,0x2
    8000172c:	0017f793          	andi	a5,a5,1
    80001730:	01457533          	and	a0,a0,s4
    80001734:	00078663          	beqz	a5,80001740 <uvmunmap+0x74>
    80001738:	8d9ff0ef          	jal	ra,80001010 <free_page>
    8000173c:	00043023          	sd	zero,0(s0)
    80001740:	fd24e4e3          	bltu	s1,s2,80001708 <uvmunmap+0x3c>
    80001744:	03813083          	ld	ra,56(sp)
    80001748:	03013403          	ld	s0,48(sp)
    8000174c:	02813483          	ld	s1,40(sp)
    80001750:	02013903          	ld	s2,32(sp)
    80001754:	01813983          	ld	s3,24(sp)
    80001758:	01013a03          	ld	s4,16(sp)
    8000175c:	00813a83          	ld	s5,8(sp)
    80001760:	04010113          	addi	sp,sp,64
    80001764:	00008067          	ret

0000000080001768 <uvmalloc>:
    80001768:	0cb66663          	bltu	a2,a1,80001834 <uvmalloc+0xcc>
    8000176c:	fc010113          	addi	sp,sp,-64
    80001770:	03213023          	sd	s2,32(sp)
    80001774:	00001937          	lui	s2,0x1
    80001778:	fff90913          	addi	s2,s2,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    8000177c:	012585b3          	add	a1,a1,s2
    80001780:	fffff937          	lui	s2,0xfffff
    80001784:	02913423          	sd	s1,40(sp)
    80001788:	01313c23          	sd	s3,24(sp)
    8000178c:	01413823          	sd	s4,16(sp)
    80001790:	01513423          	sd	s5,8(sp)
    80001794:	01613023          	sd	s6,0(sp)
    80001798:	0125f933          	and	s2,a1,s2
    8000179c:	0ff6f693          	andi	a3,a3,255
    800017a0:	02113c23          	sd	ra,56(sp)
    800017a4:	02813823          	sd	s0,48(sp)
    800017a8:	00060993          	mv	s3,a2
    800017ac:	00050a13          	mv	s4,a0
    800017b0:	00090b13          	mv	s6,s2
    800017b4:	0106e493          	ori	s1,a3,16
    800017b8:	00001ab7          	lui	s5,0x1
    800017bc:	04c97663          	bgeu	s2,a2,80001808 <uvmalloc+0xa0>
    800017c0:	fa0ff0ef          	jal	ra,80000f60 <alloc_page>
    800017c4:	00050413          	mv	s0,a0
    800017c8:	000b0593          	mv	a1,s6
    800017cc:	00100613          	li	a2,1
    800017d0:	000a0513          	mv	a0,s4
    800017d4:	06040463          	beqz	s0,8000183c <uvmalloc+0xd4>
    800017d8:	00c45413          	srli	s0,s0,0xc
    800017dc:	00a41413          	slli	s0,s0,0xa
    800017e0:	00946433          	or	s0,s0,s1
    800017e4:	b3dff0ef          	jal	ra,80001320 <walk_inner>
    800017e8:	015b0b33          	add	s6,s6,s5
    800017ec:	0c146413          	ori	s0,s0,193
    800017f0:	00050a63          	beqz	a0,80001804 <uvmalloc+0x9c>
    800017f4:	00053783          	ld	a5,0(a0)
    800017f8:	0017f793          	andi	a5,a5,1
    800017fc:	00079463          	bnez	a5,80001804 <uvmalloc+0x9c>
    80001800:	00853023          	sd	s0,0(a0)
    80001804:	fb3b6ee3          	bltu	s6,s3,800017c0 <uvmalloc+0x58>
    80001808:	00098513          	mv	a0,s3
    8000180c:	03813083          	ld	ra,56(sp)
    80001810:	03013403          	ld	s0,48(sp)
    80001814:	02813483          	ld	s1,40(sp)
    80001818:	02013903          	ld	s2,32(sp)
    8000181c:	01813983          	ld	s3,24(sp)
    80001820:	01013a03          	ld	s4,16(sp)
    80001824:	00813a83          	ld	s5,8(sp)
    80001828:	00013b03          	ld	s6,0(sp)
    8000182c:	04010113          	addi	sp,sp,64
    80001830:	00008067          	ret
    80001834:	00058513          	mv	a0,a1
    80001838:	00008067          	ret
    8000183c:	412b0633          	sub	a2,s6,s2
    80001840:	00090593          	mv	a1,s2
    80001844:	e89ff0ef          	jal	ra,800016cc <uvmunmap>
    80001848:	00000513          	li	a0,0
    8000184c:	fc1ff06f          	j	8000180c <uvmalloc+0xa4>

0000000080001850 <uvmdealloc>:
    80001850:	ff010113          	addi	sp,sp,-16
    80001854:	00813023          	sd	s0,0(sp)
    80001858:	00113423          	sd	ra,8(sp)
    8000185c:	00058413          	mv	s0,a1
    80001860:	02b67463          	bgeu	a2,a1,80001888 <uvmdealloc+0x38>
    80001864:	000017b7          	lui	a5,0x1
    80001868:	00060413          	mv	s0,a2
    8000186c:	fff78793          	addi	a5,a5,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    80001870:	fffff637          	lui	a2,0xfffff
    80001874:	00f40733          	add	a4,s0,a5
    80001878:	00f587b3          	add	a5,a1,a5
    8000187c:	00c775b3          	and	a1,a4,a2
    80001880:	00c7f633          	and	a2,a5,a2
    80001884:	00c5ec63          	bltu	a1,a2,8000189c <uvmdealloc+0x4c>
    80001888:	00813083          	ld	ra,8(sp)
    8000188c:	00040513          	mv	a0,s0
    80001890:	00013403          	ld	s0,0(sp)
    80001894:	01010113          	addi	sp,sp,16
    80001898:	00008067          	ret
    8000189c:	40b60633          	sub	a2,a2,a1
    800018a0:	e2dff0ef          	jal	ra,800016cc <uvmunmap>
    800018a4:	00813083          	ld	ra,8(sp)
    800018a8:	00040513          	mv	a0,s0
    800018ac:	00013403          	ld	s0,0(sp)
    800018b0:	01010113          	addi	sp,sp,16
    800018b4:	00008067          	ret

00000000800018b8 <free_user_pagetable>:
    800018b8:	00051463          	bnez	a0,800018c0 <free_user_pagetable+0x8>
    800018bc:	00008067          	ret
    800018c0:	00200593          	li	a1,2
    800018c4:	9b1ff06f          	j	80001274 <free_table_recursive>

00000000800018c8 <copyin>:
    800018c8:	00000713          	li	a4,0
    800018cc:	b55ff06f          	j	80001420 <copyin_internal>

00000000800018d0 <copyinstr>:
    800018d0:	00100713          	li	a4,1
    800018d4:	b4dff06f          	j	80001420 <copyin_internal>

00000000800018d8 <copyout>:
    800018d8:	0e068a63          	beqz	a3,800019cc <copyout+0xf4>
    800018dc:	fb010113          	addi	sp,sp,-80
    800018e0:	02913c23          	sd	s1,56(sp)
    800018e4:	03213823          	sd	s2,48(sp)
    800018e8:	fff004b7          	lui	s1,0xfff00
    800018ec:	00001937          	lui	s2,0x1
    800018f0:	04813023          	sd	s0,64(sp)
    800018f4:	03313423          	sd	s3,40(sp)
    800018f8:	03413023          	sd	s4,32(sp)
    800018fc:	01513c23          	sd	s5,24(sp)
    80001900:	01613823          	sd	s6,16(sp)
    80001904:	01713423          	sd	s7,8(sp)
    80001908:	04113423          	sd	ra,72(sp)
    8000190c:	00068b13          	mv	s6,a3
    80001910:	00050413          	mv	s0,a0
    80001914:	00058b93          	mv	s7,a1
    80001918:	00060a93          	mv	s5,a2
    8000191c:	01100993          	li	s3,17
    80001920:	fff90a13          	addi	s4,s2,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    80001924:	0084d493          	srli	s1,s1,0x8
    80001928:	00000613          	li	a2,0
    8000192c:	000b8593          	mv	a1,s7
    80001930:	00040513          	mv	a0,s0
    80001934:	9edff0ef          	jal	ra,80001320 <walk_inner>
    80001938:	06050263          	beqz	a0,8000199c <copyout+0xc4>
    8000193c:	00053783          	ld	a5,0(a0)
    80001940:	0117f713          	andi	a4,a5,17
    80001944:	05371c63          	bne	a4,s3,8000199c <copyout+0xc4>
    80001948:	014bf6b3          	and	a3,s7,s4
    8000194c:	40d908b3          	sub	a7,s2,a3
    80001950:	011b7463          	bgeu	s6,a7,80001958 <copyout+0x80>
    80001954:	000b0893          	mv	a7,s6
    80001958:	00279713          	slli	a4,a5,0x2
    8000195c:	00977733          	and	a4,a4,s1
    80001960:	00d76733          	or	a4,a4,a3
    80001964:	000a8793          	mv	a5,s5
    80001968:	01588833          	add	a6,a7,s5
    8000196c:	41570733          	sub	a4,a4,s5
    80001970:	0007c503          	lbu	a0,0(a5)
    80001974:	00f70633          	add	a2,a4,a5
    80001978:	00178793          	addi	a5,a5,1
    8000197c:	00a60023          	sb	a0,0(a2) # fffffffffffff000 <TRAMPOLINE>
    80001980:	fef818e3          	bne	a6,a5,80001970 <copyout+0x98>
    80001984:	411b0b33          	sub	s6,s6,a7
    80001988:	011b8bb3          	add	s7,s7,a7
    8000198c:	00080a93          	mv	s5,a6
    80001990:	f80b1ce3          	bnez	s6,80001928 <copyout+0x50>
    80001994:	00000513          	li	a0,0
    80001998:	0080006f          	j	800019a0 <copyout+0xc8>
    8000199c:	fff00513          	li	a0,-1
    800019a0:	04813083          	ld	ra,72(sp)
    800019a4:	04013403          	ld	s0,64(sp)
    800019a8:	03813483          	ld	s1,56(sp)
    800019ac:	03013903          	ld	s2,48(sp)
    800019b0:	02813983          	ld	s3,40(sp)
    800019b4:	02013a03          	ld	s4,32(sp)
    800019b8:	01813a83          	ld	s5,24(sp)
    800019bc:	01013b03          	ld	s6,16(sp)
    800019c0:	00813b83          	ld	s7,8(sp)
    800019c4:	05010113          	addi	sp,sp,80
    800019c8:	00008067          	ret
    800019cc:	00000513          	li	a0,0
    800019d0:	00008067          	ret

00000000800019d4 <uvmcopy>:
    800019d4:	12060e63          	beqz	a2,80001b10 <uvmcopy+0x13c>
    800019d8:	fb010113          	addi	sp,sp,-80
    800019dc:	01513c23          	sd	s5,24(sp)
    800019e0:	fff00ab7          	lui	s5,0xfff00
    800019e4:	02913c23          	sd	s1,56(sp)
    800019e8:	03213823          	sd	s2,48(sp)
    800019ec:	03313423          	sd	s3,40(sp)
    800019f0:	03413023          	sd	s4,32(sp)
    800019f4:	01813023          	sd	s8,0(sp)
    800019f8:	04113423          	sd	ra,72(sp)
    800019fc:	04813023          	sd	s0,64(sp)
    80001a00:	01613823          	sd	s6,16(sp)
    80001a04:	01713423          	sd	s7,8(sp)
    80001a08:	00060913          	mv	s2,a2
    80001a0c:	00050993          	mv	s3,a0
    80001a10:	00058a13          	mv	s4,a1
    80001a14:	00000c13          	li	s8,0
    80001a18:	008ada93          	srli	s5,s5,0x8
    80001a1c:	000014b7          	lui	s1,0x1
    80001a20:	00000613          	li	a2,0
    80001a24:	000c0593          	mv	a1,s8
    80001a28:	00098513          	mv	a0,s3
    80001a2c:	8f5ff0ef          	jal	ra,80001320 <walk_inner>
    80001a30:	0a050c63          	beqz	a0,80001ae8 <uvmcopy+0x114>
    80001a34:	00053783          	ld	a5,0(a0)
    80001a38:	0017f713          	andi	a4,a5,1
    80001a3c:	0a070663          	beqz	a4,80001ae8 <uvmcopy+0x114>
    80001a40:	00279693          	slli	a3,a5,0x2
    80001a44:	0156fbb3          	and	s7,a3,s5
    80001a48:	01e7fb13          	andi	s6,a5,30
    80001a4c:	d14ff0ef          	jal	ra,80000f60 <alloc_page>
    80001a50:	00050413          	mv	s0,a0
    80001a54:	0a050263          	beqz	a0,80001af8 <uvmcopy+0x124>
    80001a58:	00950633          	add	a2,a0,s1
    80001a5c:	00050793          	mv	a5,a0
    80001a60:	40ab86b3          	sub	a3,s7,a0
    80001a64:	00f68733          	add	a4,a3,a5
    80001a68:	00074703          	lbu	a4,0(a4) # 1000 <_binary_user_test_basic_bin_size+0x8bf>
    80001a6c:	00178793          	addi	a5,a5,1
    80001a70:	fee78fa3          	sb	a4,-1(a5)
    80001a74:	fec798e3          	bne	a5,a2,80001a64 <uvmcopy+0x90>
    80001a78:	000c0593          	mv	a1,s8
    80001a7c:	00100613          	li	a2,1
    80001a80:	000a0513          	mv	a0,s4
    80001a84:	89dff0ef          	jal	ra,80001320 <walk_inner>
    80001a88:	009c0c33          	add	s8,s8,s1
    80001a8c:	06050263          	beqz	a0,80001af0 <uvmcopy+0x11c>
    80001a90:	00053783          	ld	a5,0(a0)
    80001a94:	0017f793          	andi	a5,a5,1
    80001a98:	04079c63          	bnez	a5,80001af0 <uvmcopy+0x11c>
    80001a9c:	00c45793          	srli	a5,s0,0xc
    80001aa0:	00a79793          	slli	a5,a5,0xa
    80001aa4:	0167e7b3          	or	a5,a5,s6
    80001aa8:	0c17e793          	ori	a5,a5,193
    80001aac:	00f53023          	sd	a5,0(a0)
    80001ab0:	f72c68e3          	bltu	s8,s2,80001a20 <uvmcopy+0x4c>
    80001ab4:	00000513          	li	a0,0
    80001ab8:	04813083          	ld	ra,72(sp)
    80001abc:	04013403          	ld	s0,64(sp)
    80001ac0:	03813483          	ld	s1,56(sp)
    80001ac4:	03013903          	ld	s2,48(sp)
    80001ac8:	02813983          	ld	s3,40(sp)
    80001acc:	02013a03          	ld	s4,32(sp)
    80001ad0:	01813a83          	ld	s5,24(sp)
    80001ad4:	01013b03          	ld	s6,16(sp)
    80001ad8:	00813b83          	ld	s7,8(sp)
    80001adc:	00013c03          	ld	s8,0(sp)
    80001ae0:	05010113          	addi	sp,sp,80
    80001ae4:	00008067          	ret
    80001ae8:	fff00513          	li	a0,-1
    80001aec:	fcdff06f          	j	80001ab8 <uvmcopy+0xe4>
    80001af0:	00040513          	mv	a0,s0
    80001af4:	d1cff0ef          	jal	ra,80001010 <free_page>
    80001af8:	000a0513          	mv	a0,s4
    80001afc:	000c0613          	mv	a2,s8
    80001b00:	00000593          	li	a1,0
    80001b04:	bc9ff0ef          	jal	ra,800016cc <uvmunmap>
    80001b08:	fff00513          	li	a0,-1
    80001b0c:	fadff06f          	j	80001ab8 <uvmcopy+0xe4>
    80001b10:	00000513          	li	a0,0
    80001b14:	00008067          	ret

0000000080001b18 <dump_pagetable>:
    80001b18:	fa010113          	addi	sp,sp,-96
    80001b1c:	01713c23          	sd	s7,24(sp)
    80001b20:	fff00bb7          	lui	s7,0xfff00
    80001b24:	04913423          	sd	s1,72(sp)
    80001b28:	05213023          	sd	s2,64(sp)
    80001b2c:	03313c23          	sd	s3,56(sp)
    80001b30:	03513423          	sd	s5,40(sp)
    80001b34:	03613023          	sd	s6,32(sp)
    80001b38:	01813823          	sd	s8,16(sp)
    80001b3c:	01913423          	sd	s9,8(sp)
    80001b40:	04113c23          	sd	ra,88(sp)
    80001b44:	04813823          	sd	s0,80(sp)
    80001b48:	03413823          	sd	s4,48(sp)
    80001b4c:	01a13023          	sd	s10,0(sp)
    80001b50:	00058493          	mv	s1,a1
    80001b54:	00050a93          	mv	s5,a0
    80001b58:	00000993          	li	s3,0
    80001b5c:	008bdb93          	srli	s7,s7,0x8
    80001b60:	00005c17          	auipc	s8,0x5
    80001b64:	4b8c0c13          	addi	s8,s8,1208 # 80007018 <digits+0x120>
    80001b68:	00100b13          	li	s6,1
    80001b6c:	00158c9b          	addiw	s9,a1,1
    80001b70:	00005917          	auipc	s2,0x5
    80001b74:	4a090913          	addi	s2,s2,1184 # 80007010 <digits+0x118>
    80001b78:	0140006f          	j	80001b8c <dump_pagetable+0x74>
    80001b7c:	0019899b          	addiw	s3,s3,1
    80001b80:	20000793          	li	a5,512
    80001b84:	008a8a93          	addi	s5,s5,8 # fffffffffff00008 <current+0xffffffff7f6cb5e8>
    80001b88:	06f98863          	beq	s3,a5,80001bf8 <dump_pagetable+0xe0>
    80001b8c:	000aba03          	ld	s4,0(s5)
    80001b90:	001a7793          	andi	a5,s4,1
    80001b94:	fe0784e3          	beqz	a5,80001b7c <dump_pagetable+0x64>
    80001b98:	002a1d13          	slli	s10,s4,0x2
    80001b9c:	017d7d33          	and	s10,s10,s7
    80001ba0:	08905863          	blez	s1,80001c30 <dump_pagetable+0x118>
    80001ba4:	00000413          	li	s0,0
    80001ba8:	0014041b          	addiw	s0,s0,1
    80001bac:	00090513          	mv	a0,s2
    80001bb0:	dd5fe0ef          	jal	ra,80000984 <printf>
    80001bb4:	fe849ae3          	bne	s1,s0,80001ba8 <dump_pagetable+0x90>
    80001bb8:	3ffa7413          	andi	s0,s4,1023
    80001bbc:	00040713          	mv	a4,s0
    80001bc0:	000d0693          	mv	a3,s10
    80001bc4:	000a0613          	mv	a2,s4
    80001bc8:	00098593          	mv	a1,s3
    80001bcc:	000c0513          	mv	a0,s8
    80001bd0:	db5fe0ef          	jal	ra,80000984 <printf>
    80001bd4:	fa9b44e3          	blt	s6,s1,80001b7c <dump_pagetable+0x64>
    80001bd8:	fb6412e3          	bne	s0,s6,80001b7c <dump_pagetable+0x64>
    80001bdc:	000c8593          	mv	a1,s9
    80001be0:	000d0513          	mv	a0,s10
    80001be4:	f35ff0ef          	jal	ra,80001b18 <dump_pagetable>
    80001be8:	0019899b          	addiw	s3,s3,1
    80001bec:	20000793          	li	a5,512
    80001bf0:	008a8a93          	addi	s5,s5,8
    80001bf4:	f8f99ce3          	bne	s3,a5,80001b8c <dump_pagetable+0x74>
    80001bf8:	05813083          	ld	ra,88(sp)
    80001bfc:	05013403          	ld	s0,80(sp)
    80001c00:	04813483          	ld	s1,72(sp)
    80001c04:	04013903          	ld	s2,64(sp)
    80001c08:	03813983          	ld	s3,56(sp)
    80001c0c:	03013a03          	ld	s4,48(sp)
    80001c10:	02813a83          	ld	s5,40(sp)
    80001c14:	02013b03          	ld	s6,32(sp)
    80001c18:	01813b83          	ld	s7,24(sp)
    80001c1c:	01013c03          	ld	s8,16(sp)
    80001c20:	00813c83          	ld	s9,8(sp)
    80001c24:	00013d03          	ld	s10,0(sp)
    80001c28:	06010113          	addi	sp,sp,96
    80001c2c:	00008067          	ret
    80001c30:	3ffa7413          	andi	s0,s4,1023
    80001c34:	00040713          	mv	a4,s0
    80001c38:	000d0693          	mv	a3,s10
    80001c3c:	000a0613          	mv	a2,s4
    80001c40:	00098593          	mv	a1,s3
    80001c44:	000c0513          	mv	a0,s8
    80001c48:	d3dfe0ef          	jal	ra,80000984 <printf>
    80001c4c:	f36418e3          	bne	s0,s6,80001b7c <dump_pagetable+0x64>
    80001c50:	f8dff06f          	j	80001bdc <dump_pagetable+0xc4>

0000000080001c54 <map_region>:
    80001c54:	0a068c63          	beqz	a3,80001d0c <map_region+0xb8>
    80001c58:	fc010113          	addi	sp,sp,-64
    80001c5c:	02813823          	sd	s0,48(sp)
    80001c60:	02913423          	sd	s1,40(sp)
    80001c64:	03213023          	sd	s2,32(sp)
    80001c68:	01313c23          	sd	s3,24(sp)
    80001c6c:	01413823          	sd	s4,16(sp)
    80001c70:	01513423          	sd	s5,8(sp)
    80001c74:	01613023          	sd	s6,0(sp)
    80001c78:	02113c23          	sd	ra,56(sp)
    80001c7c:	00068493          	mv	s1,a3
    80001c80:	00050913          	mv	s2,a0
    80001c84:	00058993          	mv	s3,a1
    80001c88:	00060a13          	mv	s4,a2
    80001c8c:	00000b13          	li	s6,0
    80001c90:	0ff77413          	andi	s0,a4,255
    80001c94:	00001ab7          	lui	s5,0x1
    80001c98:	016985b3          	add	a1,s3,s6
    80001c9c:	00100613          	li	a2,1
    80001ca0:	00090513          	mv	a0,s2
    80001ca4:	e7cff0ef          	jal	ra,80001320 <walk_inner>
    80001ca8:	016a07b3          	add	a5,s4,s6
    80001cac:	00c7d793          	srli	a5,a5,0xc
    80001cb0:	00a79793          	slli	a5,a5,0xa
    80001cb4:	0087e7b3          	or	a5,a5,s0
    80001cb8:	0c17e793          	ori	a5,a5,193
    80001cbc:	015b0b33          	add	s6,s6,s5
    80001cc0:	04050263          	beqz	a0,80001d04 <map_region+0xb0>
    80001cc4:	00053703          	ld	a4,0(a0)
    80001cc8:	00177713          	andi	a4,a4,1
    80001ccc:	02071c63          	bnez	a4,80001d04 <map_region+0xb0>
    80001cd0:	00f53023          	sd	a5,0(a0)
    80001cd4:	fc9b62e3          	bltu	s6,s1,80001c98 <map_region+0x44>
    80001cd8:	00000513          	li	a0,0
    80001cdc:	03813083          	ld	ra,56(sp)
    80001ce0:	03013403          	ld	s0,48(sp)
    80001ce4:	02813483          	ld	s1,40(sp)
    80001ce8:	02013903          	ld	s2,32(sp)
    80001cec:	01813983          	ld	s3,24(sp)
    80001cf0:	01013a03          	ld	s4,16(sp)
    80001cf4:	00813a83          	ld	s5,8(sp)
    80001cf8:	00013b03          	ld	s6,0(sp)
    80001cfc:	04010113          	addi	sp,sp,64
    80001d00:	00008067          	ret
    80001d04:	fff00513          	li	a0,-1
    80001d08:	fd5ff06f          	j	80001cdc <map_region+0x88>
    80001d0c:	00000513          	li	a0,0
    80001d10:	00008067          	ret

0000000080001d14 <kvminit>:
    80001d14:	ff010113          	addi	sp,sp,-16
    80001d18:	00113423          	sd	ra,8(sp)
    80001d1c:	00813023          	sd	s0,0(sp)
    80001d20:	a40ff0ef          	jal	ra,80000f60 <alloc_page>
    80001d24:	08050e63          	beqz	a0,80001dc0 <kvminit+0xac>
    80001d28:	00001737          	lui	a4,0x1
    80001d2c:	00e50733          	add	a4,a0,a4
    80001d30:	00050793          	mv	a5,a0
    80001d34:	00078023          	sb	zero,0(a5)
    80001d38:	00178793          	addi	a5,a5,1
    80001d3c:	fef71ce3          	bne	a4,a5,80001d34 <kvminit+0x20>
    80001d40:	00100613          	li	a2,1
    80001d44:	01f61613          	slli	a2,a2,0x1f
    80001d48:	800006b7          	lui	a3,0x80000
    80001d4c:	00008797          	auipc	a5,0x8
    80001d50:	2ec7b783          	ld	a5,748(a5) # 8000a038 <pmm_manager+0x28>
    80001d54:	00833417          	auipc	s0,0x833
    80001d58:	cac40413          	addi	s0,s0,-852 # 80834a00 <kernel_pagetable>
    80001d5c:	00e00713          	li	a4,14
    80001d60:	00f686b3          	add	a3,a3,a5
    80001d64:	00060593          	mv	a1,a2
    80001d68:	00a43023          	sd	a0,0(s0)
    80001d6c:	ee9ff0ef          	jal	ra,80001c54 <map_region>
    80001d70:	06051863          	bnez	a0,80001de0 <kvminit+0xcc>
    80001d74:	00043503          	ld	a0,0(s0)
    80001d78:	00600713          	li	a4,6
    80001d7c:	000016b7          	lui	a3,0x1
    80001d80:	10000637          	lui	a2,0x10000
    80001d84:	100005b7          	lui	a1,0x10000
    80001d88:	ecdff0ef          	jal	ra,80001c54 <map_region>
    80001d8c:	06051663          	bnez	a0,80001df8 <kvminit+0xe4>
    80001d90:	00043503          	ld	a0,0(s0)
    80001d94:	00a00713          	li	a4,10
    80001d98:	000016b7          	lui	a3,0x1
    80001d9c:	ffffe617          	auipc	a2,0xffffe
    80001da0:	3d460613          	addi	a2,a2,980 # 80000170 <trampoline>
    80001da4:	fffff5b7          	lui	a1,0xfffff
    80001da8:	eadff0ef          	jal	ra,80001c54 <map_region>
    80001dac:	06051263          	bnez	a0,80001e10 <kvminit+0xfc>
    80001db0:	00813083          	ld	ra,8(sp)
    80001db4:	00013403          	ld	s0,0(sp)
    80001db8:	01010113          	addi	sp,sp,16
    80001dbc:	00008067          	ret
    80001dc0:	00005517          	auipc	a0,0x5
    80001dc4:	28850513          	addi	a0,a0,648 # 80007048 <digits+0x150>
    80001dc8:	00833797          	auipc	a5,0x833
    80001dcc:	c207bc23          	sd	zero,-968(a5) # 80834a00 <kernel_pagetable>
    80001dd0:	00013403          	ld	s0,0(sp)
    80001dd4:	00813083          	ld	ra,8(sp)
    80001dd8:	01010113          	addi	sp,sp,16
    80001ddc:	ba9fe06f          	j	80000984 <printf>
    80001de0:	00013403          	ld	s0,0(sp)
    80001de4:	00813083          	ld	ra,8(sp)
    80001de8:	00005517          	auipc	a0,0x5
    80001dec:	29050513          	addi	a0,a0,656 # 80007078 <digits+0x180>
    80001df0:	01010113          	addi	sp,sp,16
    80001df4:	b91fe06f          	j	80000984 <printf>
    80001df8:	00013403          	ld	s0,0(sp)
    80001dfc:	00813083          	ld	ra,8(sp)
    80001e00:	00005517          	auipc	a0,0x5
    80001e04:	2a050513          	addi	a0,a0,672 # 800070a0 <digits+0x1a8>
    80001e08:	01010113          	addi	sp,sp,16
    80001e0c:	b79fe06f          	j	80000984 <printf>
    80001e10:	00005517          	auipc	a0,0x5
    80001e14:	2b050513          	addi	a0,a0,688 # 800070c0 <digits+0x1c8>
    80001e18:	fb9ff06f          	j	80001dd0 <kvminit+0xbc>

0000000080001e1c <kvminithart>:
    80001e1c:	00833797          	auipc	a5,0x833
    80001e20:	be47b783          	ld	a5,-1052(a5) # 80834a00 <kernel_pagetable>
    80001e24:	02078063          	beqz	a5,80001e44 <kvminithart+0x28>
    80001e28:	fff00713          	li	a4,-1
    80001e2c:	03f71713          	slli	a4,a4,0x3f
    80001e30:	00c7d793          	srli	a5,a5,0xc
    80001e34:	00e7e7b3          	or	a5,a5,a4
    80001e38:	18079073          	csrw	satp,a5
    80001e3c:	12000073          	sfence.vma
    80001e40:	00008067          	ret
    80001e44:	00005517          	auipc	a0,0x5
    80001e48:	2a450513          	addi	a0,a0,676 # 800070e8 <digits+0x1f0>
    80001e4c:	b39fe06f          	j	80000984 <printf>

0000000080001e50 <register_interrupt>:
    80001e50:	0ff00793          	li	a5,255
    80001e54:	04a7e663          	bltu	a5,a0,80001ea0 <register_interrupt+0x50>
    80001e58:	04058463          	beqz	a1,80001ea0 <register_interrupt+0x50>
    80001e5c:	00351793          	slli	a5,a0,0x3
    80001e60:	00009697          	auipc	a3,0x9
    80001e64:	de068693          	addi	a3,a3,-544 # 8000ac40 <handler_table>
    80001e68:	00008717          	auipc	a4,0x8
    80001e6c:	5d870713          	addi	a4,a4,1496 # 8000a440 <arg_table>
    80001e70:	00f686b3          	add	a3,a3,a5
    80001e74:	00f70733          	add	a4,a4,a5
    80001e78:	00251513          	slli	a0,a0,0x2
    80001e7c:	00008797          	auipc	a5,0x8
    80001e80:	1c478793          	addi	a5,a5,452 # 8000a040 <enabled_table>
    80001e84:	00a78533          	add	a0,a5,a0
    80001e88:	00100793          	li	a5,1
    80001e8c:	00f52023          	sw	a5,0(a0)
    80001e90:	00b6b023          	sd	a1,0(a3)
    80001e94:	00c73023          	sd	a2,0(a4)
    80001e98:	00000513          	li	a0,0
    80001e9c:	00008067          	ret
    80001ea0:	fff00513          	li	a0,-1
    80001ea4:	00008067          	ret

0000000080001ea8 <unregister_interrupt>:
    80001ea8:	0ff00793          	li	a5,255
    80001eac:	04a7e263          	bltu	a5,a0,80001ef0 <unregister_interrupt+0x48>
    80001eb0:	00351793          	slli	a5,a0,0x3
    80001eb4:	00009697          	auipc	a3,0x9
    80001eb8:	d8c68693          	addi	a3,a3,-628 # 8000ac40 <handler_table>
    80001ebc:	00008717          	auipc	a4,0x8
    80001ec0:	58470713          	addi	a4,a4,1412 # 8000a440 <arg_table>
    80001ec4:	00f686b3          	add	a3,a3,a5
    80001ec8:	00f70733          	add	a4,a4,a5
    80001ecc:	00251513          	slli	a0,a0,0x2
    80001ed0:	00008797          	auipc	a5,0x8
    80001ed4:	17078793          	addi	a5,a5,368 # 8000a040 <enabled_table>
    80001ed8:	00a78533          	add	a0,a5,a0
    80001edc:	00052023          	sw	zero,0(a0)
    80001ee0:	0006b023          	sd	zero,0(a3)
    80001ee4:	00073023          	sd	zero,0(a4)
    80001ee8:	00000513          	li	a0,0
    80001eec:	00008067          	ret
    80001ef0:	fff00513          	li	a0,-1
    80001ef4:	00008067          	ret

0000000080001ef8 <enable_interrupt>:
    80001ef8:	0ff00793          	li	a5,255
    80001efc:	00a7ee63          	bltu	a5,a0,80001f18 <enable_interrupt+0x20>
    80001f00:	00008797          	auipc	a5,0x8
    80001f04:	14078793          	addi	a5,a5,320 # 8000a040 <enabled_table>
    80001f08:	00251513          	slli	a0,a0,0x2
    80001f0c:	00a78533          	add	a0,a5,a0
    80001f10:	00100793          	li	a5,1
    80001f14:	00f52023          	sw	a5,0(a0)
    80001f18:	00008067          	ret

0000000080001f1c <disable_interrupt>:
    80001f1c:	0ff00793          	li	a5,255
    80001f20:	00a7ec63          	bltu	a5,a0,80001f38 <disable_interrupt+0x1c>
    80001f24:	00251513          	slli	a0,a0,0x2
    80001f28:	00008797          	auipc	a5,0x8
    80001f2c:	11878793          	addi	a5,a5,280 # 8000a040 <enabled_table>
    80001f30:	00a78533          	add	a0,a5,a0
    80001f34:	00052023          	sw	zero,0(a0)
    80001f38:	00008067          	ret

0000000080001f3c <handle_irq>:
    80001f3c:	0ff00793          	li	a5,255
    80001f40:	04a7e463          	bltu	a5,a0,80001f88 <handle_irq+0x4c>
    80001f44:	00251713          	slli	a4,a0,0x2
    80001f48:	00008797          	auipc	a5,0x8
    80001f4c:	0f878793          	addi	a5,a5,248 # 8000a040 <enabled_table>
    80001f50:	00e787b3          	add	a5,a5,a4
    80001f54:	0007a783          	lw	a5,0(a5)
    80001f58:	02078863          	beqz	a5,80001f88 <handle_irq+0x4c>
    80001f5c:	00351513          	slli	a0,a0,0x3
    80001f60:	00009797          	auipc	a5,0x9
    80001f64:	ce078793          	addi	a5,a5,-800 # 8000ac40 <handler_table>
    80001f68:	00a787b3          	add	a5,a5,a0
    80001f6c:	0007b703          	ld	a4,0(a5)
    80001f70:	00070c63          	beqz	a4,80001f88 <handle_irq+0x4c>
    80001f74:	00008797          	auipc	a5,0x8
    80001f78:	4cc78793          	addi	a5,a5,1228 # 8000a440 <arg_table>
    80001f7c:	00a78533          	add	a0,a5,a0
    80001f80:	00053503          	ld	a0,0(a0)
    80001f84:	00070067          	jr	a4
    80001f88:	00008067          	ret

0000000080001f8c <clockintr>:
    80001f8c:	00833717          	auipc	a4,0x833
    80001f90:	a7c70713          	addi	a4,a4,-1412 # 80834a08 <ticks>
    80001f94:	00073783          	ld	a5,0(a4)
    80001f98:	ff010113          	addi	sp,sp,-16
    80001f9c:	00113423          	sd	ra,8(sp)
    80001fa0:	00178793          	addi	a5,a5,1
    80001fa4:	00000513          	li	a0,0
    80001fa8:	00f73023          	sd	a5,0(a4)
    80001fac:	470000ef          	jal	ra,8000241c <timer_interrupt>
    80001fb0:	498000ef          	jal	ra,80002448 <timer_schedule_next_tick>
    80001fb4:	00833797          	auipc	a5,0x833
    80001fb8:	a6c7b783          	ld	a5,-1428(a5) # 80834a20 <current>
    80001fbc:	00078863          	beqz	a5,80001fcc <clockintr+0x40>
    80001fc0:	0047a683          	lw	a3,4(a5)
    80001fc4:	00300713          	li	a4,3
    80001fc8:	00e68863          	beq	a3,a4,80001fd8 <clockintr+0x4c>
    80001fcc:	00813083          	ld	ra,8(sp)
    80001fd0:	01010113          	addi	sp,sp,16
    80001fd4:	00008067          	ret
    80001fd8:	0907a703          	lw	a4,144(a5)
    80001fdc:	00e05663          	blez	a4,80001fe8 <clockintr+0x5c>
    80001fe0:	fff7071b          	addiw	a4,a4,-1
    80001fe4:	08e7a823          	sw	a4,144(a5)
    80001fe8:	fe0712e3          	bnez	a4,80001fcc <clockintr+0x40>
    80001fec:	00813083          	ld	ra,8(sp)
    80001ff0:	00100713          	li	a4,1
    80001ff4:	08e7aa23          	sw	a4,148(a5)
    80001ff8:	01010113          	addi	sp,sp,16
    80001ffc:	00008067          	ret

0000000080002000 <devintr>:
    80002000:	ff010113          	addi	sp,sp,-16
    80002004:	00113423          	sd	ra,8(sp)
    80002008:	00813023          	sd	s0,0(sp)
    8000200c:	142027f3          	csrr	a5,scause
    80002010:	00000413          	li	s0,0
    80002014:	0007cc63          	bltz	a5,8000202c <devintr+0x2c>
    80002018:	00813083          	ld	ra,8(sp)
    8000201c:	00040513          	mv	a0,s0
    80002020:	00013403          	ld	s0,0(sp)
    80002024:	01010113          	addi	sp,sp,16
    80002028:	00008067          	ret
    8000202c:	0ff7f693          	andi	a3,a5,255
    80002030:	00369613          	slli	a2,a3,0x3
    80002034:	00009717          	auipc	a4,0x9
    80002038:	c0c70713          	addi	a4,a4,-1012 # 8000ac40 <handler_table>
    8000203c:	00c70733          	add	a4,a4,a2
    80002040:	00073703          	ld	a4,0(a4)
    80002044:	0ff7f793          	andi	a5,a5,255
    80002048:	02071863          	bnez	a4,80002078 <devintr+0x78>
    8000204c:	00500713          	li	a4,5
    80002050:	04e78e63          	beq	a5,a4,800020ac <devintr+0xac>
    80002054:	ff778413          	addi	s0,a5,-9
    80002058:	00100713          	li	a4,1
    8000205c:	00143413          	seqz	s0,s0
    80002060:	fae79ce3          	bne	a5,a4,80002018 <devintr+0x18>
    80002064:	144027f3          	csrr	a5,sip
    80002068:	ffd7f793          	andi	a5,a5,-3
    8000206c:	14479073          	csrw	sip,a5
    80002070:	00100413          	li	s0,1
    80002074:	fa5ff06f          	j	80002018 <devintr+0x18>
    80002078:	00008797          	auipc	a5,0x8
    8000207c:	fc878793          	addi	a5,a5,-56 # 8000a040 <enabled_table>
    80002080:	00269693          	slli	a3,a3,0x2
    80002084:	00d786b3          	add	a3,a5,a3
    80002088:	0006a783          	lw	a5,0(a3)
    8000208c:	00200413          	li	s0,2
    80002090:	f80784e3          	beqz	a5,80002018 <devintr+0x18>
    80002094:	00008797          	auipc	a5,0x8
    80002098:	3ac78793          	addi	a5,a5,940 # 8000a440 <arg_table>
    8000209c:	00c78633          	add	a2,a5,a2
    800020a0:	00063503          	ld	a0,0(a2)
    800020a4:	000700e7          	jalr	a4
    800020a8:	f71ff06f          	j	80002018 <devintr+0x18>
    800020ac:	ee1ff0ef          	jal	ra,80001f8c <clockintr>
    800020b0:	00200413          	li	s0,2
    800020b4:	f65ff06f          	j	80002018 <devintr+0x18>

00000000800020b8 <trap_init>:
    800020b8:	00009797          	auipc	a5,0x9
    800020bc:	b8878793          	addi	a5,a5,-1144 # 8000ac40 <handler_table>
    800020c0:	00008697          	auipc	a3,0x8
    800020c4:	38068693          	addi	a3,a3,896 # 8000a440 <arg_table>
    800020c8:	00008717          	auipc	a4,0x8
    800020cc:	f7870713          	addi	a4,a4,-136 # 8000a040 <enabled_table>
    800020d0:	00009617          	auipc	a2,0x9
    800020d4:	37060613          	addi	a2,a2,880 # 8000b440 <proc_lock>
    800020d8:	0007b023          	sd	zero,0(a5)
    800020dc:	0006b023          	sd	zero,0(a3)
    800020e0:	00072023          	sw	zero,0(a4)
    800020e4:	00878793          	addi	a5,a5,8
    800020e8:	00868693          	addi	a3,a3,8
    800020ec:	00470713          	addi	a4,a4,4
    800020f0:	fec794e3          	bne	a5,a2,800020d8 <trap_init+0x20>
    800020f4:	ffffe797          	auipc	a5,0xffffe
    800020f8:	f5c78793          	addi	a5,a5,-164 # 80000050 <kernelvec>
    800020fc:	10579073          	csrw	stvec,a5
    80002100:	100027f3          	csrr	a5,sstatus
    80002104:	0027e793          	ori	a5,a5,2
    80002108:	10079073          	csrw	sstatus,a5
    8000210c:	104027f3          	csrr	a5,sie
    80002110:	0227e793          	ori	a5,a5,34
    80002114:	10479073          	csrw	sie,a5
    80002118:	00008067          	ret

000000008000211c <usertrapret>:
    8000211c:	ff010113          	addi	sp,sp,-16
    80002120:	00813023          	sd	s0,0(sp)
    80002124:	00113423          	sd	ra,8(sp)
    80002128:	00833417          	auipc	s0,0x833
    8000212c:	8f843403          	ld	s0,-1800(s0) # 80834a20 <current>
    80002130:	08040c63          	beqz	s0,800021c8 <usertrapret+0xac>
    80002134:	100027f3          	csrr	a5,sstatus
    80002138:	ffd7f793          	andi	a5,a5,-3
    8000213c:	10079073          	csrw	sstatus,a5
    80002140:	ffffe697          	auipc	a3,0xffffe
    80002144:	03068693          	addi	a3,a3,48 # 80000170 <trampoline>
    80002148:	ffffd717          	auipc	a4,0xffffd
    8000214c:	02870713          	addi	a4,a4,40 # 7ffff170 <_binary_user_test_basic_bin_size+0x7fffea2f>
    80002150:	40d70733          	sub	a4,a4,a3
    80002154:	10571073          	csrw	stvec,a4
    80002158:	0c843783          	ld	a5,200(s0)
    8000215c:	18002673          	csrr	a2,satp
    80002160:	01843703          	ld	a4,24(s0)
    80002164:	00c7b023          	sd	a2,0(a5)
    80002168:	00e7b423          	sd	a4,8(a5)
    8000216c:	00000717          	auipc	a4,0x0
    80002170:	06c70713          	addi	a4,a4,108 # 800021d8 <usertrap>
    80002174:	00e7b823          	sd	a4,16(a5)
    80002178:	00020713          	mv	a4,tp
    8000217c:	02e7b023          	sd	a4,32(a5)
    80002180:	10002773          	csrr	a4,sstatus
    80002184:	eff77713          	andi	a4,a4,-257
    80002188:	02076713          	ori	a4,a4,32
    8000218c:	10071073          	csrw	sstatus,a4
    80002190:	0187b783          	ld	a5,24(a5)
    80002194:	14179073          	csrw	sepc,a5
    80002198:	0d043503          	ld	a0,208(s0)
    8000219c:	00013403          	ld	s0,0(sp)
    800021a0:	00813083          	ld	ra,8(sp)
    800021a4:	fff00713          	li	a4,-1
    800021a8:	00c55513          	srli	a0,a0,0xc
    800021ac:	ffffd797          	auipc	a5,0xffffd
    800021b0:	06c78793          	addi	a5,a5,108 # 7ffff218 <_binary_user_test_basic_bin_size+0x7fffead7>
    800021b4:	03f71713          	slli	a4,a4,0x3f
    800021b8:	40d787b3          	sub	a5,a5,a3
    800021bc:	00e56533          	or	a0,a0,a4
    800021c0:	01010113          	addi	sp,sp,16
    800021c4:	00078067          	jr	a5
    800021c8:	00005517          	auipc	a0,0x5
    800021cc:	f5050513          	addi	a0,a0,-176 # 80007118 <digits+0x220>
    800021d0:	acdfe0ef          	jal	ra,80000c9c <panic>
    800021d4:	f61ff06f          	j	80002134 <usertrapret+0x18>

00000000800021d8 <usertrap>:
    800021d8:	fe010113          	addi	sp,sp,-32
    800021dc:	00113c23          	sd	ra,24(sp)
    800021e0:	00813823          	sd	s0,16(sp)
    800021e4:	00913423          	sd	s1,8(sp)
    800021e8:	100027f3          	csrr	a5,sstatus
    800021ec:	1007f793          	andi	a5,a5,256
    800021f0:	0a079463          	bnez	a5,80002298 <usertrap+0xc0>
    800021f4:	ffffe797          	auipc	a5,0xffffe
    800021f8:	e5c78793          	addi	a5,a5,-420 # 80000050 <kernelvec>
    800021fc:	10579073          	csrw	stvec,a5
    80002200:	00833417          	auipc	s0,0x833
    80002204:	82043403          	ld	s0,-2016(s0) # 80834a20 <current>
    80002208:	0a040a63          	beqz	s0,800022bc <usertrap+0xe4>
    8000220c:	0c843703          	ld	a4,200(s0)
    80002210:	141027f3          	csrr	a5,sepc
    80002214:	00f73c23          	sd	a5,24(a4)
    80002218:	142024f3          	csrr	s1,scause
    8000221c:	00800693          	li	a3,8
    80002220:	0cd48063          	beq	s1,a3,800022e0 <usertrap+0x108>
    80002224:	0404c663          	bltz	s1,80002270 <usertrap+0x98>
    80002228:	00042603          	lw	a2,0(s0)
    8000222c:	00048593          	mv	a1,s1
    80002230:	00005517          	auipc	a0,0x5
    80002234:	f4050513          	addi	a0,a0,-192 # 80007170 <digits+0x278>
    80002238:	f4cfe0ef          	jal	ra,80000984 <printf>
    8000223c:	14302673          	csrr	a2,stval
    80002240:	0c843783          	ld	a5,200(s0)
    80002244:	00005517          	auipc	a0,0x5
    80002248:	f5450513          	addi	a0,a0,-172 # 80007198 <digits+0x2a0>
    8000224c:	0187b583          	ld	a1,24(a5)
    80002250:	f34fe0ef          	jal	ra,80000984 <printf>
    80002254:	fff00513          	li	a0,-1
    80002258:	5e5000ef          	jal	ra,8000303c <exit_process>
    8000225c:	01013403          	ld	s0,16(sp)
    80002260:	01813083          	ld	ra,24(sp)
    80002264:	00813483          	ld	s1,8(sp)
    80002268:	02010113          	addi	sp,sp,32
    8000226c:	eb1ff06f          	j	8000211c <usertrapret>
    80002270:	d91ff0ef          	jal	ra,80002000 <devintr>
    80002274:	fa050ae3          	beqz	a0,80002228 <usertrap+0x50>
    80002278:	00200793          	li	a5,2
    8000227c:	fef510e3          	bne	a0,a5,8000225c <usertrap+0x84>
    80002280:	329000ef          	jal	ra,80002da8 <yield>
    80002284:	01013403          	ld	s0,16(sp)
    80002288:	01813083          	ld	ra,24(sp)
    8000228c:	00813483          	ld	s1,8(sp)
    80002290:	02010113          	addi	sp,sp,32
    80002294:	e89ff06f          	j	8000211c <usertrapret>
    80002298:	00005517          	auipc	a0,0x5
    8000229c:	e9850513          	addi	a0,a0,-360 # 80007130 <digits+0x238>
    800022a0:	9fdfe0ef          	jal	ra,80000c9c <panic>
    800022a4:	ffffe797          	auipc	a5,0xffffe
    800022a8:	dac78793          	addi	a5,a5,-596 # 80000050 <kernelvec>
    800022ac:	10579073          	csrw	stvec,a5
    800022b0:	00832417          	auipc	s0,0x832
    800022b4:	77043403          	ld	s0,1904(s0) # 80834a20 <current>
    800022b8:	f4041ae3          	bnez	s0,8000220c <usertrap+0x34>
    800022bc:	00005517          	auipc	a0,0x5
    800022c0:	e9450513          	addi	a0,a0,-364 # 80007150 <digits+0x258>
    800022c4:	9d9fe0ef          	jal	ra,80000c9c <panic>
    800022c8:	0c843703          	ld	a4,200(s0)
    800022cc:	141027f3          	csrr	a5,sepc
    800022d0:	00f73c23          	sd	a5,24(a4)
    800022d4:	142024f3          	csrr	s1,scause
    800022d8:	00800693          	li	a3,8
    800022dc:	f4d494e3          	bne	s1,a3,80002224 <usertrap+0x4c>
    800022e0:	00478793          	addi	a5,a5,4
    800022e4:	00f73c23          	sd	a5,24(a4)
    800022e8:	100027f3          	csrr	a5,sstatus
    800022ec:	0027e793          	ori	a5,a5,2
    800022f0:	10079073          	csrw	sstatus,a5
    800022f4:	14d010ef          	jal	ra,80003c40 <syscall_dispatch>
    800022f8:	01013403          	ld	s0,16(sp)
    800022fc:	01813083          	ld	ra,24(sp)
    80002300:	00813483          	ld	s1,8(sp)
    80002304:	02010113          	addi	sp,sp,32
    80002308:	e15ff06f          	j	8000211c <usertrapret>

000000008000230c <kerneltrap>:
    8000230c:	fe010113          	addi	sp,sp,-32
    80002310:	00113c23          	sd	ra,24(sp)
    80002314:	00813823          	sd	s0,16(sp)
    80002318:	00913423          	sd	s1,8(sp)
    8000231c:	01213023          	sd	s2,0(sp)
    80002320:	141024f3          	csrr	s1,sepc
    80002324:	10002473          	csrr	s0,sstatus
    80002328:	14202973          	csrr	s2,scause
    8000232c:	10047793          	andi	a5,s0,256
    80002330:	0a078c63          	beqz	a5,800023e8 <kerneltrap+0xdc>
    80002334:	100027f3          	csrr	a5,sstatus
    80002338:	0027f793          	andi	a5,a5,2
    8000233c:	08079e63          	bnez	a5,800023d8 <kerneltrap+0xcc>
    80002340:	cc1ff0ef          	jal	ra,80002000 <devintr>
    80002344:	04050263          	beqz	a0,80002388 <kerneltrap+0x7c>
    80002348:	00200793          	li	a5,2
    8000234c:	00f51e63          	bne	a0,a5,80002368 <kerneltrap+0x5c>
    80002350:	00832797          	auipc	a5,0x832
    80002354:	6d07b783          	ld	a5,1744(a5) # 80834a20 <current>
    80002358:	00078863          	beqz	a5,80002368 <kerneltrap+0x5c>
    8000235c:	0047a703          	lw	a4,4(a5)
    80002360:	00300793          	li	a5,3
    80002364:	08f70a63          	beq	a4,a5,800023f8 <kerneltrap+0xec>
    80002368:	14149073          	csrw	sepc,s1
    8000236c:	10041073          	csrw	sstatus,s0
    80002370:	01813083          	ld	ra,24(sp)
    80002374:	01013403          	ld	s0,16(sp)
    80002378:	00813483          	ld	s1,8(sp)
    8000237c:	00013903          	ld	s2,0(sp)
    80002380:	02010113          	addi	sp,sp,32
    80002384:	00008067          	ret
    80002388:	00090593          	mv	a1,s2
    8000238c:	00005517          	auipc	a0,0x5
    80002390:	e6c50513          	addi	a0,a0,-404 # 800071f8 <digits+0x300>
    80002394:	df0fe0ef          	jal	ra,80000984 <printf>
    80002398:	14302673          	csrr	a2,stval
    8000239c:	00005517          	auipc	a0,0x5
    800023a0:	dfc50513          	addi	a0,a0,-516 # 80007198 <digits+0x2a0>
    800023a4:	00048593          	mv	a1,s1
    800023a8:	ddcfe0ef          	jal	ra,80000984 <printf>
    800023ac:	00005517          	auipc	a0,0x5
    800023b0:	e7450513          	addi	a0,a0,-396 # 80007220 <digits+0x328>
    800023b4:	8e9fe0ef          	jal	ra,80000c9c <panic>
    800023b8:	14149073          	csrw	sepc,s1
    800023bc:	10041073          	csrw	sstatus,s0
    800023c0:	01813083          	ld	ra,24(sp)
    800023c4:	01013403          	ld	s0,16(sp)
    800023c8:	00813483          	ld	s1,8(sp)
    800023cc:	00013903          	ld	s2,0(sp)
    800023d0:	02010113          	addi	sp,sp,32
    800023d4:	00008067          	ret
    800023d8:	00005517          	auipc	a0,0x5
    800023dc:	e0050513          	addi	a0,a0,-512 # 800071d8 <digits+0x2e0>
    800023e0:	8bdfe0ef          	jal	ra,80000c9c <panic>
    800023e4:	f5dff06f          	j	80002340 <kerneltrap+0x34>
    800023e8:	00005517          	auipc	a0,0x5
    800023ec:	dd050513          	addi	a0,a0,-560 # 800071b8 <digits+0x2c0>
    800023f0:	8adfe0ef          	jal	ra,80000c9c <panic>
    800023f4:	f41ff06f          	j	80002334 <kerneltrap+0x28>
    800023f8:	1b1000ef          	jal	ra,80002da8 <yield>
    800023fc:	f6dff06f          	j	80002368 <kerneltrap+0x5c>

0000000080002400 <sbi_set_timer>:
    80002400:	544958b7          	lui	a7,0x54495
    80002404:	d4588893          	addi	a7,a7,-699 # 54494d45 <_binary_user_test_basic_bin_size+0x54494604>
    80002408:	00000813          	li	a6,0
    8000240c:	00000073          	ecall
    80002410:	00008067          	ret

0000000080002414 <get_time>:
    80002414:	c0102573          	rdtime	a0
    80002418:	00008067          	ret

000000008000241c <timer_interrupt>:
    8000241c:	00832717          	auipc	a4,0x832
    80002420:	5fc70713          	addi	a4,a4,1532 # 80834a18 <sys_ticks>
    80002424:	00073783          	ld	a5,0(a4)
    80002428:	00178793          	addi	a5,a5,1
    8000242c:	00f73023          	sd	a5,0(a4)
    80002430:	00832797          	auipc	a5,0x832
    80002434:	5e07a783          	lw	a5,1504(a5) # 80834a10 <timer_interrupt_count>
    80002438:	0017879b          	addiw	a5,a5,1
    8000243c:	00832717          	auipc	a4,0x832
    80002440:	5cf72a23          	sw	a5,1492(a4) # 80834a10 <timer_interrupt_count>
    80002444:	00008067          	ret

0000000080002448 <timer_schedule_next_tick>:
    80002448:	ff010113          	addi	sp,sp,-16
    8000244c:	00113423          	sd	ra,8(sp)
    80002450:	fc5ff0ef          	jal	ra,80002414 <get_time>
    80002454:	000f47b7          	lui	a5,0xf4
    80002458:	24078793          	addi	a5,a5,576 # f4240 <_binary_user_test_basic_bin_size+0xf3aff>
    8000245c:	00f50533          	add	a0,a0,a5
    80002460:	14d51073          	csrw	0x14d,a0
    80002464:	00813083          	ld	ra,8(sp)
    80002468:	01010113          	addi	sp,sp,16
    8000246c:	00008067          	ret

0000000080002470 <timer_init>:
    80002470:	ff010113          	addi	sp,sp,-16
    80002474:	00113423          	sd	ra,8(sp)
    80002478:	f9dff0ef          	jal	ra,80002414 <get_time>
    8000247c:	000f45b7          	lui	a1,0xf4
    80002480:	24058593          	addi	a1,a1,576 # f4240 <_binary_user_test_basic_bin_size+0xf3aff>
    80002484:	00b505b3          	add	a1,a0,a1
    80002488:	14d59073          	csrw	0x14d,a1
    8000248c:	00813083          	ld	ra,8(sp)
    80002490:	00005517          	auipc	a0,0x5
    80002494:	da050513          	addi	a0,a0,-608 # 80007230 <digits+0x338>
    80002498:	01010113          	addi	sp,sp,16
    8000249c:	ce8fe06f          	j	80000984 <printf>

00000000800024a0 <get_sys_ticks>:
    800024a0:	00832517          	auipc	a0,0x832
    800024a4:	57853503          	ld	a0,1400(a0) # 80834a18 <sys_ticks>
    800024a8:	00008067          	ret

00000000800024ac <timer_debug_print>:
    800024ac:	00832597          	auipc	a1,0x832
    800024b0:	56c5b583          	ld	a1,1388(a1) # 80834a18 <sys_ticks>
    800024b4:	00005517          	auipc	a0,0x5
    800024b8:	da450513          	addi	a0,a0,-604 # 80007258 <digits+0x360>
    800024bc:	00832617          	auipc	a2,0x832
    800024c0:	55462603          	lw	a2,1364(a2) # 80834a10 <timer_interrupt_count>
    800024c4:	cc0fe06f          	j	80000984 <printf>

00000000800024c8 <proc_entry_wrapper>:
    800024c8:	00050067          	jr	a0

00000000800024cc <proc_init>:
    800024cc:	00009717          	auipc	a4,0x9
    800024d0:	01c70713          	addi	a4,a4,28 # 8000b4e8 <proc_table+0x18>
    800024d4:	00009697          	auipc	a3,0x9
    800024d8:	15c68693          	addi	a3,a3,348 # 8000b630 <proc_table+0x160>
    800024dc:	0000f617          	auipc	a2,0xf
    800024e0:	80c60613          	addi	a2,a2,-2036 # 80010ce8 <bcache+0x18>
    800024e4:	fe072423          	sw	zero,-24(a4)
    800024e8:	fe072623          	sw	zero,-20(a4)
    800024ec:	00073023          	sd	zero,0(a4)
    800024f0:	06072c23          	sw	zero,120(a4)
    800024f4:	06072e23          	sw	zero,124(a4)
    800024f8:	0a073823          	sd	zero,176(a4)
    800024fc:	0a073c23          	sd	zero,184(a4)
    80002500:	08072423          	sw	zero,136(a4)
    80002504:	08073823          	sd	zero,144(a4)
    80002508:	08073c23          	sd	zero,152(a4)
    8000250c:	0a073023          	sd	zero,160(a4)
    80002510:	0a072423          	sw	zero,168(a4)
    80002514:	0a072623          	sw	zero,172(a4)
    80002518:	0c073023          	sd	zero,192(a4)
    8000251c:	0c870793          	addi	a5,a4,200
    80002520:	0007b023          	sd	zero,0(a5)
    80002524:	00878793          	addi	a5,a5,8
    80002528:	fed79ce3          	bne	a5,a3,80002520 <proc_init+0x54>
    8000252c:	ff070793          	addi	a5,a4,-16
    80002530:	00078023          	sb	zero,0(a5)
    80002534:	00178793          	addi	a5,a5,1
    80002538:	fee79ce3          	bne	a5,a4,80002530 <proc_init+0x64>
    8000253c:	16078713          	addi	a4,a5,352
    80002540:	16068693          	addi	a3,a3,352
    80002544:	fac710e3          	bne	a4,a2,800024e4 <proc_init+0x18>
    80002548:	00005597          	auipc	a1,0x5
    8000254c:	d3858593          	addi	a1,a1,-712 # 80007280 <digits+0x388>
    80002550:	00009517          	auipc	a0,0x9
    80002554:	ef050513          	addi	a0,a0,-272 # 8000b440 <proc_lock>
    80002558:	0f80106f          	j	80003650 <initlock>

000000008000255c <alloc_process>:
    8000255c:	fd010113          	addi	sp,sp,-48
    80002560:	00009517          	auipc	a0,0x9
    80002564:	ee050513          	addi	a0,a0,-288 # 8000b440 <proc_lock>
    80002568:	02813023          	sd	s0,32(sp)
    8000256c:	02113423          	sd	ra,40(sp)
    80002570:	00913c23          	sd	s1,24(sp)
    80002574:	01213823          	sd	s2,16(sp)
    80002578:	01313423          	sd	s3,8(sp)
    8000257c:	0e0010ef          	jal	ra,8000365c <acquire>
    80002580:	00000413          	li	s0,0
    80002584:	00009797          	auipc	a5,0x9
    80002588:	f5078793          	addi	a5,a5,-176 # 8000b4d4 <proc_table+0x4>
    8000258c:	04000693          	li	a3,64
    80002590:	00c0006f          	j	8000259c <alloc_process+0x40>
    80002594:	0014041b          	addiw	s0,s0,1
    80002598:	0ed40c63          	beq	s0,a3,80002690 <alloc_process+0x134>
    8000259c:	0007a703          	lw	a4,0(a5)
    800025a0:	16078793          	addi	a5,a5,352
    800025a4:	fe0718e3          	bnez	a4,80002594 <alloc_process+0x38>
    800025a8:	16000713          	li	a4,352
    800025ac:	02e409b3          	mul	s3,s0,a4
    800025b0:	00008717          	auipc	a4,0x8
    800025b4:	a5070713          	addi	a4,a4,-1456 # 8000a000 <next_pid>
    800025b8:	00072783          	lw	a5,0(a4)
    800025bc:	00009917          	auipc	s2,0x9
    800025c0:	f1490913          	addi	s2,s2,-236 # 8000b4d0 <proc_table>
    800025c4:	00009517          	auipc	a0,0x9
    800025c8:	e7c50513          	addi	a0,a0,-388 # 8000b440 <proc_lock>
    800025cc:	0017869b          	addiw	a3,a5,1
    800025d0:	00d72023          	sw	a3,0(a4)
    800025d4:	00100713          	li	a4,1
    800025d8:	013904b3          	add	s1,s2,s3
    800025dc:	00e4a223          	sw	a4,4(s1) # 1004 <_binary_user_test_basic_bin_size+0x8c3>
    800025e0:	00f4a023          	sw	a5,0(s1)
    800025e4:	09c010ef          	jal	ra,80003680 <release>
    800025e8:	979fe0ef          	jal	ra,80000f60 <alloc_page>
    800025ec:	0c050a63          	beqz	a0,800026c0 <alloc_process+0x164>
    800025f0:	00832797          	auipc	a5,0x832
    800025f4:	41878793          	addi	a5,a5,1048 # 80834a08 <ticks>
    800025f8:	0007b683          	ld	a3,0(a5)
    800025fc:	0007b703          	ld	a4,0(a5)
    80002600:	000017b7          	lui	a5,0x1
    80002604:	00f50533          	add	a0,a0,a5
    80002608:	00200613          	li	a2,2
    8000260c:	0e098793          	addi	a5,s3,224 # 10e0 <_binary_user_test_basic_bin_size+0x99f>
    80002610:	0ae4b823          	sd	a4,176(s1)
    80002614:	00009717          	auipc	a4,0x9
    80002618:	01c70713          	addi	a4,a4,28 # 8000b630 <proc_table+0x160>
    8000261c:	00a4bc23          	sd	a0,24(s1)
    80002620:	0a04a023          	sw	zero,160(s1)
    80002624:	08c4b823          	sd	a2,144(s1)
    80002628:	0ad4b423          	sd	a3,168(s1)
    8000262c:	0a04bc23          	sd	zero,184(s1)
    80002630:	0c04b023          	sd	zero,192(s1)
    80002634:	0c04b423          	sd	zero,200(s1)
    80002638:	0c04b823          	sd	zero,208(s1)
    8000263c:	0c04bc23          	sd	zero,216(s1)
    80002640:	00f907b3          	add	a5,s2,a5
    80002644:	01370733          	add	a4,a4,s3
    80002648:	0007b023          	sd	zero,0(a5) # 1000 <_binary_user_test_basic_bin_size+0x8bf>
    8000264c:	00878793          	addi	a5,a5,8
    80002650:	fef71ce3          	bne	a4,a5,80002648 <alloc_process+0xec>
    80002654:	16000793          	li	a5,352
    80002658:	02f40433          	mul	s0,s0,a5
    8000265c:	00008797          	auipc	a5,0x8
    80002660:	9ac78793          	addi	a5,a5,-1620 # 8000a008 <cons_file>
    80002664:	00890433          	add	s0,s2,s0
    80002668:	0ef43423          	sd	a5,232(s0)
    8000266c:	0ef43823          	sd	a5,240(s0)
    80002670:	02813083          	ld	ra,40(sp)
    80002674:	02013403          	ld	s0,32(sp)
    80002678:	01013903          	ld	s2,16(sp)
    8000267c:	00813983          	ld	s3,8(sp)
    80002680:	00048513          	mv	a0,s1
    80002684:	01813483          	ld	s1,24(sp)
    80002688:	03010113          	addi	sp,sp,48
    8000268c:	00008067          	ret
    80002690:	00009517          	auipc	a0,0x9
    80002694:	db050513          	addi	a0,a0,-592 # 8000b440 <proc_lock>
    80002698:	7e9000ef          	jal	ra,80003680 <release>
    8000269c:	02813083          	ld	ra,40(sp)
    800026a0:	02013403          	ld	s0,32(sp)
    800026a4:	00000493          	li	s1,0
    800026a8:	01013903          	ld	s2,16(sp)
    800026ac:	00813983          	ld	s3,8(sp)
    800026b0:	00048513          	mv	a0,s1
    800026b4:	01813483          	ld	s1,24(sp)
    800026b8:	03010113          	addi	sp,sp,48
    800026bc:	00008067          	ret
    800026c0:	00009517          	auipc	a0,0x9
    800026c4:	d8050513          	addi	a0,a0,-640 # 8000b440 <proc_lock>
    800026c8:	795000ef          	jal	ra,8000365c <acquire>
    800026cc:	00009517          	auipc	a0,0x9
    800026d0:	d7450513          	addi	a0,a0,-652 # 8000b440 <proc_lock>
    800026d4:	0004a223          	sw	zero,4(s1)
    800026d8:	7a9000ef          	jal	ra,80003680 <release>
    800026dc:	00000493          	li	s1,0
    800026e0:	f91ff06f          	j	80002670 <alloc_process+0x114>

00000000800026e4 <free_process>:
    800026e4:	10050263          	beqz	a0,800027e8 <free_process+0x104>
    800026e8:	01853783          	ld	a5,24(a0)
    800026ec:	fe010113          	addi	sp,sp,-32
    800026f0:	00813823          	sd	s0,16(sp)
    800026f4:	00113c23          	sd	ra,24(sp)
    800026f8:	00050413          	mv	s0,a0
    800026fc:	0a079863          	bnez	a5,800027ac <free_process+0xc8>
    80002700:	0b843783          	ld	a5,184(s0)
    80002704:	00078a63          	beqz	a5,80002718 <free_process+0x34>
    80002708:	0c07a703          	lw	a4,192(a5)
    8000270c:	fff7069b          	addiw	a3,a4,-1
    80002710:	0606ce63          	bltz	a3,8000278c <free_process+0xa8>
    80002714:	0cd7a023          	sw	a3,192(a5)
    80002718:	0d043503          	ld	a0,208(s0)
    8000271c:	06051e63          	bnez	a0,80002798 <free_process+0xb4>
    80002720:	0c843503          	ld	a0,200(s0)
    80002724:	00050663          	beqz	a0,80002730 <free_process+0x4c>
    80002728:	8e9fe0ef          	jal	ra,80001010 <free_page>
    8000272c:	0c043423          	sd	zero,200(s0)
    80002730:	00043023          	sd	zero,0(s0)
    80002734:	08043823          	sd	zero,144(s0)
    80002738:	08043c23          	sd	zero,152(s0)
    8000273c:	0a042023          	sw	zero,160(s0)
    80002740:	0a043423          	sd	zero,168(s0)
    80002744:	0a043823          	sd	zero,176(s0)
    80002748:	0a043c23          	sd	zero,184(s0)
    8000274c:	0c043023          	sd	zero,192(s0)
    80002750:	0c043c23          	sd	zero,216(s0)
    80002754:	0e040793          	addi	a5,s0,224
    80002758:	16040713          	addi	a4,s0,352
    8000275c:	0007b023          	sd	zero,0(a5)
    80002760:	00878793          	addi	a5,a5,8
    80002764:	fef71ce3          	bne	a4,a5,8000275c <free_process+0x78>
    80002768:	00840793          	addi	a5,s0,8
    8000276c:	01840413          	addi	s0,s0,24
    80002770:	00078023          	sb	zero,0(a5)
    80002774:	00178793          	addi	a5,a5,1
    80002778:	fef41ce3          	bne	s0,a5,80002770 <free_process+0x8c>
    8000277c:	01813083          	ld	ra,24(sp)
    80002780:	01013403          	ld	s0,16(sp)
    80002784:	02010113          	addi	sp,sp,32
    80002788:	00008067          	ret
    8000278c:	0d043503          	ld	a0,208(s0)
    80002790:	0c07a023          	sw	zero,192(a5)
    80002794:	f80506e3          	beqz	a0,80002720 <free_process+0x3c>
    80002798:	0d843783          	ld	a5,216(s0)
    8000279c:	02079263          	bnez	a5,800027c0 <free_process+0xdc>
    800027a0:	918ff0ef          	jal	ra,800018b8 <free_user_pagetable>
    800027a4:	0c043823          	sd	zero,208(s0)
    800027a8:	f79ff06f          	j	80002720 <free_process+0x3c>
    800027ac:	fffff537          	lui	a0,0xfffff
    800027b0:	00a78533          	add	a0,a5,a0
    800027b4:	85dfe0ef          	jal	ra,80001010 <free_page>
    800027b8:	00043c23          	sd	zero,24(s0)
    800027bc:	f45ff06f          	j	80002700 <free_process+0x1c>
    800027c0:	00001737          	lui	a4,0x1
    800027c4:	fff70713          	addi	a4,a4,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    800027c8:	00e787b3          	add	a5,a5,a4
    800027cc:	fffff637          	lui	a2,0xfffff
    800027d0:	00c7f633          	and	a2,a5,a2
    800027d4:	00000593          	li	a1,0
    800027d8:	00a13423          	sd	a0,8(sp)
    800027dc:	ef1fe0ef          	jal	ra,800016cc <uvmunmap>
    800027e0:	00813503          	ld	a0,8(sp)
    800027e4:	fbdff06f          	j	800027a0 <free_process+0xbc>
    800027e8:	00008067          	ret

00000000800027ec <alloc_user_proc>:
    800027ec:	fe010113          	addi	sp,sp,-32
    800027f0:	00813823          	sd	s0,16(sp)
    800027f4:	00113c23          	sd	ra,24(sp)
    800027f8:	00913423          	sd	s1,8(sp)
    800027fc:	d61ff0ef          	jal	ra,8000255c <alloc_process>
    80002800:	00050413          	mv	s0,a0
    80002804:	02050663          	beqz	a0,80002830 <alloc_user_proc+0x44>
    80002808:	f58fe0ef          	jal	ra,80000f60 <alloc_page>
    8000280c:	0ca43423          	sd	a0,200(s0)
    80002810:	00050a63          	beqz	a0,80002824 <alloc_user_proc+0x38>
    80002814:	e75fe0ef          	jal	ra,80001688 <uvmcreate>
    80002818:	00050493          	mv	s1,a0
    8000281c:	02051663          	bnez	a0,80002848 <alloc_user_proc+0x5c>
    80002820:	0c043823          	sd	zero,208(s0)
    80002824:	00040513          	mv	a0,s0
    80002828:	ebdff0ef          	jal	ra,800026e4 <free_process>
    8000282c:	00000413          	li	s0,0
    80002830:	01813083          	ld	ra,24(sp)
    80002834:	00040513          	mv	a0,s0
    80002838:	01013403          	ld	s0,16(sp)
    8000283c:	00813483          	ld	s1,8(sp)
    80002840:	02010113          	addi	sp,sp,32
    80002844:	00008067          	ret
    80002848:	00a00693          	li	a3,10
    8000284c:	ffffe617          	auipc	a2,0xffffe
    80002850:	92460613          	addi	a2,a2,-1756 # 80000170 <trampoline>
    80002854:	fffff5b7          	lui	a1,0xfffff
    80002858:	db1fe0ef          	jal	ra,80001608 <map_page>
    8000285c:	08051063          	bnez	a0,800028dc <alloc_user_proc+0xf0>
    80002860:	0c843603          	ld	a2,200(s0)
    80002864:	00060c63          	beqz	a2,8000287c <alloc_user_proc+0x90>
    80002868:	00600693          	li	a3,6
    8000286c:	ffffe5b7          	lui	a1,0xffffe
    80002870:	00048513          	mv	a0,s1
    80002874:	d95fe0ef          	jal	ra,80001608 <map_page>
    80002878:	06051263          	bnez	a0,800028dc <alloc_user_proc+0xf0>
    8000287c:	01843783          	ld	a5,24(s0)
    80002880:	00000717          	auipc	a4,0x0
    80002884:	89c70713          	addi	a4,a4,-1892 # 8000211c <usertrapret>
    80002888:	0c943823          	sd	s1,208(s0)
    8000288c:	01813083          	ld	ra,24(sp)
    80002890:	02e43023          	sd	a4,32(s0)
    80002894:	02f43423          	sd	a5,40(s0)
    80002898:	04043c23          	sd	zero,88(s0)
    8000289c:	04043823          	sd	zero,80(s0)
    800028a0:	04043423          	sd	zero,72(s0)
    800028a4:	04043023          	sd	zero,64(s0)
    800028a8:	02043c23          	sd	zero,56(s0)
    800028ac:	02043823          	sd	zero,48(s0)
    800028b0:	08043423          	sd	zero,136(s0)
    800028b4:	08043023          	sd	zero,128(s0)
    800028b8:	06043c23          	sd	zero,120(s0)
    800028bc:	06043823          	sd	zero,112(s0)
    800028c0:	06043423          	sd	zero,104(s0)
    800028c4:	06043023          	sd	zero,96(s0)
    800028c8:	00040513          	mv	a0,s0
    800028cc:	01013403          	ld	s0,16(sp)
    800028d0:	00813483          	ld	s1,8(sp)
    800028d4:	02010113          	addi	sp,sp,32
    800028d8:	00008067          	ret
    800028dc:	00048513          	mv	a0,s1
    800028e0:	fd9fe0ef          	jal	ra,800018b8 <free_user_pagetable>
    800028e4:	f3dff06f          	j	80002820 <alloc_user_proc+0x34>

00000000800028e8 <kproc_create>:
    800028e8:	fd010113          	addi	sp,sp,-48
    800028ec:	00913c23          	sd	s1,24(sp)
    800028f0:	01213823          	sd	s2,16(sp)
    800028f4:	01313423          	sd	s3,8(sp)
    800028f8:	02113423          	sd	ra,40(sp)
    800028fc:	02813023          	sd	s0,32(sp)
    80002900:	00050993          	mv	s3,a0
    80002904:	00058913          	mv	s2,a1
    80002908:	00060493          	mv	s1,a2
    8000290c:	c51ff0ef          	jal	ra,8000255c <alloc_process>
    80002910:	0e050e63          	beqz	a0,80002a0c <kproc_create+0x124>
    80002914:	01853703          	ld	a4,24(a0) # fffffffffffff018 <TRAMPOLINE+0x18>
    80002918:	00000617          	auipc	a2,0x0
    8000291c:	7ec60613          	addi	a2,a2,2028 # 80003104 <kproc_start_trampoline>
    80002920:	00050413          	mv	s0,a0
    80002924:	ff373823          	sd	s3,-16(a4)
    80002928:	ff273c23          	sd	s2,-8(a4)
    8000292c:	ff070693          	addi	a3,a4,-16
    80002930:	f7070713          	addi	a4,a4,-144
    80002934:	00000793          	li	a5,0
    80002938:	02c53023          	sd	a2,32(a0)
    8000293c:	02e53423          	sd	a4,40(a0)
    80002940:	04053c23          	sd	zero,88(a0)
    80002944:	04053823          	sd	zero,80(a0)
    80002948:	04053423          	sd	zero,72(a0)
    8000294c:	04053023          	sd	zero,64(a0)
    80002950:	02053c23          	sd	zero,56(a0)
    80002954:	08053423          	sd	zero,136(a0)
    80002958:	08053023          	sd	zero,128(a0)
    8000295c:	06053c23          	sd	zero,120(a0)
    80002960:	06053823          	sd	zero,112(a0)
    80002964:	06053423          	sd	zero,104(a0)
    80002968:	06053023          	sd	zero,96(a0)
    8000296c:	02d53823          	sd	a3,48(a0)
    80002970:	00f00593          	li	a1,15
    80002974:	00f48733          	add	a4,s1,a5
    80002978:	00f406b3          	add	a3,s0,a5
    8000297c:	0007861b          	sext.w	a2,a5
    80002980:	00178793          	addi	a5,a5,1
    80002984:	00048c63          	beqz	s1,8000299c <kproc_create+0xb4>
    80002988:	00074703          	lbu	a4,0(a4)
    8000298c:	00070863          	beqz	a4,8000299c <kproc_create+0xb4>
    80002990:	00e68423          	sb	a4,8(a3)
    80002994:	feb790e3          	bne	a5,a1,80002974 <kproc_create+0x8c>
    80002998:	00f00613          	li	a2,15
    8000299c:	00c40633          	add	a2,s0,a2
    800029a0:	00060423          	sb	zero,8(a2)
    800029a4:	00009517          	auipc	a0,0x9
    800029a8:	a9c50513          	addi	a0,a0,-1380 # 8000b440 <proc_lock>
    800029ac:	4b1000ef          	jal	ra,8000365c <acquire>
    800029b0:	00832717          	auipc	a4,0x832
    800029b4:	05873703          	ld	a4,88(a4) # 80834a08 <ticks>
    800029b8:	00832797          	auipc	a5,0x832
    800029bc:	0687b783          	ld	a5,104(a5) # 80834a20 <current>
    800029c0:	00200693          	li	a3,2
    800029c4:	00d42223          	sw	a3,4(s0)
    800029c8:	0ae43823          	sd	a4,176(s0)
    800029cc:	0af43c23          	sd	a5,184(s0)
    800029d0:	00078863          	beqz	a5,800029e0 <kproc_create+0xf8>
    800029d4:	0c07a703          	lw	a4,192(a5)
    800029d8:	0017071b          	addiw	a4,a4,1
    800029dc:	0ce7a023          	sw	a4,192(a5)
    800029e0:	00009517          	auipc	a0,0x9
    800029e4:	a6050513          	addi	a0,a0,-1440 # 8000b440 <proc_lock>
    800029e8:	499000ef          	jal	ra,80003680 <release>
    800029ec:	00042503          	lw	a0,0(s0)
    800029f0:	02813083          	ld	ra,40(sp)
    800029f4:	02013403          	ld	s0,32(sp)
    800029f8:	01813483          	ld	s1,24(sp)
    800029fc:	01013903          	ld	s2,16(sp)
    80002a00:	00813983          	ld	s3,8(sp)
    80002a04:	03010113          	addi	sp,sp,48
    80002a08:	00008067          	ret
    80002a0c:	fff00513          	li	a0,-1
    80002a10:	fe1ff06f          	j	800029f0 <kproc_create+0x108>

0000000080002a14 <create_process>:
    80002a14:	00050593          	mv	a1,a0
    80002a18:	00005617          	auipc	a2,0x5
    80002a1c:	87860613          	addi	a2,a2,-1928 # 80007290 <digits+0x398>
    80002a20:	00000517          	auipc	a0,0x0
    80002a24:	aa850513          	addi	a0,a0,-1368 # 800024c8 <proc_entry_wrapper>
    80002a28:	ec1ff06f          	j	800028e8 <kproc_create>

0000000080002a2c <userinit>:
    80002a2c:	fc010113          	addi	sp,sp,-64
    80002a30:	02813823          	sd	s0,48(sp)
    80002a34:	02113c23          	sd	ra,56(sp)
    80002a38:	02913423          	sd	s1,40(sp)
    80002a3c:	03213023          	sd	s2,32(sp)
    80002a40:	01313c23          	sd	s3,24(sp)
    80002a44:	01413823          	sd	s4,16(sp)
    80002a48:	01513423          	sd	s5,8(sp)
    80002a4c:	da1ff0ef          	jal	ra,800027ec <alloc_user_proc>
    80002a50:	00050413          	mv	s0,a0
    80002a54:	12050e63          	beqz	a0,80002b90 <userinit+0x164>
    80002a58:	000015b7          	lui	a1,0x1
    80002a5c:	00005a17          	auipc	s4,0x5
    80002a60:	e9ca0a13          	addi	s4,s4,-356 # 800078f8 <_binary_user_test_basic_bin_start>
    80002a64:	00005917          	auipc	s2,0x5
    80002a68:	5d590913          	addi	s2,s2,1493 # 80008039 <_binary_user_test_basic_bin_end>
    80002a6c:	fff58993          	addi	s3,a1,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    80002a70:	0d043503          	ld	a0,208(s0)
    80002a74:	41490933          	sub	s2,s2,s4
    80002a78:	01390633          	add	a2,s2,s3
    80002a7c:	fffffab7          	lui	s5,0xfffff
    80002a80:	00e00693          	li	a3,14
    80002a84:	01567633          	and	a2,a2,s5
    80002a88:	00000593          	li	a1,0
    80002a8c:	cddfe0ef          	jal	ra,80001768 <uvmalloc>
    80002a90:	00050493          	mv	s1,a0
    80002a94:	0e050663          	beqz	a0,80002b80 <userinit+0x154>
    80002a98:	0d043503          	ld	a0,208(s0)
    80002a9c:	00090693          	mv	a3,s2
    80002aa0:	000a0613          	mv	a2,s4
    80002aa4:	00000593          	li	a1,0
    80002aa8:	e31fe0ef          	jal	ra,800018d8 <copyout>
    80002aac:	0c054a63          	bltz	a0,80002b80 <userinit+0x154>
    80002ab0:	013485b3          	add	a1,s1,s3
    80002ab4:	0d043503          	ld	a0,208(s0)
    80002ab8:	0155f5b3          	and	a1,a1,s5
    80002abc:	00002637          	lui	a2,0x2
    80002ac0:	00600693          	li	a3,6
    80002ac4:	00c58633          	add	a2,a1,a2
    80002ac8:	ca1fe0ef          	jal	ra,80001768 <uvmalloc>
    80002acc:	0a050a63          	beqz	a0,80002b80 <userinit+0x154>
    80002ad0:	0c843783          	ld	a5,200(s0)
    80002ad4:	0ca43c23          	sd	a0,216(s0)
    80002ad8:	0007bc23          	sd	zero,24(a5)
    80002adc:	02a7b823          	sd	a0,48(a5)
    80002ae0:	00004697          	auipc	a3,0x4
    80002ae4:	7c968693          	addi	a3,a3,1993 # 800072a9 <digits+0x3b1>
    80002ae8:	00100793          	li	a5,1
    80002aec:	06900713          	li	a4,105
    80002af0:	00f00593          	li	a1,15
    80002af4:	0140006f          	j	80002b08 <userinit+0xdc>
    80002af8:	0006c703          	lbu	a4,0(a3)
    80002afc:	00178793          	addi	a5,a5,1
    80002b00:	00168693          	addi	a3,a3,1
    80002b04:	00070c63          	beqz	a4,80002b1c <userinit+0xf0>
    80002b08:	00f40633          	add	a2,s0,a5
    80002b0c:	00e603a3          	sb	a4,7(a2) # 2007 <_binary_user_test_basic_bin_size+0x18c6>
    80002b10:	0007861b          	sext.w	a2,a5
    80002b14:	feb792e3          	bne	a5,a1,80002af8 <userinit+0xcc>
    80002b18:	00f00613          	li	a2,15
    80002b1c:	00c40633          	add	a2,s0,a2
    80002b20:	00009517          	auipc	a0,0x9
    80002b24:	92050513          	addi	a0,a0,-1760 # 8000b440 <proc_lock>
    80002b28:	00060423          	sb	zero,8(a2)
    80002b2c:	331000ef          	jal	ra,8000365c <acquire>
    80002b30:	00832797          	auipc	a5,0x832
    80002b34:	ed87b783          	ld	a5,-296(a5) # 80834a08 <ticks>
    80002b38:	00200713          	li	a4,2
    80002b3c:	00009517          	auipc	a0,0x9
    80002b40:	90450513          	addi	a0,a0,-1788 # 8000b440 <proc_lock>
    80002b44:	00e42223          	sw	a4,4(s0)
    80002b48:	0af43823          	sd	a5,176(s0)
    80002b4c:	335000ef          	jal	ra,80003680 <release>
    80002b50:	00042583          	lw	a1,0(s0)
    80002b54:	03013403          	ld	s0,48(sp)
    80002b58:	03813083          	ld	ra,56(sp)
    80002b5c:	02813483          	ld	s1,40(sp)
    80002b60:	02013903          	ld	s2,32(sp)
    80002b64:	01813983          	ld	s3,24(sp)
    80002b68:	01013a03          	ld	s4,16(sp)
    80002b6c:	00813a83          	ld	s5,8(sp)
    80002b70:	00004517          	auipc	a0,0x4
    80002b74:	75050513          	addi	a0,a0,1872 # 800072c0 <digits+0x3c8>
    80002b78:	04010113          	addi	sp,sp,64
    80002b7c:	e09fd06f          	j	80000984 <printf>
    80002b80:	00004517          	auipc	a0,0x4
    80002b84:	73050513          	addi	a0,a0,1840 # 800072b0 <digits+0x3b8>
    80002b88:	914fe0ef          	jal	ra,80000c9c <panic>
    80002b8c:	f55ff06f          	j	80002ae0 <userinit+0xb4>
    80002b90:	00004517          	auipc	a0,0x4
    80002b94:	70850513          	addi	a0,a0,1800 # 80007298 <digits+0x3a0>
    80002b98:	904fe0ef          	jal	ra,80000c9c <panic>
    80002b9c:	ebdff06f          	j	80002a58 <userinit+0x2c>

0000000080002ba0 <fork_user_process>:
    80002ba0:	fe010113          	addi	sp,sp,-32
    80002ba4:	00913423          	sd	s1,8(sp)
    80002ba8:	00113c23          	sd	ra,24(sp)
    80002bac:	00813823          	sd	s0,16(sp)
    80002bb0:	00832497          	auipc	s1,0x832
    80002bb4:	e704b483          	ld	s1,-400(s1) # 80834a20 <current>
    80002bb8:	10048c63          	beqz	s1,80002cd0 <fork_user_process+0x130>
    80002bbc:	c31ff0ef          	jal	ra,800027ec <alloc_user_proc>
    80002bc0:	00050413          	mv	s0,a0
    80002bc4:	10050663          	beqz	a0,80002cd0 <fork_user_process+0x130>
    80002bc8:	0d053583          	ld	a1,208(a0)
    80002bcc:	0d84b603          	ld	a2,216(s1)
    80002bd0:	0d04b503          	ld	a0,208(s1)
    80002bd4:	e01fe0ef          	jal	ra,800019d4 <uvmcopy>
    80002bd8:	0e054863          	bltz	a0,80002cc8 <fork_user_process+0x128>
    80002bdc:	0d84b703          	ld	a4,216(s1)
    80002be0:	0c84b783          	ld	a5,200(s1)
    80002be4:	0c843883          	ld	a7,200(s0)
    80002be8:	0ce43c23          	sd	a4,216(s0)
    80002bec:	12078813          	addi	a6,a5,288
    80002bf0:	00088713          	mv	a4,a7
    80002bf4:	0007b503          	ld	a0,0(a5)
    80002bf8:	0087b583          	ld	a1,8(a5)
    80002bfc:	0107b603          	ld	a2,16(a5)
    80002c00:	0187b683          	ld	a3,24(a5)
    80002c04:	00a73023          	sd	a0,0(a4)
    80002c08:	00b73423          	sd	a1,8(a4)
    80002c0c:	00c73823          	sd	a2,16(a4)
    80002c10:	00d73c23          	sd	a3,24(a4)
    80002c14:	02078793          	addi	a5,a5,32
    80002c18:	02070713          	addi	a4,a4,32
    80002c1c:	fd079ce3          	bne	a5,a6,80002bf4 <fork_user_process+0x54>
    80002c20:	0608b823          	sd	zero,112(a7)
    80002c24:	0e048793          	addi	a5,s1,224
    80002c28:	0e040713          	addi	a4,s0,224
    80002c2c:	16048613          	addi	a2,s1,352
    80002c30:	0007b683          	ld	a3,0(a5)
    80002c34:	00878793          	addi	a5,a5,8
    80002c38:	00870713          	addi	a4,a4,8
    80002c3c:	fed73c23          	sd	a3,-8(a4)
    80002c40:	fec798e3          	bne	a5,a2,80002c30 <fork_user_process+0x90>
    80002c44:	00840793          	addi	a5,s0,8
    80002c48:	00848713          	addi	a4,s1,8
    80002c4c:	01740593          	addi	a1,s0,23
    80002c50:	00074683          	lbu	a3,0(a4)
    80002c54:	00078613          	mv	a2,a5
    80002c58:	00170713          	addi	a4,a4,1
    80002c5c:	00068a63          	beqz	a3,80002c70 <fork_user_process+0xd0>
    80002c60:	00d78023          	sb	a3,0(a5)
    80002c64:	00160793          	addi	a5,a2,1
    80002c68:	fef594e3          	bne	a1,a5,80002c50 <fork_user_process+0xb0>
    80002c6c:	00058613          	mv	a2,a1
    80002c70:	00008517          	auipc	a0,0x8
    80002c74:	7d050513          	addi	a0,a0,2000 # 8000b440 <proc_lock>
    80002c78:	00060023          	sb	zero,0(a2)
    80002c7c:	1e1000ef          	jal	ra,8000365c <acquire>
    80002c80:	0c04a783          	lw	a5,192(s1)
    80002c84:	0a943c23          	sd	s1,184(s0)
    80002c88:	00832717          	auipc	a4,0x832
    80002c8c:	d8073703          	ld	a4,-640(a4) # 80834a08 <ticks>
    80002c90:	0017879b          	addiw	a5,a5,1
    80002c94:	0cf4a023          	sw	a5,192(s1)
    80002c98:	00200793          	li	a5,2
    80002c9c:	00008517          	auipc	a0,0x8
    80002ca0:	7a450513          	addi	a0,a0,1956 # 8000b440 <proc_lock>
    80002ca4:	00f42223          	sw	a5,4(s0)
    80002ca8:	0ae43823          	sd	a4,176(s0)
    80002cac:	1d5000ef          	jal	ra,80003680 <release>
    80002cb0:	00042503          	lw	a0,0(s0)
    80002cb4:	01813083          	ld	ra,24(sp)
    80002cb8:	01013403          	ld	s0,16(sp)
    80002cbc:	00813483          	ld	s1,8(sp)
    80002cc0:	02010113          	addi	sp,sp,32
    80002cc4:	00008067          	ret
    80002cc8:	00040513          	mv	a0,s0
    80002ccc:	a19ff0ef          	jal	ra,800026e4 <free_process>
    80002cd0:	fff00513          	li	a0,-1
    80002cd4:	fe1ff06f          	j	80002cb4 <fork_user_process+0x114>

0000000080002cd8 <grow_process>:
    80002cd8:	fe010113          	addi	sp,sp,-32
    80002cdc:	00913423          	sd	s1,8(sp)
    80002ce0:	00832497          	auipc	s1,0x832
    80002ce4:	d4048493          	addi	s1,s1,-704 # 80834a20 <current>
    80002ce8:	0004b783          	ld	a5,0(s1)
    80002cec:	00113c23          	sd	ra,24(sp)
    80002cf0:	00813823          	sd	s0,16(sp)
    80002cf4:	08078063          	beqz	a5,80002d74 <grow_process+0x9c>
    80002cf8:	00050613          	mv	a2,a0
    80002cfc:	0d07b503          	ld	a0,208(a5)
    80002d00:	06050a63          	beqz	a0,80002d74 <grow_process+0x9c>
    80002d04:	0d87b403          	ld	s0,216(a5)
    80002d08:	04c04663          	bgtz	a2,80002d54 <grow_process+0x7c>
    80002d0c:	00040713          	mv	a4,s0
    80002d10:	02061063          	bnez	a2,80002d30 <grow_process+0x58>
    80002d14:	0ce7bc23          	sd	a4,216(a5)
    80002d18:	0004051b          	sext.w	a0,s0
    80002d1c:	01813083          	ld	ra,24(sp)
    80002d20:	01013403          	ld	s0,16(sp)
    80002d24:	00813483          	ld	s1,8(sp)
    80002d28:	02010113          	addi	sp,sp,32
    80002d2c:	00008067          	ret
    80002d30:	40c007bb          	negw	a5,a2
    80002d34:	00000613          	li	a2,0
    80002d38:	00f46463          	bltu	s0,a5,80002d40 <grow_process+0x68>
    80002d3c:	40f40633          	sub	a2,s0,a5
    80002d40:	00040593          	mv	a1,s0
    80002d44:	b0dfe0ef          	jal	ra,80001850 <uvmdealloc>
    80002d48:	0004b783          	ld	a5,0(s1)
    80002d4c:	00050713          	mv	a4,a0
    80002d50:	fc5ff06f          	j	80002d14 <grow_process+0x3c>
    80002d54:	00e00693          	li	a3,14
    80002d58:	00860633          	add	a2,a2,s0
    80002d5c:	00040593          	mv	a1,s0
    80002d60:	a09fe0ef          	jal	ra,80001768 <uvmalloc>
    80002d64:	00050713          	mv	a4,a0
    80002d68:	00050663          	beqz	a0,80002d74 <grow_process+0x9c>
    80002d6c:	0004b783          	ld	a5,0(s1)
    80002d70:	fa5ff06f          	j	80002d14 <grow_process+0x3c>
    80002d74:	fff00513          	li	a0,-1
    80002d78:	fa5ff06f          	j	80002d1c <grow_process+0x44>

0000000080002d7c <sched>:
    80002d7c:	00832797          	auipc	a5,0x832
    80002d80:	ca47b783          	ld	a5,-860(a5) # 80834a20 <current>
    80002d84:	00008517          	auipc	a0,0x8
    80002d88:	6cc50513          	addi	a0,a0,1740 # 8000b450 <sched_ctx>
    80002d8c:	00078463          	beqz	a5,80002d94 <sched+0x18>
    80002d90:	02078513          	addi	a0,a5,32
    80002d94:	00008597          	auipc	a1,0x8
    80002d98:	6bc58593          	addi	a1,a1,1724 # 8000b450 <sched_ctx>
    80002d9c:	00832797          	auipc	a5,0x832
    80002da0:	c807b223          	sd	zero,-892(a5) # 80834a20 <current>
    80002da4:	b4cfd06f          	j	800000f0 <swtch>

0000000080002da8 <yield>:
    80002da8:	ff010113          	addi	sp,sp,-16
    80002dac:	00813023          	sd	s0,0(sp)
    80002db0:	00832417          	auipc	s0,0x832
    80002db4:	c7040413          	addi	s0,s0,-912 # 80834a20 <current>
    80002db8:	00043783          	ld	a5,0(s0)
    80002dbc:	00113423          	sd	ra,8(sp)
    80002dc0:	06078663          	beqz	a5,80002e2c <yield+0x84>
    80002dc4:	00008517          	auipc	a0,0x8
    80002dc8:	67c50513          	addi	a0,a0,1660 # 8000b440 <proc_lock>
    80002dcc:	091000ef          	jal	ra,8000365c <acquire>
    80002dd0:	00043783          	ld	a5,0(s0)
    80002dd4:	00832717          	auipc	a4,0x832
    80002dd8:	c3473703          	ld	a4,-972(a4) # 80834a08 <ticks>
    80002ddc:	00200693          	li	a3,2
    80002de0:	00d7a223          	sw	a3,4(a5)
    80002de4:	0807aa23          	sw	zero,148(a5)
    80002de8:	0ae7b823          	sd	a4,176(a5)
    80002dec:	00008517          	auipc	a0,0x8
    80002df0:	65450513          	addi	a0,a0,1620 # 8000b440 <proc_lock>
    80002df4:	08d000ef          	jal	ra,80003680 <release>
    80002df8:	00043783          	ld	a5,0(s0)
    80002dfc:	00008517          	auipc	a0,0x8
    80002e00:	65450513          	addi	a0,a0,1620 # 8000b450 <sched_ctx>
    80002e04:	00078463          	beqz	a5,80002e0c <yield+0x64>
    80002e08:	02078513          	addi	a0,a5,32
    80002e0c:	00013403          	ld	s0,0(sp)
    80002e10:	00813083          	ld	ra,8(sp)
    80002e14:	00832797          	auipc	a5,0x832
    80002e18:	c007b623          	sd	zero,-1012(a5) # 80834a20 <current>
    80002e1c:	00008597          	auipc	a1,0x8
    80002e20:	63458593          	addi	a1,a1,1588 # 8000b450 <sched_ctx>
    80002e24:	01010113          	addi	sp,sp,16
    80002e28:	ac8fd06f          	j	800000f0 <swtch>
    80002e2c:	00813083          	ld	ra,8(sp)
    80002e30:	00013403          	ld	s0,0(sp)
    80002e34:	01010113          	addi	sp,sp,16
    80002e38:	00008067          	ret

0000000080002e3c <sleep>:
    80002e3c:	fd010113          	addi	sp,sp,-48
    80002e40:	00913c23          	sd	s1,24(sp)
    80002e44:	00832497          	auipc	s1,0x832
    80002e48:	bdc48493          	addi	s1,s1,-1060 # 80834a20 <current>
    80002e4c:	0004b783          	ld	a5,0(s1)
    80002e50:	02113423          	sd	ra,40(sp)
    80002e54:	02813023          	sd	s0,32(sp)
    80002e58:	01213823          	sd	s2,16(sp)
    80002e5c:	01313423          	sd	s3,8(sp)
    80002e60:	0e078263          	beqz	a5,80002f44 <sleep+0x108>
    80002e64:	00058413          	mv	s0,a1
    80002e68:	0c058e63          	beqz	a1,80002f44 <sleep+0x108>
    80002e6c:	00008997          	auipc	s3,0x8
    80002e70:	5d498993          	addi	s3,s3,1492 # 8000b440 <proc_lock>
    80002e74:	00050913          	mv	s2,a0
    80002e78:	09358463          	beq	a1,s3,80002f00 <sleep+0xc4>
    80002e7c:	00098513          	mv	a0,s3
    80002e80:	7dc000ef          	jal	ra,8000365c <acquire>
    80002e84:	00040513          	mv	a0,s0
    80002e88:	7f8000ef          	jal	ra,80003680 <release>
    80002e8c:	0004b783          	ld	a5,0(s1)
    80002e90:	00400713          	li	a4,4
    80002e94:	00098513          	mv	a0,s3
    80002e98:	0927bc23          	sd	s2,152(a5)
    80002e9c:	00e7a223          	sw	a4,4(a5)
    80002ea0:	7e0000ef          	jal	ra,80003680 <release>
    80002ea4:	0004b503          	ld	a0,0(s1)
    80002ea8:	0a050c63          	beqz	a0,80002f60 <sleep+0x124>
    80002eac:	00008597          	auipc	a1,0x8
    80002eb0:	5a458593          	addi	a1,a1,1444 # 8000b450 <sched_ctx>
    80002eb4:	02050513          	addi	a0,a0,32
    80002eb8:	00832797          	auipc	a5,0x832
    80002ebc:	b607b423          	sd	zero,-1176(a5) # 80834a20 <current>
    80002ec0:	a30fd0ef          	jal	ra,800000f0 <swtch>
    80002ec4:	00098513          	mv	a0,s3
    80002ec8:	794000ef          	jal	ra,8000365c <acquire>
    80002ecc:	0004b783          	ld	a5,0(s1)
    80002ed0:	00008517          	auipc	a0,0x8
    80002ed4:	57050513          	addi	a0,a0,1392 # 8000b440 <proc_lock>
    80002ed8:	0807bc23          	sd	zero,152(a5)
    80002edc:	7a4000ef          	jal	ra,80003680 <release>
    80002ee0:	00040513          	mv	a0,s0
    80002ee4:	02013403          	ld	s0,32(sp)
    80002ee8:	02813083          	ld	ra,40(sp)
    80002eec:	01813483          	ld	s1,24(sp)
    80002ef0:	01013903          	ld	s2,16(sp)
    80002ef4:	00813983          	ld	s3,8(sp)
    80002ef8:	03010113          	addi	sp,sp,48
    80002efc:	7600006f          	j	8000365c <acquire>
    80002f00:	00400713          	li	a4,4
    80002f04:	08a7bc23          	sd	a0,152(a5)
    80002f08:	00e7a223          	sw	a4,4(a5)
    80002f0c:	00058513          	mv	a0,a1
    80002f10:	770000ef          	jal	ra,80003680 <release>
    80002f14:	0004b503          	ld	a0,0(s1)
    80002f18:	04050c63          	beqz	a0,80002f70 <sleep+0x134>
    80002f1c:	00008597          	auipc	a1,0x8
    80002f20:	53458593          	addi	a1,a1,1332 # 8000b450 <sched_ctx>
    80002f24:	02050513          	addi	a0,a0,32
    80002f28:	00832797          	auipc	a5,0x832
    80002f2c:	ae07bc23          	sd	zero,-1288(a5) # 80834a20 <current>
    80002f30:	9c0fd0ef          	jal	ra,800000f0 <swtch>
    80002f34:	00040513          	mv	a0,s0
    80002f38:	724000ef          	jal	ra,8000365c <acquire>
    80002f3c:	0004b783          	ld	a5,0(s1)
    80002f40:	0807bc23          	sd	zero,152(a5)
    80002f44:	02813083          	ld	ra,40(sp)
    80002f48:	02013403          	ld	s0,32(sp)
    80002f4c:	01813483          	ld	s1,24(sp)
    80002f50:	01013903          	ld	s2,16(sp)
    80002f54:	00813983          	ld	s3,8(sp)
    80002f58:	03010113          	addi	sp,sp,48
    80002f5c:	00008067          	ret
    80002f60:	00008597          	auipc	a1,0x8
    80002f64:	4f058593          	addi	a1,a1,1264 # 8000b450 <sched_ctx>
    80002f68:	00058513          	mv	a0,a1
    80002f6c:	f55ff06f          	j	80002ec0 <sleep+0x84>
    80002f70:	00008597          	auipc	a1,0x8
    80002f74:	4e058593          	addi	a1,a1,1248 # 8000b450 <sched_ctx>
    80002f78:	00058513          	mv	a0,a1
    80002f7c:	fb5ff06f          	j	80002f30 <sleep+0xf4>

0000000080002f80 <wakeup>:
    80002f80:	fe010113          	addi	sp,sp,-32
    80002f84:	00813823          	sd	s0,16(sp)
    80002f88:	00050413          	mv	s0,a0
    80002f8c:	00008517          	auipc	a0,0x8
    80002f90:	4b450513          	addi	a0,a0,1204 # 8000b440 <proc_lock>
    80002f94:	00913423          	sd	s1,8(sp)
    80002f98:	00113c23          	sd	ra,24(sp)
    80002f9c:	6f4000ef          	jal	ra,80003690 <holding>
    80002fa0:	00050493          	mv	s1,a0
    80002fa4:	06050663          	beqz	a0,80003010 <wakeup+0x90>
    80002fa8:	00008797          	auipc	a5,0x8
    80002fac:	52c78793          	addi	a5,a5,1324 # 8000b4d4 <proc_table+0x4>
    80002fb0:	0000e617          	auipc	a2,0xe
    80002fb4:	d2460613          	addi	a2,a2,-732 # 80010cd4 <bcache+0x4>
    80002fb8:	00400693          	li	a3,4
    80002fbc:	00200813          	li	a6,2
    80002fc0:	00832597          	auipc	a1,0x832
    80002fc4:	a4858593          	addi	a1,a1,-1464 # 80834a08 <ticks>
    80002fc8:	00c0006f          	j	80002fd4 <wakeup+0x54>
    80002fcc:	16078793          	addi	a5,a5,352
    80002fd0:	02c78463          	beq	a5,a2,80002ff8 <wakeup+0x78>
    80002fd4:	0007a703          	lw	a4,0(a5)
    80002fd8:	fed71ae3          	bne	a4,a3,80002fcc <wakeup+0x4c>
    80002fdc:	0947b703          	ld	a4,148(a5)
    80002fe0:	fe8716e3          	bne	a4,s0,80002fcc <wakeup+0x4c>
    80002fe4:	0005b703          	ld	a4,0(a1)
    80002fe8:	0107a023          	sw	a6,0(a5)
    80002fec:	16078793          	addi	a5,a5,352
    80002ff0:	f4e7b623          	sd	a4,-180(a5)
    80002ff4:	fec790e3          	bne	a5,a2,80002fd4 <wakeup+0x54>
    80002ff8:	02048463          	beqz	s1,80003020 <wakeup+0xa0>
    80002ffc:	01813083          	ld	ra,24(sp)
    80003000:	01013403          	ld	s0,16(sp)
    80003004:	00813483          	ld	s1,8(sp)
    80003008:	02010113          	addi	sp,sp,32
    8000300c:	00008067          	ret
    80003010:	00008517          	auipc	a0,0x8
    80003014:	43050513          	addi	a0,a0,1072 # 8000b440 <proc_lock>
    80003018:	644000ef          	jal	ra,8000365c <acquire>
    8000301c:	f8dff06f          	j	80002fa8 <wakeup+0x28>
    80003020:	01013403          	ld	s0,16(sp)
    80003024:	01813083          	ld	ra,24(sp)
    80003028:	00813483          	ld	s1,8(sp)
    8000302c:	00008517          	auipc	a0,0x8
    80003030:	41450513          	addi	a0,a0,1044 # 8000b440 <proc_lock>
    80003034:	02010113          	addi	sp,sp,32
    80003038:	6480006f          	j	80003680 <release>

000000008000303c <exit_process>:
    8000303c:	fe010113          	addi	sp,sp,-32
    80003040:	00813823          	sd	s0,16(sp)
    80003044:	00050413          	mv	s0,a0
    80003048:	00008517          	auipc	a0,0x8
    8000304c:	3f850513          	addi	a0,a0,1016 # 8000b440 <proc_lock>
    80003050:	00913423          	sd	s1,8(sp)
    80003054:	00113c23          	sd	ra,24(sp)
    80003058:	00832497          	auipc	s1,0x832
    8000305c:	9c848493          	addi	s1,s1,-1592 # 80834a20 <current>
    80003060:	5fc000ef          	jal	ra,8000365c <acquire>
    80003064:	0004b683          	ld	a3,0(s1)
    80003068:	00008797          	auipc	a5,0x8
    8000306c:	52078793          	addi	a5,a5,1312 # 8000b588 <proc_table+0xb8>
    80003070:	0000e617          	auipc	a2,0xe
    80003074:	d1860613          	addi	a2,a2,-744 # 80010d88 <bcache+0xb8>
    80003078:	0c86a223          	sw	s0,196(a3)
    8000307c:	00c0006f          	j	80003088 <exit_process+0x4c>
    80003080:	16078793          	addi	a5,a5,352
    80003084:	00c78c63          	beq	a5,a2,8000309c <exit_process+0x60>
    80003088:	0007b703          	ld	a4,0(a5)
    8000308c:	fee69ae3          	bne	a3,a4,80003080 <exit_process+0x44>
    80003090:	0007b023          	sd	zero,0(a5)
    80003094:	16078793          	addi	a5,a5,352
    80003098:	fec798e3          	bne	a5,a2,80003088 <exit_process+0x4c>
    8000309c:	0b86b503          	ld	a0,184(a3)
    800030a0:	00500793          	li	a5,5
    800030a4:	0c06a023          	sw	zero,192(a3)
    800030a8:	00f6a223          	sw	a5,4(a3)
    800030ac:	00050463          	beqz	a0,800030b4 <exit_process+0x78>
    800030b0:	ed1ff0ef          	jal	ra,80002f80 <wakeup>
    800030b4:	00008517          	auipc	a0,0x8
    800030b8:	38c50513          	addi	a0,a0,908 # 8000b440 <proc_lock>
    800030bc:	5c4000ef          	jal	ra,80003680 <release>
    800030c0:	0004b783          	ld	a5,0(s1)
    800030c4:	00008517          	auipc	a0,0x8
    800030c8:	38c50513          	addi	a0,a0,908 # 8000b450 <sched_ctx>
    800030cc:	00078463          	beqz	a5,800030d4 <exit_process+0x98>
    800030d0:	02078513          	addi	a0,a5,32
    800030d4:	00008597          	auipc	a1,0x8
    800030d8:	37c58593          	addi	a1,a1,892 # 8000b450 <sched_ctx>
    800030dc:	00832797          	auipc	a5,0x832
    800030e0:	9407b223          	sd	zero,-1724(a5) # 80834a20 <current>
    800030e4:	80cfd0ef          	jal	ra,800000f0 <swtch>
    800030e8:	01013403          	ld	s0,16(sp)
    800030ec:	01813083          	ld	ra,24(sp)
    800030f0:	00813483          	ld	s1,8(sp)
    800030f4:	00004517          	auipc	a0,0x4
    800030f8:	1e450513          	addi	a0,a0,484 # 800072d8 <digits+0x3e0>
    800030fc:	02010113          	addi	sp,sp,32
    80003100:	b9dfd06f          	j	80000c9c <panic>

0000000080003104 <kproc_start_trampoline>:
    80003104:	ff010113          	addi	sp,sp,-16
    80003108:	00113423          	sd	ra,8(sp)
    8000310c:	00040793          	mv	a5,s0
    80003110:	0087b503          	ld	a0,8(a5)
    80003114:	0007b783          	ld	a5,0(a5)
    80003118:	000780e7          	jalr	a5
    8000311c:	00813083          	ld	ra,8(sp)
    80003120:	00000513          	li	a0,0
    80003124:	01010113          	addi	sp,sp,16
    80003128:	f15ff06f          	j	8000303c <exit_process>

000000008000312c <kill_process>:
    8000312c:	ff010113          	addi	sp,sp,-16
    80003130:	00813023          	sd	s0,0(sp)
    80003134:	00050413          	mv	s0,a0
    80003138:	00008517          	auipc	a0,0x8
    8000313c:	30850513          	addi	a0,a0,776 # 8000b440 <proc_lock>
    80003140:	00113423          	sd	ra,8(sp)
    80003144:	518000ef          	jal	ra,8000365c <acquire>
    80003148:	00008697          	auipc	a3,0x8
    8000314c:	38868693          	addi	a3,a3,904 # 8000b4d0 <proc_table>
    80003150:	00068713          	mv	a4,a3
    80003154:	00000793          	li	a5,0
    80003158:	04000593          	li	a1,64
    8000315c:	00072603          	lw	a2,0(a4)
    80003160:	06861063          	bne	a2,s0,800031c0 <kill_process+0x94>
    80003164:	00472603          	lw	a2,4(a4)
    80003168:	04060c63          	beqz	a2,800031c0 <kill_process+0x94>
    8000316c:	16000713          	li	a4,352
    80003170:	02e787b3          	mul	a5,a5,a4
    80003174:	00832717          	auipc	a4,0x832
    80003178:	8ac73703          	ld	a4,-1876(a4) # 80834a20 <current>
    8000317c:	00f687b3          	add	a5,a3,a5
    80003180:	06f70063          	beq	a4,a5,800031e0 <kill_process+0xb4>
    80003184:	fff00713          	li	a4,-1
    80003188:	0b87b503          	ld	a0,184(a5)
    8000318c:	0ce7a223          	sw	a4,196(a5)
    80003190:	00500713          	li	a4,5
    80003194:	00e7a223          	sw	a4,4(a5)
    80003198:	00050463          	beqz	a0,800031a0 <kill_process+0x74>
    8000319c:	de5ff0ef          	jal	ra,80002f80 <wakeup>
    800031a0:	00008517          	auipc	a0,0x8
    800031a4:	2a050513          	addi	a0,a0,672 # 8000b440 <proc_lock>
    800031a8:	4d8000ef          	jal	ra,80003680 <release>
    800031ac:	00000513          	li	a0,0
    800031b0:	00813083          	ld	ra,8(sp)
    800031b4:	00013403          	ld	s0,0(sp)
    800031b8:	01010113          	addi	sp,sp,16
    800031bc:	00008067          	ret
    800031c0:	0017879b          	addiw	a5,a5,1
    800031c4:	16070713          	addi	a4,a4,352
    800031c8:	f8b79ae3          	bne	a5,a1,8000315c <kill_process+0x30>
    800031cc:	00008517          	auipc	a0,0x8
    800031d0:	27450513          	addi	a0,a0,628 # 8000b440 <proc_lock>
    800031d4:	4ac000ef          	jal	ra,80003680 <release>
    800031d8:	fff00513          	li	a0,-1
    800031dc:	fd5ff06f          	j	800031b0 <kill_process+0x84>
    800031e0:	00008517          	auipc	a0,0x8
    800031e4:	26050513          	addi	a0,a0,608 # 8000b440 <proc_lock>
    800031e8:	498000ef          	jal	ra,80003680 <release>
    800031ec:	fff00513          	li	a0,-1
    800031f0:	e4dff0ef          	jal	ra,8000303c <exit_process>
    800031f4:	00000513          	li	a0,0
    800031f8:	fb9ff06f          	j	800031b0 <kill_process+0x84>

00000000800031fc <scheduler>:
    800031fc:	f9010113          	addi	sp,sp,-112
    80003200:	04913c23          	sd	s1,88(sp)
    80003204:	05213823          	sd	s2,80(sp)
    80003208:	03513c23          	sd	s5,56(sp)
    8000320c:	03613823          	sd	s6,48(sp)
    80003210:	03713423          	sd	s7,40(sp)
    80003214:	03813023          	sd	s8,32(sp)
    80003218:	01913c23          	sd	s9,24(sp)
    8000321c:	01a13823          	sd	s10,16(sp)
    80003220:	06113423          	sd	ra,104(sp)
    80003224:	06813023          	sd	s0,96(sp)
    80003228:	05313423          	sd	s3,72(sp)
    8000322c:	05413023          	sd	s4,64(sp)
    80003230:	01b13423          	sd	s11,8(sp)
    80003234:	00831917          	auipc	s2,0x831
    80003238:	7d490913          	addi	s2,s2,2004 # 80834a08 <ticks>
    8000323c:	0000eb17          	auipc	s6,0xe
    80003240:	a98b0b13          	addi	s6,s6,-1384 # 80010cd4 <bcache+0x4>
    80003244:	00004b97          	auipc	s7,0x4
    80003248:	15cb8b93          	addi	s7,s7,348 # 800073a0 <queue_slices>
    8000324c:	00008c97          	auipc	s9,0x8
    80003250:	284c8c93          	addi	s9,s9,644 # 8000b4d0 <proc_table>
    80003254:	00008497          	auipc	s1,0x8
    80003258:	1ec48493          	addi	s1,s1,492 # 8000b440 <proc_lock>
    8000325c:	00200a93          	li	s5,2
    80003260:	03100c13          	li	s8,49
    80003264:	16000d13          	li	s10,352
    80003268:	00048513          	mv	a0,s1
    8000326c:	3f0000ef          	jal	ra,8000365c <acquire>
    80003270:	00093583          	ld	a1,0(s2)
    80003274:	00008797          	auipc	a5,0x8
    80003278:	26078793          	addi	a5,a5,608 # 8000b4d4 <proc_table+0x4>
    8000327c:	0007a703          	lw	a4,0(a5)
    80003280:	03571c63          	bne	a4,s5,800032b8 <scheduler+0xbc>
    80003284:	09c7a703          	lw	a4,156(a5)
    80003288:	02e05863          	blez	a4,800032b8 <scheduler+0xbc>
    8000328c:	0ac7b603          	ld	a2,172(a5)
    80003290:	fff7069b          	addiw	a3,a4,-1
    80003294:	00068713          	mv	a4,a3
    80003298:	40c58633          	sub	a2,a1,a2
    8000329c:	00269693          	slli	a3,a3,0x2
    800032a0:	00db86b3          	add	a3,s7,a3
    800032a4:	00cc7a63          	bgeu	s8,a2,800032b8 <scheduler+0xbc>
    800032a8:	0006a683          	lw	a3,0(a3)
    800032ac:	08e7ae23          	sw	a4,156(a5)
    800032b0:	0ab7b623          	sd	a1,172(a5)
    800032b4:	08d7a623          	sw	a3,140(a5)
    800032b8:	16078793          	addi	a5,a5,352
    800032bc:	fcfb10e3          	bne	s6,a5,8000327c <scheduler+0x80>
    800032c0:	00008517          	auipc	a0,0x8
    800032c4:	20050513          	addi	a0,a0,512 # 8000b4c0 <queue_cursor>
    800032c8:	00000613          	li	a2,0
    800032cc:	00052783          	lw	a5,0(a0)
    800032d0:	0407859b          	addiw	a1,a5,64
    800032d4:	41f7d41b          	sraiw	s0,a5,0x1f
    800032d8:	01a4571b          	srliw	a4,s0,0x1a
    800032dc:	00f7043b          	addw	s0,a4,a5
    800032e0:	03f47413          	andi	s0,s0,63
    800032e4:	40e4043b          	subw	s0,s0,a4
    800032e8:	03a409b3          	mul	s3,s0,s10
    800032ec:	0017879b          	addiw	a5,a5,1
    800032f0:	013c8db3          	add	s11,s9,s3
    800032f4:	004da683          	lw	a3,4(s11)
    800032f8:	01569663          	bne	a3,s5,80003304 <scheduler+0x108>
    800032fc:	0a0da683          	lw	a3,160(s11)
    80003300:	00c68e63          	beq	a3,a2,8000331c <scheduler+0x120>
    80003304:	fcf598e3          	bne	a1,a5,800032d4 <scheduler+0xd8>
    80003308:	0016061b          	addiw	a2,a2,1
    8000330c:	00300793          	li	a5,3
    80003310:	00450513          	addi	a0,a0,4
    80003314:	08f60c63          	beq	a2,a5,800033ac <scheduler+0x1b0>
    80003318:	fb5ff06f          	j	800032cc <scheduler+0xd0>
    8000331c:	00261a13          	slli	s4,a2,0x2
    80003320:	014b87b3          	add	a5,s7,s4
    80003324:	0007a683          	lw	a3,0(a5)
    80003328:	00093783          	ld	a5,0(s2)
    8000332c:	000da583          	lw	a1,0(s11)
    80003330:	00831717          	auipc	a4,0x831
    80003334:	6f070713          	addi	a4,a4,1776 # 80834a20 <current>
    80003338:	01b73023          	sd	s11,0(a4)
    8000333c:	00300713          	li	a4,3
    80003340:	00eda223          	sw	a4,4(s11)
    80003344:	08dda823          	sw	a3,144(s11)
    80003348:	0afdb423          	sd	a5,168(s11)
    8000334c:	00004517          	auipc	a0,0x4
    80003350:	fa450513          	addi	a0,a0,-92 # 800072f0 <digits+0x3f8>
    80003354:	e30fd0ef          	jal	ra,80000984 <printf>
    80003358:	00048513          	mv	a0,s1
    8000335c:	324000ef          	jal	ra,80003680 <release>
    80003360:	02098593          	addi	a1,s3,32
    80003364:	00bc85b3          	add	a1,s9,a1
    80003368:	00008517          	auipc	a0,0x8
    8000336c:	0e850513          	addi	a0,a0,232 # 8000b450 <sched_ctx>
    80003370:	d81fc0ef          	jal	ra,800000f0 <swtch>
    80003374:	00048513          	mv	a0,s1
    80003378:	2e4000ef          	jal	ra,8000365c <acquire>
    8000337c:	0014079b          	addiw	a5,s0,1
    80003380:	41f7d71b          	sraiw	a4,a5,0x1f
    80003384:	01a7571b          	srliw	a4,a4,0x1a
    80003388:	00e787bb          	addw	a5,a5,a4
    8000338c:	03f7f793          	andi	a5,a5,63
    80003390:	004da683          	lw	a3,4(s11)
    80003394:	40e787bb          	subw	a5,a5,a4
    80003398:	01448633          	add	a2,s1,s4
    8000339c:	08f62023          	sw	a5,128(a2)
    800033a0:	00500793          	li	a5,5
    800033a4:	00f68c63          	beq	a3,a5,800033bc <scheduler+0x1c0>
    800033a8:	03568263          	beq	a3,s5,800033cc <scheduler+0x1d0>
    800033ac:	00048513          	mv	a0,s1
    800033b0:	2d0000ef          	jal	ra,80003680 <release>
    800033b4:	10500073          	wfi
    800033b8:	eb1ff06f          	j	80003268 <scheduler+0x6c>
    800033bc:	0b8db503          	ld	a0,184(s11)
    800033c0:	04050663          	beqz	a0,8000340c <scheduler+0x210>
    800033c4:	bbdff0ef          	jal	ra,80002f80 <wakeup>
    800033c8:	fe5ff06f          	j	800033ac <scheduler+0x1b0>
    800033cc:	090da783          	lw	a5,144(s11)
    800033d0:	fcf04ee3          	bgtz	a5,800033ac <scheduler+0x1b0>
    800033d4:	0a0da703          	lw	a4,160(s11)
    800033d8:	00100793          	li	a5,1
    800033dc:	00e7c663          	blt	a5,a4,800033e8 <scheduler+0x1ec>
    800033e0:	0017071b          	addiw	a4,a4,1
    800033e4:	0aeda023          	sw	a4,160(s11)
    800033e8:	03a407b3          	mul	a5,s0,s10
    800033ec:	00271713          	slli	a4,a4,0x2
    800033f0:	00eb8733          	add	a4,s7,a4
    800033f4:	00072683          	lw	a3,0(a4)
    800033f8:	00093703          	ld	a4,0(s2)
    800033fc:	00fc87b3          	add	a5,s9,a5
    80003400:	08d7a823          	sw	a3,144(a5)
    80003404:	0ae7b823          	sd	a4,176(a5)
    80003408:	fa5ff06f          	j	800033ac <scheduler+0x1b0>
    8000340c:	000d8513          	mv	a0,s11
    80003410:	ad4ff0ef          	jal	ra,800026e4 <free_process>
    80003414:	f99ff06f          	j	800033ac <scheduler+0x1b0>

0000000080003418 <wait_process>:
    80003418:	fd010113          	addi	sp,sp,-48
    8000341c:	01213823          	sd	s2,16(sp)
    80003420:	00050913          	mv	s2,a0
    80003424:	00008517          	auipc	a0,0x8
    80003428:	01c50513          	addi	a0,a0,28 # 8000b440 <proc_lock>
    8000342c:	02813023          	sd	s0,32(sp)
    80003430:	00913c23          	sd	s1,24(sp)
    80003434:	01313423          	sd	s3,8(sp)
    80003438:	01413023          	sd	s4,0(sp)
    8000343c:	02113423          	sd	ra,40(sp)
    80003440:	00831997          	auipc	s3,0x831
    80003444:	5e098993          	addi	s3,s3,1504 # 80834a20 <current>
    80003448:	214000ef          	jal	ra,8000365c <acquire>
    8000344c:	0009b603          	ld	a2,0(s3)
    80003450:	00500493          	li	s1,5
    80003454:	04000413          	li	s0,64
    80003458:	00008a17          	auipc	s4,0x8
    8000345c:	ff8a0a13          	addi	s4,s4,-8 # 8000b450 <sched_ctx>
    80003460:	00008797          	auipc	a5,0x8
    80003464:	07478793          	addi	a5,a5,116 # 8000b4d4 <proc_table+0x4>
    80003468:	00000713          	li	a4,0
    8000346c:	00000813          	li	a6,0
    80003470:	0100006f          	j	80003480 <wait_process+0x68>
    80003474:	0017071b          	addiw	a4,a4,1
    80003478:	16078793          	addi	a5,a5,352
    8000347c:	06870e63          	beq	a4,s0,800034f8 <wait_process+0xe0>
    80003480:	0b47b683          	ld	a3,180(a5)
    80003484:	fec698e3          	bne	a3,a2,80003474 <wait_process+0x5c>
    80003488:	0007a683          	lw	a3,0(a5)
    8000348c:	00100813          	li	a6,1
    80003490:	fe9692e3          	bne	a3,s1,80003474 <wait_process+0x5c>
    80003494:	16000793          	li	a5,352
    80003498:	02f707b3          	mul	a5,a4,a5
    8000349c:	00008517          	auipc	a0,0x8
    800034a0:	03450513          	addi	a0,a0,52 # 8000b4d0 <proc_table>
    800034a4:	00f507b3          	add	a5,a0,a5
    800034a8:	0007a403          	lw	s0,0(a5)
    800034ac:	00090663          	beqz	s2,800034b8 <wait_process+0xa0>
    800034b0:	0c47a783          	lw	a5,196(a5)
    800034b4:	00f92023          	sw	a5,0(s2)
    800034b8:	16000793          	li	a5,352
    800034bc:	02f70733          	mul	a4,a4,a5
    800034c0:	00e50533          	add	a0,a0,a4
    800034c4:	a20ff0ef          	jal	ra,800026e4 <free_process>
    800034c8:	00008517          	auipc	a0,0x8
    800034cc:	f7850513          	addi	a0,a0,-136 # 8000b440 <proc_lock>
    800034d0:	1b0000ef          	jal	ra,80003680 <release>
    800034d4:	02813083          	ld	ra,40(sp)
    800034d8:	00040513          	mv	a0,s0
    800034dc:	02013403          	ld	s0,32(sp)
    800034e0:	01813483          	ld	s1,24(sp)
    800034e4:	01013903          	ld	s2,16(sp)
    800034e8:	00813983          	ld	s3,8(sp)
    800034ec:	00013a03          	ld	s4,0(sp)
    800034f0:	03010113          	addi	sp,sp,48
    800034f4:	00008067          	ret
    800034f8:	04080c63          	beqz	a6,80003550 <wait_process+0x138>
    800034fc:	f60602e3          	beqz	a2,80003460 <wait_process+0x48>
    80003500:	00400793          	li	a5,4
    80003504:	00f62223          	sw	a5,4(a2)
    80003508:	00008517          	auipc	a0,0x8
    8000350c:	f3850513          	addi	a0,a0,-200 # 8000b440 <proc_lock>
    80003510:	08c63c23          	sd	a2,152(a2)
    80003514:	16c000ef          	jal	ra,80003680 <release>
    80003518:	0009b783          	ld	a5,0(s3)
    8000351c:	000a0513          	mv	a0,s4
    80003520:	00078463          	beqz	a5,80003528 <wait_process+0x110>
    80003524:	02078513          	addi	a0,a5,32
    80003528:	000a0593          	mv	a1,s4
    8000352c:	00831797          	auipc	a5,0x831
    80003530:	4e07ba23          	sd	zero,1268(a5) # 80834a20 <current>
    80003534:	bbdfc0ef          	jal	ra,800000f0 <swtch>
    80003538:	00008517          	auipc	a0,0x8
    8000353c:	f0850513          	addi	a0,a0,-248 # 8000b440 <proc_lock>
    80003540:	11c000ef          	jal	ra,8000365c <acquire>
    80003544:	0009b603          	ld	a2,0(s3)
    80003548:	08063c23          	sd	zero,152(a2)
    8000354c:	f15ff06f          	j	80003460 <wait_process+0x48>
    80003550:	00008517          	auipc	a0,0x8
    80003554:	ef050513          	addi	a0,a0,-272 # 8000b440 <proc_lock>
    80003558:	128000ef          	jal	ra,80003680 <release>
    8000355c:	fff00413          	li	s0,-1
    80003560:	f75ff06f          	j	800034d4 <wait_process+0xbc>

0000000080003564 <debug_proc_table>:
    80003564:	fc010113          	addi	sp,sp,-64
    80003568:	00008517          	auipc	a0,0x8
    8000356c:	ed850513          	addi	a0,a0,-296 # 8000b440 <proc_lock>
    80003570:	02113c23          	sd	ra,56(sp)
    80003574:	02813823          	sd	s0,48(sp)
    80003578:	02913423          	sd	s1,40(sp)
    8000357c:	03213023          	sd	s2,32(sp)
    80003580:	01313c23          	sd	s3,24(sp)
    80003584:	01413823          	sd	s4,16(sp)
    80003588:	01513423          	sd	s5,8(sp)
    8000358c:	01613023          	sd	s6,0(sp)
    80003590:	0cc000ef          	jal	ra,8000365c <acquire>
    80003594:	00004517          	auipc	a0,0x4
    80003598:	d8c50513          	addi	a0,a0,-628 # 80007320 <digits+0x428>
    8000359c:	be8fd0ef          	jal	ra,80000984 <printf>
    800035a0:	00008417          	auipc	s0,0x8
    800035a4:	f3840413          	addi	s0,s0,-200 # 8000b4d8 <proc_table+0x8>
    800035a8:	0000d497          	auipc	s1,0xd
    800035ac:	73048493          	addi	s1,s1,1840 # 80010cd8 <bcache+0x8>
    800035b0:	00500a13          	li	s4,5
    800035b4:	00004997          	auipc	s3,0x4
    800035b8:	d6498993          	addi	s3,s3,-668 # 80007318 <digits+0x420>
    800035bc:	00004b17          	auipc	s6,0x4
    800035c0:	d7cb0b13          	addi	s6,s6,-644 # 80007338 <digits+0x440>
    800035c4:	00004917          	auipc	s2,0x4
    800035c8:	ddc90913          	addi	s2,s2,-548 # 800073a0 <queue_slices>
    800035cc:	00004a97          	auipc	s5,0x4
    800035d0:	d3ca8a93          	addi	s5,s5,-708 # 80007308 <digits+0x410>
    800035d4:	ffc42683          	lw	a3,-4(s0)
    800035d8:	000b0513          	mv	a0,s6
    800035dc:	00040793          	mv	a5,s0
    800035e0:	02068c63          	beqz	a3,80003618 <debug_proc_table+0xb4>
    800035e4:	00044583          	lbu	a1,0(s0)
    800035e8:	02069713          	slli	a4,a3,0x20
    800035ec:	01d75713          	srli	a4,a4,0x1d
    800035f0:	00e90733          	add	a4,s2,a4
    800035f4:	00098613          	mv	a2,s3
    800035f8:	00059463          	bnez	a1,80003600 <debug_proc_table+0x9c>
    800035fc:	000a8793          	mv	a5,s5
    80003600:	00da6463          	bltu	s4,a3,80003608 <debug_proc_table+0xa4>
    80003604:	01073603          	ld	a2,16(a4)
    80003608:	08842703          	lw	a4,136(s0)
    8000360c:	09842683          	lw	a3,152(s0)
    80003610:	ff842583          	lw	a1,-8(s0)
    80003614:	b70fd0ef          	jal	ra,80000984 <printf>
    80003618:	16040413          	addi	s0,s0,352
    8000361c:	fa941ce3          	bne	s0,s1,800035d4 <debug_proc_table+0x70>
    80003620:	03013403          	ld	s0,48(sp)
    80003624:	03813083          	ld	ra,56(sp)
    80003628:	02813483          	ld	s1,40(sp)
    8000362c:	02013903          	ld	s2,32(sp)
    80003630:	01813983          	ld	s3,24(sp)
    80003634:	01013a03          	ld	s4,16(sp)
    80003638:	00813a83          	ld	s5,8(sp)
    8000363c:	00013b03          	ld	s6,0(sp)
    80003640:	00008517          	auipc	a0,0x8
    80003644:	e0050513          	addi	a0,a0,-512 # 8000b440 <proc_lock>
    80003648:	04010113          	addi	sp,sp,64
    8000364c:	0340006f          	j	80003680 <release>

0000000080003650 <initlock>:
    80003650:	00052023          	sw	zero,0(a0)
    80003654:	00b53423          	sd	a1,8(a0)
    80003658:	00008067          	ret

000000008000365c <acquire>:
    8000365c:	00100713          	li	a4,1
    80003660:	0080006f          	j	80003668 <acquire+0xc>
    80003664:	00000013          	nop
    80003668:	00070793          	mv	a5,a4
    8000366c:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    80003670:	0007879b          	sext.w	a5,a5
    80003674:	fe0798e3          	bnez	a5,80003664 <acquire+0x8>
    80003678:	0ff0000f          	fence
    8000367c:	00008067          	ret

0000000080003680 <release>:
    80003680:	0ff0000f          	fence
    80003684:	0f50000f          	fence	iorw,ow
    80003688:	0805202f          	amoswap.w	zero,zero,(a0)
    8000368c:	00008067          	ret

0000000080003690 <holding>:
    80003690:	00052503          	lw	a0,0(a0)
    80003694:	0005051b          	sext.w	a0,a0
    80003698:	00a03533          	snez	a0,a0
    8000369c:	00008067          	ret

00000000800036a0 <sem_init>:
    800036a0:	fe010113          	addi	sp,sp,-32
    800036a4:	00813823          	sd	s0,16(sp)
    800036a8:	01213023          	sd	s2,0(sp)
    800036ac:	00050413          	mv	s0,a0
    800036b0:	00058913          	mv	s2,a1
    800036b4:	00850513          	addi	a0,a0,8
    800036b8:	00060593          	mv	a1,a2
    800036bc:	00913423          	sd	s1,8(sp)
    800036c0:	00113c23          	sd	ra,24(sp)
    800036c4:	00060493          	mv	s1,a2
    800036c8:	f89ff0ef          	jal	ra,80003650 <initlock>
    800036cc:	01813083          	ld	ra,24(sp)
    800036d0:	01242023          	sw	s2,0(s0)
    800036d4:	00943c23          	sd	s1,24(s0)
    800036d8:	01013403          	ld	s0,16(sp)
    800036dc:	00813483          	ld	s1,8(sp)
    800036e0:	00013903          	ld	s2,0(sp)
    800036e4:	02010113          	addi	sp,sp,32
    800036e8:	00008067          	ret

00000000800036ec <sem_wait>:
    800036ec:	fe010113          	addi	sp,sp,-32
    800036f0:	00913423          	sd	s1,8(sp)
    800036f4:	00850493          	addi	s1,a0,8
    800036f8:	00813823          	sd	s0,16(sp)
    800036fc:	00050413          	mv	s0,a0
    80003700:	00048513          	mv	a0,s1
    80003704:	00113c23          	sd	ra,24(sp)
    80003708:	f55ff0ef          	jal	ra,8000365c <acquire>
    8000370c:	00042783          	lw	a5,0(s0)
    80003710:	00079c63          	bnez	a5,80003728 <sem_wait+0x3c>
    80003714:	00048593          	mv	a1,s1
    80003718:	00040513          	mv	a0,s0
    8000371c:	f20ff0ef          	jal	ra,80002e3c <sleep>
    80003720:	00042783          	lw	a5,0(s0)
    80003724:	fe0788e3          	beqz	a5,80003714 <sem_wait+0x28>
    80003728:	fff7879b          	addiw	a5,a5,-1
    8000372c:	00f42023          	sw	a5,0(s0)
    80003730:	01013403          	ld	s0,16(sp)
    80003734:	01813083          	ld	ra,24(sp)
    80003738:	00048513          	mv	a0,s1
    8000373c:	00813483          	ld	s1,8(sp)
    80003740:	02010113          	addi	sp,sp,32
    80003744:	f3dff06f          	j	80003680 <release>

0000000080003748 <sem_signal>:
    80003748:	fe010113          	addi	sp,sp,-32
    8000374c:	00913423          	sd	s1,8(sp)
    80003750:	00850493          	addi	s1,a0,8
    80003754:	00813823          	sd	s0,16(sp)
    80003758:	00050413          	mv	s0,a0
    8000375c:	00048513          	mv	a0,s1
    80003760:	00113c23          	sd	ra,24(sp)
    80003764:	ef9ff0ef          	jal	ra,8000365c <acquire>
    80003768:	00042783          	lw	a5,0(s0)
    8000376c:	00040513          	mv	a0,s0
    80003770:	0017879b          	addiw	a5,a5,1
    80003774:	00f42023          	sw	a5,0(s0)
    80003778:	809ff0ef          	jal	ra,80002f80 <wakeup>
    8000377c:	01013403          	ld	s0,16(sp)
    80003780:	01813083          	ld	ra,24(sp)
    80003784:	00048513          	mv	a0,s1
    80003788:	00813483          	ld	s1,8(sp)
    8000378c:	02010113          	addi	sp,sp,32
    80003790:	ef1ff06f          	j	80003680 <release>

0000000080003794 <sys_getpid>:
    80003794:	00831797          	auipc	a5,0x831
    80003798:	28c7b783          	ld	a5,652(a5) # 80834a20 <current>
    8000379c:	00078663          	beqz	a5,800037a8 <sys_getpid+0x14>
    800037a0:	0007a503          	lw	a0,0(a5)
    800037a4:	00008067          	ret
    800037a8:	fff00513          	li	a0,-1
    800037ac:	00008067          	ret

00000000800037b0 <sys_read>:
    800037b0:	fff00513          	li	a0,-1
    800037b4:	00008067          	ret

00000000800037b8 <sys_yield>:
    800037b8:	ff010113          	addi	sp,sp,-16
    800037bc:	00113423          	sd	ra,8(sp)
    800037c0:	de8ff0ef          	jal	ra,80002da8 <yield>
    800037c4:	00813083          	ld	ra,8(sp)
    800037c8:	00000513          	li	a0,0
    800037cc:	01010113          	addi	sp,sp,16
    800037d0:	00008067          	ret

00000000800037d4 <sys_fork>:
    800037d4:	bccff06f          	j	80002ba0 <fork_user_process>

00000000800037d8 <sys_close>:
    800037d8:	fff00513          	li	a0,-1
    800037dc:	00008067          	ret

00000000800037e0 <sys_open>:
    800037e0:	fff00513          	li	a0,-1
    800037e4:	00008067          	ret

00000000800037e8 <sys_exit>:
    800037e8:	ff010113          	addi	sp,sp,-16
    800037ec:	00113423          	sd	ra,8(sp)
    800037f0:	00831797          	auipc	a5,0x831
    800037f4:	2307b783          	ld	a5,560(a5) # 80834a20 <current>
    800037f8:	02078263          	beqz	a5,8000381c <sys_exit+0x34>
    800037fc:	0c87b783          	ld	a5,200(a5)
    80003800:	00078e63          	beqz	a5,8000381c <sys_exit+0x34>
    80003804:	0707a503          	lw	a0,112(a5)
    80003808:	835ff0ef          	jal	ra,8000303c <exit_process>
    8000380c:	00813083          	ld	ra,8(sp)
    80003810:	00000513          	li	a0,0
    80003814:	01010113          	addi	sp,sp,16
    80003818:	00008067          	ret
    8000381c:	00000513          	li	a0,0
    80003820:	81dff0ef          	jal	ra,8000303c <exit_process>
    80003824:	00813083          	ld	ra,8(sp)
    80003828:	00000513          	li	a0,0
    8000382c:	01010113          	addi	sp,sp,16
    80003830:	00008067          	ret

0000000080003834 <sys_sbrk>:
    80003834:	00831797          	auipc	a5,0x831
    80003838:	1ec7b783          	ld	a5,492(a5) # 80834a20 <current>
    8000383c:	00078a63          	beqz	a5,80003850 <sys_sbrk+0x1c>
    80003840:	0c87b783          	ld	a5,200(a5)
    80003844:	00078663          	beqz	a5,80003850 <sys_sbrk+0x1c>
    80003848:	0707a503          	lw	a0,112(a5)
    8000384c:	c8cff06f          	j	80002cd8 <grow_process>
    80003850:	00000513          	li	a0,0
    80003854:	c84ff06f          	j	80002cd8 <grow_process>

0000000080003858 <sys_kill>:
    80003858:	00831797          	auipc	a5,0x831
    8000385c:	1c87b783          	ld	a5,456(a5) # 80834a20 <current>
    80003860:	00078a63          	beqz	a5,80003874 <sys_kill+0x1c>
    80003864:	0c87b783          	ld	a5,200(a5)
    80003868:	00078663          	beqz	a5,80003874 <sys_kill+0x1c>
    8000386c:	0707a503          	lw	a0,112(a5)
    80003870:	8bdff06f          	j	8000312c <kill_process>
    80003874:	00000513          	li	a0,0
    80003878:	8b5ff06f          	j	8000312c <kill_process>

000000008000387c <sys_sleep>:
    8000387c:	fe010113          	addi	sp,sp,-32
    80003880:	00113c23          	sd	ra,24(sp)
    80003884:	00813823          	sd	s0,16(sp)
    80003888:	00913423          	sd	s1,8(sp)
    8000388c:	01213023          	sd	s2,0(sp)
    80003890:	00831797          	auipc	a5,0x831
    80003894:	1907b783          	ld	a5,400(a5) # 80834a20 <current>
    80003898:	04078c63          	beqz	a5,800038f0 <sys_sleep+0x74>
    8000389c:	0c87b783          	ld	a5,200(a5)
    800038a0:	04078863          	beqz	a5,800038f0 <sys_sleep+0x74>
    800038a4:	0707a483          	lw	s1,112(a5)
    800038a8:	00831417          	auipc	s0,0x831
    800038ac:	16040413          	addi	s0,s0,352 # 80834a08 <ticks>
    800038b0:	00043703          	ld	a4,0(s0)
    800038b4:	00043783          	ld	a5,0(s0)
    800038b8:	0007091b          	sext.w	s2,a4
    800038bc:	40e787bb          	subw	a5,a5,a4
    800038c0:	0097da63          	bge	a5,s1,800038d4 <sys_sleep+0x58>
    800038c4:	ce4ff0ef          	jal	ra,80002da8 <yield>
    800038c8:	00043783          	ld	a5,0(s0)
    800038cc:	412787bb          	subw	a5,a5,s2
    800038d0:	fe97cae3          	blt	a5,s1,800038c4 <sys_sleep+0x48>
    800038d4:	01813083          	ld	ra,24(sp)
    800038d8:	01013403          	ld	s0,16(sp)
    800038dc:	00813483          	ld	s1,8(sp)
    800038e0:	00013903          	ld	s2,0(sp)
    800038e4:	00000513          	li	a0,0
    800038e8:	02010113          	addi	sp,sp,32
    800038ec:	00008067          	ret
    800038f0:	00000493          	li	s1,0
    800038f4:	fb5ff06f          	j	800038a8 <sys_sleep+0x2c>

00000000800038f8 <sys_wait>:
    800038f8:	fd010113          	addi	sp,sp,-48
    800038fc:	00913c23          	sd	s1,24(sp)
    80003900:	00831497          	auipc	s1,0x831
    80003904:	12048493          	addi	s1,s1,288 # 80834a20 <current>
    80003908:	0004b783          	ld	a5,0(s1)
    8000390c:	02113423          	sd	ra,40(sp)
    80003910:	02813023          	sd	s0,32(sp)
    80003914:	01213823          	sd	s2,16(sp)
    80003918:	04078263          	beqz	a5,8000395c <sys_wait+0x64>
    8000391c:	0c87b783          	ld	a5,200(a5)
    80003920:	02078e63          	beqz	a5,8000395c <sys_wait+0x64>
    80003924:	0707b903          	ld	s2,112(a5)
    80003928:	00012623          	sw	zero,12(sp)
    8000392c:	02090a63          	beqz	s2,80003960 <sys_wait+0x68>
    80003930:	00c10513          	addi	a0,sp,12
    80003934:	ae5ff0ef          	jal	ra,80003418 <wait_process>
    80003938:	00050413          	mv	s0,a0
    8000393c:	04055663          	bgez	a0,80003988 <sys_wait+0x90>
    80003940:	02813083          	ld	ra,40(sp)
    80003944:	00040513          	mv	a0,s0
    80003948:	02013403          	ld	s0,32(sp)
    8000394c:	01813483          	ld	s1,24(sp)
    80003950:	01013903          	ld	s2,16(sp)
    80003954:	03010113          	addi	sp,sp,48
    80003958:	00008067          	ret
    8000395c:	00012623          	sw	zero,12(sp)
    80003960:	00000513          	li	a0,0
    80003964:	ab5ff0ef          	jal	ra,80003418 <wait_process>
    80003968:	00050413          	mv	s0,a0
    8000396c:	02813083          	ld	ra,40(sp)
    80003970:	00040513          	mv	a0,s0
    80003974:	02013403          	ld	s0,32(sp)
    80003978:	01813483          	ld	s1,24(sp)
    8000397c:	01013903          	ld	s2,16(sp)
    80003980:	03010113          	addi	sp,sp,48
    80003984:	00008067          	ret
    80003988:	0004b783          	ld	a5,0(s1)
    8000398c:	00400693          	li	a3,4
    80003990:	00c10613          	addi	a2,sp,12
    80003994:	0d07b503          	ld	a0,208(a5)
    80003998:	00090593          	mv	a1,s2
    8000399c:	f3dfd0ef          	jal	ra,800018d8 <copyout>
    800039a0:	fa0550e3          	bgez	a0,80003940 <sys_wait+0x48>
    800039a4:	fff00413          	li	s0,-1
    800039a8:	f99ff06f          	j	80003940 <sys_wait+0x48>

00000000800039ac <sys_write>:
    800039ac:	f4010113          	addi	sp,sp,-192
    800039b0:	09313c23          	sd	s3,152(sp)
    800039b4:	00831997          	auipc	s3,0x831
    800039b8:	06c98993          	addi	s3,s3,108 # 80834a20 <current>
    800039bc:	0009b703          	ld	a4,0(s3)
    800039c0:	0a113c23          	sd	ra,184(sp)
    800039c4:	0a813823          	sd	s0,176(sp)
    800039c8:	0a913423          	sd	s1,168(sp)
    800039cc:	0b213023          	sd	s2,160(sp)
    800039d0:	09413823          	sd	s4,144(sp)
    800039d4:	09513423          	sd	s5,136(sp)
    800039d8:	09613023          	sd	s6,128(sp)
    800039dc:	0a070e63          	beqz	a4,80003a98 <sys_write+0xec>
    800039e0:	0c873683          	ld	a3,200(a4)
    800039e4:	0a068e63          	beqz	a3,80003aa0 <sys_write+0xf4>
    800039e8:	0706a783          	lw	a5,112(a3)
    800039ec:	00f00613          	li	a2,15
    800039f0:	0786bb03          	ld	s6,120(a3)
    800039f4:	0806a903          	lw	s2,128(a3)
    800039f8:	0af66063          	bltu	a2,a5,80003a98 <sys_write+0xec>
    800039fc:	01c78793          	addi	a5,a5,28
    80003a00:	00379793          	slli	a5,a5,0x3
    80003a04:	00f707b3          	add	a5,a4,a5
    80003a08:	0007ba03          	ld	s4,0(a5)
    80003a0c:	080a0663          	beqz	s4,80003a98 <sys_write+0xec>
    80003a10:	00000493          	li	s1,0
    80003a14:	08000a93          	li	s5,128
    80003a18:	0140006f          	j	80003a2c <sys_write+0x80>
    80003a1c:	298000ef          	jal	ra,80003cb4 <filewrite>
    80003a20:	06054c63          	bltz	a0,80003a98 <sys_write+0xec>
    80003a24:	008484bb          	addw	s1,s1,s0
    80003a28:	04854263          	blt	a0,s0,80003a6c <sys_write+0xc0>
    80003a2c:	4099043b          	subw	s0,s2,s1
    80003a30:	01648633          	add	a2,s1,s6
    80003a34:	00010593          	mv	a1,sp
    80003a38:	0004079b          	sext.w	a5,s0
    80003a3c:	0324d863          	bge	s1,s2,80003a6c <sys_write+0xc0>
    80003a40:	0009b703          	ld	a4,0(s3)
    80003a44:	00fad463          	bge	s5,a5,80003a4c <sys_write+0xa0>
    80003a48:	08000413          	li	s0,128
    80003a4c:	0d073503          	ld	a0,208(a4)
    80003a50:	00040693          	mv	a3,s0
    80003a54:	e75fd0ef          	jal	ra,800018c8 <copyin>
    80003a58:	00050793          	mv	a5,a0
    80003a5c:	00040613          	mv	a2,s0
    80003a60:	00010593          	mv	a1,sp
    80003a64:	000a0513          	mv	a0,s4
    80003a68:	fa07dae3          	bgez	a5,80003a1c <sys_write+0x70>
    80003a6c:	0b813083          	ld	ra,184(sp)
    80003a70:	0b013403          	ld	s0,176(sp)
    80003a74:	0a013903          	ld	s2,160(sp)
    80003a78:	09813983          	ld	s3,152(sp)
    80003a7c:	09013a03          	ld	s4,144(sp)
    80003a80:	08813a83          	ld	s5,136(sp)
    80003a84:	08013b03          	ld	s6,128(sp)
    80003a88:	00048513          	mv	a0,s1
    80003a8c:	0a813483          	ld	s1,168(sp)
    80003a90:	0c010113          	addi	sp,sp,192
    80003a94:	00008067          	ret
    80003a98:	fff00493          	li	s1,-1
    80003a9c:	fd1ff06f          	j	80003a6c <sys_write+0xc0>
    80003aa0:	0e073783          	ld	a5,224(a4)
    80003aa4:	fe078ae3          	beqz	a5,80003a98 <sys_write+0xec>
    80003aa8:	00000493          	li	s1,0
    80003aac:	fc1ff06f          	j	80003a6c <sys_write+0xc0>

0000000080003ab0 <argint>:
    80003ab0:	00831797          	auipc	a5,0x831
    80003ab4:	f707b783          	ld	a5,-144(a5) # 80834a20 <current>
    80003ab8:	02078863          	beqz	a5,80003ae8 <argint+0x38>
    80003abc:	0c87b703          	ld	a4,200(a5)
    80003ac0:	02070463          	beqz	a4,80003ae8 <argint+0x38>
    80003ac4:	00500793          	li	a5,5
    80003ac8:	02a7e063          	bltu	a5,a0,80003ae8 <argint+0x38>
    80003acc:	00004697          	auipc	a3,0x4
    80003ad0:	91468693          	addi	a3,a3,-1772 # 800073e0 <state_names.0+0x30>
    80003ad4:	00251513          	slli	a0,a0,0x2
    80003ad8:	00d50533          	add	a0,a0,a3
    80003adc:	00052783          	lw	a5,0(a0)
    80003ae0:	00d787b3          	add	a5,a5,a3
    80003ae4:	00078067          	jr	a5
    80003ae8:	00000793          	li	a5,0
    80003aec:	00f5a023          	sw	a5,0(a1)
    80003af0:	00000513          	li	a0,0
    80003af4:	00008067          	ret
    80003af8:	09072783          	lw	a5,144(a4)
    80003afc:	ff1ff06f          	j	80003aec <argint+0x3c>
    80003b00:	09872783          	lw	a5,152(a4)
    80003b04:	fe9ff06f          	j	80003aec <argint+0x3c>
    80003b08:	07072783          	lw	a5,112(a4)
    80003b0c:	fe1ff06f          	j	80003aec <argint+0x3c>
    80003b10:	07872783          	lw	a5,120(a4)
    80003b14:	fd9ff06f          	j	80003aec <argint+0x3c>
    80003b18:	08072783          	lw	a5,128(a4)
    80003b1c:	fd1ff06f          	j	80003aec <argint+0x3c>
    80003b20:	08872783          	lw	a5,136(a4)
    80003b24:	fc9ff06f          	j	80003aec <argint+0x3c>

0000000080003b28 <argaddr>:
    80003b28:	00831797          	auipc	a5,0x831
    80003b2c:	ef87b783          	ld	a5,-264(a5) # 80834a20 <current>
    80003b30:	02078863          	beqz	a5,80003b60 <argaddr+0x38>
    80003b34:	0c87b703          	ld	a4,200(a5)
    80003b38:	02070463          	beqz	a4,80003b60 <argaddr+0x38>
    80003b3c:	00500793          	li	a5,5
    80003b40:	02a7e063          	bltu	a5,a0,80003b60 <argaddr+0x38>
    80003b44:	00004697          	auipc	a3,0x4
    80003b48:	8b468693          	addi	a3,a3,-1868 # 800073f8 <state_names.0+0x48>
    80003b4c:	00251513          	slli	a0,a0,0x2
    80003b50:	00d50533          	add	a0,a0,a3
    80003b54:	00052783          	lw	a5,0(a0)
    80003b58:	00d787b3          	add	a5,a5,a3
    80003b5c:	00078067          	jr	a5
    80003b60:	00000793          	li	a5,0
    80003b64:	00f5b023          	sd	a5,0(a1)
    80003b68:	00000513          	li	a0,0
    80003b6c:	00008067          	ret
    80003b70:	09073783          	ld	a5,144(a4)
    80003b74:	ff1ff06f          	j	80003b64 <argaddr+0x3c>
    80003b78:	09873783          	ld	a5,152(a4)
    80003b7c:	fe9ff06f          	j	80003b64 <argaddr+0x3c>
    80003b80:	07073783          	ld	a5,112(a4)
    80003b84:	fe1ff06f          	j	80003b64 <argaddr+0x3c>
    80003b88:	07873783          	ld	a5,120(a4)
    80003b8c:	fd9ff06f          	j	80003b64 <argaddr+0x3c>
    80003b90:	08073783          	ld	a5,128(a4)
    80003b94:	fd1ff06f          	j	80003b64 <argaddr+0x3c>
    80003b98:	08873783          	ld	a5,136(a4)
    80003b9c:	fc9ff06f          	j	80003b64 <argaddr+0x3c>

0000000080003ba0 <argstr>:
    80003ba0:	00831797          	auipc	a5,0x831
    80003ba4:	e807b783          	ld	a5,-384(a5) # 80834a20 <current>
    80003ba8:	00060693          	mv	a3,a2
    80003bac:	02078863          	beqz	a5,80003bdc <argstr+0x3c>
    80003bb0:	0c87b603          	ld	a2,200(a5)
    80003bb4:	02060463          	beqz	a2,80003bdc <argstr+0x3c>
    80003bb8:	00500713          	li	a4,5
    80003bbc:	02a76063          	bltu	a4,a0,80003bdc <argstr+0x3c>
    80003bc0:	00004817          	auipc	a6,0x4
    80003bc4:	85080813          	addi	a6,a6,-1968 # 80007410 <state_names.0+0x60>
    80003bc8:	00251513          	slli	a0,a0,0x2
    80003bcc:	01050533          	add	a0,a0,a6
    80003bd0:	00052703          	lw	a4,0(a0)
    80003bd4:	01070733          	add	a4,a4,a6
    80003bd8:	00070067          	jr	a4
    80003bdc:	00000613          	li	a2,0
    80003be0:	04058c63          	beqz	a1,80003c38 <argstr+0x98>
    80003be4:	04d05a63          	blez	a3,80003c38 <argstr+0x98>
    80003be8:	0d07b503          	ld	a0,208(a5)
    80003bec:	ff010113          	addi	sp,sp,-16
    80003bf0:	00113423          	sd	ra,8(sp)
    80003bf4:	cddfd0ef          	jal	ra,800018d0 <copyinstr>
    80003bf8:	00813083          	ld	ra,8(sp)
    80003bfc:	41f5551b          	sraiw	a0,a0,0x1f
    80003c00:	01010113          	addi	sp,sp,16
    80003c04:	00008067          	ret
    80003c08:	09063603          	ld	a2,144(a2)
    80003c0c:	fd5ff06f          	j	80003be0 <argstr+0x40>
    80003c10:	09863603          	ld	a2,152(a2)
    80003c14:	fcdff06f          	j	80003be0 <argstr+0x40>
    80003c18:	07063603          	ld	a2,112(a2)
    80003c1c:	fc5ff06f          	j	80003be0 <argstr+0x40>
    80003c20:	07863603          	ld	a2,120(a2)
    80003c24:	fbdff06f          	j	80003be0 <argstr+0x40>
    80003c28:	08063603          	ld	a2,128(a2)
    80003c2c:	fb5ff06f          	j	80003be0 <argstr+0x40>
    80003c30:	08863603          	ld	a2,136(a2)
    80003c34:	fadff06f          	j	80003be0 <argstr+0x40>
    80003c38:	fff00513          	li	a0,-1
    80003c3c:	00008067          	ret

0000000080003c40 <syscall_dispatch>:
    80003c40:	ff010113          	addi	sp,sp,-16
    80003c44:	00813023          	sd	s0,0(sp)
    80003c48:	00831417          	auipc	s0,0x831
    80003c4c:	dd840413          	addi	s0,s0,-552 # 80834a20 <current>
    80003c50:	00043783          	ld	a5,0(s0)
    80003c54:	00113423          	sd	ra,8(sp)
    80003c58:	04078663          	beqz	a5,80003ca4 <syscall_dispatch+0x64>
    80003c5c:	0c87b783          	ld	a5,200(a5)
    80003c60:	04078263          	beqz	a5,80003ca4 <syscall_dispatch+0x64>
    80003c64:	0a87b683          	ld	a3,168(a5)
    80003c68:	00c00713          	li	a4,12
    80003c6c:	fff00513          	li	a0,-1
    80003c70:	02d76863          	bltu	a4,a3,80003ca0 <syscall_dispatch+0x60>
    80003c74:	00169713          	slli	a4,a3,0x1
    80003c78:	00d70733          	add	a4,a4,a3
    80003c7c:	00371713          	slli	a4,a4,0x3
    80003c80:	00004697          	auipc	a3,0x4
    80003c84:	b4068693          	addi	a3,a3,-1216 # 800077c0 <syscall_table>
    80003c88:	00e68733          	add	a4,a3,a4
    80003c8c:	00073703          	ld	a4,0(a4)
    80003c90:	00070863          	beqz	a4,80003ca0 <syscall_dispatch+0x60>
    80003c94:	000700e7          	jalr	a4
    80003c98:	00043783          	ld	a5,0(s0)
    80003c9c:	0c87b783          	ld	a5,200(a5)
    80003ca0:	06a7b823          	sd	a0,112(a5)
    80003ca4:	00813083          	ld	ra,8(sp)
    80003ca8:	00013403          	ld	s0,0(sp)
    80003cac:	01010113          	addi	sp,sp,16
    80003cb0:	00008067          	ret

0000000080003cb4 <filewrite>:
    80003cb4:	06050e63          	beqz	a0,80003d30 <filewrite+0x7c>
    80003cb8:	00452783          	lw	a5,4(a0)
    80003cbc:	06078a63          	beqz	a5,80003d30 <filewrite+0x7c>
    80003cc0:	fe010113          	addi	sp,sp,-32
    80003cc4:	00813823          	sd	s0,16(sp)
    80003cc8:	00113c23          	sd	ra,24(sp)
    80003ccc:	00913423          	sd	s1,8(sp)
    80003cd0:	01213023          	sd	s2,0(sp)
    80003cd4:	00058413          	mv	s0,a1
    80003cd8:	06058063          	beqz	a1,80003d38 <filewrite+0x84>
    80003cdc:	00060913          	mv	s2,a2
    80003ce0:	04064c63          	bltz	a2,80003d38 <filewrite+0x84>
    80003ce4:	02060863          	beqz	a2,80003d14 <filewrite+0x60>
    80003ce8:	fff6049b          	addiw	s1,a2,-1
    80003cec:	02049493          	slli	s1,s1,0x20
    80003cf0:	0204d493          	srli	s1,s1,0x20
    80003cf4:	00158793          	addi	a5,a1,1
    80003cf8:	00f484b3          	add	s1,s1,a5
    80003cfc:	00c0006f          	j	80003d08 <filewrite+0x54>
    80003d00:	b91fc0ef          	jal	ra,80000890 <uart_putc>
    80003d04:	00940863          	beq	s0,s1,80003d14 <filewrite+0x60>
    80003d08:	00044503          	lbu	a0,0(s0)
    80003d0c:	00140413          	addi	s0,s0,1
    80003d10:	fe0518e3          	bnez	a0,80003d00 <filewrite+0x4c>
    80003d14:	00090513          	mv	a0,s2
    80003d18:	01813083          	ld	ra,24(sp)
    80003d1c:	01013403          	ld	s0,16(sp)
    80003d20:	00813483          	ld	s1,8(sp)
    80003d24:	00013903          	ld	s2,0(sp)
    80003d28:	02010113          	addi	sp,sp,32
    80003d2c:	00008067          	ret
    80003d30:	fff00513          	li	a0,-1
    80003d34:	00008067          	ret
    80003d38:	fff00513          	li	a0,-1
    80003d3c:	fddff06f          	j	80003d18 <filewrite+0x64>

0000000080003d40 <fileread>:
    80003d40:	fff00513          	li	a0,-1
    80003d44:	00008067          	ret

0000000080003d48 <fileclose>:
    80003d48:	00000513          	li	a0,0
    80003d4c:	00008067          	ret

0000000080003d50 <initsleeplock>:
    80003d50:	fe010113          	addi	sp,sp,-32
    80003d54:	00813823          	sd	s0,16(sp)
    80003d58:	00058413          	mv	s0,a1
    80003d5c:	00003597          	auipc	a1,0x3
    80003d60:	71c58593          	addi	a1,a1,1820 # 80007478 <state_names.0+0xc8>
    80003d64:	00913423          	sd	s1,8(sp)
    80003d68:	00113c23          	sd	ra,24(sp)
    80003d6c:	00050493          	mv	s1,a0
    80003d70:	8e1ff0ef          	jal	ra,80003650 <initlock>
    80003d74:	00000793          	li	a5,0
    80003d78:	00f00593          	li	a1,15
    80003d7c:	00f40733          	add	a4,s0,a5
    80003d80:	00f486b3          	add	a3,s1,a5
    80003d84:	0007861b          	sext.w	a2,a5
    80003d88:	00178793          	addi	a5,a5,1
    80003d8c:	00040c63          	beqz	s0,80003da4 <initsleeplock+0x54>
    80003d90:	00074703          	lbu	a4,0(a4)
    80003d94:	00070863          	beqz	a4,80003da4 <initsleeplock+0x54>
    80003d98:	00e68823          	sb	a4,16(a3)
    80003d9c:	feb790e3          	bne	a5,a1,80003d7c <initsleeplock+0x2c>
    80003da0:	00f00613          	li	a2,15
    80003da4:	00c48633          	add	a2,s1,a2
    80003da8:	00060823          	sb	zero,16(a2)
    80003dac:	01813083          	ld	ra,24(sp)
    80003db0:	01013403          	ld	s0,16(sp)
    80003db4:	0204a023          	sw	zero,32(s1)
    80003db8:	0204b423          	sd	zero,40(s1)
    80003dbc:	00813483          	ld	s1,8(sp)
    80003dc0:	02010113          	addi	sp,sp,32
    80003dc4:	00008067          	ret

0000000080003dc8 <acquiresleep>:
    80003dc8:	ff010113          	addi	sp,sp,-16
    80003dcc:	00813023          	sd	s0,0(sp)
    80003dd0:	00113423          	sd	ra,8(sp)
    80003dd4:	00050413          	mv	s0,a0
    80003dd8:	885ff0ef          	jal	ra,8000365c <acquire>
    80003ddc:	02042783          	lw	a5,32(s0)
    80003de0:	00078c63          	beqz	a5,80003df8 <acquiresleep+0x30>
    80003de4:	00040593          	mv	a1,s0
    80003de8:	00040513          	mv	a0,s0
    80003dec:	850ff0ef          	jal	ra,80002e3c <sleep>
    80003df0:	02042783          	lw	a5,32(s0)
    80003df4:	fe0798e3          	bnez	a5,80003de4 <acquiresleep+0x1c>
    80003df8:	00100793          	li	a5,1
    80003dfc:	02f42023          	sw	a5,32(s0)
    80003e00:	00831797          	auipc	a5,0x831
    80003e04:	c207b783          	ld	a5,-992(a5) # 80834a20 <current>
    80003e08:	02f43423          	sd	a5,40(s0)
    80003e0c:	00040513          	mv	a0,s0
    80003e10:	00013403          	ld	s0,0(sp)
    80003e14:	00813083          	ld	ra,8(sp)
    80003e18:	01010113          	addi	sp,sp,16
    80003e1c:	865ff06f          	j	80003680 <release>

0000000080003e20 <releasesleep>:
    80003e20:	ff010113          	addi	sp,sp,-16
    80003e24:	00113423          	sd	ra,8(sp)
    80003e28:	00813023          	sd	s0,0(sp)
    80003e2c:	00050413          	mv	s0,a0
    80003e30:	82dff0ef          	jal	ra,8000365c <acquire>
    80003e34:	00040513          	mv	a0,s0
    80003e38:	02042023          	sw	zero,32(s0)
    80003e3c:	02043423          	sd	zero,40(s0)
    80003e40:	940ff0ef          	jal	ra,80002f80 <wakeup>
    80003e44:	00040513          	mv	a0,s0
    80003e48:	00013403          	ld	s0,0(sp)
    80003e4c:	00813083          	ld	ra,8(sp)
    80003e50:	01010113          	addi	sp,sp,16
    80003e54:	82dff06f          	j	80003680 <release>

0000000080003e58 <holdingsleep>:
    80003e58:	fe010113          	addi	sp,sp,-32
    80003e5c:	00913423          	sd	s1,8(sp)
    80003e60:	00050493          	mv	s1,a0
    80003e64:	00813823          	sd	s0,16(sp)
    80003e68:	00113c23          	sd	ra,24(sp)
    80003e6c:	ff0ff0ef          	jal	ra,8000365c <acquire>
    80003e70:	0204a403          	lw	s0,32(s1)
    80003e74:	00040c63          	beqz	s0,80003e8c <holdingsleep+0x34>
    80003e78:	0284b403          	ld	s0,40(s1)
    80003e7c:	00831797          	auipc	a5,0x831
    80003e80:	ba47b783          	ld	a5,-1116(a5) # 80834a20 <current>
    80003e84:	40f40433          	sub	s0,s0,a5
    80003e88:	00143413          	seqz	s0,s0
    80003e8c:	00048513          	mv	a0,s1
    80003e90:	ff0ff0ef          	jal	ra,80003680 <release>
    80003e94:	01813083          	ld	ra,24(sp)
    80003e98:	00040513          	mv	a0,s0
    80003e9c:	01013403          	ld	s0,16(sp)
    80003ea0:	00813483          	ld	s1,8(sp)
    80003ea4:	02010113          	addi	sp,sp,32
    80003ea8:	00008067          	ret

0000000080003eac <binit>:
    80003eac:	fc010113          	addi	sp,sp,-64
    80003eb0:	00003597          	auipc	a1,0x3
    80003eb4:	5d858593          	addi	a1,a1,1496 # 80007488 <state_names.0+0xd8>
    80003eb8:	0000d517          	auipc	a0,0xd
    80003ebc:	e1850513          	addi	a0,a0,-488 # 80010cd0 <bcache>
    80003ec0:	02913423          	sd	s1,40(sp)
    80003ec4:	01313c23          	sd	s3,24(sp)
    80003ec8:	0002e497          	auipc	s1,0x2e
    80003ecc:	e0848493          	addi	s1,s1,-504 # 80031cd0 <bcache+0x21000>
    80003ed0:	0002e997          	auipc	s3,0x2e
    80003ed4:	b1098993          	addi	s3,s3,-1264 # 800319e0 <bcache+0x20d10>
    80003ed8:	02113c23          	sd	ra,56(sp)
    80003edc:	02813823          	sd	s0,48(sp)
    80003ee0:	03213023          	sd	s2,32(sp)
    80003ee4:	01413823          	sd	s4,16(sp)
    80003ee8:	01513423          	sd	s5,8(sp)
    80003eec:	f64ff0ef          	jal	ra,80003650 <initlock>
    80003ef0:	0002f797          	auipc	a5,0x2f
    80003ef4:	c407bc23          	sd	zero,-936(a5) # 80032b48 <bcache+0x21e78>
    80003ef8:	0002f797          	auipc	a5,0x2f
    80003efc:	c407bc23          	sd	zero,-936(a5) # 80032b50 <bcache+0x21e80>
    80003f00:	d734b423          	sd	s3,-664(s1)
    80003f04:	d734b823          	sd	s3,-656(s1)
    80003f08:	0002f797          	auipc	a5,0x2f
    80003f0c:	b4078793          	addi	a5,a5,-1216 # 80032a48 <bcache+0x21d78>
    80003f10:	0002f717          	auipc	a4,0x2f
    80003f14:	c3870713          	addi	a4,a4,-968 # 80032b48 <bcache+0x21e78>
    80003f18:	0007b023          	sd	zero,0(a5)
    80003f1c:	00878793          	addi	a5,a5,8
    80003f20:	fee79ce3          	bne	a5,a4,80003f18 <binit+0x6c>
    80003f24:	00001937          	lui	s2,0x1
    80003f28:	0000d417          	auipc	s0,0xd
    80003f2c:	db840413          	addi	s0,s0,-584 # 80010ce0 <bcache+0x10>
    80003f30:	0002ea97          	auipc	s5,0x2e
    80003f34:	ab0a8a93          	addi	s5,s5,-1360 # 800319e0 <bcache+0x20d10>
    80003f38:	00003a17          	auipc	s4,0x3
    80003f3c:	558a0a13          	addi	s4,s4,1368 # 80007490 <state_names.0+0xe0>
    80003f40:	06890913          	addi	s2,s2,104 # 1068 <_binary_user_test_basic_bin_size+0x927>
    80003f44:	01040513          	addi	a0,s0,16
    80003f48:	000a0593          	mv	a1,s4
    80003f4c:	00042023          	sw	zero,0(s0)
    80003f50:	00042223          	sw	zero,4(s0)
    80003f54:	00042423          	sw	zero,8(s0)
    80003f58:	00042623          	sw	zero,12(s0)
    80003f5c:	04042023          	sw	zero,64(s0)
    80003f60:	04042223          	sw	zero,68(s0)
    80003f64:	04043823          	sd	zero,80(s0)
    80003f68:	04043423          	sd	zero,72(s0)
    80003f6c:	de5ff0ef          	jal	ra,80003d50 <initsleeplock>
    80003f70:	d684b783          	ld	a5,-664(s1)
    80003f74:	07343023          	sd	s3,96(s0)
    80003f78:	04f43c23          	sd	a5,88(s0)
    80003f7c:	0687b023          	sd	s0,96(a5)
    80003f80:	d684b423          	sd	s0,-664(s1)
    80003f84:	01240433          	add	s0,s0,s2
    80003f88:	fb541ee3          	bne	s0,s5,80003f44 <binit+0x98>
    80003f8c:	03813083          	ld	ra,56(sp)
    80003f90:	03013403          	ld	s0,48(sp)
    80003f94:	02813483          	ld	s1,40(sp)
    80003f98:	02013903          	ld	s2,32(sp)
    80003f9c:	01813983          	ld	s3,24(sp)
    80003fa0:	01013a03          	ld	s4,16(sp)
    80003fa4:	00813a83          	ld	s5,8(sp)
    80003fa8:	04010113          	addi	sp,sp,64
    80003fac:	00008067          	ret

0000000080003fb0 <bio_register_backend>:
    80003fb0:	fe010113          	addi	sp,sp,-32
    80003fb4:	00913423          	sd	s1,8(sp)
    80003fb8:	00050493          	mv	s1,a0
    80003fbc:	0000d517          	auipc	a0,0xd
    80003fc0:	d1450513          	addi	a0,a0,-748 # 80010cd0 <bcache>
    80003fc4:	00813823          	sd	s0,16(sp)
    80003fc8:	00113c23          	sd	ra,24(sp)
    80003fcc:	00058413          	mv	s0,a1
    80003fd0:	e8cff0ef          	jal	ra,8000365c <acquire>
    80003fd4:	0002f797          	auipc	a5,0x2f
    80003fd8:	cfc78793          	addi	a5,a5,-772 # 80032cd0 <icache+0xa8>
    80003fdc:	e887b023          	sd	s0,-384(a5)
    80003fe0:	01013403          	ld	s0,16(sp)
    80003fe4:	01813083          	ld	ra,24(sp)
    80003fe8:	e697bc23          	sd	s1,-392(a5)
    80003fec:	00813483          	ld	s1,8(sp)
    80003ff0:	0000d517          	auipc	a0,0xd
    80003ff4:	ce050513          	addi	a0,a0,-800 # 80010cd0 <bcache>
    80003ff8:	02010113          	addi	sp,sp,32
    80003ffc:	e84ff06f          	j	80003680 <release>

0000000080004000 <bread>:
    80004000:	fd010113          	addi	sp,sp,-48
    80004004:	00913c23          	sd	s1,24(sp)
    80004008:	00050493          	mv	s1,a0
    8000400c:	0000d517          	auipc	a0,0xd
    80004010:	cc450513          	addi	a0,a0,-828 # 80010cd0 <bcache>
    80004014:	01213823          	sd	s2,16(sp)
    80004018:	02113423          	sd	ra,40(sp)
    8000401c:	00058913          	mv	s2,a1
    80004020:	02813023          	sd	s0,32(sp)
    80004024:	01313423          	sd	s3,8(sp)
    80004028:	e34ff0ef          	jal	ra,8000365c <acquire>
    8000402c:	0124c6b3          	xor	a3,s1,s2
    80004030:	000047b7          	lui	a5,0x4
    80004034:	01f6f693          	andi	a3,a3,31
    80004038:	3ae78793          	addi	a5,a5,942 # 43ae <_binary_user_test_basic_bin_size+0x3c6d>
    8000403c:	00f687b3          	add	a5,a3,a5
    80004040:	0000d597          	auipc	a1,0xd
    80004044:	c9058593          	addi	a1,a1,-880 # 80010cd0 <bcache>
    80004048:	00379793          	slli	a5,a5,0x3
    8000404c:	00f587b3          	add	a5,a1,a5
    80004050:	0087b603          	ld	a2,8(a5)
    80004054:	0a060463          	beqz	a2,800040fc <bread+0xfc>
    80004058:	00060413          	mv	s0,a2
    8000405c:	00c0006f          	j	80004068 <bread+0x68>
    80004060:	04843403          	ld	s0,72(s0)
    80004064:	08040c63          	beqz	s0,800040fc <bread+0xfc>
    80004068:	00842783          	lw	a5,8(s0)
    8000406c:	fe979ae3          	bne	a5,s1,80004060 <bread+0x60>
    80004070:	00c42783          	lw	a5,12(s0)
    80004074:	ff2796e3          	bne	a5,s2,80004060 <bread+0x60>
    80004078:	04042783          	lw	a5,64(s0)
    8000407c:	0000d517          	auipc	a0,0xd
    80004080:	c5450513          	addi	a0,a0,-940 # 80010cd0 <bcache>
    80004084:	0017879b          	addiw	a5,a5,1
    80004088:	04f42023          	sw	a5,64(s0)
    8000408c:	df4ff0ef          	jal	ra,80003680 <release>
    80004090:	01040513          	addi	a0,s0,16
    80004094:	d35ff0ef          	jal	ra,80003dc8 <acquiresleep>
    80004098:	00042783          	lw	a5,0(s0)
    8000409c:	0e079863          	bnez	a5,8000418c <bread+0x18c>
    800040a0:	0000d517          	auipc	a0,0xd
    800040a4:	c3050513          	addi	a0,a0,-976 # 80010cd0 <bcache>
    800040a8:	db4ff0ef          	jal	ra,8000365c <acquire>
    800040ac:	0000d517          	auipc	a0,0xd
    800040b0:	c2450513          	addi	a0,a0,-988 # 80010cd0 <bcache>
    800040b4:	0002f997          	auipc	s3,0x2f
    800040b8:	a949b983          	ld	s3,-1388(s3) # 80032b48 <bcache+0x21e78>
    800040bc:	dc4ff0ef          	jal	ra,80003680 <release>
    800040c0:	14098863          	beqz	s3,80004210 <bread+0x210>
    800040c4:	00048513          	mv	a0,s1
    800040c8:	06840613          	addi	a2,s0,104
    800040cc:	00090593          	mv	a1,s2
    800040d0:	000980e7          	jalr	s3
    800040d4:	00100793          	li	a5,1
    800040d8:	02813083          	ld	ra,40(sp)
    800040dc:	00f42023          	sw	a5,0(s0)
    800040e0:	00040513          	mv	a0,s0
    800040e4:	02013403          	ld	s0,32(sp)
    800040e8:	01813483          	ld	s1,24(sp)
    800040ec:	01013903          	ld	s2,16(sp)
    800040f0:	00813983          	ld	s3,8(sp)
    800040f4:	03010113          	addi	sp,sp,48
    800040f8:	00008067          	ret
    800040fc:	0002e417          	auipc	s0,0x2e
    80004100:	94443403          	ld	s0,-1724(s0) # 80031a40 <bcache+0x20d70>
    80004104:	0002e717          	auipc	a4,0x2e
    80004108:	8dc70713          	addi	a4,a4,-1828 # 800319e0 <bcache+0x20d10>
    8000410c:	00e41863          	bne	s0,a4,8000411c <bread+0x11c>
    80004110:	11c0006f          	j	8000422c <bread+0x22c>
    80004114:	06043403          	ld	s0,96(s0)
    80004118:	10e40a63          	beq	s0,a4,8000422c <bread+0x22c>
    8000411c:	04042783          	lw	a5,64(s0)
    80004120:	fe079ae3          	bnez	a5,80004114 <bread+0x114>
    80004124:	04442783          	lw	a5,68(s0)
    80004128:	08079263          	bnez	a5,800041ac <bread+0x1ac>
    8000412c:	00100793          	li	a5,1
    80004130:	00942423          	sw	s1,8(s0)
    80004134:	01242623          	sw	s2,12(s0)
    80004138:	00043023          	sd	zero,0(s0)
    8000413c:	04f42023          	sw	a5,64(s0)
    80004140:	04c43423          	sd	a2,72(s0)
    80004144:	04043823          	sd	zero,80(s0)
    80004148:	00060463          	beqz	a2,80004150 <bread+0x150>
    8000414c:	04863823          	sd	s0,80(a2)
    80004150:	000047b7          	lui	a5,0x4
    80004154:	3ae78793          	addi	a5,a5,942 # 43ae <_binary_user_test_basic_bin_size+0x3c6d>
    80004158:	00f687b3          	add	a5,a3,a5
    8000415c:	00379793          	slli	a5,a5,0x3
    80004160:	00f587b3          	add	a5,a1,a5
    80004164:	0087b423          	sd	s0,8(a5)
    80004168:	00100793          	li	a5,1
    8000416c:	04f42223          	sw	a5,68(s0)
    80004170:	0000d517          	auipc	a0,0xd
    80004174:	b6050513          	addi	a0,a0,-1184 # 80010cd0 <bcache>
    80004178:	d08ff0ef          	jal	ra,80003680 <release>
    8000417c:	01040513          	addi	a0,s0,16
    80004180:	c49ff0ef          	jal	ra,80003dc8 <acquiresleep>
    80004184:	00042783          	lw	a5,0(s0)
    80004188:	f0078ce3          	beqz	a5,800040a0 <bread+0xa0>
    8000418c:	02813083          	ld	ra,40(sp)
    80004190:	00040513          	mv	a0,s0
    80004194:	02013403          	ld	s0,32(sp)
    80004198:	01813483          	ld	s1,24(sp)
    8000419c:	01013903          	ld	s2,16(sp)
    800041a0:	00813983          	ld	s3,8(sp)
    800041a4:	03010113          	addi	sp,sp,48
    800041a8:	00008067          	ret
    800041ac:	00c42703          	lw	a4,12(s0)
    800041b0:	00842783          	lw	a5,8(s0)
    800041b4:	00e7c7b3          	xor	a5,a5,a4
    800041b8:	00004737          	lui	a4,0x4
    800041bc:	3ae70713          	addi	a4,a4,942 # 43ae <_binary_user_test_basic_bin_size+0x3c6d>
    800041c0:	01f7f793          	andi	a5,a5,31
    800041c4:	00e787b3          	add	a5,a5,a4
    800041c8:	00379793          	slli	a5,a5,0x3
    800041cc:	00f587b3          	add	a5,a1,a5
    800041d0:	0087b703          	ld	a4,8(a5)
    800041d4:	04870663          	beq	a4,s0,80004220 <bread+0x220>
    800041d8:	04843703          	ld	a4,72(s0)
    800041dc:	00070663          	beqz	a4,800041e8 <bread+0x1e8>
    800041e0:	05043783          	ld	a5,80(s0)
    800041e4:	04f73823          	sd	a5,80(a4)
    800041e8:	05043783          	ld	a5,80(s0)
    800041ec:	00078463          	beqz	a5,800041f4 <bread+0x1f4>
    800041f0:	04e7b423          	sd	a4,72(a5)
    800041f4:	000047b7          	lui	a5,0x4
    800041f8:	3ae78793          	addi	a5,a5,942 # 43ae <_binary_user_test_basic_bin_size+0x3c6d>
    800041fc:	00f687b3          	add	a5,a3,a5
    80004200:	00379793          	slli	a5,a5,0x3
    80004204:	00f587b3          	add	a5,a1,a5
    80004208:	0087b603          	ld	a2,8(a5)
    8000420c:	f21ff06f          	j	8000412c <bread+0x12c>
    80004210:	00003517          	auipc	a0,0x3
    80004214:	2a050513          	addi	a0,a0,672 # 800074b0 <state_names.0+0x100>
    80004218:	a85fc0ef          	jal	ra,80000c9c <panic>
    8000421c:	ea9ff06f          	j	800040c4 <bread+0xc4>
    80004220:	04843703          	ld	a4,72(s0)
    80004224:	00e7b423          	sd	a4,8(a5)
    80004228:	fb5ff06f          	j	800041dc <bread+0x1dc>
    8000422c:	0000d517          	auipc	a0,0xd
    80004230:	aa450513          	addi	a0,a0,-1372 # 80010cd0 <bcache>
    80004234:	c4cff0ef          	jal	ra,80003680 <release>
    80004238:	00003517          	auipc	a0,0x3
    8000423c:	26050513          	addi	a0,a0,608 # 80007498 <state_names.0+0xe8>
    80004240:	a5dfc0ef          	jal	ra,80000c9c <panic>
    80004244:	00002783          	lw	a5,0(zero) # 0 <_binary_user_test_basic_bin_size-0x741>
    80004248:	00100073          	ebreak

000000008000424c <bwrite>:
    8000424c:	fe010113          	addi	sp,sp,-32
    80004250:	00813823          	sd	s0,16(sp)
    80004254:	00050413          	mv	s0,a0
    80004258:	01050513          	addi	a0,a0,16
    8000425c:	00113c23          	sd	ra,24(sp)
    80004260:	00913423          	sd	s1,8(sp)
    80004264:	bf5ff0ef          	jal	ra,80003e58 <holdingsleep>
    80004268:	04050a63          	beqz	a0,800042bc <bwrite+0x70>
    8000426c:	0000d517          	auipc	a0,0xd
    80004270:	a6450513          	addi	a0,a0,-1436 # 80010cd0 <bcache>
    80004274:	be8ff0ef          	jal	ra,8000365c <acquire>
    80004278:	0000d517          	auipc	a0,0xd
    8000427c:	a5850513          	addi	a0,a0,-1448 # 80010cd0 <bcache>
    80004280:	0002f497          	auipc	s1,0x2f
    80004284:	8d04b483          	ld	s1,-1840(s1) # 80032b50 <bcache+0x21e80>
    80004288:	bf8ff0ef          	jal	ra,80003680 <release>
    8000428c:	04048063          	beqz	s1,800042cc <bwrite+0x80>
    80004290:	00c42583          	lw	a1,12(s0)
    80004294:	00842503          	lw	a0,8(s0)
    80004298:	06840613          	addi	a2,s0,104
    8000429c:	000480e7          	jalr	s1
    800042a0:	00100793          	li	a5,1
    800042a4:	01813083          	ld	ra,24(sp)
    800042a8:	00f43023          	sd	a5,0(s0)
    800042ac:	01013403          	ld	s0,16(sp)
    800042b0:	00813483          	ld	s1,8(sp)
    800042b4:	02010113          	addi	sp,sp,32
    800042b8:	00008067          	ret
    800042bc:	00003517          	auipc	a0,0x3
    800042c0:	20c50513          	addi	a0,a0,524 # 800074c8 <state_names.0+0x118>
    800042c4:	9d9fc0ef          	jal	ra,80000c9c <panic>
    800042c8:	fa5ff06f          	j	8000426c <bwrite+0x20>
    800042cc:	00003517          	auipc	a0,0x3
    800042d0:	21450513          	addi	a0,a0,532 # 800074e0 <state_names.0+0x130>
    800042d4:	9c9fc0ef          	jal	ra,80000c9c <panic>
    800042d8:	fb9ff06f          	j	80004290 <bwrite+0x44>

00000000800042dc <bmarkdirty>:
    800042dc:	ff010113          	addi	sp,sp,-16
    800042e0:	00813023          	sd	s0,0(sp)
    800042e4:	00050413          	mv	s0,a0
    800042e8:	01050513          	addi	a0,a0,16
    800042ec:	00113423          	sd	ra,8(sp)
    800042f0:	b69ff0ef          	jal	ra,80003e58 <holdingsleep>
    800042f4:	00050e63          	beqz	a0,80004310 <bmarkdirty+0x34>
    800042f8:	00100793          	li	a5,1
    800042fc:	00813083          	ld	ra,8(sp)
    80004300:	00f42223          	sw	a5,4(s0)
    80004304:	00013403          	ld	s0,0(sp)
    80004308:	01010113          	addi	sp,sp,16
    8000430c:	00008067          	ret
    80004310:	00003517          	auipc	a0,0x3
    80004314:	1e850513          	addi	a0,a0,488 # 800074f8 <state_names.0+0x148>
    80004318:	985fc0ef          	jal	ra,80000c9c <panic>
    8000431c:	00100793          	li	a5,1
    80004320:	00813083          	ld	ra,8(sp)
    80004324:	00f42223          	sw	a5,4(s0)
    80004328:	00013403          	ld	s0,0(sp)
    8000432c:	01010113          	addi	sp,sp,16
    80004330:	00008067          	ret

0000000080004334 <brelse>:
    80004334:	fe010113          	addi	sp,sp,-32
    80004338:	00913423          	sd	s1,8(sp)
    8000433c:	01050493          	addi	s1,a0,16
    80004340:	00813823          	sd	s0,16(sp)
    80004344:	00050413          	mv	s0,a0
    80004348:	00048513          	mv	a0,s1
    8000434c:	00113c23          	sd	ra,24(sp)
    80004350:	b09ff0ef          	jal	ra,80003e58 <holdingsleep>
    80004354:	04050463          	beqz	a0,8000439c <brelse+0x68>
    80004358:	00048513          	mv	a0,s1
    8000435c:	ac5ff0ef          	jal	ra,80003e20 <releasesleep>
    80004360:	0000d517          	auipc	a0,0xd
    80004364:	97050513          	addi	a0,a0,-1680 # 80010cd0 <bcache>
    80004368:	af4ff0ef          	jal	ra,8000365c <acquire>
    8000436c:	04042783          	lw	a5,64(s0)
    80004370:	04f05a63          	blez	a5,800043c4 <brelse+0x90>
    80004374:	fff7871b          	addiw	a4,a5,-1
    80004378:	04e42023          	sw	a4,64(s0)
    8000437c:	06070863          	beqz	a4,800043ec <brelse+0xb8>
    80004380:	01013403          	ld	s0,16(sp)
    80004384:	01813083          	ld	ra,24(sp)
    80004388:	00813483          	ld	s1,8(sp)
    8000438c:	0000d517          	auipc	a0,0xd
    80004390:	94450513          	addi	a0,a0,-1724 # 80010cd0 <bcache>
    80004394:	02010113          	addi	sp,sp,32
    80004398:	ae8ff06f          	j	80003680 <release>
    8000439c:	00003517          	auipc	a0,0x3
    800043a0:	17450513          	addi	a0,a0,372 # 80007510 <state_names.0+0x160>
    800043a4:	8f9fc0ef          	jal	ra,80000c9c <panic>
    800043a8:	00048513          	mv	a0,s1
    800043ac:	a75ff0ef          	jal	ra,80003e20 <releasesleep>
    800043b0:	0000d517          	auipc	a0,0xd
    800043b4:	92050513          	addi	a0,a0,-1760 # 80010cd0 <bcache>
    800043b8:	aa4ff0ef          	jal	ra,8000365c <acquire>
    800043bc:	04042783          	lw	a5,64(s0)
    800043c0:	faf04ae3          	bgtz	a5,80004374 <brelse+0x40>
    800043c4:	0000d517          	auipc	a0,0xd
    800043c8:	90c50513          	addi	a0,a0,-1780 # 80010cd0 <bcache>
    800043cc:	ab4ff0ef          	jal	ra,80003680 <release>
    800043d0:	00003517          	auipc	a0,0x3
    800043d4:	15850513          	addi	a0,a0,344 # 80007528 <state_names.0+0x178>
    800043d8:	8c5fc0ef          	jal	ra,80000c9c <panic>
    800043dc:	04042783          	lw	a5,64(s0)
    800043e0:	fff7871b          	addiw	a4,a5,-1
    800043e4:	04e42023          	sw	a4,64(s0)
    800043e8:	f8071ce3          	bnez	a4,80004380 <brelse+0x4c>
    800043ec:	05843703          	ld	a4,88(s0)
    800043f0:	06043783          	ld	a5,96(s0)
    800043f4:	00070663          	beqz	a4,80004400 <brelse+0xcc>
    800043f8:	06f73023          	sd	a5,96(a4)
    800043fc:	06043783          	ld	a5,96(s0)
    80004400:	00078463          	beqz	a5,80004408 <brelse+0xd4>
    80004404:	04e7bc23          	sd	a4,88(a5)
    80004408:	04043c23          	sd	zero,88(s0)
    8000440c:	0002e797          	auipc	a5,0x2e
    80004410:	8c478793          	addi	a5,a5,-1852 # 80031cd0 <bcache+0x21000>
    80004414:	d687b703          	ld	a4,-664(a5)
    80004418:	0002d697          	auipc	a3,0x2d
    8000441c:	5c868693          	addi	a3,a3,1480 # 800319e0 <bcache+0x20d10>
    80004420:	06d43023          	sd	a3,96(s0)
    80004424:	04e43c23          	sd	a4,88(s0)
    80004428:	06873023          	sd	s0,96(a4)
    8000442c:	d687b423          	sd	s0,-664(a5)
    80004430:	01013403          	ld	s0,16(sp)
    80004434:	01813083          	ld	ra,24(sp)
    80004438:	00813483          	ld	s1,8(sp)
    8000443c:	0000d517          	auipc	a0,0xd
    80004440:	89450513          	addi	a0,a0,-1900 # 80010cd0 <bcache>
    80004444:	02010113          	addi	sp,sp,32
    80004448:	a38ff06f          	j	80003680 <release>

000000008000444c <bpin>:
    8000444c:	ff010113          	addi	sp,sp,-16
    80004450:	00813023          	sd	s0,0(sp)
    80004454:	00050413          	mv	s0,a0
    80004458:	0000d517          	auipc	a0,0xd
    8000445c:	87850513          	addi	a0,a0,-1928 # 80010cd0 <bcache>
    80004460:	00113423          	sd	ra,8(sp)
    80004464:	9f8ff0ef          	jal	ra,8000365c <acquire>
    80004468:	04042783          	lw	a5,64(s0)
    8000446c:	00813083          	ld	ra,8(sp)
    80004470:	0000d517          	auipc	a0,0xd
    80004474:	86050513          	addi	a0,a0,-1952 # 80010cd0 <bcache>
    80004478:	0017879b          	addiw	a5,a5,1
    8000447c:	04f42023          	sw	a5,64(s0)
    80004480:	00013403          	ld	s0,0(sp)
    80004484:	01010113          	addi	sp,sp,16
    80004488:	9f8ff06f          	j	80003680 <release>

000000008000448c <bunpin>:
    8000448c:	ff010113          	addi	sp,sp,-16
    80004490:	00813023          	sd	s0,0(sp)
    80004494:	00050413          	mv	s0,a0
    80004498:	0000d517          	auipc	a0,0xd
    8000449c:	83850513          	addi	a0,a0,-1992 # 80010cd0 <bcache>
    800044a0:	00113423          	sd	ra,8(sp)
    800044a4:	9b8ff0ef          	jal	ra,8000365c <acquire>
    800044a8:	04042783          	lw	a5,64(s0)
    800044ac:	08f05263          	blez	a5,80004530 <bunpin+0xa4>
    800044b0:	fff7871b          	addiw	a4,a5,-1
    800044b4:	04e42023          	sw	a4,64(s0)
    800044b8:	00070e63          	beqz	a4,800044d4 <bunpin+0x48>
    800044bc:	00013403          	ld	s0,0(sp)
    800044c0:	00813083          	ld	ra,8(sp)
    800044c4:	0000d517          	auipc	a0,0xd
    800044c8:	80c50513          	addi	a0,a0,-2036 # 80010cd0 <bcache>
    800044cc:	01010113          	addi	sp,sp,16
    800044d0:	9b0ff06f          	j	80003680 <release>
    800044d4:	05843703          	ld	a4,88(s0)
    800044d8:	06043783          	ld	a5,96(s0)
    800044dc:	00070663          	beqz	a4,800044e8 <bunpin+0x5c>
    800044e0:	06f73023          	sd	a5,96(a4)
    800044e4:	06043783          	ld	a5,96(s0)
    800044e8:	00078463          	beqz	a5,800044f0 <bunpin+0x64>
    800044ec:	04e7bc23          	sd	a4,88(a5)
    800044f0:	04043c23          	sd	zero,88(s0)
    800044f4:	0002d797          	auipc	a5,0x2d
    800044f8:	7dc78793          	addi	a5,a5,2012 # 80031cd0 <bcache+0x21000>
    800044fc:	d687b703          	ld	a4,-664(a5)
    80004500:	0002d697          	auipc	a3,0x2d
    80004504:	4e068693          	addi	a3,a3,1248 # 800319e0 <bcache+0x20d10>
    80004508:	06d43023          	sd	a3,96(s0)
    8000450c:	04e43c23          	sd	a4,88(s0)
    80004510:	06873023          	sd	s0,96(a4)
    80004514:	d687b423          	sd	s0,-664(a5)
    80004518:	00013403          	ld	s0,0(sp)
    8000451c:	00813083          	ld	ra,8(sp)
    80004520:	0000c517          	auipc	a0,0xc
    80004524:	7b050513          	addi	a0,a0,1968 # 80010cd0 <bcache>
    80004528:	01010113          	addi	sp,sp,16
    8000452c:	954ff06f          	j	80003680 <release>
    80004530:	0000c517          	auipc	a0,0xc
    80004534:	7a050513          	addi	a0,a0,1952 # 80010cd0 <bcache>
    80004538:	948ff0ef          	jal	ra,80003680 <release>
    8000453c:	00003517          	auipc	a0,0x3
    80004540:	00450513          	addi	a0,a0,4 # 80007540 <state_names.0+0x190>
    80004544:	f58fc0ef          	jal	ra,80000c9c <panic>
    80004548:	04042783          	lw	a5,64(s0)
    8000454c:	f65ff06f          	j	800044b0 <bunpin+0x24>

0000000080004550 <bsyncdev>:
    80004550:	fa010113          	addi	sp,sp,-96
    80004554:	05213023          	sd	s2,64(sp)
    80004558:	03513423          	sd	s5,40(sp)
    8000455c:	00050913          	mv	s2,a0
    80004560:	0002da97          	auipc	s5,0x2d
    80004564:	770a8a93          	addi	s5,s5,1904 # 80031cd0 <bcache+0x21000>
    80004568:	0000c517          	auipc	a0,0xc
    8000456c:	76850513          	addi	a0,a0,1896 # 80010cd0 <bcache>
    80004570:	04813823          	sd	s0,80(sp)
    80004574:	03313c23          	sd	s3,56(sp)
    80004578:	03413823          	sd	s4,48(sp)
    8000457c:	03613023          	sd	s6,32(sp)
    80004580:	01713c23          	sd	s7,24(sp)
    80004584:	04113c23          	sd	ra,88(sp)
    80004588:	04913423          	sd	s1,72(sp)
    8000458c:	01813823          	sd	s8,16(sp)
    80004590:	01913423          	sd	s9,8(sp)
    80004594:	8c8ff0ef          	jal	ra,8000365c <acquire>
    80004598:	d68ab403          	ld	s0,-664(s5)
    8000459c:	0002d997          	auipc	s3,0x2d
    800045a0:	44498993          	addi	s3,s3,1092 # 800319e0 <bcache+0x20d10>
    800045a4:	0000ca17          	auipc	s4,0xc
    800045a8:	72ca0a13          	addi	s4,s4,1836 # 80010cd0 <bcache>
    800045ac:	0002eb17          	auipc	s6,0x2e
    800045b0:	724b0b13          	addi	s6,s6,1828 # 80032cd0 <icache+0xa8>
    800045b4:	00003b97          	auipc	s7,0x3
    800045b8:	fa4b8b93          	addi	s7,s7,-92 # 80007558 <state_names.0+0x1a8>
    800045bc:	01340c63          	beq	s0,s3,800045d4 <bsyncdev+0x84>
    800045c0:	00842783          	lw	a5,8(s0)
    800045c4:	00040493          	mv	s1,s0
    800045c8:	05843403          	ld	s0,88(s0)
    800045cc:	05278263          	beq	a5,s2,80004610 <bsyncdev+0xc0>
    800045d0:	ff3418e3          	bne	s0,s3,800045c0 <bsyncdev+0x70>
    800045d4:	05013403          	ld	s0,80(sp)
    800045d8:	05813083          	ld	ra,88(sp)
    800045dc:	04813483          	ld	s1,72(sp)
    800045e0:	04013903          	ld	s2,64(sp)
    800045e4:	03813983          	ld	s3,56(sp)
    800045e8:	03013a03          	ld	s4,48(sp)
    800045ec:	02813a83          	ld	s5,40(sp)
    800045f0:	02013b03          	ld	s6,32(sp)
    800045f4:	01813b83          	ld	s7,24(sp)
    800045f8:	01013c03          	ld	s8,16(sp)
    800045fc:	00813c83          	ld	s9,8(sp)
    80004600:	0000c517          	auipc	a0,0xc
    80004604:	6d050513          	addi	a0,a0,1744 # 80010cd0 <bcache>
    80004608:	06010113          	addi	sp,sp,96
    8000460c:	874ff06f          	j	80003680 <release>
    80004610:	0044a783          	lw	a5,4(s1)
    80004614:	fa078ee3          	beqz	a5,800045d0 <bsyncdev+0x80>
    80004618:	0404a783          	lw	a5,64(s1)
    8000461c:	000a0513          	mv	a0,s4
    80004620:	01048c13          	addi	s8,s1,16
    80004624:	0017879b          	addiw	a5,a5,1
    80004628:	04f4a023          	sw	a5,64(s1)
    8000462c:	854ff0ef          	jal	ra,80003680 <release>
    80004630:	000c0513          	mv	a0,s8
    80004634:	f94ff0ef          	jal	ra,80003dc8 <acquiresleep>
    80004638:	000a0513          	mv	a0,s4
    8000463c:	820ff0ef          	jal	ra,8000365c <acquire>
    80004640:	e80b3c83          	ld	s9,-384(s6)
    80004644:	000a0513          	mv	a0,s4
    80004648:	838ff0ef          	jal	ra,80003680 <release>
    8000464c:	060c8a63          	beqz	s9,800046c0 <bsyncdev+0x170>
    80004650:	00c4a583          	lw	a1,12(s1)
    80004654:	0084a503          	lw	a0,8(s1)
    80004658:	06848613          	addi	a2,s1,104
    8000465c:	000c80e7          	jalr	s9
    80004660:	000c0513          	mv	a0,s8
    80004664:	0004a223          	sw	zero,4(s1)
    80004668:	fb8ff0ef          	jal	ra,80003e20 <releasesleep>
    8000466c:	000a0513          	mv	a0,s4
    80004670:	fedfe0ef          	jal	ra,8000365c <acquire>
    80004674:	0404a783          	lw	a5,64(s1)
    80004678:	fff7871b          	addiw	a4,a5,-1
    8000467c:	04e4a023          	sw	a4,64(s1)
    80004680:	f40718e3          	bnez	a4,800045d0 <bsyncdev+0x80>
    80004684:	0584b703          	ld	a4,88(s1)
    80004688:	0604b783          	ld	a5,96(s1)
    8000468c:	00070663          	beqz	a4,80004698 <bsyncdev+0x148>
    80004690:	06f73023          	sd	a5,96(a4)
    80004694:	0604b783          	ld	a5,96(s1)
    80004698:	00078463          	beqz	a5,800046a0 <bsyncdev+0x150>
    8000469c:	04e7bc23          	sd	a4,88(a5)
    800046a0:	0404bc23          	sd	zero,88(s1)
    800046a4:	d68ab783          	ld	a5,-664(s5)
    800046a8:	0734b023          	sd	s3,96(s1)
    800046ac:	04f4bc23          	sd	a5,88(s1)
    800046b0:	0697b023          	sd	s1,96(a5)
    800046b4:	d69ab423          	sd	s1,-664(s5)
    800046b8:	f13414e3          	bne	s0,s3,800045c0 <bsyncdev+0x70>
    800046bc:	f19ff06f          	j	800045d4 <bsyncdev+0x84>
    800046c0:	000b8513          	mv	a0,s7
    800046c4:	dd8fc0ef          	jal	ra,80000c9c <panic>
    800046c8:	f89ff06f          	j	80004650 <bsyncdev+0x100>

00000000800046cc <write_head>:
    800046cc:	ff010113          	addi	sp,sp,-16
    800046d0:	00813023          	sd	s0,0(sp)
    800046d4:	0002e417          	auipc	s0,0x2e
    800046d8:	48440413          	addi	s0,s0,1156 # 80032b58 <log>
    800046dc:	01042583          	lw	a1,16(s0)
    800046e0:	01842503          	lw	a0,24(s0)
    800046e4:	00113423          	sd	ra,8(sp)
    800046e8:	919ff0ef          	jal	ra,80004000 <bread>
    800046ec:	02442783          	lw	a5,36(s0)
    800046f0:	00050413          	mv	s0,a0
    800046f4:	06f52423          	sw	a5,104(a0)
    800046f8:	02f05e63          	blez	a5,80004734 <write_head+0x68>
    800046fc:	fff7869b          	addiw	a3,a5,-1
    80004700:	02069693          	slli	a3,a3,0x20
    80004704:	01e6d693          	srli	a3,a3,0x1e
    80004708:	0002e617          	auipc	a2,0x2e
    8000470c:	47c60613          	addi	a2,a2,1148 # 80032b84 <log+0x2c>
    80004710:	0002e797          	auipc	a5,0x2e
    80004714:	47078793          	addi	a5,a5,1136 # 80032b80 <log+0x28>
    80004718:	06c50713          	addi	a4,a0,108
    8000471c:	00c686b3          	add	a3,a3,a2
    80004720:	0007a603          	lw	a2,0(a5)
    80004724:	00478793          	addi	a5,a5,4
    80004728:	00470713          	addi	a4,a4,4
    8000472c:	fec72e23          	sw	a2,-4(a4)
    80004730:	fed798e3          	bne	a5,a3,80004720 <write_head+0x54>
    80004734:	00040513          	mv	a0,s0
    80004738:	b15ff0ef          	jal	ra,8000424c <bwrite>
    8000473c:	00040513          	mv	a0,s0
    80004740:	00013403          	ld	s0,0(sp)
    80004744:	00813083          	ld	ra,8(sp)
    80004748:	01010113          	addi	sp,sp,16
    8000474c:	be9ff06f          	j	80004334 <brelse>

0000000080004750 <install_trans>:
    80004750:	fc010113          	addi	sp,sp,-64
    80004754:	03213023          	sd	s2,32(sp)
    80004758:	0002e917          	auipc	s2,0x2e
    8000475c:	40090913          	addi	s2,s2,1024 # 80032b58 <log>
    80004760:	02492783          	lw	a5,36(s2)
    80004764:	02113c23          	sd	ra,56(sp)
    80004768:	02813823          	sd	s0,48(sp)
    8000476c:	02913423          	sd	s1,40(sp)
    80004770:	01313c23          	sd	s3,24(sp)
    80004774:	01413823          	sd	s4,16(sp)
    80004778:	01513423          	sd	s5,8(sp)
    8000477c:	01613023          	sd	s6,0(sp)
    80004780:	08f05863          	blez	a5,80004810 <install_trans+0xc0>
    80004784:	00001ab7          	lui	s5,0x1
    80004788:	00050b13          	mv	s6,a0
    8000478c:	0002ea17          	auipc	s4,0x2e
    80004790:	3f4a0a13          	addi	s4,s4,1012 # 80032b80 <log+0x28>
    80004794:	00000993          	li	s3,0
    80004798:	068a8a93          	addi	s5,s5,104 # 1068 <_binary_user_test_basic_bin_size+0x927>
    8000479c:	01092583          	lw	a1,16(s2)
    800047a0:	01892503          	lw	a0,24(s2)
    800047a4:	0015859b          	addiw	a1,a1,1
    800047a8:	013585bb          	addw	a1,a1,s3
    800047ac:	855ff0ef          	jal	ra,80004000 <bread>
    800047b0:	00050493          	mv	s1,a0
    800047b4:	000a2583          	lw	a1,0(s4)
    800047b8:	01892503          	lw	a0,24(s2)
    800047bc:	845ff0ef          	jal	ra,80004000 <bread>
    800047c0:	00050413          	mv	s0,a0
    800047c4:	06848793          	addi	a5,s1,104
    800047c8:	06850713          	addi	a4,a0,104
    800047cc:	01548633          	add	a2,s1,s5
    800047d0:	0007c683          	lbu	a3,0(a5)
    800047d4:	00178793          	addi	a5,a5,1
    800047d8:	00170713          	addi	a4,a4,1
    800047dc:	fed70fa3          	sb	a3,-1(a4)
    800047e0:	fec798e3          	bne	a5,a2,800047d0 <install_trans+0x80>
    800047e4:	00040513          	mv	a0,s0
    800047e8:	a65ff0ef          	jal	ra,8000424c <bwrite>
    800047ec:	040b0663          	beqz	s6,80004838 <install_trans+0xe8>
    800047f0:	00048513          	mv	a0,s1
    800047f4:	b41ff0ef          	jal	ra,80004334 <brelse>
    800047f8:	00040513          	mv	a0,s0
    800047fc:	b39ff0ef          	jal	ra,80004334 <brelse>
    80004800:	02492783          	lw	a5,36(s2)
    80004804:	0019899b          	addiw	s3,s3,1
    80004808:	004a0a13          	addi	s4,s4,4
    8000480c:	f8f9c8e3          	blt	s3,a5,8000479c <install_trans+0x4c>
    80004810:	03813083          	ld	ra,56(sp)
    80004814:	03013403          	ld	s0,48(sp)
    80004818:	02813483          	ld	s1,40(sp)
    8000481c:	02013903          	ld	s2,32(sp)
    80004820:	01813983          	ld	s3,24(sp)
    80004824:	01013a03          	ld	s4,16(sp)
    80004828:	00813a83          	ld	s5,8(sp)
    8000482c:	00013b03          	ld	s6,0(sp)
    80004830:	04010113          	addi	sp,sp,64
    80004834:	00008067          	ret
    80004838:	00040513          	mv	a0,s0
    8000483c:	c51ff0ef          	jal	ra,8000448c <bunpin>
    80004840:	fb1ff06f          	j	800047f0 <install_trans+0xa0>

0000000080004844 <log_recover>:
    80004844:	ff010113          	addi	sp,sp,-16
    80004848:	00813023          	sd	s0,0(sp)
    8000484c:	0002e417          	auipc	s0,0x2e
    80004850:	30c40413          	addi	s0,s0,780 # 80032b58 <log>
    80004854:	01042583          	lw	a1,16(s0)
    80004858:	01842503          	lw	a0,24(s0)
    8000485c:	00113423          	sd	ra,8(sp)
    80004860:	fa0ff0ef          	jal	ra,80004000 <bread>
    80004864:	06852703          	lw	a4,104(a0)
    80004868:	01f00693          	li	a3,31
    8000486c:	02e42223          	sw	a4,36(s0)
    80004870:	02e6f863          	bgeu	a3,a4,800048a0 <log_recover+0x5c>
    80004874:	0002e797          	auipc	a5,0x2e
    80004878:	3007a423          	sw	zero,776(a5) # 80032b7c <log+0x24>
    8000487c:	ab9ff0ef          	jal	ra,80004334 <brelse>
    80004880:	00100513          	li	a0,1
    80004884:	ecdff0ef          	jal	ra,80004750 <install_trans>
    80004888:	00013403          	ld	s0,0(sp)
    8000488c:	00813083          	ld	ra,8(sp)
    80004890:	0002e797          	auipc	a5,0x2e
    80004894:	2e07a623          	sw	zero,748(a5) # 80032b7c <log+0x24>
    80004898:	01010113          	addi	sp,sp,16
    8000489c:	e31ff06f          	j	800046cc <write_head>
    800048a0:	fc070ee3          	beqz	a4,8000487c <log_recover+0x38>
    800048a4:	0007079b          	sext.w	a5,a4
    800048a8:	fff7861b          	addiw	a2,a5,-1
    800048ac:	02061613          	slli	a2,a2,0x20
    800048b0:	01e65693          	srli	a3,a2,0x1e
    800048b4:	07050613          	addi	a2,a0,112
    800048b8:	06c50793          	addi	a5,a0,108
    800048bc:	0002e717          	auipc	a4,0x2e
    800048c0:	2c470713          	addi	a4,a4,708 # 80032b80 <log+0x28>
    800048c4:	00c68633          	add	a2,a3,a2
    800048c8:	0007a683          	lw	a3,0(a5)
    800048cc:	00478793          	addi	a5,a5,4
    800048d0:	00470713          	addi	a4,a4,4
    800048d4:	fed72e23          	sw	a3,-4(a4)
    800048d8:	fec798e3          	bne	a5,a2,800048c8 <log_recover+0x84>
    800048dc:	fa1ff06f          	j	8000487c <log_recover+0x38>

00000000800048e0 <log_init>:
    800048e0:	fe010113          	addi	sp,sp,-32
    800048e4:	00813823          	sd	s0,16(sp)
    800048e8:	0002e417          	auipc	s0,0x2e
    800048ec:	27040413          	addi	s0,s0,624 # 80032b58 <log>
    800048f0:	00913423          	sd	s1,8(sp)
    800048f4:	00003597          	auipc	a1,0x3
    800048f8:	c7c58593          	addi	a1,a1,-900 # 80007570 <state_names.0+0x1c0>
    800048fc:	00050493          	mv	s1,a0
    80004900:	00040513          	mv	a0,s0
    80004904:	00113c23          	sd	ra,24(sp)
    80004908:	d49fe0ef          	jal	ra,80003650 <initlock>
    8000490c:	00100793          	li	a5,1
    80004910:	02579793          	slli	a5,a5,0x25
    80004914:	00278793          	addi	a5,a5,2
    80004918:	00942c23          	sw	s1,24(s0)
    8000491c:	00f43823          	sd	a5,16(s0)
    80004920:	00042e23          	sw	zero,28(s0)
    80004924:	02043023          	sd	zero,32(s0)
    80004928:	01013403          	ld	s0,16(sp)
    8000492c:	01813083          	ld	ra,24(sp)
    80004930:	00813483          	ld	s1,8(sp)
    80004934:	02010113          	addi	sp,sp,32
    80004938:	f0dff06f          	j	80004844 <log_recover>

000000008000493c <begin_op>:
    8000493c:	ff010113          	addi	sp,sp,-16
    80004940:	0002e517          	auipc	a0,0x2e
    80004944:	21850513          	addi	a0,a0,536 # 80032b58 <log>
    80004948:	00813023          	sd	s0,0(sp)
    8000494c:	00113423          	sd	ra,8(sp)
    80004950:	0002e417          	auipc	s0,0x2e
    80004954:	20840413          	addi	s0,s0,520 # 80032b58 <log>
    80004958:	d05fe0ef          	jal	ra,8000365c <acquire>
    8000495c:	0080006f          	j	80004964 <begin_op+0x28>
    80004960:	cdcfe0ef          	jal	ra,80002e3c <sleep>
    80004964:	02042783          	lw	a5,32(s0)
    80004968:	00040593          	mv	a1,s0
    8000496c:	0002e517          	auipc	a0,0x2e
    80004970:	1ec50513          	addi	a0,a0,492 # 80032b58 <log>
    80004974:	fe0796e3          	bnez	a5,80004960 <begin_op+0x24>
    80004978:	01c42703          	lw	a4,28(s0)
    8000497c:	02442603          	lw	a2,36(s0)
    80004980:	01442683          	lw	a3,20(s0)
    80004984:	0017071b          	addiw	a4,a4,1
    80004988:	0027179b          	slliw	a5,a4,0x2
    8000498c:	00e787bb          	addw	a5,a5,a4
    80004990:	0017979b          	slliw	a5,a5,0x1
    80004994:	00c787bb          	addw	a5,a5,a2
    80004998:	fff6869b          	addiw	a3,a3,-1
    8000499c:	fcf6e2e3          	bltu	a3,a5,80004960 <begin_op+0x24>
    800049a0:	00e42e23          	sw	a4,28(s0)
    800049a4:	00013403          	ld	s0,0(sp)
    800049a8:	00813083          	ld	ra,8(sp)
    800049ac:	0002e517          	auipc	a0,0x2e
    800049b0:	1ac50513          	addi	a0,a0,428 # 80032b58 <log>
    800049b4:	01010113          	addi	sp,sp,16
    800049b8:	cc9fe06f          	j	80003680 <release>

00000000800049bc <end_op>:
    800049bc:	fc010113          	addi	sp,sp,-64
    800049c0:	02913423          	sd	s1,40(sp)
    800049c4:	0002e497          	auipc	s1,0x2e
    800049c8:	19448493          	addi	s1,s1,404 # 80032b58 <log>
    800049cc:	00048513          	mv	a0,s1
    800049d0:	02113c23          	sd	ra,56(sp)
    800049d4:	02813823          	sd	s0,48(sp)
    800049d8:	03213023          	sd	s2,32(sp)
    800049dc:	01313c23          	sd	s3,24(sp)
    800049e0:	01413823          	sd	s4,16(sp)
    800049e4:	01513423          	sd	s5,8(sp)
    800049e8:	c75fe0ef          	jal	ra,8000365c <acquire>
    800049ec:	01c4a783          	lw	a5,28(s1)
    800049f0:	14f05663          	blez	a5,80004b3c <end_op+0x180>
    800049f4:	0204a703          	lw	a4,32(s1)
    800049f8:	fff7841b          	addiw	s0,a5,-1
    800049fc:	0084ae23          	sw	s0,28(s1)
    80004a00:	12071463          	bnez	a4,80004b28 <end_op+0x16c>
    80004a04:	0002e517          	auipc	a0,0x2e
    80004a08:	15450513          	addi	a0,a0,340 # 80032b58 <log>
    80004a0c:	02041a63          	bnez	s0,80004a40 <end_op+0x84>
    80004a10:	00100793          	li	a5,1
    80004a14:	02f4a023          	sw	a5,32(s1)
    80004a18:	c69fe0ef          	jal	ra,80003680 <release>
    80004a1c:	0244a783          	lw	a5,36(s1)
    80004a20:	04f04863          	bgtz	a5,80004a70 <end_op+0xb4>
    80004a24:	0002e517          	auipc	a0,0x2e
    80004a28:	13450513          	addi	a0,a0,308 # 80032b58 <log>
    80004a2c:	c31fe0ef          	jal	ra,8000365c <acquire>
    80004a30:	0002e517          	auipc	a0,0x2e
    80004a34:	12850513          	addi	a0,a0,296 # 80032b58 <log>
    80004a38:	0002e797          	auipc	a5,0x2e
    80004a3c:	1407a023          	sw	zero,320(a5) # 80032b78 <log+0x20>
    80004a40:	d40fe0ef          	jal	ra,80002f80 <wakeup>
    80004a44:	03013403          	ld	s0,48(sp)
    80004a48:	03813083          	ld	ra,56(sp)
    80004a4c:	02813483          	ld	s1,40(sp)
    80004a50:	02013903          	ld	s2,32(sp)
    80004a54:	01813983          	ld	s3,24(sp)
    80004a58:	01013a03          	ld	s4,16(sp)
    80004a5c:	00813a83          	ld	s5,8(sp)
    80004a60:	0002e517          	auipc	a0,0x2e
    80004a64:	0f850513          	addi	a0,a0,248 # 80032b58 <log>
    80004a68:	04010113          	addi	sp,sp,64
    80004a6c:	c15fe06f          	j	80003680 <release>
    80004a70:	00001ab7          	lui	s5,0x1
    80004a74:	0002ea17          	auipc	s4,0x2e
    80004a78:	10ca0a13          	addi	s4,s4,268 # 80032b80 <log+0x28>
    80004a7c:	068a8a93          	addi	s5,s5,104 # 1068 <_binary_user_test_basic_bin_size+0x927>
    80004a80:	0104a583          	lw	a1,16(s1)
    80004a84:	0184a503          	lw	a0,24(s1)
    80004a88:	0015859b          	addiw	a1,a1,1
    80004a8c:	008585bb          	addw	a1,a1,s0
    80004a90:	d70ff0ef          	jal	ra,80004000 <bread>
    80004a94:	00050913          	mv	s2,a0
    80004a98:	000a2583          	lw	a1,0(s4)
    80004a9c:	0184a503          	lw	a0,24(s1)
    80004aa0:	d60ff0ef          	jal	ra,80004000 <bread>
    80004aa4:	00050993          	mv	s3,a0
    80004aa8:	06850793          	addi	a5,a0,104
    80004aac:	06890713          	addi	a4,s2,104
    80004ab0:	01550633          	add	a2,a0,s5
    80004ab4:	0007c683          	lbu	a3,0(a5)
    80004ab8:	00178793          	addi	a5,a5,1
    80004abc:	00170713          	addi	a4,a4,1
    80004ac0:	fed70fa3          	sb	a3,-1(a4)
    80004ac4:	fec798e3          	bne	a5,a2,80004ab4 <end_op+0xf8>
    80004ac8:	00090513          	mv	a0,s2
    80004acc:	f80ff0ef          	jal	ra,8000424c <bwrite>
    80004ad0:	00098513          	mv	a0,s3
    80004ad4:	861ff0ef          	jal	ra,80004334 <brelse>
    80004ad8:	00090513          	mv	a0,s2
    80004adc:	859ff0ef          	jal	ra,80004334 <brelse>
    80004ae0:	0244a783          	lw	a5,36(s1)
    80004ae4:	0014041b          	addiw	s0,s0,1
    80004ae8:	004a0a13          	addi	s4,s4,4
    80004aec:	f8f44ae3          	blt	s0,a5,80004a80 <end_op+0xc4>
    80004af0:	bddff0ef          	jal	ra,800046cc <write_head>
    80004af4:	00000513          	li	a0,0
    80004af8:	c59ff0ef          	jal	ra,80004750 <install_trans>
    80004afc:	0002e797          	auipc	a5,0x2e
    80004b00:	0807a023          	sw	zero,128(a5) # 80032b7c <log+0x24>
    80004b04:	bc9ff0ef          	jal	ra,800046cc <write_head>
    80004b08:	0002e517          	auipc	a0,0x2e
    80004b0c:	05050513          	addi	a0,a0,80 # 80032b58 <log>
    80004b10:	b4dfe0ef          	jal	ra,8000365c <acquire>
    80004b14:	0002e517          	auipc	a0,0x2e
    80004b18:	04450513          	addi	a0,a0,68 # 80032b58 <log>
    80004b1c:	0002e797          	auipc	a5,0x2e
    80004b20:	0407ae23          	sw	zero,92(a5) # 80032b78 <log+0x20>
    80004b24:	f1dff06f          	j	80004a40 <end_op+0x84>
    80004b28:	00003517          	auipc	a0,0x3
    80004b2c:	a6850513          	addi	a0,a0,-1432 # 80007590 <state_names.0+0x1e0>
    80004b30:	96cfc0ef          	jal	ra,80000c9c <panic>
    80004b34:	01c4a403          	lw	s0,28(s1)
    80004b38:	ecdff06f          	j	80004a04 <end_op+0x48>
    80004b3c:	00003517          	auipc	a0,0x3
    80004b40:	a3c50513          	addi	a0,a0,-1476 # 80007578 <state_names.0+0x1c8>
    80004b44:	958fc0ef          	jal	ra,80000c9c <panic>
    80004b48:	01c4a783          	lw	a5,28(s1)
    80004b4c:	ea9ff06f          	j	800049f4 <end_op+0x38>

0000000080004b50 <log_write>:
    80004b50:	fe010113          	addi	sp,sp,-32
    80004b54:	00913423          	sd	s1,8(sp)
    80004b58:	00050493          	mv	s1,a0
    80004b5c:	01050513          	addi	a0,a0,16
    80004b60:	00113c23          	sd	ra,24(sp)
    80004b64:	00813823          	sd	s0,16(sp)
    80004b68:	af0ff0ef          	jal	ra,80003e58 <holdingsleep>
    80004b6c:	0c050663          	beqz	a0,80004c38 <log_write+0xe8>
    80004b70:	0002e417          	auipc	s0,0x2e
    80004b74:	fe840413          	addi	s0,s0,-24 # 80032b58 <log>
    80004b78:	00040513          	mv	a0,s0
    80004b7c:	ae1fe0ef          	jal	ra,8000365c <acquire>
    80004b80:	02442783          	lw	a5,36(s0)
    80004b84:	01e00713          	li	a4,30
    80004b88:	06f76a63          	bltu	a4,a5,80004bfc <log_write+0xac>
    80004b8c:	01442703          	lw	a4,20(s0)
    80004b90:	fff7071b          	addiw	a4,a4,-1
    80004b94:	06e7f463          	bgeu	a5,a4,80004bfc <log_write+0xac>
    80004b98:	01c42783          	lw	a5,28(s0)
    80004b9c:	08f05063          	blez	a5,80004c1c <log_write+0xcc>
    80004ba0:	02442603          	lw	a2,36(s0)
    80004ba4:	00c4a583          	lw	a1,12(s1)
    80004ba8:	0ac05063          	blez	a2,80004c48 <log_write+0xf8>
    80004bac:	0002e717          	auipc	a4,0x2e
    80004bb0:	fd470713          	addi	a4,a4,-44 # 80032b80 <log+0x28>
    80004bb4:	00000793          	li	a5,0
    80004bb8:	00c0006f          	j	80004bc4 <log_write+0x74>
    80004bbc:	0017879b          	addiw	a5,a5,1
    80004bc0:	0af60663          	beq	a2,a5,80004c6c <log_write+0x11c>
    80004bc4:	00072683          	lw	a3,0(a4)
    80004bc8:	00470713          	addi	a4,a4,4
    80004bcc:	feb698e3          	bne	a3,a1,80004bbc <log_write+0x6c>
    80004bd0:	00878793          	addi	a5,a5,8
    80004bd4:	00279793          	slli	a5,a5,0x2
    80004bd8:	00f407b3          	add	a5,s0,a5
    80004bdc:	01013403          	ld	s0,16(sp)
    80004be0:	01813083          	ld	ra,24(sp)
    80004be4:	00813483          	ld	s1,8(sp)
    80004be8:	00b7a423          	sw	a1,8(a5)
    80004bec:	0002e517          	auipc	a0,0x2e
    80004bf0:	f6c50513          	addi	a0,a0,-148 # 80032b58 <log>
    80004bf4:	02010113          	addi	sp,sp,32
    80004bf8:	a89fe06f          	j	80003680 <release>
    80004bfc:	0002e517          	auipc	a0,0x2e
    80004c00:	f5c50513          	addi	a0,a0,-164 # 80032b58 <log>
    80004c04:	a7dfe0ef          	jal	ra,80003680 <release>
    80004c08:	00003517          	auipc	a0,0x3
    80004c0c:	9c050513          	addi	a0,a0,-1600 # 800075c8 <state_names.0+0x218>
    80004c10:	88cfc0ef          	jal	ra,80000c9c <panic>
    80004c14:	01c42783          	lw	a5,28(s0)
    80004c18:	f8f044e3          	bgtz	a5,80004ba0 <log_write+0x50>
    80004c1c:	0002e517          	auipc	a0,0x2e
    80004c20:	f3c50513          	addi	a0,a0,-196 # 80032b58 <log>
    80004c24:	a5dfe0ef          	jal	ra,80003680 <release>
    80004c28:	00003517          	auipc	a0,0x3
    80004c2c:	9b850513          	addi	a0,a0,-1608 # 800075e0 <state_names.0+0x230>
    80004c30:	86cfc0ef          	jal	ra,80000c9c <panic>
    80004c34:	f6dff06f          	j	80004ba0 <log_write+0x50>
    80004c38:	00003517          	auipc	a0,0x3
    80004c3c:	97050513          	addi	a0,a0,-1680 # 800075a8 <state_names.0+0x1f8>
    80004c40:	85cfc0ef          	jal	ra,80000c9c <panic>
    80004c44:	f2dff06f          	j	80004b70 <log_write+0x20>
    80004c48:	02b42423          	sw	a1,40(s0)
    80004c4c:	02060863          	beqz	a2,80004c7c <log_write+0x12c>
    80004c50:	01013403          	ld	s0,16(sp)
    80004c54:	01813083          	ld	ra,24(sp)
    80004c58:	00813483          	ld	s1,8(sp)
    80004c5c:	0002e517          	auipc	a0,0x2e
    80004c60:	efc50513          	addi	a0,a0,-260 # 80032b58 <log>
    80004c64:	02010113          	addi	sp,sp,32
    80004c68:	a19fe06f          	j	80003680 <release>
    80004c6c:	00860793          	addi	a5,a2,8
    80004c70:	00279793          	slli	a5,a5,0x2
    80004c74:	00f407b3          	add	a5,s0,a5
    80004c78:	00b7a423          	sw	a1,8(a5)
    80004c7c:	00048513          	mv	a0,s1
    80004c80:	fccff0ef          	jal	ra,8000444c <bpin>
    80004c84:	02442783          	lw	a5,36(s0)
    80004c88:	01813083          	ld	ra,24(sp)
    80004c8c:	00813483          	ld	s1,8(sp)
    80004c90:	0017879b          	addiw	a5,a5,1
    80004c94:	02f42223          	sw	a5,36(s0)
    80004c98:	01013403          	ld	s0,16(sp)
    80004c9c:	0002e517          	auipc	a0,0x2e
    80004ca0:	ebc50513          	addi	a0,a0,-324 # 80032b58 <log>
    80004ca4:	02010113          	addi	sp,sp,32
    80004ca8:	9d9fe06f          	j	80003680 <release>

0000000080004cac <bfree>:
    80004cac:	fe010113          	addi	sp,sp,-32
    80004cb0:	01213023          	sd	s2,0(sp)
    80004cb4:	0002e917          	auipc	s2,0x2e
    80004cb8:	f4c90913          	addi	s2,s2,-180 # 80032c00 <sb>
    80004cbc:	02092783          	lw	a5,32(s2)
    80004cc0:	00813823          	sd	s0,16(sp)
    80004cc4:	00913423          	sd	s1,8(sp)
    80004cc8:	00113c23          	sd	ra,24(sp)
    80004ccc:	00058413          	mv	s0,a1
    80004cd0:	00050493          	mv	s1,a0
    80004cd4:	06f5ee63          	bltu	a1,a5,80004d50 <bfree+0xa4>
    80004cd8:	01892703          	lw	a4,24(s2)
    80004cdc:	40f4043b          	subw	s0,s0,a5
    80004ce0:	00f4559b          	srliw	a1,s0,0xf
    80004ce4:	00e585bb          	addw	a1,a1,a4
    80004ce8:	00048513          	mv	a0,s1
    80004cec:	03141413          	slli	s0,s0,0x31
    80004cf0:	b10ff0ef          	jal	ra,80004000 <bread>
    80004cf4:	03445913          	srli	s2,s0,0x34
    80004cf8:	01250933          	add	s2,a0,s2
    80004cfc:	06894703          	lbu	a4,104(s2)
    80004d00:	03145413          	srli	s0,s0,0x31
    80004d04:	00747413          	andi	s0,s0,7
    80004d08:	408757bb          	sraw	a5,a4,s0
    80004d0c:	0017f793          	andi	a5,a5,1
    80004d10:	00050493          	mv	s1,a0
    80004d14:	04078863          	beqz	a5,80004d64 <bfree+0xb8>
    80004d18:	00100793          	li	a5,1
    80004d1c:	0087943b          	sllw	s0,a5,s0
    80004d20:	fff44413          	not	s0,s0
    80004d24:	00e47433          	and	s0,s0,a4
    80004d28:	06890423          	sb	s0,104(s2)
    80004d2c:	00048513          	mv	a0,s1
    80004d30:	e21ff0ef          	jal	ra,80004b50 <log_write>
    80004d34:	01013403          	ld	s0,16(sp)
    80004d38:	01813083          	ld	ra,24(sp)
    80004d3c:	00013903          	ld	s2,0(sp)
    80004d40:	00048513          	mv	a0,s1
    80004d44:	00813483          	ld	s1,8(sp)
    80004d48:	02010113          	addi	sp,sp,32
    80004d4c:	de8ff06f          	j	80004334 <brelse>
    80004d50:	00003517          	auipc	a0,0x3
    80004d54:	8b050513          	addi	a0,a0,-1872 # 80007600 <state_names.0+0x250>
    80004d58:	f45fb0ef          	jal	ra,80000c9c <panic>
    80004d5c:	02092783          	lw	a5,32(s2)
    80004d60:	f79ff06f          	j	80004cd8 <bfree+0x2c>
    80004d64:	00003517          	auipc	a0,0x3
    80004d68:	8a450513          	addi	a0,a0,-1884 # 80007608 <state_names.0+0x258>
    80004d6c:	f31fb0ef          	jal	ra,80000c9c <panic>
    80004d70:	06894703          	lbu	a4,104(s2)
    80004d74:	fa5ff06f          	j	80004d18 <bfree+0x6c>

0000000080004d78 <iupdate>:
    80004d78:	00452583          	lw	a1,4(a0)
    80004d7c:	fe010113          	addi	sp,sp,-32
    80004d80:	01213023          	sd	s2,0(sp)
    80004d84:	03000913          	li	s2,48
    80004d88:	0325d5bb          	divuw	a1,a1,s2
    80004d8c:	00813823          	sd	s0,16(sp)
    80004d90:	00050413          	mv	s0,a0
    80004d94:	00052503          	lw	a0,0(a0)
    80004d98:	00913423          	sd	s1,8(sp)
    80004d9c:	00113c23          	sd	ra,24(sp)
    80004da0:	0225859b          	addiw	a1,a1,34
    80004da4:	a5cff0ef          	jal	ra,80004000 <bread>
    80004da8:	00442783          	lw	a5,4(s0)
    80004dac:	05400393          	li	t2,84
    80004db0:	04444283          	lbu	t0,68(s0)
    80004db4:	0327f7bb          	remuw	a5,a5,s2
    80004db8:	06850693          	addi	a3,a0,104
    80004dbc:	04a45703          	lhu	a4,74(s0)
    80004dc0:	04e44883          	lbu	a7,78(s0)
    80004dc4:	04f44803          	lbu	a6,79(s0)
    80004dc8:	04644f83          	lbu	t6,70(s0)
    80004dcc:	04a44f03          	lbu	t5,74(s0)
    80004dd0:	04c44e83          	lbu	t4,76(s0)
    80004dd4:	04d44303          	lbu	t1,77(s0)
    80004dd8:	00050493          	mv	s1,a0
    80004ddc:	04645503          	lhu	a0,70(s0)
    80004de0:	00875713          	srli	a4,a4,0x8
    80004de4:	06040593          	addi	a1,s0,96
    80004de8:	00855513          	srli	a0,a0,0x8
    80004dec:	00000613          	li	a2,0
    80004df0:	00c00e13          	li	t3,12
    80004df4:	02079793          	slli	a5,a5,0x20
    80004df8:	0207d793          	srli	a5,a5,0x20
    80004dfc:	027787b3          	mul	a5,a5,t2
    80004e00:	00f686b3          	add	a3,a3,a5
    80004e04:	00568023          	sb	t0,0(a3)
    80004e08:	04544783          	lbu	a5,69(s0)
    80004e0c:	00a681a3          	sb	a0,3(a3)
    80004e10:	01f68123          	sb	t6,2(a3)
    80004e14:	00f680a3          	sb	a5,1(a3)
    80004e18:	04844783          	lbu	a5,72(s0)
    80004e1c:	00f68223          	sb	a5,4(a3)
    80004e20:	04944783          	lbu	a5,73(s0)
    80004e24:	00e683a3          	sb	a4,7(a3)
    80004e28:	01168523          	sb	a7,10(a3)
    80004e2c:	010685a3          	sb	a6,11(a3)
    80004e30:	01e68323          	sb	t5,6(a3)
    80004e34:	00f682a3          	sb	a5,5(a3)
    80004e38:	01d68423          	sb	t4,8(a3)
    80004e3c:	006684a3          	sb	t1,9(a3)
    80004e40:	05044783          	lbu	a5,80(s0)
    80004e44:	00f68623          	sb	a5,12(a3)
    80004e48:	05144783          	lbu	a5,81(s0)
    80004e4c:	00f686a3          	sb	a5,13(a3)
    80004e50:	05244783          	lbu	a5,82(s0)
    80004e54:	00f68723          	sb	a5,14(a3)
    80004e58:	05344783          	lbu	a5,83(s0)
    80004e5c:	00f687a3          	sb	a5,15(a3)
    80004e60:	05444803          	lbu	a6,84(s0)
    80004e64:	05544503          	lbu	a0,85(s0)
    80004e68:	05644703          	lbu	a4,86(s0)
    80004e6c:	05744783          	lbu	a5,87(s0)
    80004e70:	01068823          	sb	a6,16(a3)
    80004e74:	00e68923          	sb	a4,18(a3)
    80004e78:	00a688a3          	sb	a0,17(a3)
    80004e7c:	00f689a3          	sb	a5,19(a3)
    80004e80:	05844783          	lbu	a5,88(s0)
    80004e84:	05c44883          	lbu	a7,92(s0)
    80004e88:	05d44803          	lbu	a6,93(s0)
    80004e8c:	00f68a23          	sb	a5,20(a3)
    80004e90:	05944503          	lbu	a0,89(s0)
    80004e94:	05e44703          	lbu	a4,94(s0)
    80004e98:	05f44783          	lbu	a5,95(s0)
    80004e9c:	00a68aa3          	sb	a0,21(a3)
    80004ea0:	05a44503          	lbu	a0,90(s0)
    80004ea4:	00a68b23          	sb	a0,22(a3)
    80004ea8:	05b44503          	lbu	a0,91(s0)
    80004eac:	01168c23          	sb	a7,24(a3)
    80004eb0:	01068ca3          	sb	a6,25(a3)
    80004eb4:	00a68ba3          	sb	a0,23(a3)
    80004eb8:	00e68d23          	sb	a4,26(a3)
    80004ebc:	00f68da3          	sb	a5,27(a3)
    80004ec0:	0005a703          	lw	a4,0(a1)
    80004ec4:	00460793          	addi	a5,a2,4
    80004ec8:	00279793          	slli	a5,a5,0x2
    80004ecc:	00f687b3          	add	a5,a3,a5
    80004ed0:	0087531b          	srliw	t1,a4,0x8
    80004ed4:	0107589b          	srliw	a7,a4,0x10
    80004ed8:	0187581b          	srliw	a6,a4,0x18
    80004edc:	00e78623          	sb	a4,12(a5)
    80004ee0:	006786a3          	sb	t1,13(a5)
    80004ee4:	01178723          	sb	a7,14(a5)
    80004ee8:	010787a3          	sb	a6,15(a5)
    80004eec:	0016061b          	addiw	a2,a2,1
    80004ef0:	00458593          	addi	a1,a1,4
    80004ef4:	fdc616e3          	bne	a2,t3,80004ec0 <iupdate+0x148>
    80004ef8:	09044783          	lbu	a5,144(s0)
    80004efc:	09444803          	lbu	a6,148(s0)
    80004f00:	09544583          	lbu	a1,149(s0)
    80004f04:	04f68623          	sb	a5,76(a3)
    80004f08:	09144603          	lbu	a2,145(s0)
    80004f0c:	09644703          	lbu	a4,150(s0)
    80004f10:	09744783          	lbu	a5,151(s0)
    80004f14:	04c686a3          	sb	a2,77(a3)
    80004f18:	09244603          	lbu	a2,146(s0)
    80004f1c:	00048513          	mv	a0,s1
    80004f20:	04c68723          	sb	a2,78(a3)
    80004f24:	09344603          	lbu	a2,147(s0)
    80004f28:	05068823          	sb	a6,80(a3)
    80004f2c:	04b688a3          	sb	a1,81(a3)
    80004f30:	04c687a3          	sb	a2,79(a3)
    80004f34:	04e68923          	sb	a4,82(a3)
    80004f38:	04f689a3          	sb	a5,83(a3)
    80004f3c:	c15ff0ef          	jal	ra,80004b50 <log_write>
    80004f40:	01013403          	ld	s0,16(sp)
    80004f44:	01813083          	ld	ra,24(sp)
    80004f48:	00013903          	ld	s2,0(sp)
    80004f4c:	00048513          	mv	a0,s1
    80004f50:	00813483          	ld	s1,8(sp)
    80004f54:	02010113          	addi	sp,sp,32
    80004f58:	bdcff06f          	j	80004334 <brelse>

0000000080004f5c <balloc>:
    80004f5c:	fb010113          	addi	sp,sp,-80
    80004f60:	01513c23          	sd	s5,24(sp)
    80004f64:	0002ea97          	auipc	s5,0x2e
    80004f68:	c9ca8a93          	addi	s5,s5,-868 # 80032c00 <sb>
    80004f6c:	024aa783          	lw	a5,36(s5)
    80004f70:	04113423          	sd	ra,72(sp)
    80004f74:	04813023          	sd	s0,64(sp)
    80004f78:	02913c23          	sd	s1,56(sp)
    80004f7c:	03213823          	sd	s2,48(sp)
    80004f80:	03313423          	sd	s3,40(sp)
    80004f84:	03413023          	sd	s4,32(sp)
    80004f88:	06078863          	beqz	a5,80004ff8 <balloc+0x9c>
    80004f8c:	00050493          	mv	s1,a0
    80004f90:	00000993          	li	s3,0
    80004f94:	00008a37          	lui	s4,0x8
    80004f98:	00008937          	lui	s2,0x8
    80004f9c:	018aa583          	lw	a1,24(s5)
    80004fa0:	00f9d79b          	srliw	a5,s3,0xf
    80004fa4:	00048513          	mv	a0,s1
    80004fa8:	00b785bb          	addw	a1,a5,a1
    80004fac:	854ff0ef          	jal	ra,80004000 <bread>
    80004fb0:	024aa803          	lw	a6,36(s5)
    80004fb4:	00000793          	li	a5,0
    80004fb8:	0180006f          	j	80004fd0 <balloc+0x74>
    80004fbc:	06874603          	lbu	a2,104(a4)
    80004fc0:	40b656bb          	sraw	a3,a2,a1
    80004fc4:	0016f693          	andi	a3,a3,1
    80004fc8:	04068263          	beqz	a3,8000500c <balloc+0xb0>
    80004fcc:	01478e63          	beq	a5,s4,80004fe8 <balloc+0x8c>
    80004fd0:	0037d71b          	srliw	a4,a5,0x3
    80004fd4:	00f9843b          	addw	s0,s3,a5
    80004fd8:	0077f593          	andi	a1,a5,7
    80004fdc:	00e50733          	add	a4,a0,a4
    80004fe0:	0017879b          	addiw	a5,a5,1
    80004fe4:	fd046ce3          	bltu	s0,a6,80004fbc <balloc+0x60>
    80004fe8:	b4cff0ef          	jal	ra,80004334 <brelse>
    80004fec:	024aa783          	lw	a5,36(s5)
    80004ff0:	013909bb          	addw	s3,s2,s3
    80004ff4:	faf9e4e3          	bltu	s3,a5,80004f9c <balloc+0x40>
    80004ff8:	00002517          	auipc	a0,0x2
    80004ffc:	62850513          	addi	a0,a0,1576 # 80007620 <state_names.0+0x270>
    80005000:	c9dfb0ef          	jal	ra,80000c9c <panic>
    80005004:	00000513          	li	a0,0
    80005008:	02c0006f          	j	80005034 <balloc+0xd8>
    8000500c:	00100793          	li	a5,1
    80005010:	00b795bb          	sllw	a1,a5,a1
    80005014:	00b66633          	or	a2,a2,a1
    80005018:	06c70423          	sb	a2,104(a4)
    8000501c:	00a13423          	sd	a0,8(sp)
    80005020:	b31ff0ef          	jal	ra,80004b50 <log_write>
    80005024:	00813503          	ld	a0,8(sp)
    80005028:	b0cff0ef          	jal	ra,80004334 <brelse>
    8000502c:	020aa503          	lw	a0,32(s5)
    80005030:	0085053b          	addw	a0,a0,s0
    80005034:	04813083          	ld	ra,72(sp)
    80005038:	04013403          	ld	s0,64(sp)
    8000503c:	03813483          	ld	s1,56(sp)
    80005040:	03013903          	ld	s2,48(sp)
    80005044:	02813983          	ld	s3,40(sp)
    80005048:	02013a03          	ld	s4,32(sp)
    8000504c:	01813a83          	ld	s5,24(sp)
    80005050:	05010113          	addi	sp,sp,80
    80005054:	00008067          	ret

0000000080005058 <bmap.part.0>:
    80005058:	fd010113          	addi	sp,sp,-48
    8000505c:	01213823          	sd	s2,16(sp)
    80005060:	ff45891b          	addiw	s2,a1,-12
    80005064:	00913c23          	sd	s1,24(sp)
    80005068:	02113423          	sd	ra,40(sp)
    8000506c:	02813023          	sd	s0,32(sp)
    80005070:	01313423          	sd	s3,8(sp)
    80005074:	01413023          	sd	s4,0(sp)
    80005078:	0009071b          	sext.w	a4,s2
    8000507c:	3ff00793          	li	a5,1023
    80005080:	00050493          	mv	s1,a0
    80005084:	00052503          	lw	a0,0(a0)
    80005088:	08e7f863          	bgeu	a5,a4,80005118 <bmap.part.0+0xc0>
    8000508c:	00058413          	mv	s0,a1
    80005090:	0944a583          	lw	a1,148(s1)
    80005094:	0a058e63          	beqz	a1,80005150 <bmap.part.0+0xf8>
    80005098:	f69fe0ef          	jal	ra,80004000 <bread>
    8000509c:	bf44041b          	addiw	s0,s0,-1036
    800050a0:	00a4579b          	srliw	a5,s0,0xa
    800050a4:	06850993          	addi	s3,a0,104
    800050a8:	00279793          	slli	a5,a5,0x2
    800050ac:	00f989b3          	add	s3,s3,a5
    800050b0:	0009aa03          	lw	s4,0(s3)
    800050b4:	00050913          	mv	s2,a0
    800050b8:	3ff47413          	andi	s0,s0,1023
    800050bc:	100a0a63          	beqz	s4,800051d0 <bmap.part.0+0x178>
    800050c0:	00090513          	mv	a0,s2
    800050c4:	a70ff0ef          	jal	ra,80004334 <brelse>
    800050c8:	0004a503          	lw	a0,0(s1)
    800050cc:	000a0593          	mv	a1,s4
    800050d0:	00241413          	slli	s0,s0,0x2
    800050d4:	f2dfe0ef          	jal	ra,80004000 <bread>
    800050d8:	06850793          	addi	a5,a0,104
    800050dc:	00878433          	add	s0,a5,s0
    800050e0:	00042983          	lw	s3,0(s0)
    800050e4:	00050913          	mv	s2,a0
    800050e8:	0c098063          	beqz	s3,800051a8 <bmap.part.0+0x150>
    800050ec:	00090513          	mv	a0,s2
    800050f0:	a44ff0ef          	jal	ra,80004334 <brelse>
    800050f4:	02813083          	ld	ra,40(sp)
    800050f8:	02013403          	ld	s0,32(sp)
    800050fc:	01813483          	ld	s1,24(sp)
    80005100:	01013903          	ld	s2,16(sp)
    80005104:	00013a03          	ld	s4,0(sp)
    80005108:	00098513          	mv	a0,s3
    8000510c:	00813983          	ld	s3,8(sp)
    80005110:	03010113          	addi	sp,sp,48
    80005114:	00008067          	ret
    80005118:	0904a583          	lw	a1,144(s1)
    8000511c:	06058a63          	beqz	a1,80005190 <bmap.part.0+0x138>
    80005120:	02091913          	slli	s2,s2,0x20
    80005124:	eddfe0ef          	jal	ra,80004000 <bread>
    80005128:	02095913          	srli	s2,s2,0x20
    8000512c:	06850793          	addi	a5,a0,104
    80005130:	00291913          	slli	s2,s2,0x2
    80005134:	01278933          	add	s2,a5,s2
    80005138:	00092983          	lw	s3,0(s2) # 8000 <_binary_user_test_basic_bin_size+0x78bf>
    8000513c:	00050413          	mv	s0,a0
    80005140:	02098463          	beqz	s3,80005168 <bmap.part.0+0x110>
    80005144:	00040513          	mv	a0,s0
    80005148:	9ecff0ef          	jal	ra,80004334 <brelse>
    8000514c:	fa9ff06f          	j	800050f4 <bmap.part.0+0x9c>
    80005150:	e0dff0ef          	jal	ra,80004f5c <balloc>
    80005154:	00050593          	mv	a1,a0
    80005158:	0005859b          	sext.w	a1,a1
    8000515c:	0004a503          	lw	a0,0(s1)
    80005160:	08b4aa23          	sw	a1,148(s1)
    80005164:	f35ff06f          	j	80005098 <bmap.part.0+0x40>
    80005168:	0004a503          	lw	a0,0(s1)
    8000516c:	df1ff0ef          	jal	ra,80004f5c <balloc>
    80005170:	00a92023          	sw	a0,0(s2)
    80005174:	0504a783          	lw	a5,80(s1)
    80005178:	00040513          	mv	a0,s0
    8000517c:	0017879b          	addiw	a5,a5,1
    80005180:	04f4a823          	sw	a5,80(s1)
    80005184:	9cdff0ef          	jal	ra,80004b50 <log_write>
    80005188:	00092983          	lw	s3,0(s2)
    8000518c:	fb9ff06f          	j	80005144 <bmap.part.0+0xec>
    80005190:	dcdff0ef          	jal	ra,80004f5c <balloc>
    80005194:	00050593          	mv	a1,a0
    80005198:	0005859b          	sext.w	a1,a1
    8000519c:	0004a503          	lw	a0,0(s1)
    800051a0:	08b4a823          	sw	a1,144(s1)
    800051a4:	f7dff06f          	j	80005120 <bmap.part.0+0xc8>
    800051a8:	0004a503          	lw	a0,0(s1)
    800051ac:	db1ff0ef          	jal	ra,80004f5c <balloc>
    800051b0:	00a42023          	sw	a0,0(s0)
    800051b4:	0504a783          	lw	a5,80(s1)
    800051b8:	00090513          	mv	a0,s2
    800051bc:	0017879b          	addiw	a5,a5,1
    800051c0:	04f4a823          	sw	a5,80(s1)
    800051c4:	98dff0ef          	jal	ra,80004b50 <log_write>
    800051c8:	00042983          	lw	s3,0(s0)
    800051cc:	f21ff06f          	j	800050ec <bmap.part.0+0x94>
    800051d0:	0004a503          	lw	a0,0(s1)
    800051d4:	d89ff0ef          	jal	ra,80004f5c <balloc>
    800051d8:	00a9a023          	sw	a0,0(s3)
    800051dc:	00090513          	mv	a0,s2
    800051e0:	971ff0ef          	jal	ra,80004b50 <log_write>
    800051e4:	0009aa03          	lw	s4,0(s3)
    800051e8:	ed9ff06f          	j	800050c0 <bmap.part.0+0x68>

00000000800051ec <ilock.part.0>:
    800051ec:	00452583          	lw	a1,4(a0)
    800051f0:	fe010113          	addi	sp,sp,-32
    800051f4:	00913423          	sd	s1,8(sp)
    800051f8:	03000493          	li	s1,48
    800051fc:	0295d5bb          	divuw	a1,a1,s1
    80005200:	00813823          	sd	s0,16(sp)
    80005204:	00050413          	mv	s0,a0
    80005208:	00052503          	lw	a0,0(a0)
    8000520c:	00113c23          	sd	ra,24(sp)
    80005210:	0225859b          	addiw	a1,a1,34
    80005214:	dedfe0ef          	jal	ra,80004000 <bread>
    80005218:	00442783          	lw	a5,4(s0)
    8000521c:	05400713          	li	a4,84
    80005220:	06850613          	addi	a2,a0,104
    80005224:	0297f7bb          	remuw	a5,a5,s1
    80005228:	06040813          	addi	a6,s0,96
    8000522c:	00000593          	li	a1,0
    80005230:	00c00313          	li	t1,12
    80005234:	02079793          	slli	a5,a5,0x20
    80005238:	0207d793          	srli	a5,a5,0x20
    8000523c:	02e787b3          	mul	a5,a5,a4
    80005240:	00f60633          	add	a2,a2,a5
    80005244:	00164783          	lbu	a5,1(a2)
    80005248:	00064703          	lbu	a4,0(a2)
    8000524c:	00879793          	slli	a5,a5,0x8
    80005250:	00e7e7b3          	or	a5,a5,a4
    80005254:	04f41223          	sh	a5,68(s0)
    80005258:	00364783          	lbu	a5,3(a2)
    8000525c:	00264703          	lbu	a4,2(a2)
    80005260:	00879793          	slli	a5,a5,0x8
    80005264:	00e7e7b3          	or	a5,a5,a4
    80005268:	04f41323          	sh	a5,70(s0)
    8000526c:	00564783          	lbu	a5,5(a2)
    80005270:	00464703          	lbu	a4,4(a2)
    80005274:	00879793          	slli	a5,a5,0x8
    80005278:	00e7e7b3          	or	a5,a5,a4
    8000527c:	04f41423          	sh	a5,72(s0)
    80005280:	00764783          	lbu	a5,7(a2)
    80005284:	00664703          	lbu	a4,6(a2)
    80005288:	00879793          	slli	a5,a5,0x8
    8000528c:	00e7e7b3          	or	a5,a5,a4
    80005290:	04f41523          	sh	a5,74(s0)
    80005294:	00964683          	lbu	a3,9(a2)
    80005298:	00864883          	lbu	a7,8(a2)
    8000529c:	00a64703          	lbu	a4,10(a2)
    800052a0:	00b64783          	lbu	a5,11(a2)
    800052a4:	00869693          	slli	a3,a3,0x8
    800052a8:	0116e6b3          	or	a3,a3,a7
    800052ac:	01071713          	slli	a4,a4,0x10
    800052b0:	00d76733          	or	a4,a4,a3
    800052b4:	01879793          	slli	a5,a5,0x18
    800052b8:	00e7e7b3          	or	a5,a5,a4
    800052bc:	04f42623          	sw	a5,76(s0)
    800052c0:	00d64683          	lbu	a3,13(a2)
    800052c4:	00c64883          	lbu	a7,12(a2)
    800052c8:	00e64703          	lbu	a4,14(a2)
    800052cc:	00f64783          	lbu	a5,15(a2)
    800052d0:	00869693          	slli	a3,a3,0x8
    800052d4:	0116e6b3          	or	a3,a3,a7
    800052d8:	01071713          	slli	a4,a4,0x10
    800052dc:	00d76733          	or	a4,a4,a3
    800052e0:	01879793          	slli	a5,a5,0x18
    800052e4:	00e7e7b3          	or	a5,a5,a4
    800052e8:	04f42823          	sw	a5,80(s0)
    800052ec:	01164683          	lbu	a3,17(a2)
    800052f0:	01064883          	lbu	a7,16(a2)
    800052f4:	01264703          	lbu	a4,18(a2)
    800052f8:	01364783          	lbu	a5,19(a2)
    800052fc:	00869693          	slli	a3,a3,0x8
    80005300:	0116e6b3          	or	a3,a3,a7
    80005304:	01071713          	slli	a4,a4,0x10
    80005308:	00d76733          	or	a4,a4,a3
    8000530c:	01879793          	slli	a5,a5,0x18
    80005310:	00e7e7b3          	or	a5,a5,a4
    80005314:	04f42a23          	sw	a5,84(s0)
    80005318:	01564683          	lbu	a3,21(a2)
    8000531c:	01464883          	lbu	a7,20(a2)
    80005320:	01664703          	lbu	a4,22(a2)
    80005324:	01764783          	lbu	a5,23(a2)
    80005328:	00869693          	slli	a3,a3,0x8
    8000532c:	0116e6b3          	or	a3,a3,a7
    80005330:	01071713          	slli	a4,a4,0x10
    80005334:	00d76733          	or	a4,a4,a3
    80005338:	01879793          	slli	a5,a5,0x18
    8000533c:	00e7e7b3          	or	a5,a5,a4
    80005340:	04f42c23          	sw	a5,88(s0)
    80005344:	01964683          	lbu	a3,25(a2)
    80005348:	01864883          	lbu	a7,24(a2)
    8000534c:	01a64703          	lbu	a4,26(a2)
    80005350:	01b64783          	lbu	a5,27(a2)
    80005354:	00869693          	slli	a3,a3,0x8
    80005358:	0116e6b3          	or	a3,a3,a7
    8000535c:	01071713          	slli	a4,a4,0x10
    80005360:	00d76733          	or	a4,a4,a3
    80005364:	01879793          	slli	a5,a5,0x18
    80005368:	00e7e7b3          	or	a5,a5,a4
    8000536c:	04f42e23          	sw	a5,92(s0)
    80005370:	00458793          	addi	a5,a1,4
    80005374:	00279793          	slli	a5,a5,0x2
    80005378:	00f607b3          	add	a5,a2,a5
    8000537c:	00d7c683          	lbu	a3,13(a5)
    80005380:	00c7c883          	lbu	a7,12(a5)
    80005384:	00e7c703          	lbu	a4,14(a5)
    80005388:	00f7c783          	lbu	a5,15(a5)
    8000538c:	00869693          	slli	a3,a3,0x8
    80005390:	0116e6b3          	or	a3,a3,a7
    80005394:	01071713          	slli	a4,a4,0x10
    80005398:	00d76733          	or	a4,a4,a3
    8000539c:	01879793          	slli	a5,a5,0x18
    800053a0:	00e7e7b3          	or	a5,a5,a4
    800053a4:	00f82023          	sw	a5,0(a6)
    800053a8:	0015859b          	addiw	a1,a1,1
    800053ac:	00480813          	addi	a6,a6,4
    800053b0:	fc6590e3          	bne	a1,t1,80005370 <ilock.part.0+0x184>
    800053b4:	04d64683          	lbu	a3,77(a2)
    800053b8:	04c64583          	lbu	a1,76(a2)
    800053bc:	04e64703          	lbu	a4,78(a2)
    800053c0:	04f64783          	lbu	a5,79(a2)
    800053c4:	00869693          	slli	a3,a3,0x8
    800053c8:	00b6e6b3          	or	a3,a3,a1
    800053cc:	01071713          	slli	a4,a4,0x10
    800053d0:	00d76733          	or	a4,a4,a3
    800053d4:	01879793          	slli	a5,a5,0x18
    800053d8:	00e7e7b3          	or	a5,a5,a4
    800053dc:	08f42823          	sw	a5,144(s0)
    800053e0:	05164683          	lbu	a3,81(a2)
    800053e4:	05064583          	lbu	a1,80(a2)
    800053e8:	05264703          	lbu	a4,82(a2)
    800053ec:	05364783          	lbu	a5,83(a2)
    800053f0:	00869693          	slli	a3,a3,0x8
    800053f4:	00b6e6b3          	or	a3,a3,a1
    800053f8:	01071713          	slli	a4,a4,0x10
    800053fc:	00d76733          	or	a4,a4,a3
    80005400:	01879793          	slli	a5,a5,0x18
    80005404:	00e7e7b3          	or	a5,a5,a4
    80005408:	08f42a23          	sw	a5,148(s0)
    8000540c:	f29fe0ef          	jal	ra,80004334 <brelse>
    80005410:	04445783          	lhu	a5,68(s0)
    80005414:	00100713          	li	a4,1
    80005418:	04e42023          	sw	a4,64(s0)
    8000541c:	00078c63          	beqz	a5,80005434 <ilock.part.0+0x248>
    80005420:	01813083          	ld	ra,24(sp)
    80005424:	01013403          	ld	s0,16(sp)
    80005428:	00813483          	ld	s1,8(sp)
    8000542c:	02010113          	addi	sp,sp,32
    80005430:	00008067          	ret
    80005434:	01013403          	ld	s0,16(sp)
    80005438:	01813083          	ld	ra,24(sp)
    8000543c:	00813483          	ld	s1,8(sp)
    80005440:	00002517          	auipc	a0,0x2
    80005444:	1f850513          	addi	a0,a0,504 # 80007638 <state_names.0+0x288>
    80005448:	02010113          	addi	sp,sp,32
    8000544c:	851fb06f          	j	80000c9c <panic>

0000000080005450 <writei.part.0>:
    80005450:	fa010113          	addi	sp,sp,-96
    80005454:	05213023          	sd	s2,64(sp)
    80005458:	03313c23          	sd	s3,56(sp)
    8000545c:	04113c23          	sd	ra,88(sp)
    80005460:	04813823          	sd	s0,80(sp)
    80005464:	04913423          	sd	s1,72(sp)
    80005468:	03413823          	sd	s4,48(sp)
    8000546c:	03513423          	sd	s5,40(sp)
    80005470:	03613023          	sd	s6,32(sp)
    80005474:	01713c23          	sd	s7,24(sp)
    80005478:	01813823          	sd	s8,16(sp)
    8000547c:	01913423          	sd	s9,8(sp)
    80005480:	00068913          	mv	s2,a3
    80005484:	00050993          	mv	s3,a0
    80005488:	0c068c63          	beqz	a3,80005560 <writei.part.0+0x110>
    8000548c:	00001ab7          	lui	s5,0x1
    80005490:	00058a13          	mv	s4,a1
    80005494:	00060413          	mv	s0,a2
    80005498:	00000493          	li	s1,0
    8000549c:	00b00b93          	li	s7,11
    800054a0:	fffa8a93          	addi	s5,s5,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    800054a4:	00001b37          	lui	s6,0x1
    800054a8:	0009a503          	lw	a0,0(s3)
    800054ac:	00c4559b          	srliw	a1,s0,0xc
    800054b0:	00c4579b          	srliw	a5,s0,0xc
    800054b4:	00050c9b          	sext.w	s9,a0
    800054b8:	10bbfa63          	bgeu	s7,a1,800055cc <writei.part.0+0x17c>
    800054bc:	00098513          	mv	a0,s3
    800054c0:	b99ff0ef          	jal	ra,80005058 <bmap.part.0>
    800054c4:	0005059b          	sext.w	a1,a0
    800054c8:	000c8513          	mv	a0,s9
    800054cc:	b35fe0ef          	jal	ra,80004000 <bread>
    800054d0:	01547833          	and	a6,s0,s5
    800054d4:	410b07bb          	subw	a5,s6,a6
    800054d8:	409906bb          	subw	a3,s2,s1
    800054dc:	0007861b          	sext.w	a2,a5
    800054e0:	00050c93          	mv	s9,a0
    800054e4:	00c6f463          	bgeu	a3,a2,800054ec <writei.part.0+0x9c>
    800054e8:	00068793          	mv	a5,a3
    800054ec:	02081813          	slli	a6,a6,0x20
    800054f0:	02049693          	slli	a3,s1,0x20
    800054f4:	068c8713          	addi	a4,s9,104
    800054f8:	02085813          	srli	a6,a6,0x20
    800054fc:	0206d693          	srli	a3,a3,0x20
    80005500:	01070833          	add	a6,a4,a6
    80005504:	014686b3          	add	a3,a3,s4
    80005508:	00078c1b          	sext.w	s8,a5
    8000550c:	0906fa63          	bgeu	a3,a6,800055a0 <writei.part.0+0x150>
    80005510:	02079793          	slli	a5,a5,0x20
    80005514:	0207d793          	srli	a5,a5,0x20
    80005518:	00f68733          	add	a4,a3,a5
    8000551c:	08e87263          	bgeu	a6,a4,800055a0 <writei.part.0+0x150>
    80005520:	00f807b3          	add	a5,a6,a5
    80005524:	fff74683          	lbu	a3,-1(a4)
    80005528:	fff78793          	addi	a5,a5,-1
    8000552c:	fff70713          	addi	a4,a4,-1
    80005530:	00d78023          	sb	a3,0(a5)
    80005534:	fef818e3          	bne	a6,a5,80005524 <writei.part.0+0xd4>
    80005538:	000c8513          	mv	a0,s9
    8000553c:	e14ff0ef          	jal	ra,80004b50 <log_write>
    80005540:	000c8513          	mv	a0,s9
    80005544:	009c04bb          	addw	s1,s8,s1
    80005548:	dedfe0ef          	jal	ra,80004334 <brelse>
    8000554c:	008c043b          	addw	s0,s8,s0
    80005550:	f524ece3          	bltu	s1,s2,800054a8 <writei.part.0+0x58>
    80005554:	04c9a783          	lw	a5,76(s3)
    80005558:	0087f463          	bgeu	a5,s0,80005560 <writei.part.0+0x110>
    8000555c:	0489a623          	sw	s0,76(s3)
    80005560:	00098513          	mv	a0,s3
    80005564:	815ff0ef          	jal	ra,80004d78 <iupdate>
    80005568:	05813083          	ld	ra,88(sp)
    8000556c:	05013403          	ld	s0,80(sp)
    80005570:	04813483          	ld	s1,72(sp)
    80005574:	03813983          	ld	s3,56(sp)
    80005578:	03013a03          	ld	s4,48(sp)
    8000557c:	02813a83          	ld	s5,40(sp)
    80005580:	02013b03          	ld	s6,32(sp)
    80005584:	01813b83          	ld	s7,24(sp)
    80005588:	01013c03          	ld	s8,16(sp)
    8000558c:	00813c83          	ld	s9,8(sp)
    80005590:	0009051b          	sext.w	a0,s2
    80005594:	04013903          	ld	s2,64(sp)
    80005598:	06010113          	addi	sp,sp,96
    8000559c:	00008067          	ret
    800055a0:	020c1713          	slli	a4,s8,0x20
    800055a4:	02075713          	srli	a4,a4,0x20
    800055a8:	00080793          	mv	a5,a6
    800055ac:	00e80733          	add	a4,a6,a4
    800055b0:	410686b3          	sub	a3,a3,a6
    800055b4:	00d78633          	add	a2,a5,a3
    800055b8:	00064603          	lbu	a2,0(a2)
    800055bc:	00178793          	addi	a5,a5,1
    800055c0:	fec78fa3          	sb	a2,-1(a5)
    800055c4:	fee798e3          	bne	a5,a4,800055b4 <writei.part.0+0x164>
    800055c8:	f71ff06f          	j	80005538 <writei.part.0+0xe8>
    800055cc:	02079c13          	slli	s8,a5,0x20
    800055d0:	01ec5c13          	srli	s8,s8,0x1e
    800055d4:	01898c33          	add	s8,s3,s8
    800055d8:	060c2583          	lw	a1,96(s8)
    800055dc:	ee0596e3          	bnez	a1,800054c8 <writei.part.0+0x78>
    800055e0:	97dff0ef          	jal	ra,80004f5c <balloc>
    800055e4:	0005059b          	sext.w	a1,a0
    800055e8:	06bc2023          	sw	a1,96(s8)
    800055ec:	0509a783          	lw	a5,80(s3)
    800055f0:	0017879b          	addiw	a5,a5,1
    800055f4:	04f9a823          	sw	a5,80(s3)
    800055f8:	ed1ff06f          	j	800054c8 <writei.part.0+0x78>

00000000800055fc <fs_init>:
    800055fc:	fd010113          	addi	sp,sp,-48
    80005600:	01313423          	sd	s3,8(sp)
    80005604:	00002597          	auipc	a1,0x2
    80005608:	04458593          	addi	a1,a1,68 # 80007648 <state_names.0+0x298>
    8000560c:	00050993          	mv	s3,a0
    80005610:	0002d517          	auipc	a0,0x2d
    80005614:	61850513          	addi	a0,a0,1560 # 80032c28 <icache>
    80005618:	02813023          	sd	s0,32(sp)
    8000561c:	00913c23          	sd	s1,24(sp)
    80005620:	01213823          	sd	s2,16(sp)
    80005624:	02113423          	sd	ra,40(sp)
    80005628:	0002d417          	auipc	s0,0x2d
    8000562c:	62040413          	addi	s0,s0,1568 # 80032c48 <icache+0x20>
    80005630:	820fe0ef          	jal	ra,80003650 <initlock>
    80005634:	0002f917          	auipc	s2,0x2f
    80005638:	3c490913          	addi	s2,s2,964 # 800349f8 <ramdisk+0x10>
    8000563c:	00002497          	auipc	s1,0x2
    80005640:	01448493          	addi	s1,s1,20 # 80007650 <state_names.0+0x2a0>
    80005644:	fe042c23          	sw	zero,-8(s0)
    80005648:	02042823          	sw	zero,48(s0)
    8000564c:	00040513          	mv	a0,s0
    80005650:	00048593          	mv	a1,s1
    80005654:	09840413          	addi	s0,s0,152
    80005658:	ef8fe0ef          	jal	ra,80003d50 <initsleeplock>
    8000565c:	ff2414e3          	bne	s0,s2,80005644 <fs_init+0x48>
    80005660:	00100593          	li	a1,1
    80005664:	00098513          	mv	a0,s3
    80005668:	999fe0ef          	jal	ra,80004000 <bread>
    8000566c:	06850713          	addi	a4,a0,104
    80005670:	0002d617          	auipc	a2,0x2d
    80005674:	59060613          	addi	a2,a2,1424 # 80032c00 <sb>
    80005678:	04c77263          	bgeu	a4,a2,800056bc <fs_init+0xc0>
    8000567c:	09050693          	addi	a3,a0,144
    80005680:	02d67e63          	bgeu	a2,a3,800056bc <fs_init+0xc0>
    80005684:	0002d797          	auipc	a5,0x2d
    80005688:	5a478793          	addi	a5,a5,1444 # 80032c28 <icache>
    8000568c:	fff6c703          	lbu	a4,-1(a3)
    80005690:	fff78793          	addi	a5,a5,-1
    80005694:	fff68693          	addi	a3,a3,-1
    80005698:	00e78023          	sb	a4,0(a5)
    8000569c:	fec798e3          	bne	a5,a2,8000568c <fs_init+0x90>
    800056a0:	02013403          	ld	s0,32(sp)
    800056a4:	02813083          	ld	ra,40(sp)
    800056a8:	01813483          	ld	s1,24(sp)
    800056ac:	01013903          	ld	s2,16(sp)
    800056b0:	00813983          	ld	s3,8(sp)
    800056b4:	03010113          	addi	sp,sp,48
    800056b8:	c7dfe06f          	j	80004334 <brelse>
    800056bc:	0002d797          	auipc	a5,0x2d
    800056c0:	54478793          	addi	a5,a5,1348 # 80032c00 <sb>
    800056c4:	0002d617          	auipc	a2,0x2d
    800056c8:	56460613          	addi	a2,a2,1380 # 80032c28 <icache>
    800056cc:	00074683          	lbu	a3,0(a4)
    800056d0:	00178793          	addi	a5,a5,1
    800056d4:	00170713          	addi	a4,a4,1
    800056d8:	fed78fa3          	sb	a3,-1(a5)
    800056dc:	fec798e3          	bne	a5,a2,800056cc <fs_init+0xd0>
    800056e0:	02013403          	ld	s0,32(sp)
    800056e4:	02813083          	ld	ra,40(sp)
    800056e8:	01813483          	ld	s1,24(sp)
    800056ec:	01013903          	ld	s2,16(sp)
    800056f0:	00813983          	ld	s3,8(sp)
    800056f4:	03010113          	addi	sp,sp,48
    800056f8:	c3dfe06f          	j	80004334 <brelse>

00000000800056fc <iget>:
    800056fc:	fd010113          	addi	sp,sp,-48
    80005700:	01213823          	sd	s2,16(sp)
    80005704:	00050913          	mv	s2,a0
    80005708:	0002d517          	auipc	a0,0x2d
    8000570c:	52050513          	addi	a0,a0,1312 # 80032c28 <icache>
    80005710:	02813023          	sd	s0,32(sp)
    80005714:	00913c23          	sd	s1,24(sp)
    80005718:	01313423          	sd	s3,8(sp)
    8000571c:	02113423          	sd	ra,40(sp)
    80005720:	00058993          	mv	s3,a1
    80005724:	f39fd0ef          	jal	ra,8000365c <acquire>
    80005728:	0002d417          	auipc	s0,0x2d
    8000572c:	51040413          	addi	s0,s0,1296 # 80032c38 <icache+0x10>
    80005730:	00000493          	li	s1,0
    80005734:	0002f697          	auipc	a3,0x2f
    80005738:	2b468693          	addi	a3,a3,692 # 800349e8 <ramdisk>
    8000573c:	00842783          	lw	a5,8(s0)
    80005740:	08f05c63          	blez	a5,800057d8 <iget+0xdc>
    80005744:	00042703          	lw	a4,0(s0)
    80005748:	05270863          	beq	a4,s2,80005798 <iget+0x9c>
    8000574c:	09840413          	addi	s0,s0,152
    80005750:	fed466e3          	bltu	s0,a3,8000573c <iget+0x40>
    80005754:	0a048063          	beqz	s1,800057f4 <iget+0xf8>
    80005758:	00100793          	li	a5,1
    8000575c:	0124a023          	sw	s2,0(s1)
    80005760:	0134a223          	sw	s3,4(s1)
    80005764:	00f4a423          	sw	a5,8(s1)
    80005768:	0404a023          	sw	zero,64(s1)
    8000576c:	0002d517          	auipc	a0,0x2d
    80005770:	4bc50513          	addi	a0,a0,1212 # 80032c28 <icache>
    80005774:	f0dfd0ef          	jal	ra,80003680 <release>
    80005778:	02813083          	ld	ra,40(sp)
    8000577c:	02013403          	ld	s0,32(sp)
    80005780:	01013903          	ld	s2,16(sp)
    80005784:	00813983          	ld	s3,8(sp)
    80005788:	00048513          	mv	a0,s1
    8000578c:	01813483          	ld	s1,24(sp)
    80005790:	03010113          	addi	sp,sp,48
    80005794:	00008067          	ret
    80005798:	00442703          	lw	a4,4(s0)
    8000579c:	fb3718e3          	bne	a4,s3,8000574c <iget+0x50>
    800057a0:	0017879b          	addiw	a5,a5,1
    800057a4:	0002d517          	auipc	a0,0x2d
    800057a8:	48450513          	addi	a0,a0,1156 # 80032c28 <icache>
    800057ac:	00f42423          	sw	a5,8(s0)
    800057b0:	ed1fd0ef          	jal	ra,80003680 <release>
    800057b4:	00040493          	mv	s1,s0
    800057b8:	02813083          	ld	ra,40(sp)
    800057bc:	02013403          	ld	s0,32(sp)
    800057c0:	01013903          	ld	s2,16(sp)
    800057c4:	00813983          	ld	s3,8(sp)
    800057c8:	00048513          	mv	a0,s1
    800057cc:	01813483          	ld	s1,24(sp)
    800057d0:	03010113          	addi	sp,sp,48
    800057d4:	00008067          	ret
    800057d8:	f6049ae3          	bnez	s1,8000574c <iget+0x50>
    800057dc:	00040713          	mv	a4,s0
    800057e0:	09840413          	addi	s0,s0,152
    800057e4:	02079863          	bnez	a5,80005814 <iget+0x118>
    800057e8:	00070493          	mv	s1,a4
    800057ec:	f4d468e3          	bltu	s0,a3,8000573c <iget+0x40>
    800057f0:	f65ff06f          	j	80005754 <iget+0x58>
    800057f4:	0002d517          	auipc	a0,0x2d
    800057f8:	43450513          	addi	a0,a0,1076 # 80032c28 <icache>
    800057fc:	e85fd0ef          	jal	ra,80003680 <release>
    80005800:	00002517          	auipc	a0,0x2
    80005804:	e5850513          	addi	a0,a0,-424 # 80007658 <state_names.0+0x2a8>
    80005808:	c94fb0ef          	jal	ra,80000c9c <panic>
    8000580c:	00000493          	li	s1,0
    80005810:	f49ff06f          	j	80005758 <iget+0x5c>
    80005814:	fed470e3          	bgeu	s0,a3,800057f4 <iget+0xf8>
    80005818:	00842783          	lw	a5,8(s0)
    8000581c:	f2f044e3          	bgtz	a5,80005744 <iget+0x48>
    80005820:	fbdff06f          	j	800057dc <iget+0xe0>

0000000080005824 <idup>:
    80005824:	ff010113          	addi	sp,sp,-16
    80005828:	00813023          	sd	s0,0(sp)
    8000582c:	00050413          	mv	s0,a0
    80005830:	0002d517          	auipc	a0,0x2d
    80005834:	3f850513          	addi	a0,a0,1016 # 80032c28 <icache>
    80005838:	00113423          	sd	ra,8(sp)
    8000583c:	e21fd0ef          	jal	ra,8000365c <acquire>
    80005840:	00842783          	lw	a5,8(s0)
    80005844:	0002d517          	auipc	a0,0x2d
    80005848:	3e450513          	addi	a0,a0,996 # 80032c28 <icache>
    8000584c:	0017879b          	addiw	a5,a5,1
    80005850:	00f42423          	sw	a5,8(s0)
    80005854:	e2dfd0ef          	jal	ra,80003680 <release>
    80005858:	00813083          	ld	ra,8(sp)
    8000585c:	00040513          	mv	a0,s0
    80005860:	00013403          	ld	s0,0(sp)
    80005864:	01010113          	addi	sp,sp,16
    80005868:	00008067          	ret

000000008000586c <iput>:
    8000586c:	fb010113          	addi	sp,sp,-80
    80005870:	03213823          	sd	s2,48(sp)
    80005874:	00050913          	mv	s2,a0
    80005878:	0002d517          	auipc	a0,0x2d
    8000587c:	3b050513          	addi	a0,a0,944 # 80032c28 <icache>
    80005880:	04113423          	sd	ra,72(sp)
    80005884:	04813023          	sd	s0,64(sp)
    80005888:	02913c23          	sd	s1,56(sp)
    8000588c:	03313423          	sd	s3,40(sp)
    80005890:	03413023          	sd	s4,32(sp)
    80005894:	01513c23          	sd	s5,24(sp)
    80005898:	01613823          	sd	s6,16(sp)
    8000589c:	01713423          	sd	s7,8(sp)
    800058a0:	01813023          	sd	s8,0(sp)
    800058a4:	db9fd0ef          	jal	ra,8000365c <acquire>
    800058a8:	00892783          	lw	a5,8(s2)
    800058ac:	00100713          	li	a4,1
    800058b0:	04e78263          	beq	a5,a4,800058f4 <iput+0x88>
    800058b4:	04013403          	ld	s0,64(sp)
    800058b8:	fff7879b          	addiw	a5,a5,-1
    800058bc:	04813083          	ld	ra,72(sp)
    800058c0:	03813483          	ld	s1,56(sp)
    800058c4:	02813983          	ld	s3,40(sp)
    800058c8:	02013a03          	ld	s4,32(sp)
    800058cc:	01813a83          	ld	s5,24(sp)
    800058d0:	01013b03          	ld	s6,16(sp)
    800058d4:	00813b83          	ld	s7,8(sp)
    800058d8:	00013c03          	ld	s8,0(sp)
    800058dc:	00f92423          	sw	a5,8(s2)
    800058e0:	03013903          	ld	s2,48(sp)
    800058e4:	0002d517          	auipc	a0,0x2d
    800058e8:	34450513          	addi	a0,a0,836 # 80032c28 <icache>
    800058ec:	05010113          	addi	sp,sp,80
    800058f0:	d91fd06f          	j	80003680 <release>
    800058f4:	04a95703          	lhu	a4,74(s2)
    800058f8:	fa071ee3          	bnez	a4,800058b4 <iput+0x48>
    800058fc:	04092703          	lw	a4,64(s2)
    80005900:	fa070ae3          	beqz	a4,800058b4 <iput+0x48>
    80005904:	0002d517          	auipc	a0,0x2d
    80005908:	32450513          	addi	a0,a0,804 # 80032c28 <icache>
    8000590c:	d75fd0ef          	jal	ra,80003680 <release>
    80005910:	01090a13          	addi	s4,s2,16
    80005914:	000a0513          	mv	a0,s4
    80005918:	cb0fe0ef          	jal	ra,80003dc8 <acquiresleep>
    8000591c:	04092783          	lw	a5,64(s2)
    80005920:	16078063          	beqz	a5,80005a80 <iput+0x214>
    80005924:	06090413          	addi	s0,s2,96
    80005928:	09090493          	addi	s1,s2,144
    8000592c:	00c0006f          	j	80005938 <iput+0xcc>
    80005930:	00440413          	addi	s0,s0,4
    80005934:	00940e63          	beq	s0,s1,80005950 <iput+0xe4>
    80005938:	00042583          	lw	a1,0(s0)
    8000593c:	fe058ae3          	beqz	a1,80005930 <iput+0xc4>
    80005940:	00092503          	lw	a0,0(s2)
    80005944:	b68ff0ef          	jal	ra,80004cac <bfree>
    80005948:	00042023          	sw	zero,0(s0)
    8000594c:	fe5ff06f          	j	80005930 <iput+0xc4>
    80005950:	09092583          	lw	a1,144(s2)
    80005954:	0c059c63          	bnez	a1,80005a2c <iput+0x1c0>
    80005958:	09492583          	lw	a1,148(s2)
    8000595c:	04059c63          	bnez	a1,800059b4 <iput+0x148>
    80005960:	00090513          	mv	a0,s2
    80005964:	04092623          	sw	zero,76(s2)
    80005968:	04092823          	sw	zero,80(s2)
    8000596c:	c0cff0ef          	jal	ra,80004d78 <iupdate>
    80005970:	00090513          	mv	a0,s2
    80005974:	04091223          	sh	zero,68(s2)
    80005978:	04092023          	sw	zero,64(s2)
    8000597c:	bfcff0ef          	jal	ra,80004d78 <iupdate>
    80005980:	000a0513          	mv	a0,s4
    80005984:	cd4fe0ef          	jal	ra,80003e58 <holdingsleep>
    80005988:	00051863          	bnez	a0,80005998 <iput+0x12c>
    8000598c:	00002517          	auipc	a0,0x2
    80005990:	cdc50513          	addi	a0,a0,-804 # 80007668 <state_names.0+0x2b8>
    80005994:	b08fb0ef          	jal	ra,80000c9c <panic>
    80005998:	000a0513          	mv	a0,s4
    8000599c:	c84fe0ef          	jal	ra,80003e20 <releasesleep>
    800059a0:	0002d517          	auipc	a0,0x2d
    800059a4:	28850513          	addi	a0,a0,648 # 80032c28 <icache>
    800059a8:	cb5fd0ef          	jal	ra,8000365c <acquire>
    800059ac:	00892783          	lw	a5,8(s2)
    800059b0:	f05ff06f          	j	800058b4 <iput+0x48>
    800059b4:	00092503          	lw	a0,0(s2)
    800059b8:	00001bb7          	lui	s7,0x1
    800059bc:	068b8b93          	addi	s7,s7,104 # 1068 <_binary_user_test_basic_bin_size+0x927>
    800059c0:	e40fe0ef          	jal	ra,80004000 <bread>
    800059c4:	00050c13          	mv	s8,a0
    800059c8:	06850993          	addi	s3,a0,104
    800059cc:	01750ab3          	add	s5,a0,s7
    800059d0:	00c0006f          	j	800059dc <iput+0x170>
    800059d4:	00498993          	addi	s3,s3,4
    800059d8:	0b3a8a63          	beq	s5,s3,80005a8c <iput+0x220>
    800059dc:	0009a583          	lw	a1,0(s3)
    800059e0:	fe058ae3          	beqz	a1,800059d4 <iput+0x168>
    800059e4:	00092503          	lw	a0,0(s2)
    800059e8:	e18fe0ef          	jal	ra,80004000 <bread>
    800059ec:	00050b13          	mv	s6,a0
    800059f0:	06850413          	addi	s0,a0,104
    800059f4:	017504b3          	add	s1,a0,s7
    800059f8:	00042583          	lw	a1,0(s0)
    800059fc:	00440413          	addi	s0,s0,4
    80005a00:	02059063          	bnez	a1,80005a20 <iput+0x1b4>
    80005a04:	fe941ae3          	bne	s0,s1,800059f8 <iput+0x18c>
    80005a08:	000b0513          	mv	a0,s6
    80005a0c:	929fe0ef          	jal	ra,80004334 <brelse>
    80005a10:	0009a583          	lw	a1,0(s3)
    80005a14:	00092503          	lw	a0,0(s2)
    80005a18:	a94ff0ef          	jal	ra,80004cac <bfree>
    80005a1c:	fb9ff06f          	j	800059d4 <iput+0x168>
    80005a20:	00092503          	lw	a0,0(s2)
    80005a24:	a88ff0ef          	jal	ra,80004cac <bfree>
    80005a28:	fddff06f          	j	80005a04 <iput+0x198>
    80005a2c:	00092503          	lw	a0,0(s2)
    80005a30:	000014b7          	lui	s1,0x1
    80005a34:	06848493          	addi	s1,s1,104 # 1068 <_binary_user_test_basic_bin_size+0x927>
    80005a38:	dc8fe0ef          	jal	ra,80004000 <bread>
    80005a3c:	00050993          	mv	s3,a0
    80005a40:	06850413          	addi	s0,a0,104
    80005a44:	009504b3          	add	s1,a0,s1
    80005a48:	00042583          	lw	a1,0(s0)
    80005a4c:	00440413          	addi	s0,s0,4
    80005a50:	02059263          	bnez	a1,80005a74 <iput+0x208>
    80005a54:	fe849ae3          	bne	s1,s0,80005a48 <iput+0x1dc>
    80005a58:	00098513          	mv	a0,s3
    80005a5c:	8d9fe0ef          	jal	ra,80004334 <brelse>
    80005a60:	09092583          	lw	a1,144(s2)
    80005a64:	00092503          	lw	a0,0(s2)
    80005a68:	a44ff0ef          	jal	ra,80004cac <bfree>
    80005a6c:	08092823          	sw	zero,144(s2)
    80005a70:	ee9ff06f          	j	80005958 <iput+0xec>
    80005a74:	00092503          	lw	a0,0(s2)
    80005a78:	a34ff0ef          	jal	ra,80004cac <bfree>
    80005a7c:	fd9ff06f          	j	80005a54 <iput+0x1e8>
    80005a80:	00090513          	mv	a0,s2
    80005a84:	f68ff0ef          	jal	ra,800051ec <ilock.part.0>
    80005a88:	e9dff06f          	j	80005924 <iput+0xb8>
    80005a8c:	000c0513          	mv	a0,s8
    80005a90:	8a5fe0ef          	jal	ra,80004334 <brelse>
    80005a94:	09492583          	lw	a1,148(s2)
    80005a98:	00092503          	lw	a0,0(s2)
    80005a9c:	a10ff0ef          	jal	ra,80004cac <bfree>
    80005aa0:	08092a23          	sw	zero,148(s2)
    80005aa4:	ebdff06f          	j	80005960 <iput+0xf4>

0000000080005aa8 <ilock>:
    80005aa8:	ff010113          	addi	sp,sp,-16
    80005aac:	00813023          	sd	s0,0(sp)
    80005ab0:	00113423          	sd	ra,8(sp)
    80005ab4:	00050413          	mv	s0,a0
    80005ab8:	02050c63          	beqz	a0,80005af0 <ilock+0x48>
    80005abc:	01040513          	addi	a0,s0,16
    80005ac0:	b08fe0ef          	jal	ra,80003dc8 <acquiresleep>
    80005ac4:	04042783          	lw	a5,64(s0)
    80005ac8:	00078a63          	beqz	a5,80005adc <ilock+0x34>
    80005acc:	00813083          	ld	ra,8(sp)
    80005ad0:	00013403          	ld	s0,0(sp)
    80005ad4:	01010113          	addi	sp,sp,16
    80005ad8:	00008067          	ret
    80005adc:	00040513          	mv	a0,s0
    80005ae0:	00013403          	ld	s0,0(sp)
    80005ae4:	00813083          	ld	ra,8(sp)
    80005ae8:	01010113          	addi	sp,sp,16
    80005aec:	f00ff06f          	j	800051ec <ilock.part.0>
    80005af0:	00002517          	auipc	a0,0x2
    80005af4:	b8050513          	addi	a0,a0,-1152 # 80007670 <state_names.0+0x2c0>
    80005af8:	9a4fb0ef          	jal	ra,80000c9c <panic>
    80005afc:	fc1ff06f          	j	80005abc <ilock+0x14>

0000000080005b00 <iunlock>:
    80005b00:	ff010113          	addi	sp,sp,-16
    80005b04:	00813023          	sd	s0,0(sp)
    80005b08:	00113423          	sd	ra,8(sp)
    80005b0c:	01050413          	addi	s0,a0,16
    80005b10:	00050863          	beqz	a0,80005b20 <iunlock+0x20>
    80005b14:	00040513          	mv	a0,s0
    80005b18:	b40fe0ef          	jal	ra,80003e58 <holdingsleep>
    80005b1c:	00051863          	bnez	a0,80005b2c <iunlock+0x2c>
    80005b20:	00002517          	auipc	a0,0x2
    80005b24:	b4850513          	addi	a0,a0,-1208 # 80007668 <state_names.0+0x2b8>
    80005b28:	974fb0ef          	jal	ra,80000c9c <panic>
    80005b2c:	00040513          	mv	a0,s0
    80005b30:	00013403          	ld	s0,0(sp)
    80005b34:	00813083          	ld	ra,8(sp)
    80005b38:	01010113          	addi	sp,sp,16
    80005b3c:	ae4fe06f          	j	80003e20 <releasesleep>

0000000080005b40 <readi>:
    80005b40:	04c52783          	lw	a5,76(a0)
    80005b44:	1ad7e863          	bltu	a5,a3,80005cf4 <readi+0x1b4>
    80005b48:	fa010113          	addi	sp,sp,-96
    80005b4c:	04913423          	sd	s1,72(sp)
    80005b50:	05213023          	sd	s2,64(sp)
    80005b54:	01713c23          	sd	s7,24(sp)
    80005b58:	00070493          	mv	s1,a4
    80005b5c:	04113c23          	sd	ra,88(sp)
    80005b60:	04813823          	sd	s0,80(sp)
    80005b64:	03313c23          	sd	s3,56(sp)
    80005b68:	03413823          	sd	s4,48(sp)
    80005b6c:	03513423          	sd	s5,40(sp)
    80005b70:	03613023          	sd	s6,32(sp)
    80005b74:	01813823          	sd	s8,16(sp)
    80005b78:	01913423          	sd	s9,8(sp)
    80005b7c:	00e6873b          	addw	a4,a3,a4
    80005b80:	00050913          	mv	s2,a0
    80005b84:	00068b93          	mv	s7,a3
    80005b88:	00000513          	li	a0,0
    80005b8c:	0cd76463          	bltu	a4,a3,80005c54 <readi+0x114>
    80005b90:	00060993          	mv	s3,a2
    80005b94:	00e7f463          	bgeu	a5,a4,80005b9c <readi+0x5c>
    80005b98:	40d784bb          	subw	s1,a5,a3
    80005b9c:	00000413          	li	s0,0
    80005ba0:	0a048863          	beqz	s1,80005c50 <readi+0x110>
    80005ba4:	00001a37          	lui	s4,0x1
    80005ba8:	00b00b13          	li	s6,11
    80005bac:	fffa0a13          	addi	s4,s4,-1 # fff <_binary_user_test_basic_bin_size+0x8be>
    80005bb0:	00001ab7          	lui	s5,0x1
    80005bb4:	00092503          	lw	a0,0(s2)
    80005bb8:	00cbd59b          	srliw	a1,s7,0xc
    80005bbc:	00cbd79b          	srliw	a5,s7,0xc
    80005bc0:	00050c9b          	sext.w	s9,a0
    80005bc4:	10bb7063          	bgeu	s6,a1,80005cc4 <readi+0x184>
    80005bc8:	00090513          	mv	a0,s2
    80005bcc:	c8cff0ef          	jal	ra,80005058 <bmap.part.0>
    80005bd0:	0005059b          	sext.w	a1,a0
    80005bd4:	000c8513          	mv	a0,s9
    80005bd8:	c28fe0ef          	jal	ra,80004000 <bread>
    80005bdc:	014bf633          	and	a2,s7,s4
    80005be0:	40ca87bb          	subw	a5,s5,a2
    80005be4:	408486bb          	subw	a3,s1,s0
    80005be8:	0007859b          	sext.w	a1,a5
    80005bec:	00b6f463          	bgeu	a3,a1,80005bf4 <readi+0xb4>
    80005bf0:	00068793          	mv	a5,a3
    80005bf4:	02041593          	slli	a1,s0,0x20
    80005bf8:	02061613          	slli	a2,a2,0x20
    80005bfc:	0205d593          	srli	a1,a1,0x20
    80005c00:	06850713          	addi	a4,a0,104
    80005c04:	02065613          	srli	a2,a2,0x20
    80005c08:	013585b3          	add	a1,a1,s3
    80005c0c:	00c70633          	add	a2,a4,a2
    80005c10:	00078c1b          	sext.w	s8,a5
    80005c14:	06b67a63          	bgeu	a2,a1,80005c88 <readi+0x148>
    80005c18:	02079793          	slli	a5,a5,0x20
    80005c1c:	0207d793          	srli	a5,a5,0x20
    80005c20:	00f60733          	add	a4,a2,a5
    80005c24:	06e5f263          	bgeu	a1,a4,80005c88 <readi+0x148>
    80005c28:	00f587b3          	add	a5,a1,a5
    80005c2c:	fff74683          	lbu	a3,-1(a4)
    80005c30:	fff78793          	addi	a5,a5,-1
    80005c34:	fff70713          	addi	a4,a4,-1
    80005c38:	00d78023          	sb	a3,0(a5)
    80005c3c:	fef598e3          	bne	a1,a5,80005c2c <readi+0xec>
    80005c40:	008c043b          	addw	s0,s8,s0
    80005c44:	ef0fe0ef          	jal	ra,80004334 <brelse>
    80005c48:	017c0bbb          	addw	s7,s8,s7
    80005c4c:	f69464e3          	bltu	s0,s1,80005bb4 <readi+0x74>
    80005c50:	0004851b          	sext.w	a0,s1
    80005c54:	05813083          	ld	ra,88(sp)
    80005c58:	05013403          	ld	s0,80(sp)
    80005c5c:	04813483          	ld	s1,72(sp)
    80005c60:	04013903          	ld	s2,64(sp)
    80005c64:	03813983          	ld	s3,56(sp)
    80005c68:	03013a03          	ld	s4,48(sp)
    80005c6c:	02813a83          	ld	s5,40(sp)
    80005c70:	02013b03          	ld	s6,32(sp)
    80005c74:	01813b83          	ld	s7,24(sp)
    80005c78:	01013c03          	ld	s8,16(sp)
    80005c7c:	00813c83          	ld	s9,8(sp)
    80005c80:	06010113          	addi	sp,sp,96
    80005c84:	00008067          	ret
    80005c88:	020c1713          	slli	a4,s8,0x20
    80005c8c:	02075713          	srli	a4,a4,0x20
    80005c90:	00060793          	mv	a5,a2
    80005c94:	00e60733          	add	a4,a2,a4
    80005c98:	40c585b3          	sub	a1,a1,a2
    80005c9c:	0007c803          	lbu	a6,0(a5)
    80005ca0:	00b78633          	add	a2,a5,a1
    80005ca4:	00178793          	addi	a5,a5,1
    80005ca8:	01060023          	sb	a6,0(a2)
    80005cac:	fee798e3          	bne	a5,a4,80005c9c <readi+0x15c>
    80005cb0:	008c043b          	addw	s0,s8,s0
    80005cb4:	e80fe0ef          	jal	ra,80004334 <brelse>
    80005cb8:	017c0bbb          	addw	s7,s8,s7
    80005cbc:	ee946ce3          	bltu	s0,s1,80005bb4 <readi+0x74>
    80005cc0:	f91ff06f          	j	80005c50 <readi+0x110>
    80005cc4:	02079c13          	slli	s8,a5,0x20
    80005cc8:	01ec5c13          	srli	s8,s8,0x1e
    80005ccc:	01890c33          	add	s8,s2,s8
    80005cd0:	060c2583          	lw	a1,96(s8)
    80005cd4:	f00590e3          	bnez	a1,80005bd4 <readi+0x94>
    80005cd8:	a84ff0ef          	jal	ra,80004f5c <balloc>
    80005cdc:	0005059b          	sext.w	a1,a0
    80005ce0:	06bc2023          	sw	a1,96(s8)
    80005ce4:	05092783          	lw	a5,80(s2)
    80005ce8:	0017879b          	addiw	a5,a5,1
    80005cec:	04f92823          	sw	a5,80(s2)
    80005cf0:	ee5ff06f          	j	80005bd4 <readi+0x94>
    80005cf4:	00000513          	li	a0,0
    80005cf8:	00008067          	ret

0000000080005cfc <writei>:
    80005cfc:	04c52803          	lw	a6,76(a0)
    80005d00:	00068793          	mv	a5,a3
    80005d04:	00060593          	mv	a1,a2
    80005d08:	00070693          	mv	a3,a4
    80005d0c:	00f86a63          	bltu	a6,a5,80005d20 <writei+0x24>
    80005d10:	00e7873b          	addw	a4,a5,a4
    80005d14:	00f76663          	bltu	a4,a5,80005d20 <writei+0x24>
    80005d18:	00078613          	mv	a2,a5
    80005d1c:	f34ff06f          	j	80005450 <writei.part.0>
    80005d20:	fff00513          	li	a0,-1
    80005d24:	00008067          	ret

0000000080005d28 <dir_lookup>:
    80005d28:	04455703          	lhu	a4,68(a0)
    80005d2c:	f9010113          	addi	sp,sp,-112
    80005d30:	000047b7          	lui	a5,0x4
    80005d34:	05213823          	sd	s2,80(sp)
    80005d38:	05313423          	sd	s3,72(sp)
    80005d3c:	03513c23          	sd	s5,56(sp)
    80005d40:	06113423          	sd	ra,104(sp)
    80005d44:	06813023          	sd	s0,96(sp)
    80005d48:	04913c23          	sd	s1,88(sp)
    80005d4c:	05413023          	sd	s4,64(sp)
    80005d50:	00e7f7b3          	and	a5,a5,a4
    80005d54:	00050913          	mv	s2,a0
    80005d58:	00058993          	mv	s3,a1
    80005d5c:	00060a93          	mv	s5,a2
    80005d60:	0a078e63          	beqz	a5,80005e1c <dir_lookup+0xf4>
    80005d64:	04c92783          	lw	a5,76(s2)
    80005d68:	00000493          	li	s1,0
    80005d6c:	00002a17          	auipc	s4,0x2
    80005d70:	924a0a13          	addi	s4,s4,-1756 # 80007690 <state_names.0+0x2e0>
    80005d74:	02c10413          	addi	s0,sp,44
    80005d78:	06078e63          	beqz	a5,80005df4 <dir_lookup+0xcc>
    80005d7c:	02400713          	li	a4,36
    80005d80:	00048693          	mv	a3,s1
    80005d84:	00810613          	addi	a2,sp,8
    80005d88:	00000593          	li	a1,0
    80005d8c:	00090513          	mv	a0,s2
    80005d90:	db1ff0ef          	jal	ra,80005b40 <readi>
    80005d94:	02400793          	li	a5,36
    80005d98:	00f50663          	beq	a0,a5,80005da4 <dir_lookup+0x7c>
    80005d9c:	000a0513          	mv	a0,s4
    80005da0:	efdfa0ef          	jal	ra,80000c9c <panic>
    80005da4:	00812583          	lw	a1,8(sp)
    80005da8:	04058063          	beqz	a1,80005de8 <dir_lookup+0xc0>
    80005dac:	00098713          	mv	a4,s3
    80005db0:	00c10793          	addi	a5,sp,12
    80005db4:	00074803          	lbu	a6,0(a4)
    80005db8:	00178793          	addi	a5,a5,1 # 4001 <_binary_user_test_basic_bin_size+0x38c0>
    80005dbc:	fff7c883          	lbu	a7,-1(a5)
    80005dc0:	02080263          	beqz	a6,80005de4 <dir_lookup+0xbc>
    80005dc4:	00170713          	addi	a4,a4,1
    80005dc8:	03181063          	bne	a6,a7,80005de8 <dir_lookup+0xc0>
    80005dcc:	fe8794e3          	bne	a5,s0,80005db4 <dir_lookup+0x8c>
    80005dd0:	000a8463          	beqz	s5,80005dd8 <dir_lookup+0xb0>
    80005dd4:	009aa023          	sw	s1,0(s5) # 1000 <_binary_user_test_basic_bin_size+0x8bf>
    80005dd8:	00092503          	lw	a0,0(s2)
    80005ddc:	921ff0ef          	jal	ra,800056fc <iget>
    80005de0:	0180006f          	j	80005df8 <dir_lookup+0xd0>
    80005de4:	fe0886e3          	beqz	a7,80005dd0 <dir_lookup+0xa8>
    80005de8:	04c92783          	lw	a5,76(s2)
    80005dec:	0244849b          	addiw	s1,s1,36
    80005df0:	f8f4e6e3          	bltu	s1,a5,80005d7c <dir_lookup+0x54>
    80005df4:	00000513          	li	a0,0
    80005df8:	06813083          	ld	ra,104(sp)
    80005dfc:	06013403          	ld	s0,96(sp)
    80005e00:	05813483          	ld	s1,88(sp)
    80005e04:	05013903          	ld	s2,80(sp)
    80005e08:	04813983          	ld	s3,72(sp)
    80005e0c:	04013a03          	ld	s4,64(sp)
    80005e10:	03813a83          	ld	s5,56(sp)
    80005e14:	07010113          	addi	sp,sp,112
    80005e18:	00008067          	ret
    80005e1c:	00002517          	auipc	a0,0x2
    80005e20:	85c50513          	addi	a0,a0,-1956 # 80007678 <state_names.0+0x2c8>
    80005e24:	e79fa0ef          	jal	ra,80000c9c <panic>
    80005e28:	f3dff06f          	j	80005d64 <dir_lookup+0x3c>

0000000080005e2c <namex>:
    80005e2c:	f8010113          	addi	sp,sp,-128
    80005e30:	06813823          	sd	s0,112(sp)
    80005e34:	05313c23          	sd	s3,88(sp)
    80005e38:	00050413          	mv	s0,a0
    80005e3c:	00058993          	mv	s3,a1
    80005e40:	00100513          	li	a0,1
    80005e44:	00100593          	li	a1,1
    80005e48:	05613023          	sd	s6,64(sp)
    80005e4c:	03913423          	sd	s9,40(sp)
    80005e50:	06113c23          	sd	ra,120(sp)
    80005e54:	06913423          	sd	s1,104(sp)
    80005e58:	07213023          	sd	s2,96(sp)
    80005e5c:	05413823          	sd	s4,80(sp)
    80005e60:	05513423          	sd	s5,72(sp)
    80005e64:	03713c23          	sd	s7,56(sp)
    80005e68:	03813823          	sd	s8,48(sp)
    80005e6c:	03a13023          	sd	s10,32(sp)
    80005e70:	00060b13          	mv	s6,a2
    80005e74:	889ff0ef          	jal	ra,800056fc <iget>
    80005e78:	00050c93          	mv	s9,a0
    80005e7c:	30050c63          	beqz	a0,80006194 <namex+0x368>
    80005e80:	010c8513          	addi	a0,s9,16
    80005e84:	f45fd0ef          	jal	ra,80003dc8 <acquiresleep>
    80005e88:	040ca783          	lw	a5,64(s9)
    80005e8c:	28078463          	beqz	a5,80006114 <namex+0x2e8>
    80005e90:	00044783          	lbu	a5,0(s0)
    80005e94:	fff00b93          	li	s7,-1
    80005e98:	00010023          	sb	zero,0(sp)
    80005e9c:	02f00493          	li	s1,47
    80005ea0:	00010913          	mv	s2,sp
    80005ea4:	01f00a93          	li	s5,31
    80005ea8:	020bdb93          	srli	s7,s7,0x20
    80005eac:	00004a37          	lui	s4,0x4
    80005eb0:	0e979463          	bne	a5,s1,80005f98 <namex+0x16c>
    80005eb4:	00144783          	lbu	a5,1(s0)
    80005eb8:	00140413          	addi	s0,s0,1
    80005ebc:	fe978ce3          	beq	a5,s1,80005eb4 <namex+0x88>
    80005ec0:	1a078a63          	beqz	a5,80006074 <namex+0x248>
    80005ec4:	00078613          	mv	a2,a5
    80005ec8:	00040713          	mv	a4,s0
    80005ecc:	22978663          	beq	a5,s1,800060f8 <namex+0x2cc>
    80005ed0:	0c078c63          	beqz	a5,80005fa8 <namex+0x17c>
    80005ed4:	00144783          	lbu	a5,1(s0)
    80005ed8:	00140413          	addi	s0,s0,1
    80005edc:	fe979ae3          	bne	a5,s1,80005ed0 <namex+0xa4>
    80005ee0:	40e406b3          	sub	a3,s0,a4
    80005ee4:	0006881b          	sext.w	a6,a3
    80005ee8:	0d0ad863          	bge	s5,a6,80005fb8 <namex+0x18c>
    80005eec:	13277663          	bgeu	a4,s2,80006018 <namex+0x1ec>
    80005ef0:	02070693          	addi	a3,a4,32
    80005ef4:	12d97263          	bgeu	s2,a3,80006018 <namex+0x1ec>
    80005ef8:	02010713          	addi	a4,sp,32
    80005efc:	fff6c603          	lbu	a2,-1(a3)
    80005f00:	fff70713          	addi	a4,a4,-1
    80005f04:	fff68693          	addi	a3,a3,-1
    80005f08:	00c70023          	sb	a2,0(a4)
    80005f0c:	ff2718e3          	bne	a4,s2,80005efc <namex+0xd0>
    80005f10:	00979863          	bne	a5,s1,80005f20 <namex+0xf4>
    80005f14:	00144783          	lbu	a5,1(s0)
    80005f18:	00140413          	addi	s0,s0,1
    80005f1c:	fe978ce3          	beq	a5,s1,80005f14 <namex+0xe8>
    80005f20:	00098663          	beqz	s3,80005f2c <namex+0x100>
    80005f24:	00044783          	lbu	a5,0(s0)
    80005f28:	26078e63          	beqz	a5,800061a4 <namex+0x378>
    80005f2c:	044cd783          	lhu	a5,68(s9)
    80005f30:	010c8d13          	addi	s10,s9,16
    80005f34:	0147f7b3          	and	a5,a5,s4
    80005f38:	1e078c63          	beqz	a5,80006130 <namex+0x304>
    80005f3c:	00000613          	li	a2,0
    80005f40:	00090593          	mv	a1,s2
    80005f44:	000c8513          	mv	a0,s9
    80005f48:	de1ff0ef          	jal	ra,80005d28 <dir_lookup>
    80005f4c:	00050c13          	mv	s8,a0
    80005f50:	000d0513          	mv	a0,s10
    80005f54:	f05fd0ef          	jal	ra,80003e58 <holdingsleep>
    80005f58:	00051863          	bnez	a0,80005f68 <namex+0x13c>
    80005f5c:	00001517          	auipc	a0,0x1
    80005f60:	70c50513          	addi	a0,a0,1804 # 80007668 <state_names.0+0x2b8>
    80005f64:	d39fa0ef          	jal	ra,80000c9c <panic>
    80005f68:	000d0513          	mv	a0,s10
    80005f6c:	eb5fd0ef          	jal	ra,80003e20 <releasesleep>
    80005f70:	000c8513          	mv	a0,s9
    80005f74:	1a0c0863          	beqz	s8,80006124 <namex+0x2f8>
    80005f78:	8f5ff0ef          	jal	ra,8000586c <iput>
    80005f7c:	010c0513          	addi	a0,s8,16
    80005f80:	e49fd0ef          	jal	ra,80003dc8 <acquiresleep>
    80005f84:	040c2783          	lw	a5,64(s8)
    80005f88:	08078063          	beqz	a5,80006008 <namex+0x1dc>
    80005f8c:	000c0c93          	mv	s9,s8
    80005f90:	00044783          	lbu	a5,0(s0)
    80005f94:	f29780e3          	beq	a5,s1,80005eb4 <namex+0x88>
    80005f98:	0c078e63          	beqz	a5,80006074 <namex+0x248>
    80005f9c:	00078613          	mv	a2,a5
    80005fa0:	00040713          	mv	a4,s0
    80005fa4:	f20798e3          	bnez	a5,80005ed4 <namex+0xa8>
    80005fa8:	40e406b3          	sub	a3,s0,a4
    80005fac:	0006881b          	sext.w	a6,a3
    80005fb0:	00044783          	lbu	a5,0(s0)
    80005fb4:	f30acce3          	blt	s5,a6,80005eec <namex+0xc0>
    80005fb8:	fff8089b          	addiw	a7,a6,-1
    80005fbc:	01090333          	add	t1,s2,a6
    80005fc0:	0008859b          	sext.w	a1,a7
    80005fc4:	07277c63          	bgeu	a4,s2,8000603c <namex+0x210>
    80005fc8:	0176f6b3          	and	a3,a3,s7
    80005fcc:	00d70533          	add	a0,a4,a3
    80005fd0:	06a97663          	bgeu	s2,a0,8000603c <namex+0x210>
    80005fd4:	00d90733          	add	a4,s2,a3
    80005fd8:	02080463          	beqz	a6,80006000 <namex+0x1d4>
    80005fdc:	02089693          	slli	a3,a7,0x20
    80005fe0:	0206d693          	srli	a3,a3,0x20
    80005fe4:	fff6c693          	not	a3,a3
    80005fe8:	00d706b3          	add	a3,a4,a3
    80005fec:	fff54603          	lbu	a2,-1(a0)
    80005ff0:	fff70713          	addi	a4,a4,-1
    80005ff4:	fff50513          	addi	a0,a0,-1
    80005ff8:	00c70023          	sb	a2,0(a4)
    80005ffc:	fed718e3          	bne	a4,a3,80005fec <namex+0x1c0>
    80006000:	00030023          	sb	zero,0(t1)
    80006004:	f0dff06f          	j	80005f10 <namex+0xe4>
    80006008:	000c0513          	mv	a0,s8
    8000600c:	9e0ff0ef          	jal	ra,800051ec <ilock.part.0>
    80006010:	000c0c93          	mv	s9,s8
    80006014:	f7dff06f          	j	80005f90 <namex+0x164>
    80006018:	00090693          	mv	a3,s2
    8000601c:	0080006f          	j	80006024 <namex+0x1f8>
    80006020:	00074603          	lbu	a2,0(a4)
    80006024:	00168693          	addi	a3,a3,1
    80006028:	fec68fa3          	sb	a2,-1(a3)
    8000602c:	02010613          	addi	a2,sp,32
    80006030:	00170713          	addi	a4,a4,1
    80006034:	fec696e3          	bne	a3,a2,80006020 <namex+0x1f4>
    80006038:	ed9ff06f          	j	80005f10 <namex+0xe4>
    8000603c:	fc0802e3          	beqz	a6,80006000 <namex+0x1d4>
    80006040:	02059593          	slli	a1,a1,0x20
    80006044:	0205d593          	srli	a1,a1,0x20
    80006048:	00158593          	addi	a1,a1,1
    8000604c:	00b705b3          	add	a1,a4,a1
    80006050:	00090693          	mv	a3,s2
    80006054:	0080006f          	j	8000605c <namex+0x230>
    80006058:	00074603          	lbu	a2,0(a4)
    8000605c:	00c68023          	sb	a2,0(a3)
    80006060:	00170713          	addi	a4,a4,1
    80006064:	00168693          	addi	a3,a3,1
    80006068:	feb718e3          	bne	a4,a1,80006058 <namex+0x22c>
    8000606c:	00030023          	sb	zero,0(t1)
    80006070:	ea1ff06f          	j	80005f10 <namex+0xe4>
    80006074:	0a099663          	bnez	s3,80006120 <namex+0x2f4>
    80006078:	020b0663          	beqz	s6,800060a4 <namex+0x278>
    8000607c:	00010793          	mv	a5,sp
    80006080:	0f67f063          	bgeu	a5,s6,80006160 <namex+0x334>
    80006084:	02010713          	addi	a4,sp,32
    80006088:	0ceb7c63          	bgeu	s6,a4,80006160 <namex+0x334>
    8000608c:	020b0b13          	addi	s6,s6,32 # 1020 <_binary_user_test_basic_bin_size+0x8df>
    80006090:	fff74683          	lbu	a3,-1(a4)
    80006094:	fff70713          	addi	a4,a4,-1
    80006098:	fffb0b13          	addi	s6,s6,-1
    8000609c:	00db0023          	sb	a3,0(s6)
    800060a0:	fef718e3          	bne	a4,a5,80006090 <namex+0x264>
    800060a4:	010c8413          	addi	s0,s9,16
    800060a8:	00040513          	mv	a0,s0
    800060ac:	dadfd0ef          	jal	ra,80003e58 <holdingsleep>
    800060b0:	04050a63          	beqz	a0,80006104 <namex+0x2d8>
    800060b4:	00040513          	mv	a0,s0
    800060b8:	d69fd0ef          	jal	ra,80003e20 <releasesleep>
    800060bc:	07813083          	ld	ra,120(sp)
    800060c0:	07013403          	ld	s0,112(sp)
    800060c4:	06813483          	ld	s1,104(sp)
    800060c8:	06013903          	ld	s2,96(sp)
    800060cc:	05813983          	ld	s3,88(sp)
    800060d0:	05013a03          	ld	s4,80(sp)
    800060d4:	04813a83          	ld	s5,72(sp)
    800060d8:	04013b03          	ld	s6,64(sp)
    800060dc:	03813b83          	ld	s7,56(sp)
    800060e0:	03013c03          	ld	s8,48(sp)
    800060e4:	02013d03          	ld	s10,32(sp)
    800060e8:	000c8513          	mv	a0,s9
    800060ec:	02813c83          	ld	s9,40(sp)
    800060f0:	08010113          	addi	sp,sp,128
    800060f4:	00008067          	ret
    800060f8:	00090313          	mv	t1,s2
    800060fc:	00030023          	sb	zero,0(t1)
    80006100:	e11ff06f          	j	80005f10 <namex+0xe4>
    80006104:	00001517          	auipc	a0,0x1
    80006108:	56450513          	addi	a0,a0,1380 # 80007668 <state_names.0+0x2b8>
    8000610c:	b91fa0ef          	jal	ra,80000c9c <panic>
    80006110:	fa5ff06f          	j	800060b4 <namex+0x288>
    80006114:	000c8513          	mv	a0,s9
    80006118:	8d4ff0ef          	jal	ra,800051ec <ilock.part.0>
    8000611c:	d75ff06f          	j	80005e90 <namex+0x64>
    80006120:	000c8513          	mv	a0,s9
    80006124:	f48ff0ef          	jal	ra,8000586c <iput>
    80006128:	00000c93          	li	s9,0
    8000612c:	f91ff06f          	j	800060bc <namex+0x290>
    80006130:	000d0513          	mv	a0,s10
    80006134:	d25fd0ef          	jal	ra,80003e58 <holdingsleep>
    80006138:	00051863          	bnez	a0,80006148 <namex+0x31c>
    8000613c:	00001517          	auipc	a0,0x1
    80006140:	52c50513          	addi	a0,a0,1324 # 80007668 <state_names.0+0x2b8>
    80006144:	b59fa0ef          	jal	ra,80000c9c <panic>
    80006148:	000d0513          	mv	a0,s10
    8000614c:	cd5fd0ef          	jal	ra,80003e20 <releasesleep>
    80006150:	000c8513          	mv	a0,s9
    80006154:	f18ff0ef          	jal	ra,8000586c <iput>
    80006158:	00000c93          	li	s9,0
    8000615c:	f61ff06f          	j	800060bc <namex+0x290>
    80006160:	0007c703          	lbu	a4,0(a5)
    80006164:	00178793          	addi	a5,a5,1
    80006168:	001b0b13          	addi	s6,s6,1
    8000616c:	feeb0fa3          	sb	a4,-1(s6)
    80006170:	02010713          	addi	a4,sp,32
    80006174:	f2e788e3          	beq	a5,a4,800060a4 <namex+0x278>
    80006178:	0007c703          	lbu	a4,0(a5)
    8000617c:	00178793          	addi	a5,a5,1
    80006180:	001b0b13          	addi	s6,s6,1
    80006184:	feeb0fa3          	sb	a4,-1(s6)
    80006188:	02010713          	addi	a4,sp,32
    8000618c:	fce79ae3          	bne	a5,a4,80006160 <namex+0x334>
    80006190:	f15ff06f          	j	800060a4 <namex+0x278>
    80006194:	00001517          	auipc	a0,0x1
    80006198:	4dc50513          	addi	a0,a0,1244 # 80007670 <state_names.0+0x2c0>
    8000619c:	b01fa0ef          	jal	ra,80000c9c <panic>
    800061a0:	ce1ff06f          	j	80005e80 <namex+0x54>
    800061a4:	f00b00e3          	beqz	s6,800060a4 <namex+0x278>
    800061a8:	03697463          	bgeu	s2,s6,800061d0 <namex+0x3a4>
    800061ac:	02010793          	addi	a5,sp,32
    800061b0:	02fb7063          	bgeu	s6,a5,800061d0 <namex+0x3a4>
    800061b4:	020b0b13          	addi	s6,s6,32
    800061b8:	fff7c703          	lbu	a4,-1(a5)
    800061bc:	fff78793          	addi	a5,a5,-1
    800061c0:	fffb0b13          	addi	s6,s6,-1
    800061c4:	00eb0023          	sb	a4,0(s6)
    800061c8:	ff2798e3          	bne	a5,s2,800061b8 <namex+0x38c>
    800061cc:	ed9ff06f          	j	800060a4 <namex+0x278>
    800061d0:	00094783          	lbu	a5,0(s2)
    800061d4:	00190913          	addi	s2,s2,1
    800061d8:	001b0b13          	addi	s6,s6,1
    800061dc:	fefb0fa3          	sb	a5,-1(s6)
    800061e0:	02010793          	addi	a5,sp,32
    800061e4:	ecf900e3          	beq	s2,a5,800060a4 <namex+0x278>
    800061e8:	00094783          	lbu	a5,0(s2)
    800061ec:	00190913          	addi	s2,s2,1
    800061f0:	001b0b13          	addi	s6,s6,1
    800061f4:	fefb0fa3          	sb	a5,-1(s6)
    800061f8:	02010793          	addi	a5,sp,32
    800061fc:	fcf91ae3          	bne	s2,a5,800061d0 <namex+0x3a4>
    80006200:	ea5ff06f          	j	800060a4 <namex+0x278>

0000000080006204 <dir_link>:
    80006204:	04455703          	lhu	a4,68(a0)
    80006208:	fa010113          	addi	sp,sp,-96
    8000620c:	000047b7          	lui	a5,0x4
    80006210:	04913423          	sd	s1,72(sp)
    80006214:	05213023          	sd	s2,64(sp)
    80006218:	03413823          	sd	s4,48(sp)
    8000621c:	04113c23          	sd	ra,88(sp)
    80006220:	04813823          	sd	s0,80(sp)
    80006224:	03313c23          	sd	s3,56(sp)
    80006228:	00e7f7b3          	and	a5,a5,a4
    8000622c:	00050913          	mv	s2,a0
    80006230:	00058493          	mv	s1,a1
    80006234:	00060a13          	mv	s4,a2
    80006238:	0e078e63          	beqz	a5,80006334 <dir_link+0x130>
    8000623c:	00000613          	li	a2,0
    80006240:	00048593          	mv	a1,s1
    80006244:	00090513          	mv	a0,s2
    80006248:	ae1ff0ef          	jal	ra,80005d28 <dir_lookup>
    8000624c:	0e051c63          	bnez	a0,80006344 <dir_link+0x140>
    80006250:	04c92403          	lw	s0,76(s2)
    80006254:	00000693          	li	a3,0
    80006258:	04040a63          	beqz	s0,800062ac <dir_link+0xa8>
    8000625c:	00000413          	li	s0,0
    80006260:	00001997          	auipc	s3,0x1
    80006264:	45898993          	addi	s3,s3,1112 # 800076b8 <state_names.0+0x308>
    80006268:	00c0006f          	j	80006274 <dir_link+0x70>
    8000626c:	0244041b          	addiw	s0,s0,36
    80006270:	02d47e63          	bgeu	s0,a3,800062ac <dir_link+0xa8>
    80006274:	02400713          	li	a4,36
    80006278:	00040693          	mv	a3,s0
    8000627c:	00810613          	addi	a2,sp,8
    80006280:	00000593          	li	a1,0
    80006284:	00090513          	mv	a0,s2
    80006288:	8b9ff0ef          	jal	ra,80005b40 <readi>
    8000628c:	00050713          	mv	a4,a0
    80006290:	02400793          	li	a5,36
    80006294:	00098513          	mv	a0,s3
    80006298:	00f70463          	beq	a4,a5,800062a0 <dir_link+0x9c>
    8000629c:	a01fa0ef          	jal	ra,80000c9c <panic>
    800062a0:	00812783          	lw	a5,8(sp)
    800062a4:	04c92683          	lw	a3,76(s2)
    800062a8:	fc0792e3          	bnez	a5,8000626c <dir_link+0x68>
    800062ac:	01412423          	sw	s4,8(sp)
    800062b0:	00c10793          	addi	a5,sp,12
    800062b4:	02b10613          	addi	a2,sp,43
    800062b8:	0100006f          	j	800062c8 <dir_link+0xc4>
    800062bc:	00178793          	addi	a5,a5,1 # 4001 <_binary_user_test_basic_bin_size+0x38c0>
    800062c0:	fee78fa3          	sb	a4,-1(a5)
    800062c4:	00c78863          	beq	a5,a2,800062d4 <dir_link+0xd0>
    800062c8:	0004c703          	lbu	a4,0(s1)
    800062cc:	00148493          	addi	s1,s1,1
    800062d0:	fe0716e3          	bnez	a4,800062bc <dir_link+0xb8>
    800062d4:	00078023          	sb	zero,0(a5)
    800062d8:	0486e663          	bltu	a3,s0,80006324 <dir_link+0x120>
    800062dc:	fdb00793          	li	a5,-37
    800062e0:	0487e263          	bltu	a5,s0,80006324 <dir_link+0x120>
    800062e4:	02400693          	li	a3,36
    800062e8:	00040613          	mv	a2,s0
    800062ec:	00810593          	addi	a1,sp,8
    800062f0:	00090513          	mv	a0,s2
    800062f4:	95cff0ef          	jal	ra,80005450 <writei.part.0>
    800062f8:	02400793          	li	a5,36
    800062fc:	02f51463          	bne	a0,a5,80006324 <dir_link+0x120>
    80006300:	00000513          	li	a0,0
    80006304:	05813083          	ld	ra,88(sp)
    80006308:	05013403          	ld	s0,80(sp)
    8000630c:	04813483          	ld	s1,72(sp)
    80006310:	04013903          	ld	s2,64(sp)
    80006314:	03813983          	ld	s3,56(sp)
    80006318:	03013a03          	ld	s4,48(sp)
    8000631c:	06010113          	addi	sp,sp,96
    80006320:	00008067          	ret
    80006324:	00001517          	auipc	a0,0x1
    80006328:	3a450513          	addi	a0,a0,932 # 800076c8 <state_names.0+0x318>
    8000632c:	971fa0ef          	jal	ra,80000c9c <panic>
    80006330:	fd1ff06f          	j	80006300 <dir_link+0xfc>
    80006334:	00001517          	auipc	a0,0x1
    80006338:	36c50513          	addi	a0,a0,876 # 800076a0 <state_names.0+0x2f0>
    8000633c:	961fa0ef          	jal	ra,80000c9c <panic>
    80006340:	efdff06f          	j	8000623c <dir_link+0x38>
    80006344:	d28ff0ef          	jal	ra,8000586c <iput>
    80006348:	fff00513          	li	a0,-1
    8000634c:	fb9ff06f          	j	80006304 <dir_link+0x100>

0000000080006350 <dir_unlink>:
    80006350:	04455703          	lhu	a4,68(a0)
    80006354:	000047b7          	lui	a5,0x4
    80006358:	00e7f7b3          	and	a5,a5,a4
    8000635c:	24078c63          	beqz	a5,800065b4 <dir_unlink+0x264>
    80006360:	f9010113          	addi	sp,sp,-112
    80006364:	04913c23          	sd	s1,88(sp)
    80006368:	06113423          	sd	ra,104(sp)
    8000636c:	00050493          	mv	s1,a0
    80006370:	06813023          	sd	s0,96(sp)
    80006374:	05213823          	sd	s2,80(sp)
    80006378:	05313423          	sd	s3,72(sp)
    8000637c:	05413023          	sd	s4,64(sp)
    80006380:	03513c23          	sd	s5,56(sp)
    80006384:	00058713          	mv	a4,a1
    80006388:	02e00613          	li	a2,46
    8000638c:	00001797          	auipc	a5,0x1
    80006390:	34c78793          	addi	a5,a5,844 # 800076d8 <state_names.0+0x328>
    80006394:	00001517          	auipc	a0,0x1
    80006398:	36450513          	addi	a0,a0,868 # 800076f8 <state_names.0+0x348>
    8000639c:	0080006f          	j	800063a4 <dir_unlink+0x54>
    800063a0:	0007c603          	lbu	a2,0(a5)
    800063a4:	00074683          	lbu	a3,0(a4)
    800063a8:	00178793          	addi	a5,a5,1
    800063ac:	00170713          	addi	a4,a4,1
    800063b0:	02068a63          	beqz	a3,800063e4 <dir_unlink+0x94>
    800063b4:	02c69a63          	bne	a3,a2,800063e8 <dir_unlink+0x98>
    800063b8:	fea794e3          	bne	a5,a0,800063a0 <dir_unlink+0x50>
    800063bc:	fff00513          	li	a0,-1
    800063c0:	06813083          	ld	ra,104(sp)
    800063c4:	06013403          	ld	s0,96(sp)
    800063c8:	05813483          	ld	s1,88(sp)
    800063cc:	05013903          	ld	s2,80(sp)
    800063d0:	04813983          	ld	s3,72(sp)
    800063d4:	04013a03          	ld	s4,64(sp)
    800063d8:	03813a83          	ld	s5,56(sp)
    800063dc:	07010113          	addi	sp,sp,112
    800063e0:	00008067          	ret
    800063e4:	fc060ce3          	beqz	a2,800063bc <dir_unlink+0x6c>
    800063e8:	00058713          	mv	a4,a1
    800063ec:	02e00613          	li	a2,46
    800063f0:	00001797          	auipc	a5,0x1
    800063f4:	2f078793          	addi	a5,a5,752 # 800076e0 <state_names.0+0x330>
    800063f8:	00001517          	auipc	a0,0x1
    800063fc:	30850513          	addi	a0,a0,776 # 80007700 <state_names.0+0x350>
    80006400:	0080006f          	j	80006408 <dir_unlink+0xb8>
    80006404:	0007c603          	lbu	a2,0(a5)
    80006408:	00074683          	lbu	a3,0(a4)
    8000640c:	00178793          	addi	a5,a5,1
    80006410:	00170713          	addi	a4,a4,1
    80006414:	00068863          	beqz	a3,80006424 <dir_unlink+0xd4>
    80006418:	00d61863          	bne	a2,a3,80006428 <dir_unlink+0xd8>
    8000641c:	fea794e3          	bne	a5,a0,80006404 <dir_unlink+0xb4>
    80006420:	f9dff06f          	j	800063bc <dir_unlink+0x6c>
    80006424:	f8060ce3          	beqz	a2,800063bc <dir_unlink+0x6c>
    80006428:	00410613          	addi	a2,sp,4
    8000642c:	00048513          	mv	a0,s1
    80006430:	8f9ff0ef          	jal	ra,80005d28 <dir_lookup>
    80006434:	00050413          	mv	s0,a0
    80006438:	f80502e3          	beqz	a0,800063bc <dir_unlink+0x6c>
    8000643c:	01050a93          	addi	s5,a0,16
    80006440:	000a8513          	mv	a0,s5
    80006444:	985fd0ef          	jal	ra,80003dc8 <acquiresleep>
    80006448:	04042783          	lw	a5,64(s0)
    8000644c:	14078463          	beqz	a5,80006594 <dir_unlink+0x244>
    80006450:	04a45783          	lhu	a5,74(s0)
    80006454:	14078863          	beqz	a5,800065a4 <dir_unlink+0x254>
    80006458:	04445703          	lhu	a4,68(s0)
    8000645c:	000047b7          	lui	a5,0x4
    80006460:	00810993          	addi	s3,sp,8
    80006464:	00e7f7b3          	and	a5,a5,a4
    80006468:	08078863          	beqz	a5,800064f8 <dir_unlink+0x1a8>
    8000646c:	04c42703          	lw	a4,76(s0)
    80006470:	04800793          	li	a5,72
    80006474:	00810993          	addi	s3,sp,8
    80006478:	04800913          	li	s2,72
    8000647c:	00001a17          	auipc	s4,0x1
    80006480:	284a0a13          	addi	s4,s4,644 # 80007700 <state_names.0+0x350>
    80006484:	00e7e863          	bltu	a5,a4,80006494 <dir_unlink+0x144>
    80006488:	0700006f          	j	800064f8 <dir_unlink+0x1a8>
    8000648c:	04c42783          	lw	a5,76(s0)
    80006490:	06f97463          	bgeu	s2,a5,800064f8 <dir_unlink+0x1a8>
    80006494:	00090693          	mv	a3,s2
    80006498:	02400713          	li	a4,36
    8000649c:	00098613          	mv	a2,s3
    800064a0:	00000593          	li	a1,0
    800064a4:	00040513          	mv	a0,s0
    800064a8:	e98ff0ef          	jal	ra,80005b40 <readi>
    800064ac:	00050713          	mv	a4,a0
    800064b0:	02400793          	li	a5,36
    800064b4:	0249091b          	addiw	s2,s2,36
    800064b8:	000a0513          	mv	a0,s4
    800064bc:	00f70463          	beq	a4,a5,800064c4 <dir_unlink+0x174>
    800064c0:	fdcfa0ef          	jal	ra,80000c9c <panic>
    800064c4:	00812783          	lw	a5,8(sp)
    800064c8:	fc0782e3          	beqz	a5,8000648c <dir_unlink+0x13c>
    800064cc:	000a8513          	mv	a0,s5
    800064d0:	989fd0ef          	jal	ra,80003e58 <holdingsleep>
    800064d4:	00051863          	bnez	a0,800064e4 <dir_unlink+0x194>
    800064d8:	00001517          	auipc	a0,0x1
    800064dc:	19050513          	addi	a0,a0,400 # 80007668 <state_names.0+0x2b8>
    800064e0:	fbcfa0ef          	jal	ra,80000c9c <panic>
    800064e4:	000a8513          	mv	a0,s5
    800064e8:	939fd0ef          	jal	ra,80003e20 <releasesleep>
    800064ec:	00040513          	mv	a0,s0
    800064f0:	b7cff0ef          	jal	ra,8000586c <iput>
    800064f4:	ec9ff06f          	j	800063bc <dir_unlink+0x6c>
    800064f8:	04a45783          	lhu	a5,74(s0)
    800064fc:	00040513          	mv	a0,s0
    80006500:	fff7879b          	addiw	a5,a5,-1
    80006504:	04f41523          	sh	a5,74(s0)
    80006508:	871fe0ef          	jal	ra,80004d78 <iupdate>
    8000650c:	000a8513          	mv	a0,s5
    80006510:	949fd0ef          	jal	ra,80003e58 <holdingsleep>
    80006514:	04050e63          	beqz	a0,80006570 <dir_unlink+0x220>
    80006518:	000a8513          	mv	a0,s5
    8000651c:	905fd0ef          	jal	ra,80003e20 <releasesleep>
    80006520:	00040513          	mv	a0,s0
    80006524:	b48ff0ef          	jal	ra,8000586c <iput>
    80006528:	00098793          	mv	a5,s3
    8000652c:	02c10713          	addi	a4,sp,44
    80006530:	00178793          	addi	a5,a5,1 # 4001 <_binary_user_test_basic_bin_size+0x38c0>
    80006534:	fe078fa3          	sb	zero,-1(a5)
    80006538:	fee79ce3          	bne	a5,a4,80006530 <dir_unlink+0x1e0>
    8000653c:	00412603          	lw	a2,4(sp)
    80006540:	04c4a783          	lw	a5,76(s1)
    80006544:	02c7ee63          	bltu	a5,a2,80006580 <dir_unlink+0x230>
    80006548:	fdb00793          	li	a5,-37
    8000654c:	02c7ea63          	bltu	a5,a2,80006580 <dir_unlink+0x230>
    80006550:	02400693          	li	a3,36
    80006554:	00098593          	mv	a1,s3
    80006558:	00048513          	mv	a0,s1
    8000655c:	ef5fe0ef          	jal	ra,80005450 <writei.part.0>
    80006560:	02400793          	li	a5,36
    80006564:	00f51e63          	bne	a0,a5,80006580 <dir_unlink+0x230>
    80006568:	00000513          	li	a0,0
    8000656c:	e55ff06f          	j	800063c0 <dir_unlink+0x70>
    80006570:	00001517          	auipc	a0,0x1
    80006574:	0f850513          	addi	a0,a0,248 # 80007668 <state_names.0+0x2b8>
    80006578:	f24fa0ef          	jal	ra,80000c9c <panic>
    8000657c:	f9dff06f          	j	80006518 <dir_unlink+0x1c8>
    80006580:	00001517          	auipc	a0,0x1
    80006584:	19050513          	addi	a0,a0,400 # 80007710 <state_names.0+0x360>
    80006588:	f14fa0ef          	jal	ra,80000c9c <panic>
    8000658c:	00000513          	li	a0,0
    80006590:	e31ff06f          	j	800063c0 <dir_unlink+0x70>
    80006594:	00040513          	mv	a0,s0
    80006598:	c55fe0ef          	jal	ra,800051ec <ilock.part.0>
    8000659c:	04a45783          	lhu	a5,74(s0)
    800065a0:	ea079ce3          	bnez	a5,80006458 <dir_unlink+0x108>
    800065a4:	00001517          	auipc	a0,0x1
    800065a8:	14450513          	addi	a0,a0,324 # 800076e8 <state_names.0+0x338>
    800065ac:	ef0fa0ef          	jal	ra,80000c9c <panic>
    800065b0:	ea9ff06f          	j	80006458 <dir_unlink+0x108>
    800065b4:	fff00513          	li	a0,-1
    800065b8:	00008067          	ret

00000000800065bc <path_walk>:
    800065bc:	00000613          	li	a2,0
    800065c0:	00000593          	li	a1,0
    800065c4:	869ff06f          	j	80005e2c <namex>

00000000800065c8 <path_parent>:
    800065c8:	00058613          	mv	a2,a1
    800065cc:	00100593          	li	a1,1
    800065d0:	85dff06f          	j	80005e2c <namex>

00000000800065d4 <fs_create>:
    800065d4:	f3010113          	addi	sp,sp,-208
    800065d8:	09513c23          	sd	s5,152(sp)
    800065dc:	00810613          	addi	a2,sp,8
    800065e0:	00058a93          	mv	s5,a1
    800065e4:	00100593          	li	a1,1
    800065e8:	0c113423          	sd	ra,200(sp)
    800065ec:	0c813023          	sd	s0,192(sp)
    800065f0:	0a913c23          	sd	s1,184(sp)
    800065f4:	0b213823          	sd	s2,176(sp)
    800065f8:	0b313423          	sd	s3,168(sp)
    800065fc:	0b413023          	sd	s4,160(sp)
    80006600:	09613823          	sd	s6,144(sp)
    80006604:	09713423          	sd	s7,136(sp)
    80006608:	09813023          	sd	s8,128(sp)
    8000660c:	07913c23          	sd	s9,120(sp)
    80006610:	81dff0ef          	jal	ra,80005e2c <namex>
    80006614:	1c050063          	beqz	a0,800067d4 <fs_create+0x200>
    80006618:	01050b13          	addi	s6,a0,16
    8000661c:	00050493          	mv	s1,a0
    80006620:	000b0513          	mv	a0,s6
    80006624:	fa4fd0ef          	jal	ra,80003dc8 <acquiresleep>
    80006628:	0404a783          	lw	a5,64(s1)
    8000662c:	18078e63          	beqz	a5,800067c8 <fs_create+0x1f4>
    80006630:	00000613          	li	a2,0
    80006634:	00810593          	addi	a1,sp,8
    80006638:	00048513          	mv	a0,s1
    8000663c:	eecff0ef          	jal	ra,80005d28 <dir_lookup>
    80006640:	00050413          	mv	s0,a0
    80006644:	06050463          	beqz	a0,800066ac <fs_create+0xd8>
    80006648:	000b0513          	mv	a0,s6
    8000664c:	80dfd0ef          	jal	ra,80003e58 <holdingsleep>
    80006650:	04050663          	beqz	a0,8000669c <fs_create+0xc8>
    80006654:	000b0513          	mv	a0,s6
    80006658:	fc8fd0ef          	jal	ra,80003e20 <releasesleep>
    8000665c:	00048513          	mv	a0,s1
    80006660:	a0cff0ef          	jal	ra,8000586c <iput>
    80006664:	0c813083          	ld	ra,200(sp)
    80006668:	00040513          	mv	a0,s0
    8000666c:	0c013403          	ld	s0,192(sp)
    80006670:	0b813483          	ld	s1,184(sp)
    80006674:	0b013903          	ld	s2,176(sp)
    80006678:	0a813983          	ld	s3,168(sp)
    8000667c:	0a013a03          	ld	s4,160(sp)
    80006680:	09813a83          	ld	s5,152(sp)
    80006684:	09013b03          	ld	s6,144(sp)
    80006688:	08813b83          	ld	s7,136(sp)
    8000668c:	08013c03          	ld	s8,128(sp)
    80006690:	07813c83          	ld	s9,120(sp)
    80006694:	0d010113          	addi	sp,sp,208
    80006698:	00008067          	ret
    8000669c:	00001517          	auipc	a0,0x1
    800066a0:	fcc50513          	addi	a0,a0,-52 # 80007668 <state_names.0+0x2b8>
    800066a4:	df8fa0ef          	jal	ra,80000c9c <panic>
    800066a8:	fadff06f          	j	80006654 <fs_create+0x80>
    800066ac:	0004ab83          	lw	s7,0(s1)
    800066b0:	00100c13          	li	s8,1
    800066b4:	03000413          	li	s0,48
    800066b8:	000b899b          	sext.w	s3,s7
    800066bc:	05400913          	li	s2,84
    800066c0:	40000a13          	li	s4,1024
    800066c4:	0100006f          	j	800066d4 <fs_create+0x100>
    800066c8:	001c0c1b          	addiw	s8,s8,1
    800066cc:	c69fd0ef          	jal	ra,80004334 <brelse>
    800066d0:	1b4c0063          	beq	s8,s4,80006870 <fs_create+0x29c>
    800066d4:	028c55bb          	divuw	a1,s8,s0
    800066d8:	00098513          	mv	a0,s3
    800066dc:	0225859b          	addiw	a1,a1,34
    800066e0:	921fd0ef          	jal	ra,80004000 <bread>
    800066e4:	028c77bb          	remuw	a5,s8,s0
    800066e8:	06850713          	addi	a4,a0,104
    800066ec:	00050c93          	mv	s9,a0
    800066f0:	02079793          	slli	a5,a5,0x20
    800066f4:	0207d793          	srli	a5,a5,0x20
    800066f8:	032787b3          	mul	a5,a5,s2
    800066fc:	00f707b3          	add	a5,a4,a5
    80006700:	0017c703          	lbu	a4,1(a5)
    80006704:	0007c683          	lbu	a3,0(a5)
    80006708:	00871713          	slli	a4,a4,0x8
    8000670c:	00d76733          	or	a4,a4,a3
    80006710:	fa071ce3          	bnez	a4,800066c8 <fs_create+0xf4>
    80006714:	05478693          	addi	a3,a5,84
    80006718:	00078713          	mv	a4,a5
    8000671c:	00170713          	addi	a4,a4,1
    80006720:	fe070fa3          	sb	zero,-1(a4)
    80006724:	fed71ce3          	bne	a4,a3,8000671c <fs_create+0x148>
    80006728:	008ad713          	srli	a4,s5,0x8
    8000672c:	01578023          	sb	s5,0(a5)
    80006730:	00e780a3          	sb	a4,1(a5)
    80006734:	000c8513          	mv	a0,s9
    80006738:	c18fe0ef          	jal	ra,80004b50 <log_write>
    8000673c:	000c8513          	mv	a0,s9
    80006740:	bf5fd0ef          	jal	ra,80004334 <brelse>
    80006744:	000c0593          	mv	a1,s8
    80006748:	000b8513          	mv	a0,s7
    8000674c:	fb1fe0ef          	jal	ra,800056fc <iget>
    80006750:	00050413          	mv	s0,a0
    80006754:	12050463          	beqz	a0,8000687c <fs_create+0x2a8>
    80006758:	01050913          	addi	s2,a0,16
    8000675c:	00090513          	mv	a0,s2
    80006760:	e68fd0ef          	jal	ra,80003dc8 <acquiresleep>
    80006764:	04042783          	lw	a5,64(s0)
    80006768:	06078a63          	beqz	a5,800067dc <fs_create+0x208>
    8000676c:	00100793          	li	a5,1
    80006770:	04f41523          	sh	a5,74(s0)
    80006774:	00040513          	mv	a0,s0
    80006778:	e00fe0ef          	jal	ra,80004d78 <iupdate>
    8000677c:	000047b7          	lui	a5,0x4
    80006780:	06fa8c63          	beq	s5,a5,800067f8 <fs_create+0x224>
    80006784:	00442603          	lw	a2,4(s0)
    80006788:	00810593          	addi	a1,sp,8
    8000678c:	00048513          	mv	a0,s1
    80006790:	a75ff0ef          	jal	ra,80006204 <dir_link>
    80006794:	04054a63          	bltz	a0,800067e8 <fs_create+0x214>
    80006798:	00090513          	mv	a0,s2
    8000679c:	ebcfd0ef          	jal	ra,80003e58 <holdingsleep>
    800067a0:	00051863          	bnez	a0,800067b0 <fs_create+0x1dc>
    800067a4:	00001517          	auipc	a0,0x1
    800067a8:	ec450513          	addi	a0,a0,-316 # 80007668 <state_names.0+0x2b8>
    800067ac:	cf0fa0ef          	jal	ra,80000c9c <panic>
    800067b0:	00090513          	mv	a0,s2
    800067b4:	e6cfd0ef          	jal	ra,80003e20 <releasesleep>
    800067b8:	000b0513          	mv	a0,s6
    800067bc:	e9cfd0ef          	jal	ra,80003e58 <holdingsleep>
    800067c0:	e8051ae3          	bnez	a0,80006654 <fs_create+0x80>
    800067c4:	ed9ff06f          	j	8000669c <fs_create+0xc8>
    800067c8:	00048513          	mv	a0,s1
    800067cc:	a21fe0ef          	jal	ra,800051ec <ilock.part.0>
    800067d0:	e61ff06f          	j	80006630 <fs_create+0x5c>
    800067d4:	00000413          	li	s0,0
    800067d8:	e8dff06f          	j	80006664 <fs_create+0x90>
    800067dc:	00040513          	mv	a0,s0
    800067e0:	a0dfe0ef          	jal	ra,800051ec <ilock.part.0>
    800067e4:	f89ff06f          	j	8000676c <fs_create+0x198>
    800067e8:	00001517          	auipc	a0,0x1
    800067ec:	f7050513          	addi	a0,a0,-144 # 80007758 <state_names.0+0x3a8>
    800067f0:	cacfa0ef          	jal	ra,80000c9c <panic>
    800067f4:	fa5ff06f          	j	80006798 <fs_create+0x1c4>
    800067f8:	04a4d783          	lhu	a5,74(s1)
    800067fc:	00048513          	mv	a0,s1
    80006800:	0017879b          	addiw	a5,a5,1
    80006804:	04f49523          	sh	a5,74(s1)
    80006808:	d70fe0ef          	jal	ra,80004d78 <iupdate>
    8000680c:	02810793          	addi	a5,sp,40
    80006810:	00178793          	addi	a5,a5,1 # 4001 <_binary_user_test_basic_bin_size+0x38c0>
    80006814:	07010713          	addi	a4,sp,112
    80006818:	fe078fa3          	sb	zero,-1(a5)
    8000681c:	fee79ae3          	bne	a5,a4,80006810 <fs_create+0x23c>
    80006820:	0044a783          	lw	a5,4(s1)
    80006824:	00442703          	lw	a4,4(s0)
    80006828:	04800693          	li	a3,72
    8000682c:	04f12623          	sw	a5,76(sp)
    80006830:	02e00793          	li	a5,46
    80006834:	02f10623          	sb	a5,44(sp)
    80006838:	000037b7          	lui	a5,0x3
    8000683c:	e2e78793          	addi	a5,a5,-466 # 2e2e <_binary_user_test_basic_bin_size+0x26ed>
    80006840:	00000613          	li	a2,0
    80006844:	02810593          	addi	a1,sp,40
    80006848:	00040513          	mv	a0,s0
    8000684c:	04f11823          	sh	a5,80(sp)
    80006850:	02e12423          	sw	a4,40(sp)
    80006854:	bfdfe0ef          	jal	ra,80005450 <writei.part.0>
    80006858:	04800793          	li	a5,72
    8000685c:	f2f504e3          	beq	a0,a5,80006784 <fs_create+0x1b0>
    80006860:	00001517          	auipc	a0,0x1
    80006864:	ee050513          	addi	a0,a0,-288 # 80007740 <state_names.0+0x390>
    80006868:	c34fa0ef          	jal	ra,80000c9c <panic>
    8000686c:	f19ff06f          	j	80006784 <fs_create+0x1b0>
    80006870:	00001517          	auipc	a0,0x1
    80006874:	eb850513          	addi	a0,a0,-328 # 80007728 <state_names.0+0x378>
    80006878:	c24fa0ef          	jal	ra,80000c9c <panic>
    8000687c:	00001517          	auipc	a0,0x1
    80006880:	df450513          	addi	a0,a0,-524 # 80007670 <state_names.0+0x2c0>
    80006884:	c18fa0ef          	jal	ra,80000c9c <panic>
    80006888:	01000513          	li	a0,16
    8000688c:	d3cfd0ef          	jal	ra,80003dc8 <acquiresleep>
    80006890:	04002783          	lw	a5,64(zero) # 40 <_binary_user_test_basic_bin_size-0x701>
    80006894:	00100073          	ebreak

0000000080006898 <fs_unlink>:
    80006898:	fc010113          	addi	sp,sp,-64
    8000689c:	00010613          	mv	a2,sp
    800068a0:	00100593          	li	a1,1
    800068a4:	02113c23          	sd	ra,56(sp)
    800068a8:	02813823          	sd	s0,48(sp)
    800068ac:	02913423          	sd	s1,40(sp)
    800068b0:	03213023          	sd	s2,32(sp)
    800068b4:	d78ff0ef          	jal	ra,80005e2c <namex>
    800068b8:	08050063          	beqz	a0,80006938 <fs_unlink+0xa0>
    800068bc:	01050913          	addi	s2,a0,16
    800068c0:	00050413          	mv	s0,a0
    800068c4:	00090513          	mv	a0,s2
    800068c8:	d00fd0ef          	jal	ra,80003dc8 <acquiresleep>
    800068cc:	04042783          	lw	a5,64(s0)
    800068d0:	04078e63          	beqz	a5,8000692c <fs_unlink+0x94>
    800068d4:	00010593          	mv	a1,sp
    800068d8:	00040513          	mv	a0,s0
    800068dc:	a75ff0ef          	jal	ra,80006350 <dir_unlink>
    800068e0:	00050493          	mv	s1,a0
    800068e4:	00090513          	mv	a0,s2
    800068e8:	d70fd0ef          	jal	ra,80003e58 <holdingsleep>
    800068ec:	02050863          	beqz	a0,8000691c <fs_unlink+0x84>
    800068f0:	00090513          	mv	a0,s2
    800068f4:	d2cfd0ef          	jal	ra,80003e20 <releasesleep>
    800068f8:	00040513          	mv	a0,s0
    800068fc:	f71fe0ef          	jal	ra,8000586c <iput>
    80006900:	03813083          	ld	ra,56(sp)
    80006904:	03013403          	ld	s0,48(sp)
    80006908:	02013903          	ld	s2,32(sp)
    8000690c:	00048513          	mv	a0,s1
    80006910:	02813483          	ld	s1,40(sp)
    80006914:	04010113          	addi	sp,sp,64
    80006918:	00008067          	ret
    8000691c:	00001517          	auipc	a0,0x1
    80006920:	d4c50513          	addi	a0,a0,-692 # 80007668 <state_names.0+0x2b8>
    80006924:	b78fa0ef          	jal	ra,80000c9c <panic>
    80006928:	fc9ff06f          	j	800068f0 <fs_unlink+0x58>
    8000692c:	00040513          	mv	a0,s0
    80006930:	8bdfe0ef          	jal	ra,800051ec <ilock.part.0>
    80006934:	fa1ff06f          	j	800068d4 <fs_unlink+0x3c>
    80006938:	fff00493          	li	s1,-1
    8000693c:	fc5ff06f          	j	80006900 <fs_unlink+0x68>

0000000080006940 <ramdisk_read>:
    80006940:	fe010113          	addi	sp,sp,-32
    80006944:	00813823          	sd	s0,16(sp)
    80006948:	00913423          	sd	s1,8(sp)
    8000694c:	00113c23          	sd	ra,24(sp)
    80006950:	7ff00793          	li	a5,2047
    80006954:	00058413          	mv	s0,a1
    80006958:	00060493          	mv	s1,a2
    8000695c:	08b7e263          	bltu	a5,a1,800069e0 <ramdisk_read+0xa0>
    80006960:	02041793          	slli	a5,s0,0x20
    80006964:	0147d793          	srli	a5,a5,0x14
    80006968:	0002e717          	auipc	a4,0x2e
    8000696c:	08070713          	addi	a4,a4,128 # 800349e8 <ramdisk>
    80006970:	00e787b3          	add	a5,a5,a4
    80006974:	0297fe63          	bgeu	a5,s1,800069b0 <ramdisk_read+0x70>
    80006978:	000016b7          	lui	a3,0x1
    8000697c:	00d78733          	add	a4,a5,a3
    80006980:	02e4f863          	bgeu	s1,a4,800069b0 <ramdisk_read+0x70>
    80006984:	00d484b3          	add	s1,s1,a3
    80006988:	fff74683          	lbu	a3,-1(a4)
    8000698c:	fff70713          	addi	a4,a4,-1
    80006990:	fff48493          	addi	s1,s1,-1
    80006994:	00d48023          	sb	a3,0(s1)
    80006998:	fee798e3          	bne	a5,a4,80006988 <ramdisk_read+0x48>
    8000699c:	01813083          	ld	ra,24(sp)
    800069a0:	01013403          	ld	s0,16(sp)
    800069a4:	00813483          	ld	s1,8(sp)
    800069a8:	02010113          	addi	sp,sp,32
    800069ac:	00008067          	ret
    800069b0:	000016b7          	lui	a3,0x1
    800069b4:	00d786b3          	add	a3,a5,a3
    800069b8:	0007c703          	lbu	a4,0(a5)
    800069bc:	00178793          	addi	a5,a5,1
    800069c0:	00148493          	addi	s1,s1,1
    800069c4:	fee48fa3          	sb	a4,-1(s1)
    800069c8:	fed798e3          	bne	a5,a3,800069b8 <ramdisk_read+0x78>
    800069cc:	01813083          	ld	ra,24(sp)
    800069d0:	01013403          	ld	s0,16(sp)
    800069d4:	00813483          	ld	s1,8(sp)
    800069d8:	02010113          	addi	sp,sp,32
    800069dc:	00008067          	ret
    800069e0:	00001517          	auipc	a0,0x1
    800069e4:	d9050513          	addi	a0,a0,-624 # 80007770 <state_names.0+0x3c0>
    800069e8:	ab4fa0ef          	jal	ra,80000c9c <panic>
    800069ec:	f75ff06f          	j	80006960 <ramdisk_read+0x20>

00000000800069f0 <ramdisk_write>:
    800069f0:	fe010113          	addi	sp,sp,-32
    800069f4:	00813823          	sd	s0,16(sp)
    800069f8:	00913423          	sd	s1,8(sp)
    800069fc:	00113c23          	sd	ra,24(sp)
    80006a00:	7ff00793          	li	a5,2047
    80006a04:	00058413          	mv	s0,a1
    80006a08:	00060493          	mv	s1,a2
    80006a0c:	08b7e263          	bltu	a5,a1,80006a90 <ramdisk_write+0xa0>
    80006a10:	02041793          	slli	a5,s0,0x20
    80006a14:	0147d793          	srli	a5,a5,0x14
    80006a18:	0002e717          	auipc	a4,0x2e
    80006a1c:	fd070713          	addi	a4,a4,-48 # 800349e8 <ramdisk>
    80006a20:	00e787b3          	add	a5,a5,a4
    80006a24:	02f4fe63          	bgeu	s1,a5,80006a60 <ramdisk_write+0x70>
    80006a28:	000016b7          	lui	a3,0x1
    80006a2c:	00d48733          	add	a4,s1,a3
    80006a30:	02e7f863          	bgeu	a5,a4,80006a60 <ramdisk_write+0x70>
    80006a34:	00d787b3          	add	a5,a5,a3
    80006a38:	fff74683          	lbu	a3,-1(a4)
    80006a3c:	fff70713          	addi	a4,a4,-1
    80006a40:	fff78793          	addi	a5,a5,-1
    80006a44:	00d78023          	sb	a3,0(a5)
    80006a48:	fee498e3          	bne	s1,a4,80006a38 <ramdisk_write+0x48>
    80006a4c:	01813083          	ld	ra,24(sp)
    80006a50:	01013403          	ld	s0,16(sp)
    80006a54:	00813483          	ld	s1,8(sp)
    80006a58:	02010113          	addi	sp,sp,32
    80006a5c:	00008067          	ret
    80006a60:	000016b7          	lui	a3,0x1
    80006a64:	00d486b3          	add	a3,s1,a3
    80006a68:	0004c703          	lbu	a4,0(s1)
    80006a6c:	00148493          	addi	s1,s1,1
    80006a70:	00178793          	addi	a5,a5,1
    80006a74:	fee78fa3          	sb	a4,-1(a5)
    80006a78:	fed498e3          	bne	s1,a3,80006a68 <ramdisk_write+0x78>
    80006a7c:	01813083          	ld	ra,24(sp)
    80006a80:	01013403          	ld	s0,16(sp)
    80006a84:	00813483          	ld	s1,8(sp)
    80006a88:	02010113          	addi	sp,sp,32
    80006a8c:	00008067          	ret
    80006a90:	00001517          	auipc	a0,0x1
    80006a94:	cf050513          	addi	a0,a0,-784 # 80007780 <state_names.0+0x3d0>
    80006a98:	a04fa0ef          	jal	ra,80000c9c <panic>
    80006a9c:	f75ff06f          	j	80006a10 <ramdisk_write+0x20>

0000000080006aa0 <ramdisk_init>:
    80006aa0:	f8010113          	addi	sp,sp,-128
    80006aa4:	0002e797          	auipc	a5,0x2e
    80006aa8:	f4478793          	addi	a5,a5,-188 # 800349e8 <ramdisk>
    80006aac:	0082e717          	auipc	a4,0x82e
    80006ab0:	f3c70713          	addi	a4,a4,-196 # 808349e8 <panicked>
    80006ab4:	00178793          	addi	a5,a5,1
    80006ab8:	fe078fa3          	sb	zero,-1(a5)
    80006abc:	fee79ce3          	bne	a5,a4,80006ab4 <ramdisk_init+0x14>
    80006ac0:	00001797          	auipc	a5,0x1
    80006ac4:	cd078793          	addi	a5,a5,-816 # 80007790 <state_names.0+0x3e0>
    80006ac8:	0107b683          	ld	a3,16(a5)
    80006acc:	0187b703          	ld	a4,24(a5)
    80006ad0:	0007b583          	ld	a1,0(a5)
    80006ad4:	0087b603          	ld	a2,8(a5)
    80006ad8:	0207b783          	ld	a5,32(a5)
    80006adc:	00d13823          	sd	a3,16(sp)
    80006ae0:	00e13c23          	sd	a4,24(sp)
    80006ae4:	02f13023          	sd	a5,32(sp)
    80006ae8:	00b13023          	sd	a1,0(sp)
    80006aec:	00c13423          	sd	a2,8(sp)
    80006af0:	00010793          	mv	a5,sp
    80006af4:	0002f697          	auipc	a3,0x2f
    80006af8:	ef468693          	addi	a3,a3,-268 # 800359e8 <ramdisk+0x1000>
    80006afc:	02810713          	addi	a4,sp,40
    80006b00:	12d7f463          	bgeu	a5,a3,80006c28 <ramdisk_init+0x188>
    80006b04:	12e6f263          	bgeu	a3,a4,80006c28 <ramdisk_init+0x188>
    80006b08:	0002f617          	auipc	a2,0x2f
    80006b0c:	f0860613          	addi	a2,a2,-248 # 80035a10 <ramdisk+0x1028>
    80006b10:	00070693          	mv	a3,a4
    80006b14:	fff6c583          	lbu	a1,-1(a3)
    80006b18:	fff68693          	addi	a3,a3,-1
    80006b1c:	fff60613          	addi	a2,a2,-1
    80006b20:	00b60023          	sb	a1,0(a2)
    80006b24:	fef698e3          	bne	a3,a5,80006b14 <ramdisk_init+0x74>
    80006b28:	00070793          	mv	a5,a4
    80006b2c:	07c10693          	addi	a3,sp,124
    80006b30:	00178793          	addi	a5,a5,1
    80006b34:	fe078fa3          	sb	zero,-1(a5)
    80006b38:	fed79ce3          	bne	a5,a3,80006b30 <ramdisk_init+0x90>
    80006b3c:	000046b7          	lui	a3,0x4
    80006b40:	02d11423          	sh	a3,40(sp)
    80006b44:	00200693          	li	a3,2
    80006b48:	02d11723          	sh	a3,46(sp)
    80006b4c:	04800693          	li	a3,72
    80006b50:	02d12823          	sw	a3,48(sp)
    80006b54:	00100693          	li	a3,1
    80006b58:	02d12a23          	sw	a3,52(sp)
    80006b5c:	03800693          	li	a3,56
    80006b60:	04d12223          	sw	a3,68(sp)
    80006b64:	00050697          	auipc	a3,0x50
    80006b68:	ed868693          	addi	a3,a3,-296 # 80056a3c <ramdisk+0x22054>
    80006b6c:	00d77463          	bgeu	a4,a3,80006b74 <ramdisk_init+0xd4>
    80006b70:	0ef6e263          	bltu	a3,a5,80006c54 <ramdisk_init+0x1b4>
    80006b74:	00070793          	mv	a5,a4
    80006b78:	00000613          	li	a2,0
    80006b7c:	00050717          	auipc	a4,0x50
    80006b80:	f1470713          	addi	a4,a4,-236 # 80056a90 <ramdisk+0x220a8>
    80006b84:	0080006f          	j	80006b8c <ramdisk_init+0xec>
    80006b88:	0007c603          	lbu	a2,0(a5)
    80006b8c:	00168693          	addi	a3,a3,1
    80006b90:	fec68fa3          	sb	a2,-1(a3)
    80006b94:	00178793          	addi	a5,a5,1
    80006b98:	fee698e3          	bne	a3,a4,80006b88 <ramdisk_init+0xe8>
    80006b9c:	00100793          	li	a5,1
    80006ba0:	00066697          	auipc	a3,0x66
    80006ba4:	e4868693          	addi	a3,a3,-440 # 8006c9e8 <ramdisk+0x38000>
    80006ba8:	00f6a023          	sw	a5,0(a3)
    80006bac:	02f6a223          	sw	a5,36(a3)
    80006bb0:	00066717          	auipc	a4,0x66
    80006bb4:	e5c70713          	addi	a4,a4,-420 # 8006ca0c <ramdisk+0x38024>
    80006bb8:	00066797          	auipc	a5,0x66
    80006bbc:	e3478793          	addi	a5,a5,-460 # 8006c9ec <ramdisk+0x38004>
    80006bc0:	00178793          	addi	a5,a5,1
    80006bc4:	fe078fa3          	sb	zero,-1(a5)
    80006bc8:	fee79ce3          	bne	a5,a4,80006bc0 <ramdisk_init+0x120>
    80006bcc:	00066797          	auipc	a5,0x66
    80006bd0:	e4478793          	addi	a5,a5,-444 # 8006ca10 <ramdisk+0x38028>
    80006bd4:	00066717          	auipc	a4,0x66
    80006bd8:	e5c70713          	addi	a4,a4,-420 # 8006ca30 <ramdisk+0x38048>
    80006bdc:	00178793          	addi	a5,a5,1
    80006be0:	fe078fa3          	sb	zero,-1(a5)
    80006be4:	fee79ce3          	bne	a5,a4,80006bdc <ramdisk_init+0x13c>
    80006be8:	00065617          	auipc	a2,0x65
    80006bec:	e0060613          	addi	a2,a2,-512 # 8006b9e8 <ramdisk+0x37000>
    80006bf0:	00064783          	lbu	a5,0(a2)
    80006bf4:	02e00713          	li	a4,46
    80006bf8:	00e68223          	sb	a4,4(a3)
    80006bfc:	00003737          	lui	a4,0x3
    80006c00:	0017e793          	ori	a5,a5,1
    80006c04:	e2e70713          	addi	a4,a4,-466 # 2e2e <_binary_user_test_basic_bin_size+0x26ed>
    80006c08:	02e69423          	sh	a4,40(a3)
    80006c0c:	00f60023          	sb	a5,0(a2)
    80006c10:	00000597          	auipc	a1,0x0
    80006c14:	de058593          	addi	a1,a1,-544 # 800069f0 <ramdisk_write>
    80006c18:	00000517          	auipc	a0,0x0
    80006c1c:	d2850513          	addi	a0,a0,-728 # 80006940 <ramdisk_read>
    80006c20:	08010113          	addi	sp,sp,128
    80006c24:	b8cfd06f          	j	80003fb0 <bio_register_backend>
    80006c28:	0007c603          	lbu	a2,0(a5)
    80006c2c:	00178793          	addi	a5,a5,1
    80006c30:	00168693          	addi	a3,a3,1
    80006c34:	fec68fa3          	sb	a2,-1(a3)
    80006c38:	eee788e3          	beq	a5,a4,80006b28 <ramdisk_init+0x88>
    80006c3c:	0007c603          	lbu	a2,0(a5)
    80006c40:	00178793          	addi	a5,a5,1
    80006c44:	00168693          	addi	a3,a3,1
    80006c48:	fec68fa3          	sb	a2,-1(a3)
    80006c4c:	fce79ee3          	bne	a5,a4,80006c28 <ramdisk_init+0x188>
    80006c50:	ed9ff06f          	j	80006b28 <ramdisk_init+0x88>
    80006c54:	00050697          	auipc	a3,0x50
    80006c58:	e3c68693          	addi	a3,a3,-452 # 80056a90 <ramdisk+0x220a8>
    80006c5c:	fff7c603          	lbu	a2,-1(a5)
    80006c60:	fff78793          	addi	a5,a5,-1
    80006c64:	fff68693          	addi	a3,a3,-1
    80006c68:	00c68023          	sb	a2,0(a3)
    80006c6c:	fee798e3          	bne	a5,a4,80006c5c <ramdisk_init+0x1bc>
    80006c70:	f2dff06f          	j	80006b9c <ramdisk_init+0xfc>
