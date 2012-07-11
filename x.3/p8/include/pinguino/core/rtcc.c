/*	----------------------------------------------------------------------------
	FILE:  			rtcc.c
	PROJECT: 		pinguino
	PURPOSE: 		Real Time Clock and Calendar functions
	PROGRAMER: 		regis blanchot <rblanchot@gmail.com>
	FIRST RELEASE:	15 Jun 2012
	LAST RELEASE:	30 Jun 2012
	----------------------------------------------------------------------------
    CHANGELOG :
    * 30 Jun 2012   Regis Blanchot  Changed rtccTime and rtccDate to match dcf77
	----------------------------------------------------------------------------
	TODO :
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

#ifndef __RTCC__
#define __RTCC__

#if !defined(PIC18F26J50)
    #error "Error : your Pinguino has no RTCC module." 
#endif

#include <pic18fregs.h>
#include <typedef.h>
#include <const.h>
#include <macro.h>
#include <interrupt.h>
#include <bcd.c>
#include <digitalw.c>
#include <system.c>

// RTCC definitions

//typedef void (*callback) (void);	// type of: void callback()
//static callback intFunction;

// union/structure for read/write of time into the RTCC device
typedef union
{
	struct
	{
		u8	seconds;	// BCD codification for seconds, 00-59
		u8	minutes;	// BCD codification for minutes, 00-59
		u8	hours;		// BCD codification for hours, 00-24
	};					// field access
	u8		b[4];		// byte access
	u16		w[2];		// 16 bits access
	u32		l;			// 32 bits access
}rtccTime;

// union/structure for read/write of date into the RTCC device
typedef union
{
	struct
	{
		u8	dayofweek;	// BCD codification for day of the week, 00-06
		u8	dayofmonth;	// BCD codification for day of the month, 01-31
		u8	month;		// BCD codification for month, 01-12
		u8	year;		// BCD codification for years, 00-99
	};								// field access
	u8		b[4];		// byte access
	u16		w[2];		// 16 bits access
	u32		l;			// 32 bits access
}rtccDate;

// results returned by initialization functions
typedef enum
{
	RTCC_SOSC_ON,					// success, SOSC is running
	RTCC_SOSC_NRDY,				    // SOSC not running
	RTCC_CLK_NRDY,					// RTCC clock not running
	RTCC_WR_DSBL,					// WR is disabled
}rtccRes;

// global variables
rtccTime _rtccTime_;
rtccDate _rtccDate_;

// Repeat alarm every ...
#define RTCC_ALARM_EVERY_HALF_SECOND	0b0000
#define RTCC_ALARM_EVERY_SECOND 		0b0001
#define RTCC_ALARM_EVERY_TEN_SECONDS	0b0010
#define RTCC_ALARM_EVERY_MINUTE 		0b0011
#define RTCC_ALARM_EVERY_TEN_MINUTES	0b0100
#define RTCC_ALARM_EVERY_HOUR 			0b0101
#define RTCC_ALARM_EVERY_DAY  			0b0110
#define RTCC_ALARM_EVERY_WEEK 			0b0111
#define RTCC_ALARM_EVERY_MONTH 			0b1000
#define RTCC_ALARM_EVERY_YEAR 			0b1001 // except when configured for February 29th, once every 4 years

// Prototypes

void RTCC_ConvertTime(rtccTime*);
void RTCC_ConvertDate(rtccDate*);

void RTCC_SetWriteEnable(void);
void RTCC_SetWriteDisable(void);
u8 RTCC_GetWriteEnable(void);
void RTCC_Enable(void);
void RTCC_Disable(void);
u8 RTCC_GetEnable(void);
void RTCC_Wait(void);

void RTCC_init(u32, u32, s16);
void RTCC_Test(u8);
void RTCC_Shutdown(void);

//void OnRTCC(callback);
//void RTCCInterrupt(void);

void RTCC_SetCalibration(s16);
s16 RTCC_GetCalibration(void);

void RTCC_SetTime(u32);
void RTCC_SetDate(u32);
void RTCC_SetTimeDate(u32, u32);
void RTCC_GetTime(rtccTime*);
void RTCC_GetDate(rtccDate*);
void RTCC_GetTimeDate(rtccTime*, rtccDate*);
/*
void RTCC_SetAlarmEnable(int);
void RTCC_AlarmEnable(void);
void RTCC_AlarmDisable(void);
int RTCC_GetAlarmEnable(void);
void RTCC_SetChimeEnable(int);
void RTCC_ChimeEnable(void);
void RTCC_ChimeDisable(void);
int RTCC_GetChimeEnable(void);
void RTCC_SetAlarmRepeat(int);
void RTCC_AlarmRepeatEveryHalfSecond(void);
void RTCC_AlarmRepeatEverySecond(void);
void RTCC_AlarmRepeatEveryTenSeconds(void);
void RTCC_AlarmRepeatEveryMinute(void);
void RTCC_AlarmRepeatEveryTenMinutes(void);
void RTCC_AlarmRepeatEveryHour(void);
void RTCC_AlarmRepeatEveryDay(void);
void RTCC_AlarmRepeatEveryWeek(void);
void RTCC_AlarmRepeatEveryMonth(void);
void RTCC_AlarmRepeatEveryYear(void);
int RTCC_GetAlarmRepeat(void);
void RTCC_SetAlarmRepeatCount(char);
char RTCC_GetAlarmRepeatCount(void);
void RTCC_SetAlarmTime(u32);
rtccTime RTCC_GetAlarmTime(void);
void RTCC_SetAlarmDate(u32);
rtccDate RTCC_GetAlarmDate(void);
void RTCC_SetAlarmTimeDate(u32, u32);
void RTCC_GetAlarmTimeDate(rtccTime*, rtccDate*);
void RTCC_SetSync(int);
int RTCC_GetSync(void);
void RTCC_SetAlarmSync(int);
int RTCC_GetAlarmSync(void);
int RTCC_GetHalfSecond(void);
void RTCC_SecondsPulseOutput(void);
void RTCC_AlarmPulseOutput(void);
void RTCC_SetAlarmInitialPulse(int);
void RTCC_AlarmInitialPulseHigh(void);
void RTCC_AlarmInitialPulseLow(void);
int RTCC_GetAlarmInitialPulse(void);
void RTCC_AlarmInitialPulseToggle(void);
void RTCC_SetOutputEnable(int);
void RTCC_OutputEnable(void);
void RTCC_OutputDisable(void);
int RTCC_GetOutputEnable(void);
void RTCC_SetAlarmIntEnable(int);
void RTCC_AlarmIntEnable(void);
void RTCC_AlarmIntDisable(void);
*/

