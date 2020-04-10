# Give fw_setenv mmcblkXboot0 write permissions
fw_setenv() {
    boot_partition=$(readlink /dev/emmc-boot0)
    echo 0 > /sys/block/${boot_partition}/force_ro
    /sbin/fw_setenv "$@"
    echo 1 > /sys/block/${boot_partition}/force_ro
}
