FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://plymouth \
    file://ostree \
    file://run-tmpfs.patch \
    file://0001-only-scan-for-block-devices.patch \
    file://0002-redirect-console-when-conosle-null.patch \
"

PACKAGES_append = " \
    initramfs-module-plymouth \
    initramfs-module-ostree \
"

SUMMARY_initramfs-module-plymouth = "initramfs support for plymouth"
RDEPENDS_initramfs-module-plymouth = "${PN}-base plymouth ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-udev-rules', '', d)}"
FILES_initramfs-module-plymouth = "/init.d/02-plymouth"

SUMMARY_initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS_initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES_initramfs-module-ostree = "/init.d/98-ostree"

do_install_append() {
        install -m 0755 ${WORKDIR}/plymouth ${D}/init.d/02-plymouth
        install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
}
