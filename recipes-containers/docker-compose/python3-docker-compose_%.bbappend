FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# We dont support docker[ssh], hence could drop paramiko dependency,
# see file/0001-setup.py-remove-maximum-version-requirements.patch.
RDEPENDS_${PN}_remove = "${PYTHON_PN}-paramiko"
