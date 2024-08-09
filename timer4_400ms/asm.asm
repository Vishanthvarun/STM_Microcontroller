        
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
    bset PE_DDR, #5   ; Set pin 5 of port E to output mode (DDR)
    ldw y,#0;

blink_loop:
    bset    PE_ODR, #5        ; Turn on LED (set pin 5 of port B)
    call    tim4_delay        ; Call delay function
    bres    PE_ODR, #5        ; Turn off LED (clear pin 5 of port B)
    call    tim4_delay        ; Call delay function
    jra     blink_loop        ; Infinite loop
		
tim4_delay:
    bset CLK_PCKENR1,#4   ;CLK_PCKENR1 ON enable fmaster of timer4
    mov TIM4_CR1,#0x80    ;TIM4_CR1 ARPE set,(OPM,URS,UDIS,CEN)cleared
    mov TIM4_IER,#0x00    ;TIM4_IER update interrupt disabled
    mov TIM4_PSCR,#0x04   ;TIM4_PSCR prescalar register
    mov TIM4_ARR,#125    ;TIM4_ARR Auto reload Enabled
    mov TIM4_CNTR,#0x00   ;counter cleared
    bset TIM4_EGR,#0      ;set UG bit 1
    nop
    nop
    clr TIM4_SR       ;TIM4_SR flag cleared
    nop
    nop
    ;break
    bset TIM4_CR1,#0      ;counter enabled

waitfor_flag:
    btjf TIM4_SR,#0,waitfor_flag
   ; break
    bres TIM4_CR1,#0      ;counter disabled
    nop
    nop
    clr TIM4_SR     ;TIM4_SR flag cleared
    nop
    nop
   ; break;
    bset TIM4_CR1,#0      ;counter enabled
   ; break
    incw y;
   ; break
    cpw y,#400
    jrne waitfor_flag
    ldw y,#0;
    ;break
    ret
;---------------------------------------------USER CODE END-------------------------------------------------
