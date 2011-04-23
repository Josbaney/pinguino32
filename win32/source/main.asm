;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.7 #5938 (Aug 21 2010) (MINGW32)
; This file was generated Sun Apr 10 11:13:21 2011
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f2550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _intUsed
	global _intCount
	global _intCountLimit
	global _preloadH
	global _preloadL
	global _digitalwrite
	global _digitalread
	global _pinmode
	global _toggle
	global _detachInterrupt
	global _int_init
	global _int_start
	global _int_stop
	global _OnTimer0
	global _OnTimer1
	global _OnTimer2
	global _OnTimer3
	global _userhighinterrupt
	global _userinterrupt
	global _epap_in
	global _epap_out
	global _epapin_init
	global _epapout_init
	global _blink0
	global _blink1
	global _blink2
	global _blink3
	global _setup
	global _loop
	global _pinguino_main
	global _high_priority_isr
	global _low_priority_isr
	global _mask
	global _port

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _SPPDATAbits
	extern _SPPCFGbits
	extern _SPPEPSbits
	extern _SPPCONbits
	extern _UFRMLbits
	extern _UFRMHbits
	extern _UIRbits
	extern _UIEbits
	extern _UEIRbits
	extern _UEIEbits
	extern _USTATbits
	extern _UCONbits
	extern _UADDRbits
	extern _UCFGbits
	extern _UEP0bits
	extern _UEP1bits
	extern _UEP2bits
	extern _UEP3bits
	extern _UEP4bits
	extern _UEP5bits
	extern _UEP6bits
	extern _UEP7bits
	extern _UEP8bits
	extern _UEP9bits
	extern _UEP10bits
	extern _UEP11bits
	extern _UEP12bits
	extern _UEP13bits
	extern _UEP14bits
	extern _UEP15bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _OSCTUNEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _ECCP1DELbits
	extern _BAUDCONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _HLVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _FSR2Hbits
	extern _BSRbits
	extern _FSR1Hbits
	extern _FSR0Hbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _TBLPTRUbits
	extern _PCLATHbits
	extern _PCLATUbits
	extern _STKPTRbits
	extern _TOSUbits
	extern _usb_device_state
	extern _usb_active_cfg
	extern _usb_active_alt_setting
	extern _SPPDATA
	extern _SPPCFG
	extern _SPPEPS
	extern _SPPCON
	extern _UFRML
	extern _UFRMH
	extern _UIR
	extern _UIE
	extern _UEIR
	extern _UEIE
	extern _USTAT
	extern _UCON
	extern _UADDR
	extern _UCFG
	extern _UEP0
	extern _UEP1
	extern _UEP2
	extern _UEP3
	extern _UEP4
	extern _UEP5
	extern _UEP6
	extern _UEP7
	extern _UEP8
	extern _UEP9
	extern _UEP10
	extern _UEP11
	extern _UEP12
	extern _UEP13
	extern _UEP14
	extern _UEP15
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _OSCTUNE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _SPBRGH
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _ECCP1DEL
	extern _BAUDCON
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _HLVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern __mulint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
INTCON	equ	0xff2
WREG	equ	0xfe8
BSR	equ	0xfe0
TOSL	equ	0xffd
TOSH	equ	0xffe
TOSU	equ	0xfff
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
TBLPTRU	equ	0xff8
TABLAT	equ	0xff5
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1

udata_main_0	udata
_intUsed	res	20

udata_main_1	udata
_intCount	res	8

udata_main_2	udata
_intCountLimit	res	8

udata_main_3	udata
_preloadH	res	4

udata_main_4	udata
_preloadL	res	4

udata_main_5	udata
_intFunction	res	60

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block
S_main__high_priority_isr	code	0X002020
_high_priority_isr:
;	.line	121; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	void high_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	182; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	}
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
S_main__low_priority_isr	code	0X004000
_low_priority_isr:
;	.line	185; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	void low_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	188; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	userinterrupt();
	CALL	_userinterrupt
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; I code from now on!
; ; Starting pCode block
S_main__pinguino_main	code
_pinguino_main:
;	.line	53; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	PIE1 = 0;
	CLRF	_PIE1
;	.line	54; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	PIE2 = 0;
	CLRF	_PIE2
;	.line	55; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	ADCON1 = 0b00001111;				// AN0 to AN12 Digital I/O
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	58; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	int_init();							// Disable all interrupts
	CALL	_int_init
;	.line	67; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	setup();
	CALL	_setup
;	.line	70; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	int_start();							// Enable all timers interrupts
	CALL	_int_start
_00412_DS_:
;	.line	115; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	loop();
	CALL	_loop
	BRA	_00412_DS_
	RETURN	

; ; Starting pCode block
S_main__loop	code
_loop:
;	.line	43; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	ERROR: no line number 43 in file C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	29; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	//
	MOVLW	0xf0
	ANDWF	_LATB, F
;	.line	30; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	TRISB &= 0b11110000;
	ANDWF	_PORTB, F
;	.line	33; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	OnTimer1(blink1, INT_MILLISEC, 500);	// Use Timer1 to toggle pin 0 every 500 ms
	ANDWF	_TRISB, F
;	.line	35; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	OnTimer3(blink3, INT_MILLISEC, 500);	// Use Timer3 to toggle pin 0 every 500 ms
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	UPPER(_blink0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_blink0)
	MOVWF	POSTDEC1
	MOVLW	LOW(_blink0)
	MOVWF	POSTDEC1
	CALL	_OnTimer0
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	36; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	}
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	UPPER(_blink1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_blink1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_blink1)
	MOVWF	POSTDEC1
	CALL	_OnTimer1
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	37; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	UPPER(_blink2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_blink2)
	MOVWF	POSTDEC1
	MOVLW	LOW(_blink2)
	MOVWF	POSTDEC1
	CALL	_OnTimer2
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	38; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	void loop()
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	UPPER(_blink3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_blink3)
	MOVWF	POSTDEC1
	MOVLW	LOW(_blink3)
	MOVWF	POSTDEC1
	CALL	_OnTimer3
	MOVLW	0x06
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__blink3	code
_blink3:
;	.line	23; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_toggle
	INCF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__blink2	code
