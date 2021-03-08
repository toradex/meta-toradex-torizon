WKS_FILE_sota_genericx86-64 = "efidisk-sota.wks"
WKS_FILE_DEPENDS_remove = "tezi-metadata virtual/dtb"

OSTREE_BOOTLOADER_genericx86-64 = "grub"
OSTREE_DEPLOY_DEVICETREE_genericx86-64 = "0"
EFI_PROVIDER_genericx86-64 = "grub-efi"
SOTA_CLIENT_FEATURES_remove = "ubootenv"

IMAGE_FSTYPES_REMOVE = "hddimg teziimg"
IMAGE_FSTYPES_append = " wic.vmdk wic.vdi"

hostname_pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL_remove = "set-hostname"

PREFERRED_PROVIDER_u-boot-default-script = ""
PREFERRED_PROVIDER_virtual/dtb = ""
