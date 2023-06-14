# TorizonCore configuration for signed images

# inherit class to sign BSP related images
inherit tdx-signed

# globally enable the build with secure-boot support
DISTROOVERRIDES:append = ":secure-boot"

# enable FIT images in TorizonCore
KERNEL_CLASSES:append = " kernel-fitimage"
KERNEL_IMAGETYPE:forcevariable = "fitImage"
