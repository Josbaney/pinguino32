/*	----------------------------------------------------------------------------
	FILE:			interrupt.c
	PROJECT:		pinguino32X
	PURPOSE:		interrupts management
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	16 nov. 2010
	LAST RELEASE:	17 nov. 2010
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

#ifndef __INTERRUPT_C
	#define __INTERRUPT_C

	#include <p32xxxx.h>
	#include "typedef.h"
	#include "macro.h"

	// INTERRUPT CONFIG MODE
	#define INT_SYSTEM_CONFIG_MULT_VECTOR	1
	#define INT_SYSTEM_CONFIG_SINGLE_VECTOR 2

	// INTERRUPT ENABLE/DISABLE
	#define INT_ENABLED						1
	#define INT_DISABLED					0

	// INTERRUPT VECTOR LOCATION
	#define INT_CORE_TIMER_VECTOR			0
	#define INT_CORE_SOFTWARE0_VECTOR		1
	#define INT_CORE_SOFTWARE1_VECTOR		2
	#define INT_EXTERNAL0_VECTOR			3
	#define INT_TIMER1_VECTOR				4
	#define INT_INPUT_CAPTURE1_VECTOR		5  
	#define INT_OUTPUT_COMPARE1_VECTOR		6   
	#define INT_EXTERNAL1_VECTOR			7          
	#define INT_TIMER2_VECTOR				8   
	#define INT_INPUT_CAPTURE2_VECTOR		9  
	#define INT_OUTPUT_COMPARE2_VECTOR		10   
	#define INT_EXTERNAL2_VECTOR			11          
	#define INT_TIMER3_VECTOR				12   
	#define INT_INPUT_CAPTURE3_VECTOR		13  
	#define INT_OUTPUT_COMPARE3_VECTOR		14   
	#define INT_EXTERNAL3_VECTOR			15          
	#define INT_TIMER4_VECTOR				16   
	#define INT_INPUT_CAPTURE4_VECTOR		17  
	#define INT_OUTPUT_COMPARE4_VECTOR		18   
	#define INT_EXTERNAL4_VECTOR			19          
	#define INT_TIMER5_VECTOR				20   
	#define INT_INPUT_CAPTURE5_VECTOR		21  
	#define INT_OUTPUT_COMPARE5_VECTOR		22   
	#define INT_SPI1_VECTOR					23    
	#define INT_UART1_VECTOR				24    
	#define INT_I2C1_VECTOR					25   
	#define INT_INPUT_CHANGE_VECTOR			26    
	#define INT_ADC1_CONVERT_DONE_VECTOR	27          
	#define INT_PARALLEL_MASTER_PORT_VECTOR	28  
	#define INT_COMPARATOR1_VECTOR			29          
	#define INT_COMPARATOR2_VECTOR			30          
	#define INT_SPI2_VECTOR					31
	#define INT_UART2_VECTOR				32
	#define INT_I2C2_VECTOR					33
	#define INT_FSCM_VECTOR					34
	#define INT_RTCC_VECTOR					35
	#define INT_DMA0_VECTOR					36
	#define INT_DMA1_VECTOR					37
	#define INT_DMA2_VECTOR					38
	#define INT_DMA3_VECTOR					39
	#define INT_FCE_VECTOR					44
	#define INT_USB_VECTOR					45

	// IRQ NUMBER = INTERRUPT NUMBER (IFSx, IECx and IPSx registers)
	#define INT_CORE_TIMER					0
	#define INT_CORE_SOFTWARE0				1
	#define INT_CORE_SOFTWARE1				2
	#define INT_EXTERNAL0					3
	#define INT_TIMER1						4
	#define INT_INPUT_CAPTURE1				5
	#define INT_OUTPUT_COMPARE1				6
	#define INT_EXTERNAL1					7
	#define INT_TIMER2						8
	#define INT_INPUT_CAPTURE2				9
	#define INT_OUTPUT_COMPARE2				10
	#define INT_EXTERNAL2					11
	#define INT_TIMER3						12
	#define INT_INPUT_CAPTURE3				13
	#define INT_OUTPUT_COMPARE3				14
	#define INT_EXTERNAL3					15
	#define INT_TIMER4						16
	#define INT_INPUT_CAPTURE4				17
	#define INT_OUTPUT_COMPARE4				18
	#define INT_EXTERNAL4					19
	#define INT_TIMER5						20
	#define INT_INPUT_CAPTURE5				21
	#define INT_OUTPUT_COMPARE5				22
	#define INT_SPI1_FAULT					23 
	#define INT_SPI1_TRANSFER_DONE			24 
	#define INT_SPI1_RECEIVE_DONE			25
	#define INT_UART1_ERROR					26 
	#define INT_UART1_RECEIVER				27
	#define INT_UART1_TRANSMITTER			28
	#define INT_I2C1_BUS_COLLISION_EVENT	29
	#define INT_I2C1_SLAVE_EVENT			30
	#define INT_I2C1_MASTER_EVENT			31
	#define INT_INPUT_CHANGE				32
	#define INT_ADC1_CONVERT_DONE			33
	#define INT_PARALLEL_MASTER_PORT		34
	#define INT_COMPARATOR1					35
	#define INT_COMPARATOR2					36
	#define INT_SPI2_FAULT					37 
	#define INT_SPI2_TRANSFER_DONE			38 
	#define INT_SPI2_RECEIVE_DONE			39
	#define INT_UART2_ERROR					40 
	#define INT_UART2_RECEIVER				41 
	#define INT_UART2_TRANSMITTER			42 
	#define INT_I2C2_BUS_COLLISION_EVENT	43 
	#define INT_I2C2_SLAVE_EVENT			44 
	#define INT_I2C2_MASTER_EVENT			45 
	#define INT_FAIL_SAFE_CLOCK_MONITOR		46
	#define INT_REAL_TIME_CLOCK				47
	#define INT_DMA_CHANNEL_0				48 
	#define INT_DMA_CHANNEL_1				49 
	#define INT_DMA_CHANNEL_2				50 
	#define INT_DMA_CHANNEL_3				51 
	#define INT_FLASH_CONTROL_EVENT			56
	#define INT_USB							57

	// IPCx: INTERRUPT PRIORITY CONTROL REGISTER
	#define INT_UART1_ALL_PRIORITY		0x0000001F	// disable all UART1 interrupts
	#define INT_UART2_ALL_PRIORITY		0x0000001F	// disable all UART2 interrupts
	#define INT_PRIORITY_7				0b111
	#define INT_PRIORITY_6				0b110
	#define INT_PRIORITY_5				0b101
	#define INT_PRIORITY_4				0b100
	#define INT_PRIORITY_3				0b011
	#define INT_PRIORITY_2				0b010
	#define INT_PRIORITY_1				0b001
	#define INT_PRIORITY_DISABLED		0b000
	#define INT_SUBPRIORITY_3			0b11
	#define INT_SUBPRIORITY_2			0b10
	#define INT_SUBPRIORITY_1			0b01
	#define INT_SUBPRIORITY_0			0b00

	// IEC0
	#define I2C1_M_INT_ENABLE			0x80000000
	#define I2C1_S_INT_ENABLE			0x40000000
	#define I2C1_B_INT_ENABLE			0x20000000
/*	--------------------------------------------------------------------------*/
	#define UART1_TX_INT_ENABLE			0x10000000
	#define UART1_RX_INT_ENABLE			0x08000000
	#define UART1_ERROR_INT_ENABLE		0x04000000
	#define UART1_ALL_INTERRUPT			0x1C000000
