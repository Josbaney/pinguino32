/*	----------------------------------------------------------------------------
	blink led with help from interrupt library
	----------------------------------------------------------------------------
	author:			Régis Blanchot
	first release:	19/12/2010
	last update:	24/12/2010
	pinguino ide:	9.5
	wiring:			leds on pin 0 (RB0)
					RB0 --- 470 Ohms ---<|--- GND
	--------------------------------------------------------------------------*/

#define LED0	0

void blink0()
{
	Toggle(LED0);
}

void setup()
{
	pinMode(LED0, OUTPUT);
	OnTimer0(blink0, INT_MILLISEC, 500);	// Use Timer0 to toggle pin 0 every 500 ms
}

void loop()
{
}

