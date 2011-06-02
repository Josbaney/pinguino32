;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.0 #5416 (Aug  9 2009) (UNIX)
; This file was generated Sun May 29 20:37:50 2011
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f2550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _opp_king_pos
	global _val_empty
	global _val_pawn
	global _val_bishop
	global _val_knight
	global _val_rook
	global _val_queen
	global _val_king
	global _val_north
	global _val_south
	global _val_east
	global _val_west
	global _val_northwest
	global _val_northeast
	global _val_southeast
	global _val_southwest
	global _getbestpiecemove
	global _test_singlemove
	global _rate_move
	global _draw_move
	global _updatekingpos
	global _init_board
	global _draw_chessboard
	global _read_movement
	global _rx
	global _wpointer
	global _rpointer
	global _board
	global _validmovemask
	global _capturemask
	global _movecount
	global _movetype
	global _rate
	global _piecerate
	global _lastmove
	global _wh_king_pos
	global _bl_king_pos
	global _kingcapture
	global _wh_base_cont
	global _bl_base_cont
	global _currcapturemask
	global _currmovemask
	global _validate
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
	global _serial_write
	global _epap_in
	global _epap_out
	global _epapin_init
	global _epapout_init
	global _setup
	global _loop
	global _pinguino_main
	global _high_priority_isr
	global _low_priority_isr
	global _ligne

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern __gptrget3
	extern __gptrput1
	extern __gptrput3
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
	extern _uitoa
	extern __moduint
	extern __divuint
	extern __mulint
	extern __mullong
	extern __divulong
	extern __modsint
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
FSR1H	equ	0xfe2
FSR2L	equ	0xfd9
FSR2H	equ	0xfda
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW1	equ	0xfe3
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_validate	db	LOW(_val_empty), HIGH(_val_empty), UPPER(_val_empty), LOW(_val_pawn), HIGH(_val_pawn), UPPER(_val_pawn), LOW(_val_rook), HIGH(_val_rook), UPPER(_val_rook), LOW(_val_knight), HIGH(_val_knight), UPPER(_val_knight)
	db	LOW(_val_bishop), HIGH(_val_bishop), UPPER(_val_bishop), LOW(_val_queen), HIGH(_val_queen), UPPER(_val_queen), LOW(_val_king), HIGH(_val_king), UPPER(_val_king)


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
r0x1b	res	1
r0x1c	res	1
r0x1d	res	1
r0x1e	res	1

udata_main_0	udata
_pputchar	res	3

udata_main_1	udata
_opp_king_pos	res	2

udata_main_2	udata
_val_knight_move_1_1	res	48

udata_main_3	udata
_pprinti_print_buf_1_1	res	12

udata_main_4	udata
_pprint_scr_1_1	res	2

udata_main_5	udata
_psprintf_out_1_1	res	3

udata_main_6	udata
_wpointer	res	1

udata_main_7	udata
_rpointer	res	1

udata_main_8	udata
_rx	res	128

udata_main_9	udata
_serial_getstring_buffer_1_1	res	80

udata_main_10	udata
_movecount	res	2

udata_main_11	udata
_movetype	res	1

udata_main_12	udata
_piecerate	res	1

udata_main_13	udata
_rate	res	1

udata_main_14	udata
_lastmove	res	1

udata_main_15	udata
_loop_from_1_1	res	2

udata_main_16	udata
_loop_to_1_1	res	2

udata_main_17	udata
_loop_cpufrom_1_1	res	2

udata_main_18	udata
_loop_cputo_1_1	res	2

udata_main_19	udata
_currmovemask	res	8

udata_main_20	udata
_currcapturemask	res	8

udata_main_21	udata
_getbestpiecemove_to_1_1	res	2

udata_main_22	udata
_test_singlemove_opp_pos_1_1	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block
S_main__high_priority_isr	code	0X002020
_high_priority_isr:
;	.line	121; /home/mandon/pinguino32/copie courante/linux/source/main.c	void high_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
;	.line	157; /home/mandon/pinguino32/copie courante/linux/source/main.c	if (PIR1bits.RCIF) 
	MOVFF	PCLATU, POSTDEC1
; #	MOVFF	FSR1L, FSR2L
; #	BTFSS	_PIR1bits, 5
; #	GOTO	_01486_DS_
; #	CALL	_serial_interrupt
; #	MOVFF	PREINC1, FSR2L
;	.line	158; /home/mandon/pinguino32/copie courante/linux/source/main.c	serial_interrupt();
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
;	.line	185; /home/mandon/pinguino32/copie courante/linux/source/main.c	void low_priority_isr(void) interrupt
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	190; /home/mandon/pinguino32/copie courante/linux/source/main.c	}
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
;	.line	53; /home/mandon/pinguino32/copie courante/linux/source/main.c	PIE1 = 0;
	CLRF	_PIE1
;	.line	54; /home/mandon/pinguino32/copie courante/linux/source/main.c	PIE2 = 0;
	CLRF	_PIE2
;	.line	55; /home/mandon/pinguino32/copie courante/linux/source/main.c	ADCON1 = 0b00001111;				// AN0 to AN12 Digital I/O
	MOVLW	0x0f
	MOVWF	_ADCON1
;	.line	67; /home/mandon/pinguino32/copie courante/linux/source/main.c	setup();
	CALL	_setup
;	.line	100; /home/mandon/pinguino32/copie courante/linux/source/main.c	INTCONbits.PEIE = 1;
	BSF	_INTCONbits, 6
;	.line	101; /home/mandon/pinguino32/copie courante/linux/source/main.c	INTCONbits.GIE  = 1;
	BSF	_INTCONbits, 7
_01477_DS_:
;	.line	115; /home/mandon/pinguino32/copie courante/linux/source/main.c	loop();
	CALL	_loop
	BRA	_01477_DS_
	RETURN	

; ; Starting pCode block
S_main__read_movement	code
_read_movement:
;	.line	548; /home/mandon/pinguino32/copie courante/linux/source/user.c	BOOL read_movement (LOC from, LOC to)
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
;	.line	554; /home/mandon/pinguino32/copie courante/linux/source/user.c	chaine = serial_getstring(); // recupere le coup jour de la forme e2e4
	CALL	_serial_getstring
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVFF	PRODH, r0x08
;	.line	557; /home/mandon/pinguino32/copie courante/linux/source/user.c	from[1] = chaine[0]-'a';
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x09
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x0a
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x0b
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, PRODL
	MOVF	r0x08, W
	CALL	__gptrget1
	MOVWF	r0x0c
	MOVLW	0x9f
	ADDWF	r0x0c, F
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, PRODL
	MOVF	r0x0b, W
	CALL	__gptrput1
;	.line	558; /home/mandon/pinguino32/copie courante/linux/source/user.c	from[0] = chaine[1]-'1';
	MOVF	r0x06, W
	ADDLW	0x01
	MOVWF	r0x0c
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x0d
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, PRODL
	CALL	__gptrget1
	MOVWF	r0x0c
	MOVLW	0xcf
	ADDWF	r0x0c, F
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
;	.line	562; /home/mandon/pinguino32/copie courante/linux/source/user.c	p = board[from[0]][from[1]];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #;;multiply lit val:0x08 by variable r0x0c and store in r0x0c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0c, W
	MULLW	0x08
	MOVFF	PRODL, r0x0c
	CLRF	r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0c, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0d, F
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, PRODL
	MOVF	r0x0b, W
	CALL	__gptrget1
; #	MOVWF	r0x0e
; #	MOVF	r0x0e, W
	ADDWF	r0x0c, F
	CLRF	WREG
	ADDWFC	r0x0d, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	MOVFF	INDF0, r0x0c
;	.line	563; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (p == EMPTY || p & BLACK)
	MOVF	r0x0c, W
	BZ	_01456_DS_
	BTFSS	r0x0c, 3
	BRA	_01457_DS_
_01456_DS_:
;	.line	565; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_printf("\r\nillegal move!\r\n");
	MOVLW	UPPER(__str_21)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_21)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_21)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	566; /home/mandon/pinguino32/copie courante/linux/source/user.c	return FALSE;
	CLRF	WREG
	BRA	_01459_DS_
_01457_DS_:
;	.line	569; /home/mandon/pinguino32/copie courante/linux/source/user.c	to[1] = chaine[2]-'a';
	MOVF	r0x03, W
	ADDLW	0x01
	MOVWF	r0x0c
	MOVLW	0x00
	ADDWFC	r0x04, W
	MOVWF	r0x0d
	MOVLW	0x00
	ADDWFC	r0x05, W
	MOVWF	r0x0e
	MOVF	r0x06, W
	ADDLW	0x02
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x07, W
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	CALL	__gptrget1
	MOVWF	r0x0f
	MOVLW	0x9f
	ADDWF	r0x0f, F
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, PRODL
	MOVF	r0x0e, W
	CALL	__gptrput1
;	.line	570; /home/mandon/pinguino32/copie courante/linux/source/user.c	to[0] = chaine[3]-'1'; 
	MOVLW	0x03
	ADDWF	r0x06, F
	MOVLW	0x00
	ADDWFC	r0x07, F
	ADDWFC	r0x08, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, PRODL
	MOVF	r0x08, W
	CALL	__gptrget1
	MOVWF	r0x06
	MOVLW	0xcf
	ADDWF	r0x06, F
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	572; /home/mandon/pinguino32/copie courante/linux/source/user.c	return from[0] != to[0] || from[1] != to[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #	MOVF	r0x00, W
; #	XORWF	r0x03, W
	XORWF	r0x00, W
	BNZ	_01468_DS_
	CLRF	r0x00
	INCF	r0x00, F
	BRA	_01469_DS_
_01468_DS_:
	CLRF	r0x00
_01469_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVF	r0x00, W
	BNZ	_01462_DS_
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, PRODL
	MOVF	r0x0b, W
	CALL	__gptrget1
	MOVWF	r0x09
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, PRODL
	MOVF	r0x0e, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #	MOVF	r0x09, W
; #	XORWF	r0x0c, W
	XORWF	r0x09, W
	BNZ	_01470_DS_
	CLRF	r0x09
	INCF	r0x09, F
	BRA	_01471_DS_
_01470_DS_:
	CLRF	r0x09
_01471_DS_:
	MOVF	r0x09, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x09
	RLCF	r0x09, F
	MOVF	r0x09, W
	BNZ	_01462_DS_
	CLRF	r0x00
	BRA	_01463_DS_
_01462_DS_:
	MOVLW	0x01
	MOVWF	r0x00
_01463_DS_:
	MOVF	r0x00, W
_01459_DS_:
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
S_main__draw_chessboard	code
_draw_chessboard:
;	.line	511; /home/mandon/pinguino32/copie courante/linux/source/user.c	void draw_chessboard(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
;	.line	515; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_printf("\r\n%s\r\n", ligne);
	MOVLW	UPPER(_ligne)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_ligne)
	MOVWF	POSTDEC1
	MOVLW	LOW(_ligne)
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_19)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_19)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_19)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	516; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i=7;i>=0;i--)
	MOVLW	0x07
	MOVWF	r0x00
	MOVLW	0x38
	MOVWF	r0x01
_01436_DS_:
	BSF	STATUS, 0
	BTFSS	r0x00, 7
	BCF	STATUS, 0
	BTFSC	STATUS, 0
	BRA	_01439_DS_
;	.line	518; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(' ');
	MOVLW	0x20
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	519; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar('|');
	MOVLW	0x7c
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	520; /home/mandon/pinguino32/copie courante/linux/source/user.c	for(j=0;j<8;j++)
	MOVLW	LOW(_board)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_board)
	ADDWFC	r0x03, F
	CLRF	r0x04
_01432_DS_:
	MOVF	r0x04, W
	ADDLW	0x80
	ADDLW	0x78
	BTFSC	STATUS, 0
	BRA	_01435_DS_
;	.line	522; /home/mandon/pinguino32/copie courante/linux/source/user.c	switch (board[i][j])
	MOVF	r0x04, W
	ADDWF	r0x02, W
	MOVWF	r0x05
	CLRF	WREG
	BTFSC	r0x04, 7
	SETF	WREG
	ADDWFC	r0x03, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVLW	0x0f
	SUBWF	r0x05, W
	BTFSC	STATUS, 0
	BRA	_01431_DS_
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x05, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_01451_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_01451_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_01451_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_01451_DS_:
	GOTO	_01418_DS_
	GOTO	_01420_DS_
	GOTO	_01422_DS_
	GOTO	_01424_DS_
	GOTO	_01426_DS_
	GOTO	_01428_DS_
	GOTO	_01430_DS_
	GOTO	_01431_DS_
	GOTO	_01431_DS_
	GOTO	_01419_DS_
	GOTO	_01421_DS_
	GOTO	_01423_DS_
	GOTO	_01425_DS_
	GOTO	_01427_DS_
	GOTO	_01429_DS_
_01418_DS_:
;	.line	524; /home/mandon/pinguino32/copie courante/linux/source/user.c	case 0 : serial_putchar(' ');break;
	MOVLW	0x20
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01419_DS_:
;	.line	525; /home/mandon/pinguino32/copie courante/linux/source/user.c	case BLACK|PAWN : serial_putchar('p');break;
	MOVLW	0x70
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01420_DS_:
;	.line	526; /home/mandon/pinguino32/copie courante/linux/source/user.c	case WHITE|PAWN : serial_putchar('P');break;
	MOVLW	0x50
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01421_DS_:
;	.line	527; /home/mandon/pinguino32/copie courante/linux/source/user.c	case BLACK|ROOK : serial_putchar('t');break;
	MOVLW	0x74
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01422_DS_:
;	.line	528; /home/mandon/pinguino32/copie courante/linux/source/user.c	case WHITE|ROOK : serial_putchar('T');break;
	MOVLW	0x54
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01423_DS_:
;	.line	529; /home/mandon/pinguino32/copie courante/linux/source/user.c	case BLACK|KNIGHT : serial_putchar('c');break;
	MOVLW	0x63
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01424_DS_:
;	.line	530; /home/mandon/pinguino32/copie courante/linux/source/user.c	case WHITE|KNIGHT : serial_putchar('C');break;
	MOVLW	0x43
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01425_DS_:
;	.line	531; /home/mandon/pinguino32/copie courante/linux/source/user.c	case BLACK|BISHOP : serial_putchar('f');break;
	MOVLW	0x66
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01426_DS_:
;	.line	532; /home/mandon/pinguino32/copie courante/linux/source/user.c	case WHITE|BISHOP : serial_putchar('F');break;
	MOVLW	0x46
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01427_DS_:
;	.line	533; /home/mandon/pinguino32/copie courante/linux/source/user.c	case BLACK|QUEEN : serial_putchar('r');break;
	MOVLW	0x72
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01428_DS_:
;	.line	534; /home/mandon/pinguino32/copie courante/linux/source/user.c	case WHITE|QUEEN : serial_putchar('R');break;
	MOVLW	0x52
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01429_DS_:
;	.line	535; /home/mandon/pinguino32/copie courante/linux/source/user.c	case BLACK|KING : serial_putchar('k');break;
	MOVLW	0x6b
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
	BRA	_01431_DS_
_01430_DS_:
;	.line	536; /home/mandon/pinguino32/copie courante/linux/source/user.c	case WHITE|KING : serial_putchar('K');break;
	MOVLW	0x4b
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
_01431_DS_:
;	.line	538; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar('|');
	MOVLW	0x7c
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	520; /home/mandon/pinguino32/copie courante/linux/source/user.c	for(j=0;j<8;j++)
	INCF	r0x04, F
	BRA	_01432_DS_
_01435_DS_:
;	.line	540; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(' ');
	MOVLW	0x20
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	541; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(i+'1');
	MOVLW	0x31
	ADDWF	r0x00, W
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	542; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_printf("\r\n%s\r\n", ligne);
	MOVLW	UPPER(_ligne)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_ligne)
	MOVWF	POSTDEC1
	MOVLW	LOW(_ligne)
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_19)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_19)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_19)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	516; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i=7;i>=0;i--)
	MOVLW	0xf8
	ADDWF	r0x01, F
	DECF	r0x00, F
	BRA	_01436_DS_
_01439_DS_:
;	.line	544; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("  a b c d e f g h\r\n\r\n");
	MOVLW	UPPER(__str_20)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_20)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_20)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__init_board	code
_init_board:
;	.line	437; /home/mandon/pinguino32/copie courante/linux/source/user.c	void init_board () 
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
; #	MOVLW	0x0a
; #	MOVWF	(_board + 63), B
; #	MOVLW	0x0a
;	.line	441; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[7][0] = board[7][7] = BLACK|ROOK;
	MOVLW	0x0a
	BANKSEL	(_board + 63)
	MOVWF	(_board + 63), B
; removed redundant BANKSEL
	MOVWF	(_board + 56), B
; #	MOVLW	0x0b
; #	MOVWF	(_board + 62), B
; #	MOVLW	0x0b
;	.line	442; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[7][1] = board[7][6] = BLACK|KNIGHT;
	MOVLW	0x0b
; removed redundant BANKSEL
	MOVWF	(_board + 62), B
; removed redundant BANKSEL
	MOVWF	(_board + 57), B
; #	MOVLW	0x0c
; #	MOVWF	(_board + 61), B
; #	MOVLW	0x0c
;	.line	443; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[7][2] = board[7][5] = BLACK|BISHOP;
	MOVLW	0x0c
; removed redundant BANKSEL
	MOVWF	(_board + 61), B
; removed redundant BANKSEL
	MOVWF	(_board + 58), B
;	.line	444; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[7][3] = BLACK|QUEEN;
	MOVLW	0x0d
; removed redundant BANKSEL
	MOVWF	(_board + 59), B
;	.line	445; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[7][4] = BLACK|KING;
	MOVLW	0x0e
; removed redundant BANKSEL
	MOVWF	(_board + 60), B
; #	MOVLW	0x02
; #	MOVWF	(_board + 7), B
; #	MOVLW	0x02
;	.line	447; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[0][0] = board[0][7] = WHITE|ROOK;
	MOVLW	0x02
; removed redundant BANKSEL
	MOVWF	(_board + 7), B
; removed redundant BANKSEL
	MOVWF	_board, B
; #	MOVLW	0x03
; #	MOVWF	(_board + 6), B
; #	MOVLW	0x03
;	.line	448; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[0][1] = board[0][6] = WHITE|KNIGHT;
	MOVLW	0x03
; removed redundant BANKSEL
	MOVWF	(_board + 6), B
; removed redundant BANKSEL
	MOVWF	(_board + 1), B
; #	MOVLW	0x04
; #	MOVWF	(_board + 5), B
; #	MOVLW	0x04
;	.line	449; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[0][2] = board[0][5] = WHITE|BISHOP;
	MOVLW	0x04
; removed redundant BANKSEL
	MOVWF	(_board + 5), B
; removed redundant BANKSEL
	MOVWF	(_board + 2), B
;	.line	450; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[0][3] = WHITE|QUEEN;
	MOVLW	0x05
; removed redundant BANKSEL
	MOVWF	(_board + 3), B
;	.line	451; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[0][4] = WHITE|KING;
	MOVLW	0x06
; removed redundant BANKSEL
	MOVWF	(_board + 4), B
;	.line	453; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i=2; i<6; ++i)
	MOVLW	0x02
	MOVWF	r0x00
	MOVLW	0x10
	MOVWF	r0x01
_01392_DS_:
	MOVLW	0x06
	SUBWF	r0x00, W
	BC	_01395_DS_
;	.line	454; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (j=0; j<8; ++j)
	MOVLW	LOW(_board)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_board)
	ADDWFC	r0x03, F
	CLRF	r0x04
_01388_DS_:
	MOVLW	0x08
	SUBWF	r0x04, W
	BC	_01394_DS_
;	.line	455; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[i][j] = 0;
	MOVF	r0x04, W
	ADDWF	r0x02, W
	MOVWF	r0x05
	CLRF	WREG
	ADDWFC	r0x03, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	CLRF	INDF0
;	.line	454; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (j=0; j<8; ++j)
	INCF	r0x04, F
	BRA	_01388_DS_
_01394_DS_:
;	.line	453; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i=2; i<6; ++i)
	MOVLW	0x08
	ADDWF	r0x01, F
	INCF	r0x00, F
	BRA	_01392_DS_
_01395_DS_:
;	.line	457; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i=0; i<8; ++i)
	CLRF	r0x00
_01396_DS_:
	MOVLW	0x08
	SUBWF	r0x00, W
	BC	_01399_DS_
;	.line	459; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[6][i] = BLACK|PAWN;
	MOVLW	LOW(_board + 48)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_board + 48)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x09
	MOVWF	INDF0
;	.line	460; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[1][i] = WHITE|PAWN;
	MOVLW	LOW(_board + 8)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_board + 8)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x01
	MOVWF	INDF0
;	.line	457; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i=0; i<8; ++i)
	INCF	r0x00, F
	BRA	_01396_DS_
_01399_DS_:
	BANKSEL	_wh_king_pos
;	.line	464; /home/mandon/pinguino32/copie courante/linux/source/user.c	wh_king_pos[0] = 0;
	CLRF	_wh_king_pos, B
;	.line	465; /home/mandon/pinguino32/copie courante/linux/source/user.c	wh_king_pos[1] = 4;
	MOVLW	0x04
; removed redundant BANKSEL
	MOVWF	(_wh_king_pos + 1), B
;	.line	466; /home/mandon/pinguino32/copie courante/linux/source/user.c	bl_king_pos[0] = 7;
	MOVLW	0x07
	BANKSEL	_bl_king_pos
	MOVWF	_bl_king_pos, B
;	.line	467; /home/mandon/pinguino32/copie courante/linux/source/user.c	bl_king_pos[1] = 4;  
	MOVLW	0x04
; removed redundant BANKSEL
	MOVWF	(_bl_king_pos + 1), B
; #	MOVLW	0xff
; #	MOVWF	_bl_base_cont, B
; #	MOVLW	0xff
;	.line	470; /home/mandon/pinguino32/copie courante/linux/source/user.c	wh_base_cont = bl_base_cont = 0xFF;
	MOVLW	0xff
	BANKSEL	_bl_base_cont
	SETF	_bl_base_cont, B
	BANKSEL	_wh_base_cont
	SETF	_wh_base_cont, B
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__updatekingpos	code
_updatekingpos:
;	.line	423; /home/mandon/pinguino32/copie courante/linux/source/user.c	void updatekingpos(LOC to, BOOL piececolour)
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
;	.line	425; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (!piececolour)
	MOVF	r0x03, W
	BNZ	_01381_DS_
