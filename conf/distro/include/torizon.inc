require conf/distro/include/torizon-common.inc

# Distro override for all torizon Distros
DISTROOVERRIDES = "torizon:use-mainline-bsp"

PACKAGECONFIG_remove_pn-networkmanager = "ifupdown dnsmasq"

# This also disables the static packageconfig. runc needs to be dynamically
# linked for seccomp support. https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG_remove_pn-${PREFERRED_PROVIDER_virtual/runc} = "static"
PACKAGECONFIG_append_pn-${PREFERRED_PROVIDER_virtual/runc} = " seccomp"
PACKAGECONFIG_append_pn-${PREFERRED_PROVIDER_virtual/docker} = " seccomp"
PACKAGECONFIG_append_pn-systemd = " seccomp"

# Default image formats
IMAGE_FSTYPES = "teziimg-distro"
IMAGE_FSTYPES_remove_intel-corei7-64 = "teziimg-distro"

# SOTA
OSTREE_OSNAME = "torizon"
INITRAMFS_IMAGE = "initramfs-ostree-torizon-image"
INITRAMFS_FSTYPES = "cpio.gz"
BUILD_OSTREE_TARBALL = "0"
# We do not need wic or ext4 images by default
IMAGE_FSTYPES_REMOVE ?= "ota-ext4 wic"
IMAGE_FSTYPES_REMOVE_qemuarm64 = ""
IMAGE_FSTYPES_REMOVE_intel-corei7-64 = ""
IMAGE_FSTYPES_remove_sota = "${IMAGE_FSTYPES_REMOVE}"

# No need to install kernel image/devicetrees into the boot partition
IMAGE_BOOT_FILES = ""

# Use device provisioning. The signed device certificate will be stored on
# the rootfs by aktualizr-cert-provider running in Toradex Easy Installer
SOTA_CLIENT_PROV ?= "aktualizr-device-prov"
SOTA_DEPLOY_CREDENTIALS ?= "0"

DISTRO_FEATURES_append = " virtualization"
DISTRO_FEATURES_remove = "3g alsa irda pcmcia nfc ldconfig pulseaudio wayland x11 ptest multiarch opengl vulkan"

# General
WKS_FILE_DEPENDS_BOOTLOADERS_remove = "syslinux systemd-boot"
## We don't use the default efi sota wks file
WKS_FILE_sota_remove = "efiimage-sota.wks"

PREFERRED_VERSION_u-boot-toradex ?= "2019.07%"
PREFERRED_VERSION_u-boot-toradex-fw-utils ?= "2019.07%"

# Use i.MX Gstreamer Version (for PXP DMA-ENGINE Driver)
PREFERRED_VERSION_gstreamer1.0_use-mainline-bsp_torizon = "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base_use-mainline-bsp_torizon = "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good_use-mainline-bsp_torizon = "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad_use-mainline-bsp_torizon = "1.14.imx"

# TorizonCore does not use runtime package management, so version numbers going
# backwards are not a problem for us.
ERROR_QA_remove = "version-going-backwards"

hostname_pn-base-files = ""

# Remove unneeded mainline bsp firmware for i.MX8 devices
MACHINE_FIRMWARE_remove_mx8 = "linux-firmware-imx-sdma-imx6q firmware-imx-vpu-imx6q firmware-imx-vpu-imx6d"
