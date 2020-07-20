FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

inherit bash-completion

SRC_URI_append = " \
    file://chrome.json \
    file://docker.service \
"

do_install_append() {
	# Install chrome seccomp config file
	if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/docker/seccomp
		install -m 0644 ${WORKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
	fi

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		# Replace docker.service with the TorizonCore specific version
		install -m 644 ${WORKDIR}/docker.service ${D}/${systemd_unitdir}/system
	fi

	COMPLETION_DIR=${D}${datadir}/bash-completion/completions
	install -d ${COMPLETION_DIR}
	install -m 0644 ${S}/src/import/components/cli/contrib/completion/bash/docker ${COMPLETION_DIR}
}
