SUMMARY = "Toradex implementation of the Aktualizr SOTA client"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

SRC_URI = " \
  gitsm://github.com/toradex/aktualizr.git;protocol=https;branch=toradex-master \
  file://aktualizr-torizon.service \
  file://gateway.url \
  file://root.crt \
"

SRCREV = "42c9a7407e838832ebb25534556b727471b25f64"
SRCREV:use-head-next = "${AUTOREV}"

S = "${WORKDIR}/git"

PV = "1.0+git${SRCPV}"

DEPENDS = "boost curl openssl libarchive libsodium sqlite3 asn1c-native"
RDEPENDS:${PN}:class-target = "aktualizr-hwid lshw bash aktualizr-default-sec aktualizr-polling-interval greenboot"

inherit cmake pkgconfig systemd

SYSTEMD_SERVICE:${PN} = "aktualizr-torizon.service"

# For find_package(Git)
OECMAKE_FIND_ROOT_PATH_MODE_PROGRAM = "BOTH"

PACKAGECONFIG ?= "ostree ${@bb.utils.filter('SOTA_CLIENT_FEATURES', 'hsm serialcan ubootenv', d)}"
PACKAGECONFIG[warning-as-error] = "-DWARNING_AS_ERROR=ON,-DWARNING_AS_ERROR=OFF,"
PACKAGECONFIG[ostree] = "-DBUILD_OSTREE=ON,-DBUILD_OSTREE=OFF,ostree,"
PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils"
PACKAGECONFIG:remove:class-native = "ubootenv"

PROVIDES += "aktualizr"
RPROVIDES:${PN} += "aktualizr aktualizr-info aktualizr-shared-prov"

do_install:append() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/aktualizr-torizon.service ${D}${systemd_unitdir}/system/aktualizr-torizon.service

    install -m 0700 -d ${D}${libdir}/sota/conf.d 
    install -m 0644 ${S}/config/sota-device-cred.toml ${D}/${libdir}/sota/conf.d/20-sota-device-cred.toml
    install -m 0644 ${S}/config/sota-uboot-env.toml ${D}/${libdir}/sota/conf.d/30-rollback.toml
    
    install -m 0644 ${WORKDIR}/gateway.url ${D}/${libdir}/sota/gateway.url
    install -m 0644 ${WORKDIR}/root.crt ${D}/${libdir}/sota/root.crt
}

PACKAGES =+ "${PN}-misc"

FILES:${PN} += " \
  ${bindir}/aktualizr-torizon \
  ${libdir}/libaktualizr.so \
  ${systemd_unitdir}/system/aktualizr-torizon.service \
  ${sysconfdir}/sota/* \
  ${libdir}/sota/* \
  ${libdir}/sota/conf.d \
  ${libdir}/sota/conf.d/20-sota-device-cred.toml \
  ${libdir}/sota/conf.d/30-rollback.toml \
  ${bindir}/aktualizr-info \
  ${binddir}/aktualizr-cert-provider \
"

FILES:${PN}-dev = " \
  ${libdir}/libsota_tools.so \
  ${includedir}/libaktualizr \
  ${libdir}/pkgconfig \
"

FILES:${PN}-misc = " \
  ${bindir}/aktualizr-secondary \ 
  ${libdir}/libaktualizr_secondary.so \
  ${libdir}/libsota_tools.so \
  ${bindir}/aktualizr-get \
  ${bindir}/uptane-generator \
"

BBCLASSEXTEND = "native"
