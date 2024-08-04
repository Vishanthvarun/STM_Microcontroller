                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler 
                                      3 ; Version 4.4.0 #14620 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module led_blink
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _delay
                                     13 ;--------------------------------------------------------
                                     14 ; ram data
                                     15 ;--------------------------------------------------------
                                     16 	.area DATA
                                     17 ;--------------------------------------------------------
                                     18 ; ram data
                                     19 ;--------------------------------------------------------
                                     20 	.area INITIALIZED
                                     21 ;--------------------------------------------------------
                                     22 ; Stack segment in internal ram
                                     23 ;--------------------------------------------------------
                                     24 	.area SSEG
      000001                         25 __start__stack:
      000001                         26 	.ds	1
                                     27 
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; interrupt vector
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
      008000                         45 __interrupt_vect:
      008000 82 00 80 07             46 	int s_GSINIT ; reset
                                     47 ;--------------------------------------------------------
                                     48 ; global & static initialisations
                                     49 ;--------------------------------------------------------
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area GSINIT
      008007 CD 80 61         [ 4]   54 	call	___sdcc_external_startup
      00800A 4D               [ 1]   55 	tnz	a
      00800B 27 03            [ 1]   56 	jreq	__sdcc_init_data
      00800D CC 80 04         [ 2]   57 	jp	__sdcc_program_startup
      008010                         58 __sdcc_init_data:
                                     59 ; stm8_genXINIT() start
      008010 AE 00 00         [ 2]   60 	ldw x, #l_DATA
      008013 27 07            [ 1]   61 	jreq	00002$
      008015                         62 00001$:
      008015 72 4F 00 00      [ 1]   63 	clr (s_DATA - 1, x)
      008019 5A               [ 2]   64 	decw x
      00801A 26 F9            [ 1]   65 	jrne	00001$
      00801C                         66 00002$:
      00801C AE 00 00         [ 2]   67 	ldw	x, #l_INITIALIZER
      00801F 27 09            [ 1]   68 	jreq	00004$
      008021                         69 00003$:
      008021 D6 80 2C         [ 1]   70 	ld	a, (s_INITIALIZER - 1, x)
      008024 D7 00 00         [ 1]   71 	ld	(s_INITIALIZED - 1, x), a
      008027 5A               [ 2]   72 	decw	x
      008028 26 F7            [ 1]   73 	jrne	00003$
      00802A                         74 00004$:
                                     75 ; stm8_genXINIT() end
                                     76 	.area GSFINAL
      00802A CC 80 04         [ 2]   77 	jp	__sdcc_program_startup
                                     78 ;--------------------------------------------------------
                                     79 ; Home
                                     80 ;--------------------------------------------------------
                                     81 	.area HOME
                                     82 	.area HOME
      008004                         83 __sdcc_program_startup:
      008004 CC 80 2D         [ 2]   84 	jp	_main
                                     85 ;	return from main will return to caller
                                     86 ;--------------------------------------------------------
                                     87 ; code
                                     88 ;--------------------------------------------------------
                                     89 	.area CODE
                           000000    90 	G$main$0$0 ==.
                           000000    91 	C$led_blink.c$2$0_0$3 ==.
                                     92 ;	led_blink.c: 2: int main(void)
                                     93 ;	-----------------------------------------
                                     94 ;	 function main
                                     95 ;	-----------------------------------------
      00802D                         96 _main:
                           000000    97 	C$led_blink.c$9$1_0$3 ==.
                                     98 ;	led_blink.c: 9: *(unsigned int *)0x005016 = 0x20;//setting PE5 as output
      00802D 35 20 50 17      [ 1]   99 	mov	0x5016+1, #0x20
      008031 35 00 50 16      [ 1]  100 	mov	0x5016+0, #0x00
                           000008   101 	C$led_blink.c$10$1_0$3 ==.
                                    102 ;	led_blink.c: 10: while(1)
      008035                        103 00102$:
                           000008   104 	C$led_blink.c$12$2_0$4 ==.
                                    105 ;	led_blink.c: 12: *(unsigned int *)0x005014 =0x20;
      008035 35 20 50 15      [ 1]  106 	mov	0x5014+1, #0x20
      008039 35 00 50 14      [ 1]  107 	mov	0x5014+0, #0x00
                           000010   108 	C$led_blink.c$13$2_0$4 ==.
                                    109 ;	led_blink.c: 13: delay();
      00803D CD 80 4C         [ 4]  110 	call	_delay
                           000013   111 	C$led_blink.c$14$2_0$4 ==.
                                    112 ;	led_blink.c: 14: *(unsigned int *)0x005014 =0x00;
      008040 AE 50 14         [ 2]  113 	ldw	x, #0x5014
      008043 6F 01            [ 1]  114 	clr	(0x1, x)
      008045 7F               [ 1]  115 	clr	(x)
                           000019   116 	C$led_blink.c$15$2_0$4 ==.
                                    117 ;	led_blink.c: 15: delay();
      008046 CD 80 4C         [ 4]  118 	call	_delay
      008049 20 EA            [ 2]  119 	jra	00102$
                           00001E   120 	C$led_blink.c$19$1_0$3 ==.
                                    121 ;	led_blink.c: 19: }
                           00001E   122 	C$led_blink.c$19$1_0$3 ==.
                           00001E   123 	XG$main$0$0 ==.
      00804B 81               [ 4]  124 	ret
                           00001F   125 	G$delay$0$0 ==.
                           00001F   126 	C$led_blink.c$20$1_0$7 ==.
                                    127 ;	led_blink.c: 20: void delay(void)
                                    128 ;	-----------------------------------------
                                    129 ;	 function delay
                                    130 ;	-----------------------------------------
      00804C                        131 _delay:
                           00001F   132 	C$led_blink.c$23$2_0$7 ==.
                                    133 ;	led_blink.c: 23: for(x=0;x<100000;x++)
      00804C 90 AE 86 A0      [ 2]  134 	ldw	y, #0x86a0
      008050 5F               [ 1]  135 	clrw	x
      008051 5C               [ 1]  136 	incw	x
      008052                        137 00104$:
      008052 72 A2 00 01      [ 2]  138 	subw	y, #0x0001
      008056 24 01            [ 1]  139 	jrnc	00116$
      008058 5A               [ 2]  140 	decw	x
      008059                        141 00116$:
      008059 90 5D            [ 2]  142 	tnzw	y
      00805B 26 F5            [ 1]  143 	jrne	00104$
      00805D 5D               [ 2]  144 	tnzw	x
      00805E 26 F2            [ 1]  145 	jrne	00104$
                           000033   146 	C$led_blink.c$28$2_0$7 ==.
                                    147 ;	led_blink.c: 28: }
                           000033   148 	C$led_blink.c$28$2_0$7 ==.
                           000033   149 	XG$delay$0$0 ==.
      008060 81               [ 4]  150 	ret
                                    151 	.area CODE
                                    152 	.area CONST
                                    153 	.area INITIALIZER
                                    154 	.area CABS (ABS)
