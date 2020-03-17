FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://sysctl-panic.conf \
"

PACKAGECONFIG_append = " resolved networkd"
RRECOMMENDS_${PN}_remove = "os-release"

do_install_append () {
	install -m 0644 ${WORKDIR}/sysctl-panic.conf ${D}${exec_prefix}/lib/sysctl.d/60-panic.conf
}

PACKAGE_WRITE_DEPS_append = " ${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd-systemctl-native','',d)}"
pkg_postinst_${PN}_append () {
	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		if [ -n "$D" ]; then
			OPTS="--root=$D"
		fi
		# Disable reboot when Ctrl+Alt+Del is pressed on a USB keyboard
		systemctl $OPTS mask ctrl-alt-del.target

		# Mask systemd-networkd-wait-online.service to avoid long boot times
		# when networking is unplugged
		systemctl $OPTS mask systemd-networkd-wait-online.service
	fi
}
