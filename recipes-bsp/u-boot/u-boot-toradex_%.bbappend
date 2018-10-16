require recipes-bsp/u-boot/u-boot-toradex-env.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-distro-boot-ostree"

LOCALVERSION = "-${DISTRO_VERSION}"

SRCREV = "f4db39ecb6319affd10b5a10212d7af3148ca731"

SRC_URI_append += " \
    file://0001-colibri_imx7-prefer-non-secure-mode-by-default.patch \
    file://0002-colibri_imx7-run-distro_bootcmd-by-default.patch \
    file://0003-colibri_imx6-use-distro-boot-by-default.patch \
    file://0004-apalis_imx6-use-distro-boot-by-default.patch \
    file://0005-colibri-apalis-boot-from-internal-eMMC-first.patch \
"
