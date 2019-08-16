LINUX_VERSION ?= "5.2.7"

SRCREV_machine = "74e785ce1024471e77b6fb9da83ffd60762c8cac"
SRCREV_meta = "6fdf802cedc5a4915dcfb6885389fcdc1d843a3b"

KBRANCH = "toradex_5.2.y"
KMETABRANCH = "toradex_5.2.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
