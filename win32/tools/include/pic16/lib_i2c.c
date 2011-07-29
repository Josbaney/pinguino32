// ------------------------------------------------------------------------------
// I2C LIBRARY FOR PINGUINO 18FX550
// ==============================================================================
// Version: 1.1
// Author:  J.P. Mandon & Jesús Carmona Esteban
// Last modification: 1/2/2011
//
// This library is optimized for Pinguino 18F2550 
// Include all functions to handle I2C communication for Master and Slave.
//
// NOTES: 
//    - First release 2009. JP Mandon
// 
// -----------------------------------------------------------------------------



#ifndef __PINGUINOI2C
#define __PINGUINOI2C

#include <delay.h>
#include <i2c.h>

short i2c_buffer[8];
void *


// -----------------------------------------------
// INITialitation Functions for Master and Slave:
// -----------------------------------------------

void init_Master_I2C()   
{
//at the moment, only 7Bits + Int allowed:
	i2c_open(I2C_MASTER, I2C_SLEW_OFF, 0x77);
	// 0x77 sets Master's I2C Fscl to 100Khz.
  // The formula is SPPADD = (Fosc / (4 x Fscl))-1
  // Fosc in Pinguino is 48 Mhz, so :
	// SPADD = (48 / 0,4)-1 = 120 -1 = 119 = 0x77 (hex)

}

void init_Slave_I2C(short i2c_address)   
{
	// Enabling interrupts
	// enable peripheral interrupt
	INTCONbits.PEIE=1;
	// global enable interrupt
	INTCONbits.GIE=1;
	// opening MSSP as I2C slave, using 7 bits addressing.
  i2c_open(I2C_SLAVE_7B_INT, I2C_SLEW_OFF, i2c_address);   
}

// ----------------------------------------
// Auxiliary functions for this library:
// ---------------------------------------

static char _wait()   // bad name for this function.
{
uchar i=0;

while(PIR1bits.SSPIF == 0) 
	{
         i++;
         if(i==0) return -1;
         }
PIR1bits.SSPIF = 0;
return 0;
}

static char _wait_ack()
{
uchar i=0;

while(SSPCON2bits.ACKSTAT == 1) 
	{
         i++;
         if(i==0) return -1;
         }
return 0;
}

static void _read_abort()
{
SSPCON1bits.WCOL = 0;
I2C_STOP();
_wait();  
}


// -----------------------------------------
// Functions for Master
// -----------------------------------------

short I2C_send(short address,const unsigned char* ic2_message,int i2c_length)
{
// Now this function Starts & Stops transmission itself.
// It is supossed to be used to send something without expecting any answer back.
// In case you expect an answer back from slave use I2C_requestFrom function.
short i=0;    
PIR1bits.SSPIF = 0;  

I2C_START();
// Being sure that line is ready :
if (_wait())
	{
	_read_abort();
	return 0;
	}
// Sending address & 0xFE. This last puts R/W bit to 0, which means (W)rite.
if(i2c_writechar(address<<1)&0xFE) 
	{
	_read_abort();
	return 0;
	}
// Wait for finishing transmision :
if (_wait())  
	{
	_read_abort();
	return 0;
	}
// Wait for ACK from slave :
if (_wait_ack())   
	{
	_read_abort();
	return 0;
	}
delay10ktcy(1);
if (i2c_length>1)
{
for (i=0;i<i2c_length;i++)
	{
        // Writes one char :
	if(i2c_writechar(ic2_message[i])) 
		{
		_read_abort();
		return 0;
		}
        // Waits until transmision complete :
	if (_wait())
		{
		_read_abort();
		return 0;
		}
        // Waits until ACKs from slave :
	if (_wait_ack())
		{
		_read_abort();
		return 0;
		}
        // 
	delay10ktcy(1);
	}
}
// Transmision successfully completed.
return 1;
I2C_STOP();
}

