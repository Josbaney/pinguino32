/*	----------------------------------------------------------------------------
	FILE:  			RealTimeClock.pde
	PROJECT: 		Pinguino
	PURPOSE: 		Real Time Clock and Calendar functions Demo
	PROGRAMER:		regis blanchot <rblanchot@gmail.com>
	BOARD:			PIC32-PINGUINO (OLIMEX)
					or any other PIC32MX board with external 32.768 kHz clock crystal
	FIRST RELEASE:	11 apr. 2011
	LAST RELEASE:	05 jul. 2011
	--------------------------------------------------------------------------*/

char Day[7][5]		= {"Sat.","Sun.","Mon.","Tue.","Wed.","Thu.","Fri."};
char Month[13][5]	= {"","Jan.","Feb.","Mar.","Apr.","Mei.","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec."};

void blink1()
{
	toggle(LED1);
}

void setup()
{
	u32 Tm  = 0x23595500;	// 23hr, 59 min, 55 sec
	u32 Dt  = 0x11123100;	// Saturday (day 0 of the week), 31 Dec. 2011
	u32 aTm = 0x00000500;	// 00hr, 00 min, 05 sec
	u32 aDt = 0x12010101;	// Sunday (day 1 of the week), 1st Jan. 2012
	u16 drift = 200;		// add 200 pulse every minute to adjust time
	
/**	-----------------------------------------------------------------------------
	alarm will toggle the built-in led
	---------------------------------------------------------------------------*/
	pinMode(LED1, OUTPUT);
	digitalWrite(LED1, OFF);// we start with led off
/**	-----------------------------------------------------------------------------
	set date, time and calibration
	---------------------------------------------------------------------------*/
	/// 1st option
	RTCC.open(Tm, Dt, drift);
	/// 2nd option
/*
	RTCC.setTimeDate(Tm, Dt);
	RTCC.setCalibration(drift);
*/
	/// 3rd option
/*	
	RTCC.setTime(Tm);
	RTCC.setDate(Dt);
	RTCC.setCalibration(drift);
*/
/**	-----------------------------------------------------------------------------
	set alarm date and time
	---------------------------------------------------------------------------*/
	/// 1st option
/*
	RTCC.setAlarmTimeDate(aTm, aDt);
*/
	/// 2nd option
	RTCC.setAlarmTime(aTm);
	RTCC.setAlarmDate(aDt);
/**	-----------------------------------------------------------------------------
	set alarm repeat
	---------------------------------------------------------------------------*/
	/// 1st option
/*
	RTCC.chimeEnable();					// enable indefinite repeats
*/
	/// 2nd option
	RTCC.chimeDisable();				// disable indefinite repeats
	RTCC.setAlarmRepeat(5);				// repeat alarm 5 times = 5 interrupt events
	RTCC.alarmRepeatEveryTenSeconds();	// enable repeat rate, every 10 sec (compare only the last digit)
/**	-----------------------------------------------------------------------------
	1st method: set alarm output
	---------------------------------------------------------------------------*/
	RTCC.alarmPulseOutput();			// select the alarm pulse as the function of the RTCC output pin
	RTCC.secondsPulseOutput();			// select the seconds clock pulse as the function of the RTCC output pin
	RTCC.alarmInitialPulseLow();		// start Low 
	//RTCC.alarmInitialPulseHigh();		// start High
	RTCC.outputEnable();				// enable the Output pin of the RTCC
/**	-----------------------------------------------------------------------------
	2nd method: alarm interrupt
	---------------------------------------------------------------------------*/
	//RTCC.alarmIntEnable();			// enable alarm interrupt
/**	-----------------------------------------------------------------------------
	enable alarm
	---------------------------------------------------------------------------*/
	RTCC.alarmEnable();					// enable alarm
}

void loop()
{
	u8 status;
	rtccTime cT, aT;
	rtccDate cD, aD;
	rtccTime curTime, alTime;
	rtccDate curDate, alDate;

/**	-----------------------------------------------------------------------------
	get time and date
	---------------------------------------------------------------------------*/
	// 1st option
/*
	RTCC.getTimeDate(&cT, &cD);
*/
	// 2nd option
	cT = RTCC.getTime();
	cD = RTCC.getDate();
/**	-----------------------------------------------------------------------------
	get alarm time and date
	---------------------------------------------------------------------------*/
	// 1st option
/*
	RTCC.getAlarmTimeDate(&aT, &aD);
*/
	// 2nd option
	aT = RTCC.getAlarmTime();
	aD = RTCC.getAlarmDate();
/**	-----------------------------------------------------------------------------
	convert time and date from bcd to decimal format
	---------------------------------------------------------------------------*/
	curTime = RTCC.convertTime(&cT);
	curDate = RTCC.convertDate(&cD);
/**	-----------------------------------------------------------------------------
	convert alarm time and date
	---------------------------------------------------------------------------*/
	alTime  = RTCC.convertTime(&aT);
	alDate  = RTCC.convertDate(&aD);
/**	-----------------------------------------------------------------------------
	display time  and date
	see the result with cat /dev/ttyACM0
	---------------------------------------------------------------------------*/
	CDC.printf("Today's Date is ");
	CDC.printf("%04s, %02d %04s %04d, ", Day[curDate.wday], curDate.mday, Month[curDate.mon], curDate.year+2000);
	CDC.printf("%02d:%02d:%02d ", curTime.hour, curTime.min, curTime.sec);
/**	-----------------------------------------------------------------------------
	display alarm time and alarm date
	see the result with cat /dev/ttyACM0
	---------------------------------------------------------------------------*/
	CDC.printf("Alarm's Date is ");
	CDC.printf("%04s, %02d %04s %04d, ", Day[alDate.wday], alDate.mday, Month[alDate.mon], alDate.year+2000);
	CDC.printf("%02d:%02d:%02d \r\n", alTime.hour, alTime.min, alTime.sec);
/**	-----------------------------------------------------------------------------
	alarm output management
	---------------------------------------------------------------------------*/
	status = digitalRead(RTCC);			// RTCC pin
	digitalWrite(LED1, status);			// Led1 reproduce RTCC pin state
/**	-----------------------------------------------------------------------------
	alarm interrupt management
	---------------------------------------------------------------------------*/
/*
	OnRTCC(blink1);
*/
	delay(500);
}
