FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://initial-support-for-docker-compose-secondaries.patch \
"

PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils aktualizr-uboot-env-rollback"
