//************************************************************************
// This routine takes serial port data and sends it via  USB 
//************************************************************************
// Based on coding by Thorsten Klose

#include <uart18f2550.c>

void midi_receive_handler(midi_rec midix)
{
	static unsigned char mybyte, n;
	unsigned char bytecount;
	unsigned char in1buf[4];

	// Is there something in the serial inbuffer and is USB input stream available?
	if( ((BDT[EP1IN].EPStat & 0x80) == 0) && (n=serial_rxbytes()) )
	{
		mybyte = serial_read();  // get char from input buffer
		
		if( mybyte & 0x80 ) // new MIDI status byte?
		{
			if( mybyte < 0xf8 )// is byte < f8 (sysex end or less)
			{
				midi.running_status = mybyte; // store running status
				midi.expected_bytes = expected_bytes_common[(mybyte >> 4) & 0x7]; // look up expected bytes
				if( midi.expected_bytes==0 ) // System Message, take number of bytes from expected_bytes_system[] array
				{
					midi.expected_bytes = expected_bytes_system[mybyte & 0xf]; // look up expected bytes
					if( mybyte == 0xf0 )
					{
						midi.byte0 = 0xf0; // sysex begin
						midi.sysex_ctr = 0x01;
					}
					else if( mybyte == 0xf7 ) // sysex end
					{
						switch( midi.sysex_ctr )
						{
							case 0:
								in1buf[0] = (midi.cable << 4) | 0x05; // 5: SysEx ends with single byte
								in1buf[1] = 0xf7;
								in1buf[2] = 0x00;
								in1buf[3] = 0x00;
								break;
	                            
							    case 1:
								in1buf[0] = (midi.cable << 4) | 0x06; // 6: SysEx ends with two bytes
								in1buf[1] = midi.byte0;
								in1buf[2] = 0xf7;
								in1buf[3] = 0x00;
								break;
								
							    default:
								in1buf[0] = (midi.cable << 4) | 0x07; // 7: SysEx ends with two bytes
								in1buf[1] = midi.byte0;
								in1buf[2] = midi.byte1;
								in1buf[3] = 0xf7;
							
						}
				
						if (ConfiguredUSB()) // only access EP1 if configured
                			while (PutEP1(4,in1buf)==0) ;  // send via usb					
						midi.sysex_ctr = 0x00; // ensure that next F7 will just send F7
				    }
				}
				midi.wait_bytes = midi.expected_bytes;
			}  
			else // byte not less than f8 (realtime messages)
			{
	
		// Realtime messages don't change the running status and can be sent immediately
				in1buf[0] = (midi.cable << 4) | 0x0f;
				in1buf[1] = mybyte;
				in1buf[2] = 0;
				in1buf[3] = 0;
				if (ConfiguredUSB()) // only access EP1 if configured
                while (PutEP1(4,in1buf)==0) ;  // send via usb
			}
		}  
		else // data byte
		{
			if( midi.running_status == 0xf0 ) // part of a sysex message?
			{
				switch( ++midi.sysex_ctr ) // increment byte counter
				{
					case 1:  // load mybyte into proper byte in midi structure
						midi.byte0 = mybyte; 
						break;
					case 2: 
						midi.byte1 = mybyte; 
						break;
					default: // 3
						midi.byte2 = mybyte; 
						// If third byte is loaded then prepare and send packet
						in1buf[0] = (midi.cable << 4) | 0x04; // 4: SysEx starts or continues
						in1buf[1] = midi.byte0;
						in1buf[2] = midi.byte1;
						in1buf[3] = midi.byte2;
						if (ConfiguredUSB()) // only access EP1 if configured
                		    while (PutEP1(4,in1buf)==0) ;  // send via usb
						midi.sysex_ctr = 0x00;	// reset and prepare for next packet
				}
			}
			else // not part of sysex message
			{
				if( midi.wait_bytes==0 ) 
				{
					midi.wait_bytes = midi.expected_bytes - 1; // update wait bytes
				}
				else // wait_bytes !=0
					--midi.wait_bytes;  // decrease wait bytes if not zero
				if( midi.expected_bytes == 1 )
				{
					midi.byte1 = mybyte; // if only one byte was expected store it
					midi.byte2 = 0x00;
				}
				else
				{  // expected_bytes !=1
				   if( midi.wait_bytes==0 ) // if wait bytes = 0 
				      midi.byte2 = mybyte; // store in byte 2
				   else  // if wait_bytes>0
				      midi.byte1 = mybyte; // store in byte 1  
				}
	
				if( midi.wait_bytes==0 ) // is wait bytes = 0 now?
				{
					if( (midi.running_status & 0xf0) != 0xf0 )
					{
	   					in1buf[0] = (midi.cable << 4) | (midi.running_status >> 4); // common MIDI message
					}
					else
					{
						switch( midi.expected_bytes) 
						{
							case 0: 
								in1buf[0] = (midi.cable << 4) | 0x05; // SysEx common with one byte
								break;
							case 1:
								in1buf[0] = (midi.cable << 4) | 0x02; // SysEx common with two bytes
								break;
							default:
								in1buf[0] = (midi.cable << 4) | 0x03; // SysEx common with three bytes
						}
					}
					in1buf[1] = midi.running_status;
					in1buf[2] = midi.byte1;
					in1buf[3] = midi.byte2;
					if (ConfiguredUSB()) // only access EP1 if configured
                    while (PutEP1(4,in1buf)==0) ;  // send via usb
				}
			}
		}
	}
}

