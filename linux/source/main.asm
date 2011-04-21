;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Aug  9 2009) (UNIX)
; This file was generated Wed Mar 23 14:48:30 2011
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f2550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _preloadL
	global _preloadH
	global _intCountLimit
	global _intCount
	global _I2C_master
	global _I2C_slave
	global _I2C_init
	global _I2C_interrupt
	global _I2C_send
	global _I2C_get
	global _I2C_writechar
	global _I2C_readchar
	global _intUsed
	global _detachInterrupt
	global _int_init
	global _int_start
	global _int_stop
	global _userhighinterrupt
	global _userinterrupt
	global _I2C_OnRequest
	global _IC2_OnReceive
	global _epap_in
	global _epap_out
	global _epapin_init
	global _epapout_init
	global _setup
	global _loop
	global _pinguino_main
	global _high_priority_isr
	global _low_priority_isr

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

udata_main_0	udata
_intFunction	res	60

udata_main_1	udata
_intCount	res	8

udata_main_2	udata
_intCountLimit	res	8

udata_main_3	udata
_preloadH	res	4

udata_main_4	udata
_preloadL	res	4

udata_main_5	udata
__i2c_onRequest_function	res	3

udata_main_6	udata
__i2c_onReceive_function	res	3

udata_main_7	udata
_intUsed	res	20

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block
S_main__high_priority_isr	code	0X002020
_high_priority_isr:
;	.line	121; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	void high_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	172; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	I2C_interrupt();
	CALL	_I2C_interrupt
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
;	.line	185; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	void low_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	188; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	userinterrupt();
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
;	.line	53; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	PIE1 = 0;
	CLRF	_PIE1
;	.line	54; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	PIE2 = 0;
	CLRF	_PIE2
;	.line	55; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	ADCON1 = 0b00001111;				// AN0 to AN12 Digital I/O
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	58; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	int_init();							// Disable all interrupts
	CALL	_int_init
;	.line	67; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	setup();
	CALL	_setup
;	.line	70; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	int_start();							// Enable all timers interrupts
	CALL	_int_start
_00369_DS_:
;	.line	115; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	loop();
	CALL	_loop
	BRA	_00369_DS_
	RETURN	

; ; Starting pCode block
S_main__loop	code
_loop:
;	.line	8; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/user.c	}
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	3; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/user.c	I2C_slave(0x1234);
	MOVLW	0x12
	MOVWF	POSTDEC1
	MOVLW	0x34
	MOVWF	POSTDEC1
	CALL	_I2C_slave
	MOVLW	0x02
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__epapout_init	code
_epapout_init:
;	.line	41; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	void epapout_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epapin_init	code
_epapin_init:
;	.line	40; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	void epapin_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_out	code
_epap_out:
;	.line	39; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	void epap_out() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_in	code
_epap_in:
;	.line	38; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/source/main.c	void epap_in() { return; }
	RETURN	

; ; Starting pCode block
S_main__I2C_sendID	code
_I2C_sendID:
;	.line	383; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	static void I2C_sendID(u16 DeviceID, u8 r_w)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	387; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (DeviceID > 0x00FF)
	MOVLW	0x01
	SUBWF	r0x01, W
	BNZ	_00318_DS_
	MOVLW	0x00
	SUBWF	r0x00, W
_00318_DS_:
	BNC	_00310_DS_
;	.line	389; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	temp = (DeviceID >> 7) & 0x06;	// set A9 and A8 to temp.bit2 and temp.bit1
	RLCF	r0x00, W
	RLCF	r0x01, W
	MOVWF	r0x03
	MOVLW	0x06
	ANDWF	r0x03, F
;	.line	390; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	temp = temp | 0xF0 | r_w;			// set DeviceID address Hi format = 11110(A9A8)(R/W)
	MOVLW	0xf0
	IORWF	r0x03, W
; #	MOVWF	r0x04
; #	MOVF	r0x02, W
; #	IORWF	r0x04, W
	IORWF	r0x02, W
	MOVWF	r0x03
;	.line	391; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_start();
	CALL	_I2C_start
;	.line	392; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (I2C_writechar(temp) != 1)
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	INCF	FSR1L, F
	XORLW	0x01
	BZ	_00312_DS_
_00299_DS_:
;	.line	395; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_restart();
	CALL	_I2C_restart
;	.line	396; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	} while ( I2C_writechar(temp) != 1);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	INCF	FSR1L, F
	XORLW	0x01
	BNZ	_00299_DS_
