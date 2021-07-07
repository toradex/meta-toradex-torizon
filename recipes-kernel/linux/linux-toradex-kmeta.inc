SRCREV_meta = "cea1f4fd7eab17f7d83ad59cdae3478d209736ed"
SRCREV_meta_use-head-next = "${AUTOREV}"

KMETABRANCH = "toradex_5.4.y"
KMETA = "kernel-meta"

KMACHINE_apalis-imx8x-v11a = "apalis-imx8x"
KMACHINE_colibri-imx7-emmc = "colibri-imx7"
KMACHINE_colibri-imx8x-v10b = "colibri-imx8x"

KMETAREPOSITORY="github.com/toradex/toradex-kernel-cache.git"
KMETAPROTOCOL="https"

SRC_URI += "git://${KMETAREPOSITORY};protocol=${KMETAPROTOCOL};type=kmeta;name=meta;branch=${KMETABRANCH};destsuffix=${KMETA}"
