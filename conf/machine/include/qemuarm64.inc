UBOOT_MACHINE = "qemu_arm64_defconfig"
UBOOT_ENTRYPOINT = "0x40080000"

KERNEL_CLASSES = "kernel-lmp-fitimage"
KERNEL_IMAGETYPE_qemuarm64 = "fitImage"

IMAGE_BOOT_FILES_qemuarm64 = "boot.scr-${MACHINE};boot.scr"
WKS_FILE_DEPENDS_append = " virtual/bootloader u-boot-default-script"
WKS_FILE_DEPENDS_remove = "tezi-metadata virtual/dtb"

OSTREE_KERNEL_ARGS_qemuarm64 = "console=ttyAMA0 root=LABEL=otaroot rootfstype=ext4"
OSTREE_KERNEL_qemuarm64 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"

QB_MACHINE = "-machine virt"
QB_DRIVE_TYPE = "/dev/vda"
QB_DEFAULT_FSTYPE = "wic"
QB_MEM_qemuarm64 = "-m 1057"
QB_OPT_APPEND_qemuarm64 = "-show-cursor -device VGA,edid=on -device qemu-xhci -device usb-tablet -device usb-kbd -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -no-acpi -bios ${DEPLOY_DIR_IMAGE}/u-boot.bin -d unimp -semihosting-config enable,target=native"

IMAGE_FSTYPES_REMOVE = "teziimg teziimg-distro"

hostname_pn-base-files = "${MACHINE}"
CORE_IMAGE_BASE_INSTALL_remove = "set-hostname"

PREFERRED_PROVIDER_virtual/dtb = ""
PREFERRED_RPROVIDER_network-configuration_qemuarm64 = "networkd-static-conf"

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-toradex"
PREFERRED_PROVIDER_virtual/kernel_qemuarm64 = "linux-yocto"
PREFERRED_PROVIDER_virtual/kernel_qemuarm64_preempt-rt = "linux-yocto-rt"

PREFERRED_PROVIDER_u-boot-default-script_qemuarm64 = "u-boot-distro-boot"
