FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_class-target = " file://0001-__init__.py-drop-reference-to-pyopenssl.patch"

RDEPENDS_${PN}_remove_class-target = "${PYTHON_PN}-pyopenssl ${PYTHON_PN}-ndg-httpsclient"
