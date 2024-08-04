extern void delay(void);
int main(void)
{
	//0x 00 5014 PE_ODR
	//0x 00 5015 PE_IDR
	//0x 00 5016 PE_DDR
	//0x 00 5017 PE_CR1
	//0x 00 5018 PE_CR2
	*(unsigned int *)0x005016 = 0x20;//setting PE5 as output
	while(1)
	{
		*(unsigned int *)0x005014 =0x20;
		delay();
		*(unsigned int *)0x005014 =0x00;
		delay();
	}
	
//	return 0;
}
void delay(void)
{
	long int x;
	for(x=0;x<100000;x++)
	{

	}

}
