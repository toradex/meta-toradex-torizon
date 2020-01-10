LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://10-toradex-net-rename.rules \
    file://90-toradex-gpio.rules \
    file://99-toradex.rules \
    file://toradex-net-rename.sh \
"

do_install () {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/10-toradex-net-rename.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/90-toradex-gpio.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/99-toradex.rules ${D}${sysconfdir}/udev/rules.d/

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/toradex-net-rename.sh ${D}${bindir}/
}
