;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Aug  9 2009) (UNIX)
; This file was generated Sun Apr 22 12:53:19 2012
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f2550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _rx
	global _wpointer
	global _rpointer
	global _analog_init
	global _analogReference
	global _analogread
	global _pprintf
	global _psprintf
	global _serial_begin
	global _serial_available
	global _serial_putchar
	global _serial_interrupt
	global _serial_read
	global _serial_flush
	global _serial_printf
	global _serial_getkey
	global _serial_getstring
	global _serial_print
	global _serial_println
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
	extern __gptrget3
	extern __gptrput1
	extern __gptrput3
	extern __gptrget1
	extern __gptrget2
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
	extern __moduint
	extern __divuint
	extern __mulint
	extern __mullong
	extern __divulong
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
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
FSR2H	equ	0xfda
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
r0x0a	res	1
r0x0b	res	1
r0x0c	res	1
r0x0d	res	1
r0x0e	res	1
r0x0f	res	1
r0x10	res	1
r0x11	res	1
r0x12	res	1
r0x13	res	1
r0x14	res	1
r0x15	res	1
r0x16	res	1
r0x17	res	1
r0x18	res	1
r0x19	res	1
r0x1a	res	1

udata_main_0	udata
_pputchar	res	3

udata_main_1	udata
_pprinti_print_buf_1_1	res	12

udata_main_2	udata
_pprint_scr_1_1	res	2

udata_main_3	udata
_psprintf_out_1_1	res	3

udata_main_4	udata
_wpointer	res	1

udata_main_5	udata
_rpointer	res	1

udata_main_6	udata
_rx	res	128

udata_main_7	udata
_serial_getstring_buffer_1_1	res	80

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block
S_main__high_priority_isr	code	0X002020
_high_priority_isr:
;	.line	130; /opt/pinguino/pinguino32/source/main.c	void high_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
;	.line	166; /opt/pinguino/pinguino32/source/main.c	if (PIR1bits.RCIF) 
	MOVFF	PCLATU, POSTDEC1
; #	MOVFF	FSR1L, FSR2L
; #	BTFSS	_PIR1bits, 5
; #	GOTO	_00519_DS_
; #	CALL	_serial_interrupt
; #	MOVFF	PREINC1, FSR2L
;	.line	167; /opt/pinguino/pinguino32/source/main.c	serial_interrupt();
	BTFSC	_PIR1bits, 5
	CALL	_serial_interrupt
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
;	.line	194; /opt/pinguino/pinguino32/source/main.c	void low_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	199; /opt/pinguino/pinguino32/source/main.c	}
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
;	.line	58; /opt/pinguino/pinguino32/source/main.c	PIE1 = 0;
	CLRF	_PIE1
;	.line	59; /opt/pinguino/pinguino32/source/main.c	PIE2 = 0;
	CLRF	_PIE2
;	.line	60; /opt/pinguino/pinguino32/source/main.c	ADCON1 = 0b00001111;				// AN0 to AN12 Digital I/O
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	72; /opt/pinguino/pinguino32/source/main.c	setup();
	CALL	_setup
;	.line	79; /opt/pinguino/pinguino32/source/main.c	analog_init();
	CALL	_analog_init
;	.line	105; /opt/pinguino/pinguino32/source/main.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	106; /opt/pinguino/pinguino32/source/main.c	INTCONbits.GIE  = 1;
	BSF	_INTCONbits, 7
_00510_DS_:
;	.line	124; /opt/pinguino/pinguino32/source/main.c	loop();
	CALL	_loop
	BRA	_00510_DS_
	RETURN	

; ; Starting pCode block
S_main__loop	code
_loop:
;	.line	12; /opt/pinguino/pinguino32/source/user.c	void loop() {
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	13; /opt/pinguino/pinguino32/source/user.c	int sensorValue = analogread(A0);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_analogread
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	INCF	FSR1L, F
; #	MOVF	r0x01, W
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; #	MOVF	r0x00, W
; #	MOVF	r0x00, W
; #	MOVWF	r0x00
;	.line	14; /opt/pinguino/pinguino32/source/user.c	serial_println(sensorValue, DEC);
	CLRF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_println
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	9; /opt/pinguino/pinguino32/source/user.c	serial_begin(9600);
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x25
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_serial_begin
	MOVLW	0x04
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__epapout_init	code
_epapout_init:
;	.line	46; /opt/pinguino/pinguino32/source/main.c	void epapout_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epapin_init	code
_epapin_init:
;	.line	45; /opt/pinguino/pinguino32/source/main.c	void epapin_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_out	code
_epap_out:
;	.line	44; /opt/pinguino/pinguino32/source/main.c	void epap_out() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_in	code
_epap_in:
;	.line	43; /opt/pinguino/pinguino32/source/main.c	void epap_in() { return; }
	RETURN	

; ; Starting pCode block
S_main__serial_println	code
_serial_println:
;	.line	247; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	void serial_println(char *fmt,...)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	249; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_print(fmt);
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	CALL	_serial_print
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	250; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("\n\r");
	MOVLW	UPPER(__str_7)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_7)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_7)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__serial_print	code
_serial_print:
;	.line	180; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	void serial_print(char *fmt,...)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	186; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	va_start(ap, fmt);
	MOVLW	0x02
	ADDWF	FSR2L, W
	MOVWF	r0x00
	MOVLW	0x00
	ADDWFC	FSR2H, W
	MOVWF	r0x01
	MOVLW	0x03
	ADDWF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
; #	MOVF	r0x01, W
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; #	MOVF	r0x00, W
; #	MOVF	r0x00, W
; #	MOVWF	r0x00
;	.line	187; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	s = va_start(ap, fmt);
	MOVLW	0x80
;	.line	189; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	switch (*s)
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	MOVWF	r0x00
	XORLW	0x01
	BNZ	_00461_DS_
	BRA	_00448_DS_
