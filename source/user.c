
void setup()
{
pinmode(9,0);
}

void loop()
{
digitalwrite(9,1);
Delayms(500);
digitalwrite(9,0);
Delayms(500);
}
