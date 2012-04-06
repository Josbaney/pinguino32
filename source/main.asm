;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Aug  9 2009) (UNIX)
; This file was generated Fri Apr  6 11:23:32 2012
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f2550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _loopvar
	global _phase
	global _needreordering
	global _timingindex
	global _timedivision
	global _timings
	global _activatedservos
	global _servovalues
	global _maxminpos
	global _position
	global _Delayms
	global _Delayus
	global _servos_init
	global _ServoAttach
	global _ServoDetach
	global _ServoWrite
	global _ServoRead
	global _ServoMinimumPulse
	global _ServoMaximumPulse
	global _servos_interrupt
	global _epap_in
	global _epap_out
	global _epapin_init
	global _epapout_init
	global _setup
	global _loop
	global _pinguino_main
	global _high_priority_isr
	global _low_priority_isr
	global _servomasks

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
	extern _delay10ktcy
	extern ___uchar2fs
	extern ___fsdiv
	extern ___fsmul
	extern ___fsgt
	extern ___fsadd
	extern ___fs2uchar
	extern __divsint
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
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


	idata
_phase	db	0x00
_needreordering	db	0x00
_timedivision	db	0x00
_activatedservos	db	0x00, 0x00, 0x00
_position	db	0x01


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
_loopvar	res	1

udata_main_1	udata
_servovalues	res	18

udata_main_2	udata
_timingindex	res	1

udata_main_3	udata
_timings	res	72

udata_main_4	udata
_SortServoTimings_mascaratotal_1_1	res	3

udata_main_5	udata
_maxminpos	res	36

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block
S_main__high_priority_isr	code	0X002020
_high_priority_isr:
;	.line	130; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	void high_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	185; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	servos_interrupt();
	CALL	_servos_interrupt
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
;	.line	194; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	void low_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	199; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	}
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
;	.line	58; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	PIE1 = 0;
	CLRF	_PIE1
;	.line	59; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	PIE2 = 0;
	CLRF	_PIE2
;	.line	60; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	ADCON1 = 0b00001111;				// AN0 to AN12 Digital I/O
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	72; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	setup();
	CALL	_setup
;	.line	87; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	servos_init();
	CALL	_servos_init
;	.line	115; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	116; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	INTCONbits.GIE  = 1;
	BSF	_INTCONbits, 7
_00406_DS_:
;	.line	124; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	loop();
	CALL	_loop
	BRA	_00406_DS_
	RETURN	

; ; Starting pCode block
S_main__loop	code
_loop:
	BANKSEL	_position
;	.line	29; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	ServoWrite(13,position);
	MOVF	_position, W, B
	MOVWF	POSTDEC1
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_ServoWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	30; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	Delayms(500);
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	CALL	_Delayms
	MOVLW	0x04
	ADDWF	FSR1L, F
	BANKSEL	_position
;	.line	31; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	position++;
	INCF	_position, F, B
;	.line	32; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	if(position>180) position=0;
	MOVLW	0xb5
; #	SUBWF	_position, W, B
; #	BTFSS	STATUS, 0
; #	GOTO	_00397_DS_
; #	CLRF	_position, B
; #	MOVFF	PREINC1, FSR2L
; removed redundant BANKSEL
	SUBWF	_position, W, B
	BNC	_10418_DS_
; removed redundant BANKSEL
	CLRF	_position, B
_10418_DS_:
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	22; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	ServoAttach(13);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_ServoAttach
	INCF	FSR1L, F
;	.line	23; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	ServoMaximumPulse(13,2500);  
	MOVLW	0x09
	MOVWF	POSTDEC1
	MOVLW	0xc4
	MOVWF	POSTDEC1
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_ServoMaximumPulse
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	24; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/user.c	ServoMaximumPulse(13,500);   
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0xf4
	MOVWF	POSTDEC1
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_ServoMaximumPulse
	MOVLW	0x03
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__epapout_init	code
_epapout_init:
;	.line	46; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	void epapout_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epapin_init	code
_epapin_init:
;	.line	45; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	void epapin_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_out	code
_epap_out:
;	.line	44; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	void epap_out() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_in	code
_epap_in:
;	.line	43; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/source/main.c	void epap_in() { return; }
	RETURN	

