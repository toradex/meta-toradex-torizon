FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " file://inputrc.torizon"

do_install_append () {
	install -m 0644 ${WORKDIR}/inputrc.torizon ${D}${sysconfdir}/inputrc
}
