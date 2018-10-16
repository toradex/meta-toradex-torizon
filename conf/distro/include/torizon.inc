DISTRO_VERSION = "0.2"

# These default to 'oecore' and 'nodistro'
SDK_NAME_PREFIX = "${DISTRO}"
SDK_VERSION = "${DISTRO_VERSION}"

MAINTAINER = "Toradex <support.arm@toradex.com>"

TARGET_VENDOR = "-torizon"

TCLIBCAPPEND = ""

require conf/distro/include/arm-defaults.inc

PREFERRED_PROVIDER_virtual/kernel = "linux-stable"
PREFERRED_PROVIDER_iasl-native = "acpica-native"

# No need for x11 even for native
DISTRO_FEATURES_NATIVE_remove = "x11"
DISTRO_FEATURES_NATIVESDK_remove = "x11"

# TODO: review default distro features
DISTRO_FEATURES_append = " pam systemd usrmerge virtualization"
DISTRO_FEATURES_remove = "3g alsa irda pcmcia nfc pulseaudio sysvinit"
VIRTUAL-RUNTIME_init_manager = "systemd"
PACKAGECONFIG_append_pn-systemd = " resolved networkd"
PACKAGECONFIG_append_pn-qemu-native = " libusb"

# Default image formats
IMAGE_FSTYPES = "teziimg-distro"
IMAGE_CLASSES += "image_type_tezi image_torizon_tezi"

# Torizon machine specific overrides
INHERIT += "torizon"

INHERIT += "buildhistory"
INHERIT += "image-buildinfo"
BUILDHISTORY_COMMIT = "1"

