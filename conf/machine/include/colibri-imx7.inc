# The payload offsets are given in number of 512 byte blocks.
OFFSET_BOOTROM_PAYLOAD = "2"
TORADEX_PRODUCT_IDS = "0032 0033 0039 0041"
TORADEX_PRODUCT_IDS[0032] = "imx7s-colibri-eval-v3.dtb,rawnand"
TORADEX_PRODUCT_IDS[0033] = "imx7d-colibri-eval-v3.dtb,rawnand"
TORADEX_PRODUCT_IDS[0039] = "imx7d-colibri-emmc-eval-v3.dtb,emmc"
TORADEX_PRODUCT_IDS[0041] = "imx7d-colibri-eval-v3.dtb,rawnand"
TORADEX_FLASH_TYPE = "rawnand emmc"

MACHINE_BOOT_FILES = "boot.scr"
IMAGE_BOOT_FILES_append = " ${MACHINE_BOOT_FILES}"
WKS_FILE_DEPENDS_append = " u-boot-distro-boot"

UBOOT_BINARY_TEZI_EMMC = "u-boot.imx-sd"
UBOOT_BINARY_TEZI_RAWNAND = "u-boot.imx-nd"

UBOOT_ENV_TEZI_EMMC = "uEnv-sd.txt"
UBOOT_ENV_TEZI_RAWNAND = "uEnv-nd.txt"

MACHINE_FIRMWARE_remove = "firmware-imx-epdc" 

KERNEL_DEVICETREE_use-mainline-bsp = "imx7d-colibri-eval-v3.dtb \
		imx7s-colibri-eval-v3.dtb imx7d-colibri-emmc-eval-v3.dtb"

# U-Boot NAND binary includes 0x400 padding required for NAND boot
UBOOT_MACHINE = ""
UBOOT_MAKE_TARGET_remove = "u-boot-nand.imx"
# We have to set UBOOT_BINARY in torizon-machine-custom.bbclass to take effect
UBOOT_CONFIG ??= "sd nd"
UBOOT_CONFIG[sd] = "colibri_imx7_emmc_defconfig,,u-boot.imx"
UBOOT_CONFIG[nd] = "colibri_imx7_defconfig,,u-boot-nand.imx"

