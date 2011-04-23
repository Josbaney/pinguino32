// first test with Pinguino
// test digitalWrite

void setup(void)
{
pinMode(0,OUTPUT);	// test caractères
}

void loop(void)
{
digitalWrite(0,HIGH);
delay(500);
digitalWrite(0,LOW);
delay(500);
}