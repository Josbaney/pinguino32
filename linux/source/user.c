//
//
//

#define channel 20					// channel must be selected between 11 and 26
#define PAN_ID 0xFEAA				// personal area network number ( between 0 and 65535 )
#define Short_Address 0x0002		// Address of the module ( between 0 and 65535 )

unsigned char rxdata[128];			// 128 is the max length

void setup()
{
serial1init(9600);
init_zigbee(channel,PAN_ID,Short_Address);
}

void loop()
{
unsigned char length;

length=ZIGgets(rxdata);
if (length>0)
		{
		serial1printf("Source PAN ID:%04X\n\r",ZIGsrcpan);
		serial1printf("Destination PAN ID:%04X\n\r",ZIGdestpan);
		serial1printf("Source address:%04X\n\r",ZIGsrcadd);
		serial1printf("Destination address:%04X\n\r",ZIGdestadd);
		serial1printf(rxdata);
		serial1printf("\n\r");
		}
}

