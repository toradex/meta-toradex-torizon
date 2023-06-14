# TorizonCore configuration for signed images

# inherit class to sign BSP related images
inherit tdx-signed

# globally enable signing of operating system images
DISTROOVERRIDES:append = ":torizon-signed"

# enable FIT images in TorizonCore
KERNEL_CLASSES:append = " kernel-fitimage"
KERNEL_IMAGETYPE:forcevariable = "fitImage"
