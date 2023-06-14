FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

PATCHES_NXP_BSP = " "
PATCHES_NXP_BSP:torizon-signed = "\
    file://0001-fs-verity-define-a-function-to-return-the-integrity-.patch \
"

SRC_URI:append:use-nxp-bsp = "\
    ${PATCHES_NXP_BSP} \
"

SRC_URI:append:torizon-signed = "\
    file://0001-fsverity-Export-fsverity_get_digest.patch \
"

KBUILD_BUILD_VERSION .= "-TorizonCore"

# Print kernel URL and BRANCH to files to be used by ostree commit as metadata
kernel_do_deploy:append() {
	url=`git --git-dir=${S}/.git config --get remote.origin.url`
	printf "%s" ${url#*//} > ${DEPLOYDIR}/.kernel_scmurl

	branch=`git --git-dir=${S}/.git symbolic-ref --short -q HEAD`
	printf "%s" $branch > ${DEPLOYDIR}/.kernel_scmbranch

	head=`git --git-dir=${S}/.git rev-parse --verify --short HEAD 2> /dev/null`
	printf "%s" $head > ${DEPLOYDIR}/.kernel_scmversion
}
