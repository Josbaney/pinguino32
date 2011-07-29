// Simple serial test
// Jean-Pierre Mandon 2010

char caractere;
char chaine[5]={'T','E','S','T',0};

void setup()
{
Serial.begin(9600);
}

void loop()
{
if (millis()%1000==0) Serial.printf("TEST\n\r");
if (Serial.available()) {
					 Serial.printf("caractere");
					 caractere=Serial.read();
					 Serial.printf(chaine);
					 Serial.printf("%d",caractere);
					 }
}