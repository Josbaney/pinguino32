// cdc module for Pinguino32X
// Jean-Pierre Mandon 2010
// Based on the Microchip USB stack
// printf, println, print, write, getKey, getString - Régis Blanchot 2011

// 25 Feb. 2012 added support for 32MX220F032 jp.mandon
// 03 Mar. 2012 fixed a bug in WINDOWS CDC jp.mandon

#ifndef __USBCDC
#define __USBCDC

#include <stdarg.h>

#include <system.c>
#include <interrupt.c>
#include <delay.c>
#include <printf.c>

extern void USBCheckCDCRequest();
extern void CDCInitEP();
extern void USBTask();
extern void USBDeviceInit();
extern void USBDeviceAttach();
extern void putUSBUSART(char*, char);
extern char getsUSBUSART(char*, char);
extern void CDCTxService();
extern unsigned char cdc_trf_state;

#define mUSBUSARTIsTxTrfReady() (cdc_trf_state==0)

typedef enum
{
	EVENT_NONE = 0,
	EVENT_DEVICE_STACK_BASE = 1,
	EVENT_HOST_STACK_BASE = 100,
	EVENT_HUB_ATTACH,           
	EVENT_STALL,                  
	EVENT_VBUS_SES_REQUEST,     
	EVENT_VBUS_OVERCURRENT,     
	EVENT_VBUS_REQUEST_POWER,   
	EVENT_VBUS_RELEASE_POWER,   
	EVENT_VBUS_POWER_AVAILABLE, 
	EVENT_UNSUPPORTED_DEVICE,   
	EVENT_CANNOT_ENUMERATE,     
	EVENT_CLIENT_INIT_ERROR,    
	EVENT_OUT_OF_MEMORY,        
	EVENT_UNSPECIFIED_ERROR,     
	EVENT_DETACH, 
	EVENT_TRANSFER,
	EVENT_SOF,                  
	EVENT_RESUME,
	EVENT_SUSPEND,
	EVENT_RESET,  
	EVENT_DATA_ISOC_READ,
	EVENT_DATA_ISOC_WRITE,
	EVENT_GENERIC_BASE  = 400,
	EVENT_MSD_BASE      = 500,
	EVENT_HID_BASE      = 600,
	EVENT_PRINTER_BASE  = 700,
	EVENT_CDC_BASE      = 800,
	EVENT_CHARGER_BASE  = 900,
	EVENT_AUDIO_BASE    = 1000,
	EVENT_USER_BASE     = 10000,
	EVENT_BUS_ERROR     = 2^31-1
} USB_EVENT;

typedef enum
{
	EVENT_CONFIGURED = EVENT_DEVICE_STACK_BASE,
	EVENT_SET_DESCRIPTOR,
	EVENT_EP0_REQUEST,
	EVENT_ATTACH,
	EVENT_TRANSFER_TERMINATED
} USB_DEVICE_STACK_EVENTS;

// this function is here to insure compatibility between USB microchip
// stack and Pinguino interrupt code
 
void INTEnableSystemMultiVectoredInt()
{
	IntConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);
}

// this function is here to insure compatibility between USB microchip
// stack and Pinguino interrupt code

void INTEnableInterrupts()
{
	IntEnable(INT_USB);
}

#ifndef __32MX220F032D__

// this is the Set Line coding CallBack function
 
void mySetLineCodingHandler()
{
/*
	//If the request is not in a valid range
	if(cdc_notice.GetLineCoding.dwDTERate.Val > 115200)
	{
		//NOTE: There are two ways that an unsupported baud rate could be
		//handled.  The first is just to ignore the request and don't change
		//the values.  That is what is currently implemented in this function.
		//The second possible method is to stall the STATUS stage of the request.
		//STALLing the STATUS stage will cause an exception to be thrown in the 
		//requesting application.  Some programs, like HyperTerminal, handle the
		//exception properly and give a pop-up box indicating that the request
		//settings are not valid.  Any application that does not handle the
		//exception correctly will likely crash when this requiest fails.  For
		//the sake of example the code required to STALL the status stage of the
		//request is provided below.  It has been left out so that this demo
		//does not cause applications without the required exception handling
		//to crash.
		//---------------------------------------
		//USBStallEndpoint(0,1);
	}
	else
	{
		u32 dwBaud;

		//Update the baudrate info in the CDC driver
		CDCSetBaudRate(cdc_notice.GetLineCoding.dwDTERate.Val);

		//Update the baudrate of the UART
		U2BRG = ((GetPeripheralClock()+(BRG_DIV2/2*line_coding.dwDTERate.Val))/BRG_DIV2/line_coding.dwDTERate.Val-1);
		//U2MODE = 0;
		U2MODEbits.BRGH = BRGH2;
		//U2STA = 0;
	}
*/
}