; ; Starting pCode block
S_main__servos_interrupt	code
_servos_interrupt:
;	.line	1043; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (PIR1bits.TMR1IF) {
	BTFSS	_PIR1bits, 0
	BRA	_00365_DS_
;	.line	1044; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PIR1bits.TMR1IF=0;
	BCF	_PIR1bits, 0
;	.line	1045; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	T1CON=0x00;
	CLRF	_T1CON
	BANKSEL	_phase
;	.line	1046; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (phase) {
	MOVF	_phase, W, B
	BZ	_00361_DS_
;	.line	1048; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	ServosPulseUp();
	CALL	_ServosPulseUp
;	.line	1051; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TMR1H= 0xe8;
	MOVLW	0xe8
	MOVWF	_TMR1H
;	.line	1052; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TMR1L= 0x59;
	MOVLW	0x59
	MOVWF	_TMR1L
;	.line	1054; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	T1CON=1;
	MOVLW	0x01
	MOVWF	_T1CON
	BANKSEL	_phase
;	.line	1055; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	phase = 0;
	CLRF	_phase, B
	BRA	_00365_DS_
_00361_DS_:
;	.line	1060; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	ServosPulseDown();
	CALL	_ServosPulseDown
;	.line	1067; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TMR1H= 0x32;
	MOVLW	0x32
	MOVWF	_TMR1H
;	.line	1068; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TMR1L= 0xeb;
	MOVLW	0xeb
	MOVWF	_TMR1L
; #	MOVF	_needreordering, W, B
; #	BTFSC	STATUS, 2
; #	GOTO	_00359_DS_
; #	CALL	_SortServoTimings
; #	MOVLW	0x21
	BANKSEL	_needreordering
;	.line	1070; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (needreordering)	
	MOVF	_needreordering, W, B
;	.line	1071; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	SortServoTimings();  // This takes more than 1 ms, but it's call only if needed.
	BTFSS	STATUS, 2
;	.line	1072; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	T1CON= ( 1 | 2 << 4 ) ; // activate timer1 and prescaler = 1:4
	CALL	_SortServoTimings
	MOVLW	0x21
	MOVWF	_T1CON
;	.line	1073; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	phase = 1;  //This indicates that after next interrupt it will start the servos cycle.
	MOVLW	0x01
	BANKSEL	_phase
	MOVWF	_phase, B
_00365_DS_:
;	.line	1076; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return;
	RETURN	

; ; Starting pCode block
S_main__ServoMaximumPulse	code
_ServoMaximumPulse:
;	.line	1020; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	void ServoMaximumPulse(unsigned char servo,int max_microseconds)
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
;	.line	1025; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(servo>=PIC18F2550_pins)        
	MOVLW	0x12
; #	SUBWF	r0x00, W
; #	BTFSS	STATUS, 0
; #	GOTO	_00343_DS_
; #	GOTO	_00347_DS_
; #	MOVF	r0x02, W
;	.line	1026; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return;
	SUBWF	r0x00, W
;	.line	1028; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if((max_microseconds<500) || (max_microseconds>2500))
	BC	_00347_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x7f
	BNZ	_00352_DS_
	MOVLW	0xf4
	SUBWF	r0x01, W
_00352_DS_:
	BNC	_00347_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x77
	BNZ	_00353_DS_
	MOVLW	0xc5
	SUBWF	r0x01, W
_00353_DS_:
	BNC	_00345_DS_
_00344_DS_:
;	.line	1029; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return;
	BRA	_00347_DS_
_00345_DS_:
;	.line	1032; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	final_max=(max_microseconds-500+1)/8;
	MOVLW	0x0d
	ADDWF	r0x01, F
	MOVLW	0xfe
	ADDWFC	r0x02, F
	CLRF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	1035; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	maxminpos[1][servo]=final_max; 
	CLRF	r0x02
	MOVLW	LOW(_maxminpos + 18)
	ADDWF	r0x00, F
	MOVLW	HIGH(_maxminpos + 18)
	ADDWFC	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x01, INDF0
_00347_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ServoMinimumPulse	code
_ServoMinimumPulse:
;	.line	1001; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	void ServoMinimumPulse(unsigned char servo,int min_microseconds)
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
;	.line	1006; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(servo>=PIC18F2550_pins)        
	MOVLW	0x12
; #	SUBWF	r0x00, W
; #	BTFSS	STATUS, 0
; #	GOTO	_00327_DS_
; #	GOTO	_00331_DS_
; #	MOVF	r0x02, W
;	.line	1007; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return;
	SUBWF	r0x00, W
;	.line	1009; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if((min_microseconds<500) || (min_microseconds>2500))
	BC	_00331_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x7f
	BNZ	_00336_DS_
	MOVLW	0xf4
	SUBWF	r0x01, W
_00336_DS_:
	BNC	_00331_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x77
	BNZ	_00337_DS_
	MOVLW	0xc5
	SUBWF	r0x01, W
_00337_DS_:
	BNC	_00329_DS_
_00328_DS_:
;	.line	1010; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return;
	BRA	_00331_DS_
_00329_DS_:
;	.line	1013; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	final_min=(min_microseconds-500+1)/8;
	MOVLW	0x0d
	ADDWF	r0x01, F
	MOVLW	0xfe
	ADDWFC	r0x02, F
	CLRF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	1016; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	maxminpos[0][servo]=final_min; 
	CLRF	r0x02
	MOVLW	LOW(_maxminpos)
	ADDWF	r0x00, F
	MOVLW	HIGH(_maxminpos)
	ADDWFC	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x01, INDF0
_00331_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ServoRead	code
_ServoRead:
;	.line	993; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	unsigned char ServoRead(uchar servo)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	995; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(servo>=PIC18F2550_pins)        // test if numservo is valid
	MOVLW	0x12
	SUBWF	r0x00, W
	BNC	_00317_DS_
;	.line	996; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return 0;
	CLRF	WREG
	BRA	_00318_DS_
_00317_DS_:
;	.line	997; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return servovalues[servo];
	CLRF	r0x01
	MOVLW	LOW(_servovalues)
	ADDWF	r0x00, F
	MOVLW	HIGH(_servovalues)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
_00318_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ServoWrite	code
_ServoWrite:
;	.line	964; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	void ServoWrite(unsigned char servo,unsigned char degrees)
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
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	971; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(servo>=PIC18F2550_pins) {
	MOVLW	0x12
; #	SUBWF	r0x00, W
; #	BTFSS	STATUS, 0
; #	GOTO	_00300_DS_
; #	GOTO	_00303_DS_
; #	MOVLW	0xb5
;	.line	972; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	return;
	SUBWF	r0x00, W
;	.line	975; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(degrees>180) {
	BTFSC	STATUS, 0
	BRA	_00303_DS_
	MOVLW	0xb5
	SUBWF	r0x01, W
	BNC	_00302_DS_
;	.line	976; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	degrees=180;
	MOVLW	0xb4
	MOVWF	r0x01
_00302_DS_:
;	.line	980; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	difference = (maxminpos[1][servo]-maxminpos[0][servo]);
	MOVLW	LOW(_maxminpos + 18)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_maxminpos + 18)
	ADDWFC	r0x03, F
	MOVLW	LOW(_maxminpos)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_maxminpos)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x04, W
	SUBWF	r0x02, F
;	.line	981; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	ticksperdegree = ((float)difference/180);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	___uchar2fs
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x05
	MOVFF	FSR0L, r0x06
	INCF	FSR1L, F
	MOVLW	0x43
	MOVWF	POSTDEC1
	MOVLW	0x34
	MOVWF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	___fsdiv
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVFF	PRODH, r0x05
	MOVFF	FSR0L, r0x06
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	982; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	value = abs(degrees*ticksperdegree) + maxminpos[0][servo];
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	___uchar2fs
	MOVWF	r0x01
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
	MOVFF	FSR0L, r0x09
	INCF	FSR1L, F
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	___fsmul
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x05
	MOVLW	0x08
	ADDWF	FSR1L, F
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	___fsgt
	MOVWF	r0x06
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	BZ	_00305_DS_
	MOVFF	r0x01, r0x06
	MOVFF	r0x02, r0x07
	MOVFF	r0x03, r0x08
	MOVFF	r0x05, r0x09
	BRA	_00306_DS_
_00305_DS_:
	MOVFF	r0x01, r0x06
	MOVFF	r0x02, r0x07
	MOVFF	r0x03, r0x08
	MOVFF	r0x05, r0x09
	BTG	r0x09, 7
_00306_DS_:
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	___uchar2fs
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	INCF	FSR1L, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	___fsadd
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	___fs2uchar
	MOVWF	r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	987; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	servovalues[servo]= value;
	CLRF	r0x02
	MOVLW	LOW(_servovalues)
	ADDWF	r0x00, F
	MOVLW	HIGH(_servovalues)
	ADDWFC	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x01, INDF0
;	.line	989; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	needreordering=1;  // This indicates servo timings must be reordered.
	MOVLW	0x01
	BANKSEL	_needreordering
	MOVWF	_needreordering, B
_00303_DS_:
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
S_main__ServoDetach	code
_ServoDetach:
;	.line	949; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	void ServoDetach(uchar pin)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	951; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(pin>=PIC18F2550_pins) return;
	MOVLW	0x12
; #	SUBWF	r0x00, W
; #	BTFSS	STATUS, 0
; #	GOTO	_00279_DS_
; #	GOTO	_00286_DS_
; #	MOVLW	0x08
;	.line	953; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(pin<8){
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00286_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
	BC	_00284_DS_
;	.line	954; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	activatedservos[MaskPort_B] = activatedservos[MaskPort_B] ^ servomasks[pin];
	MOVLW	LOW(_servomasks)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	BANKSEL	_activatedservos
	MOVF	_activatedservos, W, B
	XORWF	r0x01, F
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	_activatedservos, B
	BRA	_00286_DS_
_00284_DS_:
;	.line	955; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	} else if (pin>12) {
	MOVLW	0x0d
	SUBWF	r0x00, W
	BNC	_00281_DS_
;	.line	956; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	activatedservos[MaskPort_A] = activatedservos[MaskPort_A] ^ servomasks[pin];
	MOVLW	LOW(_servomasks)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	BANKSEL	(_activatedservos + 2)
	MOVF	(_activatedservos + 2), W, B
	XORWF	r0x01, F
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_activatedservos + 2), B
	BRA	_00286_DS_
_00281_DS_:
;	.line	958; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	activatedservos[MaskPort_C] = activatedservos[MaskPort_C] ^ servomasks[pin];
	CLRF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_servomasks)
	ADDWF	r0x00, F
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x01, F
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	BANKSEL	(_activatedservos + 1)
	MOVF	(_activatedservos + 1), W, B
	XORWF	r0x00, F
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_activatedservos + 1), B
_00286_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ServoAttach	code
_ServoAttach:
;	.line	929; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	void ServoAttach(uchar pin)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	931; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(pin>=PIC18F2550_pins) return;
	MOVLW	0x12