_00461_DS_:
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00463_DS_
	BRA	_00450_DS_
_00463_DS_:
	MOVF	r0x00, W
	XORLW	0x08
	BNZ	_00465_DS_
	BRA	_00449_DS_
_00465_DS_:
	MOVF	r0x00, W
	XORLW	0x0a
	BZ	_00446_DS_
	MOVF	r0x00, W
	XORLW	0x10
	BNZ	_00469_DS_
	BRA	_00447_DS_
_00469_DS_:
	BRA	_00451_DS_
_00446_DS_:
;	.line	192; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("%d",fmt);
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	193; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	break;
	BRA	_00453_DS_
_00447_DS_:
;	.line	195; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("%x",fmt);
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVLW	UPPER(__str_4)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_4)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_4)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	196; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	break;
	BRA	_00453_DS_
_00448_DS_:
;	.line	198; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("%d",fmt);
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	199; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	break;
	BRA	_00453_DS_
_00449_DS_:
;	.line	201; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("%o",fmt);
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	202; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	break;
	BRA	_00453_DS_
_00450_DS_:
;	.line	204; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("%b",fmt);
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVLW	UPPER(__str_6)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_6)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_6)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	205; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	break;           
	BRA	_00453_DS_
_00451_DS_:
;	.line	207; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf(fmt);
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x03
	MOVLW	0x03
	MOVFF	PLUSW2, r0x04
	MOVLW	0x04
	MOVFF	PLUSW2, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
_00453_DS_:
;	.line	236; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	va_end(ap);
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__serial_getstring	code
_serial_getstring:
;	.line	159; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	u8 * serial_getstring()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	166; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	do {
	CLRF	r0x00
_00432_DS_:
;	.line	167; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	c = serial_getkey();
	CALL	_serial_getkey
	MOVWF	r0x01
;	.line	168; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_printf("%c", c);
	MOVFF	r0x01, r0x02
	CLRF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	169; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	buffer[i++] = c;
	MOVFF	r0x00, r0x02
	INCF	r0x00, F
	CLRF	r0x03
	MOVLW	LOW(_serial_getstring_buffer_1_1)
	ADDWF	r0x02, F
	MOVLW	HIGH(_serial_getstring_buffer_1_1)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	r0x01, INDF0
;	.line	170; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	} while (c != '\r');
	MOVF	r0x01, W
	XORLW	0x0d
	BNZ	_00432_DS_
;	.line	171; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	buffer[i] = '\0';
	CLRF	r0x01
	MOVLW	LOW(_serial_getstring_buffer_1_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_serial_getstring_buffer_1_1)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	CLRF	INDF0
;	.line	172; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	return (buffer);
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x02
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVLW	LOW(_serial_getstring_buffer_1_1)
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_getkey	code
_serial_getkey:
;	.line	145; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	u8 serial_getkey()
	MOVFF	r0x00, POSTDEC1
_00424_DS_:
;	.line	148; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	while (!(serial_available()));
	CALL	_serial_available
	MOVWF	r0x00
	MOVF	r0x00, W
	BZ	_00424_DS_
;	.line	149; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	c = serial_read();
	CALL	_serial_read
	MOVWF	r0x00
;	.line	150; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	serial_flush();
	CALL	_serial_flush
;	.line	151; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	return (c);
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_printf	code
_serial_printf:
;	.line	131; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	void serial_printf(char *fmt, ...)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	135; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	va_start(args, fmt);
	MOVLW	0x02
	ADDWF	FSR2L, W
	MOVWF	r0x00
	MOVLW	0x00
	ADDWFC	FSR2H, W
	MOVWF	r0x01
	MOVLW	0x03
	ADDWF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
; #	MOVF	r0x01, W
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; #	MOVF	r0x00, W
; #	MOVF	r0x00, W
; #	MOVWF	r0x00
	MOVLW	0x80
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
;	.line	136; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	pprintf(serial_putchar, fmt, args);
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVFF	PLUSW2, POSTDEC1
	MOVLW	0x03
	MOVFF	PLUSW2, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, POSTDEC1
	MOVLW	UPPER(_serial_putchar)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_serial_putchar)
	MOVWF	POSTDEC1
	MOVLW	LOW(_serial_putchar)
	MOVWF	POSTDEC1
	CALL	_pprintf
	MOVLW	0x09
	ADDWF	FSR1L, F
;	.line	137; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	va_end(args);
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__serial_flush	code
_serial_flush:
; #	MOVLW	0x01
; #	MOVWF	_wpointer, B
; #	MOVLW	0x01
;	.line	121; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	wpointer=1;
	MOVLW	0x01
	BANKSEL	_wpointer
;	.line	122; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	rpointer=1;
	MOVWF	_wpointer, B
	BANKSEL	_rpointer
	MOVWF	_rpointer, B
	RETURN	

; ; Starting pCode block
S_main__serial_read	code
_serial_read:
;	.line	105; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	unsigned char serial_read()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	107; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	unsigned char caractere=0;
	CLRF	r0x00
;	.line	109; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	if (serial_available())
	CALL	_serial_available
	MOVWF	r0x01
	MOVF	r0x01, W
	BZ	_00403_DS_
;	.line	111; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	caractere=rx[rpointer++];
	MOVFF	_rpointer, r0x01
	BANKSEL	_rpointer
	INCF	_rpointer, F, B
	CLRF	r0x02
	MOVLW	LOW(_rx)
	ADDWF	r0x01, F
	MOVLW	HIGH(_rx)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x00
; removed redundant BANKSEL
;	.line	112; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	if (rpointer==RXBUFFERLENGTH)
	MOVF	_rpointer, W, B
	XORLW	0x80
	BNZ	_00403_DS_
;	.line	113; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	rpointer=1;
	MOVLW	0x01
	BANKSEL	_rpointer
	MOVWF	_rpointer, B
