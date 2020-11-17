MACHINE_PREFIX = "${MACHINE}"
MACHINE_PREFIX_apalis-imx8x-v11a = "apalis-imx8x"
MACHINE_PREFIX_colibri-imx7-emmc = "colibri-imx7"
MACHINE_PREFIX_colibri-imx8x-v10b = "colibri-imx8x"

do_install_append () {
    if [ ${@ oe.types.boolean('${OSTREE_DEPLOY_DEVICETREE}')} = True ]; then
        deploy_dt_dir=${DEPLOY_DIR_IMAGE}/devicetree/
        dtbos=
        if [ -z "${TEZI_EXTERNAL_KERNEL_DEVICETREE}" -a -d "$deploy_dt_dir" ] ; then
            machine_dtbos=`cd $deploy_dt_dir && ls ${MACHINE_PREFIX}*.dtbo 2>/dev/null || true`
            common_dtbos=`cd $deploy_dt_dir && ls *.dtbo 2>/dev/null | grep -v -e 'imx[6-8]' -e 'tk1' | xargs || true`
            dtbos="$machine_dtbos $common_dtbos"
        else
            dtbos="${TEZI_EXTERNAL_KERNEL_DEVICETREE}"
        fi

        if [ -n "$dtbos" ]; then
            install -d $kerneldir/dtb/overlays
        fi

        for dtbo in $dtbos; do
            install -m 0644 $deploy_dt_dir/$dtbo $kerneldir/dtb/overlays
        done

        if [ -n "${TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT}" ]; then
            for dtbo in ${TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT}; do
                if [ ! -e $kerneldir/dtb/overlays/$dtbo ]; then
                    bbfatal "$dtbo is not installed in your rootfs, please make sure it's in TEZI_EXTERNAL_KERNEL_DEVICETREE or being provided by virtual/dtb."
                fi
            done
            echo "fdt_overlays=$(echo "${TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT}")" > $kerneldir/dtb/overlays.txt
        fi
    fi
}
do_install[depends] += "${@'virtual/dtb:do_deploy' if '${PREFERRED_PROVIDER_virtual/dtb}' else ''}"
