char c;

void setup()
{
}

void loop()
{
	CDC.printf("Press a Key ...\r\n");
	c = CDC.getKey();
	CDC.printf("You pressed \"%d\"\r\n", c);
}
