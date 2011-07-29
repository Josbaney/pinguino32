/*	----------------------------------------------------------------------------
	system.c
	Régis Blanchot
	
	Modified FAZZI 23/02/2011
	- Removed  asm("di")/asm("ei") from GetCP0Count/SetCP0Count	
	--------------------------------------------------------------------------*/

#ifndef __SYSTEM_C
	#define __SYSTEM_C

	#include "const.h"
	#include "typedef.h"

	#define CRYSTALFREQUENCY	 8000000L	// 8 MHz
	#define CPUCOREMAXFREQUENCY	80000000L	// 80 MHz
	#define FLASHACCESSTIME		50			// 50 ns

	// COSC<2:0>: Current Oscillator Selection bits
	// NOSC<2:0>: New Oscillator Selection bits
	#define FIRCOSCDIV		0b111 // Fast Internal RC Oscillator divided by OSCCON<FRCDIV> bits
	#define FIRCOSCDIV16	0b110 // Fast Internal RC Oscillator divided by 16
	#define LPIRCOSC		0b101 // Low-Power Internal RC Oscillator (LPRC)
	#define SOSC			0b100 // Secondary Oscillator (SOSC)
	#define POSCPLL			0b011 // Primary Oscillator with PLL module (XTPLL, HSPLL or ECPLL)
	#define POSC			0b010 // Primary Oscillator (XT, HS or EC)
	#define FRCOSCPLL		0b001 // Fast RC Oscillator with PLL module via Postscaler (FRCPLL)
	#define FRCOSC			0b000 // Fast RC Oscillator (FRC)

	// PLLODIV<2:0>: Output Divider for PLL
	#define PLLODIV256		0b111 // PLL output divided by 256
	#define PLLODIV64		0b110 // PLL output divided by 64
	#define PLLODIV32		0b101 // PLL output divided by 32
	#define PLLODIV16		0b100 // PLL output divided by 16
	#define PLLODIV8		0b011 // PLL output divided by 8
	#define PLLODIV4		0b010 // PLL output divided by 4
	#define PLLODIV2		0b001 // PLL output divided by 2
	#define PLLODIV1		0b000 // PLL output divided by 1

	// FRCDIV<2:0>: Fast Internal RC Clock Divider bits
	#define FRCDIV256		0b111 // FRC divided by 256
	#define FRCDIV64		0b110 // FRC divided by 64
	#define FRCDIV32		0b101 // FRC divided by 32
	#define FRCDIV16		0b100 // FRC divided by 16
	#define FRCDIV8			0b011 // FRC divided by 8
	#define FRCDIV4			0b010 // FRC divided by 4
	#define FRCDIV2			0b001 // FRC divided by 2 (default setting)
	#define FRCDIV1			0b000 // FRC divided by 1

	// PBDIV<1:0>: Peripheral Bus Clock Divisor
	#define PBDIV8			0b11 // PBCLK is SYSCLK divided by 8 (default)
	#define PBDIV4			0b10 // PBCLK is SYSCLK divided by 4
	#define PBDIV2			0b01 // PBCLK is SYSCLK divided by 2
	#define PBDIV1			0b00 // PBCLK is SYSCLK divided by 1

	// PLLMULT<2:0>: PLL Multiplier bits
	#define PLLMULT24		0b111 // Clock is multiplied by 24
	#define PLLMULT21		0b110 // Clock is multiplied by 21
	#define PLLMULT20		0b101 // Clock is multiplied by 20
	#define PLLMULT19		0b100 // Clock is multiplied by 19
	#define PLLMULT18		0b011 // Clock is multiplied by 18
	#define PLLMULT17		0b010 // Clock is multiplied by 17
	#define PLLMULT16		0b001 // Clock is multiplied by 16
	#define PLLMULT15		0b000 // Clock is multiplied by 15

/*	----------------------------------------------------------------------------
	SystemUnlock() perform a system unlock sequence
	--------------------------------------------------------------------------*/

void SystemUnlock()
{
	SYSKEY = 0;				// ensure OSCCON is locked
	SYSKEY = 0xAA996655;	// Write Key1 to SYSKEY
	SYSKEY = 0x556699AA;	// Write Key2 to SYSKEY
}

/*	----------------------------------------------------------------------------
	SystemLock() relock OSCCON by relocking the SYSKEY
	--------------------------------------------------------------------------*/

void SystemLock()
{
	SYSKEY = 0x12345678;	// Write any value other than Key1 or Key2
}

/*	----------------------------------------------------------------------------
	Software Reset
	----------------------------------------------------------------------------
	assume interrupts are disabled
	assume the DMA controller is suspended
	assume the device is locked
	--------------------------------------------------------------------------*/

void Reset()
{
	SystemUnlock();
	// set SWRST bit to arm reset
	RSWRSTSET = 1;
	// read RSWRST register to trigger reset
	u16 dummy = RSWRST;
	// prevent any unwanted code execution until reset occurs
	while(1);
}

/*	----------------------------------------------------------------------------
	GetSystemClock
	--------------------------------------------------------------------------*/

u32 GetSystemClock(void)
{
	u16 frcdiv = 1 << OSCCONbits.FRCDIV;
	u16 pllmult = 15 + OSCCONbits.PLLMULT;	// Clock has been multiplied by ...
	u16 pllodiv = 1 << OSCCONbits.PLLODIV;	// PLL output divided by ...
	if (frcdiv == 128) frcdiv = 256;
	if (pllmult == 22)  pllmult = 24;
	if (pllodiv == 128) pllodiv = 256;
	return ( 8000000L / pllodiv / frcdiv * pllmult );
}

