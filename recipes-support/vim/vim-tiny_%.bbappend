FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://defaults.vim \
"

do_install_append() {
    install -d ${D}/${datadir}/vim
    install -m 0644 ${WORKDIR}/defaults.vim ${D}/${datadir}/vim/
}

FILES_${PN} += "${datadir}/vim/*"