_00403_DS_:
;	.line	115; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	return(caractere);
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_interrupt	code
_serial_interrupt:
;	.line	85; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	void serial_interrupt(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	90; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	PIR1bits.RCIF=0;				// clear RX interrupt flag
	BCF	_PIR1bits, 5
;	.line	91; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	caractere=RCREG;				// take received char
	MOVFF	_RCREG, r0x00
	BANKSEL	_wpointer
;	.line	92; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	if (wpointer!=RXBUFFERLENGTH-1)	// if not last place in buffer
	MOVF	_wpointer, W, B
	XORLW	0x7f
	BZ	_00379_DS_
_00391_DS_:
	BANKSEL	_wpointer
;	.line	93; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	newwp=wpointer+1;			// place=place+1
	INCF	_wpointer, W, B
	MOVWF	r0x01
	BRA	_00380_DS_
_00379_DS_:
;	.line	95; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	newwp=1;					// else place=1
	MOVLW	0x01
	MOVWF	r0x01
_00380_DS_:
	BANKSEL	_rpointer
;	.line	97; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	if (rpointer!=newwp)			// if read pointer!=write pointer
	MOVF	_rpointer, W, B
	XORWF	r0x01, W
	BZ	_00382_DS_
;	.line	98; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	rx[wpointer++]=caractere;	// store received char
	MOVFF	_wpointer, r0x01
	BANKSEL	_wpointer
	INCF	_wpointer, F, B
	CLRF	r0x02
	MOVLW	LOW(_rx)
	ADDWF	r0x01, F
	MOVLW	HIGH(_rx)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x00, INDF0
_00382_DS_:
	BANKSEL	_wpointer
;	.line	100; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	if (wpointer==RXBUFFERLENGTH)	// if write pointer=length buffer
	MOVF	_wpointer, W, B
	XORLW	0x80
	BNZ	_00385_DS_
;	.line	101; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	wpointer=1;					// write pointer = 1
	MOVLW	0x01
	BANKSEL	_wpointer
	MOVWF	_wpointer, B
_00385_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_putchar	code
_serial_putchar:
;	.line	78; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	void serial_putchar(unsigned char caractere)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
_00370_DS_:
;	.line	80; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	while (!TXSTAbits.TRMT);
	BTFSS	_TXSTAbits, 1
	BRA	_00370_DS_
;	.line	81; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	TXREG=caractere;		        // yes, send char
	MOVFF	r0x00, _TXREG
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__serial_available	code
_serial_available:
;	.line	72; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	unsigned char serial_available()
	MOVFF	r0x00, POSTDEC1
;	.line	74; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	return(wpointer!=rpointer);
	CLRF	r0x00
	BANKSEL	_wpointer
	MOVF	_wpointer, W, B
	BANKSEL	_rpointer
	XORWF	_rpointer, W, B
	BNZ	_00365_DS_
	INCF	r0x00, F
_00365_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_begin	code
_serial_begin:
;	.line	48; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	void serial_begin(unsigned long baudrate)
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
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	53; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	spbrg=(48000000/(4*baudrate))-1;
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	__mullong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	0xdc
	MOVWF	POSTDEC1
	MOVLW	0x6c
	MOVWF	POSTDEC1
	MOVLW	0x00
	CLRF	POSTDEC1
	CALL	__divulong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVLW	0xff
	ADDWF	r0x00, F
	ADDWFC	r0x01, F
;	.line	54; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	highbyte=spbrg/256;
	MOVF	r0x01, W
;	.line	55; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	lowbyte=spbrg%256;
	MOVWF	r0x04
;	.line	56; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	TXSTAbits.BRGH=1;               	  	// set BRGH bit
	BSF	_TXSTAbits, 2
;	.line	57; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	BAUDCONbits.BRG16=1;					// set 16 bits SPBRG
	BSF	_BAUDCONbits, 3
;	.line	58; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	SPBRGH=highbyte;                        // set UART speed SPBRGH
	MOVFF	r0x04, _SPBRGH
;	.line	59; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	SPBRG=lowbyte;   						// set UART speed SPBRGL
	MOVFF	r0x00, _SPBRG
;	.line	60; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	RCSTA=0x90;                             // set RCEN and SPEN
	MOVLW	0x90
	MOVWF	_RCSTA
;	.line	61; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	BAUDCONbits.RCIDL=1;			// set receive active
	BSF	_BAUDCONbits, 6
;	.line	62; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	PIE1bits.RCIE=1;                        // enable interrupt on RX
	BSF	_PIE1bits, 5
;	.line	63; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	INTCONbits.PEIE=1;                      // enable peripheral interrupts
	BSF	_INTCONbits, 6
;	.line	64; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	IPR1bits.RCIP=1;                        // define high priority for RX interrupt
	BSF	_IPR1bits, 5
; #	MOVLW	0x01
; #	MOVWF	_wpointer, B
; #	MOVLW	0x01
;	.line	65; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	wpointer=1;                             // initialize write pointer
	MOVLW	0x01
	BANKSEL	_wpointer
;	.line	66; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	rpointer=1;                             // initialize read pointer
	MOVWF	_wpointer, B
	BANKSEL	_rpointer
	MOVWF	_rpointer, B
;	.line	67; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	TXSTAbits.TXEN=1;                       // enable TX
	BSF	_TXSTAbits, 5
;	.line	68; /opt/pinguino/pinguino32/p8/include/pinguino/core/serial.c	INTCONbits.GIE=1;
	BSF	_INTCONbits, 7
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__psprintf	code
_psprintf:
;	.line	248; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	int psprintf(char *out, const char *format, va_list args)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _psprintf_out_1_1
	MOVLW	0x03
	MOVFF	PLUSW2, (_psprintf_out_1_1 + 1)
	MOVLW	0x04
	MOVFF	PLUSW2, (_psprintf_out_1_1 + 2)
	MOVLW	0x05
	MOVFF	PLUSW2, r0x00
	MOVLW	0x06
	MOVFF	PLUSW2, r0x01
	MOVLW	0x07
	MOVFF	PLUSW2, r0x02
	MOVLW	0x08
	MOVFF	PLUSW2, r0x03
	MOVLW	0x09
	MOVFF	PLUSW2, r0x04
	MOVLW	0x0a
	MOVFF	PLUSW2, r0x05
;	.line	253; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	return pprint(&out, format, args);
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_psprintf_out_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_psprintf_out_1_1)
	MOVWF	POSTDEC1
	CALL	_pprint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x09
	ADDWF	FSR1L, F
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__pprintf	code
_pprintf:
;	.line	238; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	int pprintf(stdout func, const char *format, va_list args)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _pputchar
	MOVLW	0x03
	MOVFF	PLUSW2, (_pputchar + 1)
	MOVLW	0x04
	MOVFF	PLUSW2, (_pputchar + 2)
	MOVLW	0x05
	MOVFF	PLUSW2, r0x00
	MOVLW	0x06
	MOVFF	PLUSW2, r0x01
	MOVLW	0x07
	MOVFF	PLUSW2, r0x02
	MOVLW	0x08
	MOVFF	PLUSW2, r0x03
	MOVLW	0x09
	MOVFF	PLUSW2, r0x04
	MOVLW	0x0a
	MOVFF	PLUSW2, r0x05
