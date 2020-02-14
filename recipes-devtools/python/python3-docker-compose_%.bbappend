FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://0001-requirements.txt-setup.py-drop-tls-and-ssh-support.patch \
"

RDEPENDS_${PN}_remove = "${PYTHON_PN}-paramiko"