;	.line	397; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	temp = (DeviceID << 1 & 0xFE) | r_w;
	MOVF	r0x00, W
	MOVWF	r0x04
	RLNCF	r0x04, W
	ANDLW	0xfe
	MOVWF	r0x05
	MOVLW	0xfe
	ANDWF	r0x05, W
; #	MOVWF	r0x04
; #	MOVF	r0x02, W
; #	IORWF	r0x04, W
	IORWF	r0x02, W
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
;	.line	398; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_writechar(temp);
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	INCF	FSR1L, F
	BRA	_00312_DS_
_00310_DS_:
;	.line	403; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	temp = DeviceID << 1 & 0xFE;
	RLNCF	r0x00, W
	ANDLW	0xfe
	MOVWF	r0x01
	MOVLW	0xfe
	ANDWF	r0x01, W
	MOVWF	r0x03
;	.line	404; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	temp = temp | r_w;
	MOVF	r0x02, W
	IORWF	r0x03, F
;	.line	405; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_start();
	CALL	_I2C_start
;	.line	406; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (I2C_writechar(temp) != 1)
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	INCF	FSR1L, F
	XORLW	0x01
	BZ	_00312_DS_
_00304_DS_:
;	.line	409; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_restart();
	CALL	_I2C_restart
;	.line	410; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	} while (I2C_writechar(temp) != 1);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	INCF	FSR1L, F
	XORLW	0x01
	BNZ	_00304_DS_
_00312_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_sendAck	code
_I2C_sendAck:
;	.line	344; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.ACKDT = 0;
	BCF	_SSPCON2bits, 5
;	.line	345; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.ACKEN = 1;
	BSF	_SSPCON2bits, 4
;	.line	346; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
	RETURN	

; ; Starting pCode block
S_main__I2C_sendNack	code
_I2C_sendNack:
;	.line	332; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.ACKDT = 1;
	BSF	_SSPCON2bits, 5
;	.line	333; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.ACKEN = 1;
	BSF	_SSPCON2bits, 4
;	.line	334; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
	RETURN	

; ; Starting pCode block
S_main__I2C_readAbort	code
_I2C_readAbort:
;	.line	320; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON1bits.WCOL = 0;
	BCF	_SSPCON1bits, 7
;	.line	321; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_stop();
	CALL	_I2C_stop
;	.line	322; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();  
	CALL	_I2C_wait
	RETURN	

; ; Starting pCode block
S_main__I2C_waitAck	code
_I2C_waitAck:
;	.line	302; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	static u8 I2C_waitAck()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	305; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	while(SSPCON2bits.ACKSTAT == 1) 
	CLRF	r0x00
_00270_DS_:
	CLRF	r0x01
	BTFSC	_SSPCON2bits, 6
	INCF	r0x01, F
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_00272_DS_
;	.line	307; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	i++;
	INCF	r0x00, F
;	.line	308; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if(i==0) return -1;
	MOVF	r0x00, W
	BNZ	_00270_DS_
	SETF	WREG
	BRA	_00273_DS_
_00272_DS_:
;	.line	310; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	return 0;
	CLRF	WREG
_00273_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__I2C_readchar	code
_I2C_readchar:
;	.line	292; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.RCEN = 1;
	BSF	_SSPCON2bits, 3
;	.line	293; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
;	.line	294; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	return (SSPBUF);
	MOVF	_SSPBUF, W
	RETURN	

; ; Starting pCode block
S_main__I2C_writechar	code
_I2C_writechar:
;	.line	278; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	u8 I2C_writechar(u8 byte)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _SSPBUF
;	.line	281; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
;	.line	282; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	return (!SSPCON2bits.ACKSTAT);
	CLRF	r0x00
	BTFSC	_SSPCON2bits, 6
	INCF	r0x00, F
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_restart	code
_I2C_restart:
;	.line	267; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.RSEN=1;
	BSF	_SSPCON2bits, 1
;	.line	268; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
	RETURN	

; ; Starting pCode block
S_main__I2C_stop	code
_I2C_stop:
;	.line	256; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.PEN = 1;
	BSF	_SSPCON2bits, 2
;	.line	257; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
	RETURN	

; ; Starting pCode block
S_main__I2C_start	code
_I2C_start:
;	.line	245; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2bits.SEN = 1;
	BSF	_SSPCON2bits, 0
;	.line	246; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_wait();
	CALL	_I2C_wait
	RETURN	

