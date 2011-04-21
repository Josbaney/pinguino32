/*	----------------------------------------------------------------------------
	FILE:				serial.c
	PROJECT:			pinguinoX
	PURPOSE:		
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	10 nov. 2010
	LAST RELEASE:	11 nov. 2010
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
	
	// 13 feb.2011 jp mandon added #define for RX/TX pin on 32mx440f256h
	
#ifndef __SERIAL_C
	#define __SERIAL_C

	#include <stdio.c>
	#include <system.c>
	#include <interrupt.c>
	#include <typedef.h>

	#define UART1			1
	#define UART2			2

	// -------------------------------------------------------------------------
	// UxMODE
	// -------------------------------------------------------------------------

	// bit 15 ON: UARTx Enable bit
	#define UART_DISABLE		0x0000
	#define UART_ENABLE		0x8000
/*
	#define UART_PERIPHERAL	0x01
	#define UART_RX			0x02	// UART Module receiver
	#define UART_TX			0x04	// UART Module transmitter
*/
	// bit 13 SIDL: Stop in Idle Mode bit
	#define UART_ENABLE_STOP_ON_IDLE	0x00002000

	// bit 12 IREN: IrDA Encoder and Decoder Enable bit
	#define UART_ENABLE_IRDA			0x00001000

	// bit 11 RTSMD: Mode Selection for UxRTS Pin bit
	#define UART_RTS_WHEN_RX_NOT_FULL	0x000
	#define UART_RTS_WHEN_TX_NOT_EMPTY	0x800

	// bit 9-8 UEN<1:0>: UARTx Enable bits
	#define UART_ENABLE_PINS_BIT_CLOCK	0x300 // UxTX, UxRX, and UxBCLK pins are enabled and used; UxCTS pin is controlled by port latches
	#define UART_ENABLE_PINS_CTS_RTS	0x200 // UxTX, UxRX, UxCTS, and UxRTS pins are enabled and used
	#define UART_ENABLE_PINS_RTS		0x100 // UxTX, UxRX and UxRTS pins are enabled and used; UxCTS pin is controlled by port latches
	#define UART_ENABLE_PINS_TX_RX_ONLY	0x000 // UxTX and UxRX pins are enabled and used; UxCTS and UxRTS/UxBCLK pins are controlled by port latches

	// bit 7 WAKE: Enable Wake-up on Start bit Detect During Sleep mode bit
	#define UART_ENABLE_WAKE_ON_START	0x00000080

	// bit 6 LPBACK: UARTx Loopback Mode Select bit
	#define UART_ENABLE_LOOPBACK		0x00000040

	// bit 5 ABAUD: Auto-Baud Enable bit

	// bit 4 RXINV: Receive Polarity Inversion bit
	#define UART_INVERT_RECEIVE_POLARITY	0x00000010

	// bit 3 BRGH: High Baud Rate Enable bit
	#define UART_ENABLE_HIGH_SPEED		0x00000008

	// bit 2-1 PDSEL<1:0>: Parity and Data Selection bits
    
	#define UART_9_BITS_NO_PARITY		0b110
	#define UART_8_BITS_ODD_PARITY		0b100
	#define UART_8_BITS_EVEN_PARITY		0b010
	#define UART_8_BITS_NO_PARITY		0b000

	// bit 0 STSEL: Stop Selection bit
	#define UART_STOP_BITS_2			0b1	// Enables generation of 2 stop bits per frame.
	#define UART_STOP_BITS_1			0b0	// Enables generation of 1 stop bit per frame (default).

	// -------------------------------------------------------------------------
	// UxSTA
	// -------------------------------------------------------------------------

	// bit 24 ADM_EN: Automatic Address Detect Mode Enable bit

	// bit 15-14 UTXISEL<1:0>: Tx Interrupt Mode Selection bits
	#define UART_INTERRUPT_ON_TX_BUFFER_EMPTY	0x8000
	#define UART_INTERRUPT_ON_TX_DONE			0x4000
	#define UART_INTERRUPT_ON_TX_NOT_FULL		0x0000

	// bit 13 UTXINV: Transmit Polarity Inversion bit
	#define UART_INVERT_TRANSMIT_POLARITY	0x20000000

	// bit 12 URXEN: Receiver Enable bit
	#define UART_RX_ENABLED				0x1000	// UARTx receiver is enabled, UxRX pin controlled by UARTx (if ON = 1)
	#define UART_RX_DISABLED			0x0000	// UARTx receiver is disabled, the UxRX pin is ignored by the UARTx module. UxRX pin controlled by PORT.

	// bit 11 UTXBRK: Transmit Break bit

	// bit 10 UTXEN: Transmit Enable bit
	#define UART_TX_ENABLED			`	0x400	// UARTx transmitter enabled, UxTX pin controlled by UARTx (if ON = 1)
	#define UART_TX_DISABLED			0x1000	// UARTx transmitter disabled, any pending transmission is aborted and buffer is reset. UxTX pin controlled by PORT.
	#define UART_RX_TX_ENABLED			0x1400

	// bit 7-6 URXISEL<1:0>: Receive Interrupt Mode Selection bit
	#define UART_INTERRUPT_ON_RX_FULL			0x00C0
	#define UART_INTERRUPT_ON_RX_HALF_FULL		0x0040
	#define UART_INTERRUPT_ON_RX_NOT_EMPTY		0x0000

	// bit 5 ADDEN: Address Character Detect (bit 8 of received data = 1)

	// UART_CONFIGURATION
	#define UART_SUPPORT_IEEE_485		0x00000900

	// UART_LINE_STATUS;
	#define UART_TRANSMITTER_NOT_FULL	0x00000200	// The transmitter is able to accept data to transmit.
	#define UART_TRANSMITTER_EMPTY		0x00000100	// The transmitter is empty (no data is available to transmit).
	#define UART_RECEIVER_IDLE			0x00000010	// The receiver is currently idle.
	#define UART_PARITY_ERROR			0x00000008	// A received data parity error was detected.
	#define UART_FRAMING_ERROR			0x00000004	// Data was received that violated the framing protocol
	#define UART_OVERRUN_ERROR			0x00000002	// The UART has received more data than it can buffer.  Data has been lost.
	#define UART_DATA_READY				0x00000001	// UART data has been received and is avaiable in the FIFO.

