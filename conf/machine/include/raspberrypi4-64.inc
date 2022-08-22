
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"

CORE_IMAGE_BASE_INSTALL:append = "resize-helper"

# Raspberry Pi
KERNEL_BUILTIN_WIREGUARD:rpi = "1"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-fio"
PREFERRED_PROVIDER_virtual/bootloader:sota = "u-boot-fio"
PREFERRED_PROVIDER_virtual/bootloader:rpi = "u-boot-fio"
PREFERRED_PROVIDER_u-boot:rpi = "u-boot-fio"
SOTA_CLIENT_FEATURES:append:rpi = " ubootenv"
SOTA_DT_OVERLAYS:raspberrypi4-64 ?= "vc4-fkms-v3d-pi4.dtbo rpi-ft5406.dtbo"
WKS_FILE_DEPENDS_BOOTLOADERS:rpi = "virtual/bootloader"
WKS_FILE_DEPENDS:append:rpi = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script:rpi = "u-boot-ostree-scr"
PREFERRED_PROVIDER_u-boot-default-script:sota:rpi = "u-boot-ostree-scr-fit"

PREFERRED_PROVIDER_virtual/dtb:rpi ?= "lmp-device-tree"
IMAGE_FSTYPES:remove:rpi = "ext3 rpi-sdimg teziimg"
# We need ota-ext4 and wic for rpi
IMAGE_FSTYPES_REMOVE = ""
IMAGE_BOOT_FILES:rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.scr uEnv.txt "
IMAGE_BOOT_FILES:sota:rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.itb "
KERNEL_CLASSES:rpi = " toradex-fitimage "
OSTREE_KERNEL:rpi = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
KERNEL_IMAGETYPE:rpi = "fitImage"
VC4DTBO ?= "vc4-fkms-v3d-pi4"
KERNEL_DEVICETREE:raspberrypi4-64:sota ?= " broadcom/bcm2711-rpi-4-b.dtb overlays/vc4-fkms-v3d-pi4.dtbo overlays/rpi-ft5406.dtbo"
PREFERRED_PROVIDER_virtual/kernel:rpi ?= "linux-lmp-rpi"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

## Mimic meta-raspberrypi behavior
ENABLE_UART:rpi = "1"
KERNEL_SERIAL:rpi ?= "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyS0,115200", "", d)}"
OSTREE_KERNEL_ARGS_COMMON_RPI ?= "coherent_pool=1M 8250.nr_uarts=1 console=tty1 ${KERNEL_SERIAL} ${OSTREE_KERNEL_ARGS_COMMON}"
# This boot arguments are the same from torizon.bbclass
OSTREE_KERNEL_ARGS:sota:append:rpi = " root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash fbcon=map:10 "

## U-Boot entrypoints for rpi
UBOOT_ENTRYPOINT:rpi = "0x00008000"
UBOOT_DTB_LOADADDRESS:rpi = "0x02600000"
UBOOT_DTBO_LOADADDRESS:rpi = "0x026d0000"

# Use meta-lmp but maintain compatibility
BBMASK += " \
    meta-lmp/meta-lmp-base/recipes-connectivity \
    meta-lmp/meta-lmp-base/recipes-containers \
    meta-lmp/meta-lmp-base/recipes-core \
    meta-lmp/meta-lmp-base/recipes-devtools \
    meta-lmp/meta-lmp-base/recipes-extended \
    meta-lmp/meta-lmp-base/recipes-samples \
    meta-lmp/meta-lmp-base/recipes-security \
    meta-lmp/meta-lmp-base/recipes-sota \
    meta-lmp/meta-lmp-base/recipes-support \
    meta-lmp/meta-lmp-bsp/recipes-kernel/linux-firmware \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-distro-boot \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-toradex \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-distro-boot.bbappend \
    meta-toradex-torizon/recipes-bsp/u-boot/libubootenv_* \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
"