_blink2:
;	.line	22; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	void blink3() {	toggle(LED3); }
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_toggle
	INCF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__blink1	code
_blink1:
;	.line	21; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	void blink2() {	toggle(LED2); }
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_toggle
	INCF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__blink0	code
_blink0:
;	.line	20; C:\Users\jpm\Documents\pinguino32x_windows\source\/user.c	void blink1() {	toggle(LED1); }
	MOVLW	0x00
	CLRF	POSTDEC1
	CALL	_toggle
	INCF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__epapout_init	code
_epapout_init:
;	.line	41; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	void epapout_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epapin_init	code
_epapin_init:
;	.line	40; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	void epapin_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_out	code
_epap_out:
;	.line	39; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	void epap_out() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_in	code
_epap_in:
;	.line	38; C:\Users\jpm\Documents\pinguino32x_windows\source\main.c	void epap_in() { return; }
	RETURN	

; ; Starting pCode block
S_main__userinterrupt	code
_userinterrupt:
;	.line	968; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void userinterrupt()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	992; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (INTCONbits.TMR0IE && INTCONbits.TMR0IF)
	BTFSS	_INTCONbits, 5
	BRA	_00318_DS_
	BTFSS	_INTCONbits, 2
	BRA	_00318_DS_
;	.line	994; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T0CONbits.TMR0ON = OFF;
	BCF	_T0CONbits, 7
;	.line	995; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR0H = preloadH[INT_TMR0];
	MOVFF	_preloadH, _TMR0H
;	.line	996; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR0L = preloadL[INT_TMR0];
	MOVFF	_preloadL, _TMR0L
;	.line	997; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	998; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intCount[INT_TMR0]++ >= intCountLimit[INT_TMR0])
	MOVFF	_intCount, r0x00
	MOVFF	(_intCount + 1), r0x01
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x02
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	BANKSEL	_intCount
	MOVWF	_intCount, B
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_intCount + 1), B
	BANKSEL	(_intCountLimit + 1)
	MOVF	(_intCountLimit + 1), W, B
	SUBWF	r0x01, W
	BNZ	_00349_DS_
; removed redundant BANKSEL
	MOVF	_intCountLimit, W, B
	SUBWF	r0x00, W
_00349_DS_:
	BNC	_00318_DS_
	BANKSEL	_intCount
;	.line	1000; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR0] = 0;
	CLRF	_intCount, B
; removed redundant BANKSEL
	CLRF	(_intCount + 1), B
;	.line	1001; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR0]();
	MOVFF	_intFunction, r0x00
	MOVFF	(_intFunction + 1), r0x01
	MOVFF	(_intFunction + 2), r0x02
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00350_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00350_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00350_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x02, PCLATU
	MOVFF	r0x01, PCLATH
	MOVF	r0x00, W
	MOVWF	PCL
_00350_DS_:
_00318_DS_:
;	.line	1006; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (PIE1bits.TMR1IE && PIR1bits.TMR1IF)
	BTFSS	_PIE1bits, 0
	BRA	_00323_DS_
	BTFSS	_PIR1bits, 0
	BRA	_00323_DS_
;	.line	1008; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T1CONbits.TMR1ON = OFF;
	BCF	_T1CONbits, 0
;	.line	1009; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR1H = preloadH[INT_TMR1];
	MOVFF	(_preloadH + 1), _TMR1H
;	.line	1010; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR1L = preloadL[INT_TMR1];
	MOVFF	(_preloadL + 1), _TMR1L
;	.line	1011; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIR1bits.TMR1IF = 0;
	BCF	_PIR1bits, 0
;	.line	1012; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intCount[INT_TMR1]++ >= intCountLimit[INT_TMR1])
	MOVFF	(_intCount + 2), r0x00
	MOVFF	(_intCount + 3), r0x01
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x02
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	BANKSEL	(_intCount + 2)
	MOVWF	(_intCount + 2), B
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_intCount + 3), B
	BANKSEL	(_intCountLimit + 3)
	MOVF	(_intCountLimit + 3), W, B
	SUBWF	r0x01, W
	BNZ	_00351_DS_
; removed redundant BANKSEL
	MOVF	(_intCountLimit + 2), W, B
	SUBWF	r0x00, W
_00351_DS_:
	BNC	_00323_DS_
	BANKSEL	(_intCount + 2)
;	.line	1014; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR1] = 0;
	CLRF	(_intCount + 2), B
; removed redundant BANKSEL
	CLRF	(_intCount + 3), B
;	.line	1015; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR1]();
	MOVFF	(_intFunction + 3), r0x00
	MOVFF	(_intFunction + 4), r0x01
	MOVFF	(_intFunction + 5), r0x02
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00352_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00352_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00352_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x02, PCLATU
	MOVFF	r0x01, PCLATH
	MOVF	r0x00, W
	MOVWF	PCL
_00352_DS_:
_00323_DS_:
;	.line	1020; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (PIE1bits.TMR2IE && PIR1bits.TMR2IF)
	BTFSS	_PIE1bits, 1
	BRA	_00328_DS_
	BTFSS	_PIR1bits, 1
	BRA	_00328_DS_
;	.line	1022; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T2CONbits.TMR2ON = OFF;
	BCF	_T2CONbits, 2
;	.line	1023; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIR1bits.TMR2IF = 0;
	BCF	_PIR1bits, 1
