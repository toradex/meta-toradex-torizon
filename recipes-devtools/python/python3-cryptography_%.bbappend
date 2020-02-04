FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_class-target = " file://0001-setup.py-drop-cffi-from-requirements.patch"

RDEPENDS_${PN}_remove_class-target = "${PYTHON_PN}-cffi"
RDEPENDS_${PN}_append_class-target = " ${PYTHON_PN}-cffi-backend"
