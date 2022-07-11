FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# SRC_URI:append:class-target = " file://0001-__init__.py-drop-reference-to-pyopenssl.patch"

RDEPENDS:${PN}:remove:class-target = "${PYTHON_PN}-pyopenssl ${PYTHON_PN}-ndg-httpsclient"
