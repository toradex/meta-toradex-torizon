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
           file://0001-onigmo-fix-cross-compiling-issue.patch \
           file://fluent-bit.service \
           file://fluent-bit.conf \
           "
SRC_URI[md5sum] = "796569eb720431e449a6fde60e23f000"
SRC_URI[sha256sum] = "a48bc7890c923260ce03cb9d79e5076b0c456e94fff446c181ea83192284fc58"

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

do_install_append() {
    # fluent-bit unconditionally install init scripts, let's remove them to install our own
    rm -Rf ${D}/lib ${D}/etc/init

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fluent-bit.service ${D}${systemd_unitdir}/system/fluent-bit.service
    install -d ${D}${sysconfdir}/fluent-bit/
    install -m 0755 ${WORKDIR}/fluent-bit.conf ${D}${sysconfdir}/fluent-bit/fluent-bit.conf
}
