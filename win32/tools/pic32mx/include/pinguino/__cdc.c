// cdc module for Pinguino32X
// Jean-Pierre Mandon 2010
// Based on the Microchip USB stack

#ifndef __USBCDC
#define __USBCDC

#include <system.c>
#include <interrupt.c>
#include <delay.c>

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
IntEnable(INT_USB, INT_ENABLED);
}

// this is the Set Line coding CallBack function
 
void mySetLineCodingHandler()
{
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

// this function is called by the main32.c file

void init_CDC()
{
	USBDeviceInit();
	USBDeviceAttach();
	Delayms(1000);
}

// CDC puts function

void CDCputs(char *buffer, byte length)
{
	putUSBUSART(buffer,length);
	CDCTxService();
}
	
byte CDCgets(char *buffer)
{
	unsigned char receivedchar;
	
	receivedchar=getsUSBUSART(buffer, 64);
	return receivedchar;
}

#endif
