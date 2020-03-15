inherit toradex-kernel-config

kernel_do_configure_append() {
	# set kernel to reboot on panic and hung tasks
	kernel_configure_variable DETECT_HUNG_TASK y
	kernel_configure_variable BOOTPARAM_HUNG_TASK_PANIC y
	kernel_configure_variable SOFTLOCKUP_DETECTOR y
	kernel_configure_variable BOOTPARAM_SOFTLOCKUP_PANIC y
	kernel_configure_variable PANIC_ON_OOPS y
	kernel_configure_variable PANIC_TIMEOUT 5
}
