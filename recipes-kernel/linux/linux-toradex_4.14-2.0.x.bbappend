kernel_do_configure_append() {
	# set kernel to reboot on panic and hung tasks
	echo "CONFIG_DETECT_HUNG_TASK=y" >> ${B}/.config
	echo "CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y" >> ${B}/.config
	echo "CONFIG_PANIC_ON_OOPS=y" >> ${B}/.config
	echo "CONFIG_PANIC_TIMEOUT=5" >> ${B}/.config
}
