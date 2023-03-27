FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

COMPATIBLE_HOST = "(i.86|x86_64|arm|aarch64|riscv64).*-linux"

SRC_URI += "\
    file://0001-code-clean-up-for-read-3.patch \
"