/*	--------------------------------------------------------------------------*/
	#define SPI1_RX_INT_ENABLE			0x02000000
	#define SPI1_TX_INT_ENABLE			0x01000000	
	#define SPI1_ERROR_INT_ENABLE		0x00800000
	#define OUTPUT_COMPARE5_INT_ENABLE	0x00400000
	#define IC5_INT_ENABLE				0x00200000
	#define TIMER5_INT_ENABLE			0x00100000
	#define EXTERNAL4_INT_ENABLE		0x00080000
	#define OUTPUT_COMPARE4_INT_ENABLE	0x00040000
	#define IC4_INT_ENABLE				0x00020000
	#define TIMER4_INT_ENABLE			0x00010000
	#define EXTERNAL3_INT_ENABLE		0x00008000
	#define OUTPUT_COMPARE3_INT_ENABLE	0x00004000
	#define IC3_INT_ENABLE				0x00002000
	#define TIMER3_INT_ENABLE			0x00001000
	#define EXTERNAL2_INT_ENABLE		0x00000800
	#define OUTPUT_COMPARE2_INT_ENABLE	0x00000400
	#define IC2_INT_ENABLE				0x00000200
	#define TIMER2_INT_ENABLE			0x00000100
	#define EXTERNAL1_INT_ENABLE		0x00000080
	#define OUTPUT_COMPARE1_INT_ENABLE	0x00000040
	#define IC1_INT_ENABLE				0x00000020
	#define TIMER1_INT_ENABLE			0x00000010
	#define EXTERNAL0_INT_ENABLE		0x00000008
	#define CORE_SYSTEM1_INT_ENABLE		0x00000004
	#define CORE_SYSTEM0_INT_ENABLE		0x00000002
	#define CORE_TIMER_INT_ENABLE		0x00000001

	// IEC1
	#define USB_INT_ENABLE				0x02000000
	#define FCE_INT_ENABLE				0x01000000
	#define DMA3_INT_ENABLE				0x00080000
	#define DMA2_INT_ENABLE				0x00040000
	#define DMA1_INT_ENABLE				0x00020000
	#define DMA0_INT_ENABLE				0x00010000
	#define RTCC_INT_ENABLE				0x00008000
	#define FSCM_INT_ENABLE				0x00004000
	#define I2C2_M_INT_ENABLE			0x00002000
	#define I2C2_S_INT_ENABLE			0x00001000
	#define I2C2_B_INT_ENABLE			0x00000800
