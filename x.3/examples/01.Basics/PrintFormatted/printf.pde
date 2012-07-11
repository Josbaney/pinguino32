/*	----------------------------------------------------------------------------
	Pinguino printf demo - Régis Blanchot
	----------------------------------------------------------------------------
 	CDC output
 	--------------------------------------------------------------------------*/

void setup()
{
}


void loop()
{
	u8		*string = "Hello world!";
	u8		k, c = 65;
	u16		i = -333;
	u32		l = -115200;
	float	f = -1234567.14159265;

	CDC.printf("\r\n");
	CDC.println("**************************\r\n");
	CDC.printf("*  Pinguino Printf Demo  *\r\n");
	CDC.println("**************************\r\n");
	CDC.printf("\r\n");
	CDC.println("string = %s\r\n", string);
	CDC.printf("character = \"%c\"\r\n", c);
	CDC.println("signed char = %d / unsigned char = %u\r\n", -c, -c);
	CDC.printf("signed int = %d / unsigned int = %u\r\n", -i, -i);
	CDC.println("signed long = %ld / unsigned long = %lu\r\n", -l, -l);
	CDC.printf("decimal[%d] = hexa[0x%X] = binary[0b%016b] = octal[%o]\r\n", i, i, i, i);
	CDC.println("float (with 4 digits) = %.4f\r\n", f);
	CDC.printf("justif: \"%-10s\"\r\n", "left");
	CDC.println("justif: \"%10s\"\r\n", "right");
	CDC.printf(" 3: %04d zero padded\r\n", 3);
	CDC.println(" 3: %-4d left justif.\r\n", 3);
	CDC.printf(" 3: %4d right justif.\r\n", 3);
	CDC.println("-3: %04d zero padded\r\n", -3);
	CDC.printf("-3: %-4d left justif.\r\n", -3);
	CDC.println("-3: %4d right justif.\r\n", -3);
	CDC.printf("\r\n");
	CDC.printf("Press a Key ...\r\n");
	k = CDC.getKey();
	if (k == '\r')
		CDC.println("You pressed RETURN");
	else
		CDC.printf("You pressed \"%c\"\r\n", k);
}
