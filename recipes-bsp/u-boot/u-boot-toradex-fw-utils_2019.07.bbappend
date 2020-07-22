FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-2019.07:"

SRC_URI_append_colibri-imx7 = " \
    file://fw_env-emmc.config \
    file://fw_env-mtd.config \
"

SRC_URI_append = " \
    file://avoid_overwriting_same_value_to_avoid_flash_wear_out.patch \
"

do_install_colibri-imx7() {
    install -d ${D}${base_sbindir}
    install -d ${D}${sysconfdir}

    install -m 755 ${S}/tools/env/fw_printenv ${D}${base_sbindir}/fw_printenv
    ln -s fw_printenv ${D}${base_sbindir}/fw_setenv

    #for colibri imx7, we need both emmc and mtd based device in the rootfs
    if [ -e ${WORKDIR}/fw_env-emmc.config ]; then
        install -m 0644 ${WORKDIR}/fw_env-emmc.config ${D}${sysconfdir}/fw_env-emmc.config
    fi

    if [ -e ${WORKDIR}/fw_env-mtd.config ]; then
        install -m 0644 ${WORKDIR}/fw_env-mtd.config ${D}${sysconfdir}/fw_env-mtd.config
    fi
}

pkg_postinst_ontarget_${PN}_colibri-imx7 () {
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
	selected_config_file=fw_env-emmc.config
    else
	selected_config_file=fw_env-mtd.config
    fi

    if [ ! -s "/etc/fw_env.config" ]
    then
	if [ -a "/etc/$selected_config_file" ]
	then
            ln -s /etc/$selected_config_file /etc/fw_env.config
	else
	    echo "no fw_env.conf found.exiting..."
	    exit 2
	fi
    fi
}

do_install_append_colibri-imx7() {
    install_unlock_emmc
}

