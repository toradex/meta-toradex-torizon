FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
    file://bootcommand.cfg \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"

require u-boot-version.inc
