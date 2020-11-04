# disable rngd service for iMX7 devices since it fails because of CAAM driver initialization error
PACKAGECONFIG_remove_colibri-imx7-emmc = "rng-tools"
PACKAGECONFIG_remove_colibri-imx7 = "rng-tools"
