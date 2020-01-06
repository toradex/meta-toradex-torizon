LINUX_VERSION ?= "5.4.2"
PV = "${LINUX_VERSION}+git${SRCPV}"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc
inherit toradex-kernel-localversion

SRCREV_machine = "a1a7b308314d5b95d1a4fe2b1a4359fe8467684a"
SRCREV_meta = "a783aeb31050d5b5b41afaf3b5ff7e4c5971e84f"

KBRANCH = "toradex_5.4.y"
KMETABRANCH = "toradex_5.4.y"
LINUX_KERNEL_TYPE = "standard"
LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += " \
    git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
"

