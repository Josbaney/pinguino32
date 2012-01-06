/*	---------------------------------------------------------------------------
 List files on SD card
 2011 Regis Blanchot
 <rblanchot@gmail.com>
 2012 Alfred Broda
 <alfredbroda@gmail.com>
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

void setup() {
}

void loop() {

	CDCprintln("Press RETURN to start.");
	while (CDCgetkey() != '\r')
		;
	CDCprintln(" ");

	mount(8);
	CDCprintln("SD card contents");

	char res, b;
	unsigned int files, dirs;
	DIR dir; /* Directory object */
	FILINFO Finfo; /* File info */

	// open directory
	res = f_opendir(&dir, "/");
	files = dirs = 0;
	CDCprintln("Attr  Time               Size      Name");
	for (;;) {
		if ((f_readdir(&dir, &Finfo) != 0) || !Finfo.fname[0]) {
			// error or end of files
			break;
		}

		if (isDirectory(Finfo)) {
			dirs++;
		} else {
			files++;
		}
		CDCprintf("%c%c%c%c%c ", isDirectory(Finfo) ? 'D' : '-', isReadOnly(
				Finfo) ? 'R' : '-', isHidden(Finfo) ? 'H' : '-',
				isSystem(Finfo) ? 'S' : '-', isArchive(Finfo) ? 'A' : '-');
		CDCprintf("%u/%02u/%02u %02u:%02u ", (Finfo.fdate >> 9) + 1980,
				(Finfo.fdate >> 5) & 15, Finfo.fdate & 31, (Finfo.ftime >> 11),
				(Finfo.ftime >> 5) & 63);
		CDCprintf(" %9u ", Finfo.fsize);
		CDCprintln(" %-12s", Finfo.fname);
	}
	CDCprintln("found %d file(s), %d directories", files, dirs);
	unmount();
}

