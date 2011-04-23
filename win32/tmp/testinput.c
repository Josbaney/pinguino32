// Testing input with Pinguino
// jean-pierre MANDON 2008

void setup() 
{
	pinMode(1,INPUT);
	pinMode(7,OUTPUT);
}

void loop() 
{
	if (digitalRead(1)) digitalWrite(7,HIGH);
	else digitalWrite(7,LOW);
}
