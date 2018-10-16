# Torizon configuration

# Toradex (support both NAND and eMMC targets with one single image)
OSTREE_KERNEL_ARGS_append_colibri-imx7 = " console=tty1 console=ttymxc0,115200"
EXTRA_IMAGEDEPENDS_append_colibri-imx7 = " u-boot-script-toradex"
IMAGE_BOOT_FILES_append_colibri-imx7 = " boot.scr uEnv.txt u-boot-colibri-imx7.imx;u-boot-nand.imx u-boot-colibri-imx7.imx-sd;u-boot-emmc.imx ${MACHINE_ARCH}/*;${MACHINE_ARCH}"

OSTREE_KERNEL_ARGS_append_colibri-imx6 = " console=tty1 console=ttymxc0,115200"
IMAGE_BOOT_FILES_append_colibri-imx6 = " boot.scr uEnv.txt u-boot-colibri-imx6.imx;u-boot.imx ${MACHINE_ARCH}/*;${MACHINE_ARCH}"

OSTREE_KERNEL_ARGS_append_apalis-imx6 = " console=tty1 console=ttymxc0,115200"
IMAGE_BOOT_FILES_append_apalis-imx6 = " boot.scr uEnv.txt u-boot-apalis-imx6.imx;u-boot.imx ${MACHINE_ARCH}/*;${MACHINE_ARCH}"

# Cross machines / BSPs
## Drop IMX BSP that is not needed
MACHINE_EXTRA_RRECOMMENDS_remove_imx = "imx-alsa-plugins"
## No need to install u-boot, already a WKS dependency
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_remove_imx = "u-boot-fslc"