; #	SUBWF	r0x00, W
; #	BTFSS	STATUS, 0
; #	GOTO	_00257_DS_
; #	GOTO	_00264_DS_
; #	MOVLW	0x08
;	.line	933; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if(pin<8){
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00264_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
	BC	_00262_DS_
;	.line	934; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	activatedservos[MaskPort_B] = activatedservos[MaskPort_B] | servomasks[pin];  // list pin as servo driver.
	MOVLW	LOW(_servomasks)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	BANKSEL	_activatedservos
	IORWF	_activatedservos, W, B
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
	MOVWF	_activatedservos, B
;	.line	935; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TRISB = TRISB & (255 - servomasks[pin]); // set as output pin
	MOVF	r0x01, W
	SUBLW	0xff
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
	ANDWF	_TRISB, F
	BRA	_00264_DS_
_00262_DS_:
;	.line	936; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	} else if (pin>12) {
	MOVLW	0x0d
	SUBWF	r0x00, W
	BNC	_00259_DS_
;	.line	937; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	activatedservos[MaskPort_A] = activatedservos[MaskPort_A] | servomasks[pin];  // list pin as servo driver.
	MOVLW	LOW(_servomasks)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	BANKSEL	(_activatedservos + 2)
	IORWF	(_activatedservos + 2), W, B
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
	MOVWF	(_activatedservos + 2), B
;	.line	938; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TRISA = TRISA & (255 - servomasks[pin]); // set as output pin
	MOVF	r0x01, W
	SUBLW	0xff
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
	ANDWF	_TRISA, F
	BRA	_00264_DS_
_00259_DS_:
;	.line	940; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	activatedservos[MaskPort_C] = activatedservos[MaskPort_C] | servomasks[pin];  // list pin as servo driver.
	CLRF	r0x01
	CLRF	r0x02
	MOVLW	LOW(_servomasks)
	ADDWF	r0x00, F
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x01, F
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x02, F
	MOVFF	r0x00, TBLPTRL
	MOVFF	r0x01, TBLPTRH
	MOVFF	r0x02, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x00
	MOVF	r0x00, W
	BANKSEL	(_activatedservos + 1)
	IORWF	(_activatedservos + 1), W, B
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
	MOVWF	(_activatedservos + 1), B
;	.line	941; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TRISC = TRISC & (255 - servomasks[pin]); // set as output pin
	MOVF	r0x00, W
	SUBLW	0xff
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	ANDWF	_TRISC, F
_00264_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SortServoTimings	code
_SortServoTimings:
;	.line	845; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	static void SortServoTimings()
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
	BANKSEL	_SortServoTimings_mascaratotal_1_1
;	.line	852; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	uchar mascaratotal[3]={0x00,0x00,0x00};
	CLRF	_SortServoTimings_mascaratotal_1_1, B
; removed redundant BANKSEL
	CLRF	(_SortServoTimings_mascaratotal_1_1 + 1), B
; removed redundant BANKSEL
	CLRF	(_SortServoTimings_mascaratotal_1_1 + 2), B
;	.line	855; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(t=0;t<PIC18F2550_pins;t++){
	CLRF	r0x00
_00203_DS_:
	MOVLW	0x12
	SUBWF	r0x00, W
	BC	_00206_DS_
;	.line	856; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[timevalue][t]=255;
	MOVLW	LOW(_timings + 54)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_timings + 54)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	SETF	INDF0
;	.line	857; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_B][t]=0x00;
	MOVLW	LOW(_timings)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_timings)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	CLRF	INDF0