;	.line	427; /home/mandon/pinguino32/copie courante/linux/source/user.c	wh_king_pos[0] = to[0];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	BANKSEL	_wh_king_pos
	MOVWF	_wh_king_pos, B
;	.line	428; /home/mandon/pinguino32/copie courante/linux/source/user.c	wh_king_pos[1] = to[1];
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	BANKSEL	(_wh_king_pos + 1)
	MOVWF	(_wh_king_pos + 1), B
	BRA	_01383_DS_
_01381_DS_:
;	.line	432; /home/mandon/pinguino32/copie courante/linux/source/user.c	bl_king_pos[0] = to[0];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	BANKSEL	_bl_king_pos
	MOVWF	_bl_king_pos, B
;	.line	433; /home/mandon/pinguino32/copie courante/linux/source/user.c	bl_king_pos[1] = to[1];
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	BANKSEL	(_bl_king_pos + 1)
	MOVWF	(_bl_king_pos + 1), B
_01383_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__draw_move	code
_draw_move:
;	.line	372; /home/mandon/pinguino32/copie courante/linux/source/user.c	void draw_move (LOC from, LOC to,PIECE p)
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
;	.line	375; /home/mandon/pinguino32/copie courante/linux/source/user.c	basemask = (p & 0x08) ? &bl_base_cont : &wh_base_cont;
	ANDWF	r0x06, W
	MOVWF	r0x07
	MOVF	r0x07, W
	BZ	_01332_DS_
	MOVLW	LOW(_bl_base_cont)
	MOVWF	r0x08
	MOVLW	HIGH(_bl_base_cont)
	MOVWF	r0x09
	BRA	_01333_DS_
_01332_DS_:
	MOVLW	LOW(_wh_base_cont)
	MOVWF	r0x08
	MOVLW	HIGH(_wh_base_cont)
	MOVWF	r0x09
_01333_DS_:
	MOVF	r0x09, W
	MOVWF	r0x09
; #	MOVF	r0x08, W
; #	MOVWF	r0x08
	MOVLW	0x80
	MOVWF	r0x0a
;	.line	376; /home/mandon/pinguino32/copie courante/linux/source/user.c	baserow = (p & 0x08) ? 7 : 0;
	MOVF	r0x07, W
	BZ	_01334_DS_
	MOVLW	0x07
	MOVWF	r0x0b
	BRA	_01335_DS_
_01334_DS_:
	CLRF	r0x0b
_01335_DS_:
;	.line	379; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (piecetype(p) == KING) 
	MOVLW	0x07
	ANDWF	r0x06, W
; #	MOVWF	r0x0c
; #	MOVF	r0x0c, W
	XORLW	0x06
	BZ	_01350_DS_
	BRA	_01325_DS_
_01350_DS_:
;	.line	381; /home/mandon/pinguino32/copie courante/linux/source/user.c	updatekingpos(to,(p&0x08));
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_updatekingpos
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	382; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[from[0]][from[1]] = EMPTY;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #;;multiply lit val:0x08 by variable r0x0c and store in r0x0c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0c, W
	MULLW	0x08
	MOVFF	PRODL, r0x0c
	CLRF	r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0c, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0d, F
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x0e
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x0e
; #	MOVF	r0x0e, W
	MOVWF	r0x0e
	ADDWF	r0x0c, F
	CLRF	WREG
	ADDWFC	r0x0d, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	CLRF	INDF0
;	.line	383; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][to[1]] = p;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #;;multiply lit val:0x08 by variable r0x0c and store in r0x0c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0c, W
	MULLW	0x08
	MOVFF	PRODL, r0x0c
	CLRF	r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0c, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0d, F
	MOVF	r0x03, W
	ADDLW	0x01
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x04, W
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x05, W
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x0f
; #	MOVF	r0x0f, W
	MOVWF	r0x0f
	ADDWF	r0x0c, F
	CLRF	WREG
	ADDWFC	r0x0d, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	MOVFF	r0x06, INDF0
;	.line	385; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (((to[1] - from[1]) != 1) && ((from[1] - to[1]) != 1))
	MOVFF	r0x0f, r0x0c
	CLRF	r0x0d
	CLRF	r0x0f
	MOVF	r0x0e, W
	SUBWF	r0x0c, W
	MOVWF	r0x10
	MOVF	r0x0f, W
	SUBWFB	r0x0d, W
	MOVWF	r0x11
	MOVF	r0x10, W
	XORLW	0x01
	BNZ	_01352_DS_
	MOVF	r0x11, W
	BNZ	_01352_DS_
	BRA	_01326_DS_
_01352_DS_:
	MOVF	r0x0c, W
	SUBWF	r0x0e, W
	MOVWF	r0x0c
	MOVF	r0x0d, W
	SUBWFB	r0x0f, W
	MOVWF	r0x0d
	MOVF	r0x0c, W
	XORLW	0x01
	BNZ	_01354_DS_
	MOVF	r0x0d, W
	BNZ	_01354_DS_
	BRA	_01326_DS_
_01354_DS_:
;	.line	387; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (((*basemask) & 0x1F)== 0x11)
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrget1
	MOVWF	r0x0c
	MOVLW	0x1f
	ANDWF	r0x0c, W
; #	MOVWF	r0x0d
; #	MOVF	r0x0d, W
	XORLW	0x11
	BNZ	_01313_DS_
;	.line	390; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][0] = EMPTY;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x0d
; #;;multiply lit val:0x08 by variable r0x0d and store in r0x0d
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0d, W
	MULLW	0x08
	MOVFF	PRODL, r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0d, W
	MOVWF	r0x0e
	CLRF	r0x0f
	MOVLW	HIGH(_board)
	ADDWFC	r0x0f, F
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, FSR0H
	CLRF	INDF0
;	.line	391; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][3] = ((p&0x08)|ROOK);
	CLRF	r0x0e
	MOVLW	LOW(_board)
	ADDWF	r0x0d, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0e, F
	MOVLW	0x03
	ADDWF	r0x0d, F
	BTFSC	STATUS, 0
	INCF	r0x0e, F
	MOVLW	0x02
	IORWF	r0x07, W
	MOVWF	r0x0f
	MOVFF	r0x0d, FSR0L
	MOVFF	r0x0e, FSR0H
	MOVFF	r0x0f, INDF0
;	.line	392; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_printf("Queenside Castle\n");
	MOVLW	UPPER(__str_17)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_17)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_17)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_01326_DS_
_01313_DS_:
;	.line	394; /home/mandon/pinguino32/copie courante/linux/source/user.c	else if (((*basemask) & 0xF0) == 0x90)
	MOVLW	0xf0
	ANDWF	r0x0c, F
	MOVF	r0x0c, W
	XORLW	0x90
	BZ	_01361_DS_
	BRA	_01326_DS_
_01361_DS_:
;	.line	397; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][7] = EMPTY;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #;;multiply lit val:0x08 by variable r0x0c and store in r0x0c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0c, W
	MULLW	0x08
	MOVFF	PRODL, r0x0c
	CLRF	r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0c, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0d, F
	MOVF	r0x0c, W
	ADDLW	0x07
	MOVWF	r0x0e
	MOVLW	0x00
	ADDWFC	r0x0d, W
	MOVWF	r0x0f
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, FSR0H
	CLRF	INDF0
;	.line	398; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][5] = ((p&0x08)|ROOK);
	MOVLW	0x05
	ADDWF	r0x0c, F
	BTFSC	STATUS, 0
	INCF	r0x0d, F
	MOVLW	0x02
	IORWF	r0x07, W
	MOVWF	r0x0e
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	MOVFF	r0x0e, INDF0
;	.line	399; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_printf("Kingside Castle\n");
	MOVLW	UPPER(__str_18)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_18)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_18)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_01326_DS_
_01325_DS_:
;	.line	404; /home/mandon/pinguino32/copie courante/linux/source/user.c	else if (((p == 0x09) && (to[0] == 0)) || ((p == 1) && (to[0] == 7)))
	MOVF	r0x06, W
	XORLW	0x09
	BNZ	_01323_DS_
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0c
	MOVF	r0x0c, W
	BZ	_01318_DS_
_01323_DS_:
	MOVF	r0x06, W
	XORLW	0x01
	BZ	_01366_DS_
	BRA	_01319_DS_
_01366_DS_:
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #	MOVF	r0x0c, W
	XORLW	0x07
	BZ	_01318_DS_
	BRA	_01319_DS_
_01318_DS_:
;	.line	406; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[from[0]][from[1]] = EMPTY;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #;;multiply lit val:0x08 by variable r0x0c and store in r0x0c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0c, W
	MULLW	0x08
	MOVFF	PRODL, r0x0c
	CLRF	r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0c, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0d, F
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x0e
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x0e
; #	MOVF	r0x0e, W
	ADDWF	r0x0c, F
	CLRF	WREG
	ADDWFC	r0x0d, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	CLRF	INDF0
;	.line	407; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][to[1]] = QUEEN |(p&0x08);
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x0c
; #;;multiply lit val:0x08 by variable r0x0c and store in r0x0c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0c, W
	MULLW	0x08
	MOVFF	PRODL, r0x0c
	CLRF	r0x0d
	MOVLW	LOW(_board)
	ADDWF	r0x0c, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0d, F
	MOVF	r0x03, W
	ADDLW	0x01
	MOVWF	r0x0e
	MOVLW	0x00
	ADDWFC	r0x04, W
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x05, W
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x0e
; #	MOVF	r0x0e, W
	ADDWF	r0x0c, F
	CLRF	WREG
	ADDWFC	r0x0d, F
	MOVLW	0x05
	IORWF	r0x07, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	MOVFF	r0x07, INDF0
	BRA	_01326_DS_
_01319_DS_:
;	.line	412; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (board[to[0]][to[1]] != EMPTY);
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x07
; #;;multiply lit val:0x08 by variable r0x07 and store in r0x07
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x07, W
	MULLW	0x08
	MOVFF	PRODL, r0x07
	CLRF	r0x0c
	MOVLW	LOW(_board)
	ADDWF	r0x07, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0c, F
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	ADDWF	r0x07, F
	CLRF	WREG
	ADDWFC	r0x0c, F
;	.line	413; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[from[0]][from[1]] = EMPTY;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #;;multiply lit val:0x08 by variable r0x03 and store in r0x03
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x03, W
	MULLW	0x08
	MOVFF	PRODL, r0x03
	CLRF	r0x04
	MOVLW	LOW(_board)
	ADDWF	r0x03, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x04, F
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x0d
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVFF	r0x05, FSR0L
	MOVFF	r0x0d, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x05
; #	MOVF	r0x05, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	CLRF	INDF0
;	.line	414; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][to[1]] = p;
	MOVFF	r0x07, FSR0L
	MOVFF	r0x0c, FSR0H
	MOVFF	r0x06, INDF0
_01326_DS_:
;	.line	418; /home/mandon/pinguino32/copie courante/linux/source/user.c	if ((from[0] == baserow) && ((*basemask) & (1 << from[1])))
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	XORWF	r0x0b, W
	BZ	_01371_DS_
	BRA	_01330_DS_
_01371_DS_:
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrget1
	MOVWF	r0x03
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVLW	0x01
	MOVWF	r0x01
	CLRF	r0x02
	MOVF	r0x00, W
	BZ	_01372_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01373_DS_:
	RLCF	r0x01, F
	RLCF	r0x02, F
	ADDLW	0x01
	BNC	_01373_DS_
_01372_DS_:
	MOVFF	r0x03, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	ANDWF	r0x01, F
	MOVF	r0x05, W
	ANDWF	r0x02, F
	MOVF	r0x01, W
	IORWF	r0x02, W
	BZ	_01330_DS_
;	.line	419; /home/mandon/pinguino32/copie courante/linux/source/user.c	(*basemask) &= ~(1 << from[1]);
	MOVLW	0x01
	MOVWF	r0x01
	MOVF	r0x00, W
	BZ	_01374_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01375_DS_:
	RLCF	r0x01, F
	ADDLW	0x01
	BNC	_01375_DS_
_01374_DS_:
	COMF	r0x01, W
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	ANDWF	r0x03, F
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrput1
_01330_DS_:
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
S_main__rate_move	code
_rate_move:
;	.line	341; /home/mandon/pinguino32/copie courante/linux/source/user.c	int rate_move(PIECE piece, LOC to,unsigned char posrate)
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
;	.line	346; /home/mandon/pinguino32/copie courante/linux/source/user.c	value = ((piece & 0x07)== KING) ? 0 : (piece&0x07);    
	MOVLW	0x07
	ANDWF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x06
	BNZ	_01290_DS_
	CLRF	r0x05
	BRA	_01291_DS_
_01290_DS_:
	MOVFF	r0x00, r0x05
_01291_DS_:
	MOVFF	r0x05, r0x00
;	.line	348; /home/mandon/pinguino32/copie courante/linux/source/user.c	switch (movetype)
	MOVLW	0x01
	BANKSEL	_movetype
	SUBWF	_movetype, W, B
	BTFSS	STATUS, 0
	BRA	_01286_DS_
	MOVLW	0x05
; removed redundant BANKSEL
	SUBWF	_movetype, W, B
	BTFSC	STATUS, 0
	BRA	_01286_DS_
; removed redundant BANKSEL
	DECF	_movetype, W, B
	MOVWF	r0x05
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	CLRF	r0x08
	RLCF	r0x05, W
	RLCF	r0x08, F
	RLCF	WREG, W
	RLCF	r0x08, F
	ANDLW	0xfc
	MOVWF	r0x07
	MOVLW	UPPER(_01303_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_01303_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_01303_DS_)
	ADDWF	r0x07, F
	MOVF	r0x08, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x07, W
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVWF	PCL
_01303_DS_:
	GOTO	_01282_DS_
	GOTO	_01283_DS_
	GOTO	_01285_DS_
	GOTO	_01284_DS_
_01282_DS_:
;	.line	351; /home/mandon/pinguino32/copie courante/linux/source/user.c	rating = (6-value) + posrate/2;  
	MOVF	r0x00, W
	SUBLW	0x06
	MOVWF	r0x05
	RRNCF	r0x04, W
	ANDLW	0x7f
; #	MOVWF	r0x06
; #	MOVF	r0x06, W
	ADDWF	r0x05, F
;	.line	352; /home/mandon/pinguino32/copie courante/linux/source/user.c	break;
	BRA	_01287_DS_
_01283_DS_:
;	.line	354; /home/mandon/pinguino32/copie courante/linux/source/user.c	rating = (value)+((8-posrate));      
	MOVF	r0x04, W
	SUBLW	0x08
; #	MOVWF	r0x04
; #	MOVF	r0x04, W
	ADDWF	r0x00, W
	MOVWF	r0x05
;	.line	355; /home/mandon/pinguino32/copie courante/linux/source/user.c	break;
	BRA	_01287_DS_
_01284_DS_:
;	.line	357; /home/mandon/pinguino32/copie courante/linux/source/user.c	rating = 14;                            
	MOVLW	0x0e
	MOVWF	r0x05
;	.line	358; /home/mandon/pinguino32/copie courante/linux/source/user.c	break;
	BRA	_01287_DS_
_01285_DS_:
;	.line	361; /home/mandon/pinguino32/copie courante/linux/source/user.c	tmp = (board[to[0]][to[1]]&0x07)-(value);
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, PRODL
	MOVF	r0x03, W
	CALL	__gptrget1
; #	MOVWF	r0x04
; #;;multiply lit val:0x08 by variable r0x04 and store in r0x04
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x04, W
	MULLW	0x08
	MOVFF	PRODL, r0x04
	CLRF	r0x06
	MOVLW	LOW(_board)
	ADDWF	r0x04, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x06, F
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, PRODL
	MOVF	r0x03, W
	CALL	__gptrget1
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
	ADDWF	r0x04, F
	CLRF	WREG
	ADDWFC	r0x06, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x04
	MOVLW	0x07
	ANDWF	r0x04, F
	MOVF	r0x00, W
	SUBWF	r0x04, W
	MOVWF	r0x00
;	.line	362; /home/mandon/pinguino32/copie courante/linux/source/user.c	rating = (tmp < 249) ? 12 : 4;
	MOVLW	0xf9
	SUBWF	r0x00, W
	BC	_01292_DS_
	MOVLW	0x0c
	MOVWF	r0x00
	BRA	_01293_DS_
_01292_DS_:
	MOVLW	0x04
	MOVWF	r0x00
_01293_DS_:
	MOVFF	r0x00, r0x05
;	.line	363; /home/mandon/pinguino32/copie courante/linux/source/user.c	break; 
	BRA	_01287_DS_
_01286_DS_:
;	.line	365; /home/mandon/pinguino32/copie courante/linux/source/user.c	rating = 0;
	CLRF	r0x05
; =DF= MOVFF: replaced by CRLF/SETF
_01287_DS_:
;	.line	368; /home/mandon/pinguino32/copie courante/linux/source/user.c	return rating;
	CLRF	PRODL
	MOVF	r0x05, W
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
S_main__test_singlemove	code
_test_singlemove:
;	.line	289; /home/mandon/pinguino32/copie courante/linux/source/user.c	BOOL test_singlemove(LOC from,LOC to,PIECE p)
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
	MOVFF	r0x1b, POSTDEC1
	MOVFF	r0x1c, POSTDEC1
	MOVFF	r0x1d, POSTDEC1
	MOVFF	r0x1e, POSTDEC1
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
;	.line	296; /home/mandon/pinguino32/copie courante/linux/source/user.c	if ((p & 0x07) == KING) updatekingpos(to,(p & 0x08));
	MOVLW	0x07
	ANDWF	r0x06, W
; #	MOVWF	r0x07
; #	MOVF	r0x07, W
	XORLW	0x06
	BNZ	_01268_DS_
	CLRF	r0x07
	INCF	r0x07, F
	BRA	_01269_DS_
_01268_DS_:
	CLRF	r0x07
_01269_DS_:
	MOVF	r0x07, W
	BZ	_01237_DS_
	MOVLW	0x08
	ANDWF	r0x06, W
; #	MOVWF	r0x08
; #	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_updatekingpos
	MOVLW	0x04
	ADDWF	FSR1L, F
_01237_DS_:
;	.line	299; /home/mandon/pinguino32/copie courante/linux/source/user.c	tmpdest = board[to[0]][to[1]];
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x08
; #;;multiply lit val:0x08 by variable r0x08 and store in r0x08
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x08, W
	MULLW	0x08
	MOVFF	PRODL, r0x08
	CLRF	r0x09
	MOVLW	LOW(_board)
	ADDWF	r0x08, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x09, F
	MOVF	r0x03, W
	ADDLW	0x01
	MOVWF	r0x0a
	MOVLW	0x00
	ADDWFC	r0x04, W
	MOVWF	r0x0b
	MOVLW	0x00
	ADDWFC	r0x05, W
	MOVWF	r0x0c
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x0d
; #	MOVF	r0x0d, W
	ADDWF	r0x08, F
	CLRF	WREG
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0d
;	.line	302; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[from[0]][from[1]] = EMPTY;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x0e
; #;;multiply lit val:0x08 by variable r0x0e and store in r0x0e
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x0e, W
	MULLW	0x08
	MOVFF	PRODL, r0x0e
	CLRF	r0x0f
	MOVLW	LOW(_board)
	ADDWF	r0x0e, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0f, F
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x11
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x12
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x13
; #	MOVF	r0x13, W
	ADDWF	r0x0e, F
	CLRF	WREG
	ADDWFC	r0x0f, F
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, FSR0H
	CLRF	INDF0
;	.line	303; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][to[1]] = p;
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x06, INDF0
	BANKSEL	_kingcapture
;	.line	306; /home/mandon/pinguino32/copie courante/linux/source/user.c	kingcapture = FALSE;
	CLRF	_kingcapture, B
;	.line	307; /home/mandon/pinguino32/copie courante/linux/source/user.c	i = j = 0;
	CLRF	r0x08
	CLRF	r0x09
;	.line	309; /home/mandon/pinguino32/copie courante/linux/source/user.c	while ((i < 8) && (!kingcapture))
	MOVLW	0x08
	ANDWF	r0x06, W
	MOVWF	r0x0e
	SWAPF	r0x0e, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x0f
	CLRF	r0x13
	CLRF	r0x14
	CLRF	r0x15
	CLRF	r0x16
_01246_DS_:
	MOVF	r0x14, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01272_DS_
	MOVLW	0x08
	SUBWF	r0x13, W
_01272_DS_:
	BTFSC	STATUS, 0
	BRA	_01248_DS_
	BANKSEL	_kingcapture
	MOVF	_kingcapture, W, B
	BTFSS	STATUS, 2
	BRA	_01248_DS_
;	.line	312; /home/mandon/pinguino32/copie courante/linux/source/user.c	while ((j < 8) && (!kingcapture))
	MOVLW	LOW(_board)
	ADDWF	r0x15, W
	MOVWF	r0x17
	MOVLW	HIGH(_board)
	ADDWFC	r0x16, W
	MOVWF	r0x18
	MOVFF	r0x08, r0x19
	MOVFF	r0x09, r0x1a
_01242_DS_:
	MOVF	r0x1a, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01273_DS_
	MOVLW	0x08
	SUBWF	r0x19, W
_01273_DS_:
	BTFSC	STATUS, 0
	BRA	_01244_DS_
	BANKSEL	_kingcapture
	MOVF	_kingcapture, W, B
	BTFSS	STATUS, 2
	BRA	_01244_DS_
;	.line	315; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (is_opp_piece(i,j,(p&0x08)))
	MOVF	r0x19, W
	ADDWF	r0x17, W
	MOVWF	r0x1b
	MOVF	r0x1a, W
	ADDWFC	r0x18, W
	MOVWF	r0x1c
	MOVFF	r0x1b, FSR0L
	MOVFF	r0x1c, FSR0H
	MOVFF	INDF0, r0x1b
	MOVLW	0x08
	ANDWF	r0x1b, W
	MOVWF	r0x1c
	SWAPF	r0x1c, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x1c
	MOVF	r0x0f, W
	XORWF	r0x1c, F
	MOVF	r0x1c, W
	BZ	_01239_DS_
	MOVF	r0x1b, W
	BZ	_01239_DS_
