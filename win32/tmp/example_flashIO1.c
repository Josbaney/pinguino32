// test fonction ReadFlash
// Jean-Pierre MANDON 2008

// put static value to flash memory

__code __at(0x6000) uint boot1[]={0xF000,0xEF89,0xF009,0xEF43,0xF00C,0xEF75,0xF007,0xEFB8};
__code __at(0x6010) uint boot2[]={0xF00B,0xEF50,0xF004,0xEF68,0xF008,0xEF4F,0xF00C,0xEF7C};
__code __at(0x6020) uint boot3[]={0xF006,0xEF7B,0xF00C,0xEF74,0xF00A,0xEF72,0xF005,0xEFC7};
__code __at(0x6030) uint boot4[]={0xF00A,0xEF15,0xF00C,0xEFEE,0xF00B,0xEFD3,0xF00B,0xEF98};

void EraseFlash(unsigned int address)
{
TBLPTRU=0;
TBLPTRH=address>>8;
TBLPTRL=address;
 __asm
bsf     _EECON1, 7
bcf     _EECON1, 6
bsf     _EECON1, 2
bsf     _EECON1, 4
bcf     _INTCON, 7
    movlw   0x55
movwf   _EECON2
movlw   0xaa
movwf   _EECON2
bsf     _EECON1, 1
__endasm;
}

int ReadFlash(unsigned int address)
{
unsigned char high8,low8;
TBLPTRU=0;
TBLPTRH=address>>8;
TBLPTRL=address;
__asm tblrd*+ __endasm;
low8=TABLAT;
__asm tblrd*+ __endasm;
high8=TABLAT;
return((high8<<8)+low8);
}

void WriteFlash(unsigned int destination_add,__data uchar *destination)
{
static uchar i;

TBLPTRU=0;
TBLPTRH=destination_add>>8;
TBLPTRL=destination_add;

 __asm 
tblrd*-
__endasm;
    
for(i = 0; i < 32; i++)
   {
    TABLAT = *destination;
    destination++;
    __asm
        tblwt+*
    __endasm;
   } 

__asm
bsf     _EECON1, 7
bcf     _EECON1, 6
bsf     _EECON1, 2
bcf     _INTCON, 7
    
movlw   0x55
movwf   _EECON2
movlw   0xaa
movwf   _EECON2
bsf     _EECON1, 1
__endasm;

}

void setup()
{
}

void loop()
{
unsigned int i;
unsigned int buffer[16];

// erase 64 byte in flash memory at address 0x5000

EraseFlash(0x0000);

// copy 32 byte from flash memory address 0x6000 to buffer tab

for (i=0;i<32;i+=2) buffer[i/2]=ReadFlash(0x6000+i);

// write 32 byte of buffer tab to flash memory at address 0x5000

WriteFlash(0x0000,buffer[0]);

// copy 32 byte from flash memory address 0x6020 to buffer tab

for (i=0;i<32;i+=2) buffer[i/2]=ReadFlash(0x6020+i);

// write 32 byte of buffer tab to flash memory at address 0x5020

WriteFlash(0x0020,buffer[0]);


while(1);

}
