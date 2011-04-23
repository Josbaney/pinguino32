/*	----------------------------------------------------------------------------
	sprintf - Régis Blanchot
	--------------------------------------------------------------------------*/

void setup()
{
	Serial.init(9600);
}

void loop()
{
	char buf[80];

	sprintf(buf, "|justif: \"%-10s\"|\n", "left");	Serial.printf("%s", buf);
	sprintf(buf, "|justif: \"%10s\"|\n", "right");	Serial.printf("%s", buf);
	sprintf(buf, "| 3: %04d zero padded|\n", 3);		Serial.printf("%s", buf);
	sprintf(buf, "| 3: %-4d left justif.|\n", 3);	Serial.printf("%s", buf);
	sprintf(buf, "| 3: %4d right justif.|\n", 3);	Serial.printf("%s", buf);
	sprintf(buf, "|-3: %04d zero padded|\n", -3);	Serial.printf("%s", buf);
	sprintf(buf, "|-3: %-4d left justif.|\n", -3);	Serial.printf("%s", buf);
	sprintf(buf, "|-3: %4d right justif.|\n", -3);	Serial.printf("%s", buf);
}
