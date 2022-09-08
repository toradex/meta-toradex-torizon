
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"
CORE_IMAGE_BASE_INSTALL:append = "resize-helper"

OSTREE_KERNEL_ARGS:sota:append:nezha-allwinner-d1 = " root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash fbcon=map:10 "
SOTA_CLIENT_FEATURES:append:nezha-allwinner-d1 = " ubootenv"
WKS_FILE_DEPENDS_BOOTLOADERS:nezha-allwinner-d1 = "virtual/bootloader"
WKS_FILE_DEPENDS:append:nezha-allwinner-d1 = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script:nezha-allwinner-d1 = "u-boot-ostree-scr"
PREFERRED_PROVIDER_u-boot-default-script:sota:nezha-allwinner-d1 = "u-boot-ostree-scr-fit"

LINUX_VERSION_EXTENSION ?= "-torizon-${LINUX_KERNEL_TYPE}"

# Use meta-lmp but maintain compatibility
BBMASK += " \
    meta-lmp/meta-lmp-base \
    meta-lmp/meta-lmp-bsp \
"
