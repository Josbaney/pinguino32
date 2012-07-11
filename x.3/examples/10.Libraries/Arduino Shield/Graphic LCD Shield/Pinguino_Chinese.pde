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
LCD_init()  -->Initialize LCD
LCD_clear()	-->clear LCD
LCD_set_XY (X,Y)  -->SET LCD X-axis AND Y-axis POSITION
LCD_write(string)  -->write string
printchar(character)	-->Write 1 character to LCD
LCD_number(number)  -->write decimal number
LCD_draw_bmp_pixel(start X,start Y,image table name,image x-pixel,image y-pixel)  -->draw bmp
LCD_write_chinese(start X, start Y,chinese table name,ch_with,num,line,row)  -->write chinese
*/
//This Graphic LCD Shield shield use Digital Pin 2(SCK),3(MOSI),4(data/command),5(CS),6(RST),7(Backlight) and Analog Pin 0 for 5 degree joystick 
//This program display chinese word
#include <font_6x8.h>
#include <DFrobot_bmp.h>
#include <DFrobot_chinese.h>
#define SPI_CS 5		//5
#define SPI_MOSI 3		//3		
#define SPI_SCK 2		//2
#define LCD_RST 6   //6
#define LCD_DC 4		//4
#define LCD_BL 7		//7
#define putchar(c) printchar(c)
char charsel;
char char_row;
char chardata;
char charpos;
int ddram;

void setup()
{
	pinMode(SPI_CS,OUTPUT);
	pinMode(SPI_MOSI,OUTPUT);
	pinMode(SPI_SCK,OUTPUT);
	pinMode(LCD_RST,OUTPUT);
	pinMode(LCD_DC,OUTPUT);
	pinMode(LCD_BL,OUTPUT);
}	

//////////FUNCTION//////////
//WRITE DATA OR COMMAND
void LCD_write_byte(unsigned char dat,unsigned char dat_type)
{
	unsigned int i;
	digitalWrite(SPI_CS,LOW);
	if (dat_type == 0)
	digitalWrite(LCD_DC,LOW);
	else
	digitalWrite(LCD_DC,HIGH);	
	
	for (i=0;i<8;i++)
		{ 
		if(dat&0x80)
		digitalWrite(SPI_MOSI,HIGH);
		else 
		digitalWrite(SPI_MOSI,LOW);
		
		digitalWrite(SPI_SCK,LOW);
		dat=dat<<1;
		digitalWrite(SPI_SCK,HIGH);
		}
digitalWrite(SPI_CS,HIGH);
}		
//////////////////////////////////////////////////////////////////
//SET LCD X AND Y POSITION
void LCD_set_XY(unsigned char X, unsigned char Y)
  {
    LCD_write_byte(0x40 | Y, 0);		// column
    LCD_write_byte(0x80 | X, 0);         // row
  }
