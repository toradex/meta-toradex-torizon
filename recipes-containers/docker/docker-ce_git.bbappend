SRCREV_docker = "afacb8b7f0d8d4f9d2a8e8736e9c993e672b41f3"

DOCKER_VERSION = "19.03.8-ce"

do_install_prepend() {
	# Final dockerd binary location has been moved. Work around by creating
	# a symlink instead of overwriting the complete do_install task.
	mkdir -p ${S}/src/import/components/engine/bundles/latest/
	ln -sf ${S}/src/import/components/engine/bundles/dynbinary-daemon/ \
		${S}/src/import/components/engine/bundles/latest/dynbinary-daemon
}
