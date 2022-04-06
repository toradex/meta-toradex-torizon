FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit bash-completion

# we want control over the version TorizonCore will use
SRCREV_moby = "363e9a88a11be517d9e8c65c998ff56f774eb4dc"
SRCREV_libnetwork = "fa125a3512ee0f6187721c88582bf8c4378bd4d7"
SRCREV_cli = "55c4c88966a912ddb365e2d73a4969e700fc458f"
DOCKER_VERSION = "20.10.5"

SRC_URI_append = " \
    file://chrome.json \
"

do_install_append() {
	if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/docker/seccomp
		install -m 0644 ${WORKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
	fi

	COMPLETION_DIR=${D}${datadir}/bash-completion/completions
	install -d ${COMPLETION_DIR}
	install -m 0644 ${S}/cli/contrib/completion/bash/docker ${COMPLETION_DIR}
}