;	.line	858; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_C][t]=0x00;
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	CLRF	INDF0
;	.line	859; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_A][t]=0x00;
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	CLRF	INDF0
;	.line	855; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(t=0;t<PIC18F2550_pins;t++){
	INCF	r0x00, F
	BRA	_00203_DS_
_00206_DS_:
;	.line	862; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	totalservos=0;
	CLRF	r0x00
;	.line	864; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	while(totalservos<PIC18F2550_pins) {
	CLRF	r0x01
_00200_DS_:
	MOVLW	0x12
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00202_DS_
;	.line	865; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos=1;
	MOVLW	0x01
	MOVWF	r0x02
;	.line	866; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(s=0;s<PIC18F2550_pins;s++) { 
	CLRF	r0x03
_00207_DS_:
	MOVLW	0x12
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_00210_DS_
;	.line	868; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (s<8){
	MOVLW	0x08
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_00198_DS_
;	.line	869; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (servomasks[s] & mascaratotal[MaskPort_B] & activatedservos[MaskPort_B]){
	MOVLW	LOW(_servomasks)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x05, F
	CLRF	r0x06
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	BANKSEL	_SortServoTimings_mascaratotal_1_1
	MOVF	_SortServoTimings_mascaratotal_1_1, W, B
	ANDWF	r0x04, W
	MOVWF	r0x05
	BANKSEL	_activatedservos
	MOVF	_activatedservos, W, B
	ANDWF	r0x05, F
	MOVF	r0x05, W
	BTFSS	STATUS, 2
	BRA	_00209_DS_
;	.line	871; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (servovalues[s] < timings[timevalue][t]){
	MOVLW	LOW(_servovalues)
	ADDWF	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_servovalues)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVLW	LOW(_timings + 54)
	ADDWF	r0x01, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_timings + 54)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	SUBWF	r0x05, W
	BC	_00173_DS_
;	.line	872; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[timevalue][t]=servovalues[s];
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x05, INDF0
;	.line	873; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_B][t]=servomasks[s];
	MOVLW	LOW(_timings)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x04, INDF0
;	.line	874; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_C][t]=0x00;
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	875; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_A][t]=0x00;
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	876; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos=1;
	MOVLW	0x01
	MOVWF	r0x02
	BRA	_00209_DS_
_00173_DS_:
;	.line	878; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (servovalues[s] == timings[timevalue][t]){
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x05, W
	XORWF	r0x06, W
	BZ	_00240_DS_
	BRA	_00209_DS_
_00240_DS_:
;	.line	879; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_B][t] |= servomasks[s];
	MOVLW	LOW(_timings)
	ADDWF	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_timings)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	IORWF	r0x04, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x04, INDF0
