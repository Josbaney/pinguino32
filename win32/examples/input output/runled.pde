#define RUNLED PORTAbits.RA4

void setup()
{
}

void loop()
{
	RUNLED = RUNLED ^ 1;
	delay(500);
}
