        
        ;PORT E
        .equ PE_ODR,	0x005014
	.equ PE_IDR,	0x005015
	.equ PE_DDR,	0x005016
	.equ PE_CR1,	0x005017
	.equ PE_CR2,	0x005018

	;OPTION BYTE
	.equ OPT0,	0x4800
	.equ OPT1,	0x4801 
	.equ NOPT1,	0x4802  
	.equ OPT2,	0x4803     
	.equ NOPT2,	0x4804     
	.equ OPT3, 	0x4805     
	.equ NOPT3,	0x4806     
	.equ OPT4,	0x4807     
	.equ NOPT4,	0x4808     
	.equ OPT5,	0x4809     
	.equ NOPT5,	0x480A     
	.equ OPT6,	0x480B 
	.equ NOPT6,	0x480C    
	.equ OPT7,	0x480D    
	.equ NOPT7,	0x480E     

	;CLOCK
	.equ CLK_ECKR,	 0x50C1
	.equ CLK_CKDIVR, 0x50C6
	.equ CLK_SWR,    0x50C4
	.equ CLK_PCKENR1,0x50C7

	;TIMER
	.equ TIM4_CR1,	0x5340
	.equ TIM4_IER,	0x5341
	.equ TIM4_SR,   0x5342
	.equ TIM4_EGR,  0x5343
	.equ TIM4_CNTR, 0x5344
	.equ TIM4_PSCR,	0x5345
	.equ TIM4_ARR,	0x5346


        .module minimal_blink
	.optsdcc -mstm8
	.area SSEG
__start__stack:
	.ds	1
	
	.globl _main
        .area INTR
        .word 0x8200
        .word 0x8080
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000
        .word 0x0000

	.area HOME
	.area CODE
;--------------------------------------------USER CODE ----------------------------------------------------------
_main:

    ldw x ,#0x7ff       	;load stack with start address
    ldw sp,x     		;move x value to stackpointer  
test_fun1:
    push #0x11
    break
    push #0x15
    break
    push #0x18
    break
    push #0x19
    break
    call test_fun2
    break
    pop a
    break
    pop a
    break
    pop a
    break
    pop a
    break
loop: jp loop
test_fun2:
    break
    ret
    
;--------------------------------------------USER CODE END-------------------------------------------------
