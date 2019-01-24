TEZI_ROOT_LABEL = "otaroot"
TEZI_ROOT_SUFFIX = "ota.tar.xz"
TEZI_KERNEL_DEVICETREE = ""
TEZI_KERNEL_IMAGETYPE = ""
do_image_teziimg_distro[depends] += "u-boot-distro-boot-ostree:do_deploy"

SUMMARY_append_torizon-rt = " (PREEMPT_RT)"
DESCRIPTION_append_torizon-rt = " Using a Linux kernel with PREEMPT_RT real-time patch applied."

# Store image size of tar file as required by Tezi image class
CONVERSION_CMD_tar_append = "; echo $(du -ks ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.${type}.tar| cut -f 1) > ${T}/image-size.${type}.tar"
