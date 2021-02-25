FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-initial-support-for-docker-compose-secondaries.patch \
    file://0002-add-aktualizr-update-control-allow-block-mechanism.patch \
    file://0003-Integrate-Docker-Compose-with-Aktualizr.patch \
    file://rollback-manager \
    file://rollback-manager.service \
"

RDEPENDS_${PN}-configs += "aktualizr-docker-compose-sec aktualizr-polling-interval"

RDEPENDS_${PN}_class-target += "bash"

SYSTEMD_SERVICE_${PN} += "rollback-manager.service"

do_install_append() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/rollback-manager ${D}${bindir}/rollback-manager

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/rollback-manager.service ${D}${systemd_unitdir}/system/rollback-manager.service
}

FILES_${PN} += " \
                 ${bindir}/rollback-manager \
                 ${systemd_unitdir}/system/rollback-manager.service \
                 "
