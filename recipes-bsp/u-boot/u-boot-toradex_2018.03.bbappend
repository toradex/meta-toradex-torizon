FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append += " \
    file://0001-define-bootcount-related-variables-to-make-bootcount.patch \
    file://bootcount.cfg \
"
