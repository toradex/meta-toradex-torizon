SUMMARY = "TordyOS image that only includes OTA+ support"
DESCRIPTION = "Minimal TordyOS console image, featuring SOTA update capabilities."
PV = "0.1"

require image-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL += " \
    bash \
"
