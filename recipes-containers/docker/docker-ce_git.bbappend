FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://chrome.json \
    file://docker.service \
"

SRCREV_docker = "afacb8b7f0d8d4f9d2a8e8736e9c993e672b41f3"

DOCKER_VERSION = "19.03.8-ce"

do_install_prepend() {
	# Final dockerd binary location has been moved. Work around by creating
	# a symlink instead of overwriting the complete do_install task.
	mkdir -p ${S}/src/import/components/engine/bundles/latest/
	ln -sf ${S}/src/import/components/engine/bundles/dynbinary-daemon/ \
		${S}/src/import/components/engine/bundles/latest/dynbinary-daemon

	# Install chrome seccomp config file
	if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/docker/seccomp
		install -m 0644 ${WORKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
	fi
}

do_install_append() {
	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		# Replace docker.service with the TorizonCore specific version
		install -m 644 ${WORKDIR}/docker.service ${D}/${systemd_unitdir}/system
	fi
}
