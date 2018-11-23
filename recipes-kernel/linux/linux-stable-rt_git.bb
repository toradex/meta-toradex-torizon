FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.4"

SRCREV = "9dd45f508cf6835703d107e9fb8756a7771eaa22"
SRCBRANCH = "toradex_4.19.y-rt"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=https;branch=${SRCBRANCH};name=kernel \
    file://distro.scc \
    file://distro.cfg \
    file://distro-rt.cfg \
    file://ioaccounting.cfg \
"
export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-stable.inc

KBUILD_DEFCONFIG_mx6 ?= "imx_v6_v7_defconfig"
KBUILD_DEFCONFIG_mx7 ?= "imx_v6_v7_defconfig"
SRC_URI_append_imx += " file://imx.scc file://imx.cfg"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
