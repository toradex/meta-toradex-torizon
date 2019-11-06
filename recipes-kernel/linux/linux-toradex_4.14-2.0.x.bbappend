FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.14-2.0.x:"

export DTC_FLAGS = "-@"

SRC_URI_append = " \
    file://0001-ARM64-dts-fsl-imx8qm-use-X2-peripheral-clock-on-both.patch \
"