;	.line	1024; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intCount[INT_TMR2]++ >= intCountLimit[INT_TMR2])
	MOVFF	(_intCount + 4), r0x00
	MOVFF	(_intCount + 5), r0x01
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x02
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	BANKSEL	(_intCount + 4)
	MOVWF	(_intCount + 4), B
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_intCount + 5), B
	BANKSEL	(_intCountLimit + 5)
	MOVF	(_intCountLimit + 5), W, B
	SUBWF	r0x01, W
	BNZ	_00353_DS_
; removed redundant BANKSEL
	MOVF	(_intCountLimit + 4), W, B
	SUBWF	r0x00, W
_00353_DS_:
	BNC	_00328_DS_
	BANKSEL	(_intCount + 4)
;	.line	1026; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR2] = 0;
	CLRF	(_intCount + 4), B
; removed redundant BANKSEL
	CLRF	(_intCount + 5), B
;	.line	1027; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR2]();
	MOVFF	(_intFunction + 6), r0x00
	MOVFF	(_intFunction + 7), r0x01
	MOVFF	(_intFunction + 8), r0x02
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00354_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00354_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00354_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x02, PCLATU
	MOVFF	r0x01, PCLATH
	MOVF	r0x00, W
	MOVWF	PCL
_00354_DS_:
_00328_DS_:
;	.line	1033; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (PIE2bits.TMR3IE && PIR2bits.TMR3IF)
	BTFSS	_PIE2bits, 1
	BRA	_00333_DS_
	BTFSS	_PIR2bits, 1
	BRA	_00333_DS_
;	.line	1035; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T3CONbits.TMR3ON = OFF;
	BCF	_T3CONbits, 0
;	.line	1036; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR3H = preloadH[INT_TMR3];
	MOVFF	(_preloadH + 3), _TMR3H
;	.line	1037; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR3L = preloadL[INT_TMR3];
	MOVFF	(_preloadL + 3), _TMR3L
;	.line	1038; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIR2bits.TMR3IF = 0;
	BCF	_PIR2bits, 1
;	.line	1039; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intCount[INT_TMR3]++ >= intCountLimit[INT_TMR3])
	MOVFF	(_intCount + 6), r0x00
	MOVFF	(_intCount + 7), r0x01
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x02
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x02, W
	BANKSEL	(_intCount + 6)
	MOVWF	(_intCount + 6), B
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_intCount + 7), B
	BANKSEL	(_intCountLimit + 7)
	MOVF	(_intCountLimit + 7), W, B
	SUBWF	r0x01, W
	BNZ	_00355_DS_
; removed redundant BANKSEL
	MOVF	(_intCountLimit + 6), W, B
	SUBWF	r0x00, W
_00355_DS_:
	BNC	_00333_DS_
	BANKSEL	(_intCount + 6)
;	.line	1041; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR3] = 0;
	CLRF	(_intCount + 6), B
; removed redundant BANKSEL
	CLRF	(_intCount + 7), B
;	.line	1042; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR3]();
	MOVFF	(_intFunction + 9), r0x00
	MOVFF	(_intFunction + 10), r0x01
	MOVFF	(_intFunction + 11), r0x02
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00356_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00356_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00356_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x02, PCLATU
	MOVFF	r0x01, PCLATH
	MOVF	r0x00, W
	MOVWF	PCL
_00356_DS_:
_00333_DS_:
;	.line	1132; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	int_start();
	CALL	_int_start
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__userhighinterrupt	code
_userhighinterrupt:
;	.line	958; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	}
	RETURN	

; ; Starting pCode block
S_main__OnTimer3	code
_OnTimer3:
;	.line	517; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void OnTimer3(callback func, u8 timediv, u16 delay)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	519; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	u8 _t3con = 0;
	CLRF	r0x06
	BANKSEL	(_intUsed + 3)
;	.line	521; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intUsed[INT_TMR3] == INT_NOT_USED)
	MOVF	(_intUsed + 3), W, B
	BTFSS	STATUS, 2
	BRA	_00298_DS_
;	.line	523; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intUsed[INT_TMR3] = INT_USED;
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_intUsed + 3), B
	BANKSEL	(_intCount + 6)
;	.line	524; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR3] = 0;
	CLRF	(_intCount + 6), B
; removed redundant BANKSEL
	CLRF	(_intCount + 7), B
;	.line	525; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR3] = delay;
	MOVF	r0x04, W
	BANKSEL	(_intCountLimit + 6)
	MOVWF	(_intCountLimit + 6), B
	MOVF	r0x05, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 7), B
;	.line	526; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR3] = func;
	MOVF	r0x00, W
	BANKSEL	(_intFunction + 9)
	MOVWF	(_intFunction + 9), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 10), B
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 11), B
;	.line	528; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	switch(timediv)
	MOVLW	0x01
	SUBWF	r0x03, W
	BTFSS	STATUS, 0
	BRA	_00295_DS_
	MOVLW	0x04
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_00295_DS_
	DECF	r0x03, F
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x03, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_00305_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00305_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00305_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_00305_DS_:
	GOTO	_00292_DS_
	GOTO	_00293_DS_
	GOTO	_00294_DS_
_00292_DS_:
	BANKSEL	(_preloadH + 3)
;	.line	532; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR3] = high8(0xFFFF - 12);
	SETF	(_preloadH + 3), B
;	.line	533; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR3] =  low8(0xFFFF - 12);
	MOVLW	0xf3
	BANKSEL	(_preloadL + 3)
	MOVWF	(_preloadL + 3), B
;	.line	534; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t3con = T3_OFF & T3_16BIT & T3_PS_1_1 & T3_INT_CLK;
	MOVLW	0xcc
	MOVWF	r0x06
