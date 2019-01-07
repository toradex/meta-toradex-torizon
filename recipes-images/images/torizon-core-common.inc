IMAGE_INSTALL_append = " \
    udev-toradex-rules \
    networkmanager \
    wireless-regdb-static \
    linux-firmware-rtl8192cu \
    kernel-modules \
    set-hostname \
"

IMAGE_INSTALL_append_colibri-imx6ull = " \
    linux-firmware-sd8887 \
    linux-firmware-sd8997 \
"
