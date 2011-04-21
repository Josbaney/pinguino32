/*
 * LCD routines for use with pinguino board, based on LiquidCrystal lib from Arduino project.
 * By Marcus Fazzi (Anunakin)
 * Pins, Schematics and more info: 
 * http://pinguino.koocotte.org/index.php/LCD_Example
 * http://anunakin.blogspot.com/2010/08/pinguino-clock.html
 */


#define LED 1
long counter;

void setup(){
	//8 bits mode
	//lcd(8, 9, 0, 1, 2, 3, 4, 5, 6, 7); // RS, E, D0 ~ D7
	
	//4 bits mode, dont use last four pins ...
	lcd(0, 2, 3, 4, 5, 6, 0, 0, 0, 0); // RS, E, D4 ~ D8	
	
	//LCD format
	lcd.begin(4, 0);
	
	/* Debug */
	pinMode(LED, OUTPUT);		// LED on pin 13
	
}
 
void loop()
{
	// Output string
	lcd.home();
	//lcd.setCursor(0, 0);
	lcd.print("Pinguino32X");	// Output char
		
	delay(500);
	while(1){
	lcd.home();
	lcd.print("Hello World!");
	
	lcd.setCursor(0, 1);
	lcd.printNumber(counter, 10);
	
	digitalWrite(LED,HIGH);
	delay(250);
	digitalWrite(LED,LOW);
	delay(250);
	counter++;
	}
}

