SUMMARY = "Remote access client (RAC) for TorizonCore"
LICENSE = "CLOSED"

inherit systemd

# Main source respository
SRC_URI = " \
    git://github.com/toradex/remote-access-client.git;protocol=https;branch=main \
    file://remote-access.service \
    file://client.toml \
"

SRCREV = "7ecb91932a38c7b5529f4c2d261dc4d1acdf78f6"
SRCREV:use-head-next = "${AUTOREV}"

S = "${WORKDIR}/git"

SYSTEMD_SERVICE:${PN} = "remote-access.service"
# Keep disabled by default for now
SYSTEMD_AUTO_ENABLE:${PN} = "disable"

PV = "0.0+git${SRCPV}"

RAC_BINARY = "rac-32"
RAC_BINARY:mx8-nxp-bsp = "rac-64"
RAC_BINARY:qemuarm64 = "rac-64"

do_install () {
    install -d ${D}${bindir}/
    install -m 0755 ${S}/${RAC_BINARY} ${D}${bindir}/rac

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/remote-access.service ${D}${systemd_unitdir}/system/remote-access.service

    install -d ${D}${sysconfdir}/rac
    install -m 0644 ${WORKDIR}/client.toml ${D}${sysconfdir}/rac
}

INSANE_SKIP:${PN} += "already-stripped arch"