short I2C_requestFrom(short address,const unsigned char* ic2_request_msg,int i2c_rqst_length, unsigned char* i2c_answer_msg, int i2c_answer_length)
{
short i=0;    
PIR1bits.SSPIF = 0;

I2C_START();

if (ic2_request_msg > 0) {
   if (_wait())
	{
	_read_abort();
	return 0;
	}
   if(i2c_writechar(address<<1)&0xFE) 
	{
	_read_abort();
	return 0;
	}
   if (_wait())
	{
	_read_abort();
	return 0;
	}
   if (_wait_ack())
	{
	_read_abort();
	return 0;
	}
   delay10ktcy(1);
   // Transmiting the request message :
   if (i2c_rqst_length>1)
   { 
   for (i=0;i<i2c_rqst_length;i++)
	{
	if(i2c_writechar(ic2_message[i])) 
		{
		_read_abort();
		return 0;
		}
	if (_wait())
		{
		_read_abort();
		return 0;
		}
	if (_wait_ack())
		{
		_read_abort();
		return 0;
		}
	delay10ktcy(1);
	}
   } else if (i2c_rqst_length == 1) {
	if(i2c_writechar(ic2_message[0])) 
		{
		_read_abort();
		return 0;
		}
	if (_wait())
		{
		_read_abort();
		return 0;
		}
	if (_wait_ack())
		{
		_read_abort();
		return 0;
		}
	delay10ktcy(1);
   }
   // Restart : 
   i2c_restart();
}  // In case no message to send, all this block previous block will be skipped.

// Sending of the i2c device address once more for reading:
if (_wait())
	{
	_read_abort();
	return 0;
	}	
// Bit R/W is set to 1, which means (R)ead.
if(i2c_writechar((address<<1)+1)) 
	{
	_read_abort();
	return 0;
	}
if (_wait())
	{
	_read_abort();
	return 0;
	}
if (_wait_ack())
	{
	_read_abort();
	return 0;
	}
delay10ktcy(1);
// Reading the slave transmision:
if (i2c_answer_length>1)
{
for (i=0;i<i2c_answer_length-1;i++)
	{
	// i2c_buffer[i]=i2c_readchar();
        i2c_answer_msg[i]=i2c_readchar();
        // Waits until reception completed:
	if (_wait())
		{
		_read_abort();
		return 0;
		}
        // Sends an ACK for the byte received:
	i2c_ack();
        // Waits until ACK transmision completed:
	if (_wait())
		{
		_read_abort();
		return 0 ;
		}
	delay10ktcy(1);	
	}
}
// Receiving the last byte	
i2c_answer_msg[i]=i2c_readchar();	
// Wait until last byte reception is completed:
if (_wait())
	{
	_read_abort();
	return 0;
	}
// Sends a NACK for indicating whole reception is completed:
i2c_nack();
// Stops transmision.
I2C_STOP();
if (_wait())
	{
	_read_abort();
	return 0;
	}

// End of request. 
return 1;
}


// -----------------------------------------
// Functions for Slave
// -----------------------------------------

// Interrupt handler for I2C slave: 
void I2C_interrupt()
{
	PIR1bits.SSPIF = 0;
	if (SSPSTATbits.R_W) {
		_i2c_onRequest_function();
	} else {
		_i2c_onReceive_function();
	}

}


void I2C_onRequest(void (*RqstFunct_pointer)(void))
{
	_i2c_onRequest_function = RqstFunct_pointer;
}


void IC2_OnReceive(void (*RcvFunct_pointer)(void))
{
	_i2c_onReceive_function = RcvFunct_pointer;
}


short I2C_send(const unsigned char* send_string,int i2c_length)
{
		i2c_writechar(send_string[i2c_lengh]);

short I2C_receive(const unsigned char* received_string,int i2c_length)
{
short i=0;

I2C_IDLE();
I2C_START();
if (_wait())
	{
	_read_abort();
	return 0;
	}	
if(i2c_writechar((address<<1)+1)) 
	{
	_read_abort();
	return 0;
	}
if (_wait())
	{
	_read_abort();
	return 0;
	}
if (_wait_ack())
	{
	_read_abort();
	return 0;
	}
delay10ktcy(1);
if (i2c_length>1)
{	
for (i=0;i<i2c_length-1;i++)
	{
	i2c_buffer[i]=i2c_readchar();
	if (_wait())
		{
		_read_abort();
		return 0;
		}
	i2c_ack();
	if (_wait())
		{
		_read_abort();
		return 0 ;
		}
	delay10ktcy(1);	
	}
}	
i2c_buffer[i]=i2c_readchar();	
if (_wait())
	{
	_read_abort();
	return 0;
	}
i2c_nack();
I2C_STOP();
if (_wait())
	{
	_read_abort();
	return 0;
	}
return 1;
}
#endif
