/*-----------------------------------------------------------------------
/  PFF - Low level disk interface modlue include file    (C)ChaN, 2009
/-----------------------------------------------------------------------*/

#ifndef _DISKIO_H
#define _DISKIO_H

/* Status of Disk Functions */
typedef unsigned char DSTATUS;

/* Results of Disk Functions */
typedef enum {
	DRES_OK = 0,		/* 0: Function succeeded */
	DRES_ERROR,			/* 1: Disk error */
	DRES_NOTRDY,		/* 2: Not ready */
	DRES_PARERR			/* 3: Invalid parameter */
} DRESULT;

/*---------------------------------------*/
/* Prototypes for disk control functions */
/*---------------------------------------*/

DSTATUS disk_initialize(void);
DRESULT disk_readp(u8*, u32, u16, u16);
DRESULT disk_writep(const u8*, u32);

#define STA_NOINIT		0x01	/* Drive not initialized */
#define STA_NODISK		0x02	/* No medium in the drive */

/* Card type flags (CardType) */
#define CT_MMC				0x01	/* MMC ver 3 */
#define CT_SD1				0x02	/* SD ver 1 */
#define CT_SD2				0x04	/* SD ver 2 */
#define CT_SDC				(CT_SD1|CT_SD2)	/* SD */
#define CT_BLOCK			0x08	/* Block addressing */

#endif
