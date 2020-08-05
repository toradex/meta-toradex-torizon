# The payload offsets are given in number of 512 byte blocks.
OFFSET_BOOTROM_PAYLOAD = "2"
TORADEX_PRODUCT_IDS = "0032 0033 0039 0041"
TORADEX_PRODUCT_IDS[0032] = "imx7s-colibri-eval-v3.dtb,rawnand"
TORADEX_PRODUCT_IDS[0033] = "imx7d-colibri-eval-v3.dtb,rawnand"
TORADEX_PRODUCT_IDS[0039] = "imx7d-colibri-emmc-eval-v3.dtb,emmc"
TORADEX_PRODUCT_IDS[0041] = "imx7d-colibri-eval-v3.dtb,rawnand"
TORADEX_FLASH_TYPE = "rawnand emmc"

UBOOT_BINARY_TEZI_EMMC = "u-boot.imx-sd"
UBOOT_BINARY_TEZI_RAWNAND = "u-boot.imx-nd"

UBOOT_ENV_TEZI_EMMC = "u-boot-initial-env-sd"
UBOOT_ENV_TEZI_RAWNAND = "u-boot-initial-env-nd"

PREFERRED_PROVIDER_u-boot-default-script = "u-boot-distro-boot"

MACHINE_FIRMWARE_remove = "firmware-imx-epdc" 

PREFERRED_PROVIDER_virtual/kernel_use-mainline-bsp = "linux-toradex-mainline"
PREFERRED_PROVIDER_virtual/dtb_use-mainline-bsp = "device-tree-overlays-mainline"

KERNEL_DEVICETREE_use-mainline-bsp = "imx7d-colibri-eval-v3.dtb \
		imx7s-colibri-eval-v3.dtb imx7d-colibri-emmc-eval-v3.dtb"

# Using override to make sure to override what is set later in colibri-imx7.conf
UBOOT_MAKE_TARGET_colibri-imx7 = "u-boot.imx"
UBOOT_BINARY_colibri-imx7 = "u-boot.imx"

UBOOT_MACHINE = ""
UBOOT_CONFIG ??= "sd nd"
UBOOT_CONFIG[sd] = "colibri_imx7_emmc_defconfig,,u-boot.imx"
UBOOT_CONFIG[nd] = "colibri_imx7_defconfig,,u-boot.imx"

