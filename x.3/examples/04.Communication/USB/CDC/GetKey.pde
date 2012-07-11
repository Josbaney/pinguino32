//	Output GNU/Linux:	sudo minicom -o -D /dev/ttyACM0

u8 c=0;

void setup()
{
}

void loop()
{
    CDC.printf("Press a Key ...\r\n");
    c = CDC.getKey();
    CDC.printf("You pressed key [%c], code ASCII is \"%d\"\r\n", c, c);
}