/*	----------------------------------------------------------------------------
	RTCC REGISTERS
	----------------------------------------------------------------------------
    RTCCFG
    RTCCAL
    PADCFG1
    ALRMCFG
    ALRMRPT
	--------------------------------------------------------------------------*/

/********************************************************************************
    BASIC ROUTINES
********************************************************************************/

/*	-----------------------------------------------------------------------------
	Conversion routines from bcd to decimal format
	---------------------------------------------------------------------------*/

void RTCC_ConvertTime(rtccTime *pTm)
{
	pTm->hours    = bcd2bin(pTm->hours);
	pTm->minutes  = bcd2bin(pTm->minutes);
	pTm->seconds  = bcd2bin(pTm->seconds);
}

void RTCC_ConvertDate(rtccDate *pDt)
{
	pDt->dayofweek  = bcd2bin(pDt->dayofweek);
	pDt->dayofmonth = bcd2bin(pDt->dayofmonth);
	pDt->month      = bcd2bin(pDt->month);
	pDt->year       = bcd2bin(pDt->year);
}

/*	-----------------------------------------------------------------------------
	Allow a writing into the clock registers
	In order to perform a write to any of the RTCC timer registers,
    the RTCWREN bit	must be set.
	---------------------------------------------------------------------------*/

void RTCC_SetWriteEnable(void)
{
/*
    __asm
    movlb   0x0F        ;RTCCFG is banked
    ;bcf     _INTCON,7,1 ;GIE
    movlw   0x55
    movwf   _EECON2,1 
    movlw   0xAA
    movwf   _EECON2,1
    bsf     _RTCCFG,5,1 ;RTCWREN
    __endasm;
*/
    SystemUnlock();
    RTCCFGbits.RTCWREN = 1; // enable write
    SystemLock();
}

void RTCC_SetWriteDisable(void)
{
/*
    __asm
    movlb   0x0F        ;RTCCFG is banked
    ;bcf     _INTCON,7,1 ;GIE
    movlw   0x55
    movwf   _EECON2,1 
    movlw   0xAA
    movwf   _EECON2,1
    bcf     _RTCCFG,5,1 ;RTCWREN
    __endasm;
*/
    SystemUnlock();
    RTCCFGbits.RTCWREN = 0; // disable write
    SystemLock();
}

/*	-----------------------------------------------------------------------------
	Check that RTCC is writable
	---------------------------------------------------------------------------*/

u8 RTCC_GetWriteEnable(void)
{
	 return RTCCFGbits.RTCWREN != 0;
}

