SRCREV_meta = "fe6c4f1f73fd5e8e6fa70a54e7889ad3d139b77e"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "toradex_5.4.y"
KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
