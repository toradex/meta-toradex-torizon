SRCREV = "1f43bce17a57a29d180ab0facb83a88b1fb9c797"
SRCBRANCH = "toradex_4.14-2.0.x-imx-next"

kernel_do_configure_append() {
	kernel_configure_variable CFS_BANDWIDTH y
	kernel_configure_variable SENSORS_SHT3x y
}