;	.line	880; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos++;
	INCF	r0x02, F
	BRA	_00209_DS_
_00198_DS_:
;	.line	884; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (s>12){
	MOVLW	0x0d
	SUBWF	r0x03, W
	BTFSS	STATUS, 0
	BRA	_00195_DS_
;	.line	885; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (servomasks[s] & mascaratotal[MaskPort_A] & activatedservos[MaskPort_A]){
	MOVLW	LOW(_servomasks)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x05, F
	CLRF	r0x06
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	BANKSEL	(_SortServoTimings_mascaratotal_1_1 + 2)
	MOVF	(_SortServoTimings_mascaratotal_1_1 + 2), W, B
	ANDWF	r0x04, W
	MOVWF	r0x05
	BANKSEL	(_activatedservos + 2)
	MOVF	(_activatedservos + 2), W, B
	ANDWF	r0x05, F
	MOVF	r0x05, W
	BTFSS	STATUS, 2
	BRA	_00209_DS_
;	.line	887; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (servovalues[s] < timings[timevalue][t]){
	MOVLW	LOW(_servovalues)
	ADDWF	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_servovalues)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVLW	LOW(_timings + 54)
	ADDWF	r0x01, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_timings + 54)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	SUBWF	r0x05, W
	BC	_00181_DS_
;	.line	888; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[timevalue][t]=servovalues[s];
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x05, INDF0
;	.line	889; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_B][t]=0x00;
	MOVLW	LOW(_timings)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	890; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_C][t]=0x00;
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	891; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_A][t]=servomasks[s];
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x04, INDF0
;	.line	892; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos=1;
	MOVLW	0x01
	MOVWF	r0x02
	BRA	_00209_DS_
