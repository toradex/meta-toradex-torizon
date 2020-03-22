LINUX_VERSION ?= "5.4.24"
PV = "${LINUX_VERSION}+git${SRCPV}"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

python __anonymous () {
    # A temporary fix for a inter-task dependency issue in kernel-yocto.bbclass, in
    # which, kernel_checkout should run after do_symlink_kernsrc rather than do_unpack.
    #
    # It's been fixed in OE upstream, reference:
    # https://git.openembedded.org/openembedded-core/commit/?id=965090f42bc0576e938a0575b7938a1ff60b0018
    #
    # We need this temproary hack here until that patch is cherry-picked to OE zeus branch.
    bb.build.addtask('do_kernel_checkout', 'do_kernel_metadata', 'do_symlink_kernsrc', d)
}

SRCREV_machine = "8c030f32e991c5fe7153ee2671b497b0b88f8d0a"
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