/*	--------------------------------------------------------------------------*/
	#define UART2_TX_INT_ENABLE			0x00000400
	#define UART2_RX_INT_ENABLE			0x00000200
	#define UART2_ERROR_INT_ENABLE		0x00000100
	#define UART2_ALL_INTERRUPT			0x00000700
/*	--------------------------------------------------------------------------*/
	#define SPI2RX_INT_ENABLE			0x00000080
	#define SPI2TX_INT_ENABLE			0x00000040
	#define SPI2E_INT_ENABLE			0x00000020
	#define CMP2_INT_ENABLE				0x00000010
	#define CMP1_INT_ENABLE				0x00000008
	#define PMP_INT_ENABLE				0x00000004
	#define AD1_INT_ENABLE				0x00000002
	#define CN_INT_ENABLE				0x00000001

/*	----------------------------------------------------------------------------
	IntSetPriority
	----------------------------------------------------------------------------
	The Interrupt Service Routine (ISR) must clear the associated interrupt flag
	in the IFSx register before lowering the interrupt priority level to avoid
	recursive interrupts.
	IPCx: Interrupt Priority Control Registers
	IFSx: Interrupt Flag Status Registers
	--------------------------------------------------------------------------*/

void IntSetVectorPriority(u8 vector, u8 pri, u8 sub)
{
	//IFSxCLR = ;
	//IPCxCLR = ;		// clear the priority level
	switch (vector)
	{
		case INT_CORE_TIMER_VECTOR:
			break;
		case INT_CORE_SOFTWARE0_VECTOR:
			break;
		case INT_CORE_SOFTWARE1_VECTOR:
			break;
		case INT_EXTERNAL0_VECTOR:
			break;
		case INT_TIMER1_VECTOR:
			break;
		case INT_INPUT_CAPTURE1_VECTOR:
			break;
		case INT_OUTPUT_COMPARE1_VECTOR:
			break;
		case INT_EXTERNAL1_VECTOR:
			break;    
		case INT_TIMER2_VECTOR:
			break;
		case INT_INPUT_CAPTURE2_VECTOR:
			break;
		case INT_OUTPUT_COMPARE2_VECTOR:
			break;
		case INT_EXTERNAL2_VECTOR:
			break;    
		case INT_TIMER3_VECTOR:
			break;
		case INT_INPUT_CAPTURE3_VECTOR:
			break;
		case INT_OUTPUT_COMPARE3_VECTOR:
			break;
		case INT_EXTERNAL3_VECTOR:
			break;     
		case INT_TIMER4_VECTOR:
			break;
		case INT_INPUT_CAPTURE4_VECTOR:
			break;
		case INT_OUTPUT_COMPARE4_VECTOR:
			break;
		case INT_EXTERNAL4_VECTOR:
			break;
		case INT_TIMER5_VECTOR:
			break;
		case INT_INPUT_CAPTURE5_VECTOR:
			break;
		case INT_OUTPUT_COMPARE5_VECTOR:
			break;
		case INT_SPI1_VECTOR:
			break;  
		case INT_UART1_VECTOR:
			IFS0bits.U1TXIF = 0;
			IFS0bits.U1RXIF = 0;
			IFS0bits.U1EIF  = 0;
			IPC6bits.U1IP = pri;
			IPC6bits.U1IS = sub;
			break; 
		case INT_I2C1_VECTOR:
			break;
		case INT_INPUT_CHANGE_VECTOR:
			break;
		case INT_ADC1_CONVERT_DONE_VECTOR:
			break;       
		case INT_PARALLEL_MASTER_PORT_VECTOR:
			break;
		case INT_COMPARATOR1_VECTOR:
			break;         
		case INT_COMPARATOR2_VECTOR:
			break;        
		case INT_SPI2_VECTOR:
			break;
		case INT_UART2_VECTOR:
			IFS1bits.U2TXIF = 0;
			IFS1bits.U2RXIF = 0;
			IFS1bits.U2EIF  = 0;
			IPC8bits.U2IP = pri;
			IPC8bits.U2IS = sub;
			break;
		case INT_I2C2_VECTOR:
			break;
		case INT_FSCM_VECTOR:
			break;
		case INT_RTCC_VECTOR:
			break;
		case INT_DMA0_VECTOR:
			break;
		case INT_DMA1_VECTOR:
			break;
		case INT_DMA2_VECTOR:
			break;
		case INT_DMA3_VECTOR:
			break;
		case INT_FCE_VECTOR:
			break;
		case INT_USB_VECTOR:
			break;
	}
}

