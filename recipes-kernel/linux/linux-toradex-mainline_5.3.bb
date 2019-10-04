LINUX_VERSION ?= "5.3.2"
PV = "${LINUX_VERSION}+git${SRCPV}"

export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

SRCREV_machine = "1ec6cce5d96a6faad11f0f6c4c5bd36c69c7a3d7"
SRCREV_meta = "93e83b9795f8f4721dbab575426c4564236d2767"

KBRANCH = "toradex_5.3.y"
KMETABRANCH = "toradex_5.3.y"
LINUX_KERNEL_TYPE = "standard"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

SRC_URI += " \
    git://github.com/toradex/toradex-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
"

