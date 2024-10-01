///// clock block ///////
struct rcc
{
  /* Register name      Address offset*/
    char ICKR; 		//0x00
    char ECKR; 		//0x01
    char rsd0;  	//0x02
    char CMSR; 		//0x03
    char SWR;  		//0x04
    char SWCR; 		//0x05
    char CKDIVR;	//0x06
    char PCKENR1;	//0x07
    char CSSR;   	//0x08
    char CCOR;   	//0x09
    char PCKENR2;   	//0x0A
    char rsd1;   	//0x0B
    char HSITRIMR;   	//0x0C
    char SWIMCCR;   	//0x0D
};
volatile struct rcc *CLK=(volatile struct rcc*)0x0050C0;

struct port
{
  /* Register name      Address offset*/
    char ODR;		//0x00
    char IDR;		//0x01
    char DDR;		//0x02
    char CR1;		//0x03
    char CR2;		//0x04
};
volatile struct port *PD=(volatile struct port*)0x00500F;

struct uart
{
  /* Register name      Address offset*/
    char SR;		//0x00
    char DR;		//0x01
    char BRR1;		//0x02
    char BRR2;		//0x03
    char CR1;		//0x04
    char CR2;		//0x05
    char CR3;		//0x06
    char CR4;		//0x07
    char CR5;		//0x08
    char CR6;		//0X09
    char GTR;		//0X0A
    char PSCR;		//0X0B
};
volatile struct uart *UT2=(volatile struct uart*)0x005240;
