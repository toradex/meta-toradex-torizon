FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://bootcommand.cfg \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"

require u-boot-ota.inc
