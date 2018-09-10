LINUX_VERSION ?= "4.18.7"

SRCREV = "9fdf76a11b2a214bed40f71da75c329422653dd9"
SRCBRANCH = "toradex_4.18.y"

SRC_URI = "git://gitlab.toradex.int/bsp/linux-toradex.git;protocol=http;branch=${SRCBRANCH};name=kernel \
    file://distro.scc \
    file://distro.cfg \
"

require recipes-kernel/linux/linux-lmp.inc
require recipes-kernel/linux/linux-lmp-machine-custom.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"
COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
