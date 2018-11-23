FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.4"

SRCREV = "9dd45f508cf6835703d107e9fb8756a7771eaa22"
SRCBRANCH = "toradex_4.19.y-rt"

SRC_URI += "file://distro-rt.cfg"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
