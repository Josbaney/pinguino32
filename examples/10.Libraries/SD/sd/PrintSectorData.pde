/*	-----------------------------------------------------------------------------
	FatFs Demo
	Author: (c) Jonas Andersson (jonas@haksberg.net) 2009
	http://jonas.haksberg.net/post/2010/03/07/Petit-FatFs-on-a-PIC18.aspx
	Adapted and modified by Régis Blanchot (23-05-2011)
	---------------------------------------------------------------------------*/

void setup()
{   
	// File to read 
	u8 fileName[32]={"/test/test.txt"}; 

	// Global variables
	FATFS fs;
	//u8 data_buffer_32[32];
	//u16 br;
	//DRESULT DResult;
	//FRESULT FResult;
	
	// Initialize UART for output
	//Serial.begin(9600);
/*	
	// Initialize SD-card
	Serial.printf("\r\nInitializing SD-card.\r\n");
	if( (DResult = SD.init()) != DRES_OK )
	{
		Serial.printf("\r\nError while initiating SD-card : %d\r\n ", DResult);
		while(1);
	}
	else
	{
		Serial.printf("\r\nSD-card initalized.\r\n");
	}		

	// Mount SD-card
	Serial.printf("\r\nAttempting to mount file system.\r\n");
	if( (FResult = SD.mount(&fs)) == FR_OK )
	{
		Serial.printf("\r\nAttempting to open file %s.\r\n",fileName);

		// open file
		FResult = SD.open(fileName);
		if( FResult == FR_OK )
		{
			Serial.printf("\r\nStarting to read the file.\r\n");
				
			// read file and print it until it ends
			do
			{
				// Read 31 chars from the file
				if( (FResult = SD.read(data_buffer_32, 31, &br)) == FR_OK )
				{
					// printf needs a C-string (NULL terminated)
					data_buffer_32[br] = 0;
					Serial.printf("%s", data_buffer_32);
				}
				else
				{
					Serial.printf("\r\nError trying to read file %d.\r\n", FResult + 0x30);
					while(1);
				}
			} while( br == 31 );	// if less than 31 then the file has ended
		}
		else 
		{
			Serial.printf("\r\nError trying to open file : %d.\r\n", FResult + 0x30);
			while(1);
		}
	}
	else
	{
		Serial.printf("\r\nError trying to mount filesystem : %d.\r\n", FResult + 0x30);
		while(1);
	}
	
	Serial.printf("\r\n\r\n");
			
	// unmount drive
	Serial.printf("\r\nAttempting to UNmount file system.\r\n");
	
	FResult = SD.unmount();
	
	if( FResult != FR_OK )
	{
		Serial.printf("\r\nError trying to UNmount filesystem : %d.\r\n", FResult + 0x30);
		while(1);
	}	
		
	Serial.printf("\r\File system succesfully unmounted.\r\n");
*/
}

void loop()
{
}
