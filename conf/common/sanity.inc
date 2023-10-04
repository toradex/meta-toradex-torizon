
python() {
    tdx_debug = d.getVar("TDX_DEBUG", "0")
    tdx_image = d.getVar("TDX_IMAGE", "torizon-core-common-docker")
    machine = d.getVar("MACHINE", "undefined")

    if tdx_image == "torizon-core-common-docker-dev":
        if tdx_debug != "1":
            bb.fatal(f"You are trying to build a development image with TDX_DEBUG={tdx_debug}")
    elif tdx:
        # for common Torizon OS we are only allowing to build development images
        bb.fatal(
            f"\n\nYou are trying to build {machine} with TDX_IMAGE={tdx_image}" \
            "\nPlease build with TDX_IMAGE=torizon-core-common-docker-dev" \
            "\nhttps://github.com/commontorizon/Documentation/blob/main/BUILDING.md\n\n"
        )
}
