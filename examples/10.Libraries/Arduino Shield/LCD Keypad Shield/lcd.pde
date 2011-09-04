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
/*Function available
lcd
lcd.autoscroll
lcd.begin
lcd.blink
lcd.clear
lcd.command
lcd.cursor
lcd.display
lcd.home
lcd.init
lcd.leftToRight
lcd.noAutoscroll
lcd.noBlink
lcd.noCursor
lcd.noDisplay
lcd.print
lcd.printFloat
lcd.printNumber
lcd.rightToLeft
lcd.scrollDisplayLeft
lcd.scrollDisplayRight
lcd.send
lcd.setCursor
lcd.write
*/
//This LCD keypad Shield use Digital Pin 8, 9, 4, 5, 6, 7 for RS, E, D4 ~ D8 and Analog Pin 0 for keypad
//This is the clock program showing hour, min and sec 

#define LED 13

//global vars
float num;

void setup(){
	//8 bits mode
	//lcd(8, 9, 0, 1, 2, 3, 4, 5, 6, 7); // RS, E, D0 ~ D7
	
	//4 bits mode, dont use last four pins ...
	lcd(8, 9, 4, 5, 6, 7, 0, 0, 0, 0); // RS, E, D4 ~ D8	
	
	//LCD format
	lcd.begin(2, 0);
	
	/* Debug */
	pinMode(LED, OUTPUT);		// LED on pin 13	
}

uchar counter = 0;
uchar sec  = 0;
uchar min  = 0;
uchar hour = 0;
int z; 
void loop()
{

	// Output string
	lcd.home();
	lcd.print("PinguinoX2-LCD");	// Output char
	
		
	if (counter>9){
		counter = 0;
		sec++;
	}
	
	if (sec>59){
		sec = 0;
		min++;
	}
	
	if (min>59){
		min = 0;
		hour++;
	}
	
	if (hour>23){
		hour = 0;
	}
	
	
	lcd.setCursor(0, 1);
	
	if (hour < 10)
		lcd.print("0");	
	lcd.printNumber(hour, 10);
	
	if (min < 10)
		lcd.print(":0");
	else
		lcd.print(":");		
	lcd.printNumber(min, 10);
	
	if (sec < 10)
		lcd.print(":0");
	else
		lcd.print(":");
	lcd.printNumber(sec, 10);	
	
	//set hour and min	
	z=analogRead(14);

	if (z>50 && z<200)	//hour++
	{
	hour++;
	delay(50);
	} 
    
	if (z>200 && z<400)	//hour--
	{
	if (hour>0)
	hour--;
	else
	hour = 23;
	delay(50);        
	} 
	
	if (z<50)				//min++
	{
	min++;
	delay(50);
	} 
	
	if (z>400 && z<600)	//min--
	{
	if (min>0)
	min--;
	else
	min = 59;
	delay(50);
	} 
	
	if (z>600 && z<800)	//reset sec
	{
	sec=0;
	delay(50);
	} 
	
	if (z>800)	//nothing
	{
	delay(50);
	} 
	
	counter++;
	
	delay(51); //just a fine tune to get 100ms with this!
	digitalWrite(LED, LOW);
	delay(51);
	digitalWrite(LED, HIGH);	
}
