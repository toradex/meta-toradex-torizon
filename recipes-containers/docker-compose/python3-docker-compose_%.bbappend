FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# We dont support docker[ssh], hence could drop paramiko dependency,
# see file/0001-setup.py-remove-maximum-version-requirements.patch.
RDEPENDS:${PN}:remove = "${PYTHON_PN}-paramiko"
