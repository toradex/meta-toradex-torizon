SUMMARY = "FUSE implementation of overlayfs."
DESCRIPTION = "An implementation of overlay+shiftfs in FUSE for rootless \
containers."

LICENSE = "GPLv3+"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRCREV = "f38c0b849c1b77a2595b4f5658f94f3d50749c6b"
SRC_URI = "git://github.com/containers/fuse-overlayfs.git;nobranch=1"

DEPENDS = "fuse3"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
