/*	---------------------------------------------------------------------------
	Pinguino BASIC
	2011 Regis Blanchot
	<rblanchot@gmail.com>
	http:

	minicom -o -D /dev/ttyACM0
	
	Suggested modifications on board:
		- add one more user led (for SD activity)
		- add pins WP et CD to the SD/MMC module (use SPI1 rather than SPI2)
	---------------------------------------------------------------------------*/



/*---------------------------------------------------------------------------*/
void setup(void)
{
	pbasic_init();
}
/*---------------------------------------------------------------------------*/
void loop(void)
{
	pbasic();
}
/*---------------------------------------------------------------------------*/

