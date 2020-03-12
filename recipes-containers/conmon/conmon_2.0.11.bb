SUMMARY = "An OCI container runtime monitor"
SECTION = "console/utils"
HOMEPAGE = "https://github.com/containers/conmon"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=61af0b6932ea7b12fb9142721043bc77"

DEPENDS = "glib-2.0"

SRCREV = "ff9d97a08d7a4b58267ac03719786e4e7258cecf"
SRC_URI = "\
    git://github.com/containers/conmon.git \
"

SRC_URI[md5sum] = "5c711911d766d76813333c3812277574"
SRC_URI[sha256sum] = "4c31278b2c03e5be5a696c3088bc86cf2557a70e00f697799c163aba18e3c40e"

S = "${WORKDIR}/git"

inherit pkgconfig

EXTRA_OEMAKE = "PREFIX=${prefix} BINDIR=${bindir} LIBEXECDIR=${libexecdir}"

PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
PACKAGECONFIG[systemd] = ",,systemd"

do_install() {
    oe_runmake 'DESTDIR=${D}' install
}

FILES_${PN} += " \
    ${bindir}/conmon \
"
