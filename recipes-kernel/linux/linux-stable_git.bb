LINUX_VERSION ?= "4.19.11"

SRCREV_machine = "5656ec50dc9950db865d53306326b1a732e3738e"
SRCREV_meta ="97afc6b7178342e93997387ab34ff5162ed5960f"

KBRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
