DESCRIPTION = "Make your Docker Compose applications reusable, and share them on Docker Hub"
HOMEPAGE = "https://github.com/docker/app"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

GO_IMPORT = "github.com/docker/app"
SRC_URI = "git://${GO_IMPORT} \
           file://0001-packing-use-foundries-cnab-app-base.patch;patchdir=src/${GO_IMPORT} \
          "

SRCREV = "6d698be254478dffe42cfc3b44664d8b611fd42f"

UPSTREAM_CHECK_COMMITS = "1"
PV = "v0.9.0"

DEPENDS = "torizon-users"
RDEPENDS_${PN}-dev += "bash"

FILES_${PN} += "/home/torizon/.docker/cli-plugins/docker-app"

inherit go goarch

do_compile() {
	cd ${S}/src/${GO_IMPORT}
	BUILD_COMMIT=`git rev-parse --short HEAD`
	DOCKER_APP_LDFLAGS="-X ${GO_IMPORT}/internal.GitCommit=${BUILD_COMMIT} \
		-X ${GO_IMPORT}/internal.Version=${PV} \
		-X ${GO_IMPORT}/internal.Experimental=off"

	mkdir -p ${B}/${GO_BUILD_BINDIR}
	${GO} build -ldflags="${DOCKER_APP_LDFLAGS}" -o ${B}/${GO_BUILD_BINDIR}/docker-app ./cmd/docker-app
}

do_install() {
	install -d ${D}/home/torizon/.docker/cli-plugins
	install -m 0755 ${B}/${GO_BUILD_BINDIR}/docker-app ${D}/home/torizon/.docker/cli-plugins
	chown torizon:torizon -R ${D}/home/torizon
}
