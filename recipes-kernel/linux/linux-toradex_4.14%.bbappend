FILESEXTRAPATHS_append:= ":${THISDIR}/${PN}"
inherit toradex-kernel-config

SRC_URI_append = " \
	file://0001-arm64-dts-fsl-imx8qm-apalis-add-configuration-for-to.patch \
	file://0002-arm64-dts-fsl-imx8qxp-apalis-add-configuration-for-t.patch \
	file://0003-arm64-dts-fsl-imx8qxp-colibri-add-configuration-for-.patch \
	"

# Add symbols to make overlays work
EXTRA_OEMAKE += "'DTC_FLAGS=-@'"

kernel_do_configure_append() {
	# set kernel to reboot on panic and hung tasks
	kernel_configure_variable DETECT_HUNG_TASK y
	kernel_configure_variable DEFAULT_HUNG_TASK_TIMEOUT 120
	kernel_configure_variable BOOTPARAM_HUNG_TASK_PANIC y
	kernel_configure_variable SOFTLOCKUP_DETECTOR y
	kernel_configure_variable BOOTPARAM_SOFTLOCKUP_PANIC y
	kernel_configure_variable PANIC_ON_OOPS y
	kernel_configure_variable PANIC_TIMEOUT 5
}
