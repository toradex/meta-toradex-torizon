require conf/distro/include/torizon-common.inc

# Distro override for all torizon Distros
DISTROOVERRIDES = "torizon:use-mainline-bsp"

PACKAGECONFIG_append_pn-systemd = " resolved networkd seccomp"

# This also disables the static packageconfig. runc needs to be dynamically
# linked for seccomp support. https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG_pn-${PREFERRED_PROVIDER_virtual/runc} = "seccomp"

PACKAGECONFIG_append_pn-docker = " seccomp"

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

PREFERRED_VERSION_u-boot-toradex ?= "2019.07%"
PREFERRED_VERSION_u-boot-toradex-fw-utils = "2019.07%"

# Use i.MX Gstreamer Version (for PXP DMA-ENGINE Driver)
PREFERRED_VERSION_gstreamer1.0_use-mainline-bsp_torizon = "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base_use-mainline-bsp_torizon = "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good_use-mainline-bsp_torizon = "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad_use-mainline-bsp_torizon = "1.14.imx"

PREFERRED_VERSION_wayland-protocols_mx8_torizon = "1.17.imx"

ERROR_QA_remove = "version-going-backwards"
WARN_QA_append = " version-going-backwards"

# Compatibility with toradex layers
BBMASK += " \
    /meta-toradex-bsp-common/recipes-core/systemd/systemd_%.bbappend \
    /meta-toradex-nxp/recipes-kernel/kernel-modules/kernel-module-imx-gpu-viv_6.2.4.p1.8.bbappend \
    /meta-toradex-nxp/recipes-kernel/linux/linux-imx-headers_4.9.123.bbappend \
    /meta-toradex-nxp/recipes-multimedia/imx-codec/imx-codec_4.4.2.bbappend \
    /meta-toradex-nxp/recipes-graphics/imx-dpu-g2d/imx-dpu-g2d_1.4.8.bbappend \
    /meta-toradex-nxp/recipes-graphics/imx-gpu-g2d/imx-gpu-g2d_6.2.4.p1.8.bbappend \
    /meta-toradex-nxp/recipes-multimedia/imx-parser/imx-parser_4.4.2.bbappend \
    /meta-toradex-nxp/recipes-multimedia/gstreamer/imx-gst1.0-plugin_4.4.2.bbappend \
    /meta-toradex-nxp/recipes-graphics/wayland/wayland-protocols_1.13.imx.bbappend \
    /meta-toradex-nxp/recipes-graphics/wayland/weston_4.0.0.imx.bbappend \
    /meta-toradex-nxp/recipes-graphics/xorg-driver/xf86-video-imx-vivante_6.2.4.p1.8.bbappend \
    /meta-freescale/recipes-kernel/linux/linux-imx-mfgtool_4.14.98.bb \
    /meta-lmp/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
    /meta-lmp/recipes-bsp/uefi/ \
    /meta-lmp/recipes-bsp/96boards-tools/ \
    /meta-lmp/recipes-devtools/riscv-tools/ \
    /meta-lmp/recipes-sota/aktualizr/aktualizr_%.bbappend \
    /meta-lmp/recipes-connectivity/pi-bluetooth \
    /meta-lmp/recipes-kernel/bluez-firmware-rpidistro \
"

hostname_pn-base-files = ""
