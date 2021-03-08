FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://uEnv.txt.in \
"

do_install () {
    sed -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/;s/@@KERNEL_IMAGETYPE@@/${KERNEL_IMAGETYPE}/' ${WORKDIR}/uEnv.txt.in > ${WORKDIR}/uEnv.txt
    install -d ${D}${libdir}/ostree-boot
    install -m 0644 ${WORKDIR}/uEnv.txt ${D}${libdir}/ostree-boot/
}

PACKAGES = "ostree-uboot-env"
FILES_ostree-uboot-env = "${libdir}/ostree-boot/uEnv.txt"
