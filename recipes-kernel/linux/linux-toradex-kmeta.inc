SRCREV_meta = "4db1cb3192fa4db0015e453e687da0a9e3eb4581"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "toradex_5.4.y"
KMETA = "kernel-meta"

KMACHINE_colibri-imx7-emmc = "colibri-imx7"
KMACHINE_colibri-imx8x-v10b = "colibri-imx8x"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
