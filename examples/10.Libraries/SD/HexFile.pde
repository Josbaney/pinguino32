/*	---------------------------------------------------------------------------
	Read a file on SD card
	2011 Regis Blanchot
	<rblanchot@gmail.com>
	http://www.pinguino.cc

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

#define B_SIZE 256	// blocks of arbitrary length,
					// try to change it to improve efficiency 

void setup()
{
}

void loop()
{
	File *fs;
	char data[B_SIZE];
	unsigned r;
	int i, j;
	
	// wait for RETURN key to start
	CDC.println("Press RETURN to start.");
	while (CDC.getKey() != '\r');
	
	// mount FAT16 system
	// Card Select output on pin 8
	if (SD.mount(8)) // or SD.init(8) or SD.begin(8)
	{
		// open file
		if (( fs = SD.open("lorem.txt", "r") ))
		{
			do {
				r = SD.read(fs, data, B_SIZE);
				for(i = 0; i < r; i++)
				{
					CDC.printf("%02X  ", data[i]); 
					if (i%8 == 0)
					{
						for (j=i-8; j<i; j++)
						{
							if ( isAlphaNumeric(data[j]) && !isControl(data[j]) )
								CDC.printf("%c", data[j]);
							else
								CDC.printf(".");
						}
						CDC.printf("\r\n"); 
					}
				}
			} while(r == B_SIZE);
			CDC.printf("\r\n"); 
			SD.close(fs);
			SD.unmount();
		}
		else
		{
			CDC.println("file not found!");
		}
	}
	else
	{
		CDC.println("mount failed!");
	}
}
