// first test with Pinguino
// test digitalWrite

void setup(void)
{
pinMode(13,OUTPUT);	// test caractères
}

void loop(void)
{
digitalWrite(13,HIGH);
delay(500);
digitalWrite(13,LOW);
delay(500);
}