LINUX_VERSION ?= "4.19.4"

SRCREV = "a4805e5a2f40a7ec1d7a17ad05067b3d88340017"
SRCBRANCH = "toradex_4.19.y"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=https;branch=${SRCBRANCH};name=kernel \
    file://distro.scc \
    file://distro.cfg \
    file://ioaccounting.cfg \
    file://0001-enable-lm816.patch \
"
export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-stable.inc

KBUILD_DEFCONFIG_mx6 ?= "imx_v6_v7_defconfig"
KBUILD_DEFCONFIG_mx7 ?= "imx_v6_v7_defconfig"
SRC_URI_append_imx += " file://imx.scc file://imx.cfg"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