;	.line	244; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	return pprint(0, format, args);
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CALL	_pprint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x09
	ADDWF	FSR1L, F
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__pprint	code
_pprint:
;	.line	141; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	static int pprint(char **out, const char *format, va_list args)
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
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x10, POSTDEC1
	MOVFF	r0x11, POSTDEC1
	MOVFF	r0x12, POSTDEC1
	MOVFF	r0x13, POSTDEC1
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
	MOVLW	0x08
	MOVFF	PLUSW2, r0x06
	MOVLW	0x09
	MOVFF	PLUSW2, r0x07
	MOVLW	0x0a
	MOVFF	PLUSW2, r0x08
;	.line	144; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	register int pc = 0;
	CLRF	r0x09
	CLRF	r0x0a
_00271_DS_:
;	.line	147; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for (; *format != 0; ++format)
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0b
	MOVF	r0x0b, W
	BTFSC	STATUS, 2
	GOTO	_00274_DS_
;	.line	149; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == '%')
	MOVF	r0x0b, W
	XORLW	0x25
	BZ	_00311_DS_
	GOTO	_00267_DS_
_00311_DS_:
;	.line	151; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++format;
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
;	.line	152; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	width = pad = 0;
	CLRF	r0x0b
	CLRF	r0x0c
	CLRF	r0x0d
	CLRF	r0x0e
;	.line	153; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == '\0')
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0f
	MOVF	r0x0f, W
	BTFSC	STATUS, 2
	GOTO	_00274_DS_
;	.line	155; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == '%')
	MOVF	r0x0f, W
	XORLW	0x25
	BNZ	_00313_DS_
	GOTO	_00267_DS_
_00313_DS_:
;	.line	157; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == '-')
	MOVF	r0x0f, W
	XORLW	0x2d
	BNZ	_00292_DS_
;	.line	159; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++format;
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
;	.line	160; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pad = PAD_RIGHT;
	MOVLW	0x01
	MOVWF	r0x0b
	CLRF	r0x0c
_00292_DS_:
;	.line	162; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	while (*format == '0')
	MOVFF	r0x03, r0x0f
	MOVFF	r0x04, r0x10
	MOVFF	r0x05, r0x11
_00244_DS_:
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget1
; #	MOVWF	r0x12
; #	MOVF	r0x12, W
	XORLW	0x30
	BNZ	_00278_DS_
;	.line	164; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++format;
	INCF	r0x0f, F
	BTFSC	STATUS, 0
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
;	.line	165; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pad |= PAD_ZERO;
	BSF	r0x0b, 1
	BRA	_00244_DS_
_00278_DS_:
;	.line	167; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; *format >= '0' && *format <= '9'; ++format)
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget1
; #	MOVWF	r0x12
; #	MOVF	r0x12, W
	MOVWF	r0x12
	ADDLW	0x80
	ADDLW	0x50
	BNC	_00309_DS_
	MOVF	r0x12, W
	ADDLW	0x80
	ADDLW	0x46
	BC	_00309_DS_
;	.line	169; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	width *= 10;
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x0d
	MOVFF	PRODL, r0x0e
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	170; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	width += *format - '0';
	CLRF	r0x13
	BTFSC	r0x12, 7
	SETF	r0x13
	MOVLW	0xd0
	ADDWF	r0x12, F
	BTFSS	STATUS, 0
	DECF	r0x13, F
	MOVF	r0x12, W
	ADDWF	r0x0d, F
	MOVF	r0x13, W
	ADDWFC	r0x0e, F
;	.line	167; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; *format >= '0' && *format <= '9'; ++format)
	INCF	r0x0f, F
	BTFSC	STATUS, 0
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
	BRA	_00278_DS_
_00309_DS_:
	MOVFF	r0x0f, r0x03
	MOVFF	r0x10, r0x04
	MOVFF	r0x11, r0x05
;	.line	172; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 's')
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget1
; #	MOVWF	r0x0f
; #	MOVF	r0x0f, W
	MOVWF	r0x0f
	XORLW	0x73
	BZ	_00322_DS_
	BRA	_00248_DS_
_00322_DS_:
;	.line	175; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	char *s = va_arg(args, char*);
	MOVF	r0x06, W
	ADDLW	0x03
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfd
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget3
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVFF	PRODH, r0x12
;	.line	177; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprints(out, s?s:"(null)", width, pad);
	IORWF	r0x11, W
