LINUX_VERSION ?= "4.18.6"

SRCREV = "9fb7886db99149912b83685ef2881bfb06074ee7"
SRCBRANCH = "toradex_4.18.y"

SRC_URI = "git://gitlab.toradex.int/bsp/linux-toradex.git;protocol=http;branch=${SRCBRANCH};name=kernel \
    file://distro.scc \
    file://distro.cfg \
"

require recipes-kernel/linux/linux-lmp.inc
require recipes-kernel/linux/linux-lmp-machine-custom.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