_00181_DS_:
;	.line	894; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (servovalues[s] == timings[timevalue][t]){
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x05, W
	XORWF	r0x06, W
	BZ	_00246_DS_
	BRA	_00209_DS_
_00246_DS_:
;	.line	895; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_A][t] |= servomasks[s];
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	IORWF	r0x04, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x04, INDF0
;	.line	896; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos++;
	INCF	r0x02, F
	BRA	_00209_DS_
_00195_DS_:
;	.line	901; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (servomasks[s] & mascaratotal[MaskPort_C] & activatedservos[MaskPort_C]){ 
	MOVLW	LOW(_servomasks)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_servomasks)
	ADDWFC	r0x05, F
	CLRF	r0x06
	MOVLW	UPPER(_servomasks)
	ADDWFC	r0x06, F
	MOVFF	r0x04, TBLPTRL
	MOVFF	r0x05, TBLPTRH
	MOVFF	r0x06, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x04
	BANKSEL	(_SortServoTimings_mascaratotal_1_1 + 1)
	MOVF	(_SortServoTimings_mascaratotal_1_1 + 1), W, B
	ANDWF	r0x04, W
	MOVWF	r0x05
	BANKSEL	(_activatedservos + 1)
	MOVF	(_activatedservos + 1), W, B
	ANDWF	r0x05, F
	MOVF	r0x05, W
	BTFSS	STATUS, 2
	BRA	_00209_DS_
;	.line	903; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (servovalues[s] < timings[timevalue][t]){
	MOVLW	LOW(_servovalues)
	ADDWF	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_servovalues)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVLW	LOW(_timings + 54)
	ADDWF	r0x01, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_timings + 54)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	SUBWF	r0x05, W
	BC	_00189_DS_
;	.line	904; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[timevalue][t]=servovalues[s];
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x05, INDF0
;	.line	905; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_B][t]=0x00;
	MOVLW	LOW(_timings)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	906; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_C][t]=servomasks[s];
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x04, INDF0
;	.line	907; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_A][t]=0x00;
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x01, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	908; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos=1;
	MOVLW	0x01
	MOVWF	r0x02
	BRA	_00209_DS_
