#!/bin/bash

UPGRADE_AVAILABLE=$(fw_printenv upgrade_available | cut -d '=' -f 2)

# if update in progress but device is not provisioned, aktualizr will be inactive,
# so let's manually clean-up U-Boot variables to confirm the update
if [ "$UPGRADE_AVAILABLE" = "1" -a ! -e /var/sota/import/gateway.url ]; then
    echo "Aktualizr-Torizon is inactive. Cleaning up U-Boot variables to confirm the update..."
    fw_setenv upgrade_available 0
    fw_setenv bootcount 0
fi