; #	MOVF	r0x13, W
; #	MOVWF	r0x1c
; #	MOVF	r0x1c, W
;	.line	317; /home/mandon/pinguino32/copie courante/linux/source/user.c	opp_pos[0] = i, opp_pos[1] = j,opp_piece = board[i][j];
	MOVF	r0x13, W
	BANKSEL	_test_singlemove_opp_pos_1_1
	MOVWF	_test_singlemove_opp_pos_1_1, B
; #	MOVF	r0x19, W
; #	MOVWF	r0x1c
; #	MOVF	r0x1c, W
	MOVF	r0x19, W
; removed redundant BANKSEL
	MOVWF	(_test_singlemove_opp_pos_1_1 + 1), B
;	.line	318; /home/mandon/pinguino32/copie courante/linux/source/user.c	validate[piecetype(opp_piece)] (opp_pos,(opp_piece & 0x08));
	MOVLW	0x07
	ANDWF	r0x1b, W
; #	MOVWF	r0x1c
; #;;multiply lit val:0x03 by variable r0x1c and store in r0x1c
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x1c, W
	MULLW	0x03
	MOVFF	PRODL, r0x1c
	CLRF	r0x1d
	MOVLW	LOW(_validate)
	ADDWF	r0x1c, F
	MOVLW	HIGH(_validate)
	ADDWFC	r0x1d, F
	MOVFF	r0x1c, FSR0L
	MOVFF	r0x1d, FSR0H
	MOVFF	POSTINC0, r0x1c
	MOVFF	POSTINC0, r0x1d
	MOVFF	INDF0, r0x1e
	MOVLW	0x08
	ANDWF	r0x1b, F
	MOVF	r0x1b, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_test_singlemove_opp_pos_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_test_singlemove_opp_pos_1_1)
	MOVWF	POSTDEC1
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_01277_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_01277_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_01277_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x1e, PCLATU
	MOVFF	r0x1d, PCLATH
	MOVF	r0x1c, W
	MOVWF	PCL
_01277_DS_:
	MOVLW	0x04
	ADDWF	FSR1L, F
_01239_DS_:
;	.line	320; /home/mandon/pinguino32/copie courante/linux/source/user.c	j++;
	INCF	r0x19, F
	BTFSC	STATUS, 0
	INCF	r0x1a, F
	BRA	_01242_DS_
_01244_DS_:
;	.line	322; /home/mandon/pinguino32/copie courante/linux/source/user.c	j = 0;
	CLRF	r0x08
	CLRF	r0x09
;	.line	323; /home/mandon/pinguino32/copie courante/linux/source/user.c	i++;
	MOVLW	0x08
	ADDWF	r0x15, F
	BTFSC	STATUS, 0
	INCF	r0x16, F
	INCF	r0x13, F
	BTFSC	STATUS, 0
	INCF	r0x14, F
	BRA	_01246_DS_
_01248_DS_:
;	.line	326; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[to[0]][to[1]] = tmpdest;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #;;multiply lit val:0x08 by variable r0x03 and store in r0x03
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x03, W
	MULLW	0x08
	MOVFF	PRODL, r0x03
	CLRF	r0x04
	MOVLW	LOW(_board)
	ADDWF	r0x03, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x04, F
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, PRODL
	MOVF	r0x0c, W
	CALL	__gptrget1
; #	MOVWF	r0x0a
; #	MOVF	r0x0a, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	r0x0d, INDF0
;	.line	327; /home/mandon/pinguino32/copie courante/linux/source/user.c	board[from[0]][from[1]] = p;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x03
; #;;multiply lit val:0x08 by variable r0x03 and store in r0x03
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x03, W
	MULLW	0x08
	MOVFF	PRODL, r0x03
	CLRF	r0x04
	MOVLW	LOW(_board)
	ADDWF	r0x03, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x04, F
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget1
; #	MOVWF	r0x10
; #	MOVF	r0x10, W
	ADDWF	r0x03, F
	CLRF	WREG
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	r0x06, INDF0
;	.line	328; /home/mandon/pinguino32/copie courante/linux/source/user.c	if ((p & 0x07) == KING)
	MOVF	r0x07, W
	BZ	_01250_DS_
;	.line	329; /home/mandon/pinguino32/copie courante/linux/source/user.c	updatekingpos(from,(p & 0x08));
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_updatekingpos
	MOVLW	0x04
	ADDWF	FSR1L, F
_01250_DS_:
	BANKSEL	_kingcapture
;	.line	331; /home/mandon/pinguino32/copie courante/linux/source/user.c	return (kingcapture) ? FALSE : TRUE;
	MOVF	_kingcapture, W, B
	BZ	_01253_DS_
	CLRF	r0x00
	BRA	_01254_DS_
_01253_DS_:
	MOVLW	0x01
	MOVWF	r0x00
_01254_DS_:
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x1e
	MOVFF	PREINC1, r0x1d
	MOVFF	PREINC1, r0x1c
	MOVFF	PREINC1, r0x1b
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
S_main__getbestpiecemove	code
_getbestpiecemove:
;	.line	186; /home/mandon/pinguino32/copie courante/linux/source/user.c	int getbestpiecemove(LOC from)
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
;	.line	193; /home/mandon/pinguino32/copie courante/linux/source/user.c	bestmove = NO_MOVE;
	SETF	r0x03
;	.line	194; /home/mandon/pinguino32/copie courante/linux/source/user.c	piecerate = tmp = 0;
	CLRF	r0x04
	BANKSEL	_piecerate
	CLRF	_piecerate, B
;	.line	201; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8;++i)
	CLRF	r0x05
_01164_DS_:
	MOVLW	0x08
	SUBWF	r0x05, W
	BTFSC	STATUS, 0
	BRA	_01167_DS_
;	.line	203; /home/mandon/pinguino32/copie courante/linux/source/user.c	currmovemask[i]    = validmovemask[i];
	MOVLW	LOW(_currmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_currmovemask)
	ADDWFC	r0x07, F
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0a
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x0a, INDF0
;	.line	204; /home/mandon/pinguino32/copie courante/linux/source/user.c	currcapturemask[i] = capturemask[i];
	MOVLW	LOW(_currcapturemask)
	ADDWF	r0x05, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_currcapturemask)
	ADDWFC	r0x07, F
	MOVLW	LOW(_capturemask)
	ADDWF	r0x05, W
	MOVWF	r0x0a
	CLRF	r0x0b
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x0b, F
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, FSR0H
	MOVFF	INDF0, r0x0c
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x0c, INDF0
;	.line	205; /home/mandon/pinguino32/copie courante/linux/source/user.c	validmovemask[i] = 0;
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	CLRF	INDF0
;	.line	206; /home/mandon/pinguino32/copie courante/linux/source/user.c	capturemask[i] = 0;
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, FSR0H
	CLRF	INDF0
;	.line	201; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8;++i)
	INCF	r0x05, F
	BRA	_01164_DS_
_01167_DS_:
;	.line	209; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8; ++i)
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x06
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x07
	CLRF	r0x08
_01176_DS_:
	MOVLW	0x08
	SUBWF	r0x08, W
	BTFSC	STATUS, 0
	BRA	_01179_DS_
;	.line	211; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (j = 0; j < 8; ++j)
	MOVLW	LOW(_currcapturemask)
	ADDWF	r0x08, W
	MOVWF	r0x09
	CLRF	r0x0a
	MOVLW	HIGH(_currcapturemask)
	ADDWFC	r0x0a, F
	MOVLW	LOW(_capturemask)
	ADDWF	r0x08, W
	MOVWF	r0x0b
	CLRF	r0x0c
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x0c, F
	MOVLW	LOW(_currcapturemask)
	ADDWF	r0x08, W
	MOVWF	r0x0d
	CLRF	r0x0e
	MOVLW	HIGH(_currcapturemask)
	ADDWFC	r0x0e, F
	MOVLW	LOW(_capturemask)
	ADDWF	r0x08, W
	MOVWF	r0x0f
	CLRF	r0x10
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x10, F
	MOVLW	LOW(_currmovemask)
	ADDWF	r0x08, W
	MOVWF	r0x11
	CLRF	r0x12
	MOVLW	HIGH(_currmovemask)
	ADDWFC	r0x12, F
	CLRF	r0x13
_01172_DS_:
	MOVLW	0x08
	SUBWF	r0x13, W
	BTFSC	STATUS, 0
	BRA	_01178_DS_
;	.line	214; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (currmovemask[i] & 0x01)
	MOVFF	r0x11, FSR0L
	MOVFF	r0x12, FSR0H
	MOVFF	INDF0, r0x14
	BTFSS	r0x14, 0
	BRA	_01163_DS_
;	.line	216; /home/mandon/pinguino32/copie courante/linux/source/user.c	to[0] = i;
	MOVF	r0x08, W
	BANKSEL	_getbestpiecemove_to_1_1
	MOVWF	_getbestpiecemove_to_1_1, B
;	.line	217; /home/mandon/pinguino32/copie courante/linux/source/user.c	to[1] = j; 
	MOVF	r0x13, W
; removed redundant BANKSEL
	MOVWF	(_getbestpiecemove_to_1_1 + 1), B
;	.line	221; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (test_singlemove(from,to,board[from[0]][from[1]]))
	MOVLW	HIGH(_getbestpiecemove_to_1_1)
	MOVWF	r0x15
	MOVLW	LOW(_getbestpiecemove_to_1_1)
	MOVWF	r0x14
	MOVLW	0x80
	MOVWF	r0x16
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x17
; #;;multiply lit val:0x08 by variable r0x17 and store in r0x17
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x17, W
	MULLW	0x08
	MOVFF	PRODL, r0x17
	CLRF	r0x18
	MOVLW	LOW(_board)
	ADDWF	r0x17, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x18, F
	MOVF	r0x00, W
	ADDLW	0x01
	MOVWF	r0x19
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x1a
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVFF	r0x19, FSR0L
	MOVFF	r0x1a, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x19
; #	MOVF	r0x19, W
	ADDWF	r0x17, F
	CLRF	WREG
	ADDWFC	r0x18, F
	MOVFF	r0x17, FSR0L
	MOVFF	r0x18, FSR0H
	MOVFF	INDF0, r0x17
	MOVF	r0x17, W
	MOVWF	POSTDEC1
	MOVF	r0x16, W
	MOVWF	POSTDEC1
	MOVF	r0x15, W
	MOVWF	POSTDEC1
	MOVF	r0x14, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_test_singlemove
	MOVWF	r0x14
	MOVLW	0x07
	ADDWF	FSR1L, F
	MOVF	r0x14, W
	BTFSC	STATUS, 2
	BRA	_01201_DS_
; ;multiply lit val:0x08 by variable _getbestpiecemove_to_1_1 and store in r0x14
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_getbestpiecemove_to_1_1
;	.line	223; /home/mandon/pinguino32/copie courante/linux/source/user.c	move = getindex(to[0],to[1]);
	MOVF	_getbestpiecemove_to_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x14
; removed redundant BANKSEL
	MOVF	(_getbestpiecemove_to_1_1 + 1), W, B
	ADDWF	r0x14, F
;	.line	224; /home/mandon/pinguino32/copie courante/linux/source/user.c	movetype = NORMAL;  
	MOVLW	0x01
	BANKSEL	_movetype
	MOVWF	_movetype, B
;	.line	226; /home/mandon/pinguino32/copie courante/linux/source/user.c	if ((validmovemask[from[0]] >> from[1]) & 1)            
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x15
	CLRF	r0x16
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x15, F
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x16, F
	MOVFF	r0x15, FSR0L
	MOVFF	r0x16, FSR0H
	MOVFF	INDF0, r0x15
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrget1
	MOVWF	r0x16
	MOVF	r0x16, W
	BZ	_01212_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01213_DS_:
	RRCF	r0x15, F
	ADDLW	0x01
	BNC	_01213_DS_
_01212_DS_:
	BTFSS	r0x15, 0
	BRA	_01148_DS_
;	.line	227; /home/mandon/pinguino32/copie courante/linux/source/user.c	tmp = (board[from[0]][from[1]] & 0x07)/2;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x15
; #;;multiply lit val:0x08 by variable r0x15 and store in r0x15
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x15, W
	MULLW	0x08
	MOVFF	PRODL, r0x15
	CLRF	r0x17
	MOVLW	LOW(_board)
	ADDWF	r0x15, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x17, F
	CLRF	r0x18
	MOVF	r0x15, W
	ADDWF	r0x16, F
	MOVF	r0x17, W
	ADDWFC	r0x18, F
	MOVFF	r0x16, FSR0L
	MOVFF	r0x18, FSR0H
	MOVFF	INDF0, r0x16
	MOVLW	0x07
	ANDWF	r0x16, F
	RRNCF	r0x16, W
	ANDLW	0x7f
	MOVWF	r0x04
_01148_DS_:
;	.line	231; /home/mandon/pinguino32/copie courante/linux/source/user.c	if((!((capturemask[i] >> j) & 1)) && ((currcapturemask[i] >> j) & 1))
	MOVFF	r0x0b, FSR0L
	MOVFF	r0x0c, FSR0H
	MOVFF	INDF0, r0x15
	MOVF	r0x13, W
	BZ	_01216_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01217_DS_:
	RRCF	r0x15, F
	ADDLW	0x01
	BNC	_01217_DS_
_01216_DS_:
	BTFSC	r0x15, 0
	BRA	_01155_DS_
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, FSR0H
	MOVFF	INDF0, r0x15
	MOVF	r0x13, W
	BZ	_01219_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01220_DS_:
	RRCF	r0x15, F
	ADDLW	0x01
	BNC	_01220_DS_
_01219_DS_:
	BTFSS	r0x15, 0
	BRA	_01155_DS_
;	.line	232; /home/mandon/pinguino32/copie courante/linux/source/user.c	movetype = SAFECAPTURE;
	MOVLW	0x04
	BANKSEL	_movetype
	MOVWF	_movetype, B
	BRA	_01156_DS_
_01155_DS_:
;	.line	234; /home/mandon/pinguino32/copie courante/linux/source/user.c	else if ((currcapturemask[i] >> j) & 1)
	MOVFF	r0x0d, FSR0L
	MOVFF	r0x0e, FSR0H
	MOVFF	INDF0, r0x15
	MOVF	r0x13, W
	BZ	_01222_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01223_DS_:
	RRCF	r0x15, F
	ADDLW	0x01
	BNC	_01223_DS_
_01222_DS_:
	BTFSS	r0x15, 0
	BRA	_01152_DS_
;	.line	235; /home/mandon/pinguino32/copie courante/linux/source/user.c	movetype = CAPTURE;
	MOVLW	0x03
	BANKSEL	_movetype
	MOVWF	_movetype, B
	BRA	_01156_DS_
_01152_DS_:
;	.line	237; /home/mandon/pinguino32/copie courante/linux/source/user.c	else if (!((capturemask[i] >> j) & 1))
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, FSR0H
	MOVFF	INDF0, r0x15
	MOVF	r0x13, W
	BZ	_01225_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01226_DS_:
	RRCF	r0x15, F
	ADDLW	0x01
	BNC	_01226_DS_
_01225_DS_:
	BTFSC	r0x15, 0
	BRA	_01156_DS_
;	.line	238; /home/mandon/pinguino32/copie courante/linux/source/user.c	movetype = SAFE;
	MOVLW	0x02
	BANKSEL	_movetype
	MOVWF	_movetype, B
_01156_DS_:
;	.line	241; /home/mandon/pinguino32/copie courante/linux/source/user.c	curr_pos_rate  = (to[0] > 3)? to[0]-3 : 3-to[0];
	MOVLW	0x04
	BANKSEL	_getbestpiecemove_to_1_1
	SUBWF	_getbestpiecemove_to_1_1, W, B
	BNC	_01182_DS_
	MOVLW	0xfd
; removed redundant BANKSEL
	ADDWF	_getbestpiecemove_to_1_1, W, B
	MOVWF	r0x15
	BRA	_01183_DS_
_01182_DS_:
	BANKSEL	_getbestpiecemove_to_1_1
	MOVF	_getbestpiecemove_to_1_1, W, B
	SUBLW	0x03
	MOVWF	r0x15
_01183_DS_:
;	.line	242; /home/mandon/pinguino32/copie courante/linux/source/user.c	k  = (to[1] > 3)? to[1]-3 : 3-to[1];
	MOVLW	0x04
	BANKSEL	(_getbestpiecemove_to_1_1 + 1)
	SUBWF	(_getbestpiecemove_to_1_1 + 1), W, B
	BNC	_01184_DS_
	MOVLW	0xfd
; removed redundant BANKSEL
	ADDWF	(_getbestpiecemove_to_1_1 + 1), W, B
	MOVWF	r0x16
	BRA	_01185_DS_
_01184_DS_:
	BANKSEL	(_getbestpiecemove_to_1_1 + 1)
	MOVF	(_getbestpiecemove_to_1_1 + 1), W, B
	SUBLW	0x03
	MOVWF	r0x16
_01185_DS_:
;	.line	243; /home/mandon/pinguino32/copie courante/linux/source/user.c	curr_pos_rate += k;      
	MOVF	r0x16, W
	ADDWF	r0x15, F
;	.line	246; /home/mandon/pinguino32/copie courante/linux/source/user.c	tmp += rate_move((board[from[0]][from[1]]),to,curr_pos_rate);
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
; #	MOVWF	r0x16
; #;;multiply lit val:0x08 by variable r0x16 and store in r0x16
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x16, W
	MULLW	0x08
	MOVFF	PRODL, r0x16
	CLRF	r0x17
	MOVLW	LOW(_board)
	ADDWF	r0x16, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x17, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrget1
; #	MOVWF	r0x18
; #	MOVF	r0x18, W
	ADDWF	r0x16, F
	CLRF	WREG
	ADDWFC	r0x17, F
	MOVFF	r0x16, FSR0L
	MOVFF	r0x17, FSR0H
	MOVFF	INDF0, r0x16
	MOVF	r0x15, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_getbestpiecemove_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_getbestpiecemove_to_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x16, W
	MOVWF	POSTDEC1
	CALL	_rate_move
	MOVWF	r0x15
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x15, W
	ADDWF	r0x04, F
;	.line	249; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (tmp > piecerate)
	MOVF	r0x04, W
	BANKSEL	_piecerate
	SUBWF	_piecerate, W, B
	BC	_01159_DS_
;	.line	251; /home/mandon/pinguino32/copie courante/linux/source/user.c	piecerate = tmp;
	MOVFF	r0x04, _piecerate
;	.line	252; /home/mandon/pinguino32/copie courante/linux/source/user.c	bestmove = move;
	MOVFF	r0x14, r0x03
_01159_DS_:
;	.line	254; /home/mandon/pinguino32/copie courante/linux/source/user.c	tmp = 0;  
	CLRF	r0x04
_01201_DS_:
;	.line	257; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (k = 0; k < 8; ++k)
	CLRF	r0x14
_01168_DS_:
	MOVLW	0x08
	SUBWF	r0x14, W
	BC	_01163_DS_
;	.line	259; /home/mandon/pinguino32/copie courante/linux/source/user.c	validmovemask[k] = 0;
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x14, W
	MOVWF	r0x15
	CLRF	r0x16
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x16, F
	MOVFF	r0x15, FSR0L
	MOVFF	r0x16, FSR0H
	CLRF	INDF0
;	.line	260; /home/mandon/pinguino32/copie courante/linux/source/user.c	capturemask[k]   = 0;
	MOVLW	LOW(_capturemask)
	ADDWF	r0x14, W
	MOVWF	r0x15
	CLRF	r0x16
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x16, F
	MOVFF	r0x15, FSR0L
	MOVFF	r0x16, FSR0H
	CLRF	INDF0
;	.line	257; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (k = 0; k < 8; ++k)
	INCF	r0x14, F
	BRA	_01168_DS_
_01163_DS_:
;	.line	263; /home/mandon/pinguino32/copie courante/linux/source/user.c	currmovemask[i] = currmovemask[i] >> 1;
	MOVLW	LOW(_currmovemask)
	ADDWF	r0x08, W
	MOVWF	r0x14
	CLRF	r0x15
	MOVLW	HIGH(_currmovemask)
	ADDWFC	r0x15, F
	MOVFF	r0x14, FSR0L
	MOVFF	r0x15, FSR0H
	MOVFF	INDF0, r0x16
	RRNCF	r0x16, W
	ANDLW	0x7f
	MOVWF	r0x16
	MOVFF	r0x14, FSR0L
	MOVFF	r0x15, FSR0H
	MOVFF	r0x16, INDF0
;	.line	211; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (j = 0; j < 8; ++j)
	INCF	r0x13, F
	BRA	_01172_DS_
_01178_DS_:
;	.line	209; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8; ++i)
	INCF	r0x08, F
	BRA	_01176_DS_
_01179_DS_:
;	.line	280; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar('.');
	MOVLW	0x2e
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
; =DF= MOVFF: replaced by CRLF/SETF
;	.line	282; /home/mandon/pinguino32/copie courante/linux/source/user.c	return bestmove;
	CLRF	PRODL
	MOVF	r0x03, W
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
S_main__loop	code
_loop:
;	.line	55; /home/mandon/pinguino32/copie courante/linux/source/user.c	void loop()
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
	BANKSEL	_movecount
;	.line	64; /home/mandon/pinguino32/copie courante/linux/source/user.c	if ((movecount+1)%2 == 0)
	MOVF	_movecount, W, B
	ADDLW	0x01
	MOVWF	r0x00
	MOVLW	0x00
; removed redundant BANKSEL
	ADDWFC	(_movecount + 1), W, B
	MOVWF	r0x01
	CLRF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_01073_DS_
;	.line	66; /home/mandon/pinguino32/copie courante/linux/source/user.c	draw_chessboard();
	CALL	_draw_chessboard
;	.line	67; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("Jouez : ");
	MOVLW	UPPER(__str_9)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_9)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_9)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
_01046_DS_:
;	.line	74; /home/mandon/pinguino32/copie courante/linux/source/user.c	while (!read_movement(from, to));
	MOVLW	0x80
