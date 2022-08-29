FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI[md5sum] = "33314b2c98a1a4e3b57e7068811007c6"
SRC_URI[sha256sum] = "d916a26b62970e7c2f554110ed6af04c7ccff8e9f81ad17d0d40c75637e227fb"

PV = "5.0.3"

SRC_URI:append = "\
    file://0001-config-Include-usr-lib-docker-in-search-path.patch \
"
