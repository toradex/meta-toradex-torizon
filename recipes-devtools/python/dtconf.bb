SUMMARY = "Toradex Device Tree configuration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PR = "r2"

SRC_URI = "git://github.com/toradex/device-tree-conf.git;branch=master;protocol=git"
SRCREV = "a674f7d110e90d67edec4483ed2c6e6ea04bb323"

RDEPENDS_${PN} = " \
        python3 \
"

inherit setuptools3

S = "${WORKDIR}/git"