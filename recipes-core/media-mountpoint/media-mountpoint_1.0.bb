LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

SRC_URI += " \
    file://media-mountpoint.service \
    file://mediamountpoint.sh \
"

FILES_${PN} = " \
    ${systemd_system_unitdir} \
    ${bindir} \
"

SYSTEMD_SERVICE_${PN} = " \
    media-mountpoint.service \
"

do_install () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/media-mountpoint.service ${D}${systemd_system_unitdir}
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/mediamountpoint.sh ${D}${bindir}
}
