LINUX_VERSION ?= "4.20.10"

SRCREV_machine = "25dd7cfeca7a17031ab5411fa48e6e0b49b4b614"
SRCREV_meta = "8590c75f5653c6653a56b0b051f5f5304d12ba80"

KBRANCH = "toradex_4.20.y"
KMETABRANCH = "toradex_4.20.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
