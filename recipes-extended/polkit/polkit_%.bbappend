FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://0001-Allow-to-disable-polkitd-when-using-library-alone.patch \
"

# We only want to use the polkit library
REQUIRED_DISTRO_FEATURES_remove = " polkit"

DEPENDS_remove = "mozjs"

EXTRA_OECONF_append = " --disable-polkitd"

do_install_append() {
    # Avoid starting polkitd since we dont install it
    sed -i -e 's,ExecStart=.*,ExecStart=/bin/true,g' ${D}${systemd_unitdir}/system/polkit.service
    sed -i -e '/^ExecStart=.*$/aRemainAfterExit=yes' ${D}${systemd_unitdir}/system/polkit.service
}
