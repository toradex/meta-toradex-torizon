FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-mainline:"

require linux-toradex-version.inc
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

SRCREV_meta = "90c6e8f1ed6720fd3274922bf4d985ee4cb92903"

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

