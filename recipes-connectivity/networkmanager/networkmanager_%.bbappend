FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://toradex-nmconnection.conf file://network.nmconnection.in"

PACKAGECONFIG_remove = "ifupdown dnsmasq"

PACKAGECONFIG_append = "modemmanager"
RPROVIDES_${PN} = "network-configuration"

do_install_append() {
    install -m 0600 ${WORKDIR}/toradex-nmconnection.conf ${D}${nonarch_libdir}/NetworkManager/conf.d

    sed -e "s/@NET_NUM@/0/g" \
        ${WORKDIR}/network.nmconnection.in \
        >  ${D}${sysconfdir}/NetworkManager/system-connections/network0.nmconnection

    sed -e "s/@NET_NUM@/1/g" \
        ${WORKDIR}/network.nmconnection.in \
        >  ${D}${sysconfdir}/NetworkManager/system-connections/network1.nmconnection

    chmod 0600 ${D}${sysconfdir}/NetworkManager/system-connections/network?.nmconnection
}
