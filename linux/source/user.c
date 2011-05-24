#define RESET 	8
#define CS 		10
#define CLK		13
#define SDI		12
#define SDO		11

#define EADR0 0x05
#define EADR1 0x06



void init_zigbee()
{
	digitalwrite(RESET,0);
	digitalwrite(CS,1);
	digitalwrite(CLK,0);
	digitalwrite(SDO,0);
	digitalwrite(RESET,1);
	Delayms(100);
}

void short_write(byte address,byte value)
{
	address=((address<<1)&0x7F)|1;
	digitalwrite(CS,0);
	WriteSPI(address);
	WriteSPI(value);
	digitalwrite(CS,1);
}

unsigned int short_read(unsigned char address)
{
byte response;
	address=(address<<1)&0x7E;
	digitalwrite(CS,0);
	WriteSPI(address);
	response=ReadSPI();
	digitalwrite(CS,1);
	return(response);
}

void setup()
{
	pinmode(CS,OUTPUT); digitalwrite(CS,HIGH);
	pinmode(SDI,INPUT);
	pinmode(SDO,OUTPUT);
	pinmode(CLK,OUTPUT);
	pinmode(RESET,OUTPUT);	
	
	init_zigbee();
	
	serial1init(9600);
	serial1printf("BONJOUR\n\r");

	InitSPI0();

}


void loop()
{
 byte i;
 unsigned int reponse;
	
	short_write(EADR0,0x23);
	for (i=0;i<20;i++)
		{
		reponse=short_read(i);
		serial1printf("%02X ",reponse);
		}
	serial1printf("\n\r");
}

