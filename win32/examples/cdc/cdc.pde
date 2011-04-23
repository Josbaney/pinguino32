// USB CDC
// adapted Alexander Enzmann code to Pinguino and SDCC 2.9.0
// Jean-Pierre Mandon 2010 

void setup()
{
Serial.begin(9600);
Serial.print("Hello");
}


unsigned char i=0;
long j=0;
unsigned char receivedbyte;
unsigned char rxstr[64];
unsigned char txstr[7]={'M','e','s','s','a','g','e'};
unsigned char serstr[2]={0,0};

void loop()
{
// receive a string from the USB uart and send it on the uart
receivedbyte=CDC.read(rxstr);
rxstr[receivedbyte]=0; // to make received character(s) a string
if (receivedbyte>0)
	for (i=0;i<receivedbyte;i++)
		Serial.print(rxstr);

/*
// send a string to the USB uart
if (j==5000)
	{
	CDC.print(txstr,7);
	j=0;
	}
j++;
*/
// receive a character on the UART and send it on the USB uart
if (Serial.available())
	{
	serstr[0]=Serial.read();
	CDC.print(txstr,7);
	PORTAbits.RA4=1;
	}	
}