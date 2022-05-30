#!/bin/bash

UPGRADE_AVAILABLE=$(fw_printenv upgrade_available | cut -d '=' -f 2)
DEVICE_PROVISIONED=$(test -e /var/sota/import/gateway.url -o -e /var/sota/import/director/root.json && echo '1')

# if update in progress but device is not provisioned, aktualizr will be inactive,
# so let's manually clean-up U-Boot variables to confirm the update
if [ "$UPGRADE_AVAILABLE" = "1" -a "$DEVICE_PROVISIONED" != "1" ]; then
    echo "Aktualizr-Torizon is inactive. Cleaning up U-Boot variables to confirm the update..."
    fw_setenv upgrade_available 0
    fw_setenv bootcount 0
fi