/*	----------------------------------------------------------------------------
	IntGetVectorPriority
	----------------------------------------------------------------------------
	Gets the interrupt vector's priority.
	This routine gets the interrupt vector's priority.
	Parameters:
		vector    - Interrupt vector.
	Returns:
		interrupt vector's priority
	--------------------------------------------------------------------------*/

unsigned int IntGetVectorPriority(u8 vector)
{
	unsigned int pri;

	switch (vector)
	{
		case INT_CORE_TIMER_VECTOR:
			break;
		case INT_CORE_SOFTWARE0_VECTOR:
			break;
		case INT_CORE_SOFTWARE1_VECTOR:
			break;
		case INT_EXTERNAL0_VECTOR:
			break;
		case INT_TIMER1_VECTOR:
			break;
		case INT_INPUT_CAPTURE1_VECTOR:
			break;
		case INT_OUTPUT_COMPARE1_VECTOR:
			break;
		case INT_EXTERNAL1_VECTOR:
			break;    
		case INT_TIMER2_VECTOR:
			break;
		case INT_INPUT_CAPTURE2_VECTOR:
			break;
		case INT_OUTPUT_COMPARE2_VECTOR:
			break;
		case INT_EXTERNAL2_VECTOR:
			break;    
		case INT_TIMER3_VECTOR:
			break;
		case INT_INPUT_CAPTURE3_VECTOR:
			break;
		case INT_OUTPUT_COMPARE3_VECTOR:
			break;
		case INT_EXTERNAL3_VECTOR:
			break;     
		case INT_TIMER4_VECTOR:
			break;
		case INT_INPUT_CAPTURE4_VECTOR:
			break;
		case INT_OUTPUT_COMPARE4_VECTOR:
			break;
		case INT_EXTERNAL4_VECTOR:
			break;
		case INT_TIMER5_VECTOR:
			break;
		case INT_INPUT_CAPTURE5_VECTOR:
			break;
		case INT_OUTPUT_COMPARE5_VECTOR:
			break;
		case INT_SPI1_VECTOR:
			break;  
		case INT_UART1_VECTOR:
			pri = IPC6bits.U1IP;
			break; 
		case INT_I2C1_VECTOR:
			break;
		case INT_INPUT_CHANGE_VECTOR:
			break;
		case INT_ADC1_CONVERT_DONE_VECTOR:
			break;       
		case INT_PARALLEL_MASTER_PORT_VECTOR:
			break;
		case INT_COMPARATOR1_VECTOR:
			break;         
		case INT_COMPARATOR2_VECTOR:
			break;        
		case INT_SPI2_VECTOR:
			break;
		case INT_UART2_VECTOR:
			pri = IPC8bits.U2IP;
			break;
		case INT_I2C2_VECTOR:
			break;
		case INT_FSCM_VECTOR:
			break;
		case INT_RTCC_VECTOR:
			break;
		case INT_DMA0_VECTOR:
			break;
		case INT_DMA1_VECTOR:
			break;
		case INT_DMA2_VECTOR:
			break;
		case INT_DMA3_VECTOR:
			break;
		case INT_FCE_VECTOR:
			break;
		case INT_USB_VECTOR:
			break;
	}
	return (pri);
}

