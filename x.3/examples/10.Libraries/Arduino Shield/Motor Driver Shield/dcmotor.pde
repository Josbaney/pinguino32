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
//This 2 Amp Motor Driver Shield use Pin 4,5,6,7 to drive two DC motor and require 12V
//not support PWM since board's pin is not compatible with shield's pin
//This program rotate dc motor in clockwise and counter-clockwise direction

int E1 = 5;
int M1 = 7;
int E2 = 6;
int M2 = 4;

void setup() 
{ 
pinMode(M1, OUTPUT);
pinMode(M2, OUTPUT); 
pinMode(E1, OUTPUT);
pinMode(E2, OUTPUT); 
} 

void loop() 
{ 
digitalWrite(M1,HIGH); //clockwise
digitalWrite(M2, HIGH);
digitalWrite(E1, HIGH); 
digitalWrite(E2, HIGH); 
delay(5000); 
digitalWrite(E1, LOW); //stop
digitalWrite(E2, LOW);
delay(2000);
digitalWrite(M1,LOW); //counter-clockwise
digitalWrite(M2, LOW);
digitalWrite(E1, HIGH); 
digitalWrite(E2, HIGH); 
delay(5000);
digitalWrite(E1, LOW); //stop
digitalWrite(E2, LOW);
delay(2000); 
}