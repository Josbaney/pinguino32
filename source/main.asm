;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Aug  9 2009) (UNIX)
; This file was generated Tue Aug 30 22:15:46 2011
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
	global _userhighinterrupt
	global _userinterrupt
	global _epap_in
	global _epap_out
	global _epapin_init
	global _epapout_init
	global _blink0
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
;	.line	130; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	void high_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	191; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	}
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
;	.line	194; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	void low_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	197; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	userinterrupt();
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
;	.line	58; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	PIE1 = 0;
	CLRF	_PIE1
;	.line	59; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	PIE2 = 0;
	CLRF	_PIE2
;	.line	60; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	ADCON1 = 0b00001111;				// AN0 to AN12 Digital I/O
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	63; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	int_init();							// Disable all interrupts
	CALL	_int_init
;	.line	72; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	setup();
	CALL	_setup
;	.line	75; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	int_start();							// Enable all timers interrupts
	CALL	_int_start
_00313_DS_:
;	.line	124; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	loop();
	CALL	_loop
	BRA	_00313_DS_
	RETURN	

; ; Starting pCode block
S_main__loop	code
_loop:
;	.line	27; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/user.c	}
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	21; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/user.c	pinmode(LED0, OUTPUT);
	MOVLW	0x00
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CALL	_pinmode
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	22; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/user.c	OnTimer0(blink0, INT_MILLISEC, 500);	
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
	RETURN	

; ; Starting pCode block
S_main__blink0	code
_blink0:
;	.line	16; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/user.c	toggle(LED0);
	MOVLW	0x00
	CLRF	POSTDEC1
	CALL	_toggle
	INCF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__epapout_init	code
_epapout_init:
;	.line	46; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	void epapout_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epapin_init	code
_epapin_init:
;	.line	45; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	void epapin_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_out	code
_epap_out:
;	.line	44; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	void epap_out() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_in	code
_epap_in:
;	.line	43; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/source/main.c	void epap_in() { return; }
	RETURN	

; ; Starting pCode block
S_main__userinterrupt	code
_userinterrupt:
;	.line	1026; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	void userinterrupt()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	1050; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	if (INTCONbits.TMR0IE && INTCONbits.TMR0IF)
	BTFSS	_INTCONbits, 5
	BRA	_00264_DS_
	BTFSS	_INTCONbits, 2
	BRA	_00264_DS_
;	.line	1052; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	T0CONbits.TMR0ON = OFF;
	BCF	_T0CONbits, 7
;	.line	1053; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	TMR0H = preloadH[INT_TMR0];
	MOVFF	_preloadH, _TMR0H
;	.line	1054; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	TMR0L = preloadL[INT_TMR0];
	MOVFF	_preloadL, _TMR0L
;	.line	1055; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	1056; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	if (intCount[INT_TMR0]++ >= intCountLimit[INT_TMR0])
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
	BNZ	_00271_DS_
; removed redundant BANKSEL
	MOVF	_intCountLimit, W, B
	SUBWF	r0x00, W
_00271_DS_:
	BNC	_00264_DS_
	BANKSEL	_intCount
;	.line	1058; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intCount[INT_TMR0] = 0;
	CLRF	_intCount, B
; removed redundant BANKSEL
	CLRF	(_intCount + 1), B
;	.line	1059; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intFunction[INT_TMR0]();
	MOVFF	_intFunction, r0x00
	MOVFF	(_intFunction + 1), r0x01
	MOVFF	(_intFunction + 2), r0x02
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00272_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00272_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00272_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x02, PCLATU
	MOVFF	r0x01, PCLATH
	MOVF	r0x00, W
	MOVWF	PCL
_00272_DS_:
_00264_DS_:
;	.line	1190; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	int_start();
	CALL	_int_start
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__userhighinterrupt	code
_userhighinterrupt:
;	.line	1016; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	}
	RETURN	

; ; Starting pCode block
S_main__OnTimer0	code
_OnTimer0:
;	.line	377; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	void OnTimer0(callback func, u8 timediv, u16 delay)
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
;	.line	379; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	u8 _t0con = 0;
	CLRF	r0x06
	BANKSEL	_intUsed
;	.line	381; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	if (intUsed[INT_TMR0] == INT_NOT_USED)
	MOVF	_intUsed, W, B
	BTFSS	STATUS, 2
	BRA	_00244_DS_
;	.line	383; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intUsed[INT_TMR0] = INT_USED;
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	_intUsed, B
	BANKSEL	_intCount
;	.line	384; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intCount[INT_TMR0] = 0;
	CLRF	_intCount, B
; removed redundant BANKSEL
	CLRF	(_intCount + 1), B
;	.line	385; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intCountLimit[INT_TMR0] = delay;
	MOVF	r0x04, W
	BANKSEL	_intCountLimit
	MOVWF	_intCountLimit, B
	MOVF	r0x05, W
; removed redundant BANKSEL
	MOVWF	(_intCountLimit + 1), B
