FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_genericx86-64 = " file://0001-rules-whitelist-hd-devices.patch"

PACKAGECONFIG_append = " resolved networkd"
RRECOMMENDS_${PN}_remove = "os-release"

# Workaround for some systemd specific udev rules being packaged in
# systemd package while they are needed by initramfs which doesn't
# want install systemd. Please refer to the discussion:
# https://www.mail-archive.com/openembedded-core@lists.openembedded.org/msg140195.html
#
# Fix it by splitting systemd specific udev rules to its own package,
# which could be installed by initramfs.
PACKAGES_prepend = "${PN}-udev-rules "
RDEPENDS_${PN} += "systemd-udev-rules"
FILES_${PN}-udev-rules = " \
    ${rootlibexecdir}/udev/rules.d/70-uaccess.rules \
    ${rootlibexecdir}/udev/rules.d/71-seat.rules \
    ${rootlibexecdir}/udev/rules.d/73-seat-late.rules \
    ${rootlibexecdir}/udev/rules.d/99-systemd.rules \
"

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

do_install_append() {
	# meta-lmp is moving 00-create-volatile.conf to /usr/lib, but we need this file to
	# be writable for users to enable persistent logging, so let's move it back to /etc
	mv ${D}${nonarch_libdir}/tmpfiles.d/00-create-volatile.conf ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
}
