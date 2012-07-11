// Simple serial test
// Jean-Pierre Mandon 2010

int caractere;
void setup()
{
pinMode(7,OUTPUT);
pinMode(8,OUTPUT);
pinMode(9,OUTPUT);
Serial.begin(9600);
Serial.printf("Hi I AM PINGUINO");
}

void loop()
{
digitalWrite(7,LOW);
digitalWrite(8,LOW);
digitalWrite(9,LOW);
while(1)
{
if (Serial.available()) 
	{
	 caractere=Serial.read(); 
    Serial.print(caractere); 
    if (caractere=='A') 
    digitalWrite(7,digitalRead(7)^1);
    if (caractere=='B') 
    digitalWrite(8,digitalRead(8)^1);
    if (caractere=='C') 
    digitalWrite(9,digitalRead(9)^1); 
	}
}
}