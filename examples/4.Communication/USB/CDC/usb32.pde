/*
	cdc example
	pc side : gtkterm --port /dev/ttyACM0 or cat /dev/ttyACM0
*/

char* chaine;		// unsigned char
u8 length;

void setup()
{
	chaine = (char*) malloc(64 * sizeof(char*));
	Serial.Configure(UART1, UART_ENABLE, UART_RX_TX_ENABLED, 9600);
	IntEnable(INT_USB);	
	
}

void loop()
{
	delay(100);
	chaine = CDC.getString();
	length = strlen(chaine) - 1;
	if (length !=0) Serial.Printf(UART1, "length=%d\n\r",length);
	if (length > 0) CDC.printf("> %s %c", chaine, 10);
}
