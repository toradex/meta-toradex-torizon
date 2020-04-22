SOTA_MACHINE_intel-corei7-64 = "none"
OSTREE_KERNEL_ARGS_intel-corei7-64 = "console=ttyS0,115200 root=LABEL=otaroot rootfstype=ext4"
WKS_FILE_sota_intel-corei7-64 = "efidisk-sota.wks"

IMAGE_FSTYPES_REMOVE = "live hddimg teziimg-distro"
IMAGE_FSTYPES_append = " wic.vmdk wic.vdi"

PREFERRED_PROVIDER_virtual/kernel_intel-corei7-64 = "linux-yocto"
PREFERRED_PROVIDER_virtual/kernel_intel-corei7-64_preempt-rt = "linux-yocto-rt"
