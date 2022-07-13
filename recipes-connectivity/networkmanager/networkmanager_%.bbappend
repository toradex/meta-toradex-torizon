FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "\
    file://0001-85-nm-unmanaged.rules-do-not-manage-docker-bridges.patch \
    file://toradex-nmconnection.conf \
    file://network.nmconnection.in \
"

# Depend on libedit as it has a more friendly license than readline (GPLv3)
DEPENDS += "libedit"

PACKAGECONFIG:remove = "dnsmasq"

PACKAGECONFIG:append = " modemmanager ppp"
RPROVIDES:${PN} = "network-configuration"

do_install:append() {
    install -m 0600 ${WORKDIR}/toradex-nmconnection.conf ${D}${nonarch_libdir}/NetworkManager/conf.d

    sed -e "s/@NET_NUM@/0/g" \
        ${WORKDIR}/network.nmconnection.in \
        >  ${D}${sysconfdir}/NetworkManager/system-connections/network0.nmconnection

    sed -e "s/@NET_NUM@/1/g" \
        ${WORKDIR}/network.nmconnection.in \
        >  ${D}${sysconfdir}/NetworkManager/system-connections/network1.nmconnection

    chmod 0600 ${D}${sysconfdir}/NetworkManager/system-connections/network?.nmconnection
}
