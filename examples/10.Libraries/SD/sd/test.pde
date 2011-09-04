/*	-----------------------------------------------------------------------------
	FatFs Demo
	Author: (c) Jonas Andersson (jonas@haksberg.net) 2009
	http://jonas.haksberg.net/post/2010/03/07/Petit-FatFs-on-a-PIC18.aspx
	Adapted and modified by Régis Blanchot (23-05-2011)
	---------------------------------------------------------------------------*/

/*
	FATFS fs;
	byte data_buffer_32[32];
	word br; // number of bytes read

	// File to read 
	byte fileName[32]={"test.txt"}; 
*/

void setup()
{   
}

void loop()
{
	DSTATUS res;
	
	CDC.printf("init ...\r\n");
	res=SD.init();
	if (res==DRES_OK)
		CDC.printf("init OK\r\n");
	else
		CDC.printf("init error !\r\n");
	delay(1000);
/*	
	SD.mount(&fs);
	SD.open(fileName);
	// read file and print it until it ends
	do
	{
		// Read 31 chars from the file
		SD.read(data_buffer_32, 31, &br);
		// printf needs a C-string (NULL terminated)
		data_buffer_32[br] = '\0';
		CDC.printf("%s", data_buffer_32);
	} while (br == 31);	// if less than 31 bytes are read then the file has ended
	SD.unmount();
*/
}
