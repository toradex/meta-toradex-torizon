require conf/distro/include/torizon-common.inc

# TODO: review default distro features
DISTRO_FEATURES_append = " usrmerge"

# Default image formats
IMAGE_FSTYPES = "container tar"
