// Test for delayMicroseconds function:
// Modify the value of pulsewidth, and check 
// the square wave at user pin 0 with specified width.
// by Jesús Carmona Esteban
// only for Pinguino 8 bits board

unsigned int pulsewidth=10;

void setup(void)
{
pinMode(0,OUTPUT);
}

void loop(void)
{
PORTBbits.RB0 = 1;
delayMicroseconds(pulsewidth);
PORTBbits.RB0 = 0;
delayMicroseconds(pulsewidth);
PORTBbits.RB0 = 1;
delayMicroseconds(pulsewidth);
PORTBbits.RB0 = 0;
delayMicroseconds(pulsewidth);
}