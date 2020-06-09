FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://initial-support-for-docker-compose-secondaries.patch \
    file://0001-add-support-for-torizon-boot-complete-solution.patch \
"

PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils aktualizr-uboot-env-rollback"