; #	MOVWF	r0x07
; #	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_from_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_from_1_1)
	MOVWF	POSTDEC1
	CALL	_read_movement
	MOVWF	r0x02
	MOVLW	0x06
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	BZ	_01046_DS_
; ;multiply lit val:0x08 by variable _loop_from_1_1 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_loop_from_1_1
;	.line	76; /home/mandon/pinguino32/copie courante/linux/source/user.c	p = board[from[0]][from[1]];
	MOVF	_loop_from_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x02
	CLRF	r0x03
	MOVLW	LOW(_board)
	ADDWF	r0x02, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x03, F
; removed redundant BANKSEL
	MOVF	(_loop_from_1_1 + 1), W, B
	ADDWF	r0x02, F
	CLRF	WREG
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
;	.line	80; /home/mandon/pinguino32/copie courante/linux/source/user.c	validate[piecetype(p)] (from,WHITE);
	MOVLW	0x07
	ANDWF	r0x02, W
; #	MOVWF	r0x03
; #;;multiply lit val:0x03 by variable r0x03 and store in r0x03
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x03, W
	MULLW	0x03
	MOVFF	PRODL, r0x03
	CLRF	r0x04
	MOVLW	LOW(_validate)
	ADDWF	r0x03, F
	MOVLW	HIGH(_validate)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x05
	CLRF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_from_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_from_1_1)
	MOVWF	POSTDEC1
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_01120_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_01120_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_01120_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x05, PCLATU
	MOVFF	r0x04, PCLATH
	MOVF	r0x03, W
	MOVWF	PCL
_01120_DS_:
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	84; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (is_valid_move(to[0],to[1]) && test_singlemove(from,to,board[from[0]][from[1]]))
	MOVLW	LOW(_validmovemask)
	BANKSEL	_loop_to_1_1
	ADDWF	_loop_to_1_1, W, B
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVLW	0x01
	MOVWF	r0x04
	CLRF	r0x05
; removed redundant BANKSEL
	MOVF	(_loop_to_1_1 + 1), W, B
	BZ	_01121_DS_
	NEGF	WREG
	BCF	STATUS, 0
_01122_DS_:
	RLCF	r0x04, F
	RLCF	r0x05, F
	ADDLW	0x01
	BNC	_01122_DS_
_01121_DS_:
	CLRF	r0x06
	MOVF	r0x03, W
	ANDWF	r0x04, F
	MOVF	r0x06, W
	ANDWF	r0x05, F
	MOVF	r0x04, W
	IORWF	r0x05, W
	BTFSC	STATUS, 2
	BRA	_01050_DS_
; ;multiply lit val:0x08 by variable _loop_from_1_1 and store in r0x09
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_loop_from_1_1
	MOVF	_loop_from_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x09
	CLRF	r0x0a
	MOVLW	LOW(_board)
	ADDWF	r0x09, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0a, F
; removed redundant BANKSEL
	MOVF	(_loop_from_1_1 + 1), W, B
	ADDWF	r0x09, F
	CLRF	WREG
	ADDWFC	r0x0a, F
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_from_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_from_1_1)
	MOVWF	POSTDEC1
	CALL	_test_singlemove
	MOVWF	r0x03
	MOVLW	0x07
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	BTFSC	STATUS, 2
	BRA	_01050_DS_
;	.line	86; /home/mandon/pinguino32/copie courante/linux/source/user.c	draw_move(from,to,p);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_to_1_1)
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_from_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_from_1_1)
	MOVWF	POSTDEC1
	CALL	_draw_move
	MOVLW	0x07
	ADDWF	FSR1L, F
;	.line	87; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\n");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	88; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("Vous jouez : ");
	MOVLW	UPPER(__str_10)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_10)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_10)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	89; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(from[1]+'a');
	MOVLW	0x61
	BANKSEL	(_loop_from_1_1 + 1)
	ADDWF	(_loop_from_1_1 + 1), W, B
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	90; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(from[0]+'1');
	MOVLW	0x31
	BANKSEL	_loop_from_1_1
	ADDWF	_loop_from_1_1, W, B
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	91; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write(" -> ");
	MOVLW	UPPER(__str_11)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_11)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_11)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	92; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(to[1]+'a');
	MOVLW	0x61
	BANKSEL	(_loop_to_1_1 + 1)
	ADDWF	(_loop_to_1_1 + 1), W, B
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	93; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(to[0]+'1');
	MOVLW	0x31
	BANKSEL	_loop_to_1_1
	ADDWF	_loop_to_1_1, W, B
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	94; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\n");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_movecount
;	.line	95; /home/mandon/pinguino32/copie courante/linux/source/user.c	movecount++;
	INCF	_movecount, F, B
	BNC	_11491_DS_
; removed redundant BANKSEL
	INCF	(_movecount + 1), F, B
_11491_DS_:
	BRA	_01101_DS_
_01050_DS_:
;	.line	99; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\nIllegal move from this piece\r\n");
	MOVLW	UPPER(__str_12)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_12)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_12)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
_01101_DS_:
;	.line	104; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8;++i)
	CLRF	r0x03
_01075_DS_:
	MOVLW	0x08
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_01087_DS_
;	.line	106; /home/mandon/pinguino32/copie courante/linux/source/user.c	validmovemask[i] = 0;
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	CLRF	INDF0
;	.line	107; /home/mandon/pinguino32/copie courante/linux/source/user.c	capturemask[i] = 0;
	MOVLW	LOW(_capturemask)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	CLRF	INDF0
;	.line	104; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8;++i)
	INCF	r0x03, F
	BRA	_01075_DS_
_01073_DS_:
;	.line	112; /home/mandon/pinguino32/copie courante/linux/source/user.c	else if ((movecount+1)%2 == 1)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_01124_DS_
	MOVF	r0x01, W
	BZ	_01125_DS_
_01124_DS_:
	BRA	_01070_DS_
_01125_DS_:
;	.line	114; /home/mandon/pinguino32/copie courante/linux/source/user.c	bestfrom = bestto = NO_MOVE;
	SETF	r0x00
	SETF	r0x01
	BANKSEL	_piecerate
;	.line	115; /home/mandon/pinguino32/copie courante/linux/source/user.c	rate = piecerate = 0;
	CLRF	_piecerate, B
	BANKSEL	_rate
	CLRF	_rate, B
;	.line	116; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("I'm thinking ...");
	MOVLW	UPPER(__str_13)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_13)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_13)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	118; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8;++i)
	CLRF	r0x03
	CLRF	r0x04
_01083_DS_:
	MOVLW	0x08
	SUBWF	r0x03, W
	BTFSC	STATUS, 0
	BRA	_01086_DS_
;	.line	120; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (j = 0;j < 8;++j)
	MOVLW	LOW(_board)
	ADDWF	r0x04, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_board)
	ADDWFC	r0x06, F
	CLRF	r0x07
_01079_DS_:
	MOVLW	0x08
	SUBWF	r0x07, W
	BTFSC	STATUS, 0
	BRA	_01085_DS_
;	.line	122; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (board[i][j] & 0x08)
	MOVF	r0x07, W
	ADDWF	r0x05, W
	MOVWF	r0x08
	CLRF	WREG
	ADDWFC	r0x06, W
	MOVWF	r0x09
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x08
	BTFSS	r0x08, 3
	BRA	_01059_DS_
;	.line	124; /home/mandon/pinguino32/copie courante/linux/source/user.c	cpufrom[0] = i;
	MOVF	r0x03, W
	BANKSEL	_loop_cpufrom_1_1
	MOVWF	_loop_cpufrom_1_1, B
;	.line	125; /home/mandon/pinguino32/copie courante/linux/source/user.c	cpufrom[1] = j;
	MOVF	r0x07, W
; removed redundant BANKSEL
	MOVWF	(_loop_cpufrom_1_1 + 1), B
;	.line	126; /home/mandon/pinguino32/copie courante/linux/source/user.c	p = board[i][j];
	MOVFF	r0x08, r0x02
;	.line	127; /home/mandon/pinguino32/copie courante/linux/source/user.c	validate[piecetype(p)](cpufrom,BLACK);
	MOVLW	0x07
	ANDWF	r0x02, W
; #	MOVWF	r0x08
; #;;multiply lit val:0x03 by variable r0x08 and store in r0x08
; #;;Unrolled 8 X 8 multiplication
; #;;FIXME: the function does not support result==WREG
; #	MOVF	r0x08, W
	MULLW	0x03
	MOVFF	PRODL, r0x08
	CLRF	r0x09
	MOVLW	LOW(_validate)
	ADDWF	r0x08, F
	MOVLW	HIGH(_validate)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	POSTINC0, r0x08
	MOVFF	POSTINC0, r0x09
	MOVFF	INDF0, r0x0a
	MOVLW	0x08
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_cpufrom_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_cpufrom_1_1)
	MOVWF	POSTDEC1
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_01130_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_01130_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_01130_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	r0x0a, PCLATU
	MOVFF	r0x09, PCLATH
	MOVF	r0x08, W
	MOVWF	PCL
_01130_DS_:
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	130; /home/mandon/pinguino32/copie courante/linux/source/user.c	moveto   = getbestpiecemove(cpufrom);
	MOVLW	0x80
; #	MOVWF	r0x0a
; #	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_cpufrom_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_cpufrom_1_1)
	MOVWF	POSTDEC1
	CALL	_getbestpiecemove
	MOVWF	r0x08
	MOVLW	0x03
	ADDWF	FSR1L, F
; ;multiply lit val:0x08 by variable _loop_cpufrom_1_1 and store in r0x09
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_loop_cpufrom_1_1
;	.line	131; /home/mandon/pinguino32/copie courante/linux/source/user.c	movefrom = getindex(cpufrom[0],cpufrom[1]); 
	MOVF	_loop_cpufrom_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x09
; removed redundant BANKSEL
	MOVF	(_loop_cpufrom_1_1 + 1), W, B
	ADDWF	r0x09, F
; ;multiply lit val:0x08 by variable _loop_cpufrom_1_1 and store in r0x0a
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
; removed redundant BANKSEL
;	.line	134; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (((board[cpufrom[0]][cpufrom[1]]&0x07) == lastmove) && (movetype < 3))
	MOVF	_loop_cpufrom_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x0a
	CLRF	r0x0b
	MOVLW	LOW(_board)
	ADDWF	r0x0a, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x0b, F
; removed redundant BANKSEL
	MOVF	(_loop_cpufrom_1_1 + 1), W, B
	ADDWF	r0x0a, F
	CLRF	WREG
	ADDWFC	r0x0b, F
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, FSR0H
	MOVFF	INDF0, r0x0a
	MOVLW	0x07
	ANDWF	r0x0a, F
	MOVF	r0x0a, W
	BANKSEL	_lastmove
	XORWF	_lastmove, W, B
	BNZ	_01054_DS_
	MOVLW	0x03
	BANKSEL	_movetype
	SUBWF	_movetype, W, B
	BC	_01054_DS_
;	.line	135; /home/mandon/pinguino32/copie courante/linux/source/user.c	piecerate -= 3;
	MOVLW	0xfd
	BANKSEL	_piecerate
	ADDWF	_piecerate, F, B
_01054_DS_:
	BANKSEL	_piecerate
;	.line	137; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (piecerate > rate)
	MOVF	_piecerate, W, B
	BANKSEL	_rate
	SUBWF	_rate, W, B
	BC	_01059_DS_
;	.line	139; /home/mandon/pinguino32/copie courante/linux/source/user.c	rate     = piecerate;
	MOVFF	_piecerate, _rate
;	.line	140; /home/mandon/pinguino32/copie courante/linux/source/user.c	bestfrom = movefrom;
	MOVFF	r0x09, r0x01
;	.line	141; /home/mandon/pinguino32/copie courante/linux/source/user.c	bestto   = moveto;
	MOVFF	r0x08, r0x00
_01059_DS_:
	BANKSEL	_movetype
;	.line	146; /home/mandon/pinguino32/copie courante/linux/source/user.c	movetype = NO_MOVE;  
	SETF	_movetype, B
;	.line	120; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (j = 0;j < 8;++j)
	INCF	r0x07, F
	BRA	_01079_DS_
_01085_DS_:
;	.line	118; /home/mandon/pinguino32/copie courante/linux/source/user.c	for (i = 0; i < 8;++i)
	MOVLW	0x08
	ADDWF	r0x04, F
	INCF	r0x03, F
	BRA	_01083_DS_
_01086_DS_:
	BANKSEL	_rate
;	.line	150; /home/mandon/pinguino32/copie courante/linux/source/user.c	if (rate != 0) 
	MOVF	_rate, W, B
	BTFSC	STATUS, 2
	BRA	_01064_DS_
;	.line	152; /home/mandon/pinguino32/copie courante/linux/source/user.c	getcoord (cpufrom[0],cpufrom[1],bestfrom);   
	SWAPF	r0x01, W
	RLNCF	WREG, W
	ANDLW	0x1f
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
	MOVWF	r0x03
	BANKSEL	_loop_cpufrom_1_1
	MOVWF	_loop_cpufrom_1_1, B
	MOVLW	0x07
	ANDWF	r0x01, F
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_loop_cpufrom_1_1 + 1), B
;	.line	153; /home/mandon/pinguino32/copie courante/linux/source/user.c	getcoord (cputo[0],cputo[1],bestto);   
	SWAPF	r0x00, W
	RLNCF	WREG, W
	ANDLW	0x1f
; #	MOVWF	r0x04
; #	MOVF	r0x04, W
	BANKSEL	_loop_cputo_1_1
	MOVWF	_loop_cputo_1_1, B
	MOVLW	0x07
	ANDWF	r0x00, F
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_loop_cputo_1_1 + 1), B
; ;multiply lit val:0x08 by variable r0x03 and store in r0x03
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	154; /home/mandon/pinguino32/copie courante/linux/source/user.c	p = board[(cpufrom[0])][(cpufrom[1])];
	MOVF	r0x03, W
	MULLW	0x08
	MOVFF	PRODL, r0x03
	CLRF	r0x00
	MOVLW	LOW(_board)
	ADDWF	r0x03, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x00, F
	CLRF	r0x04
	MOVF	r0x03, W
	ADDWF	r0x01, F
	MOVF	r0x00, W
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x02
;	.line	155; /home/mandon/pinguino32/copie courante/linux/source/user.c	draw_move(cpufrom,cputo,p);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_cputo_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_cputo_1_1)
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	MOVLW	HIGH(_loop_cpufrom_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_loop_cpufrom_1_1)
	MOVWF	POSTDEC1
	CALL	_draw_move
	MOVLW	0x07
	ADDWF	FSR1L, F
;	.line	156; /home/mandon/pinguino32/copie courante/linux/source/user.c	lastmove = (((p&0x07) != PAWN) && ((p&0x07) != KING)) ? p&0x07 : 0;
	ANDWF	r0x02, W
	MOVWF	r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_01140_DS_
	INCF	r0x01, F
_01140_DS_:
	MOVF	r0x01, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	BZ	_01091_DS_
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x06
	BNZ	_01142_DS_
	INCF	r0x01, F
_01142_DS_:
	MOVF	r0x01, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x01
	RLCF	r0x01, F
	MOVF	r0x01, W
	BNZ	_01092_DS_
_01091_DS_:
	CLRF	r0x01
	BRA	_01093_DS_
_01092_DS_:
	MOVLW	0x01
	MOVWF	r0x01
_01093_DS_:
	MOVF	r0x01, W
	BNZ	_01090_DS_
	CLRF	r0x00
_01090_DS_:
	MOVFF	r0x00, _lastmove
;	.line	157; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\n");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	158; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("Je joue : ");
	MOVLW	UPPER(__str_14)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_14)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_14)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	159; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(cpufrom[1]+'a');
	MOVLW	0x61
	BANKSEL	(_loop_cpufrom_1_1 + 1)
	ADDWF	(_loop_cpufrom_1_1 + 1), W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	160; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(cpufrom[0]+'1');
	MOVLW	0x31
	BANKSEL	_loop_cpufrom_1_1
	ADDWF	_loop_cpufrom_1_1, W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	161; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write(" -> ");
	MOVLW	UPPER(__str_11)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_11)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_11)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	162; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(cputo[1]+'a');
	MOVLW	0x61
	BANKSEL	(_loop_cputo_1_1 + 1)
	ADDWF	(_loop_cputo_1_1 + 1), W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	163; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_putchar(cputo[0]+'1');
	MOVLW	0x31
	BANKSEL	_loop_cputo_1_1
	ADDWF	_loop_cputo_1_1, W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_putchar
	INCF	FSR1L, F
;	.line	164; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\n");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_movecount
;	.line	165; /home/mandon/pinguino32/copie courante/linux/source/user.c	movecount++;
	INCF	_movecount, F, B
	BNC	_21492_DS_
; removed redundant BANKSEL
	INCF	(_movecount + 1), F, B
_21492_DS_:
	BRA	_01087_DS_
_01064_DS_:
;	.line	170; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("Pinguino lost - You win!\r\n");
	MOVLW	UPPER(__str_15)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_15)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_15)
	MOVWF	POSTDEC1
	CALL	_serial_write
	BANKSEL	_movecount
;	.line	171; /home/mandon/pinguino32/copie courante/linux/source/user.c	movecount++;   
	INCF	_movecount, F, B
	BNC	_31493_DS_
; removed redundant BANKSEL
	INCF	(_movecount + 1), F, B
_31493_DS_:
_01061_DS_:
;	.line	172; /home/mandon/pinguino32/copie courante/linux/source/user.c	while(1);//break;
	BRA	_01061_DS_
_01070_DS_:
;	.line	178; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("Well done my friend!\r\n");
	MOVLW	UPPER(__str_16)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_16)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_16)
	MOVWF	POSTDEC1
	CALL	_serial_write
_01067_DS_:
;	.line	179; /home/mandon/pinguino32/copie courante/linux/source/user.c	while(1);//break;
	BRA	_01067_DS_
_01087_DS_:
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
	RETURN	

; ; Starting pCode block
S_main__setup	code
_setup:
;	.line	40; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_begin(9600);		// 9600,n,8,1 reception en IT
	CLRF	POSTDEC1
	CLRF	POSTDEC1
	MOVLW	0x25
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_serial_begin
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	41; /home/mandon/pinguino32/copie courante/linux/source/user.c	movecount   = 1;
	MOVLW	0x01
	BANKSEL	_movecount
	MOVWF	_movecount, B
; removed redundant BANKSEL
	CLRF	(_movecount + 1), B
	BANKSEL	_kingcapture
;	.line	42; /home/mandon/pinguino32/copie courante/linux/source/user.c	kingcapture = FALSE;
	CLRF	_kingcapture, B
;	.line	43; /home/mandon/pinguino32/copie courante/linux/source/user.c	movetype = NO_MOVE;      
	MOVLW	0xff
	BANKSEL	_movetype
	SETF	_movetype, B
;	.line	44; /home/mandon/pinguino32/copie courante/linux/source/user.c	init_board();
	CALL	_init_board
;	.line	45; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\n");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	46; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("\r\n");
	MOVLW	UPPER(__str_5)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_5)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_5)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	47; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("---------------------------------\r\n");
	MOVLW	UPPER(__str_6)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_6)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_6)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	48; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("- PLAY CHESS WITH YOUR PINGUINO -\r\n");
	MOVLW	UPPER(__str_7)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_7)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_7)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	49; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("- input example : e2e4          -\r\n");
	MOVLW	UPPER(__str_8)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_8)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_8)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	50; /home/mandon/pinguino32/copie courante/linux/source/user.c	serial_write("---------------------------------\r\n");
	MOVLW	UPPER(__str_6)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_6)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_6)
	MOVWF	POSTDEC1
	CALL	_serial_write
	MOVLW	0x03
	ADDWF	FSR1L, F
	RETURN	

; ; Starting pCode block
S_main__epapout_init	code
_epapout_init:
;	.line	41; /home/mandon/pinguino32/copie courante/linux/source/main.c	void epapout_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epapin_init	code
_epapin_init:
;	.line	40; /home/mandon/pinguino32/copie courante/linux/source/main.c	void epapin_init() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_out	code
_epap_out:
;	.line	39; /home/mandon/pinguino32/copie courante/linux/source/main.c	void epap_out() { return; }
	RETURN	

; ; Starting pCode block
S_main__epap_in	code
_epap_in:
;	.line	38; /home/mandon/pinguino32/copie courante/linux/source/main.c	void epap_in() { return; }
	RETURN	

; ; Starting pCode block
S_main__serial_write	code
_serial_write:
;	.line	180; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	void serial_write(char *fmt,...)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x08
	SUBWF	FSR1L, F
	BTFSS	STATUS, 0
	DECF	FSR1H, F
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	186; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	va_start(ap,fmt);
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
;	.line	187; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	s=va_start(ap,fmt);
	MOVLW	0x80
;	.line	188; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	switch (*s)
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	CALL	__gptrget1
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
	MOVWF	r0x00
	XORLW	0x01
	BNZ	_01005_DS_
	BRA	_00992_DS_
_01005_DS_:
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_01007_DS_
	BRA	_00994_DS_
_01007_DS_:
	MOVF	r0x00, W
	XORLW	0x08
	BNZ	_01009_DS_
	BRA	_00993_DS_
_01009_DS_:
	MOVF	r0x00, W
	XORLW	0x0a
	BZ	_00990_DS_
	MOVF	r0x00, W
	XORLW	0x10
	BZ	_00991_DS_
	BRA	_00995_DS_
_00990_DS_:
;	.line	190; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	case DEC:       serial_printf("%d",(int)fmt);
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVF	r0x04, W
	MOVWF	r0x00
	MOVF	r0x05, W
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	191; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	break;
	BRA	_00997_DS_
_00991_DS_:
;	.line	192; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	case HEX: 		serial_printf("%x",(int)fmt);
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVF	r0x04, W
	MOVWF	r0x00
	MOVF	r0x05, W
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_4)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_4)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_4)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	193; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	break;
	BRA	_00997_DS_
_00992_DS_:
;	.line	194; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	case BYTE: 		serial_printf("%d",(unsigned char)fmt);
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVF	r0x04, W
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	195; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	break;
	BRA	_00997_DS_
_00993_DS_:
;	.line	196; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	case OCTAL:     uitoa((int)fmt,chaine,8);
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVF	r0x04, W
	MOVWF	r0x00
	MOVF	r0x05, W
	MOVWF	r0x01
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVLW	0xf9
	ADDWF	FSR2L, W
	MOVWF	r0x02
	MOVLW	0xff
	ADDWFC	FSR2H, W
	MOVWF	r0x03
	MOVLW	0x08
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_uitoa
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	197; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	serial_printf(chaine);
	MOVLW	0xf9
	ADDWF	FSR2L, W
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	FSR2H, W
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; #	MOVWF	r0x01
; #	MOVWF	r0x01
	MOVWF	r0x01
