LINUX_VERSION ?= "4.18.14"

SRCREV = "601817f9c24c0b857c4f19953fae436ed3af8d93"
SRCBRANCH = "toradex_4.18.y"

SRC_URI = "git://gitlab.toradex.int/bsp/linux-toradex.git;protocol=http;branch=${SRCBRANCH};name=kernel \
    file://distro.scc \
    file://distro.cfg \
    file://ioaccounting.cfg \
"
export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-stable.inc
require recipes-kernel/linux/linux-stable-machine-custom.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
