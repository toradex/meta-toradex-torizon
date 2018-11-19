require recipes-bsp/u-boot/u-boot-toradex-env.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-distro-boot-ostree"

LOCALVERSION = "-${DISTRO_VERSION}"

SRCREV = "07edca0bb81857a339f26f3465d5c5602705a94d"

SRC_URI_append += " \
    file://0001-colibri_imx7-prefer-non-secure-mode-by-default.patch \
    file://0002-colibri_imx7-run-distro_bootcmd-by-default.patch \
    file://0003-colibri_imx6-use-distro-boot-by-default.patch \
    file://0004-apalis_imx6-use-distro-boot-by-default.patch \
    file://0005-colibri-apalis-boot-from-internal-eMMC-first.patch \
    file://0006-colibri_imx6ull-run-distro_bootcmd-by-default.patch \
"
