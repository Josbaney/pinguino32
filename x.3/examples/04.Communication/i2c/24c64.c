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
serial1init(9600);
for (i=0;i<8;i++) i2c_buffer[i]=0;
}

void loop()
{
Serial.print("try to write 8 char to eeprom\n\r");
i=I2C_write(I2C_address,string,10);
I2C_STOP();
if (i==1)
	{
	Serial.print("write OK, hit a key to read\n\r");
	serial1flush();
	while (!serial1available());
	}
else 
	{
	Serial.print("Error while writing to eeprom, reset\n\r");
	Serial.print(i);
	while(1);
	}
Serial.print("try to read 8 bytes to eeprom\n\r");
I2C_write(I2C_address,address_to_read,2);
i=I2C_read(I2C_address,8);
if  (i==1)
	Serial.print("received 8 bytes from eeprom\n\r");
for (i=0;i<8;i++) Serial.print(i2c_buffer[i]);
Serial.print("\n\r");
Delayms(50);
}	




