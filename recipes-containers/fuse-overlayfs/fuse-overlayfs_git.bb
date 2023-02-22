SUMMARY = "FUSE implementation of overlayfs."
DESCRIPTION = "An implementation of overlay+shiftfs in FUSE for rootless \
containers."

LICENSE = "GPL-3.0-or-later"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRC_URI = "git://github.com/containers/fuse-overlayfs.git;nobranch=1;protocol=https"

SRCREV = "a1e8466e2c2b46593656481508c1cf65a853e4bd"
PV = "1.10+git${SRCPV}"

DEPENDS = "fuse3"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
