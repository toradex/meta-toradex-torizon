TEZI_ROOT_LABEL = "otaroot"
TEZI_ROOT_SUFFIX = "ota-tar.xz"

do_image_teziimg_distro[depends] += "u-boot-distro-boot-ostree:do_deploy"
