FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://sysctl-panic.conf \
"

RRECOMMENDS_${PN}_remove = "os-release"

do_install_append () {
    install -m 0644 ${WORKDIR}/sysctl-panic.conf ${D}${exec_prefix}/lib/sysctl.d/60-panic.conf
}
