// pinguino print numbers example
// Jean-Pierre Mandon 2010

int number;

void setup()
{
Serial.begin(9600);
}

void loop()
{
// print decimal number
number=3200;
Serial.print("Decimal 3200=");
Serial.print(number,DEC);
Serial.print("\n\r");
number=253;
Serial.print("Hexadecimal 253=");
Serial.print(number,HEX);
Serial.print("\n\r");
number=156;
Serial.print("Binary 156=");
Serial.print(number,BIN);
Serial.print("\n\r");
number=236;
Serial.print("Octal 236=");
Serial.print(number,OCTAL);
Serial.print("\n\r");
number=65;
Serial.print("Byte 65=");
Serial.print(number,BYTE);
Serial.print("\n\r");
}
