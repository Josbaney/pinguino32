/*
 * Controlador de Bordo
 * Integração GPS, GSM/GPRS e OBD2 usando microcontrolador PIC32.
 * Desenvolvido por: Marcus Fazzi
 */






 
//






/*
define COLD_START		"$PSRF101,0,0,0,000,0,0,12,4*10\r\n"
define WARM_START		"$PSRF101,0,0,0,000,0,0,12,2*16\r\n"
define HOT_START		"$PSRF101,0,0,0,000,0,0,12,1*15\r\n"
*/

//




//




//


//



//




unsigned char linha = 10;

/*
 * Dados do GPS
 * GPRMC tipo 5
*/
unsigned char tipo_dado = 0;
unsigned char fixed = 0;
char latitude[10] = "0000.0000";
char NorteSul = 'S';
char longitude[11] = "00000.0000";
char LesteOeste = 'W';

//
unsigned char conectado = 0;


//
unsigned int inicio = 0;

//
void drawnCommands(){
    setBackColor(255,255,255);
	
//
    setColor(255,255,255);
    fillRect(0,80,40,100);
    setColor(0,0,0);
    itdb_print("HOT", 10, 84, 0);
    drawRoundRect(0,80,40,100);
    
//
    setColor(255,255,255);
    fillRect(0,100,40,120);
    setColor(0,0,0);
    itdb_print("WARM", 5, 104, 0);
    drawRoundRect(0,100,40,120);
    
//
    setColor(255,255,255);
    fillRect(0,120,40,140);
    setColor(0,0,0);   
    itdb_print("COLD", 5, 124, 0);
    drawRoundRect(0,120,40,140);
    
    setBackColor(0,0,0);
}

//
void waitForIt(int x1, int y1, int x2, int y2){
  setColor(255,0,0);
  drawRoundRect(x1, y1, x2, y2);
  while (touch_dataAvailable())
 	touch_read();
  setColor(0,0,0);
  drawRoundRect(x1, y1, x2, y2);
}

void printDEBUG(char* texto, char lin, char col){
    setBackColor(255,255,255);
    setColor(0,0,0);
    itdb_print(texto, col*6+45, lin*15, 0);
		    
    setColor(255,255,255);
    setBackColor(0,0,0);
}


unsigned char checkOK(u8 port){
char c, c2;
while(1){
//
	c = SerialRead(port);			
	u5putc(c);
	if(c == 'O'|| c == 'E') {
		c2 = SerialRead(port);
		u5putc(c);
		
		if(c == 'O' && c2 == 'K') {					
			return true;
		}				
		
		if(c2 == 'R'){
			c2 = SerialRead(port);
			u5putc(c2);
			if (c2 == 'R'){
				c2 = SerialRead(port);
				u5putc(c2);
				if (c2 == 'O'){
					c2 = SerialRead(port);
					u5putc(c2);
					if (c2 == 'R'){
						return false;
					}
					else if (c2 == 'K'){
						return true;
					}
				}
			}
		}
	}
//
}
/*while((o = SerialRead(port)) != -1) {
//
}*/
}
 
/*
 * Funções UART4 para PIC32MX795
 */
 
void u5putc(int c){
	while (U3BSTAbits.UTXBF); 
	U3BTXREG = c;
}

char u5getc(){
	while(!U3BSTAbits.URXDA); 
	return U3BRXREG;
}

void u5setup(){
//
//
	U3BBRG  = 259;
	U3BMODE = SETENB;
	U3BSTA  = SETSTA;
}

/**
 *	Bluetooth setup 
 *  MAC 00:0D:18:A0:00:70
 */
void setBluetooth(){
//
	SerialPrintf(BLUETOOTH, "\r\n+STWMOD=1\r\n");						
//
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n+STBD=9600\r\n");						
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n+STNA=Controlador_de_Bordo\r\n");		
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n+STAUTO=1\r\n");						
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n+STOAUT=1\r\n");						
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n +STPIN=0000\r\n");					
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n+LOSSRECONN=1\r\n");					
	Delayms(125);
}

void openBluetooth(){
	printDEBUG("CONECTANDO BLUETOOTH.    ", 3, 0);
	SerialPrintf(BLUETOOTH, "\r\n+INQ=1\r\n");							
	Delayms(125);
	SerialPrintf(BLUETOOTH, "\r\n+CONN=40,FC,89,7A,18,F1\r\n");		
//
	Delayms(125);
	
}

