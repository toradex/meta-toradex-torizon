FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

require linux-torizon.inc

SRC_URI += "\
    file://torizoncore.scc \
"

inherit toradex-kernel-localversion

require common.inc
require specific.inc
