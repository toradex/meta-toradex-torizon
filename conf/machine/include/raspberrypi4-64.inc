
WKS_FILE_DEPENDS_remove = "tezi-metadata virtual/dtb"

hostname_pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL_remove = "set-hostname"

# Raspberry Pi
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
IMAGE_BOOT_FILES_rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.scr uEnv.txt"
IMAGE_BOOT_FILES_sota_rpi = "${BOOTFILES_DIR_NAME}/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.itb"
KERNEL_CLASSES_rpi = " toradex-fitimage "
OSTREE_KERNEL_rpi = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
KERNEL_IMAGETYPE_rpi = "fitImage"

## Mimic meta-raspberrypi behavior
KERNEL_SERIAL_rpi ?= "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyS0,115200", "", d)}"
KERNEL_SERIAL_raspberrypi-cm3 ?= "console=ttyAMA0,115200"
OSTREE_KERNEL_ARGS_COMMON_RPI ?= "coherent_pool=1M 8250.nr_uarts=1 console=tty1 ${KERNEL_SERIAL} ${OSTREE_KERNEL_ARGS_COMMON}"
OSTREE_KERNEL_ARGS_raspberrypi3 ?= "vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 ${OSTREE_KERNEL_ARGS_COMMON_RPI}"
OSTREE_KERNEL_ARGS_raspberrypi-cm3 ?= "vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 ${OSTREE_KERNEL_ARGS_COMMON_RPI}"
OSTREE_KERNEL_ARGS_raspberrypi4 ?= "video=HDMI-A-1:1280x720@60 vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 ${OSTREE_KERNEL_ARGS_COMMON_RPI}"

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
