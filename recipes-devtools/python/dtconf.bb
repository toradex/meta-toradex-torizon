SUMMARY = "Toradex Device Tree configuration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r2"

SRC_URI = "git://github.com/toradex/device-tree-conf.git;branch=master;protocol=git"
SRCREV = "c823c9f82ec60dd98f16efd673a98eebf4a38580"

RDEPENDS_${PN} = " \
        python3 \
"

inherit setuptools3

S = "${WORKDIR}/git"