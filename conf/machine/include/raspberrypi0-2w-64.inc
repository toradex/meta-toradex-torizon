require raspberrypi-common.inc

KERNEL_DEVICETREE:raspberrypi0-2w-64:sota ?= " broadcom/bcm2710-rpi-zero-2.dtb overlays/vc4-fkms-v3d.dtbo overlays/rpi-ft5406.dtbo"
