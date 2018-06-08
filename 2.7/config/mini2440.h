/*
 * (C) Copyright 2002
 * Sysgo Real-Time Solutions, GmbH <www.elinos.com>
 * Marius Groeger <mgroeger@sysgo.de>
 * Gary Jennejohn <gj@denx.de>
 * David Mueller <d.mueller@elsoft.ch>
 *
 * (C) Copyright 2009-2010
 * Michel Pollet <buserror@gmail.com>
 * 
 * Configuation settings for the MINI2440 board.
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#ifndef __CONFIG_H
#define __CONFIG_H

/* If we want to start u-boot directly from within NAND flash
 * Also use this if loading the bootloader directly via JTAG
 * Mote that this is incompatible with NOR booting.
 */
//#define CONFIG_LL_INIT_NAND_ONLY	1

#define CONFIG_S3C2410_NAND_BOOT	1
#define CONFIG_S3C2410_NAND_SKIP_BAD	1

#define CFG_UBOOT_SIZE		0x40000 /* size of u-boot, for NAND loading */

/*
 * High Level Configuration Options
 * (easy to change)
 */
#define CONFIG_ARM920T		1	/* This is an ARM920T Core	*/
#define	CONFIG_S3C2440		1	/* in a SAMSUNG S3C2440 SoC     */
#define CONFIG_MINI2440		1	/* on a MIN2440 Board  */

/*
 * It is possible to have u-boot save it's environment in NOR, however,
 * reember it is incompatible with booting from NAND as the NOR is not
 * available at that point. So use this only if you use nand as storage
 * and will never boot from it
 */
/* #define CONFIG_MINI2440_NOR_ENV		1 */

#define CONFIG_MINI2440_OVERCLOCK 1	/* allow use of frequencies over 405Mhz */

/* input clock of PLL */
#define CONFIG_SYS_CLK_FREQ	12000000	/* MINI2440 has 12.0000MHz input clock */


#define USE_920T_MMU		1
//#define CONFIG_USE_IRQ		1	/* Needed for USB device! */

/*
 * Size of malloc() pool
 */
#define CFG_MALLOC_LEN		(CFG_ENV_SIZE + 2048*1024)
#define CFG_GBL_DATA_SIZE	128	/* size in bytes reserved for initial data */

/*
 * Hardware drivers
 */
#define CONFIG_DRIVER_DM9000		1
#define CONFIG_DRIVER_DM9000_NO_EEPROM	1
#define CONFIG_DM9000_BASE 		0x20000300
#define DM9000_IO 			CONFIG_DM9000_BASE
#define DM9000_DATA			(CONFIG_DM9000_BASE+4)

#define CONFIG_DRIVER_S3C24X0_I2C	1
#if (CONFIG_DRIVER_S3C24X0_I2C)
#define CONFIG_HARD_I2C			1
#define CFG_I2C_SPEED			100000	/* 100kHz */
#define CFG_I2C_SLAVE			0x7f

#define CONFIG_MEGADISPLAY		1
#endif

/*
 * select serial console configuration
 */
#define CONFIG_SERIAL1          1	/* we use SERIAL 1 on MINI2440 */
//#define CONFIG_HWFLOW		1

/************************************************************
 * RTC
 ************************************************************/
#define	CONFIG_RTC_S3C24X0	1

/* allow to overwrite serial and ethaddr */
#define CONFIG_ENV_OVERWRITE

#define CONFIG_BAUDRATE		115200

/***********************************************************
 * Command definition
 ***********************************************************/
#include <config_cmd_default.h>

#undef CONFIG_CMD_FPGA		/* FPGA configuration Support	*/

#undef CONFIG_CMD_CACHE
#undef CONFIG_CMD_DIAG
#undef CONFIG_CMD_ELF

#define CONFIG_CMD_DATE
#define CONFIG_CMD_DHCP
#define CONFIG_CMD_EXT2
#define CONFIG_CMD_FAT
#define CONFIG_CMD_JFFS2
#define CONFIG_CMD_MMC
#define CONFIG_CMD_NAND
#define CONFIG_CMD_PING
#define CONFIG_CMD_PORTIO
#define CONFIG_CMD_REGINFO
#define CONFIG_CMD_SAVES

#if defined(CONFIG_DRIVER_S3C24X0_I2C)
#define CONFIG_CMD_I2C		/* I2C serial bus support	*/
#endif

#define CONFIG_BOOTDELAY	0
// #define CONFIG_BOOTARGS    	"init=/busybox/sbin/init root=/dev/nfs ip=192.168.1.111 nfsroot=192.168.1.16:/rootfs console=ttySAC0,115200"
#define CONFIG_BOOTARGS    	"mini2440=6tb console=ttySAC0,115200"
#define CONFIG_ETHADDR	        08:08:11:18:12:27
#define CONFIG_NETMASK          255.255.255.0
#define CONFIG_IPADDR		192.168.1.111
#define CONFIG_SERVERIP		192.168.1.16

