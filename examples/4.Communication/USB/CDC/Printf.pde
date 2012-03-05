u8 n=0;

void setup()
{
}

void loop()
{
	CDC.printf("n = %d \r\n", n++);
	delay(100);
}
