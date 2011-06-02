// test with a 18B20+ connected on Pinguino32 ( works for Pinguino 8 bits as is )
// jean-pierre Mandon 2011

// VDD of 18B20 is connected to D8
// DQ of 18B20 is connected to D9
// GND of 18B20 is connected to D10
// 4,7k resistor between D8 and D9

#define ONEWIREBUS	9		// define the pin connected to the 18B20+ Dline

void setup()
{
Serial.begin(9600);
pinMode(8,OUTPUT);
digitalWrite(8,HIGH); 	// pin 8 is used to power the 18B20 ( +Vcc )
pinMode(10,OUTPUT);
digitalWrite(10,LOW);	// pin 10 is used to power the 18B20 ( GND )
}

void loop()
{
TEMPERATURE t;

if (DS18B20.read(ONEWIREBUS, SKIPROM, RES9BIT, &t))
	{
	if (t.sign) Serial.printf("-");
	else Serial.printf("+");
	Serial.printf("%d",t.integer);
	Serial.printf(".%d",t.fraction);
	Serial.printf("\n\r");
	}
}