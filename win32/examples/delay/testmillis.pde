// test of millis instruction
// jean-pierre MANDON 2009

int i;

void setup()
{
pinMode(0,OUTPUT);
digitalWrite(0,LOW);
}

void loop()
{
if (millis()>2000) digitalWrite(0,HIGH);
}
