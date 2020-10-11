FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit bash-completion

SRC_URI_append = " \
    file://0001-deploy-support-devicetree-directory.patch \
    file://ostree-pending-reboot.service \
    file://ostree-pending-reboot.path \
"

SYSTEMD_SERVICE_${PN} += "ostree-pending-reboot.path ostree-pending-reboot.service"

DEPENDS_append_class-target = " u-boot-default-script"
RDEPENDS_${PN}_append_class-target = " ostree-uboot-env"

do_install_append () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.path ${D}${systemd_system_unitdir}
}
