/*
	Blink a LED
*/

void setup()
{                
	// initialize the digital pin 13 as an output.
	pinMode(13, OUTPUT);     
}

void loop()
{
	toggle(13);			// alternate ON and OFF
	delay(1000);		// wait for a second
}
