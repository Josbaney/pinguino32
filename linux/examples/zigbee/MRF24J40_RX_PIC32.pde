// test zigbee receive
// Jean-Pierre Mandon 2011
// reception

#define channel 20					// channel must be selected between 11 and 26
#define PAN_ID 0xFEAA				// personal area network number ( between 0 and 65535 )
#define Short_Address 0x0002		// Address of the module ( between 0 and 65535 )

unsigned char rxdata[128];			// 128 is the max length

void setup()
{
Serial.begin(9600);
ZIG.init(channel,PAN_ID,Short_Address);
}

void loop()
{
unsigned char length;

length=ZIG.read(rxdata);
if (length>0)
		{
		Serial.printf("Source PAN ID:%04X\n\r",ZIGsrcpan);
		Serial.printf("Destination PAN ID:%04X\n\r",ZIGdestpan);
		Serial.printf("Source address:%04X\n\r",ZIGsrcadd);
		Serial.printf("Destination address:%04X\n\r",ZIGdestadd);
		Serial.printf(rxdata);
		Serial.printf("\n\r");
		}
}