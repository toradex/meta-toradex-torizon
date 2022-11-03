SRCREV_meta = "6cdbbb5cd05763bf49f5fbd4ea4ba04ddfc51421"
SRCREV_meta:use-head-next = "${AUTOREV}"

KMETABRANCH = "kirkstone-6.x.y"
KMETA = "kernel-meta"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
