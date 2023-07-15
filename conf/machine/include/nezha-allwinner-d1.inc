
WKS_FILE:nezha-allwinner-d1 = "nezha.wks"
WIC_CREATE_EXTRA_ARGS = ""
WKS_FILE:sota:nezha-allwinner-d1 = "nezha-sota.wks"
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"
CORE_IMAGE_BASE_INSTALL:append = "resize-helper"

OSTREE_KERNEL_ARGS:sota:append:nezha-allwinner-d1 = " earlycon=sbi clk_ignore_unused initcall_debug=0 console=ttyS0,115200 loglevel=8 root=LABEL=otaroot rootfstype=ext4 root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash "
SOTA_CLIENT_FEATURES:append:nezha-allwinner-d1 = " ubootenv"
WKS_FILE_DEPENDS_BOOTLOADERS:nezha-allwinner-d1 = "virtual/bootloader"
WKS_FILE_DEPENDS:append:nezha-allwinner-d1 = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script:nezha-allwinner-d1 = "u-boot-distro-boot"
PREFERRED_PROVIDER_u-boot-default-script:sota:nezha-allwinner-d1 = "u-boot-distro-boot"

OSTREE_DEPLOY_DEVICETREE:nezha-allwinner-d1 = "0"

PREFERRED_PROVIDER_virtual/dtb = ""

KERNEL_BUILTIN_WIREGUARD:nezha-allwinner-d1 = "1"
KERNEL_IMAGETYPE:nezha-allwinner-d1 = "Image"
KERNEL_IMAGETYPE:sota:nezha-allwinner-d1 = "Image"
OSTREE_KERNEL:nezha-allwinner-d1 = "Image"
#KERNEL_DEVICETREE:nezha-allwinner-d1:sota ?= " allwinner/sun20i-d1-nezha.dtb"
UBOOT_BINARY_OTA_IGNORE:nezha-allwinner-d1 = "1"
KERNEL_BOOTCMD = "booti"

LINUX_VERSION_EXTENSION = "-torizon-${LINUX_KERNEL_TYPE}"

IMAGE_FSTYPES_REMOVE = "hddimg teziimg"

CORE_IMAGE_BASE_INSTALL:remove = "kernel-module-wireguard wireguard-tools"
IMAGE_BOOT_FILES:nezha-allwinner-d1 = "${KERNEL_IMAGETYPE} sun20i-d1-nezha.dtb boot.scr.uimg"
IMAGE_BOOT_FILES:sota:nezha-allwinner-d1 = "${KERNEL_IMAGETYPE} sun20i-d1-nezha.dtb boot.scr-${MACHINE};boot.scr.uimg"

hostname:pn-base-files = "torizon-nezha"
# FIXME: rac does not compile for riscv64, https://github.com/briansmith/ring/issues/1182
CORE_IMAGE_BASE_INSTALL:remove = "set-hostname rac"

# Use meta-lmp but maintain compatibility
BBMASK += " \
    meta-common-torizon/recipes-bsp/u-boot/u-boot-toradex \
    meta-common-torizon/recipes-bsp/u-boot/libubootenv_* \
    meta-toradex-bsp-common/recipes-bsp/u-boot/libubootenv_* \
    meta-common-torizon/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
"
