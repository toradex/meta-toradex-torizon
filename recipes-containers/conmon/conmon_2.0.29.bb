SUMMARY = "An OCI container runtime monitor"
SECTION = "console/utils"
HOMEPAGE = "https://github.com/containers/conmon"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=61af0b6932ea7b12fb9142721043bc77"

DEPENDS = "glib-2.0 go-md2man-native"

SRCREV = "7e6de6678f6ed8a18661e1d5721b81ccee293b9b"
SRC_URI = "\
    git://github.com/containers/conmon.git;protocol=https;branch=main \
"

PV = "2.0.29+git${SRCPV}"

S = "${WORKDIR}/git"

inherit pkgconfig

EXTRA_OEMAKE = "PREFIX=${prefix} BINDIR=${bindir} LIBEXECDIR=${libexecdir}"

PACKAGECONFIG ??= "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
PACKAGECONFIG[systemd] = ",,systemd"

do_install() {
    oe_runmake 'DESTDIR=${D}' install
}
