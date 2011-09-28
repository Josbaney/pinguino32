


























#define BLUETOOTH   UART2
#define DATALED  12
#define ENABLE_UART3
#define GMT -3
#define GPRS        UART1
#define GPS         UART3
#define GPS_COLD_START		"$PSRF104,0,0,0,96000,237759,922,12,4*2E\r\n"
#define GPS_FACTORY_RESET	"$PSRF101,0,0,0,000,0,0,12,8*1C\r\n"
#define GPS_HOT_START		"$PSRF104,0,0,0,96000,237759,922,12,1*2B\r\n"
#define GPS_POWER_SAVE		"$PSRF107,0,400,1000*08\r\n"
#define GPS_WARM_START		"$PSRF104,0,0,0,96000,237759,922,12,2*28\r\n"
#define LINHA 70
#define SETBAUD		9600
#define SETENB 		0x8008
#define SETSTA 		0x1400
#define USERLED  13
#define sDATA 81
#include <delay.c>
#include <digitalw.c>
#include <itdb02/itdb02_graph16w.c>
#include <itdb02/itdb02_touch.c>
#include <millis.c>
#include <serial.c>
#include <string.h>
#include <string.h>
#include <typedef.h>
//#include "staticmap.c"