/*	-----------------------------------------------------------------------------
	RTCC module is enabled
	The write operations have to be enabled first.
    * clears the alarm interrupt flag.
 	---------------------------------------------------------------------------*/

void RTCC_Enable(void)
{
	RTCC_SetWriteEnable();
    RTCCFGbits.RTCEN = 1;
	RTCC_SetWriteDisable();
	PIR3bits.RTCCIF = 0;
}

/*	-----------------------------------------------------------------------------	
	RTCC module is disabled
	The write operations have to be enabled first.
 	---------------------------------------------------------------------------*/

void RTCC_Disable(void)
{
	RTCC_SetWriteEnable();
    RTCCFGbits.RTCEN = 0;
	RTCC_SetWriteDisable();
}

/*	-----------------------------------------------------------------------------
	Check if RTCC module is enable
	---------------------------------------------------------------------------*/

u8 RTCC_GetEnable(void)
{
	return RTCCFGbits.RTCEN != 0;
}

/*	-----------------------------------------------------------------------------
    The RTCSYNC bit indicates a time window during
    which the RTCC Clock Domain registers can be safely
    read and written without concern about a rollover.
    When RTCSYNC = 0, the registers can be safely
    accessed by the CPU.
	---------------------------------------------------------------------------*/

void RTCC_Wait(void)
{
    while (RTCCFGbits.RTCSYNC != 1); // if already in the middle of SYNC, wait for next period
    //while (RTCCFGbits.RTCSYNC == 1); // wait while RTCC registers are unsafe to read
}

/********************************************************************************
    INIT, SHUTDOWN and TEST THE RTCC MODULE
********************************************************************************/

/*	-----------------------------------------------------------------------------
	The function initializes the RTCC device.
    TODO * enables the INTRC oscillator (CONFIG3L<1>)
    *It enables the secondary oscillator (SOSC),
    *sets the desired time, date and calibration
    *enables the RTCC,
    *disables the Alarm and the RTCC clock output (RTCOE=0), 
	---------------------------------------------------------------------------*/

void RTCC_init(u32 tm, u32 dt, s16 drift)
{
    /// /!\ RTCC uses T1OSC/T1CKI as clock
    /// Bootloader v4.x : #pragma config RTCOSC = T1OSCREF
    /// TODO : #pragma config RTCOSC = INTOSCREF     

	RTCC_SetTime(tm);
	RTCC_SetDate(dt);
	RTCC_SetCalibration(drift);

	RTCC_Enable();
	//RTCC_AlarmDisable();
	//RTCC_OutputDisable();
}

/*	-----------------------------------------------------------------------------
	The function shutdowns the RTCC device.
    *disables the RTCC
    *disables RTCC write
    *disables the Alarm and the RTCC clock output (RTCOE=0).
    *clears the alarm interrupt flag.
 	---------------------------------------------------------------------------*/

void RTCC_Shutdown(void)
{
	RTCC_Disable();
	//RTCC_AlarmDisable();
	//RTCC_OutputDisable();
	PIR3bits.RTCCIF = 0;
}

/*	-----------------------------------------------------------------------------
	RTCC test function
    Blink a led connected to "pin"
 	---------------------------------------------------------------------------*/

void RTCC_Test(u8 pin)
{
    pinmode(pin, OUTPUT);
    if (RTCCFGbits.HALFSEC==0)
    {
        digitalwrite(pin, 1);
    }
    if (RTCCFGbits.HALFSEC==1)
    {
        digitalwrite(pin, 0);
    }
}

/********************************************************************************
    INTERRUPT FUNCTIONS
********************************************************************************/
/*
void OnRTCC(callback userfunc)
{
	intFunction = userfunc;
}
*/
/*	-----------------------------------------------------------------------------
	RTCC Interrupt Routine
	This one is private
	---------------------------------------------------------------------------*/
/*
void RTCCInterrupt(void)
{
	if (PIR3bits.RTCCIF)
	{
		PIR3bits.RTCCIF = 0;
		intFunction();
	}
}
*/
/********************************************************************************
    TIME FUNCTIONS
********************************************************************************/

/*	-----------------------------------------------------------------------------
	The write is successful only if Write Enable is set.
	---------------------------------------------------------------------------*/

void RTCC_SetTime(u32 tm)
{
    rtccTime t0;
    u8 dummy;
        
    t0.l = tm;
	RTCC_SetWriteEnable();
    RTCCFGbits.RTCPTR1 = 0;     
    RTCCFGbits.RTCPTR0 = 1;     
	while (RTCCFGbits.RTCSYNC);	// When RTCSYNC = 0, the registers can be safely accessed by the CPU
    RTCVALL = t0.hours;     
    dummy = RTCVALH;        // dummy read of RTCVALH to auto-decrement RTCPTR    
    RTCVALL = t0.seconds;
    RTCVALH = t0.minutes;   
 	RTCC_SetWriteDisable();
}

