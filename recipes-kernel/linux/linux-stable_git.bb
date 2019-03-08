LINUX_VERSION ?= "4.20.14"

SRCREV_machine = "8ccc4bfd08f1f8c5da48084c66ff46022d9db273"
SRCREV_meta = "8590c75f5653c6653a56b0b051f5f5304d12ba80"

KBRANCH = "toradex_4.20.y"
KMETABRANCH = "toradex_4.20.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
