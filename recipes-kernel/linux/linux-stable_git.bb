LINUX_VERSION ?= "4.19.6"

SRCREV = "b62d18524e9e96d0a5252048827523cd07fa2fc6"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
