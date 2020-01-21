FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += " \
    file://psplash-start.service \
    ${SPLASH_PATCH} \
"

SRCREV = "8188d68191b8bc2349319e804aa5e5df6e019ec2"
LIC_FILES_CHKSUM = "file://psplash.h;beginline=1;endline=8;md5=8f232c1e95929eacab37f00900580224"

SPLASH_PATCH = "file://torizon-blue-splash.patch"
SPLASH_IMAGES = "file://torizon-blue.png;outsuffix=default"

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES','systemd','${PN}','',d)}"
SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('DISTRO_FEATURES','systemd','psplash-start.service','',d)}"

PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"

PACKAGECONFIG[systemd] = "--with-systemd,--without-systemd,systemd"

do_install_append () {
	install -d ${D}${systemd_unitdir}/system
	install -m 644 ${WORKDIR}/psplash-start.service ${D}/${systemd_unitdir}/system
}
