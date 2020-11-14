FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://bootcommand.cfg \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"

SRC_URI_append_use-mainline-bsp = " \
    file://0001-colibri-imx6ull-colibri_imx7-add-ubifs-distro-boot-s.patch \
"
