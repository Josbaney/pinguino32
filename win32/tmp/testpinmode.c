// Testing input with Pinguino
// jean-pierre MANDON 2008

int led1;
int led2;

void setup() 
{
	led1=1;
	led2=7;
	pinMode(led1,OUTPUT);
	pinMode(led2,OUTPUT);
}

void loop() 
{
	digitalWrite(led1,HIGH);
	digitalWrite(led2,LOW);
	delay(500);
	digitalWrite(led1,LOW);
	digitalWrite(led2,HIGH);
	delay(500);
}	
