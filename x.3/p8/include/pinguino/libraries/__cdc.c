// cdc module for Pinguino - Jean-Pierre Mandon 2010
// printf, println, print, write, getKey, getString - Régis Blanchot 2011

#ifndef __USBCDC
#define __USBCDC

#define USB_USE_CDC

#include <usb/usb_cdc.h>
#include <usb/usb_config.c>
#include <usb/picUSB.c>
#include <usb/usb_cdc.c>
#include <typedef.h>
#include <delay.c>
#include <stdio.c>                  // Pinguino printf
#include <stdarg.h>

void CDC_init()
{
	INTCON=0;
	INTCON2=0xC0;
	UCON=0;
	UCFG=0;
	UEP0=0;UEP1=0;UEP2=0;UEP3=0;UEP4=0;UEP5=0;
	UEP6=0;UEP7=0;UEP8=0;UEP9=0;UEP10=0;UEP11=0;
	UEP12=0;UEP13=0;UEP14=0;UEP15=0;
	// and wait 2 seconds
	Delayms(2000);
	// Initialize USB for CDC
	UCFG = 0x14; 				// Enable pullup resistors; full speed mode
	deviceState = DETACHED;
	remoteWakeup = 0x00;
	currentConfiguration = 0x00;
	// And enable USB module
	while(deviceState != CONFIGURED)
	{
	  EnableUSBModule();
	  ProcessUSBTransactions();
	}
}

// added by regis blanchot 14/06/2011

// CDC.write
void CDCwrite(u8 c)
{
	CDCputs(c, 1);
}

// CDC.printf
void CDCprintf(const u8 *fmt, ...)
{
	u8 buffer[80];
	//char *buffer;
	u8 length;
	va_list	args;

	va_start(args, fmt);
	//length = strlen(fmt);
	//buffer = (char *) malloc(1 + length * sizeof(char));	
	length = psprintf2(buffer, fmt, args);
	CDCputs(buffer,length);
	va_end(args);
}

// CDC.print
// last is a string (char *) or an integer

void CDCprint(const u8 *fmt, ...)
{
	u8 s;
	va_list args;							// a list of arguments
	va_start(args, fmt);					// initialize the list
	s = (u8) va_arg(args, u32);				// get the first variable arg.
	
	//switch (*args)
	switch (s)
	{
		case FLOAT:
			CDCprintf("%f", (u32)fmt);
			break;
		case DEC:
			CDCprintf("%d", (u32)fmt);
			break;
		case HEX:
			CDCprintf("%x", (u32)fmt);
			break;
		case BYTE:
			//CDCprintf("%d", (u8)fmt);
			CDCprintf("%d", (u32)fmt);
			break;
		case OCT:
			CDCprintf("%o", (u32)fmt);
			break;
		case BIN:
			CDCprintf("%b", (u32)fmt);
			break;           
		default:
			CDCprintf(fmt);
			break;
	}
	va_end(args);
}

//CDC.println
void CDCprintln(const u8 *fmt, ...)
{
	va_list args;							// a list of arguments
	va_start(args, fmt);					// initialize the list

	CDCprintf(fmt, args);
	CDCprintf("\n\r");
}

// CDC.getKey
u8 CDCgetkey()
{
	u8 buffer[64];		// always get a full packet

	while (!CDCgets(buffer));
	return (buffer[0]);	// return only the first character
}

// CDC.getString
u8 * CDCgetstring(void)
{
	u8 c, i = 0;
	static u8 buffer[80];
	
	do {
		c = CDCgetkey();
		CDCprintf("%c", c);
		buffer[i++] = c;
	} while (c != '\r');
	buffer[i] = '\0';
	return buffer;
}

#endif
