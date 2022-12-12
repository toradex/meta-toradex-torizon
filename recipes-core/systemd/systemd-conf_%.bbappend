FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "\
    file://system.conf-torizon \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install_append() {
	# Do not install default config file for wired networks, we use NetworkManager
	# by default
	rm -rf ${D}${systemd_unitdir}/network

        # Install systemd configuration snippet for TorizonCore
	install -D -m0644 ${WORKDIR}/system.conf-torizon ${D}${systemd_unitdir}/system.conf.d/10-${BPN}.conf

        sed -i "s/@@MACHINE@@/${MACHINE}/g" ${D}${systemd_unitdir}/system.conf.d/10-${BPN}.conf 
}

# On Colibri iMX7, the default watchdog (/dev/watchdog0) is the one from the PMIC, and using it causes
# problems when trying to shutdown the device, so let's force the usage of the internal watchdog from
# the SoC (/dev/watchdog1).
do_install_append_colibri-imx7-emmc() {
	echo "WatchdogDevice=/dev/watchdog1" >> ${D}${systemd_unitdir}/system.conf.d/10-${BPN}.conf
}