; #	MOVF	r0x00, W
; #	MOVWF	r0x00
	MOVLW	0x80
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	198; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	break;
	BRA	_00997_DS_
_00994_DS_:
;	.line	199; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	case BIN:       uitoa((int)fmt,chaine,2);
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVF	r0x04, W
	MOVWF	r0x00
	MOVF	r0x05, W
	MOVWF	r0x01
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVLW	0xf9
	ADDWF	FSR2L, W
	MOVWF	r0x02
	MOVLW	0xff
	ADDWFC	FSR2H, W
	MOVWF	r0x03
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_uitoa
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	200; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	serial_printf(chaine);
	MOVLW	0xf9
	ADDWF	FSR2L, W
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	FSR2H, W
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; #	MOVWF	r0x01
; #	MOVWF	r0x01
	MOVWF	r0x01
; #	MOVF	r0x00, W
; #	MOVWF	r0x00
	MOVLW	0x80
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	201; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	break;           
	BRA	_00997_DS_
_00995_DS_:
;	.line	202; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	default:	serial_printf(fmt);
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x04
	MOVLW	0x03
	MOVFF	PLUSW2, r0x05
	MOVLW	0x04
	MOVFF	PLUSW2, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	CALL	_serial_printf
	MOVLW	0x03
	ADDWF	FSR1L, F
_00997_DS_:
;	.line	205; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	va_end(ap);
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVWF	POSTINC1
	MOVLW	0x07
	ADDWF	FSR1L, F
	BTFSC	STATUS, 0
	INCF	FSR1H, F
	COMF	WREG, F
	MOVF	PLUSW1, W
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__serial_getstring	code
_serial_getstring:
;	.line	159; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	u8 * serial_getstring()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	166; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	do {
	CLRF	r0x00
_00976_DS_:
;	.line	167; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	c = serial_getkey();
	CALL	_serial_getkey
	MOVWF	r0x01
;	.line	168; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	serial_printf("%c", c);
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
;	.line	169; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	buffer[i++] = c;
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
;	.line	170; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	} while (c != '\r');
	MOVF	r0x01, W
	XORLW	0x0d
	BNZ	_00976_DS_
;	.line	171; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	buffer[i] = '\0';
	CLRF	r0x01
	MOVLW	LOW(_serial_getstring_buffer_1_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_serial_getstring_buffer_1_1)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	CLRF	INDF0
;	.line	172; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	return (buffer);
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
;	.line	145; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	u8 serial_getkey()
	MOVFF	r0x00, POSTDEC1
_00968_DS_:
;	.line	148; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	while (!(serial_available()));
	CALL	_serial_available
	MOVWF	r0x00
	MOVF	r0x00, W
	BZ	_00968_DS_
;	.line	149; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	c = serial_read();
	CALL	_serial_read
	MOVWF	r0x00
;	.line	150; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	serial_flush();
	CALL	_serial_flush
;	.line	151; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	return (c);
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_printf	code
_serial_printf:
;	.line	131; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	void serial_printf(char *fmt, ...)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	135; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	va_start(args, fmt);
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
;	.line	136; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	pprintf(serial_putchar, fmt, args);
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
;	.line	137; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	va_end(args);
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
;	.line	121; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	wpointer=1;
	MOVLW	0x01
	BANKSEL	_wpointer
;	.line	122; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	rpointer=1;
	MOVWF	_wpointer, B
	BANKSEL	_rpointer
	MOVWF	_rpointer, B
	RETURN	

; ; Starting pCode block
S_main__serial_read	code
_serial_read:
;	.line	105; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	unsigned char serial_read()
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	107; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	unsigned char caractere=0;
	CLRF	r0x00
;	.line	109; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	if (serial_available())
	CALL	_serial_available
	MOVWF	r0x01
	MOVF	r0x01, W
	BZ	_00947_DS_
;	.line	111; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	caractere=rx[rpointer++];
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
;	.line	112; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	if (rpointer==RXBUFFERLENGTH)
	MOVF	_rpointer, W, B
	XORLW	0x80
	BNZ	_00947_DS_
;	.line	113; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	rpointer=1;
	MOVLW	0x01
	BANKSEL	_rpointer
	MOVWF	_rpointer, B
_00947_DS_:
;	.line	115; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	return(caractere);
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_interrupt	code
_serial_interrupt:
;	.line	85; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	void serial_interrupt(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	90; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	PIR1bits.RCIF=0;				// clear RX interrupt flag
	BCF	_PIR1bits, 5
;	.line	91; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	caractere=RCREG;				// take received char
	MOVFF	_RCREG, r0x00
	BANKSEL	_wpointer
;	.line	92; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	if (wpointer!=RXBUFFERLENGTH-1)	// if not last place in buffer
	MOVF	_wpointer, W, B
	XORLW	0x7f
	BZ	_00923_DS_
_00935_DS_:
	BANKSEL	_wpointer
;	.line	93; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	newwp=wpointer+1;			// place=place+1
	INCF	_wpointer, W, B
	MOVWF	r0x01
	BRA	_00924_DS_
_00923_DS_:
;	.line	95; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	newwp=1;					// else place=1
	MOVLW	0x01
	MOVWF	r0x01
_00924_DS_:
	BANKSEL	_rpointer
;	.line	97; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	if (rpointer!=newwp)			// if read pointer!=write pointer
	MOVF	_rpointer, W, B
	XORWF	r0x01, W
	BZ	_00926_DS_
;	.line	98; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	rx[wpointer++]=caractere;	// store received char
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
_00926_DS_:
	BANKSEL	_wpointer
;	.line	100; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	if (wpointer==RXBUFFERLENGTH)	// if write pointer=length buffer
	MOVF	_wpointer, W, B
	XORLW	0x80
	BNZ	_00929_DS_
;	.line	101; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	wpointer=1;					// write pointer = 1
	MOVLW	0x01
	BANKSEL	_wpointer
	MOVWF	_wpointer, B
_00929_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__serial_putchar	code
_serial_putchar:
;	.line	78; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	void serial_putchar(unsigned char caractere)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
_00914_DS_:
;	.line	80; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	while (!TXSTAbits.TRMT);
	BTFSS	_TXSTAbits, 1
	BRA	_00914_DS_
;	.line	81; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	TXREG=caractere;		        // yes, send char
	MOVFF	r0x00, _TXREG
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__serial_available	code
_serial_available:
;	.line	72; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	unsigned char serial_available()
	MOVFF	r0x00, POSTDEC1
;	.line	74; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	return(wpointer!=rpointer);
	CLRF	r0x00
	BANKSEL	_wpointer
	MOVF	_wpointer, W, B
	BANKSEL	_rpointer
	XORWF	_rpointer, W, B
	BNZ	_00909_DS_
	INCF	r0x00, F
_00909_DS_:
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
;	.line	48; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	void serial_begin(unsigned long baudrate)
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
;	.line	53; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	spbrg=(48000000/(4*baudrate))-1;
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
;	.line	54; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	highbyte=spbrg/256;
	MOVF	r0x01, W
;	.line	55; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	lowbyte=spbrg%256;
	MOVWF	r0x04
;	.line	56; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	TXSTAbits.BRGH=1;               	  	// set BRGH bit
	BSF	_TXSTAbits, 2
;	.line	57; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	BAUDCONbits.BRG16=1;					// set 16 bits SPBRG
	BSF	_BAUDCONbits, 3
;	.line	58; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	SPBRGH=highbyte;                        // set UART speed SPBRGH
	MOVFF	r0x04, _SPBRGH
;	.line	59; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	SPBRG=lowbyte;   						// set UART speed SPBRGL
	MOVFF	r0x00, _SPBRG
;	.line	60; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	RCSTA=0x90;                             // set RCEN and SPEN
	MOVLW	0x90
	MOVWF	_RCSTA
;	.line	61; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	BAUDCONbits.RCIDL=1;			// set receive active
	BSF	_BAUDCONbits, 6
;	.line	62; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	PIE1bits.RCIE=1;                        // enable interrupt on RX
	BSF	_PIE1bits, 5
;	.line	63; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	INTCONbits.PEIE=1;                      // enable peripheral interrupts
	BSF	_INTCONbits, 6
;	.line	64; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	IPR1bits.RCIP=1;                        // define high priority for RX interrupt
	BSF	_IPR1bits, 5
; #	MOVLW	0x01
; #	MOVWF	_wpointer, B
; #	MOVLW	0x01
;	.line	65; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	wpointer=1;                             // initialize write pointer
	MOVLW	0x01
	BANKSEL	_wpointer
;	.line	66; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	rpointer=1;                             // initialize read pointer
	MOVWF	_wpointer, B
	BANKSEL	_rpointer
	MOVWF	_rpointer, B
;	.line	67; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	TXSTAbits.TXEN=1;                       // enable TX
	BSF	_TXSTAbits, 5
;	.line	68; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/uart18f2550.c	INTCONbits.GIE=1;
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
;	.line	249; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	int psprintf(char *out, const char *format, va_list args)
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
;	.line	254; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	return pprint(&out, format, args);
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
;	.line	239; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	int pprintf(stdout func, const char *format, va_list args)
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
;	.line	245; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	return pprint(0, format, args);
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
;	.line	142; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	static int pprint(char **out, const char *format, va_list args)
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
;	.line	145; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	register int pc = 0;
	CLRF	r0x09
	CLRF	r0x0a
_00819_DS_:
;	.line	148; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for (; *format != 0; ++format)
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0b
	MOVF	r0x0b, W
	BTFSC	STATUS, 2
	GOTO	_00822_DS_
;	.line	150; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == '%')
	MOVF	r0x0b, W
	XORLW	0x25
	BZ	_00859_DS_
	GOTO	_00815_DS_
_00859_DS_:
;	.line	152; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++format;
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
;	.line	153; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	width = pad = 0;
	CLRF	r0x0b
	CLRF	r0x0c
	CLRF	r0x0d
	CLRF	r0x0e
;	.line	154; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == '\0')
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0f
	MOVF	r0x0f, W
	BTFSC	STATUS, 2
	GOTO	_00822_DS_
;	.line	156; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == '%')
	MOVF	r0x0f, W
	XORLW	0x25
	BNZ	_00861_DS_
	GOTO	_00815_DS_
_00861_DS_:
;	.line	158; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == '-')
	MOVF	r0x0f, W
	XORLW	0x2d
	BNZ	_00840_DS_
;	.line	160; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++format;
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
;	.line	161; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pad = PAD_RIGHT;
	MOVLW	0x01
	MOVWF	r0x0b
	CLRF	r0x0c
_00840_DS_:
;	.line	163; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	while (*format == '0')
	MOVFF	r0x03, r0x0f
	MOVFF	r0x04, r0x10
	MOVFF	r0x05, r0x11
_00794_DS_:
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget1
; #	MOVWF	r0x12
; #	MOVF	r0x12, W
	XORLW	0x30
	BNZ	_00826_DS_
;	.line	165; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++format;
	INCF	r0x0f, F
	BTFSC	STATUS, 0
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
;	.line	166; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pad |= PAD_ZERO;
	BSF	r0x0b, 1
	BRA	_00794_DS_
_00826_DS_:
;	.line	168; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; *format >= '0' && *format <= '9'; ++format)
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget1
; #	MOVWF	r0x12
; #	MOVF	r0x12, W
	MOVWF	r0x12
	ADDLW	0x80
	ADDLW	0x50
	BNC	_00857_DS_
	MOVF	r0x12, W
	ADDLW	0x80
	ADDLW	0x46
	BC	_00857_DS_
;	.line	170; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	width *= 10;
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
;	.line	171; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	width += *format - '0';
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
;	.line	168; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; *format >= '0' && *format <= '9'; ++format)
	INCF	r0x0f, F
	BTFSC	STATUS, 0
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
	BRA	_00826_DS_
_00857_DS_:
	MOVFF	r0x0f, r0x03
	MOVFF	r0x10, r0x04
	MOVFF	r0x11, r0x05
;	.line	173; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 's')
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget1
; #	MOVWF	r0x0f
; #	MOVF	r0x0f, W
	MOVWF	r0x0f
	XORLW	0x73
	BZ	_00870_DS_
	BRA	_00798_DS_
_00870_DS_:
;	.line	176; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	char *s = va_arg(args, char*);
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
;	.line	178; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprints(out, s?s:"(null)", width, pad);
	IORWF	r0x11, W
; #	IORWF	r0x12, W
; #	BTFSC	STATUS, 2
; #	GOTO	_00832_DS_
; #	GOTO	_00833_DS_
; #	MOVLW	LOW(__str_0)
	IORWF	r0x12, W
	BNZ	_00833_DS_
	MOVLW	LOW(__str_0)
	MOVWF	r0x10
	MOVLW	HIGH(__str_0)
	MOVWF	r0x11
	MOVLW	UPPER(__str_0)
	MOVWF	r0x12
_00833_DS_:
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
;	.line	179; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	GOTO	_00821_DS_
_00798_DS_:
;	.line	181; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'd')
	MOVF	r0x0f, W
	XORLW	0x64
	BZ	_00872_DS_
	BRA	_00800_DS_
_00872_DS_:
;	.line	183; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprinti(out, va_arg(args, int), 10, 1, width, pad, 'a');
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
;	.line	184; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00800_DS_:
;	.line	186; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'x')
	MOVF	r0x0f, W
	XORLW	0x78
	BZ	_00874_DS_
	BRA	_00802_DS_
_00874_DS_:
;	.line	188; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprinti(out, va_arg(args, int), 16, 0, width, pad, 'a');
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
;	.line	189; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00802_DS_:
;	.line	191; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'X')
	MOVF	r0x0f, W
	XORLW	0x58
	BZ	_00876_DS_
	BRA	_00804_DS_
_00876_DS_:
;	.line	193; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprinti(out, va_arg(args, int), 16, 0, width, pad, 'A');
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
;	.line	194; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00804_DS_:
;	.line	196; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'b')
	MOVF	r0x0f, W
	XORLW	0x62
	BZ	_00878_DS_
	BRA	_00806_DS_
_00878_DS_:
;	.line	198; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprinti(out, va_arg(args, int), 2, 0, width, pad, 'a');
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
;	.line	199; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00806_DS_:
;	.line	201; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'o')
	MOVF	r0x0f, W
	XORLW	0x6f
	BZ	_00880_DS_
	BRA	_00808_DS_
_00880_DS_:
;	.line	203; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprinti(out, va_arg(args, int), 8, 0, width, pad, 'a');
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
;	.line	204; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00808_DS_:
;	.line	206; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'u')
	MOVF	r0x0f, W
	XORLW	0x75
	BZ	_00882_DS_
	BRA	_00810_DS_
_00882_DS_:
;	.line	208; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprinti(out, va_arg(args, int), 10, 0, width, pad, 'a');
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
;	.line	209; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00810_DS_:
;	.line	211; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'c')
	MOVF	r0x0f, W
	XORLW	0x63
	BZ	_00884_DS_
	BRA	_00812_DS_
_00884_DS_:
;	.line	214; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	scr[0] = (char)va_arg(args, int);
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
;	.line	216; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	scr[1] = '\0';
	CLRF	(_pprint_scr_1_1 + 1), B
;	.line	217; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprints(out, scr, width, pad);
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
;	.line	218; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00812_DS_:
;	.line	220; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (*format == 'f')
	MOVF	r0x0f, W
	XORLW	0x66
	BZ	_00886_DS_
	BRA	_00821_DS_
_00886_DS_:
;	.line	222; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pc += pprints(out, "not yet implemented\0", width, pad);
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
;	.line	223; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	continue;
	BRA	_00821_DS_
_00815_DS_:
;	.line	229; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pprintchar(out, *format);
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0b
	CLRF	r0x0c
	BTFSC	r0x0b, 7
	SETF	r0x0c
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	230; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++pc;
	INCF	r0x09, F
	BTFSC	STATUS, 0
	INCF	r0x0a, F
_00821_DS_:
;	.line	148; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for (; *format != 0; ++format)
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	GOTO	_00819_DS_
_00822_DS_:
;	.line	233; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (out) **out = '\0';
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	BZ	_00824_DS_
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
_00824_DS_:
;	.line	235; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	return pc;
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
;	.line	93; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	static int pprinti(char **out, int i, int b, int sg, int width, int pad, int letbase)
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
;	.line	97; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	int t, neg = 0, pc = 0;
	CLRF	r0x0f
	CLRF	r0x10
	CLRF	r0x11
	CLRF	r0x12
;	.line	98; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	unsigned int u = i;
	MOVFF	r0x03, r0x13
	MOVFF	r0x04, r0x14
;	.line	100; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (i == 0)
	MOVF	r0x03, W
	IORWF	r0x04, W
	BNZ	_00750_DS_
;	.line	102; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	print_buf[0] = '0';
	MOVLW	0x30
	BANKSEL	_pprinti_print_buf_1_1
	MOVWF	_pprinti_print_buf_1_1, B
; removed redundant BANKSEL
;	.line	103; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	print_buf[1] = '\0';
	CLRF	(_pprinti_print_buf_1_1 + 1), B
;	.line	104; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	return pprints(out, print_buf, width, pad);
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
	BRA	_00766_DS_
_00750_DS_:
;	.line	107; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (sg && b == 10 && i < 0)
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00752_DS_
	MOVF	r0x05, W
	XORLW	0x0a
	BNZ	_00779_DS_
	MOVF	r0x06, W
	BZ	_00780_DS_
_00779_DS_:
	BRA	_00752_DS_
_00780_DS_:
	BSF	STATUS, 0
	BTFSS	r0x04, 7
	BCF	STATUS, 0
	BNC	_00752_DS_
;	.line	109; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	neg = 1;
	MOVLW	0x01
	MOVWF	r0x0f
	CLRF	r0x10
;	.line	110; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	u = -i;
	COMF	r0x04, W
	MOVWF	r0x14
	COMF	r0x03, W
	MOVWF	r0x13
	INFSNZ	r0x13, F
	INCF	r0x14, F
_00752_DS_:
;	.line	113; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	s = print_buf + PRINT_BUF_LEN-1;
	MOVLW	HIGH(_pprinti_print_buf_1_1 + 11)
	MOVWF	r0x04
	MOVLW	LOW(_pprinti_print_buf_1_1 + 11)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x07
;	.line	114; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	*s = '\0';
	CLRF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	CALL	__gptrput1
;	.line	116; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	while (u)
	MOVF	r0x0d, W
	ADDLW	0xc6
	MOVWF	r0x0d
	MOVFF	r0x05, r0x0e
	MOVFF	r0x06, r0x15
	MOVFF	r0x03, r0x16
	MOVFF	r0x04, r0x17
	MOVFF	r0x07, r0x18
_00757_DS_:
	MOVF	r0x13, W
	IORWF	r0x14, W
	BZ	_00778_DS_
;	.line	118; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	t = u % b;
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
;	.line	119; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if( t >= 10 )
	MOVF	r0x1a, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00782_DS_
	MOVLW	0x0a
	SUBWF	r0x19, W
_00782_DS_:
	BNC	_00756_DS_
;	.line	120; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	t += letbase - '0' - 10;
	MOVF	r0x0d, W
	ADDWF	r0x19, F
_00756_DS_:
;	.line	121; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	*--s = t + '0';
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
;	.line	122; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	u /= b;
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
	BRA	_00757_DS_
_00778_DS_:
	MOVFF	r0x16, r0x03
	MOVFF	r0x17, r0x04
	MOVFF	r0x18, r0x07
;	.line	125; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (neg)
	MOVF	r0x0f, W
	IORWF	r0x10, W
	BZ	_00765_DS_
;	.line	127; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (width && (pad & PAD_ZERO))
	MOVF	r0x09, W
	IORWF	r0x0a, W
	BZ	_00761_DS_
	BTFSS	r0x0b, 1
	BRA	_00761_DS_
;	.line	129; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pprintchar(out, '-');
	CLRF	POSTDEC1
	MOVLW	0x2d
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	130; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++pc;
	MOVLW	0x01
	MOVWF	r0x11
	CLRF	r0x12
;	.line	131; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	--width;
	MOVLW	0xff
	ADDWF	r0x09, F
	BTFSS	STATUS, 0
	DECF	r0x0a, F
	BRA	_00765_DS_
_00761_DS_:
;	.line	135; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	*--s = '-';
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
_00765_DS_:
;	.line	139; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	return pc + pprints(out, s, width, pad);
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
_00766_DS_:
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
;	.line	51; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	static int pprints(char **out, const char *string, int width, int pad)
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
	MOVLW	0x0b
	MOVFF	PLUSW2, r0x09
;	.line	53; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	register int pc = 0;
	CLRF	r0x0a
	CLRF	r0x0b
;	.line	54; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	int padchar = ' ';
	MOVLW	0x20
	MOVWF	r0x0c
	CLRF	r0x0d
;	.line	58; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (width > 0)
	MOVF	r0x07, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00739_DS_
	MOVLW	0x01
	SUBWF	r0x06, W
_00739_DS_:
	BNC	_00703_DS_
;	.line	60; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for (ptr = string; *ptr; ++ptr)
	CLRF	r0x0e
	CLRF	r0x0f
	MOVFF	r0x03, r0x10
	MOVFF	r0x04, r0x11
	MOVFF	r0x05, r0x12
_00706_DS_:
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget1
	MOVWF	r0x13
	MOVF	r0x13, W
	BZ	_00709_DS_
;	.line	61; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++len;
	INCF	r0x0e, F
	BTFSC	STATUS, 0
	INCF	r0x0f, F
;	.line	60; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for (ptr = string; *ptr; ++ptr)
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
	BTFSC	STATUS, 0
	INCF	r0x12, F
	BRA	_00706_DS_
_00709_DS_:
;	.line	62; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (len >= width)
	MOVF	r0x0f, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x07, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00740_DS_
	MOVF	r0x06, W
	SUBWF	r0x0e, W
_00740_DS_:
	BNC	_00698_DS_
;	.line	63; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	width = 0;
	CLRF	r0x06
	CLRF	r0x07
	BRA	_00699_DS_
_00698_DS_:
;	.line	65; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	width -= len;
	MOVF	r0x0e, W
	SUBWF	r0x06, F
	MOVF	r0x0f, W
	SUBWFB	r0x07, F
