require conf/distro/include/tdx-base.inc

IMAGE_CLASSES += "image_type_torizon"
IMAGE_CLASSES_remove = "image_type_tezi image_types_fsl"

TDX_RELEASE = "0.0.0"

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

MASK_META_VIRT_KERNEL_PATH = "/meta-virtualization/recipes-kernel/linux"
MASK_META_VIRT_KERNEL_PATH_intel-corei7-64 = ""

# Compatibility with toradex layers
BBMASK += " \
    /meta-toradex-bsp-common/recipes-core/systemd/systemd_%.bbappend \
    /meta-freescale/recipes-graphics/cairo \
    /meta-lmp/meta-lmp-base/recipes-sota/aktualizr/aktualizr_%.bbappend \
    ${MASK_META_VIRT_KERNEL_PATH} \
"
