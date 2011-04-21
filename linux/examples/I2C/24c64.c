//
//



typedef short byte;

byte string[10]={0,0,'A','B','C','D','E','F','G','H'};	// string to write to i2c memory
//
//
byte I2C_address=0x51;						// i2c address of 24C64
byte address_to_read[2]={0,0};
int i;

void setup()
{
init_I2C();
serial_begin(9600);
for (i=0;i<8;i++) i2c_buffer[i]=0;
}

void loop()
{
serial_write("try to write 8 char to eeprom\n\r");
i=I2C_write(I2C_address,string,10);
I2C_STOP();
if (i==1)
	{
	serial_write("write OK, hit a key to read\n\r");
	serial_flush();
	while (!Serial.available());
	}
else 
	{
	serial_write("Error while writing to eeprom, reset\n\r");
	serial_write(i);
	while(1);
	}
serial_write("try to read 8 bytes to eeprom\n\r");
I2C_write(I2C_address,address_to_read,2);
i=I2C_read(I2C_address,8);
if  (i==1)
	serial_write("received 8 bytes from eeprom\n\r");
for (i=0;i<8;i++) serial_write(i2c_buffer[i]);
serial_write("\n\r");
Delayms(50);
}	





