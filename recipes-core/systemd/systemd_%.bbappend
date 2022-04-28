FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

ALTERNATIVE_PRIORITY[resolv-conf] = "300"

SRC_URI_append = " \
    file://0001-tmpfiles-tmp.conf-reduce-cleanup-age-to-half.patch \
    file://0002-systemd-networkd-wait-online.service.in-use-any-by-d.patch \
    file://systemd-timesyncd-update.service \
"

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

# /var is expected to be rw, so drop volatile-binds service files
RDEPENDS_${PN}_remove = "volatile-binds"

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
    if [ ${@ oe.types.boolean('${VOLATILE_LOG_DIR}') } = True ]; then
        sed -i '/^d \/var\/log /d' ${D}${nonarch_libdir}/tmpfiles.d/var.conf
        echo 'L+ /var/log - - - - /var/volatile/log' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
    else
        # Make sure /var/log is not a link to volatile (e.g. after system updates)
        sed -i '/\[Service\]/aExecStartPre=-/bin/rm -f /var/log' ${D}${systemd_system_unitdir}/systemd-journal-flush.service
    fi

    # Workaround for https://github.com/systemd/systemd/issues/11329
    install -m 0644 ${WORKDIR}/systemd-timesyncd-update.service ${D}${systemd_system_unitdir}
    ln -sf ../systemd-timesyncd-update.service ${D}${systemd_system_unitdir}/sysinit.target.wants/systemd-timesyncd-update.service
}
