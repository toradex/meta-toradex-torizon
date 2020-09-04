SUMMARY = "Simple C Automounter based on udisks2"
DESCRIPTION = "usermount is a small C program that interacts with UDisks2 \
via D-Bus to automount removable devices as a normal user."
SECTION = "applications"
PRIORITY = "optional"
HOMEPAGE="https://github.com/tom5760/usermount"
LICENSE = "GPLv2"

DEPENDS = "udisks2"
RDEPENDS_${PN} = "udisks2"

LIC_FILES_CHKSUM = "file://LICENSE;md5=74711154e9c987a4d5c87fc8d89e279f"

SRC_URI = " \
    git://github.com/tom5760/usermount;protocol=https \
    file://usermount.service \
"

SRCREV = "55fdfc7d3fcc0e7121c2ed9f01d0ab1271bb5fd3"
PV = "1.0.0+git${SRCPV}"

S = "${WORKDIR}/git"

inherit pkgconfig systemd

EXTRA_OEMAKE += "ENABLE_LIBNOTIFY=0"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "usermount.service"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/usermount ${D}${bindir}

    install -d ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/usermount.service ${D}/${systemd_system_unitdir}
}
