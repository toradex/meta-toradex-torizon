FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable:"

LINUX_VERSION ?= "4.19.10"
LINUX_KERNEL_TYPE = "preempt-rt"

SRCREV_machine = "e9dcc568b2e968af848bbdb4267ba6cde5457b9e"
SRCREV_meta ="7f04d953fdf6c7a583cd258e5fe7127e5548a348"

KBRANCH = "toradex_4.19.y-rt"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7|colibri-imx6)"

require recipes-kernel/linux/linux-stable.inc