_00699_DS_:
;	.line	66; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (pad & PAD_ZERO) padchar = '0';
	BTFSS	r0x08, 1
	BRA	_00703_DS_
	MOVLW	0x30
	MOVWF	r0x0c
	CLRF	r0x0d
_00703_DS_:
;	.line	68; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (!(pad & PAD_RIGHT))
	BTFSC	r0x08, 0
	BRA	_00732_DS_
	CLRF	r0x08
	CLRF	r0x09
	MOVFF	r0x06, r0x0e
	MOVFF	r0x07, r0x0f
_00710_DS_:
;	.line	70; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; width > 0; --width)
	MOVF	r0x0f, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00743_DS_
	MOVLW	0x01
	SUBWF	r0x0e, W
_00743_DS_:
	BNC	_00736_DS_
;	.line	72; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pprintchar(out, padchar);
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	73; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++pc;
	INCF	r0x08, F
	BTFSC	STATUS, 0
	INCF	r0x09, F
;	.line	70; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; width > 0; --width)
	MOVLW	0xff
	ADDWF	r0x0e, F
	BTFSS	STATUS, 0
	DECF	r0x0f, F
	BRA	_00710_DS_
_00736_DS_:
	MOVFF	r0x08, r0x0a
	MOVFF	r0x09, r0x0b
	MOVFF	r0x0e, r0x06
	MOVFF	r0x0f, r0x07
_00732_DS_:
	MOVFF	r0x0a, r0x08
	MOVFF	r0x0b, r0x09
_00714_DS_:
;	.line	76; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; *string ; ++string)
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget1
	MOVWF	r0x0a
	MOVF	r0x0a, W
	BZ	_00734_DS_
;	.line	78; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pprintchar(out, *string);
	CLRF	r0x0b
	BTFSC	r0x0a, 7
	SETF	r0x0b
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	79; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++pc;
	INCF	r0x08, F
	BTFSC	STATUS, 0
	INCF	r0x09, F
;	.line	76; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; *string ; ++string)
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	BRA	_00714_DS_
_00734_DS_:
	MOVFF	r0x08, r0x03
	MOVFF	r0x09, r0x04
	MOVFF	r0x06, r0x05
	MOVFF	r0x07, r0x06
_00718_DS_:
;	.line	81; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; width > 0; --width)
	MOVF	r0x06, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00744_DS_
	MOVLW	0x01
	SUBWF	r0x05, W
_00744_DS_:
	BNC	_00721_DS_
;	.line	83; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pprintchar(out, padchar);
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_pprintchar
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	84; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++pc;
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
;	.line	81; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	for ( ; width > 0; --width)
	MOVLW	0xff
	ADDWF	r0x05, F
	BTFSS	STATUS, 0
	DECF	r0x06, F
	BRA	_00718_DS_
_00721_DS_:
;	.line	87; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	return pc;
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
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
S_main__pprintchar	code
_pprintchar:
;	.line	34; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	static void pprintchar(char **str, int c)
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
;	.line	36; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	if (str)
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	BZ	_00687_DS_
;	.line	38; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	**str = c;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget3
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVFF	PRODH, r0x07
	MOVF	r0x03, W
	MOVWF	r0x08
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrput1
;	.line	39; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	++(*str);
	INCF	r0x05, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, PRODH
	MOVFF	r0x07, TBLPTRL
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput3
	BRA	_00689_DS_
_00687_DS_:
;	.line	44; /home/mandon/pinguino32/copie courante/linux/tools/bin/../share/sdcc/include/pic16/stdio.c	pputchar(c);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVFF	INTCON, POSTDEC1
	BCF	INTCON, 7
	PUSH	
	MOVLW	LOW(_00692_DS_)
	MOVWF	TOSL
	MOVLW	HIGH(_00692_DS_)
	MOVWF	TOSH
	MOVLW	UPPER(_00692_DS_)
	MOVWF	TOSU
	MOVF	PREINC1, W
	MOVWF	INTCON
	MOVFF	(_pputchar + 2), PCLATU
	MOVFF	(_pputchar + 1), PCLATH
	BANKSEL	_pputchar
	MOVF	_pputchar, W, B
	MOVWF	PCL
_00692_DS_:
	MOVLW	0x02
	ADDWF	FSR1L, F
_00689_DS_:
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
S_main__val_southwest	code
_val_southwest:
;	.line	449; /home/mandon/Bureau/validate.c	void val_southwest(LOC from,BOOL piececolour,BOOL depth)
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
;	.line	452; /home/mandon/Bureau/validate.c	COORD row = from[0], col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	453; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	454; /home/mandon/Bureau/validate.c	while ((col-- > MIN_COL) && (row-- > MIN_ROW) && (!piecefound) && (depth--))
	MOVFF	r0x05, r0x02
; ;multiply lit val:0x08 by variable r0x05 and store in r0x05
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x05
_00658_DS_:
	MOVFF	r0x00, r0x06
	DECF	r0x00, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00661_DS_
	MOVFF	r0x02, r0x06
	MOVLW	0xf8
	ADDWF	r0x05, F
	DECF	r0x02, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00661_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00661_DS_
	MOVFF	r0x04, r0x06
	DECF	r0x04, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00661_DS_
;	.line	456; /home/mandon/Bureau/validate.c	if (board[row][col] == EMPTY)
	MOVLW	LOW(_board)
	ADDWF	r0x05, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_board)
	ADDWFC	r0x07, F
	MOVF	r0x00, W
	ADDWF	r0x06, F
	CLRF	WREG
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	BNZ	_00653_DS_
;	.line	458; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00672_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00673_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00673_DS_
_00672_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
	BRA	_00658_DS_
_00653_DS_:
;	.line	460; /home/mandon/Bureau/validate.c	else if ((board[row][col] & 0x08) ^ piececolour)
	MOVLW	0x08
	ANDWF	r0x06, F
	MOVF	r0x03, W
	XORWF	r0x06, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00650_DS_
;	.line	462; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVLW	0x01
	MOVWF	r0x09
	MOVF	r0x00, W
	BZ	_00676_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00677_DS_:
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00677_DS_
_00676_DS_:
	MOVF	r0x09, W
	IORWF	r0x08, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x08, INDF0
;	.line	463; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	IORWF	r0x09, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x09, INDF0
;	.line	464; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVLW	0x01
	MOVWF	r0x07
	CLRF	r0x08
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00680_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00681_DS_:
	RLCF	r0x07, F
	RLCF	r0x08, F
	ADDLW	0x01
	BNC	_00681_DS_
_00680_DS_:
	CLRF	r0x09
	MOVF	r0x06, W
	ANDWF	r0x07, F
	MOVF	r0x09, W
	ANDWF	r0x08, F
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00648_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00648_DS_:
;	.line	465; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00658_DS_
_00650_DS_:
;	.line	469; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00658_DS_
_00661_DS_:
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
S_main__val_southeast	code
_val_southeast:
;	.line	424; /home/mandon/Bureau/validate.c	void val_southeast (LOC from,BOOL piececolour,BOOL depth)
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
;	.line	427; /home/mandon/Bureau/validate.c	COORD row = from[0], col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	428; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	429; /home/mandon/Bureau/validate.c	while ((col++ < MAX_COL) && (row-- > MIN_ROW) && (!piecefound) && (depth--))
	MOVFF	r0x05, r0x02
; ;multiply lit val:0x08 by variable r0x05 and store in r0x05
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x05
_00618_DS_:
	MOVFF	r0x00, r0x06
	INCF	r0x00, F
	MOVLW	0x07
	SUBWF	r0x06, W
	BTFSC	STATUS, 0
	BRA	_00621_DS_
	MOVFF	r0x02, r0x06
	MOVLW	0xf8
	ADDWF	r0x05, F
	DECF	r0x02, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00621_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00621_DS_
	MOVFF	r0x04, r0x06
	DECF	r0x04, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00621_DS_
;	.line	431; /home/mandon/Bureau/validate.c	if (board[row][col] == EMPTY)
	MOVLW	LOW(_board)
	ADDWF	r0x05, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_board)
	ADDWFC	r0x07, F
	MOVF	r0x00, W
	ADDWF	r0x06, F
	CLRF	WREG
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	BNZ	_00613_DS_
;	.line	433; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00633_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00634_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00634_DS_
_00633_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
	BRA	_00618_DS_
_00613_DS_:
;	.line	435; /home/mandon/Bureau/validate.c	else if ((board[row][col] & 0x08) ^ piececolour)
	MOVLW	0x08
	ANDWF	r0x06, F
	MOVF	r0x03, W
	XORWF	r0x06, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00610_DS_
;	.line	437; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVLW	0x01
	MOVWF	r0x09
	MOVF	r0x00, W
	BZ	_00637_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00638_DS_:
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00638_DS_
_00637_DS_:
	MOVF	r0x09, W
	IORWF	r0x08, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x08, INDF0
;	.line	438; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	IORWF	r0x09, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x09, INDF0
;	.line	439; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVLW	0x01
	MOVWF	r0x07
	CLRF	r0x08
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00641_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00642_DS_:
	RLCF	r0x07, F
	RLCF	r0x08, F
	ADDLW	0x01
	BNC	_00642_DS_
_00641_DS_:
	CLRF	r0x09
	MOVF	r0x06, W
	ANDWF	r0x07, F
	MOVF	r0x09, W
	ANDWF	r0x08, F
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00608_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00608_DS_:
;	.line	440; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00618_DS_
_00610_DS_:
;	.line	444; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00618_DS_
_00621_DS_:
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
S_main__val_northeast	code
_val_northeast:
;	.line	399; /home/mandon/Bureau/validate.c	void val_northeast(LOC from,BOOL piececolour,BOOL depth)
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
;	.line	402; /home/mandon/Bureau/validate.c	COORD row = from[0], col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	403; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	404; /home/mandon/Bureau/validate.c	while ((col++ < MAX_COL) && (row++ < MAX_ROW) && (!piecefound) && (depth--))
	MOVFF	r0x05, r0x02
; ;multiply lit val:0x08 by variable r0x05 and store in r0x05
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x05
_00577_DS_:
	MOVFF	r0x00, r0x06
	INCF	r0x00, F
	MOVLW	0x07
	SUBWF	r0x06, W
	BTFSC	STATUS, 0
	BRA	_00580_DS_
	MOVFF	r0x02, r0x06
	MOVLW	0x08
	ADDWF	r0x05, F
	INCF	r0x02, F
	MOVLW	0x07
	SUBWF	r0x06, W
	BTFSC	STATUS, 0
	BRA	_00580_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00580_DS_
	MOVFF	r0x04, r0x06
	DECF	r0x04, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00580_DS_
;	.line	406; /home/mandon/Bureau/validate.c	if (board[row][col] == EMPTY)
	MOVLW	LOW(_board)
	ADDWF	r0x05, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_board)
	ADDWFC	r0x07, F
	MOVF	r0x00, W
	ADDWF	r0x06, F
	CLRF	WREG
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	BNZ	_00572_DS_
;	.line	408; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00593_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00594_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00594_DS_
_00593_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
	BRA	_00577_DS_
_00572_DS_:
;	.line	410; /home/mandon/Bureau/validate.c	else if ((board[row][col] & 0x08) ^ piececolour)
	MOVLW	0x08
	ANDWF	r0x06, F
	MOVF	r0x03, W
	XORWF	r0x06, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00569_DS_
;	.line	412; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVLW	0x01
	MOVWF	r0x09
	MOVF	r0x00, W
	BZ	_00597_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00598_DS_:
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00598_DS_
_00597_DS_:
	MOVF	r0x09, W
	IORWF	r0x08, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x08, INDF0
;	.line	413; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	IORWF	r0x09, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x09, INDF0
;	.line	414; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVLW	0x01
	MOVWF	r0x07
	CLRF	r0x08
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00601_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00602_DS_:
	RLCF	r0x07, F
	RLCF	r0x08, F
	ADDLW	0x01
	BNC	_00602_DS_
_00601_DS_:
	CLRF	r0x09
	MOVF	r0x06, W
	ANDWF	r0x07, F
	MOVF	r0x09, W
	ANDWF	r0x08, F
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00567_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00567_DS_:
;	.line	415; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00577_DS_
_00569_DS_:
;	.line	419; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00577_DS_
_00580_DS_:
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
S_main__val_northwest	code
_val_northwest:
;	.line	374; /home/mandon/Bureau/validate.c	void val_northwest (LOC from,BOOL piececolour,BOOL depth)
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
;	.line	377; /home/mandon/Bureau/validate.c	COORD row = from[0], col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	378; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	379; /home/mandon/Bureau/validate.c	while ((col-- > MIN_COL) && (row++ < MAX_ROW) && (!piecefound) &&  (depth--))
	MOVFF	r0x05, r0x02
; ;multiply lit val:0x08 by variable r0x05 and store in r0x05
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x05
_00537_DS_:
	MOVFF	r0x00, r0x06
	DECF	r0x00, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00540_DS_
	MOVFF	r0x02, r0x06
	MOVLW	0x08
	ADDWF	r0x05, F
	INCF	r0x02, F
	MOVLW	0x07
	SUBWF	r0x06, W
	BTFSC	STATUS, 0
	BRA	_00540_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00540_DS_
	MOVFF	r0x04, r0x06
	DECF	r0x04, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00540_DS_
;	.line	381; /home/mandon/Bureau/validate.c	if (board[row][col] == EMPTY)
	MOVLW	LOW(_board)
	ADDWF	r0x05, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_board)
	ADDWFC	r0x07, F
	MOVF	r0x00, W
	ADDWF	r0x06, F
	CLRF	WREG
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	BNZ	_00532_DS_
;	.line	383; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00552_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00553_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00553_DS_
_00552_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
	BRA	_00537_DS_
_00532_DS_:
;	.line	385; /home/mandon/Bureau/validate.c	else if ((board[row][col] & 0x08) ^ piececolour)
	MOVLW	0x08
	ANDWF	r0x06, F
	MOVF	r0x03, W
	XORWF	r0x06, F
	MOVF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00529_DS_
;	.line	387; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVLW	0x01
	MOVWF	r0x09
	MOVF	r0x00, W
	BZ	_00556_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00557_DS_:
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00557_DS_
_00556_DS_:
	MOVF	r0x09, W
	IORWF	r0x08, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x08, INDF0
;	.line	388; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x02, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x08
	MOVF	r0x08, W
	IORWF	r0x09, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x09, INDF0
;	.line	389; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x06
	CLRF	r0x07
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	INDF0, r0x06
	MOVLW	0x01
	MOVWF	r0x07
	CLRF	r0x08
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00560_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00561_DS_:
	RLCF	r0x07, F
	RLCF	r0x08, F
	ADDLW	0x01
	BNC	_00561_DS_
_00560_DS_:
	CLRF	r0x09
	MOVF	r0x06, W
	ANDWF	r0x07, F
	MOVF	r0x09, W
	ANDWF	r0x08, F
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00527_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00527_DS_:
;	.line	390; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00537_DS_
_00529_DS_:
;	.line	394; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00537_DS_
_00540_DS_:
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
S_main__val_west	code
_val_west:
;	.line	351; /home/mandon/Bureau/validate.c	void val_west (LOC from,BOOL piececolour,BOOL depth)
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
;	.line	353; /home/mandon/Bureau/validate.c	char row = from[0],col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	354; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
; ;multiply lit val:0x08 by variable r0x05 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	355; /home/mandon/Bureau/validate.c	while ((col-- > MIN_COL) && (!piecefound) && (depth--))
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x02
	CLRF	r0x06
	BTFSC	r0x02, 7
	SETF	r0x06
	MOVLW	LOW(_board)
	ADDWF	r0x02, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x06, F
	MOVLW	0x08
	ANDWF	r0x03, F
	SWAPF	r0x03, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x03
