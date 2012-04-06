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


// This routine is valid for pinguino boards: 
// Generic 2550 (no #define needed)
// Generic 4550 (enable #define PIC18F4550),
// PICUNO EQUO (enable #define PICUNO_EQUO)

uchar position=1;

void setup(void)
{
servo.attach(13);
servo.setMaximumPulse(13,2500);  // Maximum pulse width in microseconds (180 degrees).
servo.setMaximumPulse(13,500);   // Minimum pulse width in microseconds (0 degrees).
}

void loop(void)
{
servo.write(13,position);
delay(500);
position++;
if(position>180) position=0;
}
