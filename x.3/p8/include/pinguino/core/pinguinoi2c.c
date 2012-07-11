/*	----------------------------------------------------------------------------
	FILE:			pinguinoi2c.c
	PROJECT:		pinguino
	PURPOSE:		Include all functions to handle I2C communication for Master and Slave
	PROGRAMER:		Régis Blanchot, Jean-Pierre Mandon, Jesús Carmona Esteban & Rafael Salazar
	VERSION:		1.1
	FIRST RELEASE:	03 apr. 2010
	LAST RELEASE:	18 jun. 2012
	----------------------------------------------------------------------------
	TODO : Arduino Compatibility ???

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
#include <typedef.h>
#include <macro.h>
#include <const.h>
//#include <interrupt.c>
//#include <stdio.c>
//#include <stdarg.h>

// Modules
#define I2C1            1
#define I2C2            2

// Mode I2C
#define I2C_WRITE		0
#define I2C_READ		1
#define I2C_MASTER_MODE	0
#define I2C_SLAVE_MODE	1
#define I2C_SLEW_OFF	0
#define I2C_SLEW_ON		1

// Speed definitions
#define I2C_100KHZ		0
#define I2C_400KHZ		1
#define I2C_1MHZ		2

//typedef void (*i2c_stdout) (void);	// type of :	void foo(int x)
//i2c_stdout _i2c_onRequest_function;	// then : 		void pputchar(void)
//i2c_stdout _i2c_onReceive_function;	// then : 		void pputchar(void)

/// PROTOTYPES

// high-level functions
void I2C_master(u16);   
void I2C_slave(u16);   
void I2C_init(u8, u16);
//void I2C_printf(u8, u8 *, ...);
u8 I2C_write(u16, u8 *, u8);
u8 I2C_read(u16, u8 *, u8);
u8 I2C_send(u16, u8);
u8 I2C_get(u16);
u8 I2C_sendID(u16, u8);

// low-level functions
u8 I2C_writechar(u8);
u8 I2C_readchar(u8);
void I2C_wait();
void I2C_start();
void I2C_stop();
void I2C_restart();
void I2C_sendNack();
void I2C_sendAck();
//u8 I2C_waitAck();
//void I2C_readAbort();
//void I2C_interrupt();
//void I2C_OnRequest(void (*)(void));       // TODO : move to interrupt.c ?
//void IC2_OnReceive(void (*)(void));

/*	----------------------------------------------------------------------------
	---------- Initialisation Functions for Master and Slave
	--------------------------------------------------------------------------*/

