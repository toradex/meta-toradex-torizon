require conf/distro/include/tdx-base.inc

MAINTAINER = "Toradex TorizonCore Team <torizoncore@toradex.com>"

TCLIBCAPPEND = ""

COPY_LIC_MANIFEST = "1"
COPY_LIC_DIRS = "1"

IMAGE_CLASSES += "image_type_torizon"
IMAGE_CLASSES_remove = "image_type_tezi image_types_fsl"

IMAGE_BASENAME_SUFFIX ?= ""
IMAGE_NAME = "${IMAGE_BASENAME}${IMAGE_BASENAME_SUFFIX}-${MACHINE}"

TDX_RELEASE = "0.0.0"

IMX_DEFAULT_BSP = "nxp"
IMX_DEFAULT_BSP_upstream = "mainline"

SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

# Torizon machine specific overrides
INHERIT += "torizon"

# This also disables the static packageconfig. runc needs to be dynamically
# linked for seccomp support. https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG_remove_pn-${PREFERRED_PROVIDER_virtual/runc} = "static"
PACKAGECONFIG_append_pn-${PREFERRED_PROVIDER_virtual/runc} = " seccomp"
PACKAGECONFIG_append_pn-${PREFERRED_PROVIDER_virtual/docker} = " seccomp"
PACKAGECONFIG_append_pn-systemd = " seccomp"

# Set default network configuration
PREFERRED_RPROVIDER_network-configuration = "networkmanager"

# Default image formats
IMAGE_FSTYPES = "teziimg-distro"

# SOTA
OSTREE_OSNAME = "torizon"
SOTA_CLIENT_FEATURES_append = " ubootenv"
INITRAMFS_IMAGE = "initramfs-ostree-torizon-image"
INITRAMFS_FSTYPES = "cpio.gz"
BUILD_OSTREE_TARBALL = "0"
# We do not need wic or ext4 images by default
IMAGE_FSTYPES_REMOVE ?= "ota-ext4 wic"
IMAGE_FSTYPES_remove_sota = "${IMAGE_FSTYPES_REMOVE}"

# No need to install kernel image/devicetrees into the boot partition
IMAGE_BOOT_FILES = ""

# Use device provisioning. The signed device certificate will be stored on
# the rootfs by aktualizr-cert-provider running in Toradex Easy Installer
SOTA_CLIENT_PROV ?= "aktualizr-device-prov"
SOTA_DEPLOY_CREDENTIALS ?= "0"

DISTRO_FEATURES_append = " virtualization"
DISTRO_FEATURES_remove = "3g alsa irda pcmcia nfc ldconfig pulseaudio wayland x11 ptest multiarch opengl vulkan"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

# TorizonCore does not use runtime package management, so version numbers going
# backwards are not a problem for us.
ERROR_QA_remove = "version-going-backwards"

# Compatibility with toradex layers
BBMASK += " \
    /meta-toradex-bsp-common/recipes-core/systemd/systemd_%.bbappend \
    /meta-freescale/recipes-graphics/cairo \
    /meta-lmp/meta-lmp-base/recipes-sota/aktualizr/aktualizr_%.bbappend \
    /meta-lmp/meta-lmp-base/recipes-devtools/gcc/gcc-source_9.%.bbappend \
    /meta-lmp/meta-lmp-base/recipes-containers/docker/docker-ce_git.bbappend \
"
