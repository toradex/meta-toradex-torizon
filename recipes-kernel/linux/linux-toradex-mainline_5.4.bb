LINUX_VERSION ?= "5.4.18"
PV = "${LINUX_VERSION}+git${SRCPV}"

require recipes-kernel/linux/linux-toradex-mainline.inc
require recipes-kernel/linux/linux-yocto.inc

python __anonymous () {
    # A temporary fix for a inter-task dependency issue in kernel-yocto.bbclass, in
    # which, kernel_checkout should run after do_symlink_kernsrc rather than do_unpack.
    #
    # A patch has been sent to OE mail list on 2020-03-04, reference:
    # http://lists.openembedded.org/pipermail/openembedded-core/2020-March/293911.html
    #
    # We need this temproary hack here until that patch merged in OE layer.
    bb.build.addtask('do_kernel_checkout', 'do_kernel_metadata', 'do_symlink_kernsrc', d)
}

SRCREV_machine = "6c215c3541d4a7ac1e13a6c305e2bf3cfc0117e5"
SRCREV_meta = "bc3a6a8b0bd0cd5e08cbf655227327f222fccf90"

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
