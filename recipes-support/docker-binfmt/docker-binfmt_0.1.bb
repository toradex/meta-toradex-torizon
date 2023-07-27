SUMMARY = "Start binfmt-support from Docker torizon/binfmt"
DESCRIPTION = "Start binfmt-support from Docker torizon/binfmt"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

RDEPENDS:${PN} += " bash docker"

SRC_URI = " \
    file://docker-binfmt \
    file://docker-binfmt.service \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/docker-binfmt ${D}${sbindir}

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/docker-binfmt.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "docker-binfmt.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
