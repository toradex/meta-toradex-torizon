SUMMARY = "Script to get useful information about Toradex Hardware."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://tdx-info"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/tdx-info ${D}${bindir}
}
