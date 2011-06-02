//
//

//
//
//
//

#define ONEWIREBUS	9		// define the pin connected to the 18B20+ Dline

void setup()
{
serial1init(9600);
pinmode(8,OUTPUT);
digitalwrite(8,HIGH); 	// pin 8 is used to power the 18B20 ( +Vcc )
pinmode(10,OUTPUT);
digitalwrite(10,LOW);	// pin 10 is used to power the 18B20 ( GND )
}

void loop()
{
TEMPERATURE t;

if (DS18B20Read(ONEWIREBUS, SKIPROM, RES9BIT, &t))
	{
	if (t.sign) serial1printf("-");
	else serial1printf("+");
	serial1printf("%d",t.integer);
	serial1printf(".%d",t.fraction);
	serial1printf("\n\r");
	}
}

