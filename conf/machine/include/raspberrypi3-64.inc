
WKS_FILE_DEPENDS_remove = "tezi-metadata virtual/dtb"

hostname_pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL_append = "resize-helper"
CORE_IMAGE_BASE_INSTALL_remove = "set-hostname"

# Raspberry Pi
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-fio"
PREFERRED_PROVIDER_virtual/bootloader_sota = "u-boot-fio"
PREFERRED_PROVIDER_virtual/bootloader_rpi = "u-boot-fio"
PREFERRED_PROVIDER_u-boot_rpi = "u-boot-fio"
SOTA_CLIENT_FEATURES_append_rpi = " ubootenv"
WKS_FILE_DEPENDS_BOOTLOADERS_rpi = "virtual/bootloader"
WKS_FILE_DEPENDS_append_rpi = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script_rpi = "u-boot-ostree-scr"
PREFERRED_PROVIDER_u-boot-default-script_sota_rpi = "u-boot-ostree-scr-fit"

PREFERRED_PROVIDER_virtual/dtb_rpi ?= "lmp-device-tree"
IMAGE_FSTYPES_remove_rpi = "ext3 rpi-sdimg teziimg"
# We need ota-ext4 and wic for rpi
IMAGE_FSTYPES_REMOVE = ""
IMAGE_BOOT_FILES_rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.scr uEnv.txt "
IMAGE_BOOT_FILES_sota_rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.itb "
KERNEL_CLASSES_rpi = " toradex-fitimage "
OSTREE_KERNEL_rpi = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
KERNEL_IMAGETYPE_rpi = "fitImage"

## RPI: Use official raspberrypi downstream kernel
PREFERRED_PROVIDER_virtual/kernel_rpi ?= "linux-lmp-dev"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"
LINUX_VERSION_rpi ?= "4.19.y"
KERNEL_REPO_rpi ?= "git://github.com/raspberrypi/linux.git"
KERNEL_BRANCH_rpi ?= "rpi-4.19.y"
KERNEL_COMMIT_rpi ?= "f6b3ac28f0a9137d4c24c0b8832e693bbd16f5b7"
KERNEL_META_BRANCH_rpi ?= "linux-v4.19.y"
KERNEL_META_COMMIT_rpi ?= "1e97ab775c4c499b995e7013ffc221d71844ba87"

## Mimic meta-raspberrypi behavior
ENABLE_UART = "1"
KERNEL_SERIAL_rpi ?= "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyS0,115200", "", d)}"
OSTREE_KERNEL_ARGS_COMMON_RPI ?= "coherent_pool=1M 8250.nr_uarts=1 console=tty1 ${KERNEL_SERIAL} ${OSTREE_KERNEL_ARGS_COMMON}"
# This boot arguments are the same from torizon.bbclass
OSTREE_KERNEL_ARGS_sota_append_rpi = " root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash fbcon=map:10 "

## U-Boot entrypoints for rpi
UBOOT_ENTRYPOINT_rpi = "0x00008000"
UBOOT_DTB_LOADADDRESS_rpi = "0x02600000"
UBOOT_DTBO_LOADADDRESS_rpi = "0x026d0000"

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
    meta-toradex-torizon/recipes-bsp/u-boot \
"
