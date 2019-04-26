LINUX_VERSION ?= "4.20.17"

SRCREV_machine = "9d9ea7dde2646ba8e36037e2679f2d98080df36b"
SRCREV_meta = "8590c75f5653c6653a56b0b051f5f5304d12ba80"

KBRANCH = "toradex_4.20.y"
KMETABRANCH = "toradex_4.20.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