/**
 * Carrega imagem do mapa
 * Params.: lt -> latitude, ltp -> N ou S, lo -> longitude, lop -> W ou E, z -> zoom, s -> tamanho, t -> tipo mapa
 *          debug 0, 1 ou 2  .... 0 -> padrão/mostra dados, 1 -> mostra mapa, 2 -> mostra mapa e dados
 * Link na web: http:
 * Tamanho de 500K bytes 355x240
 */
void loadGoogleMap(){
int cnt = 0, i = 0;

char c = 0, ini = 0;
char hexa[5] = "";

char str[sDATA+1] = "";
//
//
//
/**
AT+CIPMUX=0
AT+CSTT="gprs.oi.com.br","oi","oi"
AT+CIICR
AT+CIFSR
AT+CDNSCFG="8.8.8.8","8.8.4.4"
AT+CIPSTART="TCP","fazzi.eng.br",80
*/

printDEBUG("CONECTANDO AO GPRS...    ", 3, 0);
digitalwrite(DATALED, LOW);
//
SerialPrintf(GPRS, "ATE1\r\n");
Delayms(250);

/**
##################  Método HTTP, com a FW 1137B09 #######################
AT+SAPBR=3,1,"APN","gprs.oi.com.br"
AT+SAPBR=1,1 
AT+SAPBR=2,1
AT+HTTPINIT
AT+HTTPPARA="CID",1
AT+HTTPPARA="URL","http:
AT+HTTPACTION=0
AT+HTTPREAD
*/
//
SerialFlush(GPRS);
SerialPrintf(GPRS, "AT+CIPSHUT\r\n"); 
checkOK(GPRS);
SerialPrintf(GPRS, "AT+SAPBR=0,1\r\n"); 
checkOK(GPRS);
SerialPrintf(GPRS, "AT+CIPMUX=0\r\n"); 
checkOK(GPRS);
SerialPrintf(GPRS, "AT+SAPBR=3,1,\"APN\",\"gprs.oi.com.br\"\r\n");
checkOK(GPRS);
SerialPrintf(GPRS, "AT+SAPBR=1,1\r\n");
checkOK(GPRS);
//
//
SerialPrintf(GPRS, "AT+HTTPINIT\r\n"); 
checkOK(GPRS);
SerialPrintf(GPRS, "AT+HTTPPARA=\"CID\",1\r\n");
checkOK(GPRS);
SerialPrintf(GPRS, "AT+HTTPPARA=\"URL\",\"http:\/\/fazzi.eng.br\/pinguino\/gps\/gmaps2pinguino.php?lt=0&lo=0&ltp=S&lop=W&s=10x10\"\r\n");
checkOK(GPRS);

printDEBUG("CONECTANDO HTTP...       ", 3, 0);
SerialPrintf(GPRS, "AT+HTTPACTION=0\r\n");
checkOK(GPRS);
//
//

//
linha = 0;
clrScr();
//
//
/*while (1){
	for(i=0; i<80; i++){
		c = SerialRead(GPRS);		
		toggle(BLUELED);

		if(c>31 && c < 127) {
		    str[i] = c;		    
		    if (c == ','){ 
				i = 0;
				cnt++;				
				printDEBUG("VG:", 0, 30);
				printNumI(cnt, 320, 0);
			}				
		}
		else if (c == '\n'){ 
		    break;
		}
		else
		    continue;
//
		
		if(ini == 1){		
			if(!strcmp(str,"$FIM")){ 
				printDEBUG("FIM DO DOWNLOAD...       ", 3, 0);
				SerialPrintf(GPRS, "AT+CIPCLOSE\r\n");
				ini = 0;
				break;
			}
		}	
		else if(!strcmp(str,"$INI")){ 
			printDEBUG("INICIANDO DOWNLOAD...    ", 3, 0);
			ini = 2;
			continue;
		}
	}
	
//
	
	setBackColor(0,0,0);
    setColor(255,255,255);
    itdb_print(str, 0, linha*15, 0);

    for(i=0;i<sDATA;i++) str[i] = '\0';

    linha++;
    if (linha > 16){
//
//
//
//
	    linha = 0;
    }
	
  }
  */
  while (digitalread(USERBUTTON)) {
	  toggle(DATALED);
	  Delayms(125);
  }
  while (!digitalread(USERBUTTON));
  digitalwrite(DATALED, LOW);
  Delayms(125);
}