; ; Starting pCode block
S_main__I2C_wait	code
_I2C_wait:
_00235_DS_:
;	.line	234; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	while (PIR1bits.SSPIF == 0);
	BTFSS	_PIR1bits, 3
	BRA	_00235_DS_
;	.line	235; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	PIR1bits.SSPIF = 0;
	BCF	_PIR1bits, 3
	RETURN	

; ; Starting pCode block
S_main__I2C_get	code
_I2C_get:
;	.line	212; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	u8 I2C_get(u8 address)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	216; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_sendID(address, I2C_READ);
	MOVFF	r0x00, r0x01
	MOVLW	0x01
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_I2C_sendID
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	219; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_restart();
	CALL	_I2C_restart
;	.line	220; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (I2C_writechar(address) == 0) return (0);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	MOVWF	r0x00
	INCF	FSR1L, F
	MOVF	r0x00, W
	BNZ	_00229_DS_
	CLRF	WREG
	BRA	_00230_DS_
_00229_DS_:
;	.line	221; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	byte = I2C_readchar();
	CALL	_I2C_readchar
	MOVWF	r0x00
;	.line	222; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_sendNack();
	CALL	_I2C_sendNack
;	.line	223; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_stop();
	CALL	_I2C_stop
;	.line	224; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	return (byte);
	MOVF	r0x00, W
_00230_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_send	code
_I2C_send:
;	.line	197; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	u8 I2C_send(u8 address, u8 byte)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	199; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_sendID(address, I2C_WRITE);
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_I2C_sendID
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	202; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (I2C_writechar(byte) == 0) return (0);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_I2C_writechar
	MOVWF	r0x00
	INCF	FSR1L, F
	MOVF	r0x00, W
	BNZ	_00222_DS_
	CLRF	WREG
	BRA	_00223_DS_
_00222_DS_:
;	.line	203; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_stop();
	CALL	_I2C_stop
;	.line	204; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	return (1);
	MOVLW	0x01
_00223_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_interrupt	code
_I2C_interrupt:
;	.line	182; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (PIR1bits.SSPIF)
	BTFSS	_PIR1bits, 3
	BRA	_00211_DS_
;	.line	184; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	PIR1bits.SSPIF = 0;
	BCF	_PIR1bits, 3
;	.line	185; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	if (SSPSTATbits.R_W)
	BTFSS	_SSPSTATbits, 2
	BRA	_00207_DS_
;	.line	186; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	_i2c_onRequest_function();
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00215_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00215_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00215_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	(__i2c_onRequest_function + 2), PCLATU
	MOVFF	(__i2c_onRequest_function + 1), PCLATH
	BANKSEL	__i2c_onRequest_function
	MOVF	__i2c_onRequest_function, W, B
	MOVWF	PCL
_00215_DS_:
	BRA	_00211_DS_
_00207_DS_:
;	.line	188; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	_i2c_onReceive_function();
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00216_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00216_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00216_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	(__i2c_onReceive_function + 2), PCLATU
	MOVFF	(__i2c_onReceive_function + 1), PCLATH
	BANKSEL	__i2c_onReceive_function
	MOVF	__i2c_onReceive_function, W, B
	MOVWF	PCL
_00216_DS_:
_00211_DS_:
	RETURN	

; ; Starting pCode block
S_main__IC2_OnReceive	code
_IC2_OnReceive:
;	.line	170; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	void IC2_OnReceive(stdout func)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, __i2c_onReceive_function
	MOVLW	0x03
	MOVFF	PLUSW2, (__i2c_onReceive_function + 1)
	MOVLW	0x04
	MOVFF	PLUSW2, (__i2c_onReceive_function + 2)
;	.line	172; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	_i2c_onReceive_function = func;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_OnRequest	code
_I2C_OnRequest:
;	.line	160; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	void I2C_OnRequest(stdout func)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, __i2c_onRequest_function
	MOVLW	0x03
	MOVFF	PLUSW2, (__i2c_onRequest_function + 1)
	MOVLW	0x04
	MOVFF	PLUSW2, (__i2c_onRequest_function + 2)
;	.line	162; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	_i2c_onRequest_function = func;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_init	code
_I2C_init:
;	.line	118; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	void I2C_init(u8 mode, u16 sspadd)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	121; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	TRISBbits.TRISB0 = INPUT;			// SDA = INPUT
	BSF	_TRISBbits, 0
;	.line	122; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	TRISBbits.TRISB1 = INPUT;			// SCL = INPUT
	BSF	_TRISBbits, 1
