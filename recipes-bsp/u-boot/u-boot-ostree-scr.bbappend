FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_tordy = " \
    file://boot.cmd.in \
"

do_compile_tordy() {
    sed -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
        "${WORKDIR}/boot.cmd.in" > boot.cmd
    mkimage -A arm -T script -C none -n "Ostree boot script" -d "${WORKDIR}/boot.cmd" boot.scr
}

do_deploy_tordy() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}
}
