SUMMARY = "Toradex implementation of the Aktualizr SOTA client"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

SRC_URI = " \
  gitsm://github.com/toradex/aktualizr-torizon.git;protocol=https \
  file://0001-add-libaktualizr-update-control-allow-block-mechanism.patch \
  file://0002-fix-libaktualizr-install-path.patch \
  file://aktualizr-torizon.service \
"

SRCREV = "87e919cc0302f60814eeebeb849fde9036223529"
SRCREV_use-head-next = "${AUTOREV}"

S = "${WORKDIR}/git"

PV = "1.0+git${SRCPV}"

DEPENDS = "boost curl openssl libarchive libsodium sqlite3 asn1c-native"
RDEPENDS_${PN}_class-target = "aktualizr-hwid lshw bash aktualizr-docker-compose-sec aktualizr-polling-interval greenboot"

inherit cmake pkgconfig systemd

SYSTEMD_SERVICE_${PN} = "aktualizr-torizon.service"

# For find_package(Git)
OECMAKE_FIND_ROOT_PATH_MODE_PROGRAM = "BOTH"

PACKAGECONFIG ?= "ostree ${@bb.utils.filter('SOTA_CLIENT_FEATURES', 'hsm serialcan ubootenv', d)}"
PACKAGECONFIG[warning-as-error] = "-DWARNING_AS_ERROR=ON,-DWARNING_AS_ERROR=OFF,"
PACKAGECONFIG[ostree] = "-DBUILD_OSTREE=ON,-DBUILD_OSTREE=OFF,ostree,"
PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils"
PACKAGECONFIG_remove_class-native = "ubootenv"

PROVIDES += "aktualizr"
RPROVIDES_${PN} += "aktualizr aktualizr-info aktualizr-shared-prov"

do_install_append() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/aktualizr-torizon.service ${D}${systemd_unitdir}/system/aktualizr-torizon.service

    install -m 0700 -d ${D}${libdir}/sota/conf.d 
    install -m 0644 ${S}/aktualizr/config/sota-device-cred.toml ${D}/${libdir}/sota/conf.d/20-sota-device-cred.toml
    install -m 0644 ${S}/aktualizr/config/sota-uboot-env.toml ${D}/${libdir}/sota/conf.d/30-rollback.toml
}

PACKAGES =+ "${PN}-misc"

FILES_${PN} += " \
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

FILES_${PN}-dev = " \
  ${libdir}/libsota_tools.so \
  ${includedir}/libaktualizr \
"

FILES_${PN}-misc = " \
  ${bindir}/aktualizr \
  ${bindir}/aktualizr-secondary \ 
  ${libdir}/libaktualizr_secondary.so \
  ${libdir}/libsota_tools.so \
  ${bindir}/aktualizr-get \
  ${bindir}/uptane-generator \
"

BBCLASSEXTEND = "native"
