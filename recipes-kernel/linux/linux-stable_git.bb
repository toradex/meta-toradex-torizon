LINUX_VERSION ?= "4.19.4"

SRCREV = "a4805e5a2f40a7ec1d7a17ad05067b3d88340017"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
