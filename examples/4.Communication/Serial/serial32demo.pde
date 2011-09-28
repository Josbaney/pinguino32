/*	----------------------------------------------------------------------------
	serial32demo - Régis Blanchot
	----------------------------------------------------------------------------
	serial demo for pinguino 32 bits
	----------------------------------------------------------------------------
	TTL/RS232
		=> GND TX RX +5V (Black Green White Red)
	PIC32MX4XXL (Datasheet DS61143C-page 6)
		U1RX = RF2 (pin 52) = Green
		U1TX = RF8 (pin 53) = White
	--------------------------------------------------------------------------*/
#define UARTPORT UART1
#DEFINE UARTSPEED 9600

const u8 mainMenu[] =
{
	"\r\n"\
	"Welcome to Pinguino32 Serial Demo!\r\n"\
	"Here are the main menu choices:\r\n"\
	"0. SerialPrintf Test\r\n"\
	"1. View System Clock Frequency\r\n"\
	"2. View Peripheral Clock Frequency\r\n"\
	"3. View Actual BAUD rate\r\n"\
	"4. Increase BAUD rate\r\n"\
	"5. Decrease BAUD rate\r\n"\
	"6. Set Line Control\r\n"\
	"7. ECHO\r\n"\
	"Please Choose a number\r\n"
};

const u8 lineMenu[] =
{
    "Line Control Menu\r\n"\
    "You may need to change your port conficuration on your terminal to see data\r\n"\
    "1. 8-N-1\r\n"\
    "2. 8-E-1\r\n"\
    "3. 8-O-1\r\n"\
    "4. 8-N-2\r\n"\
    "5. 8-E-2\r\n"\
    "6. 8-O-2\r\n"\
    "\r\n\r\nPlease Choose a number\r\n"
};

const u32 lineControl[] =
{
	(UART_8_BITS_NO_PARITY   | UART_STOP_BITS_1),
	(UART_8_BITS_EVEN_PARITY | UART_STOP_BITS_1),
	(UART_8_BITS_ODD_PARITY  | UART_STOP_BITS_1),
	(UART_8_BITS_NO_PARITY   | UART_STOP_BITS_2),
	(UART_8_BITS_EVEN_PARITY | UART_STOP_BITS_2),
	(UART_8_BITS_ODD_PARITY  | UART_STOP_BITS_2)
};

u32 baudrate;

void setup()
{
	baudrate = UARTSPEED;	// 300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200, until Sys. Clock / 4
	Serial.Configure(UARTPORT, UART_ENABLE, UART_RX_TX_ENABLED,	baudrate);

/*	---Use one of these forms------------------------------------------------------------
	Serial.Configure(	UARTPORT, 0x8000, 0x1400, 9600);
	Serial.Configure(	UARTPORT, UART_ENABLE,	UART_RX_TX_ENABLED,	baudrate);
	Serial.Configure(	UARTPORT,
							UART_ENABLE | UART_ENABLE_PINS_TX_RX_ONLY | UART_8_BITS_NO_PARITY | UART_STOP_BITS_1,
							UART_RX_TX_ENABLED | UART_INTERRUPT_ON_RX_FULL,
							baudrate);
/*	---or-----------------------------------------------------------------------
	Serial.PinConfigure(UARTPORT);
	Serial.SetDataRate(UARTPORT, baudrate);
	Serial.SetLineControl(UARTPORT, UART_ENABLE | UART_ENABLE_PINS_TX_RX_ONLY | UART_8_BITS_NO_PARITY | UART_STOP_BITS_1);
	Serial.Enable(UARTPORT, UART_RX_TX_ENABLED | UART_INTERRUPT_ON_RX_FULL);
	Serial.IntConfigure(UARTPORT, INT_PRIORITY_3, INT_SUBPRIORITY_3);
	--------------------------------------------------------------------------*/

	//Serial.Printf(UARTPORT, "* System Clock is %2uMHz *\n\r", GetSystemClock()/1000000);

/*	---Test---------------------------------------------------------------------
	s16 i=-1000;
	char *string = "Fine !";
	loop
	{
		Serial.Printf(UARTPORT, "Decimal[%5d] = Hexa[0x%4X] %s\n\r", i, i, string);
		i++;
	}
	--------------------------------------------------------------------------*/
}


