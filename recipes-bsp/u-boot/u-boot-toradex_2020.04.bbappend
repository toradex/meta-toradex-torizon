FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append += " \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"
