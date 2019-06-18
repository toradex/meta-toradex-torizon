FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.50"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "d15d0b7a9f89cf5a905ad6802eb23100c8063939"
SRCREV_meta = "539ccdbf257b46e74a5be9bcb80c4a756a69f018"

KBRANCH = "toradex_4.19.y-rt"
KMETABRANCH = "toradex_4.19.y"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