// this is the USB Event CallBack function

void USER_USB_CALLBACK_EVENT_HANDLER(USB_EVENT event_usb)
{
	switch(event_usb)
	{
		case EVENT_EP0_REQUEST:
			USBCheckCDCRequest();
			break;
		case EVENT_CONFIGURED: 
			CDCInitEP();
			break;
	}
}

#endif

// this function is called by the main32.c file
// CDC.init
void CDC_init()
{
	USBDeviceInit();		// Initializes USB module SFRs and firmware
	#ifndef __32MX220F032D__
		USBDeviceAttach();
	#endif
	Delayms(1500);
}

// CDC.puts
// 18-05-2011 modified by régis blanchot
void CDCputs(char *buffer, char length)
{
		int i;

		for (i = 1000; i > 0; --i)
		{
			if (mUSBUSARTIsTxTrfReady())
				break;
			#ifdef __32MX220F032D__	
				USB_Service();
			#else
				CDCTxService();
			#endif
		}
		if (i > 0)
		{
			putUSBUSART(buffer,length);
			#ifdef __32MX220F032D__	
				USB_Service();
			#else
				CDCTxService();
			#endif

		}
}
	
// CDC.read
char CDCgets(char *buffer)
{

		char numBytesRead;
		
	#ifdef __32MX220F032D__
		USB_Service();
		numBytesRead = USB_Service_CDC_GetString( buffer );
	#else
		CDCTxService();
		numBytesRead = getsUSBUSART(buffer, 64);
	#endif
		return numBytesRead;
}

// added by regis blanchot 29/05/2011

// CDC.write
void CDCwrite(char c)
{
	CDCputs(c, 1);
}

// CDC.printf
void CDCprintf(const char *fmt, ...)
{
	char buffer[80];
//char *buffer;
	char length;
	va_list	args;

	va_start(args, fmt);
//length = strlen(fmt);
//buffer = (char *) malloc(1 + length * sizeof(char));	
	length = psprintf(buffer, fmt, args);
	CDCputs(buffer,length);
	va_end(args);
}

// CDC.print
// last is a string (char *) or an integer

void CDCprint(const char *fmt, ...)
{
	unsigned char s;
	va_list args;					// list of arguments
	va_start(args, fmt);			// initialize the list
	s = (unsigned char) va_arg(args, int);		// get the first variable arg.
	
	//switch (*args)
	switch (s)
	{
		case DEC:
			CDCprintf("%d", (int)fmt);
			break;
		case HEX:
			CDCprintf("%x", (int)fmt);
			break;
		case BYTE:
			CDCprintf("%d", (unsigned char)fmt);
			break;
		case OCT:
			CDCprintf("%o", (int)fmt);
			break;
		case BIN:
			CDCprintf("%b", (int)fmt);
			break;           
		default:
			CDCprintf(fmt);
			break;
	}
	va_end(args);
}

//CDC.println
void CDCprintln(const char *fmt,...)
{
	CDCprintf(fmt);
	CDCprintf("\n\r");
}

// CDC.getKey
char CDCgetkey()
{
	char buffer[64];		// always get a full packet

	while (!CDCgets(buffer));
	return (buffer[0]);	// return only the first character
}

// CDC.getString
char CDCgetstring(void)
{
	char i = 0;
	char c;
	static char buffer[80];
	
	do {
		c = CDCgetkey();
		CDCprintf("%c", c);
		buffer[i++] = c;
	} while (c != '\r');
	buffer[i] = '\0';
	return buffer;
}

#endif	/* __USBCDC */
