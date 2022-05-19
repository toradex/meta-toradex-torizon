SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

SRC_URI[md5sum] = "33314b2c98a1a4e3b57e7068811007c6"
SRC_URI[sha256sum] = "d916a26b62970e7c2f554110ed6af04c7ccff8e9f81ad17d0d40c75637e227fb"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
        ${PYTHON_PN}-misc \
        ${PYTHON_PN}-six \
        ${PYTHON_PN}-docker-pycreds \
        ${PYTHON_PN}-requests \
        ${PYTHON_PN}-websocket-client \
"

inherit pypi setuptools3

SRC_URI_append = "\
    file://0001-config-Include-usr-lib-docker-in-search-path.patch \
"
