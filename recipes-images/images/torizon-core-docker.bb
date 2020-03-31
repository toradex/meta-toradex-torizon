SUMMARY = "TorizonCore"
DESCRIPTION = "TorizonCore Linux with no containers pre-provisioned."

require torizon-core-container.inc

CORE_IMAGE_BASE_INSTALL_append = " \
    docker-ce \
    python3-docker-compose \
    docker-compose-up \
"

EXTRA_USERS_PARAMS += "\
usermod -a -G docker torizon; \
"
