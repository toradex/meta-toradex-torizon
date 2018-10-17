#Name an ostree branch after image basename, this allows having multiple images in one repo
OSTREE_BRANCH = "${IMAGE_BASENAME}"

#Force ostree summary to be updated
OSTREE_UPDATE_SUMMARY = "1"

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
        bb.warn("Failed to get layers information. Exception: %s",e)
    return '\n'.join(res)

# Add layers revision information to ostree body
OSTREE_COMMIT_BODY = "${@get_layer_revision_information(d)}"

