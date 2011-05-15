/*      ----------------------------------------------------------------------------
        FILE:                           i2c.c
        PROJECT:                        pinguino32
        PURPOSE:                        I2C functions
        PROGRAMER:              regis blanchot <rblanchot@gmail.com>
        FIRST RELEASE:  04 mar. 2011
        LAST RELEASE:   11 apr. 2011
        ----------------------------------------------------------------------------
        TODO : slave modes improvement
        ----------------------------------------------------------------------------
        This library is free software; you can redistribute it and/or
        modify it under the terms of the GNU Lesser General Public
        License as published by the Free Software Foundation; either
        version 2.1 of the License, or (at your option) any later version.

        This library is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
        Lesser General Public License for more details.

        You should have received a copy of the GNU Lesser General Public
        License along with this library; if not, write to the Free Software
        Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
        --------------------------------------------------------------------------*/

#ifndef __I2C_C
        #define __I2C_C

        #include <typedef.h>
        #include <const.h>
        #include <macro.h>
        #include <system.c>

        // Mode I2C
        #define I2C_WRITE                                       0
        #define I2C_READ                                        1
        #define I2C_MASTER_MODE                 0
        #define I2C_SLAVE_MODE                  1
        #define I2C_MULTIMASTER_MODE    2
        #define I2C_SLEW_OFF                            0
        #define I2C_SLEW_ON                             1

        // Module I2C
        #define I2C1                    1
        #define I2C2                    2

        /// PROTOTYPES

        void I2C_init(u8,u8,u8);
        u8 I2C_send(u8, u16, u8);
        u8 I2C_get(u8, u16);
        void I2C_sendID(u8, u16, u8);
        u8 I2C_writechar(u8, u8);
        u8 I2C_readchar(u8);
        void I2C_wait(u8);
        void I2C_start(u8);
        void I2C_stop(u8);
        void I2C_restart(u8);
        void I2C_sendNack(u8);
        void I2C_sendAck(u8);

/*      ----------------------------------------------------------------------------
        ---------- Open the I2C bus
        ----------------------------------------------------------------------------
        When the module is enabled it will assume control of the SDAx and SCLx pins.
        The module software need not be concerned with the state of the port I/O of the pins,
        the module overrides, the port state and direction.
        At initialization, the pins are tri-state (released).
        --------------------------------------------------------------------------*/

