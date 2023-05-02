FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
    file://secure-boot.cfg \
"

# update U-Boot image with the one that has the signature node
# this is required when the BSP is using UBOOT_CONFIG
do_deploy:prepend() {
        if [ -n "${UBOOT_CONFIG}" ]
        then
                i=0
                j=0
                for config in ${UBOOT_MACHINE}; do
                        i=$(expr $i + 1);
                        for type in ${UBOOT_CONFIG}; do
                                j=$(expr $j + 1);
                                if [ $j -eq $i ]
                                then
                                        cp ${DEPLOYDIR}/${UBOOT_IMAGE} ${B}/${config}/u-boot-$type.${UBOOT_SUFFIX}
                                fi
                        done
                done
        fi
}