;	.line	386; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intFunction[INT_TMR0] = func;
	MOVF	r0x00, W
	BANKSEL	_intFunction
	MOVWF	_intFunction, B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 1), B
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_intFunction + 2), B
;	.line	388; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	switch(timediv)
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
;	.line	392; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	preloadH[INT_TMR0] = high8(0xFFFF - 12);
	SETF	_preloadH, B
;	.line	393; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	preloadL[INT_TMR0] =  low8(0xFFFF - 12);
	MOVLW	0xf3
	BANKSEL	_preloadL
	MOVWF	_preloadL, B
;	.line	394; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_OFF;
	MOVLW	0x1f
	MOVWF	r0x06
;	.line	395; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00241_DS_
_00239_DS_:
;	.line	399; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	preloadH[INT_TMR0] = high8(0xFFFF - 1500);
	MOVLW	0xfa
	BANKSEL	_preloadH
	MOVWF	_preloadH, B
;	.line	400; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	preloadL[INT_TMR0] =  low8(0xFFFF - 1500);
	MOVLW	0x23
	BANKSEL	_preloadL
	MOVWF	_preloadL, B
;	.line	401; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_ON & T0_PS_1_8;
	MOVLW	0x12
	MOVWF	r0x06
;	.line	402; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00241_DS_
_00240_DS_:
;	.line	406; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	preloadH[INT_TMR0] = high8(0xFFFF - 46875);
	MOVLW	0x48
	BANKSEL	_preloadH
	MOVWF	_preloadH, B
;	.line	407; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	preloadL[INT_TMR0] =  low8(0xFFFF - 46875);
	MOVLW	0xe4
	BANKSEL	_preloadL
	MOVWF	_preloadL, B
;	.line	408; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	_t0con = T0_OFF & T0_16BIT & T0_CLK & T0_PS_ON & T0_PS_1_256;
	MOVLW	0x17
	MOVWF	r0x06
_00241_DS_:
;	.line	412; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCON2bits.TMR0IP = INT_LOW_PRIORITY;
	BCF	_INTCON2bits, 2
;	.line	413; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.TMR0IE = INT_ENABLE;
	BSF	_INTCONbits, 5
;	.line	414; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
;	.line	415; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	TMR0H = preloadH[INT_TMR0];
	MOVFF	_preloadH, _TMR0H
;	.line	416; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	TMR0L = preloadL[INT_TMR0];
	MOVFF	_preloadL, _TMR0L
;	.line	417; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	T0CON = _t0con;
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
;	.line	350; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	T0CONbits.TMR0ON = OFF;
	BCF	_T0CONbits, 7
	RETURN	

; ; Starting pCode block
S_main__int_start	code
_int_start:
;	.line	324; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	T0CONbits.TMR0ON = ON;
	BSF	_T0CONbits, 7
	RETURN	

; ; Starting pCode block
S_main__int_init	code
_int_init:
;	.line	302; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	void int_init()
	MOVFF	r0x00, POSTDEC1
;	.line	306; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	RCONbits.IPEN = 1;					// Enable HP/LP interrupts
	BSF	_RCONbits, 7
;	.line	307; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.GIEH = 1;				// Enable HP interrupts
	BSF	_INTCONbits, 7
;	.line	308; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.GIEL = 1;				// Enable LP interrupts
	BSF	_INTCONbits, 6
;	.line	310; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
	CLRF	r0x00
_00214_DS_:
	MOVLW	0x14
	SUBWF	r0x00, W
	BC	_00218_DS_
;	.line	311; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	detachInterrupt(i);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_detachInterrupt
	INCF	FSR1L, F
;	.line	310; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
	INCF	r0x00, F
	BRA	_00214_DS_
_00218_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__detachInterrupt	code
_detachInterrupt:
;	.line	224; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	void detachInterrupt(u8 inter)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	226; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	intUsed[inter] = INT_NOT_USED;	// This interrupt is no longer used
	MOVLW	LOW(_intUsed)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_intUsed)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	CLRF	INDF0
;	.line	228; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	switch(inter)
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
;	.line	231; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.INT0IE = INT_DISABLE;
	BCF	_INTCONbits, 4
;	.line	232; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00186_DS_:
;	.line	234; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCON3bits.INT1IE = INT_DISABLE;
	BCF	_INTCON3bits, 3
;	.line	235; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00187_DS_:
;	.line	237; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCON3bits.INT2IE = INT_DISABLE;
	BCF	_INTCON3bits, 4
;	.line	238; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00188_DS_:
;	.line	240; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.TMR0IE = INT_DISABLE;
	BCF	_INTCONbits, 5
;	.line	241; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00189_DS_:
;	.line	243; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE1bits.TMR1IE = INT_DISABLE;
	BCF	_PIE1bits, 0
;	.line	244; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00190_DS_:
;	.line	246; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE1bits.TMR2IE = INT_DISABLE;
	BCF	_PIE1bits, 1
;	.line	247; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00191_DS_:
;	.line	249; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.TMR3IE = INT_DISABLE;
	BCF	_PIE2bits, 1
