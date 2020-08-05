FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://0001-apalis_imx6-use-distro-boot-by-default.patch \
    file://0002-colibri_imx6-boot-from-eMMC-by-default.patch \
    file://0003-colibri-imx6ull-use-distro-boot-by-default.patch \
    file://0004-colibri_imx7-use-distro-boot-by-default.patch \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"

SRC_URI_append_colibri-imx6ull = " \
    file://fw_env-mtd.config \
"

SRC_URI_append_colibri-imx7 = " \
    file://fw_env-emmc.config \
    file://fw_env-mtd.config \
"

SRC_URI_append_qemuarm64 = " \
    file://0001-qemu-arm-support-saving-env-in-boot-partition.patch \
    file://fitfatenv.cfg \
    file://fw_env-sda.config \
"

FILES_${PN}-env += "${sysconfdir}/fw_env*"

do_install_append_qemuarm64 () {
    install -m 0644 ${WORKDIR}/fw_env-sda.config ${D}${sysconfdir}/fw_env.config
}

do_install_append_colibri-imx6ull () {
    install -m 0644 ${WORKDIR}/fw_env-mtd.config ${D}${sysconfdir}/fw_env.config
}

do_install_append_colibri-imx7 () {
    rm -f ${D}${sysconfdir}/fw_env.config
    rm -f ${D}${sysconfdir}/u-boot-initial-env

    install -m 0644 ${WORKDIR}/fw_env-emmc.config ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/fw_env-mtd.config ${D}${sysconfdir}
}

nand_padding_colibri-imx7 () {
    # This step is very specific to the TorizonCore U-Boot multi-config...
    dd bs=1024 count=1 if=/dev/zero | cat - ${B}/colibri_imx7_defconfig/${binary} > ${B}/colibri_imx7_defconfig/u-boot-nd.${UBOOT_SUFFIX}
}

pkg_postinst_ontarget_${PN}-env_colibri-imx7 () {
    if [ "x$D" != "x" ]
    then
        exit 1
    fi

    # first determine if fw_env.config is present. In case
    # of colibri-imx7, we have emmc and mtd based files
    # and need to use the correct one according to the storage
    # type
    if [ -e /dev/mmcblk*boot0 ]
    then
        ln -sf ${sysconfdir}/fw_env-emmc.config ${sysconfdir}/fw_env.config
        ln -sf ${sysconfdir}/u-boot-initial-env-sd ${sysconfdir}/u-boot-initial-env
    else
        ln -sf ${sysconfdir}/fw_env-mtd.config ${sysconfdir}/fw_env.config
        ln -sf ${sysconfdir}/u-boot-initial-env-nd ${sysconfdir}/u-boot-initial-env
    fi
}
