LINUX_VERSION ?= "5.2.3"

SRCREV_machine = "e1bfc3ddb9e2be45055e8e4835e22c48a1030103"
SRCREV_meta = "8592467f9c82b7e5657d50aba0e2e14942c99bcf"

KBRANCH = "toradex_5.2.y"
KMETABRANCH = "toradex_5.2.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
