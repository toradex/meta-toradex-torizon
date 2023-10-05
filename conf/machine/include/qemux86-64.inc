
WKS_FILE:qemux86-64:sota = "efiimage-sota.wks"
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"

CORE_IMAGE_BASE_INSTALL:append = "resize-helper docker-binfmt"

OSTREE_KERNEL_ARGS:qemux86-64 = "console=ttyS0,115200 root=LABEL=otaroot rootfstype=ext4 logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash fbcon=map:10 quiet "
OSTREE_BOOTLOADER:qemux86-64 = "grub"
OSTREE_DEPLOY_DEVICETREE:qemux86-64 = "0"
EFI_PROVIDER:qemux86-64 = "grub-efi"
SOTA_CLIENT_FEATURES:remove = "ubootenv"
UBOOT_BINARY_OTA_IGNORE:qemux86-64 = "1"

IMAGE_FSTYPES_REMOVE = "hddimg teziimg"
IMAGE_FSTYPES:append = " wic"

hostname:pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL:remove = "set-hostname"

PREFERRED_PROVIDER_u-boot-default-script = ""
PREFERRED_PROVIDER_virtual/dtb = ""

LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"
