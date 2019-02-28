FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://sudoers.lmp \
"

# We explicitly require pam
inherit distro_features_check

REQUIRED_DISTRO_FEATURES = "pam"

do_install_append () {
    install -m 0440 -d ${D}${sysconfdir}/sudoers.d
    install -m 0440 ${WORKDIR}/sudoers.lmp ${D}${sysconfdir}/sudoers.d/lmp
}
