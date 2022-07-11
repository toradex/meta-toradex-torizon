PACKAGES =+ "${PN}-backend"

FILES:${PN}-backend = "${PYTHON_SITEPACKAGES_DIR}/*.so"

RDEPENDS:${PN}:append:class-target = " ${PN}-backend"
