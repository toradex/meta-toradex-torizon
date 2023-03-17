# in the engineering build, we need to enable break to debug by kernel.sysrq
do_install:append() {
    if [ "${TDX_DEBUG}" = "1" ]; then
        for keyword in \
            kernel.sysrq \
        ; do
            # enabled
            sed -i 's,'"$keyword"'=.*,'"$keyword"'=1,' ${D}${sysconfdir}/sysctl.conf
            # uncomment
            sed -i '/kernel.sysrq/s/^#//' ${D}${sysconfdir}/sysctl.conf
        done
    fi
}
