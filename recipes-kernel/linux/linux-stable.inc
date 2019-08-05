DESCRIPTION = "Common Open Source Foundries Linux microPlatform Kernel"

PV = "${LINUX_VERSION}+git${SRCPV}"

DEPENDS += "${@bb.utils.contains('ARCH', 'x86', 'elfutils-native', '', d)}"
DEPENDS += "openssl-native util-linux-native"

export DTC_FLAGS = "-@"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

inherit kernel siteinfo
require recipes-kernel/linux/linux-yocto.inc

KCONFIG_MODE = "--alldefconfig"
KERNEL_DTS_PATH = "/usr/src/dts"

KMETA = "kernel-meta"

SRC_URI += " \
	git://git.toradex.com/linux-toradex.git;protocol=https;branch=${KBRANCH};name=machine \
	git://github.com/toradex/toradex-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
"

KERNEL_INITRAMFS ?= '${@oe.utils.conditional("INITRAMFS_IMAGE_BUNDLE", "1", "1", "", d)}'

# Always have a package to allow forcing package dependency
ALLOW_EMPTY_${KERNEL_PACKAGE_NAME}-devicetree = "1"

# Task kernel_configme requires bison-native to be available
# Upstream added bison-native to build-deps but not for the required task
do_kernel_configme[depends] += "bison-native:do_populate_sysroot"

python __anonymous () {
    import bb
    devicetree = d.getVar('KERNEL_DEVICETREE') or ''
    if devicetree:
        depends = d.getVar("DEPENDS")
        d.setVar("DEPENDS", "%s dtc-native" % depends)
}

do_install_append() {
    install -d ${D}/boot
    make -C ${S} O=${B} ARCH=$ARCH dtbs || true
    install -m 0644 ${B}/arch/$ARCH/boot/dts/*.dtb ${D}/boot || true

    mkdir -p ${D}/${KERNEL_DTS_PATH}
    cp -r ${S}/arch/$ARCH/boot/dts/* ${D}/${KERNEL_DTS_PATH}
    cp -r --dereference ${S}/include/dt-bindings/ ${D}/${KERNEL_DTS_PATH}
    chown -R root:root ${D}/${KERNEL_DTS_PATH}
}

# Kernel config
KERNEL_CONFIG_NAME ?= "${KERNEL_PACKAGE_NAME}-config-${KERNEL_ARTIFACT_NAME}"
KERNEL_CONFIG_LINK_NAME ?= "${KERNEL_PACKAGE_NAME}-config"

do_deploy_append() {
    cp -a ${B}/.config ${DEPLOYDIR}/${KERNEL_CONFIG_NAME}
    ln -sf ${KERNEL_CONFIG_NAME} ${DEPLOYDIR}/${KERNEL_CONFIG_LINK_NAME}
}

PACKAGES =+ "${KERNEL_PACKAGE_NAME}-devicetree-overlays ${KERNEL_PACKAGE_NAME}-devicetree-source"
FILES_${KERNEL_PACKAGE_NAME}-devicetree-overlays = "${nonarch_base_libdir}/firmware/*.dtbo ${nonarch_base_libdir}/firmware/*.dts"
FILES_${KERNEL_PACKAGE_NAME}-devicetree += "/boot/*.dtb"
FILES_${KERNEL_PACKAGE_NAME}-devicetree-source += "${KERNEL_DTS_PATH}"

RDEPENDS_${KERNEL_PACKAGE_NAME}-image_append = " ${KERNEL_PACKAGE_NAME}-devicetree"
RRECOMMENDS_${KERNEL_PACKAGE_NAME}-image_append = " \
    ${KERNEL_PACKAGE_NAME}-devicetree-overlays \
    ${KERNEL_PACKAGE_NAME}-devicetree-source \
"
