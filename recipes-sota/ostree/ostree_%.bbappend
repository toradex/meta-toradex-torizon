FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit bash-completion

SRC_URI:append = " \
    file://0001-update-default-grub-cfg-header.patch \
    file://0002-Add-support-for-the-fdtfile-variable-in-uEnv.txt.patch \
    file://ostree-pending-reboot.service \
    file://ostree-pending-reboot.path \
"

# Disable PTEST for ostree as it requires options that are not enabled when
# building with meta-updater
PTEST_ENABLED = "0"

# gpgme is not required, and it brings GPLv3 dependencies
PACKAGECONFIG:remove = "gpgme"

SYSTEMD_SERVICE:${PN} += "ostree-pending-reboot.path ostree-pending-reboot.service"

DEPENDS:append:class-target = " ${@'u-boot-default-script' if '${PREFERRED_PROVIDER_u-boot-default-script}' else ''}"
RDEPENDS:${PN}:append:class-target = " ${@'ostree-uboot-env' if '${PREFERRED_PROVIDER_u-boot-default-script}' else ''}"

do_install:append () {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/ostree-pending-reboot.path ${D}${systemd_system_unitdir}
}
