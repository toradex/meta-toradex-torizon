require conf/distro/include/tdx-base.inc

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