void I2C_init(u8 module, u8 mode, u8 speed)
{
        u32 pbclk = GetPeripheralClock();

        switch(module)
        {
                case I2C1:
                        // Enables the I2C module and configures the SDA and SCL pins as serial port pins
                        //I2C1CONbits.ON = 1;                                                   // conflict with const.h definition
                        I2C1CON |= (1 << 15);                                                   // Set bit 15
/*
                        switch (mode)
                        {
                                case I2C_SLAVE_MODE:
                                        break;
                                case I2C_MULTIMASTER_MODE:
                                        break;
                                case I2C_MASTER_MODE:
                                default:
                        }
*/
                        switch (mode)
                        {
                                case I2C_SLEW_ON:
                                        I2C1CONbits.DISSLW = 0;                                         // 0 = Slew rate control enabled for High Speed mode (400 kHz)
                                        I2C1BRG = (pbclk / (2 * 400)) - 2;              // 400 kHz
                                        break;
                                case I2C_SLEW_OFF:
                                default:
                                        I2C1CONbits.DISSLW = 1;                                         // 1 = Slew rate control disabled for Standard Speed mode (100 kHz); also disabled for 1 MHz mode
                                        I2C1BRG = (pbclk / (2 * 100)) - 2;              // 100 kHz
                                        //I2C1BRG = (pbclk / (2 * 1000)) - 2    // 1000 kHz = 1MHz
                        }

                        //SetPriorityIntI2C1(I2C_INT_PRI_1|I2C_INT_SUB_PRI_0);
        
                        IFS0bits.I2C1MIF = 0;
                        IFS0bits.I2C1SIF = 0;
                        IFS0bits.I2C1BIF = 0;
        
                        IEC0bits.I2C1MIE = 1;
                        IEC0bits.I2C1SIE = 1;
                        IEC0bits.I2C1BIE = 1;
                        break;

                case I2C2:
                        // Enables the I2C module and configures the SDA and SCL pins as serial port pins
                        //I2C2CONbits.ON = 1;                                                   // conflict with const.h definition
                        I2C2CON |= (1 << 15);                                                   // Set bit 15
/*
                        switch (mode)
                        {
                                case I2C_SLAVE_MODE:
                                        break;
                                case I2C_MULTIMASTER_MODE:
                                        break;
                                case I2C_MASTER_MODE:
                                default:
                        }
*/
                        switch (mode)
                        {
                                case I2C_SLEW_ON:
                                        I2C2CONbits.DISSLW = 0;         // 0 = Slew rate control enabled for High Speed mode (400 kHz)
                                        I2C2BRG = (pbclk / (2 * 400)) - 2;      // 400 kHz
                                        break;
                                case I2C_SLEW_OFF:
                                default:
                                        I2C2CONbits.DISSLW = 1;         // 1 = Slew rate control disabled for Standard Speed mode (100 kHz); also disabled for 1 MHz mode
                                        I2C2BRG = (pbclk / (2 * 100)) - 2;      // 100 kHz
                                        //I2C2BRG = (pbclk / (2 * 1000)) - 2    // 1000 kHz = 1MHz

                        }

                        //SetPriorityIntI2C1(I2C_INT_PRI_1|I2C_INT_SUB_PRI_0);
        
                        IFS1bits.I2C2MIF = 0;
                        IFS1bits.I2C2SIF = 0;
                        IFS1bits.I2C2BIF = 0;
        
                        IEC1bits.I2C2MIE = 1;
                        IEC1bits.I2C2SIE = 1;
                        IEC1bits.I2C2BIE = 1;
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Send a byte to the slave
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

u8 I2C_send(u8 module, u16 adress, u8 byte)
{
        I2C_sendID(module, adress, I2C_WRITE);
        if (I2C_writechar(module, byte) == 0) return (0);
        I2C_stop(module);
        return (1);
}

/*      ----------------------------------------------------------------------------
        ---------- Get a byte from slave
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

u8 I2C_get(u8 module, u16 adress)
{
        u8 byte;

        I2C_sendID(module, adress, I2C_READ);
        I2C_restart(module);
        if (I2C_writechar(module, adress) == 0) return (0);
        byte = I2C_readchar(module);
        I2C_sendNack(module);
        I2C_stop(module);
        return (byte);
}

/*      ----------------------------------------------------------------------------
        ---------- Send the start condition, device address and r/w indication
        ----------------------------------------------------------------------------
        TODO:
                Sending a 10-bit device address involves sending 2 bytes to the slave. The first byte contains
                5 bits of the I2C device address reserved for 10-Bit Addressing modes and 2 bits of the 10-bit
                address. Because the next byte, which contains the remaining 8 bits of the 10-bit address, must
                be received by the slave, the R/W bit in the first byte must be ‘0’, indicating master transmission
                and slave reception. If the message data is also directed toward the slave, the master can con-
                tinue sending the data. However, if the master expects a reply from the slave, a Repeated Start
                sequence with the R/W bit at ‘1’ will change the R/W state of the message to a read of the slave.
        rw
                I2C_WRITE or 0
                I2C_READ or 1
        ----------------------------------------------------------------------------
        If the device is busy then it resends until accepted
        --------------------------------------------------------------------------*/

void I2C_sendID(u8 module, u16 DeviceID, u8 rw)
{         
        u8 byte1, byte2;

        switch(module)
        {
                case I2C1:
                        if (DeviceID > 0x00FF)
                        {         
                                I2C1CONbits.A10M = 1;                           // 1 = I2CxADD is a 10-bit slave address
                                //byte1 = 
                                //byte2 = 
                                I2C_start(module);
                                while (I2C_writechar(module, DeviceID | rw) != 1)
                                        I2C_restart(module);
                        }
                        else
                        {         
                                I2C1CONbits.A10M = 0;                           // 0 = I2CxADD is a 7-bit slave address
                                I2C_start(module);
                                while (I2C_writechar(module, DeviceID | rw) != 1)
                                        I2C_restart(module);
                        }
                        break;
                case I2C2:
                        if (DeviceID > 0x00FF)
                        {         
                                I2C2CONbits.A10M = 1;                           // 1 = I2CxADD is a 10-bit slave address
                                //byte1 = 
                                //byte2 = 
                                I2C_start(module);
                                while (I2C_writechar(module, DeviceID | rw) != 1)
                                        I2C_restart(module);
                        }
                        else
                        {         
                                I2C2CONbits.A10M = 0;                           // 0 = I2CxADD is a 7-bit slave address
                                I2C_start(module);
                                while (I2C_writechar(module, DeviceID | rw) != 1)
                                        I2C_restart(module);
                        }
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Send byte and return ack bit
        ----------------------------------------------------------------------------
        1 = Ack
        0 = NAck
        --------------------------------------------------------------------------*/

u8 I2C_writechar(u8 module, u8 byte)
{
        switch(module)
        {
                case I2C1:
                        I2C1TRN = byte;                 // loads the I2CxTRN with the data byte to transmit
                        I2C_wait(module);               // wait for I2CxMIF interrupt at the end of the ninth SCLx clock cycle.
                        return (!I2C1STATbits.ACKSTAT); // the slave responds with an Acknowledge
                case I2C2:
                        I2C2TRN = byte;
                        I2C_wait(module);
                        return (!I2C2STATbits.ACKSTAT);
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Get a byte from the slave
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

u8 I2C_readchar(u8 module)
{
        switch(module)
        {
                case I2C1:
                        I2C1CONbits.RCEN = 1;
                        I2C_wait(module);
                        return (I2C1TRN);
                case I2C2:
                        I2C2CONbits.RCEN = 1;
                        I2C_wait(module);
                        return (I2C2TRN);
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Wait for the module to finish it's last action
        ----------------------------------------------------------------------------
        NB: Master mode only
        --------------------------------------------------------------------------*/

void I2C_wait(u8 module)
{
        switch(module)
        {
                case I2C1:
                        while (IFS0bits.I2C1MIF == 0);  // wait until interrupt request has a occurred
                        IFS0bits.I2C1MIF = 0;                           // clear flag
                        break;
                case I2C2:
                        while (IFS1bits.I2C2MIF == 0);
                        IFS1bits.I2C2MIF = 0;
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- I2C_ start bit
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

void I2C_start(u8 module)
{
        switch(module)
        {
                case I2C1:
                        I2C1CONbits.SEN = 1;
                        I2C_wait(module);
                        break;
                case I2C2:
                        I2C2CONbits.SEN = 1;
                        I2C_wait(module);
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Send stop bit
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

void I2C_stop(u8 module)
{
        switch(module)
        {
                case I2C1:
                        I2C1CONbits.PEN = 1;
                        I2C_wait(module);
                        break;
                case I2C2:
                        I2C2CONbits.PEN = 1;
                        I2C_wait(module);
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Send stop bit
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

void I2C_restart(u8 module)
{
        switch(module)
        {
                case I2C1:
                        I2C1CONbits.RSEN=1;
                        I2C_wait(module);
                        break;
                case I2C2:
                        I2C2CONbits.RSEN=1;
                        I2C_wait(module);
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Send a Not Acknowledge (NAck) to the slave
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

void I2C_sendNack(u8 module)
{
        switch(module)
        {
                case I2C1:
                        I2C1CONbits.ACKDT = 1;
                        I2C1CONbits.ACKEN = 1;
                        I2C_wait(module);
                        break;
                case I2C2:
                        I2C2CONbits.ACKDT = 1;
                        I2C2CONbits.ACKEN = 1;
                        I2C_wait(module);
                        break;
        }
}

/*      ----------------------------------------------------------------------------
        ---------- Send an Acknowledge (Ack) to the slave
        ----------------------------------------------------------------------------
        --------------------------------------------------------------------------*/

void I2C_sendAck(u8 module)
{
        switch(module)
        {
                case I2C1:
                        I2C1CONbits.ACKDT = 0;
                        I2C1CONbits.ACKEN = 1;
                        I2C_wait(module);
                        break;
                case I2C2:
                        I2C2CONbits.ACKDT = 0;
                        I2C2CONbits.ACKEN = 1;
                        I2C_wait(module);
                        break;
        }
}

/* Found on http://www.microchip.com/forums/download.axd?file=0;515725

void I2C_enable_400(void)
{
        I2C1BRG = 0x05B;//0x00A;
        I2C1ADD = MY_I2C_ADDRESS>>1;
        I2C1MSK = 0x00;
        I2C1CON = 0b1001000011000000;
        
        SetPriorityIntI2C1(I2C_INT_PRI_1|I2C_INT_SUB_PRI_0);
        
        IFS0bits.I2C1MIF=0;
        IFS0bits.I2C1SIF=0;
        IFS0bits.I2C1BIF=0;
        
        IEC0bits.I2C1MIE=1;
        IEC0bits.I2C1SIE=1;
        IEC0bits.I2C1BIE=1;
}

#define __I2C1_ISR __ISR(_I2C_1_VECTOR, ipl1)

void __I2C1_ISR _I2C1Interrupt(void){
        
        I2C_int_task();
        
}

void I2C_int_task(void){
static unsigned char cur_buf_rx=0;
unsigned char tmpbuff;
        if(IFS0bits.I2C1MIF){ // master interrupt
                IFS0bits.I2C1MIF=0;
                if(I2C1STATbits.P){     // verify a stop condition
                        if(i2c_rx_buf[cur_buf_rx].status.locked){       // if a receive is going on, finish it
                                if(i2c_rx_buf[cur_buf_rx].cnt<=74){     // verify maximum packet size
                                        if( i2c_rx_buf[cur_buf_rx].checksum == 0){      // verify is checksum matches
                                                i2c_rx_buf[cur_buf_rx].status.rx_ok=1;  // assert the reception ok flag
                                                i2c_rx_buf[cur_buf_rx].size = i2c_rx_buf[cur_buf_rx].cnt-1;
                                        }
                                        else{   // if checksum is wrong
                                                i2c_rx_buf[cur_buf_rx].status.error=1;  // assert the error flag
                                        }
                                }
                                else{   // if size wrong
                                        i2c_rx_buf[cur_buf_rx].status.error=1;  // assert error flag
                                }
                                i2c_rx_buf[cur_buf_rx].status.locked=0; // release the buffer
                                cur_buf_rx++;   // increments buffer pointer for next reception
                        }
                }
                if(i2c_tx_buf.status.locked){   // verifie if a transmission is in progress
                        if(!i2c_tx_buf.status.tx_address){ // verifie if send the address
                                if(i2c_tx_buf.address==0) I2C1CONbits.GCEN=0;   // disable general call reception if the address is zero (issues happens with this flag enabled)
                                I2C1TRN= i2c_tx_buf.address;    // tx the address
                                i2c_tx_buf.status.tx_address=1; // assert the address transmitted flag
                        }
                        else if( !I2C1STATbits.ACKSTAT ){       // verifie if receive an ack
                                if(!i2c_tx_buf.status.tx_cmd){  // verifie if send the command
                                        I2C1CONbits.GCEN=1;             // reabilita general call
                                        I2C1TRN = i2c_tx_buf.command;   // tx the command
                                        i2c_tx_buf.checksum= i2c_tx_buf.command;        // update checksum
                                        i2c_tx_buf.status.tx_cmd=1;     // assert the command transmitted flag
                                }
                                else if(!i2c_tx_buf.status.tx_chksum){  // verifie if send the checksum
                                        if( i2c_tx_buf.cnt < i2c_tx_buf.size){  // verifie is send all data bytes
                                                I2C1TRN = i2c_tx_buf.data[i2c_tx_buf.cnt];      // send the next data byte
                                                i2c_tx_buf.checksum+=i2c_tx_buf.data[i2c_tx_buf.cnt];   // update checksum
                                                i2c_tx_buf.cnt++;       // increment data pointer
                                        }
                                        else{                                                   // tx the checksum if all data was sent
                                                I2C1TRN = 0 - i2c_tx_buf.checksum;
                                                i2c_tx_buf.status.tx_chksum=1;  // assert the checksum transmitted flag
                                        }
                                }
                                else{   // finalize the transmission wirh succes is sent the checksum correctly
                                        i2c_tx_buf.status.locked=0;
                                        i2c_tx_buf.status.tx_ok=1;
                                        i2c_tx_buf.status.start_tx=0;
                                        i2c_tx_buf.retries=0;
                                        I2C1CONbits.PEN=1;      // start a stop condition
                                }
                        }
                        else{   // if receive an nack, restart the packet transmission
                                I2C1CONbits.GCEN=1;             // enable general call
                                I2C1CONbits.PEN=1;      // stop copndition
                                while(I2C1CONbits.PEN); // wait the stop condition
                                IFS0bits.I2C1MIF=0;     // clear the int flag
                                i2c_tx_buf.status.tx_cmd=0;     
                                i2c_tx_buf.status.tx_address=0;
                                i2c_tx_buf.status.tx_chksum=0;
                                i2c_tx_buf.cnt=0;
                                i2c_tx_buf.retries++;           // increment retries counter
                                if(i2c_tx_buf.retries>=10){     // test if the retries reach 10 times and finalize the transmission with error
                                        i2c_tx_buf.status.locked=0;
                                        i2c_tx_buf.status.start_tx=0;
                                        i2c_tx_buf.status.error=1;
                                        i2c_tx_buf.retries=0;
                                }
                                else{   // if not reah 10 times, generate a start condition
                                        I2C1CONbits.SEN=1;              
                                }       
                        }
                }
                else if(i2c_tx_buf.status.start_tx){ // if not transmitting a packet, verifie if has a queued packet to send
                        if( I2C1STATbits.P || ((!I2C1STATbits.S) && (!I2C1STATbits.P))){ // verifie if bus free
                                i2c_tx_buf.status.locked=1;
                                i2c_tx_buf.cnt=0;
                                i2c_tx_buf.retries=0;
                                i2c_tx_buf.status.error=0;
                                i2c_tx_buf.status.tx_cmd=0;
                                i2c_tx_buf.status.timeout=0;
                                i2c_tx_buf.status.tx_ok=0;
                                i2c_tx_buf.status.tx_address=0;
                                i2c_tx_buf.status.tx_chksum=0;
                                I2C1CONbits.SEN=1;
                        }
                }
        }
        if(IFS0bits.I2C1SIF){ // slave interrupt - stop condition generate a master interrupt? (if yes, finalize the packet in master interrupt)
                IFS0bits.I2C1SIF=0;     
                cur_buf_rx&=0x01;
                if(I2C1STATbits.I2COV){         // verifie for an overflow
                        if( i2c_rx_buf[cur_buf_rx].status.locked ){     // if receiving something, flush the packet
                                i2c_rx_buf[cur_buf_rx].status.locked=0;
                                i2c_rx_buf[cur_buf_rx].status.rx_ok=0;
                                i2c_rx_buf[cur_buf_rx].status.error=0;
                        }
                        tmpbuff=I2C1RCV;
                        I2C1STATbits.I2COV=0;
                        I2C1CONbits.SCLREL=1;   // release the clock
                }
                else{   // if not overflow
                        if( i2c_rx_buf[cur_buf_rx].status.locked && i2c_rx_buf[cur_buf_rx].cnt>=74 ){ // verifie if reach the maximum buffer size and sign an error. Don't read the buffer to force an overflow (to generate nack)
                                i2c_rx_buf[cur_buf_rx].status.error=1;
                                i2c_rx_buf[cur_buf_rx].status.locked=0;
                                cur_buf_rx++;
                                I2C1CONbits.SCLREL=1;   // release the clock
                        }       // if size ok
                        else if(!i2c_rx_buf[cur_buf_rx].status.rx_ok){  // if the current buffer is free
                                tmpbuff=I2C1RCV;        // read the buffer
                                I2C1CONbits.SCLREL=1;   // release the clock
                                if(!I2C1STATbits.D_A){ // verifie if is an address (start of packet)
                                        i2c_rx_buf[cur_buf_rx].status.locked=1; // lock the buffer
                                        i2c_rx_buf[cur_buf_rx].status.recebeu_cmd=0;
                                        i2c_rx_buf[cur_buf_rx].status.error=0;
                                        i2c_rx_buf[cur_buf_rx].status.rx_ok=0;
                                        i2c_rx_buf[cur_buf_rx].status.timeout=0;
                                        i2c_rx_buf[cur_buf_rx].cnt=0;
                                        i2c_rx_buf[cur_buf_rx].address=tmpbuff; // store the address received
                                }
                                else{   // if data
                                        if(!i2c_rx_buf[cur_buf_rx].status.recebeu_cmd){ // verifie if received the command
                                                i2c_rx_buf[cur_buf_rx].command=tmpbuff; // stores the command
                                                i2c_rx_buf[cur_buf_rx].checksum=tmpbuff;        // update checksum
                                                i2c_rx_buf[cur_buf_rx].status.recebeu_cmd=1;    // flag the command receive
                                        }
                                        else{   // if received command, itŽs data
                                                if(i2c_rx_buf[cur_buf_rx].cnt<74){      // verifie the data size
                                                        i2c_rx_buf[cur_buf_rx].data[i2c_rx_buf[cur_buf_rx].cnt++] = tmpbuff;    // store the data
                                                        i2c_rx_buf[cur_buf_rx].checksum += tmpbuff;     // update checksum
                                                }
                                        }
                                }
                        }
                }
        }
        if(IFS0bits.I2C1BIF){ // bus interrupt
                IFS0bits.I2C1BIF=0;
                I2C1STATbits.BCL=0;     // clear the bus colision flag
                if(i2c_tx_buf.status.locked) i2c_tx_buf.status.locked=0;        // release the transmitter buffer (it will retrie to send again later)
                
        }

*/

#endif



