require conf/distro/include/tdx-base.inc

IMAGE_CLASSES += "image_type_torizon"

TDX_RELEASE = "4.0.0"

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
    /meta-lmp/meta-lmp-base/recipes-sota/aktualizr/aktualizr_%.bbappend \
"
