inherit image_type_tezi

TEZI_ROOT_LABEL = "otaroot"
TEZI_ROOT_NAME = "ota"
TEZI_ROOT_SUFFIX = "ota.tar.zst"
TEZI_USE_BOOTFILES = "false"

TEZI_CONFIG_FORMAT = "3"

def rootfs_tezi_rawnand(d):
    from collections import OrderedDict
    imagename = d.getVar('IMAGE_LINK_NAME')

    uboot1 = OrderedDict({
               "name": "u-boot1",
               "content": {
                 "rawfile": {
                   "filename": d.getVar('UBOOT_BINARY_TEZI_RAWNAND'),
                   "size": 1
                 }
               },
             })

    uboot2 = OrderedDict({
               "name": "u-boot2",
               "content": {
                 "rawfile": {
                   "filename": d.getVar('UBOOT_BINARY_TEZI_RAWNAND'),
                   "size": 1
                 }
               }
             })

    env = OrderedDict({
        "name": "u-boot-env",
        "erase": True,
        "content": {}
    })

    ubi = OrderedDict({
            "name": "ubi",
            "ubivolumes": [
              {
                "name": "rootfs",
                "content": {
                  "filesystem_type": "ubifs",
                  "filename": imagename + "." + d.getVar('TEZI_ROOT_SUFFIX'),
                  "uncompressed_size": get_uncompressed_size(d, d.getVar('TEZI_ROOT_NAME'))
                }
              }
            ]
          })

    return [uboot1, uboot2, env, ubi]

python adjust_tezi_artifacts() {
    artifacts = d.getVar('TEZI_ARTIFACTS').replace(d.getVar('KERNEL_IMAGETYPE'), '').replace(d.getVar('KERNEL_DEVICETREE'), '')
    d.setVar('TEZI_ARTIFACTS', artifacts)
}

TEZI_IMAGE_TEZIIMG_PREFUNCS_append = " adjust_tezi_artifacts"

IMAGE_CMD_ota_prepend() {
	if [ "${OSTREE_BOOTLOADER}" = "u-boot" ]; then
		cp -a ${DEPLOY_DIR_IMAGE}/boot.scr-${MACHINE} ${OTA_SYSROOT}/boot.scr
	fi
}
do_image_ota[depends] += "${@'u-boot-default-script:do_deploy' if d.getVar('OSTREE_BOOTLOADER') == 'u-boot' else ''}"
do_image_ota[lockfiles] += "${OSTREE_REPO}/ostree.lock"
do_image_ostreepush[lockfiles] += "${OSTREE_REPO}/ostree.lock"

def get_tdx_ostree_purpose(purpose):
    return purpose.lower()

TDX_OSTREE_PURPOSE ?= "${@get_tdx_ostree_purpose(d.getVar('TDX_PURPOSE'))}"

# Use new branch naming
OSTREE_BRANCHNAME = "${TDX_MAJOR}/${MACHINE}/${DISTRO}/${IMAGE_BASENAME}/${TDX_OSTREE_PURPOSE}"

# Force ostree summary to be updated
OSTREE_UPDATE_SUMMARY = "1"

# Kernel source metadata
OSTREE_KERNEL_SOURCE_META_DATA = "('${OSTREE_KERNEL_SOURCE_URL}', '${OSTREE_KERNEL_SOURCE_BRANCH}', '${OSTREE_KERNEL_SOURCE_VERSION}')"
OSTREE_KERNEL_SOURCE_META_DATA[vardepvalue] = "${OSTREE_KERNEL_SOURCE_URL}"
OSTREE_KERNEL_SOURCE_META_DATA[vardepvalue] = "${OSTREE_KERNEL_SOURCE_BRANCH}"
OSTREE_KERNEL_SOURCE_META_DATA[vardepvalue] = "${OSTREE_KERNEL_SOURCE_VERSION}"

OSTREE_KERNEL_SOURCE_URL = "${@oe.utils.read_file('${DEPLOY_DIR_IMAGE}/.kernel_scmurl')}"
OSTREE_KERNEL_SOURCE_BRANCH = "${@oe.utils.read_file('${DEPLOY_DIR_IMAGE}/.kernel_scmbranch')}"
OSTREE_KERNEL_SOURCE_VERSION = "${@oe.utils.read_file('${DEPLOY_DIR_IMAGE}/.kernel_scmversion')}"

# Create change log file inside ostree
OSTREE_CHANGE_LOG_FILE = "${OSTREE_REPO}/${DISTRO}-${IMAGE_BASENAME}-diff.log"
OSTREE_CHANGE_LOG_FOOTER = "================================"
OSTREE_CHANGE_LOG_HEADER = "Changes in version ${IMAGE_NAME}"
OSTREE_CREATE_DIFF = "1"

# Use full distro version only as commit subject, we have distro an image name
# in the OSTree branch name.
OSTREE_COMMIT_SUBJECT = "${DISTRO_VERSION}"
OSTREE_COMMIT_SUBJECT[vardepsexclude] = "DISTRO_VERSION"

