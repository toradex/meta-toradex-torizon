LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "${DISTRO_VERSION}"

# Always create vmdk and vdi images for the compatible targets
IMAGE_FSTYPES_append_intel-corei7-64 = " wic.vmdk wic.vdi"

inherit core-image extrausers

# Base packages
CORE_IMAGE_BASE_INSTALL += " \
    sudo \
    torizon-conf \
"

EXTRA_USERS_PARAMS = " \
    useradd -P torizon torizon; \
    usermod -a -G sudo,users,plugdev torizon; \
"

set_user_group_append () {
	eval flock -x ${IMAGE_ROOTFS}${sysconfdir} -c \"$PSEUDO passwd -e -R ${IMAGE_ROOTFS} torizon\" || true
}
