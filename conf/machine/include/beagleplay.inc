# taken from meta-freescale/conf/machine/include/utilities.inc
def make_dtb_boot_files(d):
    # Generate IMAGE_BOOT_FILES entries for device tree files listed in
    # KERNEL_DEVICETREE.
    # Use only the basename for dtb files:
    alldtbs = d.getVar('KERNEL_DEVICETREE')


    # DTBs may be built out of kernel with devicetree.bbclass
    if not alldtbs:
        return ''

    def transform(dtb):
        if not (dtb.endswith('dtb') or dtb.endswith('dtbo')):
            # eg: whatever/bcm2708-rpi-b.dtb has:
            #     DEPLOYDIR file: bcm2708-rpi-b.dtb
            #     destination: bcm2708-rpi-b.dtb
            bb.error("KERNEL_DEVICETREE entry %s is not a .dtb or .dtbo file." % (dtb) )
        return os.path.basename(dtb)

    return ' '.join([transform(dtb) for dtb in alldtbs.split() if dtb])

WKS_FILE = "sdimage-2part.wks"
WKS_FILE_DEPENDS:remove = "tezi-metadata virtual/dtb"
CORE_IMAGE_BASE_INSTALL:append = "resize-helper"

KERNEL_BUILTIN_WIREGUARD:beagleplay = "1"
CORE_IMAGE_BASE_INSTALL:remove = "kernel-module-wireguard wireguard-tools"
PREFERRED_PROVIDER_virtual/bootloader = "u-boot-ti-staging"
PREFERRED_PROVIDER_virtual/bootloader:sota = "u-boot-ti-staging"
PREFERRED_PROVIDER_virtual/bootloader:beagleplay = "u-boot-ti-staging"
PREFERRED_PROVIDER_u-boot:beagleplay = "u-boot-ti-staging"
PREFERRED_PROVIDER_virtual/dtb = ""
WKS_FILE_DEPENDS_BOOTLOADERS:beagleplay = "virtual/bootloader"
WKS_FILE_DEPENDS:append:beagleplay = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script:beagleplay = "u-boot-distro-boot"
PREFERRED_PROVIDER_u-boot-default-script:sota:beagleplay = "u-boot-distro-boot"

PREFERRED_PROVIDER_u-boot-fw-utils = "libubootenv"
PREFERRED_RPROVIDER_u-boot-fw-utils = "libubootenv"

IMAGE_FSTYPES:remove:beagleplay = "ext3 jffs2 teziimg"

# We need ota-ext4 and wic for beagle
IMAGE_FSTYPES_REMOVE = ""
IMAGE_BOOT_FILES:beagleplay = "u-boot.img tispl.bin tiboot3.bin ${@make_dtb_boot_files(d)} "
IMAGE_BOOT_FILES:sota:beaglebone-yocto = "u-boot.img tispl.bin tiboot3.bin ${@make_dtb_boot_files(d)} "
IMAGE_BOOT_FILES_REMOVE:sota:remove = "boot.scr-${MACHINE};boot.scr"
IMAGE_BOOT_FILES:append = " boot.scr-${MACHINE};boot.scr "

LINUX_VERSION_EXTENSION = "-torizon-${LINUX_KERNEL_TYPE}"

## same bahavior
# This boot arguments are the same from torizon.bbclass
OSTREE_KERNEL_ARGS:sota:append:beagleplay = "console=ttyS2,115200 root=LABEL=otaroot rootfstype=ext4 quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash "

UBOOT_BINARY_OTA_IGNORE:beagleplay = "1"
OSTREE_DEPLOY_DEVICETREE:beagleplay = "0"

PREFERRED_PROVIDER_virtual/mesa = "mesa-pvr"
PREFERRED_PROVIDER_virtual/egl = "mesa-pvr"
PREFERRED_PROVIDER_virtual/libgles1 = "mesa-pvr"
PREFERRED_PROVIDER_virtual/libgles2 = "mesa-pvr"
PREFERRED_PROVIDER_virtual/libgles3 = "mesa-pvr"
PREFERRED_PROVIDER_virtual/libgbm = "mesa-pvr"
PREFERRED_PROVIDER_virtual/libglx = "mesa-pvr"
PREFERRED_PROVIDER_virtual/libgl = "mesa-pvr"

INITRAMFS_MAXSIZE = "315400"

BBMASK += " \
    meta-common-torizon/recipes-bsp/u-boot/u-boot-toradex \
    meta-raspberrypi/recipes-bsp/u-boot/u-boot_%.bbappend \
    meta-common-torizon/recipes-bsp/u-boot/u-boot-toradex_%.bbappend \
"
