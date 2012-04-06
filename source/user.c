//
//
//
//
//
//
//
//
//
//


//




uchar position=1;

void setup(void)
{
ServoAttach(13);
ServoMaximumPulse(13,2500);  
ServoMaximumPulse(13,500);   
}

void loop(void)
{
ServoWrite(13,position);
Delayms(500);
position++;
if(position>180) position=0;
}

