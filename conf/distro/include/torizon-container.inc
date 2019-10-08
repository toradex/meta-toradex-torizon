require conf/distro/include/torizon-common.inc

# TODO: review default distro features
DISTRO_FEATURES_append = " usrmerge"
PACKAGECONFIG_append_pn-systemd = " resolved networkd"

# Default image formats
IMAGE_FSTYPES = "container tar"
