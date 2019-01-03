FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.8"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "780c5af3a38431370dfa04331626d621a256d692"
SRCREV_meta ="37451e2591eed639cddc91a2193a682696e37251"

KBRANCH = "toradex_4.19.y-rt"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