; #	IORWF	r0x12, W
; #	BTFSC	STATUS, 2
; #	GOTO	_00284_DS_
; #	GOTO	_00285_DS_
; #	MOVLW	LOW(__str_0)
	IORWF	r0x12, W
	BNZ	_00285_DS_
	MOVLW	LOW(__str_0)
	MOVWF	r0x10
	MOVLW	HIGH(__str_0)
	MOVWF	r0x11
	MOVLW	UPPER(__str_0)
	MOVWF	r0x12
_00285_DS_:
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x12, W
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprints
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0a
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	178; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	GOTO	_00273_DS_
_00248_DS_:
;	.line	180; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'd')
	MOVF	r0x0f, W
	XORLW	0x64
	BZ	_00324_DS_
	BRA	_00250_DS_
_00324_DS_:
;	.line	182; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprinti(out, va_arg(args, int), 10, 1, width, pad, 'a');
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	CLRF	POSTDEC1
	MOVLW	0x61
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprinti
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0f
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	183; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00250_DS_:
;	.line	185; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'x' || *format == 'p')
	MOVF	r0x0f, W
	XORLW	0x78
	BZ	_00251_DS_
	MOVF	r0x0f, W
	XORLW	0x70
	BZ	_00251_DS_
	BRA	_00252_DS_
_00251_DS_:
;	.line	187; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprinti(out, va_arg(args, int), 16, 0, width, pad, 'a');
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	CLRF	POSTDEC1
	MOVLW	0x61
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprinti
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0f
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	188; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00252_DS_:
;	.line	190; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'X' || *format == 'P')
	MOVF	r0x0f, W
	XORLW	0x58
	BZ	_00254_DS_
	MOVF	r0x0f, W
	XORLW	0x50
	BZ	_00254_DS_
	BRA	_00255_DS_
_00254_DS_:
;	.line	192; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprinti(out, va_arg(args, int), 16, 0, width, pad, 'A');
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	CLRF	POSTDEC1
	MOVLW	0x41
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprinti
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0f
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	193; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00255_DS_:
;	.line	195; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'b')
	MOVF	r0x0f, W
	XORLW	0x62
	BZ	_00334_DS_
	BRA	_00258_DS_
_00334_DS_:
;	.line	197; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprinti(out, va_arg(args, int), 2, 0, width, pad, 'a');
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	CLRF	POSTDEC1
	MOVLW	0x61
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprinti
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0f
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	198; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00258_DS_:
;	.line	200; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'o')
	MOVF	r0x0f, W
	XORLW	0x6f
	BZ	_00336_DS_
	BRA	_00260_DS_
_00336_DS_:
;	.line	202; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprinti(out, va_arg(args, int), 8, 0, width, pad, 'a');
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	CLRF	POSTDEC1
	MOVLW	0x61
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprinti
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0f
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	203; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00260_DS_:
;	.line	205; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'u')
	MOVF	r0x0f, W
	XORLW	0x75
	BZ	_00338_DS_
	BRA	_00262_DS_
_00338_DS_:
;	.line	207; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprinti(out, va_arg(args, int), 10, 0, width, pad, 'a');
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	CLRF	POSTDEC1
	MOVLW	0x61
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprinti
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0f
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	208; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00262_DS_:
;	.line	210; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'c')
	MOVF	r0x0f, W
	XORLW	0x63
	BZ	_00340_DS_
	BRA	_00264_DS_
_00340_DS_:
;	.line	213; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	scr[0] = (char)va_arg(args, int);
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x12
	MOVFF	r0x10, r0x06
	MOVFF	r0x11, r0x07
	MOVFF	r0x12, r0x08
	MOVLW	0xfe
	ADDWF	r0x10, F
	MOVLW	0xff
	ADDWFC	r0x11, F
	ADDWFC	r0x12, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget2
	BANKSEL	_pprint_scr_1_1
	MOVWF	_pprint_scr_1_1, B
; removed redundant BANKSEL
;	.line	215; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	scr[1] = '\0';
	CLRF	(_pprint_scr_1_1 + 1), B
;	.line	216; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprints(out, scr, width, pad);
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_pprint_scr_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_pprint_scr_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprints
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVLW	0x0a
	ADDWF	FSR1L, F
	MOVF	r0x10, W
	ADDWF	r0x09, F
	MOVF	r0x11, W
	ADDWFC	r0x0a, F
;	.line	217; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00264_DS_:
;	.line	219; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (*format == 'f')
	MOVF	r0x0f, W
	XORLW	0x66
	BNZ	_00273_DS_
;	.line	221; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pc += pprints(out, "not yet implemented\0", width, pad);
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprints
	MOVWF	r0x0b
	MOVFF	PRODL, r0x0c
	MOVLW	0x0a
	ADDWF	FSR1L, F
	MOVF	r0x0b, W
	ADDWF	r0x09, F
	MOVF	r0x0c, W
	ADDWFC	r0x0a, F
;	.line	222; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	continue;
	BRA	_00273_DS_
_00267_DS_:
;	.line	228; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pprintchar(out, *format);
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x0b
; #	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	229; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++pc;
	INCF	r0x09, F
	BTFSC	STATUS, 0
	INCF	r0x0a, F
