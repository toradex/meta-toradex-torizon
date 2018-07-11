FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://uEnv-rawnand.txt \
"

do_deploy_append() {
    install -m 0644 uEnv-rawnand.txt ${DEPLOYDIR}
}
