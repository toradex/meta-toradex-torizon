require conf/distro/include/torizon-common.inc

# TODO: review default distro features
DISTRO_FEATURES_append = " pam systemd usrmerge virtualization"
DISTRO_FEATURES_remove = "3g alsa irda pcmcia nfc pulseaudio sysvinit"
VIRTUAL-RUNTIME_init_manager = "systemd"
PACKAGECONFIG_append_pn-systemd = " resolved networkd"
PACKAGECONFIG_append_pn-qemu-native = " libusb"

# Default image formats
IMAGE_FSTYPES = "teziimg-distro"
IMAGE_CLASSES += "image_type_tezi image_torizon_tezi image_torizon_ostree"
