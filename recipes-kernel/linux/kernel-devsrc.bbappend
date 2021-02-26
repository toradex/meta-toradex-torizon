do_install_append() {
    mv $kerneldir/build $kerneldir/linux
    tar cjfv ${D}/usr/src/linux.tar.bz2 -C $kerneldir linux
    rm -rf ${D}/usr/lib ${D}/usr/src/kernel
}

FILES_${PN} += "/usr/src/linux.tar.bz2"

RDEPENDS_${PN}_remove = "bc python3 flex bison glibc-utils openssl-dev util-linux"
