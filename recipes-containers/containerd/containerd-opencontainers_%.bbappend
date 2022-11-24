do_install:append() {
    # containerd-ctr is a tool to debug containerd and it is not
    # required in TorizonCore. Remove it to save storage.
    rm -rf ${D}/${bindir}/ctr
    rm -rf ${D}/${bindir}/containerd-ctr
    rm -rf ${D}/${bindir}/docker-containerd-ctr
}
