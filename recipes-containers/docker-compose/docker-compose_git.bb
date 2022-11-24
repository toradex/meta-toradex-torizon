HOMEPAGE = "https://github.com/docker/compose"
SUMMARY =  "Multi-container orchestration for Docker"
DESCRIPTION = "Docker compose v2"

DEPENDS = " \
    go-md2man \
    rsync-native \
"

# Specify the first two important SRCREVs as the format
SRCREV_FORMAT="compose_survey"
SRCREV_compose = "b15df818c759b355b03ed70505ffa451301eb566"

SRC_URI = "git://github.com/docker/compose;name=compose;branch=v2;protocol=https"

include src_uri.inc

# patches and config
SRC_URI += "file://modules.txt"

SRC_URI[sha256sum] = "d7b05a9bff34dfb25abe7e5b1e54cf2607f953d91cb33fb231a4775a1a4afa3d"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

GO_IMPORT = "import"

PV = "v2.11.2"

COMPOSE_PKG = "github.com/docker/compose/v2"

inherit go goarch
inherit pkgconfig

do_configure[noexec] = "1"

PACKAGECONFIG ?= ""

include relocation.inc

do_compile() {
    	cd ${S}/src/import

	export GOPATH="$GOPATH:${S}/src/import/.gopath"

	# Pass the needed cflags/ldflags so that cgo
	# can find the needed headers files and libraries
	export GOARCH=${TARGET_GOARCH}
	export CGO_ENABLED="1"
	export CGO_CFLAGS="${CFLAGS} --sysroot=${STAGING_DIR_TARGET}"
	export CGO_LDFLAGS="${LDFLAGS} --sysroot=${STAGING_DIR_TARGET}"

	export GOFLAGS="-mod=vendor -trimpath"

	# our copied .go files are to be used for the build
	ln -sf vendor.copy vendor
	# inform go that we know what we are doing
	cp ${WORKDIR}/modules.txt vendor/

	GO_LDFLAGS="-s -w -X internal.Version=${PV} -X ${COMPOSE_PKG}/internal.Version=${PV}"
	GO_BUILDTAGS=""
	mkdir -p ./bin
	${GO} build $GOFLAGS -tags "$GO_BUILDTAGS" -ldflags "$GO_LDFLAGS" -o ./bin/docker-compose ./cmd
}

do_install() {
        #install -d "${D}${BIN_PREFIX}/bin"
        #install -m 755 "${S}/src/import/bin/docker-compose" "${D}${BIN_PREFIX}/bin"

	# commonly installed to: /usr/lib/docker/cli-plugins/
	install -d "${D}${libdir}/docker/cli-plugins/"
	install -m 755 "${S}/src/import/bin/docker-compose" "${D}${libdir}/docker/cli-plugins/"

}

RDEPENDS:${PN} += " docker"

FILES:${PN} += " ${libdir}/docker/cli-plugins/"

INHIBIT_PACKAGE_STRIP = "1"
INSANE_SKIP:${PN} += "ldflags already-stripped"
