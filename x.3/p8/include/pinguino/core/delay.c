
#ifndef __ARDDELAY__
#define __ARDDELAY__
#ifndef __DELAY_H__
#include <delay.h>
#endif

#include <typedef.h>

void Delayms(u16 milliseconde)
{
	u16 i;
	
	for (i=0;i<milliseconde;i++) delay10ktcy(1);
}

void Delayus(u16 microsecondes)
{
	u16 i;
	
	for (i=0;i<microsecondes;i++);
}

#endif
