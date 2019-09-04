inherit torizon-machine-custom

# Done as a rootfs post process hook in order to be part of the ostree image
sota_fstab_update() {
	if [ -n "${EFI_PROVIDER}" ]; then
		echo "LABEL=efi /boot/efi vfat umask=0077 0 1" >> ${IMAGE_ROOTFS}/etc/fstab
	fi
}

# Create user and change password expiration
create_user() {
	useradd -R ${IMAGE_ROOTFS} -P torizon torizon; \
	usermod -R ${IMAGE_ROOTFS} -a -G sudo,users,plugdev torizon; \
	
	passwd -e -R ${IMAGE_ROOTFS} torizon
}

ROOTFS_POSTPROCESS_COMMAND_append_sota = " sota_fstab_update; create_user; "
