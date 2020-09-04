WKS_FILE_sota_genericx86-64 = "efidisk-sota.wks"
WKS_FILE_DEPENDS_remove = "tezi-metadata virtual/dtb"

OSTREE_KERNEL_ARGS_genericx86-64 = "console=ttyS0,115200 root=LABEL=otaroot rootfstype=ext4"
OSTREE_BOOTLOADER_genericx86-64 = "grub"
EFI_PROVIDER_genericx86-64 = "grub-efi"
SOTA_CLIENT_FEATURES_remove = "ubootenv"

IMAGE_FSTYPES_REMOVE = "hddimg teziimg teziimg-distro"
IMAGE_FSTYPES_append = " wic.vmdk wic.vdi"

hostname_pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL_remove = "set-hostname"
