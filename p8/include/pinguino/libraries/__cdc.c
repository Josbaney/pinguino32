// cdc module for Pinguino - Jean-Pierre Mandon 2010
// printf, println, print, write, getKey, getString - Régis Blanchot 2011

#ifndef __USBCDC
#define __USBCDC

#define USB_USE_CDC

#include <usb/usb_cdc.h>
#include <usb/usb_config.c>
#include <usb/picUSB.c>
#include <usb/usb_cdc.c>
#include <delay.c>
#include <stdio.c>
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
void CDCwrite(char c)
{
	CDCputs(c, 1);
}

// CDC.printf
void CDCprintf(char *fmt, ...)
{
	static char buffer[80];
	u8 length;
	va_list args;

	va_start(args, fmt);
	length = psprintf(buffer, fmt, args);
	CDCputs(buffer,length);
	va_end(args);
}

//CDC.println
void CDCprintln(char *fmt,...)
{
	CDCprintf(fmt);
	CDCprintf("\n\r");
}

// CDC.print
void CDCprint(char *fmt,...)
{
	va_list ap;
	unsigned char *s;							// must be unsigned char !!!

	va_start(ap,fmt);
	s = va_start(ap,fmt);

	switch (*s)
	{
		case DEC:
			CDCprintf("%d",fmt);
			break;
		case HEX:
			CDCprintf("%x",fmt);
			break;
		case BYTE:
			CDCprintf("%d",fmt);
			break;
		case OCT:
			CDCprintf("%o",fmt);
			break;
		case BIN:
			CDCprintf("%b",fmt);
			break;           
		default:
			CDCprintf(fmt);
			break;
	}

	va_end(ap);
}

/*
// CDC.getKey
char * CDCgetkey()
{
	char c, rc;

	rc = CDCgets(c, 1);
	return (rc);
}

// CDC.getString
char * CDCgetstring()
{
	u8 i = 0;
	char c;
	static char buffer[80];
	
	do {
		c = CDCgetkey();
		CDCprintf("%c", c);
		buffer[i++] = c;
	} while (c != '\r');
	buffer[i] = '\0';
	return (buffer);
}
*/
#endif