_00189_DS_:
;	.line	910; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	else if (servovalues[s] == timings [timevalue][t]){
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x05, W
	XORWF	r0x06, W
	BNZ	_00209_DS_
;	.line	911; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timings[MaskPort_C][t] |= servomasks[s];
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	IORWF	r0x04, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x04, INDF0
;	.line	912; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	numservos++;
	INCF	r0x02, F
_00209_DS_:
;	.line	866; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(s=0;s<PIC18F2550_pins;s++) { 
	INCF	r0x03, F
	BRA	_00207_DS_
_00210_DS_:
;	.line	917; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	mascaratotal[MaskPort_B] |= timings[MaskPort_B][t];
	MOVLW	LOW(_timings)
	ADDWF	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_timings)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	BANKSEL	_SortServoTimings_mascaratotal_1_1
	MOVF	_SortServoTimings_mascaratotal_1_1, W, B
	IORWF	r0x03, F
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	_SortServoTimings_mascaratotal_1_1, B
;	.line	918; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	mascaratotal[MaskPort_C] |= timings[MaskPort_C][t];
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
; removed redundant BANKSEL
	MOVF	(_SortServoTimings_mascaratotal_1_1 + 1), W, B
	IORWF	r0x03, F
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_SortServoTimings_mascaratotal_1_1 + 1), B
;	.line	919; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	mascaratotal[MaskPort_A] |= timings[MaskPort_A][t];
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x01, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
; removed redundant BANKSEL
	MOVF	(_SortServoTimings_mascaratotal_1_1 + 2), W, B
	IORWF	r0x03, F
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_SortServoTimings_mascaratotal_1_1 + 2), B
;	.line	920; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	totalservos += numservos;
	MOVF	r0x02, W
	ADDWF	r0x00, F
;	.line	921; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	t++;
	INCF	r0x01, F
	BRA	_00200_DS_
_00202_DS_:
	BANKSEL	_needreordering
;	.line	924; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	needreordering=0;  // This indicates that servo timings is ordered.	
	CLRF	_needreordering, B
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
	RETURN	

; ; Starting pCode block
S_main__ServosPulseUp	code
_ServosPulseUp:
;	.line	839; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PORTB = activatedservos[MaskPort_B] & 0xFF;
	MOVFF	_activatedservos, _PORTB
;	.line	840; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PORTC = activatedservos[MaskPort_C] & 0xFF;
	MOVFF	(_activatedservos + 1), _PORTC
;	.line	841; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PORTA = activatedservos[MaskPort_A] & 0xFF;	
	MOVFF	(_activatedservos + 2), _PORTA
	RETURN	

; ; Starting pCode block
S_main__ServosPulseDown	code
_ServosPulseDown:
;	.line	805; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	static void ServosPulseDown()
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	BANKSEL	_timingindex
;	.line	807; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timingindex = 0;
	CLRF	_timingindex, B
	BANKSEL	_timedivision
