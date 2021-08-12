SUMMARY = "Fast Log processor and Forwarder"
DESCRIPTION = "Fluent Bit is a data collector, processor and  \
forwarder for Linux. It supports several input sources and \
backends (destinations) for your data. \
"

HOMEPAGE = "http://fluentbit.io"
BUGTRACKER = "https://github.com/fluent/fluent-bit/issues"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2ee41112a44fe7014dce33e26468ba93"
SECTION = "net"

SRC_URI = "\
           http://fluentbit.io/releases/1.8/fluent-bit-${PV}.tar.gz \
           file://0001-mbedtls-fix-issue-building-with-a-newer-GCC.patch \
           file://0002-onigmo-fix-cross-compiling-issue.patch \
           file://fluent-bit.service \
           "
SRC_URI[md5sum] = "182e9dbea7d0ab4fde32dde2bddd2205"
SRC_URI[sha256sum] = "5b91481c46828799f5f079e3b013c2359811870db5c1570da3c4aa5e5c09aa74"

DEPENDS = "zlib openssl bison-native flex-native"

# Use CMake 'Unix Makefiles' generator
OECMAKE_GENERATOR ?= "Unix Makefiles"

# Fluent Bit build options
# ========================

# Disable Debug symbols
EXTRA_OECMAKE += "-DFLB_DEBUG=Off "

# Host related setup
EXTRA_OECMAKE += "-DGNU_HOST=${HOST_SYS} -DHOST=${HOST_ARCH} "

# Disable LuaJIT and filter_lua support
EXTRA_OECMAKE += "-DFLB_LUAJIT=Off -DFLB_FILTER_LUA=Off "

# Disable Library and examples
EXTRA_OECMAKE += "-DFLB_SHARED_LIB=Off -DFLB_EXAMPLES=Off "

# Systemd support
DEPENDS += "systemd"
EXTRA_OECMAKE += "-DFLB_IN_SYSTEMD=On "

# Enable Kafka Output plugin
EXTRA_OECMAKE += "-DFLB_OUT_KAFKA=On "

inherit cmake systemd

SYSTEMD_SERVICE_${PN} = "fluent-bit.service"
SYSTEMD_AUTO_ENABLE = "disable"

do_install_append() {
    # fluent-bit unconditionally install init scripts, let's remove them to install our own
    rm -Rf ${D}/lib ${D}/etc/init

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fluent-bit.service ${D}${systemd_unitdir}/system/fluent-bit.service
}
