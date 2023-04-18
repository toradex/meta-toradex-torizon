SRCREV_meta = "2116732af9e21893eb25874274a51faeffab0284"
SRCREV_meta:use-head-next = "${AUTOREV}"

KMETABRANCH = "kirkstone-6.x.y"
KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
