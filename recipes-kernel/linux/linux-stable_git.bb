LINUX_VERSION ?= "5.0.19"

SRCREV_machine = "2115c1bc6e396d5ffe9ecbe394d1c50a6e25c404"
SRCREV_meta = "fc66c71607f5ce340a72c8e3df2548684dd46631"

KBRANCH = "toradex_5.0.y"
KMETABRANCH = "toradex_5.0.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