;	.line	535; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00295_DS_
_00293_DS_:
;	.line	539; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR3] = high8(0xFFFF - 1500);
	MOVLW	0xfa
	BANKSEL	(_preloadH + 3)
	MOVWF	(_preloadH + 3), B
;	.line	540; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR3] =  low8(0xFFFF - 1500);
	MOVLW	0x23
	BANKSEL	(_preloadL + 3)
	MOVWF	(_preloadL + 3), B
;	.line	541; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t3con = T3_OFF & T3_16BIT & T3_PS_1_8 & T3_INT_CLK;
	MOVLW	0xfc
	MOVWF	r0x06
;	.line	542; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00295_DS_
_00294_DS_:
;	.line	547; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR3] = high8(0xFFFF - 60000);
	MOVLW	0x15
	BANKSEL	(_preloadH + 3)
	MOVWF	(_preloadH + 3), B
;	.line	548; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR3] =  low8(0xFFFF - 60000);
	MOVLW	0x9f
	BANKSEL	(_preloadL + 3)
	MOVWF	(_preloadL + 3), B
;	.line	549; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR3] = delay * 25;
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x19
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	(_intCountLimit + 6)
	MOVWF	(_intCountLimit + 6), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 7), B
;	.line	550; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t3con = T3_OFF & T3_16BIT & T3_PS_1_8 & T3_INT_CLK;
	MOVLW	0xfc
	MOVWF	r0x06
_00295_DS_:
;	.line	554; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	IPR2bits.TMR3IP = INT_LOW_PRIORITY;
	BCF	_IPR2bits, 1
;	.line	555; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.TMR3IE = INT_ENABLE;
	BSF	_PIE2bits, 1
;	.line	556; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIR2bits.TMR3IF = 0;
	BCF	_PIR2bits, 1
;	.line	557; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR3H = preloadH[INT_TMR3];
	MOVFF	(_preloadH + 3), _TMR3H
;	.line	558; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR3L = preloadL[INT_TMR3];
	MOVFF	(_preloadL + 3), _TMR3L
;	.line	559; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T3CON = _t3con;
	MOVFF	r0x06, _T3CON
_00298_DS_:
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__OnTimer2	code
_OnTimer2:
;	.line	466; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void OnTimer2(callback func, u8 timediv, u16 delay)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	468; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	u8 _t2con = 0;
	CLRF	r0x06
;	.line	469; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	u8 _pr2 = 0;
	CLRF	r0x07
	BANKSEL	(_intUsed + 2)
;	.line	471; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intUsed[INT_TMR2] == INT_NOT_USED)
	MOVF	(_intUsed + 2), W, B
	BTFSS	STATUS, 2
	BRA	_00280_DS_
;	.line	473; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intUsed[INT_TMR2] = INT_USED;
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_intUsed + 2), B
	BANKSEL	(_intCount + 4)
;	.line	474; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR2] = 0;
	CLRF	(_intCount + 4), B
; removed redundant BANKSEL
	CLRF	(_intCount + 5), B
;	.line	475; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR2] = delay;
	MOVF	r0x04, W
	BANKSEL	(_intCountLimit + 4)
	MOVWF	(_intCountLimit + 4), B
	MOVF	r0x05, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 5), B
;	.line	476; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR2] = func;
	MOVF	r0x00, W
	BANKSEL	(_intFunction + 6)
	MOVWF	(_intFunction + 6), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 7), B
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 8), B
;	.line	479; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	switch(timediv)
	MOVLW	0x01
	SUBWF	r0x03, W
	BTFSS	STATUS, 0
	BRA	_00277_DS_
	MOVLW	0x04
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_00277_DS_
	DECF	r0x03, F
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	CLRF	r0x09
	RLCF	r0x03, W
	RLCF	r0x09, F
	RLCF	WREG, W
	RLCF	r0x09, F
	ANDLW	0xfc
	MOVWF	r0x08
	MOVLW	UPPER(_00287_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00287_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00287_DS_)
	ADDWF	r0x08, F
	MOVF	r0x09, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x08, W
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVWF	PCL
_00287_DS_:
	GOTO	_00274_DS_
	GOTO	_00275_DS_
	GOTO	_00276_DS_
_00274_DS_:
;	.line	483; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_pr2 = 12;
	MOVLW	0x0c
	MOVWF	r0x07
;	.line	484; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t2con = T2_OFF & T2_PS_1_1 & T2_POST_1_1;
	MOVLW	0x08
	MOVWF	r0x06
;	.line	485; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00277_DS_
_00275_DS_:
;	.line	489; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_pr2 = 50;
	MOVLW	0x32
	MOVWF	r0x07
;	.line	490; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t2con = T2_OFF & T2_POST_1_15 & T2_PS_1_16;
	MOVLW	0xeb
	MOVWF	r0x06
;	.line	491; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00277_DS_
_00276_DS_:
;	.line	495; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_pr2 = 250;
	MOVLW	0xfa
	MOVWF	r0x07
;	.line	496; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR2] = delay * 200;
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0xc8
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	(_intCountLimit + 4)
	MOVWF	(_intCountLimit + 4), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 5), B
;	.line	497; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t2con = T2_OFF & T2_POST_1_15 & T2_PS_1_16;
	MOVLW	0xeb
	MOVWF	r0x06
_00277_DS_:
;	.line	501; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	IPR1bits.TMR2IP = INT_LOW_PRIORITY;
	BCF	_IPR1bits, 1
;	.line	502; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.TMR2IE = INT_ENABLE;
	BSF	_PIE1bits, 1
;	.line	503; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIR1bits.TMR2IF = 0;
	BCF	_PIR1bits, 1
;	.line	504; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PR2 = _pr2;	// Timer2 Match value
	MOVFF	r0x07, _PR2
