FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-docker-config-support-default-system-config.patch \
    file://storage.conf \
    file://registries.conf \
"

do_install:append() {
    install ${WORKDIR}/storage.conf ${D}/${sysconfdir}/containers/storage.conf
    install ${WORKDIR}/registries.conf ${D}/${sysconfdir}/containers/registries.conf
}
