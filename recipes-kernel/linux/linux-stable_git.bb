LINUX_VERSION ?= "5.0.8"

SRCREV_machine = "2136d9515afb95a10fe9c2a2da1b54d31caa2e42"
SRCREV_meta = "8590c75f5653c6653a56b0b051f5f5304d12ba80"

KBRANCH = "toradex_5.0.y"
KMETABRANCH = "toradex_5.0.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
