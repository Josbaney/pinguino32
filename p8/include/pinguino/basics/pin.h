//pin definition

#ifndef __PIN_H
#define __PIN_H
	
#ifdef PICUNO_EQUO

	#define C7 0
	#define RC7 0
	#define RX 0
	#define DT 0
	#define SDO 0

	#define C6 1
	#define RC6 1
	#define TX 1
	#define CK 1

	// run led pin
	#define A4 2
	#define RA4 2
	#define RUNLED	2
	#define LED1 2
	#define USERLED 2

	#define B0 3
	#define RB0 3
	#define AN12 3
	#define INT0 3
	#define FLT0 3
	#define SDI 3
	#define SDA 3

	#define B1 4
	#define RB1 4
	#define AN10 4
	#define INT1 4
	#define SCK 4
	#define SCL 4

	#define B2 5
	#define RB2 5
	#define AN8 5
	#define INT2 5
	#define VMO 5

	#define B3 6
	#define RB3 6
	#define AN9 6
	#define VPO 6

	#define B4 7
	#define RB4 7
	#define AN11 7
	#define KBI0 7

	#define B5 8
	#define RB5 8
	#define KBI1 8
	#define PGM 8

	#define B6 9
	#define RB6 9
	#define KBI2 9
	#define PGC 9

	#define B7 10
	#define RB7 10
	#define KBI3 10
	#define PGD 10

	#define C0 11
	#define RC0 11
	#define T1OSO 11
	#define T13CK 11

	#define C1 12
	#define RC1 12
	#define T1OSI 12
	#define CCP2 12
	#define UOE 12
	 
	#define C2 13
	#define RC2 13
	#define CCP1 13

	#define A0 14
	#define RA0 14
	#define AN0 14

	#define A1 15
	#define RA1 15
	#define AN1 15

	#define A2 16
	#define RA2 16
	#define AN2 16

	#define A3 17
	#define RA3 17
	#define AN3 17

	#define A4 18
	#define RA5 18
	#define AN4 18
	#define SS 18
	#define HLVDIN 18
	#define C2OU 18
	
	#define A5 19
	#define RE0 19
	#define AN5 19
	#define CK1SPP 19

	#define A6 20
	#define RE1 20
	#define AN6 20
	#define CK2SPP 20

	#define A7 21
	#define RE2 21
	#define AN7 21
	#define OESPP 21

	#define RD0 22
	#define SPP0 22
	
	#define RD1 23
	#define SPP1 23

	#define RD2 24
	#define SPP2 24

	#define RD3 25
	#define SPP3 25

	#define RD7 26
	#define SPP7 26

	#define RD6 27
	#define SPP6 27
	
	#define RD5 28
	#define SPP5 28

	#define RD4 29
	#define SPP4 29

#else // Generic 18F2550

	#define B0 0
	#define RB0 0
	#define AN12 0
	#define INT0 0
	#define FLT0 0
	#define SDI 0
	#define SDA 0

	#define B1 1
	#define RB1 1
	#define AN10 1
	#define INT1 1
	#define SCK 1
	#define SCL 1

	#define B2 2
	#define RB2 2
	#define AN8 2
	#define INT2 2
	#define VMO 2

	#define B3 3
	#define RB3 3
	#define AN9 3
	#define VPO 3

	#define B4 4
	#define RB4 4
	#define AN11 4
	#define KBI0 4

	#define B5 5
	#define RB5 5
	#define KBI1 5
	#define PGM 5

	#define B6 6
	#define RB6 6
	#define KBI2 6
	#define PGC 6

	#define B7 7
	#define RB7 7
	#define KBI3 7
	#define PGD 7

	#define C6 8
	#define RC6 8
	#define TX 8
	#define CK 8

	#define C7 9
	#define RC7 9
	#define RX 9
	#define DT 9
	#define SDO 9

	#define C0 10
	#define RC0 10
	#define T1OSO 10
	#define T13CK 10

	#define C1 11
	#define RC1 11
	#define T1OSI 11
	#define CCP2 11
	#define UOE 11

	#define C2 12
	#define RC2 12
	#define CCP1 12
	
	#define A0 13
	#define RA0 13
	#define AN0 13

	#define A1 14
	#define RA1 14
	#define AN1 14

	#define A2 15
	#define RA2 15
	#define AN2 15

	#define A3 16
	#define RA3 16
	#define AN3 16

	// run led pin
	#define A4 18
	#define RA4 18
	#define RUNLED		PORTAbits.RA4
	#define LED1		PORTAbits.RA4
	#define USERLED	PORTAbits.RA4

	#define A5 17
	#define RA5 17
	#define AN4 17
	#define SS 17
	#define HLVDIN 17
	#define C2OU 17

#endif

#endif /* __PIN_H */

