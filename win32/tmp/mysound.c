/*	----------------------------------------------------------------------------
	Pinguino example to play musical sound with a buzzer or a little loud speaker
	----------------------------------------------------------------------------
	author:		Régis Blanchot
	first release:	08/10/2010
	last update:	12/10/2010
	IDE:			Pinguino b9.2
	----------------------------------------------------------------------------
	To connect your piezo buzzer or little loud speaker to your pinguino board
	just take a look at buzzer.jpg
	--------------------------------------------------------------------------*/

#define LINE_OUT 12			// Buzzer or speaker must be connected
									// to pin 11 (RC1/CCP2) or 12 (RC2/CCP1) 

// partitions

const u8 gamme[] =	{
	DO, R1,
	RE, R1,
	MI, R1,
	FA, R1,
	SOL, R1,
	LA, R1,
	SI, R1,
	DO_, R1,
	0, 0			};

const u8 jinglebells[] =	{
	E,R1_2,E,R1_2,E,R1,
	E,R1_2,E,R1_2,E,R1,
	E,R1_2,G,R1_2,C,R1_2,D,R1_2,E,R2,
	F,R1_2,F,R1_2,F,R1_2,F,R1,
	E,R1_2,E,R1_2,E,R1,
	D,R1_2,D,R1_2,E,R1_2,D,R1,
	G,R1,
	E,R1_2,E,R1_2,E,R1,
	E,R1_2,E,R1_2,E,R1,
	E,R1_2,G,R1_2,C,R1_2,D,R1_2,E,R1,
	F,R1_2,F,R1_2,F,R1_2,F,R1,
	E,R1_2,E,R1_2,E,R1,
	G,R1_2,F,R1_2,E,R1_2,D,R1_2,C,R1,
	0, 0
					};

void setup()
{
	Play(LINE_OUT, gamme,		10);
	delay(1000);
}

void loop()
{
	Play(LINE_OUT, jinglebells,	10);
	delay(1000);
}

