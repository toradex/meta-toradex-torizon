LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-add-all-devicetrees-to-ostree.patch \
    file://ostree-pending-reboot.service \
    file://ostree-pending-reboot.path \
"

SRC_URI_remove = " \
    file://avoid-race-condition-tests-build.patch \
"

SYSTEMD_SERVICE_${PN} += "ostree-pending-reboot.path ostree-pending-reboot.service"

do_install_append () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.path ${D}${systemd_system_unitdir}
}
