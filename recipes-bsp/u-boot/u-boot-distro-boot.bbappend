FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_qemuarm64 = " \
    file://boot.cmd.qemuarm64 \
"

KERNEL_BOOTCMD_qemuarm64 ?= "bootm"

do_deploy_prepend_qemuarm64() {
    mv ${WORKDIR}/boot.cmd.qemuarm64 ${WORKDIR}/boot.cmd.in
}
