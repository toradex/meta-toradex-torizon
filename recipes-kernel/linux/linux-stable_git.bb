LINUX_VERSION ?= "4.19.1"

SRCREV = "86f0ef88efb6755a18cc4eb999783ca3bd8bc2f7"
SRCBRANCH = "toradex_4.19.y"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=https;branch=${SRCBRANCH};name=kernel \
    file://distro.scc \
    file://distro.cfg \
    file://ioaccounting.cfg \
"
export DTC_FLAGS = "-@"

require recipes-kernel/linux/linux-stable.inc
require recipes-kernel/linux/linux-stable-machine-custom.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
