FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://0001-Allow-to-disable-polkitd-when-using-library-alone.patch \
"

DEPENDS_remove = "mozjs"

EXTRA_OECONF_append = " --disable-polkitd"
