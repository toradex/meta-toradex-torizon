FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://docker-compose \
"

do_install:append() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/docker-compose ${D}${bindir}
}
