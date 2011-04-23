//
//
//
//





/****************************************************************************/
/*      				  Pinguino Program 					*/
/****************************************************************************/

//
//
unsigned char sensor1[8];
//
//

void setup()
{
//
//
pinmode(10,OUTPUT);
digitalwrite(10,HIGH);
//
serial_init(9600);
}

void loop()
{
//
//
//
/*
unsigned char i;

memcpy(sensor1,readid(),8);
for (i=0;i<8;i++) 
	{
	serial_write(sensor1[i],DEC);
	serial_write(" ");
	}
serial_write("\n");
*/
//
//
//
//
//
//
//
/*
unsigned int temp;
touchcommand(sensor1,cnv);		// start a conversion
Delayms(750);					// for 12 bits resolution
//
//
touchcommand(sensor1,readt);
//
//
temp=(touchMEM[1]*256)+touchMEM[0];
serial_write(temp,DEC);
serial_write("\n");
//
//
*/
//
//
//
//
//
//
//
/*
touchMEM[0]=0xFF;
touchMEM[1]=0xFF;
touchMEM[2]=0x3F;		// 10 bits mode, resolution 0,25°C conversion time 187,5 mS

touchcommand(sensor1,writeMEM);

//
//
//

touchcommand(capteur1,copyMEM);

//

touchcommand(capteur1,RECALL);

//
//
//
//
*/

}


