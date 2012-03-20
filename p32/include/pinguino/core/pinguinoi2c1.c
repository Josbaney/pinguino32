/*	----------------------------------------------------------------------------
	FILE:				pinguinoi2c1.c
	PROJECT:			pinguino
	PURPOSE:			I2C1 functions
	PROGRAMER:			regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:		11 apr. 2011
	LAST RELEASE:		25 feb. 2012
	----------------------------------------------------------------------------
	TODO :
	----------------------------------------------------------------------------
	CHANGELOG :
		13 may. 2011 I2C_init default mode is master 400 khz jp.mandon@gmail.com
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

#ifndef __PINGUINOI2C1_C
#define __PINGUINOI2C1_C

#include <typedef.h>
#include <const.h>
#include <macro.h>
#include <system.c>
#include <i2c.c>

	/// PROTOTYPES

void I2C1_init();
u8 I2C1_send(u16, u8);
u8 I2C1_get(u16);
void I2C1_sendID(u16, u8);
u8 I2C1_writechar(u8);
u8 I2C1_readchar();
void I2C1_wait();
void I2C1_start();
void I2C1_stop();
void I2C1_restart();
void I2C1_sendNack();
void I2C1_sendAck();

/*	----------------------------------------------------------------------------
	---------- Open the I2C bus
	--------------------------------------------------------------------------*/

void I2C1_init()
{
	I2C_init(I2C1, I2C_MASTER_MODE, I2C_SLEW_OFF);
}

/*	----------------------------------------------------------------------------
	---------- Send a byte to the slave
	--------------------------------------------------------------------------*/

u8 I2C1_send(u16 adress, u8 byte)
{
	return I2C_send(I2C1, adress, byte);
}

/*	----------------------------------------------------------------------------
	---------- Get a byte from slave
	--------------------------------------------------------------------------*/

u8 I2C1_get(u16 adress)
{
	return I2C_get(I2C1, adress);
}

/*	----------------------------------------------------------------------------
	---------- Send the start condition, device address and r/w indication
	--------------------------------------------------------------------------*/

void I2C1_sendID(u16 DeviceID, u8 rw)
{         
	I2C_sendID(I2C1, DeviceID, rw);
}

/*	----------------------------------------------------------------------------
	---------- Send byte and return ack bit
	--------------------------------------------------------------------------*/

u8 I2C1_writechar(u8 byte)
{
	return I2C_writechar(I2C1, byte);
}

/*	----------------------------------------------------------------------------
	---------- Get a byte from the slave
	--------------------------------------------------------------------------*/

u8 I2C1_readchar()
{
	return I2C_readchar(I2C1);
}

/*	----------------------------------------------------------------------------
	---------- Wait for the module to finish it's last action
	--------------------------------------------------------------------------*/

void I2C1_wait()
{
	I2C_wait(I2C1);
}

/*	----------------------------------------------------------------------------
	---------- I2C_ start bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C1_start()
{
	I2C_start(I2C1);
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C1_stop()
{
	I2C_stop(I2C1);
}

/*	----------------------------------------------------------------------------
	---------- Send stop bit
	----------------------------------------------------------------------------
	--------------------------------------------------------------------------*/

void I2C1_restart()
{
	I2C_restart(I2C1);
}

/*	----------------------------------------------------------------------------
	---------- Send a Not Acknowledge (NAck) to the slave
	--------------------------------------------------------------------------*/

void I2C1_sendNack()
{
	I2C_sendNack(I2C1);
}

/*	----------------------------------------------------------------------------
	---------- Send an Acknowledge (Ack) to the slave
	--------------------------------------------------------------------------*/

void I2C1_sendAck()
{
	I2C_sendAck(I2C1);
}

#endif	/* __PINGUINOI2C_C */

