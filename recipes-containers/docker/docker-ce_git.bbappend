FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
    file://0001-dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://0002-cli-config-support-default-system-config.patch \
"

require docker-torizon.inc
