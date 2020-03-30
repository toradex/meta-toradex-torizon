LINUX_VERSION ?= "5.4.24"
PV = "${LINUX_VERSION}+git${SRCPV}"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

SRCREV_machine = "585b24d35ce748075dc88af9e55b740ad3ded8a1"
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
