DESCRIPTION = "TorizonCore OSTree initramfs image"

PACKAGE_INSTALL = "initramfs-framework-base initramfs-module-udev \
    initramfs-module-rootfs initramfs-module-debug initramfs-module-ostree \
    initramfs-module-plymouth ${VIRTUAL-RUNTIME_base-utils} base-passwd"

SYSTEMD_DEFAULT_TARGET = "initrd.target"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = "splash"

export IMAGE_BASENAME = "initramfs-ostree-torizon-image"
IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_FSTYPES = "cpio.gz"
IMAGE_FSTYPES_remove = "wic wic.gz wic.bmap ext4 ext4.gz teziimg-distro"

# avoid circular dependencies
EXTRA_IMAGEDEPENDS = ""

inherit core-image nopackages

IMAGE_ROOTFS_SIZE = "8192"

# Users will often ask for extra space in their rootfs by setting this
# globally.  Since this is a initramfs, we don't want to make it bigger
IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_OVERHEAD_FACTOR = "1.0"

BAD_RECOMMENDATIONS += "busybox-syslog"
