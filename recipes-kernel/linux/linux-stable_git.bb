LINUX_VERSION ?= "4.19.6"

SRCREV = "2e7e9a84490976af7a715a347969eadf3240c51b"
SRCBRANCH = "toradex_4.19.y"

require recipes-kernel/linux/linux-stable.inc

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"
