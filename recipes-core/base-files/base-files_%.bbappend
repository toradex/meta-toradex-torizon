FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_install_append() {
    # remove /media because we are going to use /run/media
    # as main mount point for removable storage devices
    rmdir ${D}/media

    if [ -n "${EFI_PROVIDER}" ]; then
        echo "LABEL=efi /boot/efi vfat umask=0077 0 1" >> ${D}${sysconfdir}/fstab
    fi
}
