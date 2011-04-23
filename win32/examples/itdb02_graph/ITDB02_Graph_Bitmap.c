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
//





void setup()
{
  myGLCD.InitLCD(LANDSCAPE);
}

void loop()
{
  int x, y, s;
  
  myGLCD.fillScr(255, 255, 255);
  myGLCD.setColor(255, 255, 255);
  myGLCD.print(" *** A 10 by 7 grid of a 32x32 icon *** ", CENTER, 228, 0);
  for (x=0; x<10; x++)
    for (y=0; y<7; y++)
      myGLCD.drawBitmap (x*32, y*32, 32, 32, info, 1);

  Delayms(5000);
  
  myGLCD.fillScr(255, 255, 255);
  myGLCD.setColor(255, 255, 255);
  myGLCD.print("   Two different icons in scale 1 to 4  ", CENTER, 228, 0);
  x=0;
  for (s=0; s<4; s++)
  {
    x+=(s*32);
    myGLCD.drawBitmap(x, 0, 32, 32, tux, s+1);
  }
  x=0;
  for (s=4; s>0; s--)
  {
    myGLCD.drawBitmap(x, 224-(s*32), 32, 32, icon, s);
    x+=(s*32);
  }

  Delayms(5000);
}



