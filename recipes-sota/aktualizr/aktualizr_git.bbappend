FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-initial-support-for-docker-compose-secondaries.patch \
    file://0002-add-aktualizr-update-control-allow-block-mechanism.patch \
    file://0003-Integrate-Docker-Compose-with-Aktualizr.patch \
"

RDEPENDS_${PN}-configs += "aktualizr-docker-compose-sec aktualizr-polling-interval"
