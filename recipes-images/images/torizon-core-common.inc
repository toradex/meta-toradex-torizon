LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit core-image extrausers

set_user_group_append () {
	eval flock -x ${IMAGE_ROOTFS}${sysconfdir} -c \"$PSEUDO passwd -e -R ${IMAGE_ROOTFS} torizon\" || true
}

do_rootfs[cleandirs] += "${IMAGE_ROOTFS}"

TEZI_IMAGE_NAME = "${IMAGE_BASENAME}${IMAGE_BASENAME_SUFFIX}-${MACHINE}"
IMAGE_NAME = "${IMAGE_BASENAME}${IMAGE_BASENAME_SUFFIX}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
IMAGE_LINK_NAME = "${IMAGE_BASENAME}${IMAGE_BASENAME_SUFFIX}-${MACHINE}"

IMAGE_FEATURES += "splash"

SPLASH = "plymouth"

# Base packages
CORE_IMAGE_BASE_INSTALL_append = " \
    kernel-modules \
    linux-firmware-rtl8192cu \
    usermount \
    nano \
    set-hostname \
    systemd-analyze \
    sudo \
    torizon-conf \
    torizon-users \
    tzdata \
    udev-toradex-rules \
    wireless-regdb-static \
    ostree-customize-plymouth \
    network-configuration \
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

nss_altfiles_set_users_groups () {
    default_dir=${IMAGE_ROOTFS}/${libdir}
    override_dir=${IMAGE_ROOTFS}/${sysconfdir}
    nsswitch_conf=${IMAGE_ROOTFS}/${sysconfdir}/nsswitch.conf

    sed -i -e '/^passwd/s/$/ altfiles/' -e '/^group/s/$/ altfiles/' -e '/^shadow/s/$/ altfiles/' ${nsswitch_conf}
    install -d ${default_dir}
    install -m 644 ${override_dir}/passwd ${default_dir}/
    install -m 644 ${override_dir}/group ${default_dir}/
    install -m 400 ${override_dir}/shadow ${default_dir}/
    for file in passwd group shadow
    do
	cat > ${override_dir}/${file} <<- EOF
	# NSS altfiles module is installed. Default user, group and shadow files are in
	# /usr/lib/
	EOF
	grep -r torizon ${default_dir}/${file} >> ${override_dir}/${file}
    done
}

# include nss-altfiles support
CORE_IMAGE_BASE_INSTALL_append = ' ${@bb.utils.contains("DISTRO_FEATURES", "stateless-system", "nss-altfiles", "",d)}'
IMAGE_PREPROCESS_COMMAND_append = ' ${@bb.utils.contains("DISTRO_FEATURES", "stateless-system", "nss_altfiles_set_users_groups; ", "",d)}'