_00492_DS_:
	MOVFF	r0x00, r0x07
	DECF	r0x00, F
	MOVF	r0x07, W
	ADDLW	0x80
	ADDLW	0x7f
	BTFSS	STATUS, 0
	BRA	_00495_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00495_DS_
	MOVFF	r0x04, r0x07
	DECF	r0x04, F
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00495_DS_
;	.line	356; /home/mandon/Bureau/validate.c	{ if (board[row][col] == EMPTY)
	MOVF	r0x00, W
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	WREG
	BTFSC	r0x00, 7
	SETF	WREG
	ADDWFC	r0x06, W
	MOVWF	r0x08
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	BNZ	_00488_DS_
;	.line	358; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x08
	CLRF	r0x09
	BTFSC	r0x05, 7
	SETF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0a
	MOVLW	0x01
	MOVWF	r0x0b
	MOVF	r0x00, W
	BZ	_00508_DS_
	BN	_00511_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00509_DS_:
	RLCF	r0x0b, F
	ADDLW	0x01
	BNC	_00509_DS_
	BRA	_00508_DS_
_00511_DS_:
	BCF	STATUS, 0
_00510_DS_:
	RRCF	r0x0b, F
	ADDLW	0x01
	BNC	_00510_DS_
_00508_DS_:
	MOVF	r0x0b, W
	IORWF	r0x0a, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x0a, INDF0
	BRA	_00492_DS_
_00488_DS_:
;	.line	360; /home/mandon/Bureau/validate.c	else if (is_opp_piece(row,col,piececolour))
	MOVLW	0x08
	ANDWF	r0x07, W
	MOVWF	r0x08
	SWAPF	r0x08, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x08
	MOVF	r0x03, W
	XORWF	r0x08, F
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00484_DS_
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00484_DS_
;	.line	362; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	BTFSC	r0x05, 7
	SETF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00514_DS_
	BN	_00517_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00515_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00515_DS_
	BRA	_00514_DS_
_00517_DS_:
	BCF	STATUS, 0
_00516_DS_:
	RRCF	r0x0a, F
	ADDLW	0x01
	BNC	_00516_DS_
_00514_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	363; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	BTFSC	r0x05, 7
	SETF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x09, W
	IORWF	r0x0a, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x0a, INDF0
;	.line	364; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVLW	0x01
	MOVWF	r0x08
	CLRF	r0x09
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00520_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00521_DS_:
	RLCF	r0x08, F
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00521_DS_
_00520_DS_:
	CLRF	r0x0a
	MOVF	r0x07, W
	ANDWF	r0x08, F
	MOVF	r0x0a, W
	ANDWF	r0x09, F
	MOVF	r0x08, W
	IORWF	r0x09, W
	BZ	_00482_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00482_DS_:
;	.line	365; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00492_DS_
_00484_DS_:
;	.line	369; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00492_DS_
_00495_DS_:
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
S_main__val_east	code
_val_east:
;	.line	328; /home/mandon/Bureau/validate.c	void val_east (LOC from,BOOL piececolour,BOOL depth)
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
;	.line	330; /home/mandon/Bureau/validate.c	COORD row = from[0],col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	331; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
; ;multiply lit val:0x08 by variable r0x05 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	332; /home/mandon/Bureau/validate.c	while ((col++ < MAX_COL) && (!piecefound) && (depth--))
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x02
	CLRF	r0x06
	MOVLW	LOW(_board)
	ADDWF	r0x02, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x06, F
	MOVLW	0x08
	ANDWF	r0x03, F
	SWAPF	r0x03, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x03
_00451_DS_:
	MOVFF	r0x00, r0x07
	INCF	r0x00, F
	MOVLW	0x07
	SUBWF	r0x07, W
	BTFSC	STATUS, 0
	BRA	_00454_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00454_DS_
	MOVFF	r0x04, r0x07
	DECF	r0x04, F
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00454_DS_
;	.line	333; /home/mandon/Bureau/validate.c	{ if (board[row][col] == EMPTY)
	MOVF	r0x00, W
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	WREG
	ADDWFC	r0x06, W
	MOVWF	r0x08
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	BNZ	_00447_DS_
;	.line	335; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0a
	MOVLW	0x01
	MOVWF	r0x0b
	MOVF	r0x00, W
	BZ	_00467_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00468_DS_:
	RLCF	r0x0b, F
	ADDLW	0x01
	BNC	_00468_DS_
_00467_DS_:
	MOVF	r0x0b, W
	IORWF	r0x0a, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x0a, INDF0
	BRA	_00451_DS_
_00447_DS_:
;	.line	337; /home/mandon/Bureau/validate.c	else if (is_opp_piece(row,col,piececolour))
	MOVLW	0x08
	ANDWF	r0x07, W
	MOVWF	r0x08
	SWAPF	r0x08, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x08
	MOVF	r0x03, W
	XORWF	r0x08, F
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00443_DS_
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00443_DS_
;	.line	339; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00471_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00472_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00472_DS_
_00471_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	340; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x09, W
	IORWF	r0x0a, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x0a, INDF0
;	.line	341; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVLW	0x01
	MOVWF	r0x08
	CLRF	r0x09
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00475_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00476_DS_:
	RLCF	r0x08, F
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00476_DS_
_00475_DS_:
	CLRF	r0x0a
	MOVF	r0x07, W
	ANDWF	r0x08, F
	MOVF	r0x0a, W
	ANDWF	r0x09, F
	MOVF	r0x08, W
	IORWF	r0x09, W
	BZ	_00441_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00441_DS_:
;	.line	342; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00451_DS_
_00443_DS_:
;	.line	346; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00451_DS_
_00454_DS_:
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
S_main__val_south	code
_val_south:
;	.line	305; /home/mandon/Bureau/validate.c	void val_south (LOC from,BOOL piececolour,BOOL depth)
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
;	.line	307; /home/mandon/Bureau/validate.c	char row = from[0], col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	308; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	309; /home/mandon/Bureau/validate.c	while ((row-- > MIN_ROW) && (!piecefound) && (depth--))
	MOVLW	0x01
	MOVWF	r0x02
	MOVF	r0x00, W
	BZ	_00424_DS_
	BN	_00427_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00425_DS_:
	RLCF	r0x02, F
	ADDLW	0x01
	BNC	_00425_DS_
	BRA	_00424_DS_
_00427_DS_:
	BCF	STATUS, 0
_00426_DS_:
	RRCF	r0x02, F
	ADDLW	0x01
	BNC	_00426_DS_
_00424_DS_:
	MOVLW	0x08
	ANDWF	r0x03, F
	SWAPF	r0x03, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x03
	MOVFF	r0x05, r0x06
; ;multiply lit val:0x08 by variable r0x05 and store in r0x05
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x05
_00410_DS_:
	MOVFF	r0x06, r0x07
	MOVLW	0xf8
	ADDWF	r0x05, F
	DECF	r0x06, F
	MOVF	r0x07, W
	ADDLW	0x80
	ADDLW	0x7f
	BTFSS	STATUS, 0
	BRA	_00413_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00413_DS_
	MOVFF	r0x04, r0x07
	DECF	r0x04, F
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00413_DS_
;	.line	310; /home/mandon/Bureau/validate.c	{ if (board[row][col] == EMPTY)
	MOVLW	LOW(_board)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	BTFSC	r0x05, 7
	SETF	r0x08
	MOVLW	HIGH(_board)
	ADDWFC	r0x08, F
	MOVF	r0x00, W
	ADDWF	r0x07, F
	CLRF	WREG
	BTFSC	r0x00, 7
	SETF	WREG
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	BNZ	_00406_DS_
;	.line	312; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x06, W
	MOVWF	r0x08
	CLRF	r0x09
	BTFSC	r0x06, 7
	SETF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0a
	MOVF	r0x02, W
	IORWF	r0x0a, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x0a, INDF0
	BRA	_00410_DS_
_00406_DS_:
;	.line	314; /home/mandon/Bureau/validate.c	else if (is_opp_piece(row,col,piececolour))
	MOVLW	0x08
	ANDWF	r0x07, W
	MOVWF	r0x08
	SWAPF	r0x08, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x08
	MOVF	r0x03, W
	XORWF	r0x08, F
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00402_DS_
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00402_DS_
;	.line	316; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x06, W
	MOVWF	r0x07
	CLRF	r0x08
	BTFSC	r0x06, 7
	SETF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x02, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	317; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x06, W
	MOVWF	r0x07
	CLRF	r0x08
	BTFSC	r0x06, 7
	SETF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x02, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	318; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVLW	0x01
	MOVWF	r0x08
	CLRF	r0x09
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00434_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00435_DS_:
	RLCF	r0x08, F
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00435_DS_
_00434_DS_:
	CLRF	r0x0a
	MOVF	r0x07, W
	ANDWF	r0x08, F
	MOVF	r0x0a, W
	ANDWF	r0x09, F
	MOVF	r0x08, W
	IORWF	r0x09, W
	BZ	_00400_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00400_DS_:
;	.line	319; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00410_DS_
_00402_DS_:
;	.line	323; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00410_DS_
_00413_DS_:
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
S_main__val_north	code
_val_north:
;	.line	282; /home/mandon/Bureau/validate.c	void val_north (LOC from,BOOL piececolour,BOOL depth)
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
;	.line	284; /home/mandon/Bureau/validate.c	{ COORD row = from[0],col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	285; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	286; /home/mandon/Bureau/validate.c	while ((row++ < MAX_ROW) && (!piecefound) && (depth--))
	MOVLW	0x01
	MOVWF	r0x02
	MOVF	r0x00, W
	BZ	_00385_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00386_DS_:
	RLCF	r0x02, F
	ADDLW	0x01
	BNC	_00386_DS_
_00385_DS_:
	MOVLW	0x08
	ANDWF	r0x03, F
	SWAPF	r0x03, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x03
	MOVFF	r0x05, r0x06
; ;multiply lit val:0x08 by variable r0x05 and store in r0x05
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x05
_00371_DS_:
	MOVFF	r0x06, r0x07
	MOVLW	0x08
	ADDWF	r0x05, F
	INCF	r0x06, F
	MOVLW	0x07
	SUBWF	r0x07, W
	BTFSC	STATUS, 0
	BRA	_00374_DS_
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00374_DS_
	MOVFF	r0x04, r0x07
	DECF	r0x04, F
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00374_DS_
;	.line	287; /home/mandon/Bureau/validate.c	{ if (board[row][col] == EMPTY)
	MOVLW	LOW(_board)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_board)
	ADDWFC	r0x08, F
	MOVF	r0x00, W
	ADDWF	r0x07, F
	CLRF	WREG
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	BNZ	_00367_DS_
;	.line	289; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x06, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0a
	MOVF	r0x02, W
	IORWF	r0x0a, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x0a, INDF0
	BRA	_00371_DS_
_00367_DS_:
;	.line	291; /home/mandon/Bureau/validate.c	else if (is_opp_piece(row,col,piececolour))
	MOVLW	0x08
	ANDWF	r0x07, W
	MOVWF	r0x08
	SWAPF	r0x08, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x08
	MOVF	r0x03, W
	XORWF	r0x08, F
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00363_DS_
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00363_DS_
;	.line	293; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x06, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x02, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	294; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	MOVLW	LOW(_capturemask)
	ADDWF	r0x06, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x02, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	295; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVLW	0x01
	MOVWF	r0x08
	CLRF	r0x09
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00393_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00394_DS_:
	RLCF	r0x08, F
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00394_DS_
_00393_DS_:
	CLRF	r0x0a
	MOVF	r0x07, W
	ANDWF	r0x08, F
	MOVF	r0x0a, W
	ANDWF	r0x09, F
	MOVF	r0x08, W
	IORWF	r0x09, W
	BZ	_00361_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00361_DS_:
;	.line	296; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00371_DS_
_00363_DS_:
;	.line	300; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
	BRA	_00371_DS_
_00374_DS_:
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
S_main__val_king	code
_val_king:
;	.line	231; /home/mandon/Bureau/validate.c	void val_king(LOC from,BOOL piececolour)
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
;	.line	236; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00333_DS_
	BANKSEL	_bl_king_pos
;	.line	237; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = bl_king_pos[0];
	MOVF	_bl_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_bl_king_pos + 1)
;	.line	238; /home/mandon/Bureau/validate.c	opp_king_pos[1] = bl_king_pos[1];
	MOVF	(_bl_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
	BRA	_00334_DS_
_00333_DS_:
	BANKSEL	_wh_king_pos
;	.line	241; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = wh_king_pos[0];
	MOVF	_wh_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_wh_king_pos + 1)
;	.line	242; /home/mandon/Bureau/validate.c	opp_king_pos[1] = wh_king_pos[1];
	MOVF	(_wh_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
_00334_DS_:
;	.line	247; /home/mandon/Bureau/validate.c	val_north      (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_north
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	248; /home/mandon/Bureau/validate.c	val_south      (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_south
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	249; /home/mandon/Bureau/validate.c	val_east       (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_east
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	250; /home/mandon/Bureau/validate.c	val_west       (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_west
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	251; /home/mandon/Bureau/validate.c	val_northeast  (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_northeast
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	252; /home/mandon/Bureau/validate.c	val_northwest  (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_northwest
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	253; /home/mandon/Bureau/validate.c	val_southeast  (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_southeast
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	254; /home/mandon/Bureau/validate.c	val_southwest  (from,piececolour,1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_southwest
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	257; /home/mandon/Bureau/validate.c	if (piececolour & 0x08) 
	BTFSS	r0x03, 3
	BRA	_00336_DS_
;	.line	258; /home/mandon/Bureau/validate.c	{ tmp = bl_base_cont;
	MOVFF	_bl_base_cont, r0x00
;	.line	259; /home/mandon/Bureau/validate.c	row = MAX_ROW;
	MOVLW	0x07
	MOVWF	r0x01
	BRA	_00337_DS_
_00336_DS_:
;	.line	262; /home/mandon/Bureau/validate.c	{ tmp = wh_base_cont;
	MOVFF	_wh_base_cont, r0x00
;	.line	263; /home/mandon/Bureau/validate.c	row = MIN_ROW;
	CLRF	r0x01
_00337_DS_:
;	.line	266; /home/mandon/Bureau/validate.c	if ((tmp & 0x1F)== 0x11)
	MOVLW	0x1f
	ANDWF	r0x00, W
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
	XORLW	0x11
	BNZ	_00339_DS_
;	.line	268; /home/mandon/Bureau/validate.c	validmovemask[row] |= 0x04;
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x04
	BSF	r0x04, 2
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	r0x04, INDF0
_00339_DS_:
;	.line	271; /home/mandon/Bureau/validate.c	if ((tmp & 0xF0)==0x90) 
	MOVLW	0xf0
	ANDWF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x90
	BNZ	_00342_DS_
;	.line	273; /home/mandon/Bureau/validate.c	validmovemask[row] |= 0x40;
	CLRF	r0x00
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x01, F
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x00, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x00, FSR0H
	MOVFF	INDF0, r0x02
	BSF	r0x02, 6
	MOVFF	r0x01, FSR0L
	MOVFF	r0x00, FSR0H
	MOVFF	r0x02, INDF0
_00342_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__val_queen	code
_val_queen:
;	.line	204; /home/mandon/Bureau/validate.c	void val_queen(LOC from,BOOL piececolour)
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
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	211; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00325_DS_
	BANKSEL	_bl_king_pos
;	.line	212; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = bl_king_pos[0];
	MOVF	_bl_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_bl_king_pos + 1)
;	.line	213; /home/mandon/Bureau/validate.c	opp_king_pos[1] = bl_king_pos[1];
	MOVF	(_bl_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
	BRA	_00326_DS_
_00325_DS_:
	BANKSEL	_wh_king_pos
;	.line	216; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = wh_king_pos[0];
	MOVF	_wh_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_wh_king_pos + 1)
;	.line	217; /home/mandon/Bureau/validate.c	opp_king_pos[1] = wh_king_pos[1];
	MOVF	(_wh_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
_00326_DS_:
;	.line	221; /home/mandon/Bureau/validate.c	val_north      (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_north
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	222; /home/mandon/Bureau/validate.c	val_south      (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_south
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	223; /home/mandon/Bureau/validate.c	val_east       (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_east
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	224; /home/mandon/Bureau/validate.c	val_west       (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_west
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	225; /home/mandon/Bureau/validate.c	val_northeast  (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_northeast
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	226; /home/mandon/Bureau/validate.c	val_northwest  (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_northwest
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	227; /home/mandon/Bureau/validate.c	val_southeast  (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_southeast
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	228; /home/mandon/Bureau/validate.c	val_southwest  (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_southwest
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__val_rook	code
_val_rook:
;	.line	183; /home/mandon/Bureau/validate.c	void val_rook(LOC from,BOOL piececolour)
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
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	188; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00317_DS_
	BANKSEL	_bl_king_pos
;	.line	189; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = bl_king_pos[0];
	MOVF	_bl_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_bl_king_pos + 1)
;	.line	190; /home/mandon/Bureau/validate.c	opp_king_pos[1] = bl_king_pos[1];
	MOVF	(_bl_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
	BRA	_00318_DS_
_00317_DS_:
	BANKSEL	_wh_king_pos
;	.line	193; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = wh_king_pos[0];
	MOVF	_wh_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_wh_king_pos + 1)
;	.line	194; /home/mandon/Bureau/validate.c	opp_king_pos[1] = wh_king_pos[1];
	MOVF	(_wh_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
_00318_DS_:
;	.line	198; /home/mandon/Bureau/validate.c	val_north (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_north
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	199; /home/mandon/Bureau/validate.c	val_south (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_south
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	200; /home/mandon/Bureau/validate.c	val_east  (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_east
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	201; /home/mandon/Bureau/validate.c	val_west  (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_west
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__val_knight	code
_val_knight:
;	.line	98; /home/mandon/Bureau/validate.c	void val_knight(LOC from,BOOL piececolour)
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
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	103; /home/mandon/Bureau/validate.c	{ unsigned char mask = 0,i = 0;
	CLRF	r0x04
	BANKSEL	_val_knight_move_1_1
;	.line	107; /home/mandon/Bureau/validate.c	int move[] = {0, 2, 1, 0, 2, -1, 0, 1, 2, 0, 1, -2, 0, -1, 2, 0, -1, -2, 0, -2, -1, 0, -2, 1};
	CLRF	_val_knight_move_1_1, B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 1), B
	MOVLW	0x02
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 2), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 3), B
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 4), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 5), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 6), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 7), B
	MOVLW	0x02
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 8), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 9), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 10), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 11), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 12), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 13), B
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 14), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 15), B
	MOVLW	0x02
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 16), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 17), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 18), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 19), B
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 20), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 21), B
	MOVLW	0xfe
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 22), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 23), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 24), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 25), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 26), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 27), B
	MOVLW	0x02
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 28), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 29), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 30), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 31), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 32), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 33), B
	MOVLW	0xfe
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 34), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 35), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 36), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 37), B
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 38), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 39), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 40), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 41), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 42), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 43), B
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 44), B
; removed redundant BANKSEL
	SETF	(_val_knight_move_1_1 + 45), B
	MOVLW	0x01
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 46), B
; removed redundant BANKSEL
	CLRF	(_val_knight_move_1_1 + 47), B
;	.line	110; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00200_DS_
	BANKSEL	_bl_king_pos
;	.line	111; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = bl_king_pos[0];
	MOVF	_bl_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_bl_king_pos + 1)
;	.line	112; /home/mandon/Bureau/validate.c	opp_king_pos[1] = bl_king_pos[1];
	MOVF	(_bl_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
	BRA	_00201_DS_
_00200_DS_:
	BANKSEL	_wh_king_pos
;	.line	115; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = wh_king_pos[0];
	MOVF	_wh_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_wh_king_pos + 1)
;	.line	116; /home/mandon/Bureau/validate.c	opp_king_pos[1] = wh_king_pos[1];
	MOVF	(_wh_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
_00201_DS_:
;	.line	120; /home/mandon/Bureau/validate.c	switch (from[0])
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x05
	MOVLW	0x08
	SUBWF	r0x05, W
	BC	_00210_DS_
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	CLRF	r0x0d
	RLCF	r0x05, W
	RLCF	r0x0d, F
	RLCF	WREG, W
	RLCF	r0x0d, F
	ANDLW	0xfc
	MOVWF	r0x0c
	MOVLW	UPPER(_00280_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00280_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00280_DS_)
	ADDWF	r0x0c, F
	MOVF	r0x0d, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x0c, W
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVWF	PCL
_00280_DS_:
	GOTO	_00202_DS_
	GOTO	_00203_DS_
	GOTO	_00209_DS_
	GOTO	_00209_DS_
	GOTO	_00209_DS_
	GOTO	_00209_DS_
	GOTO	_00204_DS_
	GOTO	_00205_DS_
_00202_DS_:
;	.line	121; /home/mandon/Bureau/validate.c	{ case 0 : mask |=  0x03;   break; // Two up  - None down.
	MOVLW	0x03
	MOVWF	r0x04
	BRA	_00210_DS_
_00203_DS_:
;	.line	122; /home/mandon/Bureau/validate.c	case 1 : mask |=  0x07;   break; // Two up  - One down.
	MOVLW	0x07
	MOVWF	r0x04
	BRA	_00210_DS_
_00204_DS_:
;	.line	123; /home/mandon/Bureau/validate.c	case 6 : mask |=  0x0D;   break; // One up  - Two down.
	MOVLW	0x0d
	MOVWF	r0x04
	BRA	_00210_DS_
_00205_DS_:
;	.line	124; /home/mandon/Bureau/validate.c	case 7 : mask |=  0x0C;   break; // None up - Two down.
	MOVLW	0x0c
	MOVWF	r0x04
	BRA	_00210_DS_
_00209_DS_:
;	.line	128; /home/mandon/Bureau/validate.c	case 5 : mask |=  0x0F;   break; // Two up  - Two down.
	MOVLW	0x0f
	MOVWF	r0x04
_00210_DS_:
;	.line	132; /home/mandon/Bureau/validate.c	switch (from[1])
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVLW	0x08
	SUBWF	r0x00, W
	BC	_00219_DS_
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	CLRF	r0x0d
	RLCF	r0x00, W
	RLCF	r0x0d, F
	RLCF	WREG, W
	RLCF	r0x0d, F
	ANDLW	0xfc
	MOVWF	r0x0c
	MOVLW	UPPER(_00282_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00282_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00282_DS_)
	ADDWF	r0x0c, F
	MOVF	r0x0d, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x0c, W
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVWF	PCL
_00282_DS_:
	GOTO	_00211_DS_
	GOTO	_00212_DS_
	GOTO	_00218_DS_
	GOTO	_00218_DS_
	GOTO	_00218_DS_
	GOTO	_00218_DS_
	GOTO	_00213_DS_
	GOTO	_00214_DS_
_00211_DS_:
;	.line	133; /home/mandon/Bureau/validate.c	{ case 0 : mask |=  0xC0;   break; // None left - Two right.
	MOVLW	0xc0
	IORWF	r0x04, F
	BRA	_00219_DS_
_00212_DS_:
;	.line	134; /home/mandon/Bureau/validate.c	case 1 : mask |=  0xD0;   break; // One left  - Two right.
	MOVLW	0xd0
	IORWF	r0x04, F
	BRA	_00219_DS_
_00213_DS_:
;	.line	135; /home/mandon/Bureau/validate.c	case 6 : mask |=  0x70;   break; // Two left  - One right.
	MOVLW	0x70
	IORWF	r0x04, F
	BRA	_00219_DS_
_00214_DS_:
;	.line	136; /home/mandon/Bureau/validate.c	case 7 : mask |=  0x30;   break; // Two left  - None right.
	MOVLW	0x30
	IORWF	r0x04, F
	BRA	_00219_DS_
_00218_DS_:
;	.line	140; /home/mandon/Bureau/validate.c	case 5 : mask |=  0xF0;   break; // Two left  - Two right.
	MOVLW	0xf0
	IORWF	r0x04, F
_00219_DS_:
;	.line	154; /home/mandon/Bureau/validate.c	move[0]  = up2_rgt1;
	MOVLW	0x40
	ANDWF	r0x04, W
	MOVWF	r0x01
	MOVF	r0x01, W
	BZ	_00236_DS_
	BTFSC	r0x04, 1
	BRA	_00237_DS_
_00236_DS_:
	CLRF	r0x02
	BRA	_00238_DS_
_00237_DS_:
	MOVLW	0x01
	MOVWF	r0x02
_00238_DS_:
	CLRF	r0x06
	BTFSC	r0x02, 7
	SETF	r0x06
	MOVF	r0x02, W
	BANKSEL	_val_knight_move_1_1
	MOVWF	_val_knight_move_1_1, B
	MOVF	r0x06, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 1), B
;	.line	155; /home/mandon/Bureau/validate.c	move[3]  = up2_lft1;
	MOVLW	0x10
	ANDWF	r0x04, W
	MOVWF	r0x02
	MOVF	r0x02, W
	BZ	_00239_DS_
	BTFSC	r0x04, 1
	BRA	_00240_DS_
_00239_DS_:
	CLRF	r0x06
	BRA	_00241_DS_
_00240_DS_:
	MOVLW	0x01
	MOVWF	r0x06
_00241_DS_:
	CLRF	r0x07
	BTFSC	r0x06, 7
	SETF	r0x07
	MOVF	r0x06, W
	BANKSEL	(_val_knight_move_1_1 + 6)
	MOVWF	(_val_knight_move_1_1 + 6), B
	MOVF	r0x07, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 7), B
;	.line	156; /home/mandon/Bureau/validate.c	move[6]  = up1_rgt2;
	MOVLW	0x80
	ANDWF	r0x04, W
	MOVWF	r0x06
	MOVF	r0x06, W
	BZ	_00242_DS_
	BTFSC	r0x04, 0
	BRA	_00243_DS_
_00242_DS_:
	CLRF	r0x07
	BRA	_00244_DS_
_00243_DS_:
	MOVLW	0x01
	MOVWF	r0x07
_00244_DS_:
	CLRF	r0x08
	BTFSC	r0x07, 7
	SETF	r0x08
	MOVF	r0x07, W
	BANKSEL	(_val_knight_move_1_1 + 12)
	MOVWF	(_val_knight_move_1_1 + 12), B
	MOVF	r0x08, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 13), B
;	.line	157; /home/mandon/Bureau/validate.c	move[9]  = up1_lft2;
	MOVLW	0x20
	ANDWF	r0x04, W
	MOVWF	r0x07
	MOVF	r0x07, W
	BZ	_00245_DS_
	BTFSC	r0x04, 0
	BRA	_00246_DS_
_00245_DS_:
	CLRF	r0x08
	BRA	_00247_DS_
_00246_DS_:
	MOVLW	0x01
	MOVWF	r0x08
_00247_DS_:
	CLRF	r0x09
	BTFSC	r0x08, 7
	SETF	r0x09
	MOVF	r0x08, W
	BANKSEL	(_val_knight_move_1_1 + 18)
	MOVWF	(_val_knight_move_1_1 + 18), B
	MOVF	r0x09, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 19), B
;	.line	158; /home/mandon/Bureau/validate.c	move[12] = dwn1_rgt2;
	MOVF	r0x06, W
	BZ	_00248_DS_
	BTFSC	r0x04, 2
	BRA	_00249_DS_
_00248_DS_:
	CLRF	r0x06
	BRA	_00250_DS_
_00249_DS_:
	MOVLW	0x01
	MOVWF	r0x06
_00250_DS_:
	CLRF	r0x08
	BTFSC	r0x06, 7
	SETF	r0x08
	MOVF	r0x06, W
	BANKSEL	(_val_knight_move_1_1 + 24)
	MOVWF	(_val_knight_move_1_1 + 24), B
	MOVF	r0x08, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 25), B
;	.line	159; /home/mandon/Bureau/validate.c	move[15] = dwn1_lft2;
	MOVF	r0x07, W
	BZ	_00251_DS_
	BTFSC	r0x04, 2
	BRA	_00252_DS_
_00251_DS_:
	CLRF	r0x06
	BRA	_00253_DS_
_00252_DS_:
	MOVLW	0x01
	MOVWF	r0x06
_00253_DS_:
	CLRF	r0x07
	BTFSC	r0x06, 7
	SETF	r0x07
	MOVF	r0x06, W
	BANKSEL	(_val_knight_move_1_1 + 30)
	MOVWF	(_val_knight_move_1_1 + 30), B
	MOVF	r0x07, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 31), B
;	.line	160; /home/mandon/Bureau/validate.c	move[18] = dwn2_lft1;
	MOVF	r0x02, W
	BZ	_00254_DS_
	BTFSC	r0x04, 3
	BRA	_00255_DS_
_00254_DS_:
	CLRF	r0x02
	BRA	_00256_DS_
_00255_DS_:
	MOVLW	0x01
	MOVWF	r0x02
