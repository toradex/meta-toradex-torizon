FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://10-toradex-net-rename.rules \
    file://90-toradex-gpio.rules \
    file://91-toradex-i2cdev.rules \
    file://92-toradex-spidev.rules \
    file://toradex-net-rename.sh \
    file://99-toradex-persistent-emmc-naming.rules \	
"

do_install_append () {
    install -m 0644 ${WORKDIR}/10-toradex-net-rename.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/90-toradex-gpio.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/91-toradex-i2cdev.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/92-toradex-spidev.rules ${D}${sysconfdir}/udev/rules.d/
    install -m 0644 ${WORKDIR}/99-toradex-persistent-emmc-naming.rules ${D}${sysconfdir}/udev/rules.d/    
 
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/toradex-net-rename.sh ${D}${bindir}/
}
