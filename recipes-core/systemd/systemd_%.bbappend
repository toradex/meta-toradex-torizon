FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

ALTERNATIVE_PRIORITY[resolv-conf] = "300"

SRC_URI:append = " \
    file://0001-tmpfiles-tmp.conf-reduce-cleanup-age-to-half.patch \
    file://0002-systemd-networkd-wait-online.service.in-use-any-by-d.patch \
    file://systemd-timesyncd-update.service \
"

SRC_URI:append:genericx86-64 = " file://0001-rules-whitelist-hd-devices.patch"

PACKAGECONFIG:append = " resolved networkd"
RRECOMMENDS:${PN}:remove = "os-release"

# /var is expected to be rw, so drop volatile-binds service files
RDEPENDS:${PN}:remove = "volatile-binds"

DEF_FALLBACK_NTP_SERVERS="time.cloudflare.com time1.google.com time2.google.com time3.google.com time4.google.com"

# Since 'sota.conf.inc' is export '0' into SOURCE_DATE_EPOCH, we populate this variable locally with the default
# value calculated by Yocto, as this value is used to do an initial system clock setup.
SOURCE_DATE_EPOCH = "${@get_source_date_epoch_value(d)}"

EXTRA_OEMESON += ' \
	-Dntp-servers="${DEF_FALLBACK_NTP_SERVERS}" \
'

PACKAGE_WRITE_DEPS:append = " ${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd-systemctl-native','',d)}"
pkg_postinst:${PN}:append () {
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

do_install:append() {
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
