/*	---------------------------------------------------------------------------
	List files on SD card
	2011 Regis Blanchot
	<rblanchot@gmail.com>
	http:

	circuit:
	* SD card attached to SPI bus as follows:
	** MOSI - pin 11
	** MISO - pin 12
	** CLK - pin 13
	** CS - pin 8

	output:
	(GNU/linux) sudo minicom -o -D /dev/ttyACM0
	press <return> to start
	---------------------------------------------------------------------------*/

void setup()
{
}

void loop()
{


	char i, found;
	const char ext[]="TXT";
	DIRTABLE dir[MAXFILE];

//
	CDCprintln("Press RETURN to start.");
	while (CDCgetkey() != '\r');
	CDCprintln(" ");
	
//
//
	if (mount(8))
	{
		CDCprintln("SD successfully mounted");
		found = listTYPE(dir, MAXFILE, ext);
		CDCprintln("%-8s %-8s %-8s", "name", "ext", "bytes");
		CDCprintln("-----------------------");
		for (i=0; i<found; i++)
			CDCprintf("%-8s %-8s %-8d\r\n", dir[i].filename, dir[i].ext, dir[i].size);
		CDCprintln("found %d file(s)", found);
		unmount();
	}
	else
	{
		CDCprintln("mount failed!");
	}
}

