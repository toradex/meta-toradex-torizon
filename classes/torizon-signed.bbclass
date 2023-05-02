# TorizonCore configuration for signed images

# globally enable the build with secure-boot support
DISTROOVERRIDES:append = ":secure-boot"

# enable FIT images in TorizonCore
KERNEL_CLASSES:append = " kernel-fitimage"
KERNEL_IMAGETYPE:forcevariable = "fitImage"

# enable signature checking of FIT images
UBOOT_SIGN_ENABLE = "1"
UBOOT_MKIMAGE_DTCOPTS = "-I dts -O dtb -p 2000"
UBOOT_SIGN_KEYDIR ?= "${TOPDIR}/keys"
UBOOT_SIGN_KEYNAME ?= "dev"

# signing the FIT image requires a DTB in U-Boot
# to save the public key, but colibri-imx6ull-emmc
# and colibri-imx7-emmc doesn't generate one. So
# let's disable signing the FIT image on these two
# modules for now
UBOOT_SIGN_ENABLE:colibri-imx6ull-emmc = "0"
UBOOT_SIGN_ENABLE:colibri-imx7-emmc = "0"

# parameters to generate the keys to sign the FIT image
FIT_GENERATE_KEYS ?= "1"
FIT_KEY_GENRSA_ARGS ?= "-F4"
FIT_KEY_REQ_ARGS ?= "-batch -new"
FIT_KEY_SIGN_PKCS ?= "-x509"

# parameters to sign FIT images
FIT_SIGN_ALG ?= "rsa2048"
FIT_SIGN_NUMBITS ?= "2048"
FIT_SIGN_INDIVIDUAL = "0"
