DESCRIPTION = "Docker data disk image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
	file://Dockerfile \
	file://entry.sh \
        file://docker-preload.service \
	"

S = "${WORKDIR}"
B = "${S}/build"

require docker-disk.inc
inherit systemd

# By default pull resin-supervisor
TARGET_REPOSITORY ?= "bshibley/debian-lxde-x11"
TARGET_TAG ?= "buster"


python () {
	import re
	repo = d.getVar("TARGET_REPOSITORY", True)
	tag = d.getVar("TARGET_TAG", True)
	pv = re.sub(r"[^a-z0-9A-Z_.-]", "_", "%s-%s" % (repo,tag))
	d.setVar('PV', pv)
}

PV = "${TARGET_TAG}"

recursiveSearch () {
	for f in $1/*
        do
		if [ -c "$f" ]; then
			echo "removing $f"
			rm -rf "$f" || true
		elif [ -d "$f" ]; then
			recursiveSearch $f
		fi
	done
}

do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile () {
	# Some sanity first
	if [ -z "${TARGET_REPOSITORY}" ] || [ -z "${TARGET_TAG}" ]; then
		bbfatal "docker-disk: TARGET_REPOSITORY and/or TARGET_TAG not set."
	fi

	# At this point we really need internet connectivity for building the
	# docker image
	if [ "x${@connected(d)}" != "xyes" ]; then
		bbfatal "docker-disk: Can't compile as there is no internet connectivity on this host."
	fi

	# We force the PATH to be the standard linux path in order to use the host's
	# docker daemon instead of the result of docker-native. This avoids version
	# mismatches
	DOCKER=$(PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" which docker)

	# Generate the data filesystem
	RANDOM=$$
	_image_name="docker-disk-$RANDOM"
	_container_name="docker-disk-$RANDOM"
	$DOCKER rmi ${_image_name} > /dev/null 2>&1 || true
	$DOCKER build -t ${_image_name} -f ${WORKDIR}/Dockerfile ${WORKDIR}
	$DOCKER run --privileged --rm \
		-e BALENA_STORAGE=overlay2 \
		-e USER_ID=$(id -u) -e USER_GID=$(id -u) \
		-e TARGET_REPOSITORY="${TARGET_REPOSITORY}" \
		-e TARGET_TAG="${TARGET_TAG}" \
		-v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ${B}:/build \
		--name ${_container_name} ${_image_name}
	$DOCKER rmi ${_image_name}

        recursiveSearch ${B}/docker/overlay2

	sed -i 's|@@REPO@@|${TARGET_REPOSITORY}|' "${WORKDIR}/docker-preload.service"
	sed -i 's|@@TAG@@|${TARGET_TAG}|' "${WORKDIR}/docker-preload.service"
}

do_install () {
	install -d ${D}/var/lib/
	cp -R --no-dereference --preserve=mode,links ${B}/docker ${D}/var/lib/

	install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/docker-preload.service ${D}${systemd_system_unitdir}
}

FILES_${PN} += "/var/lib/ ${systemd_system_unitdir}"
SYSTEMD_SERVICE_${PN} = "docker-preload.service"
