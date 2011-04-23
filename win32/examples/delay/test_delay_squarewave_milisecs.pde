// Test for delay (miliseconds) function:
// Modify the value of pulsewidth, and check 
// the square wave at user pin 0 with specified width.
// by Jesús Carmona Esteban

unsigned int pulsewidth=2;

void setup(void)
{
pinMode(0,OUTPUT);
}

void loop(void)
{
PORTBbits.RB0 = 1;
delay(pulsewidth);
PORTBbits.RB0 = 0;
delay(pulsewidth);
PORTBbits.RB0 = 1;
delay(pulsewidth);
PORTBbits.RB0 = 0;
delay(pulsewidth);
}