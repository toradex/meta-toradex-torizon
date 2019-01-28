require conf/distro/include/arm-defaults.inc

DISTRO_VERSION := "0.3a1"
TDX_BUILDNB ?= ""

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

MAINTAINER = "Toradex <support.arm@toradex.com>"

TARGET_VENDOR = "-torizon"

TCLIBCAPPEND = ""

# Torizon machine specific overrides
INHERIT += "torizon"

INHERIT += "buildhistory"
INHERIT += "image-buildinfo"
BUILDHISTORY_COMMIT = "1"

IMAGE_LINGUAS ?= "en-us"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

PREFERRED_PROVIDER_iasl-native = "acpica-native"


