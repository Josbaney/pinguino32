// This is an example only for test
// newlib
// Jean-Pierre MANDON 2011

void setup()
{
Serial.begin(9600);
}

void loop()
{
unsigned char random_number;
u8 chaine[20];
u8 caractere;


random_number=rand();
printf("This is a random number %02X\n\r",random_number);

if (Serial.available()) 
	{
	caractere=Serial.read();
	CDC.print(&caractere,1);
	}
if (CDC.read(chaine)!=0) CDC.print("CARACTERE",9);
delay(50);
}