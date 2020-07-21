FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

inherit bash-completion

SRCREV_docker = "48a66213fe1747e8873f849862ff3fb981899fc6"
SRCREV_libnetwork = "026aabaa659832804b01754aaadd2c0f420c68b6"

DOCKER_VERSION = "19.03.12-ce"

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
