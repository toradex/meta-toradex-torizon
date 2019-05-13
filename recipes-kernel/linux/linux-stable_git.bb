LINUX_VERSION ?= "5.0.8"

SRCREV_machine = "2136d9515afb95a10fe9c2a2da1b54d31caa2e42"
SRCREV_meta = "fc66c71607f5ce340a72c8e3df2548684dd46631"

KBRANCH = "toradex_5.0.y"
KMETABRANCH = "toradex_5.0.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
