FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-2019.07:"

LOCALVERSION = "-${DISTRO_VERSION}"

SRCREV = "e1cbe8c74e87036e649b0e34656aebabb3aa00c7"

SRC_URI_append += " \
    file://0001-colibri_imx7-use-distro-boot-by-default.patch \
    file://0001-colibri_imx7-add-addresses-required-for-distro-boot.patch \
    file://0001-colibri_imx6-use-distro-boot-by-default.patch \
    file://0002-apalis_imx6-use-distro-boot-by-default.patch \
    file://0003-colibri-imx6ull-use-distro-boot-by-default.patch \
"

nand_padding_colibri-imx7 () {
    # This step is very specific to the TorizonCore U-Boot multi-config...
    dd bs=1024 count=1 if=/dev/zero | cat - ${B}/colibri_imx7_defconfig/${binary} > ${B}/colibri_imx7_defconfig/u-boot-nd.${UBOOT_SUFFIX}
}
