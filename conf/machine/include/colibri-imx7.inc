IMAGE_CLASSES_append = " image_type_tezi"
IMAGE_FSTYPES_append = " teziimg"
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

MACHINE_FIRMWARE_remove = "firmware-imx-epdc" 
