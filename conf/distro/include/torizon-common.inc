require conf/distro/include/tdx-base.inc

IMAGE_CLASSES += "image_type_torizon"

DISTRO_VERSION := "1.1b1"
TDX_BUILDNB ?= ""

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

MAINTAINER = "Toradex TorizonCore Team <torizoncore@toradex.com>"

TCLIBCAPPEND = ""

# Torizon machine specific overrides
INHERIT += "torizon"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

PREFERRED_PROVIDER_iasl-native = "acpica-native"

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
