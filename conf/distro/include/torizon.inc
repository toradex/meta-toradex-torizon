require conf/distro/include/tdx-base.inc

MAINTAINER = "Toradex TorizonCore Team <torizoncore@toradex.com>"

TCLIBCAPPEND = ""

COPY_LIC_MANIFEST = "1"
COPY_LIC_DIRS = "1"

IMAGE_CLASSES_append = " image_type_torizon"
IMAGE_CLASSES_remove = "image_type_tezi image_types_fsl"

IMAGE_BASENAME_SUFFIX ?= ""

TDX_MAJOR = "5"

IMX_DEFAULT_BSP = "nxp"
IMX_DEFAULT_BSP_upstream = "mainline"

SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

# TorizonCore machine specific overrides
INHERIT += "torizon toradex-sanity"

# This also disables the static packageconfig. runc needs to be dynamically
# linked for seccomp support. https://github.com/opencontainers/runc/issues/2008
PACKAGECONFIG_remove_pn-${PREFERRED_PROVIDER_virtual/runc} = "static"
PACKAGECONFIG_append_pn-${PREFERRED_PROVIDER_virtual/runc} = " seccomp"
PACKAGECONFIG_append_pn-${PREFERRED_PROVIDER_virtual/docker} = " seccomp"
PACKAGECONFIG_append_pn-systemd = " seccomp"

# Set default network configuration
PREFERRED_RPROVIDER_network-configuration = "networkmanager"

# SOTA
OSTREE_OSNAME = "torizon"
OSTREE_MULTI_DEVICETREE_SUPPORT = "1"
SOTA_CLIENT_FEATURES_append = " ubootenv"
INITRAMFS_IMAGE = "initramfs-ostree-torizon-image"
INITRAMFS_FSTYPES = "cpio.gz"
BUILD_OSTREE_TARBALL = "0"
# We do not need teziimg, ota-ext4 or wic images by default
IMAGE_FSTYPES_REMOVE ?= "ota-ext4 wic wic.gz wic.bmap"
IMAGE_FSTYPES_remove_sota = "${IMAGE_FSTYPES_REMOVE}"

# No need to install boot script, kernel image, devicetrees or firmware into the boot partition
IMAGE_BOOT_FILES = ""
IMAGE_BOOT_FILES_REMOVE_sota = "boot.scr-${MACHINE};boot.scr overlays.txt overlays/*;overlays/"
IMAGE_BOOT_FILES_REMOVE_append_apalis-imx8 = " hdmitxfw.bin dpfw.bin"

DISTRO_FEATURES_append = " virtualization stateless-system"
DISTRO_FEATURES_remove = "3g alsa irda pcmcia nfc ldconfig pulseaudio wayland x11 ptest multiarch opengl vulkan"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

# Note, enable or disable the useradd-staticids in a configured system,
# the TMPDIR/DEPLOY_DIR/SSTATE_DIR may contain incorrect uid/gid values.
# Clearing them will correct this condition.
USERADDEXTENSION = "useradd-staticids"
USERADD_UID_TABLES = "files/torizon-static-passwd"
USERADD_GID_TABLES = "files/torizon-static-group"
USERADD_ERROR_DYNAMIC = "skip"

# Compatibility with toradex layers
BBMASK += " \
    /meta-toradex-bsp-common/recipes-core/systemd/systemd_%.bbappend \
    /meta-freescale/recipes-graphics/cairo \
"

# containerd recipe from meta-lmp builds a new version that might only work
# with Docker built from the Moby project, so for now, let's force the usage
# of containerd from meta-virtualization
BBMASK += " \
    /meta-lmp/meta-lmp-base/recipes-containers/containerd \
"

# we don't want meta-lmp variables in /etc/os-release
BBMASK += " \
    /meta-lmp/meta-lmp-base/recipes-core/os-release \
"

# machines where TorizonCore is experimental
EXPERIMENTALOVERRIDES = ""
# Currently TorizonCore does not support any experimental machines, in future such machines can be added like below:
#EXPERIMENTALOVERRIDES_colibri-imx6ull = ":experimental"
DISTROOVERRIDES .= "${EXPERIMENTALOVERRIDES}"

# meta-lmp provides newer versions of wireguard recipes, but
# those don't build with our current kernel version, so let's
# use the versions provided by meta-networking
PREFERRED_VERSION_wireguard-module = "1.0.20200401"
PREFERRED_VERSION_wireguard-tools = "1.0.20200319"

# Use our variant of the aktualizr client instead of the
# default from meta-updater
PREFERRED_PROVIDER_aktualizr = "aktualizr-torizon"
PREFERRED_PROVIDER_aktualizr-native = "aktualizr-torizon-native"
PREFERRED_RPROVIDER_aktualizr = "aktualizr-torizon"
PREFERRED_RPROVIDER_aktualizr-info = "aktualizr-torizon"
PREFERRED_RPROVIDER_aktualizr-shared-prov = "aktualizr-torizon"