;	.line	505; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T2CON = _t2con;
	MOVFF	r0x06, _T2CON
_00280_DS_:
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__OnTimer1	code
_OnTimer1:
;	.line	412; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void OnTimer1(callback func, u8 timediv, u16 delay)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	414; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	u8 _t1con = 0;
	CLRF	r0x06
	BANKSEL	(_intUsed + 1)
;	.line	416; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intUsed[INT_TMR1] == INT_NOT_USED)
	MOVF	(_intUsed + 1), W, B
	BTFSS	STATUS, 2
	BRA	_00262_DS_
;	.line	418; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intUsed[INT_TMR1] = INT_USED;
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_intUsed + 1), B
	BANKSEL	(_intCount + 2)
;	.line	419; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR1] = 0;
	CLRF	(_intCount + 2), B
; removed redundant BANKSEL
	CLRF	(_intCount + 3), B
;	.line	420; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR1] = delay;
	MOVF	r0x04, W
	BANKSEL	(_intCountLimit + 2)
	MOVWF	(_intCountLimit + 2), B
	MOVF	r0x05, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 3), B
;	.line	421; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR1] = func;
	MOVF	r0x00, W
	BANKSEL	(_intFunction + 3)
	MOVWF	(_intFunction + 3), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 4), B
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 5), B
;	.line	423; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	switch(timediv)
	MOVLW	0x01
	SUBWF	r0x03, W
	BTFSS	STATUS, 0
	BRA	_00259_DS_
	MOVLW	0x04
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_00259_DS_
	DECF	r0x03, F
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x03, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_00269_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00269_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00269_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_00269_DS_:
	GOTO	_00256_DS_
	GOTO	_00257_DS_
	GOTO	_00258_DS_
_00256_DS_:
	BANKSEL	(_preloadH + 1)
;	.line	427; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR1] = high8(0xFFFF - 12);
	SETF	(_preloadH + 1), B
;	.line	428; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR1] =  low8(0xFFFF - 12);
	MOVLW	0xf3
	BANKSEL	(_preloadL + 1)
	MOVWF	(_preloadL + 1), B
;	.line	429; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t1con = T1_OFF & T1_16BIT & T1_PS_1_1 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_OFF & T1_SOURCE_INT;
	MOVLW	0x84
	MOVWF	r0x06
;	.line	430; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00259_DS_
_00257_DS_:
;	.line	434; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR1] = high8(0xFFFF - 1500);
	MOVLW	0xfa
	BANKSEL	(_preloadH + 1)
	MOVWF	(_preloadH + 1), B
;	.line	435; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR1] =  low8(0xFFFF - 1500);
	MOVLW	0x23
	BANKSEL	(_preloadL + 1)
	MOVWF	(_preloadL + 1), B
;	.line	436; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t1con = T1_OFF & T1_16BIT & T1_PS_1_8 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_OFF & T1_SOURCE_INT;
	MOVLW	0xb4
	MOVWF	r0x06
;	.line	437; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00259_DS_
_00258_DS_:
;	.line	442; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR1] = high8(0xFFFF - 60000); // 62500
	MOVLW	0x15
	BANKSEL	(_preloadH + 1)
	MOVWF	(_preloadH + 1), B
;	.line	443; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR1] =  low8(0xFFFF - 60000);
	MOVLW	0x9f
	BANKSEL	(_preloadL + 1)
	MOVWF	(_preloadL + 1), B
;	.line	444; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR1] = delay * 25;
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x19
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	(_intCountLimit + 2)
	MOVWF	(_intCountLimit + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 3), B
;	.line	445; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t1con = T1_OFF & T1_16BIT & T1_PS_1_8 & T1_RUN_FROM_ANOTHER & T1_OSC_OFF & T1_SYNC_EXT_OFF & T1_SOURCE_INT;
	MOVLW	0xb4
	MOVWF	r0x06
_00259_DS_:
;	.line	449; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	IPR1bits.TMR1IP = INT_LOW_PRIORITY;
	BCF	_IPR1bits, 0
;	.line	450; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.TMR1IE = INT_ENABLE;
	BSF	_PIE1bits, 0
;	.line	451; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIR1bits.TMR1IF = 0;
	BCF	_PIR1bits, 0
;	.line	452; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR1H = preloadH[INT_TMR1];
	MOVFF	(_preloadH + 1), _TMR1H
;	.line	453; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR1L = preloadL[INT_TMR1];
	MOVFF	(_preloadL + 1), _TMR1L
;	.line	454; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T1CON = _t1con;
	MOVFF	r0x06, _T1CON
_00262_DS_:
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__OnTimer0	code
_OnTimer0:
;	.line	360; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void OnTimer0(callback func, u8 timediv, u16 delay)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	362; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	u8 _t0con = 0;
	CLRF	r0x06
	BANKSEL	_intUsed
;	.line	364; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	if (intUsed[INT_TMR0] == INT_NOT_USED)
	MOVF	_intUsed, W, B
	BTFSS	STATUS, 2
	BRA	_00244_DS_
;	.line	366; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intUsed[INT_TMR0] = INT_USED;
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	_intUsed, B
	BANKSEL	_intCount
;	.line	367; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCount[INT_TMR0] = 0;
	CLRF	_intCount, B
; removed redundant BANKSEL
	CLRF	(_intCount + 1), B
;	.line	368; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intCountLimit[INT_TMR0] = delay;
	MOVF	r0x04, W
	BANKSEL	_intCountLimit
	MOVWF	_intCountLimit, B
	MOVF	r0x05, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 1), B