// #define CONFIG_BOOTCOMMAND	"tftp 0x32000000 kernel;bootm 0x32000000"
#define CONFIG_BOOTCOMMAND	"nboot.e kernel;bootm"
// #define CONFIG_BOOTCOMMAND	"bootm"

#define CONFIG_DOS_PARTITION	1

#if defined(CONFIG_CMD_KGDB)
#define CONFIG_KGDB_BAUDRATE	115200		/* speed to run kgdb serial port */
/* what's this ? it's not used anywhere */
#define CONFIG_KGDB_SER_INDEX	1		/* which serial port to use */
#endif

/*
 * Miscellaneous configurable options
 */
#define	CFG_LONGHELP				/* undef to save memory		*/
#define	CFG_PROMPT		"MINI2440 # "	/* Monitor Command Prompt	*/
#define	CFG_CBSIZE		256		/* Console I/O Buffer Size	*/
#define	CFG_PBSIZE (CFG_CBSIZE+sizeof(CFG_PROMPT)+16) /* Print Buffer Size */
#define	CFG_MAXARGS		32		/* max number of command args	*/
#define CFG_BARGSIZE		CFG_CBSIZE	/* Boot Argument Buffer Size	*/

#define CFG_MEMTEST_START	0x30000000	/* memtest works on	*/
#define CFG_MEMTEST_END		0x33F00000	/* 63 MB in DRAM	*/

#undef  CFG_CLKS_IN_HZ		/* everything, incl board info, in Hz */

#define	CFG_LOAD_ADDR		0x32000000	/* default load address	*/

/* the PWM TImer 4 uses a counter of 15625 for 10 ms, so we need */
/* it to wrap 100 times (total 1562500) to get 1 sec. */
#define	CFG_HZ			1562500

/* valid baudrates */
#define CFG_BAUDRATE_TABLE	{ 9600, 19200, 38400, 57600, 115200 }

/*-----------------------------------------------------------------------
 * Stack sizes
 *
 * The stack sizes are set up in start.S using the settings below
 */
#define CONFIG_STACKSIZE	(128*1024)	/* regular stack */
#ifdef CONFIG_USE_IRQ
#define CONFIG_STACKSIZE_IRQ	(8*1024)	/* IRQ stack */
#define CONFIG_STACKSIZE_FIQ	(4*1024)	/* FIQ stack */
#endif

#if 1
#define CONFIG_USB_OHCI_NEW	1
#define CONFIG_CMD_USB		1

#define CFG_USB_OHCI_CPU_INIT	1
#define CFG_USB_OHCI_REGS_BASE	0x49000000 /* S3C24X0_USB_HOST_BASE */
#define CFG_USB_OHCI_SLOT_NAME	"s3c2440"
#define CFG_USB_OHCI_MAX_ROOT_PORTS 	2
#endif

#if 1
#define CONFIG_USB_DEVICE	1
#define CONFIG_USB_TTY		1
#define CONFIG_USB_STORAGE	1
#define CFG_CONSOLE_IS_IN_ENV	1
#define CONFIG_USBD_VENDORID		0x1457	/* FIC */
#define CONFIG_USBD_PRODUCTID_GSERIAL	0x5120	/* gserial */
#define CONFIG_USBD_PRODUCTID_CDCACM	0x511b	/* SMDK2440 CDC ACM */
#define CONFIG_USBD_MANUFACTURER	"MINI2440"
#define CONFIG_USBD_PRODUCT_NAME	"S3C2440 Bootloader " U_BOOT_VERSION
#define CONFIG_USBD_DFU			1
#define CONFIG_USBD_DFU_XFER_SIZE	4096
#define CONFIG_USBD_DFU_INTERFACE	2
//#define CONFIG_USB_DFU_REVISION 0x0100
#endif

/*-----------------------------------------------------------------------
 * Physical Memory Map
 */
#define CONFIG_NR_DRAM_BANKS	1	   /* we have 1 bank of DRAM */
#define PHYS_SDRAM_1		0x30000000 /* SDRAM Bank #1 */
/*
 * startup code now probes, this is no longer needed
 */
//#define PHYS_SDRAM_1_SIZE	0x04000000 /* 64 MB */

#define PHYS_FLASH_1		0x00000000 /* Flash Bank #1 */

/*
 * When booting from NAND, it is impossible to access the lowest addresses
 * due to the SteppingStone being in the way. Luckily the NOR doesn't really
 * care about the highest 16 bits of address, so we set the controlers
 * registers to go and poke over there, instead.
 */
