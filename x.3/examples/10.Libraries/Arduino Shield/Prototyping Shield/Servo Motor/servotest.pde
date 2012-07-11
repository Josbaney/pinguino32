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
//This program will rotate servo motor continuously to -90 degree and +90 degree, back and forth
//pin used to test is pin 0 or pin 29

uchar position1=1;
uchar position2=250;

void setup(void)
{
servo.attach(29); //use pin29
servo.attach(0);	//use pin0
}

void loop(void)
{
servo.write(29,position1);
servo.write(0,position1);
delay(2000);
servo.write(29,position2);
servo.write(0,position2);
delay(2000);
}

