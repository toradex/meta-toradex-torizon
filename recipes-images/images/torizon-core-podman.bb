SUMMARY = "TorizonCore image with Podman runtime"
DESCRIPTION = "TorizonCore image, featuring the podman container runtime and \
secure OTA update capabilities."

require torizon-core-container.inc

CORE_IMAGE_BASE_INSTALL_append = " \
    podman \
    podman-compose \
"
