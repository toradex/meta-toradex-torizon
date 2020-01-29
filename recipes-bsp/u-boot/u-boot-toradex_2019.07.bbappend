FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-2019.07:"

SRCREV = "694e2136eefc2d110f44b26218c03e44a1e88235"
SRCBRANCH = "toradex_2019.07-next"

SRC_URI_append += " \
    file://0001-colibri_imx7-use-distro-boot-by-default.patch \
    file://0002-colibri_imx6-use-distro-boot-by-default.patch \
    file://0003-apalis_imx6-use-distro-boot-by-default.patch \
    file://0004-colibri-imx6ull-use-distro-boot-by-default.patch \
    file://0001-qemuarm64-enable-support-for-fitimage.patch \
"

nand_padding_colibri-imx7 () {
    # This step is very specific to the TorizonCore U-Boot multi-config...
    dd bs=1024 count=1 if=/dev/zero | cat - ${B}/colibri_imx7_defconfig/${binary} > ${B}/colibri_imx7_defconfig/u-boot-nd.${UBOOT_SUFFIX}
}

RDEPENDS_${PN}_append_qemuarm64 = " u-boot-distro-boot"
