do_install_append () {
    if [ ${@ oe.types.boolean('${OSTREE_DEPLOY_DEVICETREE}')} = True ]; then
        install -d $kerneldir/dtb/overlays
        if [ ! -e ${DEPLOY_DIR_IMAGE}/overlays/none_deployed ]; then
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays/*.dtbo $kerneldir/dtb/overlays
            install -m 0644 ${DEPLOY_DIR_IMAGE}/overlays.txt $kerneldir/dtb
        fi
    fi
}
do_install[depends] += "${@'device-tree-overlay-filter:do_deploy' if '${PREFERRED_PROVIDER_virtual/dtb}' else ''}"
