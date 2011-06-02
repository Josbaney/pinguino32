// test zigbee receive
// Jean-Pierre Mandon 2011
// Tranmission

#define channel 20					// channel must be selected between 11 and 26
#define PAN_ID 0xFEAA				// personal area network number ( between 0 and 65535 )
#define Short_Address 0x0001		// Address of the module ( between 0 and 65535 )

#define Dest_Address 0x0002			// address of a module you want to communicate with

void setup()
{
ZIG.init(channel,PAN_ID,Short_Address);
}

void loop()
{
ZIG.send(Dest_Address,"TOTO",4);
delay(1000);
}