//char USB_Out_Buffer[64];

void setup()
{
Serial.begin(9600);
}

unsigned char chaine[64];
unsigned char length;

void loop()
{
delay(10);
length=getsUSBUSART(chaine,64);
if (length!=0) Serial.printf("longueur=%d\n\r",length);
if (length>0) CDC.print(chaine,length);
}