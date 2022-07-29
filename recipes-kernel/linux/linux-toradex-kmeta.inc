SRCREV_meta = "cf62fa8fd95e57773b16e060a86bc3eebae84ff0"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "dunfell-5.x.y"
KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