_00273_DS_:
;	.line	147; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for (; *format != 0; ++format)
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	GOTO	_00271_DS_
_00274_DS_:
;	.line	232; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (out) **out = '\0';
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	BZ	_00276_DS_
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget3
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	CLRF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
_00276_DS_:
;	.line	234; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	return pc;
	MOVFF	r0x0a, PRODL
	MOVF	r0x09, W
	MOVFF	PREINC1, r0x13
	MOVFF	PREINC1, r0x12
	MOVFF	PREINC1, r0x11
	MOVFF	PREINC1, r0x10
	MOVFF	PREINC1, r0x0f
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
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
S_main__pprinti	code
_pprinti:
;	.line	92; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	static int pprinti(char **out, int i, int b, int sg, int width, int pad, int letbase)
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
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x10, POSTDEC1
	MOVFF	r0x11, POSTDEC1
	MOVFF	r0x12, POSTDEC1
	MOVFF	r0x13, POSTDEC1
	MOVFF	r0x14, POSTDEC1
	MOVFF	r0x15, POSTDEC1
	MOVFF	r0x16, POSTDEC1
	MOVFF	r0x17, POSTDEC1
	MOVFF	r0x18, POSTDEC1
	MOVFF	r0x19, POSTDEC1
	MOVFF	r0x1a, POSTDEC1
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
	MOVLW	0x08
	MOVFF	PLUSW2, r0x06
	MOVLW	0x09
	MOVFF	PLUSW2, r0x07
	MOVLW	0x0a
	MOVFF	PLUSW2, r0x08
	MOVLW	0x0b
	MOVFF	PLUSW2, r0x09
	MOVLW	0x0c
	MOVFF	PLUSW2, r0x0a
	MOVLW	0x0d
	MOVFF	PLUSW2, r0x0b
	MOVLW	0x0e
	MOVFF	PLUSW2, r0x0c
	MOVLW	0x0f
	MOVFF	PLUSW2, r0x0d
	MOVLW	0x10
	MOVFF	PLUSW2, r0x0e
;	.line	96; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	int t, neg = 0, pc = 0;
	CLRF	r0x0f
	CLRF	r0x10
	CLRF	r0x11
	CLRF	r0x12
;	.line	97; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	unsigned int u = i;
	MOVFF	r0x03, r0x13
	MOVFF	r0x04, r0x14
;	.line	99; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (i == 0)
	MOVF	r0x03, W
	IORWF	r0x04, W
	BNZ	_00200_DS_
;	.line	101; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	print_buf[0] = '0';
	MOVLW	0x30
	BANKSEL	_pprinti_print_buf_1_1
	MOVWF	_pprinti_print_buf_1_1, B
; removed redundant BANKSEL
;	.line	102; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	print_buf[1] = '\0';
	CLRF	(_pprinti_print_buf_1_1 + 1), B
;	.line	103; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	return pprints(out, print_buf, width, pad);
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_pprinti_print_buf_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_pprinti_print_buf_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprints
	MOVWF	r0x15
	MOVFF	PRODL, r0x16
	MOVLW	0x0a
	ADDWF	FSR1L, F
	MOVFF	r0x16, PRODL
	MOVF	r0x15, W
	BRA	_00216_DS_
_00200_DS_:
;	.line	106; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (sg && b == 10 && i < 0)
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00202_DS_
	MOVF	r0x05, W
	XORLW	0x0a
	BNZ	_00229_DS_
	MOVF	r0x06, W
	BZ	_00230_DS_
_00229_DS_:
	BRA	_00202_DS_
_00230_DS_:
	BSF	STATUS, 0
	BTFSS	r0x04, 7
	BCF	STATUS, 0
	BNC	_00202_DS_
;	.line	108; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	neg = 1;
	MOVLW	0x01
	MOVWF	r0x0f
	CLRF	r0x10
;	.line	109; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	u = -i;
	COMF	r0x04, W
	MOVWF	r0x14
	COMF	r0x03, W
	MOVWF	r0x13
	INFSNZ	r0x13, F
	INCF	r0x14, F
_00202_DS_:
;	.line	112; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	s = print_buf + PRINT_BUF_LEN-1;
	MOVLW	HIGH(_pprinti_print_buf_1_1 + 11)
	MOVWF	r0x04
	MOVLW	LOW(_pprinti_print_buf_1_1 + 11)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x07
;	.line	113; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	*s = '\0';
	CLRF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	CALL	__gptrput1
;	.line	115; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	while (u)
	MOVF	r0x0d, W
	ADDLW	0xc6
	MOVWF	r0x0d
	MOVFF	r0x05, r0x0e
	MOVFF	r0x06, r0x15
	MOVFF	r0x03, r0x16
	MOVFF	r0x04, r0x17
	MOVFF	r0x07, r0x18
_00207_DS_:
	MOVF	r0x13, W
	IORWF	r0x14, W
	BZ	_00228_DS_
;	.line	117; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	t = u % b;
	MOVF	r0x15, W
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x14, W
	MOVWF	POSTDEC1
	MOVF	r0x13, W
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x19
	MOVFF	PRODL, r0x1a
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	118; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if( t >= 10 )
	MOVF	r0x1a, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00232_DS_
	MOVLW	0x0a
	SUBWF	r0x19, W
_00232_DS_:
	BNC	_00206_DS_
;	.line	119; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	t += letbase - '0' - 10;
	MOVF	r0x0d, W
	ADDWF	r0x19, F
_00206_DS_:
;	.line	120; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	*--s = t + '0';
	MOVLW	0xff
	ADDWF	r0x16, F
	ADDWFC	r0x17, F
	ADDWFC	r0x18, F
	MOVLW	0x30
	ADDWF	r0x19, F
	MOVFF	r0x19, POSTDEC1
	MOVFF	r0x16, FSR0L
	MOVFF	r0x17, PRODL
	MOVF	r0x18, W
	CALL	__gptrput1
;	.line	121; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	u /= b;
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x14, W
	MOVWF	POSTDEC1
	MOVF	r0x13, W
	MOVWF	POSTDEC1
	CALL	__divuint
	MOVWF	r0x13
	MOVFF	PRODL, r0x14
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00207_DS_
_00228_DS_:
	MOVFF	r0x16, r0x03
	MOVFF	r0x17, r0x04
	MOVFF	r0x18, r0x07
;	.line	124; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (neg)
	MOVF	r0x0f, W
	IORWF	r0x10, W
	BZ	_00215_DS_
;	.line	126; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (width && (pad & PAD_ZERO))
	MOVF	r0x09, W
	IORWF	r0x0a, W
	BZ	_00211_DS_
	BTFSS	r0x0b, 1
	BRA	_00211_DS_
;	.line	128; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pprintchar(out, '-');
	MOVLW	0x2d
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	129; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++pc;
	MOVLW	0x01
	MOVWF	r0x11
	CLRF	r0x12
