FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-add-all-devicetrees-to-ostree.patch \
    file://ostree-pending-reboot.service \
    file://ostree-pending-reboot.path \
    file://0001-Avoid-race-condition-when-building-outside-of-source.patch \
"

SYSTEMD_SERVICE_${PN} += "ostree-pending-reboot.path ostree-pending-reboot.service"

do_install_append () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.path ${D}${systemd_system_unitdir}
}
