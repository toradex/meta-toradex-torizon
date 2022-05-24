FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

inherit bash-completion

SRC_URI_append = " \
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
        install -m 644 ${WORKDIR}/docker.service ${D}/${systemd_unitdir}/system
    fi

    if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/docker/seccomp
        install -m 0644 ${WORKDIR}/chrome.json ${D}${sysconfdir}/docker/seccomp/chrome.json
    fi

    COMPLETION_DIR=${D}${datadir}/bash-completion/completions
    install -d ${COMPLETION_DIR}
    install -m 0644 ${S}/cli/contrib/completion/bash/docker ${COMPLETION_DIR}
}

# pigz takes advantage of both multiple CPUs and multiple CPU cores for higher
# compression and decompression speed, and also set at the official packages
RDEPENDS_${PN} += "pigz"
FILES_${PN} += "${libdir}/docker"
