#!/bin/sh

# Assign name "ethernetN" to net devices with Toradex OUI.
# Supports Toradex boards with single/dual ethernet interfaces.

if [ $# -ne 1 ]; then
    echo "Usage: $0 KERNEL" >&2
    exit 1
fi

dev="${1}"
devpath="/sys/class/net/${dev}"
if [ ! -e ${devpath} ]
then
  echo "Error: dev path does not exist!" >&2
  exit 1
fi

devaddr="${devpath}/address"

# Toradex OUI
oui=00:14:2d

# Number of net devices with Toradex OUI
devs=$(grep ${oui} /sys/class/net/*/address | wc -l)

if [ ${devs} -gt 2 ]
then
  # Limitation: this script can handle up to two devices
  echo "Error: Found ${devs} devices with Toradex OUI!" >&2
  echo "Error: Up to 2 devices are supported at the moment" >&2
  exit 1
fi

mac0_serial=$(expr $(cat /proc/device-tree/serial-number | tr '\0' '\n') + 0)

# Secondary MAC address is allocated from block
# 0x100000(1048576) higher than the first MAC address
mac1_offset=1048576
mac1_serial=$((mac0_serial + mac1_offset))

for i in $(seq 0 $((devs - 1)))
do
  eval serial="\${mac${i}_serial}"

  # 16777215 = 0xFFFFFF, maximum valid serial
  if [ ${serial} -gt 16777215 ]
  then
    echo "Error: mac${i} serial is greater than 0xFFFFFF!" >&2
    exit 1
  fi
  eval mac${i}_serial_hex=$(eval printf "%x" "\${mac${i}_serial}" |  sed -e 's/[0-9a-f]\{2\}/&:/g' -e 's/:$//')
  eval mac${i}="${oui}:\${mac${i}_serial_hex}"

  eval currentmac="\${mac${i}}"
  if [ $(cat ${devaddr}) = ${currentmac} ]
  then
    echo "ethernet${i}"
    exit 0
  fi
done

echo "Error: Could not match MAC address!" >&2
exit 1
