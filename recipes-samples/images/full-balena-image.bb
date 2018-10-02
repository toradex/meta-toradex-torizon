DESCRIPTION = "Basic TordyOS console image, featuring complete Balena runtime and SOTA update capabilities."

require full-container-image.inc

CORE_IMAGE_BASE_INSTALL += " \
    balena \
    tini-balena \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G balena tordy; \
"
