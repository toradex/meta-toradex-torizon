SUMMARY = "TorizonCore Lite"
DESCRIPTION = "TorizonCore image without a container engine. All other \
TorizonCore features are included, such as remote and offline OS updates, \
device monitoring, and more."

require torizon-core-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_VARIANT = "Lite"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL:append = " \
    bash \
"
