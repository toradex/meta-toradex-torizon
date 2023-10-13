SUMMARY = "Torizon OS Reference Minimal Image"
DESCRIPTION = "Torizon OS without a container engine. \
All other Torizon OS features are included, such as remote and offline OS updates, \
device monitoring, and more."

require torizon-core-common.inc

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_VARIANT = "Minimal"

# Extras (for development)
CORE_IMAGE_BASE_INSTALL:append = " \
    bash \
"
