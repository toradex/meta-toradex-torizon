SUMMARY = "Common Torizon anonymous Telemetry"
DESCRIPTION = "Script to ping the Common Torizon server and collect information about the hardware that is booting Common Torizon"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

RDEPENDS:${PN} += "curl bash tdx-info"

SRC_URI = " \
    file://telemetry \
    file://telemetry.service \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/telemetry ${D}${sbindir}

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/telemetry.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "telemetry.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
