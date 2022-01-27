SUMMARY = "Auto-provisioning is a service to automatically provision \
the device to the Platform Services"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://auto-provisioning.service \
    file://auto-provisioning.sh \
"

S = "${WORKDIR}"

RDEPENDS_${PN} = "bash jq"

inherit allarch systemd

SYSTEMD_SERVICE_${PN} = "auto-provisioning.service"

do_install() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/auto-provisioning.service ${D}${systemd_unitdir}/system
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/auto-provisioning.sh ${D}${sbindir}
}
