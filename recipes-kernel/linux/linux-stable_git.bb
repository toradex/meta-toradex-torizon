LINUX_VERSION ?= "4.19.11"

SRCREV = "8becf59f4dab6581a67e13f1a90ecc49c5f27a97"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
