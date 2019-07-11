FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI += " \
    file://0001-apalis-imx8-load-HDMI-firmware-and-use-distro-boot-b.patch \
"

SRCREV = "0dd07626f74e9067898f57cd5dd726438b204921"
SRCBRANCH = "toradex_imx_v2018.03_4.14.78_1.0.0_ga-bringup"