void I2C_master(u16 speed)   
{
	I2C_init(I2C_MASTER_MODE, speed);
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
	--------------------------------------------------------------------------*/

void I2C_init(u8 mode, u16 sora)
{
    // In Slave mode, the SCL and SDA pins must be configured as inputs
    #if defined(PIC18F26J50)
    TRISBbits.TRISB5 = INPUT;			// SDA = INPUT
    TRISBbits.TRISB4 = INPUT;			// SCL = INPUT
    #else
    TRISBbits.TRISB0 = INPUT;			// SDA = INPUT
    TRISBbits.TRISB1 = INPUT;			// SCL = INPUT
    #endif

    switch (mode)
    {
        case I2C_SLAVE_MODE:
            //intUsed[INT_SSP] = INT_USED;
            // Enabling interrupts (peripheral & general)
            //INTCONbits.PEIE=1;
            //INTCONbits.GIE=1;
            SSPCON1 = 0b00101110;		// Slave mode,  7-bit address with Start and Stop bit interrupts enabled
            //SSPCON1 = 0b00101111;		// Slave mode, 10-bit address with Start and Stop bit interrupts enabled
    /*	---------------------------------------------------------------------------*/
            SSPADD = sora;				// Slave 7-bit address
            // TODO						// Slave 10-bit address
    /*	---------------------------------------------------------------------------*/
            break;

        case I2C_MASTER_MODE:
        default:// I2C_MASTER_MODE
            SSPCON1 = 0b00101000;		// Master Mode, clock = FOSC/(4 * (SSPADD + 1))
            // datasheet p208
            switch (sora)
            {
                case I2C_1MHZ:
                    // SMP = 1 = Slew rate control disabled for Standard Speed mode (100 kHz and 1 MHz)
                    SSPSTATbits.SMP = 1;		// Slew Mode Off
                    SSPADD = 11;				// 1MHz = FOSC/(4 * (SSPADD + 1))
                    break;
                    
                case I2C_400KHZ:
                    // SMP = 0 = Slew rate control enabled for High-Speed mode (400 kHz)
                    SSPSTATbits.SMP = 0;		// Slew Mode On
                    SSPADD = 29;				// 400kHz = FOSC/(4 * (SSPADD + 1))
                    break;
                    
                case I2C_100KHZ:
                default:
                    // SMP = 1 = Slew rate control disabled for Standard Speed mode (100 kHz and 1 MHz)
                    SSPSTATbits.SMP = 1;		// Slew Mode Off
                    SSPADD = 119;				// 100kHz = FOSC/(4 * (SSPADD + 1))
                    break;
            }
            break;
    }
    //SSPCON2 = 0;
    PIR1bits.SSPIF = 0;
    PIR2bits.BCLIF = 0;
}

/*	----------------------------------------------------------------------------
	---------- Send a formated string to the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/
/*
void I2C_printf(u16 address, u8 *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	I2C_start();
	I2C_sendID(address, I2C_WRITE);
	pprintf(I2C_writechar, fmt, args);
	I2C_sendAck();
	I2C_stop();
	va_end(args);
}
*/
/*	----------------------------------------------------------------------------
	---------- Send x bytes to the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

u8 I2C_write(u16 address, u8 *buffer, u8 length)
{
    u8 i;
    
	I2C_start();
	I2C_sendID(address, I2C_WRITE);
    for (i=0; i<length; i++)
    {
        if (!I2C_writechar(buffer[i]))
            return 0;
    }
	I2C_stop();
	return (1);
}

/*	----------------------------------------------------------------------------
	---------- Send 1 byte to slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

u8 I2C_send(u16 address, u8 value)
{
	u8 r = 0;
	
	I2C_start();
	if (I2C_sendID(address, I2C_WRITE) == 1)
		r = I2C_writechar(value);
	I2C_stop();
	return r;
}

/*	----------------------------------------------------------------------------
	---------- Send byte and return ack bit
	----------------------------------------------------------------------------
	Serial data is transmitted eight bits at a time. After each byte is
	transmitted, an Acknowledge bit is received. Start and Stop conditions are
	output to indicate the beginning and the end of a serial transfer.
	1 = Ack
	0 = NAck
	--------------------------------------------------------------------------*/

u8 I2C_writechar(u8 value)
{
    SSPBUF = value;
    I2C_wait();
    return (!SSPCON2bits.ACKSTAT);
}

/*	----------------------------------------------------------------------------
	---------- Get x bytes from the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

u8 I2C_read(u16 address, u8 *buffer, u8 length)
{
    u8 i;
    
	I2C_start();
	I2C_sendID(address, I2C_WRITE);
    for (i=0; i<length; i++)
    {
         if (i<(length-1))
            buffer[i] = I2C_readchar(0);    // ACK all but last byte
         else
            buffer[i] = I2C_readchar(1);    // NACK last byte
    }
	I2C_stop();
	return (1);
}

/*	----------------------------------------------------------------------------
	---------- Get 1 byte from slave
	----------------------------------------------------------------------------
    - Condition de départ
    - Emission de l'adresse esclave, soit de L'EEPROM, avec une demande d'écriture
    - Acquittement de la part de l'esclave et condition de stop (Restart est possible)
    - Condition de départ
    - Emission de l'adresse esclave, soit de L'EEPROM, avec une demande de lecture, cette fois le composant confirme l'ordre et les données sont envoyées. La lecture peut se faire par bloc, dans ce cas il faut confirmer chaque donnée lu par un ACK, puis avant la condition de stop, envoyé un NACK.
    - Condition de stop
	--------------------------------------------------------------------------*/

u8 I2C_get(u16 address)
{
	u8 value = 0;

	I2C_start();
	if(I2C_sendID(address, I2C_READ) == 1)
		value = I2C_readchar(true);
	I2C_stop();
	return (value);
}

/*	----------------------------------------------------------------------------
	---------- Get a byte from the slave
	----------------------------------------------------------------------------
    RCEN = Receive Enable bit
	--------------------------------------------------------------------------*/

u8 I2C_readchar(u8 ack)
{
    u8 value;
    
    //I2C_wait();
    SSPCON2bits.RCEN = 1;
    I2C_wait();

    value = SSPBUF;
    I2C_wait();

    if (ack)
        I2C_sendAck();
    else
        I2C_sendNack();
    return value;
}

/*	----------------------------------------------------------------------------
	---------- Send the start, device address and r_w command
	----------------------------------------------------------------------------
	In Master Transmitter mode, the first byte transmitted contains the slave
	address of the receiving device (seven bits) and the Read/Write (R/W)
	bit.
	----------------------------------------------------------------------------
	author : Rafael Salazar
	For 7 bits address Device:
		Device address Format = 0 A6 A5 A4 A3 A2 A1 A0
		were: A6:A0 7 bits Device address,
	For 10 bits address Device:                
		Device address Format = 1 1 1 1 0 0 A9 A8 A7 A6 A5 A4 A3 A2 A1 A0
		were: A9:A0 are Device address,
	rw
		I2C_READ (1) or I2C_WRITE (0) parameter
	
    NB: DeviceID is sent until slave return an Ack bit
	--------------------------------------------------------------------------*/

u8 I2C_sendID(u16 DeviceID, u8 rw)
{         
	u8 hi_byte, lo_byte, value = 0;

	// 10-bit address
    if (DeviceID > 0x00FF)
    {         
        hi_byte = (DeviceID >> 7) & 0x06;       // set hi_byte.2 & hi_byte.1 to A9 & A8 
        hi_byte = hi_byte | 0xF0 | 0;			// set hi_byte of 10 bit address 
                                                // format = 11110(A9)(A8)(R/W=0)
        if (I2C_writechar(hi_byte) == 1)        // if first byte acknowledged
        {
            lo_byte = (DeviceID & 0xFF);        // second byte = A7-A0
            if (I2C_writechar(lo_byte) == 1)    // send second byte
            {
                if (rw)                         // if read required
                {
                    I2C_restart();              // resend hi-byte with R/W = 1
                    return (I2C_writechar(hi_byte | 1));
                }
                else
                {
                    return 1;
                }
            }
            else
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }

	// 7-bit address
    else
    {         
        value = (DeviceID & 0xFF) | rw;
        return I2C_writechar(value);
    }

/*
    u8 temp;

	// 10-bit address
	if (DeviceID > 0x00FF)
	{         
		temp = (DeviceID >> 7) & 0x06;	// set A9 and A8 to temp.bit2 and temp.bit1
		temp = temp | 0xF0 | rw;		// set DeviceID address Hi format = 11110(A9A8)(R/W)
		if (I2C_writechar(temp) != 1)
		{
			do {
				I2C_restart();
			} while (I2C_writechar(temp) != 1);
			temp = (DeviceID << 1 & 0xFE) | rw;
			I2C_writechar(temp);
		}
	}
    
	// 7-bit address
	else
	{         
		temp = DeviceID;
		temp = temp | rw;               // bit 0 commands read or write mode
		if (I2C_writechar(temp) != 1)
		{
			do {
				I2C_restart();
			} while (I2C_writechar(temp) != 1);
		}
	}
*/
}

/*	----------------------------------------------------------------------------
	---------- Wait for the  to finish its last action
	----------------------------------------------------------------------------
    Application note AN245 page 5, Note 1:
    The master needs to wait for I2C bus idle to indicate that the MSSP
     has finished its last task. The SSPIF interrupt could be used
    instead of the wait for idle.

    The following events will cause the MSSP Interrupt Flag bit, SSPxIF, to be set:
    - Start condition
    - Stop condition
    - Repeated Start
    - Data transfer byte transmitted/received
    - Acknowledge transmitted
	--------------------------------------------------------------------------*/

void I2C_wait()
{
    while (PIR1bits.SSPIF == 0);
    PIR1bits.SSPIF = 0;
}

/*	----------------------------------------------------------------------------
	---------- I2C_ start bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_start()
{
    SSPCON2bits.SEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_stop()
{
    SSPCON2bits.PEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_restart()
{
    SSPCON2bits.RSEN=1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send a Not Acknowledge (NAck) to the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_sendNack()
{
    SSPCON2bits.ACKDT = 1;
    SSPCON2bits.ACKEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Send an Acknowledge (Ack) to the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C_sendAck()
{
    SSPCON2bits.ACKDT = 0;
    SSPCON2bits.ACKEN = 1;
	I2C_wait();
}

/*	----------------------------------------------------------------------------
	---------- Wait for Acknowledge (Ack) from the slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/
/*
u8 I2C_waitAck()
{
	u8 i=0;

    while(SSPCON2bits.ACKSTAT == 1) 
    {
        i++;
        if(i==0) return -1;
    }

	return 0;
}
*/
/*	----------------------------------------------------------------------------
	---------- Abort reading
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/
/*
void I2C_readAbort()
{
    SSPCON1bits.WCOL = 0;
	I2C_stop();
	I2C_wait();  
}
*/
#endif


//
//  TODO: move the following to interrupt.c ?
//



/*	----------------------------------------------------------------------------
	---------- OnRequest
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/
/*
void I2C_OnRequest(i2c_stdout func)
{
	_i2c_onRequest_function = func;
}
*/
/*	----------------------------------------------------------------------------
	---------- OnReceive
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/
/*
void I2C_OnReceive(i2c_stdout func)
{
	_i2c_onReceive_function = func;
}
*/
/*	----------------------------------------------------------------------------
	---------- Interrupt handler for I2C slave
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/
/*
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
*/
