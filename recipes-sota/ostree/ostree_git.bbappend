LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-add-all-devicetrees-to-ostree.patch \
"

SRC_URI_remove = " \
    file://avoid-race-condition-tests-build.patch \
"
