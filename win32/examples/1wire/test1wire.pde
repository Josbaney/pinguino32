// Pinguino example to connect a 1wire sensor
// test made with a 18B20 temperature sensor
// Jean-Pierre Mandon 2010
// Pinguino beta 8-1 unstable version 16/05/2010

#include <1wirelib.c>
#include <string.h>


/****************************************************************************/
/*      				  Pinguino Program 					*/
/****************************************************************************/

// each sensor have a 8 bytes identification
// reserve space to store this identification
unsigned char sensor1[8];
//unsigned char sensor1[8]={40,51,173,128,0,0,0,172};
// this is my sensor number, see below

void setup()
{
// 1 wire must be connected on pin 10
// initialise it as an output and set to HIGH
pinMode(10,OUTPUT);
digitalWrite(10,HIGH);
// Serial is used for debugging
Serial.begin(9600);
}

void loop()
{
// first you must find the sensor identification
// connect a 18B20 on pin 10 and only one
// start this program and check number on the serial terminal
/*
unsigned char i;

memcpy(sensor1,readid(),8);
for (i=0;i<8;i++) 
	{
	Serial.print(sensor1[i],DEC);
	Serial.print(" ");
	}
Serial.print("\n");
*/
// my sensor has number 40,51,173,128,0,0,0,172
// now this number is in the sensor1 array
// It's time to start a temperature conversion
// to achieve this, you must use the write command
// if you have more than one sensor on the bus
// you must first address the sensor
// sensor1[8] is now equal to {40,51,173,128,0,0,0,172}
/*
unsigned int temp;
touchcommand(sensor1,cnv);		// start a conversion
delay(750);					// for 12 bits resolution
							// conversion time is 750 mS
// now read the memory of the sensor
touchcommand(sensor1,readt);
// 8 bytes of the MEM are stored in touchMEM array
// and write the temperature
temp=(touchMEM[1]*256)+touchMEM[0];
Serial.print(temp,DEC);
Serial.print("\n");
// for me temperature was 384 !!
// this is a 12 bits value, it must be multiplied by 0,0625°C
*/
// the resolution of the sensor can be changed to 9,10,11 or 12 bits
// respectivily 0,5°C, 0,25°C, 0,175°C or 0,0625°C
// thus the value is always on 12 bits
// to change this value you must write 3 bytes in the memory of the sensor
// first and second bytes are alarm bytes ( see datasheet )
// third byte is the configuration
// this is an example
/*
touchMEM[0]=0xFF;
touchMEM[1]=0xFF;
touchMEM[2]=0x3F;		// 10 bits mode, resolution 0,25°C conversion time 187,5 mS

touchcommand(sensor1,writeMEM);

// now the value are in RAM
// but not stored in eeprom
// now we will store values in EEPROM

touchcommand(capteur1,copyMEM);

// this command is used to tranfer eeprom area to RAM

touchcommand(capteur1,RECALL);

// be careful, the sensor value must be fixed
// there is sometimes +-2°C of error
// you must fix this with another sensor
// then the value should be OK
*/

}
