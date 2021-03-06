/*
 * (C) Copyright 2012
 *     wangflord@allwinnertech.com
 *
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
 * along with this program;
 *
 */
#ifndef  __boot0_v2_h
#define  __boot0_v2_h

#define STAMP_VALUE                     0x5F0A6C39


typedef struct
{
	unsigned int		ChannelCnt;
	unsigned int        ChipCnt;                            //the count of the total nand flash chips are currently connecting on the CE pin
    unsigned int       ChipConnectInfo;                    //chip connect information, bit == 1 means there is a chip connecting on the CE pin
	unsigned int		RbCnt;
	unsigned int		RbConnectInfo;						//the connect  information of the all rb  chips are connected
    unsigned int        RbConnectMode;						//the rb connect  mode
	unsigned int        BankCntPerChip;                     //the count of the banks in one nand chip, multiple banks can support Inter-Leave
    unsigned int        DieCntPerChip;                      //the count of the dies in one nand chip, block management is based on Die
    unsigned int        PlaneCntPerDie;                     //the count of planes in one die, multiple planes can support multi-plane operation
    unsigned int        SectorCntPerPage;                   //the count of sectors in one single physic page, one sector is 0.5k
    unsigned int       PageCntPerPhyBlk;                   //the count of physic pages in one physic block
    unsigned int       BlkCntPerDie;                       //the count of the physic blocks in one die, include valid block and invalid block
    unsigned int       OperationOpt;                       //the mask of the operation types which current nand flash can support support
    unsigned int        FrequencePar;                       //the parameter of the hardware access clock, based on 'MHz'
    unsigned int        EccMode;                            //the Ecc Mode for the nand flash chip, 0: bch-16, 1:bch-28, 2:bch_32
    unsigned char       NandChipId[8];                      //the nand chip id of current connecting nand chip
    unsigned int       ValidBlkRatio;                      //the ratio of the valid physical blocks, based on 1024
	unsigned int 		good_block_ratio;					//good block ratio get from hwscan
	unsigned int		ReadRetryType;						//the read retry type
	unsigned int       DDRType;
	unsigned int		Reserved[32];
}boot_nand_para_t0;


//通用的，和GPIO相关的数据结构
typedef struct _normal_gpio_cfg
{
    unsigned char      port;                       //端口号
    unsigned char      port_num;                   //端口内编号
    char      mul_sel;                    //功能编号
    char      pull;                       //电阻状态
    char      drv_level;                  //驱动驱动能力
    char      data;                       //输出电平
    unsigned char      reserved[2];                //保留位，保证对齐
}
normal_gpio_cfg;


typedef struct _boot_dram_para_t
{
    unsigned int           dram_baseaddr;
    unsigned int           dram_clk;
    unsigned int           dram_type;
    unsigned int           dram_rank_num;
    unsigned int           dram_chip_density;
    unsigned int           dram_io_width;
    unsigned int		    dram_bus_width;
    unsigned int           dram_cas;
    unsigned int           dram_zq;
    unsigned int           dram_odt_en;
    unsigned int 			dram_size;
    unsigned int           dram_tpr0;
    unsigned int           dram_tpr1;
    unsigned int           dram_tpr2;
    unsigned int           dram_tpr3;
    unsigned int           dram_tpr4;
    unsigned int           dram_tpr5;
    unsigned int 			dram_emr1;
    unsigned int           dram_emr2;
    unsigned int           dram_emr3;
}boot_dram_para_t;



/******************************************************************************/
/*                              file head of Boot0                            */
/******************************************************************************/
typedef struct _boot0_private_head_t
{
	unsigned int            prvt_head_size;
	char                    prvt_head_vsn[4];       // the version of boot0_private_head_t
	//unsigned int            dram_para[32];          // DRAM patameters for initialising dram. Original values is arbitrary,
	boot_dram_para_t		dram_para;				// DRAM patameters for initialising dram. Original values is arbitrary,
	int						uart_port;              // UART控制器编号
	normal_gpio_cfg         uart_ctrl[2];           // UART控制器(调试打印口)数据信息
	int                     enable_jtag;            // 1 : enable,  0 : disable
    normal_gpio_cfg	        jtag_gpio[5];           // 保存JTAG的全部GPIO信息
    normal_gpio_cfg         storage_gpio[32];       // 存储设备 GPIO信息
    char                    storage_data[512 - sizeof(normal_gpio_cfg) * 32];      // 用户保留数据信息
    //boot_nand_connect_info_t    nand_connect_info;
}boot0_private_head_t;


typedef struct standard_Boot_file_head
{
	unsigned int  jump_instruction;   // one intruction jumping to real code
	unsigned char   magic[8];           // ="eGON.BT0" or "eGON.BT1",  not C-style string.
	unsigned int  check_sum;          // generated by PC
	unsigned int  length;             // generated by PC
	unsigned int  pub_head_size;      // the size of boot_file_head_t
	unsigned char   pub_head_vsn[4];    // the version of boot_file_head_t
	unsigned char   file_head_vsn[4];   // the version of boot0_file_head_t or boot1_file_head_t
	unsigned char   Boot_vsn[4];        // Boot version
	unsigned char   eGON_vsn[4];        // eGON version
	unsigned char   platform[8];        // platform information
}standard_boot_file_head_t;


typedef struct _boot0_file_head_t
{
	standard_boot_file_head_t   boot_head;
	boot0_private_head_t  		prvt_head;
}boot0_file_head_t;






#endif     //  ifndef __boot0_h

/* end of boot0.h */
