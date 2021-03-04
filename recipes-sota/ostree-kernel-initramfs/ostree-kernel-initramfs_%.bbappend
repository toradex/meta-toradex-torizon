PACKAGES_prepend = "ostree-devicetree-overlays "
ALLOW_EMPTY_ostree-devicetree-overlays = "1"
FILES_ostree-devicetree-overlays = "${nonarch_base_libdir}/modules/*/dtb/*.dtbo ${nonarch_base_libdir}/modules/*/dtb/overlays.txt"

do_install_append () {
    if [ ${@ oe.types.boolean('${OSTREE_DEPLOY_DEVICETREE}')} = True ]; then
        install -d $kerneldir/dtb/overlays
        if [ ! -e ${DEPLOY_DIR_IMAGE}/overlays/none_deployed ]; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays/*.dtbo $kerneldir/dtb/overlays
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt $kerneldir/dtb
        fi
    elif [ "${KERNEL_IMAGETYPE}" = "fitImage" ]; then
        install -d $kerneldir/dtb
        install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt $kerneldir/dtb
    fi
}
do_install[depends] += "${@'virtual/dtb:do_deploy' if '${PREFERRED_PROVIDER_virtual/dtb}' else ''}"
