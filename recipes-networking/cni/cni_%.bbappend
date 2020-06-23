do_compile_append () {
    chmod +w -R ${S}
}

do_install_append_sota () {
    # Data in /opt directory is not preserved by OSTree, drop it to avoid
    # warnings in ostree image task.
    rm -rf ${D}/opt
}
