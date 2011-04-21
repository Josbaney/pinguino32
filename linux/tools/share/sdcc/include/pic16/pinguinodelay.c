#ifndef __PINGUDELAY__
#define __PINGUDELAY__
#endif

#ifndef __PINGUINODELAY_H__
#include <pinguinodelay.h>

extern unsigned int microsecs;

void Delayms(unsigned long milliseconde)
{
	unsigned long i;
	
	for (i=0;i<milliseconde;i++) delay120tcy(100);
}


#define Delayus(microseconds) { microsecs = microseconds;\
				delayusecs();}


#endif
