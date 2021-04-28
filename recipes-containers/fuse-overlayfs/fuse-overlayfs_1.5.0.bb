SUMMARY = "FUSE implementation of overlayfs."
DESCRIPTION = "An implementation of overlay+shiftfs in FUSE for rootless \
containers."

LICENSE = "GPLv3+"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRCREV = "e90bcb77f35e93003c7ac878a4670a1dc80208d1"
SRC_URI = "git://github.com/containers/fuse-overlayfs.git;nobranch=1"

DEPENDS = "fuse3"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
