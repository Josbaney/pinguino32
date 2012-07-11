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
//This input shield use Digital Pin 3,4,5 (3 buttons) and Analog Pin 0,1 
//This program will on the corresponding led based on the button you are pressing

#define x 15
#define y 14
#define button_A 5
#define button_B 3
#define button_C 4

#define LED_TOP 24
#define LED_BOTTOM 22
#define LED_RIGHT 25
#define LED_LEFT 23
#define LED_A 26
#define LED_B 27
#define LED_C 28

void setup()
{
int i;
for(i=3;i<=5;i++)
pinMode(i, INPUT);
for(i=22;i<=28;i++)
pinMode(i,OUTPUT);
}

void loop()
{
int valx,valy;
int i;

	while(1)
	{
		valx=analogRead(x); //Read Analog input
		if(valx>1000) 
		digitalWrite(LED_LEFT, HIGH);
		else if(valx<20) 
		digitalWrite(LED_RIGHT,HIGH);
		else
		{ 
		digitalWrite(LED_LEFT, LOW);
		digitalWrite(LED_RIGHT, LOW);
		}
		
		valy=analogRead(y);
		if(valy>1000) 
		digitalWrite(LED_BOTTOM, HIGH);
		else if(valy<20) 
		digitalWrite(LED_TOP,HIGH);
		else
		{ 
		digitalWrite(LED_BOTTOM, LOW);
		digitalWrite(LED_TOP, LOW);
		}
		
		if(digitalRead(button_A)==0)    //Check Button A
     {
         digitalWrite(LED_A, HIGH);   // Set LED on
     }
		else 
			digitalWrite(LED_A,LOW);
		
		if(digitalRead(button_B)==0)   //Check Button B
     {
         digitalWrite(LED_B, HIGH);    // Set LED Off
     }
		else 
			digitalWrite(LED_B,LOW);   
			  
		if(digitalRead(button_C)==0)   //Check Button C
     {
         digitalWrite(LED_C, HIGH);    // Set LED off
     }
		else 
			digitalWrite(LED_C,LOW); 
  } 
}