# Torizon configuration

# Additional boot arguments are prepended by the U-Boot distro boot
# boot flow in boot.cmd.
#
# This boot arguments are supplied to OSTree deploy command. To
# change kernel boot arguments in a deployed OSTree use:
# ostree admin deploy --karg-none --karg="newargs" ...
OSTREE_KERNEL_ARGS = "quiet logo.nologo vt.global_cursor_default=0 plymouth.ignore-serial-consoles splash"

OSTREE_KERNEL_ARGS_append_colibri-imx8x = " clk_ignore_unused"

# Cross machines / BSPs
## Drop IMX BSP that is not needed
MACHINE_EXTRA_RRECOMMENDS_remove_imx = "imx-alsa-plugins"

# A kernel specific variable, shared by all kernel recipes
export DTC_FLAGS = "-@"

# git is required by torizon to get hashes from all meta layers ()
HOSTTOOLS += "git"
