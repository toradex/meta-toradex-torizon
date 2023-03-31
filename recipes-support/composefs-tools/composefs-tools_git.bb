SUMMARY = "composefs tools"
DESCRIPTION = "Tools to work with composefs, a native Linux file \
system designed to help sharing filesystem contents, as well as \
ensuring said content \
is not modified."

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://kernel/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "\
    git://github.com/containers/composefs.git;protocol=https;branch=main \
    file://0001-ostree-convert-commit.py-calculate-fsverity-digest.patch \
    file://0002-writer-json-set-fsverity-digest.patch \
"

SRCREV = "18a6301a40aa8e14f35e8ef12a92dc37f61b306a"
PV = "0+git${SRCPV}"

S = "${WORKDIR}/git"

DEPENDS = "fsverity-utils yajl"

RDEPENDS:${PN} = "bash"

inherit autotools-brokensep pkgconfig

do_install:append() {
    install -d ${D}${bindir}/.libs
    install ${B}/tools/writer-json ${D}${bindir}
    install ${B}/tools/ostree-convert-commit.py ${D}${bindir}
    install ${B}/tools/.libs/writer-json ${D}${bindir}/.libs
    install ${B}/tools/.libs/mkcomposefs ${D}${bindir}/.libs
}

BBCLASSEXTEND = "native nativesdk"
