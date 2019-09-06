LINUX_VERSION ?= "5.2.7"
PV = "${LINUX_VERSION}+git${SRCPV}"

export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

SRCREV_machine = "74e785ce1024471e77b6fb9da83ffd60762c8cac"
SRCREV_meta = "6fdf802cedc5a4915dcfb6885389fcdc1d843a3b"

KBRANCH = "toradex_5.2.y"
KMETABRANCH = "toradex_5.2.y"
LINUX_KERNEL_TYPE = "standard"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

SRC_URI += " \
    git://github.com/toradex/toradex-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
"

