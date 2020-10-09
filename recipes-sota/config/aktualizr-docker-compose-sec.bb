SUMMARY = "Secondary configuration to update containers via docker compose files"
DESCRIPTION = "Creates a secondary configuration to update containers on the primary via docker compose files"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit allarch

SRC_URI = " \
            file://50-docker-compose.toml \
            file://docker-compose.json \
            "

do_install_append () {
    install -m 0700 -d ${D}${libdir}/sota/conf.d
    install -m 0644 ${WORKDIR}/50-docker-compose.toml ${D}${libdir}/sota/conf.d/50-docker-compose.toml
    install -m 0644 ${WORKDIR}/docker-compose.json ${D}${libdir}/sota/docker-compose.json
}

FILES_${PN} = " \
                ${libdir}/sota/conf.d/50-docker-compose.toml \
                ${libdir}/sota/docker-compose.json \
                "
