LINUX_VERSION ?= "4.19.5"

SRCREV = "8b1f65e4372b5673503826af5c57bb5c624acc3e"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
