/*
 * LCD routines for use with pinguino board, based on LiquidCrystal lib from Arduino project.
 * By Marcus Fazzi (Anunakin)
 * Pins, Schematics and more info: 
 * http://pinguino.koocotte.org/index.php/LCD_Example
 * http://anunakin.blogspot.com/2010/08/pinguino-clock.html
 */


#define LED 65
unsigned long counter;

void setup(){
	//8 bits mode
	//lcd(0, 1, 66, 67, 70, 71, 2, 3, 4, 5); // RS, E, D0 ~ D7
	//4 bits mode, dont use last four pins ...
	lcd(0, 1, 2, 3, 4, 5, 0, 0, 0, 0); // RS, E, D4 ~ D8	
	
	//LCD format
	lcd.begin(4, 0);
	
	/* Debug */
	pinMode(LED, OUTPUT);		// Debug LED
		
	lcd.clear();
}
 
void loop()
{
	lcd.home();
	lcd.print("Pinguino32X - LCDlib");	// Output char
	

	lcd.setCursor(0, 1);
	lcd.print("Hello World! PIC32");
	
	lcd.setCursor(1, 2);
	lcd.printNumber(counter, 10);
	
	lcd.setCursor(0, 3);
	lcd.print("visit: Vivaphp.net");
	
	digitalWrite(LED,HIGH);
	delay(15);
	digitalWrite(LED,LOW);
	delay(15);
	counter++;
}