#ifndef SERIALBUFFERLENGTH
	#define SERIALBUFFERLENGTH 128		// rx buffer length
#endif

u8 UART1SerialBuffer[SERIALBUFFERLENGTH];	// this is the buffer
u8 UART2SerialBuffer[SERIALBUFFERLENGTH];	// this is the buffer
u8 UART1wpointer, UART1rpointer;			// write and read pointer
u8 UART2wpointer, UART2rpointer;			// write and read pointer

/*	----------------------------------------------------------------------------
	SerialSetDataRate()
	----------------------------------------------------------------------------
	@param		port		1 (UART1) or 2 (UART2)
	@param		baudrate	baud rate
	@return		baudrate
	----------------------------------------------------------------------------
	BRGH: High Baud Rate Enable bit
	if BRGH = 1 = High-Speed mode – 4x baud clock enabled
		then UxBRG = ((FPB/Desired Baud Rate)/ 4) – 1
	if BRGH 0 = Standard Speed mode – 16x baud clock enabled
		then UxBRG = ((FPB/Desired Baud Rate)/16) – 1
	--------------------------------------------------------------------------*/

void SerialSetDataRate(u8 port, u32 baudrate)
{
	u8 speed;
	u32 max, max1, max2;
	u32 min1, min2;
	u32 pbclock;

	pbclock = GetPeripheralClock();
	max1 = pbclock / 4;
	min1 = max1 / 65536;
	max2 = pbclock / 16;
	min2 = max2 / 65536;
	if (baudrate > max1) baudrate = max1;
	if (baudrate < min2) baudrate = min2;
	max = (min1 + max2) / 2;
	//if (baudrate > min2 && baudrate < max) speed = STANDARDSPEED;
	if (baudrate > max && baudrate < max1) speed = UART_ENABLE_HIGH_SPEED;

	switch (port)
	{
		case UART1:
			if (speed == UART_ENABLE_HIGH_SPEED)
			{
				U1MODEbits.BRGH = UART_ENABLE_HIGH_SPEED;
				U1BRG = ((pbclock / baudrate) / 4) - 1;
			}
			else
				U1BRG = ((pbclock / baudrate) / 16) - 1;
			break;
		case UART2:
			if (speed == UART_ENABLE_HIGH_SPEED)
			{
				U2MODEbits.BRGH = UART_ENABLE_HIGH_SPEED;
				U2BRG = ((pbclock / baudrate) / 4) - 1;
			}
			else
				U2BRG = ((pbclock / baudrate) / 16) - 1;
			break;
	}
}

/*	----------------------------------------------------------------------------
	SerialGetDataRate
	--------------------------------------------------------------------------*/

u32 SerialGetDataRate(u8 port)
{
	u8 speed;
	u32 baudrate;
	u32 pbclock;

	pbclock = GetPeripheralClock();

	switch (port)
	{
		case UART1:
			speed = U1MODEbits.BRGH;
			if (speed == UART_ENABLE_HIGH_SPEED)
				baudrate = pbclock / (4 * (U1BRG + 1));
			else
				baudrate = pbclock / (16 * (U1BRG + 1));
			break;
		case UART2:
			speed = U2MODEbits.BRGH;
			if (speed == UART_ENABLE_HIGH_SPEED)
				baudrate = pbclock / (4 * (U2BRG + 1));
			else
				baudrate = pbclock / (16 * (U2BRG + 1));
			break;
	}
	return baudrate;
}

