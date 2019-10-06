do_install_append () {
    touch ${D}${sysconfdir}/subuid
    touch ${D}${sysconfdir}/subgid
}