void setup() {
//
//
	SerialConfigure(GPRS, UART_ENABLE, UART_RX_TX_ENABLED, 9600);

//
	SerialConfigure(BLUETOOTH, UART_ENABLE, UART_RX_TX_ENABLED, 9600);

//
	SerialConfigure(GPS, UART_ENABLE, UART_RX_TX_ENABLED, 9600);

	touch_setTouch(56,57,58,59,60); 
	touch_initTouch(LANDSCAPE);
	touch_setPrecision(PREC_MEDIUM);

	InitLCD(LANDSCAPE);
	clrScr();

	fontSize(FONT_SMALL);
  
//
	fillScr(255, 255, 255);
  
//
	drawnCommands() ;
  
//
	setColor(0,0,0);
	fillRect(0,150,400,240);
	
//
	setColor(255,255,255);
	itdb_print("Connecting to GPS module, C3-370C...", 0, 150, 0);
   
	Delayms(1000);
//
   
//
	linha = 10;
	
//
	pinmode(BLUELED, OUTPUT);
	pinmode(REDLED,  OUTPUT);
	pinmode(USERLED, OUTPUT);
	pinmode(DATALED, OUTPUT);
	
//
	digitalwrite(REDLED,  LOW);
	digitalwrite(BLUELED, LOW);
	digitalwrite(USERLED, LOW);
	digitalwrite(DATALED, LOW);
	
//
	u5setup();
	
//
	setBluetooth();
//
	openBluetooth();
			
//
	inicio = millis();
}