/*	----------------------------------------------------------------------------
	SerialEnable
	----------------------------------------------------------------------------
	ex : SerialEnable(UART1, UART_RX_TX_ENABLED | UART_INTERRUPT_ON_RX_FULL)
	--------------------------------------------------------------------------*/

void SerialEnable(u8 port, u32 config)
{
	switch (port)
	{
		case UART1: U1STASET = config; break;
		case UART2:	U2STASET = config; break;
	}
}

/*	----------------------------------------------------------------------------
	SerialSetLineControl
	----------------------------------------------------------------------------
	ex : SerialSetLineControl(UART1, UART_ENABLE | UART_ENABLE_PINS_TX_RX_ONLY | UART_8_BITS_NO_PARITY | UART_STOP_BITS_1)
	--------------------------------------------------------------------------*/

void SerialSetLineControl(u8 port, u32 config)
{
	switch (port)
	{
		case UART1: U1MODESET = config; break;
		case UART2: U2MODESET = config;	break;
	}
}

/*	----------------------------------------------------------------------------
	SerialFlush : clear SerialBuffer
	--------------------------------------------------------------------------*/

void SerialFlush(u8 port)
{
	switch (port)
	{
		case UART1:
			UART1wpointer = 1;
			UART1rpointer = 1;
			break;
		case UART2:
			UART2wpointer = 1;
			UART2rpointer = 1;
			break;
	}
}

/*	----------------------------------------------------------------------------
	SerialPinConfigure : UART I/O pins control
	--------------------------------------------------------------------------*/

void SerialPinConfigure(u8 port)
{
	switch (port)
	{
		case UART1:
			#ifdef __32MX460F512L__
			TRISFbits.TRISF8 = OUTPUT;	// RF8 / U1TX output
			TRISFbits.TRISF2 = INPUT;	// RF2 / U1RX input
			#endif
			#ifdef __32MX440F256H__
			TRISDbits.TRISD1 = OUTPUT;	// RF8 / U1TX output
			TRISDbits.TRISD0 = INPUT;	// RF2 / U1RX input
			#endif			
			break;
		case UART2:
			TRISFbits.TRISF5 = OUTPUT;	// RF5 / U2TX output
			TRISFbits.TRISF4 = INPUT;	// RF4 / U2RX input
			break;
	}
}

/*	----------------------------------------------------------------------------
	SerialIntConfigure() : Serial Interrupts Configuration
	----------------------------------------------------------------------------
	@param		port		1 (UART1) or 2 (UART2)
	@param		baudrate	baud rate
	@return		baudrate
	--------------------------------------------------------------------------*/

void SerialIntConfigure(u8 port, u8 priority, u8 subpriority)
{
	IntConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);

	switch (port)
	{
		case UART1:
			IntSetVectorPriority(INT_UART1_VECTOR, priority, subpriority);
			IntEnable(INT_UART1_RECEIVER, INT_ENABLED);
			break;
		case UART2:
			IntSetVectorPriority(INT_UART2_VECTOR, priority, subpriority);
			IntEnable(INT_UART2_RECEIVER, INT_ENABLED);
			break;
	}
}

/*	----------------------------------------------------------------------------
	SerialConfigure()
	----------------------------------------------------------------------------
	@param		port		1 (UART1) or 2 (UART2)
	@param		baudrate	baud rate
	@return		baudrate
	--------------------------------------------------------------------------*/

void SerialConfigure(u8 port, u32 config, u32 enable, u32 baudrate)
{
	SerialPinConfigure(port);
	SerialSetDataRate(port, baudrate);		// UxBRG
	SerialSetLineControl(port, config);		// UxMODE
	SerialEnable(port, enable);				// UxSTA
	SerialIntConfigure(port, INT_PRIORITY_3, INT_SUBPRIORITY_3);
	SerialFlush(port);
}

/*	----------------------------------------------------------------------------
	SerialWriteChar1 : write data bits 0-8 on the UART1
	--------------------------------------------------------------------------*/

void SerialUART1WriteChar(char c)
{
	while (!U1STAbits.TRMT);				// wait transmitter is ready
	U1TXREG = c;
}

/*	----------------------------------------------------------------------------
	SerialWriteChar2 : write data bits 0-8 on the UART2
	--------------------------------------------------------------------------*/

void SerialUART2WriteChar(char c)
{
	while (!U2STAbits.TRMT);				// wait transmission has completed
	U2TXREG = c;
}

/*	----------------------------------------------------------------------------
	SerialPrintf : write formated string on the serial port
	--------------------------------------------------------------------------*/

