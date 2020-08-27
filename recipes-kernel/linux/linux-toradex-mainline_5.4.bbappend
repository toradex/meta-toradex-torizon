FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-mainline:"

require linux-torizon.inc
require recipes-kernel/linux/linux-yocto.inc

SRCREV_meta = "90c6e8f1ed6720fd3274922bf4d985ee4cb92903"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "toradex_5.4.y"
LINUX_KERNEL_TYPE = "standard"
LINUX_KERNEL_TYPE_preempt-rt = "preempt-rt"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += " \
    git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
    file://0001-Revert-ARM-dts-imx7-colibri-aster-enable-Atmel-multi.patch \
"

SRC_URI_remove = "file://defconfig"
