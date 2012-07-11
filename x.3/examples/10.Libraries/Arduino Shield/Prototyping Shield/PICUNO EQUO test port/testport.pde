
void setup()
{
int i;
for (i=0 ; i<8 ;i++)
pinMode(i, OUTPUT);
}

void loop()
{
int i;
for (i=0; i<8 ;i++)
digitalWrite(i,HIGH);
delay(500);
for (i=0; i<8 ;i++)
digitalWrite(i,LOW);
delay(500);
}