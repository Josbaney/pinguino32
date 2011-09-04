/*	----------------------------------------------------------------------------
	lcd.printf demo for 32-bit
	<rblanchot@gmail.com>
	----------------------------------------------------------------------------
	---------- LCD 2x16
	----------------------------------------------------------------------------
	01 - VSS (GND)
	02 - VDD (+5V)
	03 - Vo (R = 1K Ohm to GND)
	04 - RS (pin 8 in this ex.)
	05 - RW (GND = LOW = write mode)
	06 - EN (pin 9 in this ex.)
	07 a 10 - D0 a D3   (connected to GND in this ex.)
	11 a 16 - D4 to D7  (pin 0 to 3 in this ex.)
	15 - LED+ (R = 470 Ohm to +5V)
	16 - LED- (GND)
	---------------------------------------------------------------------------*/

void setup()
{
//
//
	lcd(36, 37, 38, 39, 40, 41, 0, 0, 0, 0); // RS, E, D4 ~ D8	

//
	begin(2, 0); // lines, dotsize

	home(); // 0, 0
	lcdprintf("Sys.Clock: %02uMHz", GetSystemClock()/1000000);
	setCursor(0, 1);
	lcdprintf("Per.Clock: %02uMHz", GetPeripheralClock()/1000000);
}
 
void loop()
{
}