;	.line	123; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	switch (mode)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00179_DS_
;	.line	126; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	intUsed[INT_SSP] = INT_USED;
	MOVLW	0x01
	BANKSEL	(_intUsed + 19)
	MOVWF	(_intUsed + 19), B
;	.line	128; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	INTCONbits.PEIE=1;
	BSF	_INTCONbits, 6
;	.line	129; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	INTCONbits.GIE=1;
	BSF	_INTCONbits, 7
;	.line	130; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON1 = 0b00101110;		// Slave mode,  7-bit address with Start and Stop bit interrupts enabled
	MOVLW	0x2e
	MOVWF	_SSPCON1
;	.line	133; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPADD = sspadd;				// Slave 7-bit address
	MOVF	r0x01, W
	MOVWF	_SSPADD
;	.line	136; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	break;
	BRA	_00183_DS_
_00179_DS_:
;	.line	138; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON1 = 0b00101000;		// Master Mode, clock = FOSC/(4 * (SSPADD + 1))
	MOVLW	0x28
	MOVWF	_SSPCON1
;	.line	139; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	switch (sspadd)
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_00190_DS_
	MOVF	r0x02, W
	BZ	_00191_DS_
_00190_DS_:
	BRA	_00181_DS_
_00191_DS_:
;	.line	142; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPSTAT = 0b00000000;		// Slew Mode On
	CLRF	_SSPSTAT
;	.line	143; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPADD = 119;					// 100kHz = FOSC/(4 * (SSPADD + 1))
	MOVLW	0x77
	MOVWF	_SSPADD
_00181_DS_:
;	.line	146; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPSTAT = 0b10000000;		// Slew Mode Off
	MOVLW	0x80
	MOVWF	_SSPSTAT
;	.line	147; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPADD = 29;					// 400kHz = FOSC/(4 * (SSPADD + 1))
	MOVLW	0x1d
	MOVWF	_SSPADD
_00183_DS_:
;	.line	150; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	SSPCON2 = 0;
	CLRF	_SSPCON2
;	.line	151; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	PIR1bits.SSPIF = 0;
	BCF	_PIR1bits, 3
;	.line	152; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	PIR2bits.BCLIF = 0;
	BCF	_PIR2bits, 3
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_slave	code
_I2C_slave:
;	.line	102; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	void I2C_slave(u16 DeviceID)   
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	104; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_init(I2C_SLAVE_MODE, DeviceID);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_I2C_init
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__I2C_master	code
_I2C_master:
;	.line	99; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/pinguinoi2c.c	I2C_init(I2C_MASTER_MODE, I2C_SLEW_OFF);
	MOVLW	0x00
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CALL	_I2C_init
	MOVLW	0x03
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__userinterrupt	code
_userinterrupt:
;	.line	1130; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	int_start();
	CALL	_int_start
	RETURN	

; ; Starting pCode block
S_main__userhighinterrupt	code
_userhighinterrupt:
;	.line	956; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	}
	RETURN	

; ; Starting pCode block
S_main__int_stop	code
_int_stop:
;	.line	346; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	}
	RETURN	

; ; Starting pCode block
S_main__int_start	code
_int_start:
;	.line	320; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	}
	RETURN	

; ; Starting pCode block
S_main__int_init	code
_int_init:
;	.line	284; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	void int_init()
	MOVFF	r0x00, POSTDEC1
;	.line	288; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	RCONbits.IPEN = 1;					// Enable HP/LP interrupts
	BSF	_RCONbits, 7
;	.line	289; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCONbits.GIEH = 1;				// Enable HP interrupts
	BSF	_INTCONbits, 7
;	.line	290; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCONbits.GIEL = 1;				// Enable LP interrupts
	BSF	_INTCONbits, 6
;	.line	292; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
	CLRF	r0x00
_00134_DS_:
	MOVLW	0x14
	SUBWF	r0x00, W
	BC	_00138_DS_
;	.line	293; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	detachInterrupt(i);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_detachInterrupt
	INCF	FSR1L, F
;	.line	292; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	for (i = 0; i < INT_NUM; i++)		// Disable all interrupts
	INCF	r0x00, F
	BRA	_00134_DS_
_00138_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__detachInterrupt	code
_detachInterrupt:
;	.line	206; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	void detachInterrupt(u8 inter)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	208; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	intUsed[inter] = INT_NOT_USED;	// This interrupt is no longer used
	MOVLW	LOW(_intUsed)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_intUsed)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	CLRF	INDF0
