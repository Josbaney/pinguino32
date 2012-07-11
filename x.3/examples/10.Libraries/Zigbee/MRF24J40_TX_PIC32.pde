// test zigbee receive
// Jean-Pierre Mandon 2011
// Tranmission

#define CH				20			// channel must be selected between 11 and 26
#define PAN_ID			0x003C		// personal area network number ( between 0 and 65535 )
#define Short_Address	0x0001		// address of the module ( between 0 and 65535 )
#define Dest_Address	0x0002		// address of a module you want to communicate with

void setup()
{
	pinMode(13, OUTPUT);			// User Led
	ZIG.init(CH, PAN_ID, Short_Address);
}

void loop()
{
	toggle(13);						// Toggle User Led
	ZIG.send(Dest_Address, "Pinguino", 8);
	delay(1000);
}
