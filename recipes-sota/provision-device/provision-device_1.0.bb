SUMMARY = "Provision-device is a service to manually provision \
the device to the Platform Services"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://provision-device \
"

S = "${WORKDIR}"

RDEPENDS:${PN} = "bash jq curl unzip"

inherit allarch

do_install() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/provision-device ${D}${sbindir}
}
