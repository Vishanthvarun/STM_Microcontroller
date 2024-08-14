        ;PORT E
        .equ PE_ODR, 0x5014    	;Port E data output latch register
        .equ PE_IDR, 0x5015 	;Port E input pin value register
        .equ PE_DDR, 0x5016	;Port E data direction register
        .equ PE_CR1, 0x5017	;Port E control register 1
        .equ PE_CR2, 0x5018	;Port E control register 2

	;OPTION BYTE
	.equ OPT0,   0x4800	;Read-out protection (ROP)
	.equ OPT1,   0x4801	;User boot code (UBC)
	.equ NOPT1,  0x4802     ;User boot code (UBC)
	.equ OPT2,   0x4803	;Alternate function remapping (AFR)
	.equ NOPT2,  0x4804	;Alternate function remapping (AFR)
	.equ OPT3,   0x4805	;MISC option
	.equ NOPT3,  0x4806	;MISC option
	.equ OPT4,   0x4807 	;Clock option
	.equ NOPT4,  0x4808     ;Clock option
	.equ OPT5,   0x4809     ;HSE clock startup
	.equ NOPT5,  0x480A     ;HSE clock startup
	.equ OPT6,   0x480B	;Reserved
	.equ NOPT6,  0x480C	;Reserved
	.equ OPT7,   0x480D	;Reserved
	.equ NOPT7,  0x480E	;Reserved

        .module minimal_blink
	.optsdcc -mstm8
	.area SSEG

__start__stark:
	.ds    1
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
    ldw x,#0x7ff	;load stack with start address
    ldw sp,x		;move x value to stackpointer 
    MOV OPT0,#0x00	;ROP 
    MOV OPT1,#0x00      ;UBC (user boot code) option byte
    MOV NOPT1,#0xFF     ;NUBC option byte
    MOV OPT2,#0x00      ;AFR (Alternate function remapping) optionbyte
    MOV NOPT2,#0xFF     ;AFR (Alternate function remapping) optionbyte
    MOV OPT3,#0x00      ;Misc.option  
    MOV NOPT3,#0xFF     ;Misc.option
    MOV OPT4,#0x00      ;clock option 
    MOV NOPT4,#0xFF     ;clock option

_main:
   bset PE_DDR, #5	;set pin 5 of port E to output mode (DDR)
   ldw y,#0;
   
blink_loop:
   bset PE_ODR,#5	;Turn on LED (set pin 5 of port B)
   call delay_loop	;call delay function
   bres PE_ODR,#5	;Turn off LED (clear pin 5 of port B)
   call delay_loop	;call delay function 
   jra blink_loop	;jump to blink function

delay_loop:
   incw y		;increment y
   cpw y,#65535		;y register compared to  value
   jrne delay_loop	;if not equal jump to delay_loop
   ldw y ,#0		;load y register 0
   ret

;---------------------------------------------USER CODE END------------------------------------------------------
