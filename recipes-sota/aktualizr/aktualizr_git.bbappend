FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://initial-support-for-docker-compose-secondaries.patch \
"
