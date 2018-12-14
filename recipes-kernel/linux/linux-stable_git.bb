LINUX_VERSION ?= "4.19.9"

SRCREV = "9b16f34dfe4f57d38e9084d4ac8e0a0995505a18"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
