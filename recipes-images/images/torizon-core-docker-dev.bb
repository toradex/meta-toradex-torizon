require torizon-core-docker.bb
require torizon-core-dev.inc

DESCRIPTION = "TorizonCore Linux engineering image"

python() {
    tdx_debug = d.getVar("TDX_DEBUG", "0")

    if tdx_debug == "1":
        bb.warn(f"You are building a engineering image with TDX_DEBUG={tdx_debug}")
    else:
        bb.fatal(f"You are trying to build a engineering image with TDX_DEBUG={tdx_debug}")
}