;	.line	369; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intFunction[INT_TMR0] = func;
	MOVF	r0x00, W
	BANKSEL	_intFunction
	MOVWF	_intFunction, B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 1), B
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 2), B
;	.line	371; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	switch(timediv)
	MOVLW	0x01
	SUBWF	r0x03, W
	BTFSS	STATUS, 0
	BRA	_00241_DS_
	MOVLW	0x04
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_00241_DS_
	DECF	r0x03, F
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x03, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_00251_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00251_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00251_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_00251_DS_:
	GOTO	_00238_DS_
	GOTO	_00239_DS_
	GOTO	_00240_DS_
_00238_DS_:
	BANKSEL	_preloadH
;	.line	375; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR0] = high8(0xFFFF - 12);
	SETF	_preloadH, B
;	.line	376; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR0] =  low8(0xFFFF - 12);
	MOVLW	0xf3
	BANKSEL	_preloadL
	MOVWF	_preloadL, B
;	.line	377; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_OFF;
	MOVLW	0x1f
	MOVWF	r0x06
;	.line	378; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00241_DS_
_00239_DS_:
;	.line	382; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR0] = high8(0xFFFF - 1500);
	MOVLW	0xfa
	BANKSEL	_preloadH
	MOVWF	_preloadH, B
;	.line	383; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR0] =  low8(0xFFFF - 1500);
	MOVLW	0x23
	BANKSEL	_preloadL
	MOVWF	_preloadL, B
;	.line	384; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_ON & T0_PS_1_8;
	MOVLW	0x12
	MOVWF	r0x06
;	.line	385; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00241_DS_
_00240_DS_:
;	.line	389; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadH[INT_TMR0] = high8(0xFFFF - 46875);
	MOVLW	0x48
	BANKSEL	_preloadH
	MOVWF	_preloadH, B
;	.line	390; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	preloadL[INT_TMR0] =  low8(0xFFFF - 46875);
	MOVLW	0xe4
	BANKSEL	_preloadL
	MOVWF	_preloadL, B
;	.line	391; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_ON & T0_PS_1_256;
	MOVLW	0x17
	MOVWF	r0x06
_00241_DS_:
;	.line	395; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCON2bits.TMR0IP = INT_LOW_PRIORITY;
	BCF	_INTCON2bits, 2
;	.line	396; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.TMR0IE = INT_ENABLE;
	BSF	_INTCONbits, 5
;	.line	397; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	398; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR0H = preloadH[INT_TMR0];
	MOVFF	_preloadH, _TMR0H
;	.line	399; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	TMR0L = preloadL[INT_TMR0];
	MOVFF	_preloadL, _TMR0L
;	.line	400; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T0CON = _t0con;
	MOVFF	r0x06, _T0CON
_00244_DS_:
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__int_stop	code
_int_stop:
;	.line	333; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T0CONbits.TMR0ON = OFF;
	BCF	_T0CONbits, 7
;	.line	337; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T1CONbits.TMR1ON = OFF;
	BCF	_T1CONbits, 0
;	.line	341; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T2CONbits.TMR2ON = OFF;
	BCF	_T2CONbits, 2
;	.line	345; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T3CONbits.TMR3ON = OFF;
	BCF	_T3CONbits, 0
	RETURN	

; ; Starting pCode block
S_main__int_start	code
_int_start:
;	.line	307; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T0CONbits.TMR0ON = ON;
	BSF	_T0CONbits, 7
;	.line	311; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T1CONbits.TMR1ON = ON;
	BSF	_T1CONbits, 0
;	.line	315; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T2CONbits.TMR2ON = ON;
	BSF	_T2CONbits, 2
;	.line	319; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	T3CONbits.TMR3ON = ON;
	BSF	_T3CONbits, 0
	RETURN	

; ; Starting pCode block
S_main__int_init	code
_int_init:
;	.line	285; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void int_init()
	MOVFF	r0x00, POSTDEC1
;	.line	289; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	RCONbits.IPEN = 1;					// Enable HP/LP interrupts
	BSF	_RCONbits, 7
;	.line	290; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.GIEH = 1;				// Enable HP interrupts
	BSF	_INTCONbits, 7
;	.line	291; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.GIEL = 1;				// Enable LP interrupts
	BSF	_INTCONbits, 6
;	.line	293; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
	CLRF	r0x00
_00214_DS_:
	MOVLW	0x14
	SUBWF	r0x00, W
	BC	_00218_DS_
;	.line	294; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	detachInterrupt(i);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_detachInterrupt
	INCF	FSR1L, F
;	.line	293; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
	INCF	r0x00, F
	BRA	_00214_DS_
_00218_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__detachInterrupt	code
_detachInterrupt:
;	.line	207; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	void detachInterrupt(u8 inter)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	209; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	intUsed[inter] = INT_NOT_USED;	// This interrupt is no longer used
	MOVLW	LOW(_intUsed)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_intUsed)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	CLRF	INDF0
;	.line	211; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	switch(inter)
	MOVLW	0x13
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00205_DS_
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	CLRF	r0x04
	RLCF	r0x00, W
	RLCF	r0x04, F
	RLCF	WREG, W
	RLCF	r0x04, F
	ANDLW	0xfc
	MOVWF	r0x03
	MOVLW	UPPER(_00209_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00209_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00209_DS_)
	ADDWF	r0x03, F
	MOVF	r0x04, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVWF	PCL
_00209_DS_:
	GOTO	_00188_DS_
	GOTO	_00189_DS_
	GOTO	_00190_DS_
	GOTO	_00191_DS_
	GOTO	_00185_DS_
	GOTO	_00186_DS_
	GOTO	_00187_DS_
	GOTO	_00192_DS_
	GOTO	_00197_DS_
	GOTO	_00198_DS_
	GOTO	_00200_DS_
	GOTO	_00195_DS_
	GOTO	_00196_DS_
	GOTO	_00194_DS_
	GOTO	_00199_DS_
	GOTO	_00201_DS_
	GOTO	_00203_DS_
	GOTO	_00202_DS_
	GOTO	_00193_DS_
