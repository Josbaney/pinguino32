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
//


void setup()
{
  srand(127);
//
  InitLCD(LANDSCAPE);
}

int rnd(int num) {
	return (int)(rand()%num);
}

void loop()
{
  int buf[318];
  int x, x2;
  int y, y2;
  int r, i;

//
  fillScr(255, 255, 255);
  drawBitmap (5, 50, 313, 132, pinguino, 1);
  Delayms(5000);
  
//
  clrScr();
  
  setColor(255, 0, 0);
  fillRect(0, 0, 319, 13);
  setColor(64, 64, 64);
  fillRect(0, 226, 319, 239);
  setColor(255, 255, 255);
  setBackColor(255, 0, 0);
  print("*** ITDB02 - 240x320 Color Display ***", CENTER, 1, 0);
//
  setColor(255,255,0);
  setBackColor(64, 64, 64);
  print("H.Karlsen/M.Fazzi(Pinguino32X)", LEFT, 227, 0);
  print("(C)2011", RIGHT, 227, 0);
//
//

  setColor(0, 0, 255);
  drawRect(0, 14, 319, 225);

//
  setColor(0, 0, 255);
  setBackColor(0, 0, 0);
  drawLine(159, 15, 159, 224);
  drawLine(1, 119, 318, 119);
  for (i=9; i<310; i+=10)
    drawLine(i, 117, i, 121);
  for (i=19; i<220; i+=10)
    drawLine(157, i, 161, i);

//

  setColor(0,255,255);
  print("Sin", 5, 15, 0);
  for (i=1; i<318; i++)
  {
    drawPixel(i,119+(sinf(((i*1.13)*3.14)/180)*95));
  }
  
  setColor(255,0,0);
  print("Cos", 5, 27, 0);
  for (i=1; i<318; i++)
  {
    drawPixel(i,119+(cosf(((i*1.13)*3.14)/180)*95));
  }

  setColor(255,255,0);
  print("Tan", 5, 39, 0);
  for (i=1; i<318; i++)
  {
    drawPixel(i,119+(tanf(((i*1.13)*3.14)/180)));
  }

  Delayms(2000);

//

  setColor(0,0,0);
  fillRect(1,15,318,224);
  setColor(0, 0, 255);
  setBackColor(0, 0, 0);
  drawLine(159, 15, 159, 224);
  drawLine(1, 119, 318, 119);

//

  x=1;
  for (i=1; i<(318*20); i++) 
  {
    x++;
    if (x==319)
      x=1;
    if (i>319)
    {
      if ((x==159)||(buf[x-1]==119))
        setColor(0,0,255);
      else
        setColor(0,0,0);
      drawPixel(x,buf[x-1]);
    }
    setColor(0,255,255);
    y=119+(sinf(((i*1.1)*3.14)/180)*(90-(i / 100)));
    drawPixel(x,y);
    buf[x-1]=y;
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

//
  for (i=1; i<6; i++)
  {
    switch (i)
    {
      case 1:
        setColor(255,0,255);
        break;
      case 2:
        setColor(255,0,0);
        break;
      case 3:
        setColor(0,255,0);
        break;
      case 4:
        setColor(0,0,255);
        break;
      case 5:
        setColor(255,255,0);
        break;
    }
    fillRect(70+(i*20), 30+(i*20), 130+(i*20), 90+(i*20));
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

//
  for (i=1; i<6; i++)
  {
    switch (i)
    {
      case 1:
        setColor(255,0,255);
        break;
      case 2:
        setColor(255,0,0);
        break;
      case 3:
        setColor(0,255,0);
        break;
      case 4:
        setColor(0,0,255);
        break;
      case 5:
        setColor(255,255,0);
        break;
    }
    fillRoundRect(190-(i*20), 30+(i*20), 250-(i*20), 90+(i*20));
  }
  
  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

//
  for (i=1; i<6; i++)
  {
    switch (i)
    {
      case 1:
        setColor(255,0,255);
        break;
      case 2:
        setColor(255,0,0);
        break;
      case 3:
        setColor(0,255,0);
        break;
      case 4:
        setColor(0,0,255);
        break;
      case 5:
        setColor(255,255,0);
        break;
    }
    fillCircle(100+(i*20),60+(i*20), 30);
  }
  
//
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

//

  setColor (255,0,0);
  for (i=15; i<224; i+=5)
  {
    drawLine(1, i, (i*1.44)-10, 224);
  }
  setColor (255,0,0);
  for (i=224; i>15; i-=5)
  {
    drawLine(318, i, (i*1.44)-11, 15);
  }
  setColor (0,255,255);
  for (i=224; i>15; i-=5)
  {
    drawLine(1, i, 331-(i*1.44), 15);
  }
  setColor (0,255,255);
  for (i=15; i<224; i+=5)
  {
    drawLine(318, i, 330-(i*1.44), 224);
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,225);

//
  for (i=0; i<100; i++)
  {
    setColor(rnd(255), rnd(255), rnd(255));
    x=32+rnd(256);
    y=45+rnd(146);
    r=rnd(30);
    drawCircle(x, y, r);
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

//
  for (i=0; i<100; i++)
  {
    setColor(rnd(255), rnd(255), rnd(255));
    x=2+rnd(316);
    y=16+rnd(207);
    x2=2+rnd(316);
    y2=16+rnd(207);
    drawRect(x, y, x2, y2);
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

//
  for (i=0; i<100; i++)
  {
    setColor(rnd(255), rnd(255), rnd(255));
    x=2+rnd(316);
    y=16+rnd(207);
    x2=2+rnd(316);
    y2=16+rnd(207);
    drawRoundRect(x, y, x2, y2);
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

  for (i=0; i<100; i++)
  {
    setColor(rnd(255), rnd(255), rnd(255));
    x=2+rnd(316);
    y=16+rnd(209);
    x2=2+rnd(316);
    y2=16+rnd(209);
    drawLine(x, y, x2, y2);
  }

  Delayms(2000);
  
  setColor(0,0,0);
  fillRect(1,15,318,224);

  for (i=0; i<10000; i++)
  {
    setColor(rnd(255), rnd(255), rnd(255));
    drawPixel(2+rnd(316), 16+rnd(209));
  }

  Delayms(2000);

  fillScr(0, 0, 255);
  setColor(255, 0, 0);
  fillRoundRect(80, 70, 239, 169);
  
  setColor(255, 255, 255);
  setBackColor(255, 0, 0);
  print("That's it!", CENTER, 93, 0);
  print("Restarting in a", CENTER, 119, 0);
  print("few seconds...", CENTER, 132, 0);
  
  setColor(0, 255, 0);
  setBackColor(0, 0, 255);
  print("Runtime: (msecs)", CENTER, 210, 0);
  printNumI(millis(), CENTER, 225);
  
  Delayms (10000);
}



