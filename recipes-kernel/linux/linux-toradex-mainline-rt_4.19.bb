LINUX_VERSION ?= "4.19.59-rt24"
PV = "${LINUX_VERSION}+git${SRCPV}"

export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

SRCREV_machine = "3758b8bd81966b63dc93093a323e9bdd734545fd"
SRCREV_meta = "31e99fc1b9fb06cbcdc78421a66c1f45d61b090a"

KBRANCH = "toradex_4.19.y-rt"
KMETABRANCH = "toradex_4.19.y"
LINUX_KERNEL_TYPE = "preempt-rt"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

SRC_URI += " \
    git://github.com/toradex/toradex-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
"

