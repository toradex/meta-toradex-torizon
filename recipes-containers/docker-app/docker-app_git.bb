DESCRIPTION = "Make your Docker Compose applications reusable, and share them on Docker Hub"
HOMEPAGE = "https://github.com/docker/app"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

GO_IMPORT = "github.com/docker/app"
SRC_URI = "git://${GO_IMPORT} \
           file://0001-Allow-to-set-CNAB-image-name.patch;patchdir=src/${GO_IMPORT} \
"
SRCREV = "7eea32b735b1830ca7de723a1ecb923eae65a2f7"

UPSTREAM_CHECK_COMMITS = "1"
PV = "v0.8.0"

def map_cnab_image(a, v):
    if a == "arm64":
        return 'torizon/arm64v8-cnab-app-base'
    elif a == 'arm' and v == '7':
        return 'torizon/arm32v7-cnab-app-base'
    else:
        return 'docker/cnab-app-base'

CNAB_IMAGENAME = "${@map_cnab_image(d.getVar('TARGET_GOARCH'), d.getVar('TARGET_GOARM'))}"

RDEPENDS_${PN}-dev += "bash"

inherit go goarch deploy

do_compile() {
	cd ${S}/src/${GO_IMPORT}
	BUILD_TAG=`git describe --always --abbrev=10`
	BUILD_COMMIT=`git rev-parse --short HEAD`
	DOCKER_APP_LDFLAGS="-X ${GO_IMPORT}/internal.GitCommit=${BUILD_COMMIT} \
		-X ${GO_IMPORT}/internal.Version=${BUILD_TAG} \
		-X ${GO_IMPORT}/internal.CnabImage=${CNAB_IMAGENAME} \
		-X ${GO_IMPORT}/internal.Experimental=off"

	mkdir -p ${B}/${GO_BUILD_BINDIR}
	${GO} build -ldflags="${DOCKER_APP_LDFLAGS}" -o ${B}/${GO_BUILD_BINDIR}/docker-app ./cmd/docker-app-standalone
	${GO} build -ldflags="${DOCKER_APP_LDFLAGS} -s -w" -o ${WORKDIR}/cnab-run ./cmd/cnab-run
}

do_deploy() {
	install -m 0644 ${WORKDIR}/cnab-run ${DEPLOYDIR}/cnab-run
}

addtask deploy after do_install before do_build
