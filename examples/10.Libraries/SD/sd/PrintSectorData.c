/*	-----------------------------------------------------------------------------
	FatFs Demo
	Author: (c) Jonas Andersson (jonas@haksberg.net) 2009
	http://jonas.haksberg.net/post/2010/03/07/Petit-FatFs-on-a-PIC18.aspx
	Adapted and modified by Régis Blanchot (23-05-2011)
	---------------------------------------------------------------------------*/

void setup()
{   
//
	u8 fileName[32]={"/test/test.txt"}; 

//
	FATFS fs;
//
//
//
//
	
//
//
/*	
//
	serial_printf("\r\nInitializing SD-card.\r\n");
	if( (DResult = disk_initialize()) != DRES_OK )
	{
		serial_printf("\r\nError while initiating SD-card : %d\r\n ", DResult);
		while(1);
	}
	else
	{
		serial_printf("\r\nSD-card initalized.\r\n");
	}		

//
	serial_printf("\r\nAttempting to mount file system.\r\n");
	if( (FResult = pf_mount(&fs)) == FR_OK )
	{
		serial_printf("\r\nAttempting to open file %s.\r\n",fileName);

//
		FResult = pf_open(fileName);
		if( FResult == FR_OK )
		{
			serial_printf("\r\nStarting to read the file.\r\n");
				
//
			do
			{
//
				if( (FResult = pf_read(data_buffer_32, 31, &br)) == FR_OK )
				{
//
					data_buffer_32[br] = 0;
					serial_printf("%s", data_buffer_32);
				}
				else
				{
					serial_printf("\r\nError trying to read file %d.\r\n", FResult + 0x30);
					while(1);
				}
			} while( br == 31 );	// if less than 31 then the file has ended
		}
		else 
		{
			serial_printf("\r\nError trying to open file : %d.\r\n", FResult + 0x30);
			while(1);
		}
	}
	else
	{
		serial_printf("\r\nError trying to mount filesystem : %d.\r\n", FResult + 0x30);
		while(1);
	}
	
	serial_printf("\r\n\r\n");
			
//
	serial_printf("\r\nAttempting to UNmount file system.\r\n");
	
	FResult = pf_unmount();
	
	if( FResult != FR_OK )
	{
		serial_printf("\r\nError trying to UNmount filesystem : %d.\r\n", FResult + 0x30);
		while(1);
	}	
		
	serial_printf("\r\File system succesfully unmounted.\r\n");
*/
}

void loop()
{
}

