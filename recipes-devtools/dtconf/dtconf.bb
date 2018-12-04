LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRCREV = "525c5d0c14e1809c76fe8c7faf6e2e9f364b56b8"
SRC_URI = "git://github.com/toradex/device-tree-conf.git;protocol=https;branch=master"

DEST_FOLDER = "${datadir}/device-tree-conf"

FILES_${PN} = "\
    ${DEST_FOLDER}  \
    ${bindir}       \
    ${sysconfdir}   \
"

do_install () {
    install -d ${D}${bindir}/
    install -d ${D}${DEST_FOLDER}/
    install -d ${D}${DEST_FOLDER}/conf
    install -m 0755 ${WORKDIR}/git/dtconf.sh ${D}${bindir}/dtconf
}