;	.line	809; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(timedivision=0;timedivision < 251;timedivision++){
	CLRF	_timedivision, B
_00149_DS_:
	MOVLW	0xfb
	BANKSEL	_timedivision
	SUBWF	_timedivision, W, B
	BTFSC	STATUS, 0
	BRA	_00153_DS_
;	.line	810; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	if (timings[timevalue][timingindex] == timedivision){
	MOVFF	_timingindex, r0x00
	CLRF	r0x01
	MOVLW	LOW(_timings + 54)
	ADDWF	r0x00, F
	MOVLW	HIGH(_timings + 54)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
; removed redundant BANKSEL
	XORWF	_timedivision, W, B
	BNZ	_00148_DS_
;	.line	811; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PORTB = PORTB ^ timings[MaskPort_B][timingindex];
	MOVFF	_timingindex, r0x00
	CLRF	r0x01
	MOVLW	LOW(_timings)
	ADDWF	r0x00, F
	MOVLW	HIGH(_timings)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	XORWF	_PORTB, F
;	.line	812; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PORTC = PORTC ^ timings[MaskPort_C][timingindex];
	MOVFF	_timingindex, r0x00
	CLRF	r0x01
	MOVLW	LOW(_timings + 18)
	ADDWF	r0x00, F
	MOVLW	HIGH(_timings + 18)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	XORWF	_PORTC, F
;	.line	813; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PORTA = PORTA ^ timings[MaskPort_A][timingindex];
	MOVFF	_timingindex, r0x00
	CLRF	r0x01
	MOVLW	LOW(_timings + 36)
	ADDWF	r0x00, F
	MOVLW	HIGH(_timings + 36)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x00
	MOVF	r0x00, W
	XORWF	_PORTA, F
	BANKSEL	_timingindex
;	.line	814; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	timingindex++;
	INCF	_timingindex, F, B
_00148_DS_:
	movlw 6
	movwf _loopvar
bucle:
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	decfsz _loopvar,1
	goto bucle
	
	BANKSEL	_timedivision
;	.line	809; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(timedivision=0;timedivision < 251;timedivision++){
	INCF	_timedivision, F, B
	BRA	_00149_DS_
_00153_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__servos_init	code
_servos_init:
;	.line	782; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	void servos_init()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	786; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(a=0;a<PIC18F2550_pins;a++) {
	CLRF	r0x00
_00133_DS_:
	MOVLW	0x12
	SUBWF	r0x00, W
	BC	_00136_DS_
;	.line	787; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	servovalues[a]=255;
	MOVLW	LOW(_servovalues)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_servovalues)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	SETF	INDF0
;	.line	786; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	for(a=0;a<PIC18F2550_pins;a++) {
	INCF	r0x00, F
	BRA	_00133_DS_
_00136_DS_:
;	.line	791; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TMR1H=0xFF;
	SETF	_TMR1H
;	.line	792; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	TMR1L=0x00;
	CLRF	_TMR1L
;	.line	794; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	T1CON=0x01;
	MOVLW	0x01
	MOVWF	_T1CON
;	.line	796; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	PIE1bits.TMR1IE=1;
	BSF	_PIE1bits, 0
;	.line	798; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	INTCONbits.PEIE=1;
	BSF	_INTCONbits, 6
;	.line	800; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/libraries/servos.c	INTCONbits.GIE=1;
	BSF	_INTCONbits, 7
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__Delayus	code
_Delayus:
;	.line	16; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/core/delay.c	void Delayus(int microsecondes)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	20; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/core/delay.c	for (i=0;i<microsecondes;i++);
	CLRF	r0x02
	CLRF	r0x03
_00119_DS_:
	MOVF	r0x01, W
	SUBWF	r0x03, W
	BNZ	_00128_DS_
	MOVF	r0x00, W
	SUBWF	r0x02, W
_00128_DS_:
	BC	_00123_DS_
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	BRA	_00119_DS_
_00123_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__Delayms	code
_Delayms:
;	.line	9; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/core/delay.c	void Delayms(unsigned long milliseconde)
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
;	.line	13; /home/jesuscarlos/Programming_box/Pinguino/Pinguino32X_20120405/svn/trunk/p8/include/pinguino/core/delay.c	for (i=0;i<milliseconde;i++) delay10ktcy(1);
	CLRF	r0x04
	CLRF	r0x05
	CLRF	r0x06
	CLRF	r0x07
_00105_DS_:
	MOVF	r0x03, W
	SUBWF	r0x07, W
	BNZ	_00114_DS_
	MOVF	r0x02, W
	SUBWF	r0x06, W
	BNZ	_00114_DS_
	MOVF	r0x01, W
	SUBWF	r0x05, W
	BNZ	_00114_DS_
	MOVF	r0x00, W
	SUBWF	r0x04, W
_00114_DS_:
	BC	_00109_DS_
	MOVLW	0x01
	CALL	_delay10ktcy
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	BRA	_00105_DS_
_00109_DS_:
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

; ; Starting pCode block for Ival
	code
_servomasks:
	DB	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x40, 0x80, 0x01, 0x02
	DB	0x04, 0x01, 0x02, 0x04, 0x08, 0x20


; Statistics:
; code size:	 3356 (0x0d1c) bytes ( 2.56%)
;           	 1678 (0x068e) words
; udata size:	  131 (0x0083) bytes ( 7.31%)
; access size:	   10 (0x000a) bytes


	end
