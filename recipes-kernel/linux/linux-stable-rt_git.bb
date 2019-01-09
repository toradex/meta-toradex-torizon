FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.10"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "e9dcc568b2e968af848bbdb4267ba6cde5457b9e"
SRCREV_meta ="40c44931f57a6049a063b7df3159c1e32f99146a"

KBRANCH = "toradex_4.19.y-rt"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

