// Test blink of UBW32 LED with Pinguino 32X
// Marcus Fazzi (Anunakin) 2011

//UBW32 hardware definitions file
//That file contains LED pins and Buttons for use with UBW32 and EMPEROR boards
#include <hardware.c>

int tempo;					// tempo is an integer

void setup() 
{
	tempo=25;				// tempo for blink is 50 mS
	pinMode(LED1, OUTPUT);
	pinMode(LED2, OUTPUT);
	pinMode(LED3, OUTPUT);
	pinMode(LED4, OUTPUT);
}

void loop() 
{
	UBW32LedToggle(GREENLED);
	delay(tempo);
	UBW32LedToggle(GREENLED);
	delay(tempo);
	UBW32LedToggle(WHITELED);
	delay(tempo);
	UBW32LedToggle(WHITELED);
	delay(tempo);
	UBW32LedToggle(REDLED);
	delay(tempo);
	UBW32LedToggle(REDLED);
	delay(tempo);
	UBW32LedToggle(YELLOWLED);
	delay(tempo);
	UBW32LedToggle(YELLOWLED);
	delay(tempo);
}	