require raspberrypi-common.inc

SOTA_DT_OVERLAYS:raspberrypi4-64 ?= "vc4-fkms-v3d-pi4.dtbo rpi-ft5406.dtbo"
VC4DTBO:raspberrypi4-64 ?= "vc4-fkms-v3d-pi4"
KERNEL_DEVICETREE:raspberrypi4-64:sota ?= " broadcom/bcm2711-rpi-4-b.dtb overlays/vc4-fkms-v3d-pi4.dtbo overlays/rpi-ft5406.dtbo"
KERNEL_BOOTCMD:raspberrypi4-64 = "booti"
PREFERRED_VERSION_linux-raspberrypi:raspberrypi4-64 = "5.15.%"
KERNEL_SERIAL:sota:raspberrypi4-64 = "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyAMA0,115200", "", d)}"
