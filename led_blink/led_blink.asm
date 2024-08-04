;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (Linux)
;--------------------------------------------------------
	.module led_blink
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _delay
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	call	___sdcc_external_startup
	tnz	a
	jreq	__sdcc_init_data
	jp	__sdcc_program_startup
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
	G$main$0$0 ==.
	C$led_blink.c$2$0_0$3 ==.
;	led_blink.c: 2: int main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	C$led_blink.c$9$1_0$3 ==.
;	led_blink.c: 9: *(unsigned int *)0x005016 = 0x20;//setting PE5 as output
	mov	0x5016+1, #0x20
	mov	0x5016+0, #0x00
	C$led_blink.c$10$1_0$3 ==.
;	led_blink.c: 10: while(1)
00102$:
	C$led_blink.c$12$2_0$4 ==.
;	led_blink.c: 12: *(unsigned int *)0x005014 =0x20;
	mov	0x5014+1, #0x20
	mov	0x5014+0, #0x00
	C$led_blink.c$13$2_0$4 ==.
;	led_blink.c: 13: delay();
	call	_delay
	C$led_blink.c$14$2_0$4 ==.
;	led_blink.c: 14: *(unsigned int *)0x005014 =0x00;
	ldw	x, #0x5014
	clr	(0x1, x)
	clr	(x)
	C$led_blink.c$15$2_0$4 ==.
;	led_blink.c: 15: delay();
	call	_delay
	jra	00102$
	C$led_blink.c$19$1_0$3 ==.
;	led_blink.c: 19: }
	C$led_blink.c$19$1_0$3 ==.
	XG$main$0$0 ==.
	ret
	G$delay$0$0 ==.
	C$led_blink.c$20$1_0$7 ==.
;	led_blink.c: 20: void delay(void)
;	-----------------------------------------
;	 function delay
;	-----------------------------------------
_delay:
	C$led_blink.c$23$2_0$7 ==.
;	led_blink.c: 23: for(x=0;x<100000;x++)
	ldw	y, #0x86a0
	clrw	x
	incw	x
00104$:
	subw	y, #0x0001
	jrnc	00116$
	decw	x
00116$:
	tnzw	y
	jrne	00104$
	tnzw	x
	jrne	00104$
	C$led_blink.c$28$2_0$7 ==.
;	led_blink.c: 28: }
	C$led_blink.c$28$2_0$7 ==.
	XG$delay$0$0 ==.
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
