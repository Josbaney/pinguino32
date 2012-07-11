// test program for I2C communication with a 24C64 eeprom memory
// Jean-Pierre MANDON 2009

u8 string[10]={0,0,'A','B','C','D','E','F','G','H'};	// string to write to i2c memory
// fist byte of string[] is MSB of address to write to
// second byte is LSB 
u8 I2C_address=0x51;						// i2c address of 24C64
u8 address_to_read[2]={0,0};
u8 i2c_buffer[8];
int i;

void setup()
{
	I2C.master(I2C_100KHZ); // other possible values are I2C_400KHZ and I2C_1MHZ
	Serial.begin(9600);
	for (i=0;i<8;i++)
		i2c_buffer[i]=0;
}

void loop()
{
	Serial.print("try to write 8 char to eeprom\n\r");
	i=I2C.write(I2C_address, string, 10);
	if (i==1)
	{
		Serial.println("write OK, hit a key to read");
		Serial.flush();
		while (!Serial.available());
	}
	else 
	{
		Serial.println("Error while writing to eeprom, reset");
		Serial.print(i);
		while(1);
	}
	Serial.println("try to read 8 bytes to eeprom");
	I2C.write(I2C_address, address_to_read, 2);
	i=I2C.read(I2C_address, i2c_buffer, 8);
	if  (i==1)
	{
		Serial.println("received 8 bytes from eeprom");
		for (i=0;i<8;i++)
			Serial.print(i2c_buffer[i]);
		Serial.print("\n\r");
	}
	else
	{
		Serial.println("nothing received!!!");
	}
	delay(50);
}	
