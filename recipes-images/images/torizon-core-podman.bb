SUMMARY = "TorizonCore - experimental image using Podman"
DESCRIPTION = "TorizonCore Linux experimental image based on production image \
using Podman container engine."

require torizon-core-container.inc

CORE_IMAGE_BASE_INSTALL_append = " \
    podman \
    podman-compose \
"
