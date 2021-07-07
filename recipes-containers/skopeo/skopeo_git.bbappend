FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = " \
    git://github.com/containers/skopeo;branch=main \
    file://storage.conf \
    file://registries.conf \
"

do_install_append() {
    install ${WORKDIR}/storage.conf ${D}/${sysconfdir}/containers/storage.conf
    install ${WORKDIR}/registries.conf ${D}/${sysconfdir}/containers/registries.conf
}