#define CFG_FLASH_BASE		(0x0000 + PHYS_FLASH_1)

/*
 * NOR FLASH organization
 * Now uses the standard CFI interface
 */
#define CFG_FLASH_CFI		1
#define CFG_FLASH_CFI_DRIVER	1
#define CFG_FLASH_CFI_WIDTH	FLASH_CFI_16BIT
#define CFG_MONITOR_BASE	0x0
#define CFG_MAX_FLASH_BANKS	1	/* max number of memory banks */
#define CFG_MAX_FLASH_SECT	512	/* 512 * 4096 sectors, or 32 * 64k blocks */
#define CONFIG_FLASH_SHOW_PROGRESS	1

/*
 * u-boot environmnet
 */
#ifndef CONFIG_MINI2440_NOR_ENV
#define	CFG_ENV_IS_IN_NAND	1
#define CFG_ENV_OFFSET_OOB	1	// dont define for CFG_ENV_IS_IN_FLASH
/* This size must be the size of a common denominator for the NAND erase block */
#define CFG_ENV_SIZE		0x20000		/* 128k Total Size of Environment Sector */
#else
#define CFG_ENV_IS_IN_FLASH 	1
#define CFG_MY_ENV_OFFSET 	0X40000
#define CFG_ENV_ADDR		(PHYS_FLASH_1 + CFG_MY_ENV_OFFSET) /* addr of environment */
#define CFG_ENV_SIZE		0x4000		/* 16k Total Size of Environment Sector */
#endif
#define CFG_PREBOOT_OVERRIDE	1

#define NAND_MAX_CHIPS		1
#define CFG_NAND_BASE		0x4E000000 /* S3C2440_NAND_BASE */
#define CFG_MAX_NAND_DEVICE	1

#define CONFIG_MMC		1
#define CONFIG_MMC_S3C	1	/* Enabling the MMC driver */
#define CFG_MMC_BASE		0xff000000

#define CONFIG_EXT2		1

#define CONFIG_FAT		0
#define CONFIG_SUPPORT_VFAT	0

/* JFFS2 driver */
#define CONFIG_JFFS2_CMDLINE	1
#define CONFIG_JFFS2_NAND	1
#define CONFIG_JFFS2_NAND_DEV	0

/* ATAG configuration */
#define CONFIG_INITRD_TAG		1
#define CONFIG_SETUP_MEMORY_TAGS	1
#define CONFIG_CMDLINE_TAG		1
#if 0
#define CONFIG_REVISION_TAG		1
#define CONFIG_SERIAL_TAG		1
#endif
#define CONFIG_CMDLINE_EDITING		1
#define CONFIG_AUTO_COMPLETE		1

#define CONFIG_S3C2410_NAND_BBT		1	
//#define CONFIG_S3C2440_NAND_HWECC	1	/* this works for generation, not verification */

#define CFG_NAND_YAFFS_WRITE
#define CFG_NAND_YAFFS1_NEW_OOB_LAYOUT

#define MTDIDS_DEFAULT		"nand0=mini2440-nand"
#define MTPDARTS_DEFAULT		"mtdparts=mtdparts=mini2440-nand:256k@0(u-boot),128k(env),5m(kernel),-(root)"
#define CFG_NAND_DYNPART_MTD_KERNEL_NAME "mini2440-nand"
#define CONFIG_NAND_DYNPART	1

#define CONFIG_EXTRA_ENV_SETTINGS	\
	"usbtty=cdc_acm\0" \
	"mtdparts=mtdparts=mini2440-nand:256k@0(u-boot),128k(env),5m(kernel),-(root)\0" \
	"mini2440=mini2440=6tb\0" \
	"bootargs_base=console=ttySAC0,115200 \0" \
	"bootargs_init=init=/sbin/init\0" \
	"root_nfs=/mnt/nfs\0" \
	"set_root_nfs=setenv root_nfs root=/dev/nfs rw nfsroot=${serverip}:${root_nfs}\0" \
	"ifconfig_static=run setenv ifconfig ip=${ipaddr}:${serverip}::${netmask}:mini2440:eth0\0" \
	"ifconfig_dhcp=run setenv ifconfig ip=dhcp\0" \
	"ifconfig=ip=dhcp\0" \
	"set_bootargs_mmc=setenv bootargs ${bootargs_base} ${bootargs_init} ${mini2440} ${root_mmc}\0" \
	"set_bootargs_nand=setenv bootargs ${bootargs_base} ${bootargs_init} ${mini2440} ${root_nand}\0" \
	"set_bootargs_nfs=run set_root_nfs\; setenv bootargs ${bootargs_base} ${bootargs_init} ${mini2440} ${root_nfs} ${ifconfig}\0" \
	""	

#endif	/* __CONFIG_H */
