//
//

char caractere;
char chaine[5]={'T','E','S','T',0};

void setup()
{
serial1init(9600);
}

void loop()
{
if (millis()%1000==0) serial1printf("TEST\n\r");
if (serial1available()) {
					 serial1printf("caractere");
					 caractere=serial1read();
					 serial1printf(chaine);
					 serial1printf("%d",caractere);
					 }
}

