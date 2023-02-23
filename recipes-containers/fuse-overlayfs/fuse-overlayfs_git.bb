SUMMARY = "FUSE implementation of overlayfs."
DESCRIPTION = "An implementation of overlay+shiftfs in FUSE for rootless \
containers."

LICENSE = "GPLv3+"
LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"

SRCREV = "25db5be78a4cbe4d17116b95299dac2e34f2740d"
SRC_URI = "git://github.com/containers/fuse-overlayfs.git;nobranch=1"

FUSE_OVERLAYFS_VERSION = "1.10"

PV = "${FUSE_OVERLAYFS_VERSION}+git${SRCREV}"

DEPENDS = "fuse3"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
