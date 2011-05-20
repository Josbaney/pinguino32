//
//
//

void setup()
{
serial1init(9600);
}

void loop()
{
unsigned char random_number;
u8 chaine[20];
u8 caractere;


random_number=rand();
printf("This is a random number %02X\n\r",random_number);

if (serial1available()) 
	{
	caractere=serial1read();
	CDCputs(&caractere,1);
	}
if (CDCgets(chaine)!=0) CDCputs("CARACTERE",9);
Delayms(50);
}