_00185_DS_:
;	.line	214; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.INT0IE = INT_DISABLE;
	BCF	_INTCONbits, 4
;	.line	215; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00186_DS_:
;	.line	217; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCON3bits.INT1IE = INT_DISABLE;
	BCF	_INTCON3bits, 3
;	.line	218; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00187_DS_:
;	.line	220; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCON3bits.INT2IE = INT_DISABLE;
	BCF	_INTCON3bits, 4
;	.line	221; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00188_DS_:
;	.line	223; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.TMR0IE = INT_DISABLE;
	BCF	_INTCONbits, 5
;	.line	224; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00189_DS_:
;	.line	226; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.TMR1IE = INT_DISABLE;
	BCF	_PIE1bits, 0
;	.line	227; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00190_DS_:
;	.line	229; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.TMR2IE = INT_DISABLE;
	BCF	_PIE1bits, 1
;	.line	230; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00191_DS_:
;	.line	232; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.TMR3IE = INT_DISABLE;
	BCF	_PIE2bits, 1
;	.line	233; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00192_DS_:
;	.line	235; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	INTCONbits.RBIE = INT_DISABLE;
	BCF	_INTCONbits, 3
;	.line	236; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00193_DS_:
;	.line	238; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.USBIE = INT_DISABLE;
	BCF	_PIE2bits, 5
;	.line	239; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00194_DS_:
;	.line	241; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.ADIE = INT_DISABLE;
	BCF	_PIE1bits, 6
;	.line	242; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00195_DS_:
;	.line	244; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.RCIE = INT_DISABLE;
	BCF	_PIE1bits, 5
;	.line	245; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00196_DS_:
;	.line	247; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.TXIE = INT_DISABLE;
	BCF	_PIE1bits, 4
;	.line	248; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00197_DS_:
;	.line	250; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE1bits.CCP1IE = INT_DISABLE;
	BCF	_PIE1bits, 2
;	.line	251; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00198_DS_:
;	.line	253; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.CCP2IE = INT_DISABLE;
	BCF	_PIE2bits, 0
;	.line	254; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00199_DS_:
;	.line	256; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.OSCFIE = INT_DISABLE;
	BCF	_PIE2bits, 7
;	.line	257; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00200_DS_:
;	.line	259; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.CMIE = INT_DISABLE;
	BCF	_PIE2bits, 6
;	.line	260; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00201_DS_:
;	.line	262; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.EEIE = INT_DISABLE;
	BCF	_PIE2bits, 4
;	.line	263; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00202_DS_:
;	.line	265; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.BCLIE = INT_DISABLE;
	BCF	_PIE2bits, 3
;	.line	266; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	break;
	BRA	_00205_DS_
_00203_DS_:
;	.line	268; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	PIE2bits.HLVDIE = INT_DISABLE;
	BCF	_PIE2bits, 2
_00205_DS_:
;	.line	275; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/interrupt.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__toggle	code
_toggle:
;	.line	93; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	void toggle(u8 pin)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	96; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	val = digitalread(pin);
	CLRF	r0x01
	CLRF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_digitalread
	MOVWF	r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	97; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	digitalwrite(pin, val^1);
	MOVLW	0x01
	XORWF	r0x02, F
	CLRF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_digitalwrite
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__pinmode	code
_pinmode:
;	.line	69; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	void pinmode(int input, int state)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	71; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	switch (port[input])
	MOVLW	LOW(_port)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_port)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_port)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVLW	0x03
	SUBWF	r0x04, W
	BTFSC	STATUS, 0
	BRA	_00168_DS_
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x04, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_00175_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00175_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00175_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_00175_DS_:
	GOTO	_00155_DS_
	GOTO	_00159_DS_
	GOTO	_00163_DS_
_00155_DS_:
;	.line	73; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 0: if (state) TRISB=TRISB | mask[input];
	MOVF	r0x02, W
	IORWF	r0x03, W
	BZ	_00157_DS_
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	IORWF	_TRISB, F
	BRA	_00168_DS_
_00157_DS_:
;	.line	74; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else TRISB=TRISB & (255-mask[input]);
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	SUBLW	0xff
; #	MOVWF	r0x04
; #	MOVF	r0x04, W
	ANDWF	_TRISB, F
;	.line	75; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	break;
	BRA	_00168_DS_
_00159_DS_:
;	.line	76; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 1: if (state) TRISC=TRISC | mask[input];
	MOVF	r0x02, W
	IORWF	r0x03, W
	BZ	_00161_DS_
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	IORWF	_TRISC, F
	BRA	_00168_DS_
_00161_DS_:
;	.line	77; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else TRISC=TRISC & (255-mask[input]);
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	SUBLW	0xff
; #	MOVWF	r0x04
; #	MOVF	r0x04, W
	ANDWF	_TRISC, F
;	.line	78; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	break;
	BRA	_00168_DS_
_00163_DS_:
;	.line	79; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 2: if (state) TRISA=TRISA | mask[input];
	MOVF	r0x02, W
	IORWF	r0x03, W
	BZ	_00165_DS_
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	UPPER(_mask)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVF	r0x02, W
	IORWF	_TRISA, F
	BRA	_00168_DS_