/*	----------------------------------------------------------------------------
	IntGetVectorSubPriority
	----------------------------------------------------------------------------
	Gets the interrupt vector's priority.
	This routine gets the interrupt vector's priority.
	Parameters:
		vector    - Interrupt vector.
	Returns:
		interrupt vector's sub-priority
	--------------------------------------------------------------------------*/

unsigned int IntGetVectorSubPriority(u8 vector)
{
}

/*	----------------------------------------------------------------------------
	IntClearFlag
	----------------------------------------------------------------------------
	IFSx: Interrupt Flag Status Registers
	--------------------------------------------------------------------------*/

void IntClearFlag(u8 numinter)
{
	if (numinter > 31)
	{
		numinter -= 32;
		BitClear(IFS1, numinter);
	}
	else
		BitClear(IFS0, numinter);
}

/*	----------------------------------------------------------------------------
	IntGetFlag
	----------------------------------------------------------------------------
    Gets the interrupt request flag.
    This routine gets an interrupt request flag.
	Parameters:
    	source  - Interrupt source.
	Returns:
    	* 0 if the interrupt request flag is clear 
    	* 1 if the interrupt request flag is set
	--------------------------------------------------------------------------*/

unsigned int IntGetFlag(u8 numinter)
{
	if (numinter > 31)
	{
		numinter -= 32;
		return BitRead(IFS1, numinter);
	}
	else
	{
		return BitRead(IFS0, numinter);
	}
}

/*	----------------------------------------------------------------------------
	IntEnable
	----------------------------------------------------------------------------
	Enables or disables the interrupt.
	IECx: Interrupt Enable Control Registers
	--------------------------------------------------------------------------*/

void IntEnable(u8 numinter, u8 enable)
{
	switch (enable)
	{
		case INT_ENABLED:
			if (numinter > 31)
			{
				numinter -= 32;
				BitSet(IEC1, numinter);
			}
			else
			{
				BitSet(IEC0, numinter);
			}
			break;
		case INT_DISABLED:
			if (numinter > 31)
			{
				numinter -= 32;
				BitClear(IEC1, numinter);
			}
			else
				BitClear(IEC0, numinter);
			break;
	}
}

/*	----------------------------------------------------------------------------
	IntGetInterruptVectorNumber
	----------------------------------------------------------------------------
	Gets the pending interrupt vector.
	This routine gets the pending interrupt vector number.
	Returns:
		The pending interrupt vector number.  
	--------------------------------------------------------------------------*/

unsigned int IntGetInterruptVectorNumber(void)
{
    return (unsigned int)(INTSTATbits.VEC);
}

/*	----------------------------------------------------------------------------
	IntGetInterruptVectorPriority
	----------------------------------------------------------------------------
	Gets the pending interrupt vector's priority.
	This routine gets the pending interrupt vector's priority.
	Returns:
		The pending interrupt vector's priority.
	--------------------------------------------------------------------------*/

unsigned int IntGetInterruptVectorPriority(void)
{
    return (unsigned int)(INTSTATbits.SRIPL);
}

/*	----------------------------------------------------------------------------
	IntDisableInterrupts
	----------------------------------------------------------------------------
	Disables the PIC32MX from handling interrupts.
	This routine disables the core from handling any pending interrupt requests.
	Returns:
	The previous state of the CP0 register Status.IE bit.  The INTRestoreInterrupts 
	function can be used in other routines to restore the system interrupt state.
	--------------------------------------------------------------------------*/

unsigned int IntDisableInterrupts()
{
	unsigned int intStatus;

	intStatus = _CP0_GET_STATUS(); // Get Status
	asm("di"); // Disable all interrupts
	return intStatus;
}

/*	----------------------------------------------------------------------------
	IntEnableInterrupts
	----------------------------------------------------------------------------
	Enables the PIC32MX to handle interrupts.
	This routine enables the core to handle any pending interrupt requests.
	Need to configure system using INTConfigureSystem
	Returns: The previous state of the CP0 register Status.IE bit.
	The IntRestoreInterrupts function can be used in other routines to restore
	the system interrupt state.
	--------------------------------------------------------------------------*/

unsigned int IntEnableInterrupts()
{
    unsigned int intStatus;

	intStatus = _CP0_GET_STATUS(); // Get Status
	asm("ei"); // Enable all interrupts
	return intStatus;
}

/*	----------------------------------------------------------------------------
	IntRestoreInterrupts
	----------------------------------------------------------------------------
	Restores the PIC32MX interrupt state.
	This routine restores the core to the previous interrupt handling state.
	Parameters:
		status      - the state of the CP0 register Status.IE
	--------------------------------------------------------------------------*/

void IntRestoreInterrupts(unsigned int intStatus)
{
	_CP0_SET_STATUS(intStatus); // Update Status
}

/*	----------------------------------------------------------------------------
	IntSetEBASE
	----------------------------------------------------------------------------
	Sets the PIC32MX exception base.
	This routine sets the exception base of the core.
	Parameters:
		ebase_address   - The address of the EBASE.
		* must be be located in KSEG0 or KSEG1
		* must be 4KB aligned
	NB : EBASE at 0xBD000000 (microchip) or 0xBD005000 (jean-pierre mandon)
	--------------------------------------------------------------------------*/

void IntSetEBASE(unsigned int ebase_address)
{
	_CP0_SET_EBASE(ebase_address);
}

/*	----------------------------------------------------------------------------
	IntConfigureSystem
	----------------------------------------------------------------------------
	Configures the system for  multi-vector or single vectored interrupts.
	This routine configures the core to receive interrupt requests and configures the 
	Interrupt module for Multi-vectored or Single Vectored mode.
	Parameters:
		config      - The interrupt configuration to set.
		IntConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);
		IntConfigureSystem(INT_SYSTEM_CONFIG_SINGLE_VECTOR);
	NB : Place EBASE at 0xBD000000 (microchip) or 0xBD005000 (jean-pierre mandon)
	--------------------------------------------------------------------------*/

void IntConfigureSystem(u8 mode)
{
	unsigned int temp;

	asm("di"); // Disable all interrupts
	temp = _CP0_GET_STATUS(); // Get Status
	temp |= 0x00400000; // Set BEV bit
	_CP0_SET_STATUS(temp); // Update Status
	_CP0_SET_EBASE(0xBD005000); // Set an EBase value of 0xBD005000
	_CP0_SET_INTCTL(0x00000020); // Set the Vector Spacing to non-zero value
	temp = _CP0_GET_CAUSE(); // Get Cause
	temp |= 0x00800000; // Set IV
	_CP0_SET_CAUSE(temp); // Update Cause
	temp = _CP0_GET_STATUS(); // Get Status
	temp &= 0xFFBFFFFD; // Clear BEV and EXL
	_CP0_SET_STATUS(temp); // Update Status

	switch (mode)
	{
		case INT_SYSTEM_CONFIG_MULT_VECTOR:
			// Set the CP0 registers for multi-vector interrupt
			INTCONSET = 0x1000; // Set MVEC bit
		break;
		case INT_SYSTEM_CONFIG_SINGLE_VECTOR:
			// Set the CP0 registers for single-vector interrupt
			INTCONCLR = 0x1000; // Clear MVEC bit
		break;	
	}

	asm("ei"); // Enable all interrupts
}

#endif

