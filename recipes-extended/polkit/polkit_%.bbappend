FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
    file://0001-Allow-to-disable-polkitd-when-using-library-alone.patch \
"

# We only want to use the polkit library
REQUIRED_DISTRO_FEATURES:remove = " polkit"

DEPENDS:remove = "mozjs"

EXTRA_OECONF:append = " --disable-polkitd"

do_install:append() {
    # Avoid starting polkitd since we dont install it
    sed -i -e 's,ExecStart=.*,ExecStart=/bin/true,g' ${D}${systemd_unitdir}/system/polkit.service
    sed -i -e '/^ExecStart=.*$/aRemainAfterExit=yes' ${D}${systemd_unitdir}/system/polkit.service
}
