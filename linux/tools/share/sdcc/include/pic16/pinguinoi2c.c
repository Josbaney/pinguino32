/*	----------------------------------------------------------------------------
	FILE:				pinguinoi2c.c
	PROJECT:			pinguino (This library is optimized for Pinguino 18F2550)
	PURPOSE:			Include all functions to handle I2C communication for Master and Slave
	PROGRAMER:		Jean-Pierre Mandon, Jesús Carmona Esteban, Regis Blanchot & Rafael Salazar
	VERSION:			1.1
	FIRST RELEASE:	03 apr. 2010
	LAST RELEASE:	17 mar. 2011
	----------------------------------------------------------------------------
	TODO : Arduino Compatibility

	begin() initializes pinguino as an I2C master
	begin(address) initializes pinguino as a slave at address address. 
	=> I2C.master I2C_master#include <pinguinoi2c.c>
	=> I2C.slave I2C_slave#include <pinguinoi2c.c>

		void beginTransmission(uint8_t);
		void beginTransmission(int);

		uint8_t endTransmission(void);

		uint8_t requestFrom(uint8_t, uint8_t);
		uint8_t requestFrom(int, int);

		void send(uint8_t);
		void send(uint8_t*, uint8_t);
		void send(int);
		void send(char*);

		uint8_t available(void);
		uint8_t receive(void);
		void onReceive( void (*)(int) );
		void onRequest( void (*)(void) );
	----------------------------------------------------------------------------
	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
	--------------------------------------------------------------------------*/

#ifndef __PINGUINO_I2C_C
	#define __PINGUINO_I2C_C

	#define __I2C__

	#include <pic18fregs.h>
	#include "const.h"
	#include "macro.h"
	//#include "typedef.h"
	#include <interrupt.c>

	// Mode I2C
	#define I2C_WRITE			0
	#define I2C_READ			1
	#define I2C_MASTER_MODE	0
	#define I2C_SLAVE_MODE	1
	#define I2C_SLEW_OFF		0
	#define I2C_SLEW_ON		1

	typedef void (*stdout) (void);			// type of :	void foo(int x)
	static stdout _i2c_onRequest_function;	// then : 		void pputchar(void)
	static stdout _i2c_onReceive_function;	// then : 		void pputchar(void)

	/// PROTOTYPES

	void I2C_master();   
	void I2C_slave(u16);   
	void I2C_init(u8, u16);
	void I2C_interrupt();
	//void I2C_OnRequest(void (*)(void));
	//void IC2_OnReceive(void (*)(void));
	u8 I2C_writechar(u8);
	u8 I2C_readchar();
	u8 I2C_send(u8, u8);
	u8 I2C_get(u8);
	static void I2C_wait();
	static void I2C_start();
	static void I2C_stop();
	static void I2C_restart();
	static void I2C_sendNack();
	static void I2C_sendAck();
	static void I2C_sendID(u16, u8);

/*	----------------------------------------------------------------------------
	---------- Initialitation Functions for Master and Slave
	--------------------------------------------------------------------------*/

void I2C_master()   
{
	I2C_init(I2C_MASTER_MODE, I2C_SLEW_OFF);
}

void I2C_slave(u16 DeviceID)   
{
	I2C_init(I2C_SLAVE_MODE, DeviceID);
}

/*	----------------------------------------------------------------------------
	---------- Open the I2C bus
	----------------------------------------------------------------------------
	SSPSTAT.SMP: Slew Rate Control bit
	In Master or Slave mode:
	1 = Slew Mode Off = Standard Speed mode (100 kHz and 1 MHz)
	0 = Slew Mode On = High-Speed mode (400 kHz)
	RB0 = SDA
	RB1 = SCL
	--------------------------------------------------------------------------*/

void I2C_init(u8 mode, u16 sspadd)
{
	// In Slave mode, the SCL and SDA pins must be configured as inputs
	TRISBbits.TRISB0 = INPUT;			// SDA = INPUT
	TRISBbits.TRISB1 = INPUT;			// SCL = INPUT
	switch (mode)
	{
		case I2C_SLAVE_MODE:
			intUsed[INT_SSP] = INT_USED;
			// Enabling interrupts (peripheral & general)
			INTCONbits.PEIE=1;
			INTCONbits.GIE=1;
			SSPCON1 = 0b00101110;		// Slave mode,  7-bit address with Start and Stop bit interrupts enabled
			//SSPCON1 = 0b00101111;		// Slave mode, 10-bit address with Start and Stop bit interrupts enabled
/*	---------------------------------------------------------------------------*/
			SSPADD = sspadd;				// Slave 7-bit address
			// TODO							// Slave 10-bit address
/*	---------------------------------------------------------------------------*/
			break;
		default:// I2C_MASTER_MODE
			SSPCON1 = 0b00101000;		// Master Mode, clock = FOSC/(4 * (SSPADD + 1))
			switch (sspadd)
			{
				case I2C_SLEW_ON:
					SSPSTAT = 0b00000000;		// Slew Mode On
					SSPADD = 119;					// 100kHz = FOSC/(4 * (SSPADD + 1))
					//SSPADD = 11;					// 1MHz = FOSC/(4 * (SSPADD + 1))
				default:
					SSPSTAT = 0b10000000;		// Slew Mode Off
					SSPADD = 29;					// 400kHz = FOSC/(4 * (SSPADD + 1))
			}
	}
	SSPCON2 = 0;
	PIR1bits.SSPIF = 0;
	PIR2bits.BCLIF = 0;
}

