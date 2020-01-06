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

# A kernel specific variable, shared by all kernel recipes
export DTC_FLAGS = "-@"

# qemuarm64
PREFERRED_PROVIDER_virtual/bootloader_qemuarm64 = "u-boot-toradex"
UBOOT_MACHINE_qemuarm64 = "qemu_arm64_defconfig"
IMAGE_BOOT_FILES_qemuarm64 = "boot.scr uEnv.txt"
KERNEL_IMAGETYPE_qemuarm64 = "fitImage"
KERNEL_CLASSES_qemuarm64 = " kernel-fitimage "
KERNEL_FEATURES_remove_qemuall = "features/kernel-sample/kernel-sample.scc"
OSTREE_KERNEL_ARGS_qemuarm64 = "console=ttyAMA0 root=LABEL=otaroot rootfstype=ext4"
OSTREE_KERNEL_qemuarm64 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
UBOOT_ENTRYPOINT_qemuarm64 = "0x40080000"
QB_MACHINE_qemuarm64 = "-machine virt"
QB_MEM_qemuarm64 = "-m 1057"
QB_DRIVE_TYPE_qemuarm64 = "/dev/vd"
QB_OPT_APPEND_qemuarm64 = "-no-acpi -bios u-boot.bin -d unimp -semihosting-config enable,target=native"
IMAGE_FSTYPES_remove_qemuarm64 = "teziimg-distro"

# Intel X86
OSTREE_BOOTLOADER_intel-corei7-64 ?= "grub"
OSTREE_KERNEL_ARGS_intel-corei7-64 ?= "console=ttyS0,115200 root=LABEL=otaroot rootfstype=ext4"
EFI_PROVIDER_intel-corei7-64 = "grub-efi"
WKS_FILE_intel-corei7-64_sota = "efidisk-sota.wks"
IMAGE_BOOT_FILES_intel-corei7-64 = ""
IMAGE_FSTYPES_remove_intel-corei7-64 = "live hddimg"

# git is required by torizon to get hashes from all meta layers ()
HOSTTOOLS += "git"
