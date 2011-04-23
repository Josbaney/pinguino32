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
Serial.print("TEST\n\r");
if (Serial.available()) {
					 Serial.print("caractere");
					 caractere=Serial.read();
					 Serial.print(&caractere);
					 }
}