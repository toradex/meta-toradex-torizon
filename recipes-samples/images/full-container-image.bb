DESCRIPTION = "Basic TordyOS console image, featuring complete Docker runtime and SOTA update capabilities."

require full-container-image.inc

CORE_IMAGE_BASE_INSTALL += " \
    docker \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G docker tordy; \
"
