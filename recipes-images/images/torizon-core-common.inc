LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

TEZI_IMAGE_NAME = "${IMAGE_BASENAME}-${MACHINE}"

inherit core-image extrausers

set_user_group_append () {
	eval flock -x ${IMAGE_ROOTFS}${sysconfdir} -c \"$PSEUDO passwd -e -R ${IMAGE_ROOTFS} torizon\" || true
}

do_rootfs[cleandirs] += "${IMAGE_ROOTFS}"

IMAGE_FEATURES += "splash"

SPLASH = "plymouth"

# Base packages
CORE_IMAGE_BASE_INSTALL_append = " \
    kernel-modules \
    linux-firmware-rtl8192cu \
    media-mountpoint \
    set-hostname \
    sudo \
    torizon-conf \
    torizon-users \
    tzdata \
    udev-toradex-rules \
    wireless-regdb-static \
    ostree-customize-plymouth \
    virtual/network-configuration \
    u-boot-fw-utils \
"

CORE_IMAGE_BASE_INSTALL_append_colibri-imx6ull = " \
    linux-firmware-sd8887 \
    linux-firmware-sd8997 \
    mwifiexap \
"

CORE_IMAGE_BASE_INSTALL_append_mx8 = " \
    kernel-module-imx-gpu-viv \
    mwifiexap \
    backports \
"