void SerialPrintf(u8 port, char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	switch (port)
	{
		case UART1:	pprintf(SerialUART1WriteChar, fmt, args); break;
		case UART2: pprintf(SerialUART2WriteChar, fmt, args); break;
	}
	va_end(args);
}

/*	----------------------------------------------------------------------------
	SerialAvailable
	--------------------------------------------------------------------------*/

u8 SerialAvailable(u8 port)
{
	switch (port)
	{
		case UART1: return (UART1wpointer != UART1rpointer); break;
		case UART2:	return (UART2wpointer != UART2rpointer); break;
	}
}

/*	----------------------------------------------------------------------------
	SerialRead : Get char
	--------------------------------------------------------------------------*/

u8 SerialRead(u8 port)
{
	u8 c = 0;

	if (SerialAvailable(port))
	{
		switch (port)
		{
			case UART1:
				c = UART1SerialBuffer[UART1rpointer++];
				if (UART1rpointer == SERIALBUFFERLENGTH)
					UART1rpointer=1;
				break;
			case UART2:
				c = UART2SerialBuffer[UART2rpointer++];
				if (UART2rpointer == SERIALBUFFERLENGTH)
					UART2rpointer=1;
				break;
		}
	}
	return(c);
}

/*	----------------------------------------------------------------------------
	SerialGetKey
	--------------------------------------------------------------------------*/

u8 SerialGetKey(u8 port)
{
	u8 c;

	while (!(SerialAvailable(port)));
	c = SerialRead(port);
	SerialFlush(port);
	return (c);
}

/*	----------------------------------------------------------------------------
	SerialGetString
	--------------------------------------------------------------------------*/

u8 * SerialGetString(u8 port)
{
	u8 *buffer;
	u8 c;
	u8 i = 0;

	buffer = (u8 *) malloc(80);
	do {
		c = SerialGetKey(port);
		SerialPrintf(port, "%c", c);
		buffer[i++] = c;
	} while (c != '\r');
	buffer[i] = '\0';
	return (buffer);
}

/*	----------------------------------------------------------------------------
	SerialGetDataBuffer
	--------------------------------------------------------------------------*/

void SerialGetDataBuffer(u8 port)
{
	u8 caractere;
	u8 newwp;

	switch (port)
	{
		case UART1:
			caractere = U1RXREG;							// read received char
			if (UART1wpointer != SERIALBUFFERLENGTH - 1)	// if not last place in buffer
				newwp = UART1wpointer + 1;					// place=place+1
			else
				newwp = 1;									// else place=1

			if (UART1rpointer != newwp)						// if read pointer!=write pointer
				UART1SerialBuffer[UART1wpointer++] = caractere;	// store received char

			if (UART1wpointer == SERIALBUFFERLENGTH)		// if write pointer=length buffer
				UART1wpointer = 1;							// write pointer = 1

			//return UART1SerialBuffer;
			break;

		case UART2:
			caractere = U2RXREG;							// read received char
			if (UART2wpointer != SERIALBUFFERLENGTH - 1)	// if not last place in buffer
				newwp = UART2wpointer + 1;					// place=place+1
			else
				newwp = 1;									// else place=1

			if (UART2rpointer != newwp)						// if read pointer!=write pointer
				UART2SerialBuffer[UART2wpointer++] = caractere;	// store received char

			if (UART2wpointer == SERIALBUFFERLENGTH)		// if write pointer=length buffer
				UART2wpointer = 1;							// write pointer = 1

			//return UART2SerialBuffer;
			break;
	}
}

/*	----------------------------------------------------------------------------
	SerialInterrupt
	TODO: move this to interrupt library and add it to main32.c
	--------------------------------------------------------------------------*/

#pragma interrupt SerialInterrupt ipl3 vector 24
void SerialInterrupt(void)
{
	// Is this an RX interrupt?
	if (IntGetFlag(INT_UART1_RECEIVER))
	{
		SerialGetDataBuffer(UART1);
		//UBW32LedToggle(REDLED);			// Toggle LED to indicate UART activity
		IntClearFlag(INT_UART1_RECEIVER);
	}

	if (IntGetFlag(INT_UART2_RECEIVER))
	{
		SerialGetDataBuffer(UART2);
		//UBW32LedToggle(REDLED);			// Toggle LED to indicate UART activity
		IntClearFlag(INT_UART2_RECEIVER);
	}

	// We don't care about TX interrupt
/*
	if (IFS0bits.U1TXIF)
	{
		IFS0bits.U1TXIF = 0;
	}
	if (IFS1bits.U2TXIF)
	{
		IFS1bits.U2TXIF = 0;
	}
*/
	//IFS0CLR = UART1_ALL_INTERRUPT;			// clear any existing event
}

#endif
