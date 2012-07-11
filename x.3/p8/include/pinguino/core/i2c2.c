/*	----------------------------------------------------------------------------
	FILE:			i2c2.c
	PROJECT:		pinguino
	PURPOSE:		Include all functions to handle I2C communication for Master and Slave
	PROGRAMER:		Régis Blanchot, Jean-Pierre Mandon, Jesús Carmona Esteban & Rafael Salazar
	VERSION:		1.0
	FIRST RELEASE:	18 jun. 2012
	LAST RELEASE:	18 jun. 2012
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

#ifndef __I2C2_C
#define __I2C2_C

#define __I2C2__

#include <typedef.h>
#include <macro.h>
#include <const.h>
#include <pinguinoi2c.c>

/// PROTOTYPES

// high-level functions
void I2C2_master(u16);   
void I2C2_slave(u16);   
void I2C2_init(u8, u16);
u8 I2C2_write(u8, u8 *, u8);
u8 I2C2_read(u8, u8 *, u8);
u8 I2C2_send(u8, u8);
u8 I2C2_get(u8);
void I2C2_sendID(u16, u8);

// low-level function
u8 I2C2_writechar(u8);
u8 I2C2_readchar();
u8 I2C2_waitAck();
void I2C2_wait();
void I2C2_start();
void I2C2_stop();
void I2C2_restart();
void I2C2_sendNack();
void I2C2_sendAck();

/*	----------------------------------------------------------------------------
	---------- Initialitation Functions for Master and Slave
	--------------------------------------------------------------------------*/

void I2C2_master(u16 speed)   
{
	I2C_init(I2C2, I2C_MASTER_MODE, speed);
}

void I2C2_slave(u16 DeviceID)   
{
	I2C_init(I2C2, I2C_SLAVE_MODE, DeviceID);
}

/*	----------------------------------------------------------------------------
	---------- Open the I2C bus
	--------------------------------------------------------------------------*/

void I2C2_init(u8 mode, u16 sora)
{
    I2C_init(I2C2, mode, sora);
}

/*	----------------------------------------------------------------------------
	---------- Send x bytes to the slave
	--------------------------------------------------------------------------*/

u8 I2C2_write(u8 address, u8 *buffer, u8 length)
{
    return I2C_write(I2C2, address, buffer, length);
}

/*	----------------------------------------------------------------------------
	---------- Get x bytes from the slave
	--------------------------------------------------------------------------*/

u8 I2C2_read(u8 address, u8 *buffer, u8 length)
{
    return I2C_read(I2C2, address, buffer, length);
}

/*	----------------------------------------------------------------------------
	---------- Send 1 byte to slave
	--------------------------------------------------------------------------*/

u8 I2C2_send(u8 address, u8 byte)
{
    return I2C_send(I2C2, address, byte);
}

/*	----------------------------------------------------------------------------
	---------- Get 1 byte from slave
	--------------------------------------------------------------------------*/

u8 I2C2_get(u8 address)
{
    return I2C_get(I2C2, address);
}

/*	----------------------------------------------------------------------------
	---------- Send the start, device address and r_w command
	--------------------------------------------------------------------------*/

void I2C2_sendID(u16 DeviceID, u8 rw)
{         
    I2C_sendID(I2C2, DeviceID, rw);
}

/*	----------------------------------------------------------------------------
	---------- Send byte and return ack bit
	--------------------------------------------------------------------------*/

u8 I2C2_writechar(u8 b)
{
    return I2C_writechar(I2C2, b);
}

/*	----------------------------------------------------------------------------
	---------- Get a byte from the slave
	--------------------------------------------------------------------------*/

u8 I2C2_readchar()
{
    return I2C_readchar(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Wait for the module to finish it's last action
	--------------------------------------------------------------------------*/

void I2C2_wait()
{
    I2C_wait(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- I2C_ start bit
	--------------------------------------------------------------------------*/

void I2C2_start()
{
    I2C_start(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	--------------------------------------------------------------------------*/

void I2C2_stop()
{
    I2C_stop(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	--------------------------------------------------------------------------*/

void I2C2_restart()
{
    I2C_restart(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Wait for Acknowledge (Ack) from the slave
	--------------------------------------------------------------------------*/

u8 I2C2_waitAck()
{
    return I2C_waitAck(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Abort reading
	--------------------------------------------------------------------------*/

void I2C2_readAbort()
{
    I2C_readAbort(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Send a Not Acknowledge (NAck) to the slave
	--------------------------------------------------------------------------*/

void I2C2_sendNack()
{
    I2C_sendNack(I2C2);
}

/*	----------------------------------------------------------------------------
	---------- Send an Acknowledge (Ack) to the slave
	--------------------------------------------------------------------------*/

void I2C2_sendAck()
{
    I2C_sendAck(I2C2);
}

#endif
