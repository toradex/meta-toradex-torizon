
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"

CORE_IMAGE_BASE_INSTALL:append = "resize-helper"

# Raspberry Pi
KERNEL_BUILTIN_WIREGUARD:rpi = "1"
CORE_IMAGE_BASE_INSTALL:remove = "kernel-module-wireguard wireguard-tools"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot"
PREFERRED_PROVIDER_virtual/bootloader:sota = "u-boot"
PREFERRED_PROVIDER_virtual/bootloader:rpi = "u-boot"
PREFERRED_PROVIDER_u-boot:rpi = "u-boot"
PREFERRED_PROVIDER_virtual/dtb = ""
SOTA_DT_OVERLAYS:raspberrypi4-64 ?= "vc4-fkms-v3d-pi4.dtbo rpi-ft5406.dtbo"
WKS_FILE_DEPENDS_BOOTLOADERS:rpi = "virtual/bootloader"
WKS_FILE_DEPENDS:append:rpi = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script:rpi = "u-boot-distro-boot"
PREFERRED_PROVIDER_u-boot-default-script:sota:rpi = "u-boot-distro-boot"

PREFERRED_PROVIDER_u-boot-fw-utils = "libubootenv"
PREFERRED_RPROVIDER_u-boot-fw-utils = "libubootenv"

IMAGE_FSTYPES:remove:rpi = "ext3 rpi-sdimg teziimg"

# We need ota-ext4 and wic for rpi
IMAGE_FSTYPES_REMOVE = ""
IMAGE_BOOT_FILES:rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.scr uEnv.txt "
IMAGE_BOOT_FILES:sota:rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} "
IMAGE_BOOT_FILES_REMOVE:sota:remove = "boot.scr-${MACHINE};boot.scr"
IMAGE_BOOT_FILES:append = " boot.scr-${MACHINE};boot.scr "

OSTREE_KERNEL:rpi = "Image"
OSTREE_DEPLOY_DEVICETREE:rpi = "0"
KERNEL_IMAGETYPE:rpi = "Image"
KERNEL_IMAGETYPE:sota:rpi = "Image"
VC4DTBO ?= "vc4-fkms-v3d-pi4"
KERNEL_DEVICETREE:raspberrypi4-64:sota ?= " broadcom/bcm2711-rpi-4-b.dtb overlays/vc4-fkms-v3d-pi4.dtbo overlays/rpi-ft5406.dtbo"
KERNEL_BOOTCMD = "booti"

LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"
PREFERRED_VERSION_linux-raspberrypi = "5.15.%"

## Mimic meta-raspberrypi behavior
ENABLE_UART:rpi = "1"
SERIAL_CONSOLES = "115200;ttyAMA0"
KERNEL_SERIAL:sota:rpi = "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyAMA0,115200", "", d)}"
OSTREE_KERNEL_ARGS:sota = " 8250.nr_uarts=1 bcm2708_fb.fbwidth=656 bcm2708_fb.fbheight=614 bcm2708_fb.fbswap=1 vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 dwc_otg.lpm_enable=0 ${KERNEL_SERIAL} usbhid.mousepoll=0 "
# This boot arguments are the same from torizon.bbclass
OSTREE_KERNEL_ARGS:sota:append:rpi = " root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash fbcon=map:10 "

UBOOT_BINARY_OTA_IGNORE:raspberrypi4-64 = "1"

BBMASK += " \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-toradex \
    meta-raspberrypi/recipes-bsp/u-boot/u-boot_%.bbappend \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
"