;	.line	250; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00192_DS_:
;	.line	252; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	INTCONbits.RBIE = INT_DISABLE;
	BCF	_INTCONbits, 3
;	.line	253; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00193_DS_:
;	.line	255; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.USBIE = INT_DISABLE;
	BCF	_PIE2bits, 5
;	.line	256; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00194_DS_:
;	.line	258; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE1bits.ADIE = INT_DISABLE;
	BCF	_PIE1bits, 6
;	.line	259; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00195_DS_:
;	.line	261; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE1bits.RCIE = INT_DISABLE;
	BCF	_PIE1bits, 5
;	.line	262; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00196_DS_:
;	.line	264; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE1bits.TXIE = INT_DISABLE;
	BCF	_PIE1bits, 4
;	.line	265; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00197_DS_:
;	.line	267; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE1bits.CCP1IE = INT_DISABLE;
	BCF	_PIE1bits, 2
;	.line	268; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00198_DS_:
;	.line	270; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.CCP2IE = INT_DISABLE;
	BCF	_PIE2bits, 0
;	.line	271; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00199_DS_:
;	.line	273; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.OSCFIE = INT_DISABLE;
	BCF	_PIE2bits, 7
;	.line	274; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00200_DS_:
;	.line	276; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.CMIE = INT_DISABLE;
	BCF	_PIE2bits, 6
;	.line	277; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00201_DS_:
;	.line	279; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.EEIE = INT_DISABLE;
	BCF	_PIE2bits, 4
;	.line	280; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00202_DS_:
;	.line	282; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.BCLIE = INT_DISABLE;
	BCF	_PIE2bits, 3
;	.line	283; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	break;
	BRA	_00205_DS_
_00203_DS_:
;	.line	285; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	PIE2bits.HLVDIE = INT_DISABLE;
	BCF	_PIE2bits, 2
_00205_DS_:
;	.line	292; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/interrupt.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__toggle	code
_toggle:
;	.line	131; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	void toggle(u8 pin)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	134; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	val = digitalread(pin);
	CLRF	r0x01
	CLRF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_digitalread
	MOVWF	r0x02
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	135; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	digitalwrite(pin, val^1);
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
;	.line	107; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	void pinmode(int input, int state)
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
;	.line	109; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	switch (port[input])
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
;	.line	111; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 0: if (state) TRISB=TRISB | mask[input];
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
;	.line	112; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else TRISB=TRISB & (255-mask[input]);
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
;	.line	113; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	break;
	BRA	_00168_DS_
_00159_DS_:
;	.line	114; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 1: if (state) TRISC=TRISC | mask[input];
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
;	.line	115; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else TRISC=TRISC & (255-mask[input]);
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
;	.line	116; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	break;
	BRA	_00168_DS_
_00163_DS_:
;	.line	117; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 2: if (state) TRISA=TRISA | mask[input];
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
;	.line	118; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else TRISA=TRISA & (255-mask[input]);
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
;	.line	128; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	}
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
;	.line	82; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	int digitalread(int input)
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
;	.line	84; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	switch (port[input])
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
;	.line	86; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 0: if ((PORTB & mask[input])!=0) return (1);
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
;	.line	87; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else return (0);
	CLRF	PRODL
	CLRF	WREG
	BRA	_00143_DS_
_00134_DS_:
;	.line	89; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 1: if ((PORTC & mask[input])!=0) return (1);
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
;	.line	90; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else return (0);
	CLRF	PRODL
	CLRF	WREG
	BRA	_00143_DS_
_00138_DS_:
;	.line	92; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 2: if ((PORTA & mask[input])!=0) return (1);
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
;	.line	93; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else return (0);
	CLRF	PRODL
	CLRF	WREG
	BRA	_00143_DS_
_00142_DS_:
;	.line	104; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	return (0);
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
;	.line	58; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	void digitalwrite(int output,int state)
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
;	.line	60; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	switch (port[output])
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
;	.line	62; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 0: if (state) PORTB=PORTB | mask[output]; 
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
;	.line	63; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else PORTB=PORTB & (255-mask[output]);
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
;	.line	64; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	break;
	BRA	_00118_DS_
_00109_DS_:
;	.line	65; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 1: if (state) PORTC=PORTC | mask[output];
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
;	.line	66; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else PORTC=PORTC & (255-mask[output]);
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
;	.line	67; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	break;
	BRA	_00118_DS_
_00113_DS_:
;	.line	68; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	case 2: if (state) PORTA=PORTA | mask[output];
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
;	.line	69; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	else PORTA=PORTA & (255-mask[output]);
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
;	.line	79; /home/regis/Hobbies/Electronique/Projets/Pinguino/local/branches/x.2/p8/include/pinguino/basics/digitalw.c	}
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
; code size:	 2500 (0x09c4) bytes ( 1.91%)
;           	 1250 (0x04e2) words
; udata size:	  104 (0x0068) bytes ( 5.80%)
; access size:	    9 (0x0009) bytes


	end