# Get git hashes from all layers and print it as GLib g_variant_parse() string
# inspiration taken from image-buildinfo
def get_layer_revision_information(d):
    import bb.process
    import subprocess
    try:
        layers = []
        paths = (d.getVar("BBLAYERS" or "")).split()

        for path in paths:
            # Use relative path from ${OEROOT}/layers/ as layer name
            name = os.path.relpath(path, os.path.join(d.getVar('OEROOT'), "layers"))
            rev, _ = bb.process.run('git rev-parse HEAD', cwd=path)
            branch, _ = bb.process.run('git rev-parse --abbrev-ref HEAD', cwd=path)
            try:
                subprocess.check_output("""cd %s; export PSEUDO_UNLOAD=1; set -e;
                                        git diff --quiet --no-ext-diff
                                        git diff --quiet --no-ext-diff --cached""" % path,
                                        shell=True,
                                        stderr=subprocess.STDOUT)
                modified = ""
            except subprocess.CalledProcessError as ex:
                modified = ":modified"
            # Key/value pair per layer
            layers.append("'{}': '{}:{}{}'".format(name, branch.strip(), rev.strip(), modified))

        # Create GLib dictionary
        return "{" + ",".join(layers) + "}"
    except:
        e = sys.exc_info()[0]
        bb.warn("Failed to get layers information. Exception: {}".format(e))

EXTRA_OSTREE_COMMIT[vardepsexclude] = "OSTREE_KERNEL_SOURCE_META_DATA"
EXTRA_OSTREE_COMMIT = " \
    --add-metadata-string=oe.machine="${MACHINE}" \
    --add-metadata-string=oe.distro="${DISTRO}" \
    --add-metadata-string=oe.distro-codename="${DISTRO_CODENAME}" \
    --add-metadata-string=oe.image="${IMAGE_BASENAME}" \
    --add-metadata-string=oe.tdx-build-purpose="${TDX_OSTREE_PURPOSE}" \
    --add-metadata-string=oe.tdx-major="${TDX_MAJOR}" \
    --add-metadata-string=oe.arch="${TARGET_ARCH}" \
    --add-metadata-string=oe.package-arch="${TUNE_PKGARCH}" \
    --add-metadata-string=oe.kargs-default="${OSTREE_KERNEL_ARGS}" \
    --add-metadata=oe.kernel-source="${OSTREE_KERNEL_SOURCE_META_DATA}" \
    --add-metadata-string=oe.garage-target-name="${GARAGE_TARGET_NAME}" \
    --add-metadata-string=oe.garage-target-version="${GARAGE_TARGET_VERSION}" \
    --add-metadata-string=oe.sota-hardware-id="${SOTA_HARDWARE_ID}" \
    --add-metadata=oe.layers="${@get_layer_revision_information(d)} " \
"

IMAGE_CMD_ostreecommit[vardepsexclude] += "EXTRA_OSTREE_COMMIT OSTREE_COMMIT_SUBJECT"

do_image_ostreecommit[postfuncs] += " generate_diff_file"
generate_diff_file[lockfiles] += "${OSTREE_REPO}/ostree.lock"

generate_diff_file () {
    if [ "${OSTREE_CREATE_DIFF}" = "1"  ]; then
        if [ -n "${OSTREE_CHANGE_LOG_FILE}"  ]; then
            if ostree --repo=${OSTREE_REPO} diff ${OSTREE_BRANCHNAME} ; then
                touch "${OSTREE_CHANGE_LOG_FILE}"
                echo "${OSTREE_CHANGE_LOG_HEADER}" >> "${OSTREE_CHANGE_LOG_FILE}"
                ostree --repo=${OSTREE_REPO} diff ${OSTREE_BRANCHNAME} >> ${OSTREE_CHANGE_LOG_FILE}
                echo "${OSTREE_CHANGE_LOG_FOOTER}" >> "${OSTREE_CHANGE_LOG_FILE}"
            fi
        fi
    fi
}

IMAGE_DATETIME_FILES ??= " \
    ${sysconfdir}/issue \
    ${sysconfdir}/issue.net \
    ${sysconfdir}/os-release \
    ${sysconfdir}/timestamp \
    ${sysconfdir}/version \
    ${libdir}/os-release \
"

ROOTFS_POSTPROCESS_COMMAND += "tweak_os_release_variant ; "

# Tweak /etc/os-release according to IMAGE_VARIANT defined in image recipe
tweak_os_release_variant () {
	if [ -n "${IMAGE_VARIANT}" ]; then
		sed -i -e "s/^VARIANT=.*$/VARIANT=\"${IMAGE_VARIANT}\"/g" ${IMAGE_ROOTFS}${sysconfdir}/os-release
	else
		bbwarn "IMAGE_VARIANT is missing, would be better to define it for a Torizoncore image recipe."
	fi
}

IMAGE_PREPROCESS_COMMAND += "adjust_rootfs_datetime;"

# For the files listed in IMAGE_DATETIME_FILES that might contain DATETIME strings, substitute
# them with the current ${DATETIME} of do_image task, to replace the potential older DATATIMEs
# that installed from sstate.
adjust_rootfs_datetime () {
    for f in ${IMAGE_DATETIME_FILES}; do
        file=${IMAGE_ROOTFS}$f
        datetime=`grep -oE "[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])(2[0-3]|[01][0-9])([0-5][0-9]){2}" $file | head -1`
        if [ -n "$datetime" ]; then
            sed -i -e "s#$datetime#${DATETIME}#g" $file
        fi
    done
}
adjust_rootfs_datetime[vardepsexclude] = "DATETIME"
