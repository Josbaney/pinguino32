//
//
//



void setup()
{
serial1init(9600);
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
//
//
rxstr[receivedbyte]=0; // to make received character(s) a string
if (receivedbyte>0)
	for (i=0;i<receivedbyte;i++)
		Serial.print(rxstr);

//
if (j==5000)
	{
//
	j=0;
	}
j++;
//
if (serial1available())
	{
	serstr[0]=serial1read();
//
	}
}
