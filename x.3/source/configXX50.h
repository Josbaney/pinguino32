
/*	----------------------------------------------------------------------------
	PIC18Fxx50 Configuration Bit Settings
	-------------------------------------------------------------------------*/

//	CONFIG1L
//	CONFIG  PLLDIV = 5            ; PLL Prescaler Selection bits (Divide by 5 (20 MHz oscillator input))
//	CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
//	CONFIG  USBDIV = 2            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes from the 96 MHz PLL divided by 2)
//	__code char __at __CONFIG1L conf1l = 0x24;

//	CONFIG1H
//	CONFIG  FOSC = HSPLL_HS       ; Oscillator Selection bits (HS oscillator, PLL enabled (HSPLL))
//	CONFIG  FCMEN = ON            ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor enabled)
//	CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)
//	__code char __at __CONFIG1H conf1h = 0x4E;

//	CONFIG2L
//	CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
//	CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
//	CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting)
//	CONFIG  VREGEN = ON           ; USB Voltage Regulator Enable bit (USB voltage regulator enabled)
//	__code char __at __CONFIG2L	conf2l = 0x38;

//	CONFIG2H
//	CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
//	CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)
//	__code char __at __CONFIG2H	conf2h = 0x1E;

//	CONFIG3H
//	CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
//	CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
//	CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
//	CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
//	__code char __at __CONFIG3H	conf3h = 0x83;

//	CONFIG4L
//	CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
//	CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
//	CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
//	CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode enabled)
	__code char __at __CONFIG4L	conf4l = 0x81;

//	CONFIG5L
//	CONFIG  CP0 = OFF             ; __code Protection bit (Block 0 (000800-001FFFh) is code-protected)
//	CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is code-protected)
//	CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is code-protected)
//	CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)
//	__code char __at __CONFIG5L	conf5l = 0x0F;

//	CONFIG5H
//	CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is code-protected)
//	CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)
//	__code char __at __CONFIG5H	conf5h = 0xC0;

//	CONFIG6L
//	CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
//	CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
//	CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
//	CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)
//	__code char __at __CONFIG6L	conf6l = 0x0F;

//	CONFIG6H
//	CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are write-protected)
//	CONFIG  WRTB = OFF             ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is write-protected)
//	CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)
//	__code char __at __CONFIG6H	conf6h = 0xE0;

//	CONFIG7L
//	CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
//	CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
//	CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
//	CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)
//	__code char __at __CONFIG7L	conf7l = 0x0F;

//	CONFIG7H
//	CONFIG  EBTRB = ON            ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is protected from table reads executed in other blocks)
//	__code char __at __CONFIG7H	conf7h = 0x40;
