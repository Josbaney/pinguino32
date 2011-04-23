// test analogic input with Pinguino
// jean-pierre MANDON 2008

unsigned int i;

void setup() 
	{
	Serial.begin(9600);
	}

void loop() 
	{
	while (1) 	{
			i=analogRead(15);
			Serial.print("input 15=");
			Serial.print(i,DEC);
			Serial.print("\n\r");
			}
}