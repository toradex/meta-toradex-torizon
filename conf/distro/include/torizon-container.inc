
require conf/distro/include/torizon-common.inc

# TODO: review default distro features
DISTRO_FEATURES_append = " usrmerge"
PACKAGECONFIG_append_pn-systemd = " resolved networkd"

# Default image formats
IMAGE_FSTYPES = "container tar"
IMAGE_CLASSES += "image_type_tezi image_torizon_tezi"

# Force kernel to be built even for container
IMAGE_CONTAINER_NO_DUMMY = "1"
