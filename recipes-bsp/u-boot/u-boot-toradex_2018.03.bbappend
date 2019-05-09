FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-${PV}:"

SRC_URI += " \
    file://0001-apalis-imx8-use-distro-boot.patch \
    file://0002-apalis-imx8-add-scriptaddr-for-distroboot.patch \
    file://0003-apalis-imx8-enable-FDT-relocation.patch \
"

SRCREV = "b826429c457abf26d979ddf147d60269207ec80a"
SRCBRANCH = "toradex_imx_v2018.03_4.14.78_1.0.0_ga-bringup"
