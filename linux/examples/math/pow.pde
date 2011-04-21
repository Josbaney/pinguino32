// power function
// Jean-Pierre Mandon 2010

#include <math.h>

float i,j;
float result;
char chaine[10];

void setup()
{
Serial.begin(9600);
}

void loop()
{
i=45;
j=2;
result=powf(i,j);
if ((result>2024.0)&&(result<2025.0)) 
	{
	Serial.print("OK");
	Serial.print("\n\r");
	}
}