/////////////////////////////////////////////////////////////////
//CLEAR LCD
void LCD_clear(void)
{
	unsigned int i;
	LCD_write_byte(0x0c, 0);			
	LCD_write_byte(0x80, 0);			

	for (i=0; i<504; i++)
	LCD_write_byte(0x00, 1);			
}
//////////////////////////////////////////////////////////////////////
//CLEAR DDRAM
void nokia_clean_ddram(void)
{
LCD_set_XY(0,0);         // 84*6=504      clear LCD
for (ddram=504;ddram>0;ddram--)
{
LCD_write_byte(0x00, 1);
}
}
//////////////////////////////////////////////////////////////////////
//CALL DATA FROM TABLE
void table_to_lcd(void)   
{
if (charsel<0x20)return;
if (charsel>0x7f)return;

for (char_row=0;char_row<5;char_row++) // 5 bytes
{      
 if (charsel<0x39) // use TABLE5
 {
 charpos=(((charsel&0xff)-0x20)*5);
 chardata=TABLE5[(charpos+char_row)];
 }            
 
 else if (charsel<0x50&charsel>0x38) // use TABLE6
 {
 charpos=(((charsel&0xff)-0x39)*5);
 chardata=TABLE6[(charpos+char_row)];
 }            
 
 else if (charsel<0x69&charsel>0x4f) // use TABLE7
 {
 charpos=(((charsel&0xff)-0x50)*5);
 chardata=TABLE7[(charpos+char_row)];
 }            
 
 else if (charsel>0x68)	// use TABLE8
 {
 charpos=(((charsel&0xff)-0x69)*5);
 chardata=TABLE8[(charpos+char_row)];
 }            

LCD_write_byte(chardata, 1);
}
LCD_write_byte(0x00, 1); //spacing
}
///////////////////////////////////////////////////////////////////////
// Write 1 character to LCD
void printchar(byte cvar)               
{
charsel=cvar;
table_to_lcd();
}
//////////////////////////////////////////////////////////////////////////
void LCD_write(char *ptr)
{
	while(*ptr)
	{
	putchar(*ptr++);
	}
}
/////////////////////////////////////////////////////////////////////////
//write chinese word
void LCD_write_chinese(unsigned char X, unsigned char Y,unsigned char *c,unsigned char ch_with,unsigned char num,unsigned char line,unsigned char row) 
{ 
    unsigned char i;
    unsigned char n; 
    LCD_set_XY(X,Y);                             
    for (i=0;i<num;) 
    { 
      for (n=0; n<ch_with*2; n++)              
      {  
          if (n==ch_with)                       
          { 
              if (i==0) LCD_set_XY(X,Y+1); 
              else 
                { 
                  LCD_set_XY((X+(ch_with+row)*i),Y+1); 
                } 
            } 
          LCD_write_byte(c[(i*ch_with*2)+n],1); 
        } 
      i++; 
      LCD_set_XY((X+(ch_with+row)*i),Y); 
    } 
}
//////////////////////////////////////////////////////////////////////////////////////////////
//draw bmp
void LCD_draw_bmp_pixel(unsigned char X,unsigned char Y,unsigned char *map,
                  unsigned char Pix_x,unsigned char Pix_y)
  {
    unsigned int i,n;
    unsigned char row;
    
    if (Pix_y%8==0) row=Pix_y/8;  
      else
        row=Pix_y/8+1;
    
    for (n=0;n<row;n++)
      {
      	LCD_set_XY(X,Y);
        for(i=0; i<Pix_x; i++)
          {
            LCD_write_byte(map[i+n*Pix_x], 1);
          }
        Y++;                       
      }      
  }
///////////////////////////////////////////////////
//WRITE NUMBER TO LCD
void LCD_number(unsigned int number)
{
char check_thousand;
char check_hundred;
unsigned char thousand=0;
unsigned char hundred=0;
unsigned char tenth=0;

thousand=number/1000;
number=number%1000;
hundred=number/100;
number=number%100;
tenth=number/10;
number=number%10;

charsel=thousand+0x30;
if (charsel!=0x30)
{
table_to_lcd();
check_thousand=1;
}
else if (charsel==0x30)
{
check_thousand=0;
}

charsel=hundred+0x30;
if (charsel!=0x30)
{
table_to_lcd();
check_hundred=1;
}
else if (charsel == 0x30)
{
	if (check_thousand == 1)
	{
	table_to_lcd();
	check_hundred=1;
	}
	else 
	check_hundred=0;
}

charsel=tenth+0x30;
if (charsel!=0x30)
{
table_to_lcd();
}
if ((charsel == 0x30) && (check_hundred==1))
{
table_to_lcd();
}

charsel=number+0x30;
table_to_lcd();
}
/////////////////////////////////////////////////////////////////////
//LCD INITIALIZATION 
void LCD_init(void)
{
	digitalWrite(LCD_DC,HIGH);	
	digitalWrite(SPI_CS,HIGH);

	digitalWrite(LCD_RST,LOW);
	delayMicroseconds(1);
	digitalWrite(LCD_RST,HIGH);

	digitalWrite(SPI_CS,LOW);
	delayMicroseconds(1);
	digitalWrite(SPI_CS,HIGH);
	delayMicroseconds(1);

	digitalWrite(LCD_BL,HIGH);

LCD_write_byte(0x21, 0);	
LCD_write_byte(0xc0, 0);	
LCD_write_byte(0x06, 0);	
LCD_write_byte(0x13, 0);	
LCD_write_byte(0x20, 0);
nokia_clean_ddram();	
LCD_clear();	      
LCD_write_byte(0x0c, 0);	
        
digitalWrite(SPI_CS,LOW);
}
///////////////////////////////////////////////////////////
//WRITE YOUR PROGRAM HERE
//MAIN PROGRAM//
char a;
void loop()
{
LCD_init();
LCD_clear();

  for (a=0; a<5; a++)
  {
    digitalWrite(LCD_BL, LOW);
    delay(300);
    digitalWrite(LCD_BL, HIGH);
    delay(300);
  }

LCD_write_chinese(6,3, DFrobot_chinese,12,6,0,0);
	
	while(1)
	{
	LCD_set_XY(0,0);
	LCD_write("I AM PINGUINO");
	}
}