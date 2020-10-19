FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

FW_ENV_CONFIG = ""
FW_ENV_CONFIG_colibri-imx6ull = "fw_env-mtd.config"
FW_ENV_CONFIG_colibri-imx7 = "fw_env-mtd.config"
FW_ENV_CONFIG_qemuarm64 = "fw_env-sda.config"

SRC_URI_append = " \
    file://0001-apalis_imx6-use-distro-boot-by-default.patch \
    file://0002-colibri-imx6ull-use-distro-boot-by-default.patch \
    file://0003-colibri_imx7-use-distro-boot-by-default.patch \
    file://bootcount.cfg \
    file://bootlimit.cfg \
    ${@oe.utils.ifelse('${FW_ENV_CONFIG}' != '', 'file://${FW_ENV_CONFIG}', '')} \
"

do_install_append () {
    if [ -f ${WORKDIR}/${FW_ENV_CONFIG} ]; then
        install -m 0644 ${WORKDIR}/${FW_ENV_CONFIG} ${D}${sysconfdir}/fw_env.config
    fi
}
