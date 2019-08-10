require conf/distro/include/torizon-common.inc

PACKAGECONFIG_append_pn-systemd = " resolved networkd"

# Default image formats
IMAGE_FSTYPES = "teziimg-distro"

# SOTA
OSTREE_OSNAME = "torizon"
INITRAMFS_IMAGE = "initramfs-ostree-torizon-image"
INITRAMFS_FSTYPES = "cpio.gz"
BUILD_OTA_TARBALL = "1"
BUILD_OSTREE_TARBALL = "0"
# We do not need wic or ext4 images
IMAGE_FSTYPES_remove_sota = "ota-ext4 wic"

# No need to install kernel image/devicetrees into the boot partition
IMAGE_BOOT_FILES = ""

# Use device provisioning. The signed device certificate will be stored on
# the rootfs by aktualizr-cert-provider running in Toradex Easy Installer
SOTA_CLIENT_PROV ?= "aktualizr-device-prov"
SOTA_DEPLOY_CREDENTIALS ?= "0"

DISTRO_FEATURES_append = " virtualization"
DISTRO_FEATURES_remove = "3g alsa irda pcmcia nfc pulseaudio wayland x11 ptest multiarch opengl vulkan"

# General
WKS_FILE_DEPENDS_BOOTLOADERS_remove = "syslinux systemd-boot"
## We don't use the default efi sota wks file
WKS_FILE_sota_remove = "efiimage-sota.wks"

PREFERRED_VERSION_u-boot-toradex ?= "2016.11%"
PREFERRED_VERSION_u-boot-toradex-fw-utils = "2016.11%"

# Compatibility with toradex layers
BBMASK += " \
    /meta-toradex-bsp-common/recipes-core/systemd/systemd_%.bbappend \
    /meta-lmp/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
    /meta-lmp/recipes-bsp/uefi/ \
    /meta-lmp/recipes-bsp/96boards-tools/ \
    /meta-lmp/recipes-devtools/riscv-tools/ \
    /meta-lmp/recipes-sota/aktualizr/aktualizr_%.bbappend \
    /meta-lmp/recipes-connectivity/pi-bluetooth \
    /meta-lmp/recipes-kernel/bluez-firmware-rpidistro \
"

hostname_pn-base-files = ""
