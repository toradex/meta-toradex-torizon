
require common.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = "\
     file://0001-i915-hwmon-dgfx-check.patch \
"
