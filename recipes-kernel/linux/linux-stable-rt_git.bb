FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.8"

SRCREV = "780c5af3a38431370dfa04331626d621a256d692"
SRCBRANCH = "toradex_4.19.y-rt"

SRC_URI += "file://distro-rt.cfg"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
