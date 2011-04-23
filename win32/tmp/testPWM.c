// test PWM with Pinguino
// Jean-Pierre MANDON 2009

void setup()
{
}

void loop()
{
analogWrite(11,512);	// 50% square wave on output 11
analogWrite(12,102);	// 10% square wave on output 12
while(1);
}

