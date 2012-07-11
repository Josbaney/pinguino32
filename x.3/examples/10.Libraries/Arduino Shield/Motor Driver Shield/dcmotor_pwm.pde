//PICUNO EQUO Board's Digital and Analog Pin
/*
Digital Pin
pin0-->RC7		pin11-->RC0		pin22-->RD0
pin1-->RC6		pin12-->RC1		pin23-->RD1
pin2-->RA4		pin13-->RC2		pin24-->RD2
pin3-->RB0		pin14-->RA0		pin25-->RD3
pin4-->RB1		pin15-->RA1		pin26-->RD4
pin5-->RB2		pin16-->RA2		pin27-->RD5
pin6-->RB3		pin17-->RA3		pin28-->RD6
pin7-->RB4		pin18-->RA5		pin29-->RD7
pin8-->RB5		pin19-->RE0		
pin9-->RB6		pin20-->RE1		
pin10-->RB7		pin21-->RE2

Analog Pin
A0-->RA0
A1-->RA1
A2-->RA2
A3-->RA3
A4-->RA5
A5-->RE0
A6-->RE1
A7-->RE2		
*/
//This 2 Amp Motor Driver Shield use Pin 4,7,12,13 to drive two DC motor and require 12V
//not support PWM since board's pin is not compatible with shield's pin
//This program will control motor speed by different switch
//note that you can use PWM.setdutycycle instead of analogWrite

#define sw1 8
#define sw2 9
#define sw3 10
#define led1 29
#define led2 28
#define led3 27
int E1 = 12;
int M1 = 7;
int E2 = 13;
int M2 = 4;

void setup() 
{ 
pinMode(M1, OUTPUT);
pinMode(M2, OUTPUT); 
pinMode(E1, OUTPUT);
pinMode(E2, OUTPUT);
pinMode(sw1, INPUT);
pinMode(sw2, INPUT);
pinMode(sw3, INPUT);
pinMode(led1, OUTPUT);
pinMode(led2, OUTPUT);
pinMode(led3, OUTPUT); 
}

unsigned int value;

void loop() 
{
	digitalWrite(E1,LOW);
	digitalWrite(E2, LOW);
	digitalWrite(led1,LOW);
	digitalWrite(led2,LOW);
	digitalWrite(led3,LOW);
while(1)
{
	if (digitalRead(sw1) == 0)
	{
	digitalWrite(led1,HIGH);
	value=512;
	digitalWrite(M1,HIGH);
	digitalWrite(M2, HIGH);
	analogWrite(E1, value); //PWM Speed Control
	analogWrite(E2, value); //PWM Speed Control
	delay(30);
	}

	else if (digitalRead(sw2) == 0)
	{
	if (value<1023)
	{
	digitalWrite(led2,HIGH);
	value+=1;
	digitalWrite(M1,HIGH);
	digitalWrite(M2, HIGH);
	analogWrite(E1, value); //PWM Speed Control
	analogWrite(E2, value); //PWM Speed Control
	delay(30);
	}
	}
		
	else if (digitalRead(sw3) == 0)
	{
	if (value>0)
	{
	digitalWrite(led3,HIGH);
	value-=1;
	digitalWrite(M1,HIGH);
	digitalWrite(M2, HIGH);
	analogWrite(E1, value); //PWM Speed Control
	analogWrite(E2, value); //PWM Speed Control
	delay(30);
	}
	}
	digitalWrite(led1,LOW);
	digitalWrite(led2,LOW);
	digitalWrite(led3,LOW);
}
}