/*	----------------------------------------------------------------------------
	---------- OnRequest
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_OnRequest(stdout func)
{
	_i2c_onRequest_function = func;
}

/*	----------------------------------------------------------------------------
	---------- OnReceive
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void IC2_OnReceive(stdout func)
{
	_i2c_onReceive_function = func;
}

/*	----------------------------------------------------------------------------
	---------- Interrupt handler for I2C slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_interrupt()
{
	if (PIR1bits.SSPIF)
	{
		PIR1bits.SSPIF = 0;
		if (SSPSTATbits.R_W)
			_i2c_onRequest_function();
		else
			_i2c_onReceive_function();
	}
}

/*	----------------------------------------------------------------------------
	---------- Send a byte to slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

u8 I2C_send(u8 address, u8 byte)
{
	I2C_sendID(address, I2C_WRITE);
	//if (I2C_writechar(address >> 8) == 0) return(0);
	//if (I2C_writechar(address & 0xff) == 0) return(0);
	if (I2C_writechar(byte) == 0) return (0);
	I2C_stop();
	return (1);
}

/*	----------------------------------------------------------------------------
	---------- Get a byte from slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

u8 I2C_get(u8 address)
{
	u8 byte;

	I2C_sendID(address, I2C_READ);
	//if (I2C_writechar(address >> 8) == 0) return(0);
	//if (I2C_writechar(address & 0xff) == 0) return(0);
	I2C_restart();
	if (I2C_writechar(address) == 0) return (0);
	byte = I2C_readchar();
	I2C_sendNack();
	I2C_stop();
	return (byte);
}

/*	----------------------------------------------------------------------------
	---------- Wait for the module to finish it's last action
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_wait()
{
	while (PIR1bits.SSPIF == 0);
	PIR1bits.SSPIF = 0;
}

/*	----------------------------------------------------------------------------
	---------- I2C_ start bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_start()
{
	SSPCON2bits.SEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_stop()
{
	SSPCON2bits.PEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_restart()
{
	SSPCON2bits.RSEN=1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send byte and return ack bit
	----------------------------------------------------------------------------
	1 = Ack
	0 = NAck
	--------------------------------------------------------------------------*/

u8 I2C_writechar(u8 byte)
{
	SSPBUF = byte;
	I2C_wait();
	return (!SSPCON2bits.ACKSTAT);
}

/*	----------------------------------------------------------------------------
	---------- Get a byte from the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

u8 I2C_readchar()
{
	SSPCON2bits.RCEN = 1;
	I2C_wait();
	return (SSPBUF);
}

/*	----------------------------------------------------------------------------
	---------- Wait for Acknowledge (Ack) from the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static u8 I2C_waitAck()
{
	u8 i=0;
	while(SSPCON2bits.ACKSTAT == 1) 
	{
		i++;
		if(i==0) return -1;
	}
	return 0;
}

/*	----------------------------------------------------------------------------
	---------- Abort reading
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_readAbort()
{
	SSPCON1bits.WCOL = 0;
	I2C_stop();
	I2C_wait();  
}

/*	----------------------------------------------------------------------------
	---------- Send a Not Acknowledge (NAck) to the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_sendNack()
{
	SSPCON2bits.ACKDT = 1;
	SSPCON2bits.ACKEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send an Acknowledge (Ack) to the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

static void I2C_sendAck()
{
	SSPCON2bits.ACKDT = 0;
	SSPCON2bits.ACKEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send the start and device address
	----------------------------------------------------------------------------
	If the device is busy then it resends until accepted
	--------------------------------------------------------------------------*/

/*
void I2C_sendID(u8 DeviceID)
{
	I2C_start();
	if (I2C_writechar(byte) != 1)
	{
		do {
			I2C_restart();
		} while (I2C_writechar(byte) != 1);
	}
}
*/
 
/*	----------------------------------------------------------------------------
	---------- Send the start, device address and r_w command
	----------------------------------------------------------------------------
	author : Rafael Salazar
	For 7 bits address Device:
		Divice address Format = 0 A6 A5 A4 A3 A2 A1 A0
		were: A6:A0 7 bits Device address,
	For 10 bits address Device:                
		Divice address Format = 1 1 1 1 0 0 A9 A8 A7 A6 A5 A4 A3 A2 A1 A0
		were: A9:A0 are Device address,
	r_w			read (1) or write (0) parameter
	----------------------------------------------------------------------------
	If the device is busy then it resends until accepted
	--------------------------------------------------------------------------*/

static void I2C_sendID(u16 DeviceID, u8 r_w)
{         
	u8 temp;

	if (DeviceID > 0x00FF)
	{         
		temp = (DeviceID >> 7) & 0x06;	// set A9 and A8 to temp.bit2 and temp.bit1
		temp = temp | 0xF0 | r_w;			// set DeviceID address Hi format = 11110(A9A8)(R/W)
		I2C_start();
		if (I2C_writechar(temp) != 1)
		{
			do {
				I2C_restart();
			} while ( I2C_writechar(temp) != 1);
			temp = (DeviceID << 1 & 0xFE) | r_w;
			I2C_writechar(temp);
		}
	}
	else
	{         
		temp = DeviceID << 1 & 0xFE;
		temp = temp | r_w;
		I2C_start();
		if (I2C_writechar(temp) != 1)
		{
			do {
				I2C_restart();
			} while (I2C_writechar(temp) != 1);
		}
	}
}

#endif

