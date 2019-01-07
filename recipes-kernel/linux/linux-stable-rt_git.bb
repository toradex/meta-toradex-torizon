FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.8"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "6a082d8b56f739188cdcbac7cf412775a20447df"
SRCREV_meta ="addd650f31da316485489b9cbd685d6f9d567030"

KBRANCH = "toradex_4.19.y-rt"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

