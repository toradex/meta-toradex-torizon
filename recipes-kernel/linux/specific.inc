FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://${MACHINE}/ \
"

# prepend custom device trees
do_configure:prepend:beaglebone-yocto() {
    cp ${WORKDIR}/${MACHINE}/*.dts* ${S}/arch/arm/boot/dts
}
