// test program for I2C communication with a 24C64 eeprom memory
// Jean-Pierre MANDON 2009

u8 string[10]={0,0,'A','B','C','D','E','F','G','H'};	// string to write to i2c memory
// fist byte of string[] is MSB of address to write to
// second byte is LSB 
u8 I2C_address=0x51;						// i2c address of 24C64
u8 *I2C_buffer;
u8 address_to_read[2]={0,0};
u16 i;

void setup()
{
    I2C.master(I2C_100KHZ);
    Serial.begin(9600);
    for (i=0;i<8;i++) I2C_buffer[i]=0;
}

void loop()
{
    Serial.print("try to write 8 char to eeprom\n\r");
    i = I2C.write(I2C_address,string,10);
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
    I2C.write(I2C_address,address_to_read,2);
    i = I2C.read(I2C_address,I2C_buffer,8);
    if  (i==1)
        Serial.print("received 8 bytes from eeprom\n\r");
    for (i=0;i<8;i++) Serial.print(I2C_buffer[i]);
    Serial.print("\n\r");
    delay(50);
}	
