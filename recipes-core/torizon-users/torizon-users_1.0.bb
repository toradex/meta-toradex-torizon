SUMMARY = "Torizon user accounts"
DESCRIPTION = "Provides Torizon user accounts for Torizon system"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

EXCLUDE_FROM_WORLD = "1"
INHIBIT_DEFAULT_DEPS = "1"

ALLOW_EMPTY_${PN} = "1"

inherit useradd

USERADD_PACKAGES = "${PN}"

GROUPADD_PARAM_${PN} = "torizon"
USERADD_PARAM_${PN} = "-G adm,sudo,users,plugdev -m -d /home/torizon -P torizon torizon"
