
#define CS 10		
#define SDI 12		
#define SDO 11		
#define CLKpin 13		
#define RESET 8

#define wd 1	// delay for MRF24J40 clk

#define EADR0 0x05

void setup()
{
	pinMode(CS,OUTPUT);
	pinMode(SDI,INPUT);
	pinMode(SDO,OUTPUT);
	pinMode(CLKpin,OUTPUT);
	pinMode(RESET,OUTPUT);
	Serial.begin(9600);
}

void init_zigbee()
{
	digitalWrite(RESET,0);
	digitalWrite(CS,1);
	digitalWrite(CLKpin,0);
	digitalWrite(SDO,0);
	digitalWrite(RESET,1);
	delay(100);
}

unsigned char short_read(unsigned char address)
{
	unsigned char i;
	unsigned char resultat=0;
	
	digitalWrite(CS,0);
	address=(address<<1)&0x7E;
	for (i=0;i<8;i++)
		{
		if ((address&0x80)==0x80) digitalWrite(SDO,1);
		else digitalWrite(SDO,0);
		digitalWrite(CLKpin,1);
		delayMicroseconds(wd);
		digitalWrite(CLKpin,0);
		delayMicroseconds(wd);
		address=address<<1;
		}
	for (i=0;i<8;i++)
		{
		digitalWrite(CLKpin,1);
		delayMicroseconds(wd);
		if (digitalRead(SDI)) resultat=resultat|1;
		if (i!=7) resultat=resultat<<1;
		digitalWrite(CLKpin,0);
		delayMicroseconds(wd);
		}
digitalWrite(CS,1);
return(resultat);
}

void short_write(unsigned char address,unsigned char value)
{
	unsigned char i;
	
	digitalWrite(CS,0);
	address=((address<<1)&0x7F)|1;
	for (i=0;i<8;i++)
		{
		if ((address&0x80)!=0) digitalWrite(SDO,1);
		else digitalWrite(SDO,0);
		digitalWrite(CLKpin,1);
		delayMicroseconds(wd);
		digitalWrite(CLKpin,0);
		address=address<<1;
		}
	for (i=0;i<8;i++)
			{
			if ((value&0x80)!=0) digitalWrite(SDO,1);
			else digitalWrite(SDO,0);
			digitalWrite(CLKpin,1);
			delayMicroseconds(wd);
			digitalWrite(CLKpin,0);
			value=value<<1;
			}			
digitalWrite(CS,1);
}

void loop()
{
 byte reponse,i;
	Serial.printf("SPI with MRF24J40MA\r\n");
	init_zigbee();
	short_write(EADR0,0x23); 
	while(1)
	{
	for (i=0;i<20;i++)
		{
		reponse=short_read(i);
		Serial.printf("%02X ",reponse);
		}
	Serial.printf("\n\r");
	}
}
