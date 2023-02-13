
SRC_URI = " \
    git://github.com/microhobby/linux-toradex.git;protocol=https;branch=toradex_5.15-2.1.x-imx;name=machine \
"

# Make sure to override LOCALVERSION in linux-imx.inc
LOCALVERSION = "-${TDX_VERSION}-labs"


require linux-torizon.inc
require linux-toradex-kmeta.inc
require common.inc
