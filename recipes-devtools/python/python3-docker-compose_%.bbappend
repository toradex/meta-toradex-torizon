FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_remove = "file://0001-setup.py-import-fastentrypoints.patch"
SRC_URI_append_class-target = " \
    file://0001-requirements.txt-setup.py-drop-tls-and-ssh-support.patch \
"

DEPENDS_remove = "${PYTHON_PN}-fastentrypoints-native"
RDEPENDS_${PN}_remove = "${PYTHON_PN}-paramiko"
