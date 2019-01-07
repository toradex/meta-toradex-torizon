FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.8"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "6a082d8b56f739188cdcbac7cf412775a20447df"
SRCREV_meta ="97afc6b7178342e93997387ab34ff5162ed5960f"

KBRANCH = "toradex_4.19.y-rt"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

