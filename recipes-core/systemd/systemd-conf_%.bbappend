# Do not install default config file for wired networks, we use NetworkManager
# by default
do_install_append() {
	rm -rf ${D}${systemd_unitdir}/network
}