void loop() {
    char str[LINHA] = "";
    char hora[10] = "";
    char data[10] = "";
    char ctmp[2] = "";
    char tmp[3] = "";
    int x, y, i, k = 0;
    int t = 0, t2 = 0;	
    char c = 0;
    char campo = 0;
    
    int pos = 0; 
    int posa = 0;
    
    linha = linha < 10? 10: linha;
    
    str[LINHA-1] = '\0';
//
//
    
    if(touch_dataAvailable()){
	touch_read();
	x = touch_getX();
	y = touch_getY();
	
	if(x<45 && y<240){ 
	    if ((y>80) && (y<=100)){ 
		waitForIt(0,80,40,100);
		SerialPrintf(GPS, GPS_HOT_START);
		printDEBUG("HOT STARTING...          ", 3, 0);
	    }

	    if ((y>100) && (y<=120)){ 
		waitForIt(0,100,40,120);
		SerialPrintf(GPS, GPS_WARM_START);
		printDEBUG("WARM STARTING...         ", 3, 0);
	    }
	    
	    if ((y>120) && (y<=140)){ 
		waitForIt(0,120,40,140);
		SerialPrintf(GPS, GPS_COLD_START);
		printDEBUG("COLD STARTING...         ", 3, 0);
	    }
	}
    }

/**
 * @Descrição: Protocolo NMEA/GPS
 * GGA Time, position and fix type data.
 * GLL Latitude, longitude, UTC time of position fix and status.
 * GSA GPS receiver operating mode, satellites used in the position solution, and DOP values.
 * GSV The number of GPS satellites in view satellite ID numbers, elevation, azimuth, and SNR values
 * RMC Time, date, position, course and speed data.
 * VTG Course and speed information relative to the ground.
 * 150 OK to send message.
 */

	for(i=0; i<LINHA-1;){
		c = SerialRead(GPS);	
		if(c>31 && c < 127) {
		    str[i] = c;
		    i++;		    
		}
		else if (c == '\n'){ 
		    break;
		}
		else
		    continue;
		
		
		if (i == 6){ 
		    printDEBUG(str, 1, 0);
	    
		    if(!strcmp(str,"$GPGGA")){
//
			tipo_dado = 1;
		    }
	    
		    if(!strcmp(str,"$GPGLL")){
//
			tipo_dado = 2;
		    }
	    
		    if(!strcmp(str,"$GPGSA")){
//
			tipo_dado = 3;
		    }
	    
		    if(!strcmp(str,"$GPGSV")){
//
			tipo_dado = 4;
		    }
	    
		    if(!strcmp(str,"$GPRMC")){
//
			tipo_dado = 5;
		    }
	    
		    if(!strcmp(str,"$GP150")){
//
			tipo_dado = 6;
		    }
		}
		
		
		if (tipo_dado != 0 && c == ','){
		    campo++;
		    posa = pos;
		    pos  = i;	    		    
		    printNumI(campo, 320, 5);
		}
		
//
		if(tipo_dado == 5){
		    if(campo == 2){ 
//
//
//
			 
//
			strncpy(tmp, str + posa, 2); 
			
//
			t = atoi(tmp);
			t2 = t + GMT;
					    
			if (t2<0)
				t +=  24 + GMT;
			else if (t2>23)
				t = t2 - 24;
			else
				t+= GMT;
			
//
			sprintf(tmp, "%d", t); 
			if (t < 10){			
			    tmp[0] = '0';
			    tmp[2] = '\0';
			}
			    
			strcat(hora, tmp);			
			strcat(hora, ":");
			
			strncpy(tmp, str + posa + 2, 2); 
			strcat(hora, tmp);
			strcat(hora, ":");
			
			strncpy(tmp, str + posa + 4, 2); 
			strcat(hora, tmp);
//
						
			printDEBUG(hora, 4, 0);
			SerialPrintf(BLUETOOTH, "%s\r\n", hora);
			hora[0] = '\0';
		    }
		    
//
		    if(campo == 3){ 
			strncpy(ctmp, str + posa, 1);
//
//
			if(!strcmp(ctmp, "A")){
			    fixed = 1;
			    printDEBUG("FIXED    ", 6, 0);
			    digitalwrite(REDLED, HIGH);
			}
			else {
			    fixed = 0;
			    printDEBUG("NOT FIXED", 6, 0);
			    digitalwrite(REDLED, LOW);
			}		    
		    }
		    
//
		    if(campo == 4){
				strncpy(latitude, str + posa, 9);
				printDEBUG("LATITUDE:  ", 7, 0);
				printDEBUG(latitude, 7, 13);
				SerialPrintf(BLUETOOTH, "LAT: %s\r\n", latitude);
		    }
		    
		    
//
		    if(campo == 5){
				strncpy(ctmp, str + posa, 1);		    
				printDEBUG(ctmp, 7, 27);		    
		    }
		    
//
		    if(campo == 6){
				strncpy(longitude, str + posa, 10);
				printDEBUG("LONGITUDE: ", 8, 0);
				printDEBUG(longitude, 8, 13);
				SerialPrintf(BLUETOOTH, "LONG: %s\r\n", longitude);    
		    }
		    
		    
//
		    if(campo == 7){
				strncpy(ctmp, str + posa, 1);		    
				printDEBUG(ctmp, 8, 27);		    
		    }
		    
//
		    if(campo == 10){ 
//
			
//
			strncpy(tmp, str + posa, 2); 
			
//
			t = atoi(tmp);
//
			if (t2<0)
				t--;
			else if (t2>23)
				t++;
				
//
//
					
			sprintf(tmp, "%d", t); 
			strcat(data, tmp);
			strcat(data, "/");
			
			strncpy(tmp, str + posa + 2, 2); 
			strcat(data, tmp);
			strcat(data, "/");
			
			strncpy(tmp, str + posa + 4, 2); 
			strcat(data, "20"); 
			strcat(data, tmp);			
			
			printDEBUG(data, 5, 0);
			SerialPrintf(BLUETOOTH, "%s\r\n", data);
			data[0] = '\0';
			
			tipo_dado = 0;
			
		    }
		}
		
		tmp[0] = '\0';
		tmp[1] = '\0';
		tmp[2] = '\0';
	}

    setBackColor(0,0,0);
    setColor(255,255,255);
    itdb_print(str, 0, linha*15, 0);

    for(i=0;i<LINHA-1;i++){
	    str[i] = '\0';
    }

    linha++;
    if (linha > 16){
//
//
	    setColor(0,0,0);
	    fillRect(0,150,400,240);
	    linha = 10;
    }
    
    /*if(!digitalread(USERBUTTON)){
	toggle(REDLED);
	drawBitmap (0, 0, 400, 240, staticmap, 1);
	toggle(REDLED);
	toggle(BLUELED);
	Delayms(3000);
    }*/
    
    if(!digitalread(USERBUTTON)){		
		loadGoogleMap();
//
		fillScr(255, 255, 255);
  
//
		drawnCommands() ;
  
//
		setColor(0,0,0);
		fillRect(0,150,400,240);		
    }

	toggle(USERLED);
}

