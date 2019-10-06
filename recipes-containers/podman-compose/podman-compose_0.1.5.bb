DESCRIPTION = "An implementation of docker-compose with podman backend"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

inherit setuptools3 pypi

SRC_URI = "git://github.com/containers/podman-compose.git"

SRCREV = "f008986633879acf3f54848dabbf07cef8e9c68f"

S = "${WORKDIR}/git"

DEPENDS += "${PYTHON_PN}-pyyaml-native"

RDEPENDS_${PN} += "${PYTHON_PN}-pyyaml"
