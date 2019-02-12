SUMMARY = "TorizonCore customization tools image"
DESCRIPTION = "TorizonCore container including customization tools."

require image-common.inc

# Extras (for development)
CORE_IMAGE_BASE_INSTALL += " \
    bash \
    util-linux-mountpoint \
    kernel-devicetree-source \
    dtc \
    cpp \
    make \
    libdrm-tests \
    dbus \
    systemd \
    python3 \
    python3-pip \
"

IMAGE_INSTALL_remove = " \
                        aktualizr \
                        aktualizr-native \
"
