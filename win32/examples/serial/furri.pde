void setup()
{
pinMode(7,0);
Serial.begin(9600);
}

void loop()
{
Serial.print('A');
if (Serial.available())
{
digitalWrite(7,HIGH);
delay(500);
digitalWrite(7,LOW);
delay(500);
}
}