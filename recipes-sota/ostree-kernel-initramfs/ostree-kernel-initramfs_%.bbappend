PACKAGES:prepend = "ostree-devicetree-overlays "
ALLOW_EMPTY:ostree-devicetree-overlays = "1"
FILES:ostree-devicetree-overlays = "${nonarch_base_libdir}/modules/*/dtb/*.dtbo ${nonarch_base_libdir}/modules/*/dtb/overlays.txt"

do_install:append () {
    if [ ${@ oe.types.boolean('${OSTREE_DEPLOY_DEVICETREE}')} = True ]; then
        install -d $kerneldir/dtb/overlays
        if [ ! -e ${DEPLOY_DIR_IMAGE}/overlays/none_deployed ]; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays/*.dtbo $kerneldir/dtb/overlays
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt $kerneldir/dtb
        fi
    elif [ "${KERNEL_IMAGETYPE}" = "fitImage" ]; then
        if [ -e ${DEPLOY_DIR_IMAGE}/overlays.txt ]; then
            install -d $kerneldir/dtb
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt $kerneldir/dtb
        fi
    fi
}
do_install[depends] += "${@'virtual/dtb:do_deploy' if '${PREFERRED_PROVIDER_virtual/dtb}' else ''}"
