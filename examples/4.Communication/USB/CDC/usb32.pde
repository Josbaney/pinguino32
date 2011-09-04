/*
	cdc example
	pc side : gtkterm --port /dev/ttyACM0 or cat /dev/ttyACM0
*/

char chaine[64];		// unsigned char
u8 length;

void setup()
{
	Serial.begin(9600);
}

void loop()
{
	delay(100);
	length=CDC.read(chaine,64);
	if (length !=0) Serial.printf("longueur=%d\n\r",length);
	if (length > 0) CDC.print(chaine,length);
}