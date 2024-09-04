        
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
    ldw x ,#0x7ff       ;load stack with start address
    ldw sp,x		;move x value to stackpointer  
    MOV OPT0,#0x00      ;ROP (Read-out protection) option byte
    MOV OPT1,#0x00      ;UBC (user boot code) option byte
    MOV NOPT1,#0xFF     ;NUBC option byte
    MOV OPT2,#0x00      ;AFR (Alternate function remapping) option byte
    MOV NOPT2,#0xFF     ;AFR (Alternate function remapping) option byte
    MOV OPT3,#0x00      ;Misc.option  
    MOV NOPT3,#0xFF     ;Misc.option
    MOV OPT4,#0x00      ;clock option 
    MOV NOPT4,#0xFF     ;clock option

_main:
    bset PE_DDR,#5	;Set pin 5 of port E to output mode
    ldw y,#0	;

blink_loop:
    bset PE_ODR,#5      ;Turn on LED(set pin 5 of port B)
    call tim4_delay  	;call delay function
    bres PE_ODR,#5	;turn off LED
    call tim4_delay	;call delay
    jra blink_loop	;jump to blink loop

tim4_delay:
    bset CLK_PCKENR1,#4 ;on fmaster to timer4
    mov TIM4_CR1,#0x80  ;set ARPE bit on(arr register buffered throughthrough preloader register)
    mov TIM4_IER,#0x00  ;Interrupt disabled
    clr TIM4_SR	   	;cleared SR register
    mov TIM4_PSCR,#4    ;prescaler value
    mov TIM4_ARR,#125   ;arr value
    bset TIM4_EGR,#0    ;set UG bit 1
    bset TIM4_CR1,#0    ;counter enabled

waitfor_flag:
    btjf TIM4_SR,#0,waitfor_flag
    bres TIM4_CR1,#0	;counter disabled
    clr TIM4_SR		;TIM4_SR flag cleared
    bset TIM4_CR1,#0	;counter enabled
    incw y;
    cpw y,#400
    jrne waitfor_flag   ;jump to waitfor_flag
    ldw y,#0
    ret

;---------------------------------------------USER CODE END-------------------------------------------------
