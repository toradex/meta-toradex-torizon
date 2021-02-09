SUMMARY = "TorizonCore image"
DESCRIPTION = "Minimal TorizonCore console image, featuring secure OTA update \
capabilities."

require torizon-core-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_VARIANT = "Lite"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL_append = " \
    bash \
"