_00165_DS_:
;	.line	80; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else TRISA=TRISA & (255-mask[input]);
	CLRF	r0x02
	BTFSC	r0x01, 7
	SETF	r0x02
	MOVLW	LOW(_mask)
	ADDWF	r0x00, F
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, F
	MOVLW	UPPER(_mask)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	MOVF	r0x00, W
	SUBLW	0xff
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	ANDWF	_TRISA, F
_00168_DS_:
;	.line	90; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	}
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__digitalread	code
_digitalread:
;	.line	44; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	int digitalread(int input)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	46; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	switch (port[input])
	MOVLW	LOW(_port)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_port)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	UPPER(_port)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVLW	0x03
	SUBWF	r0x02, W
	BTFSC	STATUS, 0
	BRA	_00142_DS_
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	CLRF	r0x06
	RLCF	r0x02, W
	RLCF	r0x06, F
	RLCF	WREG, W
	RLCF	r0x06, F
	ANDLW	0xfc
	MOVWF	r0x05
	MOVLW	UPPER(_00150_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00150_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00150_DS_)
	ADDWF	r0x05, F
	MOVF	r0x06, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x05, W
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVWF	PCL
_00150_DS_:
	GOTO	_00130_DS_
	GOTO	_00134_DS_
	GOTO	_00138_DS_
_00130_DS_:
;	.line	48; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 0: if ((PORTB & mask[input])!=0) return (1);
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	UPPER(_mask)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVF	_PORTB, W
	ANDWF	r0x02, F
	MOVF	r0x02, W
	BZ	_00132_DS_
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00143_DS_
_00132_DS_:
;	.line	49; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else return (0);
	CLRF	PRODL
	CLRF	WREG
	BRA	_00143_DS_
_00134_DS_:
;	.line	51; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 1: if ((PORTC & mask[input])!=0) return (1);
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	UPPER(_mask)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVF	_PORTC, W
	ANDWF	r0x02, F
	MOVF	r0x02, W
	BZ	_00136_DS_
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00143_DS_
_00136_DS_:
;	.line	52; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else return (0);
	CLRF	PRODL
	CLRF	WREG
	BRA	_00143_DS_
_00138_DS_:
;	.line	54; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 2: if ((PORTA & mask[input])!=0) return (1);
	CLRF	r0x02
	BTFSC	r0x01, 7
	SETF	r0x02
	MOVLW	LOW(_mask)
	ADDWF	r0x00, F
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, F
	MOVLW	UPPER(_mask)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	MOVF	_PORTA, W
	ANDWF	r0x00, F
	MOVF	r0x00, W
	BZ	_00140_DS_
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00143_DS_
_00140_DS_:
;	.line	55; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else return (0);
	CLRF	PRODL
	CLRF	WREG
	BRA	_00143_DS_
_00142_DS_:
;	.line	66; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	return (0);
	CLRF	PRODL
	CLRF	WREG
_00143_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__digitalwrite	code
_digitalwrite:
;	.line	20; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	void digitalwrite(int output,int state)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	22; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	switch (port[output])
	MOVLW	LOW(_port)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_port)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_port)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVLW	0x03
	SUBWF	r0x04, W
	BTFSC	STATUS, 0
	BRA	_00118_DS_
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x04, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_00125_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00125_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00125_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_00125_DS_:
	GOTO	_00105_DS_
	GOTO	_00109_DS_
	GOTO	_00113_DS_
_00105_DS_:
;	.line	24; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 0: if (state) PORTB=PORTB | mask[output]; 
	MOVF	r0x02, W
	IORWF	r0x03, W
	BZ	_00107_DS_
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	IORWF	_PORTB, F
	BRA	_00118_DS_
_00107_DS_:
;	.line	25; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else PORTB=PORTB & (255-mask[output]);
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	SUBLW	0xff
; #	MOVWF	r0x04
; #	MOVF	r0x04, W
	ANDWF	_PORTB, F
;	.line	26; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	break;
	BRA	_00118_DS_
_00109_DS_:
;	.line	27; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 1: if (state) PORTC=PORTC | mask[output];
	MOVF	r0x02, W
	IORWF	r0x03, W
	BZ	_00111_DS_
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	IORWF	_PORTC, F
	BRA	_00118_DS_
_00111_DS_:
;	.line	28; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else PORTC=PORTC & (255-mask[output]);
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	BTFSC	r0x01, 7
	SETF	r0x06
	MOVLW	UPPER(_mask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	MOVF	r0x04, W
	SUBLW	0xff
; #	MOVWF	r0x04
; #	MOVF	r0x04, W
	ANDWF	_PORTC, F
;	.line	29; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	break;
	BRA	_00118_DS_
_00113_DS_:
;	.line	30; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	case 2: if (state) PORTA=PORTA | mask[output];
	MOVF	r0x02, W
	IORWF	r0x03, W
	BZ	_00115_DS_
	MOVLW	LOW(_mask)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	UPPER(_mask)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVF	r0x02, W
	IORWF	_PORTA, F
	BRA	_00118_DS_
_00115_DS_:
;	.line	31; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	else PORTA=PORTA & (255-mask[output]);
	CLRF	r0x02
	BTFSC	r0x01, 7
	SETF	r0x02
	MOVLW	LOW(_mask)
	ADDWF	r0x00, F
	MOVLW	HIGH(_mask)
	ADDWFC	r0x01, F
	MOVLW	UPPER(_mask)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	MOVF	r0x00, W
	SUBLW	0xff
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	ANDWF	_PORTA, F
_00118_DS_:
;	.line	41; C:/Users/jpm/Documents/pinguino32x_windows/tools/bin/../include/pic16/digitalw.c	}
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block for Ival
	code
_mask:
	DB	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x40, 0x80, 0x01, 0x02
	DB	0x04, 0x01, 0x02, 0x04, 0x08, 0x20
; ; Starting pCode block for Ival
_port:
	DB	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01
	DB	0x01, 0x02, 0x02, 0x02, 0x02, 0x02


; Statistics:
; code size:	 3984 (0x0f90) bytes ( 3.04%)
;           	 1992 (0x07c8) words
; udata size:	  104 (0x0068) bytes ( 5.80%)
; access size:	   10 (0x000a) bytes


	end
