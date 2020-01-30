FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_class-target = " \
    file://0001-requirements.txt-setup.py-drop-tls-and-ssh-support.patch \
    file://0001-setup.py-import-fastentrypoints.patch \
"

DEPENDS_append = " ${PYTHON_PN}-fastentrypoints-native"

RDEPENDS_${PN}_remove = "${PYTHON_PN}-paramiko"