;	.line	130; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	--width;
	MOVLW	0xff
	ADDWF	r0x09, F
	BTFSS	STATUS, 0
	DECF	r0x0a, F
	BRA	_00215_DS_
_00211_DS_:
;	.line	134; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	*--s = '-';
	MOVLW	0xff
	ADDWF	r0x03, F
	ADDWFC	r0x04, F
	ADDWFC	r0x07, F
	MOVLW	0x2d
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x07, W
	CALL	__gptrput1
_00215_DS_:
;	.line	138; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	return pc + pprints(out, s, width, pad);
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprints
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x0a
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	ADDWF	r0x11, F
	MOVF	r0x01, W
	ADDWFC	r0x12, F
	MOVFF	r0x12, PRODL
	MOVF	r0x11, W
_00216_DS_:
	MOVFF	PREINC1, r0x1a
	MOVFF	PREINC1, r0x19
	MOVFF	PREINC1, r0x18
	MOVFF	PREINC1, r0x17
	MOVFF	PREINC1, r0x16
	MOVFF	PREINC1, r0x15
	MOVFF	PREINC1, r0x14
	MOVFF	PREINC1, r0x13
	MOVFF	PREINC1, r0x12
	MOVFF	PREINC1, r0x11
	MOVFF	PREINC1, r0x10
	MOVFF	PREINC1, r0x0f
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
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
S_main__pprints	code
_pprints:
;	.line	50; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	static int pprints(char **out, const char *string, int width, int pad)
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
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x10, POSTDEC1
	MOVFF	r0x11, POSTDEC1
	MOVFF	r0x12, POSTDEC1
	MOVFF	r0x13, POSTDEC1
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
	MOVLW	0x08
	MOVFF	PLUSW2, r0x06
	MOVLW	0x09
	MOVFF	PLUSW2, r0x07
	MOVLW	0x0a
	MOVFF	PLUSW2, r0x08
	MOVLW	0x0b
	MOVFF	PLUSW2, r0x09
;	.line	52; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	register int pc = 0;
	CLRF	r0x0a
	CLRF	r0x0b
;	.line	53; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	int padchar = ' ';
	MOVLW	0x20
	MOVWF	r0x0c
;	.line	57; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (width > 0)
	MOVF	r0x07, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00189_DS_
	MOVLW	0x01
	SUBWF	r0x06, W
_00189_DS_:
	BNC	_00153_DS_
;	.line	59; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for (ptr = string; *ptr; ++ptr)
	CLRF	r0x0e
	CLRF	r0x0f
	MOVFF	r0x03, r0x10
	MOVFF	r0x04, r0x11
	MOVFF	r0x05, r0x12
_00156_DS_:
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget1
	MOVWF	r0x13
	MOVF	r0x13, W
	BZ	_00159_DS_
;	.line	60; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++len;
	INCF	r0x0e, F
	BTFSC	STATUS, 0
	INCF	r0x0f, F
;	.line	59; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for (ptr = string; *ptr; ++ptr)
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
	BTFSC	STATUS, 0
	INCF	r0x12, F
	BRA	_00156_DS_
_00159_DS_:
;	.line	61; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (len >= width)
	MOVF	r0x0f, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x07, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00190_DS_
	MOVF	r0x06, W
	SUBWF	r0x0e, W
_00190_DS_:
	BNC	_00148_DS_
;	.line	62; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	width = 0;
	CLRF	r0x06
	CLRF	r0x07
	BRA	_00149_DS_
_00148_DS_:
;	.line	64; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	width -= len;
	MOVF	r0x0e, W
	SUBWF	r0x06, F
	MOVF	r0x0f, W
	SUBWFB	r0x07, F
_00149_DS_:
;	.line	65; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (pad & PAD_ZERO) padchar = '0';
	BTFSS	r0x08, 1
	BRA	_00153_DS_
	MOVLW	0x30
	MOVWF	r0x0c
_00153_DS_:
;	.line	67; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (!(pad & PAD_RIGHT))
	BTFSC	r0x08, 0
	BRA	_00182_DS_
	CLRF	r0x08
	CLRF	r0x09
	MOVFF	r0x06, r0x0e
	MOVFF	r0x07, r0x0f
_00160_DS_:
;	.line	69; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; width > 0; --width)
	MOVF	r0x0f, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00193_DS_
	MOVLW	0x01
	SUBWF	r0x0e, W
_00193_DS_:
	BNC	_00186_DS_
; #	MOVF	r0x0c, W
; #	MOVWF	r0x10
; #	MOVF	r0x10, W
;	.line	71; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pprintchar(out, padchar);
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	72; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++pc;
	INCF	r0x08, F
	BTFSC	STATUS, 0
	INCF	r0x09, F
;	.line	69; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; width > 0; --width)
	MOVLW	0xff
	ADDWF	r0x0e, F
	BTFSS	STATUS, 0
	DECF	r0x0f, F
	BRA	_00160_DS_
_00186_DS_:
	MOVFF	r0x08, r0x0a
	MOVFF	r0x09, r0x0b
	MOVFF	r0x0e, r0x06
	MOVFF	r0x0f, r0x07
_00182_DS_:
	MOVFF	r0x0a, r0x08
	MOVFF	r0x0b, r0x09
_00164_DS_:
;	.line	75; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; *string ; ++string)
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0a
	MOVF	r0x0a, W
	BZ	_00184_DS_
;	.line	77; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pprintchar(out, *string);
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	78; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++pc;
	INCF	r0x08, F
	BTFSC	STATUS, 0
	INCF	r0x09, F
;	.line	75; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; *string ; ++string)
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	BRA	_00164_DS_
_00184_DS_:
	MOVFF	r0x08, r0x03
	MOVFF	r0x09, r0x04
	MOVFF	r0x06, r0x05
	MOVFF	r0x07, r0x06
