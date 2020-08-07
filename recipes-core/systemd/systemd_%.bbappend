FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_genericx86-64 = " file://0001-rules-whitelist-hd-devices.patch"

PACKAGECONFIG_append = " resolved networkd"
RRECOMMENDS_${PN}_remove = "os-release"

DEF_FALLBACK_NTP_SERVERS="time.cloudflare.com time1.google.com time2.google.com time3.google.com time4.google.com"
EXTRA_OEMESON += ' \
	-Dntp-servers="${DEF_FALLBACK_NTP_SERVERS}" \
'

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
