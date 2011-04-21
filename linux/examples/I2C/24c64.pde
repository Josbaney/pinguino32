// test program for I2C communication with a 24C64 eeprom memory
// Jean-Pierre MANDON 2009

#include <libI2C.c>

byte string[10]={0,0,'A','B','C','D','E','F','G','H'};	// string to write to i2c memory
// fist byte of string[] is MSB of address to write to
// second byte is LSB 
byte I2C_address=0x51;						// i2c address of 24C64
byte address_to_read[2]={0,0};
int i;

void setup()
{
init_I2C();
Serial.begin(9600);
for (i=0;i<8;i++) i2c_buffer[i]=0;
}

void loop()
{
Serial.print("try to write 8 char to eeprom\n\r");
i=I2C_write(I2C_address,string[0],10);
I2C_STOP();
if (i==1)
	{
	Serial.print("write OK, hit a key to read\n\r");
	Serial.flush();
	while (!Serial.available());
	}
else 
	{
	Serial.print("Error while writing to eeprom, reset\n\r");
	Serial.print(i);
	while(1);
	}
Serial.print("try to read 8 bytes to eeprom\n\r");
I2C_write(I2C_address,address_to_read[0],2);
i=I2C_read(I2C_address,8);
if  (i==1)
	Serial.print("received 8 bytes from eeprom\n\r");
for (i=0;i<8;i++) Serial.print(i2c_buffer[i]);
Serial.print("\n\r");
delay(50);
}	



