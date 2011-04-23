#include <eepromlib.c>

unsigned char answer;

void setup()
{
Serial.begin(9600);
}

void loop()
{
// ee_write(address,data);
// address is beetween 0 and 255
ee_write(0,0x41);
answer=ee_read(0);
Serial.print(answer,BYTE);
}
