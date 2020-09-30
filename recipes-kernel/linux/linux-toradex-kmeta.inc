require recipes-kernel/linux/linux-yocto.inc

SRCREV_meta = "45ed8e95cf76700877552fd547672a9392409cbf"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "toradex_5.4.y"
LINUX_KERNEL_TYPE = "standard"
LINUX_KERNEL_TYPE_preempt-rt = "preempt-rt"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
