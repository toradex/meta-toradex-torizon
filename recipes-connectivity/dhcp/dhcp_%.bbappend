do_install:append() {
	install -d ${D}${exec_prefix}/lib/tmpfiles.d
	echo 'd /var/lib/dhcp 0755 - - - -' > ${D}${exec_prefix}/lib/tmpfiles.d/dhcpd.conf
	echo 'f /var/lib/dhcp/dhcpd.leases - - - - -' >> ${D}${exec_prefix}/lib/tmpfiles.d/dhcpd.conf
}

FILES:${PN}-client += "${exec_prefix}/lib/tmpfiles.d/dhcpd.conf"
