FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append += " \
    file://0001-apalis_imx6-use-distro-boot-by-default.patch \
    file://0002-colibri_imx6-boot-from-eMMC-by-default.patch \
    file://0003-colibri-imx6ull-use-distro-boot-by-default.patch \
    file://0004-colibri_imx7-use-distro-boot-by-default.patch \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"

SRC_URI_append_qemuarm64 = " \
    file://0001-qemu-arm-support-saving-env-in-boot-partition.patch \
    file://fitfatenv.cfg \
"

nand_padding_colibri-imx7 () {
    # This step is very specific to the TorizonCore U-Boot multi-config...
    dd bs=1024 count=1 if=/dev/zero | cat - ${B}/colibri_imx7_defconfig/${binary} > ${B}/colibri_imx7_defconfig/u-boot-nd.${UBOOT_SUFFIX}
}
