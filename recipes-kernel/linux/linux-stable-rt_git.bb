FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.5"

SRCREV = "dfbdf77918b887c9a62d430c55bb654572826d9e"
SRCBRANCH = "toradex_4.19.y-rt"

SRC_URI += "file://distro-rt.cfg"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
