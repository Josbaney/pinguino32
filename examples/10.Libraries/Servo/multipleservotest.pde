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

// This routine will compile for 18F2550. 
// It's also valid for 18F4550, but it needs you enable the following define: 
// #define PIC18F4550

uchar position=0; // it starts at 0 degrees position
uchar position_inv=180;
uchar s;

void setup(void)
{
delay(500);
for(s==0;s<18;s++){	 //Preset of all pins as servos
	servo.attach(s);   // Attach it
	servo.setMaximumPulse(s,2200);	//Setting microseconds for 180 degrees position (Maximum)
	servo.setMinimumPulse(s,700);  // Setting microseconds for 0 degrees position (Minimum)
	}
}

void loop(void)
{                        
position++;
if(position>180){
	position = 0;
	}
// A set of servos moving from 0 to 180 degrees: 
servo.write(10,position);
servo.write(11,position);
servo.write(12,position);
servo.write(13,position);
servo.write(14,position);
servo.write(15,position);
servo.write(16,position);
servo.write(17,position);
servo.write(0,-position);

// A set of servos moving from 180 degrees to 0:
position_inv=180-position;
servo.write(1,position_inv);
servo.write(2,position_inv);
servo.write(3,position_inv);
servo.write(4,position_inv);
servo.write(5,position_inv);
servo.write(6,position_inv);
servo.write(7,position_inv);
servo.write(8,position_inv);
servo.write(9,position_inv);

delay(250);
}


