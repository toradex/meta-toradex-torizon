require raspberrypi-common.inc

KERNEL_DEVICETREE:raspberrypi0-wifi:sota ?= " bcm2708-rpi-zero-w.dtb overlays/vc4-fkms-v3d.dtbo overlays/rpi-ft5406.dtbo"
OSTREE_KERNEL:raspberrypi0-wifi = "zImage"
KERNEL_IMAGETYPE:raspberrypi0-wifi = "zImage"
KERNEL_IMAGETYPE:sota:raspberrypi0-wifi = "zImage"
KERNEL_BOOTCMD:raspberrypi0-wifi = "bootz"