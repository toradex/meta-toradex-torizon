SUMMARY = "FUSE implementation of overlayfs."
DESCRIPTION = "An implementation of overlay+shiftfs in FUSE for rootless \
containers."

LICENSE = "GPLv3+"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRCREV = "0d53568a131af3f31e3609fe2ff61d0b5970a25a"
SRC_URI = "git://github.com/containers/fuse-overlayfs.git;nobranch=1"

DEPENDS = "fuse3"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
