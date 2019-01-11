LINUX_VERSION ?= "4.19.13"

SRCREV_machine = "43f61e8df71c474cd56b5c971096b9cf8d36cd95"
SRCREV_meta ="7f04d953fdf6c7a583cd258e5fe7127e5548a348"

KBRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
