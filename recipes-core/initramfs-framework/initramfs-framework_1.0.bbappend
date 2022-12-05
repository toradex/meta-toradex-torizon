FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://plymouth \
    file://ostree \
    file://kmod \
    file://0001-Mount-run-with-tmpfs.patch \
    file://0002-only-scan-for-block-devices.patch \
"

PACKAGES:append = " \
    initramfs-module-plymouth \
    initramfs-module-ostree \
    initramfs-module-kmod \
"

SUMMARY:initramfs-module-plymouth = "initramfs support for plymouth"
RDEPENDS:initramfs-module-plymouth = "${PN}-base plymouth ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd-udev-rules', '', d)}"
FILES:initramfs-module-plymouth = "/init.d/02-plymouth"

SUMMARY:initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree = "/init.d/98-ostree"

SUMMARY:initramfs-module-kmod = "initramfs support for loading kernel modules"
RDEPENDS:initramfs-module-kmod = "${PN}-base"
FILES:initramfs-module-kmod = "\
    /init.d/01-kmod \
    /etc/modules-load.d/* \
"

do_install:append() {
    install -m 0755 ${WORKDIR}/plymouth ${D}/init.d/02-plymouth
    install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
    install -m 0755 ${WORKDIR}/kmod ${D}/init.d/01-kmod
}

# Adding modules so plymouth can show the splash screen during boot
SRC_URI:append:mx8-nxp-bsp = " file://50-imx8-graphics.conf"
RDEPENDS:initramfs-module-kmod:append:mx8-nxp-bsp = " \
    kernel-module-sec-dsim \
    kernel-module-sec-mipi-dsim-imx \
    kernel-module-ti-sn65dsi83 \
"

do_install:append:mx8-nxp-bsp() {
    install -d ${D}/etc/modules-load.d/
    install -m 0755 ${WORKDIR}/50-imx8-graphics.conf ${D}/etc/modules-load.d/50-imx8-graphics.conf
}
