FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " file://fw_env.config"

PACKAGE_ARCH = "${MACHINE_ARCH}"

RRECOMMENDS:${PN} += "u-boot-default-env"

do_install:append() {
    install -d ${D}/${sysconfdir}
    install -m 0644 ${WORKDIR}/fw_env.config ${D}/${sysconfdir}/
}
