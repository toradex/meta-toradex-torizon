inherit image_type_tezi

TEZI_ROOT_LABEL = "otaroot"
TEZI_ROOT_SUFFIX = "ota.tar.zst"
TEZI_BOOT_SUFFIX = "bootfs.tar.zst"
TEZI_CONFIG_FORMAT = "3"

SUMMARY_append_preempt-rt = " (PREEMPT_RT)"
DESCRIPTION_append_preempt-rt = " Using a Linux kernel with PREEMPT_RT real-time patch applied."

def get_tdx_ostree_purpose(purpose):
    return purpose.lower()

TDX_OSTREE_PURPOSE ?= "${@get_tdx_ostree_purpose(d.getVar('TDX_PURPOSE'))}"

# Use new branch naming
OSTREE_BRANCHNAME = "${TDX_MAJOR}/${MACHINE}/${DISTRO}/${IMAGE_BASENAME}/${TDX_OSTREE_PURPOSE}"

#Force ostree summary to be updated
OSTREE_UPDATE_SUMMARY = "1"

#Create change log file inside ostree
OSTREE_CHANGE_LOG_FILE = "${OSTREE_REPO}/${DISTRO}-${IMAGE_BASENAME}-diff.log"
OSTREE_CHANGE_LOG_FOOTER = "================================"
OSTREE_CHANGE_LOG_HEADER = "Changes in version ${IMAGE_NAME}"
OSTREE_CREATE_DIFF = "1"
EXTRA_OSTREE_COMMIT = " \
    --add-metadata-string=oe.machine="${MACHINE}" \
    --add-metadata-string=oe.distro="${DISTRO}" \
    --add-metadata-string=oe.image="${IMAGE_BASENAME}" \
    --add-metadata-string=oe.arch="${TARGET_ARCH}" \
    --add-metadata-string=oe.package-arch="${TUNE_PKGARCH}" \
    --add-metadata-string=oe.kargs-default="${OSTREE_KERNEL_ARGS}" \
    --add-metadata-string=oe.garage-target-name="${GARAGE_TARGET_NAME}" \
    --add-metadata-string=oe.garage-target-version="${GARAGE_TARGET_VERSION}" \
"

# Use full distro version only as commit subject, we have distro an image name
# in the OSTree branch name.
OSTREE_COMMIT_SUBJECT = "${DISTRO_VERSION}"
OSTREE_COMMIT_SUBJECT[vardepsexclude] = "DISTRO_VERSION"

# Get git hashes from all layers
# inspiration taken from image-buildinfo
def get_layer_revision_information(d):
    import bb.process
    import subprocess
    res = []
    max_len = 0
    try:
        paths = (d.getVar("BBLAYERS" or "")).split()

        for p in paths:
            if max_len < len(os.path.basename(p)):
                max_len = len(os.path.basename(p))

        for path in paths:
            name = os.path.basename(path)
            rev, _ = bb.process.run('git rev-parse HEAD', cwd=path)
            branch, _ = bb.process.run('git rev-parse --abbrev-ref HEAD', cwd=path)
            name = name.ljust(max_len)
            try:
                subprocess.check_output("""cd %s; export PSEUDO_UNLOAD=1; set -e;
                                        git diff --quiet --no-ext-diff
                                        git diff --quiet --no-ext-diff --cached""" % path,
                                        shell=True,
                                        stderr=subprocess.STDOUT)
                modified = ""
            except subprocess.CalledProcessError as ex:
                modified = " --modified"
            res.append(name + " " + branch.rstrip() + ":\"" + rev.rstrip()+ "\"" + modified)
    except:
        e = sys.exc_info()[0]
        bb.warn("Failed to get layers information. Exception: {}".format(e))
    return '\n'.join(res)

# Add layers revision information to ostree body
OSTREE_COMMIT_BODY := "${@get_layer_revision_information(d)}"

IMAGE_CMD_ostreecommit[vardepsexclude] += "OSTREE_COMMIT_BODY OSTREE_COMMIT_SUBJECT"

do_image_ostreecommit[postfuncs] += " generate_diff_file"

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
