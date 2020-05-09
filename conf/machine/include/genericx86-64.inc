OSTREE_KERNEL_ARGS_genericx86-64 = "console=ttyS0,115200 root=LABEL=otaroot rootfstype=ext4"
WKS_FILE_sota_genericx86-64 = "efidisk-sota.wks"

OSTREE_BOOTLOADER_genericx86-64 = "grub"
EFI_PROVIDER_genericx86-64 = "grub-efi"
IMAGE_BOOT_FILES_genericx86-64 = ""

IMAGE_FSTYPES_REMOVE = "hddimg teziimg-distro"
IMAGE_FSTYPES_append = " wic.vmdk wic.vdi"

IMAGE_RT_SUFFIX_qemuarm64 = ""
IMAGE_NAME_qemuarm64_preempt-rt = "${IMAGE_BASENAME}-rt-${MACHINE}${IMAGE_VERSION_SUFFIX}"

hostname_pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL_remove = "set-hostname"
