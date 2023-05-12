require u-boot-ota.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot:"

SRC_URI:append:rpi = " file://0001-rpi-always-set-fdt_addr-with-firmware-provided-FDT-address.patch"

DEPENDS:append:rpi = " u-boot-default-script"
