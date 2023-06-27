
python() {
    tdx_debug = d.getVar("TDX_DEBUG", "0")
    tdx_image = d.getVar("TDX_IMAGE", "torizon-core-common-docker")

    if tdx_image == "torizon-core-common-docker-dev":
        if tdx_debug != "1":
            bb.fatal(f"You are trying to build a development image with TDX_DEBUG={tdx_debug}")
}
