FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.59"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "3758b8bd81966b63dc93093a323e9bdd734545fd"
SRCREV_meta = "539ccdbf257b46e74a5be9bcb80c4a756a69f018"

KBRANCH = "toradex_4.19.y-rt"
KMETABRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