/*	----------------------------------------------------------------------------
	GetPeripheralClock()
	--------------------------------------------------------------------------*/

u32 GetPeripheralClock()
{
	return (GetSystemClock() / (1 << OSCCONbits.PBDIV));
}

/*	----------------------------------------------------------------------------
	SetFlashWaitStates()
	--------------------------------------------------------------------------*/

void SetFlashWaitStates()
{
	SystemUnlock();
	CHECON = (GetSystemClock() / 20) - 1;		// FlashWaitStates
	SystemLock();
}

/*	-------------------------------------1---------------------------------------
	SetSystemClock() : change source and frequency clock
	----------------------------------------------------------------------------	
	8MHz	24		21		20		19		18		17		16		15
	1		192		168		160		152		144		136		128		120
	2		96		84		80		76		72		68		64		60
	4		48		42		40		38		36		34		32		30
	8		24		21		20		19		18		17		16		15
	16		12		10,5	10		9,5		9		8,5		8		7,5
	32		6		5,25	5		4,75	4,5		4,25	4		3,75
	64		3		2,625	2,5		2,375	2,25	2,125	2		1,875
	256		1,5		1,3125	1,25	1,1875	1,125	1,0625	1		0,9375
	--------------------------------------------------------------------------*/

void SetSystemClock(u32 cpuCoreFrequency)
{
	u8 i=0, j=0, p=0;
	u16 d, m;
	const u32 div[8] = {1,2,4,8,16,32,64,256};
	const u32 mul[8] = {24,21,20,19,18,17,16,15};

	if (cpuCoreFrequency > CPUCOREMAXFREQUENCY)
		cpuCoreFrequency = CPUCOREMAXFREQUENCY;	

	for (i=0; i<8; i++)
	{
		for (j=0; j<8; j++)
		{
			if ( (cpuCoreFrequency * div[j]) == (CRYSTALFREQUENCY * mul[i]) )
			{
				goto abort;
			}
		}
	}

	// CPUCOREMAXFREQUENCY
	i = 2;	// x20
	j = 1;	// /2

abort:

/*
	i = 2;
	j = 2;
*/
	SystemUnlock();
	// COSC<2:0>: Current Oscillator Selection bits
	OSCCONbits.COSC = POSCPLL;						// 8MHz
	// NOSC<2:0>: New Oscillator Selection bits
	OSCCONbits.NOSC = POSCPLL;						// 8MHz
	// PLLODIV<2:0>: Output Divider for PLL
	//OSCCONbits.PLLODIV = PLLODIV2;					// 8/2 = 4MHz
	//DEVCFG2bits.FPLLODIV = PLLODIV2;
	if (div[j] == 256)
		d = 128;
	else
		d = div[j];
	while ((d >>= 1) != 1)
		p++;
	OSCCONbits.PLLODIV = p;
	// PLLMULT<2:0>: PLL Multiplier bits
	//OSCCONbits.PLLMULT = PLLMULT20;					// 4x20 = 80MHz
	//DEVCFG2bits.FPLLMULT = PLLMULT20;
	if (mul[i] == 24)
		m = 22;
	else
		m = mul[i];
	OSCCONbits.PLLMULT = m - 15;

	// Initiate an oscillator switch to selection specified by NOSC2:NOSC0 bits
	OSCCONbits.OSWEN = 1;							// Enable Oscillator switch

	// wait for OSWEN to become 0... if this is uncommented then I'll never
	// see the clock running off the internal RC because the transition has
	// completed while polling this
	// while (OSCCON & 1);
	SystemLock();
}

/*	----------------------------------------------------------------------------
	SetPeripheralClock()
	--------------------------------------------------------------------------*/

void SetPeripheralClock(u8 div)
{
	OSCCONbits.PBDIV = div; // Peripheral Clock = System Clock / div 
}

// TODO:
// PortClearBits(LED_PORT, (CORE_TIMER_LED | CORE_SW_0_LED | CORE_SW_1_LED));
// PortSetPinsDigitalOut(LED_PORT, (CORE_TIMER_LED | CORE_SW_0_LED | CORE_SW_1_LED));

/*	----------------------------------------------------------------------------
	SystemConfig()
	--------------------------------------------------------------------------*/

void SystemConfig(u32 cpuCoreFrequency)
{
	SetSystemClock(cpuCoreFrequency);
	SetFlashWaitStates();
	DDPCONbits.JTAGEN=0;		// PORTA is used as digital instead of JTAG
}

/*	----------------------------------------------------------------------------
	GetCP0Count()
	--------------------------------------------------------------------------*/

u32 GetCP0Count()
{
	//u32 count;
	//asm("di"); // Disable all interrupts
	//count = _CP0_GET_COUNT();
	//asm("ei"); // Enable all interrupts
	//return count;
	return _CP0_GET_COUNT();
}

/*	----------------------------------------------------------------------------
	SetCP0Count()
	--------------------------------------------------------------------------*/

void SetCP0Count(u32 count)
{
	//asm("di"); // Disable all interrupts
	_CP0_SET_COUNT(count);
	//asm("ei"); // Enable all interrupts
}

#endif

