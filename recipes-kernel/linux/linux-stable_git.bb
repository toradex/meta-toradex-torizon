LINUX_VERSION ?= "4.19.11"

SRCREV_machine = "8becf59f4dab6581a67e13f1a90ecc49c5f27a97"
SRCREV_meta ="37451e2591eed639cddc91a2193a682696e37251"

KBRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc
