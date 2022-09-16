
WKS_FILE:nezha-allwinner-d1 = "nezha.wks"
WIC_CREATE_EXTRA_ARGS = ""
WKS_FILE:sota:nezha-allwinner-d1 = "nezha-sota.wks"
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"
CORE_IMAGE_BASE_INSTALL:append = "resize-helper"

OSTREE_KERNEL_ARGS:sota:append:nezha-allwinner-d1 = " earlycon=sbi clk_ignore_unused initcall_debug=0 console=ttyS0,115200 loglevel=8 root=LABEL=otaroot rootfstype=ext4 root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash "
SOTA_CLIENT_FEATURES:append:nezha-allwinner-d1 = " ubootenv"
WKS_FILE_DEPENDS_BOOTLOADERS:nezha-allwinner-d1 = "virtual/bootloader"
WKS_FILE_DEPENDS:append:nezha-allwinner-d1 = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script:nezha-allwinner-d1 = "u-boot-ostree-scr"
PREFERRED_PROVIDER_u-boot-default-script:sota:nezha-allwinner-d1 = "u-boot-ostree-scr-fit"

OSTREE_DEPLOY_DEVICETREE:nezha-allwinner-d1 = "0"

PREFERRED_PROVIDER_virtual/dtb = ""

KERNEL_BUILTIN_WIREGUARD:nezha-allwinner-d1 = "1"
KERNEL_CLASSES:nezha-allwinner-d1 = " toradex-fitimage "
KERNEL_IMAGETYPE:nezha-allwinner-d1 = "fitImage"
OSTREE_KERNEL:nezha-allwinner-d1 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
#KERNEL_DEVICETREE:nezha-allwinner-d1:sota ?= " allwinner/sun20i-d1-nezha.dtb"

LINUX_VERSION_EXTENSION = "-torizon-${LINUX_KERNEL_TYPE}"

IMAGE_FSTYPES_REMOVE = "hddimg teziimg"

CORE_IMAGE_BASE_INSTALL:remove = "kernel-module-wireguard wireguard-tools"
IMAGE_BOOT_FILES:nezha-allwinner-d1 = "${KERNEL_IMAGETYPE} sun20i-d1-nezha.dtb boot.scr.uimg"
IMAGE_BOOT_FILES:sota:nezha-allwinner-d1 = "${KERNEL_IMAGETYPE} sun20i-d1-nezha.dtb boot.scr.uimg"

hostname:pn-base-files = "torizon-nezha"
CORE_IMAGE_BASE_INSTALL:remove = "set-hostname"

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
    meta-lmp/meta-lmp-bsp/recipes-kernel/linux-firmware \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-distro-boot \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-toradex \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-distro-boot.bbappend \
    meta-toradex-torizon/recipes-bsp/u-boot/libubootenv_* \
    meta-toradex-torizon/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
"
