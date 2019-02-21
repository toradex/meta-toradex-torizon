FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit systemd

DEPENDS += "systemd"

SRC_URI += " \
    file://psplash-start.service \
    file://torizon-blue-splash.patch \
    file://0001-use-run-for-communication-fifo.patch \
    file://0002-process-consecutive-commands.patch \
    file://0003-add-systemd-support.patch \
"

SPLASH_IMAGES = "file://torizon-blue-img.h;outsuffix=default"

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES','systemd','${PN}','',d)}"
SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('DISTRO_FEATURES','systemd','psplash-start.service','',d)}"

do_install_append () {
	install -d ${D}${systemd_unitdir}/system
	install -m 644 ${WORKDIR}/*.service ${D}/${systemd_unitdir}/system
}
