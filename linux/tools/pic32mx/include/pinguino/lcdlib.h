#ifndef __LCDLIB_H__
#define __LCDLIB_H__

// commands
#define LCD_CLEARDISPLAY 0x01
#define LCD_RETURNHOME 0x02
#define LCD_ENTRYMODESET 0x04
#define LCD_DISPLAYCONTROL 0x08
#define LCD_CURSORSHIFT 0x10
#define LCD_FUNCTIONSET 0x20
#define LCD_SETCGRAMADDR 0x40
#define LCD_SETDDRAMADDR 0x80

// flags for display entry mode
#define LCD_ENTRYRIGHT 0x00
#define LCD_ENTRYLEFT 0x02
#define LCD_ENTRYSHIFTINCREMENT 0x01
#define LCD_ENTRYSHIFTDECREMENT 0x00

// flags for display on/off control
#define LCD_DISPLAYON 0x04
#define LCD_DISPLAYOFF 0x00
#define LCD_CURSORON 0x02
#define LCD_CURSOROFF 0x00
#define LCD_BLINKON 0x01
#define LCD_BLINKOFF 0x00

// flags for display/cursor shift
#define LCD_DISPLAYMOVE 0x08
#define LCD_CURSORMOVE 0x00
#define LCD_MOVERIGHT 0x04
#define LCD_MOVELEFT 0x00

// flags for function set
#define LCD_8BITMODE 0x10
#define LCD_4BITMODE 0x00
#define LCD_2LINE 0x08
#define LCD_1LINE 0x00
#define LCD_5x10DOTS 0x04
#define LCD_5x8DOTS 0x00

unsigned char _rs_pin; // LOW: command.  HIGH: character.
unsigned char _rw_pin; // LOW: write to LCD.  HIGH: read from LCD. NOT IMPLEMENTED! Connect RW to GND.
unsigned char _enable_pin; // activated by a HIGH pulse.
unsigned char _data_pins[8];

unsigned char _displayfunction;
unsigned char _displaycontrol;
unsigned char _displaymode;

unsigned char _initialized;

unsigned char _numlines,_currline;

void lcd(unsigned char rs, unsigned char enable, unsigned char d0, unsigned char d1, unsigned char d2, unsigned char d3, 
			unsigned char d4, unsigned char d5, unsigned char d6, unsigned char d7);
void init(unsigned char fourbitmode, unsigned char rs, unsigned char rw, unsigned char enable, 
			unsigned char d0, unsigned char d1, unsigned char d2, unsigned char d3,
			unsigned char d4, unsigned char d5, unsigned char d6, unsigned char d7);
void begin(unsigned char lines, unsigned char dotsize);
void noAutoscroll(void);
void autoscroll(void);
void rightToLeft(void);
void leftToRight(void);
void scrollDisplayRight(void);
void scrollDisplayLeft(void);
void blink();
void noBlink();
void cursor();
void noCursor();
void display();
void noDisplay();
void clear();
void home();
void printNumber(unsigned long n, unsigned char base);
void printFloat(float number, unsigned char digits);
void lcdPrint(char *string);
void lcdprintf(char *fmt, ...);
void setCursor(unsigned char col, unsigned char row);
void command(unsigned char value);
void write(unsigned char value);
void send(unsigned char value, unsigned char mode);
void write8bits(unsigned char value);
void write4bits(unsigned char value);
void pulseEnable(void);
#endif
