FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

inherit bash-completion

SRCREV_docker = "5eb3275d4006e4093807c35b4f7776ecd73b13a7"
SRCREV_libnetwork = "55e924b8a84231a065879156c0de95aefc5f5435"

DOCKER_VERSION = "19.03.14-ce"

SRC_URI_append = " \
    file://chrome.json \
"

do_install_append() {
	# Install chrome seccomp config file
	if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/docker/seccomp
		install -m 0644 ${WORKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
	fi

	COMPLETION_DIR=${D}${datadir}/bash-completion/completions
	install -d ${COMPLETION_DIR}
	install -m 0644 ${S}/src/import/components/cli/contrib/completion/bash/docker ${COMPLETION_DIR}
}
