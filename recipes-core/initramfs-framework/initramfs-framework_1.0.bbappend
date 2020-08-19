FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://psplash \
    file://plymouth \
    file://0001-only-scan-for-block-devices.patch \
    file://0002-redirect-console-when-conosle-null.patch \
"

PACKAGES_append = " initramfs-module-psplash initramfs-module-plymouth"

SUMMARY_initramfs-module-psplash = "initramfs support for psplash"
RDEPENDS_initramfs-module-psplash = "${PN}-base psplash"
FILES_initramfs-module-psplash = "/init.d/00-psplash"

SUMMARY_initramfs-module-plymouth = "initramfs support for plymouth"
RDEPENDS_initramfs-module-plymouth = "${PN}-base plymouth ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-udev-rules', '', d)}"
FILES_initramfs-module-plymouth = "/init.d/02-plymouth"

do_install_append() {
        install -m 0755 ${WORKDIR}/psplash ${D}/init.d/00-psplash
        install -m 0755 ${WORKDIR}/plymouth ${D}/init.d/02-plymouth
}

