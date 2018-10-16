SUMMARY = "TorizonCore image with Balena runtime"
DESCRIPTION = "TorizonCore image, featuring complete Balena runtime and secure \
OTA update capabilities."

require torizon-core-container.inc

CORE_IMAGE_BASE_INSTALL += " \
    balena \
    tini-balena \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G balena torizon; \
"
