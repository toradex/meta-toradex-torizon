SUMMARY = "Set up configs for Torizon system"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://path-sbin.sh \
    file://docker-cli-experimental.sh \
"

EXCLUDE_FROM_WORLD = "1"
INHIBIT_DEFAULT_DEPS = "1"

do_install () {
    install -d ${D}${sysconfdir}/profile.d
    install -m 0755 ${WORKDIR}/path-sbin.sh ${D}${sysconfdir}/profile.d/
    install -m 0755 ${WORKDIR}/docker-cli-experimental.sh ${D}${sysconfdir}/profile.d/
}
