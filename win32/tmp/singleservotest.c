// Servo library test with Pinguino
// Connect servo control lines to pinguino pins.
// Feed servos with +5 V:
//
//   +-----+
//   |servo|--------- PWM Servo control ---> to pinguino pin.
//   |     |--------- +5V
//   |  o  |--------- GND
//   |     | 
//   +-----+

uchar position=1;

void setup(void)
{
servo.attach(17);
}

void loop(void)
{
servo.write(17,position);
delay(500);
position++;
}

