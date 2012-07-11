// test zigbee receive
// Jean-Pierre Mandon 2011
// reception
// output : sudo minicom -o -D /dev/ttyACM0

#define CH				20			// channel must be selected between 11 and 26
#define PAN_ID			0x003C		// personal area network number ( between 0 and 65535 )
#define Short_Address	0x0002		// Address of the module ( between 0 and 65535 )

unsigned char rxdata[128];			// 128 is the max length

void setup()
{
	TRISDbits.TRISD1 = OUTPUT;		// User Led2
	LATDbits.LATD1 = 0;				// Led2 starts Off
	//pinMode(13, OUTPUT);			// User Led1
	ZIG.init(CH, PAN_ID, Short_Address);
}

void loop()
{
	u8 length;
	u8 i;

	LATDbits.LATD1 = !LATDbits.LATD1;	// Toggle User Led2
	//toggle(13);						// Toggle User Led1

	for (i=0;i<20;i++)
		CDC.printf("%02X ", mrf24j40_short_addr_read(i));

	CDC.printf("\n\r");
	length = ZIG.read(rxdata);
	CDC.printf("received %d bytes\n\r",length);

	if (length > 0)
	{
		CDC.printf("Source PAN ID:%04X\n\r",ZIGsrcpan);
		CDC.printf("Destination PAN ID:%04X\n\r",ZIGdestpan);
		CDC.printf("Source address:%04X\n\r",ZIGsrcadd);
		CDC.printf("Destination address:%04X\n\r",ZIGdestadd);
		CDC.printf(rxdata);
		CDC.printf("\n\r");
	}
	
	//delay(500);
}

