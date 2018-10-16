SUMMARY = "TorizonCore image"
DESCRIPTION = "Minimal TorizonCore console image, featuring secure OTA update \
capabilities."

require image-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL += " \
    bash \
"