void loop()
{
	u8 choice;
	u8 mainItem;
	u8 lineItem;

	char *string = "Hello world!";
	char c = 65;
	int i = 333;
	long l = 115200;
	//float f = 3.14159265; // floating point support is not yet implemented in printf

	Serial.Printf(UARTPORT, "%s\r\n", mainMenu);
	mainItem = Serial.GetKey(UARTPORT);
	mainItem -= '0';

	switch (mainItem)
	{
		case 0:
			Serial.Printf(UARTPORT, "\r\n");
			Serial.Printf(UARTPORT, "**************************\r\n");
			Serial.Printf(UARTPORT, "*      Serial32 Demo     *\r\n");
			Serial.Printf(UARTPORT, "**************************\r\n");
			Serial.Printf(UARTPORT, "\r\n");
			Serial.Printf(UARTPORT, "string = %s\r\n", string);
			Serial.Printf(UARTPORT, "character = \"%c\"\r\n", c);
			Serial.Printf(UARTPORT, "signed char = %d / unsigned char = %u\r\n", -c, -c);
			Serial.Printf(UARTPORT, "signed int = %d / unsigned int = %u\r\n", -i, -i);
			Serial.Printf(UARTPORT, "signed long = %d / unsigned long = %u\r\n", -l, -l);
			Serial.Printf(UARTPORT, "decimal[%d] = hexa[0x%X] = binary[0b%016b] = octal[%o]\r\n", i, i, i, i);
			//SerialPrintf(UARTPORT, "float = %f\r\n", f);
			Serial.Printf(UARTPORT, "justif: \"%-10s\"\r\n", "left");
			Serial.Printf(UARTPORT, "justif: \"%10s\"\r\n", "right");
			Serial.Printf(UARTPORT, " 3: %04d zero padded\r\n", 3);
			Serial.Printf(UARTPORT, " 3: %-4d left justif.\r\n", 3);
			Serial.Printf(UARTPORT, " 3: %4d right justif.\r\n", 3);
			Serial.Printf(UARTPORT, "-3: %04d zero padded\r\n", -3);
			Serial.Printf(UARTPORT, "-3: %-4d left justif.\r\n", -3);
			Serial.Printf(UARTPORT, "-3: %4d right justif.\r\n", -3);
			Serial.Printf(UARTPORT, "\r\n");
			Serial.Printf(UARTPORT, "Press Any Key to continue ...\r\n");
			Serial.GetKey(UARTPORT);
			break;
		case 1:
			Serial.Printf(UARTPORT, "**************************\r\n");
			Serial.Printf(UARTPORT, "* System Clock is %2uMHz *\r\n", GetSystemClock()/1000000);
			Serial.Printf(UARTPORT, "**************************\r\n");
			Serial.Printf(UARTPORT, "Press Any Key to continue ...\r\n");
			Serial.GetKey(UARTPORT);
			break;
		case 2:
			Serial.Printf(UARTPORT, "******************************\r\n");
			Serial.Printf(UARTPORT, "* Peripheral Clock is %2uMHz *\r\n", GetPeripheralClock()/1000000);
			Serial.Printf(UARTPORT, "******************************\r\n");
			Serial.Printf(UARTPORT, "Press Any Key to continue ...\r\n");
			Serial.GetKey(UARTPORT);
			break;
		case 3:
			Serial.Printf(UARTPORT, "**************************************\r\n");
			Serial.Printf(UARTPORT, "* Actual BAUD rate is %8u bauds *\r\n", SerialGetDataRate(UARTPORT));
			Serial.Printf(UARTPORT, "**************************************\r\n");
			Serial.Printf(UARTPORT, "Press Any Key to continue ...\r\n");
			Serial.GetKey(UARTPORT);
			break;
		case 4:
			baudrate = baudrate << 1;
			Serial.Printf(UARTPORT, "BAUD rate was %u and will be %u bauds\r\n", SerialGetDataRate(UARTPORT), baudrate);
			Serial.Printf(UARTPORT, "Press Any Character after re-configuring you terminal\r\n");
			Serial.GetKey(UARTPORT);
			Serial.SetDataRate(UARTPORT, baudrate);
			Serial.Printf(UARTPORT, "New BAUD rate is %u bauds\r\n", SerialGetDataRate(UARTPORT));
			Serial.Printf(UARTPORT, "Press Any Key to continue ...\r\n");
			Serial.GetKey(UARTPORT);
			break;
		case 5:
			baudrate = baudrate >> 1;
			Serial.Printf(UARTPORT, "BAUD rate was %u and will be %u bauds\r\n", SerialGetDataRate(UARTPORT), baudrate);
			Serial.Printf(UARTPORT, "Press Any Character after re-configuring you terminal\r\n");
			Serial.GetKey(UARTPORT);
			Serial.SetDataRate(UARTPORT, baudrate);
			Serial.Printf(UARTPORT, "New BAUD rate is %u bauds\r\n", SerialGetDataRate(UARTPORT));
			Serial.Printf(UARTPORT, "Press Any Key to continue ...\r\n");
			Serial.GetKey(UARTPORT);
			break;
		case 6:
			Serial.Printf(UARTPORT, "%s", lineMenu);
			lineItem = Serial.GetKey(UARTPORT);
			lineItem = lineItem - '0';
			Serial.Printf(UARTPORT, "Press Any Character after re-configuring you terminal\r\n");
			Serial.GetKey(UARTPORT);
			Serial.SetLineControl(UARTPORT, lineControl[lineItem]);
			break;
		case 7:
			Serial.Printf(UARTPORT, "Type a message (less than 100 characters) and press return\r\n");
			string = Serial.GetString(UARTPORT);
			Serial.Printf(UARTPORT, "You Typed:\r\n\r\n%s\r\n\r\n", string);
			Serial.Printf(UARTPORT, "\r\n\r\nPress any key to continue");
			Serial.GetKey(UARTPORT);
			break;
	}
}