;	.line	210; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	switch(inter)
	MOVLW	0x13
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00125_DS_
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	CLRF	r0x04
	RLCF	r0x00, W
	RLCF	r0x04, F
	RLCF	WREG, W
	RLCF	r0x04, F
	ANDLW	0xfc
	MOVWF	r0x03
	MOVLW	UPPER(_00129_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00129_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00129_DS_)
	ADDWF	r0x03, F
	MOVF	r0x04, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVWF	PCL
_00129_DS_:
	GOTO	_00108_DS_
	GOTO	_00109_DS_
	GOTO	_00110_DS_
	GOTO	_00111_DS_
	GOTO	_00105_DS_
	GOTO	_00106_DS_
	GOTO	_00107_DS_
	GOTO	_00112_DS_
	GOTO	_00117_DS_
	GOTO	_00118_DS_
	GOTO	_00120_DS_
	GOTO	_00115_DS_
	GOTO	_00116_DS_
	GOTO	_00114_DS_
	GOTO	_00119_DS_
	GOTO	_00121_DS_
	GOTO	_00123_DS_
	GOTO	_00122_DS_
	GOTO	_00113_DS_
_00105_DS_:
;	.line	213; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCONbits.INT0IE = INT_DISABLE;
	BCF	_INTCONbits, 4
;	.line	214; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00106_DS_:
;	.line	216; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCON3bits.INT1IE = INT_DISABLE;
	BCF	_INTCON3bits, 3
;	.line	217; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00107_DS_:
;	.line	219; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCON3bits.INT2IE = INT_DISABLE;
	BCF	_INTCON3bits, 4
;	.line	220; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00108_DS_:
;	.line	222; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCONbits.TMR0IE = INT_DISABLE;
	BCF	_INTCONbits, 5
;	.line	223; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00109_DS_:
;	.line	225; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE1bits.TMR1IE = INT_DISABLE;
	BCF	_PIE1bits, 0
;	.line	226; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00110_DS_:
;	.line	228; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE1bits.TMR2IE = INT_DISABLE;
	BCF	_PIE1bits, 1
;	.line	229; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00111_DS_:
;	.line	231; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.TMR3IE = INT_DISABLE;
	BCF	_PIE2bits, 1
;	.line	232; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00112_DS_:
;	.line	234; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	INTCONbits.RBIE = INT_DISABLE;
	BCF	_INTCONbits, 3
;	.line	235; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00113_DS_:
;	.line	237; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.USBIE = INT_DISABLE;
	BCF	_PIE2bits, 5
;	.line	238; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00114_DS_:
;	.line	240; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE1bits.ADIE = INT_DISABLE;
	BCF	_PIE1bits, 6
;	.line	241; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00115_DS_:
;	.line	243; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE1bits.RCIE = INT_DISABLE;
	BCF	_PIE1bits, 5
;	.line	244; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00116_DS_:
;	.line	246; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE1bits.TXIE = INT_DISABLE;
	BCF	_PIE1bits, 4
;	.line	247; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00117_DS_:
;	.line	249; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE1bits.CCP1IE = INT_DISABLE;
	BCF	_PIE1bits, 2
;	.line	250; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00118_DS_:
;	.line	252; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.CCP2IE = INT_DISABLE;
	BCF	_PIE2bits, 0
;	.line	253; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00119_DS_:
;	.line	255; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.OSCFIE = INT_DISABLE;
	BCF	_PIE2bits, 7
;	.line	256; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00120_DS_:
;	.line	258; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.CMIE = INT_DISABLE;
	BCF	_PIE2bits, 6
;	.line	259; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00121_DS_:
;	.line	261; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.EEIE = INT_DISABLE;
	BCF	_PIE2bits, 4
;	.line	262; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00122_DS_:
;	.line	264; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.BCLIE = INT_DISABLE;
	BCF	_PIE2bits, 3
;	.line	265; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	break;
	BRA	_00125_DS_
_00123_DS_:
;	.line	267; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	PIE2bits.HLVDIE = INT_DISABLE;
	BCF	_PIE2bits, 2
_00125_DS_:
;	.line	274; /home/regis/Hobbies/Electronique/Projets/PinguinoIDE/X/branches/pic32/C32/linux/tools/bin/../share/sdcc/include/pic16/interrupt.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1472 (0x05c0) bytes ( 1.12%)
;           	  736 (0x02e0) words
; udata size:	  110 (0x006e) bytes ( 6.14%)
; access size:	    6 (0x0006) bytes


	end
