SRCREV_meta = "8b194762271deb396c6003ac1ec8928d6d7d3b96"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "toradex_5.4.y"
KMETA = "kernel-meta"

KMACHINE_apalis-imx8x-v11a = "apalis-imx8x"
KMACHINE_colibri-imx7-emmc = "colibri-imx7"
KMACHINE_colibri-imx8x-v10b = "colibri-imx8x"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
