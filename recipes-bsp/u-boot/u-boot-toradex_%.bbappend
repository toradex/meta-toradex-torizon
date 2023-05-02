FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
    file://bootcommand.cfg \
    file://bootcount.cfg \
    file://bootlimit.cfg \
"

require u-boot-ota.inc
require ${@ 'u-boot-secure-boot.inc' if 'secure-boot' in d.getVar('OVERRIDES').split(':') else ''}
