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
	git://github.com/toradex/toradex-kernel-cache.git;protocol=file;type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA} \
"

# You can define CMDLINE_DEBUG as "debug" in your local.conf or distro.conf
# to enable kernel debugging.
CMDLINE_DEBUG ?= ""
CMDLINE_append = " ${CMDLINE_DEBUG}"

KERNEL_INITRAMFS ?= '${@oe.utils.conditional("INITRAMFS_IMAGE_BUNDLE", "1", "1", "", d)}'

# Always have a package to allow forcing package dependency
ALLOW_EMPTY_${KERNEL_PACKAGE_NAME}-devicetree = "1"

# Task kernel_configme requires bison-native to be available
# Upstream added bison-native to build-deps but not for the required task
do_kernel_configme[depends] += "bison-native:do_populate_sysroot"

python __anonymous () {
    import bb
    devicetree = d.getVar('KERNEL_DEVICETREE', True) or ''
    if devicetree:
        depends = d.getVar("DEPENDS", True)
        d.setVar("DEPENDS", "%s dtc-native" % depends)
}

# Set a variable in .configure
# $1 - Configure variable to be set
# $2 - value [n/y/value]
kernel_configure_variable() {
    # Remove the config
    CONF_SED_SCRIPT="$CONF_SED_SCRIPT /CONFIG_$1[ =]/d;"
    if test "$2" = "n"
    then
        echo "# CONFIG_$1 is not set" >> ${B}/.config
    else
        echo "CONFIG_$1=$2" >> ${B}/.config
    fi
}

do_configure_prepend() {
    mv -f ${B}/.config ${B}/.config.patched
    CONF_SED_SCRIPT=""

    # Set cmdline
    kernel_configure_variable CMDLINE "\"${CMDLINE}\""

    # Keep this the last line
    # Remove all modified configs and add the rest to .config
    sed -e "${CONF_SED_SCRIPT}" < '${B}/.config.patched' >> '${B}/.config'
    rm -f ${B}/.config.patched
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

do_deploy_append() {
    # Workaround for usrmerge
    if [ ${MODULE_TARBALL_DEPLOY} = "1" ] && (grep -q -i -e '^CONFIG_MODULES=y$' .config); then
        mkdir -p ${D}${nonarch_base_libdir}
        tar -cvzf $deployDir/modules-${MODULE_TARBALL_NAME}.tgz -C ${D} ${nonarch_base_libdir#/}
        ln -sf modules-${MODULE_TARBALL_NAME}.tgz $deployDir/modules-${MODULE_TARBALL_LINK_NAME}.tgz
    fi
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
