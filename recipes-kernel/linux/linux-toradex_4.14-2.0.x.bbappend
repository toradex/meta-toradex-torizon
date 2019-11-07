FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.14-2.0.x:"

export DTC_FLAGS = "-@"

SRC_URI_append = " \
    file://0001-Revert-Revert-MLK-18433-PCI-imx-remove-the-lpcg_xxx-.patch \
    file://0002-Revert-ARM64-dts-imx8qm-apalis-add-pcie_per-clock.patch \
"
