PACKAGES =+ "${PN}-backend"

FILES_${PN}-backend = "${PYTHON_SITEPACKAGES_DIR}/*.so"

RDEPENDS_${PN}_append_class-target = " ${PN}-backend"
