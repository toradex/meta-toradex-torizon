LINUX_VERSION ?= "4.19.13"

SRCREV_machine = "43f61e8df71c474cd56b5c971096b9cf8d36cd95"
SRCREV_meta ="40c44931f57a6049a063b7df3159c1e32f99146a"

KBRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
