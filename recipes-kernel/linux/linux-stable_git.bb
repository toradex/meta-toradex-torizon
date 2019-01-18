LINUX_VERSION ?= "4.19.13"

SRCREV_machine = "43f61e8df71c474cd56b5c971096b9cf8d36cd95"
SRCREV_meta = "539ccdbf257b46e74a5be9bcb80c4a756a69f018"

KBRANCH = "toradex_4.19.y"
KMETABRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
