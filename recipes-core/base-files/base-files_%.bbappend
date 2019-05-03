
do_install_append() {
    # remove /media because we are going to use /run/media
    # as main mount point for removable storage devices
    rmdir ${D}/media
}
