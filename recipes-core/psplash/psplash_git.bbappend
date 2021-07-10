FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://torizon-blue-splash.patch \
"

SPLASH_IMAGES = "file://torizon-blue.png;outsuffix=default"
