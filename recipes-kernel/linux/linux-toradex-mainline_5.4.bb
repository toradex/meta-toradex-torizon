LINUX_VERSION ?= "5.4.28"
PV = "${LINUX_VERSION}+git${SRCPV}"

require linux-toradex-version.inc
require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

SRCREV_machine = "9ef9ba76540e1778510af18b07582d0a32c50ebf"
SRCREV_meta = "0aedf32650908d08f8cd9cbd3e12f8e65f00bea0"

KBRANCH = "toradex_5.4.y"
KMETABRANCH = "toradex_5.4.y"
LINUX_KERNEL_TYPE = "standard"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += " \
    git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
    file://0001-Revert-ARM-dts-imx7-colibri-aster-enable-Atmel-multi.patch \
"
