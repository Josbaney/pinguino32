
void setup()
{
serial1init(9600);
}

unsigned char chaine[64];
unsigned char length;

void loop()
{
Delayms(10);
length=CDCgets(chaine);
if (length!=0) serial1printf("longueur=%d\n\r",length);
if (length>0) 
	{
	CDCputs(chaine,length);
	}
}

