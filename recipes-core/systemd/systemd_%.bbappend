FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://sysctl-panic.conf \
    file://0001-seccomp-more-comprehensive-protection-against-libsec.patch \
    file://0001-seccomp-add-new-Linux-5.3-syscalls-to-syscall-filter.patch \
    file://0001-seccomp-add-all-time64-syscalls.patch \
"

PACKAGECONFIG_append = " resolved networkd"
RRECOMMENDS_${PN}_remove = "os-release"

do_install_append () {
    install -m 0644 ${WORKDIR}/sysctl-panic.conf ${D}${exec_prefix}/lib/sysctl.d/60-panic.conf
}
