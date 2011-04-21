// test IO tiny 4550
// jean-pierre Mandon 2009

#define PIC18F4550

void setup()
{
pinMode(10,OUTPUT);
}

void loop()
{
if (analogRead(20)>500) digitalWrite(10,HIGH);
else digitalWrite(10,LOW);
}
