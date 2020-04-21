UBOOT_MACHINE = "qemu_arm64_defconfig"
UBOOT_ENTRYPOINT = "0x40080000"

KERNEL_CLASSES = "kernel-fitimage"
IMAGE_BOOT_FILES_qemuarm64 = "boot.scr uEnv.txt"
KERNEL_IMAGETYPE_qemuarm64 = "fitImage"

WKS_FILE_DEPENDS_append = " virtual/bootloader u-boot-distro-boot"
WKS_FILE_DEPENDS_remove = "tezi-metadata"

OSTREE_KERNEL_ARGS_qemuarm64 = "console=ttyAMA0 root=LABEL=otaroot rootfstype=ext4"
OSTREE_KERNEL_qemuarm64 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"

QB_MACHINE = "-machine virt"
QB_MEM = "-m 1057"
QB_DRIVE_TYPE = "/dev/vd"
QB_OPT_APPEND_qemuarm64 = "-no-acpi -bios u-boot.bin -d unimp -semihosting-config enable,target=native"

IMAGE_FSTYPES_REMOVE = "teziimg-distro"

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-toradex"
PREFERRED_PROVIDER_virtual/kernel_qemuarm64 = "linux-yocto"
PREFERRED_PROVIDER_virtual/kernel_qemuarm64_torizon-rt = "linux-yocto-rt"
