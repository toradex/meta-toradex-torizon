LINUX_VERSION ?= "4.20.3"

SRCREV_machine = "464b2d557c2a4f8b62cacd0341a3c72cdbbe2f60"
SRCREV_meta = "36408d5c57ec4ca93b17e5b9143732128f0409ea"

KBRANCH = "toradex_4.20.y"
KMETABRANCH = "toradex_4.20.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
