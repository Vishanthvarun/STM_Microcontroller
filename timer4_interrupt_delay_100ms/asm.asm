       
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


	.equ count_intr, 0x0000


        .module minimal_blink
	.optsdcc -mstm8
	.area SSEG
__start__stack:
	.ds	1
	
	.globl _main
        .area INTR
        .dw 0x00008200			;0x8000
        .word reset_vector		;0x8002
        .word 0x0000			;0x8004
        .word 0x0000			;0x8006
        .word 0x0000			;0x8008
        .word 0x0000			;0x800a
        .word 0x0000			;0x800c	
        .word 0x0000			;0x800e
        .word 0x0000			;0x8010
        .word 0x0000			;0x8012
        .word 0x0000			;0x8014
        .word 0x0000			;0x8016
        .word 0x0000			;0x8018
        .word 0x0000			;0x801a
        .word 0x0000			;0x801c
        .word 0x0000			;0x801e
        .word 0x0000			;0x8020
        .word 0x0000			;0x8022
        .word 0x0000			;0x8024
        .word 0x0000			;0x8026
        .word 0x0000			;0x8028
        .word 0x0000			;0x802a
        .word 0x0000			;0x802c
        .word 0x0000			;0x802e
        .word 0x0000			;0x8030
        .word 0x0000			;0x8032
        .word 0x0000			;0x8034
        .word 0x0000			;0x8036
        .word 0x0000			;0x8038
        .word 0x0000			;0x803a
        .word 0x0000			;0x803c
        .word 0x0000			;0x803e
        .word 0x0000			;0x8040
        .word 0x0000			;0x8042
        .word 0x0000			;0x8044
        .word 0x0000			;0x8046
        .word 0x0000			;0x8048
        .word 0x0000			;0x804a
        .word 0x0000			;0x804c
        .word 0x0000			;0x804e
        .word 0x0000			;0x8050
        .word 0x0000			;0x8052
        .word 0x0000			;0x8054
        .word 0x0000			;0x8056
        .word 0x0000			;0x8058
        .word 0x0000			;0x805a
        .word 0x0000			;0x805c
        .word 0x0000			;0x805e
        .word 0x0000			;0x8060
        .word 0x0000			;0x8062
        .word 0x8200			;0x8064
        .word timer4_interrupt_service_routine			;0x8066
        .word 0x0000			;0x8068
        .word 0x0000			;0x806a

	.area HOME
	.area CODE
reset_vector:
;--------------------------------------------USER CODE ----------------------------------------------------------
    ldw x ,#0x7ff       ;load stack with start address
    ldw sp,x		;move x value to stackpointer 
    mov  count_intr,#0   ;ram address use to count value 
    sim 		 
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
    bset PE_CR1, #5   ; Set pin 5 of port E
    bset PE_CR2, #5   ; Set pin 5 of port E 
    
    call tim4_config
    rim
loop:
    jra  loop        ; Infinite loop
		
tim4_config:
    bset CLK_PCKENR1,#4   ;CLK_PCKENR1 ON enable fmaster of timer4
    mov TIM4_CR1,#0x80    ;TIM4_CR1 ARPE set,(OPM,URS,UDIS,CEN)cleared
    mov TIM4_PSCR,#0x04   ;TIM4_PSCR prescalar register
    mov TIM4_ARR,#125    ;TIM4_ARR Auto reload Enabled
    mov TIM4_CNTR,#0x00   ;counter cleared
    bset TIM4_EGR,#0      ;set UG bit 1
    nop
    nop
    clr TIM4_SR       ;TIM4_SR flag cleared
    nop
    nop
    bset TIM4_IER,#0    ;TIM4_IER update interrupt enabled
    bset TIM4_CR1,#0      ;counter enabled
    ret


   
timer4_interrupt_service_routine:
    sim
    clr TIM4_SR      ;TIM4_SR flag cleared
    inc count_intr
    ld a,count_intr
    cp a,#100
    jrne condition_false
    bcpl PE_ODR,#5   ;complement bit 5 
condition_false:
    rim
    iret 
;---------------------------------------------USER CODE END-------------------------------------------------
