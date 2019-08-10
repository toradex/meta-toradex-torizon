# Torizon configuration

# Additional boot arguments are prepended by the U-Boot distro boot
# boot flow in boot.cmd.
#
# This boot arguments are supplied to OSTree deploy command. To
# change kernel boot arguments in a deployed OSTree use:
# ostree admin deploy --karg-none --karg="newargs" ...
OSTREE_KERNEL_ARGS = "quiet logo.nologo"

OSTREE_KERNEL_ARGS_append_colibri-imx7 = " console=ttymxc0,115200"
OSTREE_KERNEL_ARGS_append_colibri-imx6 = " console=ttymxc0,115200"
OSTREE_KERNEL_ARGS_append_apalis-imx6 = " console=ttymxc0,115200"
OSTREE_KERNEL_ARGS_append_colibri_imx6ull = " console=ttymxc0,115200"

# Cross machines / BSPs
## Drop IMX BSP that is not needed
MACHINE_EXTRA_RRECOMMENDS_remove_imx = "imx-alsa-plugins"
## No need to install u-boot, already a WKS dependency
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_remove_imx = "u-boot-fslc"

