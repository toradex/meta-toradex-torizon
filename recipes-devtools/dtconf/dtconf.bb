LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRCREV = "${AUTOREV}"
SRC_URI = "git://gitlab.toradex.int/torizon-core/device-tree-conf.git;protocol=http;branch=master \
"

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
    install -m 0644 ${WORKDIR}/git/fw_env.config ${D}${DEST_FOLDER}/conf/fw_env.config
    install -m 0755 ${WORKDIR}/git/fw_unlock_mmc.sh ${D}${DEST_FOLDER}/conf/fw_unlock_mmc.sh
}
