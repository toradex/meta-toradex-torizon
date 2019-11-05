FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://psplash \
    file://0001-only-scan-for-block-devices.patch \
"

PACKAGES_append = " initramfs-module-psplash"

SUMMARY_initramfs-module-psplash = "initramfs support for psplash"
RDEPENDS_initramfs-module-psplash = "${PN}-base psplash"
FILES_initramfs-module-psplash = "/init.d/00-psplash"

do_install_append() {
        install -m 0755 ${WORKDIR}/psplash ${D}/init.d/00-psplash
}

