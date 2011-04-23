/*
	Pinguino example to read ds18b20 1wire temperature sensor
	Result is sent on usb bus and can be read with temp18b20.py
	author		Régis Blanchot
	first release	14/09/2010
	last update	06/10/2010
	IDE			Pinguino b9.2

	DS18B20 Connection
	------------------
	pin 1: GND
	pin 2: DQ (Data in/out) must be connected to the PIC
	pin 3: VDD (+5V)
	NB : 1-wire bus (DQ line) must have 4K7 pull-up resistor (connected to +5V)
*/

#define ONEWIREBUS	0		// 1-wire bus is on pin 0 (RB0), just change it to suit you 
#define RUNLED PORTAbits.RA4	// for visual debug purposes

void setup()
{
//
//
//
	
//
}

void loop()
{
	TEMPERATURE t;
	u8 temp[4];
//
//
//
	if (DS18B20Read(ONEWIREBUS, SKIPROM, RES12BIT, &t))
	{
//
		temp[0] = t.sign;			// t.sign is unsigned  char (1 byte)
		temp[1] = t.integer;		// t.integer  is unsigned  char (1 byte)
		temp[2] = high8(t.fraction);	// t.fraction is unsigned int (2 bytes)
		temp[3] = low8(t.fraction);
		usbsend(temp, 4);			// send 4-bit temp on usb bus
		RUNLED = RUNLED ^ 1;		// blinked led for visual debug
		Delayms(1000);			// wait for 1 sec. before next reading
	}
}


