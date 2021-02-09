FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://plymouth \
    file://0001-only-scan-for-block-devices.patch \
    file://0002-redirect-console-when-conosle-null.patch \
"

PACKAGES_append = " initramfs-module-plymouth"

SUMMARY_initramfs-module-plymouth = "initramfs support for plymouth"
RDEPENDS_initramfs-module-plymouth = "${PN}-base plymouth ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-udev-rules', '', d)}"
FILES_initramfs-module-plymouth = "/init.d/02-plymouth"

do_install_append() {
        install -m 0755 ${WORKDIR}/plymouth ${D}/init.d/02-plymouth
}