_00256_DS_:
	CLRF	r0x06
	BTFSC	r0x02, 7
	SETF	r0x06
	MOVF	r0x02, W
	BANKSEL	(_val_knight_move_1_1 + 36)
	MOVWF	(_val_knight_move_1_1 + 36), B
	MOVF	r0x06, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 37), B
;	.line	161; /home/mandon/Bureau/validate.c	move[21] = dwn2_rgt1;
	MOVF	r0x01, W
	BZ	_00257_DS_
	BTFSC	r0x04, 3
	BRA	_00258_DS_
_00257_DS_:
	CLRF	r0x01
	BRA	_00259_DS_
_00258_DS_:
	MOVLW	0x01
	MOVWF	r0x01
_00259_DS_:
	CLRF	r0x02
	BTFSC	r0x01, 7
	SETF	r0x02
	MOVF	r0x01, W
	BANKSEL	(_val_knight_move_1_1 + 42)
	MOVWF	(_val_knight_move_1_1 + 42), B
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_val_knight_move_1_1 + 43), B
;	.line	164; /home/mandon/Bureau/validate.c	for (i = 0; i <= 21; i += 3)
	MOVLW	0x08
	ANDWF	r0x03, F
	SWAPF	r0x03, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00230_DS_:
	MOVLW	0x16
	SUBWF	r0x02, W
	BTFSC	STATUS, 0
	BRA	_00234_DS_
;	.line	165; /home/mandon/Bureau/validate.c	{ if (move[i])
	MOVLW	LOW(_val_knight_move_1_1)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x06
	MOVLW	HIGH(_val_knight_move_1_1)
	ADDWFC	r0x06, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x06
	MOVF	r0x04, W
	IORWF	r0x06, W
	BTFSC	STATUS, 2
	BRA	_00232_DS_
;	.line	167; /home/mandon/Bureau/validate.c	row = (from[0] + move[i+1]);
	INCF	r0x02, W
	MOVWF	r0x04
; ;multiply lit val:0x02 by variable r0x04 and store in r0x04
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BCF	STATUS, 0
	RLCF	r0x04, F
	CLRF	r0x06
	MOVLW	LOW(_val_knight_move_1_1)
	ADDWF	r0x04, F
	MOVLW	HIGH(_val_knight_move_1_1)
	ADDWFC	r0x06, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	INDF0, r0x06
	MOVF	r0x05, W
	ADDWF	r0x04, F
;	.line	168; /home/mandon/Bureau/validate.c	col = (from[1] + move[i+2]);
	MOVLW	0x02
	ADDWF	r0x02, W
	MOVWF	r0x06
; ;multiply lit val:0x02 by variable r0x06 and store in r0x06
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BCF	STATUS, 0
	RLCF	r0x06, F
	CLRF	r0x07
	MOVLW	LOW(_val_knight_move_1_1)
	ADDWF	r0x06, F
	MOVLW	HIGH(_val_knight_move_1_1)
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	POSTINC0, r0x06
	MOVFF	INDF0, r0x07
	MOVF	r0x00, W
	ADDWF	r0x06, F
; ;multiply lit val:0x08 by variable r0x04 and store in r0x07
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	169; /home/mandon/Bureau/validate.c	if (board[row][col] == EMPTY)
	MOVF	r0x04, W
	MULLW	0x08
	MOVFF	PRODL, r0x07
	CLRF	r0x08
	MOVLW	LOW(_board)
	ADDWF	r0x07, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x08, F
	MOVF	r0x06, W
	ADDWF	r0x07, F
	CLRF	WREG
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	BNZ	_00226_DS_
;	.line	171; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x04, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0a
	MOVLW	0x01
	MOVWF	r0x0b
	MOVF	r0x06, W
	BZ	_00302_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00303_DS_:
	RLCF	r0x0b, F
	ADDLW	0x01
	BNC	_00303_DS_
_00302_DS_:
	MOVF	r0x0b, W
	IORWF	r0x0a, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x0a, INDF0
	BRA	_00232_DS_
_00226_DS_:
;	.line	173; /home/mandon/Bureau/validate.c	else if (is_opp_piece(row,col,piececolour))
	MOVLW	0x08
	ANDWF	r0x07, W
	MOVWF	r0x08
	SWAPF	r0x08, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x08
	MOVF	r0x01, W
	XORWF	r0x08, F
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00232_DS_
	MOVF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00232_DS_
;	.line	175; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x04, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x06, W
	BZ	_00306_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00307_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00307_DS_
_00306_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, W
	MOVWF	r0x06
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x06, INDF0
;	.line	176; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<col);
	CLRF	r0x06
	MOVLW	LOW(_capturemask)
	ADDWF	r0x04, F
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	IORWF	r0x0a, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x0a, INDF0
;	.line	177; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]] & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x04
	CLRF	r0x06
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x06, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x04
	MOVLW	0x01
	MOVWF	r0x06
	CLRF	r0x07
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00310_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00311_DS_:
	RLCF	r0x06, F
	RLCF	r0x07, F
	ADDLW	0x01
	BNC	_00311_DS_
_00310_DS_:
	CLRF	r0x08
	MOVF	r0x04, W
	ANDWF	r0x06, F
	MOVF	r0x08, W
	ANDWF	r0x07, F
	MOVF	r0x06, W
	IORWF	r0x07, W
	BZ	_00232_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00232_DS_:
;	.line	164; /home/mandon/Bureau/validate.c	for (i = 0; i <= 21; i += 3)
	MOVLW	0x06
	ADDWF	r0x03, F
	MOVLW	0x03
	ADDWF	r0x02, F
	BRA	_00230_DS_
_00234_DS_:
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
S_main__val_bishop	code
_val_bishop:
;	.line	76; /home/mandon/Bureau/validate.c	void val_bishop(LOC from,BOOL piececolour)
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
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	82; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00192_DS_
	BANKSEL	_bl_king_pos
;	.line	83; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = bl_king_pos[0];
	MOVF	_bl_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_bl_king_pos + 1)
;	.line	84; /home/mandon/Bureau/validate.c	opp_king_pos[1] = bl_king_pos[1];
	MOVF	(_bl_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
	BRA	_00193_DS_
_00192_DS_:
	BANKSEL	_wh_king_pos
;	.line	87; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = wh_king_pos[0];
	MOVF	_wh_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_wh_king_pos + 1)
;	.line	88; /home/mandon/Bureau/validate.c	opp_king_pos[1] = wh_king_pos[1];
	MOVF	(_wh_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
_00193_DS_:
;	.line	92; /home/mandon/Bureau/validate.c	val_northeast (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_northeast
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	93; /home/mandon/Bureau/validate.c	val_northwest (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_northwest
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	94; /home/mandon/Bureau/validate.c	val_southeast (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_southeast
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	95; /home/mandon/Bureau/validate.c	val_southwest (from,piececolour,-1);
	SETF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_val_southwest
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__val_pawn	code
_val_pawn:
;	.line	18; /home/mandon/Bureau/validate.c	void val_pawn(LOC from,BOOL piececolour)
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
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	20; /home/mandon/Bureau/validate.c	{ COORD row = from[0],col = from[1];
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x04
	MOVFF	r0x04, r0x05
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
;	.line	21; /home/mandon/Bureau/validate.c	BOOL piecefound = FALSE;
	CLRF	r0x01
;	.line	24; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00111_DS_
	BANKSEL	_bl_king_pos
;	.line	25; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = bl_king_pos[0];
	MOVF	_bl_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_bl_king_pos + 1)
;	.line	26; /home/mandon/Bureau/validate.c	opp_king_pos[1] = bl_king_pos[1];
	MOVF	(_bl_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
	BRA	_00112_DS_
_00111_DS_:
	BANKSEL	_wh_king_pos
;	.line	29; /home/mandon/Bureau/validate.c	{ opp_king_pos[0] = wh_king_pos[0];
	MOVF	_wh_king_pos, W, B
	BANKSEL	_opp_king_pos
	MOVWF	_opp_king_pos, B
	BANKSEL	(_wh_king_pos + 1)
;	.line	30; /home/mandon/Bureau/validate.c	opp_king_pos[1] = wh_king_pos[1];
	MOVF	(_wh_king_pos + 1), W, B
	BANKSEL	(_opp_king_pos + 1)
	MOVWF	(_opp_king_pos + 1), B
_00112_DS_:
;	.line	34; /home/mandon/Bureau/validate.c	if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00114_DS_
;	.line	35; /home/mandon/Bureau/validate.c	row++;
	INCF	r0x05, F
	BRA	_00115_DS_
_00114_DS_:
;	.line	37; /home/mandon/Bureau/validate.c	row--;
	DECF	r0x05, F
; ;multiply lit val:0x08 by variable r0x05 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
_00115_DS_:
;	.line	40; /home/mandon/Bureau/validate.c	if (board[row][col] == EMPTY)
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x02
	CLRF	r0x06
	MOVLW	LOW(_board)
	ADDWF	r0x02, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x06, F
	MOVF	r0x00, W
	ADDWF	r0x02, W
	MOVWF	r0x07
	CLRF	WREG
	ADDWFC	r0x06, W
	MOVWF	r0x08
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	BNZ	_00117_DS_
;	.line	41; /home/mandon/Bureau/validate.c	{ validmovemask[row] |= (1<<col);
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVLW	0x01
	MOVWF	r0x0a
	MOVF	r0x00, W
	BZ	_00160_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00161_DS_:
	RLCF	r0x0a, F
	ADDLW	0x01
	BNC	_00161_DS_
_00160_DS_:
	MOVF	r0x0a, W
	IORWF	r0x09, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
	BRA	_00118_DS_
_00117_DS_:
;	.line	44; /home/mandon/Bureau/validate.c	piecefound = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
_00118_DS_:
;	.line	48; /home/mandon/Bureau/validate.c	if ((is_opp_piece(row,col-1,piececolour)) && (col > MIN_COL))
	DECF	r0x00, W
; #	MOVWF	r0x07
; #	MOVF	r0x07, W
	MOVWF	r0x07
	ADDWF	r0x02, W
	MOVWF	r0x08
	CLRF	WREG
	ADDWFC	r0x06, W
	MOVWF	r0x09
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x08
	MOVLW	0x08
	ANDWF	r0x08, W
	MOVWF	r0x09
	SWAPF	r0x09, W
	RLNCF	WREG, W
	ANDLW	0x1f
	MOVWF	r0x09
	MOVLW	0x08
	ANDWF	r0x03, W
	MOVWF	r0x0a
	SWAPF	r0x0a, W
	RLNCF	WREG, W
	ANDLW	0x1f
; #	MOVWF	r0x0a
; #	MOVF	r0x0a, W
	MOVWF	r0x0a
	XORWF	r0x09, F
	MOVF	r0x09, W
	BTFSC	STATUS, 2
	BRA	_00122_DS_
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00122_DS_
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	BRA	_00122_DS_
;	.line	50; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<(col - 1));
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x08
	CLRF	r0x09
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	INDF0, r0x0b
	MOVLW	0x01
	MOVWF	r0x0c
	MOVF	r0x07, W
	BZ	_00165_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00166_DS_:
	RLCF	r0x0c, F
	ADDLW	0x01
	BNC	_00166_DS_
_00165_DS_:
	MOVF	r0x0c, W
	IORWF	r0x0b, W
	MOVWF	r0x07
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVFF	r0x07, INDF0
;	.line	51; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<(col - 1));
	MOVLW	LOW(_capturemask)
	ADDWF	r0x05, W
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x09
	MOVF	r0x09, W
	IORWF	r0x0c, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x0c, INDF0
;	.line	52; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVLW	0x01
	MOVWF	r0x08
	CLRF	r0x09
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00169_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00170_DS_:
	RLCF	r0x08, F
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00170_DS_
_00169_DS_:
	CLRF	r0x0b
	MOVF	r0x07, W
	ANDWF	r0x08, F
	MOVF	r0x0b, W
	ANDWF	r0x09, F
	MOVF	r0x08, W
	IORWF	r0x09, W
	BZ	_00122_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00122_DS_:
;	.line	55; /home/mandon/Bureau/validate.c	if ((is_opp_piece(row,col+1,piececolour)) && (col < MAX_COL))
	INCF	r0x00, W
; #	MOVWF	r0x07
; #	MOVF	r0x07, W
	MOVWF	r0x07
	ADDWF	r0x02, F
	CLRF	WREG
	ADDWFC	r0x06, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x02
	MOVLW	0x08
	ANDWF	r0x02, W
	MOVWF	r0x06
	SWAPF	r0x06, W
	RLNCF	WREG, W
	ANDLW	0x1f
; #	MOVWF	r0x06
; #	MOVF	r0x06, W
	XORWF	r0x0a, F
	MOVF	r0x0a, W
	BTFSC	STATUS, 2
	BRA	_00128_DS_
	MOVF	r0x02, W
	BTFSC	STATUS, 2
	BRA	_00128_DS_
	MOVLW	0x07
	SUBWF	r0x00, W
	BTFSC	STATUS, 0
	BRA	_00128_DS_
;	.line	57; /home/mandon/Bureau/validate.c	validmovemask[row] |= (1<<(col + 1));
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, W
	MOVWF	r0x02
	CLRF	r0x06
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x06, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x08
	MOVLW	0x01
	MOVWF	r0x09
	MOVF	r0x07, W
	BZ	_00173_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00174_DS_:
	RLCF	r0x09, F
	ADDLW	0x01
	BNC	_00174_DS_
_00173_DS_:
	MOVF	r0x09, W
	IORWF	r0x08, W
	MOVWF	r0x07
	MOVFF	r0x02, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x07, INDF0
;	.line	58; /home/mandon/Bureau/validate.c	capturemask[row]   |= (1<<(col + 1));
	MOVLW	LOW(_capturemask)
	ADDWF	r0x05, W
	MOVWF	r0x02
	CLRF	r0x06
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x06, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x07
	MOVF	r0x07, W
	IORWF	r0x09, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x09, INDF0
;	.line	59; /home/mandon/Bureau/validate.c	if (capturemask[opp_king_pos[0]]  & (1 << opp_king_pos[1])) kingcapture = TRUE;
	MOVLW	LOW(_capturemask)
	BANKSEL	_opp_king_pos
	ADDWF	_opp_king_pos, W, B
	MOVWF	r0x02
	CLRF	r0x06
	MOVLW	HIGH(_capturemask)
	ADDWFC	r0x06, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x02
	MOVLW	0x01
	MOVWF	r0x06
	CLRF	r0x07
; removed redundant BANKSEL
	MOVF	(_opp_king_pos + 1), W, B
	BZ	_00177_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00178_DS_:
	RLCF	r0x06, F
	RLCF	r0x07, F
	ADDLW	0x01
	BNC	_00178_DS_
_00177_DS_:
	CLRF	r0x08
	MOVF	r0x02, W
	ANDWF	r0x06, F
	MOVF	r0x08, W
	ANDWF	r0x07, F
	MOVF	r0x06, W
	IORWF	r0x07, W
	BZ	_00128_DS_
	MOVLW	0x01
	BANKSEL	_kingcapture
	MOVWF	_kingcapture, B
_00128_DS_:
;	.line	63; /home/mandon/Bureau/validate.c	if ((piececolour == BLACK  && from[0] == BL_PAWN_BASEROW) || (piececolour == WHITE && from[0] == WH_PAWN_BASEROW))
	MOVF	r0x03, W
	XORLW	0x08
	BNZ	_00141_DS_
	MOVF	r0x04, W
	XORLW	0x06
	BZ	_00137_DS_
_00141_DS_:
	MOVF	r0x03, W
	BTFSS	STATUS, 2
	BRA	_00142_DS_
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00142_DS_
_00137_DS_:
;	.line	64; /home/mandon/Bureau/validate.c	{  if (piececolour == WHITE)
	MOVF	r0x03, W
	BNZ	_00132_DS_
;	.line	65; /home/mandon/Bureau/validate.c	row++;
	INCF	r0x05, F
	BRA	_00133_DS_
_00132_DS_:
;	.line	67; /home/mandon/Bureau/validate.c	row--;
	DECF	r0x05, F
; ;multiply lit val:0x08 by variable r0x05 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
_00133_DS_:
;	.line	68; /home/mandon/Bureau/validate.c	if ((board[row][col] == EMPTY) && (piecefound ==FALSE))
	MOVF	r0x05, W
	MULLW	0x08
	MOVFF	PRODL, r0x02
	CLRF	r0x03
	MOVLW	LOW(_board)
	ADDWF	r0x02, F
	MOVLW	HIGH(_board)
	ADDWFC	r0x03, F
	MOVF	r0x00, W
	ADDWF	r0x02, F
	CLRF	WREG
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	BNZ	_00142_DS_
	MOVF	r0x01, W
	BNZ	_00142_DS_
;	.line	69; /home/mandon/Bureau/validate.c	{ validmovemask[row] |= (1<<col);
	CLRF	r0x01
	MOVLW	LOW(_validmovemask)
	ADDWF	r0x05, F
	MOVLW	HIGH(_validmovemask)
	ADDWFC	r0x01, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	INDF0, r0x02
	MOVLW	0x01
	MOVWF	r0x03
	MOVF	r0x00, W
	BZ	_00185_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00186_DS_:
	RLCF	r0x03, F
	ADDLW	0x01
	BNC	_00186_DS_
_00185_DS_:
	MOVF	r0x03, W
	IORWF	r0x02, W
	MOVWF	r0x00
	MOVFF	r0x05, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	r0x00, INDF0
_00142_DS_:
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
S_main__val_empty	code
_val_empty:
;	.line	14; /home/mandon/Bureau/validate.c	piececolour = piececolour;
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
	DB	0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_6:
	DB	0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d
	DB	0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d
	DB	0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x2d, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_7:
	DB	0x2d, 0x20, 0x50, 0x4c, 0x41, 0x59, 0x20, 0x43, 0x48, 0x45, 0x53, 0x53
	DB	0x20, 0x57, 0x49, 0x54, 0x48, 0x20, 0x59, 0x4f, 0x55, 0x52, 0x20, 0x50
	DB	0x49, 0x4e, 0x47, 0x55, 0x49, 0x4e, 0x4f, 0x20, 0x2d, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_8:
	DB	0x2d, 0x20, 0x69, 0x6e, 0x70, 0x75, 0x74, 0x20, 0x65, 0x78, 0x61, 0x6d
	DB	0x70, 0x6c, 0x65, 0x20, 0x3a, 0x20, 0x65, 0x32, 0x65, 0x34, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2d, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_9:
	DB	0x4a, 0x6f, 0x75, 0x65, 0x7a, 0x20, 0x3a, 0x20, 0x00
; ; Starting pCode block
__str_10:
	DB	0x56, 0x6f, 0x75, 0x73, 0x20, 0x6a, 0x6f, 0x75, 0x65, 0x7a, 0x20, 0x3a
	DB	0x20, 0x00
; ; Starting pCode block
__str_11:
	DB	0x20, 0x2d, 0x3e, 0x20, 0x00
; ; Starting pCode block
__str_12:
	DB	0x0d, 0x0a, 0x49, 0x6c, 0x6c, 0x65, 0x67, 0x61, 0x6c, 0x20, 0x6d, 0x6f
	DB	0x76, 0x65, 0x20, 0x66, 0x72, 0x6f, 0x6d, 0x20, 0x74, 0x68, 0x69, 0x73
	DB	0x20, 0x70, 0x69, 0x65, 0x63, 0x65, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_13:
	DB	0x49, 0x27, 0x6d, 0x20, 0x74, 0x68, 0x69, 0x6e, 0x6b, 0x69, 0x6e, 0x67
	DB	0x20, 0x2e, 0x2e, 0x2e, 0x00
; ; Starting pCode block
__str_14:
	DB	0x4a, 0x65, 0x20, 0x6a, 0x6f, 0x75, 0x65, 0x20, 0x3a, 0x20, 0x00
; ; Starting pCode block
__str_15:
	DB	0x50, 0x69, 0x6e, 0x67, 0x75, 0x69, 0x6e, 0x6f, 0x20, 0x6c, 0x6f, 0x73
	DB	0x74, 0x20, 0x2d, 0x20, 0x59, 0x6f, 0x75, 0x20, 0x77, 0x69, 0x6e, 0x21
	DB	0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_16:
	DB	0x57, 0x65, 0x6c, 0x6c, 0x20, 0x64, 0x6f, 0x6e, 0x65, 0x20, 0x6d, 0x79
	DB	0x20, 0x66, 0x72, 0x69, 0x65, 0x6e, 0x64, 0x21, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_17:
	DB	0x51, 0x75, 0x65, 0x65, 0x6e, 0x73, 0x69, 0x64, 0x65, 0x20, 0x43, 0x61
	DB	0x73, 0x74, 0x6c, 0x65, 0x0a, 0x00
; ; Starting pCode block
__str_18:
	DB	0x4b, 0x69, 0x6e, 0x67, 0x73, 0x69, 0x64, 0x65, 0x20, 0x43, 0x61, 0x73
	DB	0x74, 0x6c, 0x65, 0x0a, 0x00
; ; Starting pCode block for Ival
	code
_ligne:
	DB	0x20, 0x2b, 0x2d, 0x2b, 0x2d, 0x2b, 0x2d, 0x2b, 0x2d, 0x2b, 0x2d, 0x2b
	DB	0x2d, 0x2b, 0x2d, 0x2b, 0x2d, 0x2b, 0x00
; ; Starting pCode block
__str_19:
	DB	0x0d, 0x0a, 0x25, 0x73, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_20:
	DB	0x20, 0x20, 0x61, 0x20, 0x62, 0x20, 0x63, 0x20, 0x64, 0x20, 0x65, 0x20
	DB	0x66, 0x20, 0x67, 0x20, 0x68, 0x0d, 0x0a, 0x0d, 0x0a, 0x00
; ; Starting pCode block
__str_21:
	DB	0x0d, 0x0a, 0x69, 0x6c, 0x6c, 0x65, 0x67, 0x61, 0x6c, 0x20, 0x6d, 0x6f
	DB	0x76, 0x65, 0x21, 0x0d, 0x0a, 0x00


; Statistics:
; code size:	20448 (0x4fe0) bytes (15.60%)
;           	10224 (0x27f0) words
; udata size:	  314 (0x013a) bytes (17.52%)
; access size:	   31 (0x001f) bytes


	end