_00168_DS_:
;	.line	80; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; width > 0; --width)
	MOVF	r0x06, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00194_DS_
	MOVLW	0x01
	SUBWF	r0x05, W
_00194_DS_:
	BNC	_00171_DS_
; #	MOVF	r0x0c, W
; #	MOVWF	r0x07
; #	MOVF	r0x07, W
;	.line	82; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pprintchar(out, padchar);
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	83; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++pc;
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
;	.line	80; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	for ( ; width > 0; --width)
	MOVLW	0xff
	ADDWF	r0x05, F
	BTFSS	STATUS, 0
	DECF	r0x06, F
	BRA	_00168_DS_
_00171_DS_:
;	.line	86; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	return pc;
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x13
	MOVFF	PREINC1, r0x12
	MOVFF	PREINC1, r0x11
	MOVFF	PREINC1, r0x10
	MOVFF	PREINC1, r0x0f
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
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
S_main__pprintchar	code
_pprintchar:
;	.line	34; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	static void pprintchar(char **str, char c)
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
;	.line	36; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	if (str)
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	BZ	_00137_DS_
;	.line	38; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	**str = c;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget3
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVFF	PRODH, r0x06
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrput1
;	.line	39; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	++(*str);
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, PRODH
	MOVFF	r0x06, TBLPTRL
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput3
	BRA	_00139_DS_
_00137_DS_:
;	.line	43; /opt/pinguino/pinguino32/p8/include/pinguino/core/stdio.c	pputchar(c);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00142_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00142_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00142_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	(_pputchar + 2), PCLATU
	MOVFF	(_pputchar + 1), PCLATH
	BANKSEL	_pputchar
	MOVF	_pputchar, W, B
	MOVWF	PCL
_00142_DS_:
	MOVLW	0x01
	ADDWF	FSR1L, F
_00139_DS_:
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
S_main__analogread	code
_analogread:
;	.line	40; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	unsigned int analogread(unsigned char channel)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	55; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON0=(channel-13)*4;
	MOVLW	0xf3
	ADDWF	r0x00, F
; ;multiply lit val:0x04 by variable r0x00 and store in _ADCON0
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x00, W
	MULLW	0x04
	MOVFF	PRODL, _ADCON0
;	.line	59; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON0bits.ADON=1;
	BSF	_ADCON0bits, 0
;	.line	60; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	for (result=1;result<10;result++) __asm NOP __endasm;
	MOVLW	0x09
	MOVWF	r0x00
	CLRF	r0x01
_00130_DS_:
	NOP 
	MOVLW	0xff
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00130_DS_
;	.line	61; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON0bits.GO=1;
	BSF	_ADCON0bits, 1
_00125_DS_:
;	.line	62; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	while (ADCON0bits.GO);
	BTFSC	_ADCON0bits, 1
	BRA	_00125_DS_
;	.line	63; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	result=ADRESH<<8;
	MOVFF	_ADRESH, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x02
;	.line	64; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	result+=ADRESL;
	MOVFF	_ADRESL, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	ADDWF	r0x02, F
	MOVF	r0x01, W
	ADDWFC	r0x03, F
;	.line	65; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON0bits.ADON=0;
	BCF	_ADCON0bits, 0
;	.line	66; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	return(result);
	MOVFF	r0x03, PRODL
	MOVF	r0x02, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__analogReference	code
_analogReference:
;	.line	32; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	void analogReference(unsigned char Type)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
; #	MOVF	r0x00, W
; #	BTFSS	STATUS, 2
; #	GOTO	_00113_DS_
; #	GOTO	_00115_DS_
; #	MOVF	r0x00, W
;	.line	34; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	if(Type == DEFAULT)			//the default analog reference of 5 volts (on 5V Arduino boards) or 3.3 volts (on 3.3V Arduino boards)
	MOVF	r0x00, W
;	.line	35; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON1|=0x00;			//Vref+ = VDD
	BZ	_00115_DS_
;	.line	36; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	else if(Type == EXTERNAL)	//the voltage applied to the AREF pin (0 to 5V only) is used as the reference.
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00115_DS_
;	.line	37; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON1|=0x10;			//Vref+ = External source
	BSF	_ADCON1, 4
_00115_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__analog_init	code
_analog_init:
;	.line	25; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	TRISA=TRISA | 0x2F;
	MOVLW	0x2f
	IORWF	_TRISA, F
;	.line	26; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON1=0x0A;
	MOVLW	0x0a
	MOVWF	_ADCON1
;	.line	27; /opt/pinguino/pinguino32/p8/include/pinguino/core/analog.c	ADCON2=0xBD;
	MOVLW	0xbd
	MOVWF	_ADCON2
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x28, 0x6e, 0x75, 0x6c, 0x6c, 0x29, 0x00
; ; Starting pCode block
__str_1:
	DB	0x6e, 0x6f, 0x74, 0x20, 0x79, 0x65, 0x74, 0x20, 0x69, 0x6d, 0x70, 0x6c
	DB	0x65, 0x6d, 0x65, 0x6e, 0x74, 0x65, 0x64, 0x00, 0x00
; ; Starting pCode block
__str_2:
	DB	0x25, 0x63, 0x00
; ; Starting pCode block
__str_3:
	DB	0x25, 0x64, 0x00
; ; Starting pCode block
__str_4:
	DB	0x25, 0x78, 0x00
; ; Starting pCode block
__str_5:
	DB	0x25, 0x6f, 0x00
; ; Starting pCode block
__str_6:
	DB	0x25, 0x62, 0x00
; ; Starting pCode block
__str_7:
	DB	0x0a, 0x0d, 0x00


; Statistics:
; code size:	 5952 (0x1740) bytes ( 4.54%)
;           	 2976 (0x0ba0) words
; udata size:	  230 (0x00e6) bytes (12.83%)
; access size:	   27 (0x001b) bytes


	end
