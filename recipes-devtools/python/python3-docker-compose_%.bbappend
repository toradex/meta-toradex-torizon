FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://0001-requirements.txt-setup.py-drop-tls-and-ssh-support.patch \
"

DEPENDS_append = " ${PYTHON_PN}-fastentrypoints-native"

RDEPENDS_${PN}_remove = "${PYTHON_PN}-paramiko"
