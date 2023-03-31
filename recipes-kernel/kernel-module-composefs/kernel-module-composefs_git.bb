SUMMARY = "composefs kernel module"
DESCRIPTION = "Composefs is a native Linux file system designed to \
help sharing filesystem contents, as well as ensuring said content \
is not modified."

LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

inherit module

SRC_URI = "\
    git://github.com/containers/composefs.git;protocol=https;branch=main;subpath=kernel \
    file://0001-Add-targets-to-Makefile.patch \
"

SRC_URI:append:use-nxp-bsp = "\
    file://0002-Backport-to-kernel-5.15.patch \
"

SRCREV = "18a6301a40aa8e14f35e8ef12a92dc37f61b306a"

S = "${WORKDIR}/kernel"

RPROVIDES:${PN} += "kernel-module-composefs"
