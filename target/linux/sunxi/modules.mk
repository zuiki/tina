#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

define KernelPackage/rtc-sunxi
    SUBMENU:=$(OTHER_MENU)
    TITLE:=Sunxi SoC built-in RTC support
    DEPENDS:=@TARGET_sunxi
    $(call AddDepends/rtc)
    KCONFIG:= \
	CONFIG_RTC_CLASS=y \
	CONFIG_RTC_DRV_SUNXI=m
    FILES:=$(LINUX_DIR)/drivers/rtc/rtc-sunxi.ko
    AUTOLOAD:=$(call AutoLoad,50,rtc-sunxi)
endef

define KernelPackage/rtc-sunxi/description
 Support for the AllWinner sunXi SoC's onboard RTC
endef

$(eval $(call KernelPackage,rtc-sunxi))

define KernelPackage/sunxi-ir
    SUBMENU:=$(OTHER_MENU)
    TITLE:=Sunxi SoC built-in IR support (A20)
    DEPENDS:=@TARGET_sunxi +kmod-input-core
    $(call AddDepends/rtc)
    KCONFIG:= \
	CONFIG_MEDIA_SUPPORT=y \
	CONFIG_MEDIA_RC_SUPPORT=y \
	CONFIG_RC_DEVICES=y \
	CONFIG_IR_SUNXI
    FILES:=$(LINUX_DIR)/drivers/media/rc/sunxi-cir.ko
    AUTOLOAD:=$(call AutoLoad,50,sunxi-cir)
endef

define KernelPackage/sunxi-ir/description
 Support for the AllWinner sunXi SoC's onboard IR (A20)
endef

$(eval $(call KernelPackage,sunxi-ir))

define KernelPackage/eeprom-sunxi
    SUBMENU:=$(OTHER_MENU)
    TITLE:=AllWinner Security ID fuse support
    DEPENDS:=@TARGET_sunxi
    KCONFIG:= \
	CONFIG_EEPROM_SUNXI_SID
    FILES:=$(LINUX_DIR)/drivers/misc/eeprom/sunxi_sid.ko
    AUTOLOAD:=$(call AutoLoad,50,sunxi_sid)
endef

define KernelPackage/eeprom-sunxi/description
 Support for the AllWinner Security ID fuse support
endef

$(eval $(call KernelPackage,eeprom-sunxi))

define KernelPackage/ata-sunxi
    TITLE:=AllWinner sunXi AHCI SATA support
    SUBMENU:=$(BLOCK_MENU)
    DEPENDS:=@TARGET_sunxi +kmod-scsi-core
    KCONFIG:=\
	CONFIG_AHCI_SUNXI \
	CONFIG_SATA_AHCI_PLATFORM
    FILES:=$(LINUX_DIR)/drivers/ata/ahci_sunxi.ko
    AUTOLOAD:=$(call AutoLoad,41,ahci_sunxi,1)
endef

define KernelPackage/ata-sunxi/description
 SATA support for the AllWinner sunXi SoC's onboard AHCI SATA
endef

$(eval $(call KernelPackage,ata-sunxi))

define KernelPackage/sun4i-emac
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=AllWinner EMAC Ethernet support
  DEPENDS:=@TARGET_sunxi
  KCONFIG:=CONFIG_SUN4I_EMAC
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/allwinner/sun4i-emac.ko
  AUTOLOAD:=$(call AutoProbe,sun4i-emac)
endef

$(eval $(call KernelPackage,sun4i-emac))


define KernelPackage/wdt-sunxi
    SUBMENU:=$(OTHER_MENU)
    TITLE:=AllWinner sunXi Watchdog timer
    DEPENDS:=@TARGET_sunxi
    KCONFIG:=CONFIG_SUNXI_WATCHDOG
    FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/sunxi_wdt.ko
    AUTOLOAD:=$(call AutoLoad,51,sunxi_wdt)
endef

define KernelPackage/wdt-sunxi/description
    Kernel module for AllWinner sunXi watchdog timer.
endef

$(eval $(call KernelPackage,wdt-sunxi))

define KernelPackage/net-rtl8723bs
  SUBMENU:=$(WIRELESS_MENU)
  TITLE:=RTL8723BS support
  DEPENDS:=@TARGET_sunxi
  KCONFIG:=CONFIG_RTL8723BS
  FILES:=$(LINUX_DIR)/drivers/net/wireless/rtl8723bs/8723bs.ko
  AUTOLOAD:=$(call AutoProbe,8723bs)
endef

define KernelPackage/net-rtl8723bs/description
 Kernel modules for RealTek RTL8723BS support
endef

$(eval $(call KernelPackage,net-rtl8723bs))

define KernelPackage/net-ap6212
  SUBMENU:=$(WIRELESS_MENU)
  TITLE:=ap6212 support
  DEPENDS:=@TARGET_sunxi 
  FILES:=$(LINUX_DIR)/drivers/net/wireless/bcmdhd/bcmdhd.ko
  AUTOLOAD:=$(call AutoProbe,bcmdhd)
endef

define KernelPackage/net-ap6212/description
 Kernel modules for Broadcom AP6212  support
endef

$(eval $(call KernelPackage,net-ap6212))

define KernelPackage/sunxi-vfe
  SUBMENU:=$(VIDEO_MENU)
  TITLE:=sunxi-vfe support
  DEPENDS:=@TARGET_sunxi
  KCONFIG:=CONFIG_CSI_VFE
  FILES:=$(LINUX_DIR)/drivers/media/video/videobuf-core.ko
  FILES+=$(LINUX_DIR)/drivers/media/video/videobuf-dma-contig.ko  
  FILES+=$(LINUX_DIR)/drivers/media/video/sunxi-vfe/csi_cci/cci.ko
  FILES+=$(LINUX_DIR)/drivers/media/video/sunxi-vfe/vfe_os.ko
  FILES+=$(LINUX_DIR)/drivers/media/video/sunxi-vfe/vfe_subdev.ko
  FILES+=$(LINUX_DIR)/drivers/media/video/sunxi-vfe/device/gc0308.ko
  FILES+=$(LINUX_DIR)/drivers/media/video/sunxi-vfe/vfe_v4l2.ko
  AUTOLOAD:=$(call AutoLoad,90,videobuf-core videobuf-dma-contig cci vfe_os vfe_subdev gc0308 vfe_v4l2)
endef

define KernelPackage/sunxi-vfe/description
  Kernel modules for sunxi-vfe support
endef

$(eval $(call KernelPackage,sunxi-vfe))

define KernelPackage/sunxi-disp
  SUBMENU:=$(VIDEO_MENU)
  TITLE:=sunxi-disp support
  DEPENDS:=@TARGET_sunxi
  FILES:=\
	 $(LINUX_DIR)/drivers/video/sunxi/disp/disp.ko \
         $(LINUX_DIR)/drivers/video/sunxi/lcd/lcd.ko
  AUTOLOAD:=$(call AutoLoad,10,disp lcd)
endef

define KernelPackage/sunxi-disp/description
  Kernel modules for sunxi-disp support
endef

$(eval $(call KernelPackage,sunxi-disp))