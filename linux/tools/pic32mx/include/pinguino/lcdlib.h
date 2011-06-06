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
void lcd_init(unsigned char fourbitmode, unsigned char rs, unsigned char rw, unsigned char enable, 
			unsigned char d0, unsigned char d1, unsigned char d2, unsigned char d3,
			unsigned char d4, unsigned char d5, unsigned char d6, unsigned char d7);
void lcd_begin(unsigned char lines, unsigned char dotsize);
void lcd_noAutoscroll(void);
void lcd_autoscroll(void);
void lcd_rightToLeft(void);
void lcd_leftToRight(void);
void lcd_scrollDisplayRight(void);
void lcd_scrollDisplayLeft(void);
void lcd_blink();
void lcd_noBlink();
void lcd_cursor();
void lcd_noCursor();
void lcd_display();
void lcd_noDisplay();
void lcd_clear();
void lcd_home();
void lcd_printNumber(unsigned long n, unsigned char base);
void lcd_printFloat(float number, unsigned char digits);
void lcd_print(char *string);
void lcd_printf(char *fmt, ...);
void lcd_setCursor(unsigned char col, unsigned char row);
void lcd_command(unsigned char value);
void lcd_write(unsigned char value);
void lcd_send(unsigned char value, unsigned char mode);
void lcd_write8bits(unsigned char value);
void lcd_write4bits(unsigned char value);
void lcd_pulseEnable(void);
#endif
