FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

inherit bash-completion

SRCREV_docker = "5eb3275d4006e4093807c35b4f7776ecd73b13a7"
SRCREV_libnetwork = "55e924b8a84231a065879156c0de95aefc5f5435"

DOCKER_VERSION = "19.03.14-ce"

# The patch that adds configurable maximum of download attempts originates
# from https://github.com/docker/docker-ce/commit/74d15487080abcfce9d9359a746620a7f7c06c5b
SRC_URI_append = " \
    file://dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://cli-config-support-default-system-config.patch \
    file://dockerd-daemon-configurable-max-download-attempts.patch \
    file://daemon.json.in \
    file://docker.service \
    file://chrome.json \
"

DOCKER_MAX_CONCURRENT_DOWNLOADS ?= "3"
DOCKER_MAX_DOWNLOAD_ATTEMPTS ?= "5"

# Prefer docker.service instead of docker.socket as this is a critical service
SYSTEMD_SERVICE_${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','docker.service','',d)}"

do_install_prepend() {
    sed -e 's/@@MAX_CONCURRENT_DOWNLOADS@@/${DOCKER_MAX_CONCURRENT_DOWNLOADS}/' \
        -e 's/@@MAX_DOWNLOAD_ATTEMPTS@@/${DOCKER_MAX_DOWNLOAD_ATTEMPTS}/' \
        ${WORKDIR}/daemon.json.in > ${WORKDIR}/daemon.json
}

do_install_append() {
	install -d ${D}${libdir}/docker
	install -m 0644 ${WORKDIR}/daemon.json ${D}${libdir}/docker/

	# Replace default docker.service with the one provided by this recipe
	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -m 644 ${WORKDIR}/docker.service ${D}${systemd_unitdir}/system
	fi

	# Install chrome seccomp config file
	if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/docker/seccomp
		install -m 0644 ${WORKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
	fi

	COMPLETION_DIR=${D}${datadir}/bash-completion/completions
	install -d ${COMPLETION_DIR}
	install -m 0644 ${S}/src/import/components/cli/contrib/completion/bash/docker ${COMPLETION_DIR}

	# systemd[1]: /usr/lib/systemd/system/docker.socket:6: ListenStream= references
	# a path below legacy directory /var/run/, updating /var/run/docker.sock → /run/docker.sock;
	# please update the unit file accordingly.
	sed -i -e 's#ListenStream=/var#ListenStream=#' ${D}${systemd_system_unitdir}/docker.socket
}

FILES_${PN} += "${libdir}/docker"
