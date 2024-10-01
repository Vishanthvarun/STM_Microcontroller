#include "arm8.h"
extern void uart2_config(void);
extern void clock_config(void);
extern void uart2_tx(unsigned char);
extern unsigned char uart2_rx(void);

extern void delay(void);
int main(void)
{
    clock_config();
    uart2_config();
    uart2_tx('A');
    uart2_tx('B');
    while(1)
    {

    }
}
void clock_config(void)
{   
    //default internal clock (16 MHZ)
    CLK->CKDIVR=0x00;		//CLKDIVR SET to 00 
    CLK->PCKENR1=0x00;		
    CLK->PCKENR1=0x08;		//URAT2 clock enable

}
void uart2_config(void)
{
    UT2->CR1=0x00;		//UART enabled
    UT2->CR3&=~(3<<4);		//stop bit set to 1
    UT2->BRR1=0x68;		//baud rate set to 9600
    UT2->BRR2=0x03;		//baud rate set to 9600
    UT2->CR2=0x08;		//on transmit enabled

}
void uart2_tx(unsigned char a)
{
    UT2->SR&=~(1<<6);			//set status register tc bit 0 
    UT2->DR=a;				//write data to Data register
    while(!((UT2->SR & (1<<6))));	//check status register if true exit from loop

}
