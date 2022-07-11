FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
    file://torizon-blue-splash.patch \
"

SPLASH_IMAGES = "file://torizon-blue.png;outsuffix=default"
