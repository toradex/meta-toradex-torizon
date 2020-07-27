FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-2018.03:"

SRC_URI_append = " \
    file://avoid_overwriting_same_value_to_avoid_flash_wear_out.patch \
"
