LINUX_VERSION ?= "4.20.5"

SRCREV_machine = "fc1098a3d59fa1edd062737a1468fb684495e235"
SRCREV_meta = "35182fa6efbe1bea4b6ff015090b5374f38eaf4f"

KBRANCH = "toradex_4.20.y"
KMETABRANCH = "toradex_4.20.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
