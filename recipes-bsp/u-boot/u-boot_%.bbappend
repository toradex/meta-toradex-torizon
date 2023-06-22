require u-boot-ota.inc

SRCREV = "f9a043e55c78d894db01006ce442387b758e53ad"

SRC_URI = "git://github.com/commontorizon/u-boot.git;protocol=https;branch=kirkstone"

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot:"

SRC_URI:append:rpi = " file://0001-rpi-always-set-fdt_addr-with-firmware-provided-FDT-address.patch"

DEPENDS:append:rpi = " u-boot-default-script"
