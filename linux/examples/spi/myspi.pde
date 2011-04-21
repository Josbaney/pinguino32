void setup()
{
	SPI.init(SPI_MASTER_MODE_CLOCK_FOSC4, SPI_MODE_00, SPI_HIGH_SPEED_MODE);
}

void loop()
{
	SPI.write('0');
	SPI.write('0');
	SPI.write('7');
	SPI.write('\n');
	SPI.printf("My name is %s, James Bond\n", "Bond");
}
