FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

FW_ENV_CONFIG = ""
FW_ENV_CONFIG_colibri-imx6ull = "fw_env-mtd.config"
FW_ENV_CONFIG_colibri-imx7 = "fw_env-mtd.config"
FW_ENV_CONFIG_qemuarm64 = "fw_env-sda.config"

SRC_URI_append = " \
    file://bootcommand.cfg \
    file://bootcount.cfg \
    file://bootlimit.cfg \
    ${@oe.utils.ifelse('${FW_ENV_CONFIG}' != '', 'file://${FW_ENV_CONFIG}', '')} \
"

SRC_URI_append_use-mainline-bsp = " \
    file://0001-colibri-imx6ull-colibri_imx7-add-ubifs-distro-boot-s.patch \
"

do_install_append () {
    if [ -f ${WORKDIR}/${FW_ENV_CONFIG} ]; then
        install -m 0644 ${WORKDIR}/${FW_ENV_CONFIG} ${D}${sysconfdir}/fw_env.config
    fi
}
