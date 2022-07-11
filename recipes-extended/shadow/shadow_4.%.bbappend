do_install:append () {
    touch ${D}${sysconfdir}/subuid
    touch ${D}${sysconfdir}/subgid
}
