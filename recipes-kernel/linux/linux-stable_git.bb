LINUX_VERSION ?= "4.19.8"

SRCREV = "c6051ffcb824b7491419c6ac407b1a6d7756dcab"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
