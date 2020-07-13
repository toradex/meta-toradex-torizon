do_install_append() {
    # Remove $kerneldir/devicetree, or else ostree would not load multiple
    # devicetrees that Torizon is using.
    # Reference: https://github.com/advancedtelematic/meta-updater/pull/745
    rm -f $kerneldir/devicetree
}
