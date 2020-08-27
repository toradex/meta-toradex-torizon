KBUILD_BUILD_VERSION .= "-TorizonCore"

# Print kernel URL and BRANCH to files to be used by ostree commit as metadata
kernel_do_configure_append() {
	url=`git --git-dir=${S}/.git config --get remote.origin.url`
	printf "%s" ${url#*//} > ${S}/.scmurl

	branch=`git --git-dir=${S}/.git symbolic-ref --short -q HEAD`
	printf "%s" $branch > ${S}/.scmbranch
}