/*	-----------------------------------------------------------------------------
	The write is successful only if Write Enable is set.
	---------------------------------------------------------------------------*/

void RTCC_SetDate(u32 dt)
{
    rtccDate d0;
    u8 dummy;
        
    d0.l = dt;
	RTCC_SetWriteEnable();
    RTCCFGbits.RTCPTR1 = 1; // value decrements on every read or write of RTCVALH until it reaches ‘00’
    RTCCFGbits.RTCPTR0 = 1; 
    RTCVALL = d0.year;    
    dummy = RTCVALH;        // dummy read of RTCVALH to auto-decrement RTCPTR    
    RTCVALL = d0.dayofmonth;      
    RTCVALH = d0.month;   
    //RTCVALL = tm.hour;  
    RTCVALH = d0.dayofweek;
 	RTCC_SetWriteDisable();
}

/*	-----------------------------------------------------------------------------
	The write is successful only if Write Enable is set.
	---------------------------------------------------------------------------*/

void RTCC_SetTimeDate(u32 tm, u32 dt)
{
    RTCC_SetTime(tm);
    RTCC_SetDate(dt);
}

/*	-----------------------------------------------------------------------------
    Whether RTCSYNC = 1 or 0, the user should employ a
    firmware solution to ensure that the data read did not
    fall on a rollover boundary, resulting in an invalid or
    partial read. This firmware solution would consist of
    reading each register twice and then comparing the two
    values. If the two values matched, then, a rollover did
    not occur.
	---------------------------------------------------------------------------*/

void RTCC_ReadTime(rtccTime* pTm)
{
	u8 dummy;

    RTCC_Wait();
    RTCCFGbits.RTCPTR1 = 0;
    RTCCFGbits.RTCPTR0 = 1;
    pTm->hours = RTCVALL;     
    dummy = RTCVALH;        // dummy read of RTCVALH to auto-decrement RTCPTR    
    pTm->seconds = RTCVALL;
    pTm->minutes = RTCVALH;   
}

void RTCC_GetTime(rtccTime* pTm0)
{
	//rtccTime Tm1;

	//do
	//{
        RTCC_ReadTime(pTm0);
    //    RTCC_ReadTime(&Tm1);
	//}
    //while (pTm0->l != Tm1.l);

    RTCC_ConvertTime(pTm0);
}

void RTCC_ReadDate(rtccDate* pDt)
{
	u8 dummy;

    RTCC_Wait();
	RTCCFGbits.RTCPTR1 = 1;
	RTCCFGbits.RTCPTR0 = 1;
	pDt->year = RTCVALL;
    dummy = RTCVALH;        // dummy read of RTCVALH to auto-decrement RTCPTR    
	pDt->dayofmonth = RTCVALL;
	pDt->month = RTCVALH;
	dummy = RTCVALL;
	pDt->dayofweek = RTCVALH;
}

void RTCC_GetDate(rtccDate* pDt0)
{
	//rtccDate Dt1;

	//do
	//{
        RTCC_ReadDate(pDt0);
    //    RTCC_ReadDate(&Dt1);
	//}
    //while (pDt0->l != Dt1.l);

    RTCC_ConvertDate(pDt0);
}

void RTCC_GetTimeDate(rtccTime* pTm, rtccDate* pDt)
{
	rtccTime tm;
	rtccDate dt;

    RTCC_GetDate(&dt);
    RTCC_GetTime(&tm);
	pTm->l = tm.l;
	pDt->l = dt.l;
}

/*	-----------------------------------------------------------------------------
	adjust RTCC from +511 to -512 clock pulses every one minute
	0111111111 = Maximum positive adjustment, adds 511 RTC clock pulses every one minute
	1000000000 = Minimum negative adjustment, subtracts 512 clock pulses every one minute
 	10 dec 2011 : bug fixed thanks to Mark Harper
	---------------------------------------------------------------------------*/

void RTCC_SetCalibration(s16 cal)
{
	if (cal < -512)	cal = -512;
	if (cal >  511)	cal =  511;
	RTCC_SetWriteEnable();
    RTCCAL = cal;
    RTCC_SetWriteDisable();
}

/*	-----------------------------------------------------------------------------
	Return 10-bit clock pulse calibration
	---------------------------------------------------------------------------*/

s16 RTCC_GetCalibration(void)
{
	 return RTCCAL;
}

#endif	/* __RTCC__ */

