#!/bin/sh

check_target () {
	TARGET=${HOSTNAME%-*}
	echo ${TARGET}
}

select_mwifiex_module () {
	TARGET=$(check_target)
	case $TARGET in
		apalis-imx8)
			MODULE=mwifiex_pcie
			;;
		colibri-imx8x)
			MODULE=mwifiex_pcie
			;;
		verdin-imx8mm)
			MODULE=mwifiex_sdio
			;;
	esac

	echo ${MODULE}
}

MWIFIEX_TARGET=$(check_target)
MWIFIEX_MODULE=$(select_mwifiex_module)

modprobe mwifiex driver_mode=0x3

echo "Loading module ${MWIFIEX_MODULE} for target ${MWIFIEX_TARGET}"
modprobe ${MWIFIEX_MODULE}
