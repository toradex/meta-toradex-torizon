LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

SRC_URI += " \
    file://set-hostname.service \
    file://sethostname.sh \
"

FILES_${PN} = " \
    ${systemd_system_unitdir} \
    ${bindir} \
"

SYSTEMD_SERVICE_${PN} = " \
    set-hostname.service \
"

do_install () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/set-hostname.service ${D}${systemd_system_unitdir}
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/sethostname.sh ${D}${bindir}
